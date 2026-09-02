Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FEC624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A78080F76;
	Wed,  2 Sep 2026 14:16:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oT7bEhY95QBP; Wed,  2 Sep 2026 14:16:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358596;
	bh=TYbH7Yvqx4Xzn3A6hWlADgx9tQ+OxPuD7z6Kbn9niMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fRl1vc71lH1KXVfML5hnXbBNDhrQMeIV+Z2AFNz5EW0xL6b31MyV0GNVUp0h+9Xi6
	 g5Ew9PUG84jk+PrYxHxzVlBk0P1n7G0otmWEcTpXjTYN7BWAW4cuMDBFI1WxGbPKhu
	 B+5f/tqg8FZOD8t3QVZxjktkIaVHMhNBrQrqRjuvXKT5KEPX4OZsxfSEDLKIhVEmuY
	 zw30mBzN7hcaIus2cbzIIJ3mh8SW1kb3xgqz1Ne7fXj9atUtRg8xZEksfe2nMJP339
	 6Zsnd/SDlNu53uJza848yMjCF5TFrenJXg5sklbRn5PUDd4M4bfFWJgiWuLUK8Cl9k
	 AnjatLjM33Paw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD53180F7C;
	Wed,  2 Sep 2026 14:16:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A68121D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9857D606C4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbMPYuazL7B0 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=e4wvVsxx
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7FDB3606B4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:28 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so7401775e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358586; x=1788963386;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TYbH7Yvqx4Xzn3A6hWlADgx9tQ+OxPuD7z6Kbn9niMY=;
 b=e4wvVsxxsIpW8CEd9IQ2Bsnnn5kexiajI/5CNhJxzzrxneRkpl6En21fsQdQvhp8H2
 MC2HJ+CrPaxQ/nyxNX4qaOI95uMqD3vdRdI07/T1AEShL+ZBZc4mR8DYrC79kRDwsNOa
 lnsICOqn5gjdjAhzeMezVEepA09bO0R0QGAwwZHpV+N79bEJZ1J8Hw+0anMknQy324O3
 Y0SwPjaxIqffZcm0HK0Cb3RzJCS0YviARCZ3O5NkKLu0AUAXUZrOP9nrI9JqgwBltwy4
 qK+0m4SKrbQ9irPRlNWHR/fCMv/QGR0NjmBtTwQDrZ2qV3Mg9sAT6HMzW4vOim2EWV/A
 djow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358586; x=1788963386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TYbH7Yvqx4Xzn3A6hWlADgx9tQ+OxPuD7z6Kbn9niMY=;
 b=I2lAVPEt2orF+ugFqnpdkdC/cOBIUNIUMd4TNEUHEUhEMdX+RJtaNSbtPtNS57VGsn
 zc4jRbEwQGEmVOoJWm7x8QtFAN422aoCXxUKklB05By9kWqCdsPMjd+PHdxJkOAGrLrT
 loSDcPV7IZqapUN3m5K8s0ohMSdyIws/DBDcnFRDuHc/haD2jckWOWHvWsppuO3MqSVW
 O4rWfP3GYyXf4pSIXib1BLH/L/m9dvXLVGXd2ABvFKqZs2ichhiIIwfT3p58ZJ0DzyCJ
 M0PezmQUfZoXxJAKZx0rn7SiCoWRgVcV0rKZHnqyFhD3CcRkeGdKplQN8JIb+F4A4Mph
 xUbw==
X-Gm-Message-State: AFuF++l68kknCWhEhyoAqOWpsFM7NUQjLVGTVoXnA6CotP+aO+Jtrltm
 NCw/futxbKHlpoV3hIbCv+huvGrpV8pAi41IbgRkmJohRBj4A9DXCIJqr3giBrwLwVs=
X-Gm-Gg: AR+sD12qThPeV8tSB6XmpUc40UUcj/CsEi37Lgxm4NqbGfIsx7vuab3ghqi8fsVV7Yt
 90l0GuST6ljR0o9cMnS3bXG9OvtP3F/weclbnRzjvmGICu/jQzuqvssDpNEFqr8xZavHxhoKDmR
 L3e6H+qtuMiWRfjcUbbefnnZi0zHPxJs6LDRV0Q3a0bg/5JWA2uZ89ZrrwU8PWgWO31vYyaJjAD
 AB7F7XlXCI0nkHvGnW6vS0Fw1ixu9LqadvTUkeNQwyliTnSIEuEBQokQfd3v67xNOGIgehDIbQ3
 Upyx/pZCKEN43flk8rXwKGOUBlEcIRb3clXgAi/vbwiJmQpOqLl7iMgLIvEasmfbLlPODHSxJmV
 CQfNj/UB7fh6pHKtBJfobUik5OvYT7KGflceNxp+BP0WXE+oyUU46khMOFAK/j1L8Hbg6fmcsfJ
 //Cc9Bo2E9DTrDN3bopqcNVNXir1H7l2x7Eh9dOniNiYNLt0B419BQPrnXltTCJYV+xzTZTImt0
 yZRwdt59kuOYol2QSlmrcZhqb3VdZNX7pG/X+kH3raxY2Nkv8r7L3+y2H7Rsb4xZmfFWmZ35/Jy
 BxiFUD2QRw4Te8sGO25H5AG76B812TYM6OXIZ3lAQ95Y
X-Received: by 2002:a05:600c:4f0b:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49ce581316dmr74910075e9.6.1788358586459; 
 Wed, 02 Sep 2026 07:16:26 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:15:56 +0200
Subject: [PATCH v4 06/14] video: mediatek: add rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-6-7c3b4f068a56@baylibre.com>
References: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
In-Reply-To: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
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

