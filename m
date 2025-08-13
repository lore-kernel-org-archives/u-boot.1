Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D599CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 986EA8389E;
	Thu, 14 Aug 2025 01:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="kWomXQxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4EC8388C; Thu, 14 Aug 2025 01:43:37 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B928583885
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWI2uHIgxzJ21LH4uXtGQv0R4h0QfQmDp8sGQLBO37hYSgLAp/q3s0ZhJ3aYkxzyXAS47Fnhq5cpz2VpKpVsp6/xuCJra/FBw6fORlQs15DDvIsSNDOWMkqwIaH6itLJWI40skBMKKYLdnDVgTqqd+RtRp22FE4Bh5je/VF1oxr/sMI25UffZ4edpDtjDY+GO7LsS8Yb6cy5BnwBu/3Z/Ddp14rXrGtUSI+U0JTKNEoAnkCqU9U3v1GII2E2aEOAQVmsCuK1iczyk8ooPEIzPwjzFalOqDFmUXUwPKTtgU8UC3xQxSXHFMADBhcgGT10uIGTSVVRvQKbO8Turdws/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUPgIq6x4EG3jOp8KWUdw93V8PHZmMCN2fW/8PUPh+A=;
 b=cmUU5qUMAKL1Kb7cA3Op9G3LOw59+MGl2Enb44KDzlp32eCKP9USQGK9Xu9AZ71ic7PbnP67FMXz3YD4zGSZI5NLThVcbR6ojvH0BTofq/fyxwm8RROm7/7IHg1uiiaSfYwTxbreGcxfdiBrGEl1zqxLB5No+wzjJ8nA4piJ7al17/uNYHLb2Ofb6cKvOZdnBPD9W7EoFra4AFU/uVJci96AToaYZvtuUuiBP+f6TEwkVhIRfCQK5Og9oDFgCFHkdF1sGNH4PWKRRs82de1xw7x9M7opNkVdetgz1sdTSjanlIqdBWBkjiNASeNJ4ZkVnhFtWoiKx2vd/2AjMsNJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUPgIq6x4EG3jOp8KWUdw93V8PHZmMCN2fW/8PUPh+A=;
 b=kWomXQxzxHDb3uQqghcwXJqoEW5pjkWIy7DqZWwo6uqAzpTiPIC6J5FOieWIQSpiNxUaAWpLuLVinymuDdXucGxVEqyvRpQCVG6lmTVz6/rygKPd6KaZSa/VdE1d29mQNduf8q4urZOc6iSKGBUr30i6qe9F5CMUHogtJBQVCfjkIiiKpj5AvxWEzGE7v3y4qEqKZAm/AG1Gh4GdfExvmoGhc6iWw5Vx9KTTGh6xjWN3n3nuBu0cZwNBNvU+xOcPsRwv+7/yQRD9CRVhlSi08qqgTR2o6Cm4mmPSbXaDBIWZ5JGBPo3FPqfM+fQ2iokC9MReRYxXo6Sm7Eiaxbb2BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:33 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 08/21] mtd: spinand: Refactor spinand_init* functions
