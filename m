Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D189C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2000B60783;
	Wed, 26 Aug 2026 13:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pCHIl0IfP7Op; Wed, 26 Aug 2026 13:09:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749791;
	bh=8Kn1gUEuUZFqo4tnewOdnViqQZTd6qloWHooRZWjj8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HhOglD1Ux1vuv8CRqM+GwSVfCsHcLYR/NC6bUhVt/4vS6pbBFJ2Jia90HX9RS+W2k
	 zE8KnxbNaiDvrwavM0JkMXaBXVrZ6qDXIKPqqKZHY6ABzOTvRqLygE3pq1hgu5JRDe
	 qglBUGLPvdCobRsMVOdtrdSOyHuOku2uzDDDqySq1STr2ete+So0j7yXO2VeCgrEn9
	 Dd7D0HpfYdlZ2HEE3gLBJlB4g17/VC7AudjuRTBgIZI6+dQYeHLtpSGTAe7uWFFong
	 ler43KjQzlNLMsCn3zGXOzk2V4hwAdGDnQvTE7JtyZabQUTNL+JA8Ss0hsNuFjWDcF
	 FF1dwsSU2E1lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FFB060771;
	Wed, 26 Aug 2026 13:09:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 41259396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2700040695
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b6YXOm_fHEyf for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AxDG7EAq
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D82A40684
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:43 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso382263f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749781; x=1788354581;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Kn1gUEuUZFqo4tnewOdnViqQZTd6qloWHooRZWjj8U=;
 b=AxDG7EAqxRbU7//yHIHl+K1oKZ/JFHkFYnZUcKkr2yfYudjIOpXzeeiwHJhlF5p+TJ
 5RyOq381jfvmvNVM6iL+nNbJM+wbuSELAUKidJwmt5r28C7ptiBYkgtwpVOvxNoj8UuI
 v9CjNQUhLyfDqvbV1kthpuBKF6qg/dvJNu1CD2v5N/CMKe9+vb2Urz9uTHqLQC83H9E5
 KHon9eghJQyncMAwn64Eif+z0nbALroz3+gOFP7lTdsPwa+DOPFMfPACjIexUdNnDRbI
 gJaA+U4Obaa4kL5v1EwO9VSeQAAG9MVmtrConoDQQVTZDkNSxdxsmfNARpg3y4Z9oIA+
 B1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749781; x=1788354581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Kn1gUEuUZFqo4tnewOdnViqQZTd6qloWHooRZWjj8U=;
 b=TY2SRjSeL5YgTdFycn3vNphUKymXpRaEbhf2BXv1ciqKbIsHV9tn/JwD7gEnYlSIoj
 XgG+2opeO+I54pGXf0XScoHLkybPv24ib7mckVE4T/JE/c4mCP9MPd5LOuJAz/MBQVZF
 ladpVsLfClT/dIYOLKEJSDXM1/9jWZS2czGWgeAYb8yOdjdtIVSRZRazYFfOccI1/ipl
 TLZDwzNA8D5FoOPiwS8WwkGw6gWT8iaWUNY/zdARIrO+ZdvmN1BRJaCpsRFbmzu2a6At
 4vLilp4OX1UHRolrx6SHJuOkmJfQHnYpBpnmvIIMUVp4lBkeApZtCn08JSZMyBHmTIC2
 et5A==
X-Gm-Message-State: AFuF++llQL1kqOpQc5P2wbXOxr6WRW0WltwX5MnfDbROT9OxB1ci+wFr
 9xzUeCGNX3h+Xa8RjX4GQQH6MRBhR/t2GNzMfbaej5KtQ0xMb2IVF30PbFcohy127tc=
