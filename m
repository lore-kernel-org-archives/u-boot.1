Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DC3CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F8A84209;
	Fri, 10 Oct 2025 13:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="v+4bXbJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 583E883E92; Fri, 10 Oct 2025 13:58:49 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FA184207
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUM9kY7hpIpwAzVCJ2i+iMOvQqgQMBG2PtLjm4r23DPXDIM+Lm9JNFYtxUmEN8VdEfIf9D3nL5nm3W5vWL/bxr9Ve7KkhVB+w8yGVt4jqLLPU24bxjf1oZDen5hjC2RIwG5VMit/01qM9cQuxPOjvAB4kijEUD5DTIcBcvO2Z8H+rnM5igK3XTBsXYsT+E4m+z3HcigKHqIYVKS+B7e47evOuqLw5/v+L+Ws7YHT5AjQPu+v6YCnNr4qri+zlSu6CmeNGCfKqKBuyqgvX8EXRfoWvZWfKMLTgk+LjUBSRQE4akLYM94zwg7qlZBK1X+Lf2d/rbSudnNN+Yr5Qu//mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhd+yxmrkcq2pO3q/Zr/C0kVGuLb69R1KAUfqT25rLs=;
 b=O+NuXJFi9mdVA6XBA/89L4tbk4hH8fTq7IedvdTkr4kBUAJhMY6K7MuaJU2u2oTWDyvl2aILACs5ETDsKPonXhokEI1g60CudU8mrkZ5H7et+MNShqRoFhDx9wOzspr7eSJcDC32TXdp/WjbR2IRxYz/GNEvTCd1XcBTGo3rqj/MQACiXsQd6r8iwqFkumMViYQzAns3utY1agdRfFl1CqNGn6Jr/+xLVmK35+66nfEIsYOnzZjHcmUxSF+PT8xzkxYeQ+YN9bsgNhL2Rp5A7BvGmQkYEIepXG+SlZqDIKf0lyzVjqNLJUPzjzV9B3iDrTfttt9QtJb1vY+oRANqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhd+yxmrkcq2pO3q/Zr/C0kVGuLb69R1KAUfqT25rLs=;
 b=v+4bXbJ/KpBKRCv1svidpMXrX0a5yNMhxf7zf/8RbNsis/X2NfsP1lW2M25qxJkJyqo6blGgW9Qf2DovrRH8az7E6tqmjcdkZJd+VM4DFf04zBH0l+++jSOwz+H2IF498xx8pQuITPydCnuruwrSgmQD4qqTlcT2v6IST8ldFyx9FoCdoEmVI0uVJn5lRYK4SAhtU19zBSlW1ysBQrytqmFlG8ZEgjVcD6QmKdUZIWH4IiAnJUV4wioUBqj7S0zy54puCI6ZntC3hAUnMvuIIhyfMT+gy0wmshtttDZ92665bz5DJ9W+Ba9gqI0Lmvt76YrgYo3FTZ2znFrhZhV4AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 09/24] mtd: spinand: Refactor ECC/OOB functions
