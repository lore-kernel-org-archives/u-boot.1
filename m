Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D20C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10ECC813C3;
	Tue, 28 Jul 2026 12:29:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZHw1dlGajta; Tue, 28 Jul 2026 12:29:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A66A812F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241786;
	bh=WSYIPefG79+52UqPbvnOl4gVEp5Yjpgq8tTZbhlffSM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hnReyvBdhz48ZVcfPuU93c1RHUguFaBWjYEfllNFSS1BhCGdkxA3qetb16XQsYK9e
	 n7SKy2Nrz4Xxc+xqsPswdcLc1tfbx32B5ZljgTkTV9BO76xd/TolGXy/CAf5A1DK5P
	 f33WROVi3CGT8EI55W4hdoNQxFZm1seb1RL3anA/b9F0ktozDnD0StPt7NJ+f7xuLs
	 gLlegNcLciaCuL0009WZ/BTVEIytdwy1yNqOgto0rr+BWq+o3pv05JyoS7YgYPS3gV
	 z/AWHDB+Cf4RZ1BT+AGqMBUn84fpUUT9CmVJiuL/w9cXGoqcr/fx1XOcToeoH7BtWW
	 RHmT4+khv6oig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A66A812F8;
	Tue, 28 Jul 2026 12:29:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22AA84BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08DD860878
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ch8-AdsFfpTq for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B3687607ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3687607ED
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3687607ED
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:37 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so26529305e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241776; x=1785846576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WSYIPefG79+52UqPbvnOl4gVEp5Yjpgq8tTZbhlffSM=;
 b=nuMkuiu1weqRLLx4PQEZ46t8FFd0fQFPE3Kb5VInyYcnMbt5eU9HHdpcAIoIuZXGjr
 gBAMELzyFFlJsYqs7NZTxSdaQwBcetXATNEYVd/u6YMqdkjLZNBZBjO6XGs8JE/vY1de
 KXzDvzqOD8xomdyv03hpTMBH31W0xGOopwRi40iCC7KJS5CwdpTavtMNZaHiRnhF8PF5
 +6T9g9DS/WAUkuNCsLSifNBkZMrCB+qMovAme/JFaxEd0ILhYeO++GaqvUSgwiq2IuPp
 wdL5G8U82ZWeepiTF39WRSEROknqkORoX6AWE2oprEpAdyyo139PNR0y82R4AErg8EIB
 5pEw==
X-Gm-Message-State: AOJu0YwBpyANQNc+t9AD7AGl7P9MK3jmVfrupXZebSehyGjBWzHd+L7B
 blZ3OPSuo457NvvLJZArI0Vw+nm/eT0nYlwgc3lMvuCLDD+jvyTYx9tUEerCqlzDWuQ=
X-Gm-Gg: AR+sD10W6iMjkDYcvAd9gI8+7f6ff2q7pgVl46zjW9VGT0MFkCPqK6UOscwvox0eRFg
 QDLaLuNsLYacuMvuefVWoDYW4PHu5v2sZGz3kVLW14la1HuMUWXlDlUecdcq4FbZpkHRXy5N3Lm
 xFnh3S1io/zPv1dVWVcnV2CTVyKxNhyogwqbVMx7YqwSl28SH/Kffnlw2yVC7Fh+q7285R0XdVK
 lEXnf1Mtw54jIJu4xCaIVlRFmChl/fkJ/pmR9l6un9u7gepgYpVw10sxtEsqBP5jG5GVJYvzoAR
 M1m126AliBqC00GYR63xieOjCyoZbtI67NJ9Oa7hIgTtQCm6KKFpbXDnbAC1ku9MFFyX7OEnsMk
 zuYMS68Q3ev1K8zZGbfv1jruKnA0IXo2sZ7mifie0M2ziEU8uD1/ZFoK1DvyUK6lDr4dKsRdKKB
 AHhUc+8fjjwJv6zfxZVDaGh5Mh3pzLl8EG3SI7f03fEZUd7g9bNwr2FH+CaFzISTEYDxkNIE+te
 DtNNCd0AOxlTg5w/+Ay/3efMasp2G92lujfA4LDJXHDWLM6U2p3/pHFTDmIBwk5CEx1ZwWUjA==
X-Received: by 2002:a05:600c:3144:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-496c642d855mr21394755e9.1.1785241775563; 
 Tue, 28 Jul 2026 05:29:35 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:38 +0200
Subject: [PATCH 06/13] video: mediatek: add rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-6-ac54bd75f960@baylibre.com>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
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
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785241776; x=1785846576;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WSYIPefG79+52UqPbvnOl4gVEp5Yjpgq8tTZbhlffSM=;
 b=O46lydURIiBj76+Epuif+cQwJTTXKbB2kt+5SE3G1OZ/evD1LUJRsJaYtuPVgW/TcC
 BJEKU9pAJkGOY9gnXy2ntIApRpH35LveUrrMZwDukjdLzqg/G0/OmJKE19RRkIbG3tN8
 RjuCP4lMG+IUuzzveiMZ1LSqxAnDcGo2RUUhWorCuzGTc2mrXwgs4C+kzUj/8yJDxLcj
 w8WmvFmkBinOPuX4FTLouatHD1hBu+WPKyWcugGiPVt+mM+IttftvVOZIvEOYkQfKcR4
 t9pyv/0CQbH2lRWF5tuq9C4jPw6niUBVfrgibBCq8YI2Fl+oMGvFLOno9EKdg7CgZ8iN
 tyxQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=O46lydUR
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The MDP RDMA is the DMA engine reading the framebuffer on some
MediaTek SoCs, such as the MT8188. Two instances are used, each
reading one half of the frame; the second one starts at the middle of
the line (apply_offset).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_mdp_rdma_mt8188.c | 97 ++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_mdp_rdma_mt8188.h | 20 ++++++
 2 files changed, 117 insertions(+)

