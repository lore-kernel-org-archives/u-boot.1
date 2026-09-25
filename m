Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203D9C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBAED40CC3;
	Fri, 25 Sep 2026 13:40:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HyFICvB9gGzU; Fri, 25 Sep 2026 13:40:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B65FC40CBF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343652;
	b=M9/Mgl2ArxEWvGlfNXmuPlPP8iJUehR9yrq6qslAzIPt6CV+Oq1DazGLUilN+6M2w/1T
	 4MX9Aeddgox1FfxYkib6pN3av2PXD5z00vAz23MMcZ4X9+89fPbC4TEpjtnPv1LwoKqH8
	 fSQo3R2c73ithYZjeuY+wJ5AS8QNu/FOe1Tau/uMsym0bwPxcsEy9KLOLnR4zZemy60UF
	 KOOILsWv9XSRhT508JKZm7QcPHdsIY06VhnU+/W86t27BjUSWJW/4U9/m+xvZGAGpogoR
	 SziV33c3V+WlqVTOFNFfeyQY/9brx+vj89bhifCEcHnJRLXUgV1mjSQJgT34v6+GPHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oocQgrfQ01yOIc1PajZKx98kEZr3RiFUEGvHe1NoyrY=;
	b=OngLEs+ygqkH4GrxgV8vqoMbkueWJzGuc6FVwEMJleugJwj0H1J8xHxRTJg6uGltbxVc
	 2ZWsK5sUX+xeBQV7mTwNK9OPP4HrD+UN1Pb/+g0B0TyGAtZVoLgOy17kFwZ2E4ScZwRWa
	 C6AR30zAiayVKYKyfubdsGmrM4nTOHD94X70w9CB84jpT+0s5gq4DJXvmyZ+HDsOCifJX
	 QB1+ES3RHLHeMT1Zme6a3wY4QdC9UQmXCk5hxoD0GA8ZsMWdyhY1oWFXupeFWUfuTFWIe
	 Cx9eNJUWwNRpHR4wa46KYKqM6ngGEC6uFBxlpi1+vb98VlfdLMIKGKvn2xymXVx8BAw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343652;
	bh=oocQgrfQ01yOIc1PajZKx98kEZr3RiFUEGvHe1NoyrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DZnvcPBIkslSqmPLjuM8u3N6Bo0WZOkmzKS1XuhhzhJQYgIPEhIdFb3prFu0hS+iI
	 ZhjkqQWk/09NQcfiOvHEcRfncA7Rtok6Gk2mw4M/DnrV9iFQfsS0bw/JT6uDsg6c7M
	 8+u7k1Xs1brZvafJF4+KmOutdbULlww2wSJgp5WXx7K0h/YyupfVHHYJbqKHO0Q4fh
	 Z5jsgPrbSkJdC55uZJROpHWiZ+GkHQJtN1Ie1L1Oe9+eaKCXzaMJrIAJCFvs6h81fy
	 80f8yCqksqAapcpxHmvLcPug9KWD8Hm9Vw90JJIwl7ZQMGdasX05q1yatzEcppQmJ/
	 k+qCvl79demLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B65FC40CBF;
	Fri, 25 Sep 2026 13:40:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3184535A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2367E40185
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ILugvKfL96uQ for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F09A940180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::24"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343639;
 b=YoeJqWmNxvDaGcMLOS2gw7VrH/zNhadG165/Hr/DceiJLooJZzKtyBhNo6CqpKaqqCzu
 oQB7CVALIEwe7jDjWTUBmDp+xSekjJkzWyraHuBFyYCu3ZSxoydupCRj4U2riS2B5m74b
 KSfobbqWf+y7gdnTB1yXnn2jvZYvsQysLTtcyHR6IVsV4uJhWjSakVC/0JOODhy2hp1Vm
 tScXFvGdPxwGVuczo7p9atEf90KGDyRgQgRx9kIG2qYOEUPivfPuXcfm65ObxtPwlpnwQ
 sY38u9T1EBSB+4OJVhkvJun5VJ2/7LyZJ7uQazUPZCzd/YGWekx6/9D/Rh9cFceaqKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343639;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=oocQgrfQ01yOIc1PajZKx98kEZr3RiFUEGvHe1NoyrY=;
 b=O6pzLu+FnuwvNpCEpPS7MoSB93aC02jgSigmeW6852iqN0KT3LfU8d50d29bQG/jU9Hf
 JAvdVRNEQrw5ss0kyUDNmT4mzZOulm0KWYTsQOesLWFMIo9dT95Xh2fXfzs052d77iVMv
 qgsO43vFvMb51jDwudMyYPrRDO9RyWZ4bt93Zyngp5U9psWbWMNHG4RsCbEtphg8W0i36
 6PXrpFU3X+RpNGnVMzEXFPkB7bJiG0Fn80rVNwozvC2m1Gq4B126b3HAYk5q4jkvckaRQ
 /X+dYnVYz+BxE5aUaUp/FpJjTZHuXKiFcXk1FEqzcYS2Q/qPbtTfHMtW+cqcmqQtUEQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=T+dbUIag; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::24"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::24; helo=mail-wr2-x24.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=T+dbUIag
