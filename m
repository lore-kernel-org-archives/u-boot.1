Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032A71061B21
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0EA84090;
	Mon, 30 Mar 2026 22:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B2Qs4TH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E11898352B; Mon, 30 Mar 2026 22:43:13 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905C883E7A
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d7653db148so2709421a34.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774903389; x=1775508189;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1WiC14l1ivRqcz8bLfl23c93WlJIh3lw8by+arc/kR4=;
 b=B2Qs4TH4aDUxWQf2zFlotOr8duA9Jdbg8E1eR4OXY1PxtFq6rBjc7oB6L9oEq0HUIz
 FaR/LgdQe1AtoIzE/GgtCACRsO1EQT84Pzb0LoDVLG6H6kY9wvVQOTMi0q8e1IJc4/Ba
 siHKPcnglZItsycH4ufAGlhVblI80Uw5mTLQjdHfbxZVdWpXEtZQVDm5Qcbd9hCkyp9q
 Oya688GcBhot6gNTAY4dVmaEkhFVWGubRyU/60D+jIdGyooZ4krWouo0korMKoBINiGe
 dKysbwpWppYhgRDReKlWxCWjdKjdVIr97iPkieo4nMoFJ13vdFQtIM8O5G3MOpijH1n3
 bE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903389; x=1775508189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1WiC14l1ivRqcz8bLfl23c93WlJIh3lw8by+arc/kR4=;
 b=jSVzfvoYr36hHQjmp8+NvrPSiyAqEODB0U6f3VKlLGDWgeLMyMbOoguERtE6wuZRiy
 Aall9Lq5aVX+Fj9/HXw+jAK1KTmWfdqrGwrzP8iAs0UXaYrqCFibuNhJS3wjr3mw+GDC
 /3ChUM9y/A8oOhdqQA7LsX/NNmzmD0f7I/oEww8W3D5hXNjLisTuwN0ui9EEtjrievYZ
 bTQ4KslrCh1/D5Ae0IAROf+HgkOOnqCdk/Vg2kHcYXjeHStbY49ALsfkzZ5nAm3XPZ5d
 9wbofYjjFQQVHLJtBu6FlzuvNpyGBElWqjcwgPi5kKXRS5zpjVUS7hRGY3OdmzhABked
 BMuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3FSj9taGBHCOVFvMcUHvFu2ZtEH4Y88idGdQ3toKB51yuNyKwl3A/jzAQJLOqXphb/fLUNPE=@lists.denx.de
X-Gm-Message-State: AOJu0YxxkREw4o6gF9P73cU3dMXc0HjnWYyrk+dhdb0rh+P9uNo12nyP
 +KL6MdaHFQJK5dHozDsxSLBOiXRV00HhzaSKmvScX351n3SCMKMWIIIVuSOu9ZtmHdY=
X-Gm-Gg: ATEYQzxVigIkkFd8ImCmtqbPJDhmUf4y518ogFa5MzVCCyXAEfbAR7s7dUJt8aXiXp0
 gSuDcUS6hZv02iLH+NNtLR/XcN1McSgFHzGPVIPj4D81AGUPJkCxrM7VykQGvdm+x7A0M6nYKra
 IvikGuYP0MrCCEplDuppcaGecbatryhKh9QZX/H0uIPJpYck84KdF/eave65hXRhs4bSdHdM01t
 LV7uTYy5rhAr/NNJuhbwG5ctdqFgl/8G3ENuU8s5VliCKpD6TIQf6hWf8fc1rb2xj1YB29lYV2O
 hHQs49Sd31q/O56N/0w0bHB772inbU4qfr0mG7ujnz4gSLkCi9sgQnCpnnAcg79PIclrjrkQBko
 hsEQzYCKHZkI0556CVg+Owpttc88snM4M5Rk9ynoF+LEhdlKkm023bgNV+KhfQN22a7ngOT6iLs
 f6ERQTkcUYzZX1xNhWhuNSJZEnGTAm
X-Received: by 2002:a05:6830:3811:b0:7d7:fbe2:9725 with SMTP id
 46e09a7af769-7d9fadcee5bmr7857447a34.5.1774903389277; 
 Mon, 30 Mar 2026 13:43:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a384631sm6595736a34.7.2026.03.30.13.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:43:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 15:42:15 -0500
