Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A632ECCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 11:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F367E83045;
	Tue, 30 Sep 2025 13:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="tp8/Z6fa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 830968349B; Tue, 30 Sep 2025 13:03:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9EB828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 13:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h969evkeRLpUcU4NEF3Daj7L7Avd3UEukiuuNrzBBvJa3KKKiuIhykx6fJNXsMxKEh2HjsHtAS1El4h091Z4+ImNu0fzWRON/w7f9AW6OkIUAeRbE2gg/NC/Cv4A++lDpdFIxXES8ZoW8O7CFqqXuwXW9HZWMgCrikdJWs7WqVSb19K0HKPzQ/eMjnS2ZiLr3M4/Dvts4IniKQfAEzRdiI8wGr2cmQ8MLWYJgMxK2rMyt/DBmahFJc+Fw4ITe/hOIKkm3OV1hNRfgspLsTCyWL+6CPrRZvw8XN5IToInlJQig6wo1S0jjM7IOpOoaSrOxMExi/HIz+2EMOLGi2nsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbiImkL30R3AUdCxQBcwAjHGwA1aA/gdYk5NEp+x/Lo=;
 b=PJgRvCHEGeOS5edZLzIIrpjmSWoULRg/w3FnJjoDxX2GCVo8K/27tudzz0zDNDi/iOEJHVcu0N35fT/WtRPDH6IcIWM5jDBD0OAPULOd4vihaRo97SJm1inqzZ0VhWwyYlYpWa4HunvRZf1MWOEKb9sY8nMVYKKx70NM8NLzvJy4N5TtvnEDS2yEhkQJ7C1CwPMTAgLUsWmTUsRupyeL3DtyRxlBkNbFbmshQQfsnosLalhw0R7q32Xpcfu8AYXL5dJ3YbcGLuyrsU/PeNpbOQE+KoOfdtxG1DBcPRa0DFRXvzSZHoe6qLWagbapIjZsFfx2EwB8w6iY9bo8jed1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbiImkL30R3AUdCxQBcwAjHGwA1aA/gdYk5NEp+x/Lo=;
 b=tp8/Z6faGUk/pMcOp2CIE95OtBFFFI/g3RSWbycViKWXNXqfxlrVm1fADGRqjTV0caXRrWGaJPnRjm1ytRUapi86i26BCq6jMjNZVHc7tIWSVcgzLEDFtkqIdy4bvoRtmnKCj6G/pfDCrfWNlXBRSnCP1KgRpm/Upinz7iPqshUp3JYlIG1YasEtH/qAq7dbDPqkRrcraowCo5ACra3nFTSU6DEMcT+ImhPmX6i5F2osedhY0R827MjS6CWo09PMQdQSxL9KnVrjd0wj9CKohilfGVUB4mdjYjFc3c8XSGqkoEfnMXiGFedtyYH20DrDmfOIFnI+WWYwrszquxDzFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11605.eurprd08.prod.outlook.com (2603:10a6:150:2d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 11:03:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 11:03:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 2/2] cmd: mtd: add benchmark option to the help