Date: Fri, 10 Oct 2025 14:58:10 +0300
Message-ID: <20251010115825.1531775-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e49408d-0e34-4031-78d3-08de07f45d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xsHIm0LTscDgdb/DHmEWMqeB5nwG60OZqDm+yI1BWxa1hQadJAFs5aRh3Ib2?=
 =?us-ascii?Q?W+wK8AtffvslawQ3jzS1IsdzvUZj1QbEa0612JZR+UjDlWJgeAF12Dz/xgXK?=
 =?us-ascii?Q?7dE0HVfvRNSMcc1ZZsxYio1GhDL/6ox9bDVpbToNgqtONE6okxu7gIdEcJVm?=
 =?us-ascii?Q?kPmX0IQ7GzBrPx3KbvmbTMIstPYUHeVX247B58xAlyDAWg9nGYa/NkFrRdqg?=
 =?us-ascii?Q?ko0MMZakDJh8GRngGWreoZ/Evr8dMf+Iph7/gf2HqX1qrV4gB+ZZISYPdSoA?=
 =?us-ascii?Q?RANLj6a5K09DPWUN6FZVXyX9+XKiSAqm37o4P8hQ1jl/NRa02UP5GbaNK9DJ?=
 =?us-ascii?Q?M6/5vLUYjjxZTrcdhtue/072tHyFXPCGGnu0GNWk7F+8esJawYe3DqQhwVjk?=
 =?us-ascii?Q?SHVH8MgzBvwqXd4E5+NqXtUyeewEDyrK6MgPUQriALdYvT658EhGQMSGfzh1?=
 =?us-ascii?Q?q+afD2zSsF6576feU1lHTOXyeI+EdXvcQrHMuOpllyYmMQfdu5gDyGNYXrsB?=
 =?us-ascii?Q?Lzo/dgky7oI6CTp8H8TgumbRhOSLLDzvpLd5lz3Sf5ah/Xa+mFK60U2ImxUR?=
 =?us-ascii?Q?nmM8wzTTILOFfFDQBcPUifuIg+729JfQpJvWLTgiEC+03SCW8ojc7mDAdZbi?=
 =?us-ascii?Q?uYSRpq1b3l7DlJZ3eO+4VRx6XhjZDQqjHFfwoVE6SNDr0CHm3lF7glsv0GPl?=
 =?us-ascii?Q?d4OZ3TX23Pxx3ZE1Mqq0mtlNmGWBOsm1fe4SkSw2ZBzHK5b6UIUq1/Cvrp7b?=
 =?us-ascii?Q?zd0Sz7Jh1rydprF1eGWNcvgRHf4C5M3joiuAbJrPpG0VtWjqZy7SSoPTDQ9I?=
 =?us-ascii?Q?rynp3340SfqDn6UeiiWviGhqqRu+D9af5kLQOmgQCP3zmggS5iyPg6kZj6FU?=
 =?us-ascii?Q?Qaiv4H+hWnRbRg674ofHucZVpHF2ucmEKjb3bvD8bHGPH3jzeGL4rmzxLKAi?=
 =?us-ascii?Q?4vA25ySUqmaB4vwDvoix8FWVgmp6zmrLVNOIh6HOUkjjug1h39j4Vl0sdnpx?=
 =?us-ascii?Q?meZTSLPHeU8Ol1O543xWnAxi58h+zL5gQFBYRt4f1BH1KUqdbwpUnfpNHXer?=
 =?us-ascii?Q?25YiBGC9iLI2arXOu5xeZ5tQwW/qS77OsEHvw76sG7zcuDjIXv/TZDDsNVox?=
 =?us-ascii?Q?VOGNWl/aiiDUZVY9hR6e/dq+yfLwAWzh1kzBv0ng5Yx8mhnLP4vmVfTxypqA?=
 =?us-ascii?Q?EA5Nz97iCksl5FHRusAi/cUHPr5EcDTmsoA2kDI7S5OBMI2J8OciM6ZVrowQ?=
 =?us-ascii?Q?tXyOXlXBW5wUaxaj+FzORVoKTRIWoQcohecMiYrLb97eNofdFEkUEXIfTIQz?=
 =?us-ascii?Q?7GRO3gJIkhH5esfMO8iaQ4mQ3SR6raQbESSqDsmtqP+1rRrCLtMsJT1iwaBD?=
 =?us-ascii?Q?SaprV2Q7FCnhjX9mxyV1PrDjcPEXZKTj874a+9y8SKDdamuuR0WBFK1QwTa2?=
 =?us-ascii?Q?DX+5Aw7E9RQsWGRZ0GIHXFo/mgptr/Q3Eih4d9gDvssfIi7ZPx97gX0gVq+G?=
 =?us-ascii?Q?4lzDl7XtO6/kxasHnOgpKLq6BYfYiue3fef1j/MWkDlQRqRSuYLvL61ypg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6LRoW5ueTWZ7kkgvDe5ZoCmqTcC2ghYjv2fg+7gySLilge8RgTW6ejsmM5o?=
 =?us-ascii?Q?IMiVieuEKU+c1x8w3S1zQabeMz01H2qBAcPuyo/BSFeoqSvAtvKknyiDYcn6?=
 =?us-ascii?Q?JtmIeLyQroha+U6gSTo8GARCQVSF96v96lb5Kkl3KVAlON9pnF9wgHuoYWht?=
 =?us-ascii?Q?nsuEvHDYDhibBRWMUAIGVU64D1+E14z4NCzhMdqJb/y4s3mV40mvPM8Ko/c2?=
 =?us-ascii?Q?Etc21Azh/ameiQtAMfdr/Jn8NDim/mnNmW4HeUtzLFtqyF5LqGcoNmFH3JXM?=
 =?us-ascii?Q?HyMxAGDbwo0JgIzW++gh2GpAqeX3i0t8kbIfVufNojCAHm0yiCBD0mKjICyf?=
 =?us-ascii?Q?hElULvOusEKvqqK/pxY5NgXqfUSD6mvVt58oq2LX9jFd4haH4cLgt2XJpHS/?=
 =?us-ascii?Q?n57veOicO6J+MEZ2bm8lVwXCMLhBgqQJITenOADq5e28c7WDneA06RDmHAag?=
 =?us-ascii?Q?HfkyAoTIBgYWZt0PHPTjcYfv6g4ZYgjqguLkccNJxDF3bhz6XtPbGKnjJpAj?=
 =?us-ascii?Q?85b7qdCxImEEotT1Mg2kY6ye40d/ci4DTwLqBvbkm2/vQcQr4Hy2Ep9KDQgf?=
 =?us-ascii?Q?8lyKJ1BNxMDfQyR4VwYdy/AMSTXn9Yi5bA+hgdObbhMDg8EmC01dk6CYd0lF?=
 =?us-ascii?Q?FoNhtycI5D0dcytV19POTBeSLPDYPMyydxb9u5Ilj5QC94+W59YyImu851Hl?=
 =?us-ascii?Q?waqdkgW98JpQalB3NIll9qtumtKZvt2uTRr3YesWQ7jBl/rz4ezJonL/fnc/?=
 =?us-ascii?Q?oND7Y0D+/0AYWh4GVzE89Y0Z1pdEL6l+rbTpQksPjuP3RSdF4zE75LidmueS?=
 =?us-ascii?Q?3nSrqRZsWclCL2K40njlW7JHglvrZXdLlsmYDL97kzyhu+6adHVvoa0cUU0p?=
 =?us-ascii?Q?Rj2fTAOr5hZsPWSFvp3OPl/ZaMAoij309OK3+TzaPLaPIlvCSS+6e26f2mdP?=
 =?us-ascii?Q?3OX8hLOsX1d3XItEABjRQ3G0A6+9+DlPdYRfFWgpFUar9Vo+M31+tv9ls2I5?=
 =?us-ascii?Q?rRbNlxW4wqsOlwVg5ZKgKCpSFpuQE1RcBOC2yDmI5GI8BYnHyqSdn2y4yvmD?=
 =?us-ascii?Q?ghpr5b+MFxZjlqtUsj7aCqK3lE/uFYifemnpp8HGN2vPMRcUQ7364yxrWqjn?=
 =?us-ascii?Q?Tby62z0HQOtIX3oNcX0EGpu20MK5YfZqeWM3Qwq2zEDEx4zywJzZxJSfrnOV?=
 =?us-ascii?Q?CiEyVZyGBl7dHz0Pe9ckuZkC5V3yC2WumQSBeX72zXuIc7yzs4Cpgu/yoEWq?=
 =?us-ascii?Q?YcH8xU9qzVo3r+viNalMuuU8ewqfrqKI6amMZ8eMTQX4LhurY706Rb3hOPbN?=
 =?us-ascii?Q?LXBoUWupBo7wlaAMLMRk97Cb4UKxXcG1zJYwW6N9Omu+CZiaQRnLPg3fsDjG?=
 =?us-ascii?Q?GfDmdoZezVxi5W2ijfUuIro+MGqicxv3mE4l+nvqbCDOmw60WVmnfGxAFYsd?=
 =?us-ascii?Q?A4XfNq0N5665dRgQezqBUszILrIKeZK5F96POxdZJmGwuOuAe/g+KcfBTCCn?=
 =?us-ascii?Q?ZCTksHfELY0EMCyI+YpE7YUuGUB6AR1VClkfDhRPmWHrC0yrs8JX8xUKiDVv?=
 =?us-ascii?Q?y5n7Z3JzDj5Q9EKwv/8zb/FxFRo/wkvUTqg+50YG8wtUYMcgwu0KMdI/9zMH?=
 =?us-ascii?Q?YJ/SUHQVfymHeVFDLQGpma4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e49408d-0e34-4031-78d3-08de07f45d77
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:45.6498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BNuggHIqaPBFNhu+Glzgbccd8lkFcKImpX1BENKnaewphE/HzgZK4FQaMtbdaj6D0FSp90OZgr8dET8fyUwGoWkvbMee5GnP2Wee6LRJ1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8464
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

