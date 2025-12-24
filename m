Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192E0E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69B78421A;
	Wed, 24 Dec 2025 09:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="IvMxxrol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C4608421D; Wed, 24 Dec 2025 09:24:51 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D1A84212
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vR++A06ApfcVCi5Eyrdhf4zja52sFsvA8lofRzzlz5NO/BonHcNlFKMv+GuhLqCAfGKUrt1qkO4BpQKoCxH1ypNcUhuWtfz0BoDO8oftj/UgoztcadW4elhPf1yovvNTblPSzJBmQ9D5eihuRg+CdqPykv7Sz6tpO79uCQan5necQ6qW/JKafOJZwyYFqZc1tFKSfOYSB19i9o7D8oCQNt9EWJrmIC4mPWXQepduLLBauyUGUiEjZMmzUo0PF8YHiYr0jIPil614gWismycR9wPXI4HFQtPYsyII7MMC5kXiJds8CzERVtjWEWqhWu6ZFnlIsdoHI5j0mARTO+YSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYOUTblDMZ9XmSOzE3c3j5rSnTHggXEfLPuim7U3CuY=;
 b=wR/7nxmCLoig8uVutUwB3Q+OEoCheBOpk1LJ096F1YdYENA+DfwcrZfIAYyC/WeD+JRzp8+hBRs36+WSetHureoyollG+APioMJhp/gJyljbAPDyG3dUbO4VuJxY83Uwr9NT4F2720Ywof5GnQf6HgDPim5njkAm7imWbAZnGbbR1oHnwn/K119kw+SetdHTq/jPXBacp0ksE5eOPI05J2YGegF6Fkxx7tCMaVjognMqnGqqtk5WB7IkwVl92o24inJ4jDbVAvWZB9ZipEwb1AWSEE3v5L37VpxLZz7xubPPnuQSXnnyeEQC5V8abc7xzbizzB8iTiiuYDRY1WeTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYOUTblDMZ9XmSOzE3c3j5rSnTHggXEfLPuim7U3CuY=;
 b=IvMxxrolWxEGnXaWwlukxPCzZbX+yNkUZlLMgM/2s3AcYUd9oj7VZrUEyW8p464DOcSQ2DvOpW6uYNkxPK3EYuWQpFR2JOscCnhDFO7twlNR49IzwjmMK5JI4D1RtGqGpZpeGw9/6Ql+kwwwHwuNfCnzZ4iPbgylpcweeKJ5Dzcdgwzf9EYDT8WZj2/snPvymtUNZk+qK7HTnnuSBnjpViGgdODzr6O9lu7yteDKY2d5taSpnGnVZ9vqDahBID6ezveG7EMyuTcubX+xUXtzSGFYFJ08HyW3XJ4gOQ4nwhIE3Lj292sAr3+YN7fQwNwTZf0MYgreXNG3EIipSj0aaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 09/19] net: pcs-airoha: unify code using SCU regmap
 helper
