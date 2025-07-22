Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A7FC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 09:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A193839F1;
	Fri,  1 Aug 2025 11:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OsvtH64t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F41839FB; Fri,  1 Aug 2025 11:52:47 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F0A83946
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 11:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbP2ojUiXNB4DEPZCRoOSQ9fqjYYD27WzOO0bBvrDp47pHiWOJ5Yz0blWHke8AuWs+lE6q7NKfUJfiBEIfVxcEd/cSTaT5wvAi7Xn5tZ01F1RghBI5Mu2x5zbkCcpBKIkyTUF9vS1tJFcJN3phHD+uyrbSyKLK3Rul2T7qGN/tTojtCAWr+saZm+gnblp07fKtXJEHCGrWMjacXTgMmKbwGJ3AMBvQ033Fw2HRhP41p7ZQvJsK/pMVrvCxI88Gpk2gH779wbXJUyj68MSqWs4nPSJTqvqu3bO8jD2QvOwW8LbKzIEJHql9rT1ZSGnokYFJ+WuZSfPVxrlRmJ+7cG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amW1SHaKR/GUqbXrWJqKd2H6IC2ugjMsAyUzak/tBYM=;
 b=HxWm8Wa3dqmkpBKZZYJlgKinBIXMaECDSQqhyQ+vWtXCFfafjGom6lnmR51zSzxlRSwR5ykS7EmQkzXobVDEf7G4+ucCDqhkuUZApXNs4HYbaDxph8XJ3eNTW+0N0xcCJRDA+yzvMIHXsRwT+OklOkQwP6beoErmAYIBzcWJ6G/JM+zhjB3X5yVsiazAL+KQICOgccMBI2OHZlxpujUYubqVjdRbZ54ZZhcLRfiuIIeVQBNDhbETIrkN46SeXflaH85x42WOMsxr46vjG601NE0gQB3vNwPRhgLFAZxZkFxglMU1YrXo4oH1fK2MaB7FmeRKx4xNj397HrDQPFYQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amW1SHaKR/GUqbXrWJqKd2H6IC2ugjMsAyUzak/tBYM=;
 b=OsvtH64txDlxODjkwmWBJ5juHVc58zViM6al6fOcM9Lhmye5J/yZNSCQGEjKNWPKv/xhgYPEme/4SUBCnqbaNJR68VGBdCWZJeiDh/URKaPcAleThclF1rz4n+D7n2s1pBYYy+MYvXEF3aAbWCVShrtt41tga5xtN8zdtnHpMj0/FBB0KOsst82oEiFbJCTyar4fB75kLZaqeX8ev32lAjYMEPXwgQFpd7gcYq2hMwv6xexuVctt9l3o3tFgjYbmWgdIFsE5xMzr9eeWtJ3dSRQmpyb/LZ7pgEYeispIz61Z3FIcKtLobXYPwkh4aDaPNDDKByO199eL1UsDZEqlWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10103.eurprd04.prod.outlook.com (2603:10a6:800:24c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 09:52:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 09:52:41 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: tharvey@gateworks.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com, ye.li@nxp.com,
 alice.guo@nxp.com, sumit.garg@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, aford173@gmail.com, sjg@chromium.org,
 Zhiqiang.Hou@nxp.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] imx95_evk: Restore support for i.MX95 A0 silicon
