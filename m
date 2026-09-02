Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543BEC624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E162881003;
	Wed,  2 Sep 2026 14:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ImdX00c5yWEP; Wed,  2 Sep 2026 14:16:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358593;
	bh=vPrPp/hOGE/dzlqVz9hrInXDQxvBE14zsaM8gFk/BNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GyqchZnS3WnNpFBnXxYYPq5/dD7Y4DxjW6+Tnz+8gC7a7Vjjk1RaTvXOtrVv012RW
	 aDRqhR6CqeBeLG8TDTZf7omSm6PsK9ZrjCVFciieEno9fKxQlz65jqNmT+dxTczLo+
	 6sJdnF3PlL5b3SxeR9kqJ7nOVCBZYOzX8yRM1mD5k9rceGSV8cMGsMhBpv4AOyUBI5
	 5zDbapF81NF0GRKoZNtFb02I6JVBdqKnZJcN1/V0iuvEvYI/aKbCxpIfv6So37Bcs1
	 qZSJ6ElWOjLyjks5PsanNOTWx0k00IShcDFSACz5fmtchlAuKsJzmDVS8KT2yujTP5
	 J86HLqENLWeyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48B8480F62;
	Wed,  2 Sep 2026 14:16:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 71F70363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3398C80EFB
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1o0GF110dK39 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AjzPlNTK
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16F0480EF2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:24 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b0dbfbf7bso7732775e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358582; x=1788963382;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vPrPp/hOGE/dzlqVz9hrInXDQxvBE14zsaM8gFk/BNA=;
 b=AjzPlNTKDXZeh9HRCgaJo462HMIHs3HBmlKXj1Dix66d1hjUWhwWyjjiPQ7OskyY/U
 43/naVkwzH/S2Qxsx5PIazbwxeF71q+E9DZK9dQknIWPv1F3Vg+SboNnDRLvtyyFs3yD
 nSLvojpnS/0gbeaq+mzG/wu/F57TOP1pPBNFSPQXTLS3ZrUIRItywnwFoju7yD6joMvL
 dU1StozLDNTdaftARBqpGGDzGEbg7BiPhIv8uGkn4hsSr9fdy8ihF+gIuMq7CmdgTStI
 /Lt0tCAsryhcfez8EH7zJdSKQuL+tTzIAUrxXkmjYnbYYua88Gcy4emUSJR8fA8+RgcO
 ba6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358582; x=1788963382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vPrPp/hOGE/dzlqVz9hrInXDQxvBE14zsaM8gFk/BNA=;
 b=ZhhP+jVi7VNMizFe+Yn+YUb04ah06N7Jo/OcxcecNGv/zLFQf7Dm3QVgYZllZqoc+W
 U8y8dIdnyA97stbWpLWvzmaPcz5/MJyox7bAMegJqiwrCwzLYbJYipU5JCPOVCaXnoUx
 XukMj53buBFFhHezqXdWaq8uvV5Dz+ZrxtpZj5l8DsYC1Asn5H3oXriJtPqEGAiu7LEZ
 Q8nQvKX7d/aiy/Cy4sJE2rY1JZ6NwWMYDB+lkjvmit+yHyT4csZucD9dkbu8qY5zDA4Z
 TCbGh7yMwf/P6NWaBrq7ESGQD4ULwji4uDWEcn77nYfwzR0mAcCtnOO8R/M41kqZ5rGe
 XzeQ==
X-Gm-Message-State: AFuF++lykAfew5BkAexET2gDsubm7nZOPd1HBeIWOMXjXj5mdjvTxiDX
 w7xXzypwin6Wrkm2zAwNhEIJCRQnNPSBw5ljLwdMrCWPPv0vF7kkJa/S2aBhrKOlqWU=
X-Gm-Gg: AR+sD12Bi67/OmXk49e7gqEW0VJHZ2EH19l/QnKGbNV9LQthr37WoWC9KUvZOwLTTDI
 tlbaRIyHI0XtTuC/v2IGsqpkK5TuoDRSDoae2fuNuLEjnUc1PmsT7l5iw0SrMYbiva5KZE3rWHm
 2EngFhGUgCRIuHfLJJgCc+lx5pxojAs6SVk8ST1d5L6FYJa3P2QLIw3wl1earCxC+zt6M8kOTe7
 W+N02LoikZl8X0UfWDhImmI1GjlFpmE35B3krxWP0rv1LOneHpsI+880DKMEGGMCtjdJ+OMIKfi
 6QI0u8uH72bU161NmMsDtbAyyqL4sibSv7lL1rglNzO7WzW/FzEvQBjTqK1axtVwxIezK7E3A9N
 cVXKzes5veIAvA3tpMpQiDeTSPYFjQtoGfqwLzzurugQVNu+K97pq5QP7J5KsLSfOn19CDLaXna
 kqfv4p4GzH89BzBWOVLDwQ9i+C8tbXAPsDXENOW9v6GluR1MeV+XakBI03Vde1nsDoSsAt4P18J
 SXbcVkHy+oJJm2p+7mUdCeXbgttCAWNlZsiasOeHgua95NXDcYnHYj1ZYdRpHZQ42ZLr9wpNWi1
 H2WdTLhTDcNBT7LR6cj0gCs+smNEmYOcjhdb+7I9FYE+
X-Received: by 2002:a05:600c:4715:b0:49b:9161:db26 with SMTP id
 5b1f17b1804b1-49ce5843bc0mr89487015e9.14.1788358582133; 
 Wed, 02 Sep 2026 07:16:22 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:21 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:15:54 +0200
Subject: [PATCH v4 04/14] video: mediatek: add mutex component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-4-7c3b4f068a56@baylibre.com>
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

