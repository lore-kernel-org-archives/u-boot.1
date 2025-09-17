Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E7ECAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 21:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0683A8318E;
	Wed, 17 Sep 2025 23:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="IgGHBg8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F54280C93; Wed, 17 Sep 2025 23:47:24 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2100803CC
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 23:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsyR3e7nbzR258huRshtseN3nzMMOetT1E6bvg+rrCNqGlWN8mOu0+wt/P+9ytNY6aZCa/I/pNxBBvciqNsgjfxqfdnraF1P029LB7Mk9/0ezg/D8NUdjeQd1lRjo4totWs/gyXstj6eBLLnNUnVNKYip3u9nm4MDH3SSMDpYnGufDuo+IGZ1bkqnm8ONRtF4h8s4H0f5+WL643Jv/sP081RyajhaM+8hHKBjv4J1jw9yZ7vSn5g+AJ7Bf/v+AZH0frqSdXolH/p5YbU2c0DTv8oJ1NBzoylCn+DmpILCT1+iIIYAaJY8VK34Qhu64L+oAu5xMq1xCrJGER+VqBJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8qljCWrawneECtGE5L+PbJCHhq8vTySe1X4MKhFfw0=;
 b=sofEchI5KLd8pUrOrKn0aVqoD0eXaf3JJnXHcYPlhxQYcariY7QDbRumFKP10TFS9oSVOiESEQvP/Rj6MQYNWpJBguSBIsuQy6x34I3rTUk3f4TE9xRO/vZXGAyi5oCvLzWEz3W2TZIMLFtK4Zsi+B3Pnr4zwuaKOAQGwIH2UKfPfNa91m6yp+HpbczuqgCcfnwe5m4uWVB6w/JJKqY/MBBapip2P+x9I8fHGHb2V6b/WfTkgtgBYXoU1dNIZwbSMougco5TYRYsyg7xN4AsdJoppURkOKLH4DX+Ptz9m8oxndyCB9IFSFhL3hTne74qOjaT3F9LTiErlH5vndWOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8qljCWrawneECtGE5L+PbJCHhq8vTySe1X4MKhFfw0=;
 b=IgGHBg8YyK9d30eCX7wZBoDh6e6nfrNWfdFc4vt1Au8+iIjmu1Q7qw7Jn+iMR1xgq5H6csTj6nEXS1x1ulSvwUGWDZ8+VRI9pjzeMOEhv2oZe7cCgiUJr3AVn+kM039Ia91m0VPch0Qxf3SS1nl6ixT19lpKXkLQ5CO3y4c5f9nd+ahhsl2iWRHN07a+zhWiCVIa/9VtVUy1pTJ4mvV17dlpYJQMBRcs9Xt3KxJPzxiYS9jYavVcPZh59etEztMDWcGQvv3D52+2nt/7HhuTa+5u7ok88h7+KIFOCRaj+3EDr6jjqAkOFZ9Mv2KDsg8mUvysLqLktEZsF3fQgbKWMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8188.eurprd08.prod.outlook.com (2603:10a6:10:3ef::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 21:47:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:47:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 2/2] cmd: mtd: add benchmark option to the help
