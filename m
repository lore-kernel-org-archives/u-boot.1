Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B41C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 08:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0DA788E03;
	Wed, 24 Apr 2024 10:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZfO9k2zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1262388DF2; Wed, 24 Apr 2024 10:12:35 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D0088DF9
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 10:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKiamMkQeS3K9PxQmPoY+t7T26747kXA1TgwMhuFu85J742cyKgU8T6EvXyGk8HPR4qLoAxoLxrb4U1HE7wWcTstAbY0pMHnydx0it8PMISP8iwiUYk3eGbtmbXeVEdCD6Bgus4g1Qq+PoFWY3wKPpvsQlpzO9gSOK7DoMupkqTPldfr98xt+Y1Rn5WIuqpnXknyNDBmUbzugWC9w771nvxD5jxUDPZWG5GStJLcZYHmKSKt7j4a9DnkXzPLVr0sWgLp3Iyu7G2BlkGl4patRITqCe0VhwCTvzTRzrBL2FoCkpYsICaq8s2EYOwAwSU4Z1gEbQ8l+DMy2PxzBUylMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9dHvIxjsPSIWqWUy5ysun2WDjW3ahPaOhjOfDO/FrA=;
 b=nfNzgmJv/GwKxtdh90cWrX4LSZXWr4S8DsqNZiDJxDMgNwiYkjMZzbVBCn7vjsNAUdWFspDYPYEc+ELgxoyBObqN7EP2HLIyR0maHLxMvwykFw8DqkWzWz8j8K+Xu9Jujbsa7vxGIIV/mBek4vWjxcE/yur86pNo/1AjB8sLaptQw07Ui8iLQpiuS9DUVFMLbmi2Xk0SyNn0ZPUP+pI/YYYSrk+5CnA7wU/3icigM4rfXXFQvi7Gx6fBnA6A60ZIcYfY/b5hkh55srufDudw71wzNVi2zDLOMhQShGxzv9OCvtTSSDpESekoh4w6w8HoNZbsGyaSDrh7uKWHfPTddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9dHvIxjsPSIWqWUy5ysun2WDjW3ahPaOhjOfDO/FrA=;
 b=ZfO9k2zOLqwGzjfMU0zVZNAyQ67W8p41UYvUVmGYS4DIba0RapZ02blQr+wmU9nDZTth8SOtdvDPKJ4S8nUpyJu4dvTzJlYGk+kGcETpCwvgwLnNLfvr/AjgxtJYuOGcC7Qg5ehlrYMps7FzTgTOCSg3ZAs6mz4chhezmEIVHQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:12:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:12:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, Tom Rini <trini@konsulko.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 2/2] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Date: Wed, 24 Apr 2024 17:12:22 +0800
