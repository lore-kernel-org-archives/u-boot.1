Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F94CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38F7D8134E;
	Fri,  2 Oct 2026 14:01:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W9Cy9bsNJKYd; Fri,  2 Oct 2026 14:01:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D67B781338
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949691;
	b=RfPx/LNMnIEHU8TrcAD8uP94qBD3qXYil3AGr/B4644p1pyCKF8uWbRzC5Qyxo0LywiX
	 ut7vcDNCPpx3cjggvd6tRK21EYovecH1bon+f8zSrSG39ZXHKDQMR19W+ffXzBpACaYe+
	 6gXIV+5JLa2Vkr7TO3megt7PyPyInkrdolP3xhvMplvx1HAleeMzZUyxb2q4kpBZhB3xU
	 Io0Pfd4KdpEEqAirm7hwL2l33RQ1bXbye8w1lZ+RqD0EeEtOMSVs3E7Qhmy5IkhYuoRUE
	 Up5Zgf2q0doh89Tyd3/Zl2sVlgdd8FDDpcLvkHm5XHXi3L/jUgoshZ/BhdhNgmLV6hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nbRhMXtB7BKukDloXZytwXmgJXnfU5GIm5vjo5ReUUE=;
	b=m382NVsvY+fC1wOnXp7sPMkfAITUJ0kVb5nQ3Qpo63hFBfLpEcuI80cNGYjUichmsOlJ
	 EhcM2/bZ6KREHny3vjdpBKbqSUSHvP0eISsyPPim5Q+tmcBCHAUP8Jd1o5gaWAIJD5El+
	 ysRkCPDoclQ9t19OWPi56LYERrCe3L5lnWBKoatx+yLI90Xqov9VSm3NKwb4MUnhUUXyT
	 M4h+HbKoaUXIBcC2pGVyGZuUDOwzu+e23GtEPemsXxN9lTEYmo6smnmjD612+Y78/IY7p
	 SLIuRefx5yx7N1m+pdnPK52sWUHYVHl02C6PYC2C+xbRe2vIqXlRq6XyabN+8RvcNWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949691;
	bh=nbRhMXtB7BKukDloXZytwXmgJXnfU5GIm5vjo5ReUUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zGVfrFvCgLy2TW2I7n0U1afqlf4G6/6LuZBU26Q25WRL2FWgeez85OvHcgvwfzhRB
	 0wEqusoW/bUQmkhfsNXeduL/CoKhrSpw/EoWYenaHwVOB9vSQaO/GBKhB7pe8GqH2D
	 jl1w5C7ejkR0EcjbMwFJ6+e5SiLubSI0YY9duOtYStsvQ8t+OyPZk4x8SKK/yngxqw
	 TtL+fcOaEOQCKAeoAiNXBxXYtX6Zn1+g7aMdYfDo2UHKeh76J2akzzQgRPN39+O3UJ
	 vHB8L6vtIbjTMKxaLURIKdmxjacctRlb4/vxEEZXpXLR+na9D5rbElbJPK+M190bDw
	 Qfp9geg6d+f2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D67B781338;
	Fri,  2 Oct 2026 14:01:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C6FF282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6313040D94
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gx0Yk1FYeEWh for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6311840D87
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949682;
 b=RRPzhuXZVAf9XUeXXe7wmwVN9eg0HpYMxzpTdjan5J9797XsfZy4JWVHGe5GoTujBLwS
 gttqYhADzx2XtnPJCf8NQlqO7SvkQpINDfQjCYPfO8P/QQ6/jKHFKTfKh5ZwOGuRy0teF
 7rJtnLnilLmJAKdHZVPVAsl0fgap5whSnIxHCQOupEiCaAdZ4qcWqVf8ooLXRNn3/eIlL
 dBIGtF9q+V7xylkuc+rIMgBWoGvEDGurNBFtwnATG3XzDRjUSUriGK8n7r4vdSQgww7qu
 ajBkofK/0ajW5M533UORFYniGuwS9Zat1pdyesTDmOr6sQgTQQzEJwCV0zhTvCfAOuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949682;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=nbRhMXtB7BKukDloXZytwXmgJXnfU5GIm5vjo5ReUUE=;
 b=XDfwK7Qyu5Hbus7JlX3gVt25/5ZUKmAKR9/mqYnu9BpNHrLSFX2KU6sLadcLP2/rSud+
 k77CV/14+yj5WpUHc5Nl3WZY9BXIfL/zam+H7fEjwsCI8ilaDHo2GxGabns7dXXfha320
 kLFkxyOywlVHdZ7MyPbqE9smPxjFYVw4ng3KrS/ZH2xuHTN+tgcpuh3YvAbDSUNEeu/1T
 oQe6firD2BykspMxbyG4bCiZEx+DaQfVXvgChTTDEIiTKzeBYjr1Z18cmEbts52eGbwQD
 2GOMf4+0aekPOr53LfY+nhYZVKx5CwAcudhIcW66whDcWTPUQ5F/qhPwRjhUsCWu3uw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="d37nC7p/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=d37nC7p/
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6311840D87
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:22 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so780225e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949680; x=1791554480;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nbRhMXtB7BKukDloXZytwXmgJXnfU5GIm5vjo5ReUUE=;
 b=d37nC7p/tx+SkaPoqB08jbBs8Ee5v0ne7+Q5VfiuUj5jGa1ajQK89mru0YOgLxjAG1
 TctpNnshSDicEvH6Cg9nH6MLbC6OzyMgAv+41KR7kLa4tXf1vbAT7tfVJPlpb42aJYb5
 iFaWJoBilz22UrxKk++M2q9RWDgneqZ95L0Fs1LRTt+3WTuloUz4KSugxXvHXtS6J1Yf
 7RknJjUuFNWe7YKpAuoI2UdP8gBPHwbIohSRYRr1qN5L6TlO0R+yV7q/vy4y25+jcLeB
 pbMDLneD7udzL/gTMGikaWIbvz3i/GZVgqA+yDFdMqbRQ/921Tjfik2Ka0HTa6rGEChZ
 v7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949680; x=1791554480;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nbRhMXtB7BKukDloXZytwXmgJXnfU5GIm5vjo5ReUUE=;
 b=SMxdBA2gc+xLCl+l4IbfBcFdi1VIfIKAORyPHe6YR5HOTVUylBLPLtdwkXxgYVxHat
 3hmnhiCFkjC+tX/hHh/Q5k5hVDn55d5Ge+MZLrsipzr7sXtCT4m7v07bOQKK7/bt/J/h
 IUCOXJMMfz1MvTc/MbDmHTzMCn8q9iF+JQvMlGoceywgaidLfhLRN3NW/GPQiN1Zwb5s
 28nqgX7GyAzgPMOiQPUXSRIJnv2r3Jb136Q3+pkuqaAFkKKNe6+EsJe2GofdSVGN+am2
 EAapQ11uxfc+51+duqssDiZYTucQnpV63+ToYP6LRp87dq0jBQgdTwVTq4OQAz4e/qdX
 Jthw==
