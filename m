Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5133CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 888B180ECD;
	Mon, 28 Sep 2026 15:06:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XX7DiRrlkTri; Mon, 28 Sep 2026 15:06:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1355F80EBB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608008;
	b=hdzIdEwfD7sWkWh6x+4w21d3T6uzYKsY2cJczuelxOJj0+MBTtV2PjO/jueae/IZu8t3
	 tWSExQiFhDsT6NWAq5crjGmw/5APrG16ICNlzGWPRf0AbsMNIG9YcBE6biK3XViHOqv8P
	 FEd6Izd8E2Qg7a4Q1OQ5iaB9W18uyo1EIlwAmj4YQ4V7MAKYRQYc+pnpOUL4GcUZllmwt
	 lyc94x3py5ukHclD98AUcj79SKpC/E74MBuAo4/sMbPpUsnaFbetn5yWKeSUJoqd6+e4v
	 oOxLYuuFPWHCTnqirG2riNfGSvKK+GqSdusMaNSqhR1H14Io6sDpR8XWkO76GQ+U1Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AClgjogaFQSA8zjJP/0IX0ywGu36jRnZT0QyqqSbHG8=;
	b=tZEi6fOp5RVGpT5a9AZitoHjRNlDRaB/FDjc1pbs8P77OQDbKFyZMHklmTpUGWRXM/DM
	 6sS4alEZsXAnvT3l3wUpvt7ucirBVUy2RQSmWAbq+przXdvbQWYzdavRAXjxHl7eTkd72
	 jt6uLr0oe8HKOiKifiUuSYOZEey9966xx+M9HxtyHwvi0t27o+4m1Q2Y8+hgzg1qQDIZB
	 g4iG/rF4hoVMrCDAiotlbigHuJGLsuIQUFZNaGB3p9Xq3IV87GCBD7CUQg0xfnZsXk9mX
	 zv9fmznW6zCrRm56nJizIIqXAnxgNPUm1r1Ftw9guWxhN9B9rZpLWQEwQMtAWFfM2bw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608008;
	bh=AClgjogaFQSA8zjJP/0IX0ywGu36jRnZT0QyqqSbHG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KHckIWogQ+eiKj65MUBAxAV7e5k1noD4Ye934q/OuxvfzNiRoNMr85Xj12uG+P1ji
	 O/vZ8+Lru4QG6QLwFkL4RU/Oa2/ccMN2yXQihoPRRBlnmvidF/o3mAG9Z1aHy0iDMt
	 6Yr/JtckLul/5wONF6D+STvamJZKubi4jkaiQhlh4W6U5jYQhhl2CIJKXewTZnIpMq
	 L1TjELMLOVxJFogctFdb2wp8G2W7TJTpBD409A+DIEqfb5v5Z1KZigPpTpAIhRyyW7
	 SUG2y9wQkU2EiFABkHchKQqdj4q7OtTZtBfCg5TM+qY+ecvrgOT4pao9Ho0BK/dpZr
	 lb49PdkekJKJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1355F80EBB;
	Mon, 28 Sep 2026 15:06:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3F6324E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A31B14069D
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vGuyLNrijiFa for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 82630406A7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608003;
 b=lXn4eJWlIB0uqM3y0XkSoE9FCCvnpHYlfeTAs28okcZNX3Bbg0WHPQA6UvvF5l+m29CU
 5VXFwEqNY3tTedMjGvYHa0EsbMMieMgyOZxhj7UtY8FvZxikKiujhw/cNUJGHG+bsEGnb
 pge4228RV8EHTl0b6Hj9U2YTUiROMTSlMOOKBJyZ3mL1a5W2QsXlt62Jm1LxB6GjjjESP
 jbzI2MIjUcV8EDATXIBouKb9+gyblpVPeNXUWbaN7tL7kaMbonK7/WVNBn9WiU38AXiwg
 NG/I1rBypSSpkCd9Odf0AXznSfKzA2RnnM2pd9AAj3/UBcGrDEKVQ9BOnEmGbx6iR1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608003;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=AClgjogaFQSA8zjJP/0IX0ywGu36jRnZT0QyqqSbHG8=;
 b=aapBkV79rSrV5u9n4pWT6Lc+MKJXpgXp4UVji2XHi85UQSYDw8QfwBY6aQu5bRDP0dP+
 Q9CDxU2zGTo5E7A8fRSF5s5g0HPR+etDHpWkv5BOoqWfYpVOzcZo5kun6ocPII9LWMDXf
 3QO9umGQlXaFaBdvZkjVup8KtjNcr3CJzbgJ+VTQluDl8+zflgs9mInxr6xuDT2GpS4DD
 qkurCTZKpDSGgT6lCRIxVd/KRe+jOGxcOhYkHquGW+9+O6XD1LkZCtMitEh8NBdToZbZK
 OFsuYh3kSfrPNuy5lhBxFCGGEERS0iBBAbu4cquYxIfzG6mJykZEgRMkZMz7i9YSc6w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mOayP4EW; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mOayP4EW
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82630406A7
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:43 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so30332815e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608001; x=1791212801;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AClgjogaFQSA8zjJP/0IX0ywGu36jRnZT0QyqqSbHG8=;
 b=mOayP4EWNzJiR+33PsvxBVer/Uk3pp4Sxf3VxcbiRl3JT2aCPAwmjZw2OWKscrLuSi
 jE2BUUEO+C5mLlRwFqkMY1KOcFUqtu31EvTqNZCMxsoxwIvxmBkw2YmmnFfFw4cVVGR5
 E8SrFO9Ight9toZ8WQMze87hrMrZ+qmhbLJGiBPGTigc7W//FjW/VSscB1/btmYToKks
 VRH3mRnaFih2fGCt6fF5Z2mUsKf/EqV/PE35U4QSFM31IUGjR6/WWv+ZKPbJJyPrPmlf
 5nbidirgmbQLQT+BVcRr4YbHz1Sd6zI77hzgZWk9zbzrX31gSTtq2O39ZE7hpe1qkz8q
 iZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608001; x=1791212801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AClgjogaFQSA8zjJP/0IX0ywGu36jRnZT0QyqqSbHG8=;
 b=LyQQgQDZfAN/2igUEhRo0s1SRwNKcCvnxLAY7+ARbS04m7TnAXhxZel6VwPUIsj4Oh
 XKzoXUxShXw/2G+7AV3yCZbMWaj5jdVt/T2ZO8od5P+olRPttLg3UMaW0nkVcrLRogbZ
 7Ek0kDofdvbKH3xWjuNBiNyEX6tBTCgdBiX6bcaPXCcOxdV+uj4qjYomExDZd+XfbiJW
 AeJY6cLrk0mFCJunqO2qINmUGBy2rCodgv4FKG6RkjXgEJs+FAout083ZjK+ijdp1o/S
 BbQm3AbmZWIMo7aINtwGT2SqNJTM1zCC4Mld+ELVeK0nVetzpV13dF9RiKg9f49SQ0Ms
 BScQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmrA+P2LkqNwfkOLcDRDH9Myg5okcibPOxUn2pfv6PojffoAT8nUYNHjwOfCbMB3FHdrRBlXs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kMyWp4fQ0wA3tO2ZPZXN2PYPpPSvoK0OuSywQapzOLdCmLkMJW
 SScfzCsCLcS6nLsMeESWZGsURSOOSzNmKEAP7w1UO/5WJ2j8tpZwbwyCeCjhGgrkrtY=
