Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F79CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E10983531;
	Thu, 11 Sep 2025 14:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="C19fnA0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF4F68331B; Thu, 11 Sep 2025 11:59:34 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7616C83314
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaAboZNIFoHoyNuyorqpLW4h0V4VTpNWlE7dVJ2jDx1hiBaTKQJntrau6u6Dqe+6cmsBJTchMomDjAAR/Iu5KqDOMZXGU+UXoKFJqFN4KbHwz8tC+ZzzNLEO8ou9o0LFzYuorqL74xlWYDRl4Z0c1amPHx8DwbeOuUUouexXtXVK6Kephr7oUWX15eJwGrGSzfhrKBlbkGcwGRis4f9BRiNZGz4/Jrv4HAbn/QycpQKTUnchROC7lgNWcfq9GQiVTYttGOpnbkWDLLRf9ekulgCrY9BAiRQONB4uRerw44vYI8YPpZacEaxv3y82zAzr9VUxvaAZtBJhIsAP5FAyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL3obXhGULtQSRrBv+NFFAsrfgQCpkQqq+VmYkCPuZ4=;
 b=Zm5B26PyA2NF5uFp9fWFjhfosC23JWtbbY5iDREFgsMbdITsCegQpcvj2LZmpI8aXvEfbLSRWtJIMxFlGnb38I0i767B2/I5gKlLiIjlgMGaFPxU67JI/MVnOgaph2mPlFZ3w6iuKJqGl1630vipZ4RzcfGnb3KBR4G26ZVq02aMsk7TABEj3MLtZZtj7mIj2USEcZsK7C3cF1QG4xKnogOfROdkbhk7Y5K69x+KFmWqvSw+Fb3VpXPDGic4rZRv41TE79OkD7jgOcqWQjiFC7an5Z0bBisjRCNpWbcbxSoIVchfKL4D3oNo4kCWJd5sdEBAonAxNaf6HWQqTyQlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL3obXhGULtQSRrBv+NFFAsrfgQCpkQqq+VmYkCPuZ4=;
 b=C19fnA0kIXwJ7EEfmcqz4f4pOiUYC02uPOITC3mEniSfY3eap+S3tWoljH5v9jWr4qzsd3djFxMgSq5D22HzQW8F2M0N6d99WC+7L6BbjVXyjee6xqSDAvgbt1oMSMIB33QTigmDfEDLH/YkUtnVrhWuTacQdz5mOij6+pr/RFjRWNDwHqxetvXGbwOMIL4z0y36AhnXbPTH2AuDb3ObUwtepARmDQuRJm5xIo16HDWkC2jgWp3HOBWOJIJ78F+MV18w+BQLAhQWws8+1lun5bIDqFaC+Pn/t7xxUnNLnjHjQmoIbtb7+AOjlDwKsvLxEmj/kx2S/62Cq4J4jpqVhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DB8PR04MB7131.eurprd04.prod.outlook.com (2603:10a6:10:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Thu, 11 Sep
 2025 09:59:29 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 09:59:29 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com, sumit.garg@linaro.org
Subject: [PATCH 8/8] imx95_evk: Enable PCI host controller on iMX95 19x19 EVK
Date: Thu, 11 Sep 2025 17:58:41 +0800
Message-Id: <20250911095841.3659022-9-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911095841.3659022-1-ye.li@nxp.com>
References: <20250911095841.3659022-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DB8PR04MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d48178-e4ba-4242-7cad-08ddf119e5be
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|52116014|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kVgJj+9bDVkyLCLPlgoeinhReqm5YFFI7j/0wZH12QXalNG1EqpvYiSKQ0si?=
 =?us-ascii?Q?PoSEZToWlc++Y6wkt9BtQVF14uffayZeuL43fmViqOiy4mMnmvvLrZmiZRV6?=
 =?us-ascii?Q?saqIFvuw3yPWBgm/Ley+nIv+VWGTbpBSdoMuD6XhF91o4wf4cYrJRpyyzC77?=
 =?us-ascii?Q?SQFg4W6sPTT0WC81If/tz6I4jAA36xNEp1a1XGSYV2SV0CLEJ3GyxoDILgSi?=
 =?us-ascii?Q?gNe2huGfmS8LiM7Oqe+MgKVV0zQVymR9CXuaPmz3RgaIB+zhAuLa+zW9qLg4?=
 =?us-ascii?Q?5BiECT6tUOHH3ed6J/AKgVxkJQnnZ6ORjVK/tug1TVczF1WlLbBZeXX/JTFC?=
 =?us-ascii?Q?XhmF8hrWts8Q5vIkHaWz8vAMMv6/JE9pIIWZZ2FsaK1qydX85tN+vFV8ZtuW?=
 =?us-ascii?Q?zRQ/boOL0vXVLHqvbqdZ/m6w/qErBJx4BwwpBxMOnEs/+HnESBa5GD51xwLB?=
 =?us-ascii?Q?W5AgFyKfweHG5GhctfhjEqTS2hiUPje0g3sEsPprmfvB5Jeepi6xbUdZfMIv?=
 =?us-ascii?Q?X+PTSNw4POL/bIIH1wXLMIiDo3PUtOorv6x74F18uw+gwerIbtH7fnAjPC6X?=
 =?us-ascii?Q?36Ff4gEcfX39P024ZY9Pr3w14pg2NqP4C/3bF+cIUp2FpsuPaZmcHsIb9KKa?=
 =?us-ascii?Q?p28v0CkoK/+PPUh9ayeTjiH06fqzX1aLQfX9zo2KNODK9+MDkqTnH6WDFh2G?=
 =?us-ascii?Q?dxkKaL1VDRAY8USdd+t24Wty+Y5d15evxRlvRiJY06i2eNhsZx+cDkhLXyT5?=
 =?us-ascii?Q?6/ZH+c7xkRki4e1gzDQVhcPKV8+F8SDjKYd44fSlDhuOCnC2bOcGJ4Ipc7Ib?=
 =?us-ascii?Q?cOVeyeM2m6OFi+pmIP188H1blu2mhffw/ZPsNdkgSdFYxnkkZ5Z/BJEKVtrG?=
 =?us-ascii?Q?j7ibYoMntkZG3QHGbFgzTqnH5xSunLSK9qfYXR6Kk6aSbkGc/PINr4gSAZ9E?=
 =?us-ascii?Q?pbIsMaSP47w4g2IC3OHngfla4XPJAVIBdDeJq9ZTXew9MiaRLQc1y+hl3gMV?=
 =?us-ascii?Q?XGD9H+CLIQg4OCC2ELq0jwOFbLuYsD1B6scpPuVw3aiGHkDfnwcbgONk6Ouz?=
 =?us-ascii?Q?IwLHR37EvrtraIIke5Ltzvoz+5v1TcQVETCCej5gqSJ/SONLNraSIqde2EXc?=
 =?us-ascii?Q?Dhy6fDz1xQOi+AhVSSASM+fJmRBgR/vxFmoIqb79udJjt/Z+WkcdiOT4qRsL?=
 =?us-ascii?Q?RNMWIXr/H3ga5s1XhSXuT9z2/Cb8Sq6yexRCgt72PWcq8oPWfH75iZ/jQlpW?=
 =?us-ascii?Q?vE2ylpLEcBSd/7AcCSbkWxjTuMDg9YQJFFwte4HTZ5BUuD7E9h+1nSRfSq3k?=
 =?us-ascii?Q?OjyGql7i+VsNHEyTyLovUElhzFWB+4W67Xwdddu3R6aJiab1uaVWp+lZ2Lc5?=
 =?us-ascii?Q?mWQ5ITLvjpsN43GsDS1xBgNm59tie4SDz4RJTNYlpRib9bm/6kZyv90zh5iB?=
 =?us-ascii?Q?Ae+w24SPG/3ZhbOp0N7ubiSSh5Quv8/jSxSVcQjgWzzfisYRQPbY4cxcA7pH?=
 =?us-ascii?Q?kmqEUt6Be3IrL3A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B5JHSLZwBbE6oD6f/A2zoTotSpwJ9NQUNGunfZG9zDtQtX4L37JPAeAAZTXE?=
 =?us-ascii?Q?LW4RavCzcveHJInbjnQwVZEkgCCDpxh2IhDWVTjFeykhxer0+d7Vez8dd8YR?=
 =?us-ascii?Q?VQDXMYfxCsc2tBHrq49345nrHih48bJxJc0JSEh3a4NFomnGhtajO7CQOh2a?=
 =?us-ascii?Q?R6bLTgJH9GHPu7sZ0QWZgjRDAyuASmWLD0ZGeVuzrkSH8cJ6lUmJKWTm97JK?=
 =?us-ascii?Q?ZPNZs58vyVD7wYSlrYYNVT6QrRjKOgAeSCtF3ySNJeRfjP4RtVq6WVkUrV6g?=
 =?us-ascii?Q?s+5tbhhpYzZvjAsy9FNY8PIcA6pvQnLHFjfUdRSeZV23JW1ub4MfTyR0YXRV?=
 =?us-ascii?Q?JGmMhenCPY2byba/dK0rcloIDLlHlhS4731zB2aibRg7/QRozQ1an3Vm/+fv?=
 =?us-ascii?Q?Lqp0xN3mTjNTqd0asbL3HJ1CKszylLeIUArVdqpGeADqNLM8hcTLgPkJmtx1?=
 =?us-ascii?Q?ilP9YW+JCpvUrRoFKxmj8KnLVer5qNqSezFvXtaAo0zVveh5/q7ebbnoGN65?=
 =?us-ascii?Q?m1e/ZtkUz3vui3H0KnlgL35yfmmvchCz6AgDeddgo0vLQRg3YXrN15iLQ8+l?=
 =?us-ascii?Q?1iVFItn4d+W4FR7YXxBbH3EJ9nTMVzMm0gwipiKmwQjEtq4w1g3uLQ6R72Us?=
 =?us-ascii?Q?ARsEI50uzMcvZ98kyt3CjsjpEDsKniSGLR7X8TMAMvCXUQ64E9UV5zij0Cdf?=
 =?us-ascii?Q?lY6eWcGRKy6oVVThvUjOSRoV28XOeaLWega9Digzu6DObdibjabogNXwOHFm?=
 =?us-ascii?Q?FfUCStUqid9X1MfJxjIgR1kGf5Kr47lcr4+AoVZwZQaCYiNyEKZNFPm5n2Re?=
 =?us-ascii?Q?DIicw/GCpgjoiZXAEB0A/FmKlAhaX5sjanWhBO1sUrpjomOi1ZFs+NIER/sw?=
 =?us-ascii?Q?dhWFiEJI8Rqz7AI9W6C1yKHRSNPgygXWycODGUrorxR9loXxGNl87tsSXChC?=
 =?us-ascii?Q?2pawKkuXQUawaquwuMe/DMBrQjEbs0/JyJbZVbd/vsAJGNaqRAU8Oq2eSIF/?=
 =?us-ascii?Q?x+w3afyh1vIKiJpiXcHLSxl6fTFRWSGMALZ4Gg/higIraApO+AkRBRQxcJI5?=
 =?us-ascii?Q?bOVbEoXZlo7qL1q+Nu9+okCJDbp/mnxWJx/EODFhoozy7g0w+WNBz187gjmd?=
 =?us-ascii?Q?uH10cg/JBjO0qF7cDrKLKzUCvBo6snYao7AZvooK+hPhxVCpu0iQmKjHoDCE?=
 =?us-ascii?Q?5QIV54HLDc9fbkDUJVrI5BqWShpOK801PqQ0PrSfzxTcC1KHCiWdBI63yEAJ?=
 =?us-ascii?Q?QHmQgGb0I30Tz1vyPCRmARg9ox4TEtcga1jhC53hP7PggjHWAa+7x2n40JZC?=
 =?us-ascii?Q?+B4/XTt3AQ4kClLPirHGXPObf+YaM806qLui3T8sXo/If9sqBlKnbl32pAOo?=
 =?us-ascii?Q?FlU4dEWugCAFZWjE2yROcVIw7bckZm8yWzoetQId/9fTqk8fjlZwILxQb5SV?=
 =?us-ascii?Q?4az0vBXcK/erzkmqA6Cd2Tta+NEwBhZTGhpjO4jsVCTR5HAYBsIVF+TJ5/Ji?=
 =?us-ascii?Q?sscVggBMOpTEzLYv1uzvDx9pFuyazL9EqRXxRtEBW8w0L7yhZlA+DhJ9OG81?=
 =?us-ascii?Q?Z1iXbv1GKwJXpSvgrVI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d48178-e4ba-4242-7cad-08ddf119e5be
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:59:29.2148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vu8QS6hSys2gWVAaIpGLXusiUhab2I1Fd10+e5yxPeDlTF/W+JzeEh0O8+qziyix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7131
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Enable DW IMX PCI driver and iMX95 BLKCTRL clock driver in defconfig,
so PCI controller can work.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 configs/imx95_19x19_evk_defconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
index 73818a826273..f0a31dbda7ba 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -94,15 +94,12 @@ CONFIG_ETHPRIME="eth0"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_SPL_DM=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_SPL_CLK_CCF=y
-CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_SPL_CLK_SCMI=y
+CONFIG_CLK_IMX95_BLKCTRL=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SPL_FIRMWARE=y
@@ -130,13 +127,13 @@ CONFIG_DM_MDIO=y
 CONFIG_MII=y
 CONFIG_FSL_ENETC=y
 CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCIE_DW_IMX=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX_SCMI=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SCMI_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
-- 
2.7.4

