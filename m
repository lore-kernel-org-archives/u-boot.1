Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C774CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C903980DF0;
	Mon, 28 Sep 2026 09:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNlij2m9LE82; Mon, 28 Sep 2026 09:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D793A80DEB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587068;
	b=c0dZZJNnti3ahrasBkmyTmUOrTDE02svC/U2A+M/ZpfpmRF18J9O5XbvlonDPJr+JHOw
	 ezJ90JUOuhXWdB65t3Iwy91n6nBxjvOZwP6lHD50x1pdb+xnjN/57rUQv4GVu/Htigx2p
	 TXWITdpZ98Qt4+sNhp1FS2siLUolZH9XTO5PtF+SbutbQ0ju3Z4M9NcquEZqtsz/oCst0
	 78D2TlYGlEtIuME72QjKPvC6s/k/gZyqJw0U+3HI16HBsL6kVDp2AFJgoMXpmrz4YcUoq
	 gVvZR8ZIELHQh6+U4XTAbLrSUtGqIdW2t2XpoILt8H207gukbKvHJIgr+3nUm7X/7TA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
	b=QueXwjxbsHrKVIE/JnlVIjzHW927sxXoYfke57FCQ4BLXnDD2rOYz7h6D1a4ON9smuqI
	 G7r3KCodVdjxP71FW/zOcSBqpC+KaBpNi9Xyr2jRPupOH/tdcuwMSsQTTJhtQ5Kp0156Z
	 t59ladnEKsqKqXer91WNJvKRMvbsLgkvzOAdKrzZFNHiyiWlNJ0ksdT1xa2Y9havXXuDe
	 XUsoD2kljkwT6yTa2WUOjzPPUOTvPU/1pkpBOMHrzq8DMUeohnMiszj3uThp6o9Zq3DDW
	 9uYmaW78B+Xk+gmoLD52SryRbtATfMbRtgqc5ZfTeafIp8g5a4NpN3u9+GfG9+AQEZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587068;
	bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=04uDHTtr3UsMSn6MqIHLncZTAemBLcLQ1pt+LZVXmDMURepwQPJcMJEDQ3Vou79PX
	 sWt5L0GXqhhTPzzyXZO1Iq7banE2R7wD40fqAm4QMi9SV0cBhBcfns7fe4w2/P5uaL
	 MP3Vc53U+gmFH3zwkmrKOOMNSt4giQCXJV5a3d+wXVoCHfEVIwbFQOTIjCGmxLI6V8
	 qRSisW4g5vFWreyOLdQ142W9g/8gLmowhPzXy1279s3N1O4ttq0bhliJnnTTHXzAtx
	 EC+TRGaEyTXl6GPuMaDHm1ChlIvmoHeYJVtXZCsvHFlV9PqWYnFxJRo73Mvf/teMgF
	 Bhw27qmpknz/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D793A80DEB;
	Mon, 28 Sep 2026 09:17:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65E2724E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57B9E40198
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QyXgP4uWLiSB for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3E3D040194
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587060;
 b=AjYHbYc4RqvqGRmnBGExlXuE/TSDNexDMW2sAQkrUY4lMvolzpXfM7kLYDOacx9f2k6J
 81Qxocp9NC9+18XP9PbIXLafWF51rRLFiWVVQzwY4mgjHwqH57XYIDfv7Hem50vEikGfm
 QdY9By1OATxKvmE54wetl38SRyFDk6V/SeSZ2ZvFTmEDSud0anJnyuAo0fZKCizuw20T9
 C5udxERj7JSQbOOKiXWgffSUJILTj4GNjy2A0GMGRWSCGCjA0qGFuRUP8Th7kOSRv0PwY
 105FgeKArV1QQFLRKT218qUJbBFRCLi+G5XJW/VQp0B20AmfXgjagAQzplrZiN/+ZwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587060;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
 b=ng34S5t2F/70V00ctgmG+onGQMKtpywr2BcVSoCLaQPAZd0zBiDi6C/FiL0X7WhXwvPV
 /x2usOHbQ7xfASm7VGH7VzgI3/E5Gc8PMcekdy71aPSGDaIuz/nxVjPNdauiybwiC2Aoo
 SwG2FfvrGxZRwR3fRTw6axKiZ5/RW9ydvyHVMl7bGgai42TIwom14ujdQ9WYf/x2gkTm1
 GuiBPFkovI0Cdui2LNAR7jeRNxfVb5FwHPEn9xAgKVnosCkZkAm58k9ErCUn7tFeVtR9q
 KvCjBVdPoMWmvGDpuA8Mu62bgTjoDkmNu0KY9yNVZo1M9hCMR5xnmUs6g5ZAqMo5Oew==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=g4Qsu6uw; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=g4Qsu6uw
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E3D040194
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:39 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48884b926f0so1610138f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587058; x=1791191858;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
 b=g4Qsu6uweqrrxJ7goXFaxZN3QwhVDxdGNsx2dQgeMUvfQ6N0SksIBWKcBNxVR2Hq6T
 zFpTqWcvpVsL15i5Ev/tERJjONVazt2OoEvex/A/zQgs0WLVOqXNxG/QbrFMnZnWjlNo
 6iRjob5kfInK0MMJXqmJaKiufjvTCqA/snDYOerX8nB8aHGIESU0IoL65KbvsIHHhyEh
 ccdjABppA38c4AgNh/mTdXgONkTbvwdx9N0TXkzXQo26s2ALG7jA0mt4MS67PmbQCD00
 qwfKrWs5insnGCcCWINPwhSbRcLk913MvRPFYz/TZd9T74PvzxNCiDjz1PWN6lFvS3Gb
 yjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587058; x=1791191858;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JYBIC1P1rK7lEAFp1SkZnI68V/f83hg3alsDmXx+TFI=;
 b=fMjnnSqC1ji+TC8m3h4/yA4o07Aj8d/oS/+efHHSdP7m8BFFq4+BZZHNOxQQ4cMHbv
 POpOKfeS0yl5t7Jcvy7nhD+00pqQ3lKk74tEU6sCknZW73vq9Or6EiyJQH6B3rHkr5rB
 02wIdToNg07/c5jiss7duLkZcP2KgeJ0WRW4obqyUvFx3gINNSzuokZjg1XO50B/nj+i
 ZmjxaarzJ2jaAfEqdzmgOQinmwwJx5oJN8YW0wJ1T3QrkRc4M3tJ59f3iaDLRV+21b4y
 zte6evHiX+n0ACbfsfljuyPRlkfmFvAT8hYouosZ6TRozTQXQH0qDu+gAHv0U8c6yeF8
 BBnA==
