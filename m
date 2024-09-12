Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E050FEE57C7
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A8C88E9C;
	Thu, 12 Sep 2024 08:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J3eMrPPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E390A88E9C; Thu, 12 Sep 2024 08:14:01 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB8E88DBC
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2053f6b8201so5799195ad.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121638; x=1726726438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMHdzz9g+vOlTu95n8CRLgGumxkkUHve5vMt319tU3g=;
 b=J3eMrPPF+0Er4Lwj9pzav87laFFO0bNi/mowM7lGkEvrGKnZOs5nNlvvKzh/x/eaEn
 rU1gnNeJhJO+g1I8Ew3/esaY+YHGv9suykSeEEBS8QQ6/zq1RnswNutomg4DzmARmyBz
 xk5uToj7rCik8LcAizsm3G1n8Kpe4GiGpExKmkz4/S5Uip20YRQ3AlKvL/6BdtBBqLiV
 VA1DBOGmV/HV9vNESEJSGVRIfyXzxjGHWvj/1sV7KiPjlFvb7qBNxy/N4+uABc5HJiQi
 YZyokW7ic7/48cAkfEJvVmjk9zBzTNI6Ai9iJVnccYJ9Lw3UnP5+aLPhcaZSjUHFyRfr
 euAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121638; x=1726726438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMHdzz9g+vOlTu95n8CRLgGumxkkUHve5vMt319tU3g=;
 b=t6KoytfEizqo3FUzECeu4BOjxlzYS5YvIPwcE/h8Cv9+GRUjt7uF0OaPctLvGQ73U3
 tLGGgJ22rxbEoPP6oO55IBLX5wxF/TYgpBQ7gaj5EvrHuPEc4wNt7UV+IPos+NXNNODq
 7gVfLE7rWR0SrDgn+dMAdLVMSz+0Jn2/HxC+5nLHVMC83hB0HrjNQCsSjEd4ApfZs7fg
 Qo1rRHshZ/xvcjdhzROY3mfuqgM3ykY2ZOwed3/U1KnbKTj5FB9mqnOHC8soyQE6MUpJ
 pANdGAg7COm6BBduM1yrgtDGIzi6s4Lsop4jOLMtqE/3viqcbV6feHnAHEar74wEiqZC
 f07A==
X-Gm-Message-State: AOJu0YwiDHv7ZsRXhYq4sfAqz5HY6TNdrN7drIKFwenlsdq5EMAiDUjK
 zxYwuud8ugWzR8sb4eKejNvYOp6hzqtxLibCHaU1JsSBaO5GGvShtWOFdg==
X-Google-Smtp-Source: AGHT+IF6PMG2AVUmTd5lQV5t3OQ/lBbdC5MzBDS/OaDy2cpsid0dqNAwd+cQi6CNqlEbqcuajhF1qA==
X-Received: by 2002:a17:902:f681:b0:206:d8c2:4a79 with SMTP id
 d9443c01a7336-2076e3366c9mr23390585ad.15.1726121638042; 
 Wed, 11 Sep 2024 23:13:58 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afdd046sm8214065ad.166.2024.09.11.23.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:13:57 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 3/3] mtd: spi-nor-id: Add S25FS064S, S25FS128S,
 S25FS256S IDs
Date: Thu, 12 Sep 2024 15:13:01 +0900
Message-Id: <bbeab9d3a52def2796162fb36c98d93027de742d.1726120686.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726120686.git.Takahiro.Kuwano@infineon.com>
References: <cover.1726120686.git.Takahiro.Kuwano@infineon.com>
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

The S25FS064S, S25FS128S, and S25FS256S are the same family of SPI NOR
Flash devices with S25FS512S. Some difference depending on the device
densities are taken care in post SFDP fixup.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 drivers/mtd/spi/spi-nor-core.c | 24 ++++++++++++++++++------
 drivers/mtd/spi/spi-nor-ids.c  |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index b633f3092b..e126fa37c1 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3406,12 +3406,24 @@ static int s25fs_s_post_bfpt_fixup(struct spi_nor *nor,
 static void s25fs_s_post_sfdp_fixup(struct spi_nor *nor,
 				    struct spi_nor_flash_parameter *params)
 {
-	/* READ_1_1_2 is not supported */
-	params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
-	/* READ_1_1_4 is not supported */
-	params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
-	/* PP_1_1_4 is not supported */
-	params->hwcaps.mask &= ~SNOR_HWCAPS_PP_1_1_4;
+	/*
+	 * The S25FS064S(8MB) supports 1-1-2 and 1-1-4 commands, but params for
+	 * read ops in SFDP are wrong. The other density parts do not support
+	 * 1-1-2 and 1-1-4 commands.
+	 */
+	if (params->size == SZ_8M) {
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
+					  0, 8, SPINOR_OP_READ_1_1_2,
+					  SNOR_PROTO_1_1_2);
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
+					  0, 8, SPINOR_OP_READ_1_1_4,
+					  SNOR_PROTO_1_1_4);
+	} else {
+		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
+		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
+		params->hwcaps.mask &= ~SNOR_HWCAPS_PP_1_1_4;
+	}
+
 	/* Use volatile register to enable quad */
 	params->quad_enable = s25fs_s_quad_enable;
 }
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 17e0f84e9e..9693c179b7 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -342,6 +342,9 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO6("s25fl256s0", 0x010219, 0x4d0080, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO6("s25fl256s1", 0x010219, 0x4d0180,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO6("s25fl512s",  0x010220, 0x4d0080, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fs064s",  0x010217, 0x4d0181,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fs128s",  0x012018, 0x4d0181,  64 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fs256s",  0x010219, 0x4d0181,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO6("s25fs512s",  0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25fl512s_256k",  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25fl512s_64k",  0x010220, 0x4d01, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-- 
2.34.1

