Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA597C624D4
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AD6380D92;
	Tue,  1 Sep 2026 14:38:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 35BLmya97J3B; Tue,  1 Sep 2026 14:38:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273532;
	bh=A3CCZhmC6ul9Johiq9Y4kJEC4x78uyGlzeDkVBgJG7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WoZ0t4YzSZScVjm5nnnKx/s+IWv/zM2o89i04kYXA9VQw3d18FhhPZqMOvuRU23zh
	 D2YMvPp/aNdVXRGuLsovspautNXRIL3IqrlMAWXfEudm4rmMpqhgzCaNGBAbIIO56w
	 cLVh/5FrfTku9Nldf91Z1HCl8KEYzYCcRQSR4WM8V6XzpsZGR2RSWpCzW5QRYf6UUA
	 FzNSkpSXwurI5UL38W9jbxkLs/8ef0umNEpUmsJlEcIPd/lZZISmG41fFzeh4gXjJC
	 AT5j0ivR7LTBaJqnnpYE//XXxS60CrA5IoqjYKzsk1g/Epa0yzRshY7nze/xlxV56L
	 Y0dHhLs4LTnqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CC1380D17;
	Tue,  1 Sep 2026 14:38:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6649363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B84CF406D8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z-uLqslGoQcQ for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fgqdrxC/
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CFA4406D4
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:49 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso7441785e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273527; x=1788878327;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A3CCZhmC6ul9Johiq9Y4kJEC4x78uyGlzeDkVBgJG7w=;
 b=fgqdrxC/fvxNfVi9a/rMN4kX4OXnMrWwSqtwwBL9sg6V2/P7XTkfm/EHQUU70f3uWM
 eKXwhn/98d59L9+kU7ozGAbfQqA3fMSuLjshy9FJIzSK/dXaDOpzrQCYSGy775bPDdaN
 Ny8mdMH1j5gEwmJSBe1yUVaE3v3gpOjdub0Os0s3XC76bjN+jSeyDr7HzsD7Y7sONWdp
 iZLl5V/vlGtjF1h3dvDLCL79i/sDnoSda4t7STNz/cH4+YoTb0UeWE5JGvJualNyZfFJ
 oDj0jzYG/w518Rxny+SvTHuMeyoydsGDtbGq1LszlMZnNNIDSuz+1maWUV69xBRGtPJP
 R97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273527; x=1788878327;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A3CCZhmC6ul9Johiq9Y4kJEC4x78uyGlzeDkVBgJG7w=;
 b=swz1CJ/VfNR2g9dXJHsmp8rzqlQuMNMtIMoRNVLDljMC8d6LJUvoVvSiyQ8QhKF/t6
 dqzNBtHOo8pI6ZkhYHlL4O/09GXhku7edT7D4/bNF4oA00E6Sn5lF8J+bT+kfet6nb67
 kx1EXAorY5AkAkl1pvVWzYYWLb7h3ghTmHnT3vCMG3qOj+U8m22i2H7K/9nXm8WZWgBL
 hkOAEK0qZi79WJ7wufGUGY9OTxlcgG7F6T/oqNfrTwHHi7q1Wtez9HUoAwS+S4NhPFlu
 9f2jtZDjRxaYKbNykHZ8c9JBXUECxxguY1Ps/O8OX5CV2oHiH98SN9QT3XZj2d5bOUWY
 p6Iw==
X-Gm-Message-State: AFuF++lRKj+6xyOHWb+JMXnx5uCDLbQQgcTrlG3UF71uYnAV9W6Nf+5L
 j2emxPJxUFokroiMziWS5ivMYKikn/gjRtkpcEyR5ltYMDLpjcvIXDPYTpfuCuXU/4Q=
X-Gm-Gg: AR+sD13PCI43hbNlrxYeEHJxF6PmiHid8zS2iouKM6FmJDlBc2IReW6mN9nxRgAX4bc
 8Cxz3U6uHkNDq26e5N0qsGsRTtPCl+q3xF5ziSAfWeFK+9zRrbrItHYOK2+g5r65y+ZZie/9Wfy
 tYBuBFcFsCXg3CpaMMwGqx5jJo168AqGuN/Fs1+ci4XuJSf7cv66i2GdkcBWvM/3vzTmd6BGGfg
 Tq3onw1cFWNe0Nn5jF7ari1tAshKt+xpjixQGQUHacCwKZAtVS1bYR99CBPIVN/QM98KnMw6edB
 eg+nNlrUPaVp7MZrhieOH087NB97CO62hPsgge8zWYATpuWRlUIce9EpqccbPYwnH421ZKODA9J
 p5PrwsA1Ce5ZIAsC97ahICXDkIqy7C+vs8Kq5PoE1eIet1f6sP7OvK6VlLTAp1KDUP7hrIbwqfB
 Amm4CKkN/iR1ZpQekWaSINPpevCPov5nE4B5veL9NcITmrfpMnt1xnR/hevDAPxTwMLUnmaK46n
 na/24gEVl4wODRGiEE7pkTarBtWn22ogKre1yyPk4OAWq/cBffisaUJdoKIqGbclOOFsNUzzzUc
 qK5gqO+bPRMPNVoVYOUiR255UGzK0vvVcgjg4f1phwSdpIQuAArttLs=
X-Received: by 2002:a05:600c:4445:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49b91c44fbfmr480853655e9.9.1788273527099; 
 Tue, 01 Sep 2026 07:38:47 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:46 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:47 +0200
Subject: [PATCH v3 01/14] video: mediatek: add display pipeline component
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-1-38194a531b9f@baylibre.com>
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

Most of the simple display pipeline components share the same probe and
enable sequence: remap the register window and enable a bulk of clocks.
Add the mtk_disp_comp helpers holding this boilerplate so each component
driver only has to provide its own component-specific programming.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c | 78 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_comp.h | 32 ++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
new file mode 100644
index 00000000000..07ba29e3393
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek display pipeline component helpers
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
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
+	/* ungate the feeding SMI larb first, if any */
+	if (priv->larb) {
+		ret = mtk_disp_comp_enable(priv->larb);
+		if (ret)
+			return ret;
+	}
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		if (priv->larb)
+			mtk_disp_comp_disable(priv->larb);
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
+	if (ret)
+		dev_err(dev, "failed to disable clocks: %d\n", ret);
+
+	if (priv->larb)
+		mtk_disp_comp_disable(priv->larb);
+
+	return ret;
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
index 00000000000..9012dda3918
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek display pipeline component helpers
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
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
+ * a register window and a bulk of clocks. @larb is an optional SMI larb
+ * enabled and disabled together with the component (used by the RDMAs).
+ */
+struct mtk_disp_comp_priv {
+	void __iomem *base;
+	struct clk_bulk clk_bulk;
+	struct udevice *larb;
+};
+
+int mtk_disp_comp_probe(struct udevice *dev);
+int mtk_disp_comp_enable(struct udevice *dev);
+int mtk_disp_comp_disable(struct udevice *dev);
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val);
+
+#endif /* _MTK_DISP_COMP_H */

-- 
2.55.0

