Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300DBD5C0C4
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 02:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419F48042F;
	Tue, 16 Dec 2025 03:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7fi4+k4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D03280433; Tue, 16 Dec 2025 03:48:08 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C45A48036B
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 03:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34ccbf37205so303870a91.2
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765853284; x=1766458084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgweoYRLktKIVWs67kEdaagNoCg0Nqmbut69TrbwGLc=;
 b=j7fi4+k4WXKGAIi8dKvAH4LrnFIKmoBXkOES6M4e5x3FuXlkfBXw9wMbpH76vgtS+b
 e2UCIRUV6LC3WL892t66SWWeg5SDv/We4fdk7cK5NBokP9jJiXahbDNGn2Vqli7h6iQM
 9jdM0dw3Espm7snfbpa7n5xvRxqO4Ivh8MAxW3owbTjVjnFA9gO0jGga5BNhKNfdDIah
 fajXlPiC/bCNlEkQNRd8m/CvHeLi4jDUo/B9b/6zJcckHzI5N8AKZmyF2UYYelMIPPuZ
 14C4nC8QT7+ILCsMC7S7UWZBuB58kAvywujZ3fal+qU4kBLT1kyUTwyk+JzKuW8l/73T
 BJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765853284; x=1766458084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fgweoYRLktKIVWs67kEdaagNoCg0Nqmbut69TrbwGLc=;
 b=HNhK/Y+RPx7Pcj7vj1qVUxYhzyusKyDAJYOW9waeQ/N2dUttGZGoK+6/CkK5rBqydJ
 9wsbaBZKlCePwpUFsnkaAZj0+uuAYUZC1gqxTkVurOBEU4TwhpbR/5fhc2SV99N9TacI
 QGVXVC3oE2mYvyxCbCQuecf3741VgTwHR8K2vZ9+QJrwdbtaUeBKwZx20/Ei4KyZ09R4
 jKydM92ymVzldBL4bIt8FFANFcXYwf6yhDPsZcegEfP8id3fbI9VG4p5ohsP2r9c19Za
 1SEpivbYVMvZ4bo6we1rK89l7TzRbgxgARquG92mUp7M5dgkuZFLzRp9lpaS26dwM00V
 sYXQ==
X-Gm-Message-State: AOJu0Yw+z4W2iK19WzmPc3Q+76oVAvSfBjEpkPNo4rArtOt1Mkup25LL
 yBF5DM8kN1123PTMp6tt4p+jI1Pv+Mf/vsOOzvTC+9TQQc/jsfZiPQTC8RpIbJGt
X-Gm-Gg: AY/fxX7TgDrxmYC1UKt2kcW0P5FOuZ54q9Qd1lAnO00+8Rdb2NX3Nxo1/XZAeG6a78z
 +5egcAXpKHFAbML6kzCojiKwrVnjmYwOVj4bmTC1ArYOG+Wrt1Xt81W4PDJrIAhHgZV42k7a6gq
 ic8na1cNG1d4MpQMHUyKRXeBPdcmjuGmbLSDmYduJfDDh51j7DmJ+D1tYJbPD8uq5Kw6d+qQTiy
 f7ywTlk5mHtEBhFiIvFqTS73NcWNCunV4ltN4viSqjHAjbPVNdIE9Yj7e20yYZzRZAQa+BoNPoP
 LPplG/aFL5d0c8O71Aq+su6Xi34G1BZjLvvp3IWDKkmKdq3VUW98BLTobDgLoiMCD04J5ml/Vnv
 FldOrROaAh9FdzyaludPnm2+uilLpNsJfo23iypU0zgAODIeCWuSXgpfqhWik/zbZ0fzzPJkQzj
 tK828VPlXr0JnRcDb0DMkviQ==
X-Google-Smtp-Source: AGHT+IEgHpXYgUA8dSvtKelDgudHHA4cp4qF+4gknYD3/ErN7is6epr4ui3chZKFSlHfSqvcSMe/7w==
X-Received: by 2002:a17:90b:2d46:b0:34c:6124:3616 with SMTP id
 98e67ed59e1d1-34c61243815mr6476967a91.27.1765853284160; 
 Mon, 15 Dec 2025 18:48:04 -0800 (PST)
Received: from cs20-buildserver.. ([2402:7500:502:d4da:9fd1:87b1:de1a:188c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c26eb1d05sm13401606a12.13.2025.12.15.18.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 18:48:03 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 2/6] pinctrl: npcm8xx: Add smb11ddc pin config
Date: Tue, 16 Dec 2025 10:47:25 +0800
Message-Id: <20251216024729.1031306-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
References: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

smb11ddcm: connect SMB11 to external DDC pins
smb11ddcs: connect SMB11 to internal GFXDDC

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi  | 8 ++++++++
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
index 6f933355d9e..cdbe19ccf50 100644
--- a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
+++ b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
@@ -1060,5 +1060,13 @@
 			groups = "vcdhs";
 			function = "vcdhs";
 		};
+		smb11ddcm_pins: smb11ddcm-pins {
+			groups = "smb11ddcm";
+			function = "smb11ddcm";
+		};
+		smb11ddcs_pins: smb11ddcs-pins {
+			groups = "smb11ddcs";
+			function = "smb11ddcs";
+		};
 	};
 };
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index c960ca3393d..0d089110df3 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -166,6 +166,8 @@ struct npcm8xx_pinctrl_priv {
 			     213, 214, 215) \
 	FUNC(spix, MFSEL4, 27, 224, 225, 226, 227, 229, 230) \
 	FUNC(spixcs1, MFSEL4, 28, 228) \
+	FUNC(smb11ddcm, MFSEL4, 29) \
+	FUNC(smb11ddcs, MFSEL4, 30) \
 	FUNC(spi1cs1, MFSEL5, 0, 233) \
 	FUNC(jm2, MFSEL5, 1) \
 	FUNC(j2j3, MFSEL5, 2, 44, 62, 45, 46) \
-- 
2.34.1

