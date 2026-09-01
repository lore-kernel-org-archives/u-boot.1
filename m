Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18FDC624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C4E360766;
	Tue,  1 Sep 2026 14:38:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JV27Prkm2bmo; Tue,  1 Sep 2026 14:38:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273537;
	bh=vPrPp/hOGE/dzlqVz9hrInXDQxvBE14zsaM8gFk/BNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QvzZJpIfaE3/VS5VmtKAz585pWzwKHmrGVzCDjXEqfNHQWu2YnKfDoqi/lPkvCgJw
	 GrmfxQJmuSWYQUdddpIR2AzCQujCktyjV9WmEORtbp1BdTonrEPQ9puY4yL6uW7eJv
	 tNNTAsYaipTBugLkA7Tjc0xcJPY3Q1SViTip3UBEmYP2rfTO25Cj+noaDbdoDRzfC3
	 VkVs4B4+324VDB0qO1ROaY9bTwjhfXEDH3pZEig5245oeFckq+GjJ1TNF3xnsyjbIe
	 hY3ngUNzYqVtOBF+mq9ngNyH80DE456wng+jX8kvUDvMheVeWbA+WYQoxAoXXUOg5F
	 FCfUnqxSIUhNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 956C6606FF;
	Tue,  1 Sep 2026 14:38:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0D00279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86F93401CE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8B-eZUlI845q for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ug0U5AOa
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8618E401CA
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:51 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-482e067e908so3637599f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273530; x=1788878330;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vPrPp/hOGE/dzlqVz9hrInXDQxvBE14zsaM8gFk/BNA=;
 b=Ug0U5AOa1tUzspcl9aDggwH4iWxjJzAkvT8InBXqdxB7sXCEifVPOoldlkrDM/TEOs
 rE/bAoU3sd6ixYr6BStTduXJ+yJ0wyxlKqT6VCdesUM+agpneSYbgrdOdc9IurUW30eT
 kgXkgrqlrczrUOHUldF8OInXmfSlRetnJToi8jTwZH8QmDtYdBfcKvwTHNbubpM5TWU3
 3WR0RKkx8YQ4B/ZAKzh+iLj1L4jdLepske9Y0HQH9sIo3m0A4j7ua3jK7h9GAejnHrAG
 92up1t7pdKLZZgnnT6yCIkQZouCdoDFa9aCXkHM7+lhtQI73BGTd5jKRi6aT9fjnYvXz
 65ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273530; x=1788878330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vPrPp/hOGE/dzlqVz9hrInXDQxvBE14zsaM8gFk/BNA=;
 b=L8AmZbyWYzbDBkQzytuERVVjRGEZwN1Z+pnz1OrVoua+gjfG2UeV/Ak3r7+drVmMXX
 z88o9CZ3Xufw6vHv1DZDBXbTMDLUemW0bS6O5XPgSJnpJ/jIXI+iAtLzZqs/N98UQVva
 v4XpDf/xXgIPrqIZHXNXbuP6WESDc0e5gMrxKed22ojJolJrczSTq6phpQ6c3Sv2qxFc
 1eRhPW7nlYGrUZx/lUzVjW940TfXk6IEsUVuBYJjlrEDubX7dAv23SCzeUXj3b4KIVBq
 NHyqNuPW6d624AcsA6/RQbC0KAqTuu+VbQk2cg8YOtDQ0+YskreQ9QjCFxS3vZWic/CQ
 iNaw==
X-Gm-Message-State: AFuF++mtX3lzmHTwG0YX2Yycwz6qoMANmPkOFQcmB3E3fN7C3dWTlAdz
 gEhQgF5eieECAU1bfxw8ZVrvNo9Xee9kRm9q8tU/7TWJgwdObCxOnUlzNRy77Bl2L+U=
