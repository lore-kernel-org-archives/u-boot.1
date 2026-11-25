Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1737606A326
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zI47JsM3;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oZKIz5wK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A22B4033D;
	Wed, 25 Nov 2026 07:27:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xd-pIwwabF4Z; Wed, 25 Nov 2026 07:27:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CFF70405AD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795591623;
	b=SzPROTvSPs/fcOEwiGirKYQAcx5FnHnUtn/OH3JgLaByXTyLAkfOz0pvTuILgpojczSI
	 RedKRgyVXyTIiR199SZdF6/pOcGPnk2829pyU3xAjo6l24ZdcZYSC5ejgIz6hhhlTp9Uo
	 c2UkWe1LODyr+nv4AAvfOvU/vtM5PyQfMJKi74GjRKssik7mS87CKYHP/HMsaa9iQ5gw8
	 V45atax149BatcIGWjJ5WGwPyl0Wzf4PaysDwLpk8NBSuBWniOhS2U0G/O+brn/f3f2p6
	 X2ZEfgXUtFhLIixZ2WId/umNgXHXHl81HR6+ChB7zuaP/VGM2/Du8J9YVZcNnQJfkag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795591623;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=nTxo/1uGkRBLlJQs6qGfOUOT2Ft8FSFaMTB6OelA2b4=;
	b=QppVR01FIub6WTUcIOZIwtrK6a18nE3zJy+WgRwsRhMjWJ3ACCWTRSu7jRQVvMsSehgP
	 dcsGtA7AEZECfouZHZW+672/N+2/sro9bOf8jH+k4zzBIGC6SOszDhzF7XZ5fgOyrqco9
	 h51X0xwGZ/vGPcP4G75QiCvCWE+Ol65LY/vdlH4WSN97QYT7f4SZvHE0HJvuJt/oQrpip
	 ziCgEe54tzE6P+zsNDfZiooteggAIAY4Yw263JrvSZcoJyQQkibdA9eq+kucpr8MQHgnn
	 0i19Jw89l7//46wv5ryMiplVA/5LTKhvBGU7W+IgqTl1dPBcwujgmC5w9N99g37K/hg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795591623;
	bh=nTxo/1uGkRBLlJQs6qGfOUOT2Ft8FSFaMTB6OelA2b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zI47JsM3kGbm1Iw4YtgkfkGlKNBoKmqkBa6KDtxsorEGEV+muUmAl721QCXeVJyAa
	 o9SReLOlotvFStgUguuu+DzJVdqBsOHFyuN95+XaGendw3JtkwwgbTZkf2zjHxjy15
	 Pgk4FEOMODJjyip1b/I7qQX6AjUg2cEUGyncoC8adD6RAWyM328p00Y4iwrop2FdFV
	 FTZk6T1Q/hZdAfxx0HxYogYbgBbkQZtwHJVWbOd8FHeADmytAARB0p2DCpRhhowzLS
	 vKjliGGjMREyfaKlvuFC/QIubYVdiuhzlNAd6INeD/BuPid5CcZEu+duoDoGoQSxiF
	 9bHZd6/zezj/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFF70405AD;
	Wed, 25 Nov 2026 07:27:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DDA7B32D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA93280CE0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dcIt4apUkLJk for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 07:27:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA4E780CD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oZKIz5wK
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA4E780CD3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTxo/1uGkRBLlJQs6qGfOUOT2Ft8FSFaMTB6OelA2b4=;
 b=oZKIz5wKJ/D9zjmv0n92X6PUK43mxon5hjsY0DA0D8vI4fB+EnnKxWc6dwDZDU2lNrLtjjGEcj6xkMCB4AYlyXyx6lA2fC6F7QWc9pomUXfHmnf98hr26HYQnlDGZ0RNavjFZut/st23cIB2NZpfKVNObrJ74Lmd+Ut3BAMqdks+YXV21Py5f20+XitSod0df3NaIqJD+vJ4yM7sl4KNCca0GdIvEVMHB1vOE4IphZDjBTP3CNF08z7w09W36iEP4wdrwMECx23G5K0CWd+1RldLzI73C9iufsSG38rh/Ye0+0OsVJvNvACNN5Il/iLV8PD7iBTe6JXYFFlz6qqEaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 07:26:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 07:26:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Martin Schmiedel <Martin.Schmiedel@tq-group.com>,
 u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] imx9: clock: support external RMII REF_CLK source for EQOS
