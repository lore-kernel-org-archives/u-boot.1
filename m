Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07BDC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0287877EC;
	Fri, 22 Dec 2023 06:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GgWQ020N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9949387650; Fri, 22 Dec 2023 06:46:44 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B9E877E2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d3eabe9321so10466765ad.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703224001; x=1703828801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhonlz6dBLbPEeApf+akUUnz9ZMbYiPVL2+gHCwjZbA=;
 b=GgWQ020NZzSgn8Jw0dgJZFY+MfYu9+mdyfUmueeAV1Ay7CvrdJTOp+iwiSC0Fjdnn0
 Pup/zCr/W6tVQZr1OxxHaES5anhqCHQ+7Pe1dWlvCfgScSUQsbPYLWF3VfML91eldzNA
 CPBVxl3LY1hTn11Q9cd/KVgAKzbIjOkzw/OAq+Fgk79Rltz/187QNHuZUZ6n0cxPAz0C
 P7eIsQL/humT4HfmH6/2ZGeqKJsF/H0sy06XuNZiloFUbnJ/IQ62tMod2e2GMqhE6gNB
 GsyLSjrT69FbvMH/ImkRZtfYDie/SHB15+B1mpfvhPfbsFctXYA0goOZHI00XeCYy24a
 GZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703224001; x=1703828801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhonlz6dBLbPEeApf+akUUnz9ZMbYiPVL2+gHCwjZbA=;
 b=hyGXNAd3hFl3K7decSKFBJA4MmyyBacNzbkxzDEDNNEpfyPSQrhBmCHVjljNutVCj1
 B6vguovg3eWJuUXJv7zm2a4lO7lJVev3z+dOm2MdSzNlwFfeUVZ72fkXUZ/ZDd2U+Y8/
 w571bj8r3Z+8ByCb/cQyyjEDqsD83bKx6rYbVa5kb5ut53cMLEeDbnLrH5QKTnmRWwrb
 0SqWDKNMWtWf+BnYiqSzFU1D6KWEOYivtluvMyfk6CTGxF4XF8VWZ9jXv04O04zOy45c
 W/1jB8CucPUusS+t9QTGBBGCMN/YQrpf6mEf5TExDO9Go4ozMxhndL6ONFlYSQn1rT6c
 ENHA==
X-Gm-Message-State: AOJu0YxGxm8/cFtmafwao/JBQdfZKHAmoAm4BPbt5dryT5Yns3aaYjJq
 g9llWjsmSCrJoDD6kDJI5aKnvlrR0lo=
X-Google-Smtp-Source: AGHT+IH7pgudbKnh5ho89uH4+GA6QpBNdnZKEsguZVF4kDU/VomE55G1gDYzQ4s+3qjV2gHUPyJ6xA==
X-Received: by 2002:a17:902:f814:b0:1d4:8a3:52f3 with SMTP id
 ix20-20020a170902f81400b001d408a352f3mr497821plb.32.1703224000799; 
 Thu, 21 Dec 2023 21:46:40 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:46:40 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 3/9] mtd: spi-nor-core: Rework spansion_read_any_reg() to
 support Octal DTR mode
Date: Fri, 22 Dec 2023 14:46:00 +0900
Message-Id: <f3fa3d21143b36b0f7993b5c731c885571136e5d.1703220284.git.Takahiro.Kuwano@infineon.com>
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

In Infineon multi-die package parts, we need to use Read Any Register op
to read status register in 2nd or further die. Infineon S28HS02GT is
dual-die package and supports Octal DTR interface. To support this,
spansion_read_any_reg() needs to be reworked. Implementation is similar
to existing read_sr() that already supports Octal DTR mode.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f62a2f2008..3f761b9b9e 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -331,12 +331,36 @@ static int spansion_read_any_reg(struct spi_nor *nor, u32 addr, u8 dummy,
 				 u8 *val)
 {
 	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
-			   SPI_MEM_OP_ADDR(nor->addr_mode_nbytes, addr, 1),
-			   SPI_MEM_OP_DUMMY(dummy / 8, 1),
-			   SPI_MEM_OP_DATA_IN(1, NULL, 1));
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 0),
+			   SPI_MEM_OP_ADDR(nor->addr_mode_nbytes, addr, 0),
+			   SPI_MEM_OP_DUMMY(dummy, 0),
+			   SPI_MEM_OP_DATA_IN(1, NULL, 0));
+	u8 buf[2];
+	int ret;
+
+	spi_nor_setup_op(nor, &op, nor->reg_proto);
+
+	/*
+	 * In Octal DTR mode, the number of address bytes is always 4 regardless
+	 * of addressing mode setting.
+	 */
+	if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR)
+		op.addr.nbytes = 4;
+
+	/*
+	 * We don't want to read only one byte in DTR mode. So, read 2 and then
+	 * discard the second byte.
+	 */
+	if (spi_nor_protocol_is_dtr(nor->reg_proto))
+		op.data.nbytes = 2;
 
-	return spi_nor_read_write_reg(nor, &op, val);
+	ret = spi_nor_read_write_reg(nor, &op, buf);
+	if (ret)
+		return ret;
+
+	*val = buf[0];
+
+	return 0;
 }
 
 static int spansion_write_any_reg(struct spi_nor *nor, u32 addr, u8 val)
-- 
2.34.1

