Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F94C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 06:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A0C888F8;
	Thu,  8 Aug 2024 08:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GkxuIJIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FD487E96; Thu,  8 Aug 2024 08:00:30 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE1B88A14
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 08:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d162eef54so509753b3a.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723096826; x=1723701626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srK9Y7qLwHngMXyklRKTsC/SsjOJUaiIAr6TS6EdKro=;
 b=GkxuIJIxpMZ20VqviLS+s9/ekZ+4izAKYm6Vf3jbNfg8yB88y7bGMnrzJnh+yG6wmR
 Cw0TmQEf03QeaU9peB5HHfE0ZX1uv43YDInzhlD2CHkmAuxk6eI47D5FHg0ALkcWlLkg
 T2/t74+mzwdbUO44cCd8uLgyb8CaU5mVHaCWYQ58Pil91JETX2uVsu77vz5uTxfVdJ0i
 xg8Pc2Bs00H864hQg7tcKjWh2OTAzq4kLmaJQAdVtdV0pOK1D+5/VIp0mU88mYfiANxs
 nklVWTQeUQlOfgCygEPO62iF/uKQer07rAB4hcWsPyhE0FhHOd46UkWbW3F7eDw1vwPm
 ujeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723096826; x=1723701626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srK9Y7qLwHngMXyklRKTsC/SsjOJUaiIAr6TS6EdKro=;
 b=O64vsWmwwQriknq1A0FlMOAPV3ixQ2DhGbJtkA6SP5U10RXD+v9UOHP4UlqGbOerjy
 cKOXCavGemy2CXb1m+caeDKx6HFRwyfauksOa5RkTGuDtnipsL6/kGsINpNpXcgveA87
 0x79695NrwRqTZm9eO+LeI39kncj4d9F8XPvHlpEgrxYpcfnrWYhz3DswkZNO9hMdYnj
 Y269nZtwygb26MJMOVawkq1WuCkelU7wigfT0O5sGjnilMo36U/1uJDV7QnH7JSB+b9t
 boVB42H4yllY81caLYmGrGEoqkPhFjNi+oX+ea/XHCRl+ZWAORHTUIDg0bHouOfQEGjS
 vYVQ==
X-Gm-Message-State: AOJu0YwpThAT2imOMJ71ZviIBXdeTscO7qs44wgKpCisAI+V+L5XDzX9
 IgfO0hbVhMCwtwCfh7WiVAxA5aJBSfsILNjrOoglK+bIbJ3RLW4H9r8ibg==
X-Google-Smtp-Source: AGHT+IGsjEJdu87ZT1Em0v9NG0R9KQM6onoObOUkTg4fPNRoQg7wI1hm3l9K573T4k/J2vWoCIhBiQ==
X-Received: by 2002:a05:6a00:1147:b0:70d:26b5:3b43 with SMTP id
 d2e1a72fcca58-710cae1be31mr968629b3a.19.1723096826237; 
 Wed, 07 Aug 2024 23:00:26 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b7653b4d99sm7819055a12.84.2024.08.07.23.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 23:00:25 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 mwalle@kernel.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 1/4] mtd: spi-nor: Rework set_4byte()
Date: Thu,  8 Aug 2024 15:00:07 +0900
Message-Id: <8f058fc34c7a5e7baa2a7cb10e92a67518717e04.1722917617.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
References: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Synchronize set_4byte() with Linux v6.10 as much as possible.

Introduce {nor, params}->set_4byte_addr_mode().
The params->set_4byte_addr_mode is initialized with one of the
manufacturer specific methods, copied to nor->set_4byte_addr_mode,
then it is called from spi_nor_set_4byte_addr_mode() renamed from
set_4byte().

There are still manufacturer checks here and there.
And The set_4byte_addr_mode() method in both nor-> and params-> looks
redundant. Those should be cleaned up separately in another patch set.

