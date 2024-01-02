Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5876AC47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 15:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0320087944;
	Tue,  2 Jan 2024 16:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pm4DUL/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49DB5878DB; Tue,  2 Jan 2024 16:47:10 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 199C2876C0
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 16:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-59574cbcd50so419079eaf.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704210426; x=1704815226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJhSCYRgS5TwE24+2YJfWeVs9zEBA+O1bqP3d5jKlAo=;
 b=Pm4DUL/dlmPYByq2ilaxETV0fz5X9CU6MYa1dyNQvm/4COp8YLN7AT4+0oPeSv5H3E
 fwv9E/n84Z+bR99W51hNqKNj+1+mpdWMpiR+R8hCohHKJMB9BZoNFMR4tcbytRA3Z0/N
 yDiHl/FC+hOXPV8mZZu5CMnzU9fH3hlfCjiZEgtCLZbRN4cXzU2ZXbk4NOA/M+k1n6o0
 6JDdIC07sFqjdFC8qywikoLRvOzWG9xKDJCEWAgQv1Rbz//0NsweSjyq0w0xPW35fJrP
 a6vs5nm6yx8XCxmBsD+26lBmUMeAMmn0OLeNyylfC4ilmU7db1Bwi/FiRXi3EzQIpTkc
 IODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704210426; x=1704815226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJhSCYRgS5TwE24+2YJfWeVs9zEBA+O1bqP3d5jKlAo=;
 b=t3svYUyNztiao0vhFDTe8AAoYa72e9IafzteEbi1KP/aI/ght3WmE5+3rilcKrYZGT
 1SwdXvCTrb/2RFiqu6EPSk0X2ZlN7t7mXYzopni/++Ftvt6TbR5+07u+0I6EUC/7k7Vr
 Ic8YNUexxg6i/0oTBX9VMPuz0zqweJAGDIjiPMMgYKRckLeIMC+dPl30Eh0ShHIHKwVS
 qRbQbkLCdp5zf0Ez47pQyQYSbOQmf3wNJi+GXCzEYB1JlhWXr/SiVskzDW4BkNeB/ldd
 oocRm/9y6BvVqSWPjUHGxixDUHg9QZ/EsdIPT8D57AH/+0vVvcWrXEEQrnotqXa/uedq
 jdZA==
X-Gm-Message-State: AOJu0YwGlfIbCeUQzf8vPfTJQKu2VisgWWWZybzGXQnM1l4BtVbyysa0
 jdXZHUQGGBZ1QWsLmDdVNqV88HTvUniDMQ==
X-Google-Smtp-Source: AGHT+IHTgNtfupM+yqflhk+1K2rENb+UpCO8Bp0BJ0172t9EigvYzIM+wDC+fxHMlaxys7TvJW1BTQ==
X-Received: by 2002:a4a:57c1:0:b0:594:35b8:5fb9 with SMTP id
 u184-20020a4a57c1000000b0059435b85fb9mr6486113ooa.15.1704210426586; 
 Tue, 02 Jan 2024 07:47:06 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 127-20020a4a0d85000000b005958af24e84sm843197oob.42.2024.01.02.07.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 07:47:06 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, jagan@edgeble.ai,
 jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 6/7] board: rockchip: Add support for new boards to RGxx3
Date: Tue,  2 Jan 2024 09:46:53 -0600
Message-Id: <20240102154654.191055-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102154654.191055-1-macroalpha82@gmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
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
index 7bef5a53f0..e12a85a02a 100644
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
+				else if (board_id == RG353P)
 					board_id = RG353PS;
+				else
+					board_id = RGARCS;
 			}
 		}
 	}
-- 
2.34.1

