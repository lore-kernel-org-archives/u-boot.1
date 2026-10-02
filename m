Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE5ACA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 650E1811E3;
	Fri,  2 Oct 2026 14:01:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJeIli8Wp4eJ; Fri,  2 Oct 2026 14:01:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6C65B81339
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949686;
	b=E2T4yQyUAKY7DD9PS7rXqHBq21dD9+I1DUe2g7+MvXUkF7jhB6Z7eeCKuzWPcj3GV+lx
	 loUpd6bxA3cHKPTbaGoMLENR3KY7HFppKK8HhZQzZrKPKWctsofxXgqD3l6gdMp2cL6YO
	 whENeSDml4KeAGBme9pvldtgcc/J4Nk/p+8KkwjwWz1DwN8/3IaEmUB+KKU3HwEoqprdO
	 ohm50j51O37OhmZrSQ1CYvW0dKdcW1nbiDhHov+wI4pRLPfcsPD8Eb4Ek9J3zuLGPw5Rh
	 6rLerp+YUG+QCZt4YOAj/ODmFUfhAWTrWTBrgzkmF+DD+BCvQNtofJ3Vv4YAmVq4LFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949686;
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
	b=XO9ml2hk3xb8TDZvaFdjZO2oRNhh1jY8PQ9azC6UpzrM8spR5i91JelkumgWJuVgdepz
	 IkCR2Z/YNtlQTqrS3czVnuagj0hxL8IGBok6O447IKWxvt78mFlzHqFANeBQEeyY00Z5h
	 tJdA8VABoHqCmqOnmpJ/qnU7NsPWlG+Ir30WhKkRO4uc6WYGZxg2eE980W96ucSnJ/lbc
	 v1XfuFf1unWWk+KXiAR1P5cEHDYXDlr7iIGQZhtietf4ZyGAYycUbzwnyZ6Tr2dGqIgAV
	 b0DglgFzH4TMaAWppceG9KbhyucAQ6F4DCvJp1Btj0ru7RzNSf+KBGEHFga6+zlnrSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949686;
	bh=AClgjogaFQSA8zjJP/0IX0ywGu36jRnZT0QyqqSbHG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=chEw5Lub3MUUBHuw3XoofoaZU1UZapORcDLcQpGb4ycMkJEv5SBpiiLs4yIDyUR7b
	 xt3zYyaGP1TM4QUPsBEsgV8EY3tINzWvCB9Qpj1WbllV4a1R9fp8qivzBkUqtwb28v
	 Jb1jcCaoWyOIAdp3h6c633wvnL+fLLh+Eqeukdn9IAagFQ0EYMvLprWySElQiLh3AZ
	 ouEb8o9hAH8K225vc+0X+F+5/glsIIe5QmdLsZoy9TMpw+TR27/wqv9vwAiZYrZSdB
	 kKWSUdRuAfcS3ZAVAy6NPdEqHLBXI4JR5NcALkW5mMcZOSlNzSD18ryZgqyXisbVRn
	 WqdiCRwtxajsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C65B81339;
	Fri,  2 Oct 2026 14:01:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 50901435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41C4340D87
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oWO-gIxi30RU for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1D59D40D94
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949676;
 b=aRYZwQEMNSGGe3SJuAauLxZ2iuZk8VOiwZlYlGGK6IVwe97Kj3c/g7v3FxOz6/sarGIf
 VD2jbNZpgaaFxLK0zORLeyv43QD5Pc2RTiXMV3jxG9mgglLxvc5sXL6V/q4kLWfNLR6in
 9PsKTv1gWHHlLOAdhmNxqgulMpbcg09Vabp4fG4inGc97+DAjeLI/n0ui9FrJs4BB97IM
 l3LDueN0FlGWW4pxh9jpL1UdUwCEBrG2mx9uXc4eVPOmUhJN6XjQKs0c5EU9ffApEAavj
 Yje+Q+jDsTB2POFFqpuJ1P8hqlg/JQnPT0h1c4rR7pXn0ef09TKbH2JCzbb++9G30sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949676;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=AClgjogaFQSA8zjJP/0IX0ywGu36jRnZT0QyqqSbHG8=;
 b=YxgmiFhpDQJC/bzWYsuvJaRU1b40HTJY+1T/+GZBJ4NI8UNP5gANQFTXRRo2JllPhjzk
 X44D/RxOg0BtfKwaNHATuMyOGiO1v0tuZdS/P+798Cz4hTALZJ3Cssp7ZWLpy/3kK8of6
 eEvrQ3KlgnkGn+uaOESc5gUku1GIg9+hBAOY3LIp26uCJbDahFZhAxqoZj5ASom2Gc7Zc
 7ziM3d0I+Rd5sTvOO7mf5Fyj4d6lvZNAUB0xcSwjSnx1DIsCKYeJ6RU5NwtEf2NUzafS1
 lqGX0cWowSrSIcwQgFMq5B/Bf0Sn7Y2JEYU/LqxQl+nCDoiLWgOIbZzIGILQPpxClOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=b4mrv2qx; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=b4mrv2qx
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D59D40D94
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:15 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so42700845e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949674; x=1791554474;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AClgjogaFQSA8zjJP/0IX0ywGu36jRnZT0QyqqSbHG8=;
 b=b4mrv2qxHdBB7c0X+xc7IhZuXUQsPTlNHYmYzWHM94nYU3ByddHG6hkblE9xHsmd2D
 1841FBJbPjtmTw3u6Lr7Byr6zcq2K9WSi1QVIYHikHDqyCjLAiH3yBC+/MW0V6yl1GDn
 VFhx4AusNdcOeg2wPpl2aOAIHjEys1dXxqquK8Q6j+cHSVt0qxm3N1Pdbx0AZRFQ1nrj
 8siC7Sn95hKw4Wo2o+NMdT0FKuV+217t43uBR2/DzgQFPVSAsH3VdAUnmiRNHo+z1N2K
 iumCh7rBaCm9raAsEZmQ4LQonEu+bJYt7/7qC4SMVLKbwgVT3qKG5c12LwSWtjzuml5E
 1iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949674; x=1791554474;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AClgjogaFQSA8zjJP/0IX0ywGu36jRnZT0QyqqSbHG8=;
 b=ZmRVdwbeR5MXsObi5Ae/J1dtyASn6hbpZYHrCUzATfw7YXnjkHCMfEtf2A8K//ZhXv
 j/r5kulnWLW/82XlOAUnUVrlv7znE2cT3II5a1q9HBbcxP+ENXmCccgwqduslOpC+z05
 FCtC64iHo8KXfKla2ylDmHYxgofQGLCp7UzALXma1lClt0W4GLRmdq+dkxJXdWYtKPMc
 2nsB4QvdP/oxaGnvyUDo+MI/ESaAtHIbAxnZ2wQavvj2AIZ9zxK+B5FCG8nysvhTi3lZ
 uc2pY1nI2hfQY049qfxJIZT8f3TS3DJPmadPx7I9wpK8d+P+539PxC10cptATfZpcBHB
 D8aQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKO0Cod0zfHAUxi6A6V2GRS8y4sihtgJtCav3pPm/aA4ktP3RjUplCX+4h7VLPzcX9bagbj/M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nXfj7p1V7rZMkn+jDqsWi3UVYgzXHAwo7ndiFr+/8vaQMpSeKR
 QW3FRn0cVZW/LdjmKb2Plz84aeariy8m1XX0ZKyMLWPgN2QDn36nbHidGqC84o3H6I4=
