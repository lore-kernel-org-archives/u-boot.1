Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C01ECA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2EA8836D3;
	Fri, 29 Aug 2025 16:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794B183487; Fri, 29 Aug 2025 08:10:15 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0376B834AD
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PW7KjKJMygWp7XiEgHTWmwOiVbeT3Rdy/K7/6v85zgvJ/RCuZ6OLTiPEMLh+v+WoekyfYADgGyNERSbuGM1Isul7XaTLtUTBg4CAhfz437dAQLH2l10DnXPrdXKtFwgc7kEgLcTYp2hz5UfCyAoStOyxzSd50zMcPnmZGLkJMo1say8cIECYMYY0DDsYuCuql0peWy0udq192f2kUdAvsf12eGmS9Yk71hU3sVVD/SBeAV5nsbod8xlQfuCLtGM+dQI/B0Qgay/pYK9YMyfTya9Qo5GHw5zPUWFWdIKTCG6JtG82maaHpLfnTE565weakkXuR7S3kZfQA9k/z9+/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxb/r26Hddvjc2WtqrIA9rqLzmVWn6o/a2dkbVhdcZo=;
 b=fOc75okLo/wv9uUm/gA1tZ/a71CmJFYXLsUHU1GhHwrf2Tn83+0oxexRDNaP/XWUID5MOy+fmHyD2OpmlJs+JEQvHeGXpUC8yEZbruxpmpKy2n8QsLAGacIU6f+H6i6wdt+psply5g8FY65mxGFbGEqqi6p5zjR8P4fSc7zPaMqQLIZ18JXTE8qJi9JEiuXoaFqKwzAnJtkv2PJ93pqjocHTLCe6wr8eweBYme4UpLH06QHgtyUbtjLHJIL1o7yjUWxFfhXt5vn8+k4l6UL4/pfcVK4huLz1zGg4VBrGj0rfYLWm3zInbPJw73ofcOEWP8KJaEx2iRRrypUUOvSmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1258.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:07 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:07 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 01/10] riscv: dts: starfive: jh7110-common: Move out some nodes
 to the board dts
