Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8365CC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D1E984A8F;
	Wed,  8 Jul 2026 19:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="nfE6WnJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91108849F6; Wed,  8 Jul 2026 15:07:23 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BAF084A0B
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so380808f8f.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516041; x=1784120841; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EQXF/emwjxVbI/NrWYhd3ExBWEONkubg0pz6lfvFBEw=;
 b=nfE6WnJznxmrSZYZ2CCubwOvl4TIiUnWh1CjCDL2l6rRUZ3BplT8EZfjmnFSx8mR3c
 XhUyOqV+zPsezXPfyFmMWmCnp9OmQ7RHx4uiG+Nxwp3bRiEfo/Chj2WgB06OJ5BcDVqi
 2CctxWABRKF2MTkJ3deWr40+VshCK2dAXlym1GOiNbvju2kRVD7gVDXLCbU60ug6F/Al
 YZbeCwXhG4o64utTAX38vLpTUMcCGXO65Yc6K+6a1F0gn/YzcrjFKzQpdq1tTuqA0ELd
 4F+fR4APVoDx/mwY5+RIAGn73CEOYp1Tq8YtghQq9UjC2XwSbftc2UxZpIb/RndIA26z
 Ur4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516041; x=1784120841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EQXF/emwjxVbI/NrWYhd3ExBWEONkubg0pz6lfvFBEw=;
 b=WTKSsteUdh5/rGkxRpfeS2gNx1IX2FSocE9Jsj+E9Y7sMT/N4dYO3UVpLnLe0oT2Cy
 KqErg2vIASPPyM6FU/RuDFKOBa3uZ+FiqwkHtOaWRxgr22FtGkrLPkxSV1D1dR69kGDa
 Qbq3qTkLTO4/wozF9yHeXmKxZvemR2KoyXH+NoMXkr3HEwSTT96TA9sSOhzMwwITNL5u
 MnMrcaiwUYvBFhrYNyHS//DXEHUCu+ICYcqYs7/f54+Dp38sVtC2amAIPj/Oc/OyepAu
 mhPEW7atlVCKiCeNQLytWJJRagodQ3uA5wCLgoiE2+YbIT3e+AK9w7HBzhiQvyyPQbOe
 UE0A==
X-Gm-Message-State: AOJu0YxEBH9xilOcBT+xBGnPxVIq3IqRxuvhpHFBQ/a/drjawBDIVP01
 ZCS9/4EvLtzqyxjlsMh7hz8eGOfpRFE/17KYKNi7UsOMxx/DXPsicWlExc1FvgItvak=
X-Gm-Gg: AfdE7cmm0tMIZVgVjDaabEuOwksN64oCeMUmH/k9z4S+AiMrlTslZtNLSojZz3wSanz
 30z5qzfa8xHMvGZRJiS8YrjQbzzMJqqW6MGOBW37ymPTyJY8Ru8EMjlr0l8cQuBNO2LX7ddvEhN
 bJcuggdZNk8kGt28+aPwiEH0EuhmRxqGc9a/H9BUTewZ3TRMfhGFQ2zifXygjIqjcthKFj/k8rE
 TDAu3wGoDNZvo2sZAfKrbTWrzBYq5CCa76EYJYAkSFjuzdUVB8VZsdoVab7FHfZ25JH8yM51UzX
 100m7ym5DvmHRIbOE2ME1OYb0MSDlcqyDg1VWOwhVAAN2RVEWntxzMBoWEKhexeCq0rAiD48gPb
 Qu0DLRpoU5MRiUBtilXzPEDfEUpga/aT2LcBiZvDh3Oj3Ccfbg6EA1OqTVZ0ZmqCtrqq1JAELNJ
 yLpxSd+cZZUlWbb0V6V8OXe6CcD8B5xP5dKhRyYxbejgdnC3kxjcUKgbfr3u5l04KhAnos55AMh
 Xvf4KvNm37o7ufdp6LyfxjxD63WE7M4rmi4UJFHfn37vzvVJtmCl1w/l92OFgbeAD29Bm4=
X-Received: by 2002:a05:6000:4028:b0:47b:69a5:7264 with SMTP id
 ffacd0b85a97d-47df07a1fb9mr2630884f8f.5.1783516040876; 
 Wed, 08 Jul 2026 06:07:20 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jul 2026 15:07:13 +0200
Subject: [PATCH 07/12] power: domain: mediatek: wrap domain tables in
 struct scp_soc_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mt8188-add-power-domain-v1-7-0e930b4f714e@baylibre.com>
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

The per-SoC match data currently points directly at the array of
mtk_scp_domain_data. Wrap it in a new struct mtk_scp_soc_data that
carries the table pointer together with its size, and add a
MTK_SCP_SOC_DATA() helper that fills both from a single table definition
via ARRAY_SIZE().

