Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9504CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E1382A53;
	Mon, 18 Aug 2025 12:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DDUdoK0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4429880107; Mon, 18 Aug 2025 12:44:32 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56E4F81D5D
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso3749010f8f.3
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755513870; x=1756118670; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iqh+eeI/lw+ZZbK/vCKSTtUpOtrwC5RdyH+LMCAk/Tk=;
 b=DDUdoK0MG+5i1u7zhCxKspXeLjHXr6LZpayOPFHLe8jD+1u63Ce7qq5xuyd+86zVEd
 k41Gb3RWJv6cwaE4vZJFV4OCAuXnGTeIRimmpTyCrbPqkxeXetvGKNMajG6tZ00v13hJ
 wVeeHmfXXatZavieOGmfF8NNop2HdMi+X9+1iHkhv1dH1jJHI1GXw0Fib4HXgtql3eyl
 L1kKx46UlVvNiIiJz1xw9rhV1TQtUNVNGWFv/J1hjMBI0obrECYgt5LcaWqaff6zDo34
 o6id4EtQoe7s3DhKktLDtoCL6fKSOSayrRvrKKBaH3nLW+22sr5Qw0VDVky7GuIMVEW/
 Iq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755513870; x=1756118670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqh+eeI/lw+ZZbK/vCKSTtUpOtrwC5RdyH+LMCAk/Tk=;
 b=dXCfz601iv7JaiCuWeJwrl6Dzrt1ft4l8kEPrDun0OW/xcisJ8iByd+ukuC5gkFNHM
 NEq7KBcL6aeybw576Dee5BQmNFhe9s24G5BdV+ni0CD/7V3lPdk89KrBZ61qsEWyRVxd
 ZCqWGv3XRDkSDL7n8z4lvYzAWNw9SP+oU1RAxJBkOJCaJb4ROLVd2AfV3uGGDFu71saX
 VsshsmTBaRfLuNgaRFJZkn2gdW8ljBbTGoAnB43JzxBjZ/ignt9a4CSKNVViaM9vZgaO
 Z0091o4mvtAPIft6gvac3RfGY7D7Kce/DxUVOqndXnAa3sYnAqfI5ZSn90GxYb9rHz5t
 a0ug==
X-Gm-Message-State: AOJu0Yx4XqktQwV2Sl9jZai3zqIzR92F7scdBjWk8/yOxvhhIibcSyqg
 Pe5Q/HcGZeOFa9dXStbDRLinBeOog9yQO5RFEZolaRXSiN3D/mtbhaQupeee4PNh+h4=
X-Gm-Gg: ASbGncu8f3qHXxXhpiTdiTrcFoG0ezzAFY1lUP0iA3qhUqcMPUevzZH73diZp5B7H5Y
 Denq1Q3MbumK63qzhhWcbjLElZPbQTRA2UzrlgFcz9WjZsm1vDHeimQr4AoHjWnn3ZtFE7xkOsq
 jHFcSXOXyBZpqPDERBBrncNk/Cx3lC3os3qRcnn5yz8iHUkGQxfsOwLE+3RD5PAurW8T8hN/2Af
 dYpG69/mwAZSzJT0o7afOxtBJwoo6VSq2aZDCxxpDkLjPRD4M9HUDZo2SlG4xR+X4DqjVBQWIIF
 0L/5Q4uxQFvbuHWGsTT3+R8bMrklyhf7rcpiSwbWboYthT/H5XI+t3+ERiIR1h2yv9wJiJVnYVj
 0bsJ90CA9qYhLrh4e8GbNliFMWSfDNBmmDAlwhHtoV4e0n/Foko73DTKJTEUMIA==
X-Google-Smtp-Source: AGHT+IEXZX3bHvb2AAJBjoUKEs++73S/S2Zc6AagT7owV643um7pB49DGQupcGjAVz5LgjfUXHDEwg==
X-Received: by 2002:a05:6000:2409:b0:3b9:7c00:b6a9 with SMTP id
 ffacd0b85a97d-3bb68a1649amr8946782f8f.28.1755513869788; 
 Mon, 18 Aug 2025 03:44:29 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:69b5:38a0:910b:c9c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb652f75aesm12293643f8f.23.2025.08.18.03.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 03:44:29 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 18 Aug 2025 11:44:28 +0100
Subject: [PATCH v2 1/2] phy: cadence: sierra: Remove variable that is not
 assigned to
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-phy-cadence-sierra-v2-1-f2d309b170e2@linaro.org>
References: <20250806-phy-cadence-sierra-v2-0-f2d309b170e2@linaro.org>
In-Reply-To: <20250806-phy-cadence-sierra-v2-0-f2d309b170e2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In cdns_sierra_pll_bind_of_clocks the variable 'i' is declared but never
assigned to before its value is used in a dev_err. There is nothing
obvious to assign to 'i' so remove its use and just put a default of 0
in the dev_err call in its place.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 2c9d5a12127..bd7ab9d1b77 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -225,11 +225,6 @@ static const struct reg_field pllctrl_lock =
 static const struct reg_field phy_iso_link_ctrl_1 =
 				REG_FIELD(SIERRA_PHY_ISO_LINK_CTRL, 1, 1);
 
-static const char * const clk_names[] = {
-	[CDNS_SIERRA_PLL_CMNLC] = "pll_cmnlc",
-	[CDNS_SIERRA_PLL_CMNLC1] = "pll_cmnlc1",
-};
-
 enum cdns_sierra_cmn_plllc {
 	CMN_PLLLC,
 	CMN_PLLLC1,
@@ -602,7 +597,7 @@ static int cdns_sierra_pll_bind_of_clocks(struct cdns_sierra_phy *sp)
 	struct udevice *dev = sp->dev;
 	struct driver *cdns_sierra_clk_drv;
 	struct cdns_sierra_pll_mux_sel *data = pll_clk_mux_sel;
-	int i, rc;
+	int rc;
 
 	cdns_sierra_clk_drv = lists_driver_lookup_name("cdns_sierra_mux_clk");
 	if (!cdns_sierra_clk_drv) {
@@ -612,10 +607,8 @@ static int cdns_sierra_pll_bind_of_clocks(struct cdns_sierra_phy *sp)
 
 	rc = device_bind(dev, cdns_sierra_clk_drv, "pll_mux_clk",
 			 data, dev_ofnode(dev), NULL);
-	if (rc) {
-		dev_err(dev, "cannot bind driver for clock %s\n",
-			clk_names[i]);
-	}
+	if (rc)
+		dev_err(dev, "cannot bind driver for clock pll_mux_clk\n");
 
 	return 0;
 }

-- 
2.39.5

