Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C38CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B488836EE;
	Fri, 24 Oct 2025 16:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61808837B6; Fri, 24 Oct 2025 10:59:48 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D509983631
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeWHNx3gODKyzwJDR6jTzhxSSD4Imo8iDblqYoEH/NeRT35jKELDtC3Mxic2xS2cHYlbhFTGOPTbOuW6wvVeGpZPMVKwn1ZGSCKIcorPhgvgBxNrv88ewJzR/x1Bp1GpFkF9sNX/bCVgoFuZvYuTCd60OBtzz7dql9BZr5qdcoMULj9Qt3abJGNWmTnLMSK55UCq1XzGnUNoexA9faVikeN8w8L+CkJoBUl0kBOt6uHLD8X3EofGzssIEt+Nm/k8EjJ6VII5y01WcVWl37LfJckLIfVrCAcOtHuIKI7ozT40yA0Rj1A0oJ9T0/FnTWPRuo/aH8HnPCWgUJ2pPlMZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9F1T80kLoMR7dcfJ3hL8yO7Kl+7yRQQmGqSo9XMHCo=;
 b=RC37CY4CR2x86V1sSc1tc3Fom/5IYvbbl84Y3FsOxhkPfE/7xCsiqvxprj+AxwourS55djOsUaLawmEPHBfejz9BNAqVb3D+b6avtu1ReR3+L3z88E1NWiCuvRNS6bnqCPjlXRGKjhQShyo5mhkZ4zZrvjbffLxMZHlyaR5JOERX+R9kV4/BUZQlSI+Zv3uKI1lLFObi1SsWREVBOSaEwLw7AO4ugP7vhcNrKRdHC6w7tNIEyWywLOp2y3skEzqJDQC94hc7jJQG5EXvBH6A/LbmGzObwx5L3lyp/0YTyJtIX+m8r0bKeHQy6nrSjReLSzTPQQSD6lG4Ka/+JwJocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Fri, 24 Oct
 2025 08:59:40 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Fri, 24 Oct 2025
 08:59:40 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/9] riscv: dts: starfive: jh7110-common: Move out some
 nodes to the board dts