X-Gm-Gg: AYBFou2w3LZSH1kFyyAH/QGQ3KlrgpSiyLzw2RGS4kkzXXFq87BhNjox56dj+8tXdP3
 45FqS2qDudFlZtYcZNKRyIBx0TQiwZwfHj7jueJ8Wn2aoY//KMAg8W++B98hCkauxVtHugNHcxR
 EAi1V/G96I/Yy+fhACb3KqB7leVtKQDvdOpzpOskquZcQev382USTbPsMb5iX3d7jtmDaifFlXP
 l0uecLwj7VbYNQkaVpHc7hRWrqVq7ApAwmpqTDTjySPw/gT0Z+DZwzRWQVRFDgf2GOKIyMM+hYL
 Lg3LSObUvp60BvAGgl93/a8IvirTvcxPFNkpozlQSe9Vw4F3d3vKBcuRWcjiQ5JfY7rj5Wgx+/3
 iGTpDuJ29NvOoe1QGnwyAx2ZQNMcGRyjVFJZNx7NdTfApnhhWP4e2rjhMRPyoZHMNG9pSmPPLFi
 XxhFtwZGVXBu4Wv8fi/hvNpAxLjfAlN2gvCx1rouNH0sVOnBCQ6AWVVvEQ2U7gMC8DQ3MNUIv/T
 6G+2sEokCYgaWb7K0jxsBlkAVX+9FmeD5N7z8F0ZJofUJtoEpHjlQ4ev9U5iS9LhnILfmOSSwNA
 77dm2hSGGRs6gL4oxiSPit9Id+NClG6/h2+52nEyZPDQaYnuETaovxI=
