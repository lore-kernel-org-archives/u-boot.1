Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F5AF8FA6D
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 877A0805D7;
	Tue, 21 Apr 2026 14:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NjMIKqiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99B7842E6; Tue, 21 Apr 2026 14:25:48 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7C4805D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGjrEiWXPP8ofKV2waiRnfWlOjKh40kEzSHfktEPYfBwJE/zXvNRnE8G2biTOGV00eYnC4gsqv2G4rLk2fgtNb7R+KpNy5Ijj/H7nNu8iU1Q79ltCMazsGYjf/V3RBABCXniskobOhtlBLGu/y4dXfU7jkemd8Fs6MXAOGDiUSLDSNCMsDb47cDT+aVkbzOXlhgJcs1zstvs3GoT7TehhCRwdJQBVYucn7z75nQ9NXQ3M0X/EOgk/43WozYDAqxvtNFtCN55vkTlwzB+4RQUORmJtV4xKbfsGSHYmNkf79ysr5mKiLULfPAa8ZG/mT3zkCn2fqtelzYLxhj1S/3GGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY2h1dDGTZWbLgmqCXnFxnA1jzyqyAcglXuNrOybRK4=;
 b=gGeKBDruQLQuz4lLDoP1+4z4j0t48skLH/682QUNoINMyLsYBIaEXxvSaQckRIyiIxkVi0O7O1r0xXx0w5iNaXkIuZYI1Ls8IXdrrbPLg8EarhSYgRIkFBbj+2OHDoliWwZBigsDo12h2EZJ29jP6Gi1ik5Hehl9q1LIK0pdmFp9OAnF8FfTIMS2XfzVPPgEWdhbiWReFLlzCeZk4OnGS//pBitmacVNO3LkJx5ykYmZEQy8qbS4QJwVO9ndqJj4Ie352anCFxtYOKqZHS7bBeRElMK+FqDoXfJH8OPKOCHNc1gLr/QKK9jT/BFiSbpahUIzVRa2RzIBObvepMiOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY2h1dDGTZWbLgmqCXnFxnA1jzyqyAcglXuNrOybRK4=;
 b=NjMIKqiY+x8KrRGlDFjXhNaFhJIeJ8cNdirJci7/mA9mgiw7gkDN0BFW+9IpwNGGUaBPmIdJE3V5TpWcZgj9XOhSketq6F1Y5RVOs4tmLA3tJ9xegtLkcgRviWjoQ6Y2Xhmteb99PkTGWpdOgjMuCtrQWRyl2Kvui2OLJfkSVRNr6/GpFHEJ8PB7bjTblR98B3FigLPq//x7q9p1gkMkcnQ/LS5Hl4P2bCMQ77sE5rRWjO6LnihUHngcKa82dW/aGvsoo6VWcXo6nmhXaj/ov7zLrJpR3bXBysUkWJ2XTfH+sC316lIIyySi1Dtj/iF4+ZuEg+ELxihz/zSSAbwjPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 12:25:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:25:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:20 +0800
