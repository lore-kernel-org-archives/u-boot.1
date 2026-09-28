Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A284C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33CB1606A5;
	Mon, 28 Sep 2026 09:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEhloiAlEYIa; Mon, 28 Sep 2026 09:17:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 238A660684
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587066;
	b=Lq6edA1k+gy/3iLLpE1dz6tROV8VHoVJ1AqcN7CYHVA2E3YzbP9w7NbV8Oh5rtg2ev+m
	 bNR5KzR4a8EwwwDbPzvy5WF9J9tFrbq/NJMCO27V9Qy2MjNjJW+6vyiHNeC1ZVRN87ERp
	 KXEb3I9rmMZvUdfjc3OGxaB0lnuCRmUvtHfuuLW2xse/OHz/WgGv8dutDiNczeyZnOgaK
	 R8xRNxFaT4jr88RvJNKyGGscORghO1Yop6sArlY13KycNT6SYVZ8IWyNc1NYE3S9v/cAf
	 JlyD5LlXaCY2FdtcBf4NcODxsP2GAQaN5umDvm8OhGBs3k7Ib6j3pfTADyZu80/O2lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
	b=Q9Fbb8hQQlQFxIWfJKHM8dE0k+L/rbjJcU8HK4V2TqFAvZds2qkIOGm8Tmvh6/aCO9t1
	 tQobPZfZMyxwp2QT5pekem3gHASVa3gxR2R4wC/iijXEY+vf86pSIqH54bRZsgvNPsmYi
	 WTJm+qZwf3yASvI+OxpVyoRrebi3iTKYEcll5J9qH/t1GKDOAYY59oDspcd6IaeWD3SOY
	 AWq4etPhgNv/EPVcORDFdKpJ2lYg/bKQvCkQF78yeOGPthmNAg+C00+seJKI4K03XeeED
	 6KZjHNpchqc44SQzzYRCkPmXI3L9ceuOif9fPjZc7tCW/3BvHSCujdcP2FrtsG2girg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GYv3boQU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587066;
	bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z7J490LLyOcHIt/0wllx30kRbiwNnb4WwIKk7ve1I1bx7KY+TbdnzzxnK/x7VKLIX
	 ELR3x57UjH/ugahISUqIkT65NyQVLYz2BVbolIAkjljeGga00r+NUw6HFL4bPERGET
	 q1gt4cSRSS/Af7PBoQkSoVrCy36+RD15bSIqHfppA5R4msqxX9kIJLo3S38xuRi9C3
	 /4Ot5Llv0ppfoUkasrWPWK2DgT6vHqfRq2b46PlvY7Qab2zgr386Fqu8mAiliuEotB
	 xwmBUa7YhZfMlc+ISGqz6Balt7ohrRu4wjwbV08NYDhouGA4F6LyIh+6CST2WNyhLy
	 UqEVAfcBCQ/5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 238A660684;
	Mon, 28 Sep 2026 09:17:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4A873D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 814F46067E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZbo5wA4feb6 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 53F3660603
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587059;
 b=qmy/aH704827guc0vQx5ZgNNlf0qn2ZHDjT/J/C41iEzBjqiHdEKpemzQ57xIjTMfIt3
 ep4hi4wZY5y8sbrt6bxosNXRTbzGpv9fvWinRnIeb5jDvBaY2uVvbgcAy0J23tpTC9yjg
 RVSB2Tlq7z16a+tPzYHBFvgJnVQDC0/uYJbjvDssjwT8kRnL3zmr6SwWBwNMWjc2/jLxb
 58zwbfKV4ogvl/O4XEx1qEw1HEFvKUpLJgon+CFzHnubjogkgo2zYlR8ojFXT3Dd6Rggy
 dkFXuH2RPHiJXFtp3PbDxDU/xa+8+l1IPbMSVXa14HhABZ3iOBcgfmzMJMmLZuJ5AXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587059;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
 b=DK1GQa/kx02ILQi2TnBk8BDUS3waKzKBP6xbljGQkdkuJwlSYKeTPowECu8jZe2XYWdG
 VENwBGvToGMlMp1xMfb515MB/dTHgPjzuQvH9hkjBxTY54Rs85WB0811JCeFqeAcgYsDI
 1FbRTzwNPn64+kqszeR5fGc+iQUu94YIjmt9RZA+3PrYG7JvRHlLwtb+knhDoVuEghh5H
 uHuwV0yaIxvyNrAazB8QF7ZLZ1aLQuDITZ7wCp/8dTlT1Y3jkmPVe1hSLTGnrbQNSUekE
 uMuEJeSF4SBk2cU2svfdmvwH80grKAxpbGDQmZbuuA0jQAbQ3T6gmfkccUEg/5j6Iqw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=GYv3boQU; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=GYv3boQU
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53F3660603
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:38 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48884b0219bso1102884f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587056; x=1791191856;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
 b=GYv3boQU7HGq832SQSpo7uGINgBlqZIdLGrz2DiiBdQFV/xbju80qHMSH4w1Q/chZR
 HaVYlLt5ExIXD6xRo26oZKoPLyibAxlsnxJ64MMEoslbzeV1CUc+UZvlCzpLwEL+++wS
 zvvO+ju07mz40Ga7/JukWf4awRbQXUVibbtCzGNHHZ+MI9ztdpAGUHf+IWN33nK4zlAT
 SiGrbS3hsh9OsmRmXs1y6MyMr0aKTEe+capBEqX2ssq6QT9j5NDBYWse5WSPnLMQpoho
 hwTz0CEaqpKTJo61U3D0bo99Yxh9ijtN0GCBQhFVw20qOfN3UCOJxmShFYaTvavfBBs2
 L4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587057; x=1791191857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LVLFZ1GbyxA3eNWWQ3Ax7Lc0mJTsxzkI+32P6me1iis=;
 b=rqRFJ8ZJYLsefF7Mjq+W4gui2yLkKVd8TilRE+51esjqXdqB1hghTaOsYaybZ7CYjB
 7teClaPSLrCaON6KKrNkItTAF5nZHKW4/+x0GQ2bn8hGaCe7kFmoiAtGCrrM/W/70T5H
 B+E6V30/o1Va6u54lBXULSP/rTbZTQf1KCLmCXr4iPeBLDnWIBo1z6EzHSkwPNEeYwl7
 IfE/uz+oLnWLvcet64p5SOeUE8148lNwAQM195hZyqEdpv6kXWlRUTJkrvBtXzj6q3g0
 fL5l2aaj7O3h3g9DNIkmd/k/AF2LET1OWi7emWB19CIn3Sjy+VCyFp3pZzj83YG+dqKX
 6phg==