Date: Fri, 29 Aug 2025 14:09:22 +0800
Message-ID: <20250829060931.79940-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250829060931.79940-1-hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1258:EE_
X-MS-Office365-Filtering-Correlation-Id: 73911dde-d2b1-44a8-ec30-08dde6c2b409
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: kLWrxyIlRsAttVQZ1Pcoa2vYp8VqwINnmTrJutI337xECF0x9iFwM80r7hdcshfnD0FC14uHNCU8SKOvjDsRheQ9Pteu6efsCLNm1tbozmoTdNpHCR8w4eZH9+q14u5bzf1Xl0xcgofGpgJf2dO7qxXWsIB4ZyW8HMnm337ipRgPCF4MsMxC/dFVaD7Dr2yzbVfzMO03A4AVYAtbN3RSfcL34AegjCqznNAL/7j/r7NrjWT6AZ5Tze76zkzjBbI0LWFwio0dOsVGVfsizSBU/BzHRSwZ534pZyw3rXHj+NCoUHWMnwBp+QJ9RYcnlFwL+6wbmPMToN2LmKsDOu8UQTwKYOzk/OdsO/zZXveQB1xUyjlfxMmPZVjRJKJhVI1Rk+Rjamijj0ItphtQAaeCUTq9rFySaDsUPb5/8qYoIfig97nmNSbpJymXye07RMSsDQTevnym3t2Af7k7ZTZqRkq1FJYndRDtNus4nRZecw4h1eiUyNdg08QlcwN99o7pzAuoqoli1WVAY4UgnFkoOfN5S70D/yJpD4sRUqQhPBsyU3PFXyVYfqIXXgy8/m7jgWjgwgcq4zVLZCVW2JrI+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nCiTRe/g+8PbnT3rzCEQQOKhKidTmF75+zJM0Na0palqID0Zf4XwAz7rEoxu?=
 =?us-ascii?Q?1O+Gljs/Dp0SIAIXa53v3GNxRW97oSrAX845Wi/9Q3LHdAqdOxcfi5H53kOD?=
 =?us-ascii?Q?3Rm+kZ+SddM1xedM/wfryrDybxLc4dSgTNsrk9JpqO4DAI8sPBRpHd+dHuMv?=
 =?us-ascii?Q?7B24z8VMxjedbzUBk5s+5/9T5Tjl1YgYNaU9ur9GNShyah9pGmBVZ7o8M+lO?=
 =?us-ascii?Q?NHIhZiU7dlRpIqdqpU6qTCsNnunU/M/aoVqpzN4NcRhEC4wThovPKH1bQ9x8?=
 =?us-ascii?Q?qn33ayzRSeiZw9o33rdsN+V4NvBuB/DDELzcos6k+qMk31FFZUpVFFy52/8R?=
 =?us-ascii?Q?Gq9pyLJOh5VyfU8A8Nw/CZ93QDAaxHdd3yNlWiGIbq+RGvi6jfEjJzEln9h+?=
 =?us-ascii?Q?344+K8eC1zQk9jP26wQyd9b3BR2/hEWhXeRh7Mwuf3hObb/OUc1baqFUugfM?=
 =?us-ascii?Q?XiZintKhgyYVTeCL+OUwJi4bufo3fRWYAk2npm1mm3Mzu6lc+F0rzE1WQ6kQ?=
 =?us-ascii?Q?zKHTlFqLS2pc+fRSwThdEN0YJRa8zIXjJOKNCmobllMLtdwIxFJzZG8AvMi1?=
 =?us-ascii?Q?04HuidGzIOA9d7WVyhXVx91ft94xtwkqgRN//udX6m1f6DE45V6ALh8qa0jE?=
 =?us-ascii?Q?tV6hKkvwJXQOkmgJUhLGKI6da/7xW7hET+qma/N7Fh8PbHJhaP/12+dJyKAy?=
 =?us-ascii?Q?qbz2fbiQPahdkSohzC4HGrhYXTv4VFGTODfSGcavKvwxFW3Bpngtt/X0oHEY?=
 =?us-ascii?Q?lNBi9pdNIkBHusVy9PsGzE3xdmvfCNSU9DWBx08EgsF/L5UWkg6IDHRiGeiO?=
 =?us-ascii?Q?tgq13IVJI97Mp2q9jfqQfPB1kvLsJs3ltNW5rcFhjmL/opsSM6qp3DuMgrT+?=
 =?us-ascii?Q?ISnJqxDCEVsTYE2HwLTlG0pbHcWm2y3O6+IGBMweABVdcAkUuBp21Q3exrOz?=
 =?us-ascii?Q?qOihUBk0GtJ2h0EttrOzLeDooB0cAg3KlRjlyTOwqkFVj0JE4Cxgz3TM/grf?=
 =?us-ascii?Q?M/guiqzXPwNnQtqCp4k1x6zjGrH0Prn+WUMquPWAHvC5KyTCDQ6gaCszEUOF?=
 =?us-ascii?Q?8+viSBTirYssFsqBYKUGuDLMaFr1yP++J+1QfIvmP7ICI0+ppjpc6kmc3z/5?=
 =?us-ascii?Q?yv5/h5Yxzs84atgwt2QdM/RAFYGzHeAKilWYymtaJ5h1ySqmzW6YUedJQy2Z?=
 =?us-ascii?Q?i1eOsY7F4WrECy9ixCFNutuYkxYXFGLq//Qcm/PpNwfIveYt0a5VDaQae6wK?=
 =?us-ascii?Q?qQDiCgUmJ1X/JSTyccabYMFueMRFELgwr2j21HkP2lQXOjHieLDSk0CQWihH?=
 =?us-ascii?Q?sUppwco6l2UrJqnJImoUGB0Z6Bxxtx2+AMr24/toV6/6KJb/ygweKgVt4P/N?=
 =?us-ascii?Q?ULoaVuES96CHzBCKxu8gmyUPVmu52t9cKMifmm6oarCTx/aD+NpqyChi6vVl?=
 =?us-ascii?Q?AfqwFRqMYOfNcbDlDyGB45YWOvUrQ78OqthQDs2q1L4D+SsfL+QwYq3MTLz5?=
 =?us-ascii?Q?qFwoAxYlgwcBdsRmprX1mWeG67qzP/uWH3G7Vd/1rTaU4ONwRcwVLhR+wmUy?=
 =?us-ascii?Q?u57cP3XrSSKtgv+RfcKtZXD6lmV+KYAazhGhd9HBwna5StlM78CZmToTmFFI?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73911dde-d2b1-44a8-ec30-08dde6c2b409
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:07.6317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjOEDqyH9CuXG6KCjPcvwL2jCeooaFSpUi8QAREUFvRK/qtp9iPB/Mczf/yTunq2zyQ451VmfF3JkI/DDXLwc9OEfv2D7kupyWGB1CtCxWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1258
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

