Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89887C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B599F881EF;
	Fri, 12 Apr 2024 00:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="TimMT7ed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C1E88207; Fri, 12 Apr 2024 00:37:44 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105AC87B82
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so321035276.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875061; x=1713479861;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwVzG40rMp+XeKrnbrR6xYabuH0Dhlxm6zgMOLWXDu4=;
 b=TimMT7edjuOy4UgWGmkhyr6sEiADHM2Lkid1JrgvC20XWS7W3YSV5V4Xnp2eT1MTi5
 Cqk99jeE6TrRMnTxLatb0tgm5u9h9vXZRfDiU1p7moYMGQBx5ZvaRI8BCad/+p7Kj7kI
 H4Rv0mX6GicbNfm5MXZu75VX9hooGVOGkP4eefBSNNiJpd4o/ibmGE1S/4EZTBqVQusF
 2limNF8RAyu+IonzHskdX43+uKvGr1YbPS/TEJpHP58Gk4n4mCtOIAdOFtWbZEHsyCFN
 jGjKKQJXamOW9UpWSvLx2KQCqV2ot+tvovRFpyPxx6hfFqW/n8Dukc3rvVasHAUdJoBr
 Rp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875061; x=1713479861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwVzG40rMp+XeKrnbrR6xYabuH0Dhlxm6zgMOLWXDu4=;
 b=grCFUciSMQZz4mWCeo5KvaF9tEc53uIbj2JPx1lpSaKf8gCOxKJAaFNyZVIXbuVzlU
 cLXVph0j3dQgIvBpxBubVHvoE90otno2Zm/PgI5Aj25SOcuWoqjxLIlHBVfvb4HyH2WL
 qmBEmAAV+AFOuHaS1xG6a/3qrfNecsTSafFMiUP3QIHjwtdskaNVpODaHcL8dAT1BaNN
 3gUIbS6xmgLJA+u//JH2LB1YLCBW7yxR90BMo3nPALerYmBa+pMdgHYQvnRejkwRnb3A
 449ozJmnTzXaYTr8rHIsE5HTjEjSLTCF4Qsnbx7uVKj5vNWOVNENSo4TliJrcABvbNQH
 BiJg==
X-Gm-Message-State: AOJu0YymMUswQdJBvijBD4b5Y714BxnYlLv66NKtWCtwRFPnGgN1bpqR
 yCgGTtBFFl/UzAE0NCUD5gbYddcOU3W302TXicIijNm+WmmOC8J+G6FTOsSA3/L4h7OvziXSZQ0
 /dw==
X-Google-Smtp-Source: AGHT+IF7duu9K9kKg+riy3/yNczOYf9jbufUkataBjSyrA7nldxv7WzLG4kf/AdRbEWs69sECG+g2A==
X-Received: by 2002:a25:fc12:0:b0:dc2:279f:f7e with SMTP id
 v18-20020a25fc12000000b00dc2279f0f7emr966422ybd.10.1712875060758; 
 Thu, 11 Apr 2024 15:37:40 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:40 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Andre Przywara <andre.przywara@arm.com>, Bruce Suen <bruce_suen@163.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marex@denx.de>, Neal Frager <neal.frager@amd.com>,
 Nishanth Menon <nm@ti.com>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH 02/11] mtd: spi-nor: Octal DTR support for IS25*x
Date: Thu, 11 Apr 2024 18:36:46 -0400
Message-ID: <20240411223709.573-3-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411223709.573-1-greg.malysa@timesys.com>
References: <20240411223709.573-1-greg.malysa@timesys.com>
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

From: Ian Roberts <ian.roberts@timesys.com>

ISSI IS25*x series SPIflash chips are capable of Octal IO and DDR.
Add spi-nor support to enable and operate in these modes.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 drivers/mtd/spi/spi-nor-core.c | 78 ++++++++++++++++++++++++++++++++++
 drivers/mtd/spi/spi-nor-ids.c  |  6 ++-
 include/linux/mtd/spi-nor.h    |  6 +++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f164c3cf73..ce86e53860 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3968,6 +3968,76 @@ static struct spi_nor_fixups macronix_octal_fixups = {
 };
 #endif /* CONFIG_SPI_FLASH_MACRONIX */
 
