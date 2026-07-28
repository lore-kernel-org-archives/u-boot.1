Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B22FC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8B6B8136B;
	Tue, 28 Jul 2026 12:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CA1V1Q5XGbFb; Tue, 28 Jul 2026 12:29:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13F9A81092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241780;
	bh=aM5WElb9Yr1USfoFHBHEoLY0F59lzjnM6F1VWbjRW4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y8a7rBkuoXIn+isFqoe2LeWxMfE4bVWcFqgm+2O1uWCn30WweJ/HW9KxTH6ySO0eU
	 vgc5WqcN5sb8haoHdeQltAWMgtcB7JeKic7CJkg/aSwZ5UduTxnOSzro1HHBo5JBVL
	 j2mx59Js+k/cdYrbMG9kdzBYjKUT9L/1oJGFyA7YycPwpQQSY4ODUko9hotY54poLU
	 t9ESnM7BggQWRr43z3U8k87NixzGOmpU6rjMcSSIIS/WeAgoO0FHMzCO/1GEi1cBDp
	 y1QnXYu6+OYspT3mR/FxPtcB8dcVwNPqqN8xz2KQGAEr4kZn/YYwbMg8jgckGwU1li
	 Wlvk3bnqZIq4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13F9A81092;
	Tue, 28 Jul 2026 12:29:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1B0E194
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DFEB60834
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TzcwmBDJQhlt for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AA750607ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA750607ED
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA750607ED
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:34 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso2283209f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241772; x=1785846572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aM5WElb9Yr1USfoFHBHEoLY0F59lzjnM6F1VWbjRW4c=;
 b=OjJXs5onk5oSjASyUS4/lGLnsGma17dQEYhaxF3AAutBdjzEBcQ8+MUTkZ7Z9Jana+
 Zv0yB2j1gxqO7K47j9iX0OXfojaHtp8y7PE6JH+YFSQCTuEBfTjzsFer5Y8RlbImAfTB
 7iUjZd7uni8uiC2ZaQzkMjKJfZyE46sEYz9c7dkihDqnvL+O5zksop5JpImT6sdISFDu
 TNSnwsinz9rZH5kqdm90MzINftea2TbxOSclgVkbAOQA/Ia0rXP2r/efrBW6qo3aQQTH
 ynqy3tZxtOLN6VeRix35SE7PioMZi293ulK2q6JJAHEgTpo698KOcQcx3HiiU9hNHP2K
 fHbw==
X-Gm-Message-State: AOJu0YzqhKUBT7L9W9NKwtA8morg2qYs/iawVxxCXd7yd/wvghyxHM66
 aG/6qGwtvmBS1qlZ1TegYMB9P94ZGfBMtwSgO4xRfPX0c5/0kfallGlCG/rp9IYWUV8=
X-Gm-Gg: AR+sD134oQtD671geh7eF4ULollNULXz5WeOgTpNh1Mwmr203bW/iJd259IVgIX4ZJq
 eN6l1CsKr31f1zqsGL12NR4n6vT7XhG8HsLIx3rTlqD95befClp07KI9IWK1XPvpm9QMGzKVKdo
 /zHtUTABj3bWMnRthdFzidw8z/Vlf0ftPqQgmlwquxGzTsezq1YMM2ohYiTU+yIUhFz9AzGCu4+
 qKePJrG5N6jupy9ri5lkguxkGkfONCSNUsMEdseTDWzfnTaPVS3+QILJE1bFIEvGn6lWI6gQbfT
 PBO2wop6aj5DEmvT1HYxdFu/mV489z33yZOIKgS6tvERCQSzkkBEUDZ8G7/z4+p66See89t9cOM
 iChQAuK8jqDwo60WwsVADLCDwh0lDw3ukDmhPmdAqILQoke11KOMiVgFAfWbZWC9UpgKpfsr8qs
 StREb/fqsxddNF0nZizNHSg73KzoE5NXrmlXp1YHdPQxbNdQeBNYl+CIqJE1mCu+H/dveTXx1Ju
 vYjwLQL6zGGGdqhhjgpGp7chVuoZjHM8zBfFWvbr6gNxQzZ6x+fHnsmOZ74R5g=
X-Received: by 2002:a05:6000:2906:b0:47d:f023:b4b3 with SMTP id
 ffacd0b85a97d-47fb1ece057mr2343648f8f.34.1785241772387; 
 Tue, 28 Jul 2026 05:29:32 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:35 +0200
