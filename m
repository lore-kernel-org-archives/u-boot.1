Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84567C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FAD784BB9;
	Thu,  9 Jul 2026 15:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="iatclPIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B43D084B2C; Thu,  9 Jul 2026 14:58:29 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7083D84ADD
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47df4e62d2bso386337f8f.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601907; x=1784206707; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CEZ7l5Ft5jiqeBS15sLUKnOvi+SSitpi6RJ1DCAw4p4=;
 b=iatclPItfRey9QLhs7pLbUVXn3dGzV+AcPTtyR6iIKjOlYwziZ4mNFHLHrJ+U6vw1H
 jQ6BPYY66G53YTTMCewObcATPF7IwG6T5xmGeTSeMDQpe1B+dvF9aFrbxBJ8hB/RouMK
 nX9mHPUYOfJCEy5Xn3stb+6gkSROAyobIpVMP2jYUs3ofPHAYebzfks9Aw+SXsIQkW8B
 Bsj4rgTxNvdbG8dcml3NL44yjziFbl/wJghaZ1oMeNG0J6CyjONPbX9zm6cDi60R1Veb
 RZjbyXWA+SGiWD9yLnoxJXX7SXYTx2dOz3PkEPRX16BLI2jOnNZu9UDzN620kv/CsNcL
 5d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601907; x=1784206707;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CEZ7l5Ft5jiqeBS15sLUKnOvi+SSitpi6RJ1DCAw4p4=;
 b=LkvvDMbFfdqUk+WASHVqoYqLLxUfrOLDb1pSl4rLyW+sR3ongT+8UJttIHw/NHus5b
 GU76PczUVaffp4oKsjNCNeUkRXu1VyyE659kfsxuinp3xKU+EQLMpE23Tlj+SPY1YM8W
 Klk90YeUi+H9jd6jKH19OeT7Rhw97iUmOCo25zNDW1Dv83YkohQTvZmHZ2XcnLSakZqK
 5rFq1AjovyOw6J7sDk9fPnOwHG3vfW9GQx/seL2raOhjGxzh6dMaBTr0QKiTDzIb8hD9
 X/HijDH5OuTd9yQxbH/KhVq/yKjc+KOIosspPIJsolnpU2eTPRi0AnxElJ+9T+wcTogr
 FZ2A==
X-Gm-Message-State: AOJu0YwlUB4/5J5x4EGl13zla+07AIrMvZQFZXd3EQZ55WmQZfPLHY6i
 lIHqsUtiu31koKHjOWo/PEc/8wtB+o4VBswjCfDCp6clvlkOxQDiRHFO9QGNQyVlOdU=
X-Gm-Gg: AfdE7cngUlQYlhW3LggNMtFE8QRQVEhrXE5a3KsPwBG0r4I+m+Vc8vWN0/QsrDCp29J
 54a5Z16/RuTjSokYoYipfcf+SxMwrwAQVeH+psnBce3p5Gaj4ZGKG++ORhASVYeaUTeyeuVK1y+
 ywpYcNHnjmrcNwW17KyB6IQJeviIaJxgUHVFQKyR9nfsES6a7P6xAeSQlEch6jtiUusdxFM1PZC
 ve9C7YhnqyjrvlYqHNaMWbRK0ZuMYKkGc+Ie6o6J0Qw2JYARcITQs+bijawS6/g3YBArXj6cqa7
 yF8vUOwEDYUJoQUNC97nReS70Ft8U1H2EvJVyLlLQ6HoXe+fpQ5Np6dpKmgW9gew/U+aV/bRJCM
 FMPXdBllzV6s0OOv9Z4N4LmGDex1lVM8FyTkDAJT4Iq3HrlptKNiiESs9H7vXg5SZy27v3OexL/
 HWvw0pqeT91b6nvK0rz3hD/hn18kCfRKcngD8Z2oOhouXYxcbxeGHKBeCYhdMJIlSm5KzK1Bu7u
 lvtg/fXTucq/7a+0GOR0oK8gTpRvJhTjaOk7r4R+xI+jbL2xcN0JdDT1qWE+LYQkBSxHqQ=
X-Received: by 2002:a05:6000:2002:b0:475:94e1:29d5 with SMTP id
 ffacd0b85a97d-47df0723560mr7663400f8f.20.1783601906857; 
 Thu, 09 Jul 2026 05:58:26 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:18 +0200
Subject: [PATCH v2 12/14] power: domain: mediatek: add support for the
 power-controller model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-12-589ace7d30e2@baylibre.com>
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

