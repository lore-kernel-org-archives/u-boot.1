Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A66C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC45884090;
	Tue,  5 Aug 2025 00:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="HHUf6SLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264A384090; Tue,  5 Aug 2025 00:11:52 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D9084011
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ3iteMRnv9z1GtFOcDcBBR1eWbzoUVMlBraJnV6QvfDEyGdh31be4FfqM89M5lpE/SmpWC/z7NTV7S3NUlKBPbaSFUapHn7BFdNxdvBQFvAyXPj8tfDt1OQNHYsFqogxWn94wZJA+n2plucJoHgzk7LdG5+MO+1bbYDZnku6tf+/fzk15jWil509XES9F7Gztu4GI2DT+vP44zrZLB3Mu7A3nBEyZVJjYqCv4xmUusbJ3jaou5QMI/vP1MHFFc2JbbBw+dFilQH6HEfE63fjNCTTRf6Hq2QUNuVZyxYO9X1DzoIpYAvXu6GjhSSO9IsQ6mfUWCKCQZpA1pUghsIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joe3FTpTyfHftH0nZKovFP4Po8Wwcg4QHNndEk6K+gM=;
 b=RmyuVeHtkktGY5l/oC2D2bRGsW6zzNTnuCrXZ1B9tv2+F26uilPazzipBbLQn1VdIgJWM8+CORGhnhf8tRxB29Xdfd9GNo3KLrTFiIsgopQ45Nav2ZZ+t7joeYebR/5abJV66ncm9qoiEVoonrrR+4BCxHRaAAalD9iPeyLSF1S8DbLHZZ2MHi+qoAD9KPz+UQjTEL5gYr6PiKix3RXCREkxS9fYosYa46n7ls7nXZOpqZj0CuF2mfwt1yiX5ukSj/aqcgt7o9KDmfxDwDsGbTxIJyskxTusCcr6rNSHBTZrG5ke791SWS5+nlFQSIzdP7645ebY8M+R9338XcXi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joe3FTpTyfHftH0nZKovFP4Po8Wwcg4QHNndEk6K+gM=;
 b=HHUf6SLll6ytjl59Y10hb7cPoQpyZVXq/lnRR1TDCrKxpcfmauuGW/5EJbgFpKfzeqWAjMzc0G0GNCX2XFUk67AGiRU0co+woq24U/mMH4BkWu9P2OCkjkJj76H9ynH1m4zp3Iyg97MRIlRs0WDUgWbDEfSMRXMKklseTyJ0M9wP6jflXOi977y2YdS/X/RLdW7E7lmcCkUdIMgJKLNovFHbTyReeiiQXa08xNzBNOZLl7vTtFHWsZW0Q0f0Z3o/TzRlWVObQ1NJ8sJ9Zr66UpbBcNrL8ErVifnDOhNaCONCueloPrNlj4aVhvIdImPE+qpxO+qtS3A0YIWoEdA77w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 08/22] drivers: mtd: spi-nand: minor refactoring
