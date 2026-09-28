Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36F3CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B6E680DEE;
	Mon, 28 Sep 2026 15:06:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ItSAXl6qhRIT; Mon, 28 Sep 2026 15:06:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9054680EC9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608012;
	b=HDx45pAt2eWvXRzw+RBE7KP9InjlFmxMxcvis3w7cfriUpqIiOtzJZj8fh0QSK9EglwP
	 xJcGHgMJfhqdlvC3b7B1OVJ59M8+XWtjcESHntvZCnG30SG6PSVIvJWLUdbW6bCLseAAt
	 vKEqt8GJcN3S9XwlBLlN9kEvXbRBMrzpYdTBmpHqTQhvbl69FyiN77lLNdkuc4LJRkKcI
	 k7tdFpunvL+Nh3tiq9sP5zXujq2VnaHCH1aP3hpXHQuSQD3EgjtixEXQLJ7xKGeAr1Oif
	 Sm+bltKDG14MoBMFy/YR7taGnjiA4g90D8wdvONCHzod9xQN9ZdgLv0ubYgggJ4GnMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608012;
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
	b=CIXnqtr0O89EzRHVki+fLMdr31Assfr6CXx7AvpUVSRW2eARCx7Huqayi6dwfYeYOY+c
	 MLqjdD5iCEa9s6FaJ/SQW+H2hE0NJ0Xq/lzZaXOXJGSIqxErkwcsQ687S6iTbt+5yPL5p
	 kOmd+IVpcagJct6MvdOU8AUGvBCL4TqKOS4e8fyvSg8wDf++mwb1LD8ynLlxTf9CaY4k+
	 g8dCyUzMnN6WrkXIhN7vaoTea32ka4G888vxxPkXc1HPLuNZEtTM8vPmdByqiBVvnZjzN
	 YLMzb49DCCBT6cdTSwW3SJKeETI/BAK7aEUxJbPanlsCCeeLCi2aWQn19E7wpNQXqsA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608012;
	bh=nbRhMXtB7BKukDloXZytwXmgJXnfU5GIm5vjo5ReUUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AADMrbKLcFOtYNOu6yYyHhhK+a2AcAcvs021tY85hoOgs8OqM4hb2DT35AIMDMVzw
	 n5h548vY2hUkvKj3TGpjncpRcf2AOHN1ABrcEbIBmBcXQT3zPqGnrLqjJ1V78lFS9G
	 VdoAJxhbMwu904QACLfXvzrJDPSZ8DEYV/3h88Y6rn48rTtkdarAtuUg8BFPxWKmOM
	 sNosiKsjj6B8a8c2JVyGiVFy7MT7EuepUq8/X9D58mkukAZFk0p4eWkw5LdFZdkCpC
	 OP1uE5a5T3AdhVKlyStZBYYaqp1f+vajv1w0BRI31mzwhm6rzKYppDmwRrz0b9vLwE
	 edhy66B8GMKNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9054680EC9;
	Mon, 28 Sep 2026 15:06:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2972D422
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26E58406F4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGqzjuOoMveY for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:06:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 34300406F1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608008;
 b=Yf55A2npnGruC81uuV8iVcaacThVAOfSfVWkxu+HDccfe85JbKnjq+mNjni0iBvp+77l
 whWJT2fodXelwTR/xGJtR0ER0GG0a8wBaAyY3rF7fs8kaMJhYI6z61ADwWp6VJJIbdE5V
 x1h5U01JXvnIxannzAujOllfUZdQZZYr1w+Qw/Nwk8Z6ChsKzgxK1MkBvHpyszTRlZz2R
 khX6JPPp/xCtbvBaqQ6wPtj879553A18obGP70FPFuMmhuitdgv2djbbg1GVaLHrzv+bx
 EfUZ8Pbv9+TcVg4kCQmyNgImFZz/4NqnAi1b6QCsrBnhC7oypk+7vnKXLOYe5RIvKpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608008;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=nbRhMXtB7BKukDloXZytwXmgJXnfU5GIm5vjo5ReUUE=;
 b=fMI8BRmnd6ZphERHPGUxrgfWt3NyLa34+WPTe6drHLxAFYNJkSdpMVWGYOTVXaxypfz0
 fx6675ctYAlOvaJj3lgyUvJLJJB7YqPQkTki2k1RZd2tWWWqUAbosXrKWo4MObGe1a0A6
 ELsMgTxONhFQIBNxSngyNQcdZb62RWnrZgT4zCcBpO/8PHLAM2VY/IxJHMl5GQKp8VwZE
 f1H7FE5zWFkyI86I+pnHLUlj7yP+KmmYdyCvKRqGKchstB+dXnPXlrU/2Uu0T//0vKogc
 yxqCZ9Hq+/vEMSPFyu/yGhlK6PSBBygcVE8Ioo2XkeNdsFwDNBfySIH/TBG60avLT7w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fo6pMRo6; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fo6pMRo6
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34300406F1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:47 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a006bb267eso4692115e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608005; x=1791212805;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nbRhMXtB7BKukDloXZytwXmgJXnfU5GIm5vjo5ReUUE=;
 b=fo6pMRo6aqbqV4xh3wOrC4XJxe7zUySxHLB7fSDoTCWK+9QSVKEehAlIlWvFO9HiKX
 E4Nu//YqbdaDkAtvqhWY/ELEdw5OytY8Z5NrsFKRu62vSmEPaIqnjufCgvbV0xvFu9gm
 aVHKwY85HuulosG8PVG3iQoa4zhKBm6tpEc/ePTpN1/SsKPBxc+ELb0a+1FTnC2edCg2
 LENJmccMTrVQcnOq3fbpRThxnHKJqr6TyZHdCSXPPmjzIC6XPquUVijOv2RQQRdkd8A2
 g6r0ocon04XVVm++lm3Nc6AP51bI0DqQ+lXW3qN35sfFue9j/79RRVe1hsbdwB6HHJE4
 SN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608005; x=1791212805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nbRhMXtB7BKukDloXZytwXmgJXnfU5GIm5vjo5ReUUE=;
 b=Y5xddP5tFgTps7DVY7yHKFi1RFgXeUsj4tBnvGEJBqEDjtMj5uyR3BJK/F9DRbPPy4
 m003jYHJ1/gVFm2zcRdxl2wEsjs2+phjr3YkMzHa2XbEGhk7h9zZK+4CGcvw2U7cwENy
 76izR0/hSVwUyEcQtJbhxv2uTli+5OG+KOw8PTStbgaYRJiUfj5uSDiaz8wRseZkb2yE
 J1a3hSxgbALxusLyow/LZOKpqaKWlsON/pkAc4PZiNQE+OIuoPjKNftNarJYBQ07ChmD
 2qz9hizHlND1gvq+J3kRxpxo7uEXbiWu+tTFBvlnhmiHMcGNPJkKGz5+Dub9N7U7H0FY
 ljCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy07zRs7oftbBIpdv+INKYNt0lYQjEz2fY33we40ViAjn1o5Cyt3TSgjC9GJI7FyvHeo+ZT794=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ldL0Ok/JxK2qRTVVGMQ2SZp6iQyhG5gqLwiGYN3yXFHL6qjtgL
 SDxFsP4DRSaGNsQeAnHdKs/F8MBwRZ63k3kEEg2FwvqVzJKsKJrV7lUYabhlFZ02GLU=
