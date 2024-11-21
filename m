Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4024D7879D
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 17:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B56189647;
	Thu, 21 Nov 2024 18:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="sPOijDcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8934D89669; Thu, 21 Nov 2024 18:23:47 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id 69EBE88815
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 18:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732209819;
 bh=otUyvzwI/A3QLajLClc8I0z5iw/0uub63vtoBofi1dw=;
 h=From:To:CC:Subject:Date:From;
 b=sPOijDcb00NzcdQZ+OrPkPA7czXToJ2MV2LB/0v//bQZNCx2lUp8JctxEIu6FmB+D
 icM0stEtvkn94ndad+GMJO+qAL2/5sgtAmqy0lj5X00tfrpIknorVcSh4CuqL4e3m0
 O21pQQJwGlQ3G53D4vterqZWRHq3viOXGsBahRozLIozSW6FfnQ31x1T0OaOOZ4VRy
 Wf5yiYFgPZm4A+b/DgTyiMWl0Uvcg+WP77L0QiM+1SUgDPBOfvoEDay0Xpp6bRgVjn
 EUuxJcjLshXsgdlAJ57Rq2FHcqK9CyYyFlSWXuLnY0nwLwUfKQQrrrpmwWICcvL3TB
 E3HObJAhuFG4g==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, NXP i.MX U-Boot
 Team <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V3 1/3] arm64: dts: imx8mp: Add aliases for the access to the
 EEMPROM ID page node
Date: Thu, 21 Nov 2024 18:21:52 +0100
Message-ID: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
that contains an additional write-lockable page called ID page. Add
aliases eeprom0wl and eeprom1wl for the access to the EEMPROM ID
page node.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
V3: - Add this patch to the series
---
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
index c065fb8299..546490a4a8 100644
--- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
@@ -9,6 +9,8 @@
 	aliases {
 		eeprom0 = &eeprom0;
 		eeprom1 = &eeprom1;
+		eeprom0wl = &eeprom0wl;
+		eeprom1wl = &eeprom1wl;
 		mmc0 = &usdhc2;	/* MicroSD */
 		mmc1 = &usdhc3;	/* eMMC */
 		mmc2 = &usdhc1;	/* SDIO */
-- 
2.30.2

