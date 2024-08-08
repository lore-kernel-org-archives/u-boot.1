Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCBAC52D73
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 06:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E29D88763;
	Thu,  8 Aug 2024 08:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsnsWZyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E6F888A68; Thu,  8 Aug 2024 08:00:41 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41AE882BE
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 08:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-710afd56c99so465533b3a.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723096837; x=1723701637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2dhmEvnSOskzUq8W/CLAHtKyXPbt1eRzwtrMmA+huo=;
 b=nsnsWZyNZfp8oPabC0nHm3Q38vFxnWYRWVmi45UGk/73Zq8NiTWGt97kj6JU4iwzIq
 5SbfAblyhzfJEp1IbM2VoLe03zJE7Uw1zukJtSUhk+ETB70vn3MbHdIcHrRIZ+YgyDdu
 npb8VMivR6EwKmJpf7wEZ3hrKGAmSPz+2fVw/4zWHu9NxqbMOgd5qFuH9G6ftgnmw9E6
 uWpRe7rseeGiPot/xix405iGE170TPHVHMciStx0bcRR2LcPgfXrIQp6I1YCK8MsSp4O
 rIjoQOiYRhmM/U644DgttxV1JKzG0/1jkEEUaQ/iU1c1IfVuV9RNWsOAZMNztpm1Vk9y
 1ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723096837; x=1723701637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2dhmEvnSOskzUq8W/CLAHtKyXPbt1eRzwtrMmA+huo=;
 b=LBox8PaPT6k8rjioErFK2CXXDXCNi4/q2F7YDjxX5Btwxek/YKpnjuIskMFtB6libg
 5TgWTxusrEnqPEh33aFC6xcjeGiSFUMsmjMhR9/slWRvStMwdbcbkg2ftM3wjGZE/cCo
 q4XizE9kz7Bts99ubm11OyOuHFT0zUFkVHbSkJhUuXo3u+F24P0DmAbUK1BPkStYOzns
 7D7hzMJ1k/elp6D5L2bOaqqfaa91HeKCmbq52VZHGGCTwDQvqzb0/PNObbR7EdXo4QTp
 NUi8smuAS4grxoFyzzGd94v/in0L+9I7fwyW/G6PSJCOMF2oDuLOCz0tLyOQwKkdSMNv
 rAOg==
X-Gm-Message-State: AOJu0YwdCE3L8UzLAPr1MHDs0utyLtvGeVpuujhFDUmQv1y1FKdyJT21
 IL3W9PoYpiVAggQbzEoWDhs1TZ3iaWr8Dwm3LuieQb0C+Lb+Oxqy8SVtKA==
X-Google-Smtp-Source: AGHT+IEAG8Zeofb/m4N+EVEq/kGorAmK8K0UqZY/UzuMRDcw81SLCCk+pcIsGlOYGA4Uer3wHmLX5g==
X-Received: by 2002:a05:6a00:66d7:b0:70e:ce95:b87 with SMTP id
 d2e1a72fcca58-710cc32a238mr1468288b3a.0.1723096837363; 
 Wed, 07 Aug 2024 23:00:37 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b7653b4d99sm7819055a12.84.2024.08.07.23.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 23:00:36 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 mwalle@kernel.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 4/4] mtd: spi-nor: add generic flash driver
Date: Thu,  8 Aug 2024 15:00:10 +0900
Message-Id: <51d98b0a7a12d0d89f37e0ceb114d162c3ae6263.1722917617.git.Takahiro.Kuwano@infineon.com>
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

Our SFDP parsing is everything we need to support all basic operations
of a flash device. If the flash isn't found in our in-kernel flash
database, gracefully fall back to a driver described solely by its SFDP
tables.

This patch ports the commit in Linux:
773bbe104497 ("mtd: spi-nor: add generic flash driver")

