Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081CAC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B635360887;
	Tue, 28 Jul 2026 12:29:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8iSPKd2l7nli; Tue, 28 Jul 2026 12:29:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6D8360873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241782;
	bh=TfMDgdGNfNJRzPE6uMsu4uc7nHlldvIUJjjzdY1TqXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S3YUWUrDT7zWohM+mnN4YSQUHhrDgw1jWKWzaTzUZIySl9uH/DIcYBebdbNrjCynE
	 jEOYReWH/zpHkDd4GKYT4ZxMXQ3jAwt1z9quUDTTzDPptnOS2OVMZMksFsFIuEvwlx
	 nDpnxy1zcorv6duHYp7wZxskZvxcXfKMFxArjjfxUrxy5LK1LjrHZ7MwMvDaa1RgT4
	 38eTel+iU7CcLU0352np0Bgpr2YRTXk7Q7FCO+ywi1FzyxogK3pCoA3wZeLS6FoHCk
	 d0ddbVMkYEhC0Bwl0ICqQcr95jY8TWRxgaaRYRFK8YccX+Z9cGn6tdgQojjmV+EIUn
	 KinfL5jP199iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6D8360873;
	Tue, 28 Jul 2026 12:29:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E720323F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D939E409FE
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGs3gKkSOGN6 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E8290409FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E8290409FA
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8290409FA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:35 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f84023916so3785111f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241774; x=1785846574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TfMDgdGNfNJRzPE6uMsu4uc7nHlldvIUJjjzdY1TqXc=;
 b=sxWZGgd/IOpKU+dS5lrBgbYRAkAf0moiRJ0eOsM3PFaUEZdczjZ3NisJOwOZoHkwlv
 WVC0q0EUWnW+jBWhgYXA3w+3XINaD4V/z5rGO5AjfrLhmadITe3b5coZ+Ih1mzpPHkIS
 exPVnC+uNQ8WTmoHY7oSacwFdwnyaNmGWLPtonZpWI+IH8bAE/eJ8eO4WOm0PHJgr/Tp
 4iHdjGavPCSdKM6y3/N25NHPZM5eJ4hN/9xhbSkAwkh7J2hAKRglmmw/+yfYOgHyAFMq
 m0zWk5j9uPWqxMGszKpgAvvFB351/8JQUmiiQo7izeyLFjLBBldqkHmsZ8ivqdMFPoKT
 ee5A==
X-Gm-Message-State: AOJu0YxuT/t1xOjjRA8u9DPzjMidBj6Kv/Lr7JiDZG9AbH8LB+8E3bEx
 mhD0Rsb2b0Yff38hUk5LhCsKXu7O+vMPVXqY6Bz3ZI6YC2Il/ScwFtEEXoArzgMU90U=
X-Gm-Gg: AR+sD12+NsguUpwYAsyplTN0oQ7ExgBLZ1/UExyAUDr4HUHhdpb5jCUjn/WXVOfBNyd
 2rwSFppMl24VS3YJQgADxPTX4xqWKFk96O0lF6WlG5xvOhAFy2LsSqTvBE4r7r0OI0+REn0elYe
 3a3/rMq+g03YHHegzFi1VufAST7V4f2HIfvoheYtDd0OMTQ1y5DHVaWAXNoAMsv4lQWYFeHTGOG
 oxvSraI9Mhid1jYscS24ESnODQtL0gDlL9u+/05CncrDeRoNK/ETQrgNAoSZ8Q2KYFTD1bqPCk/
 jHGdfhOA3k/KIxySOAj2xJD90EcqYBZNQ+K4xzowxABlQuuviL+C/vy2J3iXnBGGyzXwwnF19ml
 utfo4u69XD5/sJjx6+XpMxJbTjaUSkc3fPjvoxPjJr5BUspVzVyBM5yqpCdJ1Fx2oR/u9Yl2txn
 fG0rCE+Bja+KmdBnTjZtbq5muclwSG4FvkCYHzNmnHrCwEKyIfWuwwhaDV6qwd4ApT0Fa5x1WKI
 5tf5ucc24tjGUNw6QIoaFr7Ko2dRg+EnHRvuaOSFTfP+kD95bzlBAvsyHpcX2Q=
X-Received: by 2002:a05:6000:2c0c:b0:47f:7129:6e2d with SMTP id
 ffacd0b85a97d-47fb1ed7535mr2486385f8f.17.1785241773619; 
 Tue, 28 Jul 2026 05:29:33 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:33 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:36 +0200