X-Gm-Gg: AR+sD12oCwhTlIcfM9xXwEk6Z8CVpiKQB01mLs2TvNZnBZw9i6wk1YWJ4Q6stc0PeNW
 PTeVh3AYDlWLI3w0iWRrlK8eLxYPNi2D1b9inQw0i+lKwBzP9tuVjXqZ6cOW4SHDtcqrUeA35Fa
 adYVkEAv4V3Afg7C8wIbK9YihkQbtmzMFlBxHqguP7Wq0aqQ/PgW7PKVCcnyLdTyh/VK+2svzAC
 qrAxAwR/kjFHLMM/rVFErpcrsYMx9MDTuLGI7HN6avlSsM711BnGvYtgf5m8zHXYjcdCY1Yj8HF
 fS1T4tzTIbLEgzFDAdGCTWf8aGzQp04NbWHiYIZwNCU3ga2Jj6oP6JDvNWQgVzL6VACiSHIPjLV
 l62/IPV+19oQkzE37A5J7rUPKVgWolD93ujAWvdhuXLUADM2wJF4ixtAXvstWm4N5Gl2L83M9No
 ZPLskAx2WvulRGpDZG0O8VWRrYDh5iCwJ1dqXwCbwgYYziNJuRxBj2x+HAgHfGZDjhbTcMHcrFC
 e/atD2Oq81zU1KZ3mM5ELCf6918axTjJagyzH26qzmFAbrEiFYjHLpF5Wmgq9o5fgqNQ8O4JraY
 TedzHg7nCQFy9dvXFM/PZq5nll2kWEXsgYwcZYweNVQo+XtSlr4UOwXe
X-Received: by 2002:a05:6000:4a0b:b0:482:a8b1:aa6d with SMTP id
 ffacd0b85a97d-482e26d8887mr7586399f8f.10.1787749781099; 
 Wed, 26 Aug 2026 06:09:41 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:40 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:35 +0200
Subject: [PATCH v2 08/14] video: mediatek: add dpi1 component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-8-68ebb1bf17df@baylibre.com>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

DPI is one of the components of the video pipeline on some MediaTek
SoCs, such as the MT8188: it is the timing generator interface
feeding the HDMI TX. Sync polarities, porches and the interlace mode
are taken from the struct display_timing selected from the EDID.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_dpi.c      | 379 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_dpi.h      |  20 ++
 drivers/video/mediatek/mtk_dpi_regs.h | 113 ++++++++++
 3 files changed, 512 insertions(+)

