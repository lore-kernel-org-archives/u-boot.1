Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D94C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E30A84CBE;
	Wed, 15 Jul 2026 16:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="QYrx4OU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12D184CBE; Wed, 15 Jul 2026 16:29:03 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E992384B43
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so38692085e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125740; x=1784730540; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6tY+rlnMeAolZx56DtKrvPPps2Mf4w5E5KoN0rE6Nek=;
 b=QYrx4OU0s2cw3gedgtwphanGdVXdqAETXW9QCn9bHDF5PRXcyoRzFxW/ufE3CCP035
 DqFXhBNy4NZiBBIUyMRR3R2TL4aWfyVfzMx5L1IjMWSDjMKzEOroDDNAjcaBAotZZyfX
 diFUATKnspcmkhzECRHGmhPJhp3zyh5SLpcHCrUlVaQ7V6b4+3zc5utpgCa8sJVZ0lWp
 ZNBcGs5N4G/NkUgxhsg54g4n9v7JZKXclFOXhOiwjWqV3RMTU8KSM1Bj8blEsFOPT659
 7i3xn0KcIjZn3Zq7hMK09ubA/FSJva73jUEYgTPMIcAQKYnGd0GcHXJFXzxkQmqKWQnO
 gTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125740; x=1784730540;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6tY+rlnMeAolZx56DtKrvPPps2Mf4w5E5KoN0rE6Nek=;
 b=cDLxLYQ4G2OiAxj/y628+2LVYL50PBZyLpzMfDFVesziw10szqR7K9K7ZZIvJrsmZ5
 Ig15xMhG4svTpEPiJt+q3/Dq2cZDE83eCE62GnjQLgt4+uXSED8UndWohQTBb8PUqF4j
 5AYWvWORoT3+r7FqS3uFDGeNLg7LatsiuEx9JW28eGXgKAX1Y1QRwmAgTGmB6gcrva0B
 ifYoPYQvsj7IsQpsrwX4EjhXPC6Zo1880aAqHXZhdXjT77aXXds+/xz61LBKoNm2sNpK
 ib6zAnlMU7LoRFgn4DWt4m2RS382GyPdOD8l/aKkqNhZ+zeUk09XrNYeZVt38jllUAS8
 J2Pg==
X-Gm-Message-State: AOJu0Yw4eeAefTi5mHw3hthtp35AqUW40g6oumQvSPO8xWIkpueqTpwe
 STeo/IytdX256v/cu3lBf1vt5X+8FNFpalGUhSPI2riwE1SUT6OBgHIwF4T/Lh/DFso=
X-Gm-Gg: AfdE7clTzPCm5U2HXtE0inPdtQ0IwjaxE5kKo8gwfr8Zw7aHoQ/9qGFaeV22vYD5x2r
 JDGcQu719hc783mp4eYqyR/asufHIMs45ctRp9JoO3QRB3Er7VJ5Lzz21qd081UFg6WAdWqcrPE
 ZLOMtTYmFfxhDQaa8+E+FW9NNgFK68+XTIlEAKKR3c8PuDmfCPt3ivhT/KA+8JRoT4R6CZMNTPJ
 PH9W7AH+RqpgJWRWdLyJICHua2Aww3rxmdOTsBKjJ0Ca+DPhWR954spPpQnXUe/LZvz2i3bmieR
 iGFddKJyMahB6+kxnkGY+2KL8q15WPqW7LsgNAAJoATG7T/5pavL9lj9Tvkuks1vmwlzWRzz9od
 G7V3RLVRMS7IGDhVCDdLcoNJdU7w9kZVjOtvz5OawRH925T+LeLihUANsN9tTBkPDMR6TllYlOZ
 XMlrR+X3Wl8lwItN1CreKn3pnbWXlwn81QCbZmYZ+5U/Iou4rNI9RLGmW9GfJTEzwXX29522aeX
 vN5oJtVDy/zRKNTcojOdKRLscgdlLNz68WmOWZ/wyEHpfBW66m3OFFZWx+hKBR2wrZ1fSME
X-Received: by 2002:a05:600c:628b:b0:495:3da0:3f52 with SMTP id
 5b1f17b1804b1-4953da04055mr31673385e9.19.1784125740426; 
 Wed, 15 Jul 2026 07:29:00 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:57 +0200
Subject: [PATCH v2 29/32] clk: mediatek: mt8189: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-29-23e907516010@baylibre.com>
References: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
In-Reply-To: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>, Sam Shih <sam.shih@mediatek.com>
X-Mailer: b4 0.15.2
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

MT8189 already shares a single U_BOOT_DRIVER across all its clock gate
controllers, passing the per-controller gate table through the driver data
via a dedicated struct mt8189_gate_clk_data.

Now that struct mtk_clk_tree can describe the gates directly, drop that
bespoke helper: give each controller its own struct mtk_clk_tree
(.gates/.num_gates/.gates_offs) and use the generic mtk_clk_topckgen_ops.
The gate offset, previously computed at runtime from the first gate ID, is
now encoded statically in each tree.