X-Forwarded-Encrypted: i=1;
 AKwUvByNOyOnxoCp+bzRphq8mvkiOXzHribo1HP1aRLtq9Au/Y25ZjiTiim2jZrysgWNWHIFgm+XmYU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mQitBfZdOs4oR148h3yOdsVNGnr16W5UVTsrZb6QXJ7CxmQE5h
 4QhCaP7COgeKAv+7lWpTCDt8pEbsoRmlr0acpygjM6kz18iQ3rEfP2khmA8pewQOwyQ=
X-Gm-Gg: AYBFou0ghoROWjXBxrIFGX4CPAUkIKa8Q+n5cO6pdMq7pzyqCc2knK3ipNhDFX7lzOL
 BJUa52aqYFy7wKE05hDcTLKrG4Ai7FqD0bZG15XetZ79/tniBTOSuvkeg2m3byjKqTrfMf/DUXz
 K/7RkeYkK4QJ4N8dSUnIwHHAZxmI449aIi/IftLtrjkyG4EX69JD6XSaah1EM3V3iIRXXC8dGAy
 aT2FrDREBTGqZa0h8PFvrwgSbydwc9K5GJu6B6vniE6Vvmt8jczTw16mktcMZZama+w/eFkTrYg
 M86eTctiG4PrJ1u1N8gl25Kp00IdYtM58YrbT6FuSb4TBY9Nu7tauTq1nYp1/PYCy3BSFepmNss
 kRkcNMZ4p6Mj934/Z82XuTc+Z8pVAHtawMGff6Vkl0YEjwoJGWjUdgjyVRuU3ZOL6qwltxq0Gvz
 o7evASxk62VMKvMp0HYDAOxJlHKSpAP8utghYhqKN5QU+P81PDBvx0emQK+RcDdr4/TWAoc1mY6
 F9Gi7li9fHhlWnYz4YwW40e3GagZcpuqqvQorbcTkhEQ3hy47Q1WMSngBscnBNgMMYxUggYE+2L
 7Tf7saAoMKv3KunXUWvukONBbaRprvNBTFwUtB7Ud6R3uWSBMFGDHEI=
