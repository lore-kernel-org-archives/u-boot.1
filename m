Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9134AC43602
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A6184A35;
	Tue,  7 Jul 2026 17:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="V8f+OtcV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FE18494B; Tue,  7 Jul 2026 17:10:36 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA4178496E
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-44c9f8c9c4aso1247421fac.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437033; x=1784041833; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EOAPI9gptt43uV6ZdopzeFl46hJEMfgJfRRIjyoWaPg=;
 b=V8f+OtcVvZwSMsoeUffPurY3i6fwTmLY71sAMKSgqGqfPtYrZoaVD/0xYukEFo5vP2
 +omfOIHT+IelhEKVi81L9SjQ1zoy+8QrcJS/As7apXDMLgWA235Bko+TpYwfZ+nJ/TOF
 cIBlOtYnAEXz+k0H4MzFD5S7NxhxsMpUu5q1I+AegPUzGJLkXrmFwRWG1tblgByagWFM
 YZL2+GyPJaiT5hD3gdKQjveYrk/03OGKafZUSokBGXUmk31RqAJ2tpPr+Lvmp8k+fNO+
 9aDpx2q9mgTNcJTlyZqLWq+GyCY3dd2Nts0XWq6FOxzelWhi5useKt3WLZtqOoB2C+hX
 dCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437033; x=1784041833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EOAPI9gptt43uV6ZdopzeFl46hJEMfgJfRRIjyoWaPg=;
 b=I9Eaxi6H+dq5BAQuInHnM0+fFFL49jeDIJTyaqIqn7LKu3y69g/Td9KpyhbCBa4LNT
 7szQeF1yVqBXGA1UdfEzPELHcNMe7K3OFLp3XdwKoH7yTHXHp3S0i/ky07Xttz4iu7NU
 XThFXrPa3XoQVVkZ53XekwDM8nVEmYzOcLhxhiNFIREGgLg0HIOK3IcU7ZNsch4lKSNC
 hU0B4Z4R0CV1FcUtMZj2uJLNevPdhDustYwtRwKaropeegcr38VVGb/Buv9wPmwV+Lmm
 mRwexZ5FI/v+saBdigaBUnveqoyrg5jlRSsJWObFvnpcCA1JglQhFrUx42Gxv51dCpA9
 ZhWQ==
X-Gm-Message-State: AOJu0Yxk+PEKhKvxA9N91BV3IXzvHRcBx1WZvwo/EIBwjts6UBzvNRtj
 +0zwnDc9Y2oKdufip7sEVIRp3ovNRzbXfJxCt3INX8clKn4vOLlQabeffFTEhgOE4l93Uanwvcy
 b1StH
X-Gm-Gg: AfdE7cnF+yXjLvYYrqwza5a3IagmeB+px84wbIzKORQGYXZgwajgUFxbwFJ++55Jco7
 Zb8E2w2WEbkBsmfqRq8N7rq4oI+ixwgZVjOy7/oBBtZhp+FYt7xpGKuXE7YI6OoZc1BDcDOetoT
 0vmqhMXn51/xlWU2E/mcZ7BsaInNHT3CfTtpX2Q3CQP/Chj5MJWo6efSTwF7oeT4Dw+57nzPqnz
 CIuqNioZ/b79h+6KHTtNxsaWD3Hnafa7QN/46DVWamySoRqpBPK19p4A1cUdoJtSiDE7vTFlLph
 McIYFZhbgKHz9sWgoDQT7IGGKePjZiNVrh3q1oqnyDSNPVovs5kdr5JRkwGGkAkaD46ydDK9tnt
 ElnEukYQIlQTByCMus/AP1ooTYYFHrgqg9BYiECmFiEwotJc4B/f+yddMjVXwZuulDPk4ysm7X1
 oRkQvejyMvX8r7HKYpKDijy48qCfGz
X-Received: by 2002:a05:6870:812f:b0:448:558c:d849 with SMTP id
 586e51a60fabf-451062dfe85mr3747728fac.36.1783437032651; 
 Tue, 07 Jul 2026 08:10:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:27 -0500
Subject: [PATCH 07/24] clk: mediaTek: mt7986: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-7-65d24cc0d569@baylibre.com>
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zglLiYAsb5jfycTrbdqkghvR9RX1OTO2i0VqoO/mUGU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRZekmOZFgFC7qAmcteMW5fS9CgbK0c0c+3Yk
 TmYIRM2/lSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WXhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ai+sH/RbYouDEBtmR/C3wDbsZLM3bioXra3Gvqtl+6jK
 kLzE9iIG8nVUq0gkLV4TSeXlW3M460qpL5W/MFVCdfpahNTAd1ez5fz1Qc0aHoaW019BS58Pul+
 zFo4QZcCvxvYnQldLxeEPpP3QJu6k1JROu48LBgyGaLwDb/NPesSUqA4DjHltpC/ASwgBSlxwES
 W+31JPfhgV6r9r1saAssI2/jF90NmyNrT+jnRP5giYna63VYH9yJ+vEDMPqHBPdrhOPhlst+hKU
 Kg2evWZ5Qs8HhoO+AYx7TeTOwVwByDROpTi3nvlH0EDmhpVlRu0WHQleC9Ku6GvHs7aMCQj5KA5
 iyHs=
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

Add clock tree type flags to the mt7986 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 9c6514120a6..fa12e86eade 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -530,6 +530,7 @@ static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 	.flags = CLK_PARENT_APMIXED,
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
@@ -544,6 +545,7 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
@@ -559,6 +561,12 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 	.num_muxes = ARRAY_SIZE(infra_muxes),
 	.num_gates = ARRAY_SIZE(infracfg_gates),
 	.flags = CLK_PARENT_INFRASYS,
+	.type = MTK_CLK_TREE_INFRASYS,
+};
+
+static const struct mtk_clk_tree mt7986_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt7986_fixed_pll_compat[] = {
@@ -649,7 +657,7 @@ static const struct mtk_gate eth_cgs[] = {
 
 static int mt7986_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7986_topckgen_clk_tree, eth_cgs,
+	return mtk_common_clk_gate_init(dev, &mt7986_clk_tree, eth_cgs,
 					ARRAY_SIZE(eth_cgs), 0);
 }
 

-- 
2.43.0

