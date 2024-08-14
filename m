Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE99C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A639F889F8;
	Wed, 14 Aug 2024 12:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cpczStdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19AB3888CC; Wed, 14 Aug 2024 12:19:56 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F25D889BD
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUjTDI+cgvfDYXdU1TvQ8A9/Tnc16lu0a4cEw2boA8l649Wof2856jj6Dnet/FsjDdYVMr/b0VkIvFQLqFdmEXwERKYzWBUgwYEp14WZjOsNjKzGDFrK6vkpA1YJiHF6TKU/BVsZbORrZ19CN+Km2Tginriv38llzzugWfNZxYdNWW5js9/IKaf11sx+GwCj8ZFMAFsbfTeR/wC7ALozKSeuXZiiID3VVfsFa1bBJ+GFLCphtQ4SCqKm0RiMFq6bog4trXlZHwT+BkHFru0HIRI5TcnzuzQZta3hILNisHwhanxfA6q1CZLWaBqUJmiloulMDxoilBnggl5WC0s++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ3kjlYr3g9Mo2OaP8bD3XPPaojb11BcMmJVbRwqy74=;
 b=a8x06Jq+CRl8vHg4vdOeC8p37wRzH92MyShntfKDLROBl1oGhf/CPRU0fM59gxw8Rdkn+EkMkDjFg7jk51zndY0WsAIDRGvuSgESxdrEAinjyJRo9hLRReQwloK3cwWl56kneF88Cwq6FC/OxHEwsRYJDz+G+TgG3jwmFgFDuicNilKQ41TMa87TyOkwjk4+h2eEOLZEIsXDz3+fzGEWyYWxC244ImUfhQ8clqKFbi6qQxeqv1x7vDTHf0V1dqy4VcgAOzFz1gTW703AXKTbD2pyBjyqXh1cPNMoBiBl0jA3Un8FNPgHqItAO6mGiYYtoSGQdfwfwVM7Smvc9hSOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ3kjlYr3g9Mo2OaP8bD3XPPaojb11BcMmJVbRwqy74=;
 b=cpczStdycj10e4SOZFkFD0i09aaxW2yYKHEuHYw0OJE6cd1PDC9NjzYKnwJ+T8FQ0vQEFe6j8yRLaN+gNFf/vKN9v0pzNmZ4w8Gl+b8S51dqsHUMFUizrRa5W8xJVHcgMOWBTixilOJah7gB8hrAU4LVQTyyrGxszrKG8DHtTqM4+08425OeN8US8NPOTOIbrAkJGmVQ7i31EY26elP/uiy1LKvVVmrMT4KGMi0fc6yUVGxCtlg/q0WDBTGvfkw4O+8tqs76mg6eYO8aLvP/BPOlKGgmCZyBED9bztkHvJOOenFVFgSpQkOy8P9iR7Bj4RloerregmfNFQ8dLELGvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:19:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:19:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v4 07/10] mtd: spinand: minor refactoring