Message-Id: <20240424091222.10843-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240424091222.10843-1-peng.fan@oss.nxp.com>
References: <20240424091222.10843-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b77bf6-ed7f-4935-164d-08dc643647e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b5ReVH6bO+FwWjVVlsaWUQfEaB7W2tB/3ERY+lCK78UhsCYAK56N93DH0tjn?=
 =?us-ascii?Q?+QKXmnV6qAXfbrSqaXARidOjUHXE5gT4LhB8UpOgmZYWtvHo2PwsHm/kq/Wn?=
 =?us-ascii?Q?6gcn1iEBdrgC6Npt8okSrTkILl7fO+WjnCWG+r0gF+PZoiV/YCZxECJ8er0Z?=
 =?us-ascii?Q?A6yzQwoojAnviQEWCUFZ7vv3833S+PFEJNd6+5ABiWONZ/LrxyPUiJKuyZ/u?=
 =?us-ascii?Q?b5EmyjtpXyvP89JwLBFPCsneTgrQyUEkxwoPA68GfGKBg8miSH2daFkDIHOy?=
 =?us-ascii?Q?4gGmC59xe0yNe/+D0R330sU8IVA0IhfbO5tkO9PBqnBVf7aSVYl//9rjmdsQ?=
 =?us-ascii?Q?HSve9ruv06SVHrnYYbVl9cDsNUoSq3qp49ya+M3DVKump+wwOjhQoSR7bdwG?=
 =?us-ascii?Q?69I6ijHkN1gQxebp6f8gGMmDmHrUG8LqGaNRydoIh/deXwPK2E7Sn86x33mo?=
 =?us-ascii?Q?aKna6oP1M80fh/Yp5wKMYceSXc6V+1vrohni7I5VQGkMTHT5Jq4wJFRT1yqB?=
 =?us-ascii?Q?SsvKOPFg+M1jpcL+u0ISCnxDaf5FcTnc0EmP0/oFMsKjUPAyFDa1OK5E7O4A?=
 =?us-ascii?Q?FdZaMayrbCrFNiHgo6vthWKclVAJUlsbgfVbz3+Ikl5/VJ3qU9WEKCIHrtL7?=
 =?us-ascii?Q?h4VTSOrmJnYuW/0zDOyvUH/4YNoodbr+hEPTrS0WfKcHRTlA6ADZgWBFjatK?=
 =?us-ascii?Q?Gxz5LL4eGgCvrz/9oXisGbZrlW5uWJy39FREgL2mmYFULivWzW6PHVmq1fDp?=
 =?us-ascii?Q?XIl9+RhkLXMazoCzUqTP561t4PZm6j+le19ZpuL1inJ9akg9zO64EGns6zGg?=
 =?us-ascii?Q?Rn1IQk32jEAf7CgPNZwzD7xlz6nXTSbh0iY4n1PhjAGC3GNe3m1A2TmQg0Py?=
 =?us-ascii?Q?FQMFMCJA4HKBbxJ6s6cM1hZnXwqtRlf+y0qdaIBDQkt9E8RGu4wMndn9974N?=
 =?us-ascii?Q?wzXfONlFgcGtoTdvTizNSHJxM0DjV9pc08RO9Zo53twEGFJOeCPaVBqk2cei?=
 =?us-ascii?Q?t933rcluHztsj5Ej+BnMaSz7st1q+Nsa5J/Q+VUfLycMcjxbm0gTYYL5AUpi?=
 =?us-ascii?Q?ALGiQb/wtSN4S1nSh14GXbkIDmCBkwxcHf1Ugr1vX6ZmcZwamfA2fZegi6kA?=
 =?us-ascii?Q?o/VvzA7wMYzpUGxYxEIty8iGjiVH9G1Rn2xtNXHMD5GpJXUzC+J76vXJC1Gy?=
 =?us-ascii?Q?nYcP8LPFSCRnjccB60EugGdWgo4Ox3azeaUKSv0CTk+0XKqhNFwtA6+9USbh?=
 =?us-ascii?Q?zWjrw7bW+VVja/kgl9Z5BEDEZ8xy/RsUDqG6bgBg1WEvYoIKdxa4Ys446w7R?=
 =?us-ascii?Q?Q06wXonlfIdsyjdzHzdkkfJvdRnrw3bcO2aKB43u4dQUBw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z5aoRXB+z0DTqxZ0n8MZqw6tA7KH1GLMOSvBrCrUBAD/S3tX4udtrkLhVjE0?=
 =?us-ascii?Q?ZRIi+wMEBBsXhGcOQTLX6kXUL8yxQz0hLrQze06yofDpxwqBPBxczWDO2BYE?=
 =?us-ascii?Q?FnCAQGl5oWpdYEUIhkoa6At5nK/7nREVrU5yG+E7KysbGu46gfQWl/9dd+/2?=
 =?us-ascii?Q?AuYxwnbmbGGOtiXU8phBDHxvq3NozCOMA5FwJL0ecaGGSfLiRLBb1fihYQ12?=
 =?us-ascii?Q?sXS1voTKsv8+DMlsLgzi3kxdbiHauxPHgGSZeQ+MBHEC8ZEL/4kNIAUbGbu1?=
 =?us-ascii?Q?vFry6ixvrSdxN91VqUTG6+F6PFyEYOX+P14B8NfKsMZl6urtQnGIHl5k/KT2?=
 =?us-ascii?Q?HzeFSoj5Fr/eJceFG1twLvciq/i/q0HERFABQAmB0BS5I9fSlSjKsmRo2ZTF?=
 =?us-ascii?Q?uKX6PWbwaWYYm+Ywd0edQ3N8mgoCus8SdtLkgYCdfXdIYA4aOMZMZh2QEGxx?=
 =?us-ascii?Q?6QZOAnBPKLdxRmCavS4tiHX/SrEptyaxbaHmbJk3BGMIOYwlSWfUYo+kyrZd?=
 =?us-ascii?Q?cnqfwHhKTMXnDBGmPdaB2YxdqzejdNmB3H4KnhDPScmCxQg3gXjbIRo7JZE1?=
 =?us-ascii?Q?SkUd6PSflxJfm+BoVpNmqMDCQi3Ov65KA/ak3bjGvnwwta0Fc3Fm11vIy+aX?=
 =?us-ascii?Q?xeg8p26AGP3pxLDZnCaSJ3fg449PApTSEF7pcNgKGxKil1SxmnqJGFtdnccg?=
 =?us-ascii?Q?3/xyTRb0Xvn+5Giq9WxopCiWFHlTg8YIoZIvZxiZsHgzsevXo8qxSRU/OeCY?=
 =?us-ascii?Q?SSg/+JeG7g146T0O4jAKa2Y9K5Bp/BDO18aHIWVauTfXFRdCZiD8pat3OIHs?=
 =?us-ascii?Q?5oT5MyFUN8LRcNeUQaNjtZYTzmDWGaltiIfnqqJU4/d0y94zhMAcne3oyw26?=
 =?us-ascii?Q?I2rJrPAIKrWgOnF7Iz4u2kg+IpuQ5JZE700WGSdscWH5t3G+djlY8tufIP7w?=
 =?us-ascii?Q?PkNXhSIYS4sSbCkCjLL0UH/V8RY75+P/SgpLKQWCSgTrDK1iZPr/0CyMbHod?=
 =?us-ascii?Q?bOz+ZJWEgkJkZMUHHecdyLX0N4jpYzAK0WVysF3fk+PLjAEFJJa58staxjxY?=
 =?us-ascii?Q?fYmusQ/NksWHHgoDEMOUtnMF1Zzu4cDjc/oUsCncVQfuRqJB2pmQJQJpnPnN?=
 =?us-ascii?Q?xNm/pmfVAwWo0gHwUpghDpj6VbMMo0G8B0BNXz+/WEgqah+MGrRPwfNx3bk3?=
 =?us-ascii?Q?yWbiCIwhld4yIUY/MLQ4viGGqGitqAsoT2MMmDDCvTFLvzdZ+QhLZNReyWAW?=
 =?us-ascii?Q?ihBUIoPSaXojMuUSN5kqUjThfDfolxoL61vohgELfB5vthTuXD5XFW4leSYe?=
 =?us-ascii?Q?kNC3BtVbUKrFaYfDOd4OF3F0E8ZVkclII3J8q4/5LWm9IwaDoMkgk5zN4CVs?=
 =?us-ascii?Q?QAqnXuylVpVBKRcUczYIzzDODTeLidb3HWt8jMPKuIo9kg/mb3iHJHlkqevQ?=
 =?us-ascii?Q?IRk6jcnsr9m4tcyb1W6HdsMur04itwGz2xR+0Aei//XacNYe1JOq9XpyQQAq?=
 =?us-ascii?Q?TPJfuUTDuEDnZAHty5DKu7mGyRDiSylZVxkz35khmc0D3/h9xcRLkdL/Hkpk?=
 =?us-ascii?Q?R6UBP/2bb6GYkLWELOKFZt7EN/N2OiBmyMGRsclv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b77bf6-ed7f-4935-164d-08dc643647e5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:12:27.9699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqxH/VkG8dLhbH3l70QkpNgb+zmkTu3GVDwtB/ml5ErZmg9Tvw2a1nQuc0MTsDW2RIMkrZ6hgGfvjbp0pMtiZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
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

