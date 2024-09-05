Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131D0CD4F59
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 08:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE0588C1B;
	Thu,  5 Sep 2024 10:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C679788C1C; Thu,  5 Sep 2024 10:28:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BD9F088C0C
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 10:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961D7FEC;
 Thu,  5 Sep 2024 01:29:00 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3F383F66E;
 Thu,  5 Sep 2024 01:28:31 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 00/16] Make EFI memory allocations synchronous with LMB
Date: Thu,  5 Sep 2024 13:57:55 +0530
Message-Id: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
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

Note: To be applied on top of the next branch.


Sughosh Ganu (16):
  lmb: add versions of the lmb API with flags
  lmb: add a flag to allow suppressing memory map change notification
  efi: memory: use the lmb API's for allocating and freeing memory
  event: add event to notify lmb memory map changes
  lib: Kconfig: add a config symbol for getting lmb memory map updates
  add a function to check if an address is in RAM memory
  lmb: notify of any changes to the LMB memory map
  efi_memory: add an event handler to update memory map
  ti: k3: remove efi_add_known_memory() function definition
  stm32mp: remove efi_add_known_memory() function definition
  lmb: allow for boards to specify memory map
  layerscape: use the lmb API's to add RAM memory
  x86: e820: use the lmb API for adding RAM memory
  efi_memory: do not add RAM memory to the memory map
  lmb: remove call to efi_lmb_reserve()
  test: event: update the expected event dump output

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c |   8 +-
 arch/arm/mach-k3/common.c               |  11 --
 arch/arm/mach-stm32mp/dram_init.c       |  11 --
 arch/x86/lib/e820.c                     |  47 ++++--
 common/board_r.c                        |   5 +
 common/event.c                          |   2 +
 include/efi_loader.h                    |  12 +-
 include/event.h                         |  14 ++
 include/lmb.h                           |  11 ++
 lib/Kconfig                             |  30 ++++
 lib/efi_loader/Kconfig                  |   3 +
 lib/efi_loader/efi_memory.c             | 184 ++++++++----------------
 lib/lmb.c                               | 146 +++++++++++++------
 test/py/tests/test_event_dump.py        |   1 +
 14 files changed, 276 insertions(+), 209 deletions(-)

-- 
2.34.1