Date: Wed, 23 Jul 2025 04:47:09 +0800
Message-ID: <20250722204709.2075421-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10103:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea0d3d1-14df-4098-5308-08ddd0e12786
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|921020|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tuvZykcqrxA+4rO/q289Uq77LliZivkx9Mj1sPiNeyuw+XcEu8yfxUUdYkqA?=
 =?us-ascii?Q?Uu/tu0qQNy3bMZOw+mrfCDksQPVVhEb2wRF5Nqc0eK96R215f6XmOpy6ugo6?=
 =?us-ascii?Q?avHeyzmeiKjMLv3XM4rpZ2t4aaYZlEm2U9M5aFEvpozm+KaUFxIGVqi/acPw?=
 =?us-ascii?Q?RZ4OI+KnYabPsvKmLNOq7Lms9+HwHQG1aMjLN2JqH42m6baIKx+zt8xYeuwh?=
 =?us-ascii?Q?W0lH2ffUGF9QVte7P+dC18EVqUH5gkViuIvYK6ImlrHb/0kspq0c61IpKXsQ?=
 =?us-ascii?Q?HNHB5CWBrMccFkHrvBkQHFtHjFocQJvtMnhNyBfd4ebYCLKNFvlniEdPnefc?=
 =?us-ascii?Q?eEGE5TWW+1/gbjQ8isrzwjMUmmbFIobdGOYdI+i8L9Zk8cnCcoyXsob7sJuF?=
 =?us-ascii?Q?BzbuJo4X67toHZdvylwqzCAnVp/Q4N4e79xOfwgjO/DeryfAt1IICTwrNITu?=
 =?us-ascii?Q?HLKCGzSd2aIlNcGzMMCIBCIP5G3NZXhaxqKZSvGo9u1Kp4AmWXHm41sdBQED?=
 =?us-ascii?Q?TrlxMz92e44p9BP3+AVOhDTrIkDtE5vq9rwOROesj0b9CZGTrKs2ABKdeJG0?=
 =?us-ascii?Q?eq2qpmOSPWkvgo6CW9OMJ2GMJMqqUEIh9XreUNaozzebeTLj99kujRiorMXB?=
 =?us-ascii?Q?y8TCL0X7whMvkuWMVK9caZQynW2i36PtZm9KgiaQmh5jr5YE3W85lA8pWE6i?=
 =?us-ascii?Q?CG4FnzCNGnQuUOMsH3swWesQ/eUjxFz19ly+adUEr/bNNxdvWHoFWup0q+Kh?=
 =?us-ascii?Q?JEtZbQSwL1GAzdU4bjtrDQUmQWP+5tCG9LMQBBoA8RynuntgB/KbQ9iYGV93?=
 =?us-ascii?Q?1+xGeihpSFxf7eKO9BdRASpN76A/mFyPhilWkLtscvD6mktmDLWDq+LgPjVp?=
 =?us-ascii?Q?R1La6AfanZ2pmyLpnPrZdBTjBPyK2nsPxzgh0u4BK2YfItlX0sMm6vobqga8?=
 =?us-ascii?Q?58zniIaFTnwNFD7/HjxXJ0LLHgklqYyJwVvJS5MiIw+QB39JcJ3z2gIwAunA?=
 =?us-ascii?Q?phuaoRhLMFyrYp4ASycVmZfcKmOkNThecUg5qoqdeu7kt23JYNlE6HfID6U3?=
 =?us-ascii?Q?9byOLtehkmiQv/gF6nevQCg0stzQU40yproi0hq6Wqq2f0ZVkWHydNIO4A2X?=
 =?us-ascii?Q?V9SFuOcRtyVzBbG3yav/XHUEkRn12F61rLBcjedTEZGOghNmz41UrHDndte+?=
 =?us-ascii?Q?7SB9JbzBinI+P3ffEClisSVcXTU7hwzsB5fT4DhRnNgj7HnFRgyISfCyoyVL?=
 =?us-ascii?Q?jLZS7188XVzTrPIkLHBnAcICmCD7Gko6dfL0+fM8HsXUggmksMXMMa0Pfx8I?=
 =?us-ascii?Q?rFAAXFL5k7eiqA8CG5DVse+F1/qsJczgU010miLP5salfMjPg5NNuicHYKNq?=
 =?us-ascii?Q?8I6kqpJiMwbf0QsmtCqyvdnaJUQV77PYlkt2FksG1vTt0g9gqvTsAQQeNa/y?=
 =?us-ascii?Q?yCKw2GiN4fsE3OwBruHrU380PC1NkOxjMYsiVBn/a+sk+Uk62IJaEvW6V7/Q?=
 =?us-ascii?Q?H8JK8HdSRJib3ntVoCX8mjZqjP2HAJ0tEgNj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(921020)(38350700014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+JaM8t8JiovmH1FCPQP8HID6faezhGcFFIQ5GNY/hK64R/4qT34bkiqENU0F?=
 =?us-ascii?Q?XytPjha6BRNjZk0dQoNB+BGGbc+tcnmOW67assvIherscXLG1FEJA0mJKfMJ?=
 =?us-ascii?Q?laDvUSX2sYdTbomYML2Lts2Xn6Gr9qELO3zvwZK1o6shwgYHX9ykbb6rHGdF?=
 =?us-ascii?Q?b8eHRYfraRV9WVsE5/3apvYUmBR62l8Eak4pP4Pb6m945CCqet0CNAUzwOFX?=
 =?us-ascii?Q?ly8tRmlNcQTM1hOpJFWr+FoNhbOq5yCxUqE84BjzM7YY/6pjSsZsGiCbZNuA?=
 =?us-ascii?Q?9lpVsxoHoDDZ1z+lkLbKVsVW3hk/CCVnKW05KJj6fS6/dgd3uL2lx3dtoN3E?=
 =?us-ascii?Q?oDKmwmi+SpF3TVLTqwjgY4YWOtmV9VLpaZz+fTaoB9zC1RIg+9SUpl9yqdvB?=
 =?us-ascii?Q?bCPlIacybsVfpYRmAsWojgBSvigkHWLJlqjuRqpLiUMOQSVzNgi+04Ui6bUs?=
 =?us-ascii?Q?CFZDdPSya3x9X2SmxNqA3T8BBNO98KRQLVUYxL7x7wepxxX0ZgV6giAvgXIp?=
 =?us-ascii?Q?y9Dkn8dTv9zaw3woKUGcIPQrit6VsBqXnHa+Y/9zHs9mVvzOhsIURv8eG441?=
 =?us-ascii?Q?WyiOF8ZG2a9XTkaaSlRGShFN43KYcZDuuLcI0s/VlJ7FSrnECpiDwGCPb0mI?=
 =?us-ascii?Q?xBwkELLdr5+3p31RZfH7LebVJfjRx1B8gDIO/Lrncez/mnE4s7KGypzaExtI?=
 =?us-ascii?Q?gTXS/Kf8VCBhRuCOLvgmPdh0Cy/AjFhl7UGQbZCb6H7tdoGubdxsYjdxM8mB?=
 =?us-ascii?Q?ENvc4ipsGY9wwm8PBETV6YlEUt+5yXm5orMCESo5Idri0xsmyBKiKL/tZ7Sf?=
 =?us-ascii?Q?mlneXXUF7Qa+mD+Dkj6amQC00P3rp7PEsrrWahSAI2PDyZ9v4j4uOOMRrz1x?=
 =?us-ascii?Q?ZQMIzVJruYdgsxBc9Wc26/gqpgnHptFSTE2L2v+U4WgjJYIY5KcxsS14Fadl?=
 =?us-ascii?Q?T6EQ9mS5EJrLUbN0c1Lpsi4fpjCD7nlED+IAYXz5MI2k4snVBz8wtOyDCBLM?=
 =?us-ascii?Q?0kbgcAbV2Oia0oi+FnL30OfkrvvdCvNHeR4M9eNrgy31hhj6eEfV+0T47sGX?=
 =?us-ascii?Q?H/RGFAWy0LRU3kHNb7T9RbtOBhkeDHAGPelE5bK2C4Nknr9QsI5SXxPWZz99?=
 =?us-ascii?Q?29SOAJzAF237Rry0y/VAxtGxLdns5HNjjXZ3DQrnCgBXzIb7ZyTdQp4Ehb76?=
 =?us-ascii?Q?MZ/meOq5Q7r8/TCIVyX0+5cDRC52S4iAVTPEf8pPChJQ1LKmv7QfsPO6N5XN?=
 =?us-ascii?Q?r1fA5juF36UdCknTC4KYMlikUsX02HWZgYbYpOsgkmc/C1NL0s0wkOjx3Crc?=
 =?us-ascii?Q?ZT+7ICHSQU53CIWpGZzya9xTBT/1kpM8FIFaByergOuEFH5nauO6cSF03GQ8?=
 =?us-ascii?Q?YtHFjd3SR30eWH5e28Fn6E8uveS+nzoWtPTZHa1Meoi7UF6Q0ak0cPkmYmLh?=
 =?us-ascii?Q?kDkva06c46+wg/GpRMMtCBbkloelvEFL986K+mPPIvjMOt91X0r5cv7QSRAr?=
 =?us-ascii?Q?gvWqtcH7kPqM2nEzFLPjxFZORL9ZyyK9kcd5ueFmT4JoctpuaQUZSRzMC429?=
 =?us-ascii?Q?20Dcisif2Q+P8ltcvRRlwubAaliVML9ZCZfY/Dvu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea0d3d1-14df-4098-5308-08ddd0e12786
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 09:52:41.0406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ho2kDN7+3DULeTOklKmIk7+wOOn6omKZmAxAIkx6bf1uuUC8foNtu9eYpny5n0qiH1uCpxxXNJxAZbwMY7B8xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10103
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

From: Alice Guo <alice.guo@nxp.com>

This patch is used to restore support for i.MX95 A0 silicon. The usage
is updated in imx95_evk.rst.

Fixes: 9936724aa9b ("imx95_evk: Add i.MX95 B0 support")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig            |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg |   2 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  11 ++
 configs/imx95_a0_19x19_evk_defconfig      | 153 ++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst               |  41 +++++-
 5 files changed, 207 insertions(+), 5 deletions(-)
 create mode 100644 configs/imx95_a0_19x19_evk_defconfig

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 4e0e194690b..a306203b111 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -25,6 +25,9 @@ config IMX91
 	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95_A0
+	bool "Choice i.MX95 A0"
+
 config IMX95
 	bool
 	select ARCH_MISC_INIT
@@ -33,7 +36,7 @@ config IMX95
 	select DM_MAILBOX
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
-	select IMX_PQC_SUPPORT
+	select IMX_PQC_SUPPORT if !IMX95_A0
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
index b25f3b726c5..bc10cdb227b 100644
--- a/arch/arm/mach-imx/imx9/scmi/container.cfg
+++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
@@ -3,7 +3,9 @@
  * Copyright 2025 NXP
  */
 
+#ifndef CONFIG_IMX95_A0
 CNTR_VERSION 2
+#endif
 BOOT_FROM SD
 SOC_TYPE IMX9
 CONTAINER
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
index c2c92174c1c..e183595b7b3 100644
--- a/arch/arm/mach-imx/imx9/scmi/imximage.cfg
+++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
@@ -3,14 +3,25 @@
  * Copyright 2025 NXP
  */
 
+#ifndef CONFIG_IMX95_A0
 CNTR_VERSION 2
+#endif
 BOOT_FROM SD
 SOC_TYPE IMX9
+#ifdef CONFIG_IMX95_A0
+APPEND mx95a0-ahab-container.img
+#else
 APPEND mx95b0-ahab-container.img
+#endif
 CONTAINER
+#ifndef CONFIG_IMX95_A0
 DUMMY_DDR
+#endif
 IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
 HOLD 0x10000
+#ifdef CONFIG_IMX95_A0
+IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
+#endif
 IMAGE M33 m33_image.bin 0x1ffc0000
 IMAGE A55 spl/u-boot-spl.bin 0x20480000
 DUMMY_V2X 0x8b000000
diff --git a/configs/imx95_a0_19x19_evk_defconfig b/configs/imx95_a0_19x19_evk_defconfig
new file mode 100644
index 00000000000..e3b17152b50
--- /dev/null
+++ b/configs/imx95_a0_19x19_evk_defconfig
@@ -0,0 +1,153 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_IMX95_A0=y
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index 27cd15eb7c9..bc08af198b8 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -21,6 +21,16 @@ Get ahab-container.img
 
 Note: srctree is U-Boot source directory
 
+i.MX95 A0:
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
+   $ sh firmware-ele-imx-1.3.0-17945fc.bin --auto-accept
+   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctree)
+
+i.MX95 B0:
+
 .. code-block:: bash
 
    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
