Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BB4C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20506885D7;
	Thu,  4 Jul 2024 09:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C1C8889F; Thu,  4 Jul 2024 09:36:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A405C885B3
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A18367;
 Thu,  4 Jul 2024 00:36:29 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29EF93F762;
 Thu,  4 Jul 2024 00:36:00 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
Date: Thu,  4 Jul 2024 13:04:56 +0530
Message-Id: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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


The aim of this patch series is to fix the current state of
incoherence between modules when it comes to memory usage. The primary
issue that this series is trying to fix is that the EFI memory module
which is responsible for allocating and freeing memory, does not have
any visibility of the memory that is being used by the LMB
module. This is further complicated by the fact that the LMB
allocations are caller specific -- the LMB memory map is not global
nor persistent. This means that the memory "allocated" by the LMB
module might be relevant only for a given function. Hence one of the
requirements for making the memory usage visible across modules is to
make LMB allocations persistent and global, and then have means to
communicate the use of memory across modules.

The first set of patches in this series work on making the LMB memory
map persistent and global. This is being done keeping in mind the
usage of LMB memory by platforms where the same memory region can be
used to load multiple different images. What is not allowed is to
overwrite memory that has been allocated by the other module,
currently the EFI memory module. This is being achieved by introducing
a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
re-requested once allocated.

A review comment on the earlier version was to do away with the static
arrays for the LMB lists of free and used memory. This version
uses the alloced list data structure for the LMB lists.

The second set of patches are making changes to the EFI memory module
to make use of the LMB functions to allocate and free memory. A
*_flags() version of LMB API's has been introduced for the same. The
earlier version was using notification mechanism from both LMB and EFI
modules to maintain memory coherence. This version makes use of the
LMB API functions for the memory allocations. This is based on review
comments of EFI maintainers.

Patches 1 - 4 are from Simon Glass and are adding support for the
alloced list data structure.

Patches 5 - 33 are for making the LMB memory map persistent and
global.

Patches 34 - 48 are for making EFI memory allocations work with LMB
API's.

Note: 

* Once the general direction of these patches has been agreed
  upon, I plan to split these patches into two series, with the above
  split.

* I am running the CI over a patch from Rasmus Villemoes -
  RFC-test-cyclic-try-to-avoid-spurious-test-failures-due-to-cyclic-callbacks.patch
  I get spurious watchdog timeout errors without this patch.

* Because this is common code, and I was not able to disable LMB
  config(some code under boot/ fails to build), all of the patches
  need to be applied together when testing.

Todo's
------

There needs to be a test written for testing the various scenarios of
memory being allocated and freed by different modules, namely LMB and
EFI. I have written a couple of commands for testing the changes that
I have made. I will be working on this once there is agreement on the
patches.

Secondly, there were comments on the earlier series about things like
code size impact etc, but I have not looked at those right now. I will
look at these aspects in the following version.


Simon Glass (4):
  malloc: Support testing with realloc()
  lib: Handle a special case with str_to_list()
  alist: Add support for an allocated pointer list
  lib: Convert str_to_list() to use alist