X-Gm-Message-State: AFq9FYLiEJ802JboUCFZ31ItKsKCWbVMfhERA2mlvdqav/RhWOT6F0OK
 Rrym0vt3Nm2yyBSrgmumhyyI7Uxqnx9VTKJf4nKpysuKhEUrXsK0YS2IAl2V9c5SdWI=
X-Gm-Gg: AYBFou01bXc77Yb69PkVasPHQ5/qJoayOdD39/78Q8QfYidBjGPVlNkDtEL+AET65kD
 ULyV+yI/LIyym9BZ+Y+dM8Bp8QnPL1PT60rCH+rR177aDDufFSWThuC2tu4cXlYUCoWiugb7vpn
 NTkrxg5Niz+V7xWJ6/ePZM9nc4jKJTuosxINSjhg8oF48J3iP+JzoQpjeageIjF21DAJHeUQKMV
 UcOoDnZ87qf9dV0XQBTRvbWM8ZRTfRW4vku4+70o/472AgG9K6DT8gCv9pXi4S1XZCJYSFTRZEK
 GiEOI8P32G0U35ljohyS+BEuk0JQWrMgtdeblVeg8rkSm2UN1MVKE1evJtb9WTjffh1/w/MXFcl
 988MrT5EqoXUspnlOX/5fvAfuChi5NAREyw0KzTaAk/DVoHprlp05m4zZVTHDzhwItbBXzwsyNB
 2Gv5HT3tyMni0DXthZ9wxwq3X+e9yAP8XLHL2dFq0MB0xDYWOUjGqd7LMk6L2e41X5PjC+LY7/Y
 g68rlruit4Ey242Psh3sS8yeHdkW+gV6h1Eb1sCnx/2dqB6FdhnziPIg92RmsFBhW2vAoQS8vMT
 FVOQhUmH8mXi/DqJnqtBMUv7SsZOlnTUhI7L8lHltqTN9L1dCirgPUGU
X-Received: by 2002:a5d:5d13:0:b0:486:e707:42eb with SMTP id
 ffacd0b85a97d-48871769a4amr30219002f8f.33.1790587057698; 
 Mon, 28 Sep 2026 02:17:37 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:37 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:39 +0200
Subject: [PATCH v7 04/12] video: mediatek: add ethdr component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-4-ee4a61a8ac1d@baylibre.com>
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