X-Received: by 2002:a05:600c:c4a1:b0:4a0:bc1:8056 with SMTP id
 5b1f17b1804b1-4a00bc18145mr14684125e9.22.1790608001025; 
 Mon, 28 Sep 2026 08:06:41 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:06:40 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:40 +0200
Subject: [PATCH 03/13] video: mediatek: add disp rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-3-212f51b1742b@baylibre.com>
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

The rdma (read DMA) block is one of the components of the video pipeline
on some MediaTek SoCs, such as the MT8365 and the MT8366. It feeds the
pipeline either from a framebuffer in DRAM, or from the stream coming out
of the overlay.

The DSI pipeline only goes through it in direct mode, the overlay being
the DMA master there, so the driver programs the frame size and the FIFO
thresholds and starts the block, leaving its memory mode alone. The
larb feeding it is still ungated with it, as the block sits behind it
either way.

The driver matches "mediatek,mt8183-disp-rdma" and
"mediatek,mt8195-disp-rdma", the generic fallbacks the MT8365 and the
MT8366 rdma nodes respectively carry behind their SoC specific string,
so a single entry covers every SoC reusing either generation. The FIFO
size of the compatible is only a default: the instances of one SoC may
differ, and "mediatek,rdma-fifo-size" overrides it when the device tree
describes it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.h |   4 +-
 drivers/video/mediatek/mtk_disp_rdma.c | 154 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_rdma.h |  30 +++++++
 3 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/drivers/video/mediatek/mtk_disp_comp.h b/drivers/video/mediatek/mtk_disp_comp.h
index fbc2174352e..9e525521cc4 100644
--- a/drivers/video/mediatek/mtk_disp_comp.h
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -18,8 +18,8 @@ struct udevice;
  * @base: register window of the component
  * @clk_bulk: clocks of the component
  * @larb: optional SMI larb device (UCLASS_MEMORY), enabled and disabled
