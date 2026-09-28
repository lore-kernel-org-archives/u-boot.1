Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FA3CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2D01406F1;
	Mon, 28 Sep 2026 15:06:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZ7ZpjMdShBs; Mon, 28 Sep 2026 15:06:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D61FC406FD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608018;
	b=r3a+68HnE4IA786nZMrKfvaf5AUGSDCwFQiItB9tq0c0WZ5CyKWOpbXfvD6rr4rUbkyY
	 y8WBqJTcIWUkzy4zXPzzeY2RW3cehPTd2HGXr0rBn+1ZQnWLDbZO3aMKF7ZH+6VmQ9Lis
	 wpzTD8SlYdxwk2gChuZyL6HyKPRjCicFpsuWVUndjRzrmNHnT87nyzrF4aHdoGBeDxSLG
	 0pQWXvV8eQkrjmyTT6Jl6xy5dQQJ+Z1sGg9YDgjZLpWqippjl0UJlxdpachB68dHi004u
	 QGDR0rKES1xuZ5y+vO1KAWVUe0MqwvmSk6TZIparZi1URp89BE60N/EOhEdzf+k0Bqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608018;
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
	b=We9hSNtp85lbz7wJEAYFCDuIWKLrIv8t8jPgpEzmbQ0gR6JRWPgZspy7dqaob842FLRZ
	 BtXqMGu3g4U/2bA2hSfcxcDBGIxBEABDLomhWMXjg/i2YzfHPt5GY9UmiDlWcC0MjEPQA
	 1896dwSsyatmMKHjelZCwM7hs+1YMnc20GWKyxKy8X2m9GURsZNOEWUljypIb7b/Zj+Xn
	 lWioayFIaTlXKDuWQjJYajR3HKUtvb2aNS0FwkBBhoIrRHA6YDgSr/USFy4VohflcLej4
	 HeOyU3n67nkipV8M5WoU7BbOp2bmYddmcb4yduGlVxFOy79cv7c1rjVnMXxiPeISQgg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ErmUrjzF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608018;
	bh=8pP5+9D+oWJnYevj71PlImQNQQv7MMT4AE4lo6hu2I8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gMIti2Blw5hbPojBbQJpCoeMN2wRqSKNGh+5+y+BAnOAp6vMbD/ErB9t+2YZqe9t7
	 d9s439NgfmaD6EGtvh0ViaP6WfrBShFfI4XxI6R+3UZ4JcAc+G3zeHYnE4f+QWJ0xy
	 LF3Nep8KCYEUt1CvgMxJjX+uD2JNjQUdlk/qiEmatVQdVpC6cNcB/eF2NP3NBWenKK
	 HlfLL87QywZI2CuLRGwEpeDj7IeIfk3XD8ba3bryR4Ru6UamGxadOK5Fj0GdzC1OiI
	 al8gkG4krgtk+2Tmeh9EIyF+Wp7q+5zLCVggnFkB+hpep90ygQBtMxhPaQDq/tJTP1
	 FZFNhuUX9dhwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D61FC406FD;
	Mon, 28 Sep 2026 15:06:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D4639422
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B77CD406C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f6v0M_NfWVrh for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A947240720
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608014;
 b=TBalBzyXwSdud04ihlnz68OZBKJQIcY4GNM7r2QtfRVQdOVHO45OPqNq2LcUlq5Wc5F+
 URCb/MTDRmE0rEUd8NFAAAZ4hnCRnOv+qPTbcZZ2UAfzvQojHMKpq1uGVa0P6momad2SW
 dLz6SsBl+iYz9HNAo9fyw4lTspw/Ea0IIK4hKfR70jrsC0p5KIAgpplSKpEZTXopkuDwO
 hjpdAsaGepYy/1iXv9HEoVZNRgQ7V1VHtav4nZyI0zu6ujCHP52yP+srjCqUVUhAj5Auh
 q6rcOZziOZkNcPThwZ4wjF+KnFlVsHJFVd4qGE0f11RWPNnaC+H/j59mu/NsO7HxBVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608014;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=8pP5+9D+oWJnYevj71PlImQNQQv7MMT4AE4lo6hu2I8=;
 b=bL9QNOQGn/qOOkwGAqee4JGGat/EklFewLNgaPEIvMWc1O02+5aPbQxhyvfFlyDwYx7l
 6WTIytuHebmPC4pbaztmVezIonEp6tbAcCPetl3O2AheQFYY9AoFSPFmMoVcw0WFhARxs
 vmJ82M8Hhmyq/Qhf5523ZcRV+60OWWADkLMvasxzLuhM5SGjoxiaE5TTJLOlngvqyC+zd
 JXZlB55l7510lmvqhiuvM1y3FVhTtnPaHV2y0tlqf7fz70wrthc9/b4lz9E4GgFl2BaSy
 Ifh7Bszsk8Q+IMNL+UWIQfPfqMeKxyh+aGynd93vglnarMF0DaRr5g7j4wjN7RsJIpw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ErmUrjzF; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ErmUrjzF
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A947240720
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:53 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffde3cec6so9390265e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608011; x=1791212811;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8pP5+9D+oWJnYevj71PlImQNQQv7MMT4AE4lo6hu2I8=;
 b=ErmUrjzFqaG8jI5tq4hQH2p0Yq8E+WxYJHLcb9Ep6f44HMiq5LGbUwPnUozA+DpjaB
 dOaIySJAVwiikT64sR5JGCFhMRsqcaDCUpsTcT1tsLPqgyJGdxkrXldBnBBj9BZ3oua7
 DntPfnAw/gv3okRG082DB6bBM+IbgTMrHHkLpR+B1RQ4IWwnt2bwPVTOvhx8+fh42pKv
 1blphoCFjwcbomhTiJwYG8AfRGSDbY5vletbE0m5kom5QkEkGv4Y1p9LjtLRhjJuuihf
 Khym3Sg9EQc5eEty5vgsVwUityUJXBeQj/taXEEeqUVnGDxRl4ppfbti/tE1eB8lISpL
 WQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608011; x=1791212811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8pP5+9D+oWJnYevj71PlImQNQQv7MMT4AE4lo6hu2I8=;
 b=2Uh4GjycokbWPYhY2Sk5/SkFKNetd3vQN7YEU6A2JCCf9CGDPn8524gLaNqlM017F3
 G1rEQHZMHb7HswBljJUoYgd2QqYKv6Lf523RrfF9YjXvFjoBr8cMkB44RdbROq0tWF1h
 N25AjVg3ybbR6ajivpW6SpjstZWjhoudmw7BXsZrcYCojPM15LyWdKxtbJRMzsCdh8J+
 FKY8CAMsg3T6I0tFjJwVqS74xOuQYbRmkrQYuFnx9Nr1gcPLwptKAOeVPF0w+aoKTVRy
 5sdxmsDWz4IJwvUnkSSXhrYMcclrzSCmlMOQq+FE6zduXWpzUgFXREoR+bvub3gYqQkc
 xqRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcDKQvEsYZilh+qsZviXjJM938kdnBh7tFneJkOmy52Znz1yxHT7sz8FEF5eDT8yYUUmfRrkY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ms2B2cC994ZG7gh/0KbMjSMocZPONYtNe6wHd+Lvz0aSz8y16Q
 /LJFGltvyqIAE62o8EMDatA845dFLuCUNeAk1w0gpxC+/37B4i26UjDuLcClJlUt6bk=
