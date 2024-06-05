Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8403DC27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA8688414;
	Wed,  5 Jun 2024 21:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T0RGS0sM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 141EF882E6; Wed,  5 Jun 2024 21:03:47 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F87F88261
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4213485697fso2140475e9.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614224; x=1718219024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kr80qGA8fTtmGld4Thh3XY/hn2vKZu79T8rEjD9KMoo=;
 b=T0RGS0sMs+YRhZ1IgYnNP5LWQ0LOQcFBD4vwDP8qRZL/M6i6Gp8WEpj821SzPXiXtX
 RjwN2m1Zf8mYX5i0N4+z0PbimPrUZbce/5rW7oFpy4pkF+vNHrBaAGt48zWAIB+m/HTO
 j8P2v2pKvnfvd1TUpThNcbijckCYXmBp1YU+LP77dZq5SMHVBVaHePJiyqqdnvzgGZBv
 ubDKMAnnqQwlasDP0xcWsRh7qQ6BHvPsmMMDcJ40JF+8/Sv38J67RtWcU0nPS9hs1TWt
 hJCYuK7efvo6yFvCc0/9dou5EsuqC7hFnQdoqRNXpNTJHdPAM7Xjkaeemch/WyyzqFhz
 RbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614224; x=1718219024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kr80qGA8fTtmGld4Thh3XY/hn2vKZu79T8rEjD9KMoo=;
 b=WdDywWq7fTDbtcQ1FsGyR++rxpyNf9qd+JGT0owRqNIRDV9Bhmk484W6xaqNstyPUT
 08kvZSWMMM2cuUO3GRfc7OvRUmjLopckT446DvlTdd8UM4xA7eCsBQHue41/0biPtSUB
 aTuY+elLQQFmKBQFSFUHQH6B+W4tOe+pxRgfuJ42agzJGDCAFZcWMhpDiJwK+D+BWFyx
 DKz4uDnfzsQvR8Nam8LrJ7ABHnwmGma/R+YSb9IJhkj4OaljZJE88fEjSJCpFzQfAvkS
 2oEzglR6W2aaF99eEylu9aa3ilwQDoCn7Fg1vx7g1xntptjqFB8ERKG4IPIyD/vD+muo
 DHVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2NKphb2f+3NSeOyeiRPquAl1qcm79lRj8e/+1kI6aPJOTVYw7xdO42qRlF7qyp2LPJaaAyNvWYvvDCnNY5ZTCg3yYPA==
X-Gm-Message-State: AOJu0YyRzxeCnSN9D6N9SRvqtBS9VRkmX4CnW6YMuDrg82YjaxTLyAot
 do7v752u+OlUaxe1VzJJQRnJRqosO00Qtz8/hJ/yNyolEWAK62WF
X-Google-Smtp-Source: AGHT+IFzLMHIiQTWILsOVgyiPA4WF0QOn97BSkqFIeETD+Dvc6dKmP8GcZM47yUzhSoCvCuBo4jg/A==
X-Received: by 2002:a05:600c:138e:b0:41f:e56c:ef81 with SMTP id
 5b1f17b1804b1-421562cf5f9mr25400085e9.1.1717614224529; 
 Wed, 05 Jun 2024 12:03:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:44 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Michal Simek <michal.simek@amd.com>, John Crispin <john@phrozen.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 04/11] net: mediatek: handle alternative name for pn_swap
 property
Date: Wed,  5 Jun 2024 21:02:11 +0200
Message-ID: <20240605190220.17616-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605190220.17616-1-ansuelsmth@gmail.com>
References: <20240605190220.17616-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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
index 75e7bcf83b7..87e2e1d9cda 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -1965,7 +1965,9 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
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
2.43.0

