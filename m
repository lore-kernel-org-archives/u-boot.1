Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9067AC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5914B80E8F;
	Fri, 31 Jul 2026 16:36:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 950I2Ib80XrL; Fri, 31 Jul 2026 16:36:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76B7A80FEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515771;
	bh=Xe82KJMcJkHnE8sxFUdRm/DzraWdjJiDaHAJJQlZNK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eP4XDMaUMMUz087FU65P4zXucEwbMj+Me/oRbyJRbPORA8rAM6AHeAB661+bMkL8n
	 PcF9+mpJQ+raNJA3B9q33ZTpomiAwSrlv5lblk4mtAWU7pquIzYS6Po5bpDNV1LOrY
	 ol8Q6Kukv+TpQcRmyzaJHipgCvR1aTe6aUNkwkb8SSX5WvNUGfcYNL2zU6RWl9p9w6
	 kAYip+TAo15ZMGbdDtvl1JxlaBk5yDRE3tBpWrKN5HvOuglBXMXE8U+A4vJ9XM3KCY
	 TvP5vhoJ1GjMZwgKFrN5bq9RhtaihFKzveVM4PkZ9ZNlSTi4v/kWVwHYFwKRBcvtoF
	 olt1vAvjIoAXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76B7A80FEF;
	Fri, 31 Jul 2026 16:36:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E5AF36E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21B9040685
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6K0Ff3hxhhXW for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92b; helo=mail-ua1-x92b.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DFE464061C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFE464061C
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DFE464061C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:30 +0000 (UTC)
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-96723c7151eso300790241.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515669; x=1786120469;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xe82KJMcJkHnE8sxFUdRm/DzraWdjJiDaHAJJQlZNK8=;
 b=FPet4f0F7scR6+UDIJ2zo1LLKKWyz0PI1wzHC8W2i18hjn5lvDuKqPUvBhQKWE2ENX
 NCfaDOhnHGLKxbKi2Z8lGoBBZ9tjU3rpQ+xnReA0Lk++t3z0EstKFbjdWbhVqPnrNjMS
 5s5Li1K2AdiHY6KDamfcFfjJZmnKbTBsUNTveBFO6yHuZ0b2q/MFk35kjvJU8VDuhKB6
 0zIKMq7zwx0tU3nGKxzsO4OViaGsd6FZ4dDFCbvdU6fAmlyMeTKVM6EG40IcTtYxtbHX
 z880rlFV85T/dRvRQATppnOzlW4QBvgQYA3VLDFIGlmPDsB3LPE+2qzzBdiOtALUs+Dv
 hIxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxxJkjWBWyjD0OZ98pElL0rokzrtVnQE8efztjicEglbv1pVX2SnmFT893I9IANd0oWtUuvSo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxAEBPqvU5AyKGRsn41HEkiOSTUcsKErOVjnynU1mmR4lx0yB0b
 ZuRDfN00YzA2BzeE+CzTqM6cXQxeVvHD8H3lUnyX2ALvK6rBsuCLd+5tnHjOCfrXEqU=
X-Gm-Gg: AR+sD10xPos3oHsNfmBPODBsfaX74vLgLYMOwmPm+8p3yS+/fv5q/ILcbw/DHZTkszI
 ZPhUiofrrECcKO+UPZR1r7R7yD4XvtL3DL1pF29r1t75VKdD6PCWIZ+0nMavPkqEtEmN7UPMlk2
 n3vhN0JaEx1wy2wVOfJrrDZ/SQbkBeaoyBYshkK3VIsTQCApTtHVWdvPfSTkv8qf6PQ5R3EYqjB
 ztcBBqieOXe0aXGrV8h+kzNlOb2XUzRFwYbAOQz2YKj1LvxdpFvgMn1yahnIa8LzGk84q+ALjYq
 6JejZ59a9Ri8Gp2AKk5J6MY6Vk3ifa1wU0n59An39ZCxFbJ7DVaSl2JSNKyyJkD2MkjRBPZa8lY
 YH0wUXAqoaJtO1oAthJNFoEK6apwoVP8ulx6wYGTqzXehKP6s8oJG/8rjqzaccYCS8XRCe74feA
 ZiWh+p6WKwKwK/2X/M4UCsoHym9e57YToJ9IcjEm19HBwZbC5X0TKN0IZmFHr5Bsm5zQxPJhkaI
 4dpK5T1q3p3C6RYZGn+TG1kDnUVTdZuV0Lqmg7skRWwWyn1BtSsXwZCOFzI/2lHXtsgRvTU
