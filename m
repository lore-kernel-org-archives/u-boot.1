Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D05C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A38AB80DB8;
	Tue,  1 Sep 2026 14:39:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LA54ws_HVV08; Tue,  1 Sep 2026 14:39:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273541;
	bh=hss58b9cl4NnfeSl8E9355QiZ+V5FZb1XDQvYAo2Vis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DYx4auraS0mDYHRaHwNP+9s5tH6qNbDZqMlkH2t0AaSwnlfZt8loJsSMY5JYMCH0p
	 iHJNe1DpHBZnCdyq5oA1AMlgSRtMTDRWsroPJTjoSzLcuFRhadbQF/WfEQkP3b65qS
	 QRKM/SpNVuQkoJtriywzzQUe7V+GEUhyy29jbL+Zbxtg0QEGI2VLcGt7BpbrgtKzkM
	 SJ7X6BXjFqh10fbW+TPcGE6furBTVGGnM7GoYO1k8w0FywVe97ttWPLTuO4KSeJ0dD
	 JceoUN4YhQiE/JXSo6/gluGDbMcM5z2/DWCva8w/rpkI6/Kgg7tV/dMpSpUumFQHWV
	 s/j/DHl+m50dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D60CF80DB3;
	Tue,  1 Sep 2026 14:39:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9119279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6D6260759
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uk_PdqZ9_Cs9 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=D/Do1aqw
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EB1A60743
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:52 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so48863405e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273531; x=1788878331;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hss58b9cl4NnfeSl8E9355QiZ+V5FZb1XDQvYAo2Vis=;
 b=D/Do1aqwIi6sz8Wjvkg91e36sEt4rKFa+vgbFI+GX7NhLFH7hmVaOPyEscXX8qoY2n
 GtHUkKxKb84U7Rt6RIybrAaxu6ZK0fFrAG/nQw1AX3nVXg/k1ywEQEnLVcCYoRHCQgK+
 kSq/Qe/z6yCk9Ag3wk2o6ZNSqe7X59X9Kp5ahPVReI1CcdsdTARKijtyQsOfNcGQH+kO
 yGZFK6RIVRJY7Yum9qNHl5VHf03xGbjyBr+IYsAqrSrg7I4+3AXwF/zfAFl43aAekA8H
 oXJI2XqhRFWODpGxa0d8VQKh/wpZ+bOP3QEmtgjxX+X2MetuneXosG/1bgp7FjsgxCx0
 tnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273531; x=1788878331;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hss58b9cl4NnfeSl8E9355QiZ+V5FZb1XDQvYAo2Vis=;
 b=IYW5BJJDtpdTmGkveiO24/KOTQuQ+GmfVDkz+ONkCCVSt8RDyJ7G4+Ysc2H2GHtQAn
 VXtj8nGBEP0wNt5Q/+ZMso40cMoxdhD4G+n0yEp04s67F5OV0gB65zrGcwITKyUSAXP0
 aBQlsXVMrlQd/NcpU+XfCikHERQu1nNzGR3Sm3tbTPvbbkQIG+codZ//jMCEM1gga9IQ
 rIjNloSs1fUDuQ3a34xMq2NpI3nxjCC4LePSDPgUsAMnIf+GXBa6Fy37WOeWnWqNDar2
 uoaK7br5krpbMLpZLjuOGIaemZ4TtC+uE1WN2d2VG2IsXcrzq0Z024l/v3QvL53kqKF/
 J/kw==
X-Gm-Message-State: AFuF++nGIkl2/aMIwuSiMkwnOJCF6AJu0v2NG7Uj+Nh5lP79RQmkRTMb
 NmtA3Za6ZMPnkcSGugIW4/ZeNgmF8NayImQB2AEUpxZ741fAbhs4zbvSEr9kwJV7CEE=
X-Gm-Gg: AR+sD10M8GkIVv7jKzTLET/Ii+D0y6Jh3u8NTvRhamd3jhvO+6BsD4OoKNR5AYP75tx
 04my0yt74Irpk+ibSTwZo7XVtsTlJ/ginSz/kwKj05cdnjgNEEohsrjes4G3Vx43uey/B8n1xIx
 bVNbJ2hPafJD5+WGXo0IbE2eDtpBl+90601qpjEfy3pQ2KSF7dD1gFDzN9PSm//xC2xp+6XhvCF
 RL2r9V9dHlRGlUXchFLDTCWxZaXDYYLNwzBzBD+Mzl/Nhf5TZH1LOxMZKAE1VQ/5RTvV1FIfjUP
 /pVUDIEZhF0b9tUQ9lQIOGt3nh9KovKCsYSM9pVRwGaJLLRLoQy6fp+rSSdFjsdNsWUYf3DPiaO
 1qUQgyjX+Zc2dLNa2R2+lMlq3ax8hrn6ijgnDsnmV5eYAJllveEdmquYtf7KJoZ1dfdubMkbI1k
 /DSLLlPhk/xfNOyR1psXJo6bgcN1NaGkS031xDl2yCE+bWpS2t8jfw5/cB6F9nZvm995N8iTtiF
 ilEaIzA3Git4UOd8XeVDv5Cw/Fx5f8PhAwBp7wiWg21yZ0IcuPc/gGeRg6mXjqhhCucqiCw/2+p
 EE3AkJpCznbE6tSarKeIBJcMvU/qJSXjaAIzzNHjG7Oj
X-Received: by 2002:a05:600d:11:b0:49c:d818:8771 with SMTP id
 5b1f17b1804b1-49cdc41c424mr180830265e9.7.1788273530907; 
 Tue, 01 Sep 2026 07:38:50 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:50 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:51 +0200
Subject: [PATCH v3 05/14] video: mediatek: add padding component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-5-38194a531b9f@baylibre.com>
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

The padding block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. It is configured in bypass
mode.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_padding.c | 40 +++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_padding.h | 16 +++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_padding.c b/drivers/video/mediatek/mtk_disp_padding.c
new file mode 100644
index 00000000000..4a69670bff2
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video Disp Padding Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_padding.h"
+
+#define PADDING_CONTROL_REG	0x00
+#define PADDING_BYPASS			BIT(0)
+#define PADDING_ENABLE			BIT(1)
+#define PADDING_PIC_SIZE_REG	0x04
+#define PADDING_H_REG		0x08 /* horizontal */
+#define PADDING_V_REG		0x0c /* vertical */
+#define PADDING_COLOR_REG	0x10
+
+void mtk_disp_padding_config(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, PADDING_CONTROL_REG,
+			    PADDING_ENABLE | PADDING_BYPASS);
+	mtk_disp_comp_write(dev, PADDING_PIC_SIZE_REG, 0x0);
+}
+
+static const struct udevice_id mtk_disp_padding_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-padding" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_disp_padding) = {
+	.name	   = "mtk_disp_padding",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_padding_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_padding.h b/drivers/video/mediatek/mtk_disp_padding.h
new file mode 100644
index 00000000000..f3cdd363b12
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video Disp Padding Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_PADDING_H
+#define _MTK_DISP_PADDING_H
+
+struct udevice;
+
+void mtk_disp_padding_config(struct udevice *dev);
+
+#endif

-- 
2.55.0

