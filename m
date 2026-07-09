Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40597C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A68984B8D;
	Thu,  9 Jul 2026 15:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="kVFtfTLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 256F684ADD; Thu,  9 Jul 2026 14:58:19 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2137A84B01
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso1699600f8f.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601896; x=1784206696; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZQHWmtZMwA3gCnzSl9G5NJajvcsikb3m686Iy8epl6Q=;
 b=kVFtfTLw6hv8TcJP5MtG4mU7IO9/mS8MOHnpvTowOMA3wY3IF/49Oiu9qa0byvOr7K
 u8x7NSPtUsRab9TOyT5mT9J7r3qqDIZ7p7U6T2u1q5tFWtbkiZW/hWYYuI2zXQBXr6T6
 /XO9McSW4ZEU/RdLCIWAQRQUbO+3WaaJlAFPfrIVe17Pmi8MmOO7NY/nImvnhaHp4w6r
 dFYCZD7kk1ZZ5gzDPs/nYgvOOS9MGqZ1UTIvrgrENz62cfqO53gq8ls+o58qnQLPAinx
 SDE4vCdGh0qNiCq1dKcbL0aMLHH1ppJpOhDfpZm73wm6ADvk81+dQ5HjV7ATG14TLSpX
 l4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601896; x=1784206696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZQHWmtZMwA3gCnzSl9G5NJajvcsikb3m686Iy8epl6Q=;
 b=n2smTUG72TNn/d3Z8PSJFaFkGL+4/Y5aqHVLMZdvfspb7lKyLxi4yXJTTQyjrwIjFC
 ldAPTYq/ZzW3PSkE/h0tokrJDWlWALOughOe+oFaDq2MMH3neNQ/i++GSwn83y8S+XgM
 YjqjrntuHaX3HXO3v0LNRBMmguXThU614jmrFY5FlYEBwmlfcH0YzO+gZN9+gzwhpugV
 Bz4Nv8i+sRqyeNpAOWcVs664NXssgyLheFRTheiLSy0XkIfMgo+jGHOuqReit+keDcRC
 +Ms2GAvplVwKtDRqb8qmcKhbvlIzJg4Xos/YUV6hQ2oQAJ93XQ+DTMUnEyaPtWQ5r8+Y
 yymQ==
X-Gm-Message-State: AOJu0YxlRI2ohaO0b26wKraYwPNG+YknId/Rj6bkGQFtRnu9HKVd9v5L
 czDuJVVxFnDJ/pKkJ33mkkf4Rn9Oayitb625vE5drvDjyxt7FQaohhnIa0+4Z2sp/ow=
X-Gm-Gg: AfdE7cmnXq2pzbHSXV3wgtANNiv7OCVyqFJ+uzQGzF3gMmqiOV5eX7LU4TxrsTXWoi6
 vFJoLUGC982KB7HbZq4vj0TcK4diy4uNrLaKVifd5/MIa9VPQM4TJ8fdbDG07eiaRpGjYIrSU0U
 Qh5PKxaHp8ocjML3m7eLxTLAGAN4l/MsxlA3sz3cfmgxmFggW1Sgz0LEAkZ2nXVc6P59VNGYB8x
 vHQHa5dznnxSfyTEUbNhtHBXE0Y0dw2Un9dgHztt4upQBNCJ6uxDfJkRFZxt1DV8mcs7BIWtau2
 HftxS6aeo8Ox5nqhxPYV7JkdWPTj0T0jBDvHiOf5RzxnbQ9dRkQqZ9ALWMhVNIUgObKSdPYYAq8
 dT/wvFXzcFtPdL/os5J3EjSxfdZLxyjFe64FZL2rjxQPOIaUTo2g+J/v/IbZKk7yDP3KavS+J02
 i6I3XhobcyC0kaTghmldnC9KkT4zU9F7i8cN4vnjC5E6y+PzJYdrI/yFBLHGdy3D3EKV1cv7Fbg
 OgYeGxaZPLaZ/O6ciHoX1uD8dMaf8+YpZsHGkXu3ous4ezEe7cpoivyLxgjKSRcLDBjvEs=
X-Received: by 2002:a05:6000:2f86:b0:46e:8226:96ba with SMTP id
 ffacd0b85a97d-47df07469bbmr8198309f8f.13.1783601896542; 
 Thu, 09 Jul 2026 05:58:16 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:16 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:13 +0200
Subject: [PATCH v2 07/14] power: domain: mediatek: constify scp_domain_data
 instances
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-7-589ace7d30e2@baylibre.com>
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
index 636d016a09c..18a45a131b8 100644
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
 
-static struct mtk_scp_domain_data scp_domain_mt2701[] = {
+static const struct mtk_scp_domain_data scp_domain_mt2701[] = {
 	[MT2701_POWER_DOMAIN_CONN] = {
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = SPM_CONN_PWR_CON,
@@ -131,7 +130,7 @@ static struct mtk_scp_domain_data scp_domain_mt2701[] = {
 	},
 };
 
-static struct mtk_scp_domain_data scp_domain_mt7622[] = {
+static const struct mtk_scp_domain_data scp_domain_mt7622[] = {
 	[MT7622_POWER_DOMAIN_ETHSYS] = {
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

