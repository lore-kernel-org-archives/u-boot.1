Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1436EB1070
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637EA8412C;
	Tue, 10 Mar 2026 16:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OGN7mF5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01DD84129; Tue, 10 Mar 2026 16:34:29 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F048410D
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-46701f2077cso9332b6e.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156864; x=1773761664;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qXxALbHXUS49Qogiopj7tf11wjlTUTWoBCTXLDLLfbI=;
 b=OGN7mF5s77qWNNyPWezt1RpTgq5sL1+LRjYMPfvpkH622UNNYOjJ7ouB1OV2O1id+k
 Hml8yfJ1RodC0b2qnLa6j3HP2DIt61GmRcBnmolAp3Ny68/a9o8Ano9zNaSll6QDwz3n
 XdNEJy3uVGY6fR2uHVx6MbhWU7dAvXtvsLHduhEgesMPh7L8cQrVESVhhuTZiQRa3d2I
 VNrTt+elgMAHYWssBe/207JDJiDPU0IJu7UewbM7vNbtEUaIfk+7H1pTdizcLk/lyUI2
 1qd5JNjkzb3QTx8KFMu4nThk0YnWAjLE3as8dJcJ496OIhRQ58CiTd3ykCaiYaEnl/uI
 OIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156864; x=1773761664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qXxALbHXUS49Qogiopj7tf11wjlTUTWoBCTXLDLLfbI=;
 b=U1ZrIbkFvMjTibPOnaUOADP2HuqNFyjmgoAB2KuBTRS2Q+RTjSrDX8LqryXBsMPte2
 85ior0+ifpr7AjxCZfVjuSNEVG4ugHZSumdP58ynrR9VmxS3Mvu8Q2kzAdKLhsZwsP2Z
 ia5AX45jecGybmJaNQ+T/Ac+rob8lV9UlAH1ncCcTcvSyUkpDEMeL3PgkUI7UWZo6c8N
 4FTfLPfMU3DOMWC8GzVjA//+HIzHNcI6K89Z2UcvR9WMBjGQ3JH535VgW67b5ECOfLvn
 SW7gco0Ix3YqHQvdPsJqplsh9CjfWz3eZ7rOd5LhBsLecie+pGcuZLr3NJJDfFos4SdC
 A9pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzOky+N9aodG3rxBxfin8L78s05FewvCCKPcCPQnPKAtAKYZTjblc5rsNGqLkVxu/S52+j4Ww=@lists.denx.de
X-Gm-Message-State: AOJu0YzuJc9y5kfYlpQsj7Kkb9sHikwc8USuwvFU00ta52gu+yja8mKm
 GMcHJOZJ1QqTWRJmb9+wsBivU4ZV5cEdROK6UZU/FAN++hTny+2ZHn5eYSwuXhcfiUU=
X-Gm-Gg: ATEYQzxaLXesVhrb8OM1NEsqvHLTLjrvrEPGfhit7uGSdL1Ne1gf2Be4O6gWo3Ne1QY
 VN3K06Y0rUW9pozM1PFm9R/8nXJ9bvjYU0+ZOkW+43Hzyxn9qEoAYWNtAoV7LaCs6IOJA0mmjea
 Cs3Y6dqxaBua9Di1uCOzhwSjkr1hjRfcmSA7irXWIzDVEDdmqOUqJzwzV78CTotcIVfz24O/UEP
 0mRrefXLR7AHalsNGKIiW6z8pp7T/iqkRzLVGrbZbo9Epanj8zggeBabwxytKbTyDJV4Uk9cV87
 xAlgAdDxTup6HAB6wYN9NDria9Rnz+sbM5ZgdyJaQzFgREF+IHyRjDoLaNKdW3TjqjMPGma0XKp
 gRGg3shkJGrXYCoKDtzqpmB0TQegjl7QEfKWZpdJcazIA6IuczB6UDd8ec8D7Ie+8BNbI5gGP5E
 wnuqrBm9qMQgz/RCCD+SHaeEtJ+YsH
X-Received: by 2002:a05:6808:1990:b0:45c:85fa:5a3e with SMTP id
 5614622812f47-4671bfb6b05mr2147431b6e.25.1773156864027; 
 Tue, 10 Mar 2026 08:34:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:21 -0500
