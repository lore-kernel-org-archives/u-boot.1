Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268F5C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B938C405CC;
	Wed, 26 Aug 2026 13:09:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RwCTcJTDBl1U; Wed, 26 Aug 2026 13:09:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749776;
	bh=CeNii/h8x96DAcu+8yRjbxWVbuZsbfyVZa64PDS6CQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p+M2EpWhs/+OLASs8eQY1nTll1Q5unNDcEnGfH3+4swHmSd3m0bEbFv2Xg/AgqawB
	 Vbcco8F1shJqO5LelzlZ2dSvuQ2kEJAMzDL3PpPV/OIwF2ZGJYnulV7TO6z/hPKZmD
	 0+fI9JvwY3g8LYQbYYKwMADATNOts59lbFyYlIe//yQWDlKrvOBJlSOi4f5xoJdcej
	 qGDG6xRPG6/k1oHv9BqQj9I7FsCKm9OdWa+/o/vgEBu+nQBqBSfOPKPqBkXJTb2uS9
	 UR2QsWdYQE3xrNLmwtTjKd6yildW6MxiI41ea3hka/Y26sbmmwHXtoR2q6kGxC5hDG
	 bDJ7JIlG2zMAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CCD4405FB;
	Wed, 26 Aug 2026 13:09:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA4DF472
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0FC040653
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XcMFDGhS5m4n for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WAToGFge
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D65CE405CC
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:32 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-499cb997b8fso5283235e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749770; x=1788354570;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CeNii/h8x96DAcu+8yRjbxWVbuZsbfyVZa64PDS6CQI=;
 b=WAToGFgervUEhu4MdWlxsLopjJ2e+4kXkl43cj1yRimTizIaWRT7D0xGqadBm60TGl
 yFxP2owpc7KjwLlyhy/nNdEmSE7yNhWTqTSRg9mLyixNcLNHRDlY+PRglXZEvZ5RlEDt
 Zbn2sU+vqPnxw6Ua9Xl9ZwjX5vc2IuckitAPbRDVaIWRaobitdcINRTenVaIaYyCvStJ
 q+vXIQ8H+Qbhsvv2ccOzhMieZAYgdHqoVIXLnQriQlc91Qo6t63q88iYRBMgpgByHMoy
 ZfMCEFTy2+CK7MQrVzpJF+P9VZq9/pxNzmlEbJFCOFauFUANr5cS/VHKTf5xpYEAX1/5
 WENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749770; x=1788354570;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CeNii/h8x96DAcu+8yRjbxWVbuZsbfyVZa64PDS6CQI=;
 b=GW7Luu/h8cdw3zBuJXokwR3LwP94x8/hY+OFRybyIkioDfIqUypBv/BLHjiixyXbsW
 8cfmolCDE5FvUmQSTkEghwMyI5uECBQRN9uBVR0JgiB5LJFf/mb/lpkcnpYl3KldL+Cu
 fI6bwHIqNNLJTWihjaWDlF1Aj50DUpchfclb1FjyVl3q7+J+WjH5+yADflh0TEYxKRnK
 ejp//Z/Qsp9d7i1bDEA+4mqdTZC7TcqSGD7EAFQGRgbmwNDzvWJDEtS6XYhaew9k6jT8
 fKWjqcGbtyqMATAXWe0T1Wb5S3n1AMMkXlcvsFNKYrWhKrvY6nyaEmTWDhpP1rlukggw
 u6Mg==
X-Gm-Message-State: AFuF++mD27e+nN6UCCFt4JSv5IyN0XDWA4D2Q96h/dq+iTIHywAE7U7/
 LYFdV9uj6aFNcqtwVTBxkv6gmrI5nky62nkqMmW4qU7Rk0hiUnQazS+2GcHuKVQ6w1c=
X-Gm-Gg: AR+sD13A9imydg295WKhVqxxRKYMFtk+y4A7DcjbJudVw7gOwoweh+fPjATe7wnEc9P
 4en1XZ2T+gUrxd++RsF69f28f4jZi97FfSvamPs5Hty0IUN8dc+9KcD65ITqJiHay7fzr4mTSnf
 eXgpnGXLTGjhttsurky+3Kwt0jt8i+QA6DmGkcw+w4drvTVx5BjzruKtOy+TLe/RfiFStFXtXS5
 Q/o0i0zf+2R1GJv+jfPc2QmtZLtoiSc+zQHqc2SI8I7y4xhn4rp7/yPLIh0MpFx2WDzOY3SiqFl
 LIYmapR0oYOh7Vp9idbTBJ6SovkqEpq0Uyl6U8gXBYL+x+ea6bLjqI5Y1vnHSNL0XqeVKtUCanv
 l9XzVyslq/5nOM7+M1NMdBEc2iit+CWSr0m17Y13isR6H55/o1/MNpjBB6aKqnqWC+K+qW4zwkN
 wbdMKs+Qgnb6T0e1dXNuYU1CT81021kPjQpwAL5N2MqFVXSA0Fe9W1N5v78jdV/Jr2hw/L+VIy9
 8P85E5Y1SOWqDHFI9Pze8xK1OgB64I/ECcOpC5j9j4EMywS440fzaCYxw1IZWw6Z3D7uUq78mpw
 xDDNezbvGQfZa/ItqOXl/zIdZKhV/by4g2Wr0EfjKbQHFA==
X-Received: by 2002:a05:600c:4e4d:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-499dc7081f2mr61651815e9.7.1787749770234; 
 Wed, 26 Aug 2026 06:09:30 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:29 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:28 +0200
Subject: [PATCH v2 01/14] video: mediatek: add display pipeline component
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-1-68ebb1bf17df@baylibre.com>
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
index 00000000000..3e76eae7f02
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
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
index 00000000000..63d740b9212
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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

