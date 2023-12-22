Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFE5C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D508780A;
	Fri, 22 Dec 2023 06:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EcaEF+HZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0EE086E7E; Fri, 22 Dec 2023 06:47:02 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994FF8780C
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d04c097e34so11203555ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703224018; x=1703828818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWXaoQIfJHWbkQd4hppCnSfiINqfufOvvFDHeqra62M=;
 b=EcaEF+HZnR3f+rgPl0NBD4itIizTP4sG16m0AhN9M5FNA1WuFucZ2OqI6Dnc1/1qWF
 FKt6HSnclvHzyDJVJqVLY5DAL62AMDJhJRDt2O5ZI1pfAttG80c8Npm6nuyEVAA8SqH3
 mj4dFT6nywC0fYMTeLs4yg/rlyb/WZIACb3me2bsWDBxbzqdbl6C5zISr5HZArfBFg6E
 mEABrxaco8SDqqS6OQNQWbEUCFj+Fx/PV2zmQY0bYD0E5uKGd8VxfAL74a9bHGne+/aU
 si4ArxudKuJZvw4HWJUFRaxC8sxFmNUfNIUb+lio91Y0HShqqJfvhyx6RqFPbPscvwlg
 THJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703224018; x=1703828818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xWXaoQIfJHWbkQd4hppCnSfiINqfufOvvFDHeqra62M=;
 b=J8g1OC5vzrAgIuTXggimN6exvNpmY5jdtLu3NowRs9DfqIyLA40uLwvkEDppnaxttw
 pWFM6H8fns+Meqyo4ylRYIdmlRrKVKi4dq0Ox1FYET2FPa5D/5M1zYG9VGqjYTRIJeaj
 q1ES+j1ffWIG7a9volNq5XaGMWaDp/PczBf8oKR389TLebGQvAjUA6mOfMa7/6z4MkFd
 dIA9SYjNY8MM8XDJHnVfGrWYrombEJuiFBIuSPTIVJQbGw0msrRaMycD6i028pHdOGNV
 GcN2O0MADSmsC1faybOegrFQPrGkNEou1awYx+MnGu+YaheMqYBz3W2OpZI1M1IjA4V9
 6mXg==
X-Gm-Message-State: AOJu0YxaUWrmGEfU1VTc+Lkqv6UNb2G0yPx0mPsdMY9oOH10GkXOqd/q
 b8wmBVlcfnSZFOL+QbKyw4nGKBaU+gg=
X-Google-Smtp-Source: AGHT+IFpIuutzIB7mDrDxK87G80JXhRa0huH2KfR0ORUhGWacG1J9404LZnYUaXbwFXpOKU/a8UTIg==
X-Received: by 2002:a17:902:c7c3:b0:1d3:fee6:8b40 with SMTP id
 r3-20020a170902c7c300b001d3fee68b40mr1795152pla.43.1703224018026; 
 Thu, 21 Dec 2023 21:46:58 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:46:57 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 8/9] mtd: spi-nor-core: Rework
 spi_nor_cypress_octal_dtr_enable()
Date: Fri, 22 Dec 2023 14:46:05 +0900
Message-Id: <e75b7d07003573dbadcc26bb07b7665e5ece8e12.1703220284.git.Takahiro.Kuwano@infineon.com>
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

Enabling Octal DTR mode in multi-die package parts requires reister setup
for each die. That can be done by simple for-loop. write_enable() takes
effect to all die at once so we can call it before the loop. Besides we
can replace spi_mem_exec_op() calls with spansion_read/write_any_reg().
And finally, we must mask CFR2V[7:4] when changing dummy cycles, as
CFR2V[7] indicates current addressing mode and that should be 1 (4-byte
address mode) for multi-die package parts.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 54 +++++++++++++++++-----------------
 include/linux/mtd/spi-nor.h    |  1 +
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 22b5999a87..860b11fd95 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3535,48 +3535,48 @@ static struct spi_nor_fixups s25fl256l_fixups = {
  */
 static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor)
 {
-	struct spi_mem_op op;
+	u32 addr;
 	u8 buf;
-	u8 addr_width = 3;
 	int ret;
 
-	/* Use 24 dummy cycles for memory array reads. */
 	ret = write_enable(nor);
 	if (ret)
 		return ret;
 
-	buf = SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24;
-	op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
-			SPI_MEM_OP_ADDR(addr_width, SPINOR_REG_CYPRESS_CFR2V, 1),
-			SPI_MEM_OP_NO_DUMMY,
-			SPI_MEM_OP_DATA_OUT(1, &buf, 1));
-	ret = spi_mem_exec_op(nor->spi, &op);
-	if (ret) {
-		dev_warn(nor->dev,
-			 "failed to set default memory latency value: %d\n",
-			 ret);
-		return ret;
-	}
-	ret = spi_nor_wait_till_ready(nor);
-	if (ret)
-		return ret;
+	/* Use 24 dummy cycles for memory array reads. */
+	for (addr = 0; addr < nor->mtd.size; addr += SZ_128M) {
+		ret = spansion_read_any_reg(nor,
+					    addr + SPINOR_REG_CYPRESS_CFR2V, 0,
+					    &buf);
+		if (ret)
+			return ret;
 
+		buf &= ~SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK;
+		buf |= SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24;
+		ret = spansion_write_any_reg(nor,
+					     addr + SPINOR_REG_CYPRESS_CFR2V,
+					     buf);
+		if (ret) {
+			dev_warn(nor->dev, "failed to set default memory latency value: %d\n", ret);
+			return ret;
+		}
+	}
 	nor->read_dummy = 24;
 
-	/* Set the octal and DTR enable bits. */
 	ret = write_enable(nor);
 	if (ret)
 		return ret;
 
+	/* Set the octal and DTR enable bits. */
 	buf = SPINOR_REG_CYPRESS_CFR5_OCT_DTR_EN;
-	op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
-			SPI_MEM_OP_ADDR(addr_width, SPINOR_REG_CYPRESS_CFR5V, 1),
-			SPI_MEM_OP_NO_DUMMY,
-			SPI_MEM_OP_DATA_OUT(1, &buf, 1));
-	ret = spi_mem_exec_op(nor->spi, &op);
-	if (ret) {
-		dev_warn(nor->dev, "Failed to enable octal DTR mode\n");
-		return ret;
+	for (addr = 0; addr < nor->mtd.size; addr += SZ_128M) {
+		ret = spansion_write_any_reg(nor,
+					     addr + SPINOR_REG_CYPRESS_CFR5V,
+					     buf);
+		if (ret) {
+			dev_warn(nor->dev, "Failed to enable octal DTR mode\n");
+			return ret;
+		}
 	}
 
 	return 0;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 8a94e12037..d1dbf3eadb 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -185,6 +185,7 @@
 #define SPINOR_REG_CYPRESS_STR1V		0x00800000
 #define SPINOR_REG_CYPRESS_CFR1V		0x00800002
 #define SPINOR_REG_CYPRESS_CFR2V		0x00800003
+#define SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK	GENMASK(3, 0)
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
 #define SPINOR_REG_CYPRESS_CFR3V		0x00800004
 #define SPINOR_REG_CYPRESS_CFR3_PGSZ		BIT(4) /* Page size. */
-- 
2.34.1

