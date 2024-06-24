Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7B5C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4249C883C9;
	Mon, 24 Jun 2024 23:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jM3ltU2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A79788418; Mon, 24 Jun 2024 23:04:34 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9E7883BA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-421a1b834acso39654185e9.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263072; x=1719867872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B61wlxiuDK9q7oVyyZYvJNYS2vY7JMd48k1n0qZYSCg=;
 b=jM3ltU2+FKYDS4BEfYWUeN2bxXBPfF20fh1hVjBLwdiw3uUaO8+lDRc20PwuEEvk3s
 NhaoyYmxYuvqZRLXzytXNa0Wy35dz/oXXTLRTLU+/USFUNwPt0Ct6veK9Xw5x+5mq4SR
 AC+rk8/pqdq+5xiqzcXmenqmfZSdal8NDRu9/IZ140jPOqqvgK9dKR4I4RU78WA1DQpr
 5VkJGrCv+L3Bvw5e4QpxmhlT3s1+AVHRC7dfRAF1E2FB21+2OztS0GvLy4qzJUaJwg2x
 2bAurNUDrboxBUFhBafRAV/VVts87Uu9mldlI5Le+QEoy6EGvON1VkU7K2gaAVj8biI9
 xYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263072; x=1719867872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B61wlxiuDK9q7oVyyZYvJNYS2vY7JMd48k1n0qZYSCg=;
 b=AbM0qDz82FUQg6cn3Eu6Sc8JXJRvf4xd0YlkZAdvtj98F4izsUYi20jSVR9KMN6FfX
 Hj22of4KEjxdvBMu9ih5/Mgh9ixUka3fnDVJjB0oIdbU6701iOhBJPRjWgmJklFzUAvv
 W0Ua6FHoXfwC0OVKVK+QdFiDXy/z9432xiW0lDPNOTky9kmHT5mjLMejB1YLDT7sgPR7
 oNZqD38L2a5CRdRSLop9xL9Adakpo665JVkEu0YZROqYVL8J7gt5xol884VUqCeMvDIJ
 8cogXnkVmk3nMEVdfbD76Utq+WjiDNO7eWQo2q3r1rAgw/i+LDG22gEVoTFJv7nLv5L1
 ex4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrGcv4QgYbDWZ2FrWnOK1GIdJK0cWKwrZmIE7L475eG6NrPn6YbzNaGVCdpr51ZoLATBpxySyWNj7/XtqQj+NJw5HH6A==
X-Gm-Message-State: AOJu0Yz+DQbTstO8eKud4PQomu4UvG1c+Pnuoqo6DBEewA8yhm+Oj0Oa
 FWyqldf3QXT0H7KecUW8N7d84oZz7QRjooubvAGdQmfBgtV2bWb5
X-Google-Smtp-Source: AGHT+IF8kGupJZX4t6BYza4kZwoPNWJepCYDED69rZtNETqa88PKskvHkTQSF7/Zz4hKESoVEKgE2A==
X-Received: by 2002:a05:600c:3b14:b0:424:8dba:4a4e with SMTP id
 5b1f17b1804b1-4248dba4d43mr36566875e9.6.1719263072140; 
 Mon, 24 Jun 2024 14:04:32 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:31 -0700 (PDT)
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
Subject: [PATCH v4 04/14] net: mediatek: handle alternative name for pn_swap
 property
Date: Mon, 24 Jun 2024 23:03:30 +0200
Message-ID: <20240624210418.19324-5-ansuelsmth@gmail.com>
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

Handle alternative name for pn_swap property as upstream linux use
mediatek,pnswap.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mtk_eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 94f17a97fe0..5098afef8a8 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -1964,7 +1964,9 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
 			return -ENODEV;
 		}
 
-		priv->pn_swap = ofnode_read_bool(args.node, "pn_swap");
+		/* Upstream linux use mediatek,pnswap instead of pn_swap */
+		priv->pn_swap = ofnode_read_bool(args.node, "pn_swap") ||
+				ofnode_read_bool(args.node, "mediatek,pnswap");
 	} else if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII) {
 		/* get corresponding usxgmii phandle */
 		ret = dev_read_phandle_with_args(dev, "mediatek,usxgmiisys",
-- 
2.45.1

