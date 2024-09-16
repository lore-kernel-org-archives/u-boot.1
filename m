Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1CAC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8894388EE3;
	Mon, 16 Sep 2024 11:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FdwSN/Lr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F9988EEB; Mon, 16 Sep 2024 11:58:53 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2797B88EC2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53568ffc525so4829051e87.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726480729; x=1727085529; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ej78Q2+PYKVgEy5EEJLNV3zuVL9MfHwoOkA0nh6pcxE=;
 b=FdwSN/Lrw+OgL0QXoK7ytOQoUhj+sPabaDF6VKwEgCI3GVbprDKdFJaeBkdGXHySkf
 dH6NhKXBJE8MUsaDY9uxkjQ38TvjNJO/wtf9oZiFg4aikF/RiimW2wuH6T/zpTtgmucS
 I85eDrZku4U6Z/1HTdGH41Mqn+Wx/8m9wzds3HH5hl+3m9+l4b49hWwuUjSeVwCHVw1r
 une43BG60XpSnBcSVngc45cPIwR886XgE/faMUSVx82G8NixfKf/9aRtDzUiA5zXNQC4
 WMi+QLZO8LY/x/02u8Ge5d43cEIqTCsH7d1z+W3u9euYF58+caqb9DuHy4Lrjgl4Vx4X
 F5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726480729; x=1727085529;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ej78Q2+PYKVgEy5EEJLNV3zuVL9MfHwoOkA0nh6pcxE=;
 b=kq//d8mRymdMppZVQz9Geq6PQSoCvcgdPN/HjifagDxlt0EJINggWusaV8Iq0LcABB
 VbEbkFxNnikV1/eKBdT9wJLX8pW0wAcpvF4iG2ZfnEBRDBKKh1OXCnjL4z4fV4PGmJq8
 pPywwmZFdQtrzUVdvdZDNOCviKm+ytZGgpRVIf9Z8b8Q9NF8zSDAEeBQfkpQOT9qP10V
 eHow+/sWPSm9dXvEKR1W79todSWDyFBsp6NNGKX/VaaU2lNSIKxTQWNoTWh/CsG+lPEQ
 5yA5McoU4KvxC1MUVRjP22Ozhf35rHLKstwFYUYEkyJ1A0pu124MbdNo5wGSRgayPxJP
 HusA==
X-Gm-Message-State: AOJu0YxiUjOwM2vgpuJcC3u2Wh8IEqq5fOGlDdIWpzzsP7tqCU7qIh6f
 Zw2QpiQ1XMnEaaVUWioYmLp5vsmTvuty3jXyBpjti2m/7BKf8asglNtjCxfGpco=
X-Google-Smtp-Source: AGHT+IEXPLgC2r0ooLEsant3mdshdbiVCPePocWi8PszOs+Cpd550DmhDj8LYfhZ0Ev45bw+FTFOuA==
X-Received: by 2002:a05:6512:2208:b0:52e:7656:a0f4 with SMTP id
 2adb3069b0e04-53678feb138mr7455275e87.41.1726480728323; 
 Mon, 16 Sep 2024 02:58:48 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109662fsm292862966b.38.2024.09.16.02.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:58:47 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Sep 2024 11:58:43 +0200
Subject: [PATCH v2 1/7] mtd: rawnand: brcmnand: Fix ECC level field setting
 for v7.2 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-brcmnand-fixes-v2-1-08632f64c8ec@linaro.org>
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
In-Reply-To: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.0
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

From: William Zhang <william.zhang@broadcom.com>

Backport from the Linux kernel
commit 2ec2839a9062db8a592525a3fdabd42dcd9a3a9b
"mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller"

