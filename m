Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0235AECE589
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A1D988E73;
	Tue, 10 Sep 2024 00:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="W0wiKzma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9852A88E60; Tue, 10 Sep 2024 00:24:30 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C15088E65
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xhz37nO3Xhur6An1zobvWGf9LSMjy/kVuesImuIyPk88xeuiTGizUn3+bDnbEUA+rbsXzvMrDCBVRU5Jt/pfFkkDDywBZIgr7BI/eUB3/YoztDTw2ksdn3KS9FEzPWSsM8OFQquj30Z/tRI+39DbJZkZWGokx3YT/bKzaIVSo+5Y4AYl91u/vNXfIlfAD54vlHQ2elOjRWl/K2oOHKcxCCY4hWbNGkxY2pQ5Pkz6G7RKnSqe38Yb2y0zgppKiO45Jd2PeGL7y6E89BHYvjlq+UR2ptbZKaRN2gFzzOCwhBU0qaLoisYF6EoxHDp+UBPA4Fe+1pGFkLihyoHpDS83Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHIpUbd1tqYqQ+cvO4iqyoaIM/DkUZef+50hZighZbo=;
 b=TzrLcDwVvCasNKhKcQ36v7FfrrcZAq+9BmAYr/bie/JrEthNxNEir5PP92Iv+7jMOYzabVS6As5+pFEzdlihQMJIQlPtwLiWMXdCX2WQwxoHePajxYp5B37u+vDq/fS+3fcYpmq3a9JCx/lUn90wNevo3rYB7JACNgJnLxWO3srNPHXA8wpo3wKVXFxpqdKOVSo5TifT3K1e3I4VLNois5NNCGJO/2sJpmf/zzBB/6xHqk6fKIRe/C7OvjbLvxwp37bNvB/WIADJ6pctQlpnlO/pGwtRkN5XvwopWf7yeibbUgl2OPW9aPLnhwrxD22up+h66yB1t+/gVJ/APNjXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHIpUbd1tqYqQ+cvO4iqyoaIM/DkUZef+50hZighZbo=;
 b=W0wiKzmakv+Glv7cC6wsFCHR+LSZgbHBMGhhgrciBcl4lxsbyGLVQcGhzOhQrs8cbs/AakR8C8x5y/ygZMf1dfxp/I75ztd4I8HHtDmkTVGmfyFHIZmn4lMeYiUCt+ax3iZZqtL4HLOJF0UIeyL/P47/QCsLmOxAVHAYwpKIW1+PjzoPD0szF12crgORoWJavQtVR9RlkzPGqmy8ZgZMKNTVwi3Q3gsnl/uhoXHfSEdxwGi5PPvpwC8n7cEqPBWyLCRGMHGdj1+mXbpgHyFxtX5xRaA9ihxZkGR6wNH8bemwrWp/MRupWPLLTZxd0zu06Fce1HiMDuq4Y8umpr1ElQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:24:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:24:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 07/10] mtd: spinand: minor refactoring
