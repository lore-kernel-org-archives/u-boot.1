Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818A2C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CD384AA4;
	Wed,  8 Jul 2026 19:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="NnYL6klL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F625849F0; Wed,  8 Jul 2026 15:07:30 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 124AA849F6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-474560436c3so627000f8f.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516047; x=1784120847; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NA95gP4cLpRoEWPOeniEOILdGdFjCYLrK9hDyTjT+Pc=;
 b=NnYL6klLRMDUq2D/2mm7OZi3tv3Fbg60RGjsXdjUzY1dUcGc51qXcSPewfWYsMWA38
 rDbH8fNppLiRdQMq0DvY1edHDVuKVVNzhmmw+P9jNrRrQoCQwhwnH93c8hGxRQ143js/
 FroPlU08jSIEcosBesWNXbfO7ezFegqBTpOKYayR8frIs1gt6T4+ZvCO1yeufhVRuwL/
 MdqXyNDL4O5WuwA/od9uye4CGfuc58nDj7veNENS5lmASBaJtE+4Tr/Uym2+fIidszoW
 d99YuUa+D+6qWu5pNE4sxVSGpVfeslArvb477MGkNgme0ojNMA0MVH7OIyaxi6aFe4Z8
 G+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516047; x=1784120847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NA95gP4cLpRoEWPOeniEOILdGdFjCYLrK9hDyTjT+Pc=;
 b=MVmxU27nsYS91+CL9qkmBU5mFzZH2CcxLRfusGo/RAKJIO30vVqEC68wcwvfxeEF4b
 kHlXTJcD+KXasejhuOMY6AAeHI6SUy4KdibmSpA0XOIOnTEHZfxLv4HIM2kLA0lmd06c
 LKtrgKwn1zGoVVVaZOxFUSVsWPlvX79voPq+NxUX+vcXa2eYDFDGuGkWDgURktjMAjix
 GTr3rVfS/5+RTKTsoRxSMeS13oHk3LfMmtsJ3RvLqosgdWwna3JrTich1TlSC4cD8yr2
 eN2esm98FiLCdxoVm7bW0y9ThLv0bubT/KUuxwb5q6BFfife/89/Iyr/P9pVe6M+1Z6W
 Qi9Q==
X-Gm-Message-State: AOJu0Yz82+3aNzQbKLrCJsn+XyRVWzz0TDJlGb+LMxpp28AEpGVZex9r
 IUIMAh6a+spIUOiMVuzIEYy0PiyJogrKgFstpQVy1Dgww3j/JgcNSovXgmcXzUlxHWw=
X-Gm-Gg: AfdE7cl+r8oiiEwTcwAAufJMo/84InKGqpvZpvljCwNNnI6E9joEbqkj/9Ok2inU8h+
 fXRXI7xIGpkXAoYF8hxA6dpGM/iN4BQJ0gtsDRjxYg+XHKLRefZNOMevWy5M/7yk2gyCdCRvvVN
 1zPV9f0lBB+HpSFDsDGQ3MOJS+8g85Weh27PF31wy9ZjIStpPPHL5rgq8Cxd3QxN/Ntgxlqf8kj
 HLbyDVt1FArH1DPp1v6XSJRTIF1w7h57QBZlyi7SohdBCVLuGsCGN8rnPug5ACfLcbAQNFryRmW
 u3fZnzTKLFAK8hxc6T0PDWHMHxa9GdBK5lXBLFBY6KivUDZZjA2DpsxDa3ZKd9yFY1GQeblCycR
 d3FZYoQKKTzeKPhNmGLkU2Lo9xjYouzapP9mSbVynMvJDscUwIDYJgfzaDYQVwHStzHuoF5Q+Uw
 yLqmR7Fqr/1J2UROOZflBIg8cu38VczPqGlIOIfwjTB5eTgZ/nWSiZpFBAxNVB+1qG2dbWFXbsg
 TMptpuyZmGImFaJtY06Zm3v+sWdX4jflASb+VcYVRLVyaHZZbyiVTF/dlNkJd3u7SJRp6k=
X-Received: by 2002:a05:6000:2084:b0:46f:558:a42a with SMTP id
 ffacd0b85a97d-47df078bc0amr2732128f8f.34.1783516047402; 
 Wed, 08 Jul 2026 06:07:27 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jul 2026 15:07:15 +0200
Subject: [PATCH 09/12] power: domain: mediatek: rename struct
 mtk_scp_domain to mtk_scpsys
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mt8188-add-power-domain-v1-9-0e930b4f714e@baylibre.com>
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
 drivers/power/domain/mt7623-power-domain.c |  2 +-
 drivers/power/domain/mt7629-power-domain.c |  2 +-
 drivers/power/domain/mtk-power-domain.c    | 44 +++++++++++++++---------------
 drivers/power/domain/mtk-power-domain.h    |  2 +-
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/power/domain/mt7623-power-domain.c b/drivers/power/domain/mt7623-power-domain.c
index 318f0fc8e76..b47ad4cde47 100644
--- a/drivers/power/domain/mt7623-power-domain.c
+++ b/drivers/power/domain/mt7623-power-domain.c
@@ -81,5 +81,5 @@ U_BOOT_DRIVER(mt7623_power_domain) = {
 	.ops = &mtk_power_domain_ops,
 	.probe = mtk_scpsys_probe,
 	.of_match = mt7623_power_domain_ids,
-	.priv_auto = sizeof(struct mtk_scp_domain),
+	.priv_auto = sizeof(struct mtk_scpsys),
 };
diff --git a/drivers/power/domain/mt7629-power-domain.c b/drivers/power/domain/mt7629-power-domain.c
index 6cc413b7a89..2f7f462579a 100644
--- a/drivers/power/domain/mt7629-power-domain.c
+++ b/drivers/power/domain/mt7629-power-domain.c
@@ -56,5 +56,5 @@ U_BOOT_DRIVER(mt7629_power_domain) = {
 	.ops = &mtk_power_domain_ops,
 	.probe = mtk_scpsys_probe,
 	.of_match = mt7629_power_domain_ids,
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