Sughosh Ganu (44):
  alist: add a couple of helper functions
  alist: add a function declaration for alist_expand_by()
  lmb: remove the unused lmb_is_reserved() function
  lmb: staticize __lmb_alloc_base()
  lmb: remove call to lmb_init()
  lmb: remove local instances of the lmb structure variable
  lmb: pass a flag to image_setup_libfdt() for lmb reservations
  lmb: allow for resizing lmb regions
  lmb: make LMB memory map persistent and global
  lmb: remove config symbols used for lmb region count
  test: lmb: remove the test for max regions
  lmb: config: add lmb config symbols for SPL
  lmb: allow lmb module to be used in SPL
  lmb: introduce a function to add memory to the lmb memory map
  lmb: remove the lmb_init_and_reserve() function
  lmb: reserve common areas during board init
  lmb: remove lmb_init_and_reserve_range() function
  lmb: init: initialise the lmb data structures during board init
  lmb: use the BIT macro for lmb flags
  lmb: add a common implementation of arch_lmb_reserve()
  sandbox: spl: enable lmb in SPL
  sandbox: iommu: remove lmb allocation in the driver
  zynq: lmb: do not add to lmb map before relocation
  test: cedit: use allocated address for reading file
  test: lmb: tweak the tests for the persistent lmb memory map
  test: lmb: run lmb tests only manually
  test: lmb: add a separate class of unit tests for lmb
  test: lmb: invoke the LMB unit tests from a separate script
  test: bdinfo: dump the global LMB memory map
  lmb: add versions of the lmb API with flags
  lmb: add a flag to allow suppressing memory map change notification
  efi: memory: use the lmb API's for allocating and freeing memory
  event: add event to notify lmb memory map changes
  lib: Kconfig: add a config symbol for getting lmb memory map updates
  add a function to check if an address is in RAM memory
  lmb: notify of any changes to the LMB memory map
  efi_memory: add an event handler to update memory map
  ti: k3: remove efi_add_known_memory() function definition
  layerscape: use the lmb API's to add RAM memory
  x86: e820: use the lmb API for adding RAM memory
  efi_memory: do not add RAM memory to the memory map
  lmb: mark the EFI runtime memory regions as reserved
  test: event: update the expected event dump output
  temp: mx6sabresd: bump up the size limit of the board

 arch/arc/lib/cache.c                    |  14 -
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c |   8 +-
 arch/arm/lib/stack.c                    |  14 -
 arch/arm/mach-apple/board.c             |  17 +-
 arch/arm/mach-k3/common.c               |  11 -
 arch/arm/mach-snapdragon/board.c        |  17 +-
 arch/arm/mach-stm32mp/dram_init.c       |   8 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c    |   7 +-
 arch/m68k/lib/bootm.c                   |  20 +-
 arch/microblaze/lib/bootm.c             |  14 -
 arch/mips/lib/bootm.c                   |  22 +-
 arch/nios2/lib/bootm.c                  |  13 -
 arch/powerpc/cpu/mpc85xx/mp.c           |   4 +-
 arch/powerpc/include/asm/mp.h           |   4 +-
 arch/powerpc/lib/bootm.c                |  25 +-
 arch/riscv/lib/bootm.c                  |  13 -
 arch/sh/lib/bootm.c                     |  13 -
 arch/x86/lib/bootm.c                    |  18 -
 arch/x86/lib/e820.c                     |  47 +-
 arch/xtensa/lib/bootm.c                 |  13 -
 board/xilinx/common/board.c             |  33 -
 boot/bootm.c                            |  37 +-
 boot/bootm_os.c                         |   5 +-
 boot/image-board.c                      |  36 +-
 boot/image-fdt.c                        |  36 +-
 cmd/bdinfo.c                            |   5 +-
 cmd/booti.c                             |   2 +-
 cmd/bootz.c                             |   2 +-
 cmd/elf.c                               |   2 +-
 cmd/load.c                              |   7 +-
 common/board_r.c                        |   9 +
 common/dlmalloc.c                       |   4 +
 common/event.c                          |   2 +
 common/spl/spl.c                        |   4 +
 configs/a3y17lte_defconfig              |   1 -
 configs/a5y17lte_defconfig              |   1 -
 configs/a7y17lte_defconfig              |   1 -
 configs/apple_m1_defconfig              |   1 -
 configs/mt7981_emmc_rfb_defconfig       |   1 -
 configs/mt7981_rfb_defconfig            |   1 -
 configs/mt7981_sd_rfb_defconfig         |   1 -
 configs/mt7986_rfb_defconfig            |   1 -
 configs/mt7986a_bpir3_emmc_defconfig    |   1 -
 configs/mt7986a_bpir3_sd_defconfig      |   1 -
 configs/mt7988_rfb_defconfig            |   1 -
 configs/mt7988_sd_rfb_defconfig         |   1 -
 configs/mx6sabresd_defconfig            |   2 +-
 configs/qcom_defconfig                  |   1 -
 configs/sandbox_spl_defconfig           |   1 +
 configs/stm32mp13_defconfig             |   3 -
 configs/stm32mp15_basic_defconfig       |   3 -
 configs/stm32mp15_defconfig             |   3 -
 configs/stm32mp15_trusted_defconfig     |   3 -
 configs/stm32mp25_defconfig             |   3 -
 configs/th1520_lpi4a_defconfig          |   1 -
 drivers/iommu/apple_dart.c              |   8 +-
 drivers/iommu/sandbox_iommu.c           |  17 +-
 fs/fs.c                                 |  10 +-
 include/alist.h                         | 236 +++++++
 include/efi_loader.h                    |  12 +-
 include/event.h                         |  14 +
 include/image.h                         |  27 +-
 include/lmb.h                           | 146 ++---
 include/test/suites.h                   |   1 +
 lib/Kconfig                             |  52 +-
 lib/Makefile                            |   3 +-
 lib/alist.c                             | 154 +++++
 lib/efi_loader/Kconfig                  |   2 +
 lib/efi_loader/efi_dt_fixup.c           |   2 +-
 lib/efi_loader/efi_helper.c             |   2 +-
 lib/efi_loader/efi_memory.c             | 187 ++----
 lib/lmb.c                               | 745 ++++++++++++++-------
 lib/strto.c                             |  33 +-
 net/tftp.c                              |  11 +-
 net/wget.c                              |   9 +-
 test/Kconfig                            |   9 +
 test/Makefile                           |   1 +
 test/boot/cedit.c                       |   6 +-
 test/cmd/bdinfo.c                       |  39 +-
 test/cmd_ut.c                           |   7 +
 test/lib/Makefile                       |   2 +-
 test/lib/alist.c                        | 197 ++++++
 test/lib/lmb.c                          | 825 ------------------------
 test/lmb_ut.c                           | 811 +++++++++++++++++++++++
 test/py/tests/test_event_dump.py        |   1 +
 test/py/tests/test_lmb.py               |  24 +
 test/str_ut.c                           |   4 +-
 87 files changed, 2346 insertions(+), 1769 deletions(-)
 create mode 100644 include/alist.h
 create mode 100644 lib/alist.c
 create mode 100644 test/lib/alist.c
 delete mode 100644 test/lib/lmb.c
 create mode 100644 test/lmb_ut.c
 create mode 100644 test/py/tests/test_lmb.py

-- 
2.34.1


