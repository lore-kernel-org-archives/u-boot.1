Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B338C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 10:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF3688C36;
	Wed, 21 Aug 2024 12:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9641188B4C; Wed, 21 Aug 2024 12:59:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0703688B52
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 12:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59290DA7;
 Wed, 21 Aug 2024 03:59:23 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 350F33F73B;
 Wed, 21 Aug 2024 03:58:53 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PATCH v3 00/27] Make LMB memory map global and persistent
Date: Wed, 21 Aug 2024 16:28:12 +0530
Message-Id: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
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


Changes since V2:
* Use a value of 0 for LMB_NONE instead of BIT(0)
* Put the changes made to the test code as part of this patch, based
  on a review comment to not disable tests.
* Do not define lmb_add_memory() as a weak function.
* Use if(CONFIG_IS_ENABLED(...)) in initr_lmb() instead of an #ifdef.
* Remove the definitions of arch_lmb_reserve() and
  arch_lmb_reserve_generic() functions.
* Introduce a new function lmb_reserve_uboot_region() and call it from
  lmb_reserve_common().
* Move the TCG event log to a location such that it does not clash
  with any load addresses in the tests.
* Adjust the values of CONFIG_TRACE_EARLY_ADDR and U-Boot load address
  for SPL accordingly.
* Put the details of the calling of the dram_init_banksize() function
  in the commit message, as per Simon's review comment.
* Change the logic to accomodate new value of LMB_NONE(0).
* s/print_region_flags()/lmb_print_region_flags().
* s/"LMB_NOMAP"/"no-map".
* s/"LMB_NOOVERWRITE"/"no-overwrite".


Sughosh Ganu (27):
  alist: add a helper to check if the list is full
  lmb: remove the unused lmb_is_reserved() function
  lmb: staticize __lmb_alloc_base()
  lmb: use the BIT macro for lmb flags
  lmb: make LMB memory map persistent and global
  lmb: allow for resizing lmb regions
  lmb: remove config symbols used for lmb region count
  lmb: config: add lmb config symbols for SPL
  lmb: allow lmb module to be used in SPL
  lmb: introduce a function to add memory to the lmb memory map
  lmb: reserve common areas during board init
  lmb: remove the lmb_init_and_reserve() function
  lmb: remove lmb_init_and_reserve_range() function
  lmb: bootm: remove superfluous lmb stub functions
  lmb: init: initialise the lmb data structures during board init
  ppc: lmb: move arch specific lmb reservations to arch_misc_init()
  lmb: do away with arch_lmb_reserve()
  lmb: remove the unused board_lmb_reserve() function
  sandbox: move the TCG event log to the start of ram memory
  spl: call spl_board_init() at the end of the spl init sequence
  spl: sandbox: initialise the ram banksize in spl
  sandbox: spl: enable lmb config for SPL
  sandbox: iommu: remove lmb allocation in the driver
  zynq: lmb: do not add to lmb map before relocation
  stm32mp: allow calling optee_get_reserved_memory() from U-Boot
  stm32mp: compute ram_top based on the optee base address
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
 arch/powerpc/cpu/mpc85xx/cpu_init.c          |  16 -
 arch/powerpc/cpu/mpc85xx/mp.c                |   4 +-
 arch/powerpc/include/asm/mp.h                |   4 +-
 arch/powerpc/lib/Makefile                    |   1 +
 arch/powerpc/lib/bootm.c                     |  55 +-
 arch/powerpc/lib/misc.c                      |  62 ++
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
 common/board_r.c                             |  10 +
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
 configs/sandbox_spl_defconfig                |   3 +-
 configs/stm32mp13_defconfig                  |   3 -
 configs/stm32mp15_basic_defconfig            |   3 -
 configs/stm32mp15_defconfig                  |   3 -
 configs/stm32mp15_trusted_defconfig          |   3 -
 configs/stm32mp25_defconfig                  |   3 -
 configs/th1520_lpi4a_defconfig               |   1 -
 doc/arch/sandbox/sandbox.rst                 |   5 +-
 drivers/iommu/apple_dart.c                   |   8 +-
 drivers/iommu/sandbox_iommu.c                |  35 +-
 fs/fs.c                                      |  10 +-
 include/alist.h                              |  11 +
 include/image.h                              |  28 +-
 include/lmb.h                                | 131 ++--
 lib/Kconfig                                  |  45 +-
 lib/Makefile                                 |   2 +-
 lib/efi_loader/efi_dt_fixup.c                |   2 +-
 lib/efi_loader/efi_helper.c                  |   2 +-
 lib/lmb.c                                    | 689 ++++++++++++-------
 net/tftp.c                                   |  39 +-
 net/wget.c                                   |   9 +-
 test/cmd/bdinfo.c                            |  41 +-
 test/lib/lmb.c                               | 542 +++++++--------
 74 files changed, 1044 insertions(+), 1190 deletions(-)
 create mode 100644 arch/arm/mach-stm32mp/include/mach/stm32mp.h
 create mode 100644 arch/powerpc/lib/misc.c

-- 
2.34.1


