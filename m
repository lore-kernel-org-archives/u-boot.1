Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0A4C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D0F180F9E;
	Wed,  2 Sep 2026 14:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tqFqyv9IbtaG; Wed,  2 Sep 2026 14:16:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358592;
	bh=PNL0Lp04gkvpttoC8BhHvFIA9qr1DH9v6KBKWhl1L9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aUEvIG/pVT9GEq3nCsRrMXvj8R71yn/wxtkIPbKNBemGeA1pxK1nicT29xjM8GqgF
	 9KKfnWNbcR7Orr5LnAgA46BBTwMaKhKE9J2cf8QOTOj7Zgp7SuDMW31FFJqGhk2Cxl
	 9oNVIDoojDVaHnTzCSmmTGDNfTqhoY8dOTkA3qiel0Ow4tQS0mpvoaioDAzkO1PsYY
	 qsg54Fcn9Hf9DAClfnwr4QB0R677o3Ex15WQNJdDg8XxH8SgkcW2NNjZyUmtTutglW
	 rdPL7E1Fo+8EaPEl/9i8t157iEDjj2GC6coPVinN2cpITUs/Qy60bnmy1/dgmt+D9Z
	 L6jhQ3dBSXkJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6988080F58;
	Wed,  2 Sep 2026 14:16:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B5492FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D10240839
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lAEqi_H-6W0F for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eZESqUHo
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11523406FA
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:22 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so715716f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358580; x=1788963380;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNL0Lp04gkvpttoC8BhHvFIA9qr1DH9v6KBKWhl1L9U=;
 b=eZESqUHobRIZk6h4L3Hl8sOaWJHhX+Xvb4f5WqmpeCFuFxys0Y/SsSvbVN+gv8TEgu
 t8LtlgQMrrQf/0SLLInFJN9dZp37pIXw9qI7wUqGUuU7nTzJeXXk9PxBQA3AzAEFodxh
 5RLYmiAXr5kKWRDvrRtAMkI3Re4HO4UFOLHv0xXsUff2QL4GP2hFT+d2zdKcuNgIvEiR
 kp/1wAn5vY5Dd0CQSVQ69kOVbQbqzLtzwAb4ITFU0L/2qI7zODIilQoFobB5MvLJV3c4
 ZNaRrbyXfHzcxCxGvz3WoH20PoesWZ9X3Niwi+7INLmGPh87ryOcuW6M9D131oFHHVBv
 Cjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358580; x=1788963380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PNL0Lp04gkvpttoC8BhHvFIA9qr1DH9v6KBKWhl1L9U=;
 b=cb+2iczsVZwEJtlQBRx/U5xd+DwnhVmDClgGu937uQXBHT09UMVuIhdkwpwSfgv1Id
 BTsYamXk00K1XnJ6PyGdUHwZX/h572NnrXyq3dzxAg5Ci0+Qf08823l47IBMRVHdq+Pa
 xWDo2xAAYt5zKy0NzghKwzoSUTV9irGD7GV1kOEtdEpK0JmrYk0HdMeGVN561WLfpXs4
 ZGwPPHYjSIO/mVCaDmkKg9tBAp7V2ag0xJC3SCMxvUL9DbCGq8QzWQrG1hnwfRETiFMl
 B+8d283WASjZhEtGnNiLERh9RPNoKsOYML5iIHw1oyfXRmOuBauvJS947LQ2jsX0kbix
 wzlA==
X-Gm-Message-State: AFuF++kNUDJLgV7ZdjRYiIMshn7NRfX/QzmgqqVaCSnxp2bzV3RrI6qb
 a/PsIjW9JFkWoOU14aZasnQi7FgB6LiFxJO4MBc336HYLgbppEtwEKnt1AUhOhcVfOI=
