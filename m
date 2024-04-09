Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D016ACD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 06:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2EEC88166;
	Tue,  9 Apr 2024 08:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wb36j/fY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE9B8815E; Tue,  9 Apr 2024 08:20:51 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE110881A8
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 08:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e2c725e234so29231225ad.1
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 23:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712643647; x=1713248447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2r1Ou44GS5k8o9rSKegI5Hz3Q2vJGJ+NmUdjFC1sLM4=;
 b=Wb36j/fYcsCqFl7B+iRSJDQDYVrpbLV+jy4hTS4iuTvfHKW0Ix03ZApl3bB6ECbwqn
 QrjR4b5xuwTnM01U72P/KBjiDHIlffgzw2r5VVfsp0D3MAAM8y+xMZDYvt87zqUcY8Gd
 t0vZemV/t00HAQkY4pDdESF+nfGGA5CjqO1EojnC1sNUXtQVk0PPlQvrsJIFnAQQlNcl
 BctI05rH6KEtme2EmZs5b36ZP7sDO0rM63jn22/hl2GArNFrbBc0OQ98SiWeKKmWcrU+
 RcYoRbPQOqQBWoFLY8DmEQJhCMmwKzdH5PD8XgPlzveoE2B5OApHb9h/edD7zenighxM
 zSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712643647; x=1713248447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2r1Ou44GS5k8o9rSKegI5Hz3Q2vJGJ+NmUdjFC1sLM4=;
 b=sLPFjiB6ACzhSIszxRaPSO+wMMhGyjH0AI5+Q6KkB50OspoHvKpW52C/0GOWHp160l
 8xKtiGZKT2ihBD3BEFkuFcW3p413SpMK7ApScIglUZHziXN4REtrrjnYs18sKruU78kA
 eJY1ZLgNKxBwcYPyE1Mk9lAfJrNiR3rDPwaQyHdz8daRQeaslVmggBTW2LBsbmMOP3YT
 bRnzloD5XiYtt6Qtu5wuTyfU8PShLcxYthxNztLyy3sqiNo6sL0Daa+V66n+dnz+Zwcg
 bH4Hz54IpIEDUP1ZjTerSITBsMG0KiqGqe7OwYCUEKmCRB/7EM/RIQYwMpiwlORIX8Hn
 q4mQ==
X-Gm-Message-State: AOJu0Yz7yPgFuyEUbg2S4FLzyrPZOOYuZcAKnIw+nGGV2g8X9MoX+4lF
 D/f86EIBbnAgaSdr0QUvGE24Hs6VTdgvTlxL+wyZANdhNjIKbFQ7hVzuL3Gn
X-Google-Smtp-Source: AGHT+IE5XyetoHZ9IE1vLV8L4nikTEm9Q9rAb31YV+6/PhoS+o8L/yH1hMYQuQlzRrbf9s3jCaP8NA==
X-Received: by 2002:a17:902:b685:b0:1e2:be24:9eac with SMTP id
 c5-20020a170902b68500b001e2be249eacmr2027904pls.9.1712643647400; 
 Mon, 08 Apr 2024 23:20:47 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 x3-20020a1709029a4300b001db5fc51d71sm8037985plv.160.2024.04.08.23.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 23:20:47 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 3/3] mtd: spi-nor-id: Add S25FS064S, S25FS128S,
 S25FS256S IDs
Date: Tue,  9 Apr 2024 15:20:22 +0900
Message-Id: <37d92e2931b646f97f73650c0306adb736bd0efc.1712638210.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
References: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
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
---
 drivers/mtd/spi/spi-nor-core.c | 24 ++++++++++++++++++------
 drivers/mtd/spi/spi-nor-ids.c  |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 9620852817..9b81b31e8e 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3356,12 +3356,24 @@ static int s25fs_s_post_bfpt_fixup(struct spi_nor *nor,
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
index a3dca506a3..9ca1f244f0 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -341,6 +341,9 @@ const struct flash_info spi_nor_ids[] = {
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

