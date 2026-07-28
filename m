Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC28C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16EEF60895;
	Tue, 28 Jul 2026 12:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87EkB7WW-_3r; Tue, 28 Jul 2026 12:29:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A97F60878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241788;
	bh=iIerSQKgYK4SWJHRe4z7sUVyFcPmFY6bsRO9frgm7JI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wgqvOO3d7So3Ivdp46+/L4QhHzeVIBlzZ5DTVhEqyXpcgYVGb6DrHf8zhT+BH3Hv9
	 ObjSePl8f779DPE8TW/XXxYP7XBWjETiWPavDPNhZrz6pPyvnLKObngXKVULh+eXw5
	 ISsjYustOME/qUfAEMJfKCqOqSlNStqtxyaWywrpnMyIwEtVMlpqg3nJ5WcfF8m0M+
	 l4pOBqRxcGveivHxhXgLBd5b0M3wt9X7p9zK3LJz4wJKyY3W9upE7YiR3H83tipzfw
	 AlsvlB2kxWex+yOW49mPioHhYYnVW+jToj91US8TzWYNxX0DOZ4kQH2Ib1Qh/tgKf3
	 yT7GIAsz+n2/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A97F60878;
	Tue, 28 Jul 2026 12:29:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E21042E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C305E409FE
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4CKBvEj7uisJ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B53F0409FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B53F0409FA
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B53F0409FA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:38 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f97d310caso2681682f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241777; x=1785846577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iIerSQKgYK4SWJHRe4z7sUVyFcPmFY6bsRO9frgm7JI=;
 b=F+pl9rZdBmicLCY1gJfnkvtH17wefoXziAWyFAVokoo0vvIyuGYzFk6V9fuUACvSZ0
 iniI+RuUQk5eSspL9jLyunxNxbBAiDejyA2+e5egh6pM94OQJk000B0C9GtWWAWVqMMU
 6H0OyHsqZP9luevbJeCgfC6a6ACuJ/IvhftPqRM4htWk9FUwjZjrRzUyri7puKlrbH9E
 8eg1duXR1E/FL/DRtmfq3NqXOL2Ei+pIyOwh8pKqXXVXMTmtjGrWMIkbrknPtgo4+gYi
 APNR3GMWFE3OlaN+S62w5FXixzr59UlAAB0EPJBTP+CC2NEGAibsIdOTQxSoG8KnRap8
 X/tg==
X-Gm-Message-State: AOJu0YzbdCUqe9ax8edRsBFSNiEJddv2YOWukNngx587wARH2MZJuq8D
 EbjXUqlFBXWzWdoUXiXglTGKUzSV+//B5UnlQw40c2v46qB34qeDrFG2sUgq1pIprt8=
X-Gm-Gg: AR+sD12hXJruYdrI8hBnvuyp1knvN077EUuXFZbT3mjIUOQLPTAH817CXRNKFe7EOPP
 UYZ7uFzyHMSYSQoNWfJIGL96gUp6On2/RZF53K2Obb9xMd6GD8Lx6yCsekp+jkTV7dGdlJEHJng
 SmDCc7ZnYMuuGOq4jVToNrUkxUFmONDbgrUIWG6OAQguXH+rXfoJdN6CFU/z7wz+1kaMtKMUehU
 d52QVkdbeuQ7cbqXC6UTGshWweT1d1sE13yzjNeMXAzTLylTl17eXpUsE1m9QDBmuf/lAwqVHms
 V2T5aD2Vcgdc9FwKMOHlxdFYRcbqMyx9p4NcE8AGQSE9Gb4X7tJefSEQIiey4xwn8SPSDioxiQM
 5uMruUc9N0Of1BpeApe1tbjww7+rtNPDgKoHtbc0VzHKpDHaG+ACVLTmVkqlOH3E6IP6v7PIm3r
 //zd2E+mwOMaOFlJmsOMy2hC3BpDbnRxqd3XbnDQLUYUR4Qhj7b6/qxEEcgHjWNk0oRFSbfeRGs
 2VCUpjpSbuTT7tB2LHIZ7ajuHyx+9YUIQpWsetqtzFhRPKXYAbNMXdXranVLEo=
X-Received: by 2002:a05:600c:6304:b0:493:e46e:157d with SMTP id
 5b1f17b1804b1-496c6565d2fmr28306495e9.19.1785241776514; 
 Tue, 28 Jul 2026 05:29:36 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:36 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:39 +0200
Subject: [PATCH 07/13] video: mediatek: add vdosys1 component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-7-ac54bd75f960@baylibre.com>
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
 d=baylibre.com; s=google; t=1785241777; x=1785846577;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iIerSQKgYK4SWJHRe4z7sUVyFcPmFY6bsRO9frgm7JI=;
 b=TkEWExtlUxHLRfA/OcI93hIpybiRRkjmHNeJnHFEkYD8YMsFWa/c2+B6ROBhFNle4s
 ddl2bghrQ/7bUQt26CO5qcZYTECsc7IrSLy/P3DTcc7WoLKgW/IRKmNklxjTvrrStXN9
 j0S7w0+313f0hbxjB9aypV2EirTLe5z0TigFhhR3Z/SGZJzNbS8SWsIpwEUZbMp40KEY
 kWF0uPiKivJ9JnN62d82oW/kK/5wvOb2cNtzaPFiM1se0SU3trR3px2GY0n/LVzdXI2K
 oSZnirEk5R80cs5OQvsDh1HlNv6xJpR2Ry0tjwwQt9oHti8Lqi1oSQDrey+WcHm24kWb
 oKTw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TkEWExtl
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