X-Gm-Gg: AYBFou2BLVURJW6jJY2rRkYjCpRmeod/w7s49jE2FTbv9Nr0BnVRytR77EXqVdKPNzB
 SU+K2g8SY81WGXtJa1T5coDTmB2qjvPYSPhgBV4z2lwfg/wnuy5qYYFI2Scn+LoupjxBeKula72
 A+Enck72GsQz7vmWS6Acwnl1BF3hLDo+L7crSBHd9YjZSerVxowAoVytO1ZsyrKs9z0uomDBkQr
 JQh7bNK0b9rjalv0a9Mbksv9cI2bxHgNcyocKVWAukUL1M0irDkHjDN937M8/lHfyA3To336f6o
 X+Ts1JYEHTuHo/GWUWAzLtocMzRgASS6difDqSiLj5TvKjW4tIlE9fgndl2juyZZnvArj+23ULl
 0f9vG2u8Lm7NuhjW6y3a6uAgvZLZMClyWrnGV2hfJHOFsGMNYCPxBSvMjTtAVviGfmq+Z5UuRN7
 qfFloi8Cn0KMIPfZGC7RAr4+h8fPJj17jggcBuZt7x7na3UYquuPL/wPLMID2/gnHXBa5gzUd8+
 dn7LR43cZeoMh1Xr6mOwVaDCEkpTMUujO9hnoXVuXC9yF8ThnF/46Kab1F2ZQBPyzIeb5tzQJf9
 IipzvRacF1LKaVLdxHfQYgHI8/Vjg4aJUwtKsCFq3JpMRnnad7pRNJc=
X-Received: by 2002:a05:600c:1d0d:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49fe66f144fmr240184985e9.16.1790608011567; 
 Mon, 28 Sep 2026 08:06:51 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:06:49 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:44 +0200
Subject: [PATCH 07/13] video: mediatek: add gamma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-7-212f51b1742b@baylibre.com>
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

