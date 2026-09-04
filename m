Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C13FC79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 597C1811C4;
	Fri,  4 Sep 2026 13:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tplEUgDT4Z1I; Fri,  4 Sep 2026 13:50:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 57773811B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529822;
	b=SOFtATy+8RmoyeDuABC6+X5f9Ua7eWgr1Ri+nnCezPr5/xwv8Bb+nT9PQD9O7jEJ+yhp
	 x2qkMDu1Il7OR01SoqwPrmRVbh3EDetHv0jnZZirQhz9debsdYIyNuj3JLd1Icm/yZ4ax
	 fshNxuTqjHNoHJVK7BLYE4eeZ24diydUcTaTix5OUbjANSrVnR1atQNoz5he/NSsmWe4n
	 0l456/cY0W+4LhCzoIa6UVWqktwa/PrFeT4JrUYj8yQwJSz5uql+aFIY28tZwg6oKhpZN
	 TXSX1NTl0Q5lzcNNxv/yI/8L4mDq3I2x+VW4kXVx4ul+4JQLfx7XNdLLybzh1y8Hemw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8JQHqOSBscb1dqB6+jGOsVG5HMvnv3AbPP5NZAqMgko=;
	b=A8Wcpj4BqiqTbWj8SM2ijK4mYniZUbJGdJJRXi1b5ehBKjSW6zrx6xz83g5sdbS3nyiI
	 OdzMyfufx2KJUVmhZXAVwZduUZBpwZOWUQPeBc8vgq93eWKhlliX2JcaJOxdaVQGYdzNo
	 +HW5aBqbALOhzDrbgwX4RZRl+NwB4+1lHNzSqNbSEfBlL7H82TFeX2KKfHQqzIrySR2Ou
	 xOMAX1HIIMR4pW+25jBZcZI/e+BynRcHQDO9CYP9gFxm0jIJ4+JF2CsdTb4QbFoR9ZltZ
	 qQjtN/fssZwbtZL4D56Rwfq+pSIqZQ+CZJ3+2keQBoFwW38UmQmoN3QtMsDfG7HW9fA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FOH++Umc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529822;
	bh=8JQHqOSBscb1dqB6+jGOsVG5HMvnv3AbPP5NZAqMgko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r7fUltvd4YpE2PUennKWUliI5NueD7cMl0gwqlpM+6L/36D83DnC/m7EotjHonqzs
	 IdXNHQ+AnQ1ah3LuoC9g8L9QBip5jmvj0fKAFJQJfvErxE8QeEbyU4hup7ebw43a72
	 bmGMJfHntScvtOrEGFdmA4mWqURHYvmBCkD+8SMyhGtjtB1gfXZeARSEzY3h7YVTHz
	 7q0mKetxm0GRcPQUW8OPJ4gkyXFB2zr4px5BWE3j2eqc3U/RtKzK14eZIE1tyZ0U9h
	 glpFgseOUH/vrmDmxmZqlPWnIpSe3wa+BuQ5TvkU7dr8c6aIgxkjIsm+ZyZccDzpqV
	 AMOvxI3V1MzWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57773811B3;
	Fri,  4 Sep 2026 13:50:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D636577F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C820A811A6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id asuHFQ-UHrtn for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8EA508119F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529817;
 b=YRVknmj8rkiAJy62KV5mHR6Q6R7o0Xbfz0e0XC+jh/NiWPRdXWpu2T6UvHXGW3SS4GFb
 U+lfOTWoqsgjHI/NxVCT+h03yot2pgLqXG/wIvJBTB1eNCHxp2tb6dYEMKYJOsH+mphR7
 KE3xnsfiVqqOiM61DKuFM2/VZpKJlMx4sDh+hpMfbXk//h093SO/0qTaUyOX3f90gzroL
 ubyzGQp4Lf+3XEejuwgv8uLa28rhOtGre0DkfJMjDG+hUTm87ht8WALxuUW1o0Mg/few9
 gGHuWnssH8wia/WwHmoT4Z+nnBnfNRqlBXcX0pS17f5pKEc1syNbGbQqWoy1nTQ5H9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529817;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=8JQHqOSBscb1dqB6+jGOsVG5HMvnv3AbPP5NZAqMgko=;
 b=GWXJeAXxjGOa5h6kUU63P+ta0+yCAjT4czy3Xbp3Y1QsF9DTRcRExCLmDGwQpOZVvXG1
 EZdZloyG1oXCv4akAOYLxmffa8o+MFHgw77IaJz9Txa8OAHvIXZQO9iu19WgTjNnJrAry
 XTJR7yvfh2u2OPc51D9hc81wKyf+bJHLI8NWBp2da63tOjbq781SaN60Xv5dH92AghlmI
 H8PS+zhXhmGsHv2H1rKRopvx7ppGYrgY3Zr97BtX9IqAQUq08z0egH4ZrSTeqgSvBGRlp
 o+NNnIpPd4BNbb0CqfZFZs6q/a3PSDtnhKVuClcsYksGsUVrbtF+OeCvJCYQtJuMMMw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FOH++Umc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FOH++Umc
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EA508119F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:14 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-495590dde14so14287385e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529812; x=1789134612;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8JQHqOSBscb1dqB6+jGOsVG5HMvnv3AbPP5NZAqMgko=;
 b=FOH++Umcs56c6KO2jJB/QdQKC3NueUUCBDZ4+eHWH3PiANcRRI5gJYOe9NviZr4YMS
 MzBwcIV48KUwgiai+8HlQ7BXHgyurPJj5QHmeeyCYHtAJBLeGBe22IyrR933KpRUG94S
 cWTILjXq1ZA6vCyIUfJa60gEpk86OAxhPjx7Y/lGu3TqI9Gu1iQH11YmREgxPqxMSWHB
 6N/rgyuAju5+lVpMsgnMp0dMupu1fvWd+yxYPm9fDmUVkuf2yiV16ceS13khB/sJE+e9
 U6mlRrY/a85HfqK4Xr4EhviRFuN4+xfMt2DfCMcskPoGBymVyf7duN8jA81Mzrh0Aawx
 GvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529812; x=1789134612;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8JQHqOSBscb1dqB6+jGOsVG5HMvnv3AbPP5NZAqMgko=;
 b=Q8M33LyWFScZ8+fnOn77SQxFNg/IgjPpmZ8/WEN6M2UrOX/z2S9w0Ue/AaGwHHz6hC
 2ssNJ4giD9OJZCUSTUoAssIq9kV10/K3NbC5JsNaKhbtDasv8DUebYgON0pkATFHnCZ7
 gd/b3xPMtH382nQiHvPIxwWJLgMWE7zly7Zh+aZj/9U5XukQOs/rkkBx+gnWkJ96c0Ix
 IvxAgiMiX2onKIkkvf5/TboNJo54YgthoMxkWMJRoQprDT2RFx7w6wAcNf+jwgaUc70P
 UTVDrQr801iAMiSu3OZRXojt8HSSw0332ukw0sy2AUHF3zx9w0Gw5qKUEbdW3KtvoQmf
 ek+Q==
