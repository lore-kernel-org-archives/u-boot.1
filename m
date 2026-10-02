Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14A3CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A60D781341;
	Fri,  2 Oct 2026 14:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CoP2ENTDwMBh; Fri,  2 Oct 2026 14:01:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 38EC981338
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949695;
	b=E6NCTdqMtkArBCwMT+gS6xULEFHFiQ0JFvyHcpmMKiqJyQsU5JeNYj5Zm9YeBKs5x0SQ
	 h00nUGcChhQQOQ8ESSXk8GtWBP2pTd/38+xdQLacOpk3p9ajjS88MqmPqwq7PJ9EPrhXJ
	 atOg/kU/8qchfzQLaCPPfP2y0wKD+6J4OaoZYp7+rbMuuns8SE9jE7V14YBFuS7DX/zPA
	 TJuq+hKZb5A3PwKaEYCgS3927f0ow9/NbxXRIXE/0QWcgAm2Ahvj4B/5r8STlHZcMQG2t
	 T1SY+0jTwKJG4tQAC8njxQRAKVjqZl7Vs52cj2aFheKYMI/i2C7utOqkJNGd0KPkZnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8pP5+9D+oWJnYevj71PlImQNQQv7MMT4AE4lo6hu2I8=;
	b=mMa2MRQbsQ+lTWDYqBjtdDKInt4qhtfVaRti/HY35a0RkFKauZ5kR2ftqQpo2fxBsGJu
	 9+KPB5zK/yixJQdwiFdV8NU96gOWWj6MMNhvdZmTev72/n71UaeHOgqoeIi7wl0mFHvMy
	 kKWfjRoj5W5f8XG6vhzz0JsZUxQYmDfU+yZ6L0mdsJbsxTvG5Ioh9MUPgvIWIU8YKFt1k
	 yQCvDA4bY5N8cKNbuBfK5bdmspcdT8IvUCQqRg+Sx6ZEJAHUuIBM/w1DdWiZaYtr47hiv
	 EkVNTAmuC9lZ2ZylDi77LmRxjxOSpIOmT3PM4pc4RIhg96yy1WqTguIDkYYeBwJdcUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949695;
	bh=8pP5+9D+oWJnYevj71PlImQNQQv7MMT4AE4lo6hu2I8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BTCUB49hm21bMjLQjMbdlRGntsMvTLqGGGyrTNWe6N5qCHA/fEDkgkI/0/hsRGwIf
	 VehSltR5zA8UApD4IW7MlHlmPG8FHAjW8Mheg/Fs/5PkoZbTsEWVsTqMXvKRdwbBwz
	 /k+2ft9ENZRaEp2ioGRG8u1HRcYio8eIdViwsKcmasdmIK7vOyQbfioABjvIWNJgud
	 nyRXpVpRvorOHajbX/zVLII/XlloDp7D5p5NktF5FBU5xNTqIbzqxbLaBp4Lpjxq9Q
	 QtOmC9nGDNWwPZ69YZhJTuP1MN149emcP7FxvLB4TwIpKL/7uAzOEoTTvSiAvzJcvf
	 Lj8nSihkJmy+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38EC981338;
	Fri,  2 Oct 2026 14:01:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 87FFE2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79B8E4055D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tvTruUkvT5YI for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6A512404F8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949692;
 b=oGELMzzqpVOjnLEotXrWePk13f4JAbCzsuJZBko10n29KiHv7LjWp0LaIGcXTaLMqlzG
 4St5Nn9bgSnFDt2bZo/LnUjAdtPsxjaSkMue2zs8/9GuOSU9KQgSUiKe57y1NZ5zP/d+P
 ZLKqnkyAl7sXGmA+rTmYeoKYXUDHM7l20TZolXL47XiF0jSyp1WnKRxTkLUKCctpbjjU4
 sEIynkYdgGpRLbVLnnRA3RGiUuY6MLGDiElELVL1sIEBECIrVyUvk0PKvUiaBw6UDmTdY
 ERf7IwtRgdD8uuB7kOM2qOGDuBZADGu4xUQ9Xsdlmp/KSM6sAiNLZx9d1rJzeQMTqHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949692;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=8pP5+9D+oWJnYevj71PlImQNQQv7MMT4AE4lo6hu2I8=;
 b=DviYDUPWfbzLCOgjybAOS5Ex59klMR6OpAgvaju+rFkpSP8YgFoaY9zq2RCGeRb8cwRS
 xE2O2epOlUxJalUXIQ+6pQqfU9YgSI/ZKr4zzI8v2SHpNbTIsyjKNfBVmC/MhcXX2g4bv
 xpTEoBuLNuztWvD1JS/unaVQc3BD+TH0+esCDeTSyyoGDWobaJIJ3hw6fPehvgQvX8Z3n
 aDBh6v3qcUtUvLcFb+DRJeg6iuDTX/23gPaONnrA/7AVfl5nMgDqrXYL/xKYwGDrMFXuy
 eHMzawn+9n6TzLVVHGc8ja682PURyDnTcFX8Cu3wH8dj7uHG9vI1CLPYnbd3Sj3+N3Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=P16bcGwP; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=P16bcGwP
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A512404F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:32 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a11603310fso899225e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949690; x=1791554490;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8pP5+9D+oWJnYevj71PlImQNQQv7MMT4AE4lo6hu2I8=;
 b=P16bcGwPUvNLUPuHb/SspBiBqXSvQfvMiffRSSMmEFZZn6R2NDz/KGL/RVS7dUsap+
 84i8IMUifj45PEMm74VQ9MgF1uj7GJiihAnr2mpSut69Uq8SQ0SZTSARNhSXwqBlDiTf
 u3GiT6Jq9u/hmBguqqr9TYslb2/eos/QuL1rSfyyAQ0H1wEHrFhmlz1p9SEIpz2ljoVg
 2jzy52Vd7tOY9cxZqQWoGa37+cwaoL4RodGYYsZIkolZnIgKYXoF8ZX0NA1bbN1TMTCw
 mUoJ6D8ZStbPd6mlLPrHTOwA5GhqyVrSoQxrSbfJ+TomUyY/NhU4DAganeLRuFxguff/
 8VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949690; x=1791554490;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8pP5+9D+oWJnYevj71PlImQNQQv7MMT4AE4lo6hu2I8=;
 b=bDiMjf5mlv62SM3TTbYllG3IpqKRYPGQD1bP9LpAHRWla+WWkYxBQLVFor+ZBMVcCT
 uzxhOjFo1XuvQWWN5wzC44VoXmV0kNgTDjhwYpDXFqxOnKqj4iFC5B/8HomDyjvGpLfG
 YHN8b+4L7BVu2HBQL1/CN+RHv23NdvIp+epfwEdxwi+yVfCU8Mmh8P3MoamsAkrySWW+
 OONFl9tRFjAcehdss9fjHIyOEIK2Ppr1+wsIP1e2K5437fcDnHyleWrI5F6vOHzhoXTp
 SNe+bAR5pJ/IF9wlBA6Kt5OjN95Hzba7Z4bh46yPTGPZG4ztjnCmgbelKLJl78XK8PG1
 sNPw==
