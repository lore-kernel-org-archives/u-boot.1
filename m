Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5A3C624D7
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F6CA40741;
	Tue,  1 Sep 2026 14:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJX5JOZOscyq; Tue,  1 Sep 2026 14:38:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273539;
	bh=TYbH7Yvqx4Xzn3A6hWlADgx9tQ+OxPuD7z6Kbn9niMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wt8L49KNtvrKeoiTKWKjYdz2uyTKwwPq27wtHuNHYnsFkLn75xHUobmTiuYO0gv57
	 xuz2pXV89B74A/Hbd0M/XeHSu0EnnbrTZRI/xmK9gWLjEUMbpox06gAM04shG/tV9O
	 g4UhUDYgxXqvxhdmpZ1M1OuQpVPHxEtCU2TwRWyXEXI6afOfLXvp4/GM1xSHUGV9yj
	 mSAxa0A7F4YjIAKzn4wWIapgNMzBULMjg111WHno/M5Qpmoldxw3m2Z5Y9dPP3R1lZ
	 vAr5lYm8nuNu5F866GyuJd6WXuDHmy18icwYxrdbRQUUJRGok/H2rxpXZqalNN7Kfd
	 lcgO+2qOnVAPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F23E74070F;
	Tue,  1 Sep 2026 14:38:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 63D89265
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A1DF401CE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZriapGu3XMsc for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TXgvJ7UJ
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 340D4401CA
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so10986465e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273532; x=1788878332;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TYbH7Yvqx4Xzn3A6hWlADgx9tQ+OxPuD7z6Kbn9niMY=;
 b=TXgvJ7UJVyJ58++IOHJmxUk4fOKpdYebM7vKG216wFHwtCp2qqo2vcJOkn5tOe56H4
 BZw0uO2tpfmUzxV3WilIkeBbCT0rQ55JsixNkH67C6JA+g0f7oKTsjqLw9wr+Npoc+Cm
 cXbuVqVWR4UTVlFFU5WE21GggqRbQp2p4I1qGLXHQu24MLunDAZEY2ZsgwJV5GIJO6nJ
 3MPqEwXJF7+gceFn/HFLnmcmVGcSWaXi3rotXXhT6tgGQcXqlXi2RQhddXUD4VerGyv4
 Ip+cdOxAN/TsgOuzzhvrAWA+i9QCpO3k1CvdX9uIGEBnPo7xnP7TOqz0nSy1rCUb8psG
 WC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273532; x=1788878332;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TYbH7Yvqx4Xzn3A6hWlADgx9tQ+OxPuD7z6Kbn9niMY=;
 b=X0z618vLT5KWPCItep6dFywZ7X/AYWXKdJwCBMCv83YSUwAEFW6siQQwkbuSaBYsqG
 BTOlW1kfhSW+mgK0dxMN2siIpOZWmZiOnqhelxRNbINwokEuTFlq/fYmj+1wB6Aw6AbO
 doNsv27gk1viZRpiBnBimVGNkzz7KWsr/YWc/LuJ37og6uKcRGorQ4bVid4yqvQ/Lh5+
 HlKE1yIOIpnLfxnLfNpAFHAFduTz/TI2ZwFluZcmpBOwcGMUs7FQVzqPM1mgqr19t3Rm
 8tjGiJ+sBObujc8ynuvBMxKnBVJORpahz/oYIs03E+ENobkh+cP21bbTwBWZ802XRJ2z
 uPWA==
X-Gm-Message-State: AFuF++kKN8SL1cohNaF9c4rSMRx0g7GphbdbYH9/507+lerVWb8gtxoa
 phl0CHW1Ic5vLYUeSJ8cBhZmbDf89VTd822V84lFvqm3kKHfPG2DClcAem4tLOVxLlM=
