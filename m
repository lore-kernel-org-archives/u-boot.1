Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7CCC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D634F406CC;
	Wed, 26 Aug 2026 13:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id grpg7DlCSOoJ; Wed, 26 Aug 2026 13:09:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749783;
	bh=Gu8n+0WLqMuZiGOZSctX2V9PL05iQQNUElmEwE1zFws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQG6ESgs9LcSZGLib7FM8S8iOK9/XI+OKIFYnqOw/za83ejd2MREjQQ0800Cv2cMq
	 3SktLaVLhiTgqU7ASvWeXjk6GfUuAMQm+9VrWqRvJdFO6cyDCa4hJW+zKvL1hWNkUy
	 DXNdj01639JqKI47JZH8PwzklqiIszzOkL/j1z3zEIKYK8Cbx/W2fsryFVWI8ai0Qt
	 ebNHLm/U574hstmq9AFleNqqp4rVpvrvQki4IzJoNuLLSLUfnHTDXtljmd8vZzVHiQ
	 yT0J8D9BnIsoB7Mandx5jUvqysHxF/RtOuLrcPAEVOWVbphcric7up71hW6Hdm6xpK
	 2jwxbs0+i1r5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6028F406C2;
	Wed, 26 Aug 2026 13:09:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40F893C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27DA280B63
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WVT6fwpqqCHO for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iAVZOvOV
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2458380A4C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:36 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso446761f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749774; x=1788354574;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gu8n+0WLqMuZiGOZSctX2V9PL05iQQNUElmEwE1zFws=;
 b=iAVZOvOVVDMEyPaJdphs8hmTrydcNoBb9aIY8BqTCXV031jFPGR0y+HAnFuOTT0V3H
 p/a8uXnHRl8krc8OsjtkBm4dpWb5L/uA/t1HsfWJtBpvyGBPpFQKUQGKEg8knNIUlZ/S
 vfEliPK8kJnpi6O0MhU2sfSpsHSfGNgp/jxRxGAFASnzOSD+BN4q3sjNHk3pT5JObkaY
 b2W4OniW9kQmv15LNVeAL5lKbMfNzv5v/XwSJ2SZImzT22px57fmJfi6pstCp/ihKIdM
 6eqdFJBvVXXIEpsvMOUBADsiYbsZXvMqzV1kBPeZYbtM2WSd8SVhokitICzRP55M11OU
 fbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749774; x=1788354574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gu8n+0WLqMuZiGOZSctX2V9PL05iQQNUElmEwE1zFws=;
 b=c06QobWIQNQKxsi/4Q0qcRQlFZIbviJANwerJBaRAErP/BpxEglhzk2EGknArSwRKA
 8r0BC1ebOsOV3k58AWqL0CTIwSXTyUjH62HVXviu2mdvV+3RE8m870JfRB7v8c5yfUcG
 j00IBKjTgT18jT9vVXit2BJmtMDrpc+e8aTZUq0OyWFd+xGswEksJTv8u57Sa780Ux+7
 lhQ4Myt5Jepka96p2Cq6DlqawDKXgMw2AMwrBU5QS1oJql55SAdd7itO/XOjawQI5QLm
 2W0H9SQ9o+6mgYz/vyJS+YLT/8b3ueu/6G9AheGg8J429aMCGElwZZFW24Elu7eq90c7
 MHJw==
X-Gm-Message-State: AFuF++ls5SA+5153nDffLuFw3Aiv+I2XL7wn9MvmiqFHkQHQ9Gw3An+m
 rHREG78tACJheJQ/B7oYD8bW05l5kd6O6+6jk/yeCdx6OT7emh4GVPBJUyoSITZ+4Rg=
X-Gm-Gg: AR+sD112fx663rHrtwPVybzfRC8A07WG/FpLxS4C7qPPazjbvPfN2TkXcSQgsa7XieT
 NfAlj1I8V0Kx4SPrVhMOcO15eJSEfMB/rEmQjV8G6xw10A7ZcDff1v0t0IPuyCV6aiHF1DQ/iRx
 lLOGHGEFwGEyu9gjylWpF1uXSV36WmWtAYgyWgqFgYtpP1PFGgTXLJxguRFyFQS0Fs5yYSKPUYt
 M1FPhsmHaJ1sQcyxld17I2V0bBZ4R4g42laJMZCkWxq6DpAh1KpzC2mDrqM+spn1JnoZyAomd2f
 eviTFcxCs54VSFgG+HoJfAhXp7gi7rQSIi7VYgBehzAjHc4IJJ71mAnUJc6EVuXVT8Q0JR8WPAf
 E8xDQ2u4U3ko7q4VrbtVX+0ALhiamEtvorWX/iUffFB90Qx2mr7hOJxdRNjY9qaqLzA3j1mZc0l
 zqD/rRCkU+yAxF2oA5INMg5/uYE44xcvK6oO5HNz1Xm4t9/jWr6LAQMhImC4BvfjIU2HL6aBWWa
 80DvXWa413ljHqGpr7fWv70DU21Th970JhFR5S5S+m2NaNoNvqkQ0GaYVH0sMoeXbfa7g5YBXFl
 Mlpy8alV196F+0j+QyFmf8qJ2Y+QEkygpuOQKtF2vPD9H7p3QxrVWmpV
X-Received: by 2002:a05:6000:430a:b0:482:e658:bb8e with SMTP id
 ffacd0b85a97d-482e658bdf2mr4186274f8f.12.1787749774580; 
 Wed, 26 Aug 2026 06:09:34 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:34 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:31 +0200
Subject: [PATCH v2 04/14] video: mediatek: add mutex component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-4-68ebb1bf17df@baylibre.com>
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

The display mutex synchronizes the components of the video pipeline
on some MediaTek SoCs, such as the MT8188. Only the modules of the
DPI1 pipeline are attached to mutex1; the module bit indices follow
the Linux mtk-mutex driver (MT8188_MUTEX_MOD_DISP1_*).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_mutex.c | 63 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_mutex.h | 14 ++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
new file mode 100644
index 00000000000..8619d9491a2
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek Video Disp Mutex Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_mutex.h"
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
diff --git a/drivers/video/mediatek/mtk_disp_mutex.h b/drivers/video/mediatek/mtk_disp_mutex.h
new file mode 100644
index 00000000000..cbf8a9f0537
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MUTEX_H
+#define _MTK_DISP_MUTEX_H
+
+struct udevice;
+
+void mtk_disp_mutex_config(struct udevice *dev);
+
+#endif

-- 
2.54.0

