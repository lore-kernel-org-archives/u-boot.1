Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E2DC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB681877D5;
	Fri, 22 Dec 2023 06:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G2CFIyDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F4F877C8; Fri, 22 Dec 2023 06:46:38 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC2BE86E7E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3eabe9321so10466275ad.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703223994; x=1703828794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ib4vJPyjcl9CBr6/cZpeTTYTztRSS6v16gBkPKkjnmk=;
 b=G2CFIyDkJrrhhORBcX2o4ruc/yS4k0ZVJz44N2a8Lcdz+fVZ8yn3T3oX+pA5LScQ5p
 8Ab3ET5Kh97ukXm6R8PvVf/FnsIXuuG4S4yFIr0da9R97zJNReNm5S8SCwZsZ6pMQPaE
 KUapStjKwXCIucU+CiSOdD3pCR1T2whaIHP8mcwHBdhi3gP9u2IryIentgNeWnDLAMCa
 RFEImOQpx7yjOJQguathUKLC4+qE39DeyKXbZMFmcm1h0G86kuFVdrzFAMd4CNxzK9kq
 oClg8JVU4rd2htpCV88y5WTZCii2sBuA1LYSJ8ripNzktb6/m+3+G6+G3IWXUdZGdeUf
 rH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703223994; x=1703828794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ib4vJPyjcl9CBr6/cZpeTTYTztRSS6v16gBkPKkjnmk=;
 b=VuNEsQlCzN7bCjCuD/RsNwNTA7ETCqJ4mmav+3y38Q0p8x+9n6tn7OBTmTpJdwykEn
 LybTPdMT2TS7ePqfNkZps2GGGAjijRWWyvZL+YyWS7wIIGFacMTc/2ohF9235ggduQiw
 06WnxyQGRmkZWfrgfO51yvTG1OwrSU7CXKwtu9wQiIUs44yEI08Cap7j3rYfPKiYNJCw
 yaEkFuevZUb4LJZQudaorhVJpx05XSVqaLyU0QVjkykuuuaECuhtaieMXIkhkJS+mvs2
 AwG8QM/fqXkwYFIn+3kz34cjTOAPqtKfsyT3of/bepGK0ScgeBk1NEX7dnDAgU32L9Cc
 3RrA==
X-Gm-Message-State: AOJu0YyKvFwsvc3f1I+p4eRJf6HJpxvbOABQCzs/sl8jSsHKBLxCGMlp
 cHU4Ap5yaKJvbLaPwYpFpsgHtndm/dM=
X-Google-Smtp-Source: AGHT+IGdVlOF5GJH6L/j/XYUU1nqRfqJCxTYMAvf5lgoDo5jxHU/XZFQu0BNbJHDHNoBsYHlqR0FrA==
X-Received: by 2002:a17:902:e547:b0:1d3:ef7a:4140 with SMTP id
 n7-20020a170902e54700b001d3ef7a4140mr604007plf.104.1703223993974; 
 Thu, 21 Dec 2023 21:46:33 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:46:33 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 1/9] mtd: spi-nor-core: Clean up macros for
 Infineon(Cypress) S25 and S28
Date: Fri, 22 Dec 2023 14:45:58 +0900
Message-Id: <c8c0d5bab3cbdf3afe3fe964cc76ad5cc365188f.1703220284.git.Takahiro.Kuwano@infineon.com>
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

Some macro definitions used in Infineon(Cypress) S25 and S28 series are
redundant and some have inconsistent prefix. This patch removes
redundant ones and renames some to have same prefix as others.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 26 ++++++++++++++------------
 include/linux/mtd/spi-nor.h    | 11 +++--------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 9a1801ba93..a2ef65cf6f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -331,7 +331,7 @@ static int spansion_read_any_reg(struct spi_nor *nor, u32 addr, u8 dummy,
 				 u8 *val)
 {
 	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDAR, 1),
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
 			   SPI_MEM_OP_ADDR(nor->addr_mode_nbytes, addr, 1),
 			   SPI_MEM_OP_DUMMY(dummy / 8, 1),
 			   SPI_MEM_OP_DATA_IN(1, NULL, 1));
@@ -342,7 +342,7 @@ static int spansion_read_any_reg(struct spi_nor *nor, u32 addr, u8 dummy,
 static int spansion_write_any_reg(struct spi_nor *nor, u32 addr, u8 val)
 {
 	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRAR, 1),
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
 			   SPI_MEM_OP_ADDR(nor->addr_mode_nbytes, addr, 1),
 			   SPI_MEM_OP_NO_DUMMY,
 			   SPI_MEM_OP_DATA_OUT(1, NULL, 1));