+#ifdef CONFIG_SPI_FLASH_ISSI
+/**
+ * spi_nor_issi_octal_dtr_enable() - Enable octal DTR on ISSI flashes.
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_issi_octal_dtr_enable(struct spi_nor *nor)
+{
+	struct spi_mem_op op;
+	int ret;
+	u8 regval;
+
+	nor->read_dummy = ISSI_MAX_DC;
+
+	ret = write_enable(nor);
+	if (ret)
+		return ret;
+
+	regval = SPINOR_REG_ISSI_VCR_ODDR_EN;
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_ISSI_WR_VCR, 1),
+			   SPI_MEM_OP_ADDR(3, SPINOR_REG_ISSI_VCR_IOMODE, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, &regval, 1));
+
+	ret = spi_mem_exec_op(nor->spi, &op);
+	if (ret) {
+		dev_err(nor->dev, "Failed to enable octal DTR mode\n");
+		return ret;
+	}
+
+	nor->reg_proto = SNOR_PROTO_8_8_8_DTR;
+
+	return 0;
+}
+
+static void issi_octal_default_init(struct spi_nor *nor)
+{
+	nor->octal_dtr_enable = spi_nor_issi_octal_dtr_enable;
+}
+
+static void issi_octal_post_sfdp_fixup(struct spi_nor *nor,
+				       struct spi_nor_flash_parameter *params)
+{
+	/*
+	 * Adding SNOR_HWCAPS_PP_8_8_8_DTR in hwcaps.mask when
+	 * SPI_NOR_OCTAL_DTR_READ flag exists.
+	 */
+	if (params->hwcaps.mask & SNOR_HWCAPS_READ_8_8_8_DTR)
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
+	nor->cmd_ext_type = SPI_NOR_EXT_INVERT;
+
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
+				  0, 16, 0x0c, SNOR_PROTO_8_8_8_DTR);
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
+				0x12, SNOR_PROTO_8_8_8_DTR);
+
+	params->rdsr_dummy = 8;
+
+	nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+	nor->flags |= SNOR_F_SOFT_RESET;
+}
+
+static struct spi_nor_fixups issi_octal_dtr_fixups = {
+	.default_init = issi_octal_default_init,
+	.post_sfdp = issi_octal_post_sfdp_fixup,
+};
+#endif /* CONFIG_SPI_FLASH_ISSI */
+
 /** spi_nor_octal_dtr_enable() - enable Octal DTR I/O if needed
  * @nor:                 pointer to a 'struct spi_nor'
  *
@@ -4161,6 +4231,14 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 		nor->fixups = &mt35xu512aba_fixups;
 #endif
 
+#if CONFIG_IS_ENABLED(SPI_FLASH_ISSI)
+	if (JEDEC_MFR(nor->info) == SNOR_MFR_ISSI) {
+		if ((nor->info->id[1] == 0x5a || nor->info->id[1] == 0x5b) &&
+		    (nor->info->id[2] == 0x19 || nor->info->id[2] == 0x18))
+			nor->fixups = &issi_octal_dtr_fixups;
+	}
+#endif
+
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
 	nor->fixups = &macronix_octal_fixups;
 #endif /* SPI_FLASH_MACRONIX */
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e83b8c94c..e3e37cd79b 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -238,8 +238,12 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("is25lx256", 0x9d5a19, 0, 128 * 1024, 256,
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ
+			| SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
-			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ
+			| SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
 			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
 #endif
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 2eddb52392..bd364e74a7 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -131,6 +131,12 @@
 #define SPINOR_REG_MXIC_DC_20		0x0		/* Setting dummy cycles to 20 */
 #define MXIC_MAX_DC			20		/* Maximum value of dummy cycles */
 
+/* Used for ISSI flashes. */
+#define SPINOR_OP_ISSI_WR_VCR		0x81
+#define SPINOR_REG_ISSI_VCR_IOMODE	0x0
+#define SPINOR_REG_ISSI_VCR_ODDR_EN	0xe7
+#define ISSI_MAX_DC			16
+
 /* Used for Spansion flashes only. */
 #define SPINOR_OP_BRWR		0x17	/* Bank register write */
 #define SPINOR_OP_BRRD		0x16	/* Bank register read */
-- 
2.43.2