X-Gm-Gg: AR+sD12HjLAZPzlTTiJGIjybDa5tWwYyGgyKKMckwKT+sAlppouDzT0dF5GhNnhhpxa
 6MRTfAXbHxuwlMBBuQiKMx7Mb0sZiLYEggeWY4DPC71eAcIHsLy5OJuwZY3tvdyJ/46JZ1L1JXf
 m+lHYiOVhuOdxeub4frjr3oQy5UP1F8JoxesNp4LxdKnMCjwj6UvNfmhmDr2pJPtd/eGsc2Ncod
 WhbOE+67x9AuaLTmFEps31vAsFlM8NjjvglCMq8nOhsPlx7tIx+mAc99EmdsYoV8T8+nq9mbG8B
 2m8hfUDefCVfwwDH/WnGTTA651TPYfZvI48QPZqMa+kbbeUzCreE1EBRaE5+CuWIU3gtFvyS7Nr
 x9eVR6QH21/kIIJMjs79AFH/Mf6rxIkE0iKi96a/y1leMmhIaD3ws8XoT67R+jpnCshlz6C8uA4
 S0Aw90vORH1oMeBnn65jhu9KwzLlW3rwU6GDKdWsDwyciSf7ZUvthNcVtPmZBO98Lmr9Z1TdjVi
 H6WgjRhVvP+g46rQzBSdCTN9MwAzTVfPlVxjGRLWOY1SHhwWcLraIOsyyL6pTsC60RStuix+RvC
 vVYG74DGlNc/PCK/wP+d8su4SnvxrPd3HN++dyJBrcaW6kpCKEmBhoE=
X-Received: by 2002:a05:600c:1f8d:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-49b91c17c41mr485732665e9.3.1788273529973; 
 Tue, 01 Sep 2026 07:38:49 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:49 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:50 +0200
Subject: [PATCH v3 04/14] video: mediatek: add mutex component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-4-38194a531b9f@baylibre.com>
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

The display mutex synchronizes the components of the video pipeline
on some MediaTek SoCs, such as the MT8188. Only the modules of the
DPI1 pipeline are attached to mutex1; the module bit indices follow
the Linux mtk-mutex driver (MT8188_MUTEX_MOD_DISP1_*).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_mutex.c | 67 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_mutex.h | 14 +++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
new file mode 100644
index 00000000000..d91d8472836
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+/*
+ * Register layout of one mutex instance @id (as in the Linux mtk-mutex
+ * driver): the block packs the per-mutex registers 0x20 apart. SOF holds
+ * the start/end-of-frame source, MOD0/MOD1 the attached modules 0-31 and
+ * 32-63. The offsets are index-based so a future DSI helper can drive a
+ * different instance/controller.
+ */
+#define DISP_MUTEX_EN(id)	(0x20 + 0x20 * (id))
+#define DISP_MUTEX_SOF(id)	(0x2c + 0x20 * (id))
+#define DISP_MUTEX_MOD0(id)	(0x30 + 0x20 * (id))
+#define DISP_MUTEX_MOD1(id)	(0x34 + 0x20 * (id))
+
+/*
+ * The DPI1 -> HDMI pipeline uses mutex instance 1 of the vdosys1 mutex
+ * controller. Module bit indices are as in the Linux mtk-mutex driver
+ * (MT8188_MUTEX_MOD_DISP1_*).
+ */
+#define MUTEX_HDMI_ID		1
+#define MUTEX_SOF_DPI1		0x5
+#define MUTEX_EOF_DPI1		(MUTEX_SOF_DPI1 << 7)
+#define MUTEX_MOD0_MDP_RDMA4	BIT(4)
+#define MUTEX_MOD0_MDP_RDMA5	BIT(5)
+#define MUTEX_MOD0_PADDING4	BIT(12)
+#define MUTEX_MOD0_PADDING5	BIT(13)
+#define MUTEX_MOD0_VPP_MERGE2	BIT(22)
+#define MUTEX_MOD0_VPP_MERGE4	BIT(24)
+#define MUTEX_MOD0_DISP_MIXER	BIT(30)
+#define MUTEX_MOD1_DPI1		BIT(38 - 32)
+
+void mtk_disp_mutex_config_hdmi(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_HDMI_ID),
+			    MUTEX_EOF_DPI1 | MUTEX_SOF_DPI1);
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_HDMI_ID),
+			    MUTEX_MOD0_MDP_RDMA4 | MUTEX_MOD0_MDP_RDMA5 |
+			    MUTEX_MOD0_PADDING4 | MUTEX_MOD0_PADDING5 |
+			    MUTEX_MOD0_VPP_MERGE2 | MUTEX_MOD0_VPP_MERGE4 |
+			    MUTEX_MOD0_DISP_MIXER);
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD1(MUTEX_HDMI_ID), MUTEX_MOD1_DPI1);
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_HDMI_ID), 0x1);
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
index 00000000000..78163e67df1
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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
+void mtk_disp_mutex_config_hdmi(struct udevice *dev);
+
+#endif

-- 
2.55.0