Date: Tue, 30 Sep 2025 14:03:02 +0300
Message-ID: <20250930110302.4031642-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930110302.4031642-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930110302.4031642-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0354.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB11605:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b0eb9f-6eba-4e32-1acf-08de0010f227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qSs76cqTALZPZTocIVHYTxqGIqfmuHCrmIACCOh0ijt68XrdI02ePVg26rPQ?=
 =?us-ascii?Q?5QhYvaYviMAdLxcZuwKkv8VLJQvyY92rIkxev5R5iRjoB7FrKBXADWWoliJA?=
 =?us-ascii?Q?+jOwzpHO6cHrfNxbh14F6s9eMOyelGjzBkBJpmJ07yXOdeBhwNh1ejRPLl/S?=
 =?us-ascii?Q?hTy0aRVSLWQVB0//3am+wWROGrKK9q3TpBQnJlhZEKv1xPIB0hXuikqeXf6I?=
 =?us-ascii?Q?WMqfph078PVBWTjAlCLIQZwZfgqkR+WatFnos+L/UUcVzUdRKsG4Yw4B6Hpu?=
 =?us-ascii?Q?2HYIhWrWfbaKIqKv1BcCyqFI0tq/9T8IBjLZn08+kce35wctt3EGFmi8f+LS?=
 =?us-ascii?Q?OR07M5tlD45MT8ewbeTCoSd5DYEzx++qL5U9BMC/CnH2iHkrtN4KysKF6hRA?=
 =?us-ascii?Q?Oelvq2RkUocTELmGnRd/xgLVzj1wEQpVuUj8kqCPfD1Xu4h2bbl69v/aOXIh?=
 =?us-ascii?Q?B22M3tkJAoeECuifKOsVtaja5MEo2Wtm7+04eAQCA70ZLWjsu5Edz1jCdqG9?=
 =?us-ascii?Q?mns67fG/6wnxxs1ts099DgAvHmSq1sDKcvmMJrHS3XNefw6IDYVkMFcZFG0p?=
 =?us-ascii?Q?5KK1kb++r5ZJDllkfMLedqtLS6v9cNKHCa4o7xcWPudKPlQE+JPos06TVC3U?=
 =?us-ascii?Q?06iZW2WNf6ufYNBI18ncba/2IcVC4o6L/XlOCJmQ0zVN14D5Ng2aMaQJ+DSw?=
 =?us-ascii?Q?FyFOJwxVhkuCAQZpjmiHlu+BKyVKzDl8AuCvscLGP/O4pB5Fc4+hgNeTunfk?=
 =?us-ascii?Q?xrvCxrVI/KNtDr33qE0r7veBr8gqZmw0ShlE58csGt4FPvPwhdcItsER8lXF?=
 =?us-ascii?Q?MXXf++VQsyN5+ArmhebBiZ9J6MO+uk6noHSBfYRsi6tnkGy4vu1oq50jaXOV?=
 =?us-ascii?Q?lYqW5n37wVvoR2GojNCpTnLD96udQqClnA8wNgI3hE8gHUJLIDwd2o/NHhTT?=
 =?us-ascii?Q?9YYTpAT76nWkGpDMNZnGxp8liXE1Q7mzAfVLO0gvCLhO+juMGDztGweT0ErL?=
 =?us-ascii?Q?WmiFR8E1cln+zjXUEPw8hO4Ng7d+ui3ykAJm0JU35tTUuWdHFr8Xad0swvIh?=
 =?us-ascii?Q?VhlKAJY7gh/xNUrzX6241LTL5YUg+M4m3g55IXUcVNXzT1U4iAsqLuxSgy9y?=
 =?us-ascii?Q?U9Pi3Slxz01gi7pKfk9Xlzy/hd4Oav8Aj4BXGVWuVIceVOMRdq5dT0Cbm8Cp?=
 =?us-ascii?Q?3OKuQ7Ai9wnKqP7e/MXlF/eZvW2p3lQptUKrjaMSaFRqbkXJuVvELojPqGKQ?=
 =?us-ascii?Q?3j1dLZF5NSLiKYsBi5na5Opd+/IRSnv3ABND7Agb9e6nrateT7Y2lmkmHqWQ?=
 =?us-ascii?Q?WNAzHoXNDJ631nb7zaxBgmsUrPR+mkYhuKI0zr7OnF/CMTx+RnbPX+wZHD48?=
 =?us-ascii?Q?bdAnLN8Te/fh9NedQUtlG51BV6AkahO9A/0aSgDSMbTR6vTKmnieNVP+ZtI1?=
 =?us-ascii?Q?D3FoFuHy3Vr0Ba7ZWHJclGI+hC4WdgUUdsGffkZs3z707JLIg8c+vn7wBWtX?=
 =?us-ascii?Q?sU/nz2suWxf6VytJK6+0otB1yjHktgDTTbCY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xu3BJUexF7h9nGogjBz9JntcIroYqYll030ETgzioSwzBYyjgke/BWZRQF8x?=
 =?us-ascii?Q?C/HhqGPiwf4fvkmkPDdRSAmcbBZMZJKxcSsIziFsusPCMzF3Nj40Ww4+LEu7?=
 =?us-ascii?Q?U0L2iR+5u6lfXEjoogT1yl/xc8RExyJHis4J6svIGv30XzL24cJHdLWNUN4E?=
 =?us-ascii?Q?YDU4R3vkAZr7F0YkdYQ0gUpSHxcsyuIQyPFme9iLyI5PZXH70GdHzzuV87HM?=
 =?us-ascii?Q?EMyxfhPnboD/QAl/QeZamJ+GDR0Qg9JN7Ot2KvTkFpaqINJFW8NQabe/uH8Z?=
 =?us-ascii?Q?7pX2ttZfAcSf/c8vB8Hrj8bUqeh4EKXvYvMOwC9Sy7R8S0ZX9erBAZ0pOwdn?=
 =?us-ascii?Q?+RJEc8aont17yRqkNjCdYMaqxJ/0nHIgyxBl5h4st2ictmqVe7oh53i+NiKh?=
 =?us-ascii?Q?2r38m9KtjLvVrtHVa/jxhpaz03uDj+zXa6SQltu9DpNMNjwr5ZvVUHSauGbK?=
 =?us-ascii?Q?Z+3jFyESe0vTUSt4ZAmw3WRKdhJy76bh2X/1j/0eCY4av1+CgltjSJNGPzz8?=
 =?us-ascii?Q?NBnLe44XvJWPkTv6nb5gXad0FPMciaIvEdNSF9N6V7OyjtzIbCSiQVgpqJcw?=
 =?us-ascii?Q?Y5cC/hY/z55+Li0OZjXljd6hT2APlFdSEX5GcqyAwZOp89NdU/yOsTKO9Pk2?=
 =?us-ascii?Q?riH2hqBfeVTeQJ/cK7aj0+1FeKJFuQNULoQozYfXz97kAxkEd6pbHDhre6MU?=
 =?us-ascii?Q?HWaC7PV700NclNmA9IUC7GOZkgsbHWnTE68GeQg/uql+IZkg/ZauwlogNj+t?=
 =?us-ascii?Q?Kn2+qCl7sLNnJmMN9MMrrQKSEdmM+p2YLSV/mc4OxB78+rZoT3UHaVLMFdZN?=
 =?us-ascii?Q?fqmLUTyM+HmeV27x7fDpOwIP2tRaeMFyY+hpWB2dDdmTZPnztP/N1kYXysOO?=
 =?us-ascii?Q?IYMqIPrXbzDw/rKiG3AswVwwJtZWtdaqSsDviPjH/66lFIhgSJnHEKYTPOIq?=
 =?us-ascii?Q?G7YCfW/vi/UEZVzpdjqzzc7jZ3BDIAVgLQ0jpf/BBD279nAgoCYNsUIuqECz?=
 =?us-ascii?Q?ASt0LjrxPGI5xjetowjS+KluxgBvIuSZR86jt9lGquksdR+dsjOZB+x2bGOg?=
 =?us-ascii?Q?UnWNRKQXEVT5BVcyJGWsjBvz/qeb0gXZyPn6rcP+0VFO8qeUSKXkC7UIBA41?=
 =?us-ascii?Q?0m7Wl9TjMTLcEEi+hm9KDm5/z9b75Z7EXky1YlnslI5Kx7VdnBxnQTjL+E6K?=
 =?us-ascii?Q?VVMVs1+b/aTEN2PVKpn5B5TrZgccVoG8A7qHmZIcXij8dwu61+TYXz2ADZdj?=
 =?us-ascii?Q?N28MKCP/t3YO+Ul3d6yv8OLWlEWB7U9MrUHiiXn9arZ5VE0X4MQ3wDHIwSzr?=
 =?us-ascii?Q?sltErDbH/sSiuEfkjHqF4fbaT8O4UGIHhia/dd4q4q8/BeCTc5bjZZ6WqzQw?=
 =?us-ascii?Q?wtAiTXuk/s4cn80hP5QyIiK1nTQCe01enwcR8qONxZDuVtXWG/LvUMMIs6IJ?=
 =?us-ascii?Q?H64LpKotMInw3G4WlSCZ0ulBzzqbb45FzMoJTpSfWfWQ37BS6EpUlqwAX1hR?=
 =?us-ascii?Q?tEPSeJab+SSyqQdZMQ/LM/xv88kUOk8XaGAHhOwTpV3LwWjI81V/r3Lhad5H?=
 =?us-ascii?Q?7KFYdeNSb3yR3BG/9fimOh/uZMMCrOWHm3A4XElLB8xq/olsuKiLJwU/wsYS?=
 =?us-ascii?Q?/X1rKwA8G4lGTgY684PthRw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b0eb9f-6eba-4e32-1acf-08de0010f227
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 11:03:11.7298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGspwLqETzjchqQKJRvZwUgDO/jBmFU6yobmBxUD+rFYSfdZNI1t61e3/kjHm3wdq7CL2GPnRWBWIhF9R7VgIcizK5bHKbKuNoCpFwiZo20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11605
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
 cmd/mtd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index e415a2d7f02..acd886da6da 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -1216,27 +1216,27 @@ static int mtd_name_complete(int argc, char *const argv[], char last_char,
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
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
-	"mtd markbad                           <name>         <off> [<off> ...]\n"
+	"mtd markbad                                     <name>         <off> [<off> ...]\n"
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
-	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+	"mtd nand_write_test                             <name>        [<off> [<size>]]\n"
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
-	"mtd nand_read_test                    <name>\n"
+	"mtd nand_read_test                              <name>\n"
 #endif
 	"\n"
 	"With:\n"
-- 
2.51.0

