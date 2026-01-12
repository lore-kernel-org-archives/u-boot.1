Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428ADC9EC6E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80FA483DE0;
	Mon, 12 Jan 2026 11:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1MxAvRGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F3D83DA9; Mon, 12 Jan 2026 11:55:47 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE57683DBF
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so68591355e9.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 02:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768215345; x=1768820145;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4LvecSZ+d5l3uPR+gMYnKFvfnta/aZ0X0FwsI5PA+90=;
 b=1MxAvRGusIse+o5BwWuzPig7ye7c9UERhvpqB89s8MDmNDnQm34Zg6w1Eg9RYVEyTT
 L4B7ik/dOw/J+dSHbsZM+j6aL8lVD6odVWIevN/aEoTmDjY8fSxYOLXwdz//Uega3bxP
 FoEOAqDp2PPPPU4SDFSSNgSGy0hTy/vwhaWX3xn/ILn5bKd/f8Vufl69dS//C8P10neA
 V73bvmPazmh3Qp/mNxVPJoH9vHH/2OHlqntCGyX5IjAORsOCSlK24wxeqlgktc3KxM+2
 y74S7ReYKnlHd10vYMUcHIZ7lA1ICFA8A2bUYK85eidYNeZApyVEKXFzUlm95D1HHq7j
 7Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768215345; x=1768820145;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4LvecSZ+d5l3uPR+gMYnKFvfnta/aZ0X0FwsI5PA+90=;
 b=H3/vMW8rI25XceFPgkH/QVLYKUs8IJC6h0CDvHRM2adq6GY79xJ3FR1vagq03EybBY
 GM0za/KtZlAkRbOjTwwLEsInhhofO9zNurfZFBZMOUyoK9/M90N2/2OAiFGcW1Vftu6o
 on1bpuLVu0byLkI7Ww5t3PslsGReeWiTDldJwY2UrQLLeC6ZEwctCSCTat5w7OTPUrwW
 2euif+g3AUka8qVMADx5LIi6tSnzr2aZbVAKFHkcijSK9jN+u4r6APoil7y2L9yxg9DE
 BxO4tKy449Qmg78JibuPmkSWLXcwLcHMyUZo7TkFma2jCbXouX8fl+racjjsUH4gq+eS
 t5Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVky7zt/OSnivCenOP2R2S7bk2X60wb5amWzc2l1x+xrQiHYYLHRE6A+tH9V9cxsNfnEvFC4WI=@lists.denx.de
X-Gm-Message-State: AOJu0YxyJmeQBBQdWnbSGyTHSWl6TUHTwz0BOi8RrRQVZTrbUdYCCYMB
 WO2M67gkT8MCgtuajQMNjZFlOFwhnerRYisYEIOnO0uEtNF05gjeoJWGDi1mCsVjgkc=
X-Gm-Gg: AY/fxX7d4UbaASmUcVti8MoaE0aIGzAm1WoWpqi1DJFxWP377odYAE3+F/PVi0ISOSy
 ph8WOeDkQF+wRB1L6lITpE5jQ6ryCfEakW6vcJy3AlbXkAyRFU2YUmemmDoUBB78ETHAgtAml/l
 YWHGD/d0qlU3gyZv55hstj4aKLnaLWL3BRupOV2b/gq3WrcQbPdLW/wfyoFI9ex8IWeh1nkzoqy
 MFMHlmTFFM8Wbt120523GZHtE3hyw0llJWrTtF2a19vesIlA0j/WWhWI5GzQ/ZlVHZARQHGzqAB
 xXlkiGgvGqIEvobCtBZuThbxtdKoWs0WuKLk1yCLxSuq+0GEeUjeHliuqqqRV/ZeV5F9rMdBcUn
 xNBFlnXvqMDKO4RcVWXHA3BAU8m/0dE89erXi+JphIuZ+kErrdiUdircwaUqDqCb+CdXVO0QVJL
 RtLGjxmFFwalwsSw==
X-Google-Smtp-Source: AGHT+IHjgH49sfkze5k6DBDPfUWg1mLZVq2KfNjfZlylj22lRd4oCMtc52f8pU5r6C0/p2Le2iSHuA==
X-Received: by 2002:a05:600c:45ca:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d84b38676mr201343635e9.32.1768215345271; 
 Mon, 12 Jan 2026 02:55:45 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:ad8e:46f0:bbfb:2e18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm36145393f8f.26.2026.01.12.02.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 02:55:44 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 12 Jan 2026 11:55:40 +0100
Subject: [PATCH v5 4/5] cmd: abootimg: Add 'get ramdisk' command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-bootconfig-v5-4-79b242159ac7@baylibre.com>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
In-Reply-To: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome@forissier.org>
X-Mailer: b4 0.14.3
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

Add support for retrieving ramdisk address and size from Android boot
images. This command allows users to extract the ramdisk information
for boot image v3+ which combines vendor ramdisk, boot ramdisk and
bootconfig sections.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 cmd/abootimg.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index c488609a8f4..eae3e643b60 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -222,6 +222,33 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int abootimg_get_ramdisk(int argc, char *const argv[])
+{
+	ulong rd_data, rd_len;
+
+	if (argc > 2)
+		return CMD_RET_USAGE;
+
+	/*
+	 * Call android_image_get_ramdisk with UNMAPPED addresses
+	 * The function will do its own mapping internally as needed
+	 */
+	if (android_image_get_ramdisk((void *)abootimg_addr(),
+				      (void *)get_avendor_bootimg_addr(),
+				      &rd_data, &rd_len))
+		return CMD_RET_FAILURE;
+
+	if (argc == 0) {
+		printf("%lx\n", rd_data);
+	} else {
+		env_set_hex(argv[0], rd_data);
+		if (argc == 2)
+			env_set_hex(argv[1], rd_len);
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
 static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
 			   char *const argv[])
 {
@@ -241,6 +268,8 @@ static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
 		return abootimg_get_dtb_load_addr(argc, argv);
 	else if (!strcmp(param, "dtb"))
 		return abootimg_get_dtb(argc, argv);
+	else if (!strcmp(param, "ramdisk"))
+		return abootimg_get_ramdisk(argc, argv);
 
 	return CMD_RET_USAGE;
 }
@@ -307,5 +336,9 @@ U_BOOT_CMD(
 	"    - get address and size (hex) of DT blob in the image by index\n"
 	"      <num>: index number of desired DT blob in DTB area\n"
 	"      [addr_var]: variable name to contain DT blob address\n"
-	"      [size_var]: variable name to contain DT blob size"
+	"      [size_var]: variable name to contain DT blob size\n"
+	"abootimg get ramdisk [addr_var [size_var]]\n"
+	"    - get address and size (hex) of ramdisk in the image\n"
+	"      [addr_var]: variable name to contain ramdisk address\n"
+	"      [size_var]: variable name to contain ramdisk size"
 );

-- 
2.34.1

