Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE15CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 01:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7EC9849AC;
	Thu, 18 Jun 2026 03:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QZzuwCva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A233A847C3; Thu, 18 Jun 2026 03:14:55 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B02A2849AC
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4UQvhSZzs+a0e8iGNfpngRajiqcG0wtYqcND2eHzUX+IZZc/I8hoBFUx8+5hHb4MvxeeaKXz4UyMTw1UQvFoFnwzhYJqPD/VvJJBkeqRXxRwUsLrKLPiTsF/MBd0RrN9MksiAfsavvuqL5F7gqrA603n+mIKjdDSdK9mR0ov0ws2rj7atS753yt7S7v8yYXANvdySdm/Ae3mKyMgfhqROh/OaOJPCno/xRyjB092Yc+3ThiAyZl1Jc8yI2QENYhmsckReF3FYnnpHLGCBqnenLH8Y2EQGlWuHce4hprPVA+6pwl+wc/rDEabhCqo1D2rDnzUywL8MIVJh77cQW5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0YrSOgxtBCxhFk/HX3vk16PErGl6V7VsFzENKH4kXo=;
 b=ehbiOYAo3RGZ7aiYtyeuqm6Hg++wiRcM/xVI2eqOOTyZaLzYPJuXfGGkra5XuCa9Tr8V2cD5+sUFfoWLPXJHMbFoqzgVSMXcxYih2QF17tVFreU8JKtZgquUC9Xpp8PzWKenRQizHdpo1vDJ2O5MWtvGmK3PCXFlVVcCiHJ0qblkVftPG+FPDPGbQo5TQk/ZALAfNT7W7oPGW4b5oVqaoB0papftpLactna13Ub2EE9wGDaNXtYJJe/qMkKaxXdoKYAz1g1/z333vybj3s3AiWwvdXIa42Bsq4c64sCTj5RIR9iRAez0Ioe4xdLy6H5cSq0iSv0+Hc4Dmvh0NrCQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0YrSOgxtBCxhFk/HX3vk16PErGl6V7VsFzENKH4kXo=;
 b=QZzuwCva5v6964F+b90OXcPuulbeBzQAnRP5vx4TCGUV3H5caHbtxEFBA5TSSEbhrzh7MEZJWbRRty8JDt8S5Uw+cfhhPRyoS5Q5WrcmVgilzNb7+eeJlx1ZMHAvd7IegcicayQ2ZjlbYuMuqA++ILjRGiuQBylv7NYY3On5TOMd41dz+CQeZebJFkYOagZsfRj2CqK1jhMIA8/pBhN+fopSVsP9VxQfQLqzsskKJmGVjOBQaKLZGcjqupO7N0iqZM6gpeqRrzFl1vJspGbd9Y/DoZf866dbtkCGVipek2hOV8UzlrI7rjW/5dfMcCmw+XsYkrpjnLBtbyvhPAFd5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 01:14:51 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 01:14:51 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH 2/3] imx9: scmi: Correct shutdown checking