diff --git a/drivers/video/mediatek/mtk_mdp_rdma_mt8188.c b/drivers/video/mediatek/mtk_mdp_rdma_mt8188.c
new file mode 100644
index 00000000000..cf85df94d10
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma_mt8188.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek Video MDP RDMA Support
+ *
+ * Copyright (c) 2022 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <dm.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_mdp_rdma_mt8188.h"
+
+/* MDP RDMA registers */
+#define MDP_RDMA_EN				0x0000
+#define MDP_RDMA_EN_ENABLE			BIT(0)
+#define MDP_RDMA_EN_DISABLE			0
+#define MDP_RDMA_EN_INTERNAL_DCM_EN		GENMASK(23, 4)
+
+#define MDP_RDMA_SRC_CON			0x0030
+#define MDP_RDMA_SRC_FORMAT_BGRA8888		2
+#define MDP_RDMA_SRC_CON_SRC_FORMAT(x)		((x) & GENMASK(3, 0))
+#define MDP_RDMA_ENABLE_UNIFORM_CONFIG		BIT(17)
+#define MDP_RDMA_ENABLE_ARGB_OUTPUT		BIT(25)
+
+#define MDP_RDMA_SRC_BASE_0			0x0f00
+#define MDP_RDMA_MF_BKGD_SIZE_IN_BYTE		0x0060
+#define MDP_RDMA_MF_SRC_SIZE			0x0070
+#define MDP_RDMA_MF_CLIP_SIZE			0x0078
+#define MDP_RDMA_SRC_OFFSET_0			0x0118
+
+#define MDP_RDMA_CON				0x0020
+#define MDP_RDMA_CON_SIMPLE_MODE		BIT(4)
+
+#define MDP_RDMA_TRANSFORM_0			0x0200
+#define MDP_RDMA_TRANSFORM_BITEXTEND_ZERO	BIT(15)
+
+#define FB_BYTES_PER_PIXEL			4
+
+void mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			 const struct display_timing *timing,
+			 bool apply_offset)
+{
+	u32 width = timing->hactive.typ;
+	u32 height = timing->vactive.typ;
+	u32 fb = plat->base;
+	int offset = apply_offset ? ((width / 2) * FB_BYTES_PER_PIXEL) : 0;
+
+	mtk_disp_comp_write(dev, MDP_RDMA_EN, MDP_RDMA_EN_INTERNAL_DCM_EN);
+
+	/* set source format and output bit depth */
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_CON,
+			    MDP_RDMA_SRC_CON_SRC_FORMAT(MDP_RDMA_SRC_FORMAT_BGRA8888) |
+			    MDP_RDMA_ENABLE_ARGB_OUTPUT |
+			    MDP_RDMA_ENABLE_UNIFORM_CONFIG);
+
+	/* set base address */
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_BASE_0, fb);
+
+	/* stride: aligned width * bytes-per-pixel */
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE,
+			    ALIGN(width, 4) * FB_BYTES_PER_PIXEL);
+
+	/*
+	 * each of the two RDMAs reads one half of the frame: size and
+	 * clip cover half the width, and the second RDMA (apply_offset)
+	 * starts at the middle of the line
+	 */
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_SRC_SIZE,
+			    (height << 16) | (width / 2));
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_CLIP_SIZE,
+			    (height << 16) | (width / 2));
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_OFFSET_0, offset);
+
+	/* simple mode + zero bit extension for 8bit -> 10bit */
+	mtk_disp_comp_write(dev, MDP_RDMA_CON, MDP_RDMA_CON_SIMPLE_MODE);
+	mtk_disp_comp_write(dev, MDP_RDMA_TRANSFORM_0,
+			    MDP_RDMA_TRANSFORM_BITEXTEND_ZERO);
+
+	/* enable engine */
+	mtk_disp_comp_write(dev, MDP_RDMA_EN,
+			    MDP_RDMA_EN_INTERNAL_DCM_EN | MDP_RDMA_EN_ENABLE);
+}
+
+static const struct udevice_id mtk_mdp_rdma_ids[] = {
+	{ .compatible = "mediatek,mt8188-vdo1-rdma" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_mdp_rdma) = {
+	.name	   = "mtk_mdp_rdma",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_mdp_rdma_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_mdp_rdma_mt8188.h b/drivers/video/mediatek/mtk_mdp_rdma_mt8188.h
new file mode 100644
index 00000000000..6646b353e3f
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma_mt8188.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mediatek Video MDP RDMA Support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_MDP_RDMA_MT8188_H
+#define _MTK_MDP_RDMA_MT8188_H
+
+struct udevice;
+struct video_uc_plat;
+struct display_timing;
+
+void mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			 const struct display_timing *timing,
+			 bool apply_offset);
+
+#endif

-- 
2.54.0