The current driver handles a flat scpsys node with a single, fixed set
of power status registers and one infracfg bus-protection mask. Newer
MediaTek SoCs describe their domains as child nodes of a power
controller and need a richer model:

  - per-domain power status register offsets (pwr_sta_offs /
    pwr_sta2nd_offs), falling back to the legacy SPM_PWR_STATUS
    registers when not set;
  - an ordered list of bus-protection steps (scpsys_bus_prot_data /
    BUS_PROT_WR), each with its own set/clear/status register, applied
    on power-off and released in reverse on power-on;
  - per-domain clocks and an optional parent power domain.

Add mtk_power_controller_probe(), which walks the controller's subnodes,
resolves each domain's id, clocks and infracfg, and builds the domain
tree. The existing flat probe (mtk_scpsys_probe) is left unchanged.

No functional change for the existing MT7623/MT7629 drivers.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 333 ++++++++++++++++++++++++++++++--
 drivers/power/domain/mtk-power-domain.h |  38 ++++
 2 files changed, 357 insertions(+), 14 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 3b0a90d3f94..9eef58d2d57 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -11,6 +11,8 @@
 #include <asm/io.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
 
 #include "mtk-power-domain.h"
 
@@ -41,14 +43,79 @@ static int mtk_infracfg_clear_bus_protection(void __iomem *infracfg,
 				  !(val & mask), 100);
 }
 
