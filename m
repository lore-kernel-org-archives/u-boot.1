Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379B8CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0553F60BCF;
	Fri,  2 Oct 2026 14:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R8S1l9sn1KLn; Fri,  2 Oct 2026 14:01:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1448F60D68
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949689;
	b=BpnnNaANl+rkkRkDklsdO0M4LLaZyqbQzDaOCkrUZG9VgHzi7mHiidm9OPY/C43U1mWr
	 k70MFfQiqyPeBf7LNn+0nt8ANEQa9fXYTsJ/GUgKt82CFjCHq2ws3Wq4HpyAQHnnKUJkm
	 VW6U+dUC36qW8K+tS65dCglFnM0BiweiJ8oz9KV9OO4yH+0s3+IQaIjKKKHdo57QaIUtb
	 ekFnOA4GJEIkgDaOyexFdAIJqlk6TpC0c/ZP3AXjtot1Y+lLykPyQe7EaGkvf9PIXm7Js
	 XkfrfB7zJtauomx2qF5cJZrQ/OEgdxE6fOzFYocbXbH4ryIaTLZnwFlxY4iXRfc55bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949689;
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
	b=Z+IEh8cBYjT63F2OgQtt223U5UpW1+f9+70uuXX3HWkut1JZKz8S/ryzD8dnmdfVv1eH
	 BbzeXrlpfJZKo84FDApEgI+tQeObRo7jfXSRWD4csSp3bJkJKuicDVXvvIm/BRijqE1cu
	 /oD9Gju54fRe8XQvS1Jg8T8b6dcva57OEVp1qHcN2t7RXZeyTqZzoPzxoQC+ugCpt12Gl
	 6kNN/dkw64J2I6C6nr6XEVlwlYWxh9asZCPMiuuAvjrQYAw8Ms1Cud9VLOl2cfH1m/iNy
	 5msDr4Gw1oDTMKa+VMyEETEC1RRg7Hwvjz2/RZWmthR8lJi7KUHZp5FtH9wNJLeqWkQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="LKCq/HsY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949689;
	bh=DzsH9qM3JYbT0p0VluIHhFIn99sg+3EM8b1a12jWPxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B1n1p0LQbnF1QABToU1D6F4xzK4+g0P266X3pr+hiBAlpkUT9bo3etzNJxw5t0U09
	 e6P/L3vZAVqKac9Ogbqt25ShUMRZjhPgabHxSAEMTp3f4kQv2VqpQXBzb5+SPiJEm4
	 pD5XrT4xWOUbEfu7khNLuopgByyIOw0KCrXrTvJxySsBYnBuGLluD6EHxT2vLUscjS
	 XCu+70vQGQO/s6u5uu1Bk1T0LFloj6TB0ZWOAwFEgrmv03sicmAn6nN0fqDvbSSSE0
	 m1FYbxucyrfn5kLeMnFKgyxGjN5TFfntjzi2dutDQn3Nm0yFY5V11xU/AGeKYQkSNF
	 bQKrZoN8L3TTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1448F60D68;
	Fri,  2 Oct 2026 14:01:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 414D92E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31D4460D6D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hI6-O569dGqK for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2EF7A606AF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949681;
 b=dM3+Wj4v1HKh7yUln3qfIRGw29jW1h6EHqaUAjWji34uJbGMojx8+3Df48VO6tOyNAF1
 x75FZy4LqLyClburjbDW+OWu4ZQmOl1Xk2TPK0dIrfvDxyFXkplITXX4HJFtB8YpQAV0V
 ACSxMhoLeaHjnK9IGJV+8TivXEFjU9t+FB23rboMXjV/aT3/3OXpy4w7QyqvvfR5MR4IA
 TqTzeiOYS2VkKxyr/r+dzefz6YDVuJ3qeEwT25X48nfrBt/tkWyKGhSBTfhIe2HxTL6TU
 ylO9yDyzDMhxZ6+ns1+4gAhmS6mvpghvS8wTrzbrZb+9abE77fHCMSLfnb0ZUayK5xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949681;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=DzsH9qM3JYbT0p0VluIHhFIn99sg+3EM8b1a12jWPxo=;
 b=Z8vJmBoKyGJspLYITqruXTRvYw13FccYjGFnKpICMI3jntcmM7/j3eh2BWXjTJ6fi2BR
 q01vFI8BsB422sBfuo2eDeDf4IPIiAxkSbb4kB7n7YkwRsgsTAm+IDw60CMGHE1yqSCes
 VcI4HqxW64jSkYGn9E16v0zeE4+Gyi35FPmCzA+WSgkT0mLntyIqjxTUB/jp9kQ9NzYv+
 kAOUM1aMIspiSlPla4Y5dnUiK3vwpj1akh0OqswGdJzosakES5uR8Afa/3NSdLq+nJGFV
 27BNmeB7ZznU/tYffzZEaB5d42Yo1VMlxyrCxQIiIvjflW2yLn8c3fWCceN0b6zSaWA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="LKCq/HsY"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LKCq/HsY
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EF7A606AF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:20 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a003bd18e5so568595e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949678; x=1791554478;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DzsH9qM3JYbT0p0VluIHhFIn99sg+3EM8b1a12jWPxo=;
 b=LKCq/HsYC7rhaBf5AQko4SwCDt1XbLP28Uf+mXhql/N9NTce/Xq4FpF4+orCl0MmAB
 2sMfkzLwxxaALurcPqXZGSIAa6WGBrqio6voW+F9zRSlXQMGomVEls7w7nW41pYWWmqh
 qNXRtnYWdk+2ceyLohEPMwtfvZ13oonrl1kaLgAareGl5oecCDEg9E2n/hDR9lukbjLE
 5f1fSYtAAacHlSULSYx4vwjdlll2B48wY31y6hVmf+fYqquT+lakAj4/8v4sU6LCwj8O
 D3yI8YWreA/i92qSXLfne+i//Jl9djtX5k4C72LgaOIMVkkgXHbHuJNCVyQm4aJEFBWs
 uUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949678; x=1791554478;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DzsH9qM3JYbT0p0VluIHhFIn99sg+3EM8b1a12jWPxo=;
 b=GBLBlQJsE8Us2Tqy5B+F7oF5fAsbbw5VtDAinwUm9u4CsHlTf8/qy2zkG556nZ6XXt
 SEzGvNRilEXLtAXqvwUbS5WUHQi1GJpJIanvSXI9wVd6/cuNVXVUud/zrKWywRwsw2mU
 SUGPk1AMlo9Qfc9N3NYOdGWcFMFkGQ55c6zzsg7PvlK9JYFRCoAXF6ppxcFOv4KxPIUA
 yqU7Ngj4aGsVoCzRMpoKFJ7sBi2CUMkMSHb/oyGPu0IXxINOzvUfUX7rhG5q4/7iFSZZ
 ZYEnGOrvR0mWnzaus+B1OnEeASxZHhA27f8tISp5z6Zpzkiii8GpefQko7jDKh58hs7O
 z0bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxv4eQsxzoiN9hkagZzPztCDQKhM9lD7xujZOcqn/XVGv93EvrHpKXvcET3GhAw3afCeVxv2HI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nTd9SUKYShLmofztGB0gi/1pRKEqsCnyUlcIwFRlPOumOKRQPM
 limKYbDuORHNJ6jBFizCNJBaV4yyF/3YetGxhhXobuz8MJeW6PoM18/zpX26Kpka7h4=
