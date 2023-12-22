Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EF4C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C99787809;
	Fri, 22 Dec 2023 06:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FENheEgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6245C86E7E; Fri, 22 Dec 2023 06:46:55 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21C18780E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d2e6e14865so10878445ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703224011; x=1703828811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+Um5VElaZeOGq0JNCRGIkrEoJrlBXk/NuDKnXCNh7k=;
 b=FENheEgG7OEIrVaGfxbQGr+vzwfXn8xU2Z1fGeh8gnCK1UxLU++BIiwgRuRS43eaS/
 OlrMT2PbQNo7RPsYh9SR+CCUlnIZUM0xZPAsvKadukIPMazV8gTtwyBeVrK7PeKBk2zH
 SqeJ6MnohLVXeRyEThBObxvbH6LR9ZISHZpSqG33g7wtHsLHT8TebHo0cvvzwWdK/OeK
 174DmPnQgC4PRScA+HW3SH8AoERzCmFnTGR3EXuMeuZv6jgT0vsfg13A6SxEY8rZuEFO
 nCLVDrsVsBBZaYYsRuC6yf8HlhdeiKQy9RUZEcT8bdXsZPwIh1nND5turaq0Xh5lO6XU
 W5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703224011; x=1703828811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+Um5VElaZeOGq0JNCRGIkrEoJrlBXk/NuDKnXCNh7k=;
 b=FVwDR37P7kRhyKZsbR1DLVDlsxg8V3n8E5daSqgii9XjXhqeyhLJIUoZoSBiPan6vM
 OsGdW2L1s1kxcEQY34D5gVwHC9aSFeUlkKgu7rT319iOMdIfYwV4ez+oi1PHnNSkcGni
 xUM3hF/QmXhDyI4cE9neOhgcD37W5j72bu5vQarIMpP6V0TcJ4UIgvYCg6OLTIKqL398
 Z6S+cbv4eFb1BCpL1QCYpYObQFt/i3QHYNk5i7BI12xS+kWKoOXvqoP7WJZP8vgfBfLN
 WjKoiEW0sium75BSW5+P2UCqKGzVuqps1YLcMpwODu1lP3Uag4iRXR/Z5vkIS1lM6m6o
 ltcg==
X-Gm-Message-State: AOJu0YyY9ju9AnbykGpUip0glOFK/bOS7Z9/ITAaIqKVXOoxccv6QGXG
 NfRkxgkuq3Hco8+9ih0O3eoo+Jtkz+s=
X-Google-Smtp-Source: AGHT+IGu2b+HRtum9EP9EOWYmvWyuexvWDIHOHFvRHWrbImih/CU6Y7Sgcqpmw9oabbWLUgnVK7AcQ==
X-Received: by 2002:a17:902:684a:b0:1d3:ef33:d0ae with SMTP id
 f10-20020a170902684a00b001d3ef33d0aemr508293pln.114.1703224011125; 
 Thu, 21 Dec 2023 21:46:51 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:46:50 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 6/9] mtd: spi-nor-core: Consolidate setup() hook for
 Infineon(Cypress) S25 and S28
Date: Fri, 22 Dec 2023 14:46:03 +0900
Message-Id: <b7d1dc1da81c1c291b8f6ddb7ac90f2982f00caa.1703220284.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
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

s28hx_t_setup() only checks sector layout setting. To support multi-die
package parts like S28HS02GT, it needs to check device size and assign
ready() hook for multi-die package parts. These are covered in s25_setup()
so we can consolidate s28hx_t_setup() and s25_setup() into one named
s25_s28_setup().

spi_nor_wait_till_ready() at the beginning of s28hx_t_setup() can be
removed since there is no op that makes device busy state before setup.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 41 ++++------------------------------
 1 file changed, 4 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index fe5579db4d..0bc43d3d21 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3375,8 +3375,8 @@ static int s25_s28_erase_non_uniform(struct spi_nor *nor, loff_t addr)
 					  SZ_128K);
 }
 
-static int s25_setup(struct spi_nor *nor, const struct flash_info *info,
-		     const struct spi_nor_flash_parameter *params)
+static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
+			 const struct spi_nor_flash_parameter *params)
 {
 	int ret;
 	u8 cr;
@@ -3423,7 +3423,7 @@ static int s25_setup(struct spi_nor *nor, const struct flash_info *info,
 
 static void s25_default_init(struct spi_nor *nor)
 {
-	nor->setup = s25_setup;
+	nor->setup = s25_s28_setup;
 }
 
 static int s25_post_bfpt_fixup(struct spi_nor *nor,
@@ -3582,43 +3582,10 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static int s28hx_t_setup(struct spi_nor *nor, const struct flash_info *info,
-			 const struct spi_nor_flash_parameter *params)
-{
-	struct spi_mem_op op;
-	u8 buf;
-	u8 addr_width = 3;
-	int ret;
-
-	ret = spi_nor_wait_till_ready(nor);
-	if (ret)
-		return ret;
-
-	/*
-	 * Check CFR3V to check if non-uniform sector mode is selected. If it
-	 * is, set the erase hook to the non-uniform erase procedure.
-	 */
-	op = (struct spi_mem_op)
-		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
-			   SPI_MEM_OP_ADDR(addr_width,
-					   SPINOR_REG_CYPRESS_CFR3V, 1),
-			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_IN(1, &buf, 1));
-
-	ret = spi_mem_exec_op(nor->spi, &op);
-	if (ret)
-		return ret;
-
-	if (!(buf & SPINOR_REG_CYPRESS_CFR3_UNISECT))
-		nor->erase = s25_s28_erase_non_uniform;
-
-	return spi_nor_default_setup(nor, info, params);
-}
-
 static void s28hx_t_default_init(struct spi_nor *nor)
 {
 	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
-	nor->setup = s28hx_t_setup;
+	nor->setup = s25_s28_setup;
 }
 
 static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
-- 
2.34.1

