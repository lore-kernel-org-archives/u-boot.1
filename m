Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387BFCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 084804058E;
	Mon, 28 Sep 2026 09:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9b6d30EPGQqk; Mon, 28 Sep 2026 09:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8330740765
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587075;
	b=b3t9Qavrzfd1nxGgGOU6wM52efaszgTlMNKnm07LHCFoT22a9Knwv4jgVWBMXXpZvz0R
	 xJVikUtU0OJoDtjdUCQ6ly4QURsa7aSYi8i5EkKEpXRS72rJncT+jsx5G807bvYE1++T+
	 aTVpufZzXcmbQZrOO7xzQGgXSOFfrqLCiXPFfqFfdY1OtLTuuKAcKLCxY1L9WW3Tu6TMb
	 mpQVCqeRaI3RmCcCPdo6vL2TBarZkLBehoCjb1tWr87oZzAi3YWoHled7W6X6DiR6MsPy
	 X0mnOvyOqguAgJiSmDf41FWD6NUeKSI6oGP3jxBDxHgXnLzQr36uS2cblSdqrftPG5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587075;
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
	b=GzIKODKY3+YgYhiGeto5r7VDqXj2EHz8MKYJ5kpiYnOn1UEz8Q7TvybMDTLKzgJ3nNuJ
	 VuOxhnNKk+sngf6f5uotbAe96QJCUzOcqjE9M+py8D9Q23xpxbD3TyT/RoSBgkJXV4h/G
	 IcAjKJuBIo7svHLM8cfSI0cbDVQt2XUs9OqeBxe4789K5gMp/p5ai7BG+n96KtzyZR4WL
	 dX+zkrg2uOkIOUS6q/cFET1VITPr4vL88C7USnGcfL0abjhsRtU5MMD7oOCp3DZsTLR6X
	 8+m+MXf1LomYE6DeDJwB0bLTSybBDbLr/KnRFsqtofebPukqxuUgLz9odHBQFUnSnyw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="g1TwBht/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587075;
	bh=oocQgrfQ01yOIc1PajZKx98kEZr3RiFUEGvHe1NoyrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S9Qs5TC2r4OSRIonaoDxe05UuAHF70ttjpns+BQaXZwZ4BcoHyoYB4oZC9TRtSBdG
	 roXQIkiRTIaMTp6EC+vIEoKbi236FoyNH5e+NF4/krrjQby0hw24VJ8tgizxS4ga35
	 xAUqKADLhvJnaLFO6n8SU0H56t6Zw/QoWa72ugzobtdRfBY0k6ZUq9IQ4d663JiTGK
	 obhPD8mAw5d98QdwavSwNpPOkaBwe5Te1S5wx2K6Sx54pJDlhC0rxmPxl0qQE2OAsB
	 aqY4nILuer7z+cpqZ4lPBUN+mFM7EKQa2+smal++IKiBCHsfygzaYQe1tD6+XTpI8O
	 hBg6Kt92LutQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8330740765;
	Mon, 28 Sep 2026 09:17:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B85D2B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 095D4406F9
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eqe4OpLvQgUk for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 070CD4059A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587065;
 b=RVo76TUSZHFVDF76j9xnsgg4cuk7g092Jc7IYBABw8i5ucIRVx904D3p1ts9xj1bmHJa
 tGi5yYVH4kFeGNK6pMVbIzAgwoepoah9JwISZmRufI37mJCX4dV/aLjy7MSvClyrVPUT3
 uHx7WD9kza4fiFX9aTmS3lKxNYXezfCjDnKENESlzdueA4g/O7FySqHAPgLEJ+FVErA/W
 ZnqE+NFqpAlN7Q3qh+U+wKbMrbaE2WmBS5ssVRgSXauwoPTIdwm8swauRJJ1Kg0PN8rOC
 WjINxLVRJGXY/VKMwiIhBxwDzUyERoO1og8homEopnbpsEkT7kg5vQT6aU/NqOqbz3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587065;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=oocQgrfQ01yOIc1PajZKx98kEZr3RiFUEGvHe1NoyrY=;
 b=hbpDQbID1qgnqitk64IWCiCb60snC+/QZzMvI5yg8U7HEdjvSISiEbpXCVaQjtPM8Eab
 KFtQANJDxFZp2daoal3/xXBmywIuzIDQ/QYkSo4pNkqXDUd6jBtVEI8eu2xP8DeXxArCK
 F7mwKqQ6nic+BBE4b2B9ZPYo+1a1WZhFjwTmzEMfQI56PGHzRsDMIRx8l2ZfRsourDJIy
 zmszWHSMnv6SIBIHZBC0Dt/jXnNGWM5T5+6pbDCnnhyLOI+BLwh7zbRHKA6ibzG0gKY1n
 q1c8+rnETYS3czAGD8hJR7xoyM59exBtCujhZBjlU00TDmtGDNdFRzR9HrpyoUABx7g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="g1TwBht/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=g1TwBht/
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 070CD4059A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:44 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-488885c3844so1087911f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587062; x=1791191862;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oocQgrfQ01yOIc1PajZKx98kEZr3RiFUEGvHe1NoyrY=;
 b=g1TwBht/nApruYENQe/N4oRmMMRN4a/qrRMtAKqJY4I3nLxmD07T5ryTKnfdPc5sdC
 QluzpcRuu3YTy0KT8GOsWijMmtPC5E8lfcaq83LrlZmJWDvrmSNfJ+kistVsygDkPuec
 SN8p7PTRe+Ptee9x58mCmafbVtdosysOBL4g9eBVEw2JU4bHF8uiIyo4r1ujEo8s1q3B
 uqOUkCxeXzRU4qAhmDYRtwkJG5IT2AxcrfrLAkPfE3g11N2ojTIJUu1DtnXBj2vs+UAv
 ZWGEIbNZOuG4VS65zFQdV1Egm/BKvqHQE/1R9KAfdf9hsGIyyQ2NFPMMmUICh/dnd5lG
 M12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587062; x=1791191862;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oocQgrfQ01yOIc1PajZKx98kEZr3RiFUEGvHe1NoyrY=;
 b=si2fJ492m26U02xMzVfSt/p93wNTZejfD4ZfsTR45H56XsdkYLdBugYIOZszjcAUzd
 KzFJVq+0V41CBtXzJzCjqOgWtcdeGNGjDYp03GG0RDwVhV4vQ3Nzxxio0jl6Nq77basL
 idBDO/d8yF9IZ3W6pMcoGDqmSUrkht+8OeM/yRvdAjCxObmkaOnTyeNL8zJmmBYThYWP
 1fZlz6lsOhvddnX01cAOWFnod4McOFZLUIGtwJzo1DSYPxDLFu+Z01KPTJ8Ke0uG4yVB
 /CkcgZ5rIZxhumcm7h+R8c/Pu23dC8t3TaDa4cmtN4cfyAD+7mqmaXSBUfeMdg7EyAd0
 Fa2g==