X-Gm-Message-State: AFq9FYLX+cGZLuE86miQgWa2XJEZPqRCeJ9OmXgl38XorKV3UISmeuqZ
 dIuLj/qw5s0znWWMT3oKT0MtgclgAU5BZYy6az1dwdW90m2ty+mMOJhBnr3d1fnY7tM=
X-Gm-Gg: AYBFou3uQ4/2bmW46+nFmOHc9s/j474A1uggali8tN/WZP8Gl3jRVn/JwLtNF+I3iEm
 gQl6GlGtgMvn2EyZXVusR+p9zvSe/GQrTDanmVY57rxhdVNIWM2gFMinhyt413h6zbVgohWAXIv
 YKgEd8v+4mhQW09lakBN2/2mN9jCtLoHdq1Z9Ei4zMr88reqrM3vXU9idKCYAM0N3oiL3jlT8Pr
 v5Xw1zcabiPqbp43k9ZVmREY8lQZZvMijBHF2YYnvvdQeesbvRwUpcuhgGxfuQaYo5Frlm22rax
 sNY7giV5Keb8+j0THcHYhv7AMJybfN4hRgYU7S/f/mkCd/g6JWfXctNQgUR1+qyrE3CDXGSCHHI
 wccE3NmNXtgJPZMku15HNCx0RwiIErGA4c+cqrMr1eAscpR/XTfa+VA98goke9gaoYmc+z/2IlH
 UvRVvQaLvhFzDbDei/UNvObDKacJF19/wEj4RWygQVP/Sh8U2HcjBWjU8k7iy0n/ZvYiuAu/uJU
 caolqM36879N/3woQVx+1AwAVli/wbGnlPo0Wj1a8HvjeyXgBys/KrjtopN4OkSWEvr3RedK+jv
 nmzkHsQ7eW3BzwgtzKjksgRYXHuMlEfdzBaMS/214exlCbmUSCm3WL0=
X-Received: by 2002:a05:6000:2206:b0:488:5d3e:bf47 with SMTP id
 ffacd0b85a97d-4887db2d092mr15274231f8f.33.1790587056503; 
 Mon, 28 Sep 2026 02:17:36 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:36 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:38 +0200
Subject: [PATCH v7 03/12] video: mediatek: add display pipeline component
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-3-ee4a61a8ac1d@baylibre.com>
References: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
In-Reply-To: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
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
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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

