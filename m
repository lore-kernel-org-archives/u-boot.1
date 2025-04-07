Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E841BC369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A742882F9E;
	Mon,  7 Apr 2025 19:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iWWTBLxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D2982FEE; Mon,  7 Apr 2025 19:00:05 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCCE82F8E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so855639966b.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045203; x=1744650003; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A5IVLQHSGkEfHQ04D83N0pqgFX73dfjkOU6h6Y+FL58=;
 b=iWWTBLxATl1JcFlw4uvQ/ROGK3ssXZ8LsNuUe8GFCHkTmQRiM0L8zxuSssp8ZdQPAF
 J6XPVyvWDrQaM++h0Eh05Jg7jMa3EjQVy4dQGzZtyGRHDjXnaRUZIN0PG8vkUMUnqrPW
 dwgB/NLl8QkYrFBruYoJv7gRBh7yM0jhocMF8gCZhtbIn0QfyoTdc1eSAHTewZRdiyDL
 M2w8N8vfwf+6RAVrgcUyTeTW2wUHfqiYPiq5SnfgmCbcWVQHqvciOGI3ScizJRn/kPxm
 msiUUInAuVCxRilYmv+3v4ZHv/1Ns3hnOKoplItfvgMsGmqc+M3vKkcZAWAwi16dxdEU
 o+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045203; x=1744650003;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5IVLQHSGkEfHQ04D83N0pqgFX73dfjkOU6h6Y+FL58=;
 b=LW/7VXZ943azx4SEjGj2sWSNRbBjLumu3wyzvMQzycSI6tvbmTTvRzDw77c0W4u+M3
 NloeZCcyHGtuknIAxgitzEDFh0DNTIzR3heVUvEmSF28nzyPFpEYrI6YG5FToiHYUJoM
 RTaMKXPeGAu2NRJNBQ5IUPvPWkXls6afjHfmQqTK1hmYayEqI2GzP9Bg0ZKHsVN7JP9F
 mbjfkmaqQuNgJ+Aj4CR49sIqm6Io1INGkq5gxp0VgYCR5FJ1jhnWZPqguhL+M7HA7Q9N
 gOkuLh45w9dNKdI0udPCQBFKjQ8J93/I1vkoexlx8/2NqYCDEqGleUIawDREM2wtC1Hz
 Ww7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWobl4EiTv3ebUQ0TMhM2mgzTK7qA6hpRSy+8W+sU8ImNEB1AA36Wi7uDCs540ZtCVPp8FrPsg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp55Py9+n4ak0ccSccOM+Dy9iq9BRt2vz++FiQlyCLC4TPLi+B
 lJxy+NgIIZqzFxrckP+HT+wPiXktx+mFqu8iwbKaebt8ARKtm9nigqjrLgeBz7s=
X-Gm-Gg: ASbGncvuTeSe/PBg5h9/thbgpGTjap07F4sCjw2PIaveCHsEuRcZb9T9Zec6SWho1RZ
 GyQ+iEWuWjmFBDtmIjaGXNyO9v87UBjJHqUrvILa2zU60w3/+ORW4cQgnC8xjtogHuT8kVPIKmI
 EtXVDQdeADHQaqtnPdE9dFZRNWYT9hIvKmAoe/cXLS39ghtMJ2X5ZF/s1XDxEunGhiq1/GWYyQG
 sq5g5PX5/jdp1zufSyUiacj4bb4W5hZbQjV5cjb1y25ytUYElBXxaKopKnH9umQPOYqnsL4Dqym
 WH6sNMzbCUCcTTvTmCzJut6BpQSnTVZjAo+bndZDWY+tCkbsDqkReLT5frxQin2x6K2b
X-Google-Smtp-Source: AGHT+IE5bFo0PC/TWf1YxOF+L9MITLHLF35T9Fl/dZRt1OQwqUOuz2WwkmDkSOAdG1t/e67N4i8iVQ==
X-Received: by 2002:a17:907:9712:b0:ac6:dd57:4bf4 with SMTP id
 a640c23a62f3a-ac7d190ec33mr1083248766b.25.1744045202705; 
 Mon, 07 Apr 2025 10:00:02 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.10.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:00:02 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:29 +0200
Subject: [PATCH 08/13] board: dragonboard410c: Fix counter frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-8-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

The actual counter frequency is 19.2 MHz, not 19.0 MHz. This isn't really
used so far though, since probably no one (except me) ever tried using
U-Boot in EL3 where we need to program the counter frequency.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 configs/dragonboard410c_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 5870aae83b4fc8d6897eb0f18cc4eb153d299c11..b7f284b4fa2812c60804126362b61164135adeeb 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="dragonboard410c"
-CONFIG_COUNTER_FREQUENCY=19000000
+CONFIG_COUNTER_FREQUENCY=19200000
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_TEXT_BASE=0x8f600000

-- 
2.47.2

