Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D97606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MylU1sPE;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cC0QorKQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA9D58109C;
	Wed, 18 Nov 2026 05:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omR8osJJlkaf; Wed, 18 Nov 2026 05:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 50A498108C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794979017;
	b=gHRyoxzRw6jSrYaf/3gsmtB1Kv+r1nCNpnJTskv3IvSAVM9xwxQiQr0XZwaTcyAym2Fn
	 Dw2sHrvym/amxw5aHqKNhqtVyPIpxjxupTZ18Sx9bqo5KQn9yPgkj4snKuuKxx0y9FIIg
	 LgHvsA15BLgjuZLgSNEZgpF9GW7naH8YAVb0WFhu7vhAdL8iZph7k5B+aN83XZ4rdcf8k
	 H1gIlS1kyuhCXIRELj80PeCCd7kE4sQTfly9MMZTHApAx6FGyEWZAbiuC4+NNbQnPp+vv
	 oVoEr2kOvEnNszKgApkwu8MOXO5hBr5kXXUTfBaeiUe3QQ9VrHPSjot6a1PKILwDRfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794979017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f0+n15aHeo+DCEUgIQDfQy4kTAgKjZ9op+W5Ozy4P9c=;
	b=gqC4gveOx6ofL30flmWa5wKujly11y3J54UugcETwWOaVZmRW0aZMWT3bs7l48SGRS8W
	 wJZAovzFjqhg9rAXi+L12rskqC1ReL9J7pu4o5rKkzkg7cSqZJENB7lBU24Nixdd3r/et
	 OSoBJt6C4TXTyzTfTU3ejgkABMgV+ZtWm4uZErDrTYEbmSBNflj09IJc/6cGbl4WWgrPf
	 EVdeWoIVKxeLh/+J7ascpyprwLEYk+WLRWaXn9mvZROen5ekHu0rzfqoTsesBecjJVJ3p
	 6xX14g9wRGGpmq2cGEdjnzBSRZZirrQGqNo80dkPTnmJnzI2jvYafuPgMSi4ICpAs1A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794979017;
	bh=f0+n15aHeo+DCEUgIQDfQy4kTAgKjZ9op+W5Ozy4P9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MylU1sPEs08qeAwg6/E1GunNNBkeQSzQRi0mJZEtpPpmLWF/tzXJ8Jzo9z7HtzTSS
	 5FlzuSrAgE+NByLat8lwKFIs7acHqMd9BQs4+eaNEE/U9EZhwVVg1NnShexOXgRj2T
	 UCEy0Ugfof2pKPewRutnDzvm+QHoExiejok2kOERUS7iBbsroiPMXLigiETo3rd24s
	 RtALZwvsjkXcXJ8kVCZOHIbhQmxcbprUbu9kmr8flXZ/xSfCPGMyP23eUIOGqIMmp1
	 Q0pvwd0AKnNJdbf5TK7Trc3ueS3AXV4neJFjr8JFkfPhc1FIKiPC2P9stONZ+4bG5H
	 56ZHIYWtBJRAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50A498108C;
	Wed, 18 Nov 2026 05:16:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 826011E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:16:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 748484009E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rgO_1yuiTa22 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 05:16:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 76A4D4005D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cC0QorKQ
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76A4D4005D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0+n15aHeo+DCEUgIQDfQy4kTAgKjZ9op+W5Ozy4P9c=;
 b=cC0QorKQPzbxceNmB5hsVBYzZdyQPUYw4y0kfpGiX/K5Utc3TNhMW1q4hyG2A5KDHR+Xy4RXlqTLFAv7hSVDaeDi2zqyPK79uhkvWWlCdMlfZvAAi5tq5Ppn+FVZ+yOCtrtLwCyTXxmbZApTHWlIgYa0yog/7nW2qSsYCDSHiEXjkYyP4LOn8cjhj3Sy7h0CwjNAvCJNmaH8XjQeUmAAKRsBpsb6Av+bvlsxCv7tSZBcHXYhyF84YS3PQ30qaHUUQwjnGhpL8AUTE4wSfSscZsaCvL3FFEnkUqPxTYR262/acyAmEsaNIQav1SE6bi9VbnTvxEnG0WaxTti3w113sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:16:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 05:16:48 +0000
