Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE43FC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 760B86076A;
	Wed, 26 Aug 2026 13:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAD0yJicj1HT; Wed, 26 Aug 2026 13:09:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749782;
	bh=SsZgI7+JWP7j6LkcIfyieQfBfFCX2Ch/pHC7rk14uGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=npMNyoMgdRegT3Xs+pdqgx+sUmej7WgWRHcyJ2Mc+w4dlt2oybV6CcbdTXPN58Rye
	 9aGrudjUygRYp0igrwQgdkc7sJ5udX7Yfj8rwsJCi9+MtCzguLzCkWpIUQgbshGJqX
	 Pq3L5/Tqqz7vKistQ5B0Lj6abcPv+ZmA+JjqCxlFPM8fVXtUMLQ5MdKpBFsHrbG3N4
	 os+y3wBFOlq8RaUTJN8qlJDEwLzW5TANbox3rFYS5SFAp82er3Qcwf9MVVvsw1lxM5
	 CTlJDlYEK8JV8cU44VQPdJOtR3MDTIhN3fQdI0/7CmRdzU7sfRCiYYeZGwwKC1Rmbo
	 gHonXW3ZsJNLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ECC360758;
	Wed, 26 Aug 2026 13:09:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14C2C3C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 037C340653
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHNhgj1R46PO for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LqWzoloC
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7580840665
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:35 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f84023916so746914f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749773; x=1788354573;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SsZgI7+JWP7j6LkcIfyieQfBfFCX2Ch/pHC7rk14uGs=;
 b=LqWzoloCjPiwvTMjyHg5JcQU9EyAw9k2XkhdwHk58E9sHaOQ7nlCkdjE/x4kBFHjF+
 z9e3Mq+w3vZSbb+If+zmyjZ9ZtDKjvbaROvFz7qMwUvFPFJPtDZCbAVprGDBguhX8kkX
 UYjSXLNeIuuBuMm8f1/CGKiuYkCSq4iLDNt2v2lUNlKqnGWUxEzbJeRkzVgAbjM7l012
 hYhRqyoMd+uY+PeR1qd2+f+4OY0c/Fhii44Kfz0vQ1JeGNpnaStlD76hc1xUMNvAHL4E
 3vRu69vzCoj+z4e/mAOtkwcNqtXur+sAiRsQSBDoywZaHbtehYvF1BaiVYr01CfeiLSN
 U8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749773; x=1788354573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SsZgI7+JWP7j6LkcIfyieQfBfFCX2Ch/pHC7rk14uGs=;
 b=Bfp7+n+vbxD4LNvzUJ5dvKBlN3FNEmIDoHn8gkwTs6E9wqzHDcV+yeXZ2JtfLv9SV8
 UTKWhFwrqC5U80D9v4rtQ8spHrgwCH2gmdWPdF25fIGLcNF61SZUg3BQ9xutQqYNGp8R
 Fug/NFWseHZGH8e+1mvQVL2ooU3KPZKnr8ejmbHmR+1wtEOIdtczLjelhUDF8c0bqpoG
 bir9LSciPhYBz8bde6D2mfXvp6GyZrIGp/QAUUkGfi5SfwZFQAbH2X81nvVyCY7f019H
 xIEV2yUqHiVS6AkiIjGPTbEEbSNzgpCIU8PRgCxcfSuQZyyTN9wy+m48vH8/D6iZpuRY
 +mWA==
X-Gm-Message-State: AFuF++kSSgTL6SCyApY8EFI/s/8ArQT9RKXkJ9Wpwk+1kZ4+mP2AwtOL
 NbC8SoEBcoI7b6ekOqhk4x8hcHTm9fWbeJvTtEOzjHdZe0lLN54n1c0Jxq+v2rzyHtY=
X-Gm-Gg: AR+sD13/WB7SdoxhS1ThaSYfJ+FxmRUobkad/yb9+LyqIfLyL6OVd3NycL0Dp39FOba
 jouzmE98r0+S4SlxCrqGPt02APTwEy5ohQZWnFy6AtCzrUhVQrzp1TesW4xdSceNli6jgT/RywI
 yCGtvMTT3JSmwfkQf3dFJnOX2RcIes78AbmiB52Po9oGcROpnc/tDzB/yGtInM5wjGWGi8hfMNX
 7g1xntRN/1C8zzPi6oV3KijQl+2/6uhtqqlax3OaXcR8EZ6tt3+DrUd/5ulOcpVCdS1YcU4b3Ey
 v4TBjtaQ5cBm+e49xGic8Gl+l5ZzYr0JQrwPaAtdu1Fzvb8p/x7Ofk1dzHNLrhmAB5ZZ1CFkQ0v
 FWB8EJnn28M0zCQp6kJDxu7VhioWfFWrofQcdxMDIIbQj32I0vhUHIz1wLnfiyxA9yMRFt0xmHH
 Is4tinpzc4JsvLr+GUPbGomDsn8bPzMrJ9iZJGJtDFajU1DA1o1U5L1fWsDCNUcGHKlMs3XtxjL
 0OpbXsL2Q0iZVA0t7rREY8bEUF04bEiSJ4mciE3rYFPCq57TnlXG6/RQZYhM+YreGd2HMiqGc37
 Cdg6KZGUspRo/COf0+LXMJmLcuXR2Lk1moKCW7WQAk2RIQ==
X-Received: by 2002:a05:6000:46c2:b0:482:abaa:fbc8 with SMTP id
 ffacd0b85a97d-482e26b61cbmr4796876f8f.2.1787749773093; 
 Wed, 26 Aug 2026 06:09:33 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:30 +0200
Subject: [PATCH v2 03/14] video: mediatek: add merge component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-3-68ebb1bf17df@baylibre.com>
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

The merge block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. It combines two half-width
inputs into one output.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_merge.c | 106 ++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_merge.h |  19 ++++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_merge.c b/drivers/video/mediatek/mtk_disp_merge.c
new file mode 100644
index 00000000000..185e75231fc
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
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
diff --git a/drivers/video/mediatek/mtk_disp_merge.h b/drivers/video/mediatek/mtk_disp_merge.h
new file mode 100644
index 00000000000..cac3982c74e
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
2.54.0

