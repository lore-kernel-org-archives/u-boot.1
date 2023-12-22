Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2894BC46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C122F8781B;
	Fri, 22 Dec 2023 06:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VNJhUiou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5DF86E7E; Fri, 22 Dec 2023 06:46:58 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 446648781B
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d3e6c86868so12565905ad.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703224014; x=1703828814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7WZ1iWxbxTriUGaEkBCAsqJd5Y/UcsAdo0qpC0gB3w=;
 b=VNJhUiouCGoyv80xbsyixxScgAy9ZHOnA8HGtW69i/2rQLk3/iHmwj2ZSQg/46CChO
 2eCuLU2Cg1q7nVrf2abNsmP3rYXMa2PBw2oTLT9lJ0Qir79FR/resC8lJaAHGkVAPGWZ
 RO5WSavMyti8mp1QI9vWWuRVRfZKov7QEy+efxUI0ih45co1/L90+3cpmaQE9rlkpWdv
 lBoigTVQh9YSXYm/0kwvgVfMLYk5HRhdHaGdDgYgiU2xpcq6SndIsYZSU6NgN/7vZahp
 PIYWMTORj//UTsux0Xzp2loIBjyCDKp5Qx10Sw9iDpU88Mxi+Xy0iMZlYZenc3UNfM9e
 G6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703224014; x=1703828814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7WZ1iWxbxTriUGaEkBCAsqJd5Y/UcsAdo0qpC0gB3w=;
 b=k5WvxHsJip6gWzL1Wah8mLptBycdoK8ypsQeg26YvqxXPhwG6mZKY1VredL0RkRWWN
 t77jr4WJZL12M7Bjr9LUvshOL+MnmGxOw98Xl0hD3WZQkbY32AOoDKLe4uAcUZfulOUy
 MGhfQDH3nQDLF9n7nE3zuWBL1AoJv6YDu4TcxjHh9YstrvB7E2GaDCELmzHiemw10SkP
 TxUT15eBAjs5/nKR4OA5WNj5mnRi9Cce/+aa/z0PbksqPwEdzP/ojFMyq4h8lJ+PEuW3
 QXNXAV0S9KHyJQyEOdCUOrKmVAj4tm8Z9Q6xHMJQMtIFk/wtgcGFKt7m6bwWMEaF134Y
 xe0g==
X-Gm-Message-State: AOJu0YxYzCI+OjxlbchxzDfKqzX6OqX96D49jwlxn/X8ku+LWdb1cC45
 m1LIBe+lj6V4gDI2qv8R2aPSY1FtKDY=
X-Google-Smtp-Source: AGHT+IHyUpPTqII7TcTSCuhDBhhrQwUjM96g1/XZ6QlmAgEH/iaBPBAClEwZ6urCktMeffDGoimvDQ==
X-Received: by 2002:a17:902:da91:b0:1d0:737d:2ae5 with SMTP id
 j17-20020a170902da9100b001d0737d2ae5mr782466plx.87.1703224014649; 
 Thu, 21 Dec 2023 21:46:54 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:46:54 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 7/9] mtd: spi-nor-core: Consolidate post_bfpt_fixup() for
 Infineon(Cypress) S25 and S28
Date: Fri, 22 Dec 2023 14:46:04 +0900
Message-Id: <4a6603f5d4221788f27b21f2de9ede6728b082cc.1703220284.git.Takahiro.Kuwano@infineon.com>
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

s28hx_t_post_bfpt_fixup() fixes erase opcode, erase size, and page size.
s25_post_bfpt_fixup() is doing same thing including multi-die support.
We can consolidate s28hx_t_post_bfpt_fixup() and s25_post_bfpt_fixup()
into one named s25_s28_post_bfpt_fixup().

In s25_s28_post_bfpt_fixup(), set_4byte() is called to force the device to
be 4-byte addressing mode. In S28HS02GT datasheet, the B7 opcode is missing
but it works actually (confirmed).

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 52 ++++------------------------------
 1 file changed, 6 insertions(+), 46 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 0bc43d3d21..22b5999a87 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3426,10 +3426,10 @@ static void s25_default_init(struct spi_nor *nor)
 	nor->setup = s25_s28_setup;
 }
 
-static int s25_post_bfpt_fixup(struct spi_nor *nor,
-			       const struct sfdp_parameter_header *header,
-			       const struct sfdp_bfpt *bfpt,
-			       struct spi_nor_flash_parameter *params)
+static int s25_s28_post_bfpt_fixup(struct spi_nor *nor,
+				   const struct sfdp_parameter_header *header,
+				   const struct sfdp_bfpt *bfpt,
+				   struct spi_nor_flash_parameter *params)
 {
 	int ret;
 	u32 addr;
@@ -3503,7 +3503,7 @@ static void s25_post_sfdp_fixup(struct spi_nor *nor,
 
 static struct spi_nor_fixups s25_fixups = {
 	.default_init = s25_default_init,
-	.post_bfpt = s25_post_bfpt_fixup,
+	.post_bfpt = s25_s28_post_bfpt_fixup,
 	.post_sfdp = s25_post_sfdp_fixup,
 };
 
@@ -3619,50 +3619,10 @@ static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
 	params->rdsr_addr_nbytes = 4;
 }
 
-static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
-				   const struct sfdp_parameter_header *bfpt_header,
-				   const struct sfdp_bfpt *bfpt,
-				   struct spi_nor_flash_parameter *params)
-{
-	struct spi_mem_op op;
-	u8 buf;
-	u8 addr_width = 3;
-	int ret;
-
-	/*
-	 * The BFPT table advertises a 512B page size but the page size is
-	 * actually configurable (with the default being 256B). Read from
-	 * CFR3V[4] and set the correct size.
-	 */
-	op = (struct spi_mem_op)
-		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
-			   SPI_MEM_OP_ADDR(addr_width, SPINOR_REG_CYPRESS_CFR3V, 1),
-			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_IN(1, &buf, 1));
-	ret = spi_mem_exec_op(nor->spi, &op);
-	if (ret)
-		return ret;
-
-	if (buf & SPINOR_REG_CYPRESS_CFR3_PGSZ)
-		params->page_size = 512;
-	else
-		params->page_size = 256;
-
-	/*
-	 * The BFPT advertises that it supports 4k erases, and the datasheet
-	 * says the same. But 4k erases did not work when testing. So, use 256k
-	 * erases for now.
-	 */
-	nor->erase_opcode = SPINOR_OP_SE_4B;
-	nor->mtd.erasesize = 0x40000;
-
-	return 0;
-}
-
 static struct spi_nor_fixups s28hx_t_fixups = {
 	.default_init = s28hx_t_default_init,
 	.post_sfdp = s28hx_t_post_sfdp_fixup,
-	.post_bfpt = s28hx_t_post_bfpt_fixup,
+	.post_bfpt = s25_s28_post_bfpt_fixup,
 };
 #endif /* CONFIG_SPI_FLASH_S28HX_T */
 
-- 
2.34.1