X-Forwarded-Encrypted: i=1;
 AKwUvByZ6mlGV8bL56PhJNs9T0MbzvDeHPnBLoZ28ELaqKyO49QKjXD+nXzcN8W3bU92FKxRJ144JvI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lv3gz15If/p/y6WcuaTnt94KQ1JANgjJmEPJi86komcUvumj4N
 mJGm37uDiFq3aYjLa7ysCiobBEVL8pEWVHPoQ6H2B49yYJ1Wvv9tsaHa35TSPXjVP3I=
X-Gm-Gg: AYBFou2DfRT0qhabCfV07NGDo5E+pv5KIAMN2IQ9gBFgcqsIfnmkowzIvnJID46WJGe
 PmRfek2/dJL4ZBCwes/IIn05X8asM6j61IfQjFOe14WwZ6QHso7WmoBu95i9QXWEM9zjIe2d2Zt
 6i5uMua87y/5joIgIGO2EuXNWxl51xP9AWX9YMwq+AX+LzKLgJex6UCEU/rbtZi6x2/PjpGg8Ft
 3XqPYV1tAQ0d0JKSOdu9CEDyQ6xO1wFoo53HZ9bnBUnMVSIS8anPNSFnfAHpFAyi5xy9ozKpx7R
 63m9rRQ5X9Sw7Y0ns+aGnYkBc25RXQvTJm9BdObYh8dpqamLS/vxuyDgjnesLA3bjkZtrjxMxrD
 WxQZVj1nsVl77GHkY6EHoxJqEuyG8XXbvGDAeZa90EMVdkwYNhi7dCCaWjAwNKE/Aa4ZwmuMrPY
 PgMcLyygM9p1InILSIG+WWymzlEcMiZ9oIXJDvrQBLtlJO7tJpjnhnJKRl0nJAK0zGyPtOQ9K7R
 nYO2og4wWNEkvO3jOl57kwhWPkJh7xEu5aeE0XY9v/vNqCdJjT5/xY0JEzgUido22M3adYKeg1O
 Lns2qaGwIjW045M9M3e44ltFKha5XzGmkHXA35kDDBhgxKouv+SIa7w=
