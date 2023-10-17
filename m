Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD66DCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 18:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133DA86C6E;
	Tue, 17 Oct 2023 20:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s3m1NIfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE92186DD5; Tue, 17 Oct 2023 20:57:28 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9ABF8074B
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c5039d4e88so69781891fa.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697569046; x=1698173846;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Onq5Ei9HhL/jY+JPRrJ/vO8LYK4BUfmy7FZQoeAmEfc=;
 b=s3m1NIfS5fGRtkwQC9PIfP/yTq9NavmX+JHvvMQw+XzZHVFs5ZpwBRLsot/cMtNxVE
 +tputP+ut6ha9CXCTWqEAJhbx7wmlPd767Q7niJD3pwargSIegteN9krEBVeYSqpREft
 zBvqt0dDJF2RVHDGST9pdYWZEAhyN298PkV6Q7hSVf2+2vovFaqrmkB9FAJC8eUGkOuB
 TkxNckKhkEJd0oDqDNO5Pvj/BQPfRVktZGErXIriY7j7h8dr6V0VV57O88XUyuYmFWng
 FzbUHRZ2X9DpB6jDOmUAGNg3C/HU/5M9WIRXIOWF1BpNq1Wt7qj3PqJd3hhi37Tp1Xlb
 raDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569046; x=1698173846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Onq5Ei9HhL/jY+JPRrJ/vO8LYK4BUfmy7FZQoeAmEfc=;
 b=f8v9Mgwk+/tJwYzLG+98vCRVBde5iE6kBvE1+OT/uTmULxqVzYJOToYUwRe6lAKOKi
 0y0aIjuc8eBd7sjNxgEIxJwBTCRsD9DY6+DJuBFDuy6BUP92YgEP9uXTFLh6NxPyz9FZ
 dCTH73GSgxGwUNYtA3lIQq4RkmFvbOsOG+XoAA0j5xYMszjAy7Leot2gJFO0PxG5mX1R
 EOVRD4wsAZWmtLCz+rQPtZqXj2vhDBWjLB5O48WIczC8cLPwzYBTdZQmdlLd7T7kuczt
 5rmtEL/psMycoG3ltO4SuNQGgyalQOFgFbiVtPXsQqp2LsqqWdgCEYeM8d0jEClq4eDc
 sKow==
X-Gm-Message-State: AOJu0YyMTTcYMjNkBW6h4bhlrKeMco0m0tM1Edq+W7wmhd0WUrI9+1l8
 61lCJO8+ZYZu9FGqNh/gkms4MA==
X-Google-Smtp-Source: AGHT+IHdMiN7anAX9QOx7OWWEnUmsThrgZGMF5RQpxq34B6mMx91q2+zdej7S6jlDhpYb9hKQ9AWUg==
X-Received: by 2002:a2e:b531:0:b0:2c5:3261:615e with SMTP id
 z17-20020a2eb531000000b002c53261615emr2082372ljm.35.1697569045855; 
 Tue, 17 Oct 2023 11:57:25 -0700 (PDT)
Received: from glaroque-desktop.box.freepro.com
 ([2a05:6e02:10a5:e010:ece4:111a:47e2:bab0])
 by smtp.gmail.com with ESMTPSA id
 fl17-20020a05600c0b9100b0040776008abdsm2579530wmb.40.2023.10.17.11.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 11:57:25 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
To: neil.armstrong@linaro.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, avromanov@salutedevices.com
Subject: [PATCH] phy: meson-g12a-usb2: fix ret check on power_domain_get
Date: Tue, 17 Oct 2023 20:57:25 +0200
Message-Id: <20231017185725.809524-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.34.1
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

Patch which add A1 SoC support create a regression on khadas vim3/vim3l
boards when we try to use fastboot command:

  => fastboot usb 0
  failed to get power domain
  failed to get power domain
  No USB device found
  USB init failed: -19

Add ENOENT check on ret in probe function.

Fixes: 5533c883ce10 ("phy: support Amlogic A1 family")

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/phy/meson-g12a-usb2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
index 4ba3992bda70..3958d2404b85 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -328,12 +328,12 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(POWER_DOMAIN)
 	ret = power_domain_get(dev, &priv->pwrdm);
-	if (ret < 0 && ret != -ENODEV) {
-		pr_err("failed to get power domain\n");
+	if (ret < 0 && ret != -ENODEV && ret != -ENOENT) {
+		pr_err("failed to get power domain : %d\n", ret);
 		return ret;
 	}
 
-	if (ret != -ENODEV) {
+	if (ret != -ENODEV && ret != -ENOENT) {
 		ret = power_domain_on(&priv->pwrdm);
 		if (ret < 0) {
 			pr_err("failed to enable power domain\n");
-- 
2.34.1

