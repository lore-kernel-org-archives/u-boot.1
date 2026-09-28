Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C8FC9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD80040740;
	Mon, 28 Sep 2026 09:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nqRXiVR826r8; Mon, 28 Sep 2026 09:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AF5834073C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587069;
	b=QHBqncuqFhaAPuzSlDqsY3/Nd8N7qW8qJwPs3Q1E331Y51dCeDtXJrjUyzr282uO/ry5
	 61hGVyw/sPE4PcXTadINvt/QtqhmCkyYXLumooWRIBJOb4NGihjiq3v92lr7S6DopmH4Y
	 wpu7C31mg5QRTdlpKseHjinoeEEzxk5XCeRVuhiA7LC6T//rpfQVpR+cS5NkCUSMv1Q1R
	 hbXJi8+B/GTtrNgRg5FPNNg8QH13Shm8FFtyH1SVrNM+3npWPSgLYTKNNMCE84Uaw6LCj
	 qM1CLrfydBTajonHCmJfL/UQBIPCER5bsINaSPt6wWX/OR5n0dNfLW9B+dsjF8FXekQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
	b=j8diSYSvDx+9mzi0sVZwIbLOICneavcYfdVspe5KdRg4UXKrm5fcOSO2lI+S6xXt3t3T
	 vlZ0Y6DDm3S9szwKg5vIqhLZXyrAR8QxlBlS9T1TjDoWiPgRGUSLQAGTzx0kdekXUoc/u
	 /dvUb4SHZBwooybJCkPC56SdL/TwQWGMs/c7Kd6elZwsEYwRir3rH1JxO791jWY2dNkb0
	 Tn+yY+p1X1gnb9DsA5RDNPdbsjY0zgs1xi8Xi3fQ4XmoeQNgLDtn1sx2TLLPZUjCcrcfb
	 fapV5A/MTR76553YAhIC2fS8bC3KC353d0qk5MA9cJVu2lMqYx0ZKgbJQe84yxI5CJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587069;
	bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eBArYeYRk6sPiE1aYA6da+RlKeZ1MwkY1M9y5bqKY230CbI9sFlQqk+Xjtnm+04qK
	 naGcV/2FPBS4EMxVocHkpUJVTZZA2Dc5D+wRUh6mYZPukxnxFbubKPs/0lZoACltUR
	 LIx9DFTwBn2bAkRBCOTtCfRMgu/BC1qMvSzGFszmlyIiF9lAy2s155J1+mAU0csca+
	 X01DA29wjb2QCUN0vbevX/NT35avyPE/O8KBj+4sMKyVS5PeyPcu2Puppa7pyAfaB5
	 Voc1MiOoqP6+bewitymR2Ex2HzTIlwSFGr0seHT85iUrbFoh4wVir8XZQKqQeOoS0J
	 f8OH2es1cxk+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF5834073C;
	Mon, 28 Sep 2026 09:17:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB8742B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D81B40198
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6WnZ_hxY-AV1 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7485240194
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587061;
 b=sGX1zQ00czqRZyiWfyFthrOjYFVmy17LGM/cMf6aGwBKNsQ0Pvkf3v1U12xkSv6BuqDB
 4wS2N4yBGU67znnEknUsxBYD+QdmwuzrmEjcnb0hG2d4aT5Pjl6QEGQVxd2dtm4seym9A
 JU/zLeTvUPlQERCqx9xVF8FaogyOejR6I9G5E7B7GP4311AZyUhWXw3lq3sQYMgsRyW1H
 l1jSsLtJdE0UCqsof1ZLIq699ODYMI9V4P0lZyPRrSYeQ4AEDi5jAeMBGlMV5Rs8Krp0+
 dzDi2j432XYGb+uLLoZ3LT/O1UfbMJ884M/2qbeN92xAJl/adHmHE/GvGxOSMvw3n3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587061;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
 b=D7v2iHngNCQZE6HbQZEfXbHHserM99ZZdNqAL64Q9F2bln3l1bMj7K8gOAHkAsfHMLcI
 hUudSzfV8CVHNPNfsdraeF9Beq1syJZE63RAuXwILhIc8ClkuMKw7Mh167NMJzqExLnvU
 xsPtsGnZoE6jDP8aWMOHFkS8C4ny+tF8ap42JTV6t6GUvc2RhTxLAZrj/hVqLMziFqP4b
 qL8qyUTPnEwfXpaZBOnl2mB2Cd3lPWWZwuIjX+Iq8sxesDApXN7Y5d41bMnlrGmTellYB
 RvXgZNIrDMozxcO2SR2Xj/4xLirvHz+kXZ6KcMOwfi5XUGa7CnxYKAGO+x687YgV6oQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=W1Izivfy; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=W1Izivfy
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7485240194
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:41 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48439feca17so2110820f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587059; x=1791191859;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
 b=W1IzivfyvD1PDtItjK6z10Yy9au1y4tQ9sY1ytt/3vadvCtgUf3JsP0JHLRMby/c/y
 8/hKHETLXjiL7PBcithNsWnca7aS/bq2XknlZTdNhx5L5lA+8/xgWQ78lpZBN4KZMUI3
 xNcI4wGCh+XEDhMdZdYtKBHgWiCXCP7GDuj2urueMcD6T/3mLh7pn2VhkCL4RUNHFPGM
 vClvdcLvcOB0K1XDmt2FI/o5TlcH8sxNnae+oB1hgDotV8qOETtcHMp5Cs9HiyEQzLf+
 +FNDySSVRffz6DGfOgdkZjVn8lB8OzmslAC5Ns0VOqztyYuC6dDs8udgAznj0XS2VhDT
 TOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587059; x=1791191859;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QgM4r0ZBTnL7GlOmypVw5jf3PG/K08HXsjp8kTEZQcY=;
 b=2rpt1MD+IbmIuRBPrjHNXKyd2hHNoJcKT3IlpDegYacx96gAFlAvHH00icfHbvjAdD
 uysRHtIzLQjWzlqsqiRwBzK/ebWq2+FS2Zqjoi5XoLR8vEbz0uta9N0ifrew5Fbrjl+D
 9ngKi4MoV+IkTjrStAYTIRo2wWhbQ2GysT5xYzNmXaPTUIf4FMzFU+Gs0Tw9AtAGwiUe
 Nv5qty+pW7gfxg9NnxTqAk+raGtaOeMVOjdYhGMeBjwoBY8kapUq65TGeNK3ggdl9xgZ
 SmQeImLZNj/tes4gFp5oZtw/y5RWUdi4klmodxLg4E2+Wrkitr+idX3iPpAIVjM8ioOu
 NnUw==
