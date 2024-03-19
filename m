Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECADC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 02:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59EBE88065;
	Tue, 19 Mar 2024 03:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710816358;
	bh=zs5Fl0LoRLRvnrmVRahzg2Xvn9eQU1OMOJLjpAXGzHw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OJ6Iu40rXbMUnYBOJv2CVWCLB/MC9mhRkgupD6SbaINF1afa0jdSaBy8kc7+zhWpX
	 RUj/lXmCPQXhWvCTFiKH0/7Yw80IPu2uc14qPAMyBSNhjLc6DibL0WzydNU9a5Tkf6
	 3fCJ5ffbyxdKaA/2SIOwk6vktUvchyEBKH8IDlHZI2x2/A36oRzuKlJUvojzBxYv2z
	 bI5U/F3oa1ckMNPIvu58yd/y/zXuW4MrNwDOwErT8761zS+olFiWlSaKyZWoQl33oQ
	 8k5JCz/HfGmtAdUGiX7GfSfdB+BA48eF1uFMtqkWily3WByHTs6moO2r/mIeei1/ZB
	 0056Dt151q7gQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 70AAA8573F;
 Tue, 19 Mar 2024 03:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710816357;
 bh=zs5Fl0LoRLRvnrmVRahzg2Xvn9eQU1OMOJLjpAXGzHw=;
 h=From:To:Cc:Subject:Date:From;
 b=CHD4TL4R58Mo+FfUMkc2xi3xwEZp3Z5PZulj4toFBTZAh0xwrHbFFAEXhWAtjzOTk
 lqpxvKWq3WRbV6zaHQ3SccVm5YdP07z18awkupDwhdos9PGAtn0GPG+N8cQBw0/Y30
 xvuYq6g944mqTrcxU9bxj/wUbPoJLIkVgRlKPiXisH5AcYj6uyo5I84FQE9RHiRJYA
 f+pLznLSG8W2zm9n7Y3N5HoQ2y2hRJK2nibX107gNwjfGYoab2s6zu5m6zwCxEd2lP
 gavIe8UXnREcRhQPIv8UIl//eQoDTCcNRg+GiE4JIo0x/ty4pmI87ZX5mWOm5PHxV9
 DKiL5LAtijnIw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] ARM: dts: stm32: add PWR regulators support on stm32mp131
Date: Tue, 19 Mar 2024 03:45:07 +0100
Message-ID: <20240319024534.103299-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

This patch adds STM32 PWR regulators DT support on stm32mp131.
This requires TFA to clear RCC_SECCFGR, is disabled by default
and can only be enabled on board DT level.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp131.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/dts/stm32mp131.dtsi b/arch/arm/dts/stm32mp131.dtsi
index 81d99a7582b..ad331b73d18 100644
--- a/arch/arm/dts/stm32mp131.dtsi
+++ b/arch/arm/dts/stm32mp131.dtsi
@@ -1092,6 +1092,30 @@
 				 <&scmi_clk CK_SCMI_LSI>;
 		};
 
+		pwr_regulators: pwr@50001000 {
+			compatible = "st,stm32mp1,pwr-reg";
+			reg = <0x50001000 0x10>;
+			status = "disabled";
+
+			reg11: reg11 {
+				regulator-name = "reg11";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+			};
+
+			reg18: reg18 {
+				regulator-name = "reg18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			usb33: usb33 {
+				regulator-name = "usb33";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+
 		exti: interrupt-controller@5000d000 {
 			compatible = "st,stm32mp13-exti", "syscon";
 			interrupt-controller;
-- 
2.43.0

