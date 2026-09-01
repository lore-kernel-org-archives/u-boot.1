Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9416C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AA0180D09;
	Tue,  1 Sep 2026 14:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id snnmbtuBZAv7; Tue,  1 Sep 2026 14:39:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273545;
	bh=vtJ+uzQL91WeRZPB5zvm+3QfYldiJZ8oazhnz7Ck+OY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a+h3ynLo8S91tD1w7Xo+5xoMsybs1CUMeRENoyWeybkbeii5oDGU1grhCqrB/9UaB
	 ZPDG1f07WYwlwjb0gw11zVZGhHksKT+XBN3luLxYa1LAKYQKVCTlhw14w9PxRh5Z6R
	 ZQnHCH7uyybbsUHRXJWrh35ev2lYp1py+FHCbNcL380hemPqx8TB/SYX/sR/v7Fsnk
	 /1PszSf0kDc5303YuSt7Gfw25AOuqleK2KVngvO5lhCVQU4tL/3e733qxHY4Tix6Ts
	 SkU3vwN5C8JkhcW22zMbYzrjQKL5K9m5aK93kVKxcbK2u1oI/zEHsZRulywf2U2z/I
	 v3FTo+t9ZMwMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D388280DB4;
	Tue,  1 Sep 2026 14:39:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95AA8363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90A764073D
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KCWLYKcGTtuS for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Kf8a9UrR
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 706994072C
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:55 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso10694145e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273534; x=1788878334;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vtJ+uzQL91WeRZPB5zvm+3QfYldiJZ8oazhnz7Ck+OY=;
 b=Kf8a9UrRYS5AZrk+dmxyJ9q6v6Rm/8sSePIDew1+8L6mrYClJ9TKrQTL2PhjBeAAbU
 IwPB8+DYz+zf+JQ+/zodUWm5AceO6l1e6qXjufffoMrG8tzD86n6XJ7TdUeA3rz1Ah1k
 JULjqkZo9XhfmDphJMciMS25gVk0hRcUhWZ4lPW5kKAlEycPAU+N1px7MjSh+5XRe6AQ
 lptwZx/olFYErF0Qk/hYzpt6Ve1BhwN+rkzYghSpCWleN3CSdnAUNnniyH+614MfbkpZ
 OOGUhf9h4P5XBTogDF2BSD2e8Z/nLJ6nbYYglUTvr5TcFLawSkbK4ihtX/lZTcSjsiiJ
 dUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273534; x=1788878334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vtJ+uzQL91WeRZPB5zvm+3QfYldiJZ8oazhnz7Ck+OY=;
 b=swmfBLpUfcrBd6ieZPVRBzRYbURGjaQq87xvzqrw8Lbh0GV9+BdtYU1QeBneBH/it9
 cmgJD+fUIHbL9KGSbsojsfNvKArcoKvGFdGLFQzG09EZVAz7evfrhrTsEe3l6YQFVnwT
 WMpG50gR3My5eDx01sZSvDyqH7axxGZFn7NK9lQ83rxdXoEEsmCtWvkj8PdCPJQH6suC
 P1SUTH1BSffIg+2XiQbxT3YZrPcIdac5UIDMFMfxt/7V29oZruE9MhHv9ho/AgaLQkkY
 9Itjhnv0zqkq5Tbc73o+mMK9hrlkd9nUIKmN5lCE/B9Rlet7KA0WHjbr5NQj9abDiAkb
 X8xA==
X-Gm-Message-State: AFuF++k/MxouAP5hQp6zbbYXd1rHBh74WUjCdYaQXsv2VAz//ytz2ZEN
 1SQZTyzZZsCOLGIUe0x9NSlSrb7F+H8JVEDrCexKhJFxsxol3Yj4RIaRPEkdKTHpfyM=
X-Gm-Gg: AR+sD13jiOSmxmLuyeOtLu4mnIP/9hWJecp3ROt1v7eh0IpcXkpO89XBSm08E+XqsaO
 Txn2IFeu1nEs1L/G1JnqQ0tnMj+SptvURar+d8s8Cfev1BvU4FbjxAAxSt4J3CxF+OTbkk1C2Rb
 bjwPI2LwRQVFENfFhOMJ7y+I7aTawOpjcBeoNybZUwOIY+OFD/yayq4/Ej8UR7GhyefQcYQWy+q
 DbtL7CUqokTHO0hkJvGQkPS7X6oLk65HSzOC8sqBOIoI4j0WBygHhA0jG+VCzuR/emdsrTgwICd
 cGPz7o4Hbq5s/ptznBtspFy7yHt2p0wcwuJF1gIjfaTzmnHkd/x3jOeShn4/coVgLuxrKPiEZlf
 BupGY+Ieji5xphLFF2UudZZnAnIucFGvrJdButqVta3URKvfCHbFIF3o6hzXZj75HLUbrrdvGQT
 +2rJoRAii4AdnQAuYqKbEyQSlw65SAWiAFysUccgY1fNsnveKKQmXXn4PCsW5osHM40/NS70fOb
 sJ8euzCe6jSFhhTNTM6mhm9ySekiJxc59LiOxcTyltq80GK4zy29gPwt9ahf+2CojBkdWjDdNb0
 F5xwutb5tHgi8xIjfRfnkkqC1n03pBFYbfeiOpS0Yipo