X-Gm-Gg: AYBFou0q3J+yPr6h60SXq2nOYLksiLo4V3bHcs8xC8CZOW4etncu0U+XJEvrqvfFhtS
 oDlGot5kl2SMbb0JF1NJrkkI1tREanhsjsJQD23SvLoPQtIXY/cpi75qs7aVn/A2OMcuwbGqoxP
 Z+6FhYDNmojM2BUEmnFfg4lNIX0/exH9vMaIYdK/GPPkuMWVSuJUT5jqS7wspVq9MzV3mrwjV+5
 /pZTGR3lgfF/16Pafw7p7aArLATHT48t9Ske/UdF+PI75rPo0S9c66QzF9Dnm0jIJXvckvKi4ey
 eRs9AWjui2bNcKB/iY2Qr+gzfdePJfBgdl10VoDS9bNBYmL2MzFfbIfKYMcHyO1xzRiazZ+azG9
 F1d8a4W18FZG8mYICzlEQ/9cZr5y45BN3Q3oH9JCDHv/B38HYR+FHB3zxBD38IpMs/aXePFYMVo
 W1vyKSWW7urKnmNo++41yKreRF6UYyzJQlNdxHpmL9wPULKZYrgulT7hC5l1NXywXwa8KGvDOeD
 vuAOjqgje5T5QSP1lPUNa8k6C+r7Wccptcn+0lVLEPdJBiVe/vAhDT+HacKkLOCcoka1CG2lsSY
 oSBPGriMfLGnNWtZLaZos5KqcjNTBMrIAqzS+0x+j3veOIYV0txhjSQ=
X-Received: by 2002:a05:600c:6094:b0:4a0:2488:71cc with SMTP id
 5b1f17b1804b1-4a0276b2222mr45227645e9.32.1790949677022; 
 Fri, 02 Oct 2026 07:01:17 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:16 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:03:57 +0200
Subject: [PATCH v2 06/13] video: mediatek: add aal component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-6-9e435457b90c@baylibre.com>
References: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
In-Reply-To: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
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
X-Mailer: b4 0.16.0
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

