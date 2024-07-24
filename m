Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F9DC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DAD88853;
	Wed, 24 Jul 2024 08:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB2788845; Wed, 24 Jul 2024 08:02:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7BCF3887FA
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CFE3106F;
 Tue, 23 Jul 2024 23:03:08 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636683F766;
 Tue, 23 Jul 2024 23:02:38 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 00/40] Make LMB memory map global and persistent
Date: Wed, 24 Jul 2024 11:31:44 +0530
Message-Id: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
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
SPL. The allocation API's have been tweaked to introduce a flag
argument, which will pass any flags that might be associated with a
lmb memory region. This is being done to avoid having a separate set
of API's for the EFI memory module, thus saving on space.

The tests have been tweaked where needed because of these changes.

The second part of the patches, to be sent subsequently, would work on
having the EFI allocations work with the LMB API's.

[1] - https://lore.kernel.org/u-boot/20240704073544.670249-1-sughosh.ganu@linaro.org/T/#t

Changes since rfc:
* Squash patches 9 - 11, 13  from the rfc v2 series into a single
  patch to make it bisectable.
* Add a function comment for lmb_add_region_flags().
* Change the wording of a comment in lmb_merge_overlap_regions() as
  per review comment from Simon Glass.
* Replace conditional compilation of lmb code to an if
  (CONFIG_IS_ENABLED()) in store_block() and tftp_init_load_addr().
* Add a function for reserving common areas in SPL,
  lmb_reserve_common_spl()
* Enable SPL config for sandbox_noinst
* Change the lmb_mem_regions_init() function to have it called from
  the lmb tests as well.


Simon Glass (4):
  malloc: Support testing with realloc()
  lib: Handle a special case with str_to_list()
  alist: Add support for an allocated pointer list
  lib: Convert str_to_list() to use alist