Subject: [PATCH 03/13] video: mediatek: add merge component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-3-ac54bd75f960@baylibre.com>
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
 d=baylibre.com; s=google; t=1785241772; x=1785846572;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aM5WElb9Yr1USfoFHBHEoLY0F59lzjnM6F1VWbjRW4c=;
 b=IAfS55E1bnY84T65QujnYo40GTycjz9ggcz757N5I0sYxWaBqX/EAZe2hjoZ9zeggH
 7kt517bFczvAJo1O6u1Hb+8mZuF3lK76QJ9qAhZcFo8KIZXxA491rE6Ry6ReZdUM0zBQ
 XhQHjm2/4XJ27o3wDwVOqc1pIJweRIDkMG6OpkIrFGGam6NFlCjmZVcGLmmi4H32HPzr
 j3kxwbcIM3U6qCA69BL4KsBy/YUOzR5+AP/HM1SrX8oTDOGp9v6w+oeG6FeZFO80Eq6k
 /QRS8vMOXdJ9Whbe5gkPfKThokXLm0JhW9j0Uq5w98wTrxBsMZRcXJRP1Zpkc6FZZMR3
 SAYQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IAfS55E1
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

The merge block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. It combines two half-width
inputs into one output.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_merge_mt8188.c | 106 +++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_merge_mt8188.h |  19 +++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_merge_mt8188.c b/drivers/video/mediatek/mtk_disp_merge_mt8188.c
new file mode 100644
index 00000000000..437bf1a5533
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge_mt8188.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek Video Disp Merge Support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_merge_mt8188.h"
+
+/* MERGE registers */
+#define SUBDISP_DISP_MERGE_ENABLE	0x000
+#define SUBDISP_DISP_MERGE_CFG_0	0x010
+#define SUBDISP_DISP_MERGE_CFG_1	0x014
+#define SUBDISP_DISP_MERGE_CFG_4	0x020
+#define SUBDISP_DISP_MERGE_CFG_10	0x038
+#define SUBDISP_DISP_MERGE_CFG_12	0x040
+#define CFG_10_10_2PI_2PO_BUF_MODE	0x08
+#define CFG_11_10_1PI_2PO_MERGE		0x12
+#define SUBDISP_DISP_MERGE_CFG_24	0x070
+#define SUBDISP_DISP_MERGE_CFG_25	0x074
+#define SUBDISP_DISP_MERGE_CFG_26	0x078
+#define SUBDISP_DISP_MERGE_CFG_27	0x07C
+#define SUBDISP_DISP_MERGE_CFG_30	0x088
+#define SUBDISP_DISP_MERGE_MUTE_0	0xf00
+
+void mtk_disp_merge_config(struct udevice *dev,
+			   u16 width1, u16 height1,
+			   u16 width2, u16 height2,
+			   u16 output_width, u16 output_height)
+{
+	bool dual_input = (width2 != 0 && height2 != 0);
+
+	/* input 1 */
+	if (width1 != 0 && height1 != 0)
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_0,
+				    height1 << 16 | width1);
+
+	/* input 2 */
+	if (dual_input)
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_1,
+				    height2 << 16 | width2);
+
+	/* output */
+	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_4,
+			    output_height << 16 | output_width);
+
+	/* no pixel/channel swap */
+	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_10, 0x0);
+
+	if (dual_input)
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_12,
+				    CFG_11_10_1PI_2PO_MERGE);
+	else
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_12,
+				    CFG_10_10_2PI_2PO_BUF_MODE);
+
+	/* size in sram of inputs 0 and 1 */
+	if (width1 != 0 && height1 != 0)
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_24,
+				    height1 << 16 | width1);
+
+	if (dual_input)
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_25,
+				    height2 << 16 | width2);
+	else
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_25,
+				    height1 << 16 | width1);
+
+	/* merged size of inputs 0 and 1 */
+	if (width1 != 0 && height1 != 0)
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_26,
+				    height1 << 16 | width1);
+
+	if (dual_input)
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_27,
+				    height2 << 16 | width2);
+	else
+		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_27,
+				    height1 << 16 | width1);
+
+	/* 12 bit lsb off */
+	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_30, 0x0);
+
+	/* unmute */
+	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_MUTE_0, 0x0);
+
+	/* enable */
+	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_ENABLE, 0x1);
+}
+
+static const struct udevice_id mtk_disp_merge_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-merge" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_disp_merge) = {
+	.name	   = "mtk_disp_merge",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_merge_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_merge_mt8188.h b/drivers/video/mediatek/mtk_disp_merge_mt8188.h
new file mode 100644
index 00000000000..7dd960541a7
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge_mt8188.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mediatek Video Disp Merge Support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MERGE_MT8188_H
+#define _MTK_DISP_MERGE_MT8188_H
+
+struct udevice;
+
+void mtk_disp_merge_config(struct udevice *dev,
+			   u16 width1, u16 height1,
+			   u16 width2, u16 height2,
+			   u16 output_width, u16 output_height);
+
+#endif

-- 
2.54.0