Date: Wed, 18 Nov 2026 13:13:00 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] regulator: pbias: Constify driver ops
Message-ID: <av0z3JZKFfjSLtvB@nxa18884-linux-1.ap.freescale.net>
References: <20261116174202.3488204-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116174202.3488204-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdbc402-a26b-4b20-30f9-08df4533257f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006|10067099003|261022105027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: GWFUnBuXhaAYNQuTjVB0CQhUnLhB2jHK9WnfT6pQNvr0wqjeOxcu9JcQTXnPtpn5xNk00vIN7wwkIfz2XWLABHQwXOQP7vkYzCPyxeAj7FUQmaId0Es5SeLNnqLB+GsrsjBWcxRnpJmC64KiyDVOJXAIH0aYyI1dtMolKaUH0wGcRgjhYIYhjHcdhUh/b3baa8HasP8rQJEYl7/zTe/te9Koq3VRH7jsWIhAJt7P0ec81khr7xJsNKCtcBgXXrsjiM/DRl37SDeJD3kRGmxqCvYgOuGc4FHf8CrMrTT1VpEqspKpslQSYBLQKG9G1eKYqTujzie6attdVxSogoxmsShZniOdFJ1dh2FemrxhSwRyZVzidfePocTTuhj2HWjaMPJyg53dCftBoyMKbcINMIq1vM/kHEEpbv4rRUCqgTWtffQnU6phLG3pGuTGo5oY/DphWMkZ4hklobAs9+tHX2fpn3ydC+Hq8LSykkHe+BuySFcDfytTicvNgG33etgNNtPTx/cTvjiqChpEZXSep3m6q4xKck3HELIgZJ2ZthVVhUHqvSJKCbSgsXS3FrW82Wd3pbXyCyRqpY3n0ma7AZu4MrFYBXZ2o5BznlsUIj7D9oEbBpP7+kRCVchRTnWgByoFGo/G8/CpOSwjByQMHsN0nAgE3N292gB6TS31Xcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XcLqQqx9dpS9EYfoYflV5bDai4l1WlF4IFmNq715R7amEJgW1KuhkcxgAh/D?=
 =?us-ascii?Q?h4UilNeYCB40vpTyix6KovPSiM93nTFGRiNqNcsgs+YuuhdfTbvPPRbkRKSq?=
 =?us-ascii?Q?ixzzF/iEK3b7CUUIC3WYFkmWXcyIsQFCbCOuG/rrM2tcozHhEPd/ggDg4r2E?=
 =?us-ascii?Q?D3iSP6PD7WKHmy2ibnnT8wk+/WSCyoHQ2KYocM+lbSgn2kv8QUrk1xr1oBPL?=
 =?us-ascii?Q?hHI5oMbk+tOFy6Jpdt8C7JUWdjOhcSvEK5OcPP5FFx+fHtxK62wjRsz1b+t3?=
 =?us-ascii?Q?EkOnmyBeHU8J8zbbZmfrq+hnGGMc9yd+YfZnPBoJfaReBCbyJnQbwSFi+iUE?=
 =?us-ascii?Q?LDAE0KmIRREUA3AxgKkvgN34prjCm+vIwF1Ep1AbDej4glFGGk8GpWRN2zUR?=
 =?us-ascii?Q?Ke3NQxAT7lRB1PcdvKYcKFoqA6XvPGlJmnOGRqoC0ckvzjuegQ5VZkkIgy7/?=
 =?us-ascii?Q?41MojPOZi+cGrJVZLEPIC6cTeHRdH5b1Jcc7gLyjRkmaKyy6o+XW65+DV+JU?=
 =?us-ascii?Q?ArfQnslR4FJaJOpsjd1nXQbEVYKX0f0PGJptJ+Rs14oikWnl5fP5BCcQC84k?=
 =?us-ascii?Q?JXuNrLbNhH3yIMRiYYi/GalYKXCBSLLLXgtVTdj+ZEOPAofYibEaJ7ExecBV?=
 =?us-ascii?Q?vhJEdSlDrP1/6XfXFP8ASRqDD48p9SbP39Xk31UlPOnoFOnBDY8FJcojPeX8?=
 =?us-ascii?Q?zzVLfYOf1wyQst1vB20UnYgoWWZRdvsca2uh5Y/hLZs+WSt9zq4SWArUaqS6?=
 =?us-ascii?Q?Hpcmx2ub/BDYr+H23KYlEbkCWTN7GtFHBncPnJgatTL1Po8sNH6PFkTPco95?=
 =?us-ascii?Q?UjnR6+21O2uPhM8b6AWUW36shzHOop3WXPK/fcsRKqzc5b4rt9SaY+BfHXn9?=
 =?us-ascii?Q?eaMPYX60gXWu0D/xCqnEPSp50cUp7k0h0q3w2zqMvE4y+PoooU2LiLTMO/sm?=
 =?us-ascii?Q?9JXVkWfvJLOn5owteDkFp77q27/AQ2RZNJ64tF1mZH2STbJVRPJtHGmdvEw+?=
 =?us-ascii?Q?07Gf5Nk/Y29kzLIb5cJPnHSd7ryO//7sPXg1FR6NGz3dRL1Rzgy2GQSkHhSO?=
 =?us-ascii?Q?GlEoPVc2XwyLzNutm4lB9Rfjppm9K9DykQWBw4GeJyYmbbNjuJ42LhNiYV4a?=
 =?us-ascii?Q?IYllw/1QaVYfywbbnKXXFUDU1d/9qhO5xIN3vJrwHPwAqrK3HIWylw1xDvP4?=
 =?us-ascii?Q?oXuzk/hdpjoOT119PVlY9MLGOaGEVlJ1p5GWXPJOkY7SWSWquGlDUyU/BBEh?=
 =?us-ascii?Q?puPWS1kr2SK+ay1BaGg0ZMxNUxOKNKK4qNF/yeFkvo2rzWtiBfp0l9aYRt1s?=
 =?us-ascii?Q?fADM69Q28sHtNPtdausL7T4XXeBL3YxLEaYaC6EDjGMFA7htKWx2RXevlp3Z?=
 =?us-ascii?Q?q/4u99jWxdnmYaHUkKNtCNG0f5U/sHdPa1F5BqIHHXf2mRhY8kk8lQhlFIaY?=
 =?us-ascii?Q?91ofBTXLMgrUjMj947jchxa1UxAYZ6W0p0oRMRG3j7h3dhmAAsf09WAjI8z1?=
 =?us-ascii?Q?wLcrGa5YGgE6A9yVL7tOw1CQzO9vYMe2QlqVCHgP2DCgK1AEQdcjS+w6gx4b?=
 =?us-ascii?Q?lFZ9hEEtBEzGPP/421m9oRo/OSU5ii9PV0qKGhJbAnHOplSs9nxRhLny8tAD?=
 =?us-ascii?Q?YFSFIgm4+57640itWYcM1nPlnq/59DhqL30KeFFyhyxjzchM0fgQNvTHq4Fb?=
 =?us-ascii?Q?lTDGc0S+1E428eomoQ1UXV528QabFYNF1YVZjVfgylVwdUejuq4nnA/TyzAV?=
 =?us-ascii?Q?QDSCzqjjlrSGNjicV6KzBdOBp7ZRbbhUuvFnSB6x8ysO5iv/Gmtq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdbc402-a26b-4b20-30f9-08df4533257f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:16:48.5745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ll4PFBz1Cv2aaLh2pKwLpX6BPLWUExn0jBuQSo9X7L5iV2ka+pHvjRvarhv+j+RJKq6sV8xBP57oeuut4qhWnTG9m6moAV0N596OiSNvr6PKLr0Fnx1h2FU6ElBCn9zB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9122
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 06:41:59PM +0100, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