Date: Tue,  5 Aug 2025 01:11:08 +0300
Message-ID: <20250804221122.1420516-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: d43f448d-9a24-4281-6234-08ddd3a3e3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H8D4oYPQIOtkAodv/5Pl6elNVfcKlYr+EBu/riUndudqNfPOZYnX83Q1FeUr?=
 =?us-ascii?Q?Nv1VfRUfMNC6e+B0a/Y8QI8tS/vSJZ4v51OfHbLEYvoe1+VKwd19Qi8wlR4q?=
 =?us-ascii?Q?jgnoRsIuWacnrz7cLp1T2h/NFs12f1phieUwv55P6U3A0gFwoT5V1eZg5tfS?=
 =?us-ascii?Q?WNyGVwPDaCYJXBk9cO9fsO6Hl2/5vrrqM8i7lBdMzR+L7vnn6o6sku/+W8ZX?=
 =?us-ascii?Q?eIi1Si+I/cLVWGUc7kw672cCfD8/4quRRbWAEzMsItHUk0/h/DXt1lOqy9bq?=
 =?us-ascii?Q?LEuqDMbneUfleNELBc5BACHyYPOV2j95xanOwQ9AfUpOkzZhUY9sHtDek+5N?=
 =?us-ascii?Q?MBi6ts1Qsqo/6inKFQ176Y9tCsYj3ln1hxfmfR5iXFKe+JiZEmdGhY5rFG5C?=
 =?us-ascii?Q?MrOuoI1OvxV/hUtDlFOdeNcEyz4EpsPfWbfCLg979z1UFrNJ3LhDtsgvoh/D?=
 =?us-ascii?Q?0yyPffa+pmaG3Q/o3af1+24/OuwyJoxkzwqSSoj7NCKxo5jEVrIhvKkTbjJn?=
 =?us-ascii?Q?XXqPr6r3PPCOGZlBqBvBQBbMcfNXmTtBSIq56xRAGivrsX3CscdR+CuPv57C?=
 =?us-ascii?Q?NY9bUxoeMbcF8PHdOxcHeAYbaBuxk7ttitcPaT/PfjrK1bMyO3huQ9Iymbck?=
 =?us-ascii?Q?5Q1c35FbN+u5OnP1XeDg068c9SU0DtA7+E7xtssBXqM0i7T8mEO6dLivwB58?=
 =?us-ascii?Q?VRmUYvpD4MTafLMhpB+n2uJfyWfd+FdX7qhA5nv+BaTISwsSy5N/0TZ/8wpM?=
 =?us-ascii?Q?Wyo+VYMe646l+aZy12DSussQEThsldvanZz5O+UnmXBrLBcrs/EC47ajELtj?=
 =?us-ascii?Q?BR9pDTbclxeuVpQj9n7bZq+EgwrQ+7iX0mImMsqanUSIRTuPmdy7bNvsvvzn?=
 =?us-ascii?Q?qBbSVwiZ+nnB1b+jdZIiG+KPKSBZGd7xBcf/CRYGwsMSIMylFH/71tTWslbw?=
 =?us-ascii?Q?h1rPQqIlTVQrr43peFCmO+q1qmzhToNCaU4hLQ5PTZ+d/Q2MuJMuHoSsgSTc?=
 =?us-ascii?Q?dHHpVwgaO7089LKtYDrPWJmscGOZsoK6YYVwrBc8LIHRMfwz6uiL67vbJPZ1?=
 =?us-ascii?Q?ksnqwUyXXntzGIaQeCnn9UTKRAQekEHPKpHO9FWj7rgHkUclxVqzNIlKDnMQ?=
 =?us-ascii?Q?Zi1fBirXiYPw1cU1QOS5ZMTbrPDG2SIlpxNbsbeYHl3fe9glui9j+/cRuP+1?=
 =?us-ascii?Q?jV8n8rJzG3oDBI+5qwIY7BCps0fML8jWhffdyds1jcRR6p8ow2lXxhNqgmKZ?=
 =?us-ascii?Q?ooILkAhebEwfmeYVesDUGN019fA87+dzwuJ3kkCiy9lKZrqTQ3gzu8Id2d1Z?=
 =?us-ascii?Q?mabH8p9OUNhbf3CI6QRCFO9TZHP5V3GTJamnBwt80DSnqvxQWR81uMk47D0O?=
 =?us-ascii?Q?gOnP0BPLXIlN1xZdaeQ+swWBNhhHwE/Bx9irujwQvbHfivy+mCtTbHPLvMsY?=
 =?us-ascii?Q?GRPEDNBzPRpqBV2rrKfkv5WNoBH1CGUDWidTF6uQPmrxBSojLct90NbkxmOY?=
 =?us-ascii?Q?/eCUPSFv7MA7cMI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5A/s4lnGAUDXYBeh3N1wbLvOpPccWWzfachQGJVzvT6xLrh9sOoonca51gB?=
 =?us-ascii?Q?bbqNBWwydJkRNwgtWkSV5GHjBBc1zWVuQ8JGgdR0VhB0xu0WZtxxIeIr2Z/j?=
 =?us-ascii?Q?gE3VeV8LhuW15AohLI7B4+4evApRnje2Q4Tr3j0xdEqqucWzmqCwfS9EEqgC?=
 =?us-ascii?Q?AlZfn0kERO6awqC0Z3pUw20Kwj84H5/FfxlACTshrmbu39KQFkCASNRy7qNU?=
 =?us-ascii?Q?AHYWx66P9bIuNk+aGYAuQEBNm0qQo04J1YVqSr0OsfMeNnBIqDiR9rPJX/rX?=
 =?us-ascii?Q?7eCAi0iSdO4cLItLH0pHmHVpxtfOF6q+f9rgZ6e2QRt9x4M1ET5Wb1P5Ejm7?=
 =?us-ascii?Q?ffwKAO4uqH3juGXfyx76RET3eCdT3eqU+ORdEpRXoVGKFsrEfWa8BGI9ZqFo?=
 =?us-ascii?Q?5nd97zhj9PuSlRRGUD8ZVjHpDpk+1n2h2n/zRQxdeNmjaCQoV6sIuk0i4flj?=
 =?us-ascii?Q?db4p2NbdXCEBsB3eRatnLc5U23APhTmY+iXsBhDxZX0ig91fOlL0X6rZ5lbR?=
 =?us-ascii?Q?RVWw7PR6PC+ZgpDS/KevfMq5DbUA96SxG653gnJvpp98R84qH9ZoDjG2lhQT?=
 =?us-ascii?Q?8pjAjze0JJit4kiNeg2CoamUEkR3J9xFikBC25Rmw8OINUksDmJcppES9C4p?=
 =?us-ascii?Q?daawQkHGoWKJNYHWjYrRbiFFyaEUh2JQB6XQO4QURVthGCHPEuoDq2xIrdis?=
 =?us-ascii?Q?tTOexTnuvrdU0Csl16MbpvqzCSU2bra+yFsndTqdSXySFLJ8cBhGMBT+7kkS?=
 =?us-ascii?Q?lz0RNk4RnWRYwkuxj80P/fbFzuispn0K7s8EOrKc1HIfkD6ef/lZrEC6JtGI?=
 =?us-ascii?Q?J21E6lbhIHeuUvIIG6zw22lluPI1UIyQ797inecAZHEywrQ5owRup7sQsVMn?=
 =?us-ascii?Q?ICfjttNuuo1zK4NAAFFG+i9jTCng0davedDxGj84wKg+fquuEO4CqLwRpGyN?=
 =?us-ascii?Q?ElCcUGQco47rYAxu9diPtBIB6fdXknH/5Tp43B9mG4J5mAwCvynxQIkijDj6?=
 =?us-ascii?Q?4c7LshO3kqd745hrLtp88Wcwo1amrHiRLQHg3ecDrihr1MmV4Sbh59KcPZu+?=
 =?us-ascii?Q?OkBMBVwxpPcAW6wozFqyQ9XxpX1cAPFmmkXYgstP9qpxPd1snxbMBdams26D?=
 =?us-ascii?Q?wIJ7p3BZG2njUaqV4yO1bhEDc41pLltFj45Ubz7gwgqsEZGZL0WWpcEZdwU9?=
 =?us-ascii?Q?TmfKCUlDOCD2XsLz8O1OHUsfumpAl1Z+gYtPg3nSZhxscwpfzsrP58OFwDvD?=
 =?us-ascii?Q?qE7TBPSyr5OEDPlqp3qNHE1stR0BSvzC7qiookcE5As84c+oeGwGBHJamH5L?=
 =?us-ascii?Q?JkmrMTTPmw25RVul+gJzjy+r6vx1N8prEHo0mXycX7GMOzZkgb7++kVSh/Jl?=
 =?us-ascii?Q?zlh18g/vhA8+v9wKJxhdghzwqhLbUGZdQFSUAx/me8c8GoCbDJLZ7oiKpNWr?=
 =?us-ascii?Q?VkhkKYF9Atq+lW2Z34Eylie1CbiFVevhwZuuOPvYb6shQIthJoQP1xSYnpIg?=
 =?us-ascii?Q?+L8/Epl0CyzS4Wwm55so5MMdq2dPuszDzTzYNKs66HaywALheQTYk11bkAiW?=
 =?us-ascii?Q?Ky/ST8oosIU6rOlgPlMc9FPf55QoBdjtgyLnton84xsXVTdw8CON79bnGA7o?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d43f448d-9a24-4281-6234-08ddd3a3e3d4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:41.3725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSBVBdaHTTaEeB87ivc4GaWhdm1ecmirG5iQX7JI3fSrbib8wz6vlsxsv43RUvy7pNKfTB3eiRA4IZLF37Euh0fl5NMU0TovZCzeksyUbUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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
index 098ed0c4cd2..df59d3d23ce 100644
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
@@ -1091,11 +1098,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
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
@@ -1128,41 +1179,10 @@ static int spinand_init(struct spinand_device *spinand)
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
@@ -1189,6 +1209,14 @@ static int spinand_init(struct spinand_device *spinand)
 
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
2.47.2

