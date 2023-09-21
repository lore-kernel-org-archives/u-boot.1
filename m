Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD16E7D0A4
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 18:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2598186BD5;
	Thu, 21 Sep 2023 20:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695321912;
	bh=wsz5LKrqjw+AmMICmybrZNYBUuCzcB1dkh2zTFqJRys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HIcFHPOtOosnizjbadZB5z/Eho54s1aHljHfxY+R/Cwzeb3Czme44m1dmJ7RgtUp3
	 1wHFS6bcffGxrPBJ8/eO9R5qqvLlen3jav4axNIBlTgIMyKsEjQIyVuZfr492/4Lh0
	 yl5Lsmw6vYxcaetgI08ud9ZqzJyN8fm6xLd6LbNQETac1ZwaaEwFSkqMvokZFiMo5b
	 JWsqE8cfb5YlYHilkCIBvB2wYrUPj8RdS0VyDkCZRMFYJ7xsKQJAqL7fdnnBDMaLdw
	 c8DPwuaK2xcD8Hh9nFqnRuY4xXqQky9AI6Ik2iT4nujVQfjYVaBIwV84sn5G9eg0bF
	 oeU7G2yOXHe7A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 56A99869F1;
 Thu, 21 Sep 2023 20:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695321910;
 bh=wsz5LKrqjw+AmMICmybrZNYBUuCzcB1dkh2zTFqJRys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k7K8y5uLjZnt1/4W/FooTJ3pzK70KExmLTpbnhCrI9Y7oXCF22mUkg0qmsuplh0mN
 8y1qbu/iYN8gd+HP7Ph2J+OKW4guZ78fIa34TKa40wO6sA0GX/Fhj/4Se0eFBikCdC
 qPxk3lXD+Ea6hZAivIzFpPcf6DRinEh6eur6BXuDOSk5seT0fdArgx3i9gM9pV4mrK
 CVUNzfZavuyH2I+x/YSi1oGk+/a8L+QCt2oBroFswhC+nxp09ds5ijsPGXxiTDb8Rd
 3FE01VF7sVJCg3/z8hYcxzRvI0rATtQzaznjxOvwE3dPWSmaUAd641JjMbACEyd5B+
 1KRcKgt2ldGnQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Fabio Estevam <festevam@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH 4/5] arm64: dts: imx8mp: Drop i.MX8MP DHCOM rev.100 PHY
 address workaround from PDK3 DT
Date: Thu, 21 Sep 2023 20:44:19 +0200
Message-Id: <20230921184420.45186-4-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230921184420.45186-1-marex@denx.de>
References: <20230921184420.45186-1-marex@denx.de>
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

In case the i.MX8MP DHCOM rev.100 has been populated on the PDK3
carrier board, the on-SoM PHY PHYAD1 signal has been pulled high
by the carrier board and changed the PHY MDIO address from 5 to 7.
This has been fixed on production rev.200 SoM by additional buffer
on the SoM PHYAD/LED signals, remove the workaround.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: Ovidiu Panait <ovpanait@gmail.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 arch/arm/dts/imx8mp-dhcom-pdk3.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3.dts b/arch/arm/dts/imx8mp-dhcom-pdk3.dts
index c5f0607f43b..867d238f2b5 100644
--- a/arch/arm/dts/imx8mp-dhcom-pdk3.dts
+++ b/arch/arm/dts/imx8mp-dhcom-pdk3.dts
@@ -227,10 +227,6 @@
 	};
 };
 
-&ethphy0g {
-	reg = <7>;
-};
-
 &fec {	/* Second ethernet */
 	pinctrl-0 = <&pinctrl_fec_rgmii>;
 	phy-handle = <&ethphypdk>;
-- 
2.40.1

