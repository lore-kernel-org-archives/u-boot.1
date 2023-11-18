Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F067C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF4287134;
	Sat, 18 Nov 2023 22:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aXYpdoGF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489CF8708B; Sat, 18 Nov 2023 22:06:19 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E46E87252
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7a67b9cd230so109728139f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341565; x=1700946365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okIDMAT2FBo5e5Uko5BdRAZJ+V9haBJdUuOGKgdm7i8=;
 b=aXYpdoGFmqvaBewmaghnF1kyoHat6lIKwwa2FKBIn0fM7W4//wz8ArEmVEteb8AhDF
 SumnlIGMwlvadhP7ehl3Zjuz+Zh/WyCpJjZx9r6H4KpX2OqkzVboFFBftLBt0X0NjFDI
 v7daT47nfgFB+UNVF0OuSuJRhT7upoMunCnlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341565; x=1700946365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okIDMAT2FBo5e5Uko5BdRAZJ+V9haBJdUuOGKgdm7i8=;
 b=W/U0XqsWXwqdV5ZLC4ay3rsBj/TyEKvAeWKX/kspuKtjMaNEhyP3+TupO7gNsdSfgh
 ahrjAR/REQE2So+gt81soh8w6qze5YnXSvcigxG6CKCsdhpS6aTo82czR37pTQZNbvIL
 M5QSBxjnY4kG8eEFfhlekoIrYCF/m6aY4MVUmRohb59x5abNKEyTUljybffh1zLtkyYu
 ij5j0i+VP2jbmhneKqhxysGhhbeCqsTXBo7PvTE3sk9uW6ALVvya/H0oiAEpRSxQ+sYY
 oXW/mOGyu3xKhtCMleyjQzXmpI1bvbjPJEq+yx4ruuIfSlHg7gweH74X0it1y+PSJs3S
 ssRg==
X-Gm-Message-State: AOJu0YyQ4WdEOCpGv90FAE5Z9F5HJ1EPgvqVU5h9ov52fLt9K26v4aKq
 wA7iRZDcJjLCW9G/Yvvv2Cz0B9mlRM9miqMW8aAn6w==
X-Google-Smtp-Source: AGHT+IHZsabrb7kiI0Txw926v1Sh27TwUhLzoSgiTnOdN4zHP1Uchxu85noRWI+WtcgvySre7cVQ/A==
X-Received: by 2002:a6b:f702:0:b0:792:8d16:91ef with SMTP id
 k2-20020a6bf702000000b007928d1691efmr3953789iog.18.1700341565477; 
 Sat, 18 Nov 2023 13:06:05 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 11/32] image: Document error codes from fit_image_load()
Date: Sat, 18 Nov 2023 14:04:59 -0700
Message-ID: <20231118210547.577026-12-sjg@chromium.org>
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

Put a list of these in the function documentation so it is easier to
decode what went wrong.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 include/image.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index 798c5f9c16e4..d37e44721672 100644
--- a/include/image.h
+++ b/include/image.h
@@ -728,7 +728,13 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
  * @param load_op	Decribes what to do with the load address
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
- * Return: node offset of image, or -ve error code on error
+ * Return: node offset of image, or -ve error code on error:
+ *   -ENOEXEC - unsupported architecture
+ *   -ENOENT - could not find image / subimage
+ *   -EACCES - hash, signature or decryptions failure
+ *   -EBADF - invalid OS or image type, or cannot get image load-address
+ *   -EXDEV - memory overwritten / overlap
+ *   -NOEXEC - image decompression error, or invalid FDT
  */
 int fit_image_load(struct bootm_headers *images, ulong addr,
 		   const char **fit_unamep, const char **fit_uname_configp,
-- 
2.43.0.rc0.421.g78406f8d94-goog

