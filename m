Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928F5E7719E
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 09:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EE1805C5;
	Mon, 13 Jan 2025 10:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jX91V+U4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A91B805DA; Mon, 13 Jan 2025 10:11:58 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CC1801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 10:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so2250257f8f.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 01:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736759515; x=1737364315;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fQnmGEXVumQRMT3Mj4Iqro4rKso6BZFspWXTFeV2Lso=;
 b=jX91V+U4QIbNtERrRFMnSKPVEUiTwnxUts+LePsyO77JRAZ8GrbVUgVaFGNYCVHqNG
 8ZlnMexavjbuI/vZoqkUeT7GVP9XfqI55QbN97z93JDrq5qdj5X9tfHuL3d1oB0ajqvv
 yik2scKBU3wL6Z+VT9Qn7mR6FMr1HZmDzsmaI0A9ZolFUVdxxvZjrDBBO32sYdHfio0Z
 Ksn5jDp7CfxEt+k6SgFfCF3FzxIqwZuam7E0wKLYIOmHOFRib9OsBfC5/czP8YjOC8UD
 igYOn1zDZxp4rgEYelqaweKAPhG7tt5E3edrJ1EOK/Tm4Jz2Y4cQJ/nU+1n1MsHuRE2g
 T9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736759515; x=1737364315;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQnmGEXVumQRMT3Mj4Iqro4rKso6BZFspWXTFeV2Lso=;
 b=HIhUDSK54BVxcz+FL/fL3wnvc0GJAVDnzaEwzY4AJSYCYsymIMzCkh9ghClXD5RTwn
 F4KcYURyN0gNf1wtoWv8KY85d8WWmTsDZFm/4EWuyEx5aoo+w+FR5dAZAMKOaJgtt+0i
 DEMKhnvqa3v93eM9x/05RXiEDBnuTw7I2HQ5KCLFmfB2M3OTbxe3lnA9qcBPwEv/6olC
 qhjXfEvEDuscmAw91j3R/gbHSjWd2EVOdx4J+yKIihXbLRbKCxIBkaoIyrqic+13TsDE
 qBqxXWm0gGGLMWIsHT5L1fe/KM6t+J9o1694ks3MQT71nuOVGK/FjkyUeqOM0Fu8XP5z
 SIkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL2MTOfstCMpGdY1F+Dd4qfywSTKKCUUF4KhmWPkk/KY8y385m0/5KJ5ztvCM17754pgCOu9Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yzm/L0VsuerKrNu2FzuWLtzNTNJ92x8AP5fMMk+9n1oxLZPRH97
 a6Gsvpx8M4BuVZR8R8G018c66E8aoXoXH5JS0311mVmIUwLxoFxCj1pujR5rmSw=
X-Gm-Gg: ASbGncvHA4LCpJ0xOCjY0edWbWIjwJXbvniSPGYIN3NsVIhy4fGskZSpixvdR2GaE6u
 n1zEUnBATrmmd++Eg0qNPAqmLnRhCE0tE6BtmD8VJNXbsbPNbTpnapxQ1bm4cWjhWGTgeW6p90E
 NWn9+TLyiym0gEdatfelI8rE59Y56yhdQ8S8xZmt03CVggoLQ5Wa+aLjRziBAHg9qM2DvgH2ueL
 om77HIFgxz4SGNh/ojjiIelQQJyL9Olh5cWfKT/AKiXHaO/u7THZ2soU2g+Ow1JtHabd7xX
X-Google-Smtp-Source: AGHT+IFHIg00wDeWODgGlJQLIGjNB06DHGDvQfR8SrmP19876LnxNAVCB4/KP8cf4OPME2gGchCABQ==
X-Received: by 2002:a5d:598b:0:b0:38a:5ce8:df6d with SMTP id
 ffacd0b85a97d-38a872fb0eemr15954979f8f.1.1736759514827; 
 Mon, 13 Jan 2025 01:11:54 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38d013sm11857746f8f.58.2025.01.13.01.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 01:11:53 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Mon, 13 Jan 2025 10:11:45 +0100
Subject: [PATCH] boot: android: Check kcmdline's for NULL in
 android_image_get_kernel()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-kcmdline-extra-fix-v1-1-03cc9c039159@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANDYhGcC/x2MQQqAIBAAvyJ7bkGziPpKdBBda6ksNCII/550n
 IGZFxJFpgSDeCHSzYmPUEBVAuxiwkzIrjDUsm6lUhpXu7uNAyE9VzTo+cFW9loralznNZTwjFT
 0Px2nnD9quy/OZAAAAA==
X-Change-ID: 20250113-kcmdline-extra-fix-509331e4d7f3
To: Tom Rini <trini@konsulko.com>, Nicolas Belin <nbelin@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Aaron Kling <webgeek1234@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.3-dev-86319
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

From: Aaron Kling <webgeek1234@gmail.com>

kcmdline and kcmdline_extra strings can be NULL. In that case, we still
read the content from 0x00000 and pass that to the kernel, which is
completely wrong.

Fix android_image_get_kernel() to check for NULL before checking if
they are empty strings.

Fixes: 53a0ddb6d3be ("boot: android: fix extra command line support")
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Thanks to Aaron for reporting this on the aosp-devs discord and for
fixing this.
---
 boot/image-android.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 60a422dfb74a6c683b3cf9d2b19b3ad1dbd0d151..fa4e14ca4698e1dea105388dd2ea590024cafa58 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -337,12 +337,12 @@ int android_image_get_kernel(const void *hdr,
 	if (bootargs)
 		len += strlen(bootargs);
 
-	if (*img_data.kcmdline) {
+	if (img_data.kcmdline && *img_data.kcmdline) {
 		printf("Kernel command line: %s\n", img_data.kcmdline);
 		len += strlen(img_data.kcmdline) + (len ? 1 : 0); /* +1 for extra space */
 	}
 
-	if (*img_data.kcmdline_extra) {
+	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
 		printf("Kernel extra command line: %s\n", img_data.kcmdline_extra);
 		len += strlen(img_data.kcmdline_extra) + (len ? 1 : 0); /* +1 for extra space */
 	}
@@ -357,13 +357,13 @@ int android_image_get_kernel(const void *hdr,
 	if (bootargs)
 		strcpy(newbootargs, bootargs);
 
-	if (*img_data.kcmdline) {
+	if (img_data.kcmdline && *img_data.kcmdline) {
 		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
 			strcat(newbootargs, " ");
 		strcat(newbootargs, img_data.kcmdline);
 	}
 
-	if (*img_data.kcmdline_extra) {
+	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
 		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
 			strcat(newbootargs, " ");
 		strcat(newbootargs, img_data.kcmdline_extra);

---
base-commit: bc157bb6667ed97e33be8ce8436c28baa275b295
change-id: 20250113-kcmdline-extra-fix-509331e4d7f3

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

