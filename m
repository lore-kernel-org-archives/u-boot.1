Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A02ACEFC39
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 18:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F3B88F27;
	Tue,  8 Oct 2024 20:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D1D088F50; Tue,  8 Oct 2024 20:15:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6460E88E26
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 20:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7014DDA7;
 Tue,  8 Oct 2024 11:15:53 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 052FE3F64C;
 Tue,  8 Oct 2024 11:15:20 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 11/14] x86: e820: use the lmb API for adding RAM memory
Date: Tue,  8 Oct 2024 23:44:32 +0530
Message-Id: <20241008181435.1753814-12-sughosh.ganu@linaro.org>
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

The EFI_CONVENTIONAL_MEMORY type is now being managed through the LMB
module. Add a separate function, lmb_arch_add_memory() to add the RAM
memory to the LMB memory map. The efi_add_known_memory() function is
now used for adding any other memory type to the EFI memory map.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 arch/x86/lib/e820.c | 47 ++++++++++++++++++++++++++++++++++-----------
 lib/Kconfig         |  2 +-
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/x86/lib/e820.c b/arch/x86/lib/e820.c
index 122b4f7ca01..d478b7486e3 100644
--- a/arch/x86/lib/e820.c
+++ b/arch/x86/lib/e820.c
@@ -4,6 +4,7 @@
  */
 
 #include <efi_loader.h>
+#include <lmb.h>
 #include <asm/e820.h>
 #include <asm/global_data.h>
 
@@ -41,15 +42,11 @@ void efi_add_known_memory(void)
 {
 	struct e820_entry e820[E820MAX];
 	unsigned int i, num;
-	u64 start, ram_top;
+	u64 start;
 	int type;
 
 	num = install_e820_map(ARRAY_SIZE(e820), e820);
 
-	ram_top = (u64)gd->ram_top & ~EFI_PAGE_MASK;
-	if (!ram_top)
-		ram_top = 0x100000000ULL;
-
 	for (i = 0; i < num; ++i) {
 		start = e820[i].addr;
 
@@ -72,13 +69,41 @@ void efi_add_known_memory(void)
 			break;
 		}
 
-		if (type == EFI_CONVENTIONAL_MEMORY) {
-			efi_add_conventional_memory_map(start,
-							start + e820[i].size,
-							ram_top);
-		} else {
+		if (type != EFI_CONVENTIONAL_MEMORY)
 			efi_add_memory_map(start, e820[i].size, type);
-		}
 	}
 }
 #endif /* CONFIG_IS_ENABLED(EFI_LOADER) */
+
+#if CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP)
+void lmb_arch_add_memory(void)
+{
+	struct e820_entry e820[E820MAX];
+	unsigned int i, num;
+	u64 ram_top;
+
+	num = install_e820_map(ARRAY_SIZE(e820), e820);
+
+	ram_top = (u64)gd->ram_top & ~EFI_PAGE_MASK;
+	if (!ram_top)
+		ram_top = 0x100000000ULL;
+
+	for (i = 0; i < num; ++i) {
+		if (e820[i].type == E820_RAM) {
+			u64 start, size, rgn_top;
+
+			start = e820[i].addr;
+			size = e820[i].size;
+			rgn_top = start + size;
+
+			if (start > ram_top)
+				continue;
+
+			if (rgn_top > ram_top)
+				size -= rgn_top - ram_top;
+
+			lmb_add(start, size);
+		}
+	}
+}
+#endif /* CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP) */
diff --git a/lib/Kconfig b/lib/Kconfig
index 3796adc453b..269a952031a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1135,7 +1135,7 @@ config SPL_LMB
 config LMB_ARCH_MEM_MAP
 	bool "Add an architecture specific memory map"
 	depends on LMB
-	default y if FSL_LAYERSCAPE
+	default y if FSL_LAYERSCAPE || X86
 	help
 	  Some architectures have special or unique aspects which need
 	  consideration when adding memory ranges to the list of available
-- 
2.34.1

