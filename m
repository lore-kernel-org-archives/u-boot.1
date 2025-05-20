Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDEEC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8384A82CA0;
	Tue, 20 May 2025 16:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oNgb1sHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25F082C55; Tue, 20 May 2025 16:26:02 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB5582B7C
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 58D5962A07;
 Tue, 20 May 2025 14:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0122CC4CEEA;
 Tue, 20 May 2025 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747751159;
 bh=mKSoDF00rUjkX5PV+Yt1mjTOaynIBlrA2D0OzBx+MgA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=oNgb1sHSJ5OUpEzv5p2roIjU71IVKwxxJWVFwZ4JU6OexHFljdxIlaHo2KdbSjwr7
 n5w2ozSyL9l/0YVqwpxeCsAlsS2rxggZYlyo7rqIvmBW8f2Y4Kdwb4MqE54MVYXRkB
 CrPVW26WIdm66JlbLJiyePERWCiv9DhAwXBh9VFcbESEIc/mJirZFuh/pwyKjD99Wi
 G3kE8w/GKxvoo0L7pOuXlxndzWS1vkD9O1qgKZ/hV3a0BZzs/w4aMzB40g1lf6PRTE
 kVqYFr0c/kLivQSxmIAqKtsqSMxG1gzbSnl2637yNgZ8aUfNWjQSt4WrlMQDkqMPZa
 EYJLjr7PH+maA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E435FC54E65;
 Tue, 20 May 2025 14:25:58 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Tue, 20 May 2025 22:25:56 +0800
Subject: [PATCH 1/4] image-android: Prepend/postpend default bootargs value
 with given bootcmd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-sc7180-android-boot-v1-1-3075a84ea094@gmail.com>
References: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
In-Reply-To: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747751157; l=2252;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=V2l2Xnbb4xXHKI8jtmuMQBBDMlfxzMwNRxFEKHjQC78=;
 b=pIOjcFwEgDu77jIfW3xAlxztaGR0VVF/8YzzsdMfL3vkINvZxU2Kiw8dRuBDph2v52iTsjqUn
 7jMNCdnJrfmBIh1OKm2BHBwm3eTm3rdWrC/ZqdWzLZ2V4NREuxd2HCN
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Tue, 20 May 2025 16:26:13 +0200
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

Control how default bootargs is prepended or postpended to boot param found
from androidboot img.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/Kconfig         |  8 ++++++++
 boot/image-android.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 30eb5b328d7..6559398cb92 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -11,6 +11,14 @@ config ANDROID_BOOT_IMAGE
 	  This enables support for booting images which use the Android
 	  image format header.
 
+config ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS
+	bool "Android Boot Image boot cmd param will prepend to env bootargs"
+	default n
+	help
+	  This control how androidboot img with bootcmd param integrate with u-boot
+	  env bootargs. By enable this, androidboot boot param will prepend to
+	  head of bootargs env.
+
 config TIMESTAMP
 	bool "Show image date and time when displaying image information"
 	default y if CMD_DATE
diff --git a/boot/image-android.c b/boot/image-android.c
index 1746b018900..fbcd2682a5e 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -347,14 +347,14 @@ int android_image_get_kernel(const void *hdr,
 		len += strlen(img_data.kcmdline_extra) + (len ? 1 : 0); /* +1 for extra space */
 	}
 
-	char *newbootargs = malloc(len + 1); /* +1 for the '\0' */
+	char *newbootargs = malloc(len + 2); /* +2 for 2x '\0' */
 	if (!newbootargs) {
 		puts("Error: malloc in android_image_get_kernel failed!\n");
 		return -ENOMEM;
 	}
 	*newbootargs = '\0'; /* set to Null in case no components below are present */
 
-	if (bootargs)
+	if (bootargs && !IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
 		strcpy(newbootargs, bootargs);
 
 	if (img_data.kcmdline && *img_data.kcmdline) {
@@ -369,6 +369,12 @@ int android_image_get_kernel(const void *hdr,
 		strcat(newbootargs, img_data.kcmdline_extra);
 	}
 
+	if (bootargs && IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS)) {
+		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
+			strcat(newbootargs, " ");
+		strcat(newbootargs, bootargs);
+	}
+
 	env_set("bootargs", newbootargs);
 	free(newbootargs);
 

-- 
2.43.0


