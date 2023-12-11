Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C66C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 23:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8BA877CC;
	Tue, 12 Dec 2023 00:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FV9smAQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A5EE877B6; Tue, 12 Dec 2023 00:21:51 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04D35877C7
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 00:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b9e2d50e61so3306728b6e.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702336895; x=1702941695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdPFbsvW1lylRt9hGXZgZtg7cFWrJzWEYdlj+gU/GcY=;
 b=FV9smAQgljkAgPeeKek7ev8Ii8u4GDmFR6rGao4BD41scOaRGs4IXAsNGvx4cVlMJh
 8iFGPPMt5DF5kwIYePB3bvwmI+iUlFWs0LcirWVvA3obHnWILOz9Rj0j8yq/oQZu/vEy
 HAGkOEaA3mSbyk15rWlBvYs1gwaKcOEl4Z33roHmiVv2IFfVefaqqZixcYC5KSKlHeUn
 /v9A/PputoRWsrY8AavpcaQqNI+S1wxlyr2zr5ScOxEaE38uPiMywu/jtbArmxkOkWxd
 nf8dcK+cE1TnDaaO8NNj+yoSf1W6klbaMiEbX6boKPAHff18soCrAizv7+t144C73Tqa
 Xk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336895; x=1702941695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdPFbsvW1lylRt9hGXZgZtg7cFWrJzWEYdlj+gU/GcY=;
 b=NFXpRPC9uCySunwVrSq0mu59ayyJgXSwiKiT5BF5vsQYYoTpdiF3GCIdxRaDSG6JK7
 pFfKmMWHiqtGYv4l9Qp5QOa+i2k7+gQE2vfMNalpKQ9pJwaz8PsrnGSUSec3K54v/AIa
 snrrfl8Bk0oO2j7X8w7XAelEbuNvz0azP6aeniw432KHBBjmMe5dQ2GwVLRXiduPVSLd
 zAFFta5V91EagF45t134XlYS7dutCOKnB9itDj8IUKUSbaHvHYx/CeJWjrhz/gJdLr3C
 pS9f7LFw01BYsGXPscoUx1y+hArnJ4CsmKBVRc1csZbhMQCSRlXdDeEPOQHvKnmhaBAY
 FD9A==
X-Gm-Message-State: AOJu0YyPKnHR6zZD/Srdj2FwUs6BjFm5sf26VOa+yc/i7ePYviCzyPFX
 HcMfWHOOZ+rMvcYdmsUtSPCUfwt3G/M=
X-Google-Smtp-Source: AGHT+IFazCcCiBdnlu3I1PTpiBmewtOGe/tYyJ8c+KVR/IoQMwnluA+bXAGG/H2/pHiHEIgrKJR5Hw==
X-Received: by 2002:a05:6808:bc7:b0:3b9:dcc8:5f3c with SMTP id
 o7-20020a0568080bc700b003b9dcc85f3cmr6394607oik.57.1702336895443; 
 Mon, 11 Dec 2023 15:21:35 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bl11-20020a056808308b00b003b9d0371517sm2059617oib.28.2023.12.11.15.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 15:21:35 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 6/7] board: rockchip: Add support for new boards to RGxx3
Date: Mon, 11 Dec 2023 17:21:24 -0600
Message-Id: <20231211232125.171438-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211232125.171438-1-macroalpha82@gmail.com>
References: <20231211232125.171438-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Anbernic RG-ARC-D, Anbernic RG-ARC-S, Powkiddy
RK2023, and Powkiddy RGB30 to the Anbernic RGxx3. While the Powkiddy
devices are manufactured by Powkiddy instead of Anbernic,
the hardware is so similar they can all use the same bootloader.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 44 +++++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 7bef5a53f0..2445663d43 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -48,9 +48,13 @@ enum rgxx3_device_id {
 	RG353P,
 	RG353V,
 	RG503,
+	RGB30,
+	RK2023,
+	RGARCD,
 	/* Devices with duplicate ADC value */
 	RG353PS,
 	RG353VS,
+	RGARCS,
 };
 
 static const struct rg3xx_model rg3xx_model_details[] = {
@@ -83,6 +87,27 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
 		.detect_panel = 0,
 	},
+	[RGB30] = {
+		.adc_value = 383, /* Gathered from second hand information */
+		.board = "rk3566-powkiddy-rgb30",
+		.board_name = "RGB30",
+		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
+		.detect_panel = 0,
+	},
+	[RK2023] = {
+		.adc_value = 635, /* Observed average from device */
+		.board = "rk3566-powkiddy-rk2023",
+		.board_name = "RK2023",
+		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
+		.detect_panel = 0,
+	},
+	[RGARCD] = {
+		.adc_value = 183, /* Observed average from device */
+		.board = "rk3566-anbernic-rg-arc-d",
+		.board_name = "Anbernic RG ARC-D",
+		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
+		.detect_panel = 0,
+	},
 	/* Devices with duplicate ADC value */
 	[RG353PS] = {
 		.adc_value = 860, /* Observed average from device */
@@ -98,6 +123,13 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
 		.detect_panel = 1,
 	},
+	[RGARCS] = {
+		.adc_value = 183, /* Observed average from device */
+		.board = "rk3566-anbernic-rg-arc-s",
+		.board_name = "Anbernic RG ARC-S",
+		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-s.dtb",
+		.detect_panel = 0,
+	},
 };
 
 struct rg353_panel {
@@ -332,19 +364,21 @@ int rgxx3_detect_device(void)
 	}
 
 	/*
-	 * Try to access the eMMC on an RG353V or RG353P. If it's
-	 * missing, it's an RG353VS or RG353PS. Note we could also
-	 * check for a touchscreen at 0x1a on i2c2.
+	 * Try to access the eMMC on an RG353V, RG353P, or RG Arc D.
+	 * If it's missing, it's an RG353VS, RG353PS, or RG Arc S.
+	 * Note we could also check for a touchscreen at 0x1a on i2c2.
 	 */
-	if (board_id == RG353V || board_id == RG353P) {
+	if (board_id == RG353V || board_id == RG353P || board_id == RGARCD) {
 		mmc = find_mmc_device(0);
 		if (mmc) {
 			ret = mmc_init(mmc);
 			if (ret) {
 				if (board_id == RG353V)
 					board_id = RG353VS;
-				else
+				if (board_id == RG353P)
 					board_id = RG353PS;
+				else
+					board_id = RGARCS;
 			}
 		}
 	}
-- 
2.34.1