Date: Wed, 25 Nov 2026 15:23:55 +0800
Message-ID: <20261125072356.27260-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261120072844.1502841-1-Max.Merchel@ew.tq-group.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA4PR04MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9f5e84-1f14-40c4-8aa4-08df4ac57b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|19092799006|56012099006|10067099003|11063799006|261021123027099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: EMa20NDOPWo198kglFyIHC+dCL1TZknnYboZEuehOh+strqHxq1/3jxajH3wGwKZTELFaZuKKYN1kUgNvKeEUAvm3wVj0pbHfxZCuBjet0Rlo1C7hLCL1gSIu3g6fh/DXqKDqI54bg8Oe6qPrG97r4RAreC6nDw8ryHbVdDy69GpSX3ucjBMOjTdKARxFR2nLyI1/FeIwDxwqICKhoTHppnrkazwMdocDFJmPckMec5miDtDF1B2je2zO4DnYeDgMlHp+jVjPyLqBJazfJd0nS6V8d3PN/udm+xbjVNQOzFuc/mmGn4nznHbkCJ0+XcgvoWV8gptX2Zg1VHGJPKllZXAtRZMK0x1oUJzDPo2YH1G3iHSTpFbKINC52k9v1Pquu//hEknIrDGOpE9obNhMX6JUYLyQsg6sDdoYhQupioriz6c2e2ALcVgCQ3mRCWLaUOMNtlIJDmI2zVw43E+S8iEt2Vy99WddLOzPTD6IgxuziOQAYE8fVJEksxqz0i9KXqUGqiUcnaZXXWPjhRgTPmqz5HDBmQP+yDsE3ZtHIL1xviznu/IZZNnC+4iwUvBpSopJm7N5n0JXSv4K4n/qlFwKrl2tb+WPMthdGbhFqWMu7s8sjB/6ZOX515+aO0TOgWzx+AgeSx/Sm0V+lgnX4/4DnQi+njNnK0dt2v7cjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(56012099006)(10067099003)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l64ibPgKg3AO9wXkvYxAYQwxwRzy+hCU4+Hbgx7cRMS70+MaoN/8oanhoetz?=
 =?us-ascii?Q?xCjDxghdPglmjbs0jmkvTV/kpjGvbFUTDyimmNWU5PniCfQjPdwHQqo8vYEt?=
 =?us-ascii?Q?N+pL6TwjrLnvWCB8ced6xABqRM6hp1biGCMU1em8+ubXg7v1+ki0hmMvVjG3?=
 =?us-ascii?Q?3wPZZR6kM2DKv7qizu03NXEZKUTLd9NvujlrHqwxlTPdZ/zwey4E1HUmx1ST?=
 =?us-ascii?Q?Gkjc2iuDZyzoAnImP+eyrSH1QYBhprVAd8DPVtusxEKW6z7c/v9lU0eQ0L7T?=
 =?us-ascii?Q?d3KgIIxJo9/oDixhUB0XPOJ1ntwx+zRNgEtcSsFCKMLCGvu4hpuqm/BpsOnh?=
 =?us-ascii?Q?quaZqQQVFXf6JtkPPlDLrQAMxwsDy3xB/ErKE00a366CPJ/nhrSN2vCcF9d8?=
 =?us-ascii?Q?Dyc9Rlscfz4/jmA9sOStVzVXLsMjzUbNSYo6cJMCM4SwtBQM+RhAfGv/sGJv?=
 =?us-ascii?Q?QBNz2Z/0I5a8Glth58Pgs8RIu/+d96mC+qhqrFr4EygE0XQk4M9oGkrX2ebX?=
 =?us-ascii?Q?Dswigb4IghhEuMJUQ4puHSKPctsne138YKMFs/2HLIJmwJldK94AcxfesHuS?=
 =?us-ascii?Q?lraNWnBZ3rCEZDlB1QLtV8m7UrZUiVoi/zwmEA+5n/ajylJ8+UwUOnvDPmpW?=
 =?us-ascii?Q?ViDAvmCd5ynf+5rIVFNhShKVz5/78Kz8tZZg4pXV8MFjOtHFJeCPXQ4eXIBP?=
 =?us-ascii?Q?b8rX0WmUC3tNt3gNS1CMyGre+TVc4AG3dh9MiHvdAKzDjWGYTXwj51OLC7uh?=
 =?us-ascii?Q?YfkbSQJcjzXLp2/Qb37ltbPi2LHjpwRVPHT+uXXAZGEd5zhODe4J418WmNzk?=
 =?us-ascii?Q?zuasf99NMUlfpUblq1TWhT9sURFM2OJSH0PbpWZw9sj8OoNCBMJ2wvnsZYbo?=
 =?us-ascii?Q?QroUYmV54rUJXup45l9yuYqzulCAyGU5EAS6eRkRHUT1sMccqgbmaaT+7u0W?=
 =?us-ascii?Q?h6NYbm34C6egwNazL9Rrv9OMrqpwmi/FOFWwqeltybywB7TBCp9DK0gZxDQJ?=
 =?us-ascii?Q?mBkp9JH+oPp/5PmQHBxLjat8tr1BhkIOGgGBtq/2WdDP6EQMqMFJLIDtQV6Y?=
 =?us-ascii?Q?mAGLWyjMQmnVyA45/ml+YNjSc9wqnPZaDkG6OcDZf/AT+ouY6rjR1sdXbCRa?=
 =?us-ascii?Q?NS25+1TsdE1haszx1WjeIHIkRofQgOAVaLwSMXcst0s8WWDAOQjNPMwjSSJB?=
 =?us-ascii?Q?mTrOwmbpsuvzJT1L5AbwJSy8+qLR2p28OU905ni5N0gbOqV2vxUEZsdelDTt?=
 =?us-ascii?Q?LLjrKafol8jVci7kk/JRMI0SFK9qpCc0j85iN08RFiAI2uiKF2ILa4XNMnIY?=
 =?us-ascii?Q?Af54hIzBADkL/W8ZhmYZ1Ry1eq/PNV74dcTbw0NjIuiihSOEpRSbTa+ey0Wv?=
 =?us-ascii?Q?kbwNXYmBHvX3WYF2hoB/kDmnSmJ9MLnKRWmKGPp/C7VxNyDnkIdKig/+MIrB?=
 =?us-ascii?Q?vYBNsYO6K7EjjeM1btUfFiOln6B+p/AqRCAlJ2UFhQ5DjTBWq/SlUgZRcAFi?=
 =?us-ascii?Q?QrGBqayUQHeSHpy7TpCxlxBl2+m0sSWT40wyzg658Y4MkQSFfhYi19mJbEqG?=
 =?us-ascii?Q?8YL4aQ44HTJEfgWxlBRhCunVPjyHC+KgRJ9WLsXLzwPCvArIOcwfPRRYXDgM?=
 =?us-ascii?Q?0tA6WXO5IN7NQA76JPMrd8AT11kQkXStNtBKvpfiDgx98jGAyKp0dlzB7Pxp?=
 =?us-ascii?Q?fTAbQ0AsFXHZ+frOq9vFTQvm8OxKDBvg9q3munJnVT7FNvARYZsxICMeDvhk?=
 =?us-ascii?Q?8bQjJGXEqH/3SYHCVZYuBe13MMRIBStGPzfPSa8zOqk3cyYAfoDL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9f5e84-1f14-40c4-8aa4-08df4ac57b10
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:26:54.6347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Hs9rpduVqHA1XhlC2UtlNdoOXJrX3VuDGSzhDGm899VR6yKvso9snizKV2XmpEBdc0wNxmcKhZEg0JrqMNtSt6vgl0dnmMSo5r2TMOMAcx3nABNy7nExO7uIAkdjdiS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	T_SPF_PERMERROR,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 08:28:40 +0100 Max Merchel <Max.Merchel@ew.tq-group.com> wrote:

> From: Martin Schmiedel <Martin.Schmiedel@tq-group.com>
> 
> The CPU supports RMII REF_CLK as output from the CPU
> and as input to the MAC in the CPU. While the first case
> is supported the second is not.
> 
> Check the presence of 'snps,rmii_refclk_ext' property
> in the MAC device node in imx93_eqos_interface_init
> and configure the direction bit in WAKEUPMIX BLKCTRL
> accordingly.
> 
> No changes for exisiting boards intended.
> 
> Signed-off-by: Martin Schmiedel <Martin.Schmiedel@tq-group.com>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> ---
>  arch/arm/include/asm/arch-imx9/imx-regs.h |  1 +
>  arch/arm/mach-imx/imx9/clock.c            | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
> index 55f4f34e1bc..0358b0a9b2a 100644
> --- a/arch/arm/include/asm/arch-imx9/imx-regs.h
> +++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
> @@ -90,6 +90,7 @@
>  #define BCTRL_GPR_ENET_QOS_INTF_SEL_RMII         (0x4 << 1)
>  #define BCTRL_GPR_ENET_QOS_INTF_SEL_RGMII        (0x1 << 1)
>  #define BCTRL_GPR_ENET_QOS_CLK_GEN_EN            (0x1 << 0)
> +#define BCTRL_GPR_ENET_QOS_CLK_SEL_EXT           (0x1 << 0)
>  
>  #define TRDC_AON_BASE		(0x44270000UL)
>  #define TRDC_WAKEUP_BASE	(0x42460000UL)
> diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
> index b05194502cd..c65a35c58fe 100644
> --- a/arch/arm/mach-imx/imx9/clock.c
> +++ b/arch/arm/mach-imx/imx9/clock.c
> @@ -12,6 +12,7 @@
>  #include <asm/arch/sys_proto.h>
>  #include <asm/io.h>
>  #include <div64.h>
> +#include <dm/read.h>
>  #include <errno.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> @@ -913,6 +914,17 @@ static int imx93_eqos_interface_init(struct udevice *dev, phy_interface_t interf
>  			     BCTRL_GPR_ENET_QOS_CLK_GEN_EN);
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
> +		/*
> +		 * On boards where the PHY is REF_CLK master (its own crystal,
> +		 * feeding REF_CLK into the SOC), the MAC's REF_CLK source mux
> +		 * (the register right after eqos_gpr) must be switched to the
> +		 * external pin - matches Linux's imx93_set_intf_mode()
> +		 * (drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c). CLK_GEN_EN
> +		 * is set unconditionally either way, same as Linux does.
> +		 */
> +		if (dev_read_bool(dev, "snps,rmii_refclk_ext"))
> +			clrbits_le32(&bctrl->enet_clk_sel,
> +				     BCTRL_GPR_ENET_QOS_CLK_SEL_EXT);
>  		setbits_le32(&bctrl->eqos_gpr,
>  			     BCTRL_GPR_ENET_QOS_INTF_SEL_RMII |
>  			     BCTRL_GPR_ENET_QOS_CLK_GEN_EN);
> 

Reviewed-by: Peng Fan <peng.fan@nxp.com>
