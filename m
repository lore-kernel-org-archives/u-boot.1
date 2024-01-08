Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574E0C47079
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 14:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D4587A86;
	Mon,  8 Jan 2024 15:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="FM0htBVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD3987A84; Mon,  8 Jan 2024 15:24:44 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A0287A75
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 15:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-556c60c3f9aso2267649a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 06:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1704723881; x=1705328681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEIQju2Arh5ej/YmKZ90GMcoQ6bw6zUTzlu6DMUZ9SQ=;
 b=FM0htBVxo7BF9m9jDt9+yOyvJTp7zplNEG0zh0V1u8sq3T4SKms3XCOWpiZFsBjHZL
 uAUMCn+aV2ENKl7vUqOVWv++i8oguuX07yRSbtBBIAramiinVrK5l6VB7xUvBSAPYrhh
 svh1w8HbvO7gvqqlZ20iQEoUeNrjlU0ME0qd9OJ5NHMNde5DtcRr5nSB22YMMCnHV5hk
 okchhoxsW0BQKotAM94vKwGtJVvzxqWSVAchDw8EyEOGNEselfaVNcKm28UG9PPpU39h
 nkpXXdjJfR3OhoBYI6rveeNfATCR07PoHyGMGa7pyQ1Wd1Q/MiGW+pk2oCob79WB7t8s
 vgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704723881; x=1705328681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEIQju2Arh5ej/YmKZ90GMcoQ6bw6zUTzlu6DMUZ9SQ=;
 b=b4mzRUcQKvZZrqd3jstpn4B+mQSba2BMcR6h70CnOC8JSMJseOIActpZUKz+Hhgr8s
 QdXPIlbAb64aExeEsbmOkimipBqdORX7DH3Zr5xaPlQf9ToJFxVRBPhTSZa29Zu+rhj9
 21qSncCSiaNYqCA8yOakaer5hAAFTJee0JLmgMdEaQFpwLDWeR+s08MhFTycnCPK31B+
 25Sodr8ph+/inreHfwG5X7sM0rT8Hu56r1blzOADLEJyJ9BVfGZywDFcetaVyPPFoxpN
 VLwAEwftTnNlS7m07uwYe1usnNPOUPczAcX8B8BTCkt0+apfqKdf6COnmjvFRXdWy8rL
 qLGA==
X-Gm-Message-State: AOJu0YzCshsMypAud1oNPujj8u8h2YCr6PIQOVUIeyjY7UtjceDfxmlA
 VRyAGqAS7HNR42U2oGgBYCZqK8G9SavP0Vyqgaj6Frmk2X8=
X-Google-Smtp-Source: AGHT+IF4xPv4M06Y34adkoL77N+s/ndeo/DMSY3K5fmQaynD7Dm2aWPIXPLS3bL9ftF4R+jMal/+qA==
X-Received: by 2002:a50:8ac2:0:b0:552:e43d:cc7c with SMTP id
 k2-20020a508ac2000000b00552e43dcc7cmr2174028edk.16.1704723881547; 
 Mon, 08 Jan 2024 06:24:41 -0800 (PST)
Received: from hugo-IdeaPad-3-15ALC6.. (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185]) by smtp.gmail.com with ESMTPSA id
 u15-20020aa7d54f000000b0055678085e27sm4298471edr.20.2024.01.08.06.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 06:24:41 -0800 (PST)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>
Subject: [PATCH] image-host: refactor and protect for very long filenames
Date: Mon,  8 Jan 2024 15:24:30 +0100
Message-Id: <20240108142430.301659-2-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108142430.301659-1-hugo.cornelis@essensium.com>
References: <CAFLszTgUwDUWSRwJZ0Jk8Bw6UUXDt72vnaj4rB72bLFoo3Lozw@mail.gmail.com>
 <20240108142430.301659-1-hugo.cornelis@essensium.com>
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

This patch adds a function fit_image_read_key_iv_data that checks the
return value of snprintf and allows to generate a sensible error
message when generating binary images using filenames that are too
long for the OS to handle.

This is especially relevant for automated builds such as Buildroot and
Yocto builds.

Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>
---
 tools/image-host.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index ca4950312f..0092fa830f 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -340,6 +340,28 @@ err:
 	return ret;
 }
 
+static int fit_image_read_key_iv_data(const char *keydir, const char *key_iv_name,
+				      unsigned char *key_iv_data, int expected_size)
+{
+	char filename[PATH_MAX];
+	int ret = -1;
+
+	ret = snprintf(filename, sizeof(filename), "%s/%s%s",
+		       keydir, key_iv_name, ".bin");
+	if (ret >= sizeof(filename)) {
+		printf("Can't format the key or IV filename when setting up the cipher: insufficient buffer space\n");
+		ret = -1;
+	}
+	if (ret < 0) {
+		printf("Can't format the key or IV filename when setting up the cipher: snprintf error\n");
+		ret = -1;
+	}
+
+	ret = fit_image_read_data(filename, key_iv_data, expected_size);
+
+	return ret;
+}
+
 static int get_random_data(void *data, int size)
 {
 	unsigned char *tmp = data;
@@ -376,7 +398,6 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 				  int noffset)
 {
 	char *algo_name;
-	char filename[128];
 	int ret = -1;
 
 	if (fit_image_cipher_get_algo(fit, noffset, &algo_name)) {
@@ -413,17 +434,17 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 		goto out;
 	}
 
-	/* Read the key in the file */
-	snprintf(filename, sizeof(filename), "%s/%s%s",
-		 info->keydir, info->keyname, ".bin");
 	info->key = malloc(info->cipher->key_len);
 	if (!info->key) {
 		fprintf(stderr, "Can't allocate memory for key\n");
 		ret = -1;
 		goto out;
 	}
-	ret = fit_image_read_data(filename, (unsigned char *)info->key,
-				  info->cipher->key_len);
+
+	/* Read the key in the file */
+	ret = fit_image_read_key_iv_data(info->keydir, info->keyname,
+					 (unsigned char *)info->key,
+					 info->cipher->key_len);
 	if (ret < 0)
 		goto out;
 
@@ -436,10 +457,11 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 
 	if (info->ivname) {
 		/* Read the IV in the file */
-		snprintf(filename, sizeof(filename), "%s/%s%s",
-			 info->keydir, info->ivname, ".bin");
-		ret = fit_image_read_data(filename, (unsigned char *)info->iv,
-					  info->cipher->iv_len);
+		ret = fit_image_read_key_iv_data(info->keydir, info->ivname,
+						 (unsigned char *)info->iv,
+						 info->cipher->iv_len);
+		if (ret < 0)
+			goto out;
 	} else {
 		/* Generate an ramdom IV */
 		ret = get_random_data((void *)info->iv, info->cipher->iv_len);
-- 
2.34.1

