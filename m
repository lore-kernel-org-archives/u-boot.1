Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F7CEFC39
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 18:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33DD788D27;
	Tue,  8 Oct 2024 20:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3576288C78; Tue,  8 Oct 2024 20:14:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 171C388B63
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 20:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF4F9DA7;
 Tue,  8 Oct 2024 11:15:15 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4C773F64C;
 Tue,  8 Oct 2024 11:14:43 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 00/14]  Make EFI memory allocations synchronous with LMB
Date: Tue,  8 Oct 2024 23:44:21 +0530
Message-Id: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
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


Changes since V1:
* Add comments for the API's added
* Add a config for SPL stage
* Call the efi_add_memory_map_pg() function directly from the
  lmb_map_update_notify() instead of doing it through the event
  framework.
* Call the efi_add_memory_map_pg() with overlap_only_ram argument set
  to false, to allow for overlapping allocation design of LMB.
* Use the return value of lmb_map_update_notify() at it's call sites
* Do not remove the inclusion of efi_loader.h as it is now needed for
  the lmb_map_update_notify()


Sughosh Ganu (14):
  lmb: add versions of the lmb API with flags
  lmb: add a flag to allow suppressing memory map change notification
  efi: memory: use the lmb API's for allocating and freeing memory
  lib: Kconfig: add a config symbol for getting lmb memory map updates
  add a function to check if an address is in RAM memory
  lmb: notify of any changes to the LMB memory map
  ti: k3: remove efi_add_known_memory() function definition
  stm32mp: remove efi_add_known_memory() function definition
  lmb: allow for boards to specify memory map
  layerscape: use the lmb API's to add RAM memory
  x86: e820: use the lmb API for adding RAM memory
  efi_memory: do not add RAM memory to the memory map
  lmb: remove call to efi_lmb_reserve()
  efi_memory: rename variable to highlight overlap with free memory

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c |   8 +-
 arch/arm/mach-k3/common.c               |  11 --
 arch/arm/mach-stm32mp/dram_init.c       |  11 --
 arch/x86/lib/e820.c                     |  47 +++--
 common/board_r.c                        |   5 +
 include/efi_loader.h                    |  27 ++-
 include/lmb.h                           |  61 +++++++
 lib/Kconfig                             |  36 ++++
 lib/efi_loader/Kconfig                  |   2 +
 lib/efi_loader/efi_memory.c             | 202 ++++++----------------
 lib/lmb.c                               | 220 +++++++++++++++++++-----
 11 files changed, 398 insertions(+), 232 deletions(-)

-- 
2.34.1


