Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27004C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD1487E30;
	Wed, 14 Aug 2024 13:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57978889A1; Wed, 14 Aug 2024 13:00:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9D0F687E30
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9829EDA7;
 Wed, 14 Aug 2024 04:00:57 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E5B13F58B;
 Wed, 14 Aug 2024 04:00:27 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 00/32] Make LMB memory map global and persistent
Date: Wed, 14 Aug 2024 16:29:37 +0530
Message-Id: <20240814110009.45310-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


This is a follow-up from an earlier RFC series [1] for making the LMB
and EFI memory allocations work together. This is a non-rfc version
with only the LMB part of the patches, for making the LMB memory map
global and persistent.

This is part one of a set of patches which aim to have the LMB and EFI
memory allocations work together. This requires making the LMB memory
map global and persistent, instead of having local, caller specific
maps. This is being done keeping in mind the usage of LMB memory by
platforms where the same memory region can be used to load multiple
different images. What is not allowed is to overwrite memory that has
been allocated by the other module, currently the EFI memory
module. This is being achieved by introducing a new flag,
LMB_NOOVERWRITE, which represents memory which cannot be re-requested
once allocated.

The data structures (alloced lists) required for maintaining the LMB
map are initialised during board init. The LMB module is enabled by
default for the main U-Boot image, while it needs to be enabled for
SPL. This version also uses a stack implementation, as suggested by
Simon Glass to temporarily store the lmb structure instance which is
used during normal operation when running lmb tests. This does away
with the need to run the lmb tests separately.

The tests have been tweaked where needed because of these changes.

The second part of the patches, to be sent subsequently, would work on
having the EFI allocations work with the LMB API's.

[1] - https://lore.kernel.org/u-boot/20240704073544.670249-1-sughosh.ganu@linaro.org/T/#t


Note: These patches are on next, as the alist patches have been
applied to that branch


Changes since V1:
* Do away with the alist_empty() function, as it is no longer needed
* Keep the alloced lists for used and free memory in a lmb structure.
* s/lmb_mem_regions_init/lmb_setup.
* Remove the special case scenario for adding region when list is
  empty(sjg).
* Optimise the logic to add a region to a sorted region list(sjg)
* Call lmb_setup() from lmb_init()
* Handle all cases for merging regions in the lmb_resize_regions()
  function, thus removing the need for lmb_merge_overlap_regions().
* Do away with lmb_region_flags_match() as there is a single use of
  the function now.
* Do not pass the flags parameter to lmb_resize_regions() as the
  function is passed only for LMB_NONE.
* Call the lmb_add_memory() from lmb_init() instead of
  lmb_mem_regions_init().
* Move the initr_lmb() function to board_r.c
* Call lmb_init() from spl.c instead of initr_lmb().
* Rejig the memory map to have the event log at 0xb000 and bloblist at
  0xd000.
* Update the memory map in the document accordingly.
* Update the commit message to explain why this change is being done.
* Move the DVA address and page size as macros to the test.h header
  file.
* Don't use the API version with flags parameter.
* Use a stack implementation to store the lmb instance pointer when
  running lmb tests(sjg).
* Add a function for setting up a new and separate lmb instance for
  the tests(sjg).
* Add functions to push and pop the lmb pointer for running lmb
  tests(sjg).
* Get the alloced lists through the lmb_get() function.