@@ -714,7 +714,7 @@ static int set_4byte(struct spi_nor *nor, const struct flash_info *info,
  */
 static int spansion_sr_ready(struct spi_nor *nor, u32 addr_base, u8 dummy)
 {
-	u32 reg_addr = addr_base + SPINOR_REG_ADDR_STR1V;
+	u32 reg_addr = addr_base + SPINOR_REG_CYPRESS_STR1V;
 	u8 sr;
 	int ret;
 
@@ -1856,7 +1856,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
 static int spansion_quad_enable_volatile(struct spi_nor *nor, u32 addr_base,
 					 u8 dummy)
 {
-	u32 addr = addr_base + SPINOR_REG_ADDR_CFR1V;
+	u32 addr = addr_base + SPINOR_REG_CYPRESS_CFR1V;
 
 	u8 cr;
 	int ret;
@@ -3263,11 +3263,11 @@ static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
 	 * Read CR3V to check if uniform sector is selected. If not, assign an
 	 * erase hook that supports non-uniform erase.
 	 */
-	ret = spansion_read_any_reg(nor, SPINOR_REG_ADDR_CFR3V,
+	ret = spansion_read_any_reg(nor, SPINOR_REG_CYPRESS_CFR3V,
 				    S25FS_S_RDAR_DUMMY, &cfr3v);
 	if (ret)
 		return ret;
-	if (!(cfr3v & CFR3V_UNHYSA))
+	if (!(cfr3v & SPINOR_REG_CYPRESS_CFR3_UNISECT))
 		nor->erase = s25fs_s_erase_non_uniform;
 
 	return spi_nor_default_setup(nor, info, params);
@@ -3366,7 +3366,8 @@ static int s25_setup(struct spi_nor *nor, const struct flash_info *info,
 	 * uniform 128KB only due to complexity of non-uniform layout.
 	 */
 	if (nor->info->id[4] == S25FS256T_ID4) {
-		ret = spansion_read_any_reg(nor, SPINOR_REG_ADDR_ARCFN, 8, &cr);
+		ret = spansion_read_any_reg(nor, SPINOR_REG_CYPRESS_ARCFN, 8,
+					    &cr);
 		if (ret)
 			return ret;
 
@@ -3380,10 +3381,10 @@ static int s25_setup(struct spi_nor *nor, const struct flash_info *info,
 	 * Read CFR3V to check if uniform sector is selected. If not, assign an
 	 * erase hook that supports non-uniform erase.
 	 */
-	ret = spansion_read_any_reg(nor, SPINOR_REG_ADDR_CFR3V, 0, &cr);
+	ret = spansion_read_any_reg(nor, SPINOR_REG_CYPRESS_CFR3V, 0, &cr);
 	if (ret)
 		return ret;
-	if (!(cr & CFR3V_UNHYSA))
+	if (!(cr & SPINOR_REG_CYPRESS_CFR3_UNISECT))
 		nor->erase = s25_erase_non_uniform;
 
 	/*
@@ -3444,12 +3445,13 @@ static int s25_post_bfpt_fixup(struct spi_nor *nor,
 	 * dies are configured to 512B buffer.
 	 */
 	for (addr = 0; addr < params->size; addr += SZ_128M) {
-		ret = spansion_read_any_reg(nor, addr + SPINOR_REG_ADDR_CFR3V,
-					    0, &cfr3v);
+		ret = spansion_read_any_reg(nor,
+					    addr + SPINOR_REG_CYPRESS_CFR3V, 0,
+					    &cfr3v);
 		if (ret)
 			return ret;
 
-		if (!(cfr3v & CFR3V_PGMBUF)) {
+		if (!(cfr3v & SPINOR_REG_CYPRESS_CFR3_PGSZ)) {
 			params->page_size = 256;
 			return 0;
 		}
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 2861b73edb..f9a55c8e74 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -136,14 +136,6 @@
 #define SPINOR_OP_BRRD		0x16	/* Bank register read */
 #define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
 #define SPINOR_OP_EX4B_CYPRESS	0xB8	/* Exit 4-byte mode */
-#define SPINOR_OP_RDAR		0x65	/* Read any register */
-#define SPINOR_OP_WRAR		0x71	/* Write any register */
-#define SPINOR_REG_ADDR_STR1V	0x00800000
-#define SPINOR_REG_ADDR_CFR1V	0x00800002
-#define SPINOR_REG_ADDR_CFR3V	0x00800004
-#define SPINOR_REG_ADDR_ARCFN	0x00000006
-#define CFR3V_UNHYSA		BIT(3)	/* Uniform sectors or not */
-#define CFR3V_PGMBUF		BIT(4)	/* Program buffer size */
 
 /* Used for Micron flashes only. */
 #define SPINOR_OP_RD_EVCR	0x65	/* Read EVCR register */
@@ -189,6 +181,9 @@
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
 #define SPINOR_OP_S28_SE_4K			0x21
+#define SPINOR_REG_CYPRESS_ARCFN		0x00000006
+#define SPINOR_REG_CYPRESS_STR1V		0x00800000
+#define SPINOR_REG_CYPRESS_CFR1V		0x00800002
 #define SPINOR_REG_CYPRESS_CFR2V		0x00800003
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
 #define SPINOR_REG_CYPRESS_CFR3V		0x00800004
-- 
2.34.1