Subject: [PATCH 08/16] clk: mediatek: mt7988: convert CLK_XTAL to
 CLK_PAD_CLK40M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-8-66175ca8f637@baylibre.com>
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6219; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=nFpynf7pfTll+E1JSn/3X6dVzIuel0Kz/QGsBzwCHzs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDm4fTh+gDCCN4v51fTEDEN06v4N1RCjvy7Nc
 CDU6O8pU8uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5uBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+JgH/1cVLHFn5DpoW922UfFdKNKbGoiJ3jcnFBw+wAw
 gZg1FASHlHF3qufc4F2Sx/MYRUgp2YwDM0OQpGwjCs4P6BG682PRnErZ5UXci2Nmn35ayZD7aih
 dXOz+LiboeQ6Qz0v7K2VeMceySLyo9PV52fFGUTW5a1TZMf451rPdfY8GXtFbxzWOhHNHgTQcLZ
 D48l+BgTT1FYnvJynfvB8jXsmIfyjBj0En0LrvBDBcrDmfFAAuoJvDHQ0zyzk47XpAHYjtsjR2B
 cz408O8yTv1rmxwwIPqtWVZ2YaTm4pZG0zL2IcJsTypgDP7Gn28bNQ1QtHJ62yafNBgdtP5KSLO
 Vziw=
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK40M.

This will eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 62 ++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index f951a6fc58d..4e19f285da0 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -21,11 +21,19 @@
 #define MT7988_ETHDMA_RST_CTRL_OFS	0x34
 #define MT7988_ETHWARP_RST_CTRL_OFS	0x8
 
+enum {
+	CLK_PAD_CLK40M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK40M] = 40 * MHZ,
+};
+
 #define FIXED_CLK0(_id, _rate)                                                 \
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK40M, CLK_PARENT_EXT, _rate)
 
-#define XTAL_FACTOR(_id, _name, _parent, _mult, _div)                          \
-	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+#define EXT_FACTOR(_id, _name, _parent, _mult, _div)                          \
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
 
 #define PLL_FACTOR(_id, _name, _parent, _mult, _div)                           \
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
@@ -629,8 +637,8 @@ static const struct mtk_gate_regs infra_3_cg_regs = {
 	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_INFRASYS)
 #define GATE_INFRA3_TOP(_id, _name, _parent, _shift) \
 	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
