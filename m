Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBCDC52D73
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 06:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886C288A5C;
	Thu,  8 Aug 2024 08:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KZOP+SJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9453688A45; Thu,  8 Aug 2024 08:00:33 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A85B87E96
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 08:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-81f9339e52cso24916739f.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 23:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723096830; x=1723701630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaqqG5c25UsnSD6mtm2dddGxUuQvJ5Z2uT0GMzKQhIQ=;
 b=KZOP+SJvS2LXds1T2U50Vp7k/C91mnDbuoRoSwOQptyA+6Hy5ZNzCsFYgOWLXuQhBf
 AmgfnxAQBYw9ctwa6ZOks7ri/12pJSyA3MThOWUnx4V31IuHBA26JR9JsB5g7U8Izpc0
 PTiQ0iiJetK+fJ5ong/K//kO4CIQZMMHPZNMm0Gx0o1B1N8XD80i7O8cTtCAd1UWCr/K
 s50Nz/YC3O63CticAN42kJHHA6hg8B5C9jNhPGOutdl+ODcrOuHKLAkRfvL5hH9wLf38
 4yo6PASZ1Bbkg9oDYJWcuY1rfDw5uWELkKbB2/b0m6Nf1Qgd4GQf0ZhfVZlAKm1HYsmp
 gyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723096830; x=1723701630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaqqG5c25UsnSD6mtm2dddGxUuQvJ5Z2uT0GMzKQhIQ=;
 b=ho/FO42KzRJee8hz0fjlr1Dn6/HPkq3kvw9SkWuF6gIXBa/DoSbX+QSd4TjOY8nGAT
 fNpVQITZ/jRMXjlSWGxs98b1UY/oMsyFvMG63XbFo9Aq6AlHlUJF9olhR5BiZVelhY/E
 H5Inalgr2UsOpS+cFpvWWx9S7SnZBSX96qKFd0Tp2hxd5H8IzHEdCkO2c6VDDbOL79Lq
 vBAi7mAxOihhYZj+Onncb66xQHc0d8WMkH/S7uKH5UOW1cP41NdQ0xsBRh7eVjCMlbvh
 ZoZkQEycTm6IRYk8LY1I7atBLz7hKjTRGD3reM/KnhfyvSS5EITb/RbIAzUY7C5R9Pbk
 NSDQ==
X-Gm-Message-State: AOJu0YyTXh/Bc6xzjRLN8EQepFl55P6vSTJ8/gD4S2tQUDlQKIESUbJH
 3gh+y2N8Zubxvqo2jh/5735swzISa+Me4LfrYJ/NrOM15fdjgux8hncOrQ==
X-Google-Smtp-Source: AGHT+IHSgqwibsWaYa0VU9faVeAjF/sjtdaY20nHL2xcu2k0ED/GSNmnGpex8t/aswgi3V1iN3lMzQ==
X-Received: by 2002:a05:6e02:4b0:b0:397:d503:6216 with SMTP id
 e9e14a558f8ab-39b5ed39937mr7389245ab.25.1723096829947; 
 Wed, 07 Aug 2024 23:00:29 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b7653b4d99sm7819055a12.84.2024.08.07.23.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 23:00:29 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 mwalle@kernel.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 2/4] mtd: spi-nor: Set the 4-Byte Address Mode method based on
 SFDP data
Date: Thu,  8 Aug 2024 15:00:08 +0900
Message-Id: <6867284bf369280409cc1792b67ac37388dff9a1.1722917617.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
References: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
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