X-Gm-Message-State: AFq9FYL2+sDdSdvO0dQUcnWWc+SemGAn41TE3XeZoHSOQWyZSKPXY0sk
 Pj5jFQ+HDV28OGCH8fCJ0NWcXFqBQDFEEnAjptrgKa/PGV6JKf0uaL//qwpp9WPZTPM=
X-Gm-Gg: AYBFou2KNIVtQiwjU1uQkwHxppO22hxDiVATGDraFrYTNHKXiQ6xRwFT9LWY/wMXTI9
 JFtylyLs0GVAZKog3fih5BWJsuJgWFN79iWBeDo65DglR8r7CTlzzR2q/ZNDLn9fLT3VjG8QBtZ
 osNeQz/AeV3qYNmzZpkoXuRBBAEXouEmUd+EcXZKulpLesb//7088XdZA6ab6Gxts8XesijzODu
 t283zy4NfWSlmHOfUWByafPKqpVJuk9TNOmyZZ89Ax7Wg5C1RSLnaYFZoGyUZS8kRX8uu0zfhKf
 iUqauoMmxpOg41IrS3HsoBuA3vHNZf8aAO3+JDHBHdV9ANincCsDrEEXqpGCqWfuC8qb/UBKVEq
 2NPY14aZOXxUnBf5TiMZMmVJ8LEyMsw2se//1QCwNqQtnMhD20UDtPmTOdVDQ+NLHpBZ/ZNha/P
 zFK26ZqUKfxMQ7b4gG14W/9lcQS4lMaUMsCyICfkOVtp4S2DF6A2DbhpgyMoQMxo/wMil5iEMGM
 9uoV0O/SJ1ZPWG9WdCK5DyZpd2j/eF1TM3cylx2pA8UOaoI5Cc1/lj6TNCRuKitiV+Wv2hVjX7f
 mVbctcXLpAt6VY106b0bZB/SROi77QL7/zyXvyOcvW1q2+kpKmpou6Q=
