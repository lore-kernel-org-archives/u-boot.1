Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7287CC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE0684A3E;
	Thu,  9 Jul 2026 15:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="F8G9SoFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D6884AFF; Thu,  9 Jul 2026 14:58:12 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70B784B01
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso1699464f8f.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601890; x=1784206690; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MteWLfL3w/JtPMjymW+34Jmb98JiR/1MW0Dd5pEuX3Q=;
 b=F8G9SoFeDzbu3mpj6xqikexIKYxtVpxCzxidDjDNLwdF1NNw8c6T7GTG30jvlqvlZV
 bs/GBQCr0XlEhJSS00GQsAdCo4ZntvK11wzUVL32cwnyilzWvD81pwEdqhuwfzXQCyxS
 oUDGygNhcDlw+cr0BVD+ULO0OUMs1MORze9JboA17j/UHIlq7hUpq//tv8dE533Oea+l
 gtBPoRAakv7jmx3iQhCp3obbuLvYaCeZwltLL3wXNiBwP6xP7CchcBvxS6SIQDTmMCtL
 Opfiu1QxZiVdc4QuRoAVkMYLWDubmflOYa+COvPtbgyHGV8/qICY4z4bqEWknT1plKlG
 /TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601890; x=1784206690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MteWLfL3w/JtPMjymW+34Jmb98JiR/1MW0Dd5pEuX3Q=;
 b=AdC9TjP5kznAQjGbZGJ8o7ZPzrtCbsoLweR7GGIwH51q47C2A/OpzxlmON16tIgvlw
 NiP0uAGuK+khKvCJ5spoo3O8ZVGBz9d6Tf9gJCyJZOUmW/fImk9dOdNNj4r8upvmgvE5
 rDbuE0WlnR8ITkpnZrv5Dww91kto1Nx8bFc8ZNJm0oFGwDRs7c32V60VC6nB2Qv4qBN+
 B2n6Ofnh7nqguatI7e+uGz3AL4w6wHvLvKl0OZtbKXeJ1yd3gYyhlX8u6gPSFlvTbroO
 ujZABMHLKZ6xlLpjNyPXL8CD2YqP9S1LiE5zumr0SR9X8ttw6ke/1z5MzoPLgqhi8Hco
 ojMg==
X-Gm-Message-State: AOJu0YxBvgP3jdpRwSv/n5Cer7KxLLk7Diflo4a83kG6Xu9k4I6a2eh5
 x4IC+Ck4goWEjcjAgyuZVKE7WKnTZX6X192yJIORJLg6hZDQxmw9mp6ImxNgpSZkjIU=
X-Gm-Gg: AfdE7clnGIqRl+SeQKho+vEg96Z/VckyHTMbwIVJpGIdvUUxP5tqJOmfmGtYlqToRiR
 GgtP8IoIs46rhfkVHIhE8Onl7F+fjjrwR9IS46ItlkA0SMhinvZOwg76d20UoaCBtbpq4dJ2i58
 3hTGu+pZaHq085WZkD4C9hmYQ3paLCXU8x+spcbqjm/h4ZOjcif/6cvba8zsLP0bOdVEZp3z/Np
 L8+ImzbxHaUQkEPTF5vVfojKRaWWIjYSTxslXky4duTerzue/CsaSQXA9MRXZR082pjdXgLaTRE
 dm91FoWJcgP17VUtyOoBUtmJ+rIrKZ42SBiPx54EGd39jtnzciiYjfke97szlTirHtqDv2ATa10
 2/NM5TcyjCKCD93zx5GCYET4o3zyrqvfchmsf5LKuO4Tnvjp1ufgj9EBpTCiTlfVXuLehqFcQWp
 TH/lnnXELu/1e3mdRS3fueTYQNQrnWPR1eJiX7SPiruR/EiLrxstbQI9rfbSNeNEcwXXj/MOJ0B
 X3gXM0ZkNk+oudEvlBv3yMVJkFSeSgmYdlFQjKoztm1MkwMIgFCbbhSBg2xBlhuQyZAk/s=
X-Received: by 2002:a05:6000:2285:b0:475:f0c2:75ac with SMTP id
 ffacd0b85a97d-47df07baa0cmr7882300f8f.61.1783601890135; 
 Thu, 09 Jul 2026 05:58:10 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:09 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:10 +0200
Subject: [PATCH v2 04/14] power: domain: mediatek: use MT2701 naming
 instead of MT7623
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-4-589ace7d30e2@baylibre.com>
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

Upstream DT bindings define "mediatek,mt7623-scpsys" to fall back to
"mediatek,mt2701-scpsys". Align the driver with this convention by
using MT2701 naming throughout.

This also allows the driver to use the upstream
dts/upstream/include/dt-bindings/power/mt2701-power.h header instead of
the local include/dt-bindings/power/mt7623-power.h, since both expose
equivalent power domain definitions.

