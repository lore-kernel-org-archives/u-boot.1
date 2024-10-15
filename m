Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12020CFC27C
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA3888875;
	Tue, 15 Oct 2024 17:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B75388770; Tue, 15 Oct 2024 17:37:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E87B388730
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 014961007;
 Tue, 15 Oct 2024 08:38:08 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0E0D3F528;
 Tue, 15 Oct 2024 08:37:35 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v4 00/15] Make EFI memory allocations synchronous with LMB
Date: Tue, 15 Oct 2024 21:07:02 +0530
Message-Id: <20241015153717.401371-1-sughosh.ganu@linaro.org>
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


This is part two of the series to have the EFI and LMB modules have a
coherent view of memory. Part one of this goal was to change the LMB
module to have a global and persistent memory map. Those patches have
now been applied to the next branch.

These patches are changing the EFI memory allocation API's such that
they rely on the LMB module to allocate RAM memory. This fixes the
current scenario where the EFI memory module has no visibility of the
allocations/reservations made by the LMB module. One thing to note
here is that this is limited to the RAM memory region, i.e. the
EFI_CONVENTIONAL_MEMORY type. Any other memory type that is to be
added to the EFI memory map, still gets handled by the EFI memory
module.


Changes since V3:
* Add comments for the LMB_NOOVERWRITE and LMB_NONOTIFY flags
* Drop use of is_addr_in_ram() function
* Drop use of CONFIG_MEM_MAP_UPDATE_NOTIFY symbol to check if the
  notification needs to be sent.
* s/lmb_notify/lmb_should_notify
* Put a check for EFI_LOADER in the lmb_should_notify() function


Some test logs to highlight the issue that is being fixed by the series.

Without patch series
--------------------