Sughosh Ganu (32):
  alist: add a helper to check if the list is full
  lmb: ut: disable unit tests for lmb changes
  lmb: remove the unused lmb_is_reserved() function
  lmb: staticize __lmb_alloc_base()
  lmb: use the BIT macro for lmb flags
  lmb: make LMB memory map persistent and global
  lmb: allow for resizing lmb regions
  lmb: remove config symbols used for lmb region count
  test: lmb: remove the test for max regions
  lmb: config: add lmb config symbols for SPL
  lmb: allow lmb module to be used in SPL
  lmb: remove the lmb_init_and_reserve() function
  lmb: remove lmb_init_and_reserve_range() function
  lmb: introduce a function to add memory to the lmb memory map
  lmb: reserve common areas during board init
  lmb: bootm: remove superfluous lmb stub functions
  lmb: init: initialise the lmb data structures during board init
  lmb: add a common implementation of arch_lmb_reserve()
  sandbox: move the TCG event log to the start of ram memory
  spl: call spl_board_init() at the end of the spl init sequence
  spl: sandbox: initialise the ram banksize in spl
  sandbox: spl: enable lmb config for SPL
  sandbox: iommu: remove lmb allocation in the driver
  zynq: lmb: do not add to lmb map before relocation
  stm32mp: allow calling optee_get_reserved_memory() from U-Boot
  stm32mp: compute ram_top based on the optee base address
  test: cedit: use allocated address for reading file
  test: lmb: tweak the tests for the persistent lmb memory map
  test: bdinfo: dump the global LMB memory map
  sandbox: adjust load address of couple of tests
  lmb: ut: re-enable unit tests
  lmb: add logic to print lmb flag strings

 arch/arc/lib/cache.c                         |  14 -
 arch/arm/lib/stack.c                         |  14 -
 arch/arm/mach-apple/board.c                  |  17 +-
 arch/arm/mach-snapdragon/board.c             |  17 +-
 arch/arm/mach-stm32mp/dram_init.c            |  33 +-
 arch/arm/mach-stm32mp/include/mach/stm32mp.h |  11 +
 arch/arm/mach-stm32mp/stm32mp1/cpu.c         |   7 +-
 arch/arm/mach-stm32mp/stm32mp1/spl.c         |  17 +-
 arch/m68k/lib/bootm.c                        |  20 +-
 arch/microblaze/lib/bootm.c                  |  14 -
 arch/mips/lib/bootm.c                        |  22 +-
 arch/nios2/lib/bootm.c                       |  13 -
 arch/powerpc/cpu/mpc85xx/mp.c                |   4 +-
 arch/powerpc/include/asm/mp.h                |   4 +-
 arch/powerpc/lib/bootm.c                     |  25 +-
 arch/riscv/lib/bootm.c                       |  13 -
 arch/sandbox/cpu/spl.c                       |  13 +-
 arch/sandbox/dts/test.dts                    |   2 +-
 arch/sandbox/include/asm/test.h              |   4 +
 arch/sh/lib/bootm.c                          |  13 -
 arch/x86/lib/bootm.c                         |  18 -
 arch/xtensa/lib/bootm.c                      |  13 -
 board/xilinx/common/board.c                  |  33 -
 boot/bootm.c                                 |  38 +-
 boot/bootm_os.c                              |   5 +-
 boot/image-board.c                           |  36 +-
 boot/image-fdt.c                             |  36 +-
 cmd/bdinfo.c                                 |   5 +-
 cmd/booti.c                                  |   2 +-
 cmd/bootz.c                                  |   2 +-
 cmd/elf.c                                    |   2 +-
 cmd/load.c                                   |   7 +-
 common/Kconfig                               |   2 +-
 common/board_r.c                             |  17 +
 common/spl/spl.c                             |   9 +-
 configs/a3y17lte_defconfig                   |   1 -
 configs/a5y17lte_defconfig                   |   1 -
 configs/a7y17lte_defconfig                   |   1 -
 configs/apple_m1_defconfig                   |   1 -
 configs/mt7981_emmc_rfb_defconfig            |   1 -
 configs/mt7981_rfb_defconfig                 |   1 -
 configs/mt7981_sd_rfb_defconfig              |   1 -
 configs/mt7986_rfb_defconfig                 |   1 -
 configs/mt7986a_bpir3_emmc_defconfig         |   1 -
 configs/mt7986a_bpir3_sd_defconfig           |   1 -
 configs/mt7988_rfb_defconfig                 |   1 -
 configs/mt7988_sd_rfb_defconfig              |   1 -
 configs/qcom_defconfig                       |   1 -
 configs/sandbox_noinst_defconfig             |   1 +
 configs/sandbox_spl_defconfig                |   1 +
 configs/sandbox_vpl_defconfig                |   1 -
 configs/stm32mp13_defconfig                  |   3 -
 configs/stm32mp15_basic_defconfig            |   3 -
 configs/stm32mp15_defconfig                  |   3 -
 configs/stm32mp15_trusted_defconfig          |   3 -
 configs/stm32mp25_defconfig                  |   3 -
 configs/th1520_lpi4a_defconfig               |   1 -
 doc/arch/sandbox/sandbox.rst                 |   3 +-
 drivers/iommu/apple_dart.c                   |   8 +-
 drivers/iommu/sandbox_iommu.c                |  35 +-
 fs/fs.c                                      |  10 +-
 include/alist.h                              |  11 +
 include/image.h                              |  28 +-
 include/lmb.h                                | 135 ++--
 lib/Kconfig                                  |  42 +-
 lib/Makefile                                 |   2 +-
 lib/efi_loader/efi_dt_fixup.c                |   2 +-
 lib/efi_loader/efi_helper.c                  |   2 +-
 lib/lmb.c                                    | 641 +++++++++++++------
 net/tftp.c                                   |  39 +-
 net/wget.c                                   |   9 +-
 test/boot/cedit.c                            |   6 +-
 test/cmd/bdinfo.c                            |  42 +-
 test/lib/kconfig.c                           |   4 +-
 test/lib/lmb.c                               | 542 ++++++++--------
 test/py/tests/test_android/test_abootimg.py  |   2 +-
 test/py/tests/test_vbe.py                    |   2 +-
 77 files changed, 988 insertions(+), 1111 deletions(-)
 create mode 100644 arch/arm/mach-stm32mp/include/mach/stm32mp.h

-- 
2.34.1