Date: Wed, 14 Aug 2024 14:19:15 +0400
Message-Id: <20240814101918.1347167-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aefe5f5-eb93-4189-527f-08dcbc4aa2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UJnQOOMtbt6/1Rc7FfvY8nVuaI5Qn0rHPNABgNqd93jLT1Tf+ZbHcCFBxc/5?=
 =?us-ascii?Q?3nmCj+evpLZJ9aA3XZeI6oFLbQnGLDRkRz8isoe6Kt25VY3kYRq8jekiCHMs?=
 =?us-ascii?Q?4zcoNlfLYH7Ai05N5v5tthkJk/sMJyIP90ft+tCShd7NX+fmI437OKTmRVK2?=
 =?us-ascii?Q?/jafI9aCd1AaLlZJoe30fGKaKgnWdKPyBsa5QwGs12FJPqVuVt+Q5Mo9SKW9?=
 =?us-ascii?Q?74H9/DndARjyWnrbANQ/k63odQ5R1mp/J8pYeYiWGNBdI42IyKdVGcF4KJUi?=
 =?us-ascii?Q?jLpF1XgF9O9l4JzFr4m1FFmmr31h00L4AQvCNZrn1+jBM8Me+QLg8YwyLd0V?=
 =?us-ascii?Q?HdxcFuu0da4PeJKS4HYMrYbHIYt83H+yWiLBWNimNZl49UBzZvRUvfB5FTW2?=
 =?us-ascii?Q?GENtNmLSblSH4eEvXG8wKZ64x8JlkX0DdWkz8ANBUQUmuLsrDlXhbjVPoEVv?=
 =?us-ascii?Q?tt60LkVbh+AMXNuMa7qZ/tugOIig73Onow4HsfLoca+UiegsisGAG7LKRwOT?=
 =?us-ascii?Q?icJEmpm71yhkGRtQocy7SshVWgqMDELGbliWdcDmiyJ66O+wMCR/y/CU8mZn?=
 =?us-ascii?Q?IlU5ErWVF3GPk8h5KX4g8/aPaDWNjmIwdLkkNUPZ+O/4nmhfz44BS1ei9sju?=
 =?us-ascii?Q?UOJLO/YhWjIT976v0YfsZn/ebIelY6Yb4A/kg9DhC2hnYQrN2lsPLppXkgw0?=
 =?us-ascii?Q?IqXRwfHz1WNPbhKRGuYYeCWDFZvEaOpRWz7Uz3durp2QayHCOYtsZaQqtGSP?=
 =?us-ascii?Q?Ts3bcRtJEvTg58a8HNQPoEoWVzF65+CqGTL5OaShBBEkQjwkB21vlUjd/1Vs?=
 =?us-ascii?Q?dGA1HBLadJpbO/IKtOlKdpAD4Ir/LAfWhqIlc4RVPWBu4mLXQ5kKnHHddctZ?=
 =?us-ascii?Q?dli2RHxaKwE2H5DB2TpTz3pDyWs33MY6+XlluguBtS8lR3K/piENuIGVCoDb?=
 =?us-ascii?Q?rBKpq+k9FqxhkfuDlpES+dFh5aecsAugoJgkgla313j7eGaCZFsz23m0g3n4?=
 =?us-ascii?Q?AOcnzAcjougMsmyKlHolwfUVHAlqYJ/cy5a6A+8BIM16V6AOlYu0EuMTfcq7?=
 =?us-ascii?Q?MFUn5WYXB759hJ9TTHPIiMlN/YGIEcpefh6siBts/QLFuDARETtl1jeB8pIM?=
 =?us-ascii?Q?OzuivGyOqhjJS1H23tN4gRs7+0JZUp/Ktp/qMmHEIRGaVLnpakNp2bgKN3B7?=
 =?us-ascii?Q?ggeA8PxR6+opZT6mIR4OB8nRlkXepNI3zkRzmxbzWxDslVBo5GP7TDCpd5Q6?=
 =?us-ascii?Q?HasqpCqmE+GalHZN1Y8TZ2WMuVchG+28LzJT47hWRIElVxOqgm4MPVNDVFbS?=
 =?us-ascii?Q?x031EJRxobfVgAFYPdpfxQV2J6+Se245Y/7ZFL8E0qA+SZQdkBKfvQRQ+NdA?=
 =?us-ascii?Q?AFDfwZt7LRYzHddAA1UOclF7AY0DjPryVDXjR9SiLPITX52sFsGLaUSqI1dg?=
 =?us-ascii?Q?TdvZSTifzkk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qEeYhUkIuF/wMBnoDCGCY5ZBJUzR5k4Wj9IZDxOI0sutKrLouqcPfFtV1MlU?=
 =?us-ascii?Q?pDJhPrwgU0jZuiUKxO2dBO8K217NXd61o8B19qJ+hsUZfMThLpekrdbn/b6w?=
 =?us-ascii?Q?d5k/TDqPhNER8mi3Gu2DABnziIw88so4vcr7SufX1aqZbx4WVVikALdxN8sO?=
 =?us-ascii?Q?/boaYQebFsb5satWN4oYrQ7tvJm+Kgr5fA6zO2Peg3plvNcA92rs54S0L9O3?=
 =?us-ascii?Q?gZMpCeYiBcuROmyEhi2TSq2p6A0jbjzmvFtUnm10xHsDCsIrmZoMzUL+RMh9?=
 =?us-ascii?Q?IDUosL5nXc4jqC0G1DOqrCwFSqE5qBt1KKEQbQijsx/9fDyYqtjfKkRVFIHG?=
 =?us-ascii?Q?R+Oy8OtHFg1Z404njNb0o1KE1/ulnVlxKUmorBzcj+W41WLEDV+/sJHyfY/u?=
 =?us-ascii?Q?ZoQD/z+Sl6/NfhMYh1hC8V/ig8XTPLnBG+piD3FatRyonInGKdpt7BinllAM?=
 =?us-ascii?Q?cfFogf3irQni3T0pjcT79jHDZaS1kVkIXs1dgIP6nEzw29w0MvdxiHaZ+5r/?=
 =?us-ascii?Q?EjBeY4yPkPgPj8wVvqkItjZmryMAYaXMPaF1BYRxVzYs/XCNS4DbNba0YTU+?=
 =?us-ascii?Q?KvMgbeD0A/kh2tFbuxxPkrjIgpLt1YNrulsw6AzLi3ORD8MHgdjKsmx34TWf?=
 =?us-ascii?Q?H+FOPo8i8MuXQcqY03B9cQ58jQ2jtUCdZMxLox7HhVb79nC0nEzXqP7kooGC?=
 =?us-ascii?Q?Vzb4YgC58apsu1BDIQ+vSLOAXC90CD9nprgNExbXJGH33DW60sD7zAq0FkRM?=
 =?us-ascii?Q?gRQ+sI5XNu7QFBj3Ku+ZGLkvJugHt2jdF5DQSXGd41x/OzNb1hwNobH+U78H?=
 =?us-ascii?Q?ygTEx3StEIJyPYf2VF9lJhn9pYEr8M6HhAbliiSBvtlHJW/WXZhzcbPh26UB?=
 =?us-ascii?Q?Xf7K3imFy833CCaT3vus+AxOTZLuga57NuC20SRJezokfTXa/tQAUpyGV11C?=
 =?us-ascii?Q?iUtyJTZPun0wOAEEfE7ow0yeoOhWIrqwsAeuZad0WECedSUATnozenRhRlFo?=
 =?us-ascii?Q?3IiB8ZQmh3hlC0oCXyehf6TbizEqS5F/TDLOoDcWMKsNXRulOtN0os2BspTb?=
 =?us-ascii?Q?fhPYA39t/6pcKTeiVm02geZCsOBnka8/1qSSCNLQ4JVhfqyU4+o4YRcNrNLX?=
 =?us-ascii?Q?rRQWbjuuxIg4VQKTHM4xd+cNY9TOSlRL3F0hE6xdHIwqlTtKwdU+1mFg1gXy?=
 =?us-ascii?Q?qcNsqkFkVRrTHLsC/5zxy46PfPKZDe/ylzmXcJGvvGkM7BCUIML2ygAAUFCb?=
 =?us-ascii?Q?lfBwuGq3SNhDnqmA9yGRjraFbhRzDrTWGRWDl3VWvZ4fpto6TIb8oTMW/k7p?=
 =?us-ascii?Q?LlXjNlzfxeY6hRqiSNB6pm4gNhN0h4AhVLTZLlCAWoUNgWCl511DYmg28sc0?=
 =?us-ascii?Q?HvZyvYRJaeCz9a6rC4EHOJT99Q7ja9zI+rqtqhMtMAFVYXnbPsx00+RbKJd0?=
 =?us-ascii?Q?p255HDhn+CGXj7Bpq2AZ47OTrpJwvKFhR5PsE39RP6fpPJaWvhhwULRQJLRq?=
 =?us-ascii?Q?Fu/RKNUJsvFcUt5fsnlIjy039hmTH1YM9QQzpZyfJucQJjw95Zc3SdAa9L4g?=
 =?us-ascii?Q?2c/gQKmwT/EBGsiMhC0OaaWXsIk9oHTTWJlQyZ9DILMTcpumETomWMX3/JJd?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aefe5f5-eb93-4189-527f-08dcbc4aa2cf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:19:52.7049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlvAmagikFVUIbbcqa4fMtdutr07zOnBgzXncfMVrN8yT2JVbJtLoMS4xgFKhbys2OrZ57a5dA4yyk9P4ECCNbiTbwSO7mHxD4GWQ9GK4Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9524
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
2.39.2

