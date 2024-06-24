Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56616C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBD488572;
	Mon, 24 Jun 2024 23:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lvd8yCPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 096D2883BA; Mon, 24 Jun 2024 23:04:40 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EFDE883CD
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-366dcd21604so1871437f8f.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263077; x=1719867877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=miNq8XFDRuPODlqFaOzenAWCqypZu8MeoDwiE2f6svo=;
 b=lvd8yCPrrBVKMnwc7yiKllo+11m4dl2w5i7uZUNW692nxdniF2GC8qyL1JekmxDrqp
 8xS8qYfIRnTLOWouXr+b89WSJX6HjZqoqKAQuEjzbdGBDLdwUQJDrPtfcja9L7RjW75S
 AvQg5Sw5LeIjnwUyowtEFhk80788ADklNPNtUl/zw1hXwIJQIUuPt2+93bq63/OM+3gx
 4zmlx/r3X3oAxz4fcEH9b5CvxTuRhgBPGIugizXcRSHkkHyX/g/hlhDnUgAP4K8yqP8A
 vBmmEGSU8EGftkq9DDL7lKAb6A+GbSsmSxsUWy4+RSPSCFMdp0iMP4Hsmuc2haA68EiE
 Q7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263077; x=1719867877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miNq8XFDRuPODlqFaOzenAWCqypZu8MeoDwiE2f6svo=;
 b=AhQj4m4uztdhxtFGihR6fmwSNYceDKS8LkkozgyX4TuKx6DUIwQzm/OOAAJkW5bRRL
 4MIu1vKPhNCeriKTb7XfoZswXUdGwEOq9yY483fKR3PvaPo9KD50tjX4RV9cxvk9Uhm0
 DspAFZpFCV8z9KYHxb3hMaVs3UKYUJhzB2pH00HgqGFeyxnuP3oaH2n4r/rgaonKgDnT
 waC00hH6cjwoofz+NilxcInNhV0M1+HX6yjY4IRzO2OKle3hsbiZZmAeG6IYSni7DfAH
 46c+0VoMt7rCQAtRT+9NC2W6Gb6EDpnZqtFu/2OBohTYCSaebMKdhCmntcAJqlFbQS4E
 CYbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm7qQWT6KL4YzLnPA7fc9qh7cpmYP4vhI3iFEzItlCf7q1jSIjSPkabwVAtNubMRWPhjYCTuEJSWyNF+t5bYiVyLagpg==
X-Gm-Message-State: AOJu0YwJpkjB4C71JiZuXK1eeNNaVH9HG6Fj5wjcg7t8PLJSRzTNkWgs
 jSuTkxmvbVUBM62cKiZ3WKZ9KNaDaqflwgcGWGhE+KV+swJ7Kpms
X-Google-Smtp-Source: AGHT+IGCn8lo1/xLXn/5jWfaQQ89p8FV6xQy7x0LfXBVZkkuY8CfRJ3XK4lhkWzx+00BUkVI9OHuYw==
X-Received: by 2002:a05:6000:2ab:b0:366:ec2f:dbd3 with SMTP id
 ffacd0b85a97d-366ec2fdc08mr4622925f8f.47.1719263076940; 
 Mon, 24 Jun 2024 14:04:36 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Crispin <john@phrozen.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4 07/14] serial: mediatek: add special handling for highspeed
 and linux compat
Date: Mon, 24 Jun 2024 23:03:33 +0200
Message-ID: <20240624210418.19324-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624210418.19324-1-ansuelsmth@gmail.com>
References: <20240624210418.19324-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Upstream linux serial driver use a different logic to setup serial regs.

They have 2 interval:
- < 115200 we use lowspeed regs and 16 * baud
- >= 115200 we use highspeed

We currently use force_highspeed property to force usage of highspeed
regs even with low baud rate.

Add special handling if the upstream compatible is used where we just
apply the same interval with anything >= 115200 in highspeed simulating
force_highspeed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/serial/serial_mtk.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 78e8d9dc735..becf9317076 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -10,6 +10,7 @@
 #include <config.h>
 #include <div64.h>
 #include <dm.h>
+#include <dm/device.h>
 #include <dm/device_compat.h>
 #include <errno.h>
 #include <log.h>
@@ -80,6 +81,7 @@ struct mtk_serial_regs {
  * @fixed_clk_rate:		Fallback fixed baud clock rate if baud clock
  *				device is not specified
  * @force_highspeed:		Force using high-speed mode
+ * @upstream_highspeed_logic:	Apply upstream high-speed logic
  */
 struct mtk_serial_priv {
 	struct mtk_serial_regs __iomem *regs;
@@ -87,6 +89,7 @@ struct mtk_serial_priv {
 	struct clk clk_bus;
 	u32 fixed_clk_rate;
 	bool force_highspeed;
+	bool upstream_highspeed_logic;
 };
 
 static void _mtk_serial_setbrg(struct mtk_serial_priv *priv, int baud,
@@ -113,7 +116,12 @@ static void _mtk_serial_setbrg(struct mtk_serial_priv *priv, int baud,
 		goto set_baud;
 	}
 
-	if (priv->force_highspeed)
+	/*
+	 * Upstream linux use highspeed for anything >= 115200 and lowspeed
+	 * for < 115200. Simulate this if we are using the upstream compatible.
+	 */
+	if (priv->force_highspeed ||
+	    (priv->upstream_highspeed_logic && baud >= 115200))
 		goto use_hs3;
 
 	if (baud <= 115200) {
@@ -259,6 +267,8 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 	clk_get_by_name(dev, "bus", &priv->clk_bus);
 
 	priv->force_highspeed = dev_read_bool(dev, "mediatek,force-highspeed");
+	priv->upstream_highspeed_logic =
+		device_is_compatible(dev, "mediatek,mt6577-uart");
 
 	return 0;
 }
-- 
2.45.1

