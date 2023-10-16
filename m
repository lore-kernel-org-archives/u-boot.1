Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB7BCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC04186ECA;
	Mon, 16 Oct 2023 16:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="L+moeEX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F101486BA6; Mon, 16 Oct 2023 16:14:43 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA21C86C39
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1BAE720009;
 Mon, 16 Oct 2023 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697465675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dd7DpkK3a77vR0a817vjia0/s33CobF+wJ8yH7KxnQ8=;
 b=L+moeEX6GfjVk0NDmLjGENxfat+/M33zNCJm62HpANDlkxOUPETJ3nvFi8g79LElPJlXK2
 UqcitYfu4Z4nCcAWLK4JwQbl8y92dK0CnweVOB1FxtBNjhmhupnlTb34qcNWeN9ynliQ9i
 YG0chFLKkl5rUUuVadqyQnoiVaJApq7NJUsj7iEoov43ej+q0MSfvnz4S++e3N3z1S3kSv
 VM15h+XACLCu7xo3VWDEHRAmkaH00z65yls9zBee2jlex/WSXcT3Zea95yq0fujX1wN6bq
 0mkz8bQJaGOapMi9hJG0Y4VyfdScUD/uFBNqfBP3LsKYo2cY+/MhiqMwsyCIPw==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/9] board: ti: j721e: During resume spl restores TF-A and
 DM-Firmware
Date: Mon, 16 Oct 2023 16:11:33 +0200
Message-Id: <20231016141135.325698-8-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016141135.325698-1-thomas.richard@bootlin.com>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Mailman-Approved-At: Mon, 16 Oct 2023 16:15:29 +0200
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

During the boot a copy of DM-Firmware is done in a reserved memory
area before it starts.
When resuming, R5 SPL uses this copy of DM-Firmware instead of the fit
image.
TF-A which saved itself in this same memory area, is restored in
SRAM by R5 SPL.

Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---

 arch/arm/mach-k3/common.c                 | 37 ++++++++++++++++++++++-
 arch/arm/mach-k3/include/mach/j721e_spl.h | 29 ++++++++++++++++++
 arch/arm/mach-k3/sysfw-loader.c           |  9 ++++--
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index a35110429b..8caeb5da3b 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -26,6 +26,7 @@
 #include <env.h>
 #include <elf.h>
 #include <soc.h>
+#include <hang.h>
 
 #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
 enum {
@@ -221,6 +222,11 @@ void release_resources_for_core_shutdown(void)
 	}
 }
 
+__weak int board_is_resuming(void)
+{
+	return 0;
+}
+
 void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(void);
@@ -235,6 +241,25 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 	if (ret)
 		panic("rproc failed to be initialized (%d)\n", ret);
 
+	if (board_is_resuming()) {
+#if IS_ENABLED(CONFIG_SOC_K3_J721E)
+		if (!valid_elf_image(LPM_DM_SAVE))
+			panic("%s: DM-Firmware image is not valid, it cannot be loaded\n",
+			      __func__);
+
+		loadaddr = load_elf_image_phdr(LPM_DM_SAVE);
+
+		memcpy((void *)BL31_START, (void *)LPM_BL31_SAVE, BL31_SIZE);
+
+		ret = rproc_load(1, *(ulong *)(LPM_BL31_SAVE + BL31_SIZE), BL31_SIZE);
+		if (ret)
+			panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
+
+		debug("%s: jumping to address %x\n", __func__, loadaddr);
+		goto start_arm64;
+#endif
+	}
+
 	init_env();
 
 	if (!fit_image_info[IMAGE_ID_DM_FW].image_start) {
@@ -289,8 +314,18 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 		loadaddr = load_elf_image_phdr(loadaddr);
 	} else {
 		loadaddr = fit_image_info[IMAGE_ID_DM_FW].image_start;
-		if (valid_elf_image(loadaddr))
+		if (valid_elf_image(loadaddr)) {
 			loadaddr = load_elf_image_phdr(loadaddr);
+#if IS_ENABLED(CONFIG_SOC_K3_J721E)
+			if (fit_image_info[IMAGE_ID_DM_FW].image_len > (BUFFER_ADDR - LPM_DM_SAVE))
+				log_warning("%s\n: Not enough space to save DM-Firmware",
+					    __func__);
+			else
+				memcpy((void *)LPM_DM_SAVE,
+				       (void *)fit_image_info[IMAGE_ID_DM_FW].image_start,
+					   fit_image_info[IMAGE_ID_DM_FW].image_len);
+#endif
+		}
 	}
 
 	debug("%s: jumping to address %x\n", __func__, loadaddr);
diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3/include/mach/j721e_spl.h
index e8947917a6..7f63c281e9 100644
--- a/arch/arm/mach-k3/include/mach/j721e_spl.h
+++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
@@ -42,4 +42,33 @@
 #define K3_PRIMARY_BOOTMODE		0x0
 #define K3_BACKUP_BOOTMODE		0x1
 
+/* Starting buffer address is 1MB before the stack address in DDR */
+#define BUFFER_ADDR (CONFIG_SPL_STACK_R_ADDR - SZ_1M)
+
+/* BL31 TF-A is in the SRAM */
+#define BL31_START 0x70000000
+
+/* This is actually the whole size of the SRAM */
+#define BL31_SIZE    0x20000
+
+/* This address belongs to a reserved memory region for the point of view of
+ * Linux, U-boot SPL must use the same address to restore TF-A and resume
+ * entry point address
+ */
+#define LPM_SAVE      0xA5000000
+#define LPM_BL31_SAVE LPM_SAVE
+#define LPM_DM_SAVE   LPM_BL31_SAVE + BL31_SIZE + __SIZEOF_POINTER__
+
+/* Check if the copy of TF-A and DM-Firmware in DRAM does not overlap an
+ * over memory section.
+ * The resume address of TF-A is also saved in DRAM.
+ * At build time we don't know the DM-Firmware size, so we keep 512k to
+ * save it.
+ */
+#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_TARGET_J7200_R5_EVM)
+#if ((LPM_DM_SAVE + SZ_512K) > BUFFER_ADDR)
+#error Not enough space to save DM-Firmware, TF-A and context for S2R
+#endif
+#endif
+
 #endif
diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
index 9be2d9eaea..e6d452e590 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/sysfw-loader.c
@@ -84,13 +84,16 @@ static bool sysfw_loaded;
 static void *sysfw_load_address;
 
 /*
- * Populate SPL hook to override the default load address used by the SPL
- * loader function with a custom address for SYSFW loading.
+ * Populate SPL hook to override the default load address used by the
+ * SPL loader function with a custom address for SYSFW loading. In
+ * other case use also a custom address located in a reserved memory
+ * region. It ensures that Linux memory won't be corrupted by SPL during
+ * suspend to ram.
  */
 struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 {
 	if (sysfw_loaded)
-		return (struct legacy_img_hdr *)(CONFIG_TEXT_BASE + offset);
+		return (struct legacy_img_hdr *)(BUFFER_ADDR + offset);
 	else if (sysfw_load_address)
 		return sysfw_load_address;
 	else
-- 
2.39.2