Date: Wed, 24 Dec 2025 11:23:59 +0300
Message-ID: <20251224082409.1347373-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 4619cafd-678b-422b-4ccc-08de42c5e65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XxnsV1fqanzVtOqwXS8hrNYiGNRryE2zg0WRXwCVehI1c5gVvqXCAXRa0Q6G?=
 =?us-ascii?Q?6U6zuqFyhEveRkEqnS3u/B8T4sufTJ/HnG+3PJvgOydLr5K++HhQF58N9npd?=
 =?us-ascii?Q?RRi1yMY87nfHPa1a4E53AemFm7QCNYQxpin3RFxxicmsvhYKKU13ZN9XZgqy?=
 =?us-ascii?Q?fWq5uE6/+XTl1Tfn0HzS8fVfu3rfu6W56UONV/uBtmvjCfaI/Ft+dGsUKMI3?=
 =?us-ascii?Q?/UrKvHT2y9WO6LSP94IJXfrai0rkI/EeVfMPThdQGkYUEmw/FVLnabhSrS1z?=
 =?us-ascii?Q?h2W9ZY+tQKd48Z7ERQruNLsVkErMmAZGOdMvxdg0iVhj2REFM1Aw6puAD7Gr?=
 =?us-ascii?Q?3X7LG6cXbxocnDPMaE945dZA91GDXjyn3fms/STW7Slj5y9mG7BMQHn6xYh2?=
 =?us-ascii?Q?72auNiXnxVGq+o14Z4fq2ub+w7Lfq3mRQE8nPDNGh6svqtL+6NMb0hxsO1BD?=
 =?us-ascii?Q?HJT/fgoEwVpzC5MFq/E8LHZbFPSYcIic6zJ8UxZamH/xbm7vJS7gDdbrteKL?=
 =?us-ascii?Q?SzzzaXV5T2ovwzc182JS8ogr0m6Kmq6J89zcNgsSzYFlwgOs3ks31eaDgmkE?=
 =?us-ascii?Q?gYWCZ9kZSwFd4H5MfycyErayQV7Gv/nBjvhU+FiTDZxZYnEAKhAWfQzhIyBu?=
 =?us-ascii?Q?26FzdVc1EsmsOf1HzxUoujp0fVIfUAcvWy2oepDYSxQANChdeUYhtgNnR0sq?=
 =?us-ascii?Q?LF7PgYPmkQcQvOPspvurGW8Z40kvusMPDuWfqSMVFReFOiiomB95pxZXovWG?=
 =?us-ascii?Q?UCsoBGhYXl4TKA7trzqsfc/ytZFWTvbqxyCdLVvDQMcqNl6Nl9I5HpfzYWmT?=
 =?us-ascii?Q?QDSPMsNyP4nzb5IPQ7+T1J8uL3yztXsiTTOvgEWLCxmlJNc/HyMN6wJkvbtV?=
 =?us-ascii?Q?bSb/Os/vNG7tjnUuxQdsnQ8lPJ+i6OTL3kokr1fVyxNBcQ46PxdvHxBHcvKQ?=
 =?us-ascii?Q?idFyNnMOPaU5jFmCDNBgsUwdMRn9Rtp9XLQdxdsAdiS/OxAzbPEDq23v+kDW?=
 =?us-ascii?Q?0Y2Uv9QtEpaQzoEXMba1NWjGnwQVobP1aqo9HiI82Wuu7nlvx7vPfXTHFKnt?=
 =?us-ascii?Q?jgeWijtxg4uI6Mg5DFyIdeIeBC0NojCM6aEXA78XrfHv+GzcHXw2c6AuH97J?=
 =?us-ascii?Q?8ve73wTA2kPCKmWVO5vKq3MUd83F2d+QpHHzxGRVqKnwLHgyB5G5/5hxrxqF?=
 =?us-ascii?Q?tzaPw780kGcfI5TLbGTqtk/9hY5xSojF3p5CV+61BddPv8hfOToBt0lxlaHL?=
 =?us-ascii?Q?C0hdfXtBTOlEYI305UwSxqdp+dShx/zQXbpdw+/zWrF3ICwn9tf8CCI2XgN7?=
 =?us-ascii?Q?3vI2ZCAjc8dz66qR5IMWPloundzOmTH/lpgLUJl6PwBHfSEcy+G7CD18X4sI?=
 =?us-ascii?Q?j9rE/cN/2i3H5j8rQ33Bs1pki20j+QZ906z2APlDSLpuCkAenoLLsri6hGE7?=
 =?us-ascii?Q?9SqgMTWYmLy7vBnYeRsYdeJ5ky5IZ2kbLIS2KQJbep4tm1MPOknHiaJIn84C?=
 =?us-ascii?Q?90WkBvjlQmwjW/UciemBpfjTv+254ck4DEG1hw/pEzI7Cp3rXlov7l8WgQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0TMBGiXOW3zDa0Yh8R7yq3qw6875WgaJj3KMdZvvOiFLrr9MQ4EcZmkZphRO?=
 =?us-ascii?Q?jv5ZTd271eO/RJ2asDvk0GYfBqSV5Mbmwb5u0HnBwRjSCRvtp5nDmvqiCvd/?=
 =?us-ascii?Q?6+f5kEV2OTdFgfWInQ0piI6t3x8pl8HpKlfQYC4KPl9AGOHmXfvVpsukx6zw?=
 =?us-ascii?Q?n4QGcV6+/msSnhbnD6zJkthZggkNAreh/R9iD+zXBIjq1I52iU3HO0r21pLB?=
 =?us-ascii?Q?SUSUf8Dw8PY5+5uX0a7jp6z+2qs3ApS4nRu/7LeF1Uq4ZORkmt2mctX4HZUn?=
 =?us-ascii?Q?SkCCQwUEeyYG1To6zZK1Tvu8xKTJX/zFa9QLPvsLrExBftmKeLZaNdHYqIDv?=
 =?us-ascii?Q?94UQBycTI4bSp9jcXW5i0qt/E6Sk7wna5bshIbxJ8Xg/3EMYiZQns4slMM3R?=
 =?us-ascii?Q?97H+sjaiZRxwBow2KDHU4BqVlS+OoPWJErqhMm2vPK3l1ms3DpO6v2A3fw69?=
 =?us-ascii?Q?g75T8fJJrXFYmSVC1ZsCqsz5nNSYKf7k7mQe1BcB5T1R/iTLYFGdh/nLPd/F?=
 =?us-ascii?Q?UA6BKvHVPZq5tkuC/oKiH/JVHv+5dKSuVSjynOUe+8Cg5eMRupvCjZ54hS3U?=
 =?us-ascii?Q?Fk2/Acc7llgsHfMwaZiP/LhOt9z2olA/I0Q7k5RU719b/ns3d/zzrR9UCXbJ?=
 =?us-ascii?Q?zpRdYYLoRHtLXJE+5RVJX1aheXGGi4ki+8NBOlYwFESfGRMsdZtXrUTM+B1M?=
 =?us-ascii?Q?pMS6nJmx/+HWJj9pmJbeJ0xnJbbl7crQrayYWrH7a6D3b+pPK11DGZgClDiv?=
 =?us-ascii?Q?aiqyCfjidnVsly60R1EKsLg+JiGYNt0N9zpnttHn9gjXFGNvMQvc4+Mh7z7M?=
 =?us-ascii?Q?Flnlru5xzWa3/Zi1YD+QeXHF9q9wndSwKsmErYNDcTPzw1X89Zxt2D4Jhk+C?=
 =?us-ascii?Q?QCCBmyZGxOLxBQGkDO+U1uhrwBZdHWyvX9Qnrgfbuzv/3plmk6Wjdn/797vC?=
 =?us-ascii?Q?8flxBtOehopX7RJyq75N7raHDen2QeRoFvxC1fC5Q0INn7d2dRQlBexMLe5/?=
 =?us-ascii?Q?8vAO1loAC6uN/QGeHT39XhYrH9CmothbqT4QOFw5d7pu7PeW9oTw60ExiNkx?=
 =?us-ascii?Q?KB5aWuUzgyW+74jLZY3a87/Q7jwms/6qtYf2Libsx1RkRnhjBwX3f1JtXW7f?=
 =?us-ascii?Q?lX84J3Feloj0xHGmyzL8R0H+mQ9szgnvsL358ssKt19ijal0EESYAcSh4OcL?=
 =?us-ascii?Q?Urp5N9n3JDYIw6ej9jKl07Ua4fjP7DDIjWMK3PkLTxWtIilpgzB2YHUiBe6V?=
 =?us-ascii?Q?Kk3Vhdp7DSsZrS9EsSxyOwkc/K0deArECiR3njFlrBqeniBWWtWD6Q8DLi46?=
 =?us-ascii?Q?xeHpxMQxVhy2846QaVLEnwnZ3+JYvQjBcyDohXmtsPiVn6l8z2UHanLzDXKM?=
 =?us-ascii?Q?iWrSviZHScVBbg6VuTyYIYm1b9JMqWgmejnLJc/qUWkf25qVzugOsWxQbwCl?=
 =?us-ascii?Q?9JSZ+6J2AxEya9fUqInKGStS9zo7JGVrlgyss2s050RDRhqKnJniXaTzn9/H?=
 =?us-ascii?Q?8NizFwlsmMxvZcAZDYox0thW6e1P4gr2fNnMO/rhV6V5B5FEOTgmit/6oaTH?=
 =?us-ascii?Q?HWYHPhgplegl3tY/Km+z0Gm0938+dUsdpCzdrGPXeIOtldkP0tkhN8A8HWdA?=
 =?us-ascii?Q?rn2ZVsI8rgv21kWuTgnpAmM7QOhfV6pMiR08zJ4cb0RtGUJ6KvrMAP8+x4hb?=
 =?us-ascii?Q?/LaYfg0I6HlTAFYqsIToQ+tWGq7t6fcies/2KwzMWN0mQn9atT9Gk5AP3/EL?=
 =?us-ascii?Q?t+CZRz+726pMuq9lRgegkuXsQECvVpk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4619cafd-678b-422b-4ccc-08de42c5e65e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:47.6889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLk3Z48oh9BcKenlX4PJBu+c9Tn5w7JplWGlEfjsvwQVi4PRY1YTXx/CXOMlm+g/ABm+2DeWaE0izoTxYUcgf1PZOPk8qODuKES8C9gWEGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6721
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

Use common code to get CHIP_SCU registers instead of driver one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/pcs-airoha-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/airoha/pcs-airoha-common.c b/drivers/net/airoha/pcs-airoha-common.c
index 8784d92a7a4..16f0dac2951 100644
--- a/drivers/net/airoha/pcs-airoha-common.c
+++ b/drivers/net/airoha/pcs-airoha-common.c
@@ -10,7 +10,7 @@
 #include <net.h>
 #include <regmap.h>
 #include <reset.h>
-#include <syscon.h>
+#include <asm/arch/scu-regmap.h>
 
 #include "pcs-airoha.h"
 
@@ -755,7 +755,7 @@ static int airoha_pcs_probe(struct udevice *dev)
 		return PTR_ERR(priv->xfi_ana);
 
 	/* SCU is used to toggle XFI or HSGMII in global SoC registers */
-	priv->scu = syscon_regmap_lookup_by_phandle(dev, "airoha,scu");
+	priv->scu = airoha_get_scu_regmap();
 	if (IS_ERR(priv->scu))
 		return PTR_ERR(priv->scu);
 
-- 
2.51.0