Date: Tue, 10 Sep 2024 01:23:55 +0300
Message-ID: <20240909222401.2562898-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b9f937-421e-44b2-d2a2-08dcd11e25de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ifeHRrVvWSaosked/8IKsFz8HI/68DGW/IeYlRovFwxMUHhkAiHiFytIaYOU?=
 =?us-ascii?Q?4MzMjgOZGwoXSmJR0FTgcNTC3abSC6UbwbesUeweOapG3qJydRyyqcCJB/kl?=
 =?us-ascii?Q?WIZsdjzAQelVxb+QGB82HFcB5VsTssQVDDynBToZHqMWrwqPKY+CmhEk2Yyf?=
 =?us-ascii?Q?TWYG9vJWSRW+TvxvfOUFfnjExzaJZQ7Z46+0ooQhdfkVj8EuNB0fW4HNN1TU?=
 =?us-ascii?Q?kuTPNO1pXt0giieWciTQjxI6dZeLkkN29GqcSkJs8SDkk7UulxaGPLexWhy/?=
 =?us-ascii?Q?fPf86ad24yN9+NqpXcBfNV+NOo7DxDl0rcuwVi9R8qzFofW5A/wlzF40FSAA?=
 =?us-ascii?Q?UybMgj+5DZxRf4H57z2VcYTg3DFLPlhY/R5sBcO2A4WswpWJ6lEfjlvae8yn?=
 =?us-ascii?Q?EtD5i8f/sfc5HIf712jjG7fC2h//8ew+wqI8LbaTjwpfY98V2RRRkZWbqOSk?=
 =?us-ascii?Q?bYuQytcViePQO5YLzn3FODrf99GKMSCU+enzNtcYb05AEypibri9g+g+dAlk?=
 =?us-ascii?Q?O1ziSYp1pIgCSG8XpCpCVaMkYA1pKaVeEgLhyWyHAl8WTVcZkg3IOwsHrE5L?=
 =?us-ascii?Q?CmFU+vFjbWCY0m/I7WYa+j8XUnLt9Htj8QZxuLeP7N7ocBeo5v+oeyH2R7AO?=
 =?us-ascii?Q?NDn7nh4PpIUiHWRLPbD2aOVd+J+PqsbtwjyqcJrQjnt0UnnQgALcu1Z7oXTi?=
 =?us-ascii?Q?/pURody94p0wbx0hpaxthFl32JGxY05bGy9FlPTzZNByu+/cNKB+fdWJ71q4?=
 =?us-ascii?Q?Sfdd189LqTrBpLsVVwcyZ/KcJgiFgVtLsra3PdacuG7e94iGe5DWZzQQ1pCN?=
 =?us-ascii?Q?kytAm9xgAJzOKt5d1czwEj8/EpSAIVnLFHGVkT7DOjWpqXG+kGVU7hNrKpAn?=
 =?us-ascii?Q?RiTeq3S5PetekXEGiY1hF/8CdwgZ5viaP2aBTO/xQ3kiZX4nRIa44YxR5RHq?=
 =?us-ascii?Q?TQNwzYX/91HSpRCWuRMK2Bt0skd5FtyGQa05OG6/kJEXAATanUOKZ4ChJ3Vg?=
 =?us-ascii?Q?yKL8faII3dlb5MAPrkEAxHwnfTEdaTY/XcX2xMcUYrJLqGvayCx2/+QhvSsM?=
 =?us-ascii?Q?DuVrySnJkdN9xuukVgEHBIPV6KVo9xp+0xYmUcwYX2ojduyil3lBjOs5KQJ3?=
 =?us-ascii?Q?ezyDsDcw3zULNWfDfjOpxZJxXg1wMEj+ZfTnytAo8Ji8ekyW9jDAs3fHcbkx?=
 =?us-ascii?Q?Z4ha+LVTlfwILnHdTjoC6sk8Ty7S4VSOFFeh7AT31Q3ndYWZWTMkltZPt8Ur?=
 =?us-ascii?Q?th4QGr5zShkL+b1K+jDmG8n5d+hmFs+7MZ6C/rge442PWgd8QEgbkNf0fFg/?=
 =?us-ascii?Q?PBHuJw8CMHUB0W5bf1Loof2DvGu3hvEMiJdDdM/q2D8HrZWS5rpNB2gZfx50?=
 =?us-ascii?Q?+atV8W+azwWVrVB4lUOblHMCbypnv+9gVvOpJvBG0jEhlCfeNcVbiV+9yXhf?=
 =?us-ascii?Q?wt1sHbNpLpY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3hDUekKzkt9xk+jYkD8Adl1iuAa820F96dx97dSmjuyKGCIJPU/G+1sLN8f?=
 =?us-ascii?Q?oOAuIZiPzQ1TJbL17Iv27uNnUa7CGwL1xHaRaIRW5gY8IINFReh//c4zB8h2?=
 =?us-ascii?Q?t5PKgUYtsgXxkAG9iZc9wkDjhkiSHEbjMc5W+CsrwGbRbtPidLT0UrG4bYpQ?=
 =?us-ascii?Q?mFqnU31tuDoIwTUR9AVvfQjv/oF7ZPBlHXn0pRvwzMLuePI3Okyryk/Pj8f/?=
 =?us-ascii?Q?AWQwHaJfqvm/Uu9/2TKdE0RuPLMUIPK06FpXj5O/SKAM9T1CDkhylrm71rqn?=
 =?us-ascii?Q?GDRp1xiVFBqVXPfpGjb65kakwSEIstP1qCcvZL30QoF8H5jFVrTW/ZnSsyaD?=
 =?us-ascii?Q?+Yhy+d0P3FU9a7dd7bfg26untikutAQTVsjsiofuh6TY+/CKBvX5lNtitwvi?=
 =?us-ascii?Q?/tS04Q6JsmupRZXouT1Bf73kYAchD9FAM6zMN9L0eSMNYG5AULUYMzzTO3FU?=
 =?us-ascii?Q?b9kkw55BVoNZgrg0iuO4rwTNXtU832lXU9DEZeFVvov5Laq8T83XLu8Kr/sN?=
 =?us-ascii?Q?hILR+VY07s+2nFWE7rT056oVVOajS9RECzWuX/0zYeE+BbIbbODjNsRShZ7E?=
 =?us-ascii?Q?ajrkaPYW6kWIqlFWyJW5OipoQ5YrGv6CANmZOSPSjhAKhSZA5CHOJg7atnQc?=
 =?us-ascii?Q?nZH4p8fsctM6qWlh+xshTXomacz6WQrjJMBwyI1tVIq19IsGMKpOVTARkwS+?=
 =?us-ascii?Q?IMNeP9KayDxUG/yX48KxZ/5iM4NxhbMRPCZ+ULzWmIZWkXglaeO4bV5kQrSv?=
 =?us-ascii?Q?zKy3v97V3gQiqznge/u9YlHSG1mHf7EScViRmEjL7INBCRQMnr+AKi9zcsz9?=
 =?us-ascii?Q?QtBBjqKdbwgdB9YIQgYipxr6cBNLdiXyqMkgMXvBJ4UMHEZa+jqGXIAPR5fK?=
 =?us-ascii?Q?4Bycq54Ke/AjQ6BgcO0lR3Z2J5KAykegA/KZ8KpTNlo3kNY7k51h3qhp25zv?=
 =?us-ascii?Q?xlwTo8DyqHrjH5t4fzt2Bx9vK05sjPjDj1rJDDgsrR8os94e3XXdo373ML6F?=
 =?us-ascii?Q?TMq+cmcetJB+SC+67TEZ0//HVFingghYcgb6+H2hDUg5eTG/KHo+CO5o+glV?=
 =?us-ascii?Q?wMOc6VycGJu6JIF54bLwAEJCzZKSag0oVxs6K/mqcNgS08IHWeZ/RsM7f3Cv?=
 =?us-ascii?Q?2R4XE9NTTkLQqLC44RkKHmfyRZDA6yCafVigN9IocFgfsyd4azho5lVF3ymS?=
 =?us-ascii?Q?BCQlLrenf0/2uqhC9xtLOT81nwSsH+y1wdproQrrx6IP/MnnXevAH4BBBHjP?=
 =?us-ascii?Q?u7qHf6u2BvedadlsV+BwH8vpbMQTckAROLHa127pYqwHckM+PkR0O8nYGQxz?=
 =?us-ascii?Q?l90gvFPwsVzqrGltHCXUitiMglkY7nlDt3XwBrQO8VohqS+DsEnYKFrEGXJU?=
 =?us-ascii?Q?wRqAIFkFDDL6wN0o0UeOmEZQtFeQ8WKJXZRNddeYvrMrBmogPZeYdGvLbxs9?=
 =?us-ascii?Q?YqwqWacXFAENG0TvsGk/LNFPFAYM12ngOtXq1wJciE2OpKgUs9wPD/QCiaWy?=
 =?us-ascii?Q?CF6svT8icCUftPT6VKSZ2YuNUYSxGe9aftt4GgTFUycXkS8Mg6ijlsuWuuEC?=
 =?us-ascii?Q?6toO/HiCHaM6JH2Zx2Dyj8wvMu3PNKr83fzW4qP9/xXUol1p6irT9twcVNCP?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b9f937-421e-44b2-d2a2-08dcd11e25de
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:24:19.5905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G5MkkMPs9fiP9J3Ly7upp37SS6/91YyLMRVMX91oYI1MIuUn5rfOLCjtuEOE0bZB6wLfbh6T4aPot8YvD4XeKxinS7I/q+Ht5y19OTS9rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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

No functional changes, just some refactoring to match better linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9629fac3388..6ca8b7c80cc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -160,20 +160,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct udevice *dev = spinand->slave->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
-					  nand->memorg.ntargets,
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -192,6 +184,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct udevice *dev = spinand->slave->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -1073,11 +1080,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1110,41 +1161,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_manuf_cleanup;
-	}
-
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
@@ -1171,6 +1191,14 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_nanddev;
+	}
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.45.2

