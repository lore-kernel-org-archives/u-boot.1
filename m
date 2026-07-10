Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901BEC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E058E84BB9;
	Fri, 10 Jul 2026 20:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="JR0RyOx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE5E84BD1; Fri, 10 Jul 2026 20:59:37 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C580284BC6
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e9f69eeb6cso782395a34.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709974; x=1784314774; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/TpR6MMkSt3nd8mmOKDXNa2zAesX8sgZlQbP70rI97A=;
 b=JR0RyOx6o8m7bUKFVetTNXoQWBkoaxmB770zQRhxOiwPfY8QI72mpzCM8qhmoMFlsU
 PrGXN8zYsSoV9Uh8DKfv2SD6D75k7OxokEdreZFOgUp/5urKmnffwIWOmr4d/PBIjGNg
 EHerj+ZoeoYQODw252Lsa+4F9aT6P9yj1L5D9qUfGA/CTw6rSh/np+0hjfU6/NO2VZ1O
 1pfZFK7VwJpbdSy1BmCtpvBLDAVB0BSL1h7NQluSPHQwCQq1buIeq8B3FjWzD4x32FpG
 Jgz1cvuv+YiXb80Z4u77Sd2BW3ZRC7paQ5mbazcCRM7Nx5TIImib462Mor1AUN0BWEkp
 7wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709974; x=1784314774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/TpR6MMkSt3nd8mmOKDXNa2zAesX8sgZlQbP70rI97A=;
 b=NAfXKD2IsdicKXjCmQbOOg2iVQAC6EHFSQTEJoecrO61Tdwti66xmHRnsPaeJFIWXL
 98vhov/VZmC2BZ/VtJoku+80JF+WM59j9SEP+J30rtrsTv1a4NfgJ83G0xTneHJ0bmaT
 3m/dP2PVusUKulvyuPidTS9ZGgV9HVhHX8oiB5tH2F3MacFS14nwLRcM42oFh6lHucK9
 Mj/yU/mlO5ZX4fO16X3CcAChI1iDCiHY7Rnku9NewUOwzME5kkWjJP1VXvs1d4Y4frHU
 fgz+uTuBpNgbqxXXeb6VuoyTfKWSYEnVnaIxIy5e35XcZ8wIin1OfbavOI6RWhQLFyAy
 YvMQ==
X-Gm-Message-State: AOJu0YzSEn+5sYoWn8IaF0EbQPU7ZCtdIY1cn3UfyXJygRUAqscBqF4H
 0lcmOADOBeaLRfhRAdZEjhGtt6dc4VwMJnau1bGwTr/O4szKlYhMaJflrXIINYB4H9ZdROgUeQ4
 21YzI
X-Gm-Gg: AfdE7cmFrCs7u4amIgeIuEoHm1bkkwtE6QjLZtRqYpv7aK2+c7bC/ZX+5lnWuCNmj7D
 t7MweRtQoLGIRGwiH0UA6X6R5KUCpdIWtThKPBLE2WKTK5URictmTaz+WdZ4kPgpfDZGIfpywIi
 UUiNKw954TU3ZAj2Bg8UR4hynhHb65q2GPcgV0iWmLyMrUV0TXQer9S2R/CfbCQ1yWn6/Zq5wKS
 M0ZRqX6vDfnJpxWXq6jz0YGx+aNrYy0xfuRG3jXNR5YpQ+eWdVkhmyNNRFumTVnYgaD8On77cLW
 WS9zYBq83xZWsvwbA0DgP5GTBC7jbZRHo13o/akchhzk0O0/K8nGmFE5pMH4zaer4/yAHzP7KqT
 0TExEPrCfTw6ZAVt+dkO50QRyTM3lZfggnL4CneyOp1TeOH+QsnYcLOsF7kt+cJ4jhV7j20urXw
 6ymHrdL0je+ry18SDRXlGtX8b7/Uc=
X-Received: by 2002:a05:6820:1f08:b0:6a1:1419:3a0b with SMTP id
 006d021491bc7-6a39a831d8dmr318887eaf.53.1783709973294; 
 Fri, 10 Jul 2026 11:59:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:31 -0500
Subject: [PATCH v2 15/24] clk: mediaTek: mt8512: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-15-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2798; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=CwMiTXIwUa0mECKZ0wr2IRYte8+B8HbG7CRqKKRl6fo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUC7dfbnLudxWgDYN+DIcWB3VSF3ptvCUHM+F
 DoR6JCrUlWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAuxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A/VMIAJyjKxmFbLXd/27qstDJik2fLCY0B5p/1ylkSgK
 KpW9qjSXxrcKVB0jUFlokdNwbFSxpp7gwYSgm5DzmA84cApAxa3Cq7vvtsinVZOZb42dgxeBSrI
 jKf/TPwUt/j3e2TpCprYhHFEvjn6l0f96U1cqntKWn+B0miuiYUcblLwS+vpHMp9WWAtgOUNCP1
 THTKtHJJm5L+0vbMSpJEV5BNARoBX/xB18pMh4SIn7xGrjI5GfG4HvxV+39xjL4+1q/1rSUjXKM
 S4AeeCPTu42epTRRgKAEdFcJ1MUr5LxobkdJvV7cbLo8FCmwOE6bzDCp6mRLbsskGZIvTYBlRD/
 UitA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add clock tree type flags to the mt8512 clock tree structures. These
will be used later for parent lookup.

Clock trees had to be split now that each tree has a different type
flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index d6e58be8e22..2bfd8c4b1b9 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -792,30 +792,42 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA5(CLK_INFRA_USB_XHCI, CLK_TOP_SSUSB_XHCI_SEL, 11),
 };
 
-static const struct mtk_clk_tree mt8512_clk_tree = {
+static const struct mtk_clk_tree mt8512_apmixed_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt8512_topckgen_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_SYSPLL1_D2,
 	.muxes_offs = CLK_TOP_AXI_SEL,
-	.plls = apmixed_plls,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
-	.num_plls = ARRAY_SIZE(apmixed_plls),
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
+	.type = MTK_CLK_TREE_TOPCKGEN,
+};
+
+static const struct mtk_clk_tree mt8512_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static int mt8512_apmixedsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8512_clk_tree);
+	return mtk_common_clk_init(dev, &mt8512_apmixed_clk_tree);
 }
 
 static int mt8512_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8512_clk_tree);
+	return mtk_common_clk_init(dev, &mt8512_topckgen_clk_tree);
 }
 
 static int mt8512_topckgen_cg_probe(struct udevice *dev)
@@ -854,6 +866,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt8512-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_apmixed_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8512_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -864,6 +877,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt8512-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8512_topckgen_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