+static int _scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
+				      void __iomem *reg)
+{
+	u32 val = 0, mask = bpd->bus_prot_mask;
+
+	if (!mask)
+		return 0;
+
+	if (bpd->bus_prot_reg_update)
+		clrsetbits_le32(reg + bpd->bus_prot_set, mask, mask);
+	else
+		writel(mask, reg + bpd->bus_prot_set);
+
+	return readl_poll_timeout(reg + bpd->bus_prot_sta, val, (val & mask) == mask, 1000);
+}
+
+static int _scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bpd,
+				       void __iomem *reg)
+{
+	u32 val = 0, mask = bpd->bus_prot_mask;
+
+	if (!mask)
+		return 0;
+
+	if (bpd->bus_prot_reg_update)
+		clrbits_le32(reg + bpd->bus_prot_clr, mask);
+	else
+		writel(mask, reg + bpd->bus_prot_clr);
+
+	if (bpd->ignore_clr_ack)
+		return 0;
+
+	return readl_poll_timeout(reg + bpd->bus_prot_sta, val, !(val & mask), 1000);
+}
+
+static int scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
+				     int bpd_size, void __iomem *reg)
+{
+	int ret, i;
+
+	for (i = 0; i < bpd_size; i++) {
+		ret = _scpsys_bus_protect_enable(&bpd[i], reg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bpd,
+				      int bpd_size, void __iomem *reg)
+{
+	int i, ret;
+
+	for (i = bpd_size - 1; i >= 0; i--) {
+		ret = _scpsys_bus_protect_disable(&bpd[i], reg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int mtk_scpsys_domain_is_on(struct power_domain *power_domain)
 {
 	struct mtk_scpsys *scpsys = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpsys->soc_data->data[power_domain->id];
-	u32 sta = readl(scpsys->base + SPM_PWR_STATUS) &
-		data->sta_mask;
-	u32 sta2 = readl(scpsys->base + SPM_PWR_STATUS_2ND) &
-		data->sta_mask;
+	const struct mtk_scp_domain_data *data = scpsys->domains[power_domain->id].data;
+	u32 spm_pwr_status = data->pwr_sta_offs ?: SPM_PWR_STATUS;
+	u32 spm_pwr_status_2nd = data->pwr_sta2nd_offs ?: SPM_PWR_STATUS_2ND;
+	u32 sta, sta2;
+
+	sta = readl(scpsys->base + spm_pwr_status) & data->sta_mask;
+	sta2 = readl(scpsys->base + spm_pwr_status_2nd) & data->sta_mask;
 
 	/*
 	 * A domain is on when both status bits are set. If only one is set
@@ -65,12 +132,36 @@ static int mtk_scpsys_domain_is_on(struct power_domain *power_domain)
 static int mtk_scpsys_power_on(struct power_domain *power_domain)
 {
 	struct mtk_scpsys *scpsys = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpsys->soc_data->data[power_domain->id];
-	void __iomem *ctl_addr = scpsys->base + data->ctl_offs;
-	u32 pdn_ack = data->sram_pdn_ack_bits;
+	struct mtk_scp_domain *domain;
+	const struct mtk_scp_domain_data *data;
+	void __iomem *ctl_addr;
+	void __iomem *infracfg;
+	u32 pdn_ack;
 	u32 val;
 	int ret, tmp;
 
+	if (power_domain->id >= scpsys->soc_data->num_domains)
+		return -EINVAL;
+
+	domain = &scpsys->domains[power_domain->id];
+	data = domain->data;
+	if (!data)
+		return -EINVAL;
+
+	ctl_addr = scpsys->base + data->ctl_offs;
+	infracfg = domain->infracfg ? domain->infracfg : scpsys->infracfg;
+	pdn_ack = data->sram_pdn_ack_bits;
+
+	if (domain->has_pd) {
+		ret = power_domain_on(&domain->parent_pd);
+		if (ret)
+			return ret;
+	}
+
+	ret = clk_enable_bulk(&domain->clks);
+	if (ret)
+		return ret;
+
 	writel(SPM_EN, scpsys->base);
 
 	val = readl(ctl_addr);
@@ -94,6 +185,10 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 	val |= PWR_RST_B_BIT;
 	writel(val, ctl_addr);
 
+	ret = clk_enable_bulk(&domain->subsys_clks);
+	if (ret)
+		return ret;
+
 	val &= ~data->sram_pdn_bits;
 	writel(val, ctl_addr);
 
@@ -102,11 +197,14 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 		return ret;
 
 	if (data->bus_prot_mask) {
-		ret = mtk_infracfg_clear_bus_protection(scpsys->infracfg,
+		ret = mtk_infracfg_clear_bus_protection(infracfg,
 							data->bus_prot_mask);
 		if (ret)
 			return ret;
 	}
+	ret = scpsys_bus_protect_disable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA, infracfg);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -114,19 +212,37 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 static int mtk_scpsys_power_off(struct power_domain *power_domain)
 {
 	struct mtk_scpsys *scpsys = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpsys->soc_data->data[power_domain->id];
-	void __iomem *ctl_addr = scpsys->base + data->ctl_offs;
-	u32 pdn_ack = data->sram_pdn_ack_bits;
+	struct mtk_scp_domain *domain;
+	const struct mtk_scp_domain_data *data;
+	void __iomem *ctl_addr;
+	void __iomem *infracfg;
+	u32 pdn_ack;
 	u32 val;
 	int ret, tmp;
 
+	if (power_domain->id >= scpsys->soc_data->num_domains)
+		return -EINVAL;
+
+	domain = &scpsys->domains[power_domain->id];
+	data = domain->data;
+	if (!data)
+		return -EINVAL;
+
+	ctl_addr = scpsys->base + data->ctl_offs;
+	infracfg = domain->infracfg ?: scpsys->infracfg;
+	pdn_ack = data->sram_pdn_ack_bits;
+
 	if (data->bus_prot_mask) {
-		ret = mtk_infracfg_set_bus_protection(scpsys->infracfg,
+		ret = mtk_infracfg_set_bus_protection(infracfg,
 						      data->bus_prot_mask);
 		if (ret)
 			return ret;
 	}
 
+	ret = scpsys_bus_protect_enable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA, infracfg);
+	if (ret < 0)
+		return ret;
+
 	val = readl(ctl_addr);
 	val |= data->sram_pdn_bits;
 	writel(val, ctl_addr);
@@ -136,6 +252,10 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 	if (ret < 0)
 		return ret;
 
+	ret = clk_disable_bulk(&domain->subsys_clks);
+	if (ret)
+		return ret;
+
 	val |= PWR_ISO_BIT;
 	writel(val, ctl_addr);
 
@@ -155,6 +275,10 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 	if (ret < 0)
 		return ret;
 
+	ret = clk_disable_bulk(&domain->clks);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -164,7 +288,7 @@ int mtk_scpsys_probe(struct udevice *dev)
 	struct mtk_scpsys *scpsys = dev_get_priv(dev);
 	struct regmap *regmap;
 	struct clk_bulk bulk;
-	int err;
+	int err, i;
 
 	scpsys->base = dev_read_addr_ptr(dev);
 	if (!scpsys->base)
@@ -172,6 +296,14 @@ int mtk_scpsys_probe(struct udevice *dev)
 
 	scpsys->soc_data = (const struct mtk_scp_soc_data *)dev_get_driver_data(dev);
 
+	scpsys->domains = devm_kcalloc(dev, scpsys->soc_data->num_domains,
+				       sizeof(*scpsys->domains), GFP_KERNEL);
+	if (!scpsys->domains)
+		return -ENOMEM;
+
+	for (i = 0; i < scpsys->soc_data->num_domains; i++)
+		scpsys->domains[i].data = &scpsys->soc_data->data[i];
+
 	/* get corresponding syscon phandle */
 	err = dev_read_phandle_with_args(dev, "infracfg", NULL, 0, 0, &args);
 	if (err)
@@ -195,6 +327,179 @@ int mtk_scpsys_probe(struct udevice *dev)
 	return clk_enable_bulk(&bulk);
 }
 
+static int mtk_scpsys_add_one_domain(struct udevice *dev, ofnode node, int parent_id)
+{
+	struct mtk_scpsys *scpsys = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	struct mtk_scp_domain *domain;
+	struct regmap *regmap;
+	const char *clk_name;
+	int i, ret, num_clks;
+	u32 id;
+
+	ret = ofnode_read_u32(node, "reg", &id);
+	if (ret) {
+		dev_err(dev, "%s: failed to retrieve domain id from reg: %d\n",
+			ofnode_get_name(node), ret);
+		return ret;
+	}
+
+	if (id >= scpsys->soc_data->num_domains) {
+		dev_err(dev, "%s: invalid domain id %d\n", ofnode_get_name(node), id);
+		return -EINVAL;
+	}
+
+	domain = &scpsys->domains[id];
+	domain->data = &scpsys->soc_data->data[id];
+
+	if (parent_id >= 0) {
+		domain->has_pd = true;
+		domain->parent_pd.dev = dev;
+		domain->parent_pd.id = parent_id;
+	}
+
+	if (ofnode_read_bool(node, "mediatek,infracfg")) {
+		ret = ofnode_parse_phandle_with_args(node, "mediatek,infracfg", NULL, 0, 0, &args);
+		if (ret)
+			return ret;
+
+		regmap = syscon_node_to_regmap(args.node);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+
+		domain->infracfg = regmap_get_range(regmap, 0);
+
+		/* enable Infra DCM */
+		if (domain->infracfg)
+			setbits_le32(domain->infracfg + INFRA_TOPDCM_CTRL,
+				     DCM_TOP_EN);
+	}
+
+	num_clks = ofnode_read_string_count(node, "clock-names");
+	for (i = 0; i < num_clks; i++) {
+		ret = ofnode_read_string_index(node, "clock-names", i, &clk_name);
+		if (ret) {
+			dev_err(dev, "%s: failed to retrieve clock-names at index %i: %d\n",
+				ofnode_get_name(node), i, ret);
+			return ret;
+		}
+
+		if (strchr(clk_name, '-'))
+			domain->subsys_clks.count++;
+		else
+			domain->clks.count++;
+	}
+
+	if (domain->clks.count) {
+		domain->clks.clks = devm_kcalloc(dev, domain->clks.count,
+						 sizeof(struct clk), GFP_KERNEL);
+		if (!domain->clks.clks)
+			return -ENOMEM;
+	}
+
+	if (domain->subsys_clks.count) {
+		domain->subsys_clks.clks = devm_kcalloc(dev,
+							domain->subsys_clks.count,
+							sizeof(struct clk), GFP_KERNEL);
+		if (!domain->subsys_clks.clks)
+			return -ENOMEM;
+	}
+
+	for (i = 0; i < domain->clks.count; i++) {
+		ret = clk_get_by_index_nodev(node, i, &domain->clks.clks[i]);
+		if (ret < 0) {
+			dev_err(dev, "%s: failed to get clk at index %d: %d\n",
+				ofnode_get_name(node), i, ret);
+			goto err_put_clocks;
+		}
+	}
+
+	for (i = 0; i < domain->subsys_clks.count; i++) {
+		ret = clk_get_by_index_nodev(node, i + domain->clks.count,
+					     &domain->subsys_clks.clks[i]);
+		if (ret < 0) {
+			dev_err(dev, "%s: failed to get subsys clk at index %d: %d\n",
+				ofnode_get_name(node), i + domain->clks.count, ret);
+			goto err_put_subsys_clocks;
+		}
+	}
+
+	return 0;
+
+err_put_subsys_clocks:
+	clk_release_all(domain->subsys_clks.clks, domain->subsys_clks.count);
+	domain->subsys_clks.count = 0;
+err_put_clocks:
+	clk_release_all(domain->clks.clks, domain->clks.count);
+	domain->clks.count = 0;
+	domain->data = NULL;
+	return ret;
+}
+
+static int mtk_scpsys_add_subdomain(struct udevice *dev, ofnode node)
+{
+	ofnode subnode;
+	int ret;
+	u32 id;
+
+	ret = ofnode_read_u32(node, "reg", &id);
+	if (ret) {
+		dev_err(dev, "%s: failed to get domain id\n", ofnode_get_name(node));
+		return ret;
+	}
+
+	ofnode_for_each_subnode(subnode, node) {
+		ret = mtk_scpsys_add_one_domain(dev, subnode, id);
+		if (ret) {
+			dev_err(dev, "failed to add child domain: %s\n",
+				ofnode_get_name(subnode));
+			continue;
+		}
+
+		ret = mtk_scpsys_add_subdomain(dev, subnode);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int mtk_power_controller_probe(struct udevice *dev)
+{
+	struct mtk_scpsys *scpsys = dev_get_priv(dev);
+	ofnode subnode;
+	int ret;
+
+	scpsys->base = dev_read_addr_ptr(dev_get_parent(dev));
+	if (!scpsys->base)
+		return -ENOENT;
+
+	scpsys->soc_data = (const struct mtk_scp_soc_data *)dev_get_driver_data(dev);
+
+	scpsys->domains = devm_kcalloc(dev, scpsys->soc_data->num_domains,
+				       sizeof(*scpsys->domains), GFP_KERNEL);
+	if (!scpsys->domains)
+		return -ENOMEM;
+
+	dev_for_each_subnode(subnode, dev) {
+		ret = mtk_scpsys_add_one_domain(dev, subnode, -1);
+		if (ret) {
+			dev_err(dev, "failed to add child domain: %s\n",
+				ofnode_get_name(subnode));
+			continue;
+		}
+
+		ret = mtk_scpsys_add_subdomain(dev, subnode);
+		if (ret) {
+			dev_err(dev, "failed to add sub domain: %s\n",
+				ofnode_get_name(subnode));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 const struct power_domain_ops mtk_power_domain_ops = {
 	.off = mtk_scpsys_power_off,
 	.on = mtk_scpsys_power_on,
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index 689ec4d1657..5bf0ca850ec 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -9,6 +9,7 @@
 #ifndef __MTK_POWER_DOMAIN_H
 #define __MTK_POWER_DOMAIN_H
 
+#include <clk.h>
 #include <power-domain-uclass.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
@@ -59,14 +60,28 @@ struct udevice;
 
 #define DCM_TOP_EN		BIT(0)
 
+#define SPM_MAX_BUS_PROT_DATA	6
+
 struct mtk_scp_domain;
 
+struct mtk_scpsys_bus_prot_data {
+	u32 bus_prot_mask;
+	u32 bus_prot_set;
+	u32 bus_prot_clr;
+	u32 bus_prot_sta;
+	bool bus_prot_reg_update;
+	bool ignore_clr_ack;
+};
+
 struct mtk_scp_domain_data {
 	u32 sta_mask;
 	int ctl_offs;
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
 	u32 bus_prot_mask;
+	const struct mtk_scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
+	int pwr_sta_offs;
+	int pwr_sta2nd_offs;
 };
 
 struct mtk_scp_soc_data {
@@ -80,13 +95,36 @@ static const struct mtk_scp_soc_data _name##_scp_soc_data = {	\
 	.num_domains = ARRAY_SIZE(_domains),			\
 }
 
+struct mtk_scp_domain {
+	const struct mtk_scp_domain_data *data;
+	void __iomem *infracfg;
+	struct clk_bulk clks;
+	struct clk_bulk subsys_clks;
+	bool has_pd;
+	struct power_domain parent_pd;
+};
+
 struct mtk_scpsys {
 	void __iomem *base;
 	void __iomem *infracfg;
 	const struct mtk_scp_soc_data *soc_data;
+	struct mtk_scp_domain *domains;
 };
 
+#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
+	.bus_prot_mask = (_mask),				\
+	.bus_prot_set = (_set),					\
+	.bus_prot_clr = (_clr),					\
+	.bus_prot_sta = (_sta),					\
+	.bus_prot_reg_update = (_update),			\
+	.ignore_clr_ack = (_ignore),				\
+}
+
+#define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
+	_BUS_PROT(_mask, _set, _clr, _sta, false, false)
+
 int mtk_scpsys_probe(struct udevice *dev);
+int mtk_power_controller_probe(struct udevice *dev);
 
 extern const struct power_domain_ops mtk_power_domain_ops;
 

-- 
2.54.0