The ETHDR is one of the components of the video pipeline on some
MediaTek SoCs, such as the MT8188. Two of its sub-blocks are used: the
mixer, which is the block's first register window and does the
compositing, and the HDR video back-end, which sits on the same data
path and is put in bypass since this pipeline does no tone mapping.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_ethdr.c | 106 +++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_ethdr.h |  37 +++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/video/mediatek/mtk_ethdr.c b/drivers/video/mediatek/mtk_ethdr.c
new file mode 100644
index 00000000000..6b480ad8319
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <errno.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_ethdr.h"
+
+#define MIX_EN				0xc
+#define MIX_ROI_SIZE			0x18
+#define MIX_DATAPATH_CON		0x1c
+#define OUTPUT_NO_RND				BIT(3)
+#define SOURCE_RGB_SEL				BIT(7)
+#define BACKGROUND_RELAY			(4 << 9)
+#define MIX_ROI_BGCLR			0x20
+#define BGCLR_BLACK				0xff000000
+#define MIX_SRC_CON			0x24
+#define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
+#define NON_PREMULTI_SOURCE			(2 << 12)
+#define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
+#define MIX_L_SRC_OFFSET(n)		(0x34 + 0x18 * (n))
+#define MIX_FUNC_DCM0			0x120
+#define MIX_FUNC_DCM1			0x124
+#define MIX_FUNC_DCM_ENABLE			0xffffffff
+
+/* HDR video back-end registers, in the "vdo_be" register window */
+#define HDR_VDO_BE_0204_VDO_DM_BE	0x204
+#define HDR_VDO_BE_0204_BYPASS_ALL		0x7e
+
+/* Fields used by this driver but not present in the upstream driver */
+#define MIX_SRC_L2_EN				BIT(2)
+#define L2_SRC_SEL				(2 << 20)
+#define L2_OUT_SEL				(2 << 22)
+
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height)
+{
+	struct mtk_ethdr_priv *priv = dev_get_priv(dev);
+
+	/*
+	 * The HDR video back-end sits between the mixer output and the final
+	 * merge, so put it in bypass: this pipeline does no tone mapping.
+	 */
+	writel(HDR_VDO_BE_0204_BYPASS_ALL,
+	       priv->vdo_be + HDR_VDO_BE_0204_VDO_DM_BE);
+
+	/* enable internal clocks */
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM0, MIX_FUNC_DCM_ENABLE);
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM1, MIX_FUNC_DCM_ENABLE);
+
+	mtk_disp_comp_write(dev, MIX_ROI_SIZE, (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_DATAPATH_CON,
+			    OUTPUT_NO_RND | SOURCE_RGB_SEL | BACKGROUND_RELAY);
+	mtk_disp_comp_write(dev, MIX_L_SRC_SIZE(2), (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_L_SRC_OFFSET(2), 0);
+	mtk_disp_comp_write(dev, MIX_ROI_BGCLR, BGCLR_BLACK);
+
+	/* only configure L2 since only rdma4 and rdma5 are used */
+	mtk_disp_comp_write(dev, MIX_L_SRC_CON(2), NON_PREMULTI_SOURCE);
+	mtk_disp_comp_write(dev, MIX_SRC_CON,
+			    MIX_SRC_L2_EN | L2_SRC_SEL | L2_OUT_SEL);
+
+	/* enable the mixer once its geometry is set, as Linux does */
+	mtk_disp_comp_write(dev, MIX_EN, 0x1);
+}
+
+static int mtk_ethdr_probe(struct udevice *dev)
+{
+	struct mtk_ethdr_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	priv->vdo_be = dev_remap_addr_name(dev, "vdo_be");
+	if (!priv->vdo_be)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id mtk_ethdr_ids[] = {
+	{ .compatible = "mediatek,mt8195-disp-ethdr" },
+	{ }
+};
+
+/*
+ * The mixer is the first register window ("mixer" in reg-names) of the
+ * ethdr block, so binding the ethdr node with default register index 0
+ * gives the mixer registers.
+ */
+U_BOOT_DRIVER(mtk_ethdr) = {
+	.name	   = "mtk_ethdr",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_ethdr_ids,
+	.probe	   = mtk_ethdr_probe,
+	.priv_auto = sizeof(struct mtk_ethdr_priv),
+};
diff --git a/drivers/video/mediatek/mtk_ethdr.h b/drivers/video/mediatek/mtk_ethdr.h
new file mode 100644
index 00000000000..28a6d3f270e
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_ETHDR_H
+#define _MTK_ETHDR_H
+
+#include "mtk_disp_comp.h"
+
+/**
+ * struct mtk_ethdr_priv - private data of the ethdr component
+ * @comp: common component state, holding the "mixer" register window. It
+ *	  must be the first member: the shared component helpers cast the
+ *	  private data of every pipeline component to struct mtk_disp_comp_priv
+ * @vdo_be: HDR video back-end ("vdo_be") register window
+ */
+struct mtk_ethdr_priv {
+	struct mtk_disp_comp_priv comp;
+	void __iomem *vdo_be;
+};
+
+/**
+ * mtk_ethdr_config() - configure the ethdr mixer
+ * @dev: ethdr device
+ * @width: width of the frame
+ * @height: height of the frame
+ *
+ * Put the HDR video back-end in bypass and set up the mixer to output its
+ * layer 2 alone, over a black background.
+ */
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height);
+
+#endif /* _MTK_ETHDR_H */

-- 
2.55.0

