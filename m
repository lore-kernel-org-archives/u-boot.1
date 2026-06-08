Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6D3CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8186A83FEC;
	Mon,  8 Jun 2026 09:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hb4w80A1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF6D838BB; Mon,  8 Jun 2026 03:28:24 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A01583314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8XuH87C7U4R5pesnOxqS/jLCG4Vmw99jZ7Ndro94+ElxpaCEAvAPsPzkkSAE04J6x85nd6fd5oPQvtVrk4BkqNoqJdy69+Fri0+kPCtwWVmkEGHsMHOwFQBXass7Wg8SMVkCWt1lga2Ep2lT9IDbsy+3fxsZsQR9iytuXOWmCvIUFE0y9DAZvZ+2j/AYyHe6QskFXHZKdqSVX+1kyGcGLUW0keR+NtP/Y8hx6hoQ/wYaAj8FP2EBdjkPpLcPpjhx0uXFjNgsIYmexKfszYvMHwhDO9MYuzwXichYfZFDhAc4cRpHj32UBTqFBIGKOkUeKFVCHodOjf+EimhQ7db6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gZD2GN3wctLfo2NSx78kUpJVqCnwGmi2r9IWR66gGU=;
 b=oPAddPLD1s0GVxgzGXuKSAvf6uqsxYM5VpeJ7egRsYrYzRKorgKrhDWaOzVipT6vq8wmkOqovPHwVOngk50XWuMUnr65lmlWMdExfGCw5kjvziob+fTapENcKfkYBTqs8ernrGueh3/Q1ufqr/67F4qHYuw6yd4LrHfc5hcCNgZhKwRrKew7oRST4WLqb2HKVVH3mzVEHfG4U79LCZwE2Sa1G9R0eGBpPVQ0js0kP+ij/LmQhJPpfoCRuWm8g0ez0d1uHhiaNnRrFnxSbkg6pETnMgR8s8QVO39uEqCQ5fFl0WOG+lcbuFOaeFbgDQqd9PHVXTeCeEmSWMpCiu/NEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gZD2GN3wctLfo2NSx78kUpJVqCnwGmi2r9IWR66gGU=;
 b=hb4w80A1FRl3SSH1RWIadx1CPnubGuL+QlzP3f4VRsx7pZfcwCtENiMPyRgL0y958cYbAv2az9JZBI9bidGA0JzMFuNqdaDZ+z47Y3fp2yJ4+ufbvANMuLn/UytYAcE7OIA3SkWldruxD8KfSRK/GRrRmD+DAH3dIF1Nub6/N8hpVb9+yO41BsU/cCmaWLpxn5ISZYCL8Ya8+5EhS3YDiANgSn+gjX4j/70y3DZw7Kfg7L8qcS0+BVknepEM3AZmil3TLa1g+op75A2k2u1I+K0iMxI8HeveSkw4qfmU2JXND+MYWG+Edy/vE3hfj7Xt9qiRnJdMUtO4W0ENhCP4Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SJ0PR03MB5807.namprd03.prod.outlook.com (2603:10b6:a03:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:28:18 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:28:18 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v3 2/7] arm: dts: socfpga: n5x: update GMAC nodes and DT
 register settings
