Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CEEC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2842B84BB2;
	Thu,  9 Jul 2026 15:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="k1Nv1ccM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B5E84A3E; Thu,  9 Jul 2026 14:58:27 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D3884AFF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493b7612475so16096385e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601905; x=1784206705; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CphY46F71fn6I5TqABjMzg+C2Z8eCUSiX0OQqeFbMLU=;
 b=k1Nv1ccMHx4gouAwfwMI5vYt/9ZJka+MYDTdXu5KDzI9tKjNqPZLRgpcJOU+CLykow
 Be5SXH5deXOXs/bHIpSxCe/dQQphWzwM1zIVWEhNOO81gV4BBXPiBw4JVnBb1yGy1/od
 6E5o2ClM+FmoEKNAXYcnpTO3ZD93r1mXrBztXlUsNuxAAarQ/yeCpzyKV4aPpl6GU5Uc
 7TxZ0NNgUg4sGMOWNkksLnN4oHTc2eCBv4lluB/iF0n3pHdORoK7dXOUKXmfO/S88C/N
 BHvkmEz8UnX1SuoOin9FRnb1Dj1K5Nvh2OUVbnV4DapKcR793BZD5bj5MfwQ6JatSd51
 cJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601905; x=1784206705;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CphY46F71fn6I5TqABjMzg+C2Z8eCUSiX0OQqeFbMLU=;
 b=YdR5EAy803Fkv5LZKZXfseQOwhAVs1KlGMHrQd1AWTbcmDMhpCuD6qg961GrNzVgn7
 MXzqfJl5ZosYJ+9+wsk6UI7RX/NUbvVKFBKUfDWFWCN//mW/vz370JH6ixBe20rA0dBM
 QzBiw3O1CdorwDEFDyp99V3jh6NHUgZOFJhaHgjDc6/TBFbV8Y8aq90lYsWxKIskEGPQ
 FtXaMEL8VyBi6Ep22L/NbHn17Q7oX6ZIgkISD8BJp5zAOPv1C8PiU2Phuov37RIh+V+7
 SI+jHSE7Ri7CwfplRaW7Crd5aMkjMUPcyv88snI2f8Ca/bJGi3er4F39xD11+fm91Z5P
 5v4w==
X-Gm-Message-State: AOJu0YwQTOphCQ6GN2q8FLpQ/tyKylNRrBUmUAFEQTy2RCBsrXvVZ+Zn
 J9s5QYF1YvCUj3wRvgZ52Vu2gfUpfVwXEKIMIHdwn2IaZTXe8jIurVblVwmwOLvttWg=
X-Gm-Gg: AfdE7cmNEFdJHwPkV9zqClht8BWIbL127Bu+E9IjDeRFFDxuwQ4NC2NoHi03VUF+j55
 Hd40WldYF1qqv20u/ZflgQnp0rX5pa5ZrdOh9+qlMpBHfg94gOkujfVKfsDdoYnTaW3XGK3rcR9
 J7i/zr47q6fadyyevCDqkxXeWWRSlcsemG0dhsNkA1i1Kwfq/rOC/0JPkEDhQKNzpXoOfM/TGno
 Rd9xmfBSgtG/Xc8B7nRSAYwB3erf/RdM62yf0xogvGYwcj7CmZhGnV7xBKeIxCt/2Spe9IN95vB
 TTzBpsD/mbts9M0DMc18dD8xuhOy0if8v0GqKE3N8r7xG3DhVeb9Ni5D7jhZ+AixMMPzBguPPFV
 Ms5j8J1N7nHNsvh85XpMLrVEqkBO2dbMEwVKDT55grOb9b8W0F0dEIDUZqeMwPSuXM37T2FuUkg
 4z0829xuEysbGnEb8HmS7mORn8t5f1kGtosNq0/e/CrP+5A8RLUUJf3CqWVo4X9u2iL4qgkqaMR
 B3DYIhYgB/kxRTfst5lhtiXVq0DYaqfCPIxcDDNbFxkBgWfQ/WOLdz3a0PuH+V89KZ5Nts=
X-Received: by 2002:a05:600c:3e1a:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-493f10cb669mr2749595e9.24.1783601904780; 
 Thu, 09 Jul 2026 05:58:24 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:17 +0200
Subject: [PATCH v2 11/14] power: domain: mediatek: rename struct
 mtk_scp_domain to mtk_scpsys
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-11-589ace7d30e2@baylibre.com>
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

Prepare for support of future MediaTek SoCs by renaming struct
mtk_scp_domain to struct mtk_scpsys.

Upcoming SoCs require additional per-domain runtime data obtained from
Device Tree. To keep the domain_data description in soc_data static
const, a new wrapper structure will be introduced to combine the
immutable domain_data description with the runtime data. The natural
name for that wrapper is struct mtk_scp_domain, so free that name by
renaming the existing runtime state structure to struct mtk_scpsys.

Update the MT7623 and MT7629 drivers accordingly.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mt2701-power-domain.c |  2 +-
 drivers/power/domain/mt7622-power-domain.c |  2 +-
 drivers/power/domain/mtk-power-domain.c    | 44 +++++++++++++++---------------
 drivers/power/domain/mtk-power-domain.h    |  2 +-
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/power/domain/mt2701-power-domain.c b/drivers/power/domain/mt2701-power-domain.c
index a6297401f6a..5bef4aa97ea 100644
--- a/drivers/power/domain/mt2701-power-domain.c
+++ b/drivers/power/domain/mt2701-power-domain.c
@@ -85,5 +85,5 @@ U_BOOT_DRIVER(mt2701_power_domain) = {
 	.ops = &mtk_power_domain_ops,
 	.probe = mtk_scpsys_probe,
 	.of_match = mt2701_power_domain_ids,
-	.priv_auto = sizeof(struct mtk_scp_domain),
+	.priv_auto = sizeof(struct mtk_scpsys),
 };