diff --git a/drivers/video/mediatek/mtk_dpi.c b/drivers/video/mediatek/mtk_dpi.c
new file mode 100644
index 00000000000..7d72ab300e6
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dpi.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek MT8188 DPI support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_dpi.h"
+#include "mtk_dpi_regs.h"
+
+enum mtk_dpintf_out_bit_num {
+	MTK_DPINTF_OUT_BIT_NUM_8BITS,
+	MTK_DPINTF_OUT_BIT_NUM_10BITS,
+	MTK_DPINTF_OUT_BIT_NUM_12BITS,
+	MTK_DPINTF_OUT_BIT_NUM_16BITS
+};
+
+enum mtk_dpintf_out_yc_map {
+	MTK_DPINTF_OUT_YC_MAP_RGB,
+	MTK_DPINTF_OUT_YC_MAP_CYCY,
+	MTK_DPINTF_OUT_YC_MAP_YCYC,
+	MTK_DPINTF_OUT_YC_MAP_CY,
+	MTK_DPINTF_OUT_YC_MAP_YC
+};
+
+enum mtk_dpintf_out_channel_swap {
+	MTK_DPINTF_OUT_CHANNEL_SWAP_RGB,
+	MTK_DPINTF_OUT_CHANNEL_SWAP_GBR,
+	MTK_DPINTF_OUT_CHANNEL_SWAP_BRG,
+	MTK_DPINTF_OUT_CHANNEL_SWAP_RBG,
+	MTK_DPINTF_OUT_CHANNEL_SWAP_GRB,
+	MTK_DPINTF_OUT_CHANNEL_SWAP_BGR
+};
+
+enum mtk_dpintf_polarity {
+	MTK_DPINTF_POLARITY_RISING,
+	MTK_DPINTF_POLARITY_FALLING,
+};
+
+struct mtk_dpintf_polarities {
+	enum mtk_dpintf_polarity de_pol;
+	enum mtk_dpintf_polarity ck_pol;
+	enum mtk_dpintf_polarity hsync_pol;
+	enum mtk_dpintf_polarity vsync_pol;
+};
+
+struct mtk_dpintf_sync_param {
+	u32 sync_width;
+	u32 front_porch;
+	u32 back_porch;
+	bool shift_half_line;
+};
+
+struct mtk_dpintf_yc_limit {
+	u16 y_top;
+	u16 y_bottom;
+	u16 c_top;
+	u16 c_bottom;
+};
+
+static void mtk_dpi_mask(struct udevice *dev, u32 offset, u32 val, u32 mask)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	void __iomem *addr = priv->base + offset;
+	u32 tmp = readl(addr) & ~mask;
+
+	tmp |= (val & mask);
+	writel(tmp, addr);
+}
+
+static void mtk_dpi_sw_reset(struct udevice *dev, bool reset)
+{
+	mtk_dpi_mask(dev, DPI_RST, reset ? RST : 0, RST);
+}
+
+static void mtk_dpi_config_hsync(struct udevice *dev,
+				 struct mtk_dpintf_sync_param *sync)
+{
+	mtk_dpi_mask(dev, DPI_TGEN_HWIDTH, sync->sync_width << HPW, HPW_MASK);
+	mtk_dpi_mask(dev, DPI_TGEN_HPORCH, sync->back_porch << HBP, HBP_MASK);
+	mtk_dpi_mask(dev, DPI_TGEN_HPORCH, sync->front_porch << HFP, HFP_MASK);
+}
+
+static void mtk_dpi_config_vsync(struct udevice *dev,
+				 struct mtk_dpintf_sync_param *sync,
+				 u32 width_addr, u32 porch_addr)
+{
+	mtk_dpi_mask(dev, width_addr, sync->sync_width << VSYNC_WIDTH_SHIFT,
+		     VSYNC_WIDTH_MASK);
+	mtk_dpi_mask(dev, width_addr,
+		     sync->shift_half_line << VSYNC_HALF_LINE_SHIFT,
+		     VSYNC_HALF_LINE_MASK);
+	mtk_dpi_mask(dev, porch_addr,
+		     sync->back_porch << VSYNC_BACK_PORCH_SHIFT,
+		     VSYNC_BACK_PORCH_MASK);
+	mtk_dpi_mask(dev, porch_addr,
+		     sync->front_porch << VSYNC_FRONT_PORCH_SHIFT,
+		     VSYNC_FRONT_PORCH_MASK);
+}
+
+static void mtk_dpi_config_vsync_lodd(struct udevice *dev,
+				      struct mtk_dpintf_sync_param *sync)
+{
+	mtk_dpi_config_vsync(dev, sync, DPI_TGEN_VWIDTH, DPI_TGEN_VPORCH);
+}
+
+static void mtk_dpi_config_vsync_leven(struct udevice *dev,
+				       struct mtk_dpintf_sync_param *sync)
+{
+	mtk_dpi_config_vsync(dev, sync, DPI_TGEN_VWIDTH_LEVEN,
+			     DPI_TGEN_VPORCH_LEVEN);
+}
+
+static void mtk_dpi_config_vsync_rodd(struct udevice *dev,
+				      struct mtk_dpintf_sync_param *sync)
+{
+	mtk_dpi_config_vsync(dev, sync, DPI_TGEN_VWIDTH_RODD,
+			     DPI_TGEN_VPORCH_RODD);
+}
+
+static void mtk_dpi_config_vsync_reven(struct udevice *dev,
+				       struct mtk_dpintf_sync_param *sync)
+{
+	mtk_dpi_config_vsync(dev, sync, DPI_TGEN_VWIDTH_REVEN,
+			     DPI_TGEN_VPORCH_REVEN);
+}
+
+static void mtk_dpi_config_pol(struct udevice *dev,
+			       struct mtk_dpintf_polarities *dpi_pol)
+{
+	unsigned int pol;
+
+	pol = (dpi_pol->ck_pol == MTK_DPINTF_POLARITY_RISING ? 0 : CK_POL) |
+	      (dpi_pol->de_pol == MTK_DPINTF_POLARITY_RISING ? 0 : DE_POL) |
+	      (dpi_pol->hsync_pol == MTK_DPINTF_POLARITY_RISING ?
+	       0 : HSYNC_POL) |
+	      (dpi_pol->vsync_pol == MTK_DPINTF_POLARITY_RISING ?
+	       0 : VSYNC_POL);
+	mtk_dpi_mask(dev, DPI_OUTPUT_SETTING, pol,
+		     CK_POL | DE_POL | HSYNC_POL | VSYNC_POL);
+}
+
+static void mtk_dpi_config_interface(struct udevice *dev, bool inter)
+{
+	mtk_dpi_mask(dev, DPI_CON, inter ? INTL_EN : 0, INTL_EN);
+}
+
+static void mtk_dpi_config_input_2p(struct udevice *dev, bool input_2p)
+{
+	mtk_dpi_mask(dev, DPI_CON, input_2p ? INPUT_2P_EN : 0, INPUT_2P_EN);
+}
+
+static void mtk_dpi_config_output_1t1p(struct udevice *dev, bool output_1t1p)
+{
+	mtk_dpi_mask(dev, DPI_CON, output_1t1p ? OUTPUT_1T1P_EN : 0,
+		     OUTPUT_1T1P_EN);
+}
+
+static void mtk_dpi_config_fb_size(struct udevice *dev, u32 width, u32 height)
+{
+	mtk_dpi_mask(dev, DPI_SIZE, width << HSIZE, HSIZE_MASK);
+	mtk_dpi_mask(dev, DPI_SIZE, height << VSIZE, VSIZE_MASK);
+}
+
+static void mtk_dpi_config_channel_limit(struct udevice *dev,
+					 struct mtk_dpintf_yc_limit *limit)
+{
+	mtk_dpi_mask(dev, DPI_Y_LIMIT, limit->y_bottom << Y_LIMINT_BOT,
+		     Y_LIMINT_BOT_MASK);
+	mtk_dpi_mask(dev, DPI_Y_LIMIT, limit->y_top << Y_LIMINT_TOP,
+		     Y_LIMINT_TOP_MASK);
+	mtk_dpi_mask(dev, DPI_C_LIMIT, limit->c_bottom << C_LIMIT_BOT,
+		     C_LIMIT_BOT_MASK);
+	mtk_dpi_mask(dev, DPI_C_LIMIT, limit->c_top << C_LIMIT_TOP,
+		     C_LIMIT_TOP_MASK);
+}
+
+static void mtk_dpi_config_bit_num(struct udevice *dev,
+				   enum mtk_dpintf_out_bit_num num)
+{
+	u32 val;
+
+	switch (num) {
+	case MTK_DPINTF_OUT_BIT_NUM_8BITS:
+		val = OUT_BIT_8;
+		break;
+	case MTK_DPINTF_OUT_BIT_NUM_10BITS:
+		val = OUT_BIT_10;
+		break;
+	case MTK_DPINTF_OUT_BIT_NUM_12BITS:
+		val = OUT_BIT_12;
+		break;
+	case MTK_DPINTF_OUT_BIT_NUM_16BITS:
+		val = OUT_BIT_16;
+		break;
+	default:
+		val = OUT_BIT_8;
+		break;
+	}
+
+	mtk_dpi_mask(dev, DPI_OUTPUT_SETTING, val << OUT_BIT, OUT_BIT_MASK);
+}
+
+static void mtk_dpi_config_yc_map(struct udevice *dev,
+				  enum mtk_dpintf_out_yc_map map)
+{
+	u32 val;
+
+	switch (map) {
+	case MTK_DPINTF_OUT_YC_MAP_RGB:
+		val = YC_MAP_RGB;
+		break;
+	case MTK_DPINTF_OUT_YC_MAP_CYCY:
+		val = YC_MAP_CYCY;
+		break;
+	case MTK_DPINTF_OUT_YC_MAP_YCYC:
+		val = YC_MAP_YCYC;
+		break;
+	case MTK_DPINTF_OUT_YC_MAP_CY:
+		val = YC_MAP_CY;
+		break;
+	case MTK_DPINTF_OUT_YC_MAP_YC:
+		val = YC_MAP_YC;
+		break;
+	default:
+		val = YC_MAP_RGB;
+		break;
+	}
+
+	mtk_dpi_mask(dev, DPI_OUTPUT_SETTING, val << YC_MAP, YC_MAP_MASK);
+}
+
+static void mtk_dpi_config_channel_swap(struct udevice *dev,
+					enum mtk_dpintf_out_channel_swap swap)
+{
+	u32 val;
+
+	switch (swap) {
+	case MTK_DPINTF_OUT_CHANNEL_SWAP_RGB:
+		val = SWAP_RGB;
+		break;
+	case MTK_DPINTF_OUT_CHANNEL_SWAP_GBR:
+		val = SWAP_GBR;
+		break;
+	case MTK_DPINTF_OUT_CHANNEL_SWAP_BRG:
+		val = SWAP_BRG;
+		break;
+	case MTK_DPINTF_OUT_CHANNEL_SWAP_RBG:
+		val = SWAP_RBG;
+		break;
+	case MTK_DPINTF_OUT_CHANNEL_SWAP_GRB:
+		val = SWAP_GRB;
+		break;
+	case MTK_DPINTF_OUT_CHANNEL_SWAP_BGR:
+		val = SWAP_BGR;
+		break;
+	default:
+		val = SWAP_RGB;
+		break;
+	}
+
+	mtk_dpi_mask(dev, DPI_OUTPUT_SETTING, val << CH_SWAP, CH_SWAP_MASK);
+}
+
+static void mtk_dpi_config_csc_enable(struct udevice *dev, bool enable)
+{
+	mtk_dpi_mask(dev, DPI_CON, enable ? CSC_ENABLE : 0, CSC_ENABLE);
+}
+
+static void mtk_dpi_config_swap_input(struct udevice *dev, bool enable)
+{
+	mtk_dpi_mask(dev, DPI_CON, enable ? IN_RB_SWAP : 0, IN_RB_SWAP);
+}
+
+static void mtk_dpi_internal_matrix_sel(struct udevice *dev, bool enable)
+{
+	mtk_dpi_config_csc_enable(dev, enable);
+	if (enable)
+		mtk_dpi_mask(dev, DPI_MATRIX_SET, RGB_TO_BT709,
+			     INT_MATRIX_SEL_MASK);
+}
+
+void mtk_dpi_hw_enable(struct udevice *dev)
+{
+	mtk_dpi_mask(dev, DPI_EN, EN, EN);
+}
+
+void mtk_dpi_hw_disable(struct udevice *dev)
+{
+	mtk_dpi_mask(dev, DPI_EN, 0, EN);
+}
+
+void mtk_dpi_config(struct udevice *dev, const struct display_timing *timing,
+		    bool rgb)
+{
+	struct mtk_dpintf_yc_limit limit;
+	struct mtk_dpintf_polarities dpi_pol;
+	struct mtk_dpintf_sync_param hsync;
+	struct mtk_dpintf_sync_param vsync_lodd = { 0 };
+	struct mtk_dpintf_sync_param vsync_leven = { 0 };
+	struct mtk_dpintf_sync_param vsync_rodd = { 0 };
+	struct mtk_dpintf_sync_param vsync_reven = { 0 };
+	bool interlaced = timing->flags & DISPLAY_FLAGS_INTERLACED;
+
+	limit.c_bottom = 0x0010;
+	limit.c_top = 0x0FE0;
+	limit.y_bottom = 0x0010;
+	limit.y_top = 0x0FE0;
+
+	dpi_pol.ck_pol = MTK_DPINTF_POLARITY_FALLING;
+	dpi_pol.de_pol = MTK_DPINTF_POLARITY_RISING;
+	dpi_pol.hsync_pol = timing->flags & DISPLAY_FLAGS_HSYNC_HIGH ?
+			    MTK_DPINTF_POLARITY_RISING :
+			    MTK_DPINTF_POLARITY_FALLING;
+	dpi_pol.vsync_pol = timing->flags & DISPLAY_FLAGS_VSYNC_HIGH ?
+			    MTK_DPINTF_POLARITY_RISING :
+			    MTK_DPINTF_POLARITY_FALLING;
+
+	hsync.sync_width = timing->hsync_len.typ;
+	hsync.back_porch = timing->hback_porch.typ;
+	hsync.front_porch = timing->hfront_porch.typ;
+	hsync.shift_half_line = false;
+
+	vsync_lodd.sync_width = timing->vsync_len.typ;
+	vsync_lodd.back_porch = timing->vback_porch.typ;
+	vsync_lodd.front_porch = timing->vfront_porch.typ;
+	vsync_lodd.shift_half_line = false;
+
+	if (interlaced) {
+		vsync_leven = vsync_lodd;
+		vsync_leven.shift_half_line = true;
+	}
+
+	mtk_dpi_sw_reset(dev, true);
+	mtk_dpi_config_pol(dev, &dpi_pol);
+
+	mtk_dpi_config_hsync(dev, &hsync);
+	mtk_dpi_config_vsync_lodd(dev, &vsync_lodd);
+	mtk_dpi_config_vsync_rodd(dev, &vsync_rodd);
+	mtk_dpi_config_vsync_leven(dev, &vsync_leven);
+	mtk_dpi_config_vsync_reven(dev, &vsync_reven);
+
+	mtk_dpi_config_interface(dev, interlaced);
+	if (interlaced)
+		mtk_dpi_config_fb_size(dev, timing->hactive.typ,
+				       timing->vactive.typ / 2);
+	else
+		mtk_dpi_config_fb_size(dev, timing->hactive.typ,
+				       timing->vactive.typ);
+
+	mtk_dpi_config_input_2p(dev, true);
+	mtk_dpi_config_output_1t1p(dev, true);
+	mtk_dpi_config_channel_limit(dev, &limit);
+	mtk_dpi_config_bit_num(dev, MTK_DPINTF_OUT_BIT_NUM_8BITS);
+	mtk_dpi_config_channel_swap(dev, MTK_DPINTF_OUT_CHANNEL_SWAP_RGB);
+	mtk_dpi_internal_matrix_sel(dev, !rgb);
+	mtk_dpi_config_yc_map(dev, MTK_DPINTF_OUT_YC_MAP_RGB);
+	mtk_dpi_config_swap_input(dev, false);
+	mtk_dpi_sw_reset(dev, false);
+}
+
+static const struct udevice_id mtk_dpi_ids[] = {
+	{ .compatible = "mediatek,mt8188-dpi" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_dpi) = {
+	.name	   = "mtk_dpi",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_dpi_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_dpi.h b/drivers/video/mediatek/mtk_dpi.h
new file mode 100644
index 00000000000..ccce83ec8d3
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dpi.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mediatek MT8188 DPI Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DPI_H
+#define _MTK_DPI_H
+
+struct display_timing;
+struct udevice;
+
+void mtk_dpi_hw_enable(struct udevice *dev);
+void mtk_dpi_hw_disable(struct udevice *dev);
+void mtk_dpi_config(struct udevice *dev, const struct display_timing *timing,
+		    bool rgb);
+
+#endif
diff --git a/drivers/video/mediatek/mtk_dpi_regs.h b/drivers/video/mediatek/mtk_dpi_regs.h
new file mode 100644
index 00000000000..54e370460f0
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dpi_regs.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ * Copyright (c) 2026 BayLibre, SAS
+ */
+
+#ifndef __MTK_DPI_REGS_H
+#define __MTK_DPI_REGS_H
+
+#define DPI_EN				0x00
+#define EN				(0x1 << 0)
+
+#define DPI_RST				0x04
+#define RST				(0x1 << 0)
+
+#define DPI_INTEN			0x08
+#define INT_VSYNC_EN			(0x1 << 0)
+
+#define DPI_CON				0x10
+#define IN_RB_SWAP			(0x1 << 1)
+#define INTL_EN				(0x1 << 2)
+#define TDFP_EN				(0x1 << 3)
+#define YUV422_EN			(0x1 << 5)
+#define CSC_ENABLE			(0x1 << 6)
+#define OUTPUT_1T1P_EN			(0x1 << 24)
+#define INPUT_2P_EN			(0x1 << 25)
+
+#define DPI_OUTPUT_SETTING		0x14
+#define CH_SWAP				0
+#define CH_SWAP_MASK			(0x7 << 0)
+#define SWAP_RGB			0x00
+#define SWAP_GBR			0x01
+#define SWAP_BRG			0x02
+#define SWAP_RBG			0x03
+#define SWAP_GRB			0x04
+#define SWAP_BGR			0x05
+#define DE_POL				(0x1 << 12)
+#define HSYNC_POL			(0x1 << 13)
+#define VSYNC_POL			(0x1 << 14)
+#define CK_POL				(0x1 << 15)
+#define OUT_BIT				18
+#define OUT_BIT_MASK			(0x3 << 18)
+#define OUT_BIT_8			0x00
+#define OUT_BIT_10			0x01
+#define OUT_BIT_12			0x02
+#define OUT_BIT_16			0x03
+#define YC_MAP				20
+#define YC_MAP_MASK			(0x7 << 20)
+#define YC_MAP_RGB			0x00
+#define YC_MAP_CYCY			0x04
+#define YC_MAP_YCYC			0x05
+#define YC_MAP_CY			0x06
+#define YC_MAP_YC			0x07
+
+#define DPI_SIZE			0x18
+#define HSIZE				0
+#define HSIZE_MASK			(0x1FFF << 0)
+#define VSIZE				16
+#define VSIZE_MASK			(0x1FFF << 16)
+
+#define DPI_DDR_SETTING			0x1C
+#define DDR_EN				(0x1 << 0)
+#define DDR_4PHASE			(0x1 << 2)
+
+#define DPI_TGEN_HWIDTH			0x20
+#define HPW				0
+#define HPW_MASK			(0xFFF << 0)
+
+#define DPI_TGEN_HPORCH			0x24
+#define HBP				0
+#define HBP_MASK			(0xFFF << 0)
+#define HFP				16
+#define HFP_MASK			(0xFFF << 16)
+
+#define DPI_TGEN_VWIDTH			0x28
+#define DPI_TGEN_VPORCH			0x2C
+
+#define VSYNC_WIDTH_SHIFT		0
+#define VSYNC_WIDTH_MASK		(0xFFF << 0)
+#define VSYNC_HALF_LINE_SHIFT		16
+#define VSYNC_HALF_LINE_MASK		(0xFFF << 16)
+#define VSYNC_BACK_PORCH_SHIFT		0
+#define VSYNC_BACK_PORCH_MASK		(0xFFF << 0)
+#define VSYNC_FRONT_PORCH_SHIFT		16
+#define VSYNC_FRONT_PORCH_MASK		(0xFFF << 16)
+
+#define DPI_TGEN_VWIDTH_LEVEN		0x68
+#define DPI_TGEN_VPORCH_LEVEN		0x6C
+#define DPI_TGEN_VWIDTH_RODD		0x70
+#define DPI_TGEN_VPORCH_RODD		0x74
+#define DPI_TGEN_VWIDTH_REVEN		0x78
+#define DPI_TGEN_VPORCH_REVEN		0x7C
+
+#define DPI_Y_LIMIT			0x98
+#define Y_LIMINT_BOT			0
+#define Y_LIMINT_BOT_MASK		(0xFFF << 0)
+#define Y_LIMINT_TOP			16
+#define Y_LIMINT_TOP_MASK		(0xFFF << 16)
+
+#define DPI_C_LIMIT			0x9C
+#define C_LIMIT_BOT			0
+#define C_LIMIT_BOT_MASK		(0xFFF << 0)
+#define C_LIMIT_TOP			16
+#define C_LIMIT_TOP_MASK		(0xFFF << 16)
+
+#define DPI_MATRIX_SET			0xB4
+#define INT_MATRIX_SEL_MASK		(0x1F << 0)
+#define RGB_TO_BT709			0x03
+
+#define DPI_PATTERN0			0xF00
+#define DPI_PATTERN_EN			BIT(0)
+#define DPI_PATTERN_COLOR_BAR		(0x4 << 4)
+#endif /* __MTK_DPI_REGS_H */

-- 
2.54.0

