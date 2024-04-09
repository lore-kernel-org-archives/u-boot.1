Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CF1CD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 06:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFD688180;
	Tue,  9 Apr 2024 08:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hzh+AUbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 958948815E; Tue,  9 Apr 2024 08:20:47 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8F088180
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 08:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e4149e7695so13562295ad.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712643644; x=1713248444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hw/oFPldScZAVj6AYEeIoMGpd+HuVKjvglewlj+gQwE=;
 b=Hzh+AUbOUyyohG4i6ZJVdxvHwr1Q+cBWmDcsDRSKeMGzs9t7bwTIeQkKBJ2TkyRMrs
 NAmW/8jjDKW1V1EPhYCDdzIzt336UZFmVu/rXeBbmueklBcKFYqQT785R/yKBkDgMo8a
 GiX3Kta2xNwPPHhrwYYSyHsQV350SVuvrnuHkMbpVA55BtwedHrB5MdsPUMx/y1YC6Pn
 DnATc7rn/Co9fkazCja5AcZOTRBqpzpnHVfwtoaHfOplsgHxp9rxb8FXLjPTbjpDkn9H
 ibfUykuPSgp/3tVNROpcVGZu5H32nJF2GoToGejISI1YrsELZu+CPqD3sJ9wlZ0WfWPj
 3lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712643644; x=1713248444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hw/oFPldScZAVj6AYEeIoMGpd+HuVKjvglewlj+gQwE=;
 b=SwDVMgX15kBrKssoKxUfX4n/GTXkFed7l8u7OKo7nnndQKReWKkJo/dDqOkxRsnc93
 5cXzxG6av5TSR7vRI+hsacUX4l+PK4fRKOYci/bzRNwnxn20kHEOoHEGvndZtlZ9Ry9U
 0HSFDMtJTkJg/oi/bsS+Pg2MJqLZSSL8ySQE7D+tINQyNq7qhU9yTdFUnIE5zsOqTvkJ
 hrQeQCbc6y5kGe6dJdn5XCd92AhSO94LSApuBrnqoJuTN7EYsdYOhBNpPvDAop0DE3K0
 vN197O+DPbel50TdRQziRWUkL7jIW7FxTaKlmwkAIvQMecs6jHKZ2CDMgsJIClP92GXD
 +lcA==
X-Gm-Message-State: AOJu0Yyb24veHSp/i0BfyHbliJaIV7Yh6rrBQWDao/FKkorf5XLG9GMc
 U9za+NbTJ46iRoeH0o+CLxk9C1nCEDFndmRZGWiwC6AItoLvSHSnTPQfhCoJ
X-Google-Smtp-Source: AGHT+IEMOqSVa5VPwJZpwYyEmtYPwnsDLZkY78yYxHo7QxRgQmNz8IZTHuFqrRAP648L0D7v2Jf9dQ==
X-Received: by 2002:a17:902:ef93:b0:1e0:a3dd:82df with SMTP id
 iz19-20020a170902ef9300b001e0a3dd82dfmr8337879plb.38.1712643643963; 
 Mon, 08 Apr 2024 23:20:43 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 x3-20020a1709029a4300b001db5fc51d71sm8037985plv.160.2024.04.08.23.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 23:20:43 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 2/3] mtd: spi-nor-id: Use INFO6 macro for S25FL-S
Date: Tue,  9 Apr 2024 15:20:21 +0900
Message-Id: <a988761256bdfd8a55a009d127b8b44b3f9aac92.1712638210.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
References: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
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

The 6th ID byte is needed to distiguish S25FL-S and S25FS-S families.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e83b8c94c..a3dca506a3 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -338,8 +338,8 @@ const struct flash_info spi_nor_ids[] = {
 	 */
 	{ INFO("s25sl032p",  0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("s25sl064p",  0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("s25fl256s0", 0x010219, 0x4d00, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-	{ INFO("s25fl256s1", 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fl256s0", 0x010219, 0x4d0080, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fl256s1", 0x010219, 0x4d0180,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO6("s25fl512s",  0x010220, 0x4d0080, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO6("s25fs512s",  0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25fl512s_256k",  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-- 
2.34.1