Date: Mon,  8 Jun 2026 09:27:36 +0800
Message-ID: <20260608012741.23760-3-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260608012741.23760-1-chen.huei.lok@altera.com>
References: <20260608012741.23760-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SJ0PR03MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 022a0180-0c38-478c-7fe2-08dec4fd37e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1QqI8ilrAP2sukCwxThxspWZLLwCZPljL22iphizsxg37BJcpLgYGX3Y0/8t43vHi5I8IGpYwiqq+Qyg2n5/Gu2yb/OfymEOGNvn94I6fDZndPfhuC52DVs6FJz4C0ITTi3DRDYy2uBr0ovKOJVipamghllsUoeoEcU1Veij5kSyoet82+uIqwMK1LlBKP96Zl6vdhJFffGT9HbR9wkiPYMQvMOc4rhRxanS6uI6PoCNqnMaKG4jCuKRRLR117j1HwJ4jMUxKeIOmJa9xc3QhCJS3KViJAIz5x6tk+8+9pHVNB8Hf2nSuc0GkIaEDqvKiFlgnVt9rvJVkqClfskMISVIg4Wuh8k9DJ/ZnvBb02XSOvhGy2LTOA9HsfMKe5AZzIVDmgQXycA863L7V8FGCSZCMvgeV9c/ABdqSbKAsD5ueemtF0ASKNYdcZmFQD6czKFhgAUcUTIUSKtd9vSOLfCv08Mrk173MvEcTh5OcaK0dCvXc6Ij/de0VHGiiiwgd1fM8971DrzQx77pw3FMcoF9Hyem4RnCy+Qsj73TqZhb/RSmPnMgxkP1RYWfR6hheUVVoK1Jvwl6TWLjUOV1Rt+o8sN4VB22NxWIicohSwbEAz9Uz4sWf8mm6uaYzHAb5hidp+dh6PN9UdUx3XPFPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q0HyovMiS6An+CCC5B4IiWWBI77F3vkiBQYFEpv+wyDEfvINYslv5FvrKj1j?=
 =?us-ascii?Q?luxThToER0ElLAPr9wcdYwgfa1fVsIow4J4uWCiVEDBay+H43dmLDrskjEpj?=
 =?us-ascii?Q?qpCA9oFvwfJqYJLp1pyH5luFEDjpehcjuD9V5mL1hhGlK0Kup7HGnXITczdX?=
 =?us-ascii?Q?8egLrqRHB0LrlOl3BWhLcOvsV6lvHyM+GPqS3vgTCVd13WFSCmQNGYGXa/FW?=
 =?us-ascii?Q?zw/db07arjzLJoOpG8ij913jVS5gUcMXqRTL84+BiP/S1qnjVEu2HDwQKEsj?=
 =?us-ascii?Q?2rGzOv9PhFthbuKsLT91/d44dLBCI3zsi3XXthm4KZGldfzvG7ozmDbpG/TE?=
 =?us-ascii?Q?FgejUiEztV+5hH0jbLrvGkD7t482vpGeXVRXvT33U2Ci2qDtgmc8ddy3o5TV?=
 =?us-ascii?Q?F0XhEZicQJRga+D2tpfyY+UgY6bQ5UzyYnd4wgUbm1VlCUydE9xRZdGOcYut?=
 =?us-ascii?Q?n2z+V984Tk6qcU98gTJe9u1EjIF627bIPnTuL45TmIv3+1m2UpCL6GRBbxIH?=
 =?us-ascii?Q?M78RsXIiKkdV83XG6yWy8DYRSuRB10wQY0hlamHdzfYjvqmtxOrTESIV8URk?=
 =?us-ascii?Q?MmSGFPOZqKll7ijMkIaixOaX/dKy15gr5N4jYgYspSfoQJrpN5pQ149kaxuX?=
 =?us-ascii?Q?8LJV2sbhSht5/+z8KMigSmcYzKT/neFSp9LKyCwS8h2X45/fhZW5W/l5itDM?=
 =?us-ascii?Q?jrO4PmS7T1gL0puHBx0zS+pGe2Uv30vWtO8vt8krsoNa+QnPHb9LamCy8IgS?=
 =?us-ascii?Q?JcEU9udqnfC1gRHhUIQ1cV/j59ce0bNNsEywh8UaY4q75+fTqyzhVliqLbbO?=
 =?us-ascii?Q?akYUJCmRcPX8TgrZyV/F5tZC61+06cVyWHaLnOjiMwG92c4RPlkeBS5FySWB?=
 =?us-ascii?Q?cUBRN3U7d8cthh1+1IAiXPRXsOoFEOOwG0Vo12eNkvhZuSJiuXP3+e5ZOgj8?=
 =?us-ascii?Q?E9wE8jLjk6Nt2ylA8AqLEoYyhI3Fyb2CO7JBhOhVFgoP55nDsJZukD8UKrpn?=
 =?us-ascii?Q?FA99/m5Nko6rFEy/U/bqmbXPD11sDb1Muew7jWR1m9Eo4ZC3KYDNEjH7Hl7y?=
 =?us-ascii?Q?Xwp6s4dkM5hXtYBwqDH1BmqoHyI+EKMh51HjSOmyBSLLBhXy3WR4ZzYTpYpB?=
 =?us-ascii?Q?4IBzCqFp4Ei2ewJrUfUQrKN6A2A/r9DERPtabmmelS1hVzJQxXlqk7Gy0xD5?=
 =?us-ascii?Q?irVAdRkD0uWIeFq/eJRr+6wdyQvJEGOAXMS/ccErD2YRYENQlC60RZUcklUa?=
 =?us-ascii?Q?aQFcIheNv+DGy+dkmew3Qr1VLcpeMAPluxsjf5dcPjWqvw9jARBuedTyuDML?=
 =?us-ascii?Q?I6WfjxLu14/D7eaIi8fjprZ74CJil/dd4s9xR6Msq+BjGieE6WFA3yWSLeF3?=
 =?us-ascii?Q?EYLe5VLD14y+6l5uW5LVmvI7xjjMUX90K1opnx0SyipuVVsmJIXA9px//OB6?=
 =?us-ascii?Q?0oFRUoZGwY5oNFYpCR+CIHDycK6ua/yKwm+RRv7BmVT8Ayy7G+b/xpe/0Xur?=
 =?us-ascii?Q?kJvzkgIQwHmIcpBOmwIipds+K1e9MPmdKq3Lt+5vR0UCqZuUckACiVRbv+sI?=
 =?us-ascii?Q?1p6E5e/dstc73hPnvNOwN08+mpc6/CC+BwKUaCPQ9d+n2rpxY0BliGFgHR0s?=
 =?us-ascii?Q?k4lDU4rHzHBGsX2K1eT2MDxYtbm7jpplUmNhm2Dyl/WvUFkgfIwLl7tiqvSf?=
 =?us-ascii?Q?OwZaTVDXYnZ2T4snKtr6zt4lrQ8E1j/7jjQufzDWkg2OC6cmcv8L480gls6V?=
 =?us-ascii?Q?2yDMjNrRbg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022a0180-0c38-478c-7fe2-08dec4fd37e5
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:28:18.0314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50pKyOuYubtal8MglulcK5nh+aAJl+0ELFfAKeWrYZDjen13dERb83+ozYTq031JR30vHlKuRnEKsljm5tO1j3DEMPcuN+jEET6eylaHKkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5807
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:15 +0200
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

