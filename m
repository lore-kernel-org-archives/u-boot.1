Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEDDC61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4BFC4072F;
	Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sHThd7y6oDJP; Tue,  1 Sep 2026 14:38:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273534;
	bh=PNL0Lp04gkvpttoC8BhHvFIA9qr1DH9v6KBKWhl1L9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vbNmvOStHJLr+oTNKbemqrzOCxsYFJUmjbCoZt6Dr+ZKd0TpsYlHpAVAOZGSnws3h
	 0JOQ1hFoxwoW+DdyE0yVloC+FSFtxVDMJ2qruMgP2Nvd7fGaCThZA5Tixy1RLcAGbk
	 3RnO+wlUutokM4dqoV4NXorD+tR3hjFRQmKDc14LgiM9dOS4PTXWhqsFtUvv9lUVcx
	 pjGBwmvIwjhmoKF7WyAOuYjwRYV1POO/osA2CUXoS8krYeFgy9/QbOuFXscSvaT05D
	 MYMazJrt6NJnY264sTPHqaHBdMTcO0iphT0brHUnuALUwCMIv9XduE04fQiy5sHOkp
	 ej87lGDWhlvJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC2BF406D4;
	Tue,  1 Sep 2026 14:38:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5003D265
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4203F406D8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FOLiFyviBVVb for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Vgo63sYX
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 446C4406D4
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:50 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48436251906so2880975f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273529; x=1788878329;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNL0Lp04gkvpttoC8BhHvFIA9qr1DH9v6KBKWhl1L9U=;
 b=Vgo63sYXVDHeyHgyQ2t/uv6o24hmsjwWFzpK6fd2pkdh1v/I01jYH4u+H9i24qlTdp
 JWTFMuNd1Rte5YQ1RYUw2l+KUbMJ72AkUHGwYBs5m/3JLJcd/oCv0HcwE9iSwZQRjTS1
 xCgUIG79/qO/Z0ZDw+s3a5siRovyZkVkE7IzEYa3jY7AwRElp5rETgQYXD43gwj2i+ua
 m1XDnl50QG7eEHAfL5wnS6LCOXVox7zpd4savh46dIQYk4VZ0DNWuEdi9GEmbh4bGj2B
 DC2QqeG/MBxeWYeUJP1r+VFutW+XLdZJT2ZVvqAAWvVNkhMZbr7sR8ycc7jni8GwTv20
 99ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273529; x=1788878329;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PNL0Lp04gkvpttoC8BhHvFIA9qr1DH9v6KBKWhl1L9U=;
 b=MQfj1wELNYWcqXRBZR46fu9nP2v4kpzWE9SFP6SoIoqkUdf3iJvIfiALxEGPw+ottB
 MHq6tSD/9WTZeEuVFlB4TQmizSz1+Vwalh8JU01p16+wr0tyRKDcvqcRPEbHIoPyE7xa
 7udWdS+EkbgvAkHedUuXlGC/269uaw/9914/16LXanMztSdV8JZ1aKNBBmL+p7/ASypz
 G0X/dPuzxdzYgE5YrQvC7528e9VCYn5DuO5tN6T32cyARNaPgO3uLIk7DS6UtTVgH6cN
 1uGvdg3CyEyzk4B3ghgCnlmQlOPEzTJfblV9m1EAlquGVrleiaWreo/czOAEbIz0prZH
 YG+g==
X-Gm-Message-State: AFuF++mXU02wLcL6KLZmh6cjC9WZAGA0da4NWHYsya9+aGw3i6uln8iE
 cE3D5ng6Po06YFxfpff5x42oZOP8c87uyKcCl6DuQ/EGwbLX7Btl/l4htdabj26gGr4=
X-Gm-Gg: AR+sD10kITLF66MP/SYtS6RbTZJ7n8okTQRO8ZIt4ZAANCxJk9XKBNKk9z1f+E5SU7z
 GkxcOf6FLv8v88761EHY10mt08ESKZjVlLS717ulEFKxkwSIBq8OHf+ldjhtV+PtdjwoZKrKNSz
 foN6b1lnYHtpMt4OeYjVvKw7P0Q8lZJBNY9Bs9Q+KvM53W2da8TMc9AuaarxSMyfSlh8jNXryBh
 EFZde9Z0kjCFxNVhvmiveVyEcwPeJBpHr4guh0Gn1cHFmr/0YR2sY9GULqZqeENDwjbykJe9jn/
 dnOhrP/HnmrBxNHq+0FT4JZnvMsMCtAWZQeppqRUrP/KRF47sud4mwYsrusCyE3/Wyv7yh3MUxD
 wB+4b4eyzzSD1O9YYdduRIzflltD4tkkGtiqVTWUbyZVKYHMp7I/BoJYkPMlGEKqCg0G3PbpgA2
 F0rsjOJ30r/D/tJvFwOHxbI4ETAHGb3iAQeOORHI6KKeLmNaZXueR6QlCBFaPLARsjooKnJ89SJ
 aCEMIdSdm7vOdifu2MHiSXhP9YpM4ANZbyWdTVmYwi+lhEAzw2b1m0C0i0HQVBw87WB6UJ/Ucmg
 A8KQ0a6bI+5WuWICiLUDHt+73P5A0NpKbDlO5SduBXc/
X-Received: by 2002:a05:600c:524b:b0:49c:c9ac:a4f3 with SMTP id
 5b1f17b1804b1-49cdc42f43dmr148824965e9.1.1788273528926; 
 Tue, 01 Sep 2026 07:38:48 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:48 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:49 +0200
Subject: [PATCH v3 03/14] video: mediatek: add merge component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-3-38194a531b9f@baylibre.com>
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

