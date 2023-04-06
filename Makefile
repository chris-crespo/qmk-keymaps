USER = chris

KEYBOARDS = lily58
VARIANT_lily58 = lily58/r2g
PATH_lily58 = lily58

.PHONY: all $(KEYBOARDS) clean

all: $(KEYBOARDS)

$(KEYBOARDS):
		git submodule update --init --recursive

		for f in $(KEYBOARDS); do rm -rf qmk_firmware/keyboards/$(PATH_$@)/keymaps/$(USER); done
		ln -s $(shell pwd)/$@ qmk_firmware/keyboards/$(PATH_$@)/keymaps/$(USER)

		#cd qmk_firmware; qmk lint -km $(USER) -kb $(PATH_$@) --strict

		make BUILD_DIR=$(shell pwd) -j1 -C qmk_firmware $(VARIANT_$@):$(USER)

		for f in $(KEYBOARDS); do rm -rf qmk_firmware/keyboards/$(PATH_$@)/keymaps/$(USER); done

clean:
		rm -rf obj_*
		rm -rf *.elf
		rm -rf *.map
		rm -rf *.hex
