Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE18CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFD2460D79;
	Fri,  2 Oct 2026 14:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4H84k20zYoBs; Fri,  2 Oct 2026 14:01:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 163C060D4B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949698;
	b=c126GcDADeMSuQEHKTXtIWkUSwiQ+fRVrxshrLqoU9yPJgghj1QrUOXslPNZfFkIJLQf
	 KQCln+J7Y2Zb2VsSMCg745ozTk0FAJcsJ+9z5yfLXvc9FOW+kMfaIGoZkTjjmSQ0Go/dU
	 pvikFpAa86JcYpwkplF+5FZnsfr7KA6ZfXSGpErrn/BGf9UZSMeZxPFWYbuuRvj8AUwBp
	 4x6BqWMoRv66C9CCZpvGyZMjknF7NZyKUStX62wT6uEf3Ab8K7js2j/MaaCZNQqu6Jmnx
	 iRKe/WufBhG7uBA+3hIklLF4HxJKgmbYcLwsqm9Sjpa2OgHgxfZNOIYcl8HcaamE5Lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
	b=f2Gidn+cK2X5vYj0hHb8GNeMf2eZpU+A1qpJ7b0qs8wNwQaIZHSfYcm4Iid/rXUV47aY
	 BhnVrSNgeriYhsw9gDxXhSviINmrKvHcvo3uFmmIy4J1d4GqnmOnWovl+K7PDcjrwbdL/
	 kJlxwZmkx3GQniqpXi9J0NZ8iUz51ysUaojx9Koi2zvWGvoCy5yXZHoebYAbCUR5VuiVw
	 7k9Ph2AU5Y1b49PqRmWWO5g65yf0CW6v8sTC2zWuGrFrBkHc7pSR41bzjydWhScBxs8jt
	 aZI3jdNUak7qJmguB7qgVnnTYQ4vZ478SDNhEyeU7FQI8RRkkVg1i7EUGzeQqXJJI9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BNpXV4H+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949698;
	bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a2yZHgQZ7P4YqMq9EJokCgzVv2HGfP6rFcCZe4CEPvA7pS4qLNMRqo+m2ESvgdiJe
	 pBAEG1ViYee4UlCQkLy7mZUxF1PVUdAjVDt43IjSZPmeMPT8bZQT03bfQSYVJmipyo
	 eU5EJ9EWT3nxvmHfRtbP0/9WF6RPeGLvgvlY2DBhxf4LTe3W5glus4OvpmyZIA7Eym
	 IxWdupX1UCRPq+sYFu0TTfQQqLBUG0qi/03rtc3ZhgBcSh4XaoBQZ6MEEgULq6Q+3U
	 bk+9mMGg/kumyESxNj1ARnLtPCPEO93kxzl0vaEwQb39iakRUYK2+meS5uVRqQ1voF
	 PDr2VrG23xAuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 163C060D4B;
	Fri,  2 Oct 2026 14:01:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A7B9E34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E1A460D79
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-DwfBbfc1Gz for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 806D060D70
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949694;
 b=dgQk8MKvbJ9BzlWSXEaaqKtpDIDKy7xJ8Ne/bcdeFWzAVP5vj9bb+fPbvQ12b7fx5sHG
 yOowW0MAjjF8MYkQzWeAOCCY/fUYJFSRLxt/EAyLA7h7XiLmPL0UG/pPYQP0ewKiovad6
 qZ0bgcMDNcIZQ1Sq38RDa7d5UM0FwFsGG2c5YOxbu/FMcOmX4bJpDKlHY4xYnHNAd0ks4
 +i4gygO0wLZhqjZDIHGMKmfgT6Rix2Z1FfUcfHSdDT7RUa1NIzaLgU17EuWPBzXEdL51I
 XZlBPxmwhShWpiHEHJ25pq1T4fkJ0nUU9iL8wVRsQn0SlEFcWF8QD234wKo81rfLKlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949694;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
 b=KyTAo0KKSiao276GtVRr1VlRw6CluvnUYU7rYuB7czwODMpSMxKjDL3hdK3VQbq6apyl
 gI52sRHyyd8LG9s7xu2l57W8T079OwibdjV0PNHZ6NTOmAa36sSImI6rykPcPsQDraX+/
 lPiDPkZlGsiVwSD0BZT3d11XkrCwOYd+lR/HGaT5rBkG8SlFiyQNV1vagD0X+swCYrQZl
 u6qiHAwkswqvrvKFcK1IUYBDFoKPTgKPpP82if9pMpUNmMM+EgZXlAw+Lo18f/GWqIbim
 I/OdSB/dyR2Cqu/SU7ZKP3bMBCOWQXysbHplUOtPKuiBdjJwGV/Iuv0da1ZStJNQL9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BNpXV4H+; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BNpXV4H+
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 806D060D70
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:33 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48aff58e6abso1760999f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949691; x=1791554491;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
 b=BNpXV4H+bB2pexzGOz80rNQIK0/rjNop07rUVVHYkyhBD6wMzkel49S0hfATT2NkJJ
 LCdS/Fglc46beRzM+3KCozPzvfIO/PaBrntm+mTwGhkt2+d2LR9x7bNR3woT3M6d7o0m
 r76UxFP2BO0ahsVqDOKjH/UvwjNTkV8gZSXVeDXWwAWOHvkou2SWnViXPgZ7QTS2U7eh
 L0P00fAtN4D+21xz9fEQOeZjm84e0hf+YPhlJ8SN69eKAsNamo6+7pdTx+Awk+sY5Chj
 xclnP4Mr4HKt/BJj8G9toAg3SSvShFHVlSWAWP1GC/TV0NqtmwV88qk4rRhwK80JwxPT
 KSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949691; x=1791554491;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rwonvp9Cvby25/84Kv4JvVu9NKciC+1BVG8KUEiRjnk=;
 b=PpBXNXDjZFaWovXwHl2sFy2LBvQXgAMfDvCdsoQOYeTQjKNf9K8x8ZuvJArUKJzf6l
 JZmze2ts6l11Y0muUPMl1Xx/tRD2wrs1Hsov8EBlOug0J90Eff4U++GI5VOP4iMN3sd1
 8V5ByJJKzgQPiMBIiYTA7Yj9c8Com/0aPQPntbTblGw33FLvzSm8ydHwTV4FtD3quZKJ
 ha7KgUQRcrGjOknzke4M8wdjJ+fpxORdyZNCEvxnN5BJppZhE5kCXi6HuHjsoHwpTYae
 Dr4/USrWbT+e578mJv2Zgfd6wnElN0J21ecE9cua2wpFhSkiApypf8ToXoU1KeMhV3bt
 oJKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/OI5e/T0K5yXTd32yvVwsZr/htEXLFQal9frTIvHP82K9uNSYnrKSK1WN5yl9TbRAGj95Vq4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI30EUwFfL8RUf8ww5pC6hSfvjX9Fy+TsYU2xEfChmIMCBdGUxW
 7ZsHghP7r69Ic3PN6wxl7EVYty8MLZRUeAnje8UUSHZO+O5btKdm9xBUDGBICCRIFW8=