Some node in this file are not used by the upcoming VisionFive 2 Lite
board. Move them to the board dts to prepare for adding the new
VisionFive 2 Lite device tree.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../src/riscv/starfive/jh7110-common.dtsi     | 22 ---------
 .../jh7110-deepcomputing-fml13v01.dts         | 49 +++++++++++++++++++
 .../src/riscv/starfive/jh7110-milkv-mars.dts  | 49 +++++++++++++++++++
 .../riscv/starfive/jh7110-pine64-star64.dts   | 49 +++++++++++++++++++
 .../jh7110-starfive-visionfive-2.dtsi         | 46 +++++++++++++++++
 dts/upstream/src/riscv/starfive/jh7110.dtsi   | 16 ------
 6 files changed, 193 insertions(+), 38 deletions(-)

diff --git a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
index 4baeb981d4d..9d3d03ad2ed 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
+++ b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
@@ -272,15 +272,9 @@
 	assigned-clock-rates = <50000000>;
 	bus-width = <8>;
 	bootph-pre-ram;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	cap-mmc-hw-reset;
 	post-power-on-delay-ms = <200>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&emmc_vdd>;
 	status = "okay";
 };
 
@@ -290,12 +284,7 @@
 	assigned-clock-rates = <50000000>;
 	bus-width = <4>;
 	bootph-pre-ram;
-	no-sdio;
-	no-mmc;
-	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
-	disable-wp;
 	cap-sd-highspeed;