X-Gm-Message-State: AFuF++k/2VEOVAth1IqL7f7IC3FRdqI/RYxgNLdA6TUk1/qsMEgL19+b
 papGL/wmE8MEGe7UcT92yBL8xzCyKekdS1t1alGYMQwgqsM0we1kJ/tM1nn85WjTvNM=
X-Gm-Gg: AYBFou1FB2amBy58LMcoc051zDZ94g8FRJAubEeCcOf9zuaBR9nFXJY2Ttb5vjFSjB7
 bHIXwAKEHvjWiWPj+z/7DUKZ7nh0pxTUWC6X5qiJzb4XxNMjwi8POQ3NoI13DQfjjyMXsiPxtmA
 BFvh5wJL8FXk4riJtwIrUOTwQsPk3HpEg8JhIdodEPZW8BbmppTvfLeOlpM27JA1rDvYJi6kxxd
 ebo8T5S/shmdr495zMzw8EBXo2M4L0Jwt/VKdr4UqhFdGsEU0TkYwrjvigdOSwOVsD4kkDQTpKg
 SyAdC9sH/ZoOldoVVg6MIN/1yoewFtwD7hVTbcVo7GEm9c/NhlCv5KbZWyVzqgflQciOHOJ3lnn
 lKJxs8GjIwzo+P5nToG1TcYAAfAJgLltcoNI53JUZ30Cwe3ra1LOaueE3tBr0aQ+O4y38x/w859
 mvFH2s0EJpWHUd0Wb8BUqicXVgrlWpRwuqPEzAd6PEk1JiE/ewfIP9YAQkEdHwsA7I5iDMcK4Ol
 rp1fwM1PmLRsv29BMcqfffXCv846N1o7zdOuQ1aqkrtCuEYTwEadUqWq0YhICfuBeOKsX8pt40e
 prcwJyNeLDPSPUgRKPukujLeA1v4IiIidD2CJMAHzGA=
X-Received: by 2002:a05:600c:3b11:b0:49c:f7c4:dc54 with SMTP id
 5b1f17b1804b1-49cf82512b9mr93769265e9.14.1788529812378; 
 Fri, 04 Sep 2026 06:50:12 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:11 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:10 +0200
Subject: [PATCH v5 04/13] video: mediatek: add ethdr component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-4-dd9dde2f972e@baylibre.com>
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

The ETHDR is one of the components of the video pipeline on some
MediaTek SoCs, such as the MT8188. Two of its sub-blocks are used: the
mixer, which is the block's first register window and does the
compositing, and the HDR video back-end, which sits on the same data
path and is put in bypass since this pipeline does no tone mapping.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_ethdr.c | 104 +++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_ethdr.h |  27 ++++++++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/video/mediatek/mtk_ethdr.c b/drivers/video/mediatek/mtk_ethdr.c
new file mode 100644
index 00000000000..08ce5fbf518
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Mediatek Video ETHDR support
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
+	/* enable mixer */
+	mtk_disp_comp_write(dev, MIX_EN, 0x1);
+
+	mtk_disp_comp_write(dev, MIX_ROI_SIZE, (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_DATAPATH_CON,
+			    OUTPUT_NO_RND | SOURCE_RGB_SEL | BACKGROUND_RELAY);
+	mtk_disp_comp_write(dev, MIX_L_SRC_SIZE(2), (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_ROI_BGCLR, BGCLR_BLACK);
+
+	/* only configure L2 since only rdma4 and rdma5 are used */
+	mtk_disp_comp_write(dev, MIX_L_SRC_CON(2), NON_PREMULTI_SOURCE);
+	mtk_disp_comp_write(dev, MIX_SRC_CON,
+			    MIX_SRC_L2_EN | L2_SRC_SEL | L2_OUT_SEL);
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
index 00000000000..4a1bae3ddbf
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Mediatek Video ETHDR support
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
+/*
+ * @comp must be the first member: the shared component helpers cast the
+ * private data of every pipeline component to struct mtk_disp_comp_priv.
+ * @comp holds the "mixer" register window, @vdo_be the HDR video back-end
+ * one.
+ */
+struct mtk_ethdr_priv {
+	struct mtk_disp_comp_priv comp;
+	void __iomem *vdo_be;
+};
+
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height);
+
+#endif /* _MTK_ETHDR_H */

-- 
2.55.0

