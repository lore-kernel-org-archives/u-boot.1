Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512A6D1D879
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F1988CC5;
	Tue, 15 Oct 2024 17:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB8688CC5; Tue, 15 Oct 2024 17:38:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E5DCE88B99
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3FFF16F3;
 Tue, 15 Oct 2024 08:38:41 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8062D3F528;
 Tue, 15 Oct 2024 08:38:09 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 10/15] layerscape: use the lmb API's to add RAM memory
Date: Tue, 15 Oct 2024 21:07:12 +0530
Message-Id: <20241015153717.401371-11-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015153717.401371-1-sughosh.ganu@linaro.org>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
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

The EFI memory allocations are now being done through the LMB module,
and hence the memory map is maintained by the LMB module. Use the
lmb_arch_add_memory() API function to add the usable RAM memory to the
LMB's memory map.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V3: None

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 8 ++++----
 lib/Kconfig                             | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index f9c2083677a..d2d3e346a36 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -10,6 +10,7 @@
 #include <env.h>
 #include <init.h>
 #include <hang.h>
+#include <lmb.h>
 #include <log.h>
 #include <net.h>
 #include <vsprintf.h>
@@ -1525,8 +1526,8 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(EFI_LOADER)
-void efi_add_known_memory(void)
+#if CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP)
+void lmb_arch_add_memory(void)
 {
 	int i;
 	phys_addr_t ram_start;
@@ -1548,8 +1549,7 @@ void efi_add_known_memory(void)
 		    gd->arch.resv_ram < ram_start + ram_size)
 			ram_size = gd->arch.resv_ram - ram_start;
 #endif
-		efi_add_memory_map(ram_start, ram_size,
-				   EFI_CONVENTIONAL_MEMORY);
+		lmb_add(ram_start, ram_size);
 	}
 }
 #endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 3d2011ad4b7..b6b8b8d9c29 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1122,6 +1122,7 @@ config SPL_LMB
 config LMB_ARCH_MEM_MAP
 	bool "Add an architecture specific memory map"
 	depends on LMB
+	default y if FSL_LAYERSCAPE
 	help
 	  Some architectures have special or unique aspects which need
 	  consideration when adding memory ranges to the list of available
-- 
2.34.1