A new flag named SPI_NOR_PARSE_SFDP is defined to perform SFDP parse for
the spi-nor-generic. And spi_nor_read_id() is moved to later part than
SFDP functions.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/sf_internal.h  |  1 +
 drivers/mtd/spi/spi-nor-core.c | 95 ++++++++++++++++++++++++----------
 2 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 57608750c9..f7b0cea983 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -68,6 +68,7 @@ struct flash_info {
 #define SPI_NOR_HAS_SST26LOCK	BIT(14)	/* Flash supports lock/unlock via BPR */
 #define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
 #define SPI_NOR_OCTAL_DTR_READ	BIT(16)	/* Flash supports Octal DTR Read */
+#define SPI_NOR_PARSE_SFDP	BIT(17)	/* Parse SFDP tables */
 };
 
 extern const struct flash_info spi_nor_ids[];
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index feafc48a49..c1186271a4 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1509,31 +1509,6 @@ static int stm_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 #endif /* CONFIG_SPI_FLASH_STMICRO */
 #endif
 
-static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
-{
-	int			tmp;
-	u8			id[SPI_NOR_MAX_ID_LEN];
-	const struct flash_info	*info;
-
-	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
-	if (tmp < 0) {
-		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
-		return ERR_PTR(tmp);
-	}
-
-	info = spi_nor_ids;
-	for (; info->name; info++) {
-		if (info->id_len) {
-			if (!memcmp(info->id, id, info->id_len))
-				return info;
-		}
-	}
-
-	dev_err(nor->dev, "unrecognized JEDEC id bytes: %02x, %02x, %02x\n",
-		id[0], id[1], id[2]);
-	return ERR_PTR(-ENODEV);
-}
-
 static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
@@ -2154,6 +2129,17 @@ spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
 }
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_SFDP_SUPPORT)
+
+static const struct flash_info spi_nor_generic_flash = {
+	.name = "spi-nor-generic",
+	/*
+	 * JESD216 rev A doesn't specify the page size, therefore we need a
+	 * sane default.
+	 */
+	.page_size = 256,
+	.flags = SPI_NOR_PARSE_SFDP,
+};
+
 /*
  * Serial Flash Discoverable Parameters (SFDP) parsing.
  */
@@ -2724,6 +2710,32 @@ out:
 	return ret;
 }
 
+/**
+ * spi_nor_check_sfdp_signature() - check for a valid SFDP signature
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Used to detect if the flash supports the RDSFDP command as well as the
+ * presence of a valid SFDP table.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_check_sfdp_signature(struct spi_nor *nor)
+{
+	u32 signature;
+	int err;
+
+	/* Get the SFDP header. */
+	err = spi_nor_read_sfdp(nor, 0, sizeof(signature), &signature);
+	if (err < 0)
+		return err;
+
+	/* Check the SFDP signature. */
+	if (le32_to_cpu(signature) != SFDP_SIGNATURE)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
@@ -3014,7 +3026,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	nor->addr_width = 0;
 	nor->mtd.erasesize = 0;
 	if (info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-	    SPI_NOR_OCTAL_DTR_READ)) {
+	    SPI_NOR_OCTAL_DTR_READ | SPI_NOR_PARSE_SFDP)) {
 		struct spi_nor_flash_parameter sfdp_params;
 
 		memcpy(&sfdp_params, params, sizeof(sfdp_params));
@@ -4170,6 +4182,37 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif /* SPI_FLASH_MACRONIX */
 }
 
+static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
+{
+	int			tmp;
+	u8			id[SPI_NOR_MAX_ID_LEN];
+	const struct flash_info	*info;
+
+	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
+	if (tmp < 0) {
+		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
+		return ERR_PTR(tmp);
+	}
+
+	info = spi_nor_ids;
+	for (; info->name; info++) {
+		if (info->id_len) {
+			if (!memcmp(info->id, id, info->id_len))
+				return info;
+		}
+	}
+
+#if CONFIG_IS_ENABLED(SPI_FLASH_SFDP_SUPPORT)
+	/* Fallback to a generic flash described only by its SFDP data. */
+	if (!spi_nor_check_sfdp_signature(nor))
+		return &spi_nor_generic_flash;
+#endif
+
+	dev_err(nor->dev, "unrecognized JEDEC id bytes: %02x, %02x, %02x\n",
+		id[0], id[1], id[2]);
+	return ERR_PTR(-ENODEV);
+}
+
 int spi_nor_scan(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter params;
-- 
2.34.1

