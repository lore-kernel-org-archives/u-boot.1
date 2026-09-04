Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F9AC624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3B51811E4;
	Fri,  4 Sep 2026 13:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67zD2YL2zF6X; Fri,  4 Sep 2026 13:50:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A757A811AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529828;
	b=IRTTCRncadOZYh4IkI8IIXJW1pCEOzk/+GOlB6xMcSVzd1Nn/T9AU60+nCKP876Tbj99
	 7xV06ItAXrSCS0FKFdpom5liN4j3+tgpfPOndrDNx0krTQ10hcztBcmbf1LPebluV+w9s
	 LOwnx8NI2WMDmksXCruvhWDLzfxvRDRi6wbsPrfBhlip4qs5fgY1VWls+IA7Qxzt+PIhc
	 QyXbITSXXwxZHAo4CQTHqHwKw5vZJylpNoVg2ag+ie3fxCfPNjR3FZ0ZgYVb94g0XRcza
	 GORpvmwN9M6+gsbdUiDdVMktRmPR/7HVpHU1AbSMDdrVPsVncK4yC2BzeFRSXB8PFpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529828;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3oa21CD4sxgLI0a90HaqAo12boKA73oFgn0a1CS5FGs=;
	b=qnmw2R1Bqz9A7NXSbbj92d5U1pFS7xhrs14TR3nnldZJh+LbjMoGAyZ4za1oLzUDXjuZ
	 zx0JUIKX77T2IxPruT+tNhq62rAtgBH43nS0WfaD9DorGcZ2D+Chs+LoN1K0WXxQrEZy5
	 BSVFpsm/Rs+Bxg4xwN3eEkmJAilhykadTeHP7qEXlZLKQuH57GlEFku0Ltuc04BS2a9IJ
	 ZYgn6YFfk/qsnOZjOEGnS8MM5a+DhGG+0u/EgcAQZGSV9hMd609024V0E/ZhPLqDHXj+1
	 gkAbwj/l6N1jfxxLpbAqc1YGJ4pMe4R/N4y74IX89g0gJMdcp3hp0Nfv5vkXdxPpiwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529828;
	bh=3oa21CD4sxgLI0a90HaqAo12boKA73oFgn0a1CS5FGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A0vpRhVCJPqeua+qKjEmcrjIC10cgQw5gBmpMfx479Sxc//QNJoO4R+dg+4zJX+Vc
	 tLRuwhBhSUgAmQl3iwoRuUTrq8/2ccr8uu8/QTO2Hg2ztlavhrkgOMlsmwmVqaak62
	 BnMzUFveJ8pn9Gj7VbKERwfOcJ143mHmbYqwTO3QYpCvfCdmLuZBIHZ3MZRt6sHWNG
	 3SZhYsNJckjv0bC3MCBwilIyGOICaqjNtdHM6fbnChdjhcvwCtRbhlfki3cGpA/wk3
	 yXmzHm8o++USaR4VoHb3eknd9I0wy4GeAYJFO0oau84jL0pfP1UVNIYl4Ll3rZ9oa6
	 cY2K4V02w7bww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A757A811AE;
	Fri,  4 Sep 2026 13:50:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DD7F118
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E37740BE3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q8O4hsX7Qlcf for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 299E740BDE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529819;
 b=Fg1s9zfG5c4j/FD75nFavJFo+rIIkFH/mKM15NhuC//mLwlXuj0Q/mS4fpCPsWn0mub1
 BGGxhcvSYbzuBfyNamaJJl57DlJ2dg6chgRpHDTqjnZ/A5rbVJ9tLnHeoJCggu9r4FSUp
 0F07tZmSVmZQln3Js4dBQuFr2ZDfD5azy+yhXOUNdED44TC9r53xAivbMVMGK7GNJ+61I
 3U5BgNxA9cCmrBCDZyAgVYQ5kmhqYGy4OX4iYTOJjbwKV6UW6bTJ8DnPSwKoYs8ToE6CU
 05rZ3q+RMgDbcYeQHObxe4oW5AdvMjflDUiKzQg5SMHNQt5Q8gvJs/vk8arI6yPxXPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529819;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=3oa21CD4sxgLI0a90HaqAo12boKA73oFgn0a1CS5FGs=;
 b=MJH7ln6rlzOPK7n0JSrPCE+raVky2wdLz3tFynaw0E0YUV62wE7Rob6shvkmGC8XRzi6
 epKGzCPGt/rK3Z7AKqWZywXOjU5z7StEbVy68m7Y8bm6Tn8mSI8jCTeLuIFBfWwEoWp1+
 IxPmQN7x/ToY8MI1Mp2CJSMZtYfHX+NzKhp+1+QXJiQAhCKKniYymNj8ViiKb15KTF3nA
 c1i9NtyhqjPeoI2eK1O7RbfZcrlGNcRI8ULQV/LTplbaaGx9p7F41xBjj+yckCnAWhl/q
 SWy5OuhAU1oDxvzJP87MJP9hO5YZ/6gIUfyBpGy3DdhadF7j8dLniRRpW09TxVA0jFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KGjohXob; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KGjohXob
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 299E740BDE
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:18 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so1086762f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529817; x=1789134617;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3oa21CD4sxgLI0a90HaqAo12boKA73oFgn0a1CS5FGs=;
 b=KGjohXobySZcjU7/TbCA4VtG2Oy6OVkvfg7+e6CI3Z6BfFbJC4LMdNePr/pI7lbkTr
 YB/9ETsj3l0HTkvWPtXIM509e0hYOy9urWlU8mVQVM9rA7oVAuBJk7g9cxGDRPN0+Ye5
 bF0FPO3M9ch0xjRW8psdKK1WkFqjoT2543xhU7Ltea0zkGZz2GMNcV/AA06pUXQJEizi
 T6XCNN59Hw9P25a4quG3MDMvqGQ8MpR+iezCLyDGm92UAoo+U3oecX34d0yA/AiyAIEO
 JvYWK1XdjVk32UC4mEnw14AiJC5sdI4ResRj72Ij41kSe4fRL0uNntHRr99u1a/naN31
 jbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529817; x=1789134617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3oa21CD4sxgLI0a90HaqAo12boKA73oFgn0a1CS5FGs=;
 b=KaVwMX4TFWOxkvKBC8hq66Pd12ViOyV2XJEWpNrMTvcxTrtp8iKgvcF8M6V12jubpu
 hhuj9h49kRaWXbX7wG7pDYX3j1GDq79EV0/Gz+ve9tKzczT+TlS767dILDRCFHQZhI4z
 mAy4tGMbWfbb0Pkig7j5FkNS34O8kdY/b65fwyqpAwt9dWCLpSO4xH5/e8y9CnWwKXdQ
 UdJrksgWjaMm+tQz+rezSHF3dYdlUiLJqvWoanFWza93CmtHJPmmu53e/yrsrY8xQRaD
 K98jHNUWMd6Wg4JwOIIw4ca9PqgQ6CoYemnEtRPeITvenBziN8k8qKJY+CyXs0+6CmS5
 Sdvg==
