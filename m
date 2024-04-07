Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DC2CD11C2
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 13:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D3687F78;
	Sun,  7 Apr 2024 15:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="iTssyRkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E52F87E2C; Sun,  7 Apr 2024 10:57:25 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4233287E3D
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 10:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0MxVLCKJegxIDCqSF4U12iM0h98MsUNyA8gVZ8rLRNc8gr+1GVTACjSB3vDX8rdJ4mbxMa+TQxQX9kUqJCCqbT0afoyyJ/cF457Vk8deE6oLteE9ZeHc0VY7UngPBFGESCVnPNEwNPc5xYIYUfL6MSiHcBB0mmw1Hn7R6J1kfKt+FSHqovCU2Fz8Ozc4QTL1p9xlM0IHaIa8QhgwUpvJduXUd/QfovVX4UadcUBk4OK282JPO3xH/jYtn7j4jFmbe9W15mwmffgMWhfkrwpzfa5fUSxU/1kNnWOxcsUzVSuN5sIegDhLiLfaScWRvWA//Nf8xVCcNx4wJAMByCw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZCLhTgL5xvqoYERRWa82gkWYGbDrR1BQQNtfb6d4o8=;
 b=biEVEewuZPyZ6N3pnSz6BQcEkaAfwkLohfKhVQ6VrNTbr9PFQxTsU64lTJ18ePLdZo67SbScTAJK2gRixMFDOFmztdbH7GfY5RSiHIjqvDTH/OoSaVkCGN6OVJZQvDE5ViPv/cLefXEdD45KxCa8vBLEhV/ezrV5In7/t78mu1Xjp+g2cbh1lJQCa9of7AF5e39VVuEjO+dq7zQArF2bMOSbzet9+KnG0OXY3qhg5E/t2HR1mcnkoSvjob03c9oPtCbvWrlmWZRrD06RUVNxhdswKh284aMq/lUj+WZg1yrQgEpK82MBiYmuLFHs7BZmZLY1HNzGGtTq3Y5ofaLcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZCLhTgL5xvqoYERRWa82gkWYGbDrR1BQQNtfb6d4o8=;
 b=iTssyRkD91vH74fOxZhPrYeZrfDdoLnlAtMXy6k/a3m91Cu5bBB+xD//Z6lCH51a0eSLjhphrmqNYa4cNqcw5eWXKkfqTwH/rp+cGbzECu4zOjVncTDUHcZG4L064Kfj1Ine07OO0IrCsKwz+6D0l5VssPJCKwMmXo4inYwo2jg=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB8279.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 08:57:21 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 08:57:21 +0000
