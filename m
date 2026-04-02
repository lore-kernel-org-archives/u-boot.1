Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B41D39404
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 09:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B095C8419A;
	Thu,  2 Apr 2026 11:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J6H6fOGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7D3840BE; Thu,  2 Apr 2026 11:29:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1940383D8A
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 11:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWNP3l+VkFhAdViHfL0MLI2zkK1KM9bFbjEZv+cTChAA9YXb0vDaFsdIZTveFVd080WTNThFebCInIErnbtQwq68JD7tsvxlpEARJ1I8ojlQFh4gPLcSajA80ML8woii4wUdB6kBgj3J3BUpnD7DuCmhg7/ToeKzIuNoZuYMRt0trU/1F0q6UGy3C+SsathvXcSvBuLvCblfHmcD+zJhtVPlsnK532hsuCGWARBFWplY1xO++tZHX54QdclwPmBhBYxW2ZOe1PRN5vkfZBlaFU7The1g9gdA3G1sd2+X0FMjk+0jky6r54S9TBtfvfKwTT9JxTuqomBAag8HVhOovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6rzow2IZgXsnrz+oQcZmF3wY/SJFiyCs1SaT0AfMtA=;
 b=kUP+s4MMKvvWLK3USarOvS9r60U0uZ4UcKvbOFgIsGlfoMYtFSp7VIZKu1EaLvfUGeF+Mt0Izus5cAA+xCr91rHQpOxpj3cMHq0a51u9FoNa6IXzuIS9g2EdvcoukKsGQM9tItGKk8WEWzfhrv/7JQYw8zn8yRlz0hdds/qsj5stQRGsbM+YmDZYDvRItkRyCWf+4i36wMoRIv4oOmhAxB//wunQREkvaBzj1Y5YH2QIgAa1MySWtrosGYTBdlI0w3+xGIzbwGFB+HCEOHbgsNZ2K0rnI8VnGRUw+1utWvX3m/w1ha9XC6Cayt4FCoJToFeeTORtAxCgAUzannYnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6rzow2IZgXsnrz+oQcZmF3wY/SJFiyCs1SaT0AfMtA=;
 b=J6H6fOGq3fe4c2NwfW7ax9Lkh0eD634In1jfL6sNRqyI4bHg8Ru5hvPzBFtf/31UTy3HzWLP7otqVOosk1Y6mnXB5RTfQRebnlH3sXDRT7lbivU5VaknqzB3r9VPd9gGLNcE2T07EmDwQZhcLJwWdjvcj7zHoxM8WAj7+ZRaBejhNR2Lnn5QbzDin+yhKOxezNMvolUss6zDlCvjR1Gx/X+NTpzV0K8Y5cII7AF5NU6kDW04lAXGoyE++nJ1jbxT3ygIEd20o5jo/sWH2dSMJo1cE6FGYK1rJVHGRpCvzP+ZWXKeo+YI+uwDEDcTDOYI4REIICb9TpYecKZAm2XkrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 09:29:33 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:29:32 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com,
 ye.li@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