Date: Fri, 24 Oct 2025 16:59:24 +0800
Message-ID: <20251024085932.83596-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251024085932.83596-1-hal.feng@starfivetech.com>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dff3392-ffff-4fac-3550-08de12dbaa96
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: cGte2/WFv99NLa90kkpYl2Dh9KX7LkYFeUixooSwcmofXJI/gQ2s77r5wLs/yTHvLvZrELx4eEwIU206MM8v5FKUM6U9q2nefg6T9tfux1HmPBz/omBguhcOKIzeFxEF0kqoy8Gdgb3QcXCNHzUP2In3Q3+vkBj4T0yeEkdqN0cx/dRaEIoU/HU9ZQ1PIj8s66NWLgtsFy+8z6sOwwsFV57vjmBfnLXMWbUvvZt8sWhnD96JiCxFX5Za+mfrBDi22avTNojLxqUdVQ/Djy9SDpDeyQsx5p2hbSiKszRAmNL09ygEVqcvvHYbAe58U/B9esSc5ujR7uuPpxVf22ACLf5fLskO/lGnh2tmQfs4lmHqU3jidKvHNi6dyTr8UdhK8volgy5DJFODzEyyAk4B7QBErIBqRRddFUC6U6g6EtX1zf/h5US8SGfnUFaPzTK4fqBrzgvu8luVXzXd2gTxKp0DPzKhjT4rNf+BciB3/+gWLBJDa2U5xOFuDcm7zbSYwOsS+4JhkkteQzYbFul/1FfcKqUnPHyZ8a4b0/Rk+Rwuazd/QzZiD2cLOQYfjq/U7uAwaFBjWOWdGjZRV9j2OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJ2my0nG7R/XHyR8wiL3nXQq7jOvl+Aul/52r8SG5RbParfVt6IoRJvSR4EW?=
 =?us-ascii?Q?TKINUocW4eYqrWjqL9Hl+rqOnrzcVEwULyOrS/bTZ3cDFldHM56gAUSlEhxY?=
 =?us-ascii?Q?dsyGhvoFvPLENGSP2QJpkC8MeUqhmjDW5MsSKvvGqV726PEDKJxV4M5ihAr/?=
 =?us-ascii?Q?jX0wrealv1CshRx9GUN4A6QaQYO1/cxe47pmPxIzDEq3RonGoNrrUaZCGSF8?=
 =?us-ascii?Q?7EUzYtgXgStrFfOTr/L8p1ybmJJbT2gZebe7cjNz1zoKsLpAHGdbcp0bVdzY?=
 =?us-ascii?Q?qLlmZuqh/qSPGjFHM5hHaAsLZMJLRDz3rEEP/304byYaFSjs2NSFWboTDuLX?=
 =?us-ascii?Q?aYqptaQGgca2eYgGm6eWggotgSlqLRoCO+9wrUB3RTjtzpIq9PMmu+uEg/dX?=
 =?us-ascii?Q?f323PoOhrizpc+dR0bMW0QmnEhypTZ4tGxszRYgpCYmUR2iZGOM2XnCod578?=
 =?us-ascii?Q?Ugokt6CQGbdI17Kpzsk0fYdi4RXlxcgyKyx9nogDc1naRBzXAqip2zW0ZDxL?=
 =?us-ascii?Q?LdykO1rO0Az41sfSoiZ/SwUHoxprmDRNBda6EzyzHj2SJ1PLhRFrVwfhSF89?=
 =?us-ascii?Q?ZVE0SC8yKh9KItGz+CUua6LvXjgG6aCeM3iyxlPy8qMYaa9ryM1eIAAr3LUm?=
 =?us-ascii?Q?DLXIhhzuCyvHG57dcKh+QZqtGhJHMhG3qZPJDxebJwvtnht5sVzPVLvDj/1u?=
 =?us-ascii?Q?vxnYm04BlVOVd1ssV0pXwk6wBjKpGNjRESKj4GvREOGV/AIsZ0v60Z1XgR03?=
 =?us-ascii?Q?QLeP7mQfp+iZjx+/bQ3IgFTPkU6RPt+ZvWDjcifSDEk+WyooYZMEWTW4t4zd?=
 =?us-ascii?Q?6lZRPMT/pGZWU7/plYm0bTtUzOYOrHiB7F/FVjTUie10eZhb6eC5w7KTqfS0?=
 =?us-ascii?Q?eWavukFxeSHFasrYkmjbxLarVJmuWzsWk2b4egw67nbU3mOE9LxvDED2ZjT/?=
 =?us-ascii?Q?8lO5aDIkYD3mhnf4c1NqKPw1TdjdoI7wgaeGqTaa7Vm3KOuuQyYQHs/eQv6g?=
 =?us-ascii?Q?05OsplpejfK2XfyLfCOpEbSRbQ2AFVh5zSrIRn8H5n+CX8JI6d4fAUQ44YYQ?=
 =?us-ascii?Q?7SqLgi2ePV6fO/BPzzTSlYEMwwhnCAqjWPYzOF8N0wx9QG2uZOPmB/7H7ThG?=
 =?us-ascii?Q?RSI2H3rp7qyDpVJeFUfH/PmF7AvZ+zp2V80TaxFCXBEBHLPzvw59YpCOC5yN?=
 =?us-ascii?Q?V+Q4EhXtIsBXAe8149OjjT02myPoQw0I2QBLK3DLh2D7fC2rbZlAsxSTFCXf?=
 =?us-ascii?Q?u7A2FXDI/GvJuzlPeQaU6/JpxL2b9/DzuDMvMfs1e+AgbX9elvvYUlo4dBcR?=
 =?us-ascii?Q?0886EjOVsRaxt/9Nlrng1ZwwxLQnCfP1XvFrdG+R7S8UWm+pGty+1bfd6Ylq?=
 =?us-ascii?Q?FkHWrnGXkXVYohS+1z6AEpbXCZ5kwVBcy3Ux9PwbdXNeGZcbE0pIuFrtDjBA?=
 =?us-ascii?Q?n/EvmANWc1qZl9tBveKu5EaB/4OrB4aXZw7hFE2z+HScVDBOmHwhIQMKwB58?=
 =?us-ascii?Q?+rLXszl/EiYgQvQ43Pb8NWD6Qux+LqfMa0hTN/LA6SLPHeAVfblaxzTPmRKd?=
 =?us-ascii?Q?iJknnJ9psWSrPtgfb0yO3dIO5sO7U1PFJwhk47HyOtoB1AD4xjPBnUU8J+tF?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dff3392-ffff-4fac-3550-08de12dbaa96
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:40.3492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18sIvtSfMB1imaXL2CxPJ+cpkksJKmb2MBq+L1aJkw2IO71p/RqT16X/vfh3F08d9tc+cqYTgX8Tobr6o9RcxfdEgwXxHfSqy46abd96VJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

/****************************************************************/
This patch picked from [1] is just for test and can be ignored.
dts/upstream should be synced regularly with devicetree-rebasing.

[1] https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/
/****************************************************************/

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
index 2eaf01775ef..8332622420c 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
+++ b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
@@ -281,15 +281,9 @@
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
 
@@ -299,12 +293,7 @@
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
@@ -448,17 +437,6 @@
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
index fdaf6b4557d..96f6b2f072d 100644
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
 	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
 	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
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

