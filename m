Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BE7C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C312780FFE;
	Tue, 28 Jul 2026 12:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqMOYYQ2iNRM; Tue, 28 Jul 2026 12:29:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D468980F19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241779;
	bh=fgN/EGht8d2Nw/IPJz8SxeHpAidqq6RUrJ4f/SfFbqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IWIuuBZ6dSiTLj2ryTNLam10Ni8ZJpUUx9IIGkjpNBZH0bRrM0maVQw2Hc73Fjz0l
	 NURji79LaW0mT8SCJQFlORk/ZxMMLEh73RUjv00foJ/WUWx3IrQtZs9/spz1gcFZVG
	 sMeXhjMgQ4RIxJIpP1inGI+JQhQVETH5CkJqIGVd4a9qkhAdRYefTd31qUMcRw+eVJ
	 dIbvgY2Nd4H432gqQeLlWVCgv32e8SvSC6nYFkg+Ucz5vJj/RkV3VZMdavhKq40/7J
	 9qWmMw43b18aeFlZ33u6v2nQ6SPzV3NGgUDZZxdrzGDZJpFM+ljiCjQWP0je4RCBAb
	 naZKfTfD0YFVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D468980F19;
	Tue, 28 Jul 2026 12:29:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80FEA2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73978409FA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3VmU5w8GoD2U for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 75E70409B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75E70409B0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75E70409B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:33 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so32161155e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241771; x=1785846571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fgN/EGht8d2Nw/IPJz8SxeHpAidqq6RUrJ4f/SfFbqg=;
 b=YEtvKO0CSJz/Sw4NOawCkdsMZS/d5fIni7Vo2otOTbMgUnyatAlmiJiiKERQYH4Jaf
 iAXqR6qex0a/Mk3aH1EwAtj8Mus54jgeXLi+gL5qhtILxa73BPjbycsPlhuI4LDMz5YW
 iRzwKCzwGvXxTiGD/5AV0I9bWKia3uONF+aTEoU66qYgTjlst8nPdchjTOIjbEy6upGr
 zSVULVe6lvt6N8SeK33W4iAgO2GGKDljkLhgXO0E4PcRFf+CmWPTQgItUAPc6u8GPaLl
 a8ZG4jQvsqFvc9aiZ0RmLl6OXDyjeTQDIIohx3u1lBtxgdoN/O+r7h+kPc/ujOSd7GyU
 9pRw==
X-Gm-Message-State: AOJu0YwOVsfihEKvNPTv90+0zdq1cb4OsfX3A1YRNPVxrHsnANYVOx4i
 OUH5JaluQE343deIWNLPxNPNw78WIwyTS4RpmZ8bOj0F1e2JmQFnMQDxn/xM93W5dMs=
X-Gm-Gg: AR+sD11BICKFGSgTwN92LrZWSf/mZ5S+L3dP5uccIqTqZ7qJBxzdLlrQTmYNw/OI5Mc
 ULkiVbZs1o4ePyj/38w+vrztHppT+RFC3ETj3QFD1XeXb7FzUokRd3+Y6kuN+R4PB8hZWqYxZBr
 ZIIBKsKeiI5bVELJx18Pqi6C+yOyjnMY0wm5ejAYV1qUtpCktLFKE0+uA3sjy8UM84DZUWzgI08
 r7KtH8P5EW9uqsUTlgI/FghU78zyjqIZnK/1Z1VRb2hc2mgAgEB0z6Tbi8SksY6YV6wZcaYZFsD
 6yo3YXcZB3tt6kAJqXTczpk3ooUb8DumgSOD8d345RZivxKe3GbbIvCvcDRqMvPCnLcc7ud/agj
 fM22dSPjoyXDklo5h+M0KnCC05WXpJCUH9o1Ky0orxOO9BROggxMI0lHfsU+Jd/E/npDXWIZVm9
 2f8OUy3RH+0WX34Ge1BR5Mk971UO9NxsVL4h7PbLNihrhdh1vOpa/W2iAUvUS0fBgGW0I+o+N6U
 VKhKby2+1ggPACwah7TDEwstFiWVZndvM//pWcDYNvN/3IqgCNCe/oHGfDWgYw=
X-Received: by 2002:a05:600c:4744:b0:495:4c74:6a14 with SMTP id
 5b1f17b1804b1-496c6438e91mr24323185e9.14.1785241771330; 
 Tue, 28 Jul 2026 05:29:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:31 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:34 +0200