This also stops using mtk_common_clk_gate_init() and struct mtk_cg_priv,
which are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 64 +++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index cf5c4fffe7c..562e55078a0 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1970,11 +1970,6 @@ static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
 	.type = MTK_CLK_TREE_VLP_CK,
 };
 
-static const struct mtk_clk_tree mt8189_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-};
-
 static const struct udevice_id mt8189_apmixed[] = {
 	{ .compatible = "mediatek,mt8189-apmixedsys", },
 	{ }
@@ -1990,32 +1985,31 @@ static const struct udevice_id mt8189_vlpckgen[] = {
 	{ }
 };
 
-struct mt8189_gate_clk_data {
-	const struct mtk_gate *gates;
-	int num_gates;
-};
-
-#define GATE_CLK_DATA(name) \
-static const struct mt8189_gate_clk_data name##_data = { \
-	.gates = name, .num_gates = ARRAY_SIZE(name) \
+#define GATE_CLK_TREE(_name, _gates_offs) \
+static const struct mtk_clk_tree _name##_tree = { \
+	.ext_clk_rates = ext_clock_rates, \
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates), \
+	.gates = _name, \
+	.num_gates = ARRAY_SIZE(_name), \
+	.gates_offs = _gates_offs, \
 }
 
-GATE_CLK_DATA(perao_clks);
-GATE_CLK_DATA(imp_clks);
-GATE_CLK_DATA(mm_clks);
-GATE_CLK_DATA(mminfra_config_clks);
-GATE_CLK_DATA(ufs_config_ao_clks);
-GATE_CLK_DATA(ufs_config_pdn_clks);
-GATE_CLK_DATA(vlpcfg_ao_clks);
+GATE_CLK_TREE(perao_clks, CLK_PERAO_UART0);
+GATE_CLK_TREE(imp_clks, CLK_IMPE_I2C0);
+GATE_CLK_TREE(mm_clks, CLK_MM_DISP_OVL0_4L);
+GATE_CLK_TREE(mminfra_config_clks, CLK_MMINFRA_GCE_D);
+GATE_CLK_TREE(ufs_config_ao_clks, CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM);
+GATE_CLK_TREE(ufs_config_pdn_clks, CLK_UFSCFG_REG_UFSHCI_UFS);
+GATE_CLK_TREE(vlpcfg_ao_clks, CLK_VLPCFG_REG_SCP);
 
 static const struct udevice_id of_match_mt8189_clk_gate[] = {
-	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_data },
-	{ .compatible = "mediatek,mt8189-iic-wrap", .data = (ulong)&imp_clks_data },
-	{ .compatible = "mediatek,mt8189-dispsys", .data = (ulong)&mm_clks_data },
-	{ .compatible = "mediatek,mt8189-mm-infra", .data = (ulong)&mminfra_config_clks_data },
-	{ .compatible = "mediatek,mt8189-ufscfg-ao", .data = (ulong)&ufs_config_ao_clks_data },
-	{ .compatible = "mediatek,mt8189-ufscfg-pdn", .data = (ulong)&ufs_config_pdn_clks_data },
-	{ .compatible = "mediatek,mt8189-vlpcfg-ao", .data = (ulong)&vlpcfg_ao_clks_data },
+	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_tree },
+	{ .compatible = "mediatek,mt8189-iic-wrap", .data = (ulong)&imp_clks_tree },
+	{ .compatible = "mediatek,mt8189-dispsys", .data = (ulong)&mm_clks_tree },
+	{ .compatible = "mediatek,mt8189-mm-infra", .data = (ulong)&mminfra_config_clks_tree },
+	{ .compatible = "mediatek,mt8189-ufscfg-ao", .data = (ulong)&ufs_config_ao_clks_tree },
+	{ .compatible = "mediatek,mt8189-ufscfg-pdn", .data = (ulong)&ufs_config_pdn_clks_tree },
+	{ .compatible = "mediatek,mt8189-vlpcfg-ao", .data = (ulong)&vlpcfg_ao_clks_tree },
 	{ }
 };
 
@@ -2034,15 +2028,11 @@ static int mt8189_infrasys_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8189_vlpckgen_clk_tree);
 }
 
-static int mt8189_clk_gate_probe(struct udevice *dev)
+static int mt8189_clk_probe(struct udevice *dev)
 {
-	struct mt8189_gate_clk_data *data;
-
-	data = (void *)dev_get_driver_data(dev);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
-	return mtk_common_clk_gate_init(dev, &mt8189_clk_tree,
-					data->gates, data->num_gates,
-					data->gates[0].id);
+	return mtk_common_clk_init(dev, tree);
 }
 
 U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
@@ -2082,8 +2072,8 @@ U_BOOT_DRIVER(mt8189_clk_gate) = {
 	.name = "mt8189-gate-clk",
 	.id = UCLASS_CLK,
 	.of_match = of_match_mt8189_clk_gate,
-	.probe = mt8189_clk_gate_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.probe = mt8189_clk_probe,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.54.0

