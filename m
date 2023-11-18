Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF25BC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E3788751F;
	Sat, 18 Nov 2023 22:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bwvWHRhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5F38755E; Sat, 18 Nov 2023 22:06:41 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C5EE87523
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7a956887c20so125093539f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341579; x=1700946379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxPGYQBGECC7Y/ZXsWgO1vbN7ibNUVjCT6MaJMvpeLY=;
 b=bwvWHRhgbmv9ivhA0CG0cN7ciZ75kofe+w4F0psy5J3qchY47s5ZU9Rdr28iLKN+if
 P65Fz/6S6n+FlK3Ky3meTdyBeZ+a5jN9Uq5kFv9cjURe8Uig8y2ckA9Jm5jWFgqGgTVb
 2hjMpLNMd51ogZlyyQglvl0cu9Tz6b/zaMaW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341579; x=1700946379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxPGYQBGECC7Y/ZXsWgO1vbN7ibNUVjCT6MaJMvpeLY=;
 b=m0fR0q79aH8G9rGjyXloGHWl5RIVBw8hUyFzGweXQmyd36ujtyeoQtkw0wZJ492Dnq
 +eKqEhUvOHDsPQ9iZHvtpTZUj2Vq45lJPLX9ODpQ/o5pllFaUunx5+NycywfvZ+PTG59
 L7puoGQIM65P9z2vrcNKhSIXzkV1vhtqByiqXiFnzkpwRVGWjBrxSaeFuzArjXGUlecT
 uJpIr/C12gJuYpWFm+PMNDxESXl/y+bZRLgrgsWHWjDQgX9N+F2A0AlPSsQpt9ZdUngt
 hmNycfZJZS3dLx6lycUT0NFDMwgffDvCMM/IvtrOuMpMyYKLwSixLunpauhNChGETgqj
 E5EQ==
X-Gm-Message-State: AOJu0YxiV0foFFgPyVXwTRcQwCbcVr1XzNLbfE/NV4kmUosX8aIBocAn
 +U6lhZugrmOwCrTwA1ZlqlwWQNBarfikrzAze0QdyA==
X-Google-Smtp-Source: AGHT+IGIjbQJxc/kIt6fOsMzZMO9KPHTikkV0t11eUA8i5IxYNsBif6cxorEPCTGISsKD7b1K/vR+g==
X-Received: by 2002:a6b:5903:0:b0:7b0:3779:ad5 with SMTP id
 n3-20020a6b5903000000b007b037790ad5mr3756327iob.12.1700341578239; 
 Sat, 18 Nov 2023 13:06:18 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 25/32] bootm: Simplify Android ramdisk addr in
 bootm_find_images()
Date: Sat, 18 Nov 2023 14:05:13 -0700
Message-ID: <20231118210547.577026-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

The Android mechanism uses the loadaddr envrionment-variable to get the
load address, if none is provided. This is equivalent to
image_load_addr so use that instead, converting it to a string as
needed.

This change will permit passing img_addr to this function, in a future
change.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index aae097df0c7f..db1466cecf2d 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -490,15 +490,20 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		      ulong size)
 {
 	const char *select = NULL;
+	char addr_str[17];
 	ulong img_addr;
 	void *buf;
 	int ret;
 
+	img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
+
 	if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE)) {
 		/* Look for an Android boot image */
 		buf = map_sysmem(images.os.start, 0);
-		if (buf && genimg_get_format(buf) == IMAGE_FORMAT_ANDROID)
-			select = argc ? argv[0] : env_get("loadaddr");
+		if (buf && genimg_get_format(buf) == IMAGE_FORMAT_ANDROID) {
+			strcpy(addr_str, simple_xtoa(img_addr));
+			select = addr_str;
+		}
 	}
 
 	if (argc >= 2)
@@ -525,7 +530,6 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 	}
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT)) {
-		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
 		buf = map_sysmem(img_addr, 0);
 
 		/* find flattened device tree */
-- 
2.43.0.rc0.421.g78406f8d94-goog