Rename scp_domain_mt7623 to scp_domain_mt2701, replace SCPSYS_MT7623
enum by SCPSYS_MT2701, and switch all MT7623 power domain defines to
their MT2701 equivalents.

Note:
we intentionally keep the explicit "mediatek,mt7623-scpsys"
compatible entry to avoid breaking legacy boards
(mt7623a_unielec_u7623_02 and mt7623n_bpir2_defconfig) that didn't
switched yet to OF_UPSTREAM. Same for
include/dt-bindings/power/mt7623-power.h that is only used in these
boards.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 36 ++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index dd45f63b763..9888d00421c 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -16,8 +16,8 @@
 #include <linux/err.h>
 #include <linux/iopoll.h>
 
+#include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/power/mt7622-power.h>
-#include <dt-bindings/power/mt7623-power.h>
 
 #define SPM_EN			(0xb16 << 16 | 0x1)
 #define SPM_VDE_PWR_CON		0x0210
@@ -62,8 +62,8 @@
 #define DCM_TOP_EN		BIT(0)
 
 enum scp_domain_type {
+	SCPSYS_MT2701,
 	SCPSYS_MT7622,
-	SCPSYS_MT7623,
 };
 
 struct scp_domain;
@@ -84,54 +84,54 @@ struct scp_domain {
 	struct scp_domain_data *data;
 };
 
-static struct scp_domain_data scp_domain_mt7623[] = {
-	[MT7623_POWER_DOMAIN_CONN] = {
+static struct scp_domain_data scp_domain_mt2701[] = {
+	[MT2701_POWER_DOMAIN_CONN] = {
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = SPM_CONN_PWR_CON,
 		.bus_prot_mask = BIT(8) | BIT(2),
 	},
-	[MT7623_POWER_DOMAIN_DISP] = {
+	[MT2701_POWER_DOMAIN_DISP] = {
 		.sta_mask = PWR_STATUS_DISP,
 		.ctl_offs = SPM_DIS_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.bus_prot_mask = BIT(2),
 	},
-	[MT7623_POWER_DOMAIN_MFG] = {
+	[MT2701_POWER_DOMAIN_MFG] = {
 		.sta_mask = PWR_STATUS_MFG,
 		.ctl_offs = SPM_MFG_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
-	[MT7623_POWER_DOMAIN_VDEC] = {
+	[MT2701_POWER_DOMAIN_VDEC] = {
 		.sta_mask = PWR_STATUS_VDEC,
 		.ctl_offs = SPM_VDE_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
-	[MT7623_POWER_DOMAIN_ISP] = {
+	[MT2701_POWER_DOMAIN_ISP] = {
 		.sta_mask = PWR_STATUS_ISP,
 		.ctl_offs = SPM_ISP_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 	},
-	[MT7623_POWER_DOMAIN_BDP] = {
+	[MT2701_POWER_DOMAIN_BDP] = {
 		.sta_mask = PWR_STATUS_BDP,
 		.ctl_offs = SPM_BDP_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 	},
-	[MT7623_POWER_DOMAIN_ETH] = {
+	[MT2701_POWER_DOMAIN_ETH] = {
 		.sta_mask = PWR_STATUS_ETH,
 		.ctl_offs = SPM_ETH_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
-	[MT7623_POWER_DOMAIN_HIF] = {
+	[MT2701_POWER_DOMAIN_HIF] = {
 		.sta_mask = PWR_STATUS_HIF,
 		.ctl_offs = SPM_HIF_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
-	[MT7623_POWER_DOMAIN_IFR_MSC] = {
+	[MT2701_POWER_DOMAIN_IFR_MSC] = {
 		.sta_mask = PWR_STATUS_IFR_MSC,
 		.ctl_offs = SPM_IFR_MSC_PWR_CON,
 	},
@@ -322,12 +322,12 @@ static int mtk_power_domain_hook(struct udevice *dev)
 	scpd->type = (enum scp_domain_type)dev_get_driver_data(dev);
 
 	switch (scpd->type) {
+	case SCPSYS_MT2701:
+		scpd->data = scp_domain_mt2701;
+		break;
 	case SCPSYS_MT7622:
 		scpd->data = scp_domain_mt7622;
 		break;
-	case SCPSYS_MT7623:
-		scpd->data = scp_domain_mt7623;
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -375,13 +375,17 @@ static int mtk_power_domain_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mtk_power_domain_ids[] = {
+	{
+		.compatible = "mediatek,mt2701-scpsys",
+		.data = SCPSYS_MT2701,
+	},
 	{
 		.compatible = "mediatek,mt7622-scpsys",
 		.data = SCPSYS_MT7622,
 	},
 	{
 		.compatible = "mediatek,mt7623-scpsys",
-		.data = SCPSYS_MT7623,
+		.data = SCPSYS_MT2701,
 	},
 	{ /* sentinel */ }
 };

-- 
2.54.0