Date: Thu, 18 Sep 2025 00:47:06 +0300
Message-ID: <20250917214706.18130-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917214706.18130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917214706.18130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a475819-b770-4351-15b4-08ddf633c54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rTP3TFSg5x7QOz33A9gpRnPCpPI4Dw6W4mdDLm9u5wpbuJyHPd0d5OCnN83e?=
 =?us-ascii?Q?aGVNH6HdSBLVfZ4q1SXJy4Z7qnbdBqUPndxEW5Ink2oigHjaeVwmNQc6OIP0?=
 =?us-ascii?Q?D/6iSSlwdUC8iVGXBMHsAHlprIrglSvOVeApCMF56f6eesIcAtNHW0ytQAPN?=
 =?us-ascii?Q?W/4eJhbzGIpB7/SC+00DFWU9MFBvsb/ZU6nsiPYPKtAvYif+ymyDQcAwdbh7?=
 =?us-ascii?Q?t8RabQT5QcL46kEuWeWa1uqaXTIXIq1HN3iAzMqDnQIhPmxXkK+HtuOufJl9?=
 =?us-ascii?Q?ZZ4aLeCq7EWuJlCQHlsYFuPc1SATFpJXzwOVFNC9n+ouivq/Xm66XIz+nwwR?=
 =?us-ascii?Q?f8PvQSGHFwl1P9qNn5mY8cFUvn9ROuENKytoZ7K6j8nvTn4FPVhjTCyo0JQQ?=
 =?us-ascii?Q?C2GeK85KE+qIyzGHF3xB6SHOM5M8daSqv05oTReGqz+UOZv5rKu2dcDJGvS2?=
 =?us-ascii?Q?LcalcxhWEz8Y2GqoYvoTvZDRgaLGvHegU/ZXUWHCuq/ycucXHPNPskcMAJGt?=
 =?us-ascii?Q?sGu+EMsNuWV3CvNBEluhaELpRZFzP7XykEyMe4i/Ci03ZdQbrfJOJXTiX3Na?=
 =?us-ascii?Q?HCfVHntJjmY0/5+I/VuWq5SQd+SDn2YZ52TevVGsVuR5ShcsSkbOiT37SvqL?=
 =?us-ascii?Q?omBBK2pf0S0T6NF7oL+1Lws7rkVEZ2FHdqkb4h+cTaPw6qCLaU3SfqqK19T+?=
 =?us-ascii?Q?6DRgHGPLZv7/Gt1bPenIZ1HlapDNLhUz7Mv/n1SibRk5FCVYwej5Ou34BKKN?=
 =?us-ascii?Q?aPKMFkXi+eNajWI3YApKev7a0hV7k/KufYrSqNkabrQISsPhdIAC2KHZuWyR?=
 =?us-ascii?Q?YVzc1CrnrGe7X26VApY6PdOxNpJb32UO2E+K4WSWLT9FeVuDD83OvVswbfzA?=
 =?us-ascii?Q?y6tTRSZub5/pAaxQQjULagYdLecmmss7YyhhKmrtlofinf6zfxDLPLQmWVN5?=
 =?us-ascii?Q?mZ1jut2Y5DYGf5EgVjWhxAH4wp2INmfvVOpWVU+RfkuSSuX2HnCB4ZWTcYcd?=
 =?us-ascii?Q?iRa4lb63jbkSPyVEoTDZea/7xuWQSdbGZfUo9PEn+Ttvj2j8NuVqLmnUYTJt?=
 =?us-ascii?Q?fpXkpG3EEEQJORPMVYHa4fYHtuhwCP8z6dSAgZTxceQbEAKFM/Y5kvWsnIC9?=
 =?us-ascii?Q?kdgGAeqDcVnVa6C/S25gN5Rk5NepdYFizcc27d5/Ez5Ru17Kkodgb0Lm6xNY?=
 =?us-ascii?Q?TYYrmdClq/tjRptlMfemGK9z59GrUEI4ndFrddxBEaQ154Kj3iySq5LvUpHs?=
 =?us-ascii?Q?GnguLNlNBmdHWk7zeDfPa0f7HZY4jEjrsQH9Pj3km8hDk6+zjudFoP/JfSaV?=
 =?us-ascii?Q?nvVoakHs0ItbzADSK8RJO9QdzU7MMs6rF+Z+cjnUHsZYA6+bAtMTXTA9PoyM?=
 =?us-ascii?Q?GqQabzI0iy7F782sFJXhp5cvinoLDmlLt6YjePZufQrF3wUTCTI1jeHyAFTn?=
 =?us-ascii?Q?/e2+FeaWcC+ef16SeXeS13s+N0d/RK9zMgXBWfGZ0RKxIf7aGvk4JQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0pfpgx+zBaoFrg8sZJf8xAFjMDQKtmarGvEjj81zBLNyapdyo5K7ZgvbyCd?=
 =?us-ascii?Q?AvuTi7HtIZkBTWCLJ+z6pKAl8SpTaj+Y7FTwXt3noYCtpLKrEubC7D7WQgZM?=
 =?us-ascii?Q?qTx6mQhnMZu2VKR4SzgUhpEqfWzvKiZazajgZlfdTTlAfEbjXdJpSZCUThDa?=
 =?us-ascii?Q?SzkZwS/DjnwMTYV0NHtm+rjCW93mFsBrJBV/a6iOICuPDdP5mqcTzaMaLxIT?=
 =?us-ascii?Q?0gjYXJT7eW9I7mFBbol1oHwhS9wN4x1RHGLPJTUDzW2BKzB5/C76XR8sCj/z?=
 =?us-ascii?Q?hlzopOFhUwtSxk5HkqsUt8DPdvV7KVzkFxqdsrtMU+N7kcUk4QbzN147/NXI?=
 =?us-ascii?Q?wYgLOw9K0Xbn0B4bz8ko3b9Ryq5Bem8InBg85wXWhGmH3IcG3gQzp/cxIt+w?=
 =?us-ascii?Q?Bzt7WPeNb3hDAlr6AJjnSMzst/B6Oig74D/So4+3rc5O+SsjwhWFW5gfwwaV?=
 =?us-ascii?Q?sQwdQnbKfEH8VD3GTPYFT72vmNIMBsPJMlPc3j2pSOv+abg86UgGknA2NiOg?=
 =?us-ascii?Q?HPrhJWHQoRQdjKDDmfS9dsi8o3qxhX/KVRH68uB3E3EDWzpe/b6VI+xr6psa?=
 =?us-ascii?Q?nnHP6rquTda5cS02bqd7YdrUS8WQ8IJU5IaDB9LUkOtHwJTKXGkf3ec0dE2C?=
 =?us-ascii?Q?ufZxUUwtAnsJKOtMTiMTirtjk8wuN4ue9WtgaJNGYfmajPLCAbewiexgOsK4?=
 =?us-ascii?Q?hJ44oSfcksEicjKLknBUbuNpMwU50YrUmyN72ma62bM61UB4ZtS6ppp+ZaPp?=
 =?us-ascii?Q?amXA5zgOrmP6axZTgOkDkArUvVwLlvXd2C8HipCAg7hRPKrYGAWJcOgT/j1M?=
 =?us-ascii?Q?QequZL6BkY9VEpL1EaMXZkbSsIfSFJvjeioBMK7Ri0tHqSJivlpH7MgdO6FB?=
 =?us-ascii?Q?n4fOD2z+TYSBoAyRwMpI8Trwnl7X6AI8lbHKDxAtpwgoxETkn9FxzdOdPLS0?=
 =?us-ascii?Q?eonbXxStXb5Itm5ZfhvAT0uVvSInyW+cgIKtUtdj/ZuvMUa4Xcn2R3bQ6UUR?=
 =?us-ascii?Q?vLqsxngF5Yn9/U42ohnoxY+mjWj8ICOilUqSo/dutDu8JoISY+AMOp8Qp8cw?=
 =?us-ascii?Q?Kg08Jc+N0slUl1+qXB1S2Db+bxjnnRXs3jJc/9k94qFfZCnk2cBkOP4wHi4o?=
 =?us-ascii?Q?0QgewAaegxbFMZd0SszgRUaJa+Z761PVWDrl3Z0HFY19m0FWqiHnddv42O43?=
 =?us-ascii?Q?J8D3rvYN/daxbpJwtF9JZITI5x7AzIMOwwOJWJl51s8HSggeM44KdMYSUdrj?=
 =?us-ascii?Q?EO7z4yPZmE8H3PlgwBiE4iaj+Uv2S2Qwtndp8ys8ptitrm8/mPfCHnSji2TX?=
 =?us-ascii?Q?Xe797obTnaWzmXqpbXHNZ1ckBt9GOGIphfAaMfsP/2vADxE9PSvAxvuIqNat?=
 =?us-ascii?Q?ctgBsOr96LUi8636UMB+OckbRNE/HEn46gzZxSxDsmmXXMZ/W6ltDvSUAduz?=
 =?us-ascii?Q?kgzjrsWTXG5jgmWltQ8vXCUUPA4Eg9vi6cgsePWJZk7YwM6gWqJI2dMfaWij?=
 =?us-ascii?Q?y1MGwYNkz9T7wgHUyIgLuSGcbFxlfYqgGK2gklYG8nKKobVwWy7tjil1H6fm?=
 =?us-ascii?Q?pwBdLQcom5VQvb6fbLCgd4fFSs2aLItFwdGo9AUwklP7z5gkLjW3tgMMB3Oa?=
 =?us-ascii?Q?frZLFjXrV8SQxbb+FM+TYFE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a475819-b770-4351-15b4-08ddf633c54f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:47:17.1986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8kwUHowwXaMtIeasVlzflps4uCq+0lvZFxy/Po7mU7WpjaRxOcYBvykl+7PxyodW3+le2u7f15jefi0yY+zdxkYKbjzaVr/w0/9H4HRYBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8188
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