X-Gm-Gg: AYBFou30TEdqIRO5M29TDEydfOVHXY6eyqlNLuYmndRuempyFbQ8npniAEpwetpkZ0E
 vldZrBfSyArMTm4bx1ubcVDlHhfbI99A6cqbg8j8sb1TIeOy9Hn4HN48tZtoxjaEETelT0JW+SE
 2GmKy2uI01g6YDyEVT2omEFGB1Jn7RJkTdacgHhOMkXa8vu+crmugVpRcJ4z5EKZ3ctPbfzEMmM
 +JRqlEThrJ4LE1Z2HdY8bwHbEMVH0S99H1+XcjutX6bqvFTs0lWlXHK1qjROK/K5zXmBdViJQ3u
 7HvnRmfEFpQERQg7soMKE5A3eNKKYQ8pnbc8rHeROYVXaq3ThI5m30qVevd7+WA/0oBIty/Dl3Q
 0smWh+CJHVKZh0fBoVCdr706Ewl4CrNnEWH2k1dr6YzBaOyFRruJkKZTxb/QpRT6klzh/JXmGLA
 LEpkPjO2cCKBhcdYLGvTebkBB6K6leByfkb+scu5nTH0cTqhXTGkdCHAKxig2mozkGhTkI2mHbg
 Ehvz5/ByGtBg/eVgI0fnFqxox6P7bp/N0kVGSg2O6Fn9+SVtjn7dGDZ46Upy8STCrDTWOAEBYBb
 OVCA9O9wEQZBOIrhsWmPT0UvY4+atop8ze7o2U3SDn/e
X-Received: by 2002:a5d:5f54:0:b0:482:e658:bb8e with SMTP id
 ffacd0b85a97d-48488f0dba5mr9933640f8f.12.1788358580365; 
 Wed, 02 Sep 2026 07:16:20 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:19 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:15:53 +0200
Subject: [PATCH v4 03/14] video: mediatek: add merge component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-3-7c3b4f068a56@baylibre.com>
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

The merge block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. It combines two half-width
inputs into one output.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_merge.c | 108 ++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_merge.h |  19 ++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_merge.c b/drivers/video/mediatek/mtk_disp_merge.c
new file mode 100644
index 00000000000..487d6df6f0d
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_merge.h"
+
+#define DISP_REG_MERGE_CTRL		0x000
+#define MERGE_EN				1
+#define DISP_REG_MERGE_CFG_0		0x010
+#define DISP_REG_MERGE_CFG_1		0x014
+#define DISP_REG_MERGE_CFG_4		0x020
+#define DISP_REG_MERGE_CFG_10		0x038
+#define DISP_REG_MERGE_CFG_12		0x040
+#define CFG_10_10_2PI_2PO_BUF_MODE	8
+#define CFG_11_10_1PI_2PO_MERGE		18
+#define DISP_REG_MERGE_CFG_24		0x070
+#define DISP_REG_MERGE_CFG_25		0x074
+#define DISP_REG_MERGE_CFG_26		0x078
+#define DISP_REG_MERGE_CFG_27		0x07c
+#define DISP_REG_MERGE_MUTE_0		0xf00
+
+/* CFG_30 (0x088, "12 bit lsb off") is not present in the upstream driver */
+#define DISP_REG_MERGE_CFG_30		0x088
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
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_0,
+				    height1 << 16 | width1);
+
+	/* input 2 */
+	if (dual_input)
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_1,
+				    height2 << 16 | width2);
+
+	/* output */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_4,
+			    output_height << 16 | output_width);
+
+	/* no pixel/channel swap */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_10, 0x0);
+
+	if (dual_input)
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_12,
+				    CFG_11_10_1PI_2PO_MERGE);
+	else
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_12,
+				    CFG_10_10_2PI_2PO_BUF_MODE);
+
+	/* size in sram of inputs 0 and 1 */
+	if (width1 != 0 && height1 != 0)
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_24,
+				    height1 << 16 | width1);
+
+	if (dual_input)
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_25,
+				    height2 << 16 | width2);
+	else
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_25,
+				    height1 << 16 | width1);
+
+	/* merged size of inputs 0 and 1 */
+	if (width1 != 0 && height1 != 0)
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_26,
+				    height1 << 16 | width1);
+
+	if (dual_input)
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_27,
+				    height2 << 16 | width2);
+	else
+		mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_27,
+				    height1 << 16 | width1);
+
+	/* 12 bit lsb off */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_30, 0x0);
+
+	/* unmute */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_MUTE_0, 0x0);
+
+	/* enable */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CTRL, MERGE_EN);
+}
+
+static const struct udevice_id mtk_disp_merge_ids[] = {
+	{ .compatible = "mediatek,mt8195-disp-merge" },
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
diff --git a/drivers/video/mediatek/mtk_disp_merge.h b/drivers/video/mediatek/mtk_disp_merge.h
new file mode 100644
index 00000000000..4a91129711a
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MERGE_H
+#define _MTK_DISP_MERGE_H
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
2.55.0

