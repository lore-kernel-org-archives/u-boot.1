Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94370C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E76E607CA;
	Mon, 17 Aug 2026 15:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9YfopNQgDcr7; Mon, 17 Aug 2026 15:38:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CDB1607A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981112;
	bh=OVPEk5hOjEI6mvVYFTaTNmiA+SAL/lJhQjaTX85eWyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hbkAl/2GdDhuWAuQm9KeLz5nTThEjyE6qw3y2IdAo7t6mJDRfB81Q9lb/BjZveS4g
	 xP+HNYZu8Eyes3o410crqOFNkbv5uccHqJfUF7s0w8VP++qYUBCDNXsnSMv49CvyuY
	 A+1n/w2xuJFldHkPqvlWCp2JB5SJg2yrnSAkuN/mxEjD1gRAP2pw5BnyqtfdVjeh93
	 GuV0KE2uWXsSPtcbH26Re+aqnsOM+ZdaYutWs3Eu0o4mza033gYYPUxzhwpFKWElhV
	 VDs9dK8KgOWTSWK7ESnqxrYUpqZ6FQe8GwMqUkogyuLKuUQBRd5R4I3achyyvn0uNe
	 SpA+tEo+Mqhig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CDB1607A9;
	Mon, 17 Aug 2026 15:38:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0182A2B2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F31D280F6B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:38:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cXMSJsV9wmmh for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:38:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EFF0980ECB
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFF0980ECB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=EVk9WXLc
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFF0980ECB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4AA5BB0053E;
 Mon, 17 Aug 2026 17:38:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786981108;
 bh=wygv9/mCxMVf15w7jlEiA0/Nl4q/bV8CuiXrPg8wPG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EVk9WXLcTEK2ZUx0N/i27lxuCgPRAHoO+jh49FLhigEpu2L32qsoEsn5JIaezezCn
 5g1QIllQSnkF93BaO5fK+fHw0/ScPGOPNeSiqVbdKNurr2nzvhNNpR36RQ8Gpk1R9g
 KkI1j5YY/xZgYcHEgiZl+9kz4NOh565NkFXr6z0qjTxUelOPbwzU2lWm3XqmDVN1IZ
 f1cHcCOdHXRKSuCj0Rsc8d4LaUTZ2tUf86d0u6mDBfkb2Wgm8i3JbriTDmfoXTquk0
 uYTTVjivVY2NLecSf6gdGH+FbiktCiq1nMJTsbVFwtYEoa42irwRS4vjT211A0GPzT
 w6t+l1f8nBAyA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 22/23] board: nbxv3: enable GPIO controllers with line
 names and hogs
Date: Mon, 17 Aug 2026 17:31:40 +0200
Message-ID: <20260817153144.1951036-23-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Label every pin via gpio-line-names so `gpio status` prints meaningful names.

Most pads on this module are alt function consumed (UART, IIC, SDHC,
XSPI, RGMII); those keep an "altfn:" prefixed name, not connected pins
"nc", and the lines with a real GPIO identity.

defconfig: CONFIG_MPC8XXX_GPIO ("fsl,qoriq-gpio" driver),
CONFIG_CMD_GPIO, and CONFIG_GPIO_HOG so the hogs can be applied.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 161 +++++++++++++++++++++++++++++
 configs/nbxv3_tfa_defconfig        |   3 +
 2 files changed, 164 insertions(+)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index d2e4cb53bf1..40b76cec333 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -368,3 +368,164 @@
 &wdt0 {
 	timeout-sec = <120>;
 };