Subject: [PATCH 02/13] video: mediatek: add mixer component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-2-ac54bd75f960@baylibre.com>
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
 bh=fgN/EGht8d2Nw/IPJz8SxeHpAidqq6RUrJ4f/SfFbqg=;
 b=d+XP9lYy7+Trr5saRBAwkBJqQiLBGzXjo7ZhmUCzrUWNI/Zdz6h/PXEDYfMKzNzdNB
 xWX4Bn1l3FOgwSpoOuKMsRT1w7Yaso+4blPrdwJaX0FR4cG7xy8a3oYAOElZgzyxY8/B
 UhKyBa3CN3NVbzvOsJASvdvUTU9BKYw7pmbvv7DWjXTCChmf8io9pB7AX6k3y52D1Tvh
 p3LKQYO7mfXUGqqMWCRs7THRQJ2iKRHmGb8TTny5N0z46bnxjy0JXGMc0SS2BFIIn4Qx
 TeHpllvG8cqmCmlKDSLSV4uSEUiQNgte/1AS7CLVDpWJ4IuvmhaLEPejsCSKvbKAsYns
 YvcA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=d+XP9lYy
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

The (ETHDR) mixer is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. Only the mixer sub-block of
the ethdr is used, which is its first register window.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_mixer_mt8188.c | 76 ++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_mixer_mt8188.h | 16 ++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_mixer_mt8188.c b/drivers/video/mediatek/mtk_disp_mixer_mt8188.c
new file mode 100644
index 00000000000..60b027691ca
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mixer_mt8188.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek Video Disp Mixer Support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_mixer_mt8188.h"
+
+#define MIX_EN			0xc
+#define MIX_ROI_SIZE		0x18
+#define MIX_DATAPATH_CON	0x1c
+#define OUTPUT_NO_RND		BIT(3)
+#define SOURCE_RGB_SEL		BIT(7)
+#define BACKGROUND_RELAY	(4 << 9)
+#define MIX_ROI_BGCLR		0x20
+#define BGCLR_BLACK		0xff000000
+#define MIX_SRC_CON		0x24
+
+#define MIX_SRC_L2_EN		BIT(2)
+#define L2_SRC_SEL		(2 << 20)
+#define L2_OUT_SEL		(2 << 22)
+
+#define MIX_FUNC_DCM0		0x120
+#define MIX_UPD_REG_CK_EN	BIT(0)
+#define MIX_FUNC_DCM1		0x124
+#define BG_CLR_CK_EN		BIT(7)
+#define MIX_CK_EN		BIT(9)
+#define MIX_FUNC_DCM_ENABLE	0xffffffff
+
+#define MIX_L2_CON		0x58
+#define NON_PREMULTI_SOURCE	(2 << 12)
+#define MIX_L2_SRC_SIZE		0x60
+
+void mtk_disp_mixer_config(struct udevice *dev, u16 width, u16 height)
+{
+	/* enable internal clocks */
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM0, MIX_FUNC_DCM_ENABLE);
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM1, MIX_FUNC_DCM_ENABLE);
+
+	/* enable mixer */
+	mtk_disp_comp_write(dev, MIX_EN, 0x1);
+
+	mtk_disp_comp_write(dev, MIX_ROI_SIZE, (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_DATAPATH_CON,
+			    OUTPUT_NO_RND | SOURCE_RGB_SEL);
+	mtk_disp_comp_write(dev, MIX_L2_SRC_SIZE, (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_ROI_BGCLR, BGCLR_BLACK);
+
+	/* only configure L2 since only rdma4 and rdma5 are used */
+	mtk_disp_comp_write(dev, MIX_L2_CON, NON_PREMULTI_SOURCE);
+	mtk_disp_comp_write(dev, MIX_SRC_CON,
+			    MIX_SRC_L2_EN | L2_SRC_SEL | L2_OUT_SEL);
+}
+
+static const struct udevice_id mtk_disp_mixer_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-ethdr" },
+	{}
+};
+
+/*
+ * The mixer is the first register window ("mixer" in reg-names) of the
+ * ethdr block, so binding the ethdr node with default register index 0
+ * gives the mixer registers.
+ */
+U_BOOT_DRIVER(mtk_disp_mixer) = {
+	.name	   = "mtk_disp_mixer",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_mixer_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_mixer_mt8188.h b/drivers/video/mediatek/mtk_disp_mixer_mt8188.h
new file mode 100644
index 00000000000..a34aca6c757
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mixer_mt8188.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mediatek Video Disp Mixer Support
+ *
+ * Copyright (c) 2025 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MIXER_H
+#define _MTK_DISP_MIXER_H
+
+struct udevice;
+
+void mtk_disp_mixer_config(struct udevice *dev, u16 width, u16 height);
+
+#endif

-- 
2.54.0

