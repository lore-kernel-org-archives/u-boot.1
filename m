Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3315C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088DD885B6;
	Sun, 23 Jun 2024 19:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cY2H4YSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BB1885AE; Sun, 23 Jun 2024 19:55:26 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A81E88433
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7eeea388a8eso143729839f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165322; x=1719770122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61teAF4z9QYPqE2dHTGBd5n7k4ZlCtrd5ypMBq94joc=;
 b=cY2H4YSdBoQJTTRhjbWORYRn6vLorfKL6dl0bA4NjTyE2ZDf7rQzxIV/GHzoEePXv7
 LoNx++4bYrr46rrsnZYWIddW9iA2xPbpFKqH6O3uRVSF/ad+8LEy+15GzBCuXw3XjG5l
 9IKP6yOs52b6CEHGab+JDfHE96LV7R3FU9z4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165322; x=1719770122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61teAF4z9QYPqE2dHTGBd5n7k4ZlCtrd5ypMBq94joc=;
 b=bI/8XnOncqTMHXoDDbux+Q+rJ9/5dhRHNIMYFuhLkzQ3e0IE1mfB1E/NLBuhpeCurW
 2xBT8cyTv7/AAr1GrHnoZaMP8vrlEu76EngiA2fzdBnvzBwq6mdPT6Yts7ti3aox1qYA
 VfnAkmR0v0ogOHJTRGPIcIvIEyq41njdAZusP9g/bn4L++z0/b4yL3D9XUH1F1hyhotm
 JfEFHFmgnj934w+XsgLHNioqDFCrzveukdN3DJdAf0phGZf/9vYuWszzLvIQqO+CtkDF
 y9EcvyhIDOgbKlkqtq1/HJrGy5ccSNvIZQBfv64QX0BC0c9l7uj7CHioHi3MdMHEAm0a
 2Qtw==
X-Gm-Message-State: AOJu0Yy8b1HtDJGdo/Q7yjiOD8bzdmQ2qW937a61ZYPsmQ7PC2l32VEW
 4FE8z/G53E6LfUpewkOIxhnFVOWnzcEZLAH9oMw/xsy089ZOQZFBr4r3rPbpxeKi3oza2o+CSeB
 8Jw==
X-Google-Smtp-Source: AGHT+IHTM/5TDzovqgtX2KfHIHN71JVNY6B/8nQo3CdLN0hCPdKthtYaeewp3/jVd4FHBz8TEeeb4w==
X-Received: by 2002:a05:6602:6c04:b0:7eb:81d6:c914 with SMTP id
 ca18e2360f4ac-7f3a7471000mr331410939f.4.1719165322148; 
 Sun, 23 Jun 2024 10:55:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 04/14] binman: Update the entrydocs header
Date: Sun, 23 Jun 2024 11:55:05 -0600
Message-Id: <20240623175515.1466908-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175515.1466908-1-sjg@chromium.org>
References: <20240623175515.1466908-1-sjg@chromium.org>
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

Reduce the length of the underline for this header, to match the
heading itself.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/entry.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 42e0b7b9145..2ed65800d22 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -812,7 +812,7 @@ class Entry(object):
                 as missing
         """
         print('''Binman Entry Documentation
-===========================
+==========================
 
 This file describes the entry types supported by binman. These entry types can
 be placed in an image one by one to build up a final firmware image. It is
-- 
2.34.1