-	post-power-on-delay-ms = <200>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	status = "okay";
@@ -439,17 +428,6 @@
 	};
 
 	mmc0_pins: mmc0-0 {
-		 rst-pins {
-			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
 		mmc-pins {
 			pinmux = <PINMUX(PAD_SD0_CLK, 0)>,
 				 <PINMUX(PAD_SD0_CMD, 0)>,
diff --git a/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts b/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
index f2857d021d6..5a2a41a7e8c 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
+++ b/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
@@ -11,6 +11,55 @@
 	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
 };
 
+&cpu_opp {
+	opp-375000000 {
+		opp-hz = /bits/ 64 <375000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-750000000 {
+		opp-hz = /bits/ 64 <750000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-1500000000 {
+		opp-hz = /bits/ 64 <1500000000>;
+		opp-microvolt = <1040000>;
+	};
+};
+
+&mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+};
+
+&mmc0_pins {
+	rst-pins {
+		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
+				      GPOEN_ENABLE,
+				      GPI_NONE)>;
+		bias-pull-up;
+		drive-strength = <12>;
+		input-disable;
+		input-schmitt-disable;
+		slew-rate = <0>;
+	};
+};
+
+&mmc1 {
+	no-sdio;
+	no-mmc;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	post-power-on-delay-ms = <200>;
+};
+
 &pcie1 {
 	perst-gpios = <&sysgpio 21 GPIO_ACTIVE_LOW>;
 	phys = <&pciephy1>;
diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts b/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
index 3bd62ab7852..0c90facc4ee 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
+++ b/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
@@ -11,6 +11,25 @@
 	compatible = "milkv,mars", "starfive,jh7110";
 };
 
+&cpu_opp {
+	opp-375000000 {
+		opp-hz = /bits/ 64 <375000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-750000000 {
+		opp-hz = /bits/ 64 <750000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-1500000000 {
+		opp-hz = /bits/ 64 <1500000000>;
+		opp-microvolt = <1040000>;
+	};
+};
+
 &gmac0 {
 	starfive,tx-use-rgmii-clk;
 	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
@@ -22,6 +41,36 @@
 	status = "okay";
 };
 
+&mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+};
+
+&mmc0_pins {
+	rst-pins {
+		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
+				      GPOEN_ENABLE,
+				      GPI_NONE)>;
+		bias-pull-up;
+		drive-strength = <12>;
+		input-disable;
+		input-schmitt-disable;
+		slew-rate = <0>;
+	};
+};
+
+&mmc1 {
+	no-sdio;
+	no-mmc;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	post-power-on-delay-ms = <200>;
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts b/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
index 31e825be206..c9677aef9ff 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
+++ b/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
@@ -14,6 +14,25 @@
 	};
 };
 
+&cpu_opp {
+	opp-375000000 {
+		opp-hz = /bits/ 64 <375000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-750000000 {
+		opp-hz = /bits/ 64 <750000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-1500000000 {
+		opp-hz = /bits/ 64 <1500000000>;
+		opp-microvolt = <1040000>;
+	};
+};
+
 &gmac0 {
 	starfive,tx-use-rgmii-clk;
 	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
@@ -44,6 +63,36 @@
 	status = "okay";
 };
 
+&mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+};
+
+&mmc0_pins {
+	rst-pins {
+		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
+				      GPOEN_ENABLE,
+				      GPI_NONE)>;
+		bias-pull-up;
+		drive-strength = <12>;
+		input-disable;
+		input-schmitt-disable;
+		slew-rate = <0>;
+	};
+};
+
+&mmc1 {
+	no-sdio;
+	no-mmc;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	post-power-on-delay-ms = <200>;
+};
+
 &pcie1 {
 	status = "okay";
 };
diff --git a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
index 5f14afb2c24..d1e4206f125 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -13,6 +13,25 @@
 	};
 };
 
+&cpu_opp {
+	opp-375000000 {
+		opp-hz = /bits/ 64 <375000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-750000000 {
+		opp-hz = /bits/ 64 <750000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-1500000000 {
+		opp-hz = /bits/ 64 <1500000000>;
+		opp-microvolt = <1040000>;
+	};
+};
+
 &gmac0 {
 	status = "okay";
 };
@@ -38,9 +57,36 @@
 };
 
 &mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
 	non-removable;
 };
 
+&mmc0_pins {
+	rst-pins {
+		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
+				      GPOEN_ENABLE,
+				      GPI_NONE)>;
+		bias-pull-up;
+		drive-strength = <12>;
+		input-disable;
+		input-schmitt-disable;
+		slew-rate = <0>;
+	};
+};
+
+&mmc1 {
+	no-sdio;
+	no-mmc;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	post-power-on-delay-ms = <200>;
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/dts/upstream/src/riscv/starfive/jh7110.dtsi b/dts/upstream/src/riscv/starfive/jh7110.dtsi
index 0ba74ef0467..d2463399b95 100644
--- a/dts/upstream/src/riscv/starfive/jh7110.dtsi
+++ b/dts/upstream/src/riscv/starfive/jh7110.dtsi
@@ -200,22 +200,6 @@
 	cpu_opp: opp-table-0 {
 			compatible = "operating-points-v2";
 			opp-shared;
-			opp-375000000 {
-					opp-hz = /bits/ 64 <375000000>;
-					opp-microvolt = <800000>;
-			};
-			opp-500000000 {
-					opp-hz = /bits/ 64 <500000000>;
-					opp-microvolt = <800000>;
-			};
-			opp-750000000 {
-					opp-hz = /bits/ 64 <750000000>;
-					opp-microvolt = <800000>;
-			};
-			opp-1500000000 {
-					opp-hz = /bits/ 64 <1500000000>;
-					opp-microvolt = <1040000>;
-			};
 	};
 
 	thermal-zones {
-- 
2.43.2

