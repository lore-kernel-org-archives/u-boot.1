Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE2ECD4F5B
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 08:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96DE088C9C;
	Thu,  5 Sep 2024 10:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CDEB88CBF; Thu,  5 Sep 2024 10:29:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C525988CD2
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 10:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D304BFEC;
 Thu,  5 Sep 2024 01:29:29 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E06313F66E;
 Thu,  5 Sep 2024 01:29:00 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 10/16] stm32mp: remove efi_add_known_memory() function
 definition
Date: Thu,  5 Sep 2024 13:58:05 +0530
Message-Id: <20240905082811.1585467-11-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
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

The efi_add_known_memory() function for the stm32mp platforms is adding
the EFI_CONVENTIONAL_MEMORY type. This memory is now being handled
through the LMB module -- the lmb_add_memory() adds this memory to the
memory map. Remove the definition of the now superfluous
efi_add_known_memory() function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 arch/arm/mach-stm32mp/dram_init.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index 198785353f..3698fc49bf 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -86,14 +86,3 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 
 	return reg + size;
 }
-
-void efi_add_known_memory(void)
-{
-	if (IS_ENABLED(CONFIG_EFI_LOADER))
-		/*
-		 * Memory over ram_top is reserved to OPTEE.
-		 * Declare to EFI only memory area below ram_top
-		 */
-		efi_add_memory_map(gd->ram_base, gd->ram_top - gd->ram_base,
-				   EFI_CONVENTIONAL_MEMORY);
-}
-- 
2.34.1