lmb_dump_all:
 memory.count = 0x1
 memory[0]	[0x40000000-0x820fffff], 0x42100000 bytes flags: none
 reserved.count = 0x3
 reserved[0]	[0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
 reserved[1]	[0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
 reserved[2]	[0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite


=> efidebug memmap -- does not show regions allocated by lmb

Missing TPMv2 device for EFI_TCG_PROTOCOL
Type             Start            End              Attributes
================ ================ ================ ==========
CONVENTIONAL     0000000040000000-000000007f751000 WB
BOOT DATA        000000007f751000-000000007f756000 WB
RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
BOOT DATA        000000007f757000-000000007f758000 WB
RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
BOOT DATA        000000007f77a000-000000007f781000 WB
BOOT CODE        000000007f781000-00000000807b5000 WB
RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
BOOT CODE        00000000807b6000-00000000817c0000 WB
RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
BOOT CODE        00000000817d0000-0000000082100000 WB
=> 


Trying to allocate EFI memory with already allocated region succeeds(should fail)
---------------------------------------------------------------------------------

=> efi_mem alloc 2000 42000000
Address returned 0x42000000

=> efidebug memmap
Type             Start            End              Attributes
================ ================ ================ ==========
CONVENTIONAL     0000000040000000-0000000042000000 WB
BOOT DATA        0000000042000000-0000000042002000 WB
CONVENTIONAL     0000000042002000-000000007f751000 WB
BOOT DATA        000000007f751000-000000007f756000 WB
RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
BOOT DATA        000000007f757000-000000007f758000 WB
RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
BOOT DATA        000000007f77a000-000000007f781000 WB
BOOT CODE        000000007f781000-00000000807b5000 WB
RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
BOOT CODE        00000000807b6000-00000000817c0000 WB
RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
BOOT CODE        00000000817d0000-0000000082100000 WB
=> 


With patch series
-----------------

lmb_dump_all:
 memory.count = 0x1
 memory[0]	[0x40000000-0x820fffff], 0x42100000 bytes flags: none
 reserved.count = 0x4
 reserved[0]	[0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
 reserved[1]	[0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
 reserved[2]	[0x7f74f000-0x7f77dfff], 0x0002f000 bytes flags: no-notify, no-overwrite
 reserved[3]	[0x7f77ea00-0x820fffff], 0x02981600 bytes flags: no-overwrite


=> efidebug memmap
Type             Start            End              Attributes
================ ================ ================ ==========
BOOT DATA        000000000e100000-000000000f000000 WB
CONVENTIONAL     0000000040000000-0000000042000000 WB
BOOT DATA        0000000042000000-0000000042200000 WB
CONVENTIONAL     0000000042200000-000000007f74e000 WB
BOOT DATA        000000007f74e000-000000007f753000 WB
RUNTIME DATA     000000007f753000-000000007f754000 WB|RT
BOOT DATA        000000007f754000-000000007f755000 WB
RUNTIME DATA     000000007f755000-000000007f777000 WB|RT
BOOT DATA        000000007f777000-00000000807b6000 WB
RUNTIME DATA     00000000807b6000-00000000807b7000 WB|RT
BOOT DATA        00000000807b7000-00000000817c0000 WB
RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
BOOT DATA        00000000817d0000-0000000082100000 WB


Trying to allocate EFI memory with already allocated region fails
-----------------------------------------------------------------

=> efi_mem alloc 2000 42000000
efi_allocate_pages failed 800000000000000e
=> 

Trying to allocate EFI memory with non-allocated region succeeds
----------------------------------------------------------------

=> efi_mem alloc 2000 42200000
Address returned 0x42200000

=> efidebug memmap            
Type             Start            End              Attributes
================ ================ ================ ==========
BOOT DATA        000000000e100000-000000000f000000 WB
CONVENTIONAL     0000000040000000-0000000042000000 WB
BOOT DATA        0000000042000000-0000000042202000 WB
CONVENTIONAL     0000000042202000-000000007f74d000 WB
BOOT DATA        000000007f74d000-000000007f752000 WB
RUNTIME DATA     000000007f752000-000000007f753000 WB|RT
BOOT DATA        000000007f753000-000000007f754000 WB
RUNTIME DATA     000000007f754000-000000007f776000 WB|RT
BOOT DATA        000000007f776000-00000000807b5000 WB
RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
BOOT DATA        00000000807b6000-00000000817c0000 WB
RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
BOOT DATA        00000000817d0000-0000000082100000 WB
=> 

lmb_dump_all:
 memory.count = 0x1
 memory[0]	[0x40000000-0x820fffff], 0x42100000 bytes flags: none
 reserved.count = 0x5
 reserved[0]	[0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
 reserved[1]	[0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
 reserved[2]	[0x42200000-0x42201fff], 0x00002000 bytes flags: no-notify, no-overwrite
 reserved[3]	[0x7f74e000-0x7f77cfff], 0x0002f000 bytes flags: no-notify, no-overwrite
 reserved[4]	[0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite


Sughosh Ganu (15):
  lmb: add versions of the lmb API with flags
  lmb: add a flag to allow suppressing memory map change notification
  lmb: add and reserve memory above ram_top
  efi: memory: use the lmb API's for allocating and freeing memory
  lmb: notify of any changes to the LMB memory map
  efi_memory: do not add U-Boot memory to the memory map
  ti: k3: remove efi_add_known_memory() function definition
  stm32mp: remove efi_add_known_memory() function definition
  lmb: allow for boards to specify memory map
  layerscape: use the lmb API's to add RAM memory
  x86: e820: use the lmb API for adding RAM memory
  efi_memory: do not add RAM memory to the memory map
  lmb: remove call to efi_lmb_reserve()
  efi_memory: rename variable to highlight overlap with free memory
  lmb: replace the double-underscore with single-underscore for all
    functions

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c |   8 +-
 arch/arm/mach-k3/common.c               |  11 --
 arch/arm/mach-stm32mp/dram_init.c       |  11 --
 arch/x86/lib/e820.c                     |  47 +++--
 include/efi_loader.h                    |  27 ++-
 include/lmb.h                           |  63 ++++++
 lib/Kconfig                             |  19 ++
 lib/efi_loader/Kconfig                  |   1 +
 lib/efi_loader/efi_memory.c             | 217 ++++++---------------
 lib/lmb.c                               | 242 ++++++++++++++++++------
 10 files changed, 389 insertions(+), 257 deletions(-)

-- 
2.34.1


