Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE0BC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 04:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4D088189;
	Mon, 15 Apr 2024 06:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HJdWKJPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C57287F4A; Mon, 15 Apr 2024 06:33:39 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B93F88188
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e3f6f03594so16414695ad.0
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 21:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713155616; x=1713760416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wnyHioWevkDl53M0/Dw9BTFFxW+6//7zz2iYOESz1c=;
 b=HJdWKJPejhxEub9yX7uBKqnhCVo53kugvh9tsrIhENn/Iv81L4zSEvNjte3+z347Kj
 JmL5JqasATfIi1bOrKTdSArNQxuW1SA0U3aTU8SkKH9NL8RUMtw+WXHMrZxaDM9g1C1v
 J68OM/R13GwU4dKko9fdOQX6rOW3cVLNcA7vD2W6igV8sWdWPp5Jw9c9pkM20iR/lMaC
 vXL0UzcVYn1rmyzchAFTMvcV1f8pm2cUZ7HP/GrOlETRksEipoFYGMtJrvIbOxswScjk
 VRQtJC488+xJBB5X2HWIdhmcUStQ1/c7qtT9nif2NF8I4iSbr5kWn4lhKzuR3Cf+PmQu
 g2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713155616; x=1713760416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4wnyHioWevkDl53M0/Dw9BTFFxW+6//7zz2iYOESz1c=;
 b=VotdfWl7lLAp4EvJ7RQFhYHbrzudImA+6r4h3TpRHLgEcqq+G/WEBtkffUJELWIy9R
 rQSd1ix8Vm6+qVtdNXBFH7vjTdTbb6bZWxq0EUZLHA6wP1ykgUnJfWSJSOwTQxLVIBNb
 yaNinbFzEYjYlVZlQ3DCLMWU64Lh2W+JXoHgsnVTI7XKM9iMo6vrWUiDPqNTKiazWRUK
 H9STgMxYkAn+wXbIt1uzAKV9hHrdNRtJ4gJ0eBTL+Cr9FWHgeNcYspFLes8JWDpyjKt7
 1KxkRON02r59pX4FUllxgkCefAJ2DFmj3hidkQvPQmmaREUcR5MFhKfe63PcPDS5lgkt
 YCtw==
X-Gm-Message-State: AOJu0Yx7BKGRTn4h5d/lCM7D+WPyMtaiEtRyrrichmyc7Vjl6kFvZLhb
 05O5NuVYepAbNiF3MxftQaBP6NAaf/YowE9ysnUL97xxBwhYfdDBtXGkzw==
X-Google-Smtp-Source: AGHT+IHXel4wmv2+0qnHfr6KNxr3MlmVSGsTfOUFVfTykl/933neh/fidWBOixFGqYcoJ40HsE/3Ew==
X-Received: by 2002:a17:902:74c7:b0:1e0:94a1:95c1 with SMTP id
 f7-20020a17090274c700b001e094a195c1mr7166129plt.29.1713155615789; 
 Sun, 14 Apr 2024 21:33:35 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001dd88a5dc47sm6902682plh.290.2024.04.14.21.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 21:33:35 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 4/4] mtd: spi-nor: Set ECC unit size to MTD writesize in
 Infineon SEMPER flashes
Date: Mon, 15 Apr 2024 13:33:11 +0900
Message-Id: <45f73124ace6e2110cbda2eee9ba44b1320feeae.1713154967.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
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

The Infineon SEMPER NOR flash family uses 2-bit ECC by default with each
ECC block being 16 bytes. Under this scheme multi-pass programming to an
ECC block is not allowed. Set the writesize to make sure multi-pass
programming is not attempted on the flash.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8f371a5213..773afd4040 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3459,6 +3459,13 @@ static void s25_default_init(struct spi_nor *nor,
 			     struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25_s28_setup;
+
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	params->writesize = 16;
 }
 
 static int s25_s28_post_bfpt_fixup(struct spi_nor *nor,
@@ -3623,6 +3630,13 @@ static void s28hx_t_default_init(struct spi_nor *nor,
 {
 	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
 	nor->setup = s25_s28_setup;
+
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	params->writesize = 16;
 }
 
 static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
-- 
2.34.1