@@ -53,12 +63,24 @@ branch: master
    $ export TOOLS=$PWD
    $ git clone -b master https://github.com/nxp-imx/imx-oei.git
    $ cd imx-oei
-   $ make board=mx95lp5 oei=ddr DEBUG=1
+
+i.MX95 A0:
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=A0 DDR_CONFIG=XIMX95LPD5EVK19_6400mbps_train_timing_a1
    $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
 
-   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ make board=mx95lp5 oei=tcm DEBUG=1 r=A0
    $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
 
+i.MX95 B0:
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=B0
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
 Get and Build System Manager Image
 --------------------------------------
 
@@ -82,13 +104,14 @@ Get and Build the ARM Trusted Firmware
 
 Note: srctree is U-Boot source directory
 Get ATF from: https://github.com/nxp-imx/imx-atf/
-branch: lf_v2.10
+branch: lf_v2.12
 
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-
    $ unset LDFLAGS
-   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
+   $ unset AS
+   $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
    $ cd imx-atf
    $ make PLAT=imx95 bl31
    $ cp build/imx95/release/bl31.bin $(srctree)
@@ -96,6 +119,16 @@ branch: lf_v2.10
 Build the Bootloader Image
 --------------------------
 
+i.MX95 A0:
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_a_19x19_evk_defconfig
+   $ make
+
+i.MX95 B0:
+
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-
-- 
2.43.0