-#define GATE_INFRA3_XTAL(_id, _name, _parent, _shift) \
-	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_XTAL)
+#define GATE_INFRA3_EXT(_id, _name, _parent, _shift) \
+	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_EXT)
 
 /* INFRA GATE */
 static const struct mtk_gate infracfg_mtk_gates[] = {
@@ -751,21 +759,18 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 	GATE_INFRA3_TOP(CLK_INFRA_USB_SYS, "infra_usb_sys", CLK_TOP_USB_SYS_SEL, 4),
 	GATE_INFRA3_TOP(CLK_INFRA_USB_SYS_CK_P1, "infra_usb_sys_ck_p1",
 			CLK_TOP_USB_SYS_P1_SEL, 5),
-	GATE_INFRA3_XTAL(CLK_INFRA_USB_REF, "infra_usb_ref", CLK_XTAL, 6),
-	GATE_INFRA3_XTAL(CLK_INFRA_USB_CK_P1, "infra_usb_ck_p1", CLK_XTAL,
-			 7),
+	GATE_INFRA3_EXT(CLK_INFRA_USB_REF, "infra_usb_ref", CLK_PAD_CLK40M, 6),
+	GATE_INFRA3_EXT(CLK_INFRA_USB_CK_P1, "infra_usb_ck_p1", CLK_PAD_CLK40M, 7),
 	GATE_INFRA3_TOP(CLK_INFRA_USB_FRMCNT, "infra_usb_frmcnt",
 			CLK_TOP_USB_FRMCNT_SEL, 8),
 	GATE_INFRA3_TOP(CLK_INFRA_USB_FRMCNT_CK_P1, "infra_usb_frmcnt_ck_p1",
 			CLK_TOP_USB_FRMCNT_P1_SEL, 9),
-	GATE_INFRA3_XTAL(CLK_INFRA_USB_PIPE, "infra_usb_pipe", CLK_XTAL,
-			 10),
-	GATE_INFRA3_XTAL(CLK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1",
-			 CLK_XTAL, 11),
-	GATE_INFRA3_XTAL(CLK_INFRA_USB_UTMI, "infra_usb_utmi", CLK_XTAL,
-			 12),
-	GATE_INFRA3_XTAL(CLK_INFRA_USB_UTMI_CK_P1, "infra_usb_utmi_ck_p1",
-			 CLK_XTAL, 13),
+	GATE_INFRA3_EXT(CLK_INFRA_USB_PIPE, "infra_usb_pipe", CLK_PAD_CLK40M, 10),
+	GATE_INFRA3_EXT(CLK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1",
+			CLK_PAD_CLK40M, 11),
+	GATE_INFRA3_EXT(CLK_INFRA_USB_UTMI, "infra_usb_utmi", CLK_PAD_CLK40M, 12),
+	GATE_INFRA3_EXT(CLK_INFRA_USB_UTMI_CK_P1, "infra_usb_utmi_ck_p1",
+			CLK_PAD_CLK40M, 13),
 	GATE_INFRA3_TOP(CLK_INFRA_USB_XHCI, "infra_usb_xhci", CLK_TOP_USB_XHCI_SEL,
 			14),
 	GATE_INFRA3_TOP(CLK_INFRA_USB_XHCI_CK_P1, "infra_usb_xhci_ck_p1",
@@ -778,14 +783,14 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 			  CLK_INFRA_PCIE_GFMUX_TL_O_P2_SEL, 22),
 	GATE_INFRA3_INFRA(CLK_INFRA_PCIE_GFMUX_TL_P3, "infra_pcie_gfmux_tl_ck_p3",
 			  CLK_INFRA_PCIE_GFMUX_TL_O_P3_SEL, 23),
-	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P0, "infra_pcie_pipe_ck_p0",
-			 CLK_XTAL, 24),
-	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P1, "infra_pcie_pipe_ck_p1",
-			 CLK_XTAL, 25),
-	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P2, "infra_pcie_pipe_ck_p2",
-			 CLK_XTAL, 26),
-	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P3, "infra_pcie_pipe_ck_p3",
-			 CLK_XTAL, 27),
+	GATE_INFRA3_EXT(CLK_INFRA_PCIE_PIPE_P0, "infra_pcie_pipe_ck_p0",
+			CLK_PAD_CLK40M, 24),
+	GATE_INFRA3_EXT(CLK_INFRA_PCIE_PIPE_P1, "infra_pcie_pipe_ck_p1",
+			CLK_PAD_CLK40M, 25),
+	GATE_INFRA3_EXT(CLK_INFRA_PCIE_PIPE_P2, "infra_pcie_pipe_ck_p2",
+			CLK_PAD_CLK40M, 26),
+	GATE_INFRA3_EXT(CLK_INFRA_PCIE_PIPE_P3, "infra_pcie_pipe_ck_p3",
+			CLK_PAD_CLK40M, 27),
 	GATE_INFRA3_TOP(CLK_INFRA_133M_PCIE_CK_P0, "infra_133m_pcie_ck_p0",
 			CLK_TOP_SYSAXI_SEL, 28),
 	GATE_INFRA3_TOP(CLK_INFRA_133M_PCIE_CK_P1, "infra_133m_pcie_ck_p1",
@@ -797,14 +802,17 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 };
 
 static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
-	.xtal_rate = 40 * MHZ,
 };
 
 static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_XTAL_D2,
 	.muxes_offs = CLK_TOP_NETSYS_SEL,
 	.fclks = topckgen_mtk_fixed_clks,
@@ -814,17 +822,17 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
-	.xtal_rate = 40 * MHZ,
 };
 
 static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.muxes_offs = CLK_INFRA_MUX_UART0_SEL,
 	.gates_offs = CLK_INFRA_PCIE_PERI_26M_CK_P0,
 	.muxes = infracfg_mtk_mux,
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
-	.xtal_rate = 40 * MHZ,
 };
 
 static const struct udevice_id mt7988_fixed_pll_compat[] = {

-- 
2.43.0

