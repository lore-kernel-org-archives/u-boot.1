Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BFAC47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 321F3880B9;
	Thu, 28 Mar 2024 02:27:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ljXHdZla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AFF2880D6; Thu, 28 Mar 2024 02:27:07 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20DD687F4F
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqPDCfTcxM0tQoz8qYj/l/fXj3NR0m7qY8gahY/+RwBRxD9R55G0PKUUsX2uh4c50GZssNFeaxrhKS6I7e5ADOb/gj+pOz/sqhGSoicywp8Nawd/R4JnmfOV5vYuqjY8JzwVqNO7NO/gJ3yHK5cSs6Ia45KbC8xrRpgsrx61hoTeSrzi2JG5oYc7PxrGaeViKm+nE3FBFwTIFZXrO6xSkWbH0yeb0p8WCw4ZF07PBLS2l09mEG4LQNzIyR4cHmtEjEq+4kn8Jq8KYd+1mALmSg7Waae7u7HVrR18odqlRM1Q//mAuAePf032+0aMAoNxITwQqorCte25g5AKMOCKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aarUlL/iQ5haoJwj5gEAtTyBvvkRA1NKeK7+KZPc9vk=;
 b=kPzLwN5tLOwhr1bXerXgdIef7Clmiwz0i6Mcd/qF/hwp3Few8+L20h/gqxDnMiujl6Va5p5s6LqdYluF8T/76nHpQJ8G4cWyVIdc5miAXI7UN5jySeek/0rTgSB3QNhBTl4QEczRxLCzSFkvOZcuhMHvXnTZfh3YWby8qqBpZiFD42XHTdO7+xpvb+ASnQnWbFsAWcHPXMpASajF8e4YZIv+SqECFx7PpfpLlN77StXa+4FUKq6GNbRoyfYfIs1cLZwRrisEThBrU3pAhTQdhCOSUBjHZJRIwL6hwGJqmPrKQZVqxKhKlz2KHiJlyLyvfM3KV7M2uN/2crgWAS1JpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aarUlL/iQ5haoJwj5gEAtTyBvvkRA1NKeK7+KZPc9vk=;
 b=ljXHdZlaE50p1oaTE9H6558Fky7U/cv3EJulsYMYDwis4pnIPFZjS0hBXCa6YLeLArpsVX3qP5ZuhlMK21Abki9wTjCuLkrL1T65O2Z/8XltoyTejVukJc44yHLN5b2VbM9Tmx5X6I8LHD77r2mHP5T9mGquwmzPi31lwN3bmK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8763.eurprd04.prod.outlook.com (2603:10a6:20b:40a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 01:27:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:27:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 10:26:35 +0800
Subject: [PATCH 2/4] imx: imx8mm_evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx8m-v1-2-2be5e6657a88@nxp.com>
References: <20240328-imx8m-v1-0-2be5e6657a88@nxp.com>
In-Reply-To: <20240328-imx8m-v1-0-2be5e6657a88@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a11889-0941-4d2b-cb9d-08dc4ec62c52
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTyYuswDkAhXT5QkrH5J5ZO9S3qbiFWWcfDYLLN3EIj2ax9l8UAxpQIqLGj696iwmSAN96vsrKEdc+5VyUuVP1f93vVatRudo+Us6PbOA9UacMfR1mtCn38l4f+pyJ0K5h13X2hfm00U1taZDs808zbh66pDreAEXd5zxnNZvkTlGkiKnXZYF51tn0Iwja1y3zOKhd3TW508wsYg+35K5fr+Olo+fOx61e6iNJoQnjeMjEGI6yxk/AiRU4C4pr8O7SEJHrUvn0zGyZ/X5neaAJRwM483aYKGIrBwHmHI7kRIuCuvm7ueFwoYV2mpfutuqWAlFLx/aW3zz75uvDCQ/sOyscLZFv0Sjy4AXrIZ76mUpT5Zr6ItvJCS42dOWwLJDw9fXKbJBO0Q8T/U/eicKKVKDHgTruyhlVlaJYgeAHWRYPGHZEwvKOr1NkuH/NOkrm8vtxZyqRy7CfTRGHa0g0bTeKCKqW/2uulXDmC2REZdTOH5J3wkT+dBfxVlM0RbDQ9zdzgk8Og+VkldxZ+Zxzn6HGXVwWQcSeuCPySMa/GJc+SlQXtE46lLwf7gIWz6aEtZp/UUrriRRUKeudRbg56bhVzHtDZYTikn5jEU3nPvxox6pc+sK6yf7bc/RGl3NM2InzjntkvWcIDwWfqU2ua/TnNy7RHRFCt/NLDNpx89J4GShahZ7HFKHh6JowYErQ3Kk0AQcJD6sRCogoPocDjO4pBjFHzyVMyk9QpcP5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGFKbm1tNFVqNmd3RGxEU2dTdHN0V2FvNzIxdGIrNEUydjZWSFBCMGhSb0ln?=
 =?utf-8?B?WEZLNU1VVFZpekx4VjVnRUpjR0kwZ2U1cGpQRmU0bFMwYkF1d1U1aC9mV1o1?=
 =?utf-8?B?aUtZcHVqLzhKN3IrTEpJb0hKSWRpTDJCT3hnaVFuZExsNG5WWFpEL1ErOFlu?=
 =?utf-8?B?UzRUYXFXOGUwNno5M3pkK2RTSnR4T1ZtSDlxNlBVVjkrbWlhc3k3cFYzNldY?=
 =?utf-8?B?a2w0S2VIak9mOXBlbno2L3Z4RGNvNHRYdFovL2VCUno5M053cGMrWndDNkE0?=
 =?utf-8?B?dHFPOWU3RkE4dG1WSy8zRHRzanZ4TWZDOE4vajNhaGtxVFB3ZkdjWGw5bXhE?=
 =?utf-8?B?STJ3YTQ0ODczMmRiWVJiQU5nMFc1aXJEMjRnZXRxZDhBQ3g3dzhzVmg2SE1E?=
 =?utf-8?B?RWRLMU9WUkxGV2xFZ2xNSTFndEVQb3NqR0xZWWgzZFo2SVM0Q1I4L2tLZWFZ?=
 =?utf-8?B?ZHpvWTRxY0l2NWhIMVQ1akQ2b0VSc3pVaXoyUzloclg2NWdUTndRZVVtSzNI?=
 =?utf-8?B?Q1F3NVc0enJCVnZpcGJiNGtBNFh0KzljUTVkODlWczNMVCtyYS9BV2pzYkZC?=
 =?utf-8?B?NlgvRmxidGxybkZUVWo3c3R3dGZMSFh0eGV6VEx1Sm1uZi9oQ3pGMlV5cEcv?=
 =?utf-8?B?a3NnRWhGWXdZZ0FQM1dEQ0VxeWFNTGVMdnMvbjNzVmV4UjFsZnExQUt5SGQx?=
 =?utf-8?B?cUMzZmQ5ZnUraTB1aFUrTDhUdUdMOXJRczFsNmxRbVNUdnJldGpoNHc4dTM2?=
 =?utf-8?B?eVRBMGVJMEtBbFhsQ0FKOHNQaFg2Y0tjWVJYTzg5QnR6VGxBNlF2dGMyVFdD?=
 =?utf-8?B?ZXFDMHJRcU1ObjhxMVhzamdkWEZIZ0RHdTQrNGpxU21vOUtFRXRiWFlLU3o4?=
 =?utf-8?B?NXRYMzl2cG1SYmQ4emlrVjc5RitxR1lJa0l4eUhIekQzQVlvREE0YXpRS3pK?=
 =?utf-8?B?SjUzYnhnTDZ2YW5NdGoxbXFSWEtvU25TWElYcXd0a1pBN25QeUxHL280TlNH?=
 =?utf-8?B?cXVPcGNMZ3lWY0tENzREN2ZNZUQ2ZWNjSUQ2c2N6Y2dKN0VRNks0VGl4T0lV?=
 =?utf-8?B?NEZKU2F3eUZJb1JrdUh4OXFwZlFHa1lsNkVjVkZGVU9TUmNzWG5Eb3pqbUlU?=
 =?utf-8?B?UjFPd1BCWjl2Qmk2UzdSeWQxSG1EUHVEMnV2T0pkRyt2ekdOYmYxc2F3TlFy?=
 =?utf-8?B?a1V1ekYxZFRuTHVZUjJycXV0MHNXN0grUW1Penh3NVBTb1VpYXdpbG1jNWo2?=
 =?utf-8?B?bEFtNWNCa3Eyamd6d0VmcVo4TkFJK2E0QVdCVFZUT2ExUFhBSWszS3JTMUZC?=
 =?utf-8?B?bTRiYkxuOE9kQVhzbEREM3pkcW1VUWNZZXMrNUJDeTFlOUxZTnV0VWJNRkE0?=
 =?utf-8?B?VE9SZ2toOHlWYUxabTZ3NVYvelptaXV2SUF1R0Y1U1BLZHhLNHc3NktYVFFl?=
 =?utf-8?B?SG5uMnNXbGViTVRGUG5tQWlaYm1ZeStoSXBTTmpnaXRhaHU0bTAzMDNEMmps?=
 =?utf-8?B?ZTlMb1pKTjNrQnJNN0ZKeDM0ZEpvNEVtZGVDdko5NGgzcCtHNG1DT0Q4YUVj?=
 =?utf-8?B?OFNuMVBHbDF2dzJvM3UrM0ZMYW9NdHJIZjVseUlzOUdXYlB3REg1Z3BTbzg1?=
 =?utf-8?B?bTdSL282M3hVbm5maWp6T0lNaE1JYVkwaCtoYlQ2UUJZUWFvbTRPL3JCYnJK?=
 =?utf-8?B?TVkrTzRZaXBHUDdPZEJva3IzejV6OTR3MVpxV1djNW9VVVVKYmdnZU5IL29n?=
 =?utf-8?B?dDFXQjV3U2NjOVRXeHh3TzNBWlRlT0NUV1lyTXpFVHQzZmg4YWtUOUxDcjBG?=
 =?utf-8?B?WG54enYrOTlVVmEwRkZSWEh5akM2dVZQM1kzaTJIOTdjeWYxYUpNdVg2ZGR2?=
 =?utf-8?B?L0s2Y3hvZU9tMVViSXFWc3I0bTB1UEpKaGQwVjFDY3lIeG5TazAwMDlZSll2?=
 =?utf-8?B?bUw1OTlTSmVyR2o0ZjRwZFZ2OEthMHNqWkZITVh3Mlc5c1hGRmJCWndNYnpm?=
 =?utf-8?B?U3oxNHZ0WVpKLytiYk9DQnQzZFluRDlLYzlRNG5ZWXZuL0xRcW5ZeTR4YlZK?=
 =?utf-8?B?d2dVdllrR1RPSG9CaFN5ZnFSVGZOUXlMQmpWbkl3ckN0WDRFK0Z2bnhScXV4?=
 =?utf-8?Q?fqeKs0Fd/d6q4LEFDLiFiBk4L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a11889-0941-4d2b-cb9d-08dc4ec62c52
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:27:03.4699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeIpasLXbDtzTWeqcS+VyifXEM1GD0v1Hpx1kfmRVxWWLP6IszXv4UVBSnYu6+FgK7Mq/+xm7hTdPYS7/fM1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8763
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

From: Peng Fan <peng.fan@nxp.com>

Convert i.MX8MM EVK to OF_UPSTREAM

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mm-evk.dts       | 128 --------
 arch/arm/dts/imx8mm-evk.dtsi      | 615 --------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig   |   1 +
 configs/imx8mm_evk_defconfig      |   2 +-
 configs/imx8mm_evk_fspi_defconfig |   2 +-
 5 files changed, 3 insertions(+), 745 deletions(-)

diff --git a/arch/arm/dts/imx8mm-evk.dts b/arch/arm/dts/imx8mm-evk.dts
deleted file mode 100644
index a2b24d4d4e3..00000000000
--- a/arch/arm/dts/imx8mm-evk.dts
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019-2020 NXP
- */
-
-/dts-v1/;
-
-#include <dt-bindings/usb/pd.h>
-#include "imx8mm-evk.dtsi"
-
-/ {
-	model = "FSL i.MX8MM EVK board";
-	compatible = "fsl,imx8mm-evk", "fsl,imx8mm";
-
-	aliases {
-		spi0 = &flexspi;
-	};
-};
-
-&ddrc {
-	operating-points-v2 = <&ddrc_opp_table>;
-
-	ddrc_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp-25M {
-			opp-hz = /bits/ 64 <25000000>;
-		};
-
-		opp-100M {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-
-		opp-750M {
-			opp-hz = /bits/ 64 <750000000>;
-		};
-	};
-};
-
-&flexspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi>;
-	status = "okay";
-
-	flash@0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <80000000>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_flexspi: flexspigrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
-			MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
-			MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
-			MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
-			MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
-			MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x190
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d0
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d0
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d0
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d0
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d0
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d0
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d0
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x194
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d4
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d4
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d4
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d4
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d4
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d4
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d4
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d4
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d4
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x196
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d6
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d6
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d6
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d6
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d6
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d6
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d6
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d6
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d6
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x196
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mm-evk.dtsi b/arch/arm/dts/imx8mm-evk.dtsi
deleted file mode 100644
index 7d6317d95b1..00000000000
--- a/arch/arm/dts/imx8mm-evk.dtsi
+++ /dev/null
@@ -1,615 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2020 NXP
- */
-
-/dts-v1/;
-
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include <dt-bindings/usb/pd.h>
-#include "imx8mm.dtsi"
-
-/ {
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0 0x80000000>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_led>;
-
-		status {
-			label = "status";
-			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	pcie0_refclk: pcie0-refclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	reg_pcie0: regulator-pcie {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcie0_reg>;
-		regulator-name = "MPCIE_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000 0>;
-		brightness-levels = <0 255>;
-		num-interpolated-steps = <255>;
-		default-brightness-level = <250>;
-	};
-
-	ir-receiver {
-		compatible = "gpio-ir-receiver";
-		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ir>;
-		linux,autosuspend-period = <125>;
-	};
-
-	audio_codec_bt_sco: audio-codec-bt-sco {
-		compatible = "linux,bt-sco";
-		#sound-dai-cells = <1>;
-	};
-
-	wm8524: audio-codec {
-		#sound-dai-cells = <0>;
-		compatible = "wlf,wm8524";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_wlf>;
-		wlf,mute-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
-	};
-
-	sound-bt-sco {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "bt-sco-audio";
-		simple-audio-card,format = "dsp_a";
-		simple-audio-card,bitclock-inversion;
-		simple-audio-card,frame-master = <&btcpu>;
-		simple-audio-card,bitclock-master = <&btcpu>;
-
-		btcpu: simple-audio-card,cpu {
-			sound-dai = <&sai2>;
-			dai-tdm-slot-num = <2>;
-			dai-tdm-slot-width = <16>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&audio_codec_bt_sco 1>;
-		};
-	};
-
-	sound-wm8524 {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "wm8524-audio";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&cpudai>;
-		simple-audio-card,bitclock-master = <&cpudai>;
-		simple-audio-card,widgets =
-			"Line", "Left Line Out Jack",
-			"Line", "Right Line Out Jack";
-		simple-audio-card,routing =
-			"Left Line Out Jack", "LINEVOUTL",
-			"Right Line Out Jack", "LINEVOUTR";
-
-		cpudai: simple-audio-card,cpu {
-			sound-dai = <&sai3>;
-			dai-tdm-slot-num = <2>;
-			dai-tdm-slot-width = <32>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&wm8524>;
-			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
-		};
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			qca,disable-smarteee;
-			vddio-supply = <&vddio>;
-
-			vddio: vddio-regulator {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic@4b {
-		compatible = "rohm,bd71847";
-		reg = <0x4b>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		rohm,reset-snvs-powered;
-
-		#clock-cells = <0>;
-		clocks = <&osc_32k 0>;
-		clock-output-names = "clk-32k-out";
-
-		regulators {
-			buck1_reg: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-			};
-
-			buck2_reg: BUCK2 {
-				regulator-name = "buck2";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
-			};
-
-			buck3_reg: BUCK3 {
-				// BUCK5 in datasheet
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck4_reg: BUCK4 {
-				// BUCK6 in datasheet
-				regulator-name = "buck4";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5_reg: BUCK5 {
-				// BUCK7 in datasheet
-				regulator-name = "buck5";
-				regulator-min-microvolt = <1605000>;
-				regulator-max-microvolt = <1995000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6_reg: BUCK6 {
-				// BUCK8 in datasheet
-				regulator-name = "buck6";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1_reg: LDO1 {
-				regulator-name = "ldo1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2_reg: LDO2 {
-				regulator-name = "ldo2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3_reg: LDO3 {
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: LDO4 {
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo6_reg: LDO6 {
-				regulator-name = "ldo6";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	ptn5110: tcpc@50 {
-		compatible = "nxp,ptn5110";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_typec1>;
-		reg = <0x50>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 8>;
-		status = "okay";
-
-		port {
-			typec1_dr_sw: endpoint {
-				remote-endpoint = <&usb1_drd_sw>;
-			};
-		};
-
-		typec1_con: connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			power-role = "dual";
-			data-role = "dual";
-			try-power-role = "sink";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-				     PDO_VAR(5000, 20000, 3000)>;
-			op-sink-microwatt = <15000000>;
-			self-powered;
-		};
-	};
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
-	pca6416: gpio@20 {
-		compatible = "ti,tca6416";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
-&pcie_phy {
-	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	fsl,tx-deemph-gen1 = <0x2d>;
-	fsl,tx-deemph-gen2 = <0xf>;
-	clocks = <&pcie0_refclk>;
-	status = "okay";
-};
-
-&pcie0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
-		 <&pcie0_refclk>;
-	clock-names = "pcie", "pcie_aux", "pcie_bus";
-	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
-			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
-	assigned-clock-rates = <10000000>, <250000000>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
-				 <&clk IMX8MM_SYS_PLL2_250M>;
-	vpcie-supply = <&reg_pcie0>;
-	status = "okay";
-};
-
-&sai2 {
-	#sound-dai-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai2>;
-	assigned-clocks = <&clk IMX8MM_CLK_SAI2>;
-	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&sai3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&uart2 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	usb-role-switch;
-	disable-over-current;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	status = "okay";
-
-	port {
-		usb1_drd_sw: endpoint {
-			remote-endpoint = <&typec1_dr_sw>;
-		};
-	};
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_backlight>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
-			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22		0x19
-		>;
-	};
-
-	pinctrl_gpio_led: gpioledgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
-		>;
-	};
-
-	pinctrl_ir: irgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13              0x4f
-		>;
-	};
-
-	pinctrl_gpio_wlf: gpiowlfgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21	0xd6
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x400001c3
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x400001c3
-		>;
-	};
-
-	pinctrl_pcie0: pcie0grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B    0x61
-			MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21       0x41
-		>;
-	};
-
-	pinctrl_pcie0_reg: pcie0reggrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5       0x41
-		>;
-	};
-
-	pinctrl_pmic: pmicirqgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
-		>;
-	};
-
-	pinctrl_sai2: sai2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
-			MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
-			MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
-			MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0    0xd6
-		>;
-	};
-
-	pinctrl_sai3: sai3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
-			MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
-			MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
-			MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
-		>;
-	};
-
-	pinctrl_typec1: typec1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2grpgpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x166
-		>;
-	};
-
-	pinctrl_backlight: backlightgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT	0x06
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 6f68ee2c27d..dd139c1b223 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -79,6 +79,7 @@ config TARGET_IMX8MM_EVK
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MM_ICORE_MX8MM
 	bool "Engicam i.Core MX8M Mini SOM"
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index b51e3931d24..e41facd8513 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-evk"
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_TARGET_IMX8MM_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 34e8071611b..3aaf7a4d0d5 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_IMX_CONFIG="board/freescale/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-evk"
 CONFIG_SPL_TEXT_BASE=0x7E2000
 CONFIG_TARGET_IMX8MM_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.35.3