The num_domains field is not used yet; it is added here so that upcoming
SoC support can validate the domain index coming from the device tree
against the size of the table.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mt7623-power-domain.c |  4 +++-
 drivers/power/domain/mt7629-power-domain.c |  6 ++++--
 drivers/power/domain/mtk-power-domain.c    |  8 ++++----
 drivers/power/domain/mtk-power-domain.h    | 14 +++++++++++++-
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/power/domain/mt7623-power-domain.c b/drivers/power/domain/mt7623-power-domain.c
index 88ea17fd52b..03dd20e7bc1 100644
--- a/drivers/power/domain/mt7623-power-domain.c
+++ b/drivers/power/domain/mt7623-power-domain.c
@@ -65,10 +65,12 @@ static const struct mtk_scp_domain_data mt7623_scp_domain[] = {
 	},
 };
 
+MTK_SCP_SOC_DATA(mt7623, mt7623_scp_domain);
+
 static const struct udevice_id mt7623_power_domain_ids[] = {
 	{
 		.compatible = "mediatek,mt7623-scpsys",
-		.data = (ulong)&mt7623_scp_domain,
+		.data = (ulong)&mt7623_scp_soc_data,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/power/domain/mt7629-power-domain.c b/drivers/power/domain/mt7629-power-domain.c
index 47993aa102a..a4456f399bb 100644
--- a/drivers/power/domain/mt7629-power-domain.c
+++ b/drivers/power/domain/mt7629-power-domain.c
@@ -36,14 +36,16 @@ static const struct mtk_scp_domain_data mt7629_scp_domain[] = {
 	},
 };
 
+MTK_SCP_SOC_DATA(mt7629, mt7629_scp_domain);
+
 static const struct udevice_id mt7629_power_domain_ids[] = {
 	{
 		.compatible = "mediatek,mt7622-scpsys",
-		.data = (ulong)&mt7629_scp_domain,
+		.data = (ulong)&mt7629_scp_soc_data,
 	},
 	{
 		.compatible = "mediatek,mt7629-scpsys",
-		.data = (ulong)&mt7629_scp_domain,
+		.data = (ulong)&mt7629_scp_soc_data,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index a8045c1f91e..752ca404875 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -44,7 +44,7 @@ static int mtk_infracfg_clear_bus_protection(void __iomem *infracfg,
 static int mtk_scpsys_domain_is_on(struct power_domain *power_domain)
 {
 	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
+	const struct mtk_scp_domain_data *data = &scpd->soc_data->data[power_domain->id];
 	u32 sta = readl(scpd->base + SPM_PWR_STATUS) &
 			data->sta_mask;
 	u32 sta2 = readl(scpd->base + SPM_PWR_STATUS_2ND) &
@@ -65,7 +65,7 @@ static int mtk_scpsys_domain_is_on(struct power_domain *power_domain)
 static int mtk_scpsys_power_on(struct power_domain *power_domain)
 {
 	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
+	const struct mtk_scp_domain_data *data = &scpd->soc_data->data[power_domain->id];
 	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
@@ -114,7 +114,7 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 static int mtk_scpsys_power_off(struct power_domain *power_domain)
 {
 	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
+	const struct mtk_scp_domain_data *data = &scpd->soc_data->data[power_domain->id];
 	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
@@ -170,7 +170,7 @@ int mtk_power_domain_probe(struct udevice *dev)
 	if (!scpd->base)
 		return -ENOENT;
 
-	scpd->data = (const struct mtk_scp_domain_data *)dev_get_driver_data(dev);
+	scpd->soc_data = (const struct mtk_scp_soc_data *)dev_get_driver_data(dev);
 
 	/* get corresponding syscon phandle */
 	err = dev_read_phandle_with_args(dev, "infracfg", NULL, 0, 0, &args);
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index 0c2c06a045f..ade77af8f33 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -12,6 +12,7 @@
 #include <power-domain-uclass.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/kernel.h>
 #include <linux/types.h>
 
 struct udevice;
@@ -68,10 +69,21 @@ struct mtk_scp_domain_data {
 	u32 bus_prot_mask;
 };
 
+struct mtk_scp_soc_data {
+	const struct mtk_scp_domain_data *data;
+	int num_domains;
+};
+
+#define MTK_SCP_SOC_DATA(_name, _domains)			\
+static const struct mtk_scp_soc_data _name##_scp_soc_data = {	\
+	.data = _domains,					\
+	.num_domains = ARRAY_SIZE(_domains),			\
+}
+
 struct mtk_scp_domain {
 	void __iomem *base;
 	void __iomem *infracfg;
-	const struct mtk_scp_domain_data *data;
+	const struct mtk_scp_soc_data *soc_data;
 };
 
 int mtk_power_domain_probe(struct udevice *dev);

-- 
2.54.0

