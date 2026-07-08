Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D78C44506
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E06184A4F;
	Wed,  8 Jul 2026 19:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ng7WQDSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D2B184A0B; Wed,  8 Jul 2026 15:07:12 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948F2849F0
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so501585f8f.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516030; x=1784120830; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=llPu8Prg2WtoqnCvI7hTtL1jBF1b+RKxTVg/XgjlfgQ=;
 b=ng7WQDSr3TX4gjlmSL7Cvnq4jowwtwiGPpUxuut5cXOaE/kPt1afDIwX/Y6hdxyHrR
 PdZVKgqTwwBTifPOKX+wWyAHg1hp+zaBJ6Xo1CDAVnGbwCYq8ne6KaEmMV6VGGLvcTOI
 n6XBKNYfHiI+uexNKD9SIQEPTelHOmVUz7NlxuTbog3wdN76+zrZYG0gnl1oGl/wohdo
 9yz9ITmZzky+JNphGNxcpwCMxmE8E6Z5pkKuxY7TI83lRkCo63EQcI4txvipc7GQ2aF6
 auiim2fKEEdpiDX4/6joHfxsAbjR4nnEZTcCDvaG2Hxzb7h/11/g7GEZBx5/HIHHJCy8
 ucpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516030; x=1784120830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=llPu8Prg2WtoqnCvI7hTtL1jBF1b+RKxTVg/XgjlfgQ=;
 b=U6EOU9kO/Yb0DL3Bj17t4JH/mMuErJGr4L9Ag2KodyIKsbyfAzj6gOZZsExmx78ql5
 hpXMTa/q7Qb3+A9lYcMLVQ2R5WA8A848T2RGbBH+HP0Goxf+9PQAaVpHINuy2ukS2R7K
 /UAln+mKcsP8p5qclbuUOZnahl4t27UDF5PJETy3iJTJlHFLHup9O4zkPgUi9GWZvfk/
 DwtGwoMd7WrRv3biqeEReuABBQRR9mpxmoZbTf2HCPouL69FdmVzpTGIUeSGOgidFrP6
 09ryihpjd16dy661vfsrYMYuHwaRTudmFo4cRDqSrKe27AkUPz/LBaOnhDouJclM26xX
 wk7g==
X-Gm-Message-State: AOJu0YztHblrWTZqj3H9b45hn1MiPwBMWevjml3ekG+CCPlPVgCzNAdJ
 f4nJjkXId2P6URhDtVLWdhZvkiXASZmUBr+T+4udIzK6kAOjl0y3CpR5YKT8XTz169U=
X-Gm-Gg: AfdE7cnroGL+aGKGsIAV3oFE2iD5VG3/pS/MizQr0q717/A39ckOCUwM696qL37Llu6
 Omeb4Iv/scEJOHfYunSeZAer3DJ/rBwsjYg57iQeHGVRTZ6/GmoRC85nkKAzRmRsuKKMSFxw+z2
 EpY8TnmEvquIB5No6BKHh5Rv1dSKjhb51J8ZQXie1dTUm2+fKojdnsVMIpwHsQIJaVdymcaxStN
 jGIkfQAoRu8HC6z68Y5Yha8FIP/j9TlQNyfmultO/6h4OhILNEJEan0aGfSxjJwiJHFiVH/VG4J
 qt88aQoJrJIuT2ayFksx01HVG897Rv2guYujWM0EJKEh81UCmKTNFUAgEvoZch7oysqx1xOXcIz
 6t3VtkLnSEDhIwS5Kb4slE6WoYIcQdykH5zNOJ8C/bChDTUVcqQxwdhdx37Zjk/x5/25cMKvAZb
 tdjvXs+2xpbdc7eOff8WDk+mhrsXqd+S51jR30NavnL/DQGD3ogR2G+OiGcVq8rr//4jB3+gR31
 iNeMqoxFksyzSzrk+axYwqXAzggOyqSif9E7EzBtIXLuEYHDjxYFygG7uHqT+ktfASmkx8=
X-Received: by 2002:a05:6000:3cb:b0:472:aaba:faed with SMTP id
 ffacd0b85a97d-47df075e330mr2647674f8f.31.1783516029976; 
 Wed, 08 Jul 2026 06:07:09 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:09 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jul 2026 15:07:09 +0200
Subject: [PATCH 03/12] power: domain: mediatek: remove enum scp_domain_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mt8188-add-power-domain-v1-3-0e930b4f714e@baylibre.com>
References: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
In-Reply-To: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:37 +0200
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

The driver mapped each compatible to an enum scp_domain_type via the
match data, then used mtk_power_domain_hook() to switch on that enum
and select the per-SoC domain table. This forces every new SoC to add
an enum value and a switch case in shared code.

Store a pointer to the per-SoC table directly in the match data and
drop the enum, the type field, and mtk_power_domain_hook(). This keeps
per-SoC information in the match data where it belongs, making it
possible to later split the SoC-specific tables into standalone drivers.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 38 ++++-----------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 24dd540897d..16a97094303 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -61,12 +61,6 @@
 
 #define DCM_TOP_EN		BIT(0)
 
-enum scp_domain_type {
-	SCPSYS_MT7622,
-	SCPSYS_MT7623,
-	SCPSYS_MT7629,
-};
-
 struct scp_domain;
 
 struct scp_domain_data {
@@ -81,7 +75,6 @@ struct scp_domain_data {
 struct scp_domain {
 	void __iomem *base;
 	void __iomem *infracfg;
-	enum scp_domain_type type;
 	struct scp_domain_data *data;
 };
 
@@ -316,27 +309,6 @@ static int scpsys_power_request(struct power_domain *power_domain)
 	return 0;
 }
 
-static int mtk_power_domain_hook(struct udevice *dev)
-{
-	struct scp_domain *scpd = dev_get_priv(dev);
-
-	scpd->type = (enum scp_domain_type)dev_get_driver_data(dev);
-
-	switch (scpd->type) {
-	case SCPSYS_MT7623:
-		scpd->data = scp_domain_mt7623;
-		break;
-	case SCPSYS_MT7622:
-	case SCPSYS_MT7629:
-		scpd->data = scp_domain_mt7629;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int mtk_power_domain_probe(struct udevice *dev)
 {
 	struct ofnode_phandle_args args;
@@ -349,9 +321,7 @@ static int mtk_power_domain_probe(struct udevice *dev)
 	if (!scpd->base)
 		return -ENOENT;
 
-	err = mtk_power_domain_hook(dev);
-	if (err)
-		return err;
+	scpd->data = (struct scp_domain_data *)dev_get_driver_data(dev);
 
 	/* get corresponding syscon phandle */
 	err = dev_read_phandle_with_args(dev, "infracfg", NULL, 0, 0, &args);
@@ -379,15 +349,15 @@ static int mtk_power_domain_probe(struct udevice *dev)
 static const struct udevice_id mtk_power_domain_ids[] = {
 	{
 		.compatible = "mediatek,mt7622-scpsys",
-		.data = SCPSYS_MT7622,
+		.data = (ulong)&scp_domain_mt7629,
 	},
 	{
 		.compatible = "mediatek,mt7623-scpsys",
-		.data = SCPSYS_MT7623,
+		.data = (ulong)&scp_domain_mt7623,
 	},
 	{
 		.compatible = "mediatek,mt7629-scpsys",
-		.data = SCPSYS_MT7629,
+		.data = (ulong)&scp_domain_mt7629,
 	},
 	{ /* sentinel */ }
 };

-- 
2.54.0

