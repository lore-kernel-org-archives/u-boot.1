Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA320C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 804256077B;
	Wed, 26 Aug 2026 13:09:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mn3dWjps_Kdc; Wed, 26 Aug 2026 13:09:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749786;
	bh=QLd2L10nLxD3BG0pqVIQ+UCSVDxZCNVUU4OxRBldXqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MtmpyZoJ9B7T/jqrma8W6ouCQ2aZXCnd2OP8gLYbHFYf2C6tKwL26TtEhKFd69+sY
	 tjY38jk847/2GTkEHBGkDryq4lm4mXyQBMS3nZedywLnJkPkCi3f0dwphSmgp4sp9B
	 w2l0h4ns//E4egNYFFJs+hcdMIJ7hWtFrLac2eWvIVOFR74kiLBTy3MSWx6l397Dub
	 w2HZfbWFoeya6QvOtmipoH5hgidHXgmlc40JauKf45z+JTdAMUvflkNCBGKYVs4ijD
	 vn+w65b/5HC5Lg3NUJ/ZsIW5ipNQABxWNdFPxOZUwK9uhcw5DVFAMHmsr5rmS6mJVW
	 tVriIzfAPxUhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C25836067B;
	Wed, 26 Aug 2026 13:09:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73C293C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65EE080B63
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hGYtym3TBS9M for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UpTSPFV/
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6700080A4C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:38 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so7453575e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749777; x=1788354577;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QLd2L10nLxD3BG0pqVIQ+UCSVDxZCNVUU4OxRBldXqg=;
 b=UpTSPFV/wWE1ALz1nSJi/xobCzJ8mDIRR2NxOnwWzgyi4C8T/7dL3YtWnsHIrNVbSH
 L92yNM1w2fiGKBb2WOUwJYo/Ghwu5Zv3NmvfUT9ef5gRpTmC13cQ2fr1TDm2YSw+xh7+
 Iz+A3VkzgxoasFoX8JlAH6AzAkxgP+qEQ4cgEVu2i1nhrmW1alYerNOYsC1tkfOAMPGU
 CJfCMS/hstLYcJO9FOZ0IuoL2dFiH+VksNvswe6OxkqwNhAH4GpFaCqB/T9oiZgB9tWG
 4CUid/uX0LQXJoB1zAAEo5vupJajk/ZnShgJkuuJXxM0ta2Ztex6fZOaFFHINrv4YIqf
 LSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749777; x=1788354577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QLd2L10nLxD3BG0pqVIQ+UCSVDxZCNVUU4OxRBldXqg=;
 b=rvSgtKI97GFwHaRQdSbH/mo9tLQrM/DP0YtkRQ32ES6/OuefKRrSTpRUgUnqCNsHz/
 6A22BJ5pRPNfDnzX6OuFeVIlNjJJw6YNt6yxJ12fpHiwojC4pD5fljO9BaBtwheUHnq7
 rKeL0bEeW5ax3RaD0H92fu1E9mDEmvCk3DkOmDz0F9vmgtTa4LILSe2VMlUSYEGc6sUp
 Rdd8O7/bWkAsZ6mhYq57Mysl917865vWmez3THfS6lMH3ZVk3/AqVdZfGBXZWGksL4LG
 03hooP5+JRaMmKrPtnGBe6MbFw4QSmq8Czp00Mm0cGnZJ4D+XZWP1sPukNgKpP8gn7OH
 /u9w==
X-Gm-Message-State: AFuF++mkPqCdlgcZ1DMFYHLLBvlxhrel2PVW+1nZt9RZ18pXnK80zhcx
 2+GIN733vNrXL+Z7rCzGf2LWDkagaiq/f3hUDMXyv8RRulM6mq+0TlQWiG5f+Nr7UMh48Aogn3C
 w86tw
X-Gm-Gg: AR+sD1183qZCNsGD27Hs5V2RM5XNa4d/FTnUymfCSC+9N4lpXiToQhW1oN+hQJpsuIJ
 USfCPY5DFOb17WRAgxJCaJOuLAXxdSECf881frW5suwO951deKykPCtNgNkbOT9+A1n088Nx5qf
 rt1+pGVo2XVHnZqkwmjLi7wBwt9H0JlwkQqEifsn/yxct/ie36hzT7laux5/R3/1jfzEKOMETOQ
 5rUkqpftYdkm3w2i7LnZGxwKZe1VJDNv2FGlJnQB/UN4JQn0BugWcxzhSkY+sGsCRcuRd+Bzodg
 ZPaLj99HFf/gla61R8bp6FrZAzByr9mDKTpxIGPdZCwFcvmrPW6ulwWrX32+zQHA+RWPXDe1fkk
 mBqnQb1PlG2Vqq6nP33xEEXadO1vhtwXiy9nPj5TSTVSXwafl45A5aseo52QSYhxejf66Ketbhn
 MiI84LjDOjQjMA/fW4eVvklgC/YrZ7No3VnV7dwD4VFHKhJj/dIxOKuMUPGOv2qYfqhZYSq1u57
 vUQeDNEf08w+JVp+Y93TZ7nJhgPqBvMTR74PMHZwdOsLR9At06pKwULunBWic3dYamqHMWF75Sl
 zYMpkblTe/z9EPzTuWn3p2h8zR4s2+RQzwlDjX9CgA623gLJVSfdfkMz
X-Received: by 2002:a05:600c:8518:b0:499:d95a:414 with SMTP id
 5b1f17b1804b1-499dc7042b6mr64029095e9.6.1787749776937; 
 Wed, 26 Aug 2026 06:09:36 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:36 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:33 +0200
Subject: [PATCH v2 06/14] video: mediatek: add rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-6-68ebb1bf17df@baylibre.com>
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

The MDP RDMA is the DMA engine reading the framebuffer on some
MediaTek SoCs, such as the MT8188. Two instances are used, each
reading one half of the frame; the second one starts at the middle of
the line (apply_offset).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_mdp_rdma.c | 97 +++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_mdp_rdma.h | 20 ++++++++
 2 files changed, 117 insertions(+)

diff --git a/drivers/video/mediatek/mtk_mdp_rdma.c b/drivers/video/mediatek/mtk_mdp_rdma.c
new file mode 100644
index 00000000000..eb8b673477f
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek Video MDP RDMA Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_mdp_rdma.h"
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
diff --git a/drivers/video/mediatek/mtk_mdp_rdma.h b/drivers/video/mediatek/mtk_mdp_rdma.h
new file mode 100644
index 00000000000..aa2585e9c27
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+void mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			 const struct display_timing *timing,
+			 bool apply_offset);
+
+#endif

-- 
2.54.0

