Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8B3C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E0E84A77;
	Wed,  8 Jul 2026 19:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gxzTYT6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3962484A0B; Wed,  8 Jul 2026 15:07:18 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314C1849F0
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so579744f8f.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516036; x=1784120836; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f5vv2yZnanHZV9k8jzR0kQsJzsaq8RCJR5t6tc5ftx4=;
 b=gxzTYT6I/VpBLGPDH9FIo52xKZw1qQ5WR4D6nlr4URwfDkJ/n50vs+dfhSlZOw2zlj
 d+9ZL9O+P/Qrk+E5rlBFXsS06QLb4BgQWRBgOeEVgFwbXyfFLJRVKKOBWT/wsJW+0JQA
 CCZTYcXWQvZvPWjBxyUNnZDH6AFP+RERGytiddR+hqsg/IfSzixNCWYKv8A0WqsGh/YT
 zyIJXUHerTpWCcuHfbsom5xW1TGH5f29eWH9t0DwbDyQD/2T2INIm930AVVl+6KgpR/X
 rL1/torz2+KDWZzb323PJZcXN2Y9L239dkszjbIS4zR+7KZrDWX+Q0Q0l+hQcJmAnG6Y
 0J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516036; x=1784120836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f5vv2yZnanHZV9k8jzR0kQsJzsaq8RCJR5t6tc5ftx4=;
 b=R7iA2ARCOWDFF6UNa5sDZLE1y6zq8o2P8Xo+9az9TNVLwgFPVwyjHDA7DWTfeeUW4b
 nWuNjjXGbBimeh/tvJVzbbY739bXTjgDejPNDe++5sIGhim+z9bhYVu9sTba9QEjdmQl
 y0Dsoi4W/yRYyJYmfmTM3EZpr0g5Y4ZcJ9x6H9ioNzJWTyWFQR+/FU1UVvdcBbD+yjyp
 EzgQ2+3DXw47FEHIdA3Hr67AmBCy1UMfgtY9RtEBZAIknS/rW7ftM+qXXvGTYlnA3h7+
 i9MIVjtpiX6mwOloPIPo19xNQ51RsXASrKe3oI61oBzNm/bOoRQj7DPUWl/92SsBKzTQ
 ycGg==
X-Gm-Message-State: AOJu0YyrNY7FNuNn4FxW5KccBwnbgeIUSc6iIxyKb9O9zmIKd9vQ4W9f
 Vr4X4Vqg6EGsp0dNcWGryBlNrjkJDV8zZqLdf65x5YdmFfEU1SkYarFbhnKqQ0WjcsQ=
X-Gm-Gg: AfdE7ckSiCuRydC4SvudvgLWlqVRggYg6FcVQnulQWASk4uShAXpXUDFuDJwq+XuXcJ
 EXiNSKy/3Dff2bSLrSoPvzTCcrgvI2m4/CpYMbOxpSv29Kva1UslZ9E92UTTCRZMqoLt0Tudhzz
 kY8EUFBbf9ExYQyCy1+Dl1XuN652Qr40k4Pp9Hy8QbH+MKuB1vB2zkLN1Uf1HQEzejmffU37hxR
 YV0F+kER/Sh/TW98sAtMz56LEkhXYIogsXOl9iECrp03W8eJCMLFAjskY4I/FDSyzS1appnRKAJ
 OSOA90xZWHWjqxvHIBvqLc5IOXC6K5+oEork0nTjW0YHoHD/mGYx1g5KnCgLQe/axj1wBN/kZpG
 ++3Avq1WmU6NF+Cyv/NC2ByLuEiuaUB/ZwhreLNgJKuz5gshxwQ4jqS3BxjZ/6Wc9TUVQsgiQGC
 jr5fKtE9CGVqZKXydVrIwD0FPfUh6AKetJ3LZL9M9pFFH+E7SP4Jg7frjWAwg5pXpVaxWuBta/a
 BZFyislFGVXkl+Zog1zgs3X05xBRKkfquknuOL3UHzLCXlbGJ3KYnAgaH1IbPRi3i1ca4Q=
X-Received: by 2002:a05:6000:1a86:b0:47d:ec60:6581 with SMTP id
 ffacd0b85a97d-47df06e5b76mr2828822f8f.0.1783516035579; 
 Wed, 08 Jul 2026 06:07:15 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jul 2026 15:07:11 +0200
Subject: [PATCH 05/12] power: domain: mediatek: constify scp_domain_data
 instances
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mt8188-add-power-domain-v1-5-0e930b4f714e@baylibre.com>
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

Make all scp_domain_data instances static const by removing the mutable
scpd member from struct scp_domain_data.

