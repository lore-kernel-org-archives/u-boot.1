Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E8FC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238FC876CF;
	Thu, 30 Nov 2023 15:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="vvaB4c/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C0A870B7; Thu, 30 Nov 2023 13:35:29 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DB8870E4
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 13:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 7982F120008;
 Thu, 30 Nov 2023 15:35:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7982F120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1701347726;
 bh=p5h2HOkApI0PODxodRe0tPnWrKOz37J7AZ/kMjGxtS4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=vvaB4c/jXA3YBbZyflkmjcKOkmm1MOe18ayXRP5bQIFJy32IBxFuEZplguJwuhQ71
 L/SKBZAXWQN/IhFey0Q7TQgiZEAlzdZraLeIx8yqcVBr/6wylUIlvYF6G2Rryvti/t
 74XOdhkO/W4Yh1H2B6t8K4An7qN2NMDlYXjLija+H7XpqA3WDNoJ9Zv2JMmiztKZp7
 XmVJVpWIramswACEU5Rsgj4B6aIfPTXLi71ZZLNz4XmtVudptLWwfItQhWikJ/bV+s
 vVUn40CUr5qplMLSRaGwUDFNFBsnkPrbkZJ6mjPsx/j2BhvGmCtUfkcnRWJWT0MhFo
 CvEsfhKhS/P0A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 30 Nov 2023 15:35:26 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 Nov 2023 15:35:26 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v1] arm: dts: meson: add NAND controller node for AXG
Date: Thu, 30 Nov 2023 15:27:12 +0300
Message-ID: <20231130122712.189700-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181735 [Nov 30 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5
 98d108ddd984cca1d7e65e595eac546a62b0144b,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; 100.64.160.123:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/30 11:05:00 #22583687
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 30 Nov 2023 15:10:20 +0100
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

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm/dts/meson-axg.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
index 3f5254eeb4..c01ace3ff1 100644
--- a/arch/arm/dts/meson-axg.dtsi
+++ b/arch/arm/dts/meson-axg.dtsi
@@ -430,6 +430,27 @@
 					};
 				};
 
+				nand_all_pins: nand_all_pins {
+					mux {
+						groups = "emmc_nand_d0",
+							 "emmc_nand_d1",
+							 "emmc_nand_d2",
+							 "emmc_nand_d3",
+							 "emmc_nand_d4",
+							 "emmc_nand_d5",
+							 "emmc_nand_d6",
+							 "emmc_nand_d7",
+							 "nand_ce0",
+							 "nand_ale",
+							 "nand_cle",
+							 "nand_wen_clk",
+							 "nand_ren_wr";
+						function = "nand";
+						input-enable;
+						bias-pull-up;
+					};
+				};
+
 				emmc_ds_pins: emmc_ds {
 					mux {
 						groups = "emmc_ds";
@@ -1906,6 +1927,20 @@
 				resets = <&reset RESET_SD_EMMC_C>;
 			};
 
+			nfc: nand-controller@7800 {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				pinctrl-0 = <&nand_all_pins>;
+				pinctrl-names = "default";
+				compatible = "amlogic,meson-axg-nfc";
+				status = "okay";
+				reg = <0x0 0x7800 0x0 0x100>,
+				      <0x0 0x7000 0x0 0x800>;
+				clocks = <&clkc CLKID_SD_EMMC_C>,
+					 <&clkc CLKID_FCLK_DIV2>;
+				clock-names = "core", "device";
+			};
+
 			usb2_phy1: phy@9020 {
 				compatible = "amlogic,meson-gxl-usb2-phy";
 				#phy-cells = <0>;
-- 
2.35.0