X-Gm-Gg: AYBFou0bsgKNU29e37AKpF1WRUi3ObbFVAN6uhDHgvDBB7v98Exzv3cJk9EsHcAZbQH
 g64YS/wedVVxMmWy4TlkdBVJ8TVDa1dzY+i7hBOosbdp6MZdm4VQTZQCZ5rH/veTH9FeVF98KkP
 tVvkleVcaTZ1de0rBW8qmffCZa/Y/sq2txFx2tT0G5uE4Xoefe7NWboD0yhal8j7axbTWq0fNfu
 yBcf4s50C7tq9LcbwB4M6H422+gLPGOAGRDpIsEh2ld/fGpa0lqL6mjRn7uwAxiRRZ4tq3ibvUi
 HIFxZ+TWLh4u+D8M8DoMJ3Cjdu8GfNXIF1gh+rdG2uWSRWD6bCOSLR8j2C22jhAbPVlmfsDT4hM
 GgRHoRAzc8m65F1I+DIEqdG1r1L/H6cb1jJPW4H1mRO5fCsRv+ParyMmP3c1CjEavibJLeUols9
 8fJizfOpKxDHca1jqjkdpOXaBg4seW/zD0XYGvMU2BWwDlyHN0kPQQmdi3ZAMzp3t/5xeNKl5Jo
 C0f8qngjVYDKeD0rrqedgkRZ8j4lfhqMfayj4UZoW/o1m0gNwnjujcHwu9YvN0eCsTNd88wcQlK
 k4XHyE2R3lGLKwSsDYyE1czwjnQs/E2G2jMvhUnrvDSCSvaJj9iz2A8=
X-Received: by 2002:adf:e009:0:10b0:48a:fcec:2a1b with SMTP id
 ffacd0b85a97d-48b1272d365mr4070509f8f.17.1790949691273; 
 Fri, 02 Oct 2026 07:01:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:30 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:03:59 +0200
Subject: [PATCH v2 08/13] video: mediatek: add dither component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-8-9e435457b90c@baylibre.com>
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

The dither block is the last of the colour blocks of the video pipeline
on some MediaTek SoCs, such as the MT8365. It reduces the pixel depth of
the stream down to the bit depth of the panel and spreads the resulting
quantization error over the neighbouring pixels.

