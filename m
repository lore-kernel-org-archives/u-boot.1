Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE2DCEBF67
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B7A88E7E;
	Fri, 27 Sep 2024 03:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YLk9WVwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A20688FF8; Fri, 27 Sep 2024 03:27:19 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCAF88E39
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2055a3f80a4so10483805ad.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727400435; x=1728005235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DGNGF7eO3t38w9yDtJyTFQ4IFiPZGpvqaVYQf7DQaHc=;
 b=YLk9WVwMsg/8kJ7EiQorU8m87ysKySI6QgFl+uv1EAJbPIEXSBjgWee0jYjni31aJG
 odrAhVwOZaJkgYig6XkG5bnbV9Tgw+Y0BRD7bkEXKZ/ZykKLUY0dqXdd2NJYJYFCXPdb
 yiRoavTMBi/YJrFPYZcBsvZ0U716AfLU2J2TD9sf40/bvj4wX8YAMkNrDay/LhCU3SJZ
 f7cokYyYee0FnjSnDoO6IyGPicDI33+tPRqj7efuc642L/4JFJe9ZYy0TVXLheNhCotc
 uY/IK+LenebxMxcVcqPLHInJBsd3xKHAgvQQ0xwWxGcW3ytEhA2bnDRyNSJQ6wF7c2ea
 g2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727400435; x=1728005235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGNGF7eO3t38w9yDtJyTFQ4IFiPZGpvqaVYQf7DQaHc=;
 b=V817Y98PYSXxtQGBNPyZayaoBFSgYF5mv3OzuTMYvVx3can4d69FaghNQWJorP5I3T
 vJcIulqcZsPeh2fulnQrCw8NZeL6y1KMEVyHXpmEpmMWLmOUj8TzmpNVXGIAH0Nr6qlY
 K55/hrBF/awtaP5hRVcd0JLDKAknHNQ5RTZtNEq9SKhm6hAEC2ioWhXg7XeiIMpWtysb
 WjRRV9oBopOMkrSHrSMrKoNyRqPuAYzOUl5hIA62aiq/Cuiwn4uA8EkcqGmXo1yHbqlz
 0YJ6GIWM4MBbxATmfxILhIz2DRippd8qOKXjllTMY3nv3DY9TbWJstTr80RDm+cnpTTW
 DTog==
X-Gm-Message-State: AOJu0YyCaxjFx3mMi0qjFSVQ6djcjQ8P4ggu3v23qZRdxz9AdrupzjGL
 SXSBjUmpeUM2C5KY1PwZnF/1UjRw6RkgxrfJ9Rnv/R/UdT/8fWGHXt+hfQ==
X-Google-Smtp-Source: AGHT+IH0GwVB8LwyFkSCa0HZClIFx/lK7+gJW0moNNyRdt0yP/qEhteDZqKq2LfrrPUPfYFfyWRDLg==
X-Received: by 2002:a17:902:cec1:b0:202:32cf:5dbe with SMTP id
 d9443c01a7336-20b37bb65femr23930435ad.58.1727400435443; 
 Thu, 26 Sep 2024 18:27:15 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6db613f6csm517705a12.91.2024.09.26.18.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:27:15 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH] mtd: spi-nor-ids: Add support for S28HS256T
Date: Fri, 27 Sep 2024 10:27:08 +0900
Message-Id: <20240927012708.8732-1-Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
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

Infineon S28HS256T is 256Mb Octal SPI device which has same
functionalities with 512Mb and 1Gb parts.

Link:https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HL256T_256Mb_SEMPER_Flash_Octal_interface_1_8V_3-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c8fc2dd9c018fc66787aa0657
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e7e89eb65a..b1e3a08089f 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -386,6 +386,7 @@ const struct flash_info spi_nor_ids[] = {
 #ifdef CONFIG_SPI_FLASH_S28HX_T
 	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },
-- 
2.34.1

