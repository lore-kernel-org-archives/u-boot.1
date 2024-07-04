Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFA5C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C03488966;
	Thu,  4 Jul 2024 09:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704BB888E7; Thu,  4 Jul 2024 09:38:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2FBAD88974
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1CBADA7;
 Thu,  4 Jul 2024 00:39:11 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75F883F762;
 Thu,  4 Jul 2024 00:38:43 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 44/48] x86: e820: use the lmb API for adding RAM memory
Date: Thu,  4 Jul 2024 13:05:40 +0530
Message-Id: <20240704073544.670249-45-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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
module. Add a separate function, lmb_add_memory() to add the RAM
memory to the LMB memory map. The efi_add_known_memory() function is
now used for adding any other memory type to the EFI memory map.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 arch/x86/lib/e820.c | 47 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/x86/lib/e820.c b/arch/x86/lib/e820.c
index 122b4f7ca0..8b3ce8c6ec 100644
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
+#if CONFIG_IS_ENABLED(LMB)
+void lmb_add_memory(void)
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
+#endif /* CONFIG_IS_ENABLED(LMB) */
-- 
2.34.1

