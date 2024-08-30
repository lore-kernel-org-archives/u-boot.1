Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46036CA0EDF
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 05:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF448855C;
	Fri, 30 Aug 2024 07:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="evN0a2rB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9706886CC; Fri, 30 Aug 2024 07:00:24 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DBC88817C
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 07:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-202318c4f45so13786595ad.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724994021; x=1725598821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RAY2Ea+jPqLOyTERY7utV0UGbHNqz9IpPpJkR+5f5to=;
 b=evN0a2rBTtWjwJpRrGzTBRltp17rUuoaR8hEnS9QjLNHjtR9BRS+o9kL8k/8EoH2+S
 rZcog8R+em+7KgIUKUtve5mltUB+Jd0coDrUVCkEDzEPg1RHCJpDHuUVYobEoTCIZABH
 ino98NqopqD23ytfdlLLNOB4BxJ4QxLm8CIdcuDn6iS2NBjBaIi5fYKQbTzWOuvaiY6R
 hcclvaXDMzeDisYWVMVOIfWAZ5vJJd7UG9cl4p59nLJjZ2gqOGn9Nzn20mGNWzbCVCae
 sya6wQrICqiumry7ebAld4457J3fYHsWqMqM5QiDonO7b9VHX/wevRWOlXGdz2oHVxFM
 MNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724994021; x=1725598821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RAY2Ea+jPqLOyTERY7utV0UGbHNqz9IpPpJkR+5f5to=;
 b=YWcUpfcYPfhymma9LofGI5O9J4nTvKIUNDutaQvFB7d0ie94Q/6WII6iecisjo7yju
 Y59whoqCP6iDOxd7kZ6j/IBRq5cw0EgkJPOUEhvz8+NnAq65Pq3ij2hHvJiMxguSr0FH
 aLxIZAiJR7ClXRY+bl36tDKne+hxKGYZtM80MJejtsSzm6mb5ZaELFNklyxVmklEb0RK
 DGhMOrfIwTP2ANNxpPaTBsPIuFkGACAv1+kJUrpLQb6Yuj2l6APcCXgVYnahi5NAHXf1
 uWdWWfzXXlNuLxGMoxhysrcxrh/qYMN3CX+70HCq+lt0JNuzIGdjV4uGp5A8KzXLz1gd
 F4rA==
X-Gm-Message-State: AOJu0Yzq6ffdYlSjj+U8qRoorUsJKIN+MSeN4ZZ9G5yy0yuoG12jjik9
 8vWKbMPSYXsqvqQu90jx2otiX6ewGKcLqH1eBcf7qG1er7ip7dgaAbeFhw==
X-Google-Smtp-Source: AGHT+IHwj0QTP8TPctUoqrxRFzV2ENKF7/5EL3ED4lu5mXfE/QvOLd815dy99Zwrk4jlOnGkr/SfPg==
X-Received: by 2002:a17:902:c40e:b0:202:508c:b598 with SMTP id
 d9443c01a7336-2050c4b9a58mr51768325ad.59.1724994020616; 
 Thu, 29 Aug 2024 22:00:20 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-205152b4dd0sm19371015ad.15.2024.08.29.22.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 22:00:20 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH] mtd: spi-nor-ids: Add support for S28HS256T
Date: Fri, 30 Aug 2024 14:00:12 +0900
Message-Id: <20240830050012.28870-1-Takahiro.Kuwano@infineon.com>
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

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
Datasheet can be found:
https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HL256T_256Mb_SEMPER_Flash_Octal_interface_1_8V_3-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c8fc2dd9c018fc66787aa0657

Tested on Xilinx Zynq-7000 board and Infineon internal SPI controller.
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 457965dad1..5769e662e0 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -383,6 +383,7 @@ const struct flash_info spi_nor_ids[] = {
 #ifdef CONFIG_SPI_FLASH_S28HX_T
 	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },
-- 
2.34.1