The pipeline carries 10 bits per component and U-Boot always drives the
panel with 8, so the driver programs the block as Linux does for an
8 bpc output: the frame size, then the DITHER_5/7/15/16 settings of
mtk_dither_set_common() before enabling the engine.

The driver matches "mediatek,mt8183-disp-dither", the generic fallback
the MT8365 dither0 node carries behind "mediatek,mt8365-disp-dither", so
a single entry covers every SoC reusing that block.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_dither.c | 89 ++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_dither.h | 32 ++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_dither.c b/drivers/video/mediatek/mtk_disp_dither.c
new file mode 100644
index 00000000000..51ed69df011
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_dither.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Dither support
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
+#include "mtk_disp_dither.h"
+
+#define DISP_REG_DITHER_EN	0x00
+#define DITHER_EN			BIT(0)
+
+#define DISP_REG_DITHER_CFG	0x20
+#define DITHER_RELAY_MODE		BIT(0)
+#define DITHER_ENGINE_EN		BIT(1)
+
+#define DISP_REG_DITHER_SIZE	0x30
+#define DISP_REG_DITHER_SIZE_HSIZE	GENMASK(28, 16)
+#define DISP_REG_DITHER_SIZE_VSIZE	GENMASK(12, 0)
+
+#define DISP_REG_DITHER_5	0x114
+#define DISP_REG_DITHER_7	0x11c
+
+#define DISP_REG_DITHER_15	0x13c
+#define DITHER_LSB_ERR_SHIFT_R		GENMASK(30, 28)
+#define DITHER_ADD_LSHIFT_R		GENMASK(22, 20)
+#define DITHER_NEW_BIT_MODE		BIT(0)
+
+#define DISP_REG_DITHER_16	0x140
+#define DITHER_LSB_ERR_SHIFT_B		GENMASK(30, 28)
+#define DITHER_ADD_LSHIFT_B		GENMASK(22, 20)
+#define DITHER_LSB_ERR_SHIFT_G		GENMASK(14, 12)
+#define DITHER_ADD_LSHIFT_G		GENMASK(6, 4)
+
+/* the pipeline carries 10 bits per component, the panel takes 8 */
+#define MTK_MAX_BPC			10
+#define MTK_DITHER_BPC			8
+#define MTK_DITHER_SHIFT		(MTK_MAX_BPC - MTK_DITHER_BPC)
+
+void mtk_dither_config(struct udevice *dev, const struct display_timing *timing)
+{
+	u32 sz;
+
+	sz = FIELD_PREP(DISP_REG_DITHER_SIZE_HSIZE, timing->hactive.typ) |
+	     FIELD_PREP(DISP_REG_DITHER_SIZE_VSIZE, timing->vactive.typ);
+
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_SIZE, sz);
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_CFG, DITHER_RELAY_MODE);
+
+	/* as mtk_dither_set_common() in Linux */
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_5, 0);
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_7, 0);
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_15,
+			    FIELD_PREP(DITHER_LSB_ERR_SHIFT_R, MTK_DITHER_SHIFT) |
+			    FIELD_PREP(DITHER_ADD_LSHIFT_R, MTK_DITHER_SHIFT) |
+			    DITHER_NEW_BIT_MODE);
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_16,
+			    FIELD_PREP(DITHER_LSB_ERR_SHIFT_B, MTK_DITHER_SHIFT) |
+			    FIELD_PREP(DITHER_ADD_LSHIFT_B, MTK_DITHER_SHIFT) |
+			    FIELD_PREP(DITHER_LSB_ERR_SHIFT_G, MTK_DITHER_SHIFT) |
+			    FIELD_PREP(DITHER_ADD_LSHIFT_G, MTK_DITHER_SHIFT));
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_CFG, DITHER_ENGINE_EN);
+}
+
+void mtk_dither_start(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_REG_DITHER_EN, DITHER_EN);
+}
+
+static const struct udevice_id mtk_disp_dither_ids[] = {
+	{ .compatible = "mediatek,mt8183-disp-dither" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_dither) = {
+	.name	   = "mtk_disp_dither",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_dither_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_dither.h b/drivers/video/mediatek/mtk_disp_dither.h
new file mode 100644
index 00000000000..019e6c954bb
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_dither.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_DITHER_H
+#define _MTK_DISP_DITHER_H
+
+struct display_timing;
+struct udevice;
+
+/**
+ * mtk_dither_config() - configure the dither block
+ * @dev: dither device
+ * @timing: display timing, giving the frame size
+ *
+ * Set the frame size of the dither block, and dither its 10-bit input down
+ * to 8 bits per component.
+ */
+void mtk_dither_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_dither_start() - start the dither block
+ * @dev: dither device
+ *
+ * Start the dither block.
+ */
+void mtk_dither_start(struct udevice *dev);
+
+#endif /* _MTK_DISP_DITHER_H */

-- 
2.55.0

