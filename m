Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C64C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC73982A25;
	Fri, 16 May 2025 10:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oXlxtQFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BACB2803DF; Fri, 16 May 2025 10:17:52 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD1D82A33
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442f5b3c710so13957815e9.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747383469; x=1747988269;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJ/sRU1s5uCt7GiycEaM5hmahnHrMbYIPPT7bUyIP9A=;
 b=oXlxtQFH/oXABTsqd9TyzzJ5MEAIC7oCykWt6EaBWqFu7igM40qvY9fu7hyqpxe03i
 0TsRqrlwvA2c3/JYfejh0fvXhuohIGPlwdapKNhplNAZQhu7yUN1gOIzwjiokU9e9cRy
 VbkEjLjJpbpKpw8lBloArQRrqeTopfXNr4UMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383469; x=1747988269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJ/sRU1s5uCt7GiycEaM5hmahnHrMbYIPPT7bUyIP9A=;
 b=Rbq50d/TlVVoakFXxNOgEipwfj/0KM2JqXbKLO58o7rMD/CiDqPbPWODRkflCpxRBm
 RpufmNhbh55RCNtyLkLrJUeRXIchwrMh5gTlGDkD5PSDxS1DFUNAojsk8Ogc6ILinR8R
 mkrXygZgUinLJWK4cb3b2Y6vUZvLpku2x8rHuIzC/w3/RDuOrfbD4EXNbbeTQgmQb/JZ
 QCyLxt/MYwUO+cNplmwiebOxY+drMxrZNSkj3oKRwUZdbGP0nn/JAbCIt8u5kpVIdBla
 qbE+i5YZo2q1TXIFgPg2tTPZDR6dfzffRoY0tc/3SJFGRZ2KJ+TOPs2nbSys6sIkV7TU
 xAKA==
X-Gm-Message-State: AOJu0YzTroQj73UbhwTo5lOspRTm5+xsbS6vwTMmByTJ/5mhz/q2s3c0
 g+6Sd0YYIN/oqW5y1W1ZZCYJ9/6gjgXkUdi7dlQMKtQDl/HnxWAuqHn3CvAwZh7IRTyShH1cqJY
 zLQES3ip/W/U9
X-Gm-Gg: ASbGncviITtju90p/pp3o+l45/y4bZuWaaeKV2Wlfj7P55UKKXWQM2BQgQl4yuj+QkI
 jCG58EB9FzpHCt18T/cY9TUYqRvVKo4Gqz1Aatemqhx7OsuLfFYJsLCe4DPpNzi/J0l1oWxOkPJ
 BC/xoWZR0b3VWajLuoy+oZA7W8wxRJQItEgeTFS4CI6Xu76MufV2Nku8GIs/0IoVXQG/mIYEQyP
 mgRK5hF1Lwcf30tBHU62kk812cOp/1Vn9Jg5trY3/xsYq99LQr/GT9USA55h5Af3g/E7obdvX7K
 YezqVHHbBvyPgrPIYyBGwXqTQmu/CaosarY3XBnAquGONW/OdofpOu76bwbq6gEQaOd3e9XeXKr
 s90bt3zU3HJkNwP6E8VQCTwjsFp66Vg==
X-Google-Smtp-Source: AGHT+IFnHlw0f4395qPh8dmXToQFRF7d37rHun3d7SYsGqrVtd179IVV+SV+P53N9pfapAVwVgWhtw==
X-Received: by 2002:a5d:5886:0:b0:3a2:3c53:947b with SMTP id
 ffacd0b85a97d-3a35c7de96bmr2773015f8f.0.1747383469531; 
 Fri, 16 May 2025 01:17:49 -0700 (PDT)
Received: from panicking.rbg.bshg.com (p5b26784b.dip0.t-ipconnect.de.
 [91.38.120.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d0fasm2098172f8f.8.2025.05.16.01.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:48 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] configs: imx6ulz_smm_m2: Add board watchdog reset
 configuration
Date: Fri, 16 May 2025 10:17:20 +0200
Message-ID: <20250516081738.2524518-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516081738.2524518-1-michael@amarulasolutions.com>
References: <20250516081738.2524518-1-michael@amarulasolutions.com>
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

Add the configuration that allow to reset the board from reset
cmd

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 configs/imx6ulz_smm_m2_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 15a3ec5c627..436bfb78cc2 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -64,6 +64,8 @@ CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
@@ -75,3 +77,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x877fffc0
 CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.43.0

base-commit: 7a18328d70cddf8d9ffab046ff38def5d2f61add
branch: next
