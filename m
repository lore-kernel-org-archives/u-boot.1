Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F0DC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C6084B85;
	Thu,  9 Jul 2026 15:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="dci1S6wN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C0684AFF; Thu,  9 Jul 2026 14:58:17 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1938C84ADD
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47362928f65so770813f8f.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601894; x=1784206694; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AWB3VglY3RHe1xGr2+JxrJnhcyhc4iuD25cvIWzqVqU=;
 b=dci1S6wNu9mx+VCeA95iGFaGGYv/9KuUejVrXDHCtzANdWOx+FbjNv4o847Tl7Vkm3
 fElGkjPKcSV9KSiA1/ynjEBdHrO79V3yZyKbdHKqRo4VE8vWEGLqZaYWOFSzJnC7YhiW
 Um8/qCc/EM4FR/448hAekl4YMuM3MdLARq2hDp/eKx2ScPovwZZ+399scwZvD+WJiKI4
 RAnw+WRLYXTYX4c8yt6DuYg8Bwx4NoQMhbh+0qlcXDqSZb2zDpOD/asGSlgyJHgnP5WD
 B/JnL/u6wJ5AOFt7E51wcFcd6evfkeW27LDZ7jVfFdszenI7IXN1kZrN5RHFvxpmktqb
 fhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601894; x=1784206694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AWB3VglY3RHe1xGr2+JxrJnhcyhc4iuD25cvIWzqVqU=;
 b=ixI05BSZC9kCLlEWNx+f6UUN6QeD8OfDZ4+XZxBd8M+XXvEqy5ZPkrXwSQi1X0U42C
 zwWDi2lLYNaTTMoPXfinfwMTYD53Oa36yKGlw2+mM6ybBc/GVEgHkWBwDgPPipkTueEM
 wWeaNW0rcWd/IIMlp+eu7X6ihNoCnkrlZfj+EqNBGdMf4unsUEVp43KE8dsTfTIeumkG
 P2ijkYSZ/lExSXTfpU+lGaGe1nXcEuNMn8wsvorrz3v11wIut4W2n4pivybtac4yriM7
 yF9n7mzzG4+LiIvi91lDjvn817V4nvWEwxuiWQ0E0PYDyFPS2J3PUlhpoUDDwQO8DJqs
 +qDA==
X-Gm-Message-State: AOJu0YyuT77bwYG2fx+qslj1qGywUKl3gPlhNJ42uQQLBv2MySHAmjOi
 nQLBZKxJHxBeWI3bPWK+ddFSA9v7KHAaCyZrMLG1LGdoteuhP++6RW5+pb8f5vRLR58=
X-Gm-Gg: AfdE7clAGr4e//nelP+Mcp3+2Ll1FnpAGM4+hnzVmx1EzzDGMmyRp6wEEB+ZZTlJ195
 DvMEZaS9nGEJz12pWkBNal1Yk+MLDyXwkzWBtufWGvUVVdrJLrHZsewd/XeUpunuuFNZzQBm1Dr
 sOFor3O6N0tmyCNfwAIrFIV3l5ran6RJvX7kUkN7M6QG1yzWB9D7NY0j22QQi4rRbSXGgUNpKr2
 uwOXq55t0CUK4wQx3r2t+AY8VG81xSgtDufjs8lCXKm7rPVUfAnrgHj4Hs34/lW+1c3A3e7TKUC
 c9wX8suLULnDT5ZXkJoOfmLijI4vyCCdgnPTPM1mXJQh+hVSjqrpkap2f9DTJcxpD0XdR7wVJZ4
 QDtepLn4c77AT3UROb9+H/Kb6njoKUYqPjVPUdXYDCm8+R2bOQaflSQ79vOLiyYWtKjfTMgRELL
 KVSjteUAOlYgwvEi/FBY7t7T16yGDxwaDvsHuV2tEHTETjIDQwsXLn7y1agMA8XpTUYvkPS6T3z
 D4yQNZ5JAGkRfY5ykeyn6S1gaF0g1vkdOpfJpKbU8MBM+KKLBiO9fVmaDp2KhkcT7SR0Zs=
X-Received: by 2002:adf:e193:0:b0:474:83d4:9916 with SMTP id
 ffacd0b85a97d-47df075a172mr7551109f8f.17.1783601894495; 
 Thu, 09 Jul 2026 05:58:14 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:12 +0200
Subject: [PATCH v2 06/14] power: domain: mediatek: prefix internal
 identifiers with mtk_
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-6-589ace7d30e2@baylibre.com>
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

Prefix internal functions, variables, and struct tags with the mtk_
prefix to avoid namespace collisions.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 52 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index dc326cd8c94..636d016a09c 100644
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
 
-static struct scp_domain_data scp_domain_mt2701[] = {
+static struct mtk_scp_domain_data scp_domain_mt2701[] = {
 	[MT2701_POWER_DOMAIN_CONN] = {
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = SPM_CONN_PWR_CON,
@@ -131,7 +131,7 @@ static struct scp_domain_data scp_domain_mt2701[] = {
 	},
 };
 
-static struct scp_domain_data scp_domain_mt7622[] = {
+static struct mtk_scp_domain_data scp_domain_mt7622[] = {
 	[MT7622_POWER_DOMAIN_ETHSYS] = {
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