Subject: [PATCH 08/15] mx6: sabreauto/sd: Exclude power_init_board from SPL
 build
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-8-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7a8369-0898-4567-6074-08de9fa11c16
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AXdrrQfp/lDXppMPrFKfZbDRzaKXxr7wX97NrwNLsrI+YVJWYRI0WMrnB0AJKM7szF/JZv8wesV3n25kHZwFvk/I9loGQrGxlbJ22hUhqGsTkyoRrX4WmHYj265IXS1jmYmlFRwwwPSKuLv3WdU1VhTXGNgZkv/jtXLK7VO9gKuDsjoW4osE6jmc8WwE122+bpRCI6JP9qMFMi1rrfQgDe1b0JxaAUaLYBP0o4heleWBZwY32Xa3TIrXAkF5KaLFKVf8TfmM850E/Y/Xy9qAGU/DIaM/bhjVaweZdytvFLV3vjGVV7B5hIUyGlO+AtVbu/Wu3ELbAMeaUhDJXNJFVxnFElqBpLiHXSTP3aP2DgDgp2X/QScB2pc/n+V/x6LFRUUhve4sjRXXSNfzsZELt6hPrLh3UY314rAAl9IJ8j68zpPLQ+gMhO4fpDoVmJf8OUkLSAdu4c2N7IMGJIuyi/GqLFG60KyYar5Rj+8U6M6rMfqkhRDIZu/GoabaBjwHCW4Be1owmk6naXfVYWPbH0o+cylg2Ga+PDjd0/JSIGO72TW4yKxeEEwnU+zW8Crid11OU3dTfk8+naG/lVlERAJnyzqUZ6GOcJF8rKRC9uJXfA+Brv2V4laZIoAoZPmDzHn5xmjGN7SI5Yo9UBE4k+LwAFNOY7QbJc89zNVAPzWDNDDj8qrY9RYYNQsocDjRHiZcQA/H4YEprFbpc01uGGnfNeGKmUySS1Wektf+ZkexXPR5Y3UgM2pQPDQtP3YOGcAMrLqbtZ4f/+iuY2leH/kCF/fgyEO57pKn8PQHYJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUl3eEpNam5lUGJRWis1WFZvc3ZvbmFDU0xHRzlENHZiSXhiT2lZMW1Ncncw?=
 =?utf-8?B?K0hvSFJJMG0rdVdFZ1RMUjlZV2g2SThHVXBEOEphT05qVURDbFE5ZFpuanFB?=
 =?utf-8?B?K21jTnF3bHVoUXVUVnA0bGprNk1GTVZGWkcrTjczQk9KMUhUdHh1emcxbXVt?=
 =?utf-8?B?YnViaE9mYVJ4azVTMGtMYVp2VE1LUkxKOVprZ20zeHJHQ29kZ1psSVpCUklG?=
 =?utf-8?B?RjJCTzlxTUd0eGZXWC82ZzlBR2tFYTlrTERKUFVLdTFIckNzWTFmOG5SUHgz?=
 =?utf-8?B?RHp5cm1VWUFHbndDcUdLdXNWUTJma1pSeEFGY2pEVmxwbnlPQ2dJZGR6WU85?=
 =?utf-8?B?QlZ4aFVabkltbHZNSUlvS0h5eFNtazhmbnE5SHQ0emNPdk15S01MV0JzVVc2?=
 =?utf-8?B?ZWZCclhoSGRUUUREYTRtV3JicTRjeEFqbmN0Qmw3R3N6a0NaT2g3aWFmbjhK?=
 =?utf-8?B?K2lveDBFRG9yS3BLMGhNbENrMVE4cGNuUGJYZjFBWWg5OENGWm5ZVWQ4Ny9t?=
 =?utf-8?B?Ny84cS9vVXhZdXdYaVV5T2lJUGNiRlZvUERBZTJnOWxQS2dDL1dVNzFLUlho?=
 =?utf-8?B?Zk9jdWJaMXVTaE05Rml1eDMzMEhQeWd3QVQ4c291bXp5T3k2dFYzYkV6L1A1?=
 =?utf-8?B?US9WS0J0b0hiV0xCQU5wVTQwaytxYzNBZDF3bllmTjlsdHhPYU9XWHdpZWh0?=
 =?utf-8?B?SS9VaThLQTU1cVB6UngySFhCR05LOFJQcE5sOWZyWndWYjJnVEpET3l1OE5l?=
 =?utf-8?B?VEZwbG00WTNodVBWbDB2ZXVHdWV5eEZMdHkvNmZRdG5jRE82WmVNYmNKbzBX?=
 =?utf-8?B?ekhrbjdZV0FjM09FVEFkOWN5ZGppUzhYRVFEcklnRkJuMlg2d0p4ZTdxS0lw?=
 =?utf-8?B?MmJ5SjBTYklkR0IxbkVtczBhWGMxTTVKdXp4K0NwZVk2NDZndTB3eVJnM1U0?=
 =?utf-8?B?d25hckZJeVp0Ny9JRGZqZkkzd2VwSzhDSVF6Z1M5SE1ieEVNVE1Hblc5NFhp?=
 =?utf-8?B?Umx3UWlhYmFZNzJkTlh5blhGR1NoT2tNNHV4QXpxMjRzaWFoSjVabmZTbEJl?=
 =?utf-8?B?SWNJVnhWVVFvemJsdTk3djVsRXcwS3JyaEMza0tqb2hSaDNDR1hkczg3NXBE?=
 =?utf-8?B?KzExNmc1N2NBb0szRjlQRk4rakxrbnR2ZnkvdHVyZDBkOTN1WDdtb0ZmYjF1?=
 =?utf-8?B?RmRDYXRETGZ2U1BWaUhHUFVKQ0pPRGQyWWROYW1qTVlhS2lWY21YMjcrWC9V?=
 =?utf-8?B?OUJhQStTaERHZzFFWGY4Y2xoR1paZTc5dHRVeHBLRnBtZU1TOGpPVWp4em5q?=
 =?utf-8?B?RFpTbkhwYitvc0YzaTV2ZEJ4eE9maXhPNTlaK2IwSTV5eFQ4UXhlNVVvK05p?=
 =?utf-8?B?QjBMZ3c1aThmRkhQYXRGMkt5elVScGhTR2JNMzYyM2t6SUxBZ1NEN1dlWjdj?=
 =?utf-8?B?Q0hXa0wvUkZWbnhPWndGMGJRd0RXaURLZGUzZkxyS0FKYTZTZmhwbkF1aGpw?=
 =?utf-8?B?QXk1Q1cwRE43U0R1MHBrMGJlZWVmRmpmVzJYNzZ5M3VhOVg5YWJIWFllMFZX?=
 =?utf-8?B?SWZrUmRTK3UwY3JtVHBSSzNnbXV2STNkZ3pCZURiSUxFcWlkVm5pVCtmQlFR?=
 =?utf-8?B?UUhJU2RKWVRMdmxVQ1NJSnp4cXRna2VZWlBQU3ZwVndGUkgrNE0zdjFRemt4?=
 =?utf-8?B?S2hxVlZVUS95WkN6NG1yRmZwVW1iOUhQdVRTOHFYbE9uWjdXbFYzRjFPaVFB?=
 =?utf-8?B?cVk0QVNyRVRkbk1XWXNkdlRPOU12djNxR3RaTTh3QTBmcUdQTWwwNThoalQ4?=
 =?utf-8?B?QmcvTm1sNUdFZ3JwTlZkTmdTTSttTEdiZXlreng4djBrZ1AwNXE4ZkNUWEI1?=
 =?utf-8?B?clVUcE45TVgzckF0bXFscHVFRDdhNU1NZUYwTXN6VXVDdE8wS0hEaFU4bFIr?=
 =?utf-8?B?R0IyY3llcEo4VVJmbjBhNHduMGJqdHhuNktFOGxQK0pFbmt4REQ3aVVhbFBw?=
 =?utf-8?B?ZEFKcFp0WDdQQ2thSzlvZHJUZmpxOS80YmRBcG1pcTVXM2pLTTRITmNaSFFj?=
 =?utf-8?B?enE4VkorREM0N2NrZ3FPWXVLem9QL2ViSUVMMFYxMUI5VnJNcjRidVk3Zmxa?=
 =?utf-8?B?ZEdvVHN0UG1FTFRYSHFXTGxOSDliR29QUkRrZDliVnVVTy9lSHhCWkR5Rmor?=
 =?utf-8?B?WWs2YWQxNy9mY1ZtVUdHc1c1dFBJbVI0WTJLTS93MXRERElIVW5LS1h1SXMz?=
 =?utf-8?B?K2ZWbGJUUk9UYnVKalc5czF1aG4vbjFkMEtUa1lya3k1SXhZYmVWdnd1b3p3?=
 =?utf-8?B?YklwY2krOGR3dzRwYlBaRWR1QXk3WHM0SG5peitybktjNXZ0SzZIZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7a8369-0898-4567-6074-08de9fa11c16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:25:44.4259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mn2JluFkKi+rgssSbETNT6NjLQbtPJe/v72Iru+JR6HKlk7YV31v9DtfUs7DSQrjuaX1JYKyUSS7gDC1Ra/+iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9349
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

