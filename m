Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B688C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBAB84A67;
	Wed,  8 Jul 2026 19:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="B4Ypa0k/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31C4849F6; Wed,  8 Jul 2026 15:07:15 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1E2849F0
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso501474f8f.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516033; x=1784120833; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=olBHJMgexmPZRcpAaOsIoWjgp2T9T+CeqBDw2wT8dFo=;
 b=B4Ypa0k/WG800Ok1UNTfCaNp5y/b5DNQhC6ETK5eLX5Xcid1u+poxt0Cwd6vmE6SJ2
 Zr0fH+rMjOjqRsMEXp0aozQfUfA0kbSYa/L3J2dG/Db6eY040MhoVYNRF0fuvZkUWFia
 iJH/OfvoIjHCtGFO5zGAbhWYMNixDjPY1wHHUDI+ZSf4ULYj0pvPhRED1exix1j2+58u
 9IGKKHV6M3gYiwMyo9gDgQoQgDrCABCV1QNOHBLk1n+z7f87ktx5OUJUcRtWbSd59e8B
 rXgfI/3aJe+o9s1HJyUNrF+fg8Ue8oEreORG89DUuIkz9hyO2Ekshk08cEQ5GKT2q8G1
 LTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516033; x=1784120833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=olBHJMgexmPZRcpAaOsIoWjgp2T9T+CeqBDw2wT8dFo=;
 b=jlW+NtHX3b5CrdY/zvS30MC4/J8j4LPrfn7kQZ0DJSNXWLSUTH9NoD+p6gGSmEMo47
 ZBJXzqwpChc3xyJMzqfqhapSbUubOydLJvWNiR7W82vuzApzdJSAIeG94Hp0dBb1sbBY
 QgytQVykwBTKBLbxjMEy0eKvQ+onv5OmpNVJLrYPTXWRerS3/U+ejwNfh7OT3anLBZsq
 8q8NoyjkpbZ6lyuo4gYP4r6ua40Xbni7ye2NvD4n0b184U0+0MnOG4Hn0Coq98Xn3Ora
 P500v7KdbYAxKNzGU0F+S82OTbKcZkPhbjxzsHHuOw8PAgTpyU0y/P0mrXfWJQy731cw
 SRyg==
X-Gm-Message-State: AOJu0YxZIRDtHVQXdtzGD6m5MZS4Rcminpk4bEtKkyD/IkBqPkIBgmC4
 QvN7H05F15uem5R46cAChYeYxL6ftfp70a58WnrphHYbZd8fQtYs9xoGFs1qWY96RN8=
X-Gm-Gg: AfdE7cnTEBwyic/7OqxXYcQtYCQVlJaEHmXZFkS3cinVi88IZ6qVTU2G4YPNmEFRbyT
 dGEjsPfsmoKXlTjfgHyseyDwitiYnmqaeh9xdE0Y8J/mRZUpU/OdnewHbmr3Kd/FbmBWdT8f4dj
 J7+YfvI52L4LL34WZTg6zCyyoIhRFSXatkbe7TnxW4L6OZmXMqc3YQOo6DWAghU6H9QI/oGYYwI
 9mlEA9XZQtGViphq5/lj8JzFnvedQlu+CVI+dVdvIjdZXB5WfycOL8eK7FAvL++1mdukD9VslUw
 vm8XAzC3iv1KTXjwl1nHbQHp3gCR7szedgKMrzVyKNhIi1mYT0n8y4dqlGz5YS6wPM9rVfJbiGU
 0AF6hVdvxqmGoau0SyYVsVzk7ZFITT32C5Ir6ALrd0K3U7H4yTvwpp/QHyJ8FYDqIQDiy6qk7ms
 /gE/tuVizCeORqTWbPYU3g40SjXQ6OmfCV5r5yDEwj9OA4vT/7Kv/eogrnqJcxbiajuSCHzi4J9
 PxVfZeyForSkjIJC2SfpfLbU+bGP45TulVCGcZMHsmJR/qolUzDr4RvUQ7uJpwWEn95uVg=
X-Received: by 2002:a05:6000:603:b0:475:f0c2:75b4 with SMTP id
 ffacd0b85a97d-47df028da28mr3063357f8f.31.1783516032869; 
 Wed, 08 Jul 2026 06:07:12 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:12 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jul 2026 15:07:10 +0200
Subject: [PATCH 04/12] power: domain: mediatek: prefix internal identifiers
 with mtk_
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mt8188-add-power-domain-v1-4-0e930b4f714e@baylibre.com>
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

Prefix internal functions, variables, and struct tags with the mtk_
prefix to avoid namespace collisions.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 52 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 16a97094303..f3d79331474 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -61,10 +61,10 @@
 
 #define DCM_TOP_EN		BIT(0)
 
-struct scp_domain;
+struct mtk_scp_domain;
 
