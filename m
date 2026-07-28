Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5650DC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73C126087B;
	Tue, 28 Jul 2026 12:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YjZL4Vop69Zk; Tue, 28 Jul 2026 12:29:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAA9F60856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241777;
	bh=qXc7b1SRW3wdgbfYoWWVYHuWratPC0PtFxqtl3M+SSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lrOX/eooEk9g4GHgGzraEZqRKcwzXiV3RA8JSx3qya4PjZzBerwG0KeTPpAm56Lcg
	 PJRi2WaSZUiPcN1hMLj7KzJc7xqQqJCDm4Pxwx0Q7/kz+/SYT6BWwZsm+T2tG27nnX
	 SlWQsU50tOgrF0DTlKlKLUsw+8C9gpYOvUU+fLcz8ifQ8aztf5ClO+jtxZoPeFy+uM
	 Tnpqom536aqkFWxHs2FpQxaZ5HNbTUnoZevUu/NJi9DCUHb/MWd/eLwWQiTvrokWup
	 oN2VvNOJtLm9iMfYqymJQ/B0emH6rLYn6tr/uHiPThXMWtLhb2HOPwiVSznjocWVCC
	 F6nB1j/ykZl8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAA9F60856;
	Tue, 28 Jul 2026 12:29:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AED42E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 110A8400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zl_KTG0M0ptn for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0061D4006B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0061D4006B
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0061D4006B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:32 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso2283187f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241771; x=1785846571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qXc7b1SRW3wdgbfYoWWVYHuWratPC0PtFxqtl3M+SSU=;
 b=GU0DKzd6YNnQMVn367fLi0EeByRoRNFWlSMHX3noAFM7eIg5hYpvbhCvZ3a3t5hQ6I
 fTpTGrTrk6J+/iOFbk57vz3e03/O42iPse5O/HP+9UVQhY9SBRT2FYetfg8cXInlhDxJ
 lfqOMGQp/Zt/LK35uvUDyWHPkJaw9tz8NMuaq1muwVAvS3usR0qpsThCnHFMW27GFJPS
 G42CgfX//xeZXAGhGiHO/+91Qh63ZJMtgbLgGBb7Wae5iLM/0/9P1Y2GadbnRtTd/GKC
 R9Kta5C9mm9dEpIw7KC2UCycN6mKrDE9MA/apTX8VQgrBJNWp3+vJXnIbIcjdRy+Z5CH
 /Uow==
X-Gm-Message-State: AOJu0YzYhbChYh/uwOX7oYsb8x/IjyZ4490qLy4tTn+/5qYgoaiUqqy3
 5lVSNO6071oPc4WEquGAf0mn1uuNofWsF1ILpaO+LSaQ9c8ZT0mz4ni7QOBwznrmtpc=
X-Gm-Gg: AR+sD13nL8eWb+3oeflX5/ngRk974PP0ZM785XhafbmL3trTQ4UZfr2teCDy8V46fFL
 hnAWEeZMnCaSWPLxMmxZ+U4vRi/qckUpZNYSPixmpFvEwgnQpsBAztzX7M6HCo2cEEDgOoxR2kF
 I2avzFwmiXI/XXgcOd78hFgfY/mecC1uUEx84fDkwSnQNAzawxNi9cYx3m3E3aOMU61Vy959nVn
 +HRyCHqXzQrikmARAjWKXCfHoxc74LM9jZtVJg7vIRNylQhX33W5KZ000+ioZS99u7MUdMRRXz2
 p0xv/2tKMeMkoCltXPo9Gr3if/yzS6zPsBEc10CajNh1U85N3KnkR3wuM4aGClFvmJ+wRxeO+Tj
 46wjvo3Wj6WsGmgOHTb32v+WG1XdlOdGUeIWJSEhplwUkYJwiDcx1ijIVggrWTg3kstabJsXKqi
 xyrIzV4LnvPgHJgYhHALfneewto6LPEug1isHgfolX46bQ00/jYUcnsus/3BL82W9JR7PBJkTzS
 yaKaqJJYB1M/f4ILVhP3v/K1avrE6k6RoO6LduuXE+3y43nDcLNym+V3rYbEU4=
X-Received: by 2002:a5d:5f86:0:b0:47f:8866:bd6a with SMTP id
 ffacd0b85a97d-47fb1e92808mr2926934f8f.19.1785241770442; 
 Tue, 28 Jul 2026 05:29:30 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:30 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:33 +0200
Subject: [PATCH 01/13] video: mediatek: add display pipeline component helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-1-ac54bd75f960@baylibre.com>
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
 d=baylibre.com; s=google; t=1785241771; x=1785846571;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qXc7b1SRW3wdgbfYoWWVYHuWratPC0PtFxqtl3M+SSU=;
 b=nryfJpXzrKeF50GgEl2+hKD6OnxBpD8/UOfah/oINm+a7FQoo8ZkRLQ+GyTzIde9E5
 RCyPEnhSH11INyYWybsMHQ5lRumZsRcE4PSQWOZ9jKWSzbADmnjJ6mN03ZKy5N+V713d
 59/o4ysa9DoVbfbLJ+T/tyUBR4XSbyaXe08qIQQwecmrzzdSF3iYXaQ8e/ctsBeWccqx
 FP2iBpxuuZ25ZNAOZL/RXwnL+vnyGtPvnqpgxFBEJvM6Y5labdT4fQHzZCjrXnbPfW54
 AohFtS/ffy6j7c+pwisuoGR8peLyrRyupdcmJ4m8171oK9TfRWCXA9xNKXgV77jDeYXL
 nQAw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nryfJpXz
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

Most of the simple display pipeline components share the same probe
sequence: remap the register window and enable a bulk of clocks. Add
the mtk_disp_comp helpers holding this boilerplate so each component
driver only has to provide its own component-specific programming.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c | 68 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_comp.h | 30 +++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
new file mode 100644
index 00000000000..7d53fe261f8
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek display pipeline component helpers
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+
+#include "mtk_disp_comp.h"
+
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+
+	writel(val, priv->base + offset);
+}
+
+int mtk_disp_comp_enable(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int mtk_disp_comp_disable(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_disable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to disable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int mtk_disp_comp_probe(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/video/mediatek/mtk_disp_comp.h b/drivers/video/mediatek/mtk_disp_comp.h
new file mode 100644
index 00000000000..dafbf5f3ba9
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * MediaTek display pipeline component helpers
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_COMP_H
+#define _MTK_DISP_COMP_H
+
+#include <clk.h>
+
+struct udevice;
+
+/*
+ * Common state shared by all the simple display pipeline components:
+ * a register window and a bulk of clocks.
+ */
+struct mtk_disp_comp_priv {
+	void __iomem *base;
+	struct clk_bulk clk_bulk;
+};
+
+int mtk_disp_comp_probe(struct udevice *dev);
+int mtk_disp_comp_enable(struct udevice *dev);
+int mtk_disp_comp_disable(struct udevice *dev);
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val);
+
+#endif /* _MTK_DISP_COMP_H */

-- 
2.54.0

