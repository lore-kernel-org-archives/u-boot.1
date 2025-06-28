Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00FDC7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 12:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA9B82E8E;
	Sat, 28 Jun 2025 14:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DEwKzcz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E97B282E27; Sat, 28 Jun 2025 14:25:26 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A626880C83
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 14:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CD91C4618E;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97DA2C4CEF0;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751113522;
 bh=q2w+Y+HmikOdodeAjeSEvhVzpzj07f2VA1PbcxOYUro=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DEwKzcz8b2cxGGyd0O29PW6CgpX16ECZXQ6oZB2C6hF/dX/T5cuvsBhdoNI3tkh1o
 J4FgLGuwhPDjzDa1H32EqA6fuxUO7ZXiofGHK4wGJN5QVTC2Ru3TDB/w/4XgmsGRIS
 3/D66G3WNmmrNoq2MV3HoXIu1tRaP8/8+paFjZEGm+LPitGgk58o+GOiZmsEP7SdUT
 xOAuZdxE/1UERWsEQ9QW4yGp/FfFvLXxActa0xohbPxfl4HMpU74v52oFixxNoZs8h
 VnNjjOlZcqWydIB0S808vxykyps2TMHl8MzeTLq5SvFSAdi8MaAaCnkGK5BbRNOLPt
 g0m8FafnMIGYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 87769C83026;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sat, 28 Jun 2025 20:25:20 +0800
Subject: [PATCH v3 2/7] boot/image-android.c: Split
 android_image_get_kernel into two functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-sc7180-android-boot-v3-2-105098a19165@gmail.com>
References: <20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com>
In-Reply-To: <20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751113519; l=6120;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=r4LLSwa6xUZUvoKGbY1jQ02X40OG0j2CRpXQulW/F00=;
 b=LUSNirH5GAmgmwLFCuW7sXrPDsK22rWS0y366cdzbbqmDxzSVqUpREYXwWiHLJj9neOeRRFur
 ZG+VovvHl2iCsafJMPvyJKpwUOfN0A/lmghpa1ejQFopIWxxTe2cDG5
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sat, 28 Jun 2025 14:35:06 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

Since fastboot->bootm glue layer also need to cater with bootargs
environment, so move common logic from android_image_get_kernel into
a new function to avoid some degree of code duplication.

This new function is android_image_modify_bootargs_env to specially
cater bootargs env value with boot image provided cmdline.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/image-android.c | 106 ++++++++++++++++++++++++++++++++-------------------
 include/image.h      |  12 ++++++
 2 files changed, 79 insertions(+), 39 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index d78e8a4148a..26e2fc21929 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -285,6 +285,65 @@ static ulong android_image_get_kernel_addr(struct andr_image_data *img_data,
 	return img_data->kernel_addr;
 }
 