X-Received: by 2002:a05:6102:424b:b0:739:4fa1:50af with SMTP id
 ada2fe7eead31-75b21a61015mr731640137.2.1785515668757; 
 Fri, 31 Jul 2026 09:34:28 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:28 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:45 -0400
Subject: [PATCH 16/17] ARM: dts: r9a06g032-rzn1-snarc: enable new drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-16-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515626; l=11337;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=P25MWE5y+T+eMFpbW5KWatXu15RXmd8S/s0H4jIfFeM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPGZYItkVHiBHmDwESYNxGZ9IzPfCEDcGHYH4ds/35bJvB4XyYSU2clmJSPWz6BUtb+HpmQVdd2
 4euFrcYzZggs=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515669; x=1786120469;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xe82KJMcJkHnE8sxFUdRm/DzraWdjJiDaHAJJQlZNK8=;
 b=Lh0GCN8yy8DgWRmygt6CIiWyTraTHcAlm2qhXw5SQExOnB/Jso8Mk9yAg5G8Y5xRAu
 kvchUmPOb7P26/cvVyE3rNdOfKxBTgSpfsXZAilVSVcBTEDGPQiE8PoASjTE/X1nDiuX
 XhEPJKCL1TfnOUOTmT3omaram5pXaa0l9L6ewaGt5HcB2XjJvBTuAjHD9QaTvDlBu4n5
 V+96HTX/B7/Tyv9BbdN1dy2uOuKy8axKBybkPN7ueKhL+QWW/HYOwVHYsxQGOJpD6Wow
 LDmERQFwyA8JLXngDFNxugPEvD4fiOE7JpifAtuUGmuM2LgpJwnRBWn0r/LwVOF+kHC2
 JH5g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Lh0GCN8y
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add pinmux and enable newly added drivers:
- MMC (SDIO)
- QSPI flash
- NAND flash
- USB controller
- GPIO
- Ethernet (designware)
- A5PSW ethernet switch
- MIIC media converter

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 arch/arm/dts/r9a06g032-rzn1-snarc.dts | 390 ++++++++++++++++++++++++++++++++++
 1 file changed, 390 insertions(+)

diff --git a/arch/arm/dts/r9a06g032-rzn1-snarc.dts b/arch/arm/dts/r9a06g032-rzn1-snarc.dts
index 7de8ee15ef3..c05dc3346ff 100644
--- a/arch/arm/dts/r9a06g032-rzn1-snarc.dts
+++ b/arch/arm/dts/r9a06g032-rzn1-snarc.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzn1-pinctrl.h>
 #include "r9a06g032.dtsi"
 
@@ -73,9 +74,262 @@
 	};
 };
 
