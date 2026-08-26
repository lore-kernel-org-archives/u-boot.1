Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7183AC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3888680C12;
	Wed, 26 Aug 2026 13:09:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6Mh85iAInTH; Wed, 26 Aug 2026 13:09:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749780;
	bh=cvOSgQA4Ov14+lrW8gKpdxdkacTxlPl87ObrQPQiAms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iuFMiMn0hCmKfoOma8dRfYc4nRJwkjnkaqT3Px2yK+SNYSvpaiNX2gnwtVEdS6Hab
	 XyyhBJo1XdfSQl+JLXrk4NdifFtG5J8bejrX3OWoX3lRqL0FIJdI1GlxiVqqhs7Q8i
	 H/RPQiwg6Nh4YIMnbxmtON9YXrMdn75xZL6E2SnfGcjj2ibY+UsjvoiV8e54X/TF0J
	 3I2ZICdu4S2Zsb11VbZxiq+dy3WExOP/CVJDmSh7ihtiPh8Y1MIanL2yBVN1dZ2mOj
	 SYzsnBWg7THl2oAgRx4eJXN9DvbNmgIH+LWGc2Q1Jqj53iyclAAgF+DXGxOYTbDzP6
	 I4ZFZbeovyc7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70A7980A4C;
	Wed, 26 Aug 2026 13:09:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 807FC334
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6649B80B63
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdgKH-32ykjc for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DN6G7vVJ
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2550680A4C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:33 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so7091255e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749772; x=1788354572;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cvOSgQA4Ov14+lrW8gKpdxdkacTxlPl87ObrQPQiAms=;
 b=DN6G7vVJtPLUrqwNwWjgV7lYyKCoL/EiTVRSQu4wyb6kBEuoH+aSQdghSGHwSVyHnP
 o+CWt37NicEbD5WRFr88mZG6nzDGUAWILZ9RgJ7pzynkAS1FNDvIL7CBQx/XgVXk8f+y
 wGKVVhQv4hngYVQCW7Qeee5ZKBilfu/Dj7uFeSg9IGK16flzMzjjMWDo4zvUovFuNwUK
 J74zg4hH9dzuDdCeylbDe91iCjEuA7s8pqSjSVnWzeC2MYpFDBSaVuiw4GdJQYrQOyTe
 4NKlUiDzTjsXrxX8olm5NEIwdw48CFYBts35yad3r3j2n7zBtPKpS3j9XsAg214gK4/3
 Ogrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749772; x=1788354572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cvOSgQA4Ov14+lrW8gKpdxdkacTxlPl87ObrQPQiAms=;
 b=Y6fPmbeQ46vaCTuetcufuG14iC/DHEoRfB979MdGpre1PKwkT7Ch7+xx8eL/RX3J+X
 2bcj8nD4OxSNeCSFd0kVpcip9JYC/x45eMYXJsjSzxYHAYSsjAHxTwoecLzUPRenMFmP
 LUj0oXb1w7F1nEkymknc7vdEBMMEvkV949fUEEGYE/2dUOo3aL8UhomTxqqAV1B+zzFk
 G7dcL3s27YSciCzpq4T9fPEtqmNjJALxR2Po9gqitDilnxE68I1dSzvZxiP0MpkMt40n
 QlZCIrL5uRbuwNCsX8owmreRopS8DSgBrO+1h47oIXN5auD3eNZtAa7i8wkle8EIdn4X
 ImzA==
X-Gm-Message-State: AFuF++mv5Q4Jvn9lhPn9xKQCmn3qfI+WqVllkXsEDq7Eh8oSa4NnmZ1O
 sTcnNtHcV5NSYVygf7zrdTrhmadL2qfHiAfCLGxpAlj97MtaYKm4GwpD8/i8tpJuJFw=
X-Gm-Gg: AR+sD12oo+bLPUGabijZ0iP10eKgQgtUlBBCQ3W/fDSGqFhvadDrAURNoc9PA8Lsi+Y
 AedoDoJyhk8tuqaW/ojPY/dRQtyFvuHuNb85SoFEMKEp751xAsqXybSmsqFf8fjcPyC7+UUj+C0
 F/7y6O8KPWkjZTWWOjJ/+OxHNQkyrbMv3Dt4G0YXyMAyLmX2WFIH2BJiiYpEehadmz5IbVV423K
 uXP8CxZ8lAW/+WgR8ti93WNkGpFP6n2aSBBnhJwfvUZuzRChBrKG4Su754W83pEdBsQxjsuhDkU
 s7FitP1ACApvhzgz4ilJ9JNsjLB9YRtRRTCyLmOYzxkxgVBoHBHhTHQ114Mrn0ZtLau6NlEB9h/
 Vw2Oe8Gy+pQyvhspgon1CfOcssfSSapmJNM8RcWabEXAbTRzNEHNtsjzWV9kX2bpTVaJg8/pE4+
 fVZR4eyTjNYK5XTvsmCSU5PpWJAHlvCbVdC8/cLA3aIVzIR9mGgbJiP/2TFCGtuOIoTRtiQ5Sa8
 q0tbX9V9X0ov69pwqXATrxzVnm/myQx9gXe8H7sWihJDffYtW4hv1/rhqlHG3EnW5zdd8ZC/d7d
 4VMCjfkcpibLKZUIVvSXfEFHdwsV6iQO6fMqReM/SJydyv8=
X-Received: by 2002:a05:600c:a43:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-499dc717e27mr56330575e9.9.1787749771688; 
 Wed, 26 Aug 2026 06:09:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:31 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:29 +0200
Subject: [PATCH v2 02/14] video: mediatek: add ethdr component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-2-68ebb1bf17df@baylibre.com>
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

The ETHDR is one of the components of the video pipeline on some
MediaTek SoCs, such as the MT8188. Only its mixer sub-block is used,
which is the block's first register window.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_ethdr.c | 76 ++++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_ethdr.h | 16 ++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/video/mediatek/mtk_ethdr.c b/drivers/video/mediatek/mtk_ethdr.c
new file mode 100644
index 00000000000..531c95f53a1
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_ethdr.h"
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
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height)
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
+static const struct udevice_id mtk_ethdr_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-ethdr" },
+	{}
+};
+
+/*
+ * The mixer is the first register window ("mixer" in reg-names) of the
+ * ethdr block, so binding the ethdr node with default register index 0
+ * gives the mixer registers.
+ */
+U_BOOT_DRIVER(mtk_ethdr) = {
+	.name	   = "mtk_ethdr",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_ethdr_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_ethdr.h b/drivers/video/mediatek/mtk_ethdr.h
new file mode 100644
index 00000000000..038c658a704
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mediatek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_ETHDR_H
+#define _MTK_ETHDR_H
+
+struct udevice;
+
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height);
+
+#endif

-- 
2.54.0