X-Gm-Gg: AYBFou2IclQcEpmEGix3KojjeZfullQ4qfBbfEyVHnrQjXINsQ3zVyHr//qZePY/Xi/
 QCtMLtyjl+TP5tfSJcvVm54CSWRppMRLILcgJU/FnJKakshs5IdH2WtJSuRTD8i+dQgD9gfMtwc
 FK+xI1grtKX8wf5T320hi2zDSA1HLM3JaBJXWqCntXF5vzBQbz4x6D//z2bmlGRJRnUAY5up1CE
 9X9O4qk8lqRirgFOhe1zNkWTpOQXldJ97QtKmP8jGbxKUQpoDTdOFsNYx5bTmaN7qbEtFAtcT+q
 wyVFRNASjJpEY9+qh5b1vSKWDRbIzlEPmjJ1kN+Y3h/XhEgbQ/ippEulrGWmyR9ohMu8Ku7MT6a
 RQDruu+IMUL4pEOQ1Im06m839GVbSaSNt/FrJo2WYHhhgsMEbTfz3UNiIM4PSROCy98IqXRqzl+
 MxVGA383/NTABfUrXOSGCd9iyJxC7ATJVrESUk4hPP78p8gBqGyBEI4b3jMpZ21YG0dr7iGyW12
 b2ZWm7PbzKotr++tOotiJefqBFhpOMzk1ARgOBnUa37HLVqZM6+hrKvvdK+r0N/0v8ayxpS3WiJ
 IaP1OFTHQd38PH22JNRmubushP5d0+jFzn9hU9ObKlqOCHv+scnuQKY=
X-Received: by 2002:a05:600c:871b:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a0276cba9amr48202605e9.20.1790949672209; 
 Fri, 02 Oct 2026 07:01:12 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:11 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:03:54 +0200
Subject: [PATCH v2 03/13] video: mediatek: add disp rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-3-9e435457b90c@baylibre.com>
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

