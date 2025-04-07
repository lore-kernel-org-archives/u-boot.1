Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277DCC369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28AF08311B;
	Tue,  8 Apr 2025 00:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hKSUYiE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 460D883189; Tue,  8 Apr 2025 00:48:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BDDD83108
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066103; bh=I1Ahz2Rjf5e8UNbDVO12E9Dc1Ewu3VNE7YkuP7W9TsM=;
 b=hKSUYiE/KklVhZyb/lsNfg0LVTV+BFt/W1RaC4qP1IwnM1Jx8INsj0b0aQ3ynlvrQSPawKZY3
 LKiXoBRMg5cOppZheM6ZmyX9ZfXSnY9D4MC7UrxLXFaUi6ymirKk2+rSB0MyY7/BDJYXZ4G4ahf
 v2+ZByRat8uyjRZShL+s22njNFjoUC/7Px2rOlSezf/FHDLPwGAJSthJ1Z+/WI436c/Qeqp0gZp
 PRbo3cqhl1OYukzsILiI7atvZ1f8kLvEEsuyVQYwcStHfjb4mYkspISWhC7TQatdEGJoztF8Fcy
 wTwlopOfPr/U9Rp8Lq/1S5UgMddXEGAAJPJJRbWtlyaw==
X-Forward-Email-ID: 67f456329fd75b9b965127e4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 08/30] arm64: dts: rockchip: Add SDHCI controller for RK3528
Date: Mon,  7 Apr 2025 22:46:41 +0000
Message-ID: <20250407224743.2423921-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

The SDHCI controller in Rockchip RK3528 is similar to the one included
in RK3588.

Add device tree node for the SDHCI controller in RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20250305214108.1327208-3-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: a98cc47f79ab5b8059b748bf0bd59335edfff7d9 ]

(cherry picked from commit db7a99c423dea0ead19d6a18053d898a762a3b48)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 dts/upstream/src/arm64/rockchip/rk3528.dtsi | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528.dtsi b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
index c2eaa0c6ea90..26c3559d6a6d 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
@@ -468,6 +468,30 @@
 			status = "disabled";
 		};
 
+		sdhci: mmc@ffbf0000 {
+			compatible = "rockchip,rk3528-dwcmshc",
+				     "rockchip,rk3588-dwcmshc";
+			reg = <0x0 0xffbf0000 0x0 0x10000>;
+			assigned-clocks = <&cru BCLK_EMMC>, <&cru TCLK_EMMC>,
+					  <&cru CCLK_SRC_EMMC>;
+			assigned-clock-rates = <200000000>, <24000000>,
+					       <200000000>;
+			clocks = <&cru CCLK_SRC_EMMC>, <&cru HCLK_EMMC>,
+				 <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
+				 <&cru TCLK_EMMC>;
+			clock-names = "core", "bus", "axi", "block", "timer";
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <200000000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&emmc_bus8>, <&emmc_clk>, <&emmc_cmd>,
+				    <&emmc_strb>;
+			resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
+				 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
+				 <&cru SRST_T_EMMC>;
+			reset-names = "core", "bus", "axi", "block", "timer";
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl {
 			compatible = "rockchip,rk3528-pinctrl";
 			rockchip,grf = <&ioc_grf>;
-- 
2.49.0