From: Joy Zou <joy.zou@nxp.com>
To: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de,
 festevam@gmail.com, sjg@chromium.org, saproj@gmail.com,
 judge.packham@gmail.com
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Subject: [PATCH v4 2/3] imx: imx93_evk: add rtc PCF2131
Date: Sun,  7 Apr 2024 17:05:02 +0800
Message-Id: <20240407090503.2312483-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240407090503.2312483-1-joy.zou@nxp.com>
References: <20240407090503.2312483-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB8279:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y06ZaXlLjXf87RLj8+KnizbuetTcmxHyhwW1JXJBJnD07G/zFpVagpUX/8w0ZHw5WNbVCxi7cNfCuKxg6WqYE+gmTHlkoyGZJGsVCIAhYpEFVEcR1ufSAxVIZCu+Eo5VfIldUKfWaNK2dWwiDT0izTGtv6PXcbgeWAL9fq3FOAz5FDDkksW5wcgI/G1C/n5TxHwCZKFjKQ05VxEtTEZlX6dblZHE1e0lDlxPIdgpYCdYXSwBRDHqPaxADop6JTc/vl5UydXq4lJNTV5O0G2ElWGxy8l7X5cHXdYET9anK7/KM3IskluxNwGF9ez5zgM/GavAujQibkHYJZi/uZCuv1f/tyExdz1hXGNR7FoZXTHonxShji6jej2VNzhcieo/e/DgqOsDOJ5iXvdRfARK28q1A/Ac58hWY8r8ejXCE59tPey9/F0xS7Jxhz0r/4q8ezUe3c9QU0HTqFZFSX6sl0XZAwFKlr8mTScTFDg8RQFGIBS1UH6lwpFa2kr95+hOm6NEmRhnwNSEoWmG9JcggXS7IB2Hr5ZY16CpVhMJKyB1ix8Si54wyRLuCCGWhPRoEThjjN4kUf6A7PHXQzt5sx0QZsRW4S9bFSrPPnzo3megks3ckPRpmcRdpUkWa972Se8kYxHqiuIbqOWGDuVXVmE3Hwb266HTrDDG/cIuhNRj2pQqmw1Srum4Ttdyo+G/4L5YpIEiTodVoz+8RR+sQVq4lYY0gc0WH/0rg9AREyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HuH00YLplpK2X+3YSnZ6hHFtcZYQG8a3CT8Qu7ALOE9uPbDUmz4RUw0tvt5X?=
 =?us-ascii?Q?4KS0OUscuBCF9mWSU/FntqkQeBrYAC3miLkIOqs9TVaPfbnx8fNV01Je8+tk?=
 =?us-ascii?Q?2psqoCnOQkaaiPnsgfzgpFCM7FOKKR+RrauOHgGPMNf8IC+GlGYiH9kJdsSw?=
 =?us-ascii?Q?NhdQDkSdzcxGOg6FQoi/a5IXURw3H4btHDqAzkpiJcve0VNE+4yGw4npTumb?=
 =?us-ascii?Q?SqY1ilPBnQgR/XBoExAdZyfVPjVEQda8l0mhq6RHO4TRFXaXRt7zZzr76A5r?=
 =?us-ascii?Q?4+BbTi+v01qPxSC0cgoZpR3rXHqWLMSkeoFUOb5bPSSMaN/+ek7dwH2X65r9?=
 =?us-ascii?Q?xCYIVnXrU9lkrX+1rwbznSA/TfdOj1L9MRbFt4Zc7S17l7Trx+zjrrGiau9k?=
 =?us-ascii?Q?E5PBohKa6EcRIHxrFw0oiEf/GaPRGOVV5oRJ9pFZi+/MrAfRKQstm6mY6zV3?=
 =?us-ascii?Q?0YZM6avQt+BM0YYrzGys2+S6EjVBlQU0c5eS3izc1sJrNdA16ygwsxh6D/vk?=
 =?us-ascii?Q?Y2H15X52xt5BQc2GOwWOmOUxbCRfKS2DIcjEpvgaeRgUqox2ZP720MGCLwdO?=
 =?us-ascii?Q?ITwFr6SDhz9l09R8fwmhNX2Y7TmtZpjEzyZB56Mo15Y80zxCYOBcBygYtw+Q?=
 =?us-ascii?Q?3DWruDHRh4vSIQ/HMrL5oMdfufXW30KtZ5PF6LQNRM1DJZqdEL0mgtayx/C4?=
 =?us-ascii?Q?nnLp5POFG3XPupCicnfTTb2oqD/G9ZAQxiuQHPCrcC2NCVJWukLvq4j6n6iT?=
 =?us-ascii?Q?1WwL0YLmFkdQ0ElyidKBhcCrKu3zb1hWzgUWqhDtr9VTkHrtmn4qqEgHLE8/?=
 =?us-ascii?Q?VUKpil6iTMyf/elSAtdg1FxCpo3wJRQyjziqbY9dlFZwdxEEv92+Fw4i8Y2V?=
 =?us-ascii?Q?wO4QajIyjjGvBzQVHNYSy5cx07ePGWkjOk6M8z42sDCHSyjyfGTDdy6/1YGR?=
 =?us-ascii?Q?C4xYCCt5nAHzJRkponM9qm/urLIeL5AtYssqIYueCif9MYG5OfwyyjsVDXcx?=
 =?us-ascii?Q?yLuuOBzaA43TC8BPhrWDf4wl+NrYm0htEjmQS4JCg5RLb9wVTE6hHrpvs9s6?=
 =?us-ascii?Q?UGlF36jut0/XcnvvrJ+peGLsg9LpNguo4FTduQaImx6Ocqt9/7xLjt4D9Ncs?=
 =?us-ascii?Q?bvETg1pCHQkwOGD3zMMNJt9lcs+UhttZQbeE0AwoOBTo3H5DuTO1WlKEEYmz?=
 =?us-ascii?Q?40hKA53P+V3ChNbLummd91qR67SrNYKq5IBb0h4Rfu61b9uN31NNDCHcYzpp?=
 =?us-ascii?Q?vGiNpy0Si+snNwE1E5Zlbk76mCs/+TtxiebwYMG26l1BrqWJ3Gd8ndroJNw/?=
 =?us-ascii?Q?UwOTRer510z7oVT/QK/C/xop/ezAYfw+RBa2MmDU5ZrRIXpyEVn8Kb7+3mv/?=
 =?us-ascii?Q?5gh56OJ2gSb+afM5inSsmwPU80ubQ0qCUmEIvWwtrHeI9Q5MQdNCdInUs019?=
 =?us-ascii?Q?yq80hOGeDTu5vI+gxbNtj7KyFAPGzU1AIfxw6K/yozYmiHm5xO9t5a65KJoM?=
 =?us-ascii?Q?nzSQz3BtOaBG+lTRYovvjVa3H2zyBDO3zf197tikpYlQvR7/xEBKKZEKrbhX?=
 =?us-ascii?Q?FPoUNzFnfjHZY/Z6Pofv37EuEblD/BJnzOBobPen?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758bea47-3f75-44cb-959d-08dc56e0bc6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 08:57:21.5438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mM9OFVpu2mjYR1nuWUcM5pxzb8ZCxQY/5/Z0168TnTIKhNujZ+Wb5k9MlTCRNZWM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8279
X-Mailman-Approved-At: Sun, 07 Apr 2024 15:03:39 +0200
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

support rtc PCF2131 for imx93.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v4:
1. remove arch/arm/dts/imx93_11x11_evk.dts change because it can sync from kernel dts.
2. add the RTC support to the -u-boot.dtsi.
3. assign the rtc0 to rtc@53 in order to avoid date reset fail.

Changes in v3:
1. remove arch/arm/dts/imx93.dtsi modification because this change have existed.

Changes in v2:
1. use the flag bootph-pre-ram instead of uboot,dm-spl.
---
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index a99ba99bfb..85aaf0844f 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -19,6 +19,11 @@
 			method = "smc";
 		};
 	};
+
+	aliases {
+		rtc0 = &pcf2131;
+	};
+
 };
 
 &{/soc@0} {
@@ -112,6 +117,25 @@
 	bootph-some-ram;
 };
 
+&lpi2c3 {
+	bootph-pre-ram;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+	};
+};
+
 &{/soc@0/bus@44000000/i2c@44350000/pmic@25} {
 	bootph-pre-ram;
 	bootph-some-ram;
@@ -127,6 +151,16 @@
 	bootph-some-ram;
 };
 
+&iomuxc {
+	pinctrl_lpi2c3: lpi2c3grp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA                  0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL                  0x40000b9e
+		>;
+	};
+};
+
 &fec {
 	phy-reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
 	phy-reset-duration = <15>;
-- 
2.37.1

