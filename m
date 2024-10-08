Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7E5CEFC39
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 18:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5420C88EF9;
	Tue,  8 Oct 2024 20:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B449D88F2A; Tue,  8 Oct 2024 20:15:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BF00F88E26
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 20:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95EDDA7;
 Tue,  8 Oct 2024 11:15:39 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FFC83F64C;
 Tue,  8 Oct 2024 11:15:07 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 07/14] ti: k3: remove efi_add_known_memory() function
 definition
Date: Tue,  8 Oct 2024 23:44:28 +0530
Message-Id: <20241008181435.1753814-8-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
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

The efi_add_known_memory() function for the TI K3 platforms is adding
the EFI_CONVENTIONAL_MEMORY type. This memory is now being handled
through the LMB module -- the lmb_add_memory() adds this memory to the
memory map. Remove the definition of the now superfluous
efi_add_known_memory() function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 arch/arm/mach-k3/common.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index df48ec8d479..f2086cbdf51 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -310,14 +310,3 @@ void setup_qos(void)
 		writel(qos_data[i].val, (uintptr_t)qos_data[i].reg);
 }
 #endif
-
-void efi_add_known_memory(void)
-{
-	if (IS_ENABLED(CONFIG_EFI_LOADER))
-		/*
-		 * Memory over ram_top can be used by various firmware
-		 * Declare to EFI only memory area below ram_top
-		 */
-		efi_add_memory_map(gd->ram_base, gd->ram_top - gd->ram_base,
-				   EFI_CONVENTIONAL_MEMORY);
-}
-- 
2.34.1

