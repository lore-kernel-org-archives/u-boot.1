Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B78CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A436480EE4;
	Mon, 28 Sep 2026 15:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I_amdIKOfndf; Mon, 28 Sep 2026 15:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CEC0F80ED9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608015;
	b=OhpyLOuzpGQhz5hE0JBwC1VZj/Dwq3ysu8IMpxfruaHS7t3iD/s47ZKL+Kqdtysv0rix
	 l2drcb/iwfd8Kk13Icg1l26pTjuWVgSafFK/ocWAHST5rsupyi1T46HuEipMPIG6XOuiW
	 zIzO9yYNdvQ2T46nSJRqlNcUjcCjfqg/rWwM704jmjnzd2V1A60CRtAAI6rPvgFbN4lbP
	 iNJgGIQI8HUqBPdQcbKUY9b0m3qV0L1Gzzm4iB/+bHZXKZio9rONqVbyctpMgtne6OrPs
	 T1rU0WGeqzqSpJFk2pqrz87BbU/Cx4a7tIcKglrsfCHJqHfrR6X6TKsmt8H8NTHBYuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DzsH9qM3JYbT0p0VluIHhFIn99sg+3EM8b1a12jWPxo=;
	b=KlLKGS5UpN88nnlmBzpXa6qo2v22a9PmHL0ex5joSN+8TlbmoGy1GaGX8EMSUcizhbV/
	 8hozeqQ/lZ7Rwu8PvdPmTGntola17rRtEqjKkoxSZ2JHp1vKcVQX7HgXhi3/+KTXnOnn1
	 32vtN1DH5AmxUCppG5mRNHj9jNL1ZH+5IV/j3ur1oUz0FH3KmHcItOAd6v19SIL+jOKam
	 bTt7K9H3bFu2qMdIFH5WhHriudPrr3gKk0limM0BkFby4Aa2pVwQd2yc48ede6ZdlkbP7
	 uhJDZHwP8o1ijatp2cRtnQVljcrjl/o53ktfWtGpHprhBjAraYbL52d7xQypnI3BFew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608015;
	bh=DzsH9qM3JYbT0p0VluIHhFIn99sg+3EM8b1a12jWPxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p7AU+ZcxEcGHg2Pv6YDK1iHEo2qrDjKYeKinZG/gviXu/s6TzXFdSe+Rq2cpqlY8h
	 lXVizB/FYL23n/HlOVM7j9N/BrgOjJTDm4Co+BUd/QcB51zoGm+4nnzD3FtSFu2VyZ
	 GWfFHaZK0b+LuQIoXfM2P1Z2HjXlqTK1p/tR25Ggx8meDF2hjtbySgVE/6l3Ak2tvH
	 KetmB8hxuPlhIg3jNGSAVy2pi9Nvvs1YiE8DIV9WPZvYmxHW/7o55U+uOlL7eY0dsV
	 QjdZSVrIhcvVgdmk7soGWGXEW9HsO5bnQn5XfSu+XN/3AobYtuC9r9dev5SppBjoLs
	 1DjYFPssdn8Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEC0F80ED9;
	Mon, 28 Sep 2026 15:06:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CE1D422
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7207040703
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Js6tMfNxvSvj for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:06:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2EF31406FA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608010;
 b=q4k7wFzHaXoOqi3WTp3RIRH/mGrHfGK8QjlrovPFbxsgeMcSyX7gvhsCbYEVig3AS70b
 jlur6vnaDM3zrAuZLcOqJLfSSc2wXW6SDzhpZVwbB8d9rn2Po9/DnxQBlfZZkFNIlzi7o
 w1Uzrl0MILOTqZ/OK4r0b7i755ebfUQYyljma8oeeseMlZ8qT2F6IfsHCUEVlsPvVbgrl
 j8FWyZkmcDmitqO9r/ruLBs+ATUOK43IzrlVHMR+B3pgD3R7Z2dP540ofM9dlgIte4fTu
 GmGKsoyuEBT5GbzMulpoHz7pRKsI5ZkXqSARxxq+e3dCo3c5qkuTfOPDpVOQYNlEqYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608010;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=DzsH9qM3JYbT0p0VluIHhFIn99sg+3EM8b1a12jWPxo=;
 b=V4MQnIK/NaPsIWkbm7Igv+E1ovTX7UuBefJgqQYUHLCX2qhteSJ+av4BjsgsdwWzkRUO
 patUzFjLxmLLY3jJZCMxyGhYmYHtYlxWwCduIcbLKWd7x5gSUPfEUYSynJ693XYZI2/OX
 FZUZ3xB+NP1RZ/rCPPa6u1AOrYQnJYhVQkgIifkbFZmYnU4xmOe2IO7m+8ZhFQ3j2IeGN
 aOsx70bdYGMvexqjaquZ/PkxFm0ufcktAjqqXqflALnY51eLHx1vW7Zm0f9/Qhlj76nNo
 WrtWat6Mg7a3HlyP38XTrpzCG97g7pGKbeRiAZ7JkhWHnwEYSTTKSP9oxosJL3qnmBw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QmpnGCxZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QmpnGCxZ
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EF31406FA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:50 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso747695e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608008; x=1791212808;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DzsH9qM3JYbT0p0VluIHhFIn99sg+3EM8b1a12jWPxo=;
 b=QmpnGCxZKs7Q8DPh2XRso6VKdPX+6rHDjarVT0Y7oIjIk5zhX6VI1Q22MZywgNGAiW
 ya15b1YeeKoL0LWec7vpjYRTg4eycfoqIRHs18qplKX+EgQYtWexXU5bYaz2WjgZ0RGJ
 vKksJmFn4E8Jlt1swdDha+mfKk+5gjuS+LXmyO9Wzs6SY40QSzdRvt82fJM0528Oqp7D
 1XOeieaBCTqRBRbGN+1afmuoGPmqpv2FxTAcZuJpNDvs8k5jZPjY4ZwU+N4LEGCYOgYT
 1+Qr63vDSXBeWDdls7GCMjupnAT8Xt6HRlqAhOseqkHByqecgxnrYckivom8AAVsKTMZ
 VLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608008; x=1791212808;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DzsH9qM3JYbT0p0VluIHhFIn99sg+3EM8b1a12jWPxo=;
 b=kfAzPfPUyRysGjxCzD3EMcR9Vjl7/xQcu6VrSDiGng6CFk6mAs+UhcW1KSp+jOazAB
 ROyPZPvIAf5anjgKGf6P9aJ2eHRypJW2LWxza1uavQiljf4h1ICiWtMfFOlqf/UWNcKV
 Qy1GHAiqWHDV+EauAtPNdiN3OAk6TgMFYHMTWIDgExJSMbVpEUfkPo45z7OHK8d0p1d0
 tbbnIrcfbrwHZxweEHvJjCtHefZzFk1tc5uFHTW0Ho2oElFjzZzO+BLm5g9PV6yBE1Fw
 riFhzTmHclkXfsvWZTQUUS44z7UQSbaq9waCJpFqqUNFO2IccP8xiL5P4FDTTbcldNwd
 IRgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwq9XkZxzSPAccXqACMboUCFqtYYOgazBgUGUnEjctBS85xCouvPq6mlmzdyvHAHiWscYJttdc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nBGj48jxSw2pfnd9PzF2PeagSSOrJO6Uz0uJU7suhl2IO/Of+t
 hN4X/7iuLkuaz0a7dCwnHSbzVzD6xIMcKJJLXx7lXD641stHHlhLxANZQfiEgijvZtY=