Sughosh Ganu (36):
  spl: alloc: call full alloc functions if malloc pool is available
  alist: add a couple of helper functions
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
  lmb: introduce a function to add memory to the lmb memory map
  lmb: remove the lmb_init_and_reserve() function
  lmb: reserve common areas during board init
  lmb: remove lmb_init_and_reserve_range() function
  lmb: bootm: remove superfluous lmb stub functions
  lmb: init: initialise the lmb data structures during board init
  lmb: add a flags parameter to the API's
  lmb: add a common implementation of arch_lmb_reserve()
  sandbox: move the TCG event log to the start of ram memory
  spl: call spl_board_init() at the end of the spl init sequence
  spl: sandbox: initialise the ram banksize in spl
  lmb: config: make lmb config symbol def_bool
  sandbox: spl: enable lmb config for SPL
  sandbox: iommu: remove lmb allocation in the driver
  zynq: lmb: do not add to lmb map before relocation
  stm32mp: do not add lmb memory before relocation
  test: cedit: use allocated address for reading file
  test: lmb: tweak the tests for the persistent lmb memory map
  test: lmb: run lmb tests only manually
  test: lmb: add a separate class of unit tests for lmb
  test: lmb: invoke the LMB unit tests from a separate script
  test: bdinfo: dump the global LMB memory map
  sandbox: adjust load address of couple of tests
  lmb: ut: re-enable unit tests

 arch/arc/lib/cache.c                        |  14 -
 arch/arm/lib/stack.c                        |  14 -
 arch/arm/mach-apple/board.c                 |  20 +-
 arch/arm/mach-snapdragon/board.c            |  17 +-
 arch/arm/mach-stm32mp/dram_init.c           |  13 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c        |   7 +-
 arch/m68k/lib/bootm.c                       |  20 +-
 arch/microblaze/lib/bootm.c                 |  14 -
 arch/mips/lib/bootm.c                       |  22 +-
 arch/nios2/lib/bootm.c                      |  13 -
 arch/powerpc/cpu/mpc85xx/mp.c               |   4 +-
 arch/powerpc/include/asm/mp.h               |   4 +-
 arch/powerpc/lib/bootm.c                    |  25 +-
 arch/riscv/lib/bootm.c                      |  13 -
 arch/sandbox/cpu/spl.c                      |  13 +-
 arch/sandbox/dts/test.dts                   |   2 +-
 arch/sh/lib/bootm.c                         |  13 -
 arch/x86/lib/bootm.c                        |  18 -
 arch/xtensa/lib/bootm.c                     |  13 -
 board/xilinx/common/board.c                 |  33 -
 boot/bootm.c                                |  39 +-
 boot/bootm_os.c                             |   5 +-
 boot/image-board.c                          |  47 +-
 boot/image-fdt.c                            |  37 +-
 cmd/bdinfo.c                                |   5 +-
 cmd/booti.c                                 |   2 +-
 cmd/bootz.c                                 |   2 +-
 cmd/elf.c                                   |   2 +-
 cmd/load.c                                  |   7 +-
 common/board_r.c                            |   4 +
 common/dlmalloc.c                           |   4 +
 common/malloc_simple.c                      |  13 +
 common/spl/spl.c                            |   9 +-
 configs/a3y17lte_defconfig                  |   1 -
 configs/a5y17lte_defconfig                  |   1 -
 configs/a7y17lte_defconfig                  |   1 -
 configs/apple_m1_defconfig                  |   1 -
 configs/mt7981_emmc_rfb_defconfig           |   1 -
 configs/mt7981_rfb_defconfig                |   1 -
 configs/mt7981_sd_rfb_defconfig             |   1 -
 configs/mt7986_rfb_defconfig                |   1 -
 configs/mt7986a_bpir3_emmc_defconfig        |   1 -
 configs/mt7986a_bpir3_sd_defconfig          |   1 -
 configs/mt7988_rfb_defconfig                |   1 -
 configs/mt7988_sd_rfb_defconfig             |   1 -
 configs/qcom_defconfig                      |   1 -
 configs/sandbox_noinst_defconfig            |   1 +
 configs/sandbox_spl_defconfig               |   1 +
 configs/sandbox_vpl_defconfig               |   1 -
 configs/stm32mp13_defconfig                 |   3 -
 configs/stm32mp15_basic_defconfig           |   3 -
 configs/stm32mp15_defconfig                 |   3 -
 configs/stm32mp15_trusted_defconfig         |   3 -
 configs/stm32mp25_defconfig                 |   3 -
 configs/th1520_lpi4a_defconfig              |   1 -
 drivers/iommu/apple_dart.c                  |   8 +-
 drivers/iommu/sandbox_iommu.c               |  19 +-
 fs/fs.c                                     |  10 +-
 include/alist.h                             | 236 ++++++
 include/image.h                             |  28 +-
 include/lmb.h                               | 159 ++--
 include/test/suites.h                       |   1 +
 lib/Kconfig                                 |  46 +-
 lib/Makefile                                |   3 +-
 lib/alist.c                                 | 147 ++++
 lib/efi_loader/efi_dt_fixup.c               |   2 +-
 lib/efi_loader/efi_helper.c                 |   2 +-
 lib/lmb.c                                   | 672 +++++++++++-----
 lib/strto.c                                 |  33 +-
 net/tftp.c                                  |  39 +-
 net/wget.c                                  |   9 +-
 test/Kconfig                                |   9 +
 test/Makefile                               |   1 +
 test/boot/cedit.c                           |   6 +-
 test/cmd/bdinfo.c                           |  39 +-
 test/cmd_ut.c                               |   7 +
 test/lib/Makefile                           |   2 +-
 test/lib/alist.c                            | 197 +++++
 test/lib/lmb.c                              | 825 --------------------
 test/lmb_ut.c                               | 813 +++++++++++++++++++
 test/py/tests/test_android/test_abootimg.py |   2 +-
 test/py/tests/test_lmb.py                   |  24 +
 test/py/tests/test_vbe.py                   |   2 +-
 test/str_ut.c                               |   4 +-
 84 files changed, 2192 insertions(+), 1653 deletions(-)
 create mode 100644 include/alist.h
 create mode 100644 lib/alist.c
 create mode 100644 test/lib/alist.c
 delete mode 100644 test/lib/lmb.c
 create mode 100644 test/lmb_ut.c
 create mode 100644 test/py/tests/test_lmb.py

-- 
2.34.1