Subject: [PATCH 04/13] video: mediatek: add mutex component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-4-ac54bd75f960@baylibre.com>
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
 d=baylibre.com; s=google; t=1785241774; x=1785846574;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TfMDgdGNfNJRzPE6uMsu4uc7nHlldvIUJjjzdY1TqXc=;
 b=R/QduwNJ/kOVnxsPmutyOjX2t5sRx3QBHP2Ruy2+4xo1VLQyd9kK9pHT08vwMPOkI1
 REbZ0afr1jWBv6zvtgJ7XFg+w34IT9V8PjoivmzjWNwr1Rx3bk21oOS0277HGbzUy9d3
 GlCst/blBm8ZoaUuQJSCY0XSTO0tZLZwfsfkE639orfwvdXlbMCSpl+zfy1S53tTWpT1
 +2f9Dwtgs6ExNJI6qlrSZhGzI9B+r0OX/vYb78W6vMxSzEU/GBClYU8AfXf133rxe0VI
 2Czt/oD23ggpwCmrvK8HRpfV8dfkiozeWQ6VbvbCHbbh1j5i77tCjWMYwJvQbEbqryr1
 nUQg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=R/QduwNJ
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

The display mutex synchronizes the components of the video pipeline
on some MediaTek SoCs, such as the MT8188. Only the modules of the
DPI1 pipeline are attached to mutex1; the module bit indices follow
the Linux mtk-mutex driver (MT8188_MUTEX_MOD_DISP1_*).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_mutex_mt8188.c | 63 ++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_mutex_mt8188.h | 14 ++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_mutex_mt8188.c b/drivers/video/mediatek/mtk_disp_mutex_mt8188.c
new file mode 100644
index 00000000000..f7e52cd25bb
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex_mt8188.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek Video Disp Mutex Support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_mutex_mt8188.h"
+
+#define DISP_MUTEX1_EN		0x40
+#define DISP_MUTEX1_CTL		0x4c
+#define MUTEX_SOF_DPI1		0x5
+#define MUTEX_EOF_DPI1		(0x5 << 7)
+#define DISP_MUTEX1_MOD0	0x50
+#define DISP_MUTEX1_MOD1	0x54
+
+/*
+ * Modules attached to mutex1, bit indices as in the Linux mtk-mutex
+ * driver (MT8188_MUTEX_MOD_DISP1_*). MOD0 holds modules 0-31, MOD1
+ * holds modules 32-63.
+ */
+#define MUTEX_MOD0_MDP_RDMA4	BIT(4)
+#define MUTEX_MOD0_MDP_RDMA5	BIT(5)
+#define MUTEX_MOD0_PADDING4	BIT(12)
+#define MUTEX_MOD0_PADDING5	BIT(13)
+#define MUTEX_MOD0_VPP_MERGE2	BIT(22)
+#define MUTEX_MOD0_VPP_MERGE4	BIT(24)
+#define MUTEX_MOD0_DISP_MIXER	BIT(30)
+#define MUTEX_MOD1_DPI1		BIT(38 - 32)
+
+void mtk_disp_mutex_config(struct udevice *dev)
+{
+	/* the pipeline for the hdmi connection ends with DPI1 -> HDMI */
+	mtk_disp_comp_write(dev, DISP_MUTEX1_CTL,
+			    MUTEX_EOF_DPI1 | MUTEX_SOF_DPI1);
+
+	/* attach the modules of the DPI1 pipeline to mutex1 */
+	mtk_disp_comp_write(dev, DISP_MUTEX1_MOD0,
+			    MUTEX_MOD0_MDP_RDMA4 | MUTEX_MOD0_MDP_RDMA5 |
+			    MUTEX_MOD0_PADDING4 | MUTEX_MOD0_PADDING5 |
+			    MUTEX_MOD0_VPP_MERGE2 | MUTEX_MOD0_VPP_MERGE4 |
+			    MUTEX_MOD0_DISP_MIXER);
+	mtk_disp_comp_write(dev, DISP_MUTEX1_MOD1, MUTEX_MOD1_DPI1);
+
+	mtk_disp_comp_write(dev, DISP_MUTEX1_EN, 0x1);
+}
+
+static const struct udevice_id mtk_disp_mutex_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-mutex" },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_disp_mutex) = {
+	.name	   = "mtk_disp_mutex",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_mutex_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_mutex_mt8188.h b/drivers/video/mediatek/mtk_disp_mutex_mt8188.h
new file mode 100644
index 00000000000..1739c0e2381
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex_mt8188.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MUTEX_MT8188_H
+#define _MTK_DISP_MUTEX_MT8188_H
+
+struct udevice;
+
+void mtk_disp_mutex_config(struct udevice *dev);
+
+#endif

-- 
2.54.0