changes:
 * Move spinand_check_ecc_status(), spinand_noecc_ooblayout_ecc(),
   spinand_noecc_ooblayout_free() and spinand_noecc_ooblayout close
   to each other.
 * some code formatting
 * remove comments not present in linux driver

This aligns the code with Linux 6.10.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9b48bcba496..ad699a0c6b1 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	if (spinand->eccinfo.get_status)
+		return spinand->eccinfo.get_status(spinand, status);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * We have no way to know exactly how many bitflips have been
+		 * fixed, so let's return the maximum possible value so that
+		 * wear-leveling layers move the data immediately.
+		 */
+		return nand->eccreq.strength;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
+	.ecc = spinand_noecc_ooblayout_ecc,
+	.rfree = spinand_noecc_ooblayout_free,
+};
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -425,9 +478,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
-						 spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -457,35 +509,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-
-	if (spinand->eccinfo.get_status)
-		return spinand->eccinfo.get_status(spinand, status);
-
-	switch (status & STATUS_ECC_MASK) {
-	case STATUS_ECC_NO_BITFLIPS:
-		return 0;
-
-	case STATUS_ECC_HAS_BITFLIPS:
-		/*
-		 * We have no way to know exactly how many bitflips have been
-		 * fixed, so let's return the maximum possible value so that
-		 * wear-leveling layers move the data immediately.
-		 */
-		return nand->eccreq.strength;
-
-	case STATUS_ECC_UNCOR_ERROR:
-		return -EBADMSG;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req,
 			     bool ecc_enabled)
@@ -1086,30 +1109,6 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
-{
-	return -ERANGE;
-}
-
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
-
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.rfree = spinand_noecc_ooblayout_free,
-};
-
 static int spinand_init_flash(struct spinand_device *spinand)
 {
 	struct udevice *dev = spinand->slave->dev;
@@ -1199,10 +1198,6 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
-	/*
-	 * Right now, we don't support ECC, so let the whole oob
-	 * area is available for user.
-	 */
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
-- 
2.51.0

