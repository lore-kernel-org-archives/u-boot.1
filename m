Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9707ACEBF60
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D64B89036;
	Fri, 27 Sep 2024 03:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H1gLooyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE0C8901A; Fri, 27 Sep 2024 03:11:39 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6183E88F92
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7db54269325so1187543a12.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399496; x=1728004296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbMH9Vn5UEisbRohX7IXOJsetc/yDsrvw7QEfb4/Y64=;
 b=H1gLooyovV9GlktBYYe/OaceeAbuTOfqdsKS3Upe0jou8oBhHKRtI1IxDI6gjIBc5/
 yUaVegzgEfLRhv1HMwdNDANA6jh6v+Z7O+vlGTYOv0iFL+/1XuT62+HPEQzgYvgcOABK
 tfItYKnAu2YmwRHOQi9mCGv64Kf3igfi5xUkLijhmfHaGTu9TD980niZC3eBKFHyHMvq
 a2YrsfWI4UkkzCNCYVh1zj07dxhb+o6VOSKsUr1xwK1QXT0c+eodqQdFTcJBniwT3k1y
 EiK4gRKMglCFrDQyn/mt+cdYoCphVVEQIgsBAF66KFrP0Lbn+vG2m5k+Eov2Zxq4m2Ed
 I6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399496; x=1728004296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbMH9Vn5UEisbRohX7IXOJsetc/yDsrvw7QEfb4/Y64=;
 b=NfgnjbUjM48gpdluX43PQwO+OYc3/6ID+WmqihbmJK7I2Dclm66CNZy03st0AAw81A
 UnZX7kLoSICwJJVRc+wBdwsXHqzXEboAwG3CSCk+Mza8RvH4BOvZ4DV40ujoBeUVi2NB
 acWELB+xiK8Uk9w3CS6Sit6HufVHGf8rXReHLTSCka2TXBDmkSr027EUnxtYO2uktMpk
 YvGBLabEgVTlEbnRPajo+dWRA5PXBbTZGN9tS6l05RpSr7hdz3cXPs9fv0kFQy3GmLcz
 UB9MndeSWcjbDB2LHM2a+EuIjE9IHXJz4TmIxiAa0vyBduXeD08hHCyjAGHxHSp1NUo/
 UqBw==
X-Gm-Message-State: AOJu0YxVKLBLZm4+4zFtp3Xo0k59miCvY6xg/oxz1HVBszGqQ+zND0FK
 pN0Tp3yjUCOdwy+eWyfi+gse+hajSxHE71vG+4+eu7SytQOGeNewp/HBMw==
X-Google-Smtp-Source: AGHT+IHY81L/qkaVcxfi6Jz8xx36tzV/K67EoHWvsJTVcCUHrdAue8URjxKLMK/He+6h31HebYFJQQ==
X-Received: by 2002:a05:6a20:bc86:b0:1d4:fc11:baec with SMTP id
 adf61e73a8af0-1d4fc11bb32mr1411454637.2.1727399494474; 
 Thu, 26 Sep 2024 18:11:34 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b264d86bfsm524068b3a.95.2024.09.26.18.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:11:34 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Dhruva Gole <d-gole@ti.com>
Subject: [2nd RESEND PATCH v2 2/3] mtd: spi-nor-id: Use INFO6 macro for S25FL-S
Date: Fri, 27 Sep 2024 10:11:18 +0900
Message-Id: <340ebd9792c07e7e687ddfbb6b1236ef8d62eda2.1727399216.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727399216.git.Takahiro.Kuwano@infineon.com>
References: <cover.1727399216.git.Takahiro.Kuwano@infineon.com>
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
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 88709a52b3a..17e0f84e9ee 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -339,8 +339,8 @@ const struct flash_info spi_nor_ids[] = {
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

