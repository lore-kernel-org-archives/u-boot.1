Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC840C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 03:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D564D835C1;
	Thu, 24 Jul 2025 05:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S348bEKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A3C835D8; Thu, 24 Jul 2025 05:35:42 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D763D8343F
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 05:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLGVj08NZU2mlLu3bHuUnWJu1JIXRfVE/zc13Dj3r5t4EPESnhKIzy5JRwcCPoSe8QjzwzHRuhSpwGYaWuVvIbn/497Egl4QmIw8/8zF2phydVAhjcQ8lXJLXmIZ6OgD3fWB6ClJz0PawMDc0ZKSO7xSf0f67WZIp4Rke6et47VQBFvCYWHPteeI0+iNfcWev8bTNDEnJmd9AOZxqgp8z5J5uR7kIvTFrCXqYEgl0U6EUdnELYCNSpZrdUEfDrQLNQpyu75T6Azd8ZfwRjVtcRGrrcaM+PcAgdjoBJir7vi0TrtqIkcksxrJKUVQ5jXoKHP9UDxSi3EScubt/Pullg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7w/B95++1LOKqkbyLvFxnW4e0nfYemCXdCXfJ0TGA8=;
 b=YytgTDFwkReXURl4XfuJRFZGFQG/u40VB8ZwCCfjEfiBlH9WDWBSHn+sHA1FPmy9Tt5fG+vazIAv+/acsna+vAAH4gkkriKgwSi7WfOaFbwWTsHeDj8MyYbYGxYgU1NQzT5xn/J15v39r3ghemdmLenXtR3iKcfuRq230G7iJWZzd0EsUEsISe2sRSZyq4iqL2qQW1GqJditYbaqn9HsuhlXQlFnHuI/gwtOcSgr0g1AomdEN/agzmNri2g0tZyKzrPa0Hox1eRs3wetgHPiX0HLWCibeFap0tV+0yRN1cqioiJduhIAQn/p+9G1zHWdNClwwCsiIuBtK7/ZytIUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7w/B95++1LOKqkbyLvFxnW4e0nfYemCXdCXfJ0TGA8=;
 b=S348bEKcU6+9Ey7QXZ5vjICnPYy4EasIqfHfKQcB3cPm4B6/xTrKMQmZHRTjjQTnDDD5LAvH0WUPCKQv1WtPg2ZZ86HQJrjprlLTmfEm3ckJbjua0GssbOH6RT7aTg55yckUOATt1zKA1MsVA9/XoTVp6u6AtrTj1HRTwS3Bfr+i6twjLC2SG2rY5l8DKLh1aDpk2L7FMt0CKR6rCbdICnNvgm8oviF7oSBV8SW30hw7ayyIbkXTa9y3mJsTGn+EObm/wJTCNWlPHFbIStkVx50seYCk62jCuhrNsinhWnYUWJqDYUPbGr5/vmqHrtYmjMseZP/rNhdA0DZqPRyJpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Thu, 24 Jul
 2025 03:35:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 03:35:36 +0000
