Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F6CCD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F37188019;
	Fri,  5 Apr 2024 08:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ijxVVNxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 584DE883EE; Fri,  5 Apr 2024 08:48:05 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEAAC87F2F
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso980628b3a.2
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 23:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712299681; x=1712904481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mpKTgVngRkGsutErWGFn4SEv49ceTBFIoNudkPTtrxI=;
 b=ijxVVNxRfjP2ivl4NphQcQGk4vnLiVWexDIlR1Snfirv/6ZMumrREHDJXkaixyULkz
 Tlos6AfLjMx7ItFZVuILuaned9t3XRvRrPeHD4eIlVkRlLPKL3S9McfwGYAxF42F0J4c
 5gqIMImK+EqCfIQXUJ/zcGCxQUUE3uXRvF9LgqC6lPjfSUjXuIdwIYG74GCfJR0Bpg0l
 9TwOmigQOZfVW+0p7QFoUFMBHxVh6PUl5PzxWGkVCDl91vRnQlLdyVqkI/9QbZhdGdyh
 D9GE2tJiVLrRYix88ZrgIqMIqvLu6ThB+t9gkQjafyPHi3pft4PP2/mhPvv8JGQFMpBI
 0a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712299681; x=1712904481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mpKTgVngRkGsutErWGFn4SEv49ceTBFIoNudkPTtrxI=;
 b=dn9bgOJ2UZax5JWs6UVYYosaamqI4oXscykks0Zm8nPHB3991DPmNmFyEK/fmFq+vM
 ruVlnxvO5ZlzqLQwQXXinD5WC5b8mp1KEfmFjRByEg3nmKfXK3HfKdpRmunviVKl4wNO
 0V8etdxWbDwj5NqYBX4dWMGv+DT5W+PiNE6mjftNQi4fKY4lX4igU9io//yqkvWtI/FN
 n+3a4zYg5iAHeuE/eJLFMaBsB1YDCRnbNtpCP7sUE5Tn/iswd5+dVAQZFIUZceP1cxK9
 jA0Rokgt07T+EDqVKrjrJ+pdo0NlU7lrqwhI3gBHFhoQ9iiOpIYRBNakjl3EWWR6CwOB
 1I1A==
X-Gm-Message-State: AOJu0YzVYsBpFBfq3q/s4Oibee7NYj2Wm5r4+TBdxgbcyHX7i++FZ63k
 bVeJjiZPcWJiZFVR0c5cne464MS3y8CWUcJv2cSoqodNNYxnG/y+wjuhJYEM
X-Google-Smtp-Source: AGHT+IHy9b0rCng+AsB4KRahU7SQ5jWWrPCrcb7IixTfNy1xKQygzCZmuKJb2RcsARuXD22lz+cg7w==
X-Received: by 2002:a05:6a21:1aa:b0:1a5:698e:505c with SMTP id
 le42-20020a056a2101aa00b001a5698e505cmr754171pzb.10.1712299681195; 
 Thu, 04 Apr 2024 23:48:01 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 n13-20020a170903110d00b001e0a61cb886sm769595plh.120.2024.04.04.23.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 23:48:00 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 d-gole@ti.com, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH] mtd: spi-nor: Add support for Infineon S25FS-S family
Date: Fri,  5 Apr 2024 15:47:46 +0900
Message-Id: <20240405064746.1600-1-Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
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
densities are taken care in fixup hooks.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
Datasheets:
https://www.infineon.com/dgdl/Infineon-S25FS064S_64_Mb_8_MB_FS-S_Flash_SPI_Multi-I_O_1-DataSheet-v10_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed526b25412
https://www.infineon.com/dgdl/Infineon-S25FS128S_S25FS256S_1.8_V_Serial_Peripheral_Interface_with_Multi-I_O_MirrorBit(R)_Non-Volatile_Flash-DataSheet-v15_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed6b5ab5758
---
 drivers/mtd/spi/spi-nor-core.c | 28 +++++++++++++++++++++-------
 drivers/mtd/spi/spi-nor-ids.c  |  7 +++++--
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f86003ca8c..9b81b31e8e 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3299,8 +3299,10 @@ static int s25fs_s_quad_enable(struct spi_nor *nor)
 
 static int s25fs_s_erase_non_uniform(struct spi_nor *nor, loff_t addr)
 {
+	u8 opcode = nor->addr_width == 4 ? SPINOR_OP_BE_4K_4B : SPINOR_OP_BE_4K;
+
 	/* Support 8 x 4KB sectors at bottom */
-	return spansion_erase_non_uniform(nor, addr, SPINOR_OP_BE_4K_4B, 0, SZ_32K);
+	return spansion_erase_non_uniform(nor, addr, opcode, 0, SZ_32K);
 }
 
 static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
@@ -3354,12 +3356,24 @@ static int s25fs_s_post_bfpt_fixup(struct spi_nor *nor,
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
index 4e83b8c94c..9ca1f244f0 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -338,9 +338,12 @@ const struct flash_info spi_nor_ids[] = {
 	 */
 	{ INFO("s25sl032p",  0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("s25sl064p",  0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("s25fl256s0", 0x010219, 0x4d00, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-	{ INFO("s25fl256s1", 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fl256s0", 0x010219, 0x4d0080, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fl256s1", 0x010219, 0x4d0180,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO6("s25fl512s",  0x010220, 0x4d0080, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fs064s",  0x010217, 0x4d0181,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fs128s",  0x012018, 0x4d0181,  64 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fs256s",  0x010219, 0x4d0181,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO6("s25fs512s",  0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25fl512s_256k",  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25fl512s_64k",  0x010220, 0x4d01, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-- 
2.34.1