Received: from mail-wr2-x24.google.com (mail-wr2-x24.google.com
 [IPv6:2a00:1450:4864:30::24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F09A940180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:38 +0000 (UTC)
Received: by mail-wr2-x24.google.com with SMTP id
 ffacd0b85a97d-482f63546c3so716660f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343637; x=1790948437;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oocQgrfQ01yOIc1PajZKx98kEZr3RiFUEGvHe1NoyrY=;
 b=T+dbUIagBhpBRDAZPalimhbRdKf28Z0iya31pqe74wBdikc+4QSO+qapnv/gdzMe0d
 1Jf/ngQPvGbXT6/Ws1hCwO4PkOKweA+zwVJrI+9Q4EeBp94uSjaxsONvxR6xHI76Z9qp
 0rKsmnJAOUnvmhMUSZINIlkBknO9KN/CocG+wVeMTnlLqicVGJ0Ny3mPCEj0KEg1Csvd
 7eCwfr/lc2rPIrNFrDDsluI0IwGXcHj0pXeCyE2/2z1s1CknhFN0+XDVNQ7pszmu1qIV
 icU4hVwfrNTRWU6oWd4lOVPXtuUFZ8q1mf0BNq5rJ9JiqLdRAtDnJdE4HY/SGUKCqwgq
 mjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343637; x=1790948437;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oocQgrfQ01yOIc1PajZKx98kEZr3RiFUEGvHe1NoyrY=;
 b=FlXEdwfc+yySChVFXnj1LSioVBeMu9ZFSUMdKEnaA5XViUcomFix/CHVsQHCh3Exaq
 bKgmrHZ1n83ERYUl33U4UgDrHhYHr4RtKp7kfFrdrQErys6Maq8THqlZorP4TvOQVCrG
 YEx1oslFkEHrOZMNgGxoiMGGkSGTh8eDJzMwU5q3fZItQ7Wwq1fR674FHDSdjOyqaG1I
 d8xLe6fTyXblwfSsCTBwIcIxIRjFQDaCkKaOwTWbwuqVDeMlODzE79ELUkWl4a1CJDW+
 OP9uTFR2Osv3NKgQXKk4z7i/2Hj6b21StZTaEMOVyYeXKKJUzaUe929bqCECqfKFPZa5
 rtug==
X-Gm-Message-State: AFuF++loMUgZQ3cl2NoPgosDUbij33mYiQQdgzuIgiTXDQknlYquZqLL
 a6TpyEJYAyLVHSVqajIZswlqdL+D7Bino+5Ie1T/rC3R2fw2QsLibuB3HtD899wBfvI=
X-Gm-Gg: AYBFou0ZdSy31kHMw6hOM1zJFOu/OaqEzag+6FlChJSRjf+Df19MPrNzIasuYspslaR
 6hJplydlOHX2YJs2VKNkFrKR6FGa9o42IuyqvdsqaGDjnhiWNJxXmOjnPC4DMRdxjfX69u6MvVn
 ch/PtvA3BjzvYatXhmAb2Ny6/tzQWHGcrMdezlxT5BLkY1SPBJk7c3ls1O0BklrlzV1E98Mmvuo
 Lm+MkOe/HBCZb8dBDr4lwJw1+kWDHzhK8xxkjfoFDQluRrbK+a+NfoRm4p5ehfu6Rg6I0UJ3fXS
 yxQToW/zed5vbvYeUbHgMYwL+R8431K0bLjo3432/9QjkFgsE9JyAnPGRc4qQ4hDrreLPGcfLmQ
 a4ioR46I2UR7/90MRz4zWsQnjg1j9H0lSmbtOykCkuhQSbn6//zUT7PCShjaWjVdh572y6yx3sV
 VUw/HAdmEz2hmwdR+Y2sdkvgzBb6JwuVFnuellBaIoVRDC2xHEAg9LsZAYnCUiddLVBSdZ6C+mM
 m9yJ2WQt72ekwA6PCwOVxy/eIkk9OSF8u8gYKN6t5lH915/jThDustV2aZUOOcc7Umxd79VFPEe
 1Fy2966YDF8lYIGza9srr0Gag8/CHRBVOmDHPxkc1sC+7pea1T1qdJE=
X-Received: by 2002:a5d:5e84:0:b0:487:12cf:e65d with SMTP id
 ffacd0b85a97d-4887176eb38mr10535655f8f.38.1790343636492; 
 Fri, 25 Sep 2026 06:40:36 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:36 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:06 +0200
Subject: [PATCH v6 08/12] video: mediatek: add mdp rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-8-29e626b213e9@baylibre.com>
References: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
In-Reply-To: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
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

The MDP RDMA is the DMA engine reading the framebuffer on some
MediaTek SoCs, such as the MT8188. Two instances are used, each
reading one half of the frame; the second one starts at the middle of
the line (apply_offset).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_mdp_rdma.c | 185 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_mdp_rdma.h |  34 +++++++
 2 files changed, 219 insertions(+)

diff --git a/drivers/video/mediatek/mtk_mdp_rdma.c b/drivers/video/mediatek/mtk_mdp_rdma.c
new file mode 100644
index 00000000000..4664663b586
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video MDP RDMA Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_mdp_rdma.h"
+
+/* MDP RDMA registers (see Linux drivers/gpu/drm/mediatek/mtk_mdp_rdma.c) */
+#define MDP_RDMA_EN			0x000
+#define FLD_ROT_ENABLE				BIT(0)
+#define MDP_RDMA_CON			0x020
+#define FLD_SIMPLE_MODE				BIT(4)
+#define MDP_RDMA_GMCIF_CON		0x028
+#define FLD_COMMAND_DIV				BIT(0)
+#define FLD_EXT_PREULTRA_EN			BIT(3)
+#define FLD_RD_REQ_TYPE				GENMASK(7, 4)
+#define VAL_RD_REQ_TYPE_BURST_8_ACCESS		7
+#define FLD_ULTRA_EN				GENMASK(13, 12)
+#define VAL_ULTRA_EN_ENABLE			1
+#define FLD_PRE_ULTRA_EN			GENMASK(17, 16)
+#define VAL_PRE_ULTRA_EN_ENABLE			1
+#define FLD_EXT_ULTRA_EN			BIT(18)
+#define MDP_RDMA_SRC_CON		0x030
+#define FLD_UNIFORM_CONFIG			BIT(17)
+#define FLD_SRC_FORMAT				GENMASK(3, 0)
+#define MDP_RDMA_COMP_CON		0x038
+#define MDP_RDMA_MF_BKGD_SIZE_IN_BYTE	0x060
+#define FLD_MF_BKGD_WB				GENMASK(22, 0)
+#define MDP_RDMA_MF_SRC_SIZE		0x070
+#define FLD_MF_SRC_H				GENMASK(30, 16)
+#define FLD_MF_SRC_W				GENMASK(14, 0)
+#define MDP_RDMA_MF_CLIP_SIZE		0x078
+#define FLD_MF_CLIP_H				GENMASK(30, 16)
+#define FLD_MF_CLIP_W				GENMASK(14, 0)
+#define MDP_RDMA_SRC_OFFSET_0		0x118
+#define MDP_RDMA_TRANSFORM_0		0x200
+#define MDP_RDMA_SRC_BASE_0		0xf00
+
+/*
+ * Source format 2 is named after its byte order in memory, B, G, R, A, as
+ * the datasheet does. That is the same encoding as DRM_FORMAT_XRGB8888,
+ * which Linux' rdma_fmt_convert() maps to RDMA_INPUT_FORMAT_RGBA8888: its
+ * name only records that the alpha byte comes last, the R/B order being
+ * selected separately by FLD_SWAP (left clear here).
+ */
+#define MDP_RDMA_SRC_FORMAT_BGRA8888		2
+
+/*
+ * Fields used by this driver but not present in the upstream driver, named
+ * after the datasheet:
+ * - MDP_RDMA_EN[23:4] INTERNAL_DCM_EN: dynamic clock gating of the RDMA
+ *   internal blocks, all enabled out of reset (0x00fffff0)
+ * - MDP_RDMA_TRANSFORM_0[15] BITEXTEND_WITH_ZERO: extend the LSBs with zeros
+ *   when converting 8-bit data to 10-bit
+ */
+#define FLD_INTERNAL_DCM_EN			GENMASK(23, 4)
+#define FLD_BITEXTEND_WITH_ZERO			BIT(15)
+#define FB_BYTES_PER_PIXEL			4
+
+/*
+ * DRAM request settings, as programmed by Linux'
+ * mtk_mdp_rdma_fifo_config(): 8-beat burst reads plus the ultra/pre-ultra
+ * high priority requests that keep the RDMA from underrunning at high pixel
+ * clocks.
+ */
+#define MDP_RDMA_GMCIF_CON_QOS \
+	(FLD_COMMAND_DIV | FLD_EXT_PREULTRA_EN | FLD_EXT_ULTRA_EN | \
+	 FIELD_PREP(FLD_RD_REQ_TYPE, VAL_RD_REQ_TYPE_BURST_8_ACCESS) | \
+	 FIELD_PREP(FLD_ULTRA_EN, VAL_ULTRA_EN_ENABLE) | \
+	 FIELD_PREP(FLD_PRE_ULTRA_EN, VAL_PRE_ULTRA_EN_ENABLE))
+
+int mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			const struct display_timing *timing,
+			unsigned int pitch, bool apply_offset)
+{
+	u32 width = timing->hactive.typ;
+	u32 height = timing->vactive.typ;
+	int offset = apply_offset ? ((width / 2) * FB_BYTES_PER_PIXEL) : 0;
+	u32 fb;
+
+	/* the RDMA source address register is 32-bit only */
+	if (plat->base != (u32)plat->base) {
+		dev_err(dev, "framebuffer base %#lx is above 4GB\n", plat->base);
+		return -EINVAL;
+	}
+	fb = plat->base;
+
+	/* the stride register only holds FLD_MF_BKGD_WB bits */
+	if (pitch > FLD_MF_BKGD_WB) {
+		dev_err(dev, "framebuffer pitch %u is too large\n", pitch);
+		return -EINVAL;
+	}
+
+	mtk_disp_comp_write(dev, MDP_RDMA_EN, FLD_INTERNAL_DCM_EN);
+
+	/* DRAM request type and ultra thresholds */
+	mtk_disp_comp_write(dev, MDP_RDMA_GMCIF_CON, MDP_RDMA_GMCIF_CON_QOS);
+
+	/*
+	 * Set the source format. U-Boot's 32bpp framebuffer has no alpha
+	 * channel and the mixer blends this layer with alpha disabled, so
+	 * FLD_OUTPUT_ARGB is left clear as Linux does for such a source.
+	 */
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_CON,
+			    FIELD_PREP(FLD_SRC_FORMAT,
+				       MDP_RDMA_SRC_FORMAT_BGRA8888) |
+			    FLD_UNIFORM_CONFIG);
+
+	/* no framebuffer compression */
+	mtk_disp_comp_write(dev, MDP_RDMA_COMP_CON, 0x0);
+
+	/* set base address */
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_BASE_0, fb);
+
+	/* stride comes from the framebuffer line length */
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE,
+			    FIELD_PREP(FLD_MF_BKGD_WB, pitch));
+
+	/*
+	 * each of the two RDMAs reads one half of the frame: size and
+	 * clip cover half the width, and the second RDMA (apply_offset)
+	 * starts at the middle of the line
+	 */
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_SRC_SIZE,
+			    FIELD_PREP(FLD_MF_SRC_H, height) |
+			    FIELD_PREP(FLD_MF_SRC_W, width / 2));
+	mtk_disp_comp_write(dev, MDP_RDMA_MF_CLIP_SIZE,
+			    FIELD_PREP(FLD_MF_CLIP_H, height) |
+			    FIELD_PREP(FLD_MF_CLIP_W, width / 2));
+	mtk_disp_comp_write(dev, MDP_RDMA_SRC_OFFSET_0, offset);
+
+	/*
+	 * Simple mode, plus the downstream way of feeding the 10-bit
+	 * pipeline from 8-bit data: BITEXTEND_WITH_ZERO zero-extends each
+	 * component, instead of MDP_RDMA_CON's FLD_OUTPUT_10B used by Linux.
+	 * Only one of the two is needed; do not switch to FLD_OUTPUT_10B
+	 * when re-syncing with Linux.
+	 */
+	mtk_disp_comp_write(dev, MDP_RDMA_CON, FLD_SIMPLE_MODE);
+	mtk_disp_comp_write(dev, MDP_RDMA_TRANSFORM_0,
+			    FLD_BITEXTEND_WITH_ZERO);
+
+	/* enable engine */
+	mtk_disp_comp_write(dev, MDP_RDMA_EN,
+			    FLD_INTERNAL_DCM_EN | FLD_ROT_ENABLE);
+
+	return 0;
+}
+
+static int mtk_mdp_rdma_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	/* the RDMA is a DMA master: it feeds from an SMI larb */
+	return mtk_disp_comp_get_larb(dev);
+}
+
+static const struct udevice_id mtk_mdp_rdma_ids[] = {
+	{ .compatible = "mediatek,mt8195-vdo1-rdma" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_mdp_rdma) = {
+	.name	   = "mtk_mdp_rdma",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_mdp_rdma_ids,
+	.probe	   = mtk_mdp_rdma_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_mdp_rdma.h b/drivers/video/mediatek/mtk_mdp_rdma.h
new file mode 100644
index 00000000000..832cf8133c5
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video MDP RDMA Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_MDP_RDMA_H
+#define _MTK_MDP_RDMA_H
+
+struct udevice;
+struct video_uc_plat;
+struct display_timing;
+
+/**
+ * mtk_mdp_rdma_config() - configure an RDMA to read one half of the frame
+ * @dev: RDMA device
+ * @plat: video uclass platform data, holding the framebuffer base address
+ * @timing: display timing, giving the frame size
+ * @pitch: framebuffer line length, in bytes
+ * @apply_offset: read the right half of the frame instead of the left one
+ *
+ * Each of the two RDMAs of the pipeline reads one half of the XRGB8888
+ * framebuffer and feeds it to the mixer.
+ *
+ * Return: 0 on success, -EINVAL if the framebuffer is above 4 GiB or its
+ * pitch is too large
+ */
+int mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			const struct display_timing *timing,
+			unsigned int pitch, bool apply_offset);
+
+#endif /* _MTK_MDP_RDMA_H */

-- 
2.55.0

