Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7CCC624D6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB52F80D9D;
	Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5sn0feK3Yk8I; Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273536;
	bh=1I1vuQxV/Z8i2qDECVlVnDlM3x/aUj5wxWYD6+XB4d8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eVsxO6FHsOVy5nX3J/IsQHisuN3/j6eRzkxgdzBiTbLNNieDruAV+h5ha4t63Tmbe
	 2jb/ExViJ90Y25rTxRHGSmFpLVA5o15KCosvlW/VN8UaPJ+fMHv86DPjCaJ8f1134G
	 baaM69fxw4Kb9zujSBVSYFE5TAKKAFM9FzBIOakHdn4Mu3R2bUtlVbMPJSfqc4Jb+J
	 s95/vpRVK35MPhiC6w6IQWpGyOKZyW3j6bhXOV0x9kQEtpCQuJAXUX6+Qn29FHsEhF
	 knmSa4uPkGxywj4R+l1ml15A+8EMk4x2pfjLgu5uVQ115EUCmbMXE/Be8aJ0/ZKbyg
	 S/3wptuGnBNnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 044D280D93;
	Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64883E45
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56F33406D4
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PxB_B8SlZXH4 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lW4lH/Ku
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D2AB406C3
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:50 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso12037275e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273528; x=1788878328;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1I1vuQxV/Z8i2qDECVlVnDlM3x/aUj5wxWYD6+XB4d8=;
 b=lW4lH/KulXrDohNgIQCwJ62+v+2fLt9wqMu3WabURFo/5/49OQhAOhIHpTYSoFA9CC
 f8A+rDQ30cTiV/XvHdKUioMtUnulvw3PA74FwvKqMZ28EjfYEXHfau+i/Q9dyO21uvku
 HSeOVcLlS4Wsffp4PHkZMmMINQyTdrEvJ6/UXcggx6uDmKo+ZAK5pJmCwt6KDbYmWF7R
 rgZ6pCE086t4kHe/sYyEA9pO/Io2r9NvmngNANWl860kguSA7kNQtehReVoo7UZXTIDh
 UfElzZJh96vUvaJAmDj3ZF3ee9wFBWYRwxlFVJEaYqIgnJwMgOevaMqf/SVFSG6mktqi
 JaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273528; x=1788878328;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1I1vuQxV/Z8i2qDECVlVnDlM3x/aUj5wxWYD6+XB4d8=;
 b=p7dlqG6JsrOFZn/BRyqHZOqZx2LTWqHPSSLmNnGqafsb288s+Szvhla1Unj12bnJbU
 a+OlugupfZGeu31n36wBsJnpeJyxjkbQiUGXqXp58kBmOeVq00hfUlVxACsgxLQFjNd+
 XvPLY0DHT6RdJNEszYJ5Lczo/tRjPqGY7YbfB5gMTx/hXxQSvnRMbqQpRZTsL60K+OI8
 YJhl3Orh7x6b47HgQJ3BIrkO3RoLqVQNO3ZdBHq4rbothpa9LzKxoE9xPYHOrVyqEhu3
 S/nw8C3q4CnkkNMKnQyPj977xx8oaJWu7waF/4MfCmVUuiOa8kNFYs4F7l/TQLmlhhV7
 Twqg==
X-Gm-Message-State: AFuF++nbHEmOIHyQBj1+i5pEyzV69ICUR4nFFOvvGdLQr2dTG5iXhyW9
 zZ79tBAECY+EowuZC4DvFaoZmHhsckVJ7S9eUL1mdXrkizaEB4yvkFfGGPwXF4vMFFg=
X-Gm-Gg: AR+sD12fOCgnRdDp4CNArFUW9sjqquJEYfGa/yPV/jpMfi1kidAUHVjgR7IjJrpQxL1
 F+4jmHQoH44vdFUv3ccPjVRzd81L4hariuhiwaXBM+nHuOSC6hCiq+3/JOXoN/xqbzDzcemgCPo
 gLqpUGfNez+n1UgunJbmPZUvx8sEVcqUl4wDBywL8xVgY5N6cif9BLri3sF7Wyo6JD50Snxn+kK
 vSxxXSF9nHLQm7hCvPIAuPEb5DlF9+0EOUMS7osZ2jdOQ9kvg+VeltqQd2Ktv+VbmK7Ip9T9pXL
 +grSW5TlLaSpCYFQlUZB0gf+d5w/0D9v4VYSBbYocshbIaQD1oZO2pImJ0o2mF1foovo6Y6xNtQ
 +WOl9nYx3t5CUUFOj2aLbnX6uv/uxNuq4mKmzbFqWpmYpdIk7y3if2AOcBhOnITmWCOT8uZLtR5
 2fXJOOhW+KD31X80X42x54yJPPzImZQrFTG8bt425fcX8IoUb6Z9dJ6vqj2sjiVoY8Fx5fie+Pj
 tO1d2wMGOp9AUHsZf3YXL6Oi3eF3oDmyghJSffZAKKJ7KNwINX/PfFwkK7zlYNRzkq9bOdgQ8m7
 ISIkwleAL1JOB726vMpALe0xotbMiTG0RiZTnXTDlUgZ