Enable register settings in the N5X U-Boot device tree by adding
firewall configuration nodes under the L3 interconnect firewall.
These settings disable OCRAM security at the CCU and relax MPFE
firewall restrictions required during early boot.

Update the GMAC nodes to include proper compatible,
reset-names, and clock-names properties, explicitly setting
their status.

Remove the clocks property from the QSPI node in
socfpga_n5x_socdk-u-boot.dtsi. The QSPI controller clock is obtained
via cm_get_qspi_controller_clk_hz(), so the device tree clock
reference is unnecessary.

Additionally, include socfpga_soc64_u-boot.dtsi and rename the
soc node to soc@0 in socfpga_n5x-u-boot.dtsi to align with
the common SoCFPGA DT layout.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 38 +++++++++++++++++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  5 +++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index e27a64651e1..dbfd2abfd59 100644
--- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
  */
 
+#include "socfpga_soc64_u-boot.dtsi"
 #include "socfpga_soc64_fit-u-boot.dtsi"
 #include <dt-bindings/clock/n5x-clock.h>
 
@@ -15,7 +16,7 @@
 		bootph-all;
 	};
 
-	soc {
+	soc@0 {
 		bootph-all;
 
 		ccu: cache-controller@f7000000 {
@@ -46,17 +47,29 @@
 };
 
 &gmac0 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	clocks = <&clkmgr N5X_EMAC0_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &gmac1 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	altr,sysmgr-syscon = <&sysmgr 0x48 0>;
 	clocks = <&clkmgr N5X_EMAC1_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &gmac2 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
 	clocks = <&clkmgr N5X_EMAC2_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &i2c0 {
@@ -132,6 +145,29 @@
 	clocks = <&clkmgr N5X_L4_MAIN_CLK>;
 };
 
+&socfpga_l3interconnect_firewall {
+	ocram-firewall@f7100200 {
+		reg = <0xf7100200 0x00000014>;
+		intel,offset-settings =
+			/* Disable ocram security at CCU for non secure access */
+			<0x00000004 0x8000ffff 0xe007ffff>,
+			<0x00000008 0x8000ffff 0xe007ffff>,
+			<0x0000000c 0x8000ffff 0xe007ffff>,
+			<0x00000010 0x8000ffff 0xe007ffff>;
+		bootph-all;
+	};
+
+	mpfe-firewall@f8020000 {
+		reg = <0xf8020000 0x0000001c>;
+		intel,offset-settings =
+			/* Disable MPFE firewall for SMMU */
+			<0x00000000 0x00010101 0x00010101>,
+			/* Disable MPFE firewall for HMC adapter */
+			<0x00000004 0x00000001 0x00010101>;
+		bootph-all;
+	};
+};
+
 &sysmgr {
 	compatible = "altr,sys-mgr", "syscon";
 	bootph-all;
diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
index 840537c9d0b..1f7e31bcae3 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -44,6 +44,10 @@
 	bootph-all;
 };
 
+&gmac0 {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -55,6 +59,7 @@
 };
 
 &qspi {
+	/delete-property/ clocks;
 	status = "okay";
 };
 
-- 
2.43.7