Refactor mtk_scpsys_domain_is_on() to take struct power_domain as
parameter instead of struct mtk_scp_domain_data and remove
mtk_scpsys_power_request(), which only existed to associate a struct
scp_domain with struct scp_domain_data.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 34 +++++++++++----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index f3d79331474..aeb27d9bced 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -64,7 +64,6 @@
 struct mtk_scp_domain;
 
 struct mtk_scp_domain_data {
-	struct mtk_scp_domain *scpd;
 	u32 sta_mask;
 	int ctl_offs;
 	u32 sram_pdn_bits;
@@ -75,10 +74,10 @@ struct mtk_scp_domain_data {
 struct mtk_scp_domain {
 	void __iomem *base;
 	void __iomem *infracfg;
-	struct mtk_scp_domain_data *data;
+	const struct mtk_scp_domain_data *data;
 };
 
-static struct mtk_scp_domain_data scp_domain_mt7623[] = {
+static const struct mtk_scp_domain_data scp_domain_mt7623[] = {
 	[MT7623_POWER_DOMAIN_CONN] = {
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = SPM_CONN_PWR_CON,
@@ -131,7 +130,7 @@ static struct mtk_scp_domain_data scp_domain_mt7623[] = {
 	},
 };
 
-static struct mtk_scp_domain_data scp_domain_mt7629[] = {
+static const struct mtk_scp_domain_data scp_domain_mt7629[] = {
 	[MT7629_POWER_DOMAIN_ETHSYS] = {
 		.sta_mask = PWR_STATUS_ETHSYS,
 		.ctl_offs = SPM_ETHSYS_PWR_CON,
@@ -182,9 +181,10 @@ static int mtk_infracfg_clear_bus_protection(void __iomem *infracfg,
 				  !(val & mask), 100);
 }
 
-static int mtk_scpsys_domain_is_on(struct mtk_scp_domain_data *data)
+static int mtk_scpsys_domain_is_on(struct power_domain *power_domain)
 {
-	struct mtk_scp_domain *scpd = data->scpd;
+	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
+	const struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
 	u32 sta = readl(scpd->base + SPM_PWR_STATUS) &
 			data->sta_mask;
 	u32 sta2 = readl(scpd->base + SPM_PWR_STATUS_2ND) &
@@ -205,7 +205,7 @@ static int mtk_scpsys_domain_is_on(struct mtk_scp_domain_data *data)
 static int mtk_scpsys_power_on(struct power_domain *power_domain)
 {
 	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
+	const struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
 	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
@@ -220,7 +220,7 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 	val |= PWR_ON_2ND_BIT;
 	writel(val, ctl_addr);
 
-	ret = readx_poll_timeout(mtk_scpsys_domain_is_on, data, tmp, tmp > 0,
+	ret = readx_poll_timeout(mtk_scpsys_domain_is_on, power_domain, tmp, tmp > 0,
 				 100);
 	if (ret < 0)
 		return ret;
@@ -254,7 +254,7 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 static int mtk_scpsys_power_off(struct power_domain *power_domain)
 {
 	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
+	const struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
 	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
@@ -291,24 +291,13 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 	val &= ~PWR_ON_2ND_BIT;
 	writel(val, ctl_addr);
 
-	ret = readx_poll_timeout(mtk_scpsys_domain_is_on, data, tmp, !tmp, 100);
+	ret = readx_poll_timeout(mtk_scpsys_domain_is_on, power_domain, tmp, !tmp, 100);
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
 
-static int mtk_scpsys_power_request(struct power_domain *power_domain)
-{
-	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	struct mtk_scp_domain_data *data;
-
-	data = &scpd->data[power_domain->id];
-	data->scpd = scpd;
-
-	return 0;
-}
-
 static int mtk_power_domain_probe(struct udevice *dev)
 {
 	struct ofnode_phandle_args args;
@@ -321,7 +310,7 @@ static int mtk_power_domain_probe(struct udevice *dev)
 	if (!scpd->base)
 		return -ENOENT;
 
-	scpd->data = (struct mtk_scp_domain_data *)dev_get_driver_data(dev);
+	scpd->data = (const struct mtk_scp_domain_data *)dev_get_driver_data(dev);
 
 	/* get corresponding syscon phandle */
 	err = dev_read_phandle_with_args(dev, "infracfg", NULL, 0, 0, &args);
@@ -365,7 +354,6 @@ static const struct udevice_id mtk_power_domain_ids[] = {
 static const struct power_domain_ops mtk_power_domain_ops = {
 	.off = mtk_scpsys_power_off,
 	.on = mtk_scpsys_power_on,
-	.request = mtk_scpsys_power_request,
 };
 
 U_BOOT_DRIVER(mtk_power_domain) = {

-- 
2.54.0