+/**
+ * android_image_modify_bootargs_env() - helper to set new bootargs
+ *
+ * set boot based on provided cmdline and u-boot pre-set value
+ *
+ * @cmd: usually contain kernel boot command line string
+ * @cmd_extra: usually contain kernel boot command line string from vendor img
+ * return: 0, success; otherwise fail in various problem.
+*/
+int android_image_modify_bootargs_env(const char *cmd, const char *cmd_extra) {
+	char *bootargs = env_get("bootargs");
+	char *newbootargs;
+	int len = 0;
+
+	if (bootargs)
+		len += strlen(bootargs);
+
+	if (cmd && *cmd)
+		len += strlen(cmd) + (len ? 1 : 0); /* +1 for extra space */
+
+	if (cmd_extra && *cmd_extra)
+		len += strlen(cmd_extra) + (len ? 1 : 0); /* +1 for extra space */
+
+	newbootargs = malloc(len + 2); /* +2 for 2x '\0' */
+
+	if (!newbootargs) {
+		puts("Error: malloc in android_image_get_kernel failed!\n");
+		return -ENOMEM;
+	}
+
+	*newbootargs = '\0'; /* set to Null in case no components below are present */
+
+	if (bootargs && !IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
+		strcpy(newbootargs, bootargs);
+
+	if (cmd && *cmd) {
+		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
+				strcat(newbootargs, " ");
+		strcat(newbootargs, cmd);
+	}
+
+	if (cmd_extra && *cmd_extra) {
+		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
+				strcat(newbootargs, " ");
+		strcat(newbootargs, cmd_extra);
+	}
+
+	if (bootargs && IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS)) {
+		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
+				strcat(newbootargs, " ");
+		strcat(newbootargs, bootargs);
+	}
+
+	env_set("bootargs", newbootargs);
+	free(newbootargs);
+
+	return 0;
+}
+
 /**
  * android_image_get_kernel() - processes kernel part of Android boot images
  * @hdr:	Pointer to boot image header, which is at the start
@@ -310,6 +369,8 @@ int android_image_get_kernel(const void *hdr,
 	ulong kernel_addr;
 	const struct legacy_img_hdr *ihdr;
 	ulong comp;
+	const char *cmd, *cmd_extra;
+	int ret;
 
 	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
 		return -EINVAL;
@@ -330,54 +391,21 @@ int android_image_get_kernel(const void *hdr,
 		printf("Android's image name: %s\n", andr_tmp_str);
 
 	printf("Kernel load addr 0x%08lx size %u KiB\n",
-	       kernel_addr, DIV_ROUND_UP(img_data.kernel_size, 1024));
-
-	int len = 0;
-	char *bootargs = env_get("bootargs");
-
-	if (bootargs)
-		len += strlen(bootargs);
+		kernel_addr, DIV_ROUND_UP(img_data.kernel_size, 1024));
 
 	if (img_data.kcmdline && *img_data.kcmdline) {
 		printf("Kernel command line: %s\n", img_data.kcmdline);
-		len += strlen(img_data.kcmdline) + (len ? 1 : 0); /* +1 for extra space */
+		cmd = img_data.kcmdline;
 	}
 
 	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
 		printf("Kernel extra command line: %s\n", img_data.kcmdline_extra);
-		len += strlen(img_data.kcmdline_extra) + (len ? 1 : 0); /* +1 for extra space */
-	}
-
-	char *newbootargs = malloc(len + 2); /* +2 for 2x '\0' */
-	if (!newbootargs) {
-		puts("Error: malloc in android_image_get_kernel failed!\n");
-		return -ENOMEM;
-	}
-	*newbootargs = '\0'; /* set to Null in case no components below are present */
-
-	if (bootargs && !IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
-		strcpy(newbootargs, bootargs);
-
-	if (img_data.kcmdline && *img_data.kcmdline) {
-		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
-			strcat(newbootargs, " ");
-		strcat(newbootargs, img_data.kcmdline);
+		cmd_extra = img_data.kcmdline_extra;
 	}
 
-	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
-		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
-			strcat(newbootargs, " ");
-		strcat(newbootargs, img_data.kcmdline_extra);
-	}
-
-	if (bootargs && IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS)) {
-		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
-			strcat(newbootargs, " ");
-		strcat(newbootargs, bootargs);
-	}
-
-	env_set("bootargs", newbootargs);
-	free(newbootargs);
+	ret = android_image_modify_bootargs_env(cmd, cmd_extra);
+	if (ret)
+		return ret;
 
 	if (os_data) {
 		if (image_get_magic(ihdr) == IH_MAGIC) {
diff --git a/include/image.h b/include/image.h
index b695cc39447..11d33ceeb39 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1890,6 +1890,18 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 
 struct andr_boot_img_hdr_v0;
 
+/**
+ * android_image_modify_bootargs_env() - helper to set new bootargs
+ *
+ * set boot based on provided cmdline and u-boot pre-set value
+ *
+ * @cmd: usually contain kernel boot command line string
+ * @cmd_extra: usually contain kernel boot command line string from vendor img
+ * return: 0, success; otherwise fail in various problem.
+*/
+int android_image_modify_bootargs_env(const char *cmd,
+					 const char *cmd_extra);
+
 /**
  * android_image_get_kernel() - Processes kernel part of Android boot images
  *

-- 
2.43.0