- *	  together with the component. Only the DMA masters of the pipelines,
- *	  the overlays and the MDP RDMAs, have one.
+ *	  together with the component. Only the components sitting behind an
+ *	  SMI larb, the overlays and the rdmas, have one.
  * @larb_port: M4U port index of the component within @larb
  */
 struct mtk_disp_comp_priv {
diff --git a/drivers/video/mediatek/mtk_disp_rdma.c b/drivers/video/mediatek/mtk_disp_rdma.c
new file mode 100644
index 00000000000..e66092c7799
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_rdma.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video RDMA support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/read.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/sizes.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_rdma.h"
+
+#define DISP_REG_RDMA_GLOBAL_CON	0x010
+#define RDMA_ENGINE_EN				BIT(0)
+
+#define DISP_REG_RDMA_SIZE_CON_0	0x014
+#define RDMA_SIZE_CON_0_WIDTH			GENMASK(11, 0)
+
+#define DISP_REG_RDMA_SIZE_CON_1	0x018
+#define RDMA_SIZE_CON_1_HEIGHT			GENMASK(19, 0)
+
+#define DISP_REG_RDMA_FIFO_CON		0x040
+#define RDMA_FIFO_UNDERFLOW_EN			BIT(31)
+#define RDMA_FIFO_PSEUDO_SIZE			GENMASK(27, 16)
+#define RDMA_OUTPUT_VALID_FIFO_THRESHOLD	GENMASK(11, 0)
+
+/* the FIFO registers count in 16-byte words */
+#define RDMA_FIFO_WORD(bytes)		((bytes) / 16)
+
+/**
+ * struct mtk_disp_rdma_data - per-SoC rdma data
+ * @fifo_size: default FIFO size, in bytes
+ */
+struct mtk_disp_rdma_data {
+	u32 fifo_size;
+};
+
+/**
+ * struct mtk_disp_rdma_priv - private data of an rdma
+ * @comp: common component state, must be the first member
+ * @fifo_size: FIFO size, in bytes, from "mediatek,rdma-fifo-size" or the
+ *	       per-SoC default
+ */
+struct mtk_disp_rdma_priv {
+	struct mtk_disp_comp_priv comp;
+	u32 fifo_size;
+};
+
+void mtk_rdma_config(struct udevice *dev, const struct display_timing *timing)
+{
+	struct mtk_disp_rdma_priv *rdma = dev_get_priv(dev);
+	u32 threshold = rdma->fifo_size * 7 / 10;
+
+	mtk_disp_comp_update(dev, DISP_REG_RDMA_SIZE_CON_0,
+			     FIELD_PREP(RDMA_SIZE_CON_0_WIDTH, timing->hactive.typ),
+			     RDMA_SIZE_CON_0_WIDTH);
+	mtk_disp_comp_update(dev, DISP_REG_RDMA_SIZE_CON_1,
+			     FIELD_PREP(RDMA_SIZE_CON_1_HEIGHT, timing->vactive.typ),
+			     RDMA_SIZE_CON_1_HEIGHT);
+
+	/*
+	 * Enable FIFO underflow since the DSI and the DPI can't be blocked,
+	 * and set the output threshold to 70% of the FIFO size so that it
+	 * never overflows.
+	 */
+	mtk_disp_comp_write(dev, DISP_REG_RDMA_FIFO_CON,
+			    RDMA_FIFO_UNDERFLOW_EN |
+			    FIELD_PREP(RDMA_FIFO_PSEUDO_SIZE,
+				       RDMA_FIFO_WORD(rdma->fifo_size)) |
+			    FIELD_PREP(RDMA_OUTPUT_VALID_FIFO_THRESHOLD,
+				       RDMA_FIFO_WORD(threshold)));
+}
+
+void mtk_rdma_start(struct udevice *dev)
+{
+	mtk_disp_comp_update(dev, DISP_REG_RDMA_GLOBAL_CON, RDMA_ENGINE_EN,
+			     RDMA_ENGINE_EN);
+}
+
+static int mtk_disp_rdma_probe(struct udevice *dev)
+{
+	struct mtk_disp_rdma_priv *rdma = dev_get_priv(dev);
+	const struct mtk_disp_rdma_data *data;
+	int ret;
+
+	data = (const struct mtk_disp_rdma_data *)dev_get_driver_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * The rdma sits behind an SMI larb, which has to be ungated with it
+	 * even on the paths where the overlay is the one doing the DMA.
+	 */
+	ret = mtk_disp_comp_get_larb(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * The instances of a same SoC may have different FIFO depths, so the
+	 * per-compatible size is only the default: the MT8365 and the MT8183
+	 * describe both of their RDMAs in the device tree, the MT8186 none.
+	 */
+	ret = dev_read_u32(dev, "mediatek,rdma-fifo-size", &rdma->fifo_size);
+	if (ret && ret != -EINVAL) {
+		dev_err(dev, "failed to get the rdma fifo size: %d\n", ret);
+		return ret;
+	}
+
+	if (ret)
+		rdma->fifo_size = data->fifo_size;
+
+	return 0;
+}
+
+static const struct mtk_disp_rdma_data mt8183_rdma_driver_data = {
+	.fifo_size = 5 * SZ_1K,
+};
+
+static const struct mtk_disp_rdma_data mt8195_rdma_driver_data = {
+	.fifo_size = 1920,
+};
+
+static const struct udevice_id mtk_disp_rdma_ids[] = {
+	{
+		.compatible = "mediatek,mt8183-disp-rdma",
+		.data = (ulong)&mt8183_rdma_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8195-disp-rdma",
+		.data = (ulong)&mt8195_rdma_driver_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_rdma) = {
+	.name	   = "mtk_disp_rdma",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_rdma_ids,
+	.probe	   = mtk_disp_rdma_probe,
+	.priv_auto = sizeof(struct mtk_disp_rdma_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_rdma.h b/drivers/video/mediatek/mtk_disp_rdma.h
new file mode 100644
index 00000000000..c2fe9228661
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_rdma.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_RDMA_H
+#define _MTK_DISP_RDMA_H
+
+struct display_timing;
+struct udevice;
+
+/**
+ * mtk_rdma_config() - configure an rdma
+ * @dev: rdma device
+ * @timing: display timing, giving the frame size
+ *
+ * Set the frame size and the FIFO thresholds of the rdma, which passes the
+ * overlay output through without reading DRAM itself.
+ */
+void mtk_rdma_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_rdma_start() - start an rdma
+ * @dev: rdma device
+ */
+void mtk_rdma_start(struct udevice *dev);
+
+#endif /* _MTK_DISP_RDMA_H */

-- 
2.55.0

