Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC04E7E631
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 13:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6881986D7B;
	Tue, 26 Sep 2023 15:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=initse.com header.i=@initse.com header.b="Y7l6qq44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B3086C06; Tue, 26 Sep 2023 08:55:07 +0200 (CEST)
Received: from mx0.init-ka.de (mx0.init-ka.de [85.115.11.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3355E86B95
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=initse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=akoch@initse.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=initse.com; i=@initse.com; q=dns/txt; s=mail;
 t=1695711305; x=1727247305;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lNIdQp26hozJ+g8KO7Yd6i5H+K6JbcPtZUTJZqpu/GI=;
 b=Y7l6qq44LOxRHCRLMGJYTGxxysnJMOVKUOk/+WbtqBkp7lJqinGpnev9
 lymg1HWHni6D8vKhRzUNtqcqP896lR+gj82dMlvLBr27qMs62Im7njjLs
 tDhmr/rElfwkzXlBQcIJSdF/9CiFU9wZP+F6DWiIfOBVAhvzDocMG7TOb Q=;
X-IPAS-Result: =?us-ascii?q?A2C9AgDwfxJl/xpkFaxagRKBRoUMG5YWkhyLYhSBag8BA?=
 =?us-ascii?q?QEBAQEBAQEIAUQEAQGFB4cHJzQJDgECBAEBAQEDAgMBAQEBAQEDAQEBBQEBA?=
 =?us-ascii?q?QEBAQYDAQGBHIUvRoI3KwGEFAsBRiiBFg4Fgn6CX7QGMxoCZbMngWgJAYE+g?=
 =?us-ascii?q?WmGIQGENIYUgUlEgRWBPIIthCsMhlAEiUCFPwcygiWDLyqKcyqBCAhdgWo9A?=
 =?us-ascii?q?g1UCwtdgRGCRAICETkTBENaFhsDBwNaKhArBwQvIgYJFi0lBlEEFxYkCRMSP?=
 =?us-ascii?q?gSDOAqBBj8RDhGCRSICPTYZS4JbCRUMNE52ECsEFBeBE24fFR42ERIZDQMId?=
 =?us-ascii?q?h0CESM8AwUDBDYKFQ0LIQUUQwNHBkwLAwIcBQMDBIE2BQ8eAhAuKQMDGU4CE?=
 =?us-ascii?q?BQDPgMDBgMLMgMwYQMJAwcFLB1AAwsYDUgRLDUUGwZBcweiGoFtcnsUlWqDE?=
 =?us-ascii?q?owFoliEFZoOhngaM4RNknQDkhoBLpd/o22EMAIEAgQFAhaBY4IVMxoIGxWDI?=
 =?us-ascii?q?lIXAqIidDsCBwsBAQMJiSKBEoEVAQE?=
IronPort-PHdr: A9a23:BHOn1hEwPFc+nSo7qp4qlZ1Gf65MhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k30hmQDNiQsqsdw8Pt8InYEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/94PSbglSmTawZbN/I
 BqroQnMq8UdnJdvJLs2xhbVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3U
 bJXAjImM3so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RTKv5
 LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cWGFPXNteVzZZD428c
 YUCEfcPM+hboYf6qFQAogexBQi3CePzyTJFnGP60Lcm3+g9FwzNwQwuH8gJsHTRtNj4KKMSX
 v66zabSyzXMcu1Z2S3g44bNdRAuvfGMVq93fMXLykkvEB/KjlWLpIzkOTOV1/gNs3OF4OZ6S
 e2vjGsnphh3rzOyycgilpPHiZgJylDY6yp52oA1KMW7RUB7ZdOqH5ldui6eOoZoX84vX25lt
 Do1x7ACpZK1cygHxZY7yhPcd/GKd4iF7BLtWeqPLzl1mXxodrKhihqs90Wr1+7yVtGs3VpXr
 CdJjMPAum4Q2xDJ98SLVudx8l2/1TuOzwzf9+NJLV4umabFNZIt2KA8mocJvUjeHCL7mkP7h
 7KMeEo+4Oin8eHnb63jpp+bKoB7lBnzMr8rmsyjGeQ4NRUOX3SD9eS8yrLj+Ur5Ta1Rjv0sj
 KnZto7VJd4Fqa6kGA9ZyIcj6xC+Dze6ydgYnmMIIEhBeB2diYjlI1DOIPbmAvejm1mgjTVmy
 +7cMrH/H5nBNGXPnKv9cbpn9UJRyRI/zdVF6JJVDrEBLujzWkj0tNHAFBA5MAu0zPrnCNhm1
 4MeX2OPArOCMKzMq1OH+uUvI+yUaI8ToznyM+Il6OL2jX8lhV8derGk0JUPZHCiAvtmO1mZY
 WbrgtoZDGcGpxExTOvtiF2eSjNTY3eyX7kg5jEgEo6pEJnMRoaigbCbwSi0AIVaZnpaBVCUD
 Xfoa4KEVu8XaC2JOMBuiT0EWqS6RoA8yx6usgD7x6B6IeXK4iEYr47s1MBp5+3PkhE/7TJ0A
 NqG02GRUW50gHkHRzot0aBwpExy0FaD0axij/NEEtxT4qABbgBvYYOZxet9F/j2WxndZZGFR
 VC2BNmrV2IfVNU0lvYKblZ0HdmvlFjg2CGqS+sclLuABLQ19KPAxHW3LMF4nSWVnJI9hkUrF
 5McfVatgbRyok2KX9ahrg==
IronPort-Data: A9a23:/cBFQKnMQUu7x2sgdVzd31ro5gzAJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbX2vUOvreNGajct9wYNixp05Su5SDx9UyTVdlrXhhHy4T+ZvOCP2ndUqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9CU6j+fRLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgf+s9JIGjhMsfnb+Ukx5K2aVA4w5zTSW9ga5DcyqFFIVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuAon/Bovv8+lrKWhViroz6ZGBiuVIPM0SWuSWukwRpukoN2FvwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSMIUekIIrL0RTvuSV4WrgLV/q2M82J1E1E7Q+pcVtJm5Ro
 KlwxDAlNnhvhsqt2qy9R/Nhm99lLc/qIMYcszdkxDex4fQOGM+ZBf+To4YAhHFq2KiiHt6HD
 yYdQTNsax/ASxxJO0sMBdQ1m+LAanzXKGQF9Q3J+fpfD277yyZQ2unyE9rpZJ/Sd8R2v1Sq+
 2Gb8DGsav0dHJnFodafyVqxw+XImj/TXIMJCKb++vNskBufywQ7ExcfX1qwifW0jF74V983A
 0IZ4TYjs6E33EOuR9j5GRa/pRa5UgU0AoUKVbdjrljVkuyOvW51G1Q5c9KIU/R+3OdeeNDg/
 gbhcw/BbdC3jICodA==
IronPort-HdrOrdr: A9a23:mczeiKMkzNqCQ8BcTvSjsMiBIKoaSvp037Eqv3oedfUzSL39qy
 nOpoV96faaslYssR0b9exoW5PwJE80l6QFgrX5VI3KNGOKhILBFvAF0WKI+Vzd8kPFmdK0XM
 xbGJSXhrXLfCNHZZGQ2njBLz9Z+qjkzEn+v5am80tQ
X-Talos-CUID: 9a23:ITV7GWMYI0WlBO5DXgdA0hAwHNsfKlbNz1npBRCbE0FmV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AQsGUqg5AWyKnbGvZpekVKbuBxoxvyYWkWV8ukak?=
 =?us-ascii?q?Y+JG2NA9RKQXAj2m4F9o=3D?=
Received: from unknown (HELO srvnereus.init-ka.lan) ([172.21.100.26])
 by gateway13.init-ka.lan with ESMTP; 26 Sep 2023 08:55:02 +0200
X-AuditID: ac15641a-59bff700000057fc-7a-651280362182
Received: from srvkamail01.init-ka.lan (Unknown_Domain [172.22.3.254])
 by srvnereus.init-ka.lan (INIT-Mailsystem) with SMTP id 76.4C.22524.63082156;
 Tue, 26 Sep 2023 08:54:46 +0200 (CEST)
Received: from pc1209.init-ka.lan (172.22.21.177) by srvkamail01.init-ka.lan
 (172.22.3.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Tue, 26 Sep
 2023 08:55:02 +0200
From: Alexander Koch <akoch@initse.com>
To: <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Alexander Koch <akoch@initse.com>
Subject: [PATCH] arm: dts: imx8mm_evk: Fix PMIC definition
Date: Tue, 26 Sep 2023 08:54:38 +0200
Message-ID: <20230926065438.418051-1-akoch@initse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.21.177]
X-ClientProxiedBy: srvkamail01.init-ka.lan (172.22.3.254) To
 srvkamail01.init-ka.lan (172.22.3.254)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWyRoz5n65Zg1CqwYVDehYPr/pbtJ/ysXi7
 t5Pdgdlj3qwTLB47Z91l9zh7ZwdjAHMUl01Kak5mWWqRvl0CV8bU/ja2gl7zijk3frI3MG7X
 6mLk5JAQMJG4t2k/cxcjF4eQwF5GiV2f1jBBOG8YJfb8ecsMUsUmoC6x4OROMFtEQEriZedG
 MJtZIFviSudhRhBbWMBKYu38vewgNouAqsSyy/fAbF4BM4lbZ7ewQWyTl9iz6DsTRFxQ4uTM
 JywQc+QlmrfOhpopIXHwxQswW0hAVuJezzeoXkWJxbvnMEHYqRJPnx5km8AoMAvJqFlIRs1C
 MmoBI/MqRs7iorK81KLU0uJNjKCAFE2R2sF4e5LlIUYBDkYlHt6ESYKpQqyJZcWVuYcYJTiY
 lUR4fz3jSxXiTUmsrEotyo8vKs1JLT7EKM3BoiTO+1rFLkBIID2xJDU7NbUgtQgmy8TBKdXA
 aKex+tynVN0/Qqu2fX2xQrdCUV9y93G2cu5CTmXeCMlLi4w5uCQ5kw+p/rJQ8VU2L3V9uamk
 /nR63DyJ5KkpgX+yLsd5MQaXLBU60jMpVmbBlID+2ftmGMrq9lbsKip+WfpI3DfqvOTMd38D
 RI9O2PPM59POou7D6icllY6e4VKwu3HiSkSxEktxRqKhFnNRcSIA+y3UdkQCAAA=
X-Mailman-Approved-At: Tue, 26 Sep 2023 15:07:17 +0200
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

Newer revisions of the i.MX8MM EVK are equipped with a different PMIC than
the initial ones (PCA9540 instead of BD71847), which has already been
reflected in 4c07a21e5.

These changes have been reverted implicitly as part of the device tree
re-sync with the Linux kernel done in 24a7a3c1c.

This lead to an inconsistent state: while the device tree describes the old
PMIC again the code in board/freescale/imx8mm_evk/spl.c tries to initialize
the new PMIC:

    ret = pmic_get("pca9450@25", &dev);
    if (ret == -ENODEV) {
            puts("No pmic\n");
            return 0;
    }

This leads to the expected error message from SPL:

    U-Boot SPL 2023.07.02 (Sep 04 2023 - 15:57:57 +0200)
 -> No pmic
    SEC0:  RNG instantiated
    WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
    Trying to boot from NOR
    NOTICE:  BL31: v2.2(release):rel_imx_5.4.70_2.3.6-0-g15e8ff164
    NOTICE:  BL31: Built : 13:51:09, Sep  4 2023

Fix by re-applying the device tree changes from 4c07a21e5.

Signed-off-by: Alexander Koch <akoch@initse.com>
---
 arch/arm/dts/imx8mm-evk-u-boot.dtsi |   4 +-
 arch/arm/dts/imx8mm-evk.dtsi        | 126 ++++++++++++++--------------
 2 files changed, 67 insertions(+), 63 deletions(-)

diff --git a/arch/arm/dts/imx8mm-evk-u-boot.dtsi b/arch/arm/dts/imx8mm-evk-u-boot.dtsi
index 13688ec0d0..1bc7e4a38b 100644
--- a/arch/arm/dts/imx8mm-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-evk-u-boot.dtsi
@@ -121,11 +121,11 @@
 	bootph-pre-ram;
 };
 
-&{/soc@0/bus@30800000/i2c@30a20000/pmic@4b} {
+&{/soc@0/bus@30800000/i2c@30a20000/pca9450@25} {
 	bootph-pre-ram;
 };
 
-&{/soc@0/bus@30800000/i2c@30a20000/pmic@4b/regulators} {
+&{/soc@0/bus@30800000/i2c@30a20000/pca9450@25/regulators} {
 	bootph-pre-ram;
 };
 
diff --git a/arch/arm/dts/imx8mm-evk.dtsi b/arch/arm/dts/imx8mm-evk.dtsi
index 7d6317d95b..f2c15bf0ff 100644
--- a/arch/arm/dts/imx8mm-evk.dtsi
+++ b/arch/arm/dts/imx8mm-evk.dtsi
@@ -183,114 +183,118 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pmic@4b {
-		compatible = "rohm,bd71847";
-		reg = <0x4b>;
-		pinctrl-names = "default";
+	pmic: pca9450@25 {
+		reg = <0x25>;
+		compatible = "nxp,pca9450a";
+		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
 		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		rohm,reset-snvs-powered;
-
-		#clock-cells = <0>;
-		clocks = <&osc_32k 0>;
-		clock-output-names = "clk-32k-out";
+		gpio_intr = <&gpio1 3 GPIO_ACTIVE_LOW>;
 
 		regulators {
-			buck1_reg: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9450,pmic-buck2-uses-i2c-dvs;
+			/* Run/Standby voltage */
+			pca9450,pmic-buck2-dvs-voltage = <950000>, <850000>;
+
+			buck1_reg: regulator@0 {
+				reg = <0>;
+				regulator-compatible = "buck1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
 				regulator-boot-on;
 				regulator-always-on;
-				regulator-ramp-delay = <1250>;
+				regulator-ramp-delay = <3125>;
 			};
 
-			buck2_reg: BUCK2 {
-				regulator-name = "buck2";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
+			buck2_reg: regulator@1 {
+				reg = <1>;
+				regulator-compatible = "buck2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
 				regulator-boot-on;
 				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
+				regulator-ramp-delay = <3125>;
 			};
 
-			buck3_reg: BUCK3 {
-				// BUCK5 in datasheet
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
+			buck3_reg: regulator@2 {
+				reg = <2>;
+				regulator-compatible = "buck3";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
-			buck4_reg: BUCK4 {
-				// BUCK6 in datasheet
-				regulator-name = "buck4";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
+			buck4_reg: regulator@3 {
+				reg = <3>;
+				regulator-compatible = "buck4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
-			buck5_reg: BUCK5 {
-				// BUCK7 in datasheet
-				regulator-name = "buck5";
-				regulator-min-microvolt = <1605000>;
-				regulator-max-microvolt = <1995000>;
+			buck5_reg: regulator@4 {
+				reg = <4>;
+				regulator-compatible = "buck5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
-			buck6_reg: BUCK6 {
-				// BUCK8 in datasheet
-				regulator-name = "buck6";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
+			buck6_reg: regulator@5 {
+				reg = <5>;
+				regulator-compatible = "buck6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
-			ldo1_reg: LDO1 {
-				regulator-name = "ldo1";
+			ldo1_reg: regulator@6 {
+				reg = <6>;
+				regulator-compatible = "ldo1";
 				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
-			ldo2_reg: LDO2 {
-				regulator-name = "ldo2";
+			ldo2_reg: regulator@7 {
+				reg = <7>;
+				regulator-compatible = "ldo2";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <900000>;
+				regulator-max-microvolt = <1150000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
-			ldo3_reg: LDO3 {
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
+			ldo3_reg: regulator@8 {
+				reg = <8>;
+				regulator-compatible = "ldo3";
+				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
-			ldo4_reg: LDO4 {
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
+			ldo4_reg: regulator@9 {
+				reg = <9>;
+				regulator-compatible = "ldo4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
-			ldo6_reg: LDO6 {
-				regulator-name = "ldo6";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
+			ldo5_reg: regulator@10 {
+				reg = <10>;
+				regulator-compatible = "ldo5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
 			};
 		};
 	};
-- 
2.42.0