Date: Thu, 14 Aug 2025 02:43:01 +0300
Message-ID: <20250813234314.3945708-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 14517872-daf4-46e2-f5d7-08dddac336ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K1m1G3ehVwHqxWvbIeyIQqkJiuJQgSeYqqyydPWQaHYwcLzphruRtb3auoZE?=
 =?us-ascii?Q?u622p5Xh3k6U0X8IqETUcG8NpTxFT0vWOVdsNvfiXv1HIeZO7Dcy+ctOeQCQ?=
 =?us-ascii?Q?nUmv48OCWcFyVaLyTv5E3B8dchFTkmA4q7qIXr5NhD6zIzXhKjaDmvPn+xrG?=
 =?us-ascii?Q?g0IXsnXG7whjeXOoYwP/JrGiXc9o9diiwSTtf7n/An779lQnH8fOKDHkB8um?=
 =?us-ascii?Q?5eSG+WgL0nuq2xc6bY7M+tPICG/woeYNabT1A5EcL8qNMJdq9s+ofFlKu6F7?=
 =?us-ascii?Q?JmX+KzoZhj6vawC/cQA6mkpdx4phwFU2eIC1JEZuQXruCls+XNrtoV9pp4K3?=
 =?us-ascii?Q?6FulH6H/pYcgRzorCjQkmJ+Mc5Jwj+wJaA6P+9/l18u7VHYP5lScIPntDyBJ?=
 =?us-ascii?Q?8xFNwjjvL4hSrE7ZHTmhHKoZq0XExrvUU4lEaldTTvNmmsQzbq6KaOrqQUdg?=
 =?us-ascii?Q?B22NgSgEvhW86/AGsg/aitLLhDtS8vUxdIaN6Q4N091WHkwi5GJbTgT4Rgwm?=
 =?us-ascii?Q?w0v9011eeHnFpEGVFihmHPeOhzxMSFrWW0jr2NjEXDB8dNip4sKVRZfSGOtf?=
 =?us-ascii?Q?2IxRynFwc9kSY2Mv8/a/p8vhde2jUymwQlLvh/tdSV5vl/AWjDfAjhJ75BeA?=
 =?us-ascii?Q?Hwer8FhYjEoJiDX8i43x+9GTq0fq8UZZPG/MM4el8XgxsRqDAhlwwfIM9qft?=
 =?us-ascii?Q?cP1/nrz4MeOo6XBB534vmb7rl+jVhUDsNOd8YtsSrGiiiH/tb2L+Iu98y82i?=
 =?us-ascii?Q?p0VDrssfP7sN4XisIK8E4DFvGBITpAPdxU5dgUM4zhYXu1+laSb76ogn/iZx?=
 =?us-ascii?Q?C0LKoK3G/ijvL9HtcYNuMMdOLgX28sSguSxDuMBsV7pZSdvLKCA00hFvPZLh?=
 =?us-ascii?Q?xrOuV+b28RMhZuwJkdoSwYxDvT3ERFVJdr+afHWkBR0BKfRTi5e+a/SNV0bG?=
 =?us-ascii?Q?Y7J/Z7uBPVvIEM0Esf45SL7nVywu0CVvhL0aWSnt6bAI1us1DBQQc0WhEyqQ?=
 =?us-ascii?Q?IokeV37p+f6EUCn+EAdqV1bpfmxSLCd0/U9zDbSQzL1TWa5mY0nkhA/vhN0a?=
 =?us-ascii?Q?L4iz77fyGzOmipYRkKGczPvyElhi8Sjlp5frhhWQtn8PERjZH4yLdaYESiIb?=
 =?us-ascii?Q?Pj7pTvTMplvSswJbcsiac+T6JQdvhJ+Pljis1Oc8Z7BHNgIxhh+Q2Sl44o+U?=
 =?us-ascii?Q?qSuR45FbgV/VgCJpGkxYimP755m88Xt0QrvHXzDS31LbNKB3kMoeNOQ0Q+T2?=
 =?us-ascii?Q?lCdL8/7qDQ7KvFqR7WJPpQyIKJc5YU4x2QU+nHaoAx6CA1pamjdN9s6VGkcN?=
 =?us-ascii?Q?P5QqYYsap83YcpSWl7HUd70nputS8YFRmn6mOtF5nyS4OqT2FFL3XFQZmiKo?=
 =?us-ascii?Q?GQDehdf/g24wN9s30IsRtdLf+n+uck6Sa/t7Ojb/nSe9ZFtd+zXnJeabMYx0?=
 =?us-ascii?Q?snZh1O9zd9EOd9UG7waDYfE41/f+oqd0mPbuYQJxpoEVo+Vsz0dyqEkUYsSZ?=
 =?us-ascii?Q?CiQbtBjkhUllp1k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0bqWbWs+KBnUZHWZ/ae5VCFUNfoC48UYwhudkbWjvIxKTEsBCr0IjZ9w/mO?=
 =?us-ascii?Q?NUSY7szMeqiuTVIndnuT20d5oa69sFZrnYFe+rVGE1RDuzxXFQ2pgu9GZG5g?=
 =?us-ascii?Q?eDnHNo1GhYVZs0Z2/Hja/pnThk9GkPBcPgq8fh84dyRrXqPnKEvPe+mNoVdX?=
 =?us-ascii?Q?m7BuSrvYfC1kggssA8dIRmOJGoRX9A+pNAXiyxDXBdNUUN4VkcZOIdoo/ReV?=
 =?us-ascii?Q?qhboai8M6k5s0iqcB0sGYoec8T5UDQHYwXWwsbCvmh0gVOYfLNyKU/RqFRF1?=
 =?us-ascii?Q?jSmJcLtFsOE5j/ZGTAaBvl+ewwTtCZVGgDAveDem4uiDbhWT9BIxmX/ArZnF?=
 =?us-ascii?Q?ZhRlXWwZB6Dovcnf9vTTY2D0o0WHt2s17q/ojd0lP1tgD/pwoPCegPjcfkyd?=
 =?us-ascii?Q?g65AXli3IZ4PzxLJFE8nfh+2G0sZNCPQS8BW9JL03thjGlfLIZN+da9/7QqC?=
 =?us-ascii?Q?1iveYXDPQFU5hMELFIQPn79t61POk7pQJ667v7n7wIFhMwHUKRwCnhy6ayPz?=
 =?us-ascii?Q?ImObk6DtmIyZn5wZE4IdvcSIWdHGM4jaGCnLf+wSUxyO7Qp4QI3614DNn84j?=
 =?us-ascii?Q?7hCNBo7xDsWrJcNPh8tX8GCrCUtQ0Js5DcS80B6To14+4Y/HMdMESAWVWbRX?=
 =?us-ascii?Q?jMdGu6vp7tLp+vpj3ztjj/Qw4PucUbypppT6JibwTdVEaiIy9vk+UikCeXUu?=
 =?us-ascii?Q?zcNdpgsWwhMS99bE04nd+qXeJRM8Zw0zIga/Ncb1V9Pz7GtQ9yy8AhBCnUL3?=
 =?us-ascii?Q?oirn8BXhl2Ecx/74rrCvCscTv0wsc8bBEJ2dwjud8W/AykwtT8Ip3Wr1UukH?=
 =?us-ascii?Q?nGDbSBN3/uYV4qVyO/aZsaZaG7afBl+/kZRHrhT7nO9G2OruAX6XZFe0kKem?=
 =?us-ascii?Q?l7BXad11wymAwmPDioA/WgtSndXdvtSl3Pc8HCqa893Hv8mDHCBga0llE5TX?=
 =?us-ascii?Q?B045hSyLfEKIv2RIVtS0+gUuzHr3FD7i6C/gX8xLH6HSUoIPdTuk9RoP8rDQ?=
 =?us-ascii?Q?m1LSJ6jjBNk1oMVHt8VbnRJt96wExpluodmwzA/h26JzNr4sQG7DNNuR8sP5?=
 =?us-ascii?Q?avflWUL3jtn4+8b2rXn0nasKbDUtEvy1QPFeAIi/UJ5rzelTFXV6TPycIiG8?=
 =?us-ascii?Q?1LagzMVI8cPk9VrIdX76iJRJYS5XISR7Nx3rfEf+c0Mv/4VDo0s3ep+Tq4PK?=
 =?us-ascii?Q?vf06+kFt0QGXnVQ0HdFPIj87FY+8TXdq6TuYzy/4LDNIiaaeu0ib4/0PmZwl?=
 =?us-ascii?Q?XlzHXD+NWe81ZjMQaTsoDHwAYTNtyLqZ6Ad5AWFt5EoSoJ9oscQCvAFhOeuQ?=
 =?us-ascii?Q?lCWM3oqcmJA6U2YnAR75HUpZ6NfLs+DhzDYUEETe90n+QxXe5MSgklqz2Gbu?=
 =?us-ascii?Q?PeXj7V52n4QH7MbWsg6+a9PmzABweHkaMwt15t3Eh1ON/hhF3UV3H9wQ1aAV?=
 =?us-ascii?Q?46d6YkxfkKdeUPzbIcsEYEoCbfRdnvNOICWsQvKHBraj/QFePlxxOte9Q32D?=
 =?us-ascii?Q?YgeyWEqbMcESomDeXl8YjHygEsRue+g02VxiDPWfi3g7dJ4MjzKwu7ZGRqpe?=
 =?us-ascii?Q?fz8DjaL0J1xbwQNKJlfGbXMyFc2xV7qDcEjFfSuZmXNVzRcYgkqtrHFf0G2T?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 14517872-daf4-46e2-f5d7-08dddac336ef
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:33.3186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AofNJyVKXqrRUlfJlzSSeJnU9Z1FjKO/ZFD+7K68XiUP4/w+V7nQHV0TtzF80whcO0mQUIldDJ0gr0cH7hYEzzGudQ7AW/jtuVKmU7XFeTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

No functional changes, just some refactoring to better match linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 6d80b7c6d30..9b48bcba496 100644
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
@@ -1103,11 +1110,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
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
@@ -1140,41 +1191,10 @@ static int spinand_init(struct spinand_device *spinand)
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
@@ -1201,6 +1221,14 @@ static int spinand_init(struct spinand_device *spinand)
 
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
2.50.1