Convert to OF_UPSTREAM for i.MX93 11x11 EVK.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 +++++++++
 arch/arm/dts/imx93-11x11-evk.dts         | 322 -----------------------
 arch/arm/dts/imx93-u-boot.dtsi           |  15 ++
 arch/arm/mach-imx/imx9/Kconfig           |   1 +
 configs/imx93_11x11_evk_defconfig        |   2 +-
 configs/imx93_11x11_evk_ld_defconfig     |   2 +-
 7 files changed, 136 insertions(+), 325 deletions(-)
 delete mode 100644 arch/arm/dts/imx93-11x11-evk.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index dad869726dc..5c32daaebfe 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1041,7 +1041,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-librem5-r4.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
-	imx93-11x11-evk.dtb \
 	imx93-var-som-symphony.dtb \
 	imx93-phyboard-segin.dtb
 
diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index a99ba99bfb4..408e601bc90 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -26,6 +26,111 @@
 	bootph-pre-ram;
 };
 
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	adp5585gpio: gpio@34 {
+		compatible = "adp5585";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &aips1 {
 	bootph-pre-ram;
 	bootph-all;
@@ -44,6 +149,19 @@
 &iomuxc {
 	bootph-pre-ram;
 	bootph-some-ram;
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
 };
 
 &reg_usdhc2_vmmc {
diff --git a/arch/arm/dts/imx93-11x11-evk.dts b/arch/arm/dts/imx93-11x11-evk.dts
deleted file mode 100644
index 4322cc3e11b..00000000000
--- a/arch/arm/dts/imx93-11x11-evk.dts
+++ /dev/null
@@ -1,322 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 NXP
- */
-
-/dts-v1/;
-
-#include "imx93.dtsi"
-
-/ {
-	model = "NXP i.MX93 11X11 EVK board";
-	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
-
-	chosen {
-		stdout-path = &lpuart1;
-	};
-
-	reg_vref_1v8: regulator-adc-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "vref_1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-};
-
-&adc1 {
-	vref-supply = <&reg_vref_1v8>;
-	status = "okay";
-};
-
-&mu1 {
-	status = "okay";
-};
-
-&mu2 {
-	status = "okay";
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy2>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy2: ethernet-phy@2 {
-			reg = <2>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2>;
-	status = "okay";
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <650000>;
-				regulator-max-microvolt = <2237500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	adp5585gpio: gpio@34 {
-		compatible = "adp5585";
-		reg = <0x34>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
-&lpuart1 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1>;
-	pinctrl-2 = <&pinctrl_usdhc1>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-	no-sdio;
-	no-mmc;
-};
-
-&iomuxc {
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <
-			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_pcal6524: pcal6524grp {
-		fsl,pins = <
-			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-		>;
-	};
-
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
-			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
-			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
-			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
-			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
-			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
-			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
-			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
-			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
-			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
-			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
-			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
-			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
-			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
-		>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
-			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x57e
-			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
-			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
-			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
-			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
-			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
-			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
-			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
-			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
-			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
-			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
-			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x5fe
-			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x13fe
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index 40e17bbc5ae..289aba17584 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -86,3 +86,18 @@
 		};
 	};
 };
+
+&tmu {
+	compatible = "fsl,imx93-tmu";
+	reg = <0x44482000 0x1000>;
+	clocks = <&clk IMX93_CLK_TMC_GATE>;
+	little-endian;
+	fsl,tmu-calibration = <0x0000000e 0x800000da
+			       0x00000029 0x800000e9
+			       0x00000056 0x80000102
+			       0x000000a2 0x8000012a
+			       0x00000116 0x80000166
+			       0x00000195 0x800001a7
+			       0x000001b2 0x800001b6>;
+	#thermal-sensor-cells = <1>;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index b79485f1f75..e892da80fe8 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -31,6 +31,7 @@ choice
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
 	select IMX93
+	imply OF_UPSTREAM
 
 config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index db2f2623d89..5ad770f91e1 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_TARGET_IMX93_11X11_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/imx93_11x11_evk_ld_defconfig b/configs/imx93_11x11_evk_ld_defconfig
index 822cad7e3fa..abda6d12662 100644
--- a/configs/imx93_11x11_evk_ld_defconfig
+++ b/configs/imx93_11x11_evk_ld_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_IMX9_LOW_DRIVE_MODE=y
 CONFIG_TARGET_IMX93_11X11_EVK=y
-- 
2.35.3