diff --git a/drivers/power/domain/mt7622-power-domain.c b/drivers/power/domain/mt7622-power-domain.c
index 339a896e19d..13f2154e145 100644
--- a/drivers/power/domain/mt7622-power-domain.c
+++ b/drivers/power/domain/mt7622-power-domain.c
@@ -52,5 +52,5 @@ U_BOOT_DRIVER(mt7622_power_domain) = {
 	.ops = &mtk_power_domain_ops,
 	.probe = mtk_scpsys_probe,
 	.of_match = mt7622_power_domain_ids,
-	.priv_auto = sizeof(struct mtk_scp_domain),
+	.priv_auto = sizeof(struct mtk_scpsys),
 };
diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index e0293aadfd8..3b0a90d3f94 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -43,12 +43,12 @@ static int mtk_infracfg_clear_bus_protection(void __iomem *infracfg,
 
 static int mtk_scpsys_domain_is_on(struct power_domain *power_domain)
 {
-	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpd->soc_data->data[power_domain->id];
-	u32 sta = readl(scpd->base + SPM_PWR_STATUS) &
-			data->sta_mask;
-	u32 sta2 = readl(scpd->base + SPM_PWR_STATUS_2ND) &
-			 data->sta_mask;
+	struct mtk_scpsys *scpsys = dev_get_priv(power_domain->dev);
+	const struct mtk_scp_domain_data *data = &scpsys->soc_data->data[power_domain->id];
+	u32 sta = readl(scpsys->base + SPM_PWR_STATUS) &
+		data->sta_mask;
+	u32 sta2 = readl(scpsys->base + SPM_PWR_STATUS_2ND) &
+		data->sta_mask;
 
 	/*
 	 * A domain is on when both status bits are set. If only one is set
@@ -64,14 +64,14 @@ static int mtk_scpsys_domain_is_on(struct power_domain *power_domain)
 
 static int mtk_scpsys_power_on(struct power_domain *power_domain)
 {
-	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpd->soc_data->data[power_domain->id];
-	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
+	struct mtk_scpsys *scpsys = dev_get_priv(power_domain->dev);
+	const struct mtk_scp_domain_data *data = &scpsys->soc_data->data[power_domain->id];
+	void __iomem *ctl_addr = scpsys->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
 	int ret, tmp;
 
-	writel(SPM_EN, scpd->base);
+	writel(SPM_EN, scpsys->base);
 
 	val = readl(ctl_addr);
 	val |= PWR_ON_BIT;
@@ -102,7 +102,7 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 		return ret;
 
 	if (data->bus_prot_mask) {
-		ret = mtk_infracfg_clear_bus_protection(scpd->infracfg,
+		ret = mtk_infracfg_clear_bus_protection(scpsys->infracfg,
 							data->bus_prot_mask);
 		if (ret)
 			return ret;
@@ -113,15 +113,15 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 
 static int mtk_scpsys_power_off(struct power_domain *power_domain)
 {
-	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpd->soc_data->data[power_domain->id];
-	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
+	struct mtk_scpsys *scpsys = dev_get_priv(power_domain->dev);
+	const struct mtk_scp_domain_data *data = &scpsys->soc_data->data[power_domain->id];
+	void __iomem *ctl_addr = scpsys->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
 	int ret, tmp;
 
 	if (data->bus_prot_mask) {
-		ret = mtk_infracfg_set_bus_protection(scpd->infracfg,
+		ret = mtk_infracfg_set_bus_protection(scpsys->infracfg,
 						      data->bus_prot_mask);
 		if (ret)
 			return ret;
@@ -161,16 +161,16 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 int mtk_scpsys_probe(struct udevice *dev)
 {
 	struct ofnode_phandle_args args;
-	struct mtk_scp_domain *scpd = dev_get_priv(dev);
+	struct mtk_scpsys *scpsys = dev_get_priv(dev);
 	struct regmap *regmap;
 	struct clk_bulk bulk;
 	int err;
 
-	scpd->base = dev_read_addr_ptr(dev);
-	if (!scpd->base)
+	scpsys->base = dev_read_addr_ptr(dev);
+	if (!scpsys->base)
 		return -ENOENT;
 
-	scpd->soc_data = (const struct mtk_scp_soc_data *)dev_get_driver_data(dev);
+	scpsys->soc_data = (const struct mtk_scp_soc_data *)dev_get_driver_data(dev);
 
 	/* get corresponding syscon phandle */
 	err = dev_read_phandle_with_args(dev, "infracfg", NULL, 0, 0, &args);
@@ -181,12 +181,12 @@ int mtk_scpsys_probe(struct udevice *dev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	scpd->infracfg = regmap_get_range(regmap, 0);
-	if (!scpd->infracfg)
+	scpsys->infracfg = regmap_get_range(regmap, 0);
+	if (!scpsys->infracfg)
 		return -ENOENT;
 
 	/* enable Infra DCM */
-	setbits_le32(scpd->infracfg + INFRA_TOPDCM_CTRL, DCM_TOP_EN);
+	setbits_le32(scpsys->infracfg + INFRA_TOPDCM_CTRL, DCM_TOP_EN);
 
 	err = clk_get_bulk(dev, &bulk);
 	if (err)
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index 830d6947962..689ec4d1657 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -80,7 +80,7 @@ static const struct mtk_scp_soc_data _name##_scp_soc_data = {	\
 	.num_domains = ARRAY_SIZE(_domains),			\
 }
 
-struct mtk_scp_domain {
+struct mtk_scpsys {
 	void __iomem *base;
 	void __iomem *infracfg;
 	const struct mtk_scp_soc_data *soc_data;

-- 
2.54.0

