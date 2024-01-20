Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D2DC47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 144D587CEB;
	Sat, 20 Jan 2024 17:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IADKgppn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1945E87D00; Sat, 20 Jan 2024 17:26:57 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F3F87861
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2cdfa8e69b5so19715351fa.0
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705768014; x=1706372814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UICucv6bKNvOrrM+SfZ3ATNp0EouIcnzrgeeJAb91yI=;
 b=IADKgppnR0xvTB5InyWlWX9OgorYPXLnxEGO0hqD+2dEAILmu2PFWTz6KiXBdxSiHi
 KgYPmcEaoiCWCF7zGuFD+xLWQHsR+GapjysJqWNRltbtb6htKgYRpOuSkt+eB+Cc609n
 W/2Cz8iSmzFxs1lPzWy5iX/BmTfVhjqe+KtSCPVXy/nXhoLoDymRC8SOlVEMQHnpRkHx
 RahSUHkIA8h1+Gz/17/H4IPA5SAka9F/kdJWQlayFlhkhUtVpNP0joh6zBdu7lzsE9VZ
 +yIRTzrwogjoppAfLkcyGO96wtsYy2Uo/YisWSCJVJe5xzb50+oj0M0hWf7I86V7Ixby
 pDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705768014; x=1706372814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UICucv6bKNvOrrM+SfZ3ATNp0EouIcnzrgeeJAb91yI=;
 b=EI5FcPgox/RFUygKmGERk5UZZ6YQIc5+2M+Bq+uHEBRMYjhu6kbt8C/1aHpUlobbot
 /OiC+vT4jGxIWfG5nML5zM+Gr82lfgDLcgPHQtHWMKYv+twBquxqVIampk5G6zFpmTXd
 ZN2EKL1IYVlYo1+0kEvQbJw6vWClbf+7vVSiRVZj7yjYwGlWM1yGhqK7HHogOx81J+mP
 ++K9RF6+s7dSYFhH4I2AtL9plJ5U2MAsLvsdBLB64Xob25DJuZUwKezTEr1k4+AhnVN5
 Z78KyAA3CURDyJR2PeWekIHjJizOFvB1mjZehHjYAl/dTd5F10mzEzD+uxnRT4W9j9La
 MvPw==
X-Gm-Message-State: AOJu0YyYHfGxoHZCusk8XdxzFrUomdzVgZD0Ucx7MBQJPp2TMsy4meyA
 7E7Z571SmS50ECdQHhX7vABGhYwKSF0ilN3yidB1tbaBRYEXmjNS
X-Google-Smtp-Source: AGHT+IH2o72aBC01oONMNpctmh0q0qYTRo5Bp5jPJjWxmV1qKFg51uIRw+1Wr3Bs70bzGiI+SGCsRg==
X-Received: by 2002:a05:6512:6ca:b0:50e:d10:84a with SMTP id
 u10-20020a05651206ca00b0050e0d10084amr465865lff.84.1705768014050; 
 Sat, 20 Jan 2024 08:26:54 -0800 (PST)
Received: from user-PC.. ([92.51.95.194]) by smtp.gmail.com with ESMTPSA id
 o3-20020a056512230300b0050ee557f1dcsm1356715lfu.115.2024.01.20.08.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:26:53 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>, Sam Edwards <CFSworks@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH v2] net: sun8i-emac: Add support for fixed-link phy
Date: Sat, 20 Jan 2024 19:26:24 +0300
Message-Id: <20240120162625.2413494-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Make the "phy-handle" property optional, which allows support
for a fixed-link phy configuration.

Thus if the "phy-handle" is present in a DT, then driver will work as
before. Otherwise, phyaddr initialization will not be necessary,
as it is not needed in case of a fixed-link config.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/net/sun8i_emac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index a12f7e32e8..8bff4fe9a9 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -833,11 +833,8 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
 	priv->use_internal_phy = false;
 
 	offset = fdtdec_lookup_phandle(gd->fdt_blob, node, "phy-handle");
-	if (offset < 0) {
-		debug("%s: Cannot find PHY address\n", __func__);
-		return -EINVAL;
-	}
-	priv->phyaddr = fdtdec_get_int(gd->fdt_blob, offset, "reg", -1);
+	if (offset >= 0)
+		priv->phyaddr = fdtdec_get_int(gd->fdt_blob, offset, "reg", -1);
 
 	pdata->phy_interface = dev_read_phy_mode(dev);
 	debug("phy interface %d\n", pdata->phy_interface);
-- 
2.40.1