v7.2 controller has different ECC level field size and shift in the acc
control register than its predecessor and successor controller. It needs
to be set specifically.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-2-william.zhang@broadcom.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 74 ++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index b1af3f717d43..700d1122639f 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -218,6 +218,7 @@ struct brcmnand_controller {
 	const unsigned int	*page_sizes;
 	unsigned int		page_size_shift;
 	unsigned int		max_oob;
+	u32			ecc_level_shift;
 	u32			features;
 
 	/* for low-power standby/resume only */
@@ -544,6 +545,34 @@ enum {
 	INTFC_CTLR_READY		= BIT(31),
 };
 
+/***********************************************************************
+ * NAND ACC CONTROL bitfield
+ *
+ * Some bits have remained constant throughout hardware revision, while
+ * others have shifted around.
+ ***********************************************************************/
+
+/* Constant for all versions (where supported) */
+enum {
+	/* See BRCMNAND_HAS_CACHE_MODE */
+	ACC_CONTROL_CACHE_MODE				= BIT(22),
+
+	/* See BRCMNAND_HAS_PREFETCH */
+	ACC_CONTROL_PREFETCH				= BIT(23),
+
+	ACC_CONTROL_PAGE_HIT				= BIT(24),
+	ACC_CONTROL_WR_PREEMPT				= BIT(25),
+	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
+	ACC_CONTROL_RD_ERASED				= BIT(27),
+	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
+	ACC_CONTROL_WR_ECC				= BIT(30),
+	ACC_CONTROL_RD_ECC				= BIT(31),
+};
+
+#define	ACC_CONTROL_ECC_SHIFT			16
+/* Only for v7.2 */
+#define	ACC_CONTROL_ECC_EXT_SHIFT		13
+
 static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)
 {
 	return brcmnand_readl(ctrl->nand_base + offs);
@@ -675,6 +704,12 @@ static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
 #endif /* __UBOOT__ */
 		ctrl->features |= BRCMNAND_HAS_WP;
 
+	/* v7.2 has different ecc level shift in the acc register */
+	if (ctrl->nand_version == 0x0702)
+		ctrl->ecc_level_shift = ACC_CONTROL_ECC_EXT_SHIFT;
+	else
+		ctrl->ecc_level_shift = ACC_CONTROL_ECC_SHIFT;
+
 	return 0;
 }
 
@@ -844,30 +879,6 @@ static inline int brcmnand_cmd_shift(struct brcmnand_controller *ctrl)
 	return 0;
 }
 
-/***********************************************************************
- * NAND ACC CONTROL bitfield
- *
- * Some bits have remained constant throughout hardware revision, while
- * others have shifted around.
- ***********************************************************************/
-
-/* Constant for all versions (where supported) */
-enum {
-	/* See BRCMNAND_HAS_CACHE_MODE */
-	ACC_CONTROL_CACHE_MODE				= BIT(22),
-
-	/* See BRCMNAND_HAS_PREFETCH */
-	ACC_CONTROL_PREFETCH				= BIT(23),
-
-	ACC_CONTROL_PAGE_HIT				= BIT(24),
-	ACC_CONTROL_WR_PREEMPT				= BIT(25),
-	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
-	ACC_CONTROL_RD_ERASED				= BIT(27),
-	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
-	ACC_CONTROL_WR_ECC				= BIT(30),
-	ACC_CONTROL_RD_ECC				= BIT(31),
-};
-
 static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
 {
 	if (ctrl->nand_version == 0x0702)
@@ -880,18 +891,15 @@ static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
 		return GENMASK(4, 0);
 }
 
-#define NAND_ACC_CONTROL_ECC_SHIFT	16
-#define NAND_ACC_CONTROL_ECC_EXT_SHIFT	13
-
 static inline u32 brcmnand_ecc_level_mask(struct brcmnand_controller *ctrl)
 {
 	u32 mask = (ctrl->nand_version >= 0x0600) ? 0x1f : 0x0f;
 
-	mask <<= NAND_ACC_CONTROL_ECC_SHIFT;
+	mask <<= ACC_CONTROL_ECC_SHIFT;
 
 	/* v7.2 includes additional ECC levels */
-	if (ctrl->nand_version >= 0x0702)
-		mask |= 0x7 << NAND_ACC_CONTROL_ECC_EXT_SHIFT;
+	if (ctrl->nand_version == 0x0702)
+		mask |= 0x7 << ACC_CONTROL_ECC_EXT_SHIFT;
 
 	return mask;
 }
@@ -905,8 +913,8 @@ static void brcmnand_set_ecc_enabled(struct brcmnand_host *host, int en)
 
 	if (en) {
 		acc_control |= ecc_flags; /* enable RD/WR ECC */
-		acc_control |= host->hwcfg.ecc_level
-			       << NAND_ACC_CONTROL_ECC_SHIFT;
+		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
+		acc_control |= host->hwcfg.ecc_level << ctrl->ecc_level_shift;
 	} else {
 		acc_control &= ~ecc_flags; /* disable RD/WR ECC */
 		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
@@ -2225,7 +2233,7 @@ static int brcmnand_set_cfg(struct brcmnand_host *host,
 	tmp &= ~brcmnand_ecc_level_mask(ctrl);
 	tmp &= ~brcmnand_spare_area_mask(ctrl);
 	if (ctrl->nand_version >= 0x0302) {
-		tmp |= cfg->ecc_level << NAND_ACC_CONTROL_ECC_SHIFT;
+		tmp |= cfg->ecc_level << ctrl->ecc_level_shift;
 		tmp |= cfg->spare_area_size;
 	}
 	nand_writereg(ctrl, acc_control_offs, tmp);

-- 
2.46.0

