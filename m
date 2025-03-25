Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A788C36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 301248122F;
	Tue, 25 Mar 2025 03:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EpUkY6LI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD3B81A0C; Tue, 25 Mar 2025 03:55:10 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1533E8186D
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-47690a4ec97so52597931cf.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742871306; x=1743476106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqaTMnhpC7O0Qxjh+9lA4E17zCk14IMJECx3LfqMZJc=;
 b=EpUkY6LIC2RJIC4W2D2bThTY5SBs4La87OZnwYQ7h5B/54jnuIXoE1Miutc0dZBzkG
 tFhTWmR+USIOVz0EdyZoigOxNKLCNxGijel5TjTLs0U7rweenQzNI2R+VcWb0G/nY/oF
 xw0D0N3sMfOJ/BPRtUEnhfzfx6MhG3/O7o5h/ngrWx9tqWpHRQB05L459L5uU/5THehG
 qAge1tXkM8RjV2qmxvUy5Lpie26zBbv+4iu/R7cqe+qaAHXCvLCArKzo8Uvb1Hdm4wup
 dF6HuEyGC2DZ4Dv1sVjdy34CLcOFlNReJcBpEjjtog8I84IM5gSUQxLfzSec+oeXax+6
 0/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742871306; x=1743476106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GqaTMnhpC7O0Qxjh+9lA4E17zCk14IMJECx3LfqMZJc=;
 b=j8hKoXSXXf6HRnyDSjehSgscF9C9Vv26X7ZqMe0lThftMh/OuNf+2somgarMdIjSbd
 7lSRr491mAvRHOQFtZ1Ul2ZYhK3f+HQXH83RpX3Udd3UqQtvD79KbZ/HrJWVg9adcF1i
 yhgDuyRbGgr2UYayIVLQ3IAVRySPRv0rQvdCd5EmLeN2OfXvFQtJ9tSZU8W6y1n2TUhf
 kYq3Tr0IMoJJBRyb9Br0iRc5UXOooAJ7+1tmzv5hkPW2nEWeuARK5VzzPjSQGrhC8a0E
 k9eBL2UnWYTWOqKupRXkrivmPF/ylpz+MoSoAtmFyxD0jbTxZMY3dNZo7mE5uLFtqLTm
 R7eg==
X-Gm-Message-State: AOJu0Ywq8LY/NcPAkQxqA3RtXyXrPd3/56YsyZH0Jjab2vNc0fUxGADE
 lKKlnnPx5B6MVeFudrw729zxAiPQP6UYnmxFfJ4VKbX85mqGiB8DGmknvQ==
X-Gm-Gg: ASbGnctTPWHZFfjdpyMo6Yk0rjoZ5NVD8guMpQl/mOHA8/GELfyzIYwCWyoGdeVIAGi
 D1iRDN1vZ4Zf5OKQUSj09rLlu3F+PooAdox9NVnKQpG0hMLavSvZ1tIxueXZdtrJenG/ZXrU5OI
 egRqo1icE88Ute8TKpaVxCDHnHDbAqiKMNZgoAAhADSdIrvDRxd5QX7VuorNFqlpWQg1Y5ULzvv
 5M75akbaOB5pC1bYpY+WXGGNVDaDGebycw59bIzLgVeAqG0Ul3fZl7LiFAAkyjxBDn8xyPfIRVj
 RJEulF2T9kWLQGmBfJ/imYFsjhWZGTIgWJyt0qmGqsC5UDlfG9J6wA/TzC7dGzrb6adUvibdilg
 CwtbhdxU6/NyzTgM6o70=
X-Google-Smtp-Source: AGHT+IF1C3+Sz3Es6dSNTADptyLEwL40jsxQHvkPKm8wqvAF8AJr1XRFhm7t/h/n8HT2X39p1T64Dg==
X-Received: by 2002:a05:622a:5193:b0:472:1225:bd98 with SMTP id
 d75a77b69052e-4771de8fa0amr267391231cf.50.1742871306213; 
 Mon, 24 Mar 2025 19:55:06 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d176113sm54712021cf.17.2025.03.24.19.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:55:05 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com, marek.vasut@mailbox.org,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V4 1/7] imx: imx9: Imply IMX_TMU
Date: Mon, 24 Mar 2025 21:54:42 -0500
Message-ID: <20250325025452.950303-2-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250325025452.950303-1-aford173@gmail.com>
References: <20250325025452.950303-1-aford173@gmail.com>
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

If the CPU Information is displayed from imx8_cpu, it displays
the cpu temperature grade and operating temperature if
CONFIG_IMX9 is defined. This behavior is similar to what
happens arch/arm/mach-imx/cpu.c except that the latter
checks for CONFIG_IMX_THERMAL or CONFIG_IMX_TMU.
In preparation to make imx8_cpu act like the previous
implementation for any CPU, make IMX9 imply IMX_TMU, so
it will be always displayed unless a user decides to
disable it.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 49220c0955e..c3e758e103a 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -10,6 +10,7 @@ config IMX9
 	select BINMAN
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
+	imply IMX_TMU
 
 config IMX93
 	bool
-- 
2.45.2