The following commits in Linux are related to this patch.
64c160f32235 ("mtd: spi-nor: Create a ->set_4byte() method")
81924dae5194 ("mtd: spi-nor: Emphasise which is the
               genericset_4byte_addr_mode() method")
076aa4eac8b3 ("mtd: spi-nor: core: Move generic method to core -
               micron_st_nor_set_4byte_addr_mode")
288df4378319 ("mtd: spi-nor: core: Update name and description of
               micron_st_nor_set_4byte_addr_mode")
f1f1976224f3 ("mtd: spi-nor: core: Update name and description of
               spansion_set_4byte_addr_mode")
b6094ac83dd4 ("mtd: spi-nor: core: Introduce
               spi_nor_set_4byte_addr_mode()")

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 179 +++++++++++++++++++++++++--------
 include/linux/mtd/spi-nor.h    |   3 +
 2 files changed, 138 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8d2afaa0e2..d523c045f4 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -680,54 +680,123 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
 }
 #endif /* !CONFIG_SPI_FLASH_BAR */
 
-/* Enable/disable 4-byte addressing mode. */
-static int set_4byte(struct spi_nor *nor, const struct flash_info *info,
-		     int enable)
+/**
+ * spi_nor_set_4byte_addr_mode_en4b_ex4b() - Enter/Exit 4-byte address mode
+ *			using SPINOR_OP_EN4B/SPINOR_OP_EX4B. Typically used by
+ *			Winbond and Macronix. Cypress also uses SPINOR_OP_EN4B
+ *			to enter, but not SPINOR_OP_EX4B to exit.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor,
+						 bool enable)
 {
-	int status;
-	bool need_wren = false;
-	u8 cmd;
+	u8 opcode;
+	int ret;
 
-	switch (JEDEC_MFR(info)) {
-	case SNOR_MFR_ST:
-	case SNOR_MFR_MICRON:
-		/* Some Micron need WREN command; all will accept it */
-		need_wren = true;
-		fallthrough;
-	case SNOR_MFR_ISSI:
-	case SNOR_MFR_MACRONIX:
-	case SNOR_MFR_WINBOND:
-		if (need_wren)
-			write_enable(nor);
+	if (enable)
+		opcode = SPINOR_OP_EN4B;
+	else if (JEDEC_MFR(nor->info) == SNOR_MFR_CYPRESS)
+		opcode = SPINOR_OP_EX4B_CYPRESS;
+	else
+		opcode = SPINOR_OP_EX4B;
 
-		cmd = enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B;
-		status = nor->write_reg(nor, cmd, NULL, 0);
-		if (need_wren)
-			write_disable(nor);
+	ret = nor->write_reg(nor, opcode, NULL, 0);
+	if (ret)
+		return ret;
 
-		if (!status && !enable &&
-		    JEDEC_MFR(info) == SNOR_MFR_WINBOND) {
-			/*
-			 * On Winbond W25Q256FV, leaving 4byte mode causes
-			 * the Extended Address Register to be set to 1, so all
-			 * 3-byte-address reads come from the second 16M.
-			 * We must clear the register to enable normal behavior.
-			 */
-			write_enable(nor);
-			nor->cmd_buf[0] = 0;
-			nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf, 1);
-			write_disable(nor);
-		}
+	/*
+	 * On Winbond W25Q256FV, leaving 4byte mode causes the Extended
+	 * Address Register to be set to 1, so all 3-byte-address reads
+	 * come from the second 16M. We must clear the register to
+	 * enable normal behavior.
+	 */
+	if (!enable && JEDEC_MFR(nor->info) == SNOR_MFR_WINBOND) {
+		ret = write_enable(nor);
+		if (ret)
+			return ret;
 
-		return status;
-	case SNOR_MFR_CYPRESS:
-		cmd = enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B_CYPRESS;
-		return nor->write_reg(nor, cmd, NULL, 0);
-	default:
-		/* Spansion style */
-		nor->cmd_buf[0] = enable << 7;
-		return nor->write_reg(nor, SPINOR_OP_BRWR, nor->cmd_buf, 1);
+		nor->cmd_buf[0] = 0;
+		ret = nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf,
+					1);
+		if (ret)
+			return ret;
+
+		ret = write_disable(nor);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * spi_nor_set_4byte_addr_mode_wren_en4b_ex4b() - Set 4-byte address mode using
+ *			SPINOR_OP_WREN followed by SPINOR_OP_EN4B or
+ *			SPINOR_OP_EX4B. Typically used by ST and Micron flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
+						      bool enable)
+{
+	int ret;
+
+	ret = write_enable(nor);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_set_4byte_addr_mode_en4b_ex4b(nor, enable);
+	if (ret)
+		return ret;
+
+	return write_disable(nor);
+}
+
+/**
+ * spi_nor_set_4byte_addr_mode_brwr() - Set 4-byte address mode using
+ *			SPINOR_OP_BRWR. Typically used by Spansion flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
+ *		address mode.
+ *
+ * 8-bit volatile bank register used to define A[30:A24] bits. MSB (bit[7]) is
+ * used to enable/disable 4-byte address mode. When MSB is set to ‘1’, 4-byte
+ * address mode is active and A[30:24] bits are don’t care. Write instruction is
+ * SPINOR_OP_BRWR(17h) with 1 byte of data.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable)
+{
+	nor->cmd_buf[0] = enable ? BIT(7) : 0;
+	return nor->write_reg(nor, SPINOR_OP_BRWR, nor->cmd_buf, 1);
+}
+
+/* Enable/disable 4-byte addressing mode. */
+static int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	ret = nor->set_4byte_addr_mode(nor, enable);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		nor->addr_width = 4;
+		nor->addr_mode_nbytes = 4;
+	} else {
+		nor->addr_width = 3;
+		nor->addr_mode_nbytes = 3;
 	}
+
+	return 0;
 }
 
 #ifdef CONFIG_SPI_FLASH_SPANSION