Subject: [PATCH 3/6] clk: mediatek: mt8189: add UFS clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mtk-genio-720-ufs-v1-3-3bad8362ed70@baylibre.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3327; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=B/ABSxkbFpRwOSriHM19ZOZE83XdVIum2jPd1Rhapko=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyuA+D8/K+Owu7Eg0oQkvMj5/eDFTXU5VI4sFJ
 mzanodg6oqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrgPhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AELAH/0LqoLvMxjriJT2FhjUVHWa429tSDa84t2N4M+t
 n2QaVlnBUPu2jeRbg99/CguQtiKfhh/lkG/HN+M/2nrBhBEvUcAVk2mu5DXcJJA572Hkjv4Qln2
 wO2aUoxsicyGMezEX27GG5ddqAZ1YCeNFJ0t+V1ex48tgNtv7miTPhpSh2XVGhsr7XNLpVnsiDG
 EUCQpL8lC3+MeeuZSs3KxTbXL2TIi09XzU0R/jeo2LEEnPWZTqwfVkF68e3dh34guaebW5MGW57
 yZvAnmNz2oX8De6rgOhsHvEzx4pcSL1SejkNAAqoeFhMHjnl1a7KzsK8W501SM0OUPxSgGS4A/o
 iedg=
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

Add some clocks required for UFS on MT8189 targets.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 9e640059f11..d11947ee461 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1641,6 +1641,46 @@ static const struct mtk_gate mminfra_config_clks[] = {
 	GATE_MMINFRA_CONFIG1(CLK_MMINFRA_GCE_26M, CLK_TOP_MMINFRA_SEL, 17),
 };
 
+static const struct mtk_gate_regs ufscfg_ao_reg_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSCFG_AO_REG_EXT(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &ufscfg_ao_reg_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_EXT)
+
+#define GATE_UFSCFG_AO_REG_TOP(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &ufscfg_ao_reg_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+static const struct mtk_gate ufs_config_ao_clks[] = {
+	GATE_UFSCFG_AO_REG_EXT(CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM, CLK_PAD_CLK26M, 1),
+	GATE_UFSCFG_AO_REG_EXT(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0, CLK_PAD_CLK26M, 2),
+	GATE_UFSCFG_AO_REG_EXT(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1, CLK_PAD_CLK26M, 3),
+	GATE_UFSCFG_AO_REG_TOP(CLK_UFSCFG_AO_REG_UNIPRO_SYS, CLK_TOP_U_SEL, 4),
+	GATE_UFSCFG_AO_REG_EXT(CLK_UFSCFG_AO_REG_U_SAP_CFG, CLK_PAD_CLK26M, 5),
+	GATE_UFSCFG_AO_REG_TOP(CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS, CLK_TOP_AXI_U_SEL, 6),
+};
+
+static const struct mtk_gate_regs ufscfg_pdn_reg_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSCFG_PDN_REG(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &ufscfg_pdn_reg_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+static const struct mtk_gate ufs_config_pdn_clks[] = {
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_UFS, CLK_TOP_U_SEL, 0),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_AES, CLK_TOP_AES_UFSFDE_SEL, 1),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AHB, CLK_TOP_AXI_U_SEL, 3),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AXI, CLK_TOP_MEM_SUB_U_SEL, 5),
+};
+
 static const struct mtk_parent vlp_26m_oscd10_parents[] = {
 	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_OSC_D10),
@@ -1955,6 +1995,8 @@ GATE_CLK_DATA(perao_clks);
 GATE_CLK_DATA(imp_clks);
 GATE_CLK_DATA(mm_clks);
 GATE_CLK_DATA(mminfra_config_clks);
+GATE_CLK_DATA(ufs_config_ao_clks);
+GATE_CLK_DATA(ufs_config_pdn_clks);
 GATE_CLK_DATA(vlpcfg_ao_clks);
 
 static const struct udevice_id of_match_mt8189_clk_gate[] = {
@@ -1962,6 +2004,8 @@ static const struct udevice_id of_match_mt8189_clk_gate[] = {
 	{ .compatible = "mediatek,mt8189-iic-wrap", .data = (ulong)&imp_clks_data },
 	{ .compatible = "mediatek,mt8189-dispsys", .data = (ulong)&mm_clks_data },
 	{ .compatible = "mediatek,mt8189-mm-infra", .data = (ulong)&mminfra_config_clks_data },
+	{ .compatible = "mediatek,mt8189-ufscfg-ao", .data = (ulong)&ufs_config_ao_clks_data },
+	{ .compatible = "mediatek,mt8189-ufscfg-pdn", .data = (ulong)&ufs_config_pdn_clks_data },
 	{ .compatible = "mediatek,mt8189-vlpcfg-ao", .data = (ulong)&vlpcfg_ao_clks_data },
 	{ }
 };

-- 
2.43.0