X-Received: by 2002:a05:600c:5490:b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49ccf18498emr382938015e9.12.1788273533886; 
 Tue, 01 Sep 2026 07:38:53 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:53 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:54 +0200
Subject: [PATCH v3 08/14] video: mediatek: add dpi1 component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-8-38194a531b9f@baylibre.com>
References: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
In-Reply-To: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
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
 drivers/video/mediatek/mtk_dpi.c      | 383 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_dpi.h      |  20 ++
 drivers/video/mediatek/mtk_dpi_regs.h | 247 ++++++++++++++++++++++
 3 files changed, 650 insertions(+)

diff --git a/drivers/video/mediatek/mtk_dpi.c b/drivers/video/mediatek/mtk_dpi.c
new file mode 100644
index 00000000000..49930a1f104
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dpi.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+/* INT_MATRIX_SEL value not present in the upstream register header */
+#define MATRIX_SEL_RGB_TO_BT709		3
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
+	mtk_dpi_mask(dev, DPI_RET, reset ? RST : 0, RST);
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
+	mtk_dpi_mask(dev, DPI_CON, input_2p ? DPI_INPUT_2P_EN : 0,
+		     DPI_INPUT_2P_EN);
+}
+
+static void mtk_dpi_config_output_1t1p(struct udevice *dev, bool output_1t1p)
+{
+	mtk_dpi_mask(dev, DPI_CON, output_1t1p ? DPI_OUTPUT_1T1P_EN : 0,
+		     DPI_OUTPUT_1T1P_EN);
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
+		mtk_dpi_mask(dev, DPI_MATRIX_SET, MATRIX_SEL_RGB_TO_BT709,
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
+	struct mtk_dpintf_sync_param vsync_lodd = {};
+	struct mtk_dpintf_sync_param vsync_leven = {};
+	struct mtk_dpintf_sync_param vsync_rodd = {};
+	struct mtk_dpintf_sync_param vsync_reven = {};
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
+	{ .compatible = "mediatek,mt8195-dpi" },
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
index 00000000000..2712ea05500
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dpi.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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
index 00000000000..23eeefce8fd
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dpi_regs.h
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Jie Qiu <jie.qiu@mediatek.com>
+ */
+#ifndef __MTK_DPI_REGS_H
+#define __MTK_DPI_REGS_H
+
+#define DPI_EN			0x00
+#define EN				BIT(0)
+
+#define DPI_RET			0x04
+#define RST				BIT(0)
+
+#define DPI_INTEN		0x08
+#define INT_VSYNC_EN			BIT(0)
+#define INT_VDE_EN			BIT(1)
+#define INT_UNDERFLOW_EN		BIT(2)
+
+#define DPI_INTSTA		0x0C
+#define INT_VSYNC_STA			BIT(0)
+#define INT_VDE_STA			BIT(1)
+#define INT_UNDERFLOW_STA		BIT(2)
+
+#define DPI_CON			0x10
+#define BG_ENABLE			BIT(0)
+#define IN_RB_SWAP			BIT(1)
+#define INTL_EN				BIT(2)
+#define TDFP_EN				BIT(3)
+#define CLPF_EN				BIT(4)
+#define YUV422_EN			BIT(5)
+#define CSC_ENABLE			BIT(6)
+#define R601_SEL			BIT(7)
+#define EMBSYNC_EN			BIT(8)
+#define VS_LODD_EN			BIT(16)
+#define VS_LEVEN_EN			BIT(17)
+#define VS_RODD_EN			BIT(18)
+#define VS_REVEN			BIT(19)
+#define FAKE_DE_LODD			BIT(20)
+#define FAKE_DE_LEVEN			BIT(21)
+#define FAKE_DE_RODD			BIT(22)
+#define FAKE_DE_REVEN			BIT(23)
+
+/* DPI_CON: DPI instances */
+#define DPI_OUTPUT_1T1P_EN		BIT(24)
+#define DPI_INPUT_2P_EN			BIT(25)
+/* DPI_CON: DPINTF instances */
+#define DPINTF_YUV422_EN		BIT(24)
+#define DPINTF_CSC_ENABLE		BIT(26)
+#define DPINTF_INPUT_2P_EN		BIT(29)
+
+#define DPI_OUTPUT_SETTING	0x14
+#define CH_SWAP				0
+#define DPINTF_CH_SWAP			1
+#define CH_SWAP_MASK			(0x7 << 0)
+#define SWAP_RGB			0x00
+#define SWAP_GBR			0x01
+#define SWAP_BRG			0x02
+#define SWAP_RBG			0x03
+#define SWAP_GRB			0x04
+#define SWAP_BGR			0x05
+#define BIT_SWAP			BIT(3)
+#define B_MASK				BIT(4)
+#define G_MASK				BIT(5)
+#define R_MASK				BIT(6)
+#define DE_MASK				BIT(8)
+#define HS_MASK				BIT(9)
+#define VS_MASK				BIT(10)
+#define DE_POL				BIT(12)
+#define HSYNC_POL			BIT(13)
+#define VSYNC_POL			BIT(14)
+#define CK_POL				BIT(15)
+#define OEN_OFF				BIT(16)
+#define EDGE_SEL			BIT(17)
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
+#define DPI_SIZE		0x18
+#define HSIZE				0
+#define HSIZE_MASK			(0x1FFF << 0)
+#define DPINTF_HSIZE_MASK		(0xFFFF << 0)
+#define VSIZE				16
+#define VSIZE_MASK			(0x1FFF << 16)
+#define DPINTF_VSIZE_MASK		(0xFFFF << 16)
+
+#define DPI_DDR_SETTING		0x1C
+#define DDR_EN				BIT(0)
+#define DDDR_SEL			BIT(1)
+#define DDR_4PHASE			BIT(2)
+#define DDR_WIDTH			(0x3 << 4)
+#define DDR_PAD_MODE			(0x1 << 8)
+
+#define DPI_TGEN_HWIDTH		0x20
+#define HPW				0
+#define HPW_MASK			(0xFFF << 0)
+#define DPINTF_HPW_MASK			(0xFFFF << 0)
+
+#define DPI_TGEN_HPORCH		0x24
+#define HBP				0
+#define HBP_MASK			(0xFFF << 0)
+#define DPINTF_HBP_MASK			(0xFFFF << 0)
+#define HFP				16
+#define HFP_MASK			(0xFFF << 16)
+#define DPINTF_HFP_MASK			(0xFFFF << 16)
+
+#define DPI_TGEN_VWIDTH		0x28
+#define DPI_TGEN_VPORCH		0x2C
+
+#define VSYNC_WIDTH_SHIFT		0
+#define VSYNC_WIDTH_MASK		(0xFFF << 0)
+#define DPINTF_VSYNC_WIDTH_MASK		(0xFFFF << 0)
+#define VSYNC_HALF_LINE_SHIFT		16
+#define VSYNC_HALF_LINE_MASK		BIT(16)
+#define VSYNC_BACK_PORCH_SHIFT		0
+#define VSYNC_BACK_PORCH_MASK		(0xFFF << 0)
+#define DPINTF_VSYNC_BACK_PORCH_MASK	(0xFFFF << 0)
+#define VSYNC_FRONT_PORCH_SHIFT		16
+#define VSYNC_FRONT_PORCH_MASK		(0xFFF << 16)
+#define DPINTF_VSYNC_FRONT_PORCH_MASK	(0xFFFF << 16)
+
+#define DPI_BG_HCNTL		0x30
+#define BG_RIGHT			(0x1FFF << 0)
+#define BG_LEFT				(0x1FFF << 16)
+
+#define DPI_BG_VCNTL		0x34
+#define BG_BOT				(0x1FFF << 0)
+#define BG_TOP				(0x1FFF << 16)
+
+#define DPI_BG_COLOR		0x38
+#define BG_B				(0xF << 0)
+#define BG_G				(0xF << 8)
+#define BG_R				(0xF << 16)
+
+#define DPI_FIFO_CTL		0x3C
+#define FIFO_VALID_SET			(0x1F << 0)
+#define FIFO_RST_SEL			(0x1 << 8)
+
+#define DPI_STATUS		0x40
+#define VCOUNTER			(0x1FFF << 0)
+#define DPI_BUSY			BIT(16)
+#define OUTEN				BIT(17)
+#define FIELD				BIT(20)
+#define TDLR				BIT(21)
+
+#define DPI_TMODE		0x44
+#define DPI_OEN_ON			BIT(0)
+
+#define DPI_CHECKSUM		0x48
+#define DPI_CHECKSUM_MASK		(0xFFFFFF << 0)
+#define DPI_CHECKSUM_READY		BIT(30)
+#define DPI_CHECKSUM_EN			BIT(31)
+
+#define DPI_DUMMY		0x50
+#define DPI_DUMMY_MASK			(0xFFFFFFFF << 0)
+
+#define DPI_TGEN_VWIDTH_LEVEN	0x68
+#define DPI_TGEN_VPORCH_LEVEN	0x6C
+#define DPI_TGEN_VWIDTH_RODD	0x70
+#define DPI_TGEN_VPORCH_RODD	0x74
+#define DPI_TGEN_VWIDTH_REVEN	0x78
+#define DPI_TGEN_VPORCH_REVEN	0x7C
+
+#define DPI_ESAV_VTIMING_LODD	0x80
+#define ESAV_VOFST_LODD			(0xFFF << 0)
+#define ESAV_VWID_LODD			(0xFFF << 16)
+
+#define DPI_ESAV_VTIMING_LEVEN	0x84
+#define ESAV_VOFST_LEVEN		(0xFFF << 0)
+#define ESAV_VWID_LEVEN			(0xFFF << 16)
+
+#define DPI_ESAV_VTIMING_RODD	0x88
+#define ESAV_VOFST_RODD			(0xFFF << 0)
+#define ESAV_VWID_RODD			(0xFFF << 16)
+
+#define DPI_ESAV_VTIMING_REVEN	0x8C
+#define ESAV_VOFST_REVEN		(0xFFF << 0)
+#define ESAV_VWID_REVEN			(0xFFF << 16)
+
+#define DPI_ESAV_FTIMING	0x90
+#define ESAV_FOFST_ODD			(0xFFF << 0)
+#define ESAV_FOFST_EVEN			(0xFFF << 16)
+
+#define DPI_CLPF_SETTING	0x94
+#define CLPF_TYPE			(0x3 << 0)
+#define ROUND_EN			BIT(4)
+
+#define DPI_Y_LIMIT		0x98
+#define Y_LIMINT_BOT			0
+#define Y_LIMINT_BOT_MASK		(0xFFF << 0)
+#define Y_LIMINT_TOP			16
+#define Y_LIMINT_TOP_MASK		(0xFFF << 16)
+
+#define DPI_C_LIMIT		0x9C
+#define C_LIMIT_BOT			0
+#define C_LIMIT_BOT_MASK		(0xFFF << 0)
+#define C_LIMIT_TOP			16
+#define C_LIMIT_TOP_MASK		(0xFFF << 16)
+
+#define DPI_YUV422_SETTING	0xA0
+#define UV_SWAP				BIT(0)
+#define CR_DELSEL			BIT(4)
+#define CB_DELSEL			BIT(5)
+#define Y_DELSEL			BIT(6)
+#define DE_DELSEL			BIT(7)
+
+#define DPI_EMBSYNC_SETTING	0xA4
+#define EMBSYNC_R_CR_EN			BIT(0)
+#define EMPSYNC_G_Y_EN			BIT(1)
+#define EMPSYNC_B_CB_EN			BIT(2)
+#define ESAV_F_INV			BIT(4)
+#define ESAV_V_INV			BIT(5)
+#define ESAV_H_INV			BIT(6)
+#define ESAV_CODE_MAN			BIT(8)
+#define VS_OUT_SEL			(0x7 << 12)
+
+#define DPI_ESAV_CODE_SET0	0xA8
+#define ESAV_CODE0			(0xFFF << 0)
+#define ESAV_CODE1			(0xFFF << 16)
+
+#define DPI_ESAV_CODE_SET1	0xAC
+#define ESAV_CODE2			(0xFFF << 0)
+#define ESAV_CODE3_MSB			BIT(16)
+
+#define EDGE_SEL_EN			BIT(5)
+#define H_FRE_2N			BIT(25)
+
+#define DPI_MATRIX_SET		0xB4
+#define INT_MATRIX_SEL_MASK		GENMASK(4, 0)
+#define MATRIX_SEL_RGB_TO_JPEG		0
+#define MATRIX_SEL_RGB_TO_BT601		2
+
+#define DPI_PATTERN0		0xf00
+#define DPI_PAT_EN			BIT(0)
+#define DPI_PAT_SEL			GENMASK(6, 4)
+
+#endif /* __MTK_DPI_REGS_H */

-- 
2.55.0