X-Gm-Gg: AYBFou2vNXJqbutTGCvhY9Hb7qwCvDao6vDXLxQtkDmk2e/xY5XhgcsiYcPy1gRMGd1
 n5N19a85Es+Gws/N4u/Ug3lWbiz/4OCWavI/pGi+EVdzUa1o57qA2NzDeJCXpxRbPwWnt3MyBH4
 707o2weydgL0KcgwoK6LFv+eRzhz3dKq4RDvK+eJWto/cI6XgCAyiXS1x9llyY4C14d9xobmYyZ
 IxcOKg2MSnpJNEepOqJRR1yErTXxSd6QTof0Ufj40o5CfRc5bYH3YXQuIuNqNqDJfZETiq1PsJf
 XmY12H4sjc+N8Z8NX1J1fQuPK87uG6aMkgO7WdJMbLuCxAkAc8Km4jJsnsNIn/LpdFA9DjK0LNe
 LbL22yV9N/CcCqX5/3omsCDz2LsxdhftpsJNmsYfYTge223ZlJ83lwhnDYvJgPXKzifjmjbZeIM
 WhXGcbdsHAYs0Ob8v5fQdO9AukbEC5OSfB+cMD88lZFXv335sCEZ3cmD4MUMuYyznNkOA1nEOww
 HRDmtnt795R7vcV5jVP/35pq+NDjR3hhtqv6DK5/4uRBCgtxlSJp4m0MTSZ+VFSMVc/oGIoYiCG
 YrtOWUKZEYDdmdNPDQpXBahdsgJtOq+sn8RLnivohEWdbEFGWavDnH1Hj8Nvll1RPQ==
