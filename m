Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE7EFA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9644488D8B;
	Fri, 13 Sep 2024 11:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n3Dvtej3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1408A88D7B; Fri, 13 Sep 2024 11:57:25 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF16588C63
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53568ffc525so2468015e87.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221437; x=1726826237;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwi4cPqbH0Gum7XAARv0sguyMNQwlnsuLBp/em7mdL8=;
 b=n3Dvtej38zAkYrAcOzzRXsTEksA298MQ0GC2pjsQGxHgMUBB7vKkehttIPjIjQEHtY
 WQT2Q1Gw5JM/YrLutDYmTYJ4fcBuLxNiC4WMTXmMnBcHcCn1w68BTKH1IxHIIKrL5fqJ
 +88rG5+d3plqvWFFgo9aFy1fLbwgBYpjzbahw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221437; x=1726826237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwi4cPqbH0Gum7XAARv0sguyMNQwlnsuLBp/em7mdL8=;
 b=hyDLnEYPxlmTZtuX1OPOrCU5JUYlnE5O/l6SHLMkRZ/QyBkvaXdJd22CotqCGPhpLK
 t3Ueoa55o/Ydjmoif8XB7jjLM16uKDrgnImww1qJy9jlAgrLSdczhChT3/ScVEqNMyK0
 orP2WqTv1NGnRVeYMYtAxxvffxoz8jLH8eURR3DNvM5CNC/cjKGQ/iNudQEJ3Q3o0VMR
 BOzTGjRt9Lx+i853rkJa5KjTfFD9K451LA79HiFiit+s2uuJSc7AWKDtLaXITW6DcRTK
 f9DY4mRR+JFcxVbdzSUdpwERV2WDhvBqSYN11itmHw31iyLoE63xIP83/GP38cbOXeRd
 yMpw==
X-Gm-Message-State: AOJu0YwGXsIHTDn+G+MHH8gIx4fnv8HsUBRbsJ3x6PZS5wgJKvNQec+H
 Umy9eH/SD5Md5rftenlfDsQoAb5h7/NawKZKUMg45KX3b5MQFwHb7dWI5I0jNnygnzyBsdzHED6
 6ygQ=
X-Google-Smtp-Source: AGHT+IE/797e8F0J/AGAdFkC//QTExzwfhsWD+rZ8skW7Q+UVeFI0XkhJdMi99CEFVDFtrRRDUxOqQ==
X-Received: by 2002:a05:6512:3f03:b0:52c:cc38:592c with SMTP id
 2adb3069b0e04-53678f616demr3681093e87.0.1726221436131; 
 Fri, 13 Sep 2024 02:57:16 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:15 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Marco Felsch <m.felsch@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Liu Ying <victor.liu@nxp.com>,
 Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/26] phy: dphy: add support to calculate the timing based on
 hs_clk_rate
Date: Fri, 13 Sep 2024 11:55:56 +0200
Message-ID: <20240913095622.72377-15-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Upstream Linux commit 22168675bae7.

For MIPI-CSI sender use-case it is common to specify the allowed
link-frequencies which should be used for the MIPI link and is
half the hs-clock rate.

This commit adds a helper to calculate the D-PHY timing based on the
hs-clock rate so we don't need to calculate the timings within the
driver.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/phy/phy-core-mipi-dphy.c | 30 +++++++++++++++++++++++++-----
 include/phy-mipi-dphy.h          |  3 +++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index 8fb985a1e682..727c2b040520 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -13,21 +13,23 @@
 /*
  * Minimum D-PHY timings based on MIPI D-PHY specification. Derived
  * from the valid ranges specified in Section 6.9, Table 14, Page 41
- * of the D-PHY specification (v2.1).
+ * of the D-PHY specification (v1.2).
  */
-int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
+static int phy_mipi_dphy_calc_config(unsigned long pixel_clock,
 				     unsigned int bpp,
 				     unsigned int lanes,
+				     unsigned long long hs_clk_rate,
 				     struct phy_configure_opts_mipi_dphy *cfg)
 {
-	unsigned long long hs_clk_rate;
 	unsigned long long ui;
 
 	if (!cfg)
 		return -EINVAL;
 
-	hs_clk_rate = pixel_clock * bpp;
-	do_div(hs_clk_rate, lanes);
+	if (!hs_clk_rate) {
+		hs_clk_rate = pixel_clock * bpp;
+		do_div(hs_clk_rate, lanes);
+	}
 
 	ui = ALIGN(PSEC_PER_SEC, hs_clk_rate);
 	do_div(ui, hs_clk_rate);
@@ -74,6 +76,24 @@ int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
 	return 0;
 }
 
+int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
+				     unsigned int bpp,
+				     unsigned int lanes,
+				     struct phy_configure_opts_mipi_dphy *cfg)
+{
+	return phy_mipi_dphy_calc_config(pixel_clock, bpp, lanes, 0, cfg);
+}
+
+int phy_mipi_dphy_get_default_config_for_hsclk(unsigned long long hs_clk_rate,
+					       unsigned int lanes,
+					       struct phy_configure_opts_mipi_dphy *cfg)
+{
+	if (!hs_clk_rate)
+		return -EINVAL;
+
+	return phy_mipi_dphy_calc_config(0, 0, lanes, hs_clk_rate, cfg);
+}
+
 /*
  * Validate D-PHY configuration according to MIPI D-PHY specification
  * (v1.2, Section Section 6.9 "Global Operation Timing Parameters").
diff --git a/include/phy-mipi-dphy.h b/include/phy-mipi-dphy.h
index a877ffee845d..1ac128d78dfe 100644
--- a/include/phy-mipi-dphy.h
+++ b/include/phy-mipi-dphy.h
@@ -279,6 +279,9 @@ int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
 				     unsigned int bpp,
 				     unsigned int lanes,
 				     struct phy_configure_opts_mipi_dphy *cfg);
+int phy_mipi_dphy_get_default_config_for_hsclk(unsigned long long hs_clk_rate,
+					       unsigned int lanes,
+					       struct phy_configure_opts_mipi_dphy *cfg);
 int phy_mipi_dphy_config_validate(struct phy_configure_opts_mipi_dphy *cfg);
 
 #endif /* __PHY_MIPI_DPHY_H_ */
-- 
2.43.0