X-Gm-Message-State: AFuF++nuoGVkiSSo0v0hgs1r2DdyrtNhaUYNLVwxkOO3T2EEUeb1eio4
 H+DYfHCI29cNIn/OwM64yO1el2ghoQuUq/KhzF1qKsWtjL29mRP2NaeyeOIx3e0/1NI=
X-Gm-Gg: AYBFou0GhGhtYNsYTddI9bJxQn8G2yrqJdfjbAZl55nB4SxcHjacPKQ6OQCUzB5dyla
 tPSLraZwactzaiDu9roGNpHHnysiPID3Rghf4ilf8L9nsU0MKlMLyJ+T0Jcni2wnmoVWkbog/4y
 aqoJARYVmdfQM/b/M2vOKUfraKdmnGi9DyDuMbbsZ/X5fTqCfXDXdNcChQ29Wyiszr0CvvWGf2K
 vb6zcENyw9yUhsg8en63+la/nL4xH7I9X7cNzRQ04M0Go3x3C1CiHp1eyFd5UKhcznru+nyCDDg
 onTtq+Ong/EFGyDli+W2Nko3ezVu/ZmTkyZE0zn14Ml0B1gqJFmK+/k9UWDJxryr7nG1SEzVV7M
 oN8hAPIK/UXh6PrhblHmgc6tGsvlGA7VR8y4kzXAtcTnUejeeT4Qaadlz0pd2Zx/r0HAQqNQ9Cf
 /N3VavwwmN2XL3Ek250lr50j1e0C1lApLkVZ8NxDI3nfkerYutX2KfBbO4uAPqIio5zF/fJxPUf
 xpT+IskftsTCvYL+dwDOxFuwiqlIBhMemGw5EXFA5utLnIuUhbMVeQC8+3kjOFwOWb4XY0w1SzC
 q7PFyw68YCA3dL/7Nby45/JOwnkYEhwtrKTn6Lq2LuU=
