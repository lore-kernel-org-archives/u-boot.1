Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DF0F364DC
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 11:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEDB84106;
	Fri, 10 Apr 2026 13:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="gGpkUAoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6248414B; Fri, 10 Apr 2026 13:04:39 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A1738414B
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 13:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso20156555e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775819075; x=1776423875;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZN1OzbWillfz+ozJwlcO6+S3o8uAqfaCBfcAyAtiL6Q=;
 b=gGpkUAoXKiiaS5rVrqBh7V3y8o7q+Jm6FJIvTqx8GOqverxA6mseV3H7KXhszcujnc
 K5HqOwbR9HS9Vx1gWDwjIsWYhMEEm/md2j3csgwwGz6gRFLQ5tkV4yCZumecvHumCAOc
 ini1KUwFZDb9kG+W9tmj3ijeTmlG8PANVgv+CNY0yMDjVo1zgaBmKs2Z0B+1M5/lAVlz
 xuAzz443cdy1yMS5vr7g5GCaPrF8q0/pe7J6mvfrhTgVt/NtLNiYAdvpQI8pqhGmRUEU
 fBzZbUjQK3Cy/fTodCNYT0zS/QZqBWAQaTuy78bRWK8DqOdbqMVPstY4kCI/HUnFHmhz
 HXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775819075; x=1776423875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZN1OzbWillfz+ozJwlcO6+S3o8uAqfaCBfcAyAtiL6Q=;
 b=gzPtsH1WS2OO7Y894HxH7siAHKPyWRunQINRTrbXxrpwICyTldFzf3rdShgRT3hu9z
 NURURZZfR8cXzAHLJuMY381YIFlMoKjaaMF6chGS8pDiclMHQKptYa16V3cekR7nxTGD
 NZwRJL4G8Y5G1nZJMUlAhulxN92UKr8qoQ8zLvOQOSs6iSlIW1V2g/NxwQL5bmMdDE5I
 KX2579Y4yTtOQMiE23YTaHN3ygWuSzsoa2V0+7wPdyuod8x/tqIX8qFqEdok6itKQkaz
 XcZILXUopMVHiDXlINQt6i4uMtIOroxxbblcVS506hfnm3au1nQ+vAZTq2+r7Gh9WcAJ
 aVkw==
X-Gm-Message-State: AOJu0YzIrmxAPLjQAH11FdX5nhbKOT23+G6XSquDkNUre8GNsJpCYS+4
 Ox987ASXgYS4edrACqY/ulxnFuN06OXi1o+zm5imgKg6Vn7oUWYQmHcwF9IdSqMZfp8=
X-Gm-Gg: AeBDietx80qz7aF+4jQqYJv1N2lsbKd+xZyfqkR5uMWWAzKcQO3NBqB+6jSynn1ls2O
 TqkQNrqxlorOhF8RiCRh3AtnvcdItBnJPFnBFZZWk3wP6yb4HgDwQEuKfQZaWUwM2cMiAUy+lH0
 mX7wo7zlmiOhww+/CeFdZ1VXNQHjrRMjfk28h7B5VzuTWwxVbaAOLrYtiNi5vuEgkkJQHyHMYds
 7AjeJstDm39MexfHEpYRtkGKA/qAyjMCuJIzrT/tf58UeFZ/dslVbr4H2Z5z0AoBfQk+L/9dfz2
 Zx+6pPEfbTUTXy0nzLxI4diJJKf1AoKJT08lBm2Yr88aaT33oXLGwf8RtG6kncz5SfT5oON34XR
 hwJvwMpFAeOmIaNqbZmaLFdGfClCXPi/nA1pxOCOOXNIxgQN/wLdsA007xQDq2JOWW3Xw04aKjo
 QnTlAqWpWle/Oc8KiO1oOZHkx/fVtbr9M=
X-Received: by 2002:a05:600c:a105:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-488d681701fmr21942875e9.1.1775819075381; 
 Fri, 10 Apr 2026 04:04:35 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d768afsm28377985e9.2.2026.04.10.04.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 04:04:35 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 13:04:04 +0200
Subject: [PATCH 2/4] net: cpsw: Remove compat string argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-cpsw-switch-v2026-07-next-v1-2-c914724b13e4@baylibre.com>
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
In-Reply-To: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=msp@baylibre.com;
 h=from:subject:message-id; bh=AFVzrkSTekVVI2V8UuqK6GvlQiF948dHfr88q4+k02w=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbN41+Kx/tmi7Lfu2biz6/t9ZUU9kldxvOhVnf5tjBV
 yg7e/bpjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIui5Ghm0BCRL5Vetmrv0R
 e0TsfM/M7QmyBiaXn5rO8cg5rT3r92OGv+ISd5X0/r3OnGL1qs35c6BMVuKSh/UeS777zN26uFH
 xBzsA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

The string is already in the priv struct, remove it from the argument
list.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/net/ti/cpsw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index 6bfdbb60091ac1cb7ef5a0bb3ad5221c2c11206f..c844416d50ca3db9bb0d9ffe56cd9c352b8c58b0 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -1064,9 +1064,10 @@ static void cpsw_gmii_sel_dra7xx(struct cpsw_priv *priv,
 	writel(reg, priv->data->gmii_sel);
 }
 
-static void cpsw_phy_sel(struct cpsw_priv *priv, const char *compat,
-			 phy_interface_t phy_mode)
+static void cpsw_phy_sel(struct cpsw_priv *priv, phy_interface_t phy_mode)
 {
+	const char *compat = priv->data->phy_sel_compat;
+
 	if (!strcmp(compat, "ti,am3352-cpsw-phy-sel"))
 		cpsw_gmii_sel_am3352(priv, phy_mode);
 	if (!strcmp(compat, "ti,am43xx-cpsw-phy-sel"))
@@ -1084,8 +1085,7 @@ static int cpsw_eth_probe(struct udevice *dev)
 	priv->data = pdata->priv_pdata;
 	ti_cm_get_macid(dev, priv->data, pdata->enetaddr);
 	/* Select phy interface in control module */
-	cpsw_phy_sel(priv, priv->data->phy_sel_compat,
-		     pdata->phy_interface);
+	cpsw_phy_sel(priv, pdata->phy_interface);
 
 	return _cpsw_register(priv);
 }

-- 
2.53.0