The patch adds benchmark option to the help of mtd command. For the
'mtd write' case the help line exceed 80 characters. Ignore this issue
as modern terminals are capable to handle more characters.

The patch also formats other command to make sure all device names
starts on the same collumn.

Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/mtd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 57f6c700f1d..f053dbadd78 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -782,18 +782,18 @@ static int mtd_name_complete(int argc, char *const argv[], char last_char,
 U_BOOT_LONGHELP(mtd,
 	"- generic operations on memory technology devices\n\n"
 	"mtd list\n"
-	"mtd read[.raw][.oob]                  <name> <addr> [<off> [<size>]]\n"
-	"mtd dump[.raw][.oob]                  <name>        [<off> [<size>]]\n"
-	"mtd write[.raw][.oob][.dontskipff]    <name> <addr> [<off> [<size>]]\n"
-	"mtd erase[.dontskipbad]               <name>        [<off> [<size>]]\n"
+	"mtd read[.raw][.oob][.benchmark]                <name> <addr> [<off> [<size>]]\n"
+	"mtd dump[.raw][.oob]                            <name>        [<off> [<size>]]\n"
+	"mtd write[.raw][.oob][.dontskipff][.benchmark]  <name> <addr> [<off> [<size>]]\n"
+	"mtd erase[.dontskipbad]                         <name>        [<off> [<size>]]\n"
 	"\n"
 	"Specific functions:\n"
-	"mtd bad                               <name>\n"
+	"mtd bad                                         <name>\n"
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
-	"mtd otpread                           <name> [u|f] <off> <size>\n"
-	"mtd otpwrite                          <name> <off> <hex string>\n"
-	"mtd otplock                           <name> <off> <size>\n"
-	"mtd otpinfo                           <name> [u|f]\n"
+	"mtd otpread                                     <name> [u|f] <off> <size>\n"
+	"mtd otpwrite                                    <name> <off> <hex string>\n"
+	"mtd otplock                                     <name> <off> <size>\n"
+	"mtd otpinfo                                     <name> [u|f]\n"
 #endif
 	"\n"
 	"With:\n"
-- 
2.51.0