Date: Thu, 24 Jul 2025 12:46:10 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3] imx93_frdm: Add initial board support
Message-ID: <20250724044610.GK18395@nxa18884-linux.ap.freescale.net>
References: <20250724024749.2165530-1-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724024749.2165530-1-festevam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MAXP287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f7ca6b-4bc5-48cd-75ce-08ddca63273d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CO0TeLxtk1JuIEXHbchXFqAsCr5pz2a2N774OdRitZaA3UjZQNw07+1anpaa?=
 =?us-ascii?Q?EyWJBZEhEvvBXR1bcwdbZlDDwrD/20T3Wtlf/QskneReV3EqsoVChY3/HNsF?=
 =?us-ascii?Q?A918XzqVMEeX0z4YOmxe0DKPANW+uH0hY9Jzn2wmxadigokEThJyp5mXO0IS?=
 =?us-ascii?Q?+eQbCnN/8xYFhx7e+EE7szatrl3DuWS47Q4GS+x3yYzM3Wz0tGsyJs+BfPVG?=
 =?us-ascii?Q?ng4R6YFusM5+Kb6Kk28v+nUCkarEqENOy6b/0OOiLLH8KRDXYn68mQcj2pQC?=
 =?us-ascii?Q?pFTRSwpoPJRzqz0nGN6YVjfiyYfIXsc/I9ID2llbUWuXL5Xy4uEJyj3bvYYh?=
 =?us-ascii?Q?7A46rgtpjeu5xSaJEAp50YxEJh3ygg/ckHLLoncxmHctld8u2IHge2GXOD17?=
 =?us-ascii?Q?H6M0HniLHnywJjdZS9Vld6MHh3njHoHq2E7AjtdM1tBGO6jqtVWsvmZWSM96?=
 =?us-ascii?Q?e+JVCB/acUXiIT1iDuKjEBvN8V4lJ3C0soK88aXfWdwGm7YGOUWW04hnMj38?=
 =?us-ascii?Q?WQNLsjBKJcsxX2aqnga6ES7kwhhci51KYLFqeP7VYyGY6g7+cdv0vbO77TD+?=
 =?us-ascii?Q?8IoLM/EQW7VwwvI+rCEJ1dXZGU/5bgt5f3/GVOAh8mYrrKTbkJTy7dFC9NNF?=
 =?us-ascii?Q?NGxHvVbK5kVitR217Z9p6e1M6DfT9aEFua08NaGtkCiC0Cp9wxnNgUC5GbAK?=
 =?us-ascii?Q?fFHtxm4ET/hF6zMFNSH0dPI01pbg3RMWIo546j9x2BITG5KddoSEUiUJ2VIB?=
 =?us-ascii?Q?Mc6jVCMuAFHa09HABNBEZK1DsbYnT+zM4sHx8ek4gBmH7MYN4mqqVWhtCBJP?=
 =?us-ascii?Q?X29LqnoLgHpjTulLo5wRjr4ptc3rEk6hMFKqVUBBeTwJoha0YHIo1/Fe2hYJ?=
 =?us-ascii?Q?XmHQ+XJ3WocsPHLi66en6pYagylbmIJsa74jX1gkwn9eSV+71stdSU8yIRiE?=
 =?us-ascii?Q?ZEMYpCd8xJ8vzy6rALMdZUy1Qw+sjKRty5Q5o7KCHF2AFTZAJsTNISvCrd00?=
 =?us-ascii?Q?Myh2WereLlVwJPHsAMKd7PIC1c0Yk/ssQUkqkRI3xefY9Tt8R5IWf0zVh8q4?=
 =?us-ascii?Q?aPy+yO+/GcvwdzwN3f9CbhryFLLSwWvI6B31Zw1D/0RnsPMSQf/NwBomASVp?=
 =?us-ascii?Q?V972ntjtCIlXI0ZsbG9uSbTzuMtHsptEdKHsiDoHKjl7hSS+Q0XwKC1PvNUA?=
 =?us-ascii?Q?GTAiKrfkRCE3a0uvrgXLcxJnXzalHn8y3F2BCdiX59ACYjBq2lhVq/YuFSLB?=
 =?us-ascii?Q?roIVE57Bk+uq1swwgtXgxDiQk7Ya8I+r69LzCV/DB5/mEmEB5xAVbUErNTjc?=
 =?us-ascii?Q?YbV7gM6UeK6kdUT8Va/e1fbF/lwu+7Lkb32zFA2+Zlnrl6uFkUTPSdaa0erc?=
 =?us-ascii?Q?3a5ButIrm4LOZuMURid24bwHG7TM1U4m1QgoPapeTXDK1pCrLxBNb1Et+dDM?=
 =?us-ascii?Q?dDshbe9S80VV4BjtWsSHp+IC77EZ0Q9dIZpDub8q+9NZsqREAa0+fDNNAVEU?=
 =?us-ascii?Q?RG08S2BUH01oNS8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nK68DUZ4flfYhBsYty6i8vde6/sO3PN2wzT6Gc01pI1G2rnLJ/YxOGgDLFH3?=
 =?us-ascii?Q?X0GxlRTlp2uukJ2BgXsl5XRJ2rjs2bW9A3qQRKt9iu2MJFP1xPrZu8gBFWv1?=
 =?us-ascii?Q?uUhgqy58fwsOy13mKPA+Is0y8w0T+h1+QgCN+BSeooYaqmpP0uGGgcN9dCJZ?=
 =?us-ascii?Q?5MZcMerAiXTuewmt463hd5QGvqHL0OYo4v5zkPp1UV6fRbBxaVIODQUjSh2G?=
 =?us-ascii?Q?BUlsOL9gqEeiHV9zLWx8PPyG//Cji4pCrA+Akm/pBp2GrmEDOkWqEpwT1Cny?=
 =?us-ascii?Q?dRICci7HHV4xxzy44SqPPSYxZQOhRU9RBEo06gTaJRUDAHoSvjmcQ+ik13KX?=
 =?us-ascii?Q?+lnXqM0RlXSwc3UyipstOco7jeRqJivkAgB3CkVusjScxPUedYy3fOhenQ8H?=
 =?us-ascii?Q?Nxo/EXlHztHiU3GJePGJOz39X+jWxGnLIO5fWLKOVeVQK8Rff50qR3U8hFP+?=
 =?us-ascii?Q?sP3VRqMuIurxYwWECoDnxrDkwIA3tRJIgY5SLP0L/V0qrct4HPqgXGnoV8WC?=
 =?us-ascii?Q?G5p/dAdPCscJDkhAMJ3SyXglAj5soPvPzrXF9P9OhvYY2KWeD69MMSfGc5V8?=
 =?us-ascii?Q?o5Upmvyx5ldGsCm8QqM6ZFpFdnZTVw1tiEtpU9zPjBrfCtEUVBG4azSlB9M/?=
 =?us-ascii?Q?pyruaSJoIsIsnKBIur5EMSOPGZz+kLO51QnKr/pCjNM5JGOL3uETKb5OTefU?=
 =?us-ascii?Q?+r5olfXw3zRHOVBVFRXYl+hjLqbtRhhvPpYqLO+PkDNXTPUzrZa4mDPeJ+n+?=
 =?us-ascii?Q?KUBOjwRp3rw9Hn1tU9xmvG0iNYQwkM5lmwWPM+TuUA5sEvNFsCGvDIfgCiax?=
 =?us-ascii?Q?SU3Ef+g9ahI5ushznKvJdeREEN07LOV+GEKYbeRUuM3120SR7zDNZEtUScUQ?=
 =?us-ascii?Q?7cZFZZ2z8bZxJGJH2bDY+11IIu824X+dEytMoUer8vH49XQcjIIuNRynYtZ5?=
 =?us-ascii?Q?pX7fIGkn3DIQRTyMzS7BM0zAANKHI4Mk9i2pfnf1sX+03vTbkJZ52XaZiFnf?=
 =?us-ascii?Q?zbQgtLITmtGqs0cFT7mOjQuCG96NDaAiOXNgJGWeOn2DRo91CIDOfthNQPq1?=
 =?us-ascii?Q?mls/37ivB18fi2ndbLidYtBNrCgfpDEkJmTx3LBdkzrUGsKD9o1q06TiytXf?=
 =?us-ascii?Q?XgMbpYPa9y5akDtUHXsxisRD5vMLtNNaA/1HUk+QiS8741Q+m8PXtFbeABqC?=
 =?us-ascii?Q?UOf+GdPBuK8xLmLR5Ki/U3PkHOW3BxDeFK/Al9AASOO/d3BZj4xFvYl75h8H?=
 =?us-ascii?Q?FSCFITAzTlLvFlKZwG38LEKGaWRRlXw81tmhOOTtuQBdL9ts5hdW6RYcvrxa?=
 =?us-ascii?Q?CgEKz9aecy0kD2R2kT+kWchgSHuMhbEH0PEUOgGJ7H4MkZPqjkBDSeT/X/zO?=
 =?us-ascii?Q?euhaTgFC8M3PUbxx93RXCk3NEh2xdqQbDb5wirTi74hHgUaiqkWLWet5Nmtq?=
 =?us-ascii?Q?Jp3SSM2FoXnz4pnme1fvhTKYKX5leaBN5wsRG9U8FmBD/3VXCqvwj45HwY8N?=
 =?us-ascii?Q?SQJm5csqbggvX7K1ffHttSHul0GBEozwmC6suFV4p4HfMI/3AD+3TmjUCa3u?=
 =?us-ascii?Q?lDYvsFUrYOAWMpsvoCP97XLMEASXxFMznQvabMLc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f7ca6b-4bc5-48cd-75ce-08ddca63273d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 03:35:36.8076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJFhvN0q76LRGx7G4DCTu5Kla93C6fQnyoaW7O980o5A5l+2kocVu6vZN8AWST7g3vjKBRfGY5gP1lPHoBwWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9571
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

On Wed, Jul 23, 2025 at 11:47:49PM -0300, Fabio Estevam wrote:
>Add the initial board support for the NXP i.MX93 FRDM board:
>
>https://www.nxp.com/design/design-center/development-boards-and-designs/frdm-i-mx-93-development-board:FRDM-IMX93
>
>Based on the NXP U-Boot code.
>
>There were attempts to upstream the board devicetree, but it has not been
>accepted upstream yet:
>
>https://lore.kernel.org/linux-arm-kernel/20250526-fpg-nxp-imx93-frdm-v2-2-e5ad0efaec33@pengutronix.de/
>
>Once it reaches upstream, we can switch to OF_UPSTREAM.
>
>Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