X-Gm-Gg: AR+sD13DjBK+pbtyMEP+Py5G9WDaQe8kLzyuTi7OHetLpnA+YWvIDbfuam8Zqh5iRJ8
 dhGttD9cr/DK4cHeZyzdqCy6guVHVVJUlN1VKVJ7sROJKsYNKSNcrscvqpmu+Dg8r3NLA2pM0Zu
 dUhhDFowKdg3+ma3lcg+Ek9haAQsccVH606D7KJ5ZTWeQsBlBar3/lFG9ERJ8gN1B4WQ13H6cBI
 8WAvlYIECjlndQWo2imt589eesdXXK7Rqf30CPx3ChUUsSn4teta98X+kOjloKnjJQ9KB3p31FF
 vBkKiw/yzR5zNrLPpRWT7VVBsE4fzOiK9suQHa9D/FB/MAJ6TK7mljSevRadsnjirOY9ShC3qsc
 UhgwnQ/qq2RsMoknuXi99J0Bi0eWzZhK3tOerG51Oy9UD9TS/6Ci6/reVgNXVnnjHqVN+Xa/mv5
 kz166xGJJ4fZsgBwfbpSHI+bUXThryHk6EYDidkFnltK9Mm1mk1Wn5iqKPfKvc9Ug/Gmj5nMN2S
 LNATK2y3SotAuWa9wTX+pINY6xVc5AG7D64DZGL8jioLh1Qojaq8MY8Bxz7M2wiON0BONYNJmUU
 atAGYuGSKNPtzo3u2/beSEfEaqwZ8JPZDhwv5jp9p1Vg
X-Received: by 2002:a05:600c:3511:b0:499:adb4:a922 with SMTP id
 5b1f17b1804b1-49b91c4bab5mr397949555e9.12.1788273531848; 
 Tue, 01 Sep 2026 07:38:51 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:51 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:52 +0200
Subject: [PATCH v3 06/14] video: mediatek: add rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-6-38194a531b9f@baylibre.com>
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

The MDP RDMA is the DMA engine reading the framebuffer on some
MediaTek SoCs, such as the MT8188. Two instances are used, each
reading one half of the frame; the second one starts at the middle of
the line (apply_offset).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_mdp_rdma.c | 159 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_mdp_rdma.h |  20 +++++
 2 files changed, 179 insertions(+)

