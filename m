Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677A7C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D46FE84B77;
	Thu,  9 Jul 2026 15:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="P8ppG7wc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28F384A3E; Thu,  9 Jul 2026 14:58:14 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E521284B2C
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493ece78b0cso4436825e9.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601892; x=1784206692; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cn2rbe2r6eAfkob6t79yiuwLp9fX9Onui2OeKhrCYOg=;
 b=P8ppG7wc/6NJrncoH9aC2qW4em+FgQEwq4u4tEN/2hKy+alc6BNceVQOah+yFMujGJ
 Z5CWBwBlnrigPANmCZmtXgaWvTmE+x7p9c9RE91sT/qCRGtW/2HUfJQYyizY8QIw8dPP
 hlh3Vzt4EsUkZbCIS5IMDLxS76uUoHJRBQ5vedNTPDA9Sg40PNRuVltUDaDu37SiSzr+
 WpnxtCW2gytvGIu2yedmM8nLarLJ3VhrzVEgicZSeFPSgcdHkDUUcHDcsoakF8ftOwSf
 +Q5dAAogQl7tk72FC+EnfRZqCc9mFB36X4EBc5ywhfX94+ZtGtcoYPPffHQSvAwsj5wF
 CHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601892; x=1784206692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cn2rbe2r6eAfkob6t79yiuwLp9fX9Onui2OeKhrCYOg=;
 b=rNhWoyNdcCVUtFumvd962EmJRrJvRaaqgir02blJmqkznBP+ruvx+O5C33ZFJE+bu1
 Pp3GBC6oWRQkDP9/k+DrxhbijY92U6bWur6KbHMlfLjxXA6bAkKKxYY2IunKXS7YWhB4
 B9Fy7km7+adueEHLePXc+nX8htPUtcGK0VA24M/xCqPCPcuTG4d6+wlpE6iYie5Ips7i
 ClDedmrNpEYVlHPBSg/mID7EOBNWbNIKWOyvhlR2ITWuSfYneoTmaFuKKM3O1+pOLdYX
 TWdG3vVqPFhErFBSGjrAFoFH2+8FCuAZWSUObYsbxHzTMUPPlpTnf5cMRNcQ0XxlwLXg
 r5DQ==
X-Gm-Message-State: AOJu0YybPrGRbnkNI3DJfcvVhpcwGzYiMRbEhDWJy1KecNgial4ro2t1
 HvdT7rWWROYIqQacG915wN0mFPNW0C9Jp64LYPCwbhrahvLTL/v0Kr5LN32u417DY3EOZ5bbDrl
 ZqqH71BQ=
X-Gm-Gg: AfdE7cl2bWEUlvEbgxIOSz/H0bK0FA54lu9FuJULH5ifeDFBCnKog443p0keuw5YbM+
 Rpq0J8yP+qa+gnOv2Dt7guqqkHXIIiVg/fhwUOddFc8VZNMPG7oDEQoy0uNqDuTwmyldUoxHeDC
 X+gmbGrfJ1uAKGn877ltU3U1RW1YnYQEHEBkpV6JQQMS7Gm6nxc4CT0fn8Ybd3XAWyQjho6eIDn
 HU8FqtULuuhYV5zd0Ysn7l9jdB30WwqhNPqvu8MJEgvZhxIAZWzULO/2Sgo8gUK1YJE9VJDoY+k
 NNfUpZ7tyDeZ6BUroXqDaVq2ffUrpa66c+kj+XWHYUo4pfA7Hl8IC7HBTJgrzAyqs0K4ke/5KtS
 TfNTby01h6sJH4u9fXCmGWpylV/G/1IHqKQKCOePfOIHzgkvYlzMTFyHukYuWN5tOFSRR0I6gBq
 5Np2lg8bvPsN+OPTKQz2ubxkCggVRIWsfatmxnCylFKMME2C281rA5bm+WqF9ZwIPzwBq2xMlbG
 /UpO1gdsac7vIjF0ehtPVJtgyut3smI4Uq3z+cNdSRNSrAY3Sb1Ok5n8pjq2j0uA4FEmRk=
X-Received: by 2002:a05:6000:1865:b0:475:f0f0:9ef1 with SMTP id
 ffacd0b85a97d-47df078306fmr7398904f8f.54.1783601892279; 
 Thu, 09 Jul 2026 05:58:12 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:11 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:11 +0200
Subject: [PATCH v2 05/14] power: domain: mediatek: remove enum scp_domain_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-5-589ace7d30e2@baylibre.com>
References: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
In-Reply-To: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
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
X-Mailman-Approved-At: Thu, 09 Jul 2026 15:05:30 +0200
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
 drivers/power/domain/mtk-power-domain.c | 36 ++++-----------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 9888d00421c..dc326cd8c94 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -61,11 +61,6 @@
 
 #define DCM_TOP_EN		BIT(0)
 
-enum scp_domain_type {
-	SCPSYS_MT2701,
-	SCPSYS_MT7622,
-};
-
 struct scp_domain;
 
 struct scp_domain_data {
@@ -80,7 +75,6 @@ struct scp_domain_data {
 struct scp_domain {
 	void __iomem *base;
 	void __iomem *infracfg;
-	enum scp_domain_type type;
 	struct scp_domain_data *data;
 };
 
@@ -315,26 +309,6 @@ static int scpsys_power_request(struct power_domain *power_domain)
 	return 0;
 }
 
-static int mtk_power_domain_hook(struct udevice *dev)
-{
-	struct scp_domain *scpd = dev_get_priv(dev);
-
-	scpd->type = (enum scp_domain_type)dev_get_driver_data(dev);
-
-	switch (scpd->type) {
-	case SCPSYS_MT2701:
-		scpd->data = scp_domain_mt2701;
-		break;
-	case SCPSYS_MT7622:
-		scpd->data = scp_domain_mt7622;
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
@@ -347,9 +321,7 @@ static int mtk_power_domain_probe(struct udevice *dev)
 	if (!scpd->base)
 		return -ENOENT;
 
-	err = mtk_power_domain_hook(dev);
-	if (err)
-		return err;
+	scpd->data = (struct scp_domain_data *)dev_get_driver_data(dev);
 
 	/* get corresponding syscon phandle */
 	err = dev_read_phandle_with_args(dev, "infracfg", NULL, 0, 0, &args);
@@ -377,15 +349,15 @@ static int mtk_power_domain_probe(struct udevice *dev)
 static const struct udevice_id mtk_power_domain_ids[] = {
 	{
 		.compatible = "mediatek,mt2701-scpsys",
-		.data = SCPSYS_MT2701,
+		.data = (ulong)&scp_domain_mt2701,
 	},
 	{
 		.compatible = "mediatek,mt7622-scpsys",
-		.data = SCPSYS_MT7622,
+		.data = (ulong)&scp_domain_mt7622,
 	},
 	{
 		.compatible = "mediatek,mt7623-scpsys",
-		.data = SCPSYS_MT2701,
+		.data = (ulong)&scp_domain_mt2701,
 	},
 	{ /* sentinel */ }
 };

-- 
2.54.0