X-Received: by 2002:a05:600c:4f89:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-49fe66c80c8mr230803705e9.2.1790608008094; 
 Mon, 28 Sep 2026 08:06:48 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:06:46 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:43 +0200
Subject: [PATCH 06/13] video: mediatek: add aal component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-6-212f51b1742b@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

The Adaptive Ambient Light (aal) block is one of the components of the
video pipeline on some MediaTek SoCs, such as the MT8365. It adapts the
picture to the ambient light through a per frame histogram and a
correction curve.

U-Boot only needs the frame to go through untouched, so the driver just
programs the frame size and enables the block, leaving the histogram and
the correction curve at their reset values.

The driver matches "mediatek,mt8183-disp-aal", the generic fallback the
MT8365 aal0 node carries behind "mediatek,mt8365-disp-aal", so a single
entry covers every SoC reusing that block.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_aal.c | 54 +++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_aal.h | 31 ++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_aal.c b/drivers/video/mediatek/mtk_disp_aal.c
new file mode 100644
index 00000000000..bbd8e6da6bc
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_aal.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Adaptive Ambient Light support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm/device.h>
+#include <fdtdec.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_aal.h"
+#include "mtk_disp_comp.h"
+
+#define DISP_AAL_EN		0x00
+#define AAL_EN				BIT(0)
+
+#define DISP_AAL_SIZE		0x30
+#define DISP_AAL_SIZE_HSIZE		GENMASK(28, 16)
+#define DISP_AAL_SIZE_VSIZE		GENMASK(12, 0)
+
+#define DISP_AAL_OUTPUT_SIZE	0x4d8
+
+void mtk_aal_config(struct udevice *dev, const struct display_timing *timing)
+{
+	u32 sz;
+
+	sz = FIELD_PREP(DISP_AAL_SIZE_HSIZE, timing->hactive.typ) |
+	     FIELD_PREP(DISP_AAL_SIZE_VSIZE, timing->vactive.typ);
+
+	mtk_disp_comp_write(dev, DISP_AAL_SIZE, sz);
+	mtk_disp_comp_write(dev, DISP_AAL_OUTPUT_SIZE, sz);
+}
+
+void mtk_aal_start(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_AAL_EN, AAL_EN);
+}
+
+static const struct udevice_id mtk_disp_aal_ids[] = {
+	{ .compatible = "mediatek,mt8183-disp-aal" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_aal) = {
+	.name	   = "mtk_disp_aal",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_aal_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_aal.h b/drivers/video/mediatek/mtk_disp_aal.h
new file mode 100644
index 00000000000..d745556412e
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_aal.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_AAL_H
+#define _MTK_DISP_AAL_H
+
+struct display_timing;
+struct udevice;
+
+/**
+ * mtk_aal_config() - configure the aal block
+ * @dev: aal device
+ * @timing: display timing, giving the frame size
+ *
+ * Set the input and output frame sizes of the adaptive ambient light block.
+ */
+void mtk_aal_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_aal_start() - start the aal block
+ * @dev: aal device
+ *
+ * Start the adaptive ambient light block.
+ */
+void mtk_aal_start(struct udevice *dev);
+
+#endif /* _MTK_DISP_AAL_H */

-- 
2.55.0