vdosys1 hosts the routing muxes (SEL_IN/SOUT) of the video pipeline
on some MediaTek SoCs, such as the MT8188. Configure the route from
the VPP merge output through the ETHDR mixer and the HDR back-end
down to DPI1.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_vdosys1_mt8188.c | 74 +++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_vdosys1_mt8188.h | 16 +++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/video/mediatek/mtk_vdosys1_mt8188.c b/drivers/video/mediatek/mtk_vdosys1_mt8188.c
new file mode 100644
index 00000000000..61d84d745af
--- /dev/null
+++ b/drivers/video/mediatek/mtk_vdosys1_mt8188.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek MT8188 VDOSYS1 support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_vdosys1_mt8188.h"
+
+#define SUBDISP_DISP_DPI1_SEL_IN	0xF10
+#define SUBDISP_DISP_MERGE4_MOUT_SEL	0xF18
+#define SUBDISP_MIXER_IN3_SEL_IN	0xF2C
+#define SUBDISP_MIXER_OUT_SOUT_SEL	0xF34
+#define SUBDISP_MERGE2_ASYNC_SOUT_SEL	0xF48
+#define SUBDISP_MERGE4_ASYNC_SEL_IN	0xF50
+#define SUBDISP_MIXER_IN3_SOUT_SEL	0xF60
+#define SUBDISP_MIXER_SOUT_SEL_IN	0xF68
+
+#define OUTPUT_TO_MIXER_IN3_SEL		0x1
+#define INPUT_FROM_MERGE2_ASYNC_SOUT	0x1
+#define OUTPUT_TO_DISP_MIXER		0x0
+#define INPUT_FROM_DISP_MIXER		0x0
+#define OUTPUT_TO_HDR_VDO_BE0		0x0
+#define INPUT_FROM_HDR_VDO_BE0		0x0
+#define OUTPUT_TO_DPI1_SEL		0x4
+#define INPUT_FROM_VPP_MERGE4_MOUT	0x0
+
+void mtk_vdosys1_configure_hdmi(struct udevice *dev)
+{
+	/* MERGE2_ASYNC_SOUT --> MIXER_IN3_SEL */
+	mtk_disp_comp_write(dev, SUBDISP_MERGE2_ASYNC_SOUT_SEL,
+			    OUTPUT_TO_MIXER_IN3_SEL);
+	mtk_disp_comp_write(dev, SUBDISP_MIXER_IN3_SEL_IN,
+			    INPUT_FROM_MERGE2_ASYNC_SOUT);
+
+	/* MIXER_IN3_SOUT --> DISP_MIXER */
+	mtk_disp_comp_write(dev, SUBDISP_MIXER_IN3_SOUT_SEL,
+			    OUTPUT_TO_DISP_MIXER);
+
+	/* DISP_MIXER --> MIXER_SOUT_SEL */
+	mtk_disp_comp_write(dev, SUBDISP_MIXER_SOUT_SEL_IN,
+			    INPUT_FROM_DISP_MIXER);
+
+	/* MIXER_SOUT_SEL --> HDR_VDO_BE0 */
+	mtk_disp_comp_write(dev, SUBDISP_MIXER_OUT_SOUT_SEL,
+			    OUTPUT_TO_HDR_VDO_BE0);
+
+	/* HDR_VDO_BE0 --> MERGE4_ASYNC_SEL */
+	mtk_disp_comp_write(dev, SUBDISP_MERGE4_ASYNC_SEL_IN,
+			    INPUT_FROM_HDR_VDO_BE0);
+
+	/* MERGE4_MOUT_SEL --> DPI1_SEL */
+	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE4_MOUT_SEL,
+			    OUTPUT_TO_DPI1_SEL);
+	mtk_disp_comp_write(dev, SUBDISP_DISP_DPI1_SEL_IN,
+			    INPUT_FROM_VPP_MERGE4_MOUT);
+}
+
+static const struct udevice_id mtk_vdosys1_ids[] = {
+	{ .compatible = "mediatek,mt8188-vdosys1-pipeline" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_vdosys1) = {
+	.name	   = "mtk_vdosys1",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_vdosys1_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_vdosys1_mt8188.h b/drivers/video/mediatek/mtk_vdosys1_mt8188.h
new file mode 100644
index 00000000000..e388a068343
--- /dev/null
+++ b/drivers/video/mediatek/mtk_vdosys1_mt8188.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mediatek MT8188 VDOSYS1 Support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_VDOSYS1_MT8188_H
+#define _MTK_VDOSYS1_MT8188_H
+
+struct udevice;
+
+void mtk_vdosys1_configure_hdmi(struct udevice *dev);
+
+#endif

-- 
2.54.0

