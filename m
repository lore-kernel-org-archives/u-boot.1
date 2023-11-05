Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCF1C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 00:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244A786EDF;
	Sun,  5 Nov 2023 01:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699142721;
	bh=dVE++EJDL7vu4s+rhanr10cDhVyJ6s7xhZoSCHTG06g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LeDOTcw1pBzE04Vh0c61C6LcQuJ4WVFQA66pAIC2MyjynrfsIax/r/5qND1QnueiE
	 msjM4LpJ2iB52dEencvcrPZszchYlCBAuSDvX2dGSqFEsaZSK+lRFFckpiI+hLHW2X
	 7Lww8tImini86YrvCQAmYqCfnhwgps8J95PocSu2v4Y/gZXGjNmiPPKsyc3g9GfqUu
	 3o07BkalrmGNF+i4uL2TVXbZsw3pH89qsDZokHkgn1BUCa2qQKuGunccMIlFS9k/gX
	 3tft4fSTqp5Ezu3XR7mPwg6aKgnkmjf4kwt24Eghx2r4VODp0bSvSbceivk9ErRbaW
	 UX7D1Fe8JZRsw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5348386EC9;
 Sun,  5 Nov 2023 01:04:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699142692;
 bh=dVE++EJDL7vu4s+rhanr10cDhVyJ6s7xhZoSCHTG06g=;
 h=From:To:Cc:Subject:Date:From;
 b=nfA/HVZuNKRMslDpBWZujYm+Z0YRDHEP+mB6oUuKlKCzrj2Jo5GuYMqIYo9Cmzxzs
 /kXOAmKCQbFyhFVpeaO/vyF55JGA1DBlw55cI5uvbW3OeNDBlJAK8f5mv/7P2ZMrCZ
 Vc+ar2FLP7p/nZmr4K2Sm8JNU5dhsIFDj++1LxBOv+FEgDnNAfxvXs4MtwvkR3WxwC
 6fDUwc5OrEBbRwq5/6aOv9f3XQOSgy2PUNIho2aCBakof8GZeG+CYr2PtZP2K3A40x
 9emnYsOJ4eNTcrSoh4/ynNNQBzfMwtypWZ2lCorEFD5oQUbFDqdz1w44ZK138fKzj0
 m5ZFEDU3Wtgsw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH] arm64: imx8mp: Inhibit DTC warning on DH i.MX8MP DHCOM
 rev.100 DTO
Date: Sun,  5 Nov 2023 01:04:32 +0100
Message-ID: <20231105000440.273177-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Inhibit DTC warning in imx8mp-dhcom-pdk3-overlay-rev100.dts:
"
arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo: Warning (reg_format): /fragment@0/__overlay__:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo: Warning (avoid_default_addr_size): /fragment@0/__overlay__: Relying on default #address-cells value
arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo: Warning (avoid_default_addr_size): /fragment@0/__overlay__: Relying on default #size-cells value
"

The DTO overwrites the 'reg' property of an ethernet PHY and is only
used on specific combination of old prototype SoM and old prototype
PDK3 carrier board, which had incorrectly placed pull resistor, which
made the PHY change its MDIO address in that specific combination and
which is already fixed on production hardware.

The DTO is implemented in this simple manner because if it contained a
full MDIO bus node reference to define #address-cells and #size-cells,
it would also require a full new copy of the PHY node, i.e.
ethernet-phy@5 { ... reg = <5>; ... }, to avoid DTC warnings about
mismatch between node unit and reg value. The node unit in SoM DT is
ethernet-phy@7 { ... }; .

This simpler approach avoids unnecessary duplication without adverse
side effects.

Reported-by: Fabio Estevam <festevam@denx.de>
Reported-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 arch/arm/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 66862a70be1..70845c7ac8c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1481,6 +1481,8 @@ targets += $(dtb-y)
 # Add any required device tree compiler flags here
 DTC_FLAGS += -a 0x8
 
+DTC_FLAGS_imx8mp-dhcom-pdk3-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
+
 PHONY += dtbs
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 	@:
-- 
2.42.0