-struct scp_domain_data {
-	struct scp_domain *scpd;
+struct mtk_scp_domain_data {
+	struct mtk_scp_domain *scpd;
 	u32 sta_mask;
 	int ctl_offs;
 	u32 sram_pdn_bits;
@@ -72,13 +72,13 @@ struct scp_domain_data {
 	u32 bus_prot_mask;
 };
 
-struct scp_domain {
+struct mtk_scp_domain {
 	void __iomem *base;
 	void __iomem *infracfg;
-	struct scp_domain_data *data;
+	struct mtk_scp_domain_data *data;
 };
 
-static struct scp_domain_data scp_domain_mt7623[] = {
+static struct mtk_scp_domain_data scp_domain_mt7623[] = {
 	[MT7623_POWER_DOMAIN_CONN] = {
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = SPM_CONN_PWR_CON,
@@ -131,7 +131,7 @@ static struct scp_domain_data scp_domain_mt7623[] = {
 	},
 };
 
-static struct scp_domain_data scp_domain_mt7629[] = {
+static struct mtk_scp_domain_data scp_domain_mt7629[] = {
 	[MT7629_POWER_DOMAIN_ETHSYS] = {
 		.sta_mask = PWR_STATUS_ETHSYS,
 		.ctl_offs = SPM_ETHSYS_PWR_CON,
@@ -182,9 +182,9 @@ static int mtk_infracfg_clear_bus_protection(void __iomem *infracfg,
 				  !(val & mask), 100);
 }
 
-static int scpsys_domain_is_on(struct scp_domain_data *data)
+static int mtk_scpsys_domain_is_on(struct mtk_scp_domain_data *data)
 {
-	struct scp_domain *scpd = data->scpd;
+	struct mtk_scp_domain *scpd = data->scpd;
 	u32 sta = readl(scpd->base + SPM_PWR_STATUS) &
 			data->sta_mask;
 	u32 sta2 = readl(scpd->base + SPM_PWR_STATUS_2ND) &
@@ -202,10 +202,10 @@ static int scpsys_domain_is_on(struct scp_domain_data *data)
 	return -EINVAL;
 }
 
-static int scpsys_power_on(struct power_domain *power_domain)
+static int mtk_scpsys_power_on(struct power_domain *power_domain)
 {
-	struct scp_domain *scpd = dev_get_priv(power_domain->dev);
-	struct scp_domain_data *data = &scpd->data[power_domain->id];
+	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
+	struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
 	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
@@ -220,7 +220,7 @@ static int scpsys_power_on(struct power_domain *power_domain)
 	val |= PWR_ON_2ND_BIT;
 	writel(val, ctl_addr);
 
-	ret = readx_poll_timeout(scpsys_domain_is_on, data, tmp, tmp > 0,
+	ret = readx_poll_timeout(mtk_scpsys_domain_is_on, data, tmp, tmp > 0,
 				 100);
 	if (ret < 0)
 		return ret;
@@ -251,10 +251,10 @@ static int scpsys_power_on(struct power_domain *power_domain)
 	return 0;
 }
 
-static int scpsys_power_off(struct power_domain *power_domain)
+static int mtk_scpsys_power_off(struct power_domain *power_domain)
 {
-	struct scp_domain *scpd = dev_get_priv(power_domain->dev);
-	struct scp_domain_data *data = &scpd->data[power_domain->id];
+	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
+	struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
 	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
@@ -291,17 +291,17 @@ static int scpsys_power_off(struct power_domain *power_domain)
 	val &= ~PWR_ON_2ND_BIT;
 	writel(val, ctl_addr);
 
-	ret = readx_poll_timeout(scpsys_domain_is_on, data, tmp, !tmp, 100);
+	ret = readx_poll_timeout(mtk_scpsys_domain_is_on, data, tmp, !tmp, 100);
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
 
-static int scpsys_power_request(struct power_domain *power_domain)
+static int mtk_scpsys_power_request(struct power_domain *power_domain)
 {
-	struct scp_domain *scpd = dev_get_priv(power_domain->dev);
-	struct scp_domain_data *data;
+	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
+	struct mtk_scp_domain_data *data;
 
 	data = &scpd->data[power_domain->id];
 	data->scpd = scpd;
@@ -312,7 +312,7 @@ static int scpsys_power_request(struct power_domain *power_domain)
 static int mtk_power_domain_probe(struct udevice *dev)
 {
 	struct ofnode_phandle_args args;
-	struct scp_domain *scpd = dev_get_priv(dev);
+	struct mtk_scp_domain *scpd = dev_get_priv(dev);
 	struct regmap *regmap;
 	struct clk_bulk bulk;
 	int err;
@@ -321,7 +321,7 @@ static int mtk_power_domain_probe(struct udevice *dev)
 	if (!scpd->base)
 		return -ENOENT;
 
-	scpd->data = (struct scp_domain_data *)dev_get_driver_data(dev);
+	scpd->data = (struct mtk_scp_domain_data *)dev_get_driver_data(dev);
 
 	/* get corresponding syscon phandle */
 	err = dev_read_phandle_with_args(dev, "infracfg", NULL, 0, 0, &args);
@@ -363,9 +363,9 @@ static const struct udevice_id mtk_power_domain_ids[] = {
 };
 
 static const struct power_domain_ops mtk_power_domain_ops = {
-	.off = scpsys_power_off,
-	.on = scpsys_power_on,
-	.request = scpsys_power_request,
+	.off = mtk_scpsys_power_off,
+	.on = mtk_scpsys_power_on,
+	.request = mtk_scpsys_power_request,
 };
 
 U_BOOT_DRIVER(mtk_power_domain) = {
@@ -374,5 +374,5 @@ U_BOOT_DRIVER(mtk_power_domain) = {
 	.ops = &mtk_power_domain_ops,
 	.probe = mtk_power_domain_probe,
 	.of_match = mtk_power_domain_ids,
-	.priv_auto	= sizeof(struct scp_domain),
+	.priv_auto	= sizeof(struct mtk_scp_domain),
 };

-- 
2.54.0

