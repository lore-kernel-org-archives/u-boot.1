Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5394DC46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 21:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8DB87A27;
	Fri, 29 Dec 2023 22:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="NaAtAdGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 601EF87B50; Fri, 29 Dec 2023 22:07:53 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B09887282
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 22:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d5b159497so34485625e9.1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1703884070; x=1704488870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=joprFudLg8rgj07fdWOaLa4XZ587vae037ooSZzUZlc=;
 b=NaAtAdGg8E1NCWCIiOF5EZPysAiG0dT5DNxCwVeZAXbps0vayuOfJkeqWX29QGsygn
 P2q7OuvZ4IXqU1vSD/dYBx0ObeKdBhCKX78xHUdhPoypTod2FvVnLbEKJDd35IBJr6GV
 t7u+3TnzPyWQ4eC7BQ0Kw7UgulPudbPF5SN685CycLdPEqvHhcq2GZpk9tM5ahXHaPNo
 ElBHf2V9mi73Jc047WHj4XFjewTXQTwQ2TB8IWCBf04r2X7qJ+Bug3Hq0LwE4JXKBAEG
 fk9K2KNCuKBBbpJuv40id2o164YSSrHLguUKafLEKtu5/51TrtNmjvxZVliXYi7gruzz
 Y0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703884070; x=1704488870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=joprFudLg8rgj07fdWOaLa4XZ587vae037ooSZzUZlc=;
 b=ghlGjEmwmwHiE2D1CtMLrxlnuZh/e9CbJDoFNq8jtu/J4+CjJppZTzFOzwrt5g3n0/
 oizAuICssfIdbY/100u6hyHba5CwQaG4bU8u31N7s3mcN0XIbxSFzC8iYrfmhhudD06u
 1qm0jqoI+H59DpZZRJnIR7j77L5iNMtEZVlfOtkqcClBqbp3FLkGvR8CG3G83Z1Pc9fM
 NvilkPN+OJ5pmbdPZ6N5x0xXwCjpkif6F/rhOgnDYERD7Ia2le3C9jw/dTO9hNPVfT0T
 QsqrC+X2jaMRUpq4leBAGwuemLCHLbZ3yqT2K+C3+g8oslegMnPgUOYousIwYWpRSUmf
 oPqQ==
X-Gm-Message-State: AOJu0YyZ+DibPFqk36+bIqovJeuQInolZ5shs5tzYpmCcbleTyhTbcKq
 W6PLWxbUP6Q5qq1HuQGCVaMVLReM9G7//PoBVTC17MLwqsg=
X-Google-Smtp-Source: AGHT+IGeDBWlFQ0SB7HAEdDZ6nDC48FFy8naOfydKfgUHG0zspGc1QYzbvNmNvkEvuP1CnTvGIpUjQ==
X-Received: by 2002:a05:600c:4f8d:b0:40d:5abb:fd81 with SMTP id
 n13-20020a05600c4f8d00b0040d5abbfd81mr1996315wmq.151.1703884070609; 
 Fri, 29 Dec 2023 13:07:50 -0800 (PST)
Received: from hugo-IdeaPad-3-15ALC6.home
 (ptr-4h549o5tww32w5ynsss.18120a2.ip6.access.telenet.be.
 [2a02:1810:952e:3700:2ded:4ef:219f:78c])
 by smtp.gmail.com with ESMTPSA id
 i2-20020adffc02000000b003364aa5cc13sm20144703wrr.1.2023.12.29.13.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:07:49 -0800 (PST)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] image-host: add a check of the return value of snprintf.
Date: Fri, 29 Dec 2023 22:07:37 +0100
Message-Id: <20231229210738.82387-1-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
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

This patch allows to generate a sensible error message when generating
binary images using very long filenames.

This can happen with Buildroot and Yocto builds.

Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>
---

 tools/image-host.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index ca4950312f..3719f36117 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -378,6 +378,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 	char *algo_name;
 	char filename[128];
 	int ret = -1;
+	int snprintf_return;
 
 	if (fit_image_cipher_get_algo(fit, noffset, &algo_name)) {
 		fprintf(stderr, "Can't get algo name for cipher in image '%s'\n",
@@ -414,8 +415,18 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 	}
 
 	/* Read the key in the file */
-	snprintf(filename, sizeof(filename), "%s/%s%s",
-		 info->keydir, info->keyname, ".bin");
+	snprintf_return = snprintf(filename, sizeof(filename), "%s/%s%s",
+				   info->keydir, info->keyname, ".bin");
+	if (snprintf_return >= sizeof(filename)) {
+		printf("Can't format the key filename when setting up the cipher: insufficient buffer space\n");
+		ret = -1;
+		goto out;
+	}
+	if (snprintf_return < 0) {
+		printf("Can't format the key filename when setting up the cipher: snprintf error\n");
+		ret = -1;
+		goto out;
+	}
 	info->key = malloc(info->cipher->key_len);
 	if (!info->key) {
 		fprintf(stderr, "Can't allocate memory for key\n");
@@ -436,8 +447,18 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 
 	if (info->ivname) {
 		/* Read the IV in the file */
-		snprintf(filename, sizeof(filename), "%s/%s%s",
-			 info->keydir, info->ivname, ".bin");
+		snprintf_return = snprintf(filename, sizeof(filename), "%s/%s%s",
+					   info->keydir, info->ivname, ".bin");
+		if (snprintf_return >= sizeof(filename)) {
+			printf("Can't format the IV filename when setting up the cipher: insufficient buffer space\n");
+			ret = -1;
+			goto out;
+		}
+		if (snprintf_return < 0) {
+			printf("Can't format the IV filename when setting up the cipher: snprintf error\n");
+			ret = -1;
+			goto out;
+		}
 		ret = fit_image_read_data(filename, (unsigned char *)info->iv,
 					  info->cipher->iv_len);
 	} else {
-- 
2.34.1