X-Gm-Gg: AYBFou0HDvCKLvWPw5MjoXvOBeEJhSwgUJiB9JFcX4VsE3Tpx4IdVuFcYVlIJTDSxa4
 BScz0bd0nRDAbS0t3NWolGuP2wUS3DXJp3vwadKkwRHCEOjuXnN1qhBMzulj5zo7szH0IwjeB4N
 +gg95qslQWDJwv3ot9jMw1jiLhvRMOEsDsxVR06MyeYg4G/driVj/kriqLOC0d8uJ9ls6qoXuk1
 5JdOIRSsay6yDRvrq5VfOmuOIDdb3ny5jDh+aMKkzVH+Ea/2LHK0EMgfrAwchM4WrDIKKkeOXWM
 g8gv+obAh57b5juGednhFsPtAuwxtkCHNwI/QTVGJjRbz2DGj9dcnr1BCALryFrYmKIjKOEPDvg
 DYT4dTtdY4ak8eaMiDTWl4Hscq3U/f3M93ka6YcPRnY/lDzSxVjI9vuGUMkhpAB+DfUgl8RUW2f
 8kM5i7HDwD5ZCOjW9Q+ruk0xjtDOs9Jw/xujs7Mu2JgnVlICNzL5iNzLm/cpe/zYVjVkmCGf0Xw
 BwFY4RGiSxYuIFxFaq/BvFyffaF737MYt2J5jgAbIK89bc6kS1j8DfbnWx+0lMgk09DhNbF4RvB
 EMBbubiHxyF2pZ8G1h7/9rj26Xkj29xXYnQPPMmWkpJxEfgyV83JSOSZ
X-Received: by 2002:a05:600c:8b74:b0:49c:fc6e:a3d7 with SMTP id
 5b1f17b1804b1-49fe66e87damr214007035e9.22.1790608005460; 
 Mon, 28 Sep 2026 08:06:45 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:06:44 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:42 +0200
Subject: [PATCH 05/13] video: mediatek: add ccorr component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-5-212f51b1742b@baylibre.com>
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