X-Received: by 2002:a05:600c:310b:b0:49f:bd3c:bc25 with SMTP id
 5b1f17b1804b1-4a0276a224amr52032365e9.32.1790949690098; 
 Fri, 02 Oct 2026 07:01:30 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:03:58 +0200
Subject: [PATCH v2 07/13] video: mediatek: add gamma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-7-9e435457b90c@baylibre.com>
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

The gamma block is one of the components of the video pipeline on some
MediaTek SoCs, such as the MT8365. It applies a gamma correction lookup
table to the pixel stream.

U-Boot has no use for a gamma curve, so the driver only programs the
frame size and enables the block, leaving the lookup table disabled.

The driver matches "mediatek,mt8183-disp-gamma", the generic fallback
the MT8365 gamma0 node carries behind "mediatek,mt8365-disp-gamma", so
a single entry covers every SoC reusing that block.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_gamma.c | 51 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_gamma.h | 31 ++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_gamma.c b/drivers/video/mediatek/mtk_disp_gamma.c
new file mode 100644
index 00000000000..335e7216277
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_gamma.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video GAMMA support
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
+#include "mtk_disp_comp.h"
+#include "mtk_disp_gamma.h"
+
+#define DISP_GAMMA_EN		0x00
+#define GAMMA_EN			BIT(0)
+
+#define DISP_GAMMA_SIZE		0x30
+#define DISP_GAMMA_SIZE_HSIZE		GENMASK(28, 16)
+#define DISP_GAMMA_SIZE_VSIZE		GENMASK(12, 0)
+
+void mtk_gamma_config(struct udevice *dev, const struct display_timing *timing)
+{
+	u32 sz;
+
+	sz = FIELD_PREP(DISP_GAMMA_SIZE_HSIZE, timing->hactive.typ) |
+	     FIELD_PREP(DISP_GAMMA_SIZE_VSIZE, timing->vactive.typ);
+
+	mtk_disp_comp_write(dev, DISP_GAMMA_SIZE, sz);
+}
+
+void mtk_gamma_start(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_GAMMA_EN, GAMMA_EN);
+}
+
+static const struct udevice_id mtk_disp_gamma_ids[] = {
+	{ .compatible = "mediatek,mt8183-disp-gamma" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_gamma) = {
+	.name	   = "mtk_disp_gamma",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_gamma_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_gamma.h b/drivers/video/mediatek/mtk_disp_gamma.h
new file mode 100644
index 00000000000..8dc171b8b16
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_gamma.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_GAMMA_H
+#define _MTK_DISP_GAMMA_H
+
+struct display_timing;
+struct udevice;
+
+/**
+ * mtk_gamma_config() - configure the gamma block
+ * @dev: gamma device
+ * @timing: display timing, giving the frame size
+ *
+ * Set the frame size of the gamma block.
+ */
+void mtk_gamma_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_gamma_start() - start the gamma block
+ * @dev: gamma device
+ *
+ * Start the gamma block.
+ */
+void mtk_gamma_start(struct udevice *dev);
+
+#endif /* _MTK_DISP_GAMMA_H */

-- 
2.55.0