@@ -2884,6 +2953,25 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		}
 	}
 
+	/* Select the procedure to enter/exit 4-byte address mode. */
+	switch (JEDEC_MFR(info)) {
+	case SNOR_MFR_ST:
+	case SNOR_MFR_MICRON:
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
+		break;
+
+	case SNOR_MFR_ISSI:
+	case SNOR_MFR_MACRONIX:
+	case SNOR_MFR_WINBOND:
+	case SNOR_MFR_CYPRESS:
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+		break;
+
+	default:
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
+		break;
+	}
+
 	/* Override the parameters with data read from SFDP tables. */
 	nor->addr_width = 0;
 	nor->mtd.erasesize = 0;
@@ -3272,6 +3360,9 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 	else
 		nor->quad_enable = NULL;
 
+	/* Enter/Exit 4-byte address mode */
+	nor->set_4byte_addr_mode = params->set_4byte_addr_mode;
+
 	return 0;
 }
 
@@ -3504,7 +3595,7 @@ static int s25_s28_post_bfpt_fixup(struct spi_nor *nor,
 	 */
 	if (params->size > SZ_128M) {
 		if (bfpt->dwords[BFPT_DWORD(16)] & BFPT_DWORD16_EX4B_PWRCYC) {
-			ret = set_4byte(nor, nor->info, 1);
+			ret = spi_nor_set_4byte_addr_mode(nor, true);
 			if (ret)
 				return ret;
 		}
@@ -3923,7 +4014,7 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		if (nor->flags & SNOR_F_BROKEN_RESET)
 			debug("enabling reset hack; may not recover from unexpected reboots\n");
-		set_4byte(nor, nor->info, 1);
+		return spi_nor_set_4byte_addr_mode(nor, true);
 	}
 
 	return 0;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 0d37a806c4..f5d26447c2 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -446,6 +446,7 @@ struct spi_nor_flash_parameter {
 	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
 
 	int (*quad_enable)(struct spi_nor *nor);
+	int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
 };
 
 /**
@@ -528,6 +529,7 @@ struct spi_flash {
  * @flash_is_unlocked:	[FLASH-SPECIFIC] check if a region of the SPI NOR is
  *			completely unlocked
  * @quad_enable:	[FLASH-SPECIFIC] enables SPI NOR quad mode
+ * @set_4byte_addr_mode:[FLASH-SPECIFIC] enter/exit 4-byte address mode
  * @octal_dtr_enable:	[FLASH-SPECIFIC] enables SPI NOR octal DTR mode.
  * @ready:		[FLASH-SPECIFIC] check if the flash is ready
  * @dirmap:		pointers to struct spi_mem_dirmap_desc for reads/writes.
@@ -579,6 +581,7 @@ struct spi_nor {
 	int (*flash_unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 	int (*flash_is_unlocked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 	int (*quad_enable)(struct spi_nor *nor);
+	int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
 	int (*octal_dtr_enable)(struct spi_nor *nor);
 	int (*ready)(struct spi_nor *nor);
 
-- 
2.34.1

