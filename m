Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCE3C02190
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 05:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34668802EF;
	Mon,  3 Feb 2025 06:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mKAO/s6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0B2880285; Mon,  3 Feb 2025 06:17:46 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259AD80079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 06:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21661be2c2dso64556545ad.1
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 21:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738559860; x=1739164660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvt8ixcXi3qRocESic9qaUZ9atF86Zk8xT2/StCtD7k=;
 b=mKAO/s6h0UyifQXPjyde/k6V5Mja+/VUgxM0bgwPv1Hy4s566T9FboXlTDoOOuxMMA
 VvN+ewQZiEnWsqlyKSSuQ3e9YQnLsbSSZHDh+5+eEBru4lfFFZF2Ym9Y1THP6OW8SZRQ
 ezLfy6lM+n44oJs9OnTnEPLq9HOFqFGni6JNDlPbGk8FhEXNawsFZ7dwgegL/RgHwylx
 eIpDUcfLDGEJTHG22v95qTP3i9yFxQBN7dHtQONsDHYlvlXmq/YvqnwBEr3nGW4YiJO1
 Zb9PytJkCM8T8Dgh/A3Vlm52pcXKyrpm9PZ9OQqd6GRrsbHAtq9+6WUEyBJCJTt40Yrg
 yQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738559860; x=1739164660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvt8ixcXi3qRocESic9qaUZ9atF86Zk8xT2/StCtD7k=;
 b=QLAWXWCo4pUZDBJpZqutoOk2jF/aMXtmvaNSZ7hVn8G9CqRliU/D7u5+M+Hdctytse
 p48rdEyhFEvtSZvBogblyV2OKnBe8X4SQX782R1c0WPry5QurcTFrfTeIEGVieCJ5vzJ
 hIKQb3HgrYqhgiaeNmKu8PEgoMrWzJgW/AY9JgPcuZAcbLln0uZ9oN+4As0/u1ARE4D/
 d4t8LK5yq5Ip9zNkKGNOldnEKnTGXgRsiy/bA0zbWi9qzt8s32cxG9kTZxgQZTdmbYt5
 UBQ2behp4RA6aK0cSXT5/XoGHatNi+CBRCiNo1n0q2DiFmLW6ZYnhJl9nxPRj4AoJUs3
 hNiw==
X-Gm-Message-State: AOJu0YzlVEimbBEDV5k/jXkJHtTm6MbeM8+mlkSN+hlhzngswh9GVXsG
 7ZN7FUFQeu9mUnF9PeCJ86u5mUN3fcJ7KgOblVuq98EyJb4RSUY2X0ppR/y5
X-Gm-Gg: ASbGncvtMNAk4b1EcwuL7ureYJDMnPFjMlPRADpK6c0tzERBhl1YJb5hl2RYMZcJWe6
 32+6GxTfSUGMRZZ1XGvpIQ8YcbL/vYMCRxeI69WNG3uJo+LBLZU42PDVbXUbjbwzi0J0ZA/+cI3
 /IFVXF997sseoxHDVuSUhYjU8esMmqIcYVDPRd6+/AQLtpzp5A6961Dc0ujyJE7hNQKcjZXP3Vg
 xo8WQQcV/IjtO8hVhdzPlAbYT7zvSFFA0798MePzlmuIQqKsrPZP5KJZRkan+L1gev5ama4xAhf
 thCWDB8P/CQs8JZMSqFNQb4HFxjvdVFFZNrEzymGm1H/loc12uxmdHA9/Lmuhs+ReI8nxsl6RIt
 NGBTl+Q==
X-Google-Smtp-Source: AGHT+IEs3VM8pn+1rgcZpWNqBEnlmLUbl420fAnx3MYYx24Eb070wtCx7PuVHDY8AUJB23AieTshUg==
X-Received: by 2002:a05:6a21:6d9a:b0:1e1:af74:a235 with SMTP id
 adf61e73a8af0-1ed7a53b45emr35845169637.24.1738559860550; 
 Sun, 02 Feb 2025 21:17:40 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (sp49-96-228-226.msd.spmode.ne.jp.
 [49.96.228.226]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe6539fc4sm7508639b3a.73.2025.02.02.21.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 21:17:40 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 2/2] mtd: spi-nor-ids: Add support for S28HL02GT
Date: Mon,  3 Feb 2025 14:17:12 +0900
Message-Id: <417e036a8ba6df0b793efd95e80553436ffbafd3.1738559198.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1738559198.git.Takahiro.Kuwano@infineon.com>
References: <cover.1738559198.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Infineon S28HL02GT is 3.0V, 2Gb Flash device with Octal interface.
It has the same functionalities with S28HS02GT.

Link: https://www.infineon.com/dgdl/Infineon-S28HS02GT_S28HS04GT_S28HL02GT_S28HL04GT_2Gb_4Gb_SEMPER_Flash_Octal_interface_1.8V_3.0V-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7e7124d1017f0631e33714d9
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index a500fff4775..503dca28b89 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -417,6 +417,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s28hl256t",  0x345a19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("s28hl02gt",  0x345a1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },
 	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
-- 
2.34.1