+
+/* GPIO misc helper namings based on lx2160arm documentation */
+&gpio0 {
+	gpio-line-names =
+		"nc", "nc",
+		"altfn:iic1-scl",
+		"altfn:iic1-sda",
+		"altfn:uart4-sin",
+		"altfn:uart4-sout",
+		"altfn:uart2-sin",
+		"altfn:uart2-sout-cfg-rcw-src0",
+		"altfn:uart3-sin",
+		"altfn:uart3-sout",
+		"altfn:uart1-sin",
+		"altfn:uart1-sout-cfg-rcw-src1",
+		"altfn:spi3-pcs3",
+		"altfn:spi3-pcs2",
+		"altfn:spi3-pcs1",
+		"altfn:spi3-pcs0",
+		"altfn:spi1-sck",
+		"altfn:spi1-sin",
+		"altfn:spi1-pcs2",
+		"altfn:spi1-pcs1",
+		"altfn:spi1-pcs0-u1700-zl30733",
+		"altfn:spi1-sout",
+		"altfn:iic6-sda",
+		"altfn:iic6-scl",
+		"altfn:spi3-sin",
+		"altfn:spi3-sout",
+		"altfn:iic4-sda",
+		"altfn:iic4-scl",
+		"altfn:iic3-sda",
+		"altfn:iic3-scl",
+		"altfn:iic2-sda",
+		"altfn:iic2-scl";
+};
+
+&gpio1 {
+	gpio-line-names =
+		"nc", "nc", "nc", "nc", "nc", "nc",
+		"cfg-rcw-src2",
+		"cfg-rcw-src3",
+		"reset-req-b",
+		"altfn:sdhc2-clk-u700-emmc",
+		"altfn:sdhc2-ds-u700-emmc",
+		"altfn:sdhc2-dat0-u700-emmc",
+		"altfn:sdhc2-dat1-u700-emmc",
+		"altfn:sdhc2-dat2-u700-emmc",
+		"altfn:sdhc2-dat3-u700-emmc",
+		"altfn:sdhc2-dat4-u700-emmc",
+		"altfn:sdhc2-dat5-u700-emmc",
+		"altfn:sdhc2-dat6-u700-emmc",
+		"altfn:sdhc2-dat7-u700-emmc",
+		"altfn:sdhc2-cmd-u700-emmc",
+		"cfg-svr1",
+		"altfn:xspi1-cs0-u1000-u1100-gd55lb02gf",
+		"altfn:xspi1-sck-cfg-eng-use0",
+		"thermtrip",
+		"altfn:xspi1-data0-mosi",
+		"altfn:xspi1-data1-miso",
+		"nc",
+		"nc",
+		"u1000-u1100-gd55lb02gf-reset#",
+		"pltrst#",
+		"nc",
+		"ethsw-reset#";
+
+	pltrst-hog {
+		gpio-hog;
+		gpios = <29 1>;
+		output-low;
+		line-name = "pltrst-deassert";
+	};
+
+	thermtrip-hog {
+		gpio-hog;
+		gpios = <23 0>;
+		output-low;
+		line-name = "thermtrip-deassert";
+	};
+
+	flash-reset-hog {
+		gpio-hog;
+		gpios = <28 1>;
+		output-low;
+		line-name = "flash-reset-deassert";
+	};
+
+	ethsw-reset-hog {
+		gpio-hog;
+		gpios = <31 0>;
+		output-high;
+		line-name = "ethsw-reset-deassert";
+	};
+};
+
+&gpio2 {
+	gpio-line-names =
+		"irq00#",
+		"i2c2-alert#",
+		"i2c4-alert#",
+		"i2c6-alert#",
+		"u800-tca9539-int#",
+		"spi3-alert#",
+		"wake0",
+		"wake1",
+		"carrier-hot#",
+		"u1300-rtl8211fd-int#",
+		"ethsw-int#",
+		"nc",
+		"nc",
+		"u1700-zl30733-clk-gpio0",
+		"u1700-zl30733-clk-gpio1",
+		"u1700-zl30733-clk-gpio2",
+		"u1700-zl30733-clk-gpio3",
+		"nc", "nc", "nc", "nc", "nc", "nc", "nc", "nc",
+		"nc", "nc", "nc", "nc", "nc", "nc", "nc";
+};
+
+&gpio3 {
+	gpio-line-names =
+		"altfn:ec1-txd3-rgmii1",
+		"altfn:ec1-txd2-rgmii1",
+		"altfn:ec1-txd1-rgmii1",
+		"altfn:ec1-txd0-rgmii1",
+		"altfn:ec1-tx-en-rgmii1",
+		"altfn:ec1-gtx-clk-rgmii1",
+		"altfn:ec1-rxd3-rgmii1",
+		"altfn:ec1-rxd2-rgmii1",
+		"altfn:ec1-rxd1-rgmii1",
+		"altfn:ec1-rxd0-rgmii1",
+		"altfn:ec1-rx-clk-rgmii1",
+		"altfn:ec1-rx-dv-rgmii1",
+		"nc",
+		"nc",
+		"ptp-refclk-in",
+		"nc",
+		"nc",
+		"nc",
+		"nc",
+		"nc",
+		"nc",
+		"nc",
+		"nc",
+		"u1700-zl30733-pps-out",
+		"nc",
+		"ethsw-mdio-en",
+		"usb01-oc#",
+		"nc",
+		"usb01-oc#",
+		"altfn:spi3-sck",
+		"nc",
+		"nc";
+
+	ethsw-mdio-en-hog {
+		gpio-hog;
+		gpios = <25 0>;
+		output-low;
+		line-name = "ethsw-mdio-en";
+	};
+};
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 040353c4a03..a4c8419f0c3 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -40,6 +40,7 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
 CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
@@ -58,7 +59,9 @@ CONFIG_DYNAMIC_DDR_CLK_FREQ=y
 CONFIG_DDR_ECC=y
 CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
 CONFIG_SYS_FSL_DDR_INTLV_256B=y
+CONFIG_GPIO_HOG=y
 CONFIG_DM_PCA953X=y
+CONFIG_MPC8XXX_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_I2C_MUX=y
-- 
2.43.0