To mx6sabreauto and mx6sabresd, power_init_board is called in board_r phase.
After CONFIG_SPL_DM_PMIC_PFUZE100 included, there will be build error to build
power_init_board() when CONFIG_SPL_DM_PMIC_PFUZE100 is not enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/mx6sabreauto/mx6sabreauto.c | 2 ++
 board/nxp/mx6sabresd/mx6sabresd.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/board/nxp/mx6sabreauto/mx6sabreauto.c b/board/nxp/mx6sabreauto/mx6sabreauto.c
index 8ca57e0b2ac..aef8bc0ad90 100644
--- a/board/nxp/mx6sabreauto/mx6sabreauto.c
+++ b/board/nxp/mx6sabreauto/mx6sabreauto.c
@@ -465,6 +465,7 @@ int board_spi_cs_gpio(unsigned bus, unsigned cs)
 }
 #endif
 
+#ifndef CONFIG_XPL_BUILD
 int power_init_board(void)
 {
 	struct udevice *dev;
@@ -488,6 +489,7 @@ int power_init_board(void)
 
 	return pfuze_mode_init(dev, APS_PFM);
 }
+#endif
 
 #ifdef CONFIG_CMD_BMODE
 static const struct boot_mode board_boot_modes[] = {
diff --git a/board/nxp/mx6sabresd/mx6sabresd.c b/board/nxp/mx6sabresd/mx6sabresd.c
index dff3a9c33bf..9404535104c 100644
--- a/board/nxp/mx6sabresd/mx6sabresd.c
+++ b/board/nxp/mx6sabresd/mx6sabresd.c
@@ -437,6 +437,7 @@ int board_init(void)
 	return 0;
 }
 
+#ifndef CONFIG_XPL_BUILD
 int power_init_board(void)
 {
 	struct udevice *dev;
@@ -468,6 +469,7 @@ int power_init_board(void)
 
 	return 0;
 }
+#endif
 
 #ifdef CONFIG_MXC_SPI
 int board_spi_cs_gpio(unsigned bus, unsigned cs)

-- 
2.51.0

