Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF729C27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31FDD8890F;
	Thu, 13 Jun 2024 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UB+nVSAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD06888F2; Thu, 13 Jun 2024 13:10:21 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799B3883D3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57c6afa1839so423931a12.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277019; x=1718881819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kr80qGA8fTtmGld4Thh3XY/hn2vKZu79T8rEjD9KMoo=;
 b=UB+nVSAUMkgVN4Ye0gldVzLbJzKkNzocI9RJJO4LiuCn4RmXn5drH6UBbKaWcQmVbP
 yOwuVpYmBegbSwYbdXqbBHdzTXInEw+3Dmv6yLVZTuXQFMuCAbv/Tkg/Mp6rfB6YiFWF
 eNxBOhS1+3XSvOGM7gu9e+Zzmbr+05SvJOZZCTOKl/OkRGVsVTMFeLi96H06XKSBzFyq
 TKk46Y4t+F4vWYF5GU6JEwDoe+/PmSi8AdyNl1fnW9B8eMPQbAshAUSmzy6tEnHMs+IM
 hEx1+eGYb7QefX+Nbk/3ChRRCvQskc2/KM5COfYpiEpYk/ecSPGrESJOkGyzmHyXJoXU
 WGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277019; x=1718881819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kr80qGA8fTtmGld4Thh3XY/hn2vKZu79T8rEjD9KMoo=;
 b=o26jmUBL7Sdo6CDJtN7jUlewPQJSjjOIw6y7lZXJI/apEJxo3PIjp5AXciN5/XtrMo
 lauMV3XKHVbF7hVGnsPoAfdy75xILGT+vOhfoU3rx80f+KaupnJUqPSq2lZ6xi1RUuhV
 azNOkbsyRTI1jou9MjBpS9RlYWKyAqz0l838yRFUxD5lv464ODJDJEDeOFP2+kHqnxZH
 dRL2GC4YMGczccGLpK2ThOLv4EG2PA+wqqsaZ4cM/a+wdTFKHy4TwpxQikoLVq10i/rx
 Py8S0WxTi8GMmPYUS/K16cs2pYG+0iixeJILYHT/JpPpvOHg67VHZEZXpSvrZ4RO7Uae
 dUhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqWcSprgMIzEulrtLXvuC0lWp3kXqeUtBkkn3aaZewdN1dffLiCPn3jml4K0+BdV7jSpemc3rXTdmQoFlYIDjMhC+nyA==
X-Gm-Message-State: AOJu0Yx/qeZxKsLnSF9RhcKY9LX28vZAcvcH9n2HNSGyRhphDQZ60zKW
 giY+gbpg9IH90k5wl+RdAw+Wp2EpWBfUev4iztHdQEjttX4qyxyvn3UqCQ==
X-Google-Smtp-Source: AGHT+IFLUlNtZIbf65wp7K+4UED37pe4u0W5JmVhFzBgf52celWvYIzkBu3i+9jcM2SkbMu/EoukWg==
X-Received: by 2002:a50:d596:0:b0:57c:77a1:d1da with SMTP id
 4fb4d7f45d1cf-57ca8e69171mr4009929a12.0.1718277018724; 
 Thu, 13 Jun 2024 04:10:18 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:18 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 04/14] net: mediatek: handle alternative name for pn_swap
 property
Date: Thu, 13 Jun 2024 13:09:22 +0200
Message-ID: <20240613110949.11076-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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