This patch partially ports the Linux commit:
4e53ab0c292d ("mtd: spi-nor: Set the 4-Byte Address Mode method based on
               SFDP data")

BFPT[DWORD(16)] defines the methods to enter and exit the 4-Byte Address
Mode. Parse BFPT to determine the method. Will rename the methods with
generic names in a further patch, to keep things trackable in this one.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 40 +++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index d523c045f4..54fd2869a2 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -96,6 +96,7 @@ struct sfdp_header {
  */
 #define BFPT_DWORD(i)		((i) - 1)
 #define BFPT_DWORD_MAX		20
+#define BFPT_MASK_CHECK(dword, mask)		(((dword) & (mask)) == (mask))
 
 /* The first version of JESB216 defined only 9 DWORDs. */
 #define BFPT_DWORD_MAX_JESD216			9
@@ -161,6 +162,32 @@ struct sfdp_header {
 #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
 #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
 
+#define BFPT_DWORD16_EN4B_MASK			GENMASK(31, 24)
+#define BFPT_DWORD16_EN4B_ALWAYS_4B		BIT(30)
+#define BFPT_DWORD16_EN4B_4B_OPCODES		BIT(29)
+#define BFPT_DWORD16_EN4B_16BIT_NV_CR		BIT(28)
+#define BFPT_DWORD16_EN4B_BRWR			BIT(27)
+#define BFPT_DWORD16_EN4B_WREAR			BIT(26)
+#define BFPT_DWORD16_EN4B_WREN_EN4B		BIT(25)
+#define BFPT_DWORD16_EN4B_EN4B			BIT(24)
+#define BFPT_DWORD16_EX4B_MASK			GENMASK(18, 14)
+#define BFPT_DWORD16_EX4B_16BIT_NV_CR		BIT(18)
+#define BFPT_DWORD16_EX4B_BRWR			BIT(17)
+#define BFPT_DWORD16_EX4B_WREAR			BIT(16)
+#define BFPT_DWORD16_EX4B_WREN_EX4B		BIT(15)
+#define BFPT_DWORD16_EX4B_EX4B			BIT(14)
+#define BFPT_DWORD16_4B_ADDR_MODE_MASK			\
+	(BFPT_DWORD16_EN4B_MASK | BFPT_DWORD16_EX4B_MASK)
+#define BFPT_DWORD16_4B_ADDR_MODE_16BIT_NV_CR		\
+	(BFPT_DWORD16_EN4B_16BIT_NV_CR | BFPT_DWORD16_EX4B_16BIT_NV_CR)
+#define BFPT_DWORD16_4B_ADDR_MODE_BRWR			\
+	(BFPT_DWORD16_EN4B_BRWR | BFPT_DWORD16_EX4B_BRWR)
+#define BFPT_DWORD16_4B_ADDR_MODE_WREAR			\
+	(BFPT_DWORD16_EN4B_WREAR | BFPT_DWORD16_EX4B_WREAR)
+#define BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B	\
+	(BFPT_DWORD16_EN4B_WREN_EN4B | BFPT_DWORD16_EX4B_WREN_EX4B)
+#define BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B		\
+	(BFPT_DWORD16_EN4B_EN4B | BFPT_DWORD16_EX4B_EX4B)
 #define BFPT_DWORD16_SOFT_RST			BIT(12)
 #define BFPT_DWORD16_EX4B_PWRCYC		BIT(21)
 
@@ -2372,7 +2399,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	struct sfdp_bfpt bfpt;
 	size_t len;
 	int i, cmd, err;
-	u32 addr;
+	u32 addr, dword;
 	u16 half;
 
 	/* JESD216 Basic Flash Parameter Table length is at least 9 DWORDs. */
@@ -2510,6 +2537,17 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		break;
 	}
 
+	/* 4-byte address mode entry */
+	dword = bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_4B_ADDR_MODE_MASK;
+	if (BFPT_MASK_CHECK(dword, BFPT_DWORD16_4B_ADDR_MODE_BRWR))
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
+	else if (BFPT_MASK_CHECK(dword, BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B))
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
+	else if (BFPT_MASK_CHECK(dword, BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B))
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+	else
+		dev_dbg(nor->dev, "BFPT: 4-Byte Address Mode method is not recognized or not implemented\n");
+
 	/* Soft Reset support. */
 	if (bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_SOFT_RST)
 		nor->flags |= SNOR_F_SOFT_RESET;
-- 
2.34.1