X-Received: by 2002:a05:600c:468d:b0:49b:4eb6:6ffd with SMTP id
 5b1f17b1804b1-49cdd418c7cmr76896945e9.5.1788273528007; 
 Tue, 01 Sep 2026 07:38:48 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:47 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:48 +0200
Subject: [PATCH v3 02/14] video: mediatek: add ethdr component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-2-38194a531b9f@baylibre.com>
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

The ETHDR is one of the components of the video pipeline on some
MediaTek SoCs, such as the MT8188. Only its mixer sub-block is used,
which is the block's first register window.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_ethdr.c | 72 ++++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_ethdr.h | 16 +++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/video/mediatek/mtk_ethdr.c b/drivers/video/mediatek/mtk_ethdr.c
new file mode 100644
index 00000000000..7584fd565f5
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_ethdr.h"
+
+#define MIX_EN				0xc
+#define MIX_ROI_SIZE			0x18
+#define MIX_DATAPATH_CON		0x1c
+#define OUTPUT_NO_RND				BIT(3)
+#define SOURCE_RGB_SEL				BIT(7)
+#define BACKGROUND_RELAY			(4 << 9)
+#define MIX_ROI_BGCLR			0x20
+#define BGCLR_BLACK				0xff000000
+#define MIX_SRC_CON			0x24
+#define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
+#define NON_PREMULTI_SOURCE			(2 << 12)
+#define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
+#define MIX_FUNC_DCM0			0x120
+#define MIX_FUNC_DCM1			0x124
+#define MIX_FUNC_DCM_ENABLE			0xffffffff
+
+/* Fields used by this driver but not present in the upstream driver */
+#define MIX_SRC_L2_EN				BIT(2)
+#define L2_SRC_SEL				(2 << 20)
+#define L2_OUT_SEL				(2 << 22)
+
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height)
+{
+	/* enable internal clocks */
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM0, MIX_FUNC_DCM_ENABLE);
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM1, MIX_FUNC_DCM_ENABLE);
+
+	/* enable mixer */
+	mtk_disp_comp_write(dev, MIX_EN, 0x1);
+
+	mtk_disp_comp_write(dev, MIX_ROI_SIZE, (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_DATAPATH_CON,
+			    OUTPUT_NO_RND | SOURCE_RGB_SEL | BACKGROUND_RELAY);
+	mtk_disp_comp_write(dev, MIX_L_SRC_SIZE(2), (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_ROI_BGCLR, BGCLR_BLACK);
+
+	/* only configure L2 since only rdma4 and rdma5 are used */
+	mtk_disp_comp_write(dev, MIX_L_SRC_CON(2), NON_PREMULTI_SOURCE);
+	mtk_disp_comp_write(dev, MIX_SRC_CON,
+			    MIX_SRC_L2_EN | L2_SRC_SEL | L2_OUT_SEL);
+}
+
+static const struct udevice_id mtk_ethdr_ids[] = {
+	{ .compatible = "mediatek,mt8195-disp-ethdr" },
+	{ }
+};
+
+/*
+ * The mixer is the first register window ("mixer" in reg-names) of the
+ * ethdr block, so binding the ethdr node with default register index 0
+ * gives the mixer registers.
+ */
+U_BOOT_DRIVER(mtk_ethdr) = {
+	.name	   = "mtk_ethdr",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_ethdr_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_ethdr.h b/drivers/video/mediatek/mtk_ethdr.h
new file mode 100644
index 00000000000..5242b362268
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_ETHDR_H
+#define _MTK_ETHDR_H
+
+struct udevice;
+
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height);
+
+#endif

-- 
2.55.0

