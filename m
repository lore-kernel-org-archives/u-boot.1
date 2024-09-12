Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C60EEB569
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 08:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0D788DF1;
	Thu, 12 Sep 2024 10:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gSfhEX4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3243288D85; Thu, 12 Sep 2024 10:54:52 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB7E688EFE
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2055f630934so6671985ad.1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726131288; x=1726736088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mBSJVqiSjBgt9wSTZXLa8QxNkqxXGP4AzKiQFPakxCc=;
 b=gSfhEX4/Jm2nPxKJsATsfS4qL3Fu3dL3laT6ARXLkQohQRetan3gnmO9nifmznCk+c
 fBAPA/NECYiOWcKF8Gaypf0pdqzQj7FtZsCznCVGAuUO5bA6HGFe3S3DxKMQLp7q1GF5
 xZjem/J/cGhGicG3sP+ZzKRkVnpE0CHDES4IRnuncCJk9+in6IIe8zQ1pEpZ7GFZdpqj
 j3O7lQkJzn8zcqyFLIWYYHcYsc2kC/JlVgaGy4s/V1ipA/MiOQxpunWx5glDCmuAWIxG
 zTyid0mhXukGW0XhwEErfMQ7YIMne4vge+eoOZYjh+PM4YJI2SC2qOuEEICZ7N9w7CDp
 PiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726131288; x=1726736088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mBSJVqiSjBgt9wSTZXLa8QxNkqxXGP4AzKiQFPakxCc=;
 b=GpTq+sMGJQCaOD7lnA6c4d56NMKpDkQKabYwrCgJWQbJew3OhZahYQ0kRrIMexcRUt
 MEgP3IC7iYYjueCa3Ds4fA2rjk1ftJQy7A23fBIwVVox4FDZNhq/K2Dragwi/0c2YCbk
 qoFDyxvVu8TWS5Jx6/6lw6iMQvfo/6Zx3ytPegyFvw4LVPLnHFzUKuhr+xZtJFkjhvO/
 eJuW61Q5Z1Uu8UbpmGNSYaqxkIwYK80hlq7MFD/Hm9kqIoTj8D8V3R+g41ueDhtjjl/J
 8T+4gLz3QKPajZY4ot93vhTspsPd0YPKJ+tV/VUWyd1nWdex0maHb5P2KU1geNrwIwUp
 iNPQ==
X-Gm-Message-State: AOJu0YwclXSyBcb2/hCIjg4A03miq7kSkfUbPiNAJIQ6fzlv3TtG9ksq
 hQpfeBXyMEuhCBVCHz3aCuqHk9tzow5HD0psT3oRMQOp+4anhHHndUA0ag==
X-Google-Smtp-Source: AGHT+IGHAVMvlCh9OLjQVGVOc6MXuq4MY38zC5O0GhGFA7wOidBtGAs5BEtDNcneFCrvK+d9Ag4/MQ==
X-Received: by 2002:a17:902:db03:b0:206:bdb7:7637 with SMTP id
 d9443c01a7336-2076e3eaba3mr33280385ad.48.1726131288092; 
 Thu, 12 Sep 2024 01:54:48 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9ea2sm10629265ad.233.2024.09.12.01.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:54:47 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH] mtd: spi-nor-ids: Add support for S28HS256T
Date: Thu, 12 Sep 2024 17:54:27 +0900
Message-Id: <20240912085427.14636-1-Takahiro.Kuwano@infineon.com>
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
Resent after adding R-b and Lin tags

Tested on Xilinx Zynq-7000 board and Infineon internal SPI controller.
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e7e89eb65..b1e3a08089 100644
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