X-Gm-Message-State: AFq9FYI/wMpbeYr2kRdozPNN0UzCSQNIz2xNKTB4qEK0lkWD2/mjtH5X
 CwqUxgq8Kg4bK8BOAaD1wxFoQwty5ANgCY+gAe3NSHKtuSTzJe+a3n1Rzit6ke3SeX0=
X-Gm-Gg: AYBFou2KOCgpqsr68yB3rMuySqqq9QvRTWvCVDoSgKBbboRSnHr6X3Jlbdf5U+7pQen
 ZbU5NuLid9l7q/XsLne9KwXTG63+RHHlUjSLDyLceGsbG91pu+O6eXR7MORrBI+yBhKFpoAMu4y
 O9+H7q/YzAaqDkuPUf1JxaUUN1yWVdnJ2u1RIRNleM2GvEBCX/4yVRZ0Cj3C3SA/ZJx99XwdWjx
 GEb8/ZGk662We2nKk9Hh+G7P8C2HlJ14B/mPW37vAgXkldrwPsXO/Od0EmeYz9WFSqsJZZLOmrP
 ssWvYxlZsPtjvCgOUyP03Yh5NJQO8G1m1G6d8kuog9lZaRbZ2+ZyENaKmJleKVaRVgt+iklCg7Y
 9qyHgxUXF8w/n9ymbshEoxifVDs7ZCwJo03/2zRaEDAXnSES5UTZNd4k1GpT7g1BgnJEVUrQoKn
 KNVo4SubX1GE1SdUSH6/Nm7e5Ypf+RWuqmCaPfppCmux3PNp9U1MZdEYQOZjtyB+8Sa0Bilnnvn
 iaJHx5cboBzYb1wtGeNpHEEgFWYkWM1TGBEXjkdTJApcvwMCokRIug7wNNYyojeGbiD4+Hpmzal
 ul0losGgYXSQPc+EqoUxHafWxCKQE7yGkcQaXQpqK/ZQqwjR89EHbQU=
X-Received: by 2002:a5d:6f17:0:b0:488:8733:21d0 with SMTP id
 ffacd0b85a97d-4888733220dmr11987013f8f.17.1790587062537; 
 Mon, 28 Sep 2026 02:17:42 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:42 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:43 +0200
Subject: [PATCH v7 08/12] video: mediatek: add mdp rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-8-ee4a61a8ac1d@baylibre.com>
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