X-Received: by 2002:a05:6000:430b:b0:485:8ad6:3752 with SMTP id
 ffacd0b85a97d-4858ad63a6fmr8808416f8f.5.1788529816823; 
 Fri, 04 Sep 2026 06:50:16 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:16 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:14 +0200
Subject: [PATCH v5 08/13] video: mediatek: add rdma component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-8-dd9dde2f972e@baylibre.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
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
 drivers/video/mediatek/mtk_mdp_rdma.c | 213 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_mdp_rdma.h |  20 ++++
 2 files changed, 233 insertions(+)

diff --git a/drivers/video/mediatek/mtk_mdp_rdma.c b/drivers/video/mediatek/mtk_mdp_rdma.c
new file mode 100644
index 00000000000..21e0f8ffca5
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video MDP RDMA Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <dt-bindings/memory/mtk-memory-port.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <linux/bitfield.h>
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
+/* Fields/values used by this driver but not present in the upstream driver */
+#define FLD_INTERNAL_DCM_EN			GENMASK(23, 4)
+#define FLD_BITEXTEND_ZERO			BIT(15)
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
+	 * pipeline from 8-bit data: TRANSFORM_0 bit 15 zero-extends each
+	 * component instead of MDP_RDMA_CON's FLD_OUTPUT_10B used by Linux.
+	 */
+	mtk_disp_comp_write(dev, MDP_RDMA_CON, FLD_SIMPLE_MODE);
+	mtk_disp_comp_write(dev, MDP_RDMA_TRANSFORM_0, FLD_BITEXTEND_ZERO);
+
+	/* enable engine */
+	mtk_disp_comp_write(dev, MDP_RDMA_EN,
+			    FLD_INTERNAL_DCM_EN | FLD_ROT_ENABLE);
+
+	return 0;
+}
+
+/*
+ * The RDMA is the DMA master, so the SMI larb feeding it must be ungated for
+ * its DRAM access. The RDMA points at its IOMMU (M4U) port through "iommus";
+ * MTK_M4U_TO_LARB() extracts the larb id from that port. Resolve the matching
+ * larb in the IOMMU's "mediatek,larbs" list by its "mediatek,larb-id"; the
+ * component helper then enables and disables it together with the RDMA.
+ */
+static int mtk_mdp_rdma_get_larb(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	ofnode iommu, node;
+	u32 larb_id, id;
+	int i, ret;
+
+	ret = dev_read_phandle_with_args(dev, "iommus", "#iommu-cells", 0, 0,
+					 &args);
+	if (ret) {
+		dev_err(dev, "cannot parse iommus: %d\n", ret);
+		return ret;
+	}
+	iommu = args.node;
+	larb_id = MTK_M4U_TO_LARB(args.args[0]);
+
+	for (i = 0; ; i++) {
+		node = ofnode_parse_phandle(iommu, "mediatek,larbs", i);
+		if (!ofnode_valid(node)) {
+			dev_err(dev, "no larb %u in iommu\n", larb_id);
+			return -ENODEV;
+		}
+		if (!ofnode_read_u32(node, "mediatek,larb-id", &id) &&
+		    id == larb_id)
+			break;
+	}
+
+	return uclass_get_device_by_ofnode(UCLASS_MEMORY, node, &priv->larb);
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
+	return mtk_mdp_rdma_get_larb(dev);
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
index 00000000000..ceeaa8df3ac
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mdp_rdma.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video MDP RDMA Support
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
+int mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
+			const struct display_timing *timing,
+			unsigned int pitch, bool apply_offset);
+
+#endif /* _MTK_MDP_RDMA_H */

-- 
2.55.0