+&gpio0 {
+	pinctrl-0 = <&pins_gpio0>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gpio1 {
+	pinctrl-0 = <&pins_gpio1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gpio2 {
+	pinctrl-0 = <&pins_gpio2>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gmac2 {
+	status = "okay";
+
+	phy-connection-type = "rgmii-id";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	fixed-link {
+		full-duplex;
+		speed = <1000>;
+	};
+};
+
+&eth_miic {
+	status = "okay";
+};
+
+&mii_conv1 {
+	status = "okay";
+};
+
+&mii_conv2 {
+	status = "okay";
+};
+
+&mii_conv3 {
+	status = "okay";
+};
+
+&mii_conv4 {
+	status = "okay";
+};
+
+&mii_conv5 {
+	status = "okay";
+};
+
+&switch {
+	pinctrl-0 = <&pins_eth3>, <&pins_eth4>, <&pins_mdio1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	phy-reset-gpios = <&gpio2a 26 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <15>;
+
+	dsa,member = <0 0>;
+
+	syscon = <&plat_regs>;
+
+	mdio {
+		clock-frequency = <2500000>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch0phy4: ethernet-phy@4 {
+			reg = <4>;
+		};
+
+		switch0phy5: ethernet-phy@5 {
+			reg = <5>;
+		};
+	};
+};
+
+&switch_port0 {
+	label = "end0";
+	phy-mode = "rgmii-id";
+	phy-handle = <&switch0phy5>;
+	status = "okay";
+};
+
+&switch_port1 {
+	label = "end1";
+	phy-mode = "rgmii-id";
+	phy-handle = <&switch0phy4>;
+	status = "okay";
+};
+
+&switch_port4 {
+	/* Upstream to GMAC2 */
+	status = "okay";
+};
+
 &pinctrl {
 	status = "okay";
 
+	pins_eth3: pins_eth3 {
+		pinmux = <
+			RZN1_PINMUX(36, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_TXCLK */
+			RZN1_PINMUX(37, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_TXD[0] */
+			RZN1_PINMUX(38, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_TXD[1] */
+			RZN1_PINMUX(39, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_TXD[2] */
+			RZN1_PINMUX(40, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_TXD[3] */
+			RZN1_PINMUX(41, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_TXEN */
+			RZN1_PINMUX(42, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_RXCLK */
+			RZN1_PINMUX(43, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_RXD[0] */
+			RZN1_PINMUX(44, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_RXD[1] */
+			RZN1_PINMUX(45, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_RXD[2] */
+			RZN1_PINMUX(46, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_RXD[3] */
+			RZN1_PINMUX(47, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH3_RXDV */
+		>;
+		bias-disable;
+		drive-strength = <6>;
+	};
+
+	pins_eth4: pins_eth4 {
+		pinmux = <
+			RZN1_PINMUX(48, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_TXCLK */
+			RZN1_PINMUX(49, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_TXD[0] */
+			RZN1_PINMUX(50, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_TXD[1] */
+			RZN1_PINMUX(51, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_TXD[2] */
+			RZN1_PINMUX(52, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_TXD[3] */
+			RZN1_PINMUX(53, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_TXEN */
+			RZN1_PINMUX(54, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_RXCLK */
+			RZN1_PINMUX(55, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_RXD[0] */
+			RZN1_PINMUX(56, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_RXD[1] */
+			RZN1_PINMUX(57, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_RXD[2] */
+			RZN1_PINMUX(58, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_RXD[3] */
+			RZN1_PINMUX(59, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)       /* ETH4_RXDV */
+		>;
+		bias-disable;
+		drive-strength = <6>;
+	};
+
+	pins_gpio0: pins_gpio0 {
+		pinmux = <
+			RZN1_PINMUX(13, RZN1_FUNC_GPIO)	/* GPIO0B[7] */
+			RZN1_PINMUX(14, RZN1_FUNC_GPIO)	/* GPIO0B[8] */
+			RZN1_PINMUX(15, RZN1_FUNC_GPIO)	/* GPIO0A[6] */
+			RZN1_PINMUX(16, RZN1_FUNC_GPIO)	/* GPIO0A[7] */
+			RZN1_PINMUX(17, RZN1_FUNC_GPIO)	/* GPIO0B[9] */
+			RZN1_PINMUX(18, RZN1_FUNC_GPIO)	/* GPIO0B[10] */
+			RZN1_PINMUX(22, RZN1_FUNC_GPIO)	/* GPIO0A[9] */
+			RZN1_PINMUX(23, RZN1_FUNC_GPIO)	/* GPIO0B[13] */
+		>;
+		drive-strength = <6>;
+		bias-disable;
+
+		pins_gpio0_pullup {
+			pinmux = <
+				RZN1_PINMUX(25, RZN1_FUNC_GPIO)	/* GPIO0B[14] - A70CI_EN_N */
+				RZN1_PINMUX(26, RZN1_FUNC_GPIO)	/* GPIO0B[15] - A71CH_EN_N */
+				RZN1_PINMUX(27, RZN1_FUNC_GPIO)	/* GPIO0A[11] - TRUST_M_EN_N */
+				RZN1_PINMUX(28, RZN1_FUNC_GPIO)	/* GPIO0A[12] - TRUST_X_EN_N */
+				RZN1_PINMUX(32, RZN1_FUNC_GPIO)	/* GPIO0B[19] - STMA100_EN_N*/
+			>;
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+
+	};
+
+	pins_gpio1: pins_gpio1 {
+		pinmux = <
+			RZN1_PINMUX(108, RZN1_FUNC_GPIO)	/* GPIO1A[18] - for SPI1_SS_N[0] */
+			RZN1_PINMUX(109, RZN1_FUNC_GPIO)	/* GPIO1A[19] - for SPI0_SS_N[1] */
+			RZN1_PINMUX(110, RZN1_FUNC_GPIO)	/* GPIO1A[20] - for SPI0_SS_N[2] */
+			RZN1_PINMUX(114, RZN1_FUNC_GPIO)	/* GPIO1A[24] - for SPI0_SS_N[0] */
+		>;
+	};
+
+	pins_gpio2: pins_gpio2 {
+		pinmux = <
+			RZN1_PINMUX(147, RZN1_FUNC_GPIO)	/* Eth4 IRQ (GPIO2A[25]) */
+			RZN1_PINMUX(148, RZN1_FUNC_GPIO)	/* Touch IRQ (GPIO2A[26]) */
+			RZN1_PINMUX(149, RZN1_FUNC_GPIO)	/* Eth5 IRQ (GPIO2A[27]) */
+		>;
+	};
+
+	pins_mdio1: pins_mdio1 {
+		pinmux = <
+			RZN1_PINMUX(152, RZN1_FUNC_ETH_MDIO)   /* MDIO1_MDC */
+			RZN1_PINMUX(153, RZN1_FUNC_ETH_MDIO)   /* MDIO1_MDIO */
+			RZN1_PINMUX(171, RZN1_FUNC_MDIO1_SWITCH)    /* MDIO1_MUX_SWITCH */
+		>;
+	};
+
+	pins_nand: pins_nand {
+		pinmux = <
+			RZN1_PINMUX(80, RZN1_FUNC_CLK_ETH_NAND) /* NAND_ALE */
+			RZN1_PINMUX(81, RZN1_FUNC_CLK_ETH_NAND) /* NAND_CLE */
+			RZN1_PINMUX(82, RZN1_FUNC_CLK_ETH_NAND) /* NAND_WE_N */
+			RZN1_PINMUX(83, RZN1_FUNC_CLK_ETH_NAND) /* NAND_RE_N */
+			RZN1_PINMUX(84, RZN1_FUNC_CLK_ETH_NAND) /* NAND_IO[0] */
+			RZN1_PINMUX(85, RZN1_FUNC_CLK_ETH_NAND) /* NAND_IO[1] */
+			RZN1_PINMUX(86, RZN1_FUNC_CLK_ETH_NAND) /* NAND_IO[2] */
+			RZN1_PINMUX(87, RZN1_FUNC_CLK_ETH_NAND) /* NAND_IO[3] */
+			RZN1_PINMUX(88, RZN1_FUNC_CLK_ETH_NAND) /* NAND_IO[4] */
+			RZN1_PINMUX(89, RZN1_FUNC_CLK_ETH_NAND) /* NAND_IO[5] */
+			RZN1_PINMUX(90, RZN1_FUNC_CLK_ETH_NAND) /* NAND_IO[6] */
+			RZN1_PINMUX(91, RZN1_FUNC_CLK_ETH_NAND) /* NAND_IO[7] */
+			RZN1_PINMUX(92, RZN1_FUNC_CLK_ETH_NAND) /* NAND_CE_N[0] */
+			RZN1_PINMUX(93, RZN1_FUNC_CLK_ETH_NAND) /* NAND_WP_N[0] */
+			RZN1_PINMUX(94, RZN1_FUNC_CLK_ETH_NAND) /* NAND_RYBY_N[0] */
+		>;
+	};
+
+	pins_qspi0: pins_qspi0 {
+		pinmux = <
+			RZN1_PINMUX(74, RZN1_FUNC_QSPI)        /* QSPI0_CS_N[0] */
+			RZN1_PINMUX(75, RZN1_FUNC_QSPI)        /* QSPI0_IO[3] */
+			RZN1_PINMUX(76, RZN1_FUNC_QSPI)        /* QSPI0_IO[2] */
+			RZN1_PINMUX(77, RZN1_FUNC_QSPI)        /* QSPI0_IO[1] */
+			RZN1_PINMUX(78, RZN1_FUNC_QSPI)        /* QSPI0_IO[0] */
+			RZN1_PINMUX(79, RZN1_FUNC_QSPI)        /* QSPI0_CLK */
+		>;
+		bias-disable;
+	};
+
+	pins_sdio1: pins_sdio1 {
+		pinmux = <
+			RZN1_PINMUX(95, RZN1_FUNC_SDIO)		/* SDIO0_CMD */
+			RZN1_PINMUX(97, RZN1_FUNC_SDIO)		/* SDIO0_IO[0] */
+			RZN1_PINMUX(98, RZN1_FUNC_SDIO)		/* SDIO0_IO[1] */
+			RZN1_PINMUX(99, RZN1_FUNC_SDIO)		/* SDIO0_IO[2] */
+			RZN1_PINMUX(100, RZN1_FUNC_SDIO)	/* SDIO0_IO[3] */
+		>;
+
+		pins_sdio1_clk: pins_sdio1_clk {
+			pinmux = <
+				RZN1_PINMUX(96, RZN1_FUNC_SDIO)	/* SDIO0_CLK */
+			>;
+			drive-strength = <12>;
+		};
+
+		pins_sdio1_cd_wp: pins_sdio1_cd_wp {
+			pinmux = <
+				RZN1_PINMUX(101, RZN1_FUNC_SDIO_E)	/* SDIO0_CD_N */
+				RZN1_PINMUX(102, RZN1_FUNC_SDIO_E)	/* SDIO0_WP */
+			>;
+			bias-pull-down;
+		};
+	};
+
 	pins_uart0: pins_uart0 {
 		pinmux = <
 			RZN1_PINMUX(103, RZN1_FUNC_UART0_I)     /* UART0_TXD */
@@ -83,6 +337,142 @@
 			>;
 		bias-disable;
 	};
+
+	pins_usb: pins_usb {
+		pins_usb_pdown {
+			pinmux = <
+				RZN1_PINMUX(119, RZN1_FUNC_USB)	/* USB_PPON[1] */
+				RZN1_PINMUX(121, RZN1_FUNC_USB)	/* USB_PPON[2] */
+			>;
+			drive-strength = <4>;
+			bias-pull-down;
+		};
+
+		pins_usb_pup {
+			pinmux = <
+				RZN1_PINMUX(120, RZN1_FUNC_USB)	/* USB_OC[1] */
+				RZN1_PINMUX(122, RZN1_FUNC_USB)	/* USB_OC[2] */
+			>;
+			drive-strength = <4>;
+			bias-pull-up;
+		};
+	};
+};
+
+&nand_controller {
+	pinctrl-0 = <&pins_nand>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	oob-reserved = <8>;
+	nand@0 {
+		label = "nand";
+		reg = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			/* 512MB */
+			label = "nand:ubi0";
+			reg = <0x0000000 0>;
+		};
+	};
+};
+
+&qspi0 {
+	pinctrl-0 = <&pins_qspi0>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <62500000>;
+		spi-cpha;
+		spi-cpol;
+		spi-rx-bus-width = <4>;
+
+		partition@0 {
+			/* 256KB */
+			label = "qspi0:spl";
+			reg = <0x00000000 0x00040000>;
+		};
+		partition@1 {
+			/* 256KB */
+			label = "qspi0:unused_mtd3";
+			reg = <0x00040000 0x00040000>;
+		};
+		partition@2 {
+			/* 256KB */
+			label = "qspi0:configcms";
+			reg = <0x00080000 0x00040000>;
+		};
+		partition@3 {
+			/* 256KB */
+			label = "qspi0:unused_mtd5";
+			reg = <0x000C0000 0x00040000>;
+		};
+		partition@4{
+			/* 256KB */
+			label = "qspi0:env";
+			reg = <0x00100000 0x00040000>;
+		};
+		partition@5 {
+			/* 1MB */
+			label = "qspi0:unused_mtd7";
+			reg = <0x00140000 0x00100000>;
+		};
+		partition@6 {
+			/* 1MB */
+			label = "qspi0:uboot0fit";
+			reg = <0x00240000 0x00100000>;
+		};
+		partition@7 {
+			/* 1MB */
+			label = "qspi0:uboot1fit";
+			reg = <0x00340000 0x00100000>;
+		};
+		partition@8 {
+			/* 1MB */
+			label = "qspi0:tosfit0";
+			reg = <0x00440000 0x00100000>;
+		};
+		partition@9 {
+			/* 1MB */
+			label = "qspi0:tosfit1";
+			reg = <0x00540000 0x00100000>;
+		};
+		partition@10 {
+			/* 1MB */
+			label = "qspi0:cm3fit0";
+			reg = <0x00640000 0x00100000>;
+		};
+		partition@11 {
+			/* 1MB */
+			label = "qspi0:cm3fit1";
+			reg = <0x00740000 0x00100000>;
+		};
+		partition@12 {
+			/* Remaining */
+			label = "qspi0:data";
+			reg = <0x00840000 0>;
+		};
+	};
+};
+
+&sdio1 {
+	pinctrl-0 = <&pins_sdio1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&udc {
+	pinctrl-0 = <&pins_usb>;
+	pinctrl-names = "default";
+	status = "okay";
 };
 
 &uart0 {

-- 
2.55.0

