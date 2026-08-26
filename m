Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAB1C61DBE
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77FE880C79;
	Wed, 26 Aug 2026 13:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ue9Y5bLwL4V; Wed, 26 Aug 2026 13:09:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749785;
	bh=JXI8mM3vSZeu7+F2jUV5ijIZ0I152XZ+g6EVgugjNo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tpnJvl3NI42wWXNEUspt15Dvq2GDq7GbQmK4ZpdBorHMEeLzJQqS4bchN1lOyZFQE
	 P37hoHWKwKpegGkQMcsfAqHgsb4alwJyiAz59uKqzG+I922qw4DjHT/+uCpJKX9OiF
	 2fmEi1phRzhfg0As3a7oMAJnO+obcgKzsSn/33UjYc1AzVnrjV6qoDQ/tIew2sLmge
	 SEemQrkRsbNDp5IP+JlRHVfw/MqDRZkTM7cpv/2fFuXq4DHks2ChZagdPfUCxgMlIk
	 pefGe0Q+750l0POONxQtqgibkMobLLAgxV6YyGTtRK/r6AAVQcYEqtWcMnZFsuPoI3
	 Tbq2ZkeItAOBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C06880B6B;
	Wed, 26 Aug 2026 13:09:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFA0C3C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98E4940684
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t_8zP8o4jFSb for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bwk5Ehns
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CDAA406BE
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:37 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so405126f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749776; x=1788354576;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JXI8mM3vSZeu7+F2jUV5ijIZ0I152XZ+g6EVgugjNo8=;
 b=bwk5EhnsCbTy/pVbvgi9ouUEOgomOlgqJLT7uWwCJvvm3EBWcv1sZ3FVz6yToaZMDy
 +zf5fhHeecoYyKTk3Si5PTnWy+tPgrZsFUEaX1DqkRhUQ8O9lpZttm3B119T4X7azuXW
 JtwKnJ+nJJHFpsyiurE+CdGbfXs9Dvj9CKUKNpZFrYKHC/yhmOABETQJPVgIe4pkAkpm
 N2MjhXfFcAwuIoeGe4WqaQIiH6x2/jb9NhvWFySwYM4NuCEETLS0/byA7cIXxktrIw+/
 wKQn0FZ2F1bHAeo55NBUYz8f4LDVbxf3eT+HXTg87+mPVSqNiyl6sI+vG+zH4z6rJO86
 CtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749776; x=1788354576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JXI8mM3vSZeu7+F2jUV5ijIZ0I152XZ+g6EVgugjNo8=;
 b=Rj576g5O6cql6uDWNjdR6jfJ88meXYti3Z7e+xTS6f7/DUXSnWfx/Eg7wNwxcrFy4l
 0bddtOe42GSXo4BkO4zzo9t2P57D1PiyPF4UOMTDXErFSTh/Lg198Y6o2u2SVcqxJKgI
 s8SSX4MjVp7zLU1hlO23oXE0zBNesrf5+1WjH0JNeF/zhIzHye366tkXtbbzERe4ZPQM
 gV9iugYNsZublBZr/ete6SAV5ZpHzLcsj+iSdbfnqfgZmJCoZzaNatudZwZvTd/t1XIW
 5N8Wr1SH5faLcYwF1wNHxvo+LU4DMXnXMQuaZM4e+oQ/OEjF1ExY3MMkTlBoWiGShZsW
 hu9g==
X-Gm-Message-State: AFuF++n/wUtlrw1fre0RRwwGmKePzI24P+f7XxSyvcImhPXs3VHt/iut
 aSOsFPGEQaEZQGgdiJcvzJwn//iY9tvGA1cmffcydY2xi11n2he8XMttY6+6BOL0DlA=
X-Gm-Gg: AR+sD11YF+qhD2mjeZm7TxNErRATyR0g2t9NAgLmZRR0WA5x2AlyaYGw1p1oeNYkpKK
 YKikNwaX2z1lBdM0B0meEjmmkYC4NCU7b/D1QnqlYsvpU97BXcMhDBLtggGW6SIQuYrgRfgINDI
 0NuSjAc7r0akNIVVBPsaKmicsJoYrSk3DceDFGxynibiUdYvPXCDFqU0a1Mf/e3jpS8Fzz7g7tq
 C/JSb6JI6NJNGoKP4qfGRAHkCIvz44+Aby8jEXfvb0MGRIp6MrufLn1xgemlROp49EEKoWEVCLf
 01HXqYGEIxSdul72LhBKnTPulga60VU7OdaJkxVvGg/al8DaT417cvid6Tf9d1z8Iao12vUrsGT
 OijRQSiXvIrmBXVrT+zGcXhab2f0dsMDmIXGt3zxpk9UnHkr52wLSb+J5HFA5qKrZqZXRuhII7F
 OCc+L7F2q1PCQFf+Z2XT2uZy0jpaPf/cmVFh5mjWc7j0ZQBDkVr53ZWTFLXO/Nw8b3DaLB6RHUP
 paCtPOJl+JEAdrV6mBqdxcHLqyIBdyMHFLmsmz0zJOdwmQ8D+cd9TgbLfRqoOHtSUiI2niff/x6
 9San8WPhVaeMPUIPFD3pmjFjj49pmrutUxOwI9KAmClzVQ==
X-Received: by 2002:a5d:414b:0:b0:482:b813:8315 with SMTP id
 ffacd0b85a97d-482e26f767cmr5567207f8f.21.1787749775912; 
 Wed, 26 Aug 2026 06:09:35 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:32 +0200
Subject: [PATCH v2 05/14] video: mediatek: add padding component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-5-68ebb1bf17df@baylibre.com>
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

The padding block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. It is configured in bypass
mode.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_padding.c | 37 +++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_padding.h | 16 +++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_padding.c b/drivers/video/mediatek/mtk_disp_padding.c
new file mode 100644
index 00000000000..2f94e55c05b
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#define PADDING_CON		0x0
+#define PADDING_EN		BIT(1)
+#define PADDING_BYPASS		BIT(0)
+
+#define PADDING_PIC_SIZE	0x4
+
+void mtk_disp_padding_config(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, PADDING_CON, PADDING_EN | PADDING_BYPASS);
+	mtk_disp_comp_write(dev, PADDING_PIC_SIZE, 0x0);
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
index 00000000000..42ff177f307
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
2.54.0

