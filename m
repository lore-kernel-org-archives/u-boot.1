Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BCAC28B2F
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 01:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA538142D;
	Mon, 10 Mar 2025 02:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KY4ECXFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B9E80107; Mon, 10 Mar 2025 02:46:00 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D6680107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 02:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so5016601a91.0
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 18:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741571146; x=1742175946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2LfkTV2BuknoEWloggMmJ9oOfx0EnRbNR4xQWKKAwI=;
 b=KY4ECXFuRTPHGxbBnMUScHCu/3Bajemi+UKAyAHgAKr2ftc14ZFoMN92Xa0nxyhaRn
 vXDJTja4Sz5y0kOo+3vztsn56M9g1SkS2up9ZXHmNOneZQTrPKLILPehQZEF3rkuIcd5
 IWpri2/9CuWqnPEIkLbJWxpzI4KCJOYZgruaM5dvLxPrnPbmdOHCLTx16VEZ87W3rAWh
 TBYBhwHgGURYMsi+8mgTZLwsvxTmoiuIotN44xOUS8n27fFPanOvmKPuEwn6A2C0N95X
 Bh2Zk0pwrNztFD1t/SURrJUHlIOUMJ2Ml/33EfmGArt2AC99cU/DqZznsWjhre1WVuJY
 Y9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741571146; x=1742175946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2LfkTV2BuknoEWloggMmJ9oOfx0EnRbNR4xQWKKAwI=;
 b=I915rCWX0Rj7BEFn+ePRvlp/b7Bh21ENdX9PagtspR93sM9fxuQNCXM0rL7asQdaJ8
 dcQ05HDrjMoKNs2os27NK7l7e5TmZ3I+esp36flTyaQoi1Rh/MaRWchtLDv+h1IcXbxH
 vqUqNrw5F+3Zg32bxdgr1QOBOMfASo0/BoZWOhN807iSyfQhjJvg49IJrD8NhwJtscoT
 XXA5iPH4AUDJU9w71D5T7I0IQ3OPx8yPawBOjRbndiQe/JDBGk8+s2WyMSMxklrHNENy
 WJq/gxSHTJ2HDwBgaFyqsN8n1pAvU8auU5IgAO7Bqb4r19xFK8cfGP7LoARACLdazFMg
 4UyA==
X-Gm-Message-State: AOJu0Yxs1+lC93/xcyaXvTVDyuilIslcBCeqegs/L+mwwCwF1TTkWPCa
 1jY34Row6gRV1+Im/Ace9zEehpRh3CSEzU7WBghFYa3irz61Og0Ee4ajDQ==
X-Gm-Gg: ASbGncsBqaLjoltiWSY/38nOWfEGk8zu1ESoEWjT/qKo/+xW94QhWs1k6a7pXo2aIGu
 SqeKhL6BeVU6YcfUXp5SrOsrwvfg8Zzc53osXTraGklrj3cFPkLDEMveawmnKibwmT/7VQX7KJQ
 F/1pwEWItwmY0BC1VEdm3YAm1fWM5gQg2uv4veeUso4AY13e8tUai5gpilPf7Uj9UqKcofC6sat
 BV3QJL5huvhAGPdAVM8rIYM/h5SVErAerQ7TpwZ/lUI+gbYsRQ66lk/3t+Lxrqhz7JCIEwhS5aW
 BMCxtyuoBtJJKVkN6OQl2AjGu/nZ5WGIULq6O1GpG4PEi92Br2nhUw2vd6xTPrMkUAXgvTKJKYD
 XFClbqpXBrYr0JraPdWYlpAs72Hp6Yrmh9rkzcg==
X-Google-Smtp-Source: AGHT+IE3y4BcXke6hVr3f7MTVcJBadhOvdPczHaLiCsmlfeQd50zsRI5bzFWMkqGZx6oR+I+r5cG/A==
X-Received: by 2002:a17:90b:2d82:b0:2ee:5958:828 with SMTP id
 98e67ed59e1d1-2ff7ce93dfdmr20554227a91.9.1741571145904; 
 Sun, 09 Mar 2025 18:45:45 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff69181d13sm6696049a91.0.2025.03.09.18.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 18:45:45 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH 2/2] mtd: spi-nor-ids: Add support for S28HL02GT
Date: Mon, 10 Mar 2025 10:44:29 +0900
Message-Id: <533e6be2817b97ea6a516de1aa4634bfebe1cb30.1741570750.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741570750.git.Takahiro.Kuwano@infineon.com>
References: <cover.1741570750.git.Takahiro.Kuwano@infineon.com>
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
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
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