diff --git a/drivers/video/mediatek/mtk_mdp_rdma.c b/drivers/video/mediatek/mtk_mdp_rdma.c
new file mode 100644
index 00000000000..f954f197985
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video MDP RDMA Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <dt-bindings/memory/mtk-memory-port.h>
+#include <linux/bitfield.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_mdp_rdma.h"
+
+/* MDP RDMA registers (see Linux drivers/gpu/drm/mediatek/mtk_mdp_rdma.c) */
+#define MDP_RDMA_EN			0x000
+#define FLD_ROT_ENABLE				BIT(0)
+#define MDP_RDMA_CON			0x020
+#define FLD_SIMPLE_MODE				BIT(4)
+#define MDP_RDMA_SRC_CON		0x030
+#define FLD_OUTPUT_ARGB				BIT(25)
+#define FLD_UNIFORM_CONFIG			BIT(17)
+#define FLD_SRC_FORMAT				GENMASK(3, 0)
+#define MDP_RDMA_MF_BKGD_SIZE_IN_BYTE	0x060
+#define MDP_RDMA_MF_SRC_SIZE		0x070
+#define FLD_MF_SRC_H				GENMASK(30, 16)
+#define FLD_MF_SRC_W				GENMASK(14, 0)
+#define MDP_RDMA_MF_CLIP_SIZE		0x078
+#define FLD_MF_CLIP_H				GENMASK(30, 16)
+#define FLD_MF_CLIP_W				GENMASK(14, 0)
+#define MDP_RDMA_SRC_OFFSET_0		0x118
+#define MDP_RDMA_TRANSFORM_0		0x200
+#define MDP_RDMA_SRC_BASE_0		0xf00
+
+/* Fields/values used by this driver but not present in the upstream driver */
+#define FLD_INTERNAL_DCM_EN			GENMASK(23, 4)
+#define MDP_RDMA_SRC_FORMAT_BGRA8888		2
+#define FLD_BITEXTEND_ZERO			BIT(15)
+#define FB_BYTES_PER_PIXEL			4
+
+int mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			const struct display_timing *timing,
+			unsigned int pitch, bool apply_offset)
+{
+	u32 width = timing->hactive.typ;
+	u32 height = timing->vactive.typ;
+	int offset = apply_offset ? ((width / 2) * FB_BYTES_PER_PIXEL) : 0;
+	u32 fb;
+
+	/* the RDMA source address register is 32-bit only */
+	if (plat->base != (u32)plat->base) {
+		dev_err(dev, "framebuffer base %pa is above 4GB\n", &plat->base);
+		return -EINVAL;
+	}
+	fb = plat->base;
+
+	mtk_disp_comp_write(dev, MDP_RDMA_EN, FLD_INTERNAL_DCM_EN);
+
+	/* set source format and output bit depth */
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_CON,
+			    FIELD_PREP(FLD_SRC_FORMAT, MDP_RDMA_SRC_FORMAT_BGRA8888) |
+			    FLD_OUTPUT_ARGB |
+			    FLD_UNIFORM_CONFIG);
+
+	/* set base address */
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_BASE_0, fb);
+
+	/* stride comes from the framebuffer line length */
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE, pitch);
+
+	/*
+	 * each of the two RDMAs reads one half of the frame: size and
+	 * clip cover half the width, and the second RDMA (apply_offset)
+	 * starts at the middle of the line
+	 */
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_SRC_SIZE,
+			    FIELD_PREP(FLD_MF_SRC_H, height) |
+			    FIELD_PREP(FLD_MF_SRC_W, width / 2));
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_CLIP_SIZE,
+			    FIELD_PREP(FLD_MF_CLIP_H, height) |
+			    FIELD_PREP(FLD_MF_CLIP_W, width / 2));
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_OFFSET_0, offset);
+
+	/* simple mode + zero bit extension for 8bit -> 10bit */
+	mtk_disp_comp_write(dev, MDP_RDMA_CON, FLD_SIMPLE_MODE);
+	mtk_disp_comp_write(dev, MDP_RDMA_TRANSFORM_0, FLD_BITEXTEND_ZERO);
+
+	/* enable engine */
+	mtk_disp_comp_write(dev, MDP_RDMA_EN,
+			    FLD_INTERNAL_DCM_EN | FLD_ROT_ENABLE);
+
+	return 0;
+}
+
+/*
+ * The RDMA is the DMA master, so the SMI larb feeding it must be ungated for
+ * its DRAM access. The RDMA points at its IOMMU (M4U) port through "iommus";
+ * MTK_M4U_TO_LARB() extracts the larb id from that port. Resolve the matching
+ * larb in the IOMMU's "mediatek,larbs" list by its "mediatek,larb-id"; the
+ * component helper then enables and disables it together with the RDMA.
+ */
+static int mtk_mdp_rdma_get_larb(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	ofnode iommu, node;
+	u32 larb_id, id;
+	int i, ret;
+
+	ret = dev_read_phandle_with_args(dev, "iommus", "#iommu-cells", 0, 0,
+					 &args);
+	if (ret) {
+		dev_err(dev, "cannot parse iommus: %d\n", ret);
+		return ret;
+	}
+	iommu = args.node;
+	larb_id = MTK_M4U_TO_LARB(args.args[0]);
+
+	for (i = 0; ; i++) {
+		node = ofnode_parse_phandle(iommu, "mediatek,larbs", i);
+		if (!ofnode_valid(node)) {
+			dev_err(dev, "no larb %u in iommu\n", larb_id);
+			return -ENODEV;
+		}
+		if (!ofnode_read_u32(node, "mediatek,larb-id", &id) &&
+		    id == larb_id)
+			break;
+	}
+
+	return uclass_get_device_by_ofnode(UCLASS_MISC, node, &priv->larb);
+}
+
+static int mtk_mdp_rdma_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	return mtk_mdp_rdma_get_larb(dev);
+}
+
+static const struct udevice_id mtk_mdp_rdma_ids[] = {
+	{ .compatible = "mediatek,mt8195-vdo1-rdma" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_mdp_rdma) = {
+	.name	   = "mtk_mdp_rdma",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_mdp_rdma_ids,
+	.probe	   = mtk_mdp_rdma_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_mdp_rdma.h b/drivers/video/mediatek/mtk_mdp_rdma.h
new file mode 100644
index 00000000000..86297e42341
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video MDP RDMA Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_MDP_RDMA_H
+#define _MTK_MDP_RDMA_H
+
+struct udevice;
+struct video_uc_plat;
+struct display_timing;
+
+int mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			const struct display_timing *timing,
+			unsigned int pitch, bool apply_offset);
+
+#endif

-- 
2.55.0