X-Received: by 2002:a05:600c:993:b0:4a0:1fb9:2f51 with SMTP id
 5b1f17b1804b1-4a027579559mr38461895e9.14.1790949674592; 
 Fri, 02 Oct 2026 07:01:14 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:13 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:03:56 +0200
Subject: [PATCH v2 05/13] video: mediatek: add ccorr component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-5-9e435457b90c@baylibre.com>
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

The color correction (CCORR) block is one of the components of the video
pipeline on some MediaTek SoCs, such as the MT8365. It applies a 3x3
color transform matrix to the pixel stream.

U-Boot has no color management, so the driver only programs the frame
size and enables the engine, which then applies the matrix left in the
coefficient registers at reset.

The driver matches "mediatek,mt8183-disp-ccorr", the generic fallback
the MT8365 ccorr0 node carries behind "mediatek,mt8365-disp-ccorr", so
a single entry covers every SoC reusing that block.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_ccorr.c | 55 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_ccorr.h | 31 +++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_ccorr.c b/drivers/video/mediatek/mtk_disp_ccorr.c
new file mode 100644
index 00000000000..b54cc7dbe82
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_ccorr.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Color Correction Engine support
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
+#include "mtk_disp_ccorr.h"
+#include "mtk_disp_comp.h"
+
+#define DISP_CCORR_EN		0x00
+#define CCORR_EN			BIT(0)
+
+#define DISP_CCORR_CFG		0x20
+#define CCORR_ENGINE_EN			BIT(1)
+
+#define DISP_CCORR_SIZE		0x30
+#define DISP_CCORR_SIZE_HSIZE		GENMASK(28, 16)
+#define DISP_CCORR_SIZE_VSIZE		GENMASK(12, 0)
+
+void mtk_ccorr_config(struct udevice *dev, const struct display_timing *timing)
+{
+	u32 sz;
+
+	sz = FIELD_PREP(DISP_CCORR_SIZE_HSIZE, timing->hactive.typ) |
+	     FIELD_PREP(DISP_CCORR_SIZE_VSIZE, timing->vactive.typ);
+
+	mtk_disp_comp_write(dev, DISP_CCORR_SIZE, sz);
+	mtk_disp_comp_write(dev, DISP_CCORR_CFG, CCORR_ENGINE_EN);
+}
+
+void mtk_ccorr_start(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_CCORR_EN, CCORR_EN);
+}
+
+static const struct udevice_id mtk_disp_ccorr_ids[] = {
+	{ .compatible = "mediatek,mt8183-disp-ccorr" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_ccorr) = {
+	.name	   = "mtk_disp_ccorr",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_ccorr_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_ccorr.h b/drivers/video/mediatek/mtk_disp_ccorr.h
new file mode 100644
index 00000000000..2d5bd3aa060
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_ccorr.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_CCORR_H
+#define _MTK_DISP_CCORR_H
+
+struct display_timing;
+struct udevice;
+
+/**
+ * mtk_ccorr_config() - configure the ccorr block
+ * @dev: ccorr device
+ * @timing: display timing, giving the frame size
+ *
+ * Set the frame size of the color correction block.
+ */
+void mtk_ccorr_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_ccorr_start() - start the ccorr block
+ * @dev: ccorr device
+ *
+ * Start the color correction block.
+ */
+void mtk_ccorr_start(struct udevice *dev);
+
+#endif /* _MTK_DISP_CCORR_H */

-- 
2.55.0