Subject: [PATCH v3 3/6] configs: imx9{43, 5}: Enable SPI SFDP support
Date: Thu,  2 Apr 2026 12:40:45 +0300
Message-ID: <a711f4dd7adfcb7f08fd679c85ca42a93e39bb04.1775121078.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775121078.git.simona.toaca@nxp.com>
References: <cover.1775121078.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a936c6-8eae-4667-2512-08de909a58fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Pviy3vB9D7tldQUaZ0Q4X7BTYJ92kdopV1+/3Y2NQduamGC1PVqJUpcbXTXFVkD0jmxS/nn/qfBr0/b7vgLWeuhmTRkkzZvmNM5HQLHwbXZ5XvKTbvcNL9l0iM77WjDQiSTxTNyE7ZVcDIe1C3eegsBI3eJIzybN4PWAhYYHOkCTWZ7rJjMHSELntJZiYReE1/MThl/bhMxSq7lPa8esAIZuTgbm8Etj79Vr5T8LqP1mkADqulOMvfia/s6IMjYOdeWhQ1L7lLxodZrqLSlcIxhyX1MpZ3R5QartJYLgaJtbdaffwVrFuBlyy5VEjgF/ffblrfkWQbkwSB7eDDUTz3NHCn2YGYFj6NCy9HQ9Hj0YIcgzzJjOO02urFAPls4pmha7M+SMHEU1vdlv3V0w96hQguiMe8SMPSAZTclKHR6m2ilET5NZrkZHWJOH3yPHDeZQ87dHrbfo5LOI1VUAYYI8Nu7S2VbS4I5X3fB3AQvha9QHmZz1pP7vFg2E213uknm8EWF4+JvEcIOkxBuwYoS27EMI6AAOd2Usk7K4IHGZ9b2AcFvm0of37k7eHjmdYyonS14UXJ8qIHBkgtYoLxPEo88RE8jdqh2z+u8WyS2rF62/yyXrPrxBZjHlg8WEgqReCdK9AvyWUmS2Y+B9KIjxSEgIiaICbDODbtWCTvawBVQp3aXjIk714/fQ+Xlmf0lGPqN7HG07Kp/Pfjbmx0/L9Aqz1sy+MQGCrv7m5+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5EquIdRG0j+HmZnhoZ8uOq+uKvTpwD0p4jBRHgheSVDhH0M2U6dQgbbfd9pY?=
 =?us-ascii?Q?kNcaGPO3eC2vtNllAeVyqp0Io4ZHTVC683XckYLar1Sk21xj4jV4LguJpQSj?=
 =?us-ascii?Q?uUKWVG/QXDntvrPSqgqvpmUwo/aLGaxuTwC8gF0HtmJnBlQBiA2gD8J9lWFJ?=
 =?us-ascii?Q?tQ6kieonBMkaT3e+iTW2Rcwp9J5vhHTeq5fQTPP1QshaCQL76GLOJ9yQayVm?=
 =?us-ascii?Q?mJQwEDOMaS2kibtivih2YnCFDXzQWy5JyhNCz8LtXKbHDImiHigWxyynJj28?=
 =?us-ascii?Q?kz2jKcVmziP4msL9CppI2hUGwtVSLuKNR4RNN8MUXtlJKmaggdtNbXf7ew+1?=
 =?us-ascii?Q?kAJCwiZVgEJGhar5hn4gtKPM4PpLeQEj40ePRAUEa+qBz/s1xU9CTdphp5Ln?=
 =?us-ascii?Q?uUxjCYEC7QhYVNXndOLaqkbDAc/gMM+LTm6HybdRX5hcH+rmWfWbUC9uCsJz?=
 =?us-ascii?Q?6Nqkggo8N5a/AKOGVLtpxNXE8+QQK8hJfR5rMEcJ/V570ewxryeRIZkdT6pr?=
 =?us-ascii?Q?rjQ7BGJo9myaCnXBCYwnM5hDK0z8kjw/2pw9qI+2lh6LWKySjF6pRQVghFtB?=
 =?us-ascii?Q?tXwiv1ylhugZubzOXVHMuIyVw9pYX0syuBXH4zdAkbKm3IrVZW1yvAfgXRJO?=
 =?us-ascii?Q?4pktD5s1wlEG6AOqHB+lUictFXxy9kIZCCONvnBFVYSpCa9Ghbn9F7P3WaEk?=
 =?us-ascii?Q?eVl9OwyuEHUEAjRyOtSdLsussczGj6FETGYysV8oBV84bBIcbOBNyiecaMKA?=
 =?us-ascii?Q?kQ2JXI6vXcrS0X6JncuOW6mctom+svttF6vGMvNyICqZ0CjqH5yRu8AQFWNo?=
 =?us-ascii?Q?eQr4/lsNamJJAJ+qE1ELBamZ2fuE9w2VIag1OyeIyIzWw4KrKeUdNCrg+KZQ?=
 =?us-ascii?Q?Jy6Cym3ozs/fUFyiMxu3f7vEOAB0xvvoYBl6gteTZihFzRE36E1TIT85JkCr?=
 =?us-ascii?Q?tY2LjLXaQ6XVfkfxn1RR759txfpSZ7d8A8UtbZcms24rwcwKIBTaesvDOuZR?=
 =?us-ascii?Q?R/TaWdB9PYyD5/iMR3PCTA+2f/p8oyeKqUK38gVJIXA3BleYM0vqC443Vgzw?=
 =?us-ascii?Q?jWQcRN9JYeKrghN8Am/iT1htEyJhfRfSNJ7eUKqJOV+X63zGY7krDWy1atLA?=
 =?us-ascii?Q?6S1r2m/Zg4Q9er7QFP5IbXdRWsOv9IyCxfA0FL1HbwK0iAYEJIDGZqko8CNo?=
 =?us-ascii?Q?wUTCvcR0EYYc3vQcSbpkxuwByiF4Sv0+StiGAGGtseZw8UdcCX0D+1aq0bcY?=
 =?us-ascii?Q?lhP9GE71zSdqKlPbihANwdr8P5DcxJ+pKRxwIeHM9DTJS8bFL8ujKyBJK7VL?=
 =?us-ascii?Q?DEk90OytevrN1lk7FDe1epypNP8eOY8pfVXk+EGO/izWzMSnVIMdfhw4Mmmk?=
 =?us-ascii?Q?D3ATcFbmAXw2rnzCqd8UzqmdY/MevwDx5dLuRQRMNPVQslheeuUSUDYxIeX5?=
 =?us-ascii?Q?EX+WivQe71+hlqHjIS3qFoWa61D7oneEgd8JAyF8stvsGQ8lNRwWwBc/6WY2?=
 =?us-ascii?Q?PPFh1ZROmIPTdwGjLyNvwxAkr8foBVDI7KgQLgGXoQ1E2/DICU57KI0h8Fzu?=
 =?us-ascii?Q?+k7xuBrE2764lP49a/DlK1xQP6smE+1sf2aJdIYQctUyRO1b4lzs9WdtR/mP?=
 =?us-ascii?Q?7rZBMXY38i6/It9kLsA8teJ0MYCZLW8yBG9udOkIl/4DaPBEYOlTHrlpg6IK?=
 =?us-ascii?Q?gvMaHWKo8qDqyyJaent7nmfK8PprTudBBTP1hbcQagvn8lnaz75Epsbz+XbK?=
 =?us-ascii?Q?g0hENtT0+A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a936c6-8eae-4667-2512-08de909a58fc
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:29:32.8189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JjsxS1pRIqI0iNSK+Ef6esWKXI/3YtQaFEQ4bfq4ZtV8T52l2/qM1WdGJ/y9/q9vvK6+GveSgaXwmfjAGFYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095
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

From: Simona Toaca <simona.toaca@nxp.com>

In the context of saving Quickboot data to SPI
NOR, this option needs to be enabled so that the
erase size is parsed correctly.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 configs/imx943_evk_defconfig      | 1 +
 configs/imx95_15x15_evk_defconfig | 1 +
 configs/imx95_evk.config          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 6acb49e47e2..624ee9b73d1 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -109,6 +109,7 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
index 38a855417d0..97eebe83639 100644
--- a/configs/imx95_15x15_evk_defconfig
+++ b/configs/imx95_15x15_evk_defconfig
@@ -120,6 +120,7 @@ CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_AQUANTIA=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 3db583cce59..0388d999cfa 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -121,6 +121,7 @@ CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_PHYLIB=y
-- 
2.43.0