Date: Thu, 18 Jun 2026 09:17:48 +0800
Message-Id: <20260618011749.2871269-2-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618011749.2871269-1-ye.li@oss.nxp.com>
References: <20260618011749.2871269-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::11) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b2f1ae-3e86-4faf-e048-08deccd6ff33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MmSJq0Xx9Qx/y+rUwnVsc73BP3l784bllXkjX6B5Anym+KmEu7k4WJSmSbMYRnjWKuuRL+4Z1WskwOcYEFFIxMikl0H3iUY+bP+jcNkDfY1Pw6wTdyVWhIWD67cJ01x1/y5jQm5/IoTon7LkfSdWKsvzMOrJ5Ox5VDkY8uxME3X79fmYdP6GzDTRvQhYwoMx9IJVAU7tE6+ly2nHXeiwKSxOOVKkQAhMr7iJECD/aatn4UjVxqq/K6M+nFJbby9xSDGXFlccy685PXGHLAztQGxYFD6Oum/kV5vSUT2y27wpc1hS5/T5VXMiq2DYjdFcSdL6D66JygWIPrSs4E6hhYjsEAV/gwMdwY4EsP7DTzaVujKmVSniWd2nb31ZZdw08cbFF6aJoBHBP2LhRWRFxzSQdjogfSurydgOfGmp+rzyp/PDmFE1Jxa51yJcyC0PRv+whSv8AklfnP5fgTwHdwK36XUPwDKhaIGbvqMzWgW/yqjHpSYPDM159XHRebMnSDhpEpnCSkE+bi7/X1jaaJO9mJo22m5Rh2athsI0RR1lLaObCKLc/Q52AL+l/+FLZQqH8A04ELowO42FAIhi8V4Ulun0ECn7EeC6KEDcRNfW2W0LZjwmO1ZoJrk6+rkTYATw81/OFJwFZeeeGEwWk2MJKIIWkyqUBpU1zRPoSEpKUQ8WkLUKjRaiRuxCH2H7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zqj87w2ggYx60t2rIiDb4rYF4XIi4ntN7g5Eu7RhhT5mczzVOfPDlFed32f5?=
 =?us-ascii?Q?UcKM6FczQAKKJLesVUhSCSMvQXYzsAUAI3QZjXSDwIt67aM/qj+HCSYCq03l?=
 =?us-ascii?Q?aEPjMN/iChvpLN2Y4ZioYvoeHLAlB8YJCngB1aYZqimbJ3Lp+UbOy56m+jkG?=
 =?us-ascii?Q?mhoECqfAxHCieuchTrrLAC7IEOqBp2FZGS+cmprxZ4LbQlc37oNbSnboi3nI?=
 =?us-ascii?Q?sPxOArRihCPCVLmV1QRaHlHM8plDtk1GhKSUrYjKUwvwibHt9lLD3rcEz4g4?=
 =?us-ascii?Q?NxoGegOkcZ8ui4rBwRMTxUbiKYuVS6plT3jiAEsUBH/PFELXNIfYw39EExVD?=
 =?us-ascii?Q?Xa2qIJhYjbupLcS4UI8HuffKvl8LCa53as4UtJG4YTI767OGub+tVjNDhpsH?=
 =?us-ascii?Q?kJCvjkSu/nMhE57e0JliobCegyLaooJKqCCgPOiiF098qREAaSc78eiJb73o?=
 =?us-ascii?Q?alBEDYk6gwCdwKbU8xzDD+RypjQWpIoCWj8AVuSCT+ixBo1byjp6Q+46kfrv?=
 =?us-ascii?Q?mBLrDJa+dUhiiJrgyzlchly96czDFypuA+8YpDa15XyQwP8ilJVQhoVtGnoM?=
 =?us-ascii?Q?nZP4S23hs3cpNx4g6eMfLcxEG6czcghg4OTz/Y/3yJb1w/ZMddkMJYiCR5+K?=
 =?us-ascii?Q?O5it5X3aeHeZ8lqvBtnOi4PYFkrOCrV1tyIddbUesHXgeXV5CqsQFU1dToEN?=
 =?us-ascii?Q?Ai3AX6DL9tFnSYbqC/JXRcRLgWdbhUjrSz+duwcNzZd7zRSXwCtAEa8p5VMn?=
 =?us-ascii?Q?tQka5JFWX5AQVa3uDByioGQoP6+zKyGXarjfpUq5e4yu4iJhJ59P85l1b7aw?=
 =?us-ascii?Q?6RHbeu72Z8kcFqn+LNT5gqprJaU+FTU8wVcxwu2V3oexN5mNdHrRrqwIUCZy?=
 =?us-ascii?Q?MzD/OyIdaW4hNIBla4McdGNb9pNls8RQUqrNiMsMIU+41kxznqbUx+jIknbl?=
 =?us-ascii?Q?eoaUITHlyn235rIt16tiSPTCAOts64kzDLI9K073s9FbsaaIrN8GiCwH6NTK?=
 =?us-ascii?Q?ZxMtgoupigDYCnYXhAjjIWfcnp6peILRy1SCCKeNoe/R45KzkYjqyc0ILXs0?=
 =?us-ascii?Q?lVdnbpGArIp/6ooLykc71tImbg1pAAD8As1JMuP2ydLlbyYUcSrjzitcBDIk?=
 =?us-ascii?Q?bWbOXoKOOIgHoG9Okrdmggh2S6fUe2sFmed6Zyf1pGNkEATkBFWPittxsev9?=
 =?us-ascii?Q?X4caXBwAlqhNV7llkL+E7Y5Qps+1+m5JZOl/eRcsKRquolgHAktzwr0hHLsD?=
 =?us-ascii?Q?/GOVvO2rTtwslDRwTNRMeMhrYBRN1UICckSYhdHysju25S3oPBjJYgJD9cLo?=
 =?us-ascii?Q?3nb9DOEUp1Tw/8Qh3yWu3Ayv8eCTaWvDl4L5sdhEFvI2s+zheXgCbimtPuM5?=
 =?us-ascii?Q?6Y/ibEAkBZd74OpAbrwUOfxIN3Xcz1kWfvs9+fAPzwBqUHorFKUSdnKz66t2?=
 =?us-ascii?Q?yjJ34Fb5+O/iSYY7ABZlcppR/eZ49aJAUN+Ns+uCUkux7kBePpLnCoucfqR7?=
 =?us-ascii?Q?VgET8v6kLU2tD4SLS8Bg8f+x2zccSB1lnTjdF0twcsa4SqJhDEo6RAHCBcWb?=
 =?us-ascii?Q?HeSMvHVn5AwsiOxCLJWrgyVw6oHKWVkmi+RNxy3faCJo07Mq6zSn95Pse59F?=
 =?us-ascii?Q?pW7yw5MJO+PS2ghKCmnbFBNAEtoVct1QVGiZebK2OL+95shHQm70sXtF+928?=
 =?us-ascii?Q?qA38ew0wmtqepP0iU4RyWQHy4pA91Ihdw174c5+AxPZTwK3Iu2vQiECFAWNI?=
 =?us-ascii?Q?GT05iikX3GGCTFyknfRBkrTUvVa90ek=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b2f1ae-3e86-4faf-e048-08deccd6ff33
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 01:14:51.3499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0waLUvZh2QRcSShUDD1cng3h1o7M2sRJ8VTa1+8XcePgA4ejdgws8ipDfFJENiI/CogwuOF4p7CXZeB7eRDk0tMGxhL0zE8T80bQBYD1P3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174
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

The shutdown checking should use shutdown flags, not bootflags.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index ce86cdf8574..4341a061d08 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -741,11 +741,11 @@ int get_reset_reason(bool sys, bool lm)
 		}
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
 			printf("SYS shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
-			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
-			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
-			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
-			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.bootflags) : -1
+			       rst[out.shutdownflags & MISC_SHUTDOWN_FLAG_REASON],
+			       out.shutdownflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.shutdownflags) : -1,
+			       out.shutdownflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.shutdownflags) : -1
 			       );
 		}
 	}
@@ -772,11 +772,11 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
 			printf("LM shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
-			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
-			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
-			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
-			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.bootflags) : -1
+			       rst[out.shutdownflags & MISC_SHUTDOWN_FLAG_REASON],
+			       out.shutdownflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.shutdownflags) : -1,
+			       out.shutdownflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.shutdownflags) : -1
 			       );
 		}
 	}
-- 
2.34.1

