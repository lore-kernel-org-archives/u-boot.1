Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEE3CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 13:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55DF983526;
	Wed,  1 Oct 2025 15:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HAdg40Jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5948344E; Wed,  1 Oct 2025 15:18:49 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B63528328F
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 15:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b07d4d24d09so1364079966b.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759324726; x=1759929526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEjIlDEKSPJRm3DGGMFNRj7LW8/9zzyXp52Ba/W9E2E=;
 b=HAdg40Jws/bKaM91YSsw3vc9n+lImMNGRNz94m2pC4sCBrXKEOfjFSymmuwNVDxiFQ
 Z6OlelxxfWkDsAw6scm2fGR9X4Chn7UBX9lq2TfoZxDEdQGnnPRpAyW403jba6D7rhWm
 OMNN6Vt2l9dbzhSkYL/CI4oK4NLeLI7T+M23bWAGG2nDHSl2N6vJVee/OwkPIWutXQ3Q
 LK96FeWJtzk4sCltyMis1CgplfZ8mNgHxUSQc7DKJq9JBANgf1WN/fhfiQ2niDXUMoHi
 MyVJktGzhLCUav8EEkEMF2gjY8piiDr2aBKiWVeL7dful+3XNigobF3/x37qftUBIVYC
 fYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759324726; x=1759929526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEjIlDEKSPJRm3DGGMFNRj7LW8/9zzyXp52Ba/W9E2E=;
 b=X7A8GWbVzZaitWbx1iN1w0SXrXAptFYVru7MTBJWFfCofKZcenl69kVkwJCykKIwYh
 9+EnKXgWjo6CsV5+hKwPD6M2p00CvlDHRgOpYYZ35NMF1na9CttVWqmMTJvKjYbyQYuS
 QpPPTs5zP/FbnQGfat4LScffBds81/rrWsxhnpgezd+qNX+3Rno5uieeSJUF8Ptia1lx
 VaQNreDZag8P5dhenuRbUSALRbGTr/WlAD4VLXkiwzEin2rU7SryvYmI0OML3n24PK+A
 G7eFJsUZC1zdnEj2p5PnKySBwMdsMWmQ8Z/GgZ6xyQvcD3l4mvlWC37euXe5qU7FuQss
 fVjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhGPmbb5PVL+QWjxy9JNKnUWPxYvWrXpEbe5KzeTzLEyeMwxX5fWdg4PV0pc1w/ZkApbMKTxU=@lists.denx.de
X-Gm-Message-State: AOJu0YxEX36ZICg+zhTZWClmbwVvlFEongUFvqCwcweHbv1uyBuuAcwh
 AtMiu18J2Q3oBfXn1ycUypGo56bSrUAI/LTkz1GKCl6/3Atmix2LtJH+DN3yGmvc
X-Gm-Gg: ASbGncveS60VNgjT7ZWV1KBe8idHFuBFgbfVFa+dGb8pZAonUsB+bEYRZe+yMk73yEL
 eCgNztmICtVN63VoApKymUlhfi80/wesGKJ0gToA4gRVjqfNTdm3M06B36MZoMuSYET718Vg24v
 8aQiYAwY4DcI3EDjHIsocz7K22K8HnfbUpFUJ6npuT0UZWtHSL6ECfMyCdNOHRnua7ttIdzKsaf
 4uXj2VwX5xbxNW+h54ZFUb8ZJOJvrrU1ESQ0b9FdLPlhi3fSNnRDXUBGwfHkaoRRKB9sj5J/CfX
 oej/NY3t9H28IoTwACsoz3yr3wgjM8F+yAuXQMljcF/PE+I/v5uERTUX3HIY4VXGqXGyPsPrZ+G
 QubTp1qHOF1+WLwzttjjlNb4mIW7VPuf9/6BM+SdWli/yjk08Utd46HHBf47Vxmy28wowCwXooe
 7vwxr+axM5rDnKy2EAsfLkqbiq4WZRdk0wKNln37LDQAbv7l+KdOMao5JgACNau9mvf4Y4pgJF
X-Google-Smtp-Source: AGHT+IEAiDjdgAVBzyRysn6hYs8FHdZZAItBKlV8e4UMtaWS76EGEYVTgQkC8rVfKX1nAwKpSJQ1CA==
X-Received: by 2002:a17:907:72c8:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b46e9575b40mr417182766b.55.1759324726018; 
 Wed, 01 Oct 2025 06:18:46 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3d27759835sm757006666b.13.2025.10.01.06.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 06:18:45 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/2] configs: verdin-am62: enable USB Gadget OS Descriptors
 for fastboot
Date: Wed,  1 Oct 2025 15:18:34 +0200
Message-ID: <20251001131839.1488633-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001131839.1488633-1-ghidoliemanuele@gmail.com>
References: <20251001131839.1488633-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

USB OS Descriptors are used to install and configure the device without
requiring any user interaction on OS which support them (e.g. Windows).
Enable them in order to improve the user experience when fastboot is used.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/verdin-am62_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 2c0573cd54e6..d97dec3a3603 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -193,6 +193,7 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_HEXDUMP=y
-- 
2.43.0