X-Received: by 2002:a05:6000:2c11:b0:487:b28:c82a with SMTP id
 ffacd0b85a97d-48871879aecmr23739535f8f.47.1790587058981; 
 Mon, 28 Sep 2026 02:17:38 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:40 +0200
Subject: [PATCH v7 05/12] video: mediatek: add merge component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-5-ee4a61a8ac1d@baylibre.com>
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

The merge block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. With two inputs it combines
them side by side into one output; with a single input it only buffers
that input through its SRAMs.

A merge declaring "mediatek,merge-fifo-en" additionally uses both SRAMs
as a FIFO, which needs the DRAM latency thresholds to be programmed so
that the block does not underrun.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_merge.c | 154 ++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_merge.h |  44 +++++++++
 2 files changed, 198 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_merge.c b/drivers/video/mediatek/mtk_disp_merge.c
new file mode 100644
index 00000000000..8898bdbd7fb
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_merge.h"
+
+#define DISP_REG_MERGE_CTRL		0x000
+#define MERGE_EN				1
+#define DISP_REG_MERGE_CFG_0		0x010
+#define DISP_REG_MERGE_CFG_1		0x014
+#define DISP_REG_MERGE_CFG_4		0x020
+#define DISP_REG_MERGE_CFG_10		0x038
+#define SWAP_MODE				0
+#define FLD_SWAP_MODE				GENMASK(4, 0)
+#define DISP_REG_MERGE_CFG_12		0x040
+#define CFG_10_10_1PI_2PO_BUF_MODE		6
+#define CFG_10_10_2PI_2PO_BUF_MODE		8
+#define CFG_11_10_1PI_2PO_MERGE			18
+#define FLD_CFG_MERGE_MODE			GENMASK(4, 0)
+#define DISP_REG_MERGE_CFG_24		0x070
+#define DISP_REG_MERGE_CFG_25		0x074
+#define DISP_REG_MERGE_CFG_26		0x078
+#define DISP_REG_MERGE_CFG_27		0x07c
+#define DISP_REG_MERGE_CFG_36		0x0a0
+#define ULTRA_EN				BIT(0)
+#define PREULTRA_EN				BIT(4)
+#define DISP_REG_MERGE_CFG_37		0x0a4
+/* BUFFER_MODE: 0 - no fifo, 1 - SRAM0, 2 - SRAM1, 3 - SRAM0 and SRAM1 */
+#define BUFFER_MODE				3
+#define FLD_BUFFER_MODE				GENMASK(1, 0)
+/*
+ * ultra threshold in units of pixels, the recommended values are
+ * 6 us and 8 us worth of pixels at 594 Mpixel/s.
+ */
+#define ULTRA_TH_LOW				(6 * 594)
+#define ULTRA_TH_HIGH				(8 * 594)
+#define DISP_REG_MERGE_CFG_40		0x0b0
+#define FLD_ULTRA_TH_LOW			GENMASK(15, 0)
+#define FLD_ULTRA_TH_HIGH			GENMASK(31, 16)
+#define PREULTRA_TH_LOW				(8 * 594)
+#define PREULTRA_TH_HIGH			(9 * 594)
+#define DISP_REG_MERGE_CFG_41		0x0b4
+#define FLD_PREULTRA_TH_LOW			GENMASK(15, 0)
+#define FLD_PREULTRA_TH_HIGH			GENMASK(31, 16)
+#define DISP_REG_MERGE_MUTE_0		0xf00
+
+/* CFG_30 (0x088, "12 bit lsb off") is not present in the upstream driver */
+#define DISP_REG_MERGE_CFG_30		0x088
+
+/*
+ * The DRAM latency thresholds that keep the merge from underrunning while it
+ * buffers a line through its SRAMs.
+ */
+static void mtk_disp_merge_fifo_setting(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_36,
+			    ULTRA_EN | PREULTRA_EN);
+	mtk_disp_comp_update(dev, DISP_REG_MERGE_CFG_37,
+			     FIELD_PREP(FLD_BUFFER_MODE, BUFFER_MODE),
+			     FLD_BUFFER_MODE);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_40,
+			    FIELD_PREP(FLD_ULTRA_TH_LOW, ULTRA_TH_LOW) |
+			    FIELD_PREP(FLD_ULTRA_TH_HIGH, ULTRA_TH_HIGH));
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_41,
+			    FIELD_PREP(FLD_PREULTRA_TH_LOW, PREULTRA_TH_LOW) |
+			    FIELD_PREP(FLD_PREULTRA_TH_HIGH,
+				       PREULTRA_TH_HIGH));
+}
+
+void mtk_disp_merge_config(struct udevice *dev, u16 l_w, u16 r_w, u16 h)
+{
+	struct mtk_disp_merge_priv *priv = dev_get_priv(dev);
+	u32 mode = CFG_10_10_1PI_2PO_BUF_MODE;
+
+	if (priv->fifo_en) {
+		mtk_disp_merge_fifo_setting(dev);
+		mode = CFG_10_10_2PI_2PO_BUF_MODE;
+	}
+
+	if (r_w)
+		mode = CFG_11_10_1PI_2PO_MERGE;
+
+	/* input 1 and input 2 sizes */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_0, h << 16 | l_w);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_1, h << 16 | r_w);
+
+	/* output size */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_4, h << 16 | (l_w + r_w));
+
+	/* no pixel/channel swap */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_10,
+			    FIELD_PREP(FLD_SWAP_MODE, SWAP_MODE));
+
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_12,
+			    FIELD_PREP(FLD_CFG_MERGE_MODE, mode));
+
+	/*
+	 * CFG_24 is the merge SRAM0 size and CFG_25 the SRAM1 size. In merge
+	 * mode input 1 goes to SRAM0 and input 2 to SRAM1; in buffer mode the
+	 * single input goes through SRAM0 and then SRAM1, so both hold it.
+	 */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_24, h << 16 | l_w);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_25,
+			    h << 16 | (r_w ? r_w : l_w));
+
+	/* merged sizes of inputs 1 and 2, only used in merge mode */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_26, h << 16 | l_w);
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_27, h << 16 | r_w);
+
+	/* 12 bit lsb off */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CFG_30, 0x0);
+
+	/* unmute */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_MUTE_0, 0x0);
+
+	/* enable */
+	mtk_disp_comp_write(dev, DISP_REG_MERGE_CTRL, MERGE_EN);
+}
+
+static int mtk_disp_merge_probe(struct udevice *dev)
+{
+	struct mtk_disp_merge_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	priv->fifo_en = dev_read_bool(dev, "mediatek,merge-fifo-en");
+
+	return 0;
+}
+
+static const struct udevice_id mtk_disp_merge_ids[] = {
+	{ .compatible = "mediatek,mt8195-disp-merge" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_merge) = {
+	.name	   = "mtk_disp_merge",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_merge_ids,
+	.probe	   = mtk_disp_merge_probe,
+	.priv_auto = sizeof(struct mtk_disp_merge_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_merge.h b/drivers/video/mediatek/mtk_disp_merge.h
new file mode 100644
index 00000000000..679d4c4c59c
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_merge.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video Disp Merge Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MERGE_H
+#define _MTK_DISP_MERGE_H
+
+#include "mtk_disp_comp.h"
+
+/**
+ * struct mtk_disp_merge_priv - private data of a merge component
+ * @comp: common component state, must be the first member: the shared
+ *	  component helpers cast the private data of every pipeline component
+ *	  to struct mtk_disp_comp_priv
+ * @fifo_en: buffer the input through the merge SRAMs, from the
+ *	     "mediatek,merge-fifo-en" property
+ */
+struct mtk_disp_merge_priv {
+	struct mtk_disp_comp_priv comp;
+	bool fifo_en;
+};
+
+/**
+ * mtk_disp_merge_config() - configure a merge component
+ * @dev: merge device
+ * @l_w: width of the left input
+ * @r_w: width of the right input, or 0 when there is none
+ * @h: height of both inputs
+ *
+ * With a right input the two inputs are merged side by side, otherwise the
+ * single input is only buffered through the merge SRAMs.
+ *
+ * A single input with no fifo just goes straight through, one pixel in and
+ * two out. The HDMI pipeline never takes that path (merge3 has a right input
+ * and merge5 declares mediatek,merge-fifo-en), so it is untested and only
+ * here for a future single-pixel user.
+ */
+void mtk_disp_merge_config(struct udevice *dev, u16 l_w, u16 r_w, u16 h);
+
+#endif /* _MTK_DISP_MERGE_H */

-- 
2.55.0

