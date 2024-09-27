Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118DDCEBF66
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D28888FF1;
	Fri, 27 Sep 2024 03:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A7A9WgMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AEE089043; Fri, 27 Sep 2024 03:24:30 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F39188F89
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo2062739a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727400266; x=1728005066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uf9RUtl/Tr0OPTBTIBzO9rddMoHtyO/6Fqh0WfoqxtQ=;
 b=A7A9WgMoDSr5Ro68molCyHS8HsSQlgq7gyQCamYsFSBEsfZCJ48t0Ks8fi2e0ND6Q2
 1T8qbZmiiriK9zDLBs2E6FDZWQmzbwnRVpukj0asYeu7pqQfoDysqxywWanPwzQSW51Z
 Q2CMfpZhBY0QtxmQHnD7shADnFRh558ui4MwB3uLl53a/Knv+P75bQ7lUXtqZGQgPayG
 2JPlbaDC6hiPtA9C7RSwdYgdaxYFosxy5uNLrf0qX/sqLw6P7u/pcm766prY3Io78ZBu
 swxsn8VnmshsAfuG7iELg8WL/0KHNUD7ZTxioaqMspxzns039/zX08mtkk/c2S9pRYra
 qFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727400266; x=1728005066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uf9RUtl/Tr0OPTBTIBzO9rddMoHtyO/6Fqh0WfoqxtQ=;
 b=dLwtRkPMb43S2ui4x7Xo5u4Y2n1LKAsFIO9Ck5pegk1AqapfCesh0Ey3qaPpwYlz+d
 l+HA6gZu4un16/jx0g+Y9pIeKFqkG0eEWZ9kckh1Cqu0Lu97zCQ2StcY7pKB+kILbd1s
 bCGGpRCFatR3UYN7PbNy93LlZcMh7zoM1uMuoY1SRm35BeFA5pTJ+UtBnN4h4sNJ7SrG
 gUfOY003X1iNdEcHqkBIlZfYEyYG35Yhnvk3R+oSS+4Iees6CKy1bYye+itPz9crsdOh
 kyMF/poSK8m6zXgeLjWuscYSUodkJhlLQmi+7bV7GB8K2XTWMu/Gb3v5TnWrHiPCfMd7
 nwDA==
X-Gm-Message-State: AOJu0Ywn0FOxZaXl5sVDkOhKQS3I51HEiPekbWVLr7BBS8EiZ0jtz89D
 dVHsg9F2rc4kwnda8JDV08oee5fsFptQCX3/5qy9guf5LAcCenfK2oc/Ww==
X-Google-Smtp-Source: AGHT+IFDF8Fg5w9yqDO5lzvjCCAd+IbjoD1cyebuXk/r92m2ZCiSd5JNbJjN3JgXH3GWBs2X7LeATA==
X-Received: by 2002:a05:6a20:6f9c:b0:1cf:4ed:ffc0 with SMTP id
 adf61e73a8af0-1d4fa1b8417mr3172177637.4.1727400266524; 
 Thu, 26 Sep 2024 18:24:26 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652e609sm516341b3a.182.2024.09.26.18.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:24:26 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 1/2] mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to
 Infineon s25hl02Gt and s25hs02gt
Date: Fri, 27 Sep 2024 10:24:15 +0900
Message-Id: <e53926f0a392413244fad554389c4bcec3f783a3.1727400131.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727400131.git.Takahiro.Kuwano@infineon.com>
References: <cover.1727400131.git.Takahiro.Kuwano@infineon.com>
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

S25HL02GT and S25HS02GT are dual-die package parts and do not support
chip erase.

Fixes: c95a914aed7 ("mtd: spi-nor-ids: Add Cypress s25hl-t/s25hs-t")
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 9693c179b7e..3270ebb533c 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -372,7 +372,7 @@ const struct flash_info spi_nor_ids[] = {
 		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
 		USE_CLSR) },
 	{ INFO6("s25hl02gt",  0x342a1c, 0x0f0090, 256 * 1024, 1024,
-		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 	{ INFO6("s25hs512t",  0x342b1a, 0x0f0390, 256 * 1024, 256,
 		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
 		USE_CLSR) },
@@ -380,7 +380,7 @@ const struct flash_info spi_nor_ids[] = {
 		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
 		USE_CLSR) },
 	{ INFO6("s25hs02gt",  0x342b1c, 0x0f0090, 256 * 1024, 1024,
-		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 	{ INFO6("s25fs256t",  0x342b19, 0x0f0890, 128 * 1024, 256,
 		SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #ifdef CONFIG_SPI_FLASH_S28HX_T
-- 
2.34.1

