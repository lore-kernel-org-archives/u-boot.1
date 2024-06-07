Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1EEC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9FD88498;
	Fri,  7 Jun 2024 20:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C32884B8; Fri,  7 Jun 2024 20:53:56 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D05E8884AC
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B04FC1480;
 Fri,  7 Jun 2024 11:54:16 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9813E3F8A4;
 Fri,  7 Jun 2024 11:53:49 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 06/31] lmb: reserve and add common memory regions post
 relocation
Date: Sat,  8 Jun 2024 00:22:15 +0530
Message-Id: <20240607185240.1892031-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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

The LMB module provides API's for allocating chunks of memory. The LMB
module should not be allocating memory regions that are in use, or
that might be occupied by the U-Boot image. Prevent allocations of
memory areas used by the U-Boot image by reserving these regions once
U-Boot has been relocated. Also add the rest of the memory that is
available for allocations to the LMB's memory map.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 common/board_r.c | 15 +++++++++++++++
 include/lmb.h    | 14 ++++++++++++++
 lib/lmb.c        | 14 +++++++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/common/board_r.c b/common/board_r.c
index da0b80f24f..a9f0b0cec1 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -22,6 +22,7 @@
 #include <hang.h>
 #include <image.h>
 #include <irq_func.h>
+#include <lmb.h>
 #include <log.h>
 #include <net.h>
 #include <asm/cache.h>
@@ -555,6 +556,17 @@ static int run_main_loop(void)
 	return 0;
 }
 
+#if defined(CONFIG_LMB)
+static int initr_lmb(void)
+{
+	lmb_reserve_common((void *)gd->fdt_blob);
+
+	lmb_add_memory(gd->bd);
+
+	return 0;
+}
+#endif
+
 /*
  * Over time we hope to remove these functions with code fragments and
  * stub functions, and instead call the relevant function directly.
@@ -613,6 +625,9 @@ static init_fnc_t init_sequence_r[] = {
 #endif
 #ifdef CONFIG_EFI_LOADER
 	efi_memory_init,
+#endif
+#if defined(CONFIG_LMB)
+	initr_lmb,
 #endif
 	initr_binman,
 #ifdef CONFIG_FSP_VERSION2
diff --git a/include/lmb.h b/include/lmb.h
index 8f8a32c2ca..d2b829ace1 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -125,6 +125,20 @@ void board_lmb_reserve(void);
 void arch_lmb_reserve(void);
 void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
 
+/**
+ * lmb_reserve_common() - Reserve memory region occupied by U-Boot image
+ * @fdt_blob: pointer to the FDT blob
+ *
+ * Reserve common areas of memory that are occupied by the U-Boot image.
+ * This function gets called once U-Boot has been relocated, so that any
+ * request for memory allocations would not touch memory region occupied
+ * by the U-Boot image, heap, bss etc.
+ *
+ * Return: None
+ *
+ */
+void lmb_reserve_common(void *fdt_blob);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
diff --git a/lib/lmb.c b/lib/lmb.c
index b0c9e2ef30..8003aae6f7 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -216,7 +216,19 @@ static __maybe_unused int efi_lmb_reserve(void)
 	return 0;
 }
 
-static void lmb_reserve_common(void *fdt_blob)
+/**
+ * lmb_reserve_common() - Reserve memory region occupied by U-Boot image
+ * @fdt_blob: pointer to the FDT blob
+ *
+ * Reserve common areas of memory that are occupied by the U-Boot image.
+ * This function gets called once U-Boot has been relocated, so that any
+ * request for memory allocations would not touch memory region occupied
+ * by the U-Boot image, heap, bss etc.
+ *
+ * Return: None
+ *
+ */
+void lmb_reserve_common(void *fdt_blob)
 {
 	arch_lmb_reserve();
 	board_lmb_reserve();
-- 
2.34.1

