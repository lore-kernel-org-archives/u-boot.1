Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB2ACAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F340083807;
	Tue, 30 Sep 2025 02:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="LD3QtVzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B217836F0; Tue, 30 Sep 2025 02:21:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26DA68362A
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9lWYu7WI7J1KB9b7VWGznscIlLpEz0DlyNNm5JX7yez5DHAvsdFhiLvQ8mA4oP2Yd2tTvGc42b+XWCWYHxsj1v1jhBk/FoyPoXrcYcIzRPzwSco/A082N9xYbsowi3SoCNtT16QMm5gPNoreWgrv44DrB2NWCPeeENhvD/hCn+x5M+9B4fIEsbaa5G0jCjAml0idDlNtzjFjU3ISa+cZXDq+mezuAE734BaLJZhWGYf4n/VZ0jOy+5yDpZEjNmmRAN4k+HW16L2WloK1fpLSUMqdetQX7iXkGc912ZhP/FGlLpsB72Q99AkME5cSV7HfPn031YJLy9Mpa+PGR5HAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I4TTTiDqK2qN+U76rxSsudVvQxbczZ9H8gSjoO4qh0=;
 b=rL6RFlLEqe5xLHGuqCespgmRYB5+XyCD5QRD8wC30zf1asest6UM6Vw5R1SzEXGZvGA9dKvJWg69sbxho1bxIGG6MzRSifM8x5t6Dcl7ap/iyMh8sf2CpvKc1oHB/b+W0WkBa5Rzsz25w2mVyoCnFNshjeX5FcETxJzcavZMRthgghMtfPiKTc7Mj1bLh9tacZVQqpjf983NPOmaVFLHw0hhXrKDtePnpnL2KPoETSZAXMJM8rMP/gqCUaHZBRyMUxFRb/f5Vmwm3slkxYjFijZXnveX3b+vc4TP3qfFcbdqflUg+/K4XBaQs66TbOVLCJA/Jz47H9uTFy2CO4pCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I4TTTiDqK2qN+U76rxSsudVvQxbczZ9H8gSjoO4qh0=;
 b=LD3QtVzz0l/PcgebCxfRx4p5VSKEGyYZzLTj5rG46RUpGirlccieSuj2vY+wWRVROY+fWK7Ptj4toRr+zHqu6zGU7taWqSV1iF2+MV3DYcNyEMXbsheJrwCRKUtKqpvwHZOK83Ca2Cg8B9QDDaGLv3TH8P4Wvxlw0h/P9o4L/C84N0vzq9atTCK8inp7Z4HixQTziIAKgb8/VtMqJkb19BZY6Sv0UlB0afn/nS5bnBXFxxY3x5xzYYGRlE3b/oBTRr3ZKxIXISuaecWCjPBCcO1A2pcQwZoSwidxm5jIO8hS3QgRU/Hmmc9z/Qml5xbCxZxOmtULYn6KLc6jkG0/ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9417.eurprd08.prod.outlook.com (2603:10a6:10:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 00:21:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:43 +0000
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
Subject: [PATCH v7 20/24] mtd: spinand: Add a ->configure_chip() hook
Date: Tue, 30 Sep 2025 03:21:05 +0300
Message-ID: <20250930002109.3600886-21-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 2070a032-5eb4-4d28-43cf-08ddffb7556c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jNiSGOUAdtLRaenXFr5ukqa3av2Cn9JnnXK67/8KkXDWs2KP2A7/1pd9OT0T?=
 =?us-ascii?Q?Sf2z8/eHYovAkt3ZSWrnji/aTF9QJyckF4/KKgdUkLLI1+0jDQ1HWJL76TWC?=
 =?us-ascii?Q?UUWn8+cGR2dkRSOTzAVkvJo5ZPcoSVrtATojd7Ub2BvXYgQNreDMut5qH42b?=
 =?us-ascii?Q?mcFS8UJ5BSGtYCXnXMweAUne5lNSmMAPngUXJWdmM1bv4qQEEGaqDb8HvmCK?=
 =?us-ascii?Q?qTJ/PH7zA8xqkoplwwBDBiJ85mb7z7skU24Yf5fT5kRzlmkRsJ/+Qg/lZUg8?=
 =?us-ascii?Q?JJc33Gm1v9H/Pa+q+z5t5FiNjevl3KgvS0VNbY0HN6tfCUx5YAnVQ66sFNkc?=
 =?us-ascii?Q?yADDE3ZXSjKAF4u42dzh5vsxqZWFz0+Y1IMyrZtoQ/xw+c4Y78gJdDpNQufN?=
 =?us-ascii?Q?6F8HwRLrVIszZx/9tKbDZxEyqy7gw/qU/dGg5RQWxzitGDGHragwU1QZvwoy?=
 =?us-ascii?Q?qRuLL88GNEbVu8UfsG02pLpBXGXwBX7kp1dM1Po//gMogiLZK0nIzghJRzOH?=
 =?us-ascii?Q?Bk/RZrHZXIGTbSEKy37BGVddp4ZguneQibL6EO45xeYoq4eHrZxZAFnTKh5L?=
 =?us-ascii?Q?I5auGCE0HQGTz10MezE5Kx8NJ3K1Wm46mOfOJJ9+RKYXuEY5MDDrUw9u9/tJ?=
 =?us-ascii?Q?nI2Q/AJSr7lUQqECHjovhyQrAWJsMAH33gAeSn97AXUTsvch+W0cN5D/3/JZ?=
 =?us-ascii?Q?4UdbYx7+ItHDhiKZNND8epyzuvbSmXRRGHwMAibb6ORBo/bG43iowvhn7LB9?=
 =?us-ascii?Q?Ew8mHXm9olpk/rEPSCT8EQaBFUmfAO5vh7+QHQS0jswXcZsVqoQKyUfOmpbQ?=
 =?us-ascii?Q?yHmUXph3ZurbadCw9Wu12j+RL96nRxpZ+kzauivTtQztYenOiMybEjYFv42+?=
 =?us-ascii?Q?q6Biuw2Z4YW3BB2NhVOWj535t4B8CWF/FC45VNydrFwitCp2MC7dbfzo90ac?=
 =?us-ascii?Q?e4/1H2YDbGIonybErFQ0rq4TqOvXAGHL8V0E9Kkd65rlQiV3b0Ie+omngotH?=
 =?us-ascii?Q?oeUY0ZzwJJxnT2XqOo85hL58i3y+G+reTS9OCplSalfURUqWWUGSssC5CxRr?=
 =?us-ascii?Q?wlaNDKgL2Wfwh8pqjd1Lqc7VIpInxwe71cMedO8Gx3AHYSO+ljhp8SfJ3L/x?=
 =?us-ascii?Q?55h20oHxv31CDsJGY8xjFZCO6GAxGiTdyInX4vmBDMpamf3iBsJPKSawQEkN?=
 =?us-ascii?Q?6Dy9unp8h17sJsr+vMS9XKj61wDQPxlZ6GGFBLAzo5X+VueRKrxcXMY9gWks?=
 =?us-ascii?Q?0XakHSt14bUB/fpzggvp1bhNj4DwPwROgxGac2Dl+BLRnBRpBqYmYWr24Es8?=
 =?us-ascii?Q?+Etgxj9BZPD2TTj4vjb+2lipt/gYfR9UFXRKMBNHL41e16JtQQO4QDuNJL/m?=
 =?us-ascii?Q?PG6y4sWsGoP2rQ65bKsis2WDu+vDqGOHvYXZU4KY5qhdMV/bSAVKumSmC3n8?=
 =?us-ascii?Q?XL2ACEN5ZzuinBqjkzYu9gMyj6dyXkySM116vMKTJskqGvsNdXk97Mf7C42k?=
 =?us-ascii?Q?SOLjj13AcXHV1cCSdOr5c8vbAO3MSfck+xsj+SkSoJos8yiLZOwr0etxjw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NtOaP+IVTbHIs5JXYB5ktqkVlLhM2DPF5cTY48X6tA0ffIGs90sgmwIoOWnJ?=
 =?us-ascii?Q?yRc80xqkodllK5FSNd7ub5P1tEugAs0Rmmcju82Elg4t+fXFKKYtZZ2ybciV?=
 =?us-ascii?Q?PDC2Q+n010BPekJ/yFkgL5/S4Ikw60OIPQkSsLCRMTXWFJ/cz07+Yu3fHrRU?=
 =?us-ascii?Q?oOOSrMsNjtueLjFn/h4mFjmaWj61G1Zx1Zg9du1e6tUNBTSk1hQ+YFTZ5e5X?=
 =?us-ascii?Q?HDTnzGjsTXOTQjFcidT8hdyde8XZ/6ilN25c21duwybcIAXle7eqWnHLVvYT?=
 =?us-ascii?Q?42+SiU9jaP5ZfjnFNejGj5wvKzVRcLYesuRYdsLM7K5Dad9go56QOk8jBBJh?=
 =?us-ascii?Q?jABCnqQB0OZTPRe9RHmp7oHwL3AzL7wwqCFHG/Bihym4LzdfDpbUb3kudSeH?=
 =?us-ascii?Q?hma+jwN9N1YekZLHjJLXI24xPaVEjeFz9lPVya3yCpbo06O1lChedz2q1Gd1?=
 =?us-ascii?Q?hKvPUowmNzXfXhn2W/C5a+MNHuEyxll7jbNZ0qS9XAvlkdzt8azztIHKqfDP?=
 =?us-ascii?Q?M9WZM28Zl5wrvCHw5cFIYjb1XSxPoDWMzxU1Z5CpUi15N+VOMxxUM/Bn71gp?=
 =?us-ascii?Q?2L2sZ7/sdnqPdL0FIPjVt2xpjfwMy3EL79ex+2v/jEf6isl/hSeNLtAAiPjM?=
 =?us-ascii?Q?7yOCg9mLeDUh4oamjb3h5FOmyuSA96klQAxQiS4lYQkiUT7D6L+LBwdyYr3T?=
 =?us-ascii?Q?yEpmzxTBJqMhSAyDR5XhcR2kaeA7T0w+J/7Ly9XDB+9f9C3v6PgiUnEmNmqb?=
 =?us-ascii?Q?i66ZKIRK2wWqp5rIyz1/9/wkkMU/wetnuH2f+6VvM9H7AxQU/Seigs3jVyPJ?=
 =?us-ascii?Q?i4IHXF6Fa9p2QB8/Apxlch/ooStgb+QjkKiBGn364x5ccUBRSSLuRcxAtZom?=
 =?us-ascii?Q?UNxjLtf921nmyaEy0hSMlpfcNgktlP/BVOxAeyATSvVKb8wap1uih66wBflF?=
 =?us-ascii?Q?0VYCX6nn9ziGwAY6LBOj6vkxm3gc40frzotdiua/XC74hu3RPCBANW6rR0Kf?=
 =?us-ascii?Q?EP8dKIJ9g79J3J3C6tsySOLxFMVdyg7JteHcyO2IIBUQLi0OF17GdL8uEvnH?=
 =?us-ascii?Q?UezW35TNLDZEIkjXsu52OTZFIC3yqqUI2/1D/63QQHW8xH+vOjZzNqhNsxzU?=
 =?us-ascii?Q?uXHN3SUWt5Dx44ewD0IF443GUW8mKuJUBoAuA0EFXYieF+DR2nq8Vsh5dFso?=
 =?us-ascii?Q?jgxMLdy3PuyMTthtUpBAbnDqt1/hp/2T/XHqmR3tx2LUBWnVJ7HPwUN/wczo?=
 =?us-ascii?Q?GAUBp+8yt1OZv+uILdV+fdMn0jew/huv5f5LB1RPr7RO8tlg5uON43jF/Sqt?=
 =?us-ascii?Q?sQNK0p8zJ0ivzsESucj6uxfXfk778lxOjqomWH7mW96aUOs09r0s8q5TamD4?=
 =?us-ascii?Q?uec0PwiqARv65kgMpwJcvrOI4iicXyWslOGr8XNZlXylFL0hKzwl8GO4faZ+?=
 =?us-ascii?Q?dOY0TKckPvPzowdvcia4GOa2CzSGDSZU/BfG0UzP6Z+3qpeKJxBexozsY0tx?=
 =?us-ascii?Q?88uyOCm+ZWXHgTxBU1P6McAn94Y2/Jk918zZ08wFEIAmIoPYxrTV1QpBJDto?=
 =?us-ascii?Q?tLH2dudpmk8QsiXJoqoBfBBDuK0DNUaJdCOuc3A/JeGdVkgyexi1x0Q6RS/2?=
 =?us-ascii?Q?Va6+SQigibWE+1DUcr0Bij0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2070a032-5eb4-4d28-43cf-08ddffb7556c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:43.5580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNDiovSUadP2zyIRn5GCylxedNxkQ/vKHYX5A29HKLH8vE2oQzmt8CZ0wiQqD8B9UpHOSIHeCKojhGBKwkTiytcEsouaCNKXE0ZldXFpoGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9417
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

There is already a manufacturer hook, which is manufacturer specific but
not chip specific. We no longer have access to the actual NAND identity
at this stage so let's add a per-chip configuration hook to align the
chip configuration (if any) with the core's setting.

This is a port of linux commit
da55809ebb45 ("mtd: spinand: Add a ->configure_chip() hook")

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 16 ++++++++++++++--
 include/linux/mtd/spinand.h |  7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3e21a06dd0f..25e7a38a874 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1251,8 +1251,19 @@ static int spinand_id_detect(struct spinand_device *spinand)
 
 static int spinand_manufacturer_init(struct spinand_device *spinand)
 {
-	if (spinand->manufacturer->ops->init)
-		return spinand->manufacturer->ops->init(spinand);
+	int ret;
+
+	if (spinand->manufacturer->ops->init) {
+		ret = spinand->manufacturer->ops->init(spinand);
+		if (ret)
+			return ret;
+	}
+
+	if (spinand->configure_chip) {
+		ret = spinand->configure_chip(spinand);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -1363,6 +1374,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->configure_chip = table[i].configure_chip;
 		spinand->set_cont_read = table[i].set_cont_read;
 		spinand->fact_otp = &table[i].fact_otp;
 		spinand->user_otp = &table[i].user_otp;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index adfb5f3ffbc..94f324741e0 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -398,6 +398,7 @@ struct spinand_user_otp {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @configure_chip: Align the chip configuration with the core settings
  * @set_cont_read: enable/disable continuous cached reads
  * @fact_otp: SPI NAND factory OTP info.
  * @user_otp: SPI NAND user OTP info.
@@ -421,6 +422,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*configure_chip)(struct spinand_device *spinand);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
@@ -453,6 +455,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONFIGURE_CHIP(__configure_chip)			\
+	.configure_chip = __configure_chip
+
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
@@ -521,6 +526,7 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @configure_chip: Align the chip configuration with the core settings
  * @cont_read_possible: Field filled by the core once the whole system
  *		configuration is known to tell whether continuous reads are
  *		suitable to use or not in general with this chip/configuration.
@@ -569,6 +575,7 @@ struct spinand_device {
 
 	u8 last_wait_status;
 
+	int (*configure_chip)(struct spinand_device *spinand);
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
-- 
2.51.0