The components which are DMA masters also need the SMI larb feeding them
ungated, so add the lookup resolving that larb from their "iommus"
property; the enable and disable helpers take care of it from there.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c | 123 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_comp.h |  95 +++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
new file mode 100644
index 00000000000..f9eb9e00de6
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -0,0 +1,123 @@
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
+#include <dm/ofnode.h>
+#include <dt-bindings/memory/mtk-memory-port.h>
+#include <errno.h>
+#include <mtk_smi.h>
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
+void mtk_disp_comp_update(struct udevice *dev, u32 offset, u32 val, u32 mask)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	void __iomem *reg = priv->base + offset;
+	u32 tmp;
+
+	tmp = readl(reg);
+	tmp = (tmp & ~mask) | (val & mask);
+	writel(tmp, reg);
+}
+
+int mtk_disp_comp_enable(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* ungate the feeding SMI larb first, if any */
+	if (priv->larb) {
+		ret = mtk_smi_larb_enable(priv->larb);
+		if (ret)
+			return ret;
+	}
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		if (priv->larb)
+			mtk_smi_larb_disable(priv->larb);
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
+		mtk_smi_larb_disable(priv->larb);
+
+	return ret;
+}
+
+int mtk_disp_comp_get_larb(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	ofnode iommu, node;
+	u32 larb_id, id;
+	int i, ret;
+
+	ret = dev_read_phandle_with_args(dev, "iommus", "#iommu-cells", 0, 0,
+					 &args);
+	if (ret) {
+		dev_err(dev, "cannot parse iommus: %d\n", ret);
+		return ret;
+	}
+	iommu = args.node;
+	larb_id = MTK_M4U_TO_LARB(args.args[0]);
+
+	for (i = 0; ; i++) {
+		node = ofnode_parse_phandle(iommu, "mediatek,larbs", i);
+		if (!ofnode_valid(node)) {
+			dev_err(dev, "no larb %u in iommu\n", larb_id);
+			return -ENODEV;
+		}
+		if (!ofnode_read_u32(node, "mediatek,larb-id", &id) &&
+		    id == larb_id)
+			break;
+	}
+
+	return uclass_get_device_by_ofnode(UCLASS_MEMORY, node, &priv->larb);
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
index 00000000000..8214af38b27
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -0,0 +1,95 @@
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
+/**
+ * struct mtk_disp_comp_priv - common state of a display pipeline component
+ * @base: register window of the component
+ * @clk_bulk: clocks of the component
+ * @larb: optional SMI larb device (UCLASS_MEMORY), enabled and disabled
+ *	  together with the component. Only the RDMAs, which are the DMA
+ *	  masters of this pipeline, have one.
+ */
+struct mtk_disp_comp_priv {
+	void __iomem *base;
+	struct clk_bulk clk_bulk;
+	struct udevice *larb;
+};
+
+/**
+ * mtk_disp_comp_probe() - probe a display pipeline component
+ * @dev: component device, whose private data starts with a
+ *	 struct mtk_disp_comp_priv
+ *
+ * Map the first register window of the component and get its clocks.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_probe(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_get_larb() - resolve the SMI larb behind a DMA master
+ * @dev: component device
+ *
+ * A DMA master component reaches DRAM through an SMI larb, which must be
+ * ungated for its accesses. The component points at its IOMMU (M4U) port
+ * through "iommus", and MTK_M4U_TO_LARB() extracts the larb id from that
+ * port. Resolve the matching larb in the IOMMU's "mediatek,larbs" list by
+ * its "mediatek,larb-id", so that mtk_disp_comp_enable() and
+ * mtk_disp_comp_disable() then enable and disable it together with the
+ * component.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_get_larb(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_enable() - enable a display pipeline component
+ * @dev: component device
+ *
+ * Ungate the SMI larb of the component, if any, then enable its clocks.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_enable(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_disable() - disable a display pipeline component
+ * @dev: component device
+ *
+ * Undo mtk_disp_comp_enable(): disable the clocks of the component, then
+ * gate its SMI larb, if any.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_disable(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_write() - write a component register
+ * @dev: component device
+ * @offset: register offset in the component register window
+ * @val: value to write
+ */
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val);
+
+/**
+ * mtk_disp_comp_update() - update some bits of a component register
+ * @dev: component device
+ * @offset: register offset in the component register window
+ * @val: new value of the bits in @mask
+ * @mask: bits to update
+ */
+void mtk_disp_comp_update(struct udevice *dev, u32 offset, u32 val, u32 mask);
+
+#endif /* _MTK_DISP_COMP_H */

-- 
2.55.0

