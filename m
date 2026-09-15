Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7212CC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 09:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 972DB60731;
	Tue, 15 Sep 2026 09:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HlYsmQNHbsXq; Tue, 15 Sep 2026 09:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E20496066C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789464923;
	b=gmpnxIFDL+z7rtzciMunIXLYDJq0jk6AAQTemWJ65ueBxgyKhYgmpxI5btg/Mt81hanB
	 mc2O7SFKvyGKKFA5s6zseg7Qu51BrS0RHbZ8H2Q3g1cHTm1EjXacjwuolyymWK+5ciTmU
	 OH0opm42X5nEh5Yix60fw4BZ+1q1fAwXnI2M5F1whl+pZziW8rQe8M3LkDL3Ah7wf6UEy
	 0/fa4yv/X/1ijKY2nedBsP7/x23NQOeMCsdL78XhqDHWZVQag2v1Cp1T0QD29SplAAUg5
	 TGiWkqAGT+bIjR2AVc/9GVCG0Xe252qZGBXbflVnO8I4wqmTs4JcRFlUYaMgRlYgviw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789464923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=KUjByUkgEST75CtqoK1LwGNWOyx8AqRPj67OkbehB7E=;
	b=Dfk5ssI48NEd7y/LIUPNji51RCZAzFSVXmPuDOIZp/SBksQZw7APu+4XH7ZAPhwq7Xz7
	 FExx0PTppHIODTEv/iwg+A9cFu3P4vR82fD3hEWKrmM7hR6LiWfPU3bAa++zTOuEIxgSd
	 jIgcF6nTwCE36lwJ9IuO5ZI+0Du+Gi1+PoyhMFwvR/S+mqDuRoHYu/qkZsGd80Il1rDp7
	 YFnTzLxVy+W4h//yAAIarE9Q/Wt7OigcP8kJwsyVLvzmC+jH9vvZlOFc3d2x9n4mTKDXv
	 B6/HmFH6TwJGuTC3rchY+ULnZ0bQEj8QdVMq9fohfIYbfKRTW7B5e7AULMbxqHm8ZEQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789464923;
	bh=KUjByUkgEST75CtqoK1LwGNWOyx8AqRPj67OkbehB7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfmMvQqode4BWG/otSwlxPNnGLALdenTJj5MczKmDs10wSBwInp5/Jfeqg70TznIO
	 jPJblrOKcABvnRuLxFodsITRCpNVuHbgw9gDaGLSTkHK8qQQTgfzu8oEr6Uc9Egfr5
	 QsjjyxJ/Lb9PQNjuihhbQdfZdWUGGoY8U97uLl6ZKal6bAy/ecYxMo+1jm5M5/oZ9b
	 UftC/vQiYgxRIoWn9xcQANL2UJWgYrMsaCsW0C1VtwvYL4X+50euUZ7oScEqNC9ACg
	 WUcHFznOUiLL97FJSNaVQ3bfekZnfJwEW1AvysX1W5iu2c1sm67duMpq8MWGQGBz7w
	 n7qxOWfJBc1sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E20496066C;
	Tue, 15 Sep 2026 09:35:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CEEEDCF
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D7DA401DD
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kupn_1Ms_VQQ for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 09:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 14F9F401B0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789464920;
 b=VJvdgIMJT3wup2Q7w3aEUMDSeRlGrd+s2zXgRM+Y9qyOoUhMv9TdVtkS3Cwy/fX4ZeNf
 B5lCABcS41mEl60xGDjF0IurfpLci5nRDMXC+i4H17Gq+zb7oyLoDedeEnbgp94LeqZ1C
 5KWmQ8vb3SrnxnoqmxnKvQkptBoqmnFrS6sgmfdB6YBqAcOs7/4Sx/n33eIRGhhk+w+Mx
 kd+ir+aE+tdhxOflHXxa68KuHhN6prC0xSmjyfep6jBzYDmHWAwxOD9ylknWZAGhHp37X
 Ash2HDNAGgdM+p/57U+kEx6ZdLHALk71xjY0AskNzKs+JE0WRLFuBE34cuDvPOfF4iQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789464920;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=KUjByUkgEST75CtqoK1LwGNWOyx8AqRPj67OkbehB7E=;
 b=G1uFPZ3w1Sa7UkFRZZTfJ31v4i7bHBnJC3B/Qb8rsXDUyTL/o1tBXq34Qk19/vg5FmPK
 aoHnz9vEAwP29wBBBwio70Q9uXTabfp9qXtw1Au1dVxM1MlngjreDfRUEY25YwWcbYKJX
 kBa7SwnXRRnpO+spGVnabIVL5HXhkJrVlhngbLjFZ6c3E8pFEe6dAuMH0qy5ri0X+EJFH
 K171qDmrz7CQhfBiHZXUjndx+pFItaIMm5+CS4l/uuygJHvPmHzInzYh5sPkogOLnAGET
 QWrQkmh04gx/7WF1gqY4MOnuwmQ5h9WIt9HH4AegyXYteX66qAPa5Ckh/ernHZK+rxQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=L4CqwrsL;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=L4CqwrsL
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14F9F401B0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgQYQ2oNGSnqOb3Qw7tnl2/XdGQ7/6FFZJlRH8zHSBFDNrvVnZ+qviNENkCyqlDgkHSV9ZFWzoMPsRKdX5IjZgLx06xb49ujYDuBSWmTHzgmKcxNmbggVWS2Xc3Ve/1fGnwKcrPVhgSj34Bx6x+HjrZAAZ0RCqr4rdPScjewlX3RaN9WEXidr1DG4ilEqewyoCNTQMdfhLctp+SkPEZ3aU1p93DAd3lUQiVUYDlnsq9ogb3kMxW6ikDC/jgd2cn4YsThcbG5itLHci4/zUdgVzQPdDsOwqZqnyg0VXUciWjsSTito14NbldvV5fbP6y4nfGJODSSe/N3A+pa4g76Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUjByUkgEST75CtqoK1LwGNWOyx8AqRPj67OkbehB7E=;
 b=FruJJDpswmZOZ6FdLJayrmFKOGgvXQOhabJ5NMnCcWiNyx9tbXU1DvqEPcGghS3AyQIB5wypm+yGSB704pcZfgAMafrJuONXh1rlKO26ErTJxkzOP1qBkZHHzEgSrorjfoJELcVdMslKAAEHZNX3ye+taG4yTu4Q3h1fQ+yvGKVMntUUeBcpWgoYROOhQLWP2gS2xrCYjGBSyYpcJ5XgmUJXQtwg5tm5zYlHSg9j0cMbuOiTjufs1QOUesjo38h8J88QyxzfR7rIAZRaVPYm7hC9BTN0NozhTKD5Abn+InW9sf+oysf4CsnkFgkabHsKcZJBP25eBQwszhY9LH5KOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUjByUkgEST75CtqoK1LwGNWOyx8AqRPj67OkbehB7E=;
 b=L4CqwrsLgv6DSctVmNM6iYRU614JH+9G13TDZoF/4ZNHd/WgSiK0iBQG/ucmZoOoSsD9BoL8zTlYYopgQN552TinMs3btRMRMrBoZDVsZHJsqUtOJIYWtWaoIkEL8NAvbUAk484z386nStkj23gQkU91aMPCrIoLvNOEEovXdivKYT4KgPehC/NaPSlzGSSET8LBrCaVUFsNU3PaSivegqNLbnP6wvOWd933u3DPmGwGZxjhGM9U8st24tuFsGwQ2Vb5B9v/rdh3UMqEJeN0DMN/+Myi3XX/55MBZMG8XH2MXoeLqyLBQaFkmF+/CzB5vlKYqpu9MDF1cMYowF6a8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by ZR6PR04MB602044.eurprd04.prod.outlook.com (2603:10a6:910:e1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 09:35:13 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 09:35:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Rafael Beims <rafael@beims.me>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, uboot-imx@nxp.com,
 u-boot@lists.u-boot-project.org, Rafael Beims <rafael.beims@toradex.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm: dts: imx95-aquila: migrate to OF_UPSTREAM
Date: Tue, 15 Sep 2026 17:32:44 +0800
Message-ID: <20260915093247.2738336-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910192216.518123-1-rafael@beims.me>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0279.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|ZR6PR04MB602044:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ad8c92-dddd-44c7-d0be-08df130ca466
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|23010399003|376014|366016|56012099006|11063799006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: RUQzoHk20DA9P2w4VR7dmKm0Y2JAJ4O8BgYeFnf51/2hJvUQmut/cBZwxaAoYyfjuaTN8AGJh/F+Pd8jqnyvGnDrNNQweBBSjFCBJHIdlXgNOLvZpO7N7D8i1NtgNKWu/YQ4Cxbtq8xINoi/+gLNtWDiGxqUkJ9xxaEXbt4hCvQQSdSZONOuqLXg82HjR1c/kj6zS152zAeN2CoRa6ziewNFkK1SpYvAr7mjg+EietbIajpcMwCfcuwnc3Bs7wCRdpsZrhm+Mi+ICtJMX2rEBsszqptgulHw6WOKrwMT91hMtYmcivi+rVlf1qvFoafjheHG/mZMdHocsD5IQYvNsOwBJ+P6ZANKEes+in+Wwz3EXKdFMmYueOIavjj5PSd07uDyPUUtG+FMqJytO6dg1yzqJihZtG0YFaMWexDARGx/jNoj1KJVLjdc7PhYwzHkHU2eAf+MRBzD7QDzT/0sXVEJhxAm2eSKhi2FP0ze8OV3kkyHeT11bZ4Ji2xMN9Jvu18/DxyEr1DEGB8bV5y445697wXWmDCT30Iu+VxaGd5A+QP+PyKdHNQZa5b4/qH5SMNF0SXfOztYMoxPx4e7vdtAbbli4UO5UM6ON2EhJroEdaG4djRKWLoImntMejCNxVDyfGahP4qv3Vv0XoilMd1b1PAKanTZUz4WoxzZk64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbaQFx8TYAm9PjPbletd0bkte3LDGY7zvaNOQRv0X0m3ThVz9L80yhXIi52B?=
 =?us-ascii?Q?L3iYl4lRQNyt3aDdF4R61Ve8e778WGF7l4aOEkLUI7jBtRyHw+OIDlFlF6ZK?=
 =?us-ascii?Q?rjBCo3MN6WTJvCZwhZHFivUCYJIa8z42ojZSyZQmNanSK/Qk7CUqPLOKv+2X?=
 =?us-ascii?Q?W9EJLsdupe9UXSCnRblM5yw9Zrcf2X4uqvpNCo65/6tCPay/Ai7+SngZL5sw?=
 =?us-ascii?Q?Hy/JHDFiUfv+v4yM+ZeCH50K9reJb6TvP3AEg+DiEMJXFDF6cjy1qLzl6Kfy?=
 =?us-ascii?Q?73hsY7se9Ih1drEW6pS9uhH3e2PG7Qm+LO+82yOBWfuCKERo0U5Bd7Kw/5+f?=
 =?us-ascii?Q?IB0seB8kZCIoB65iYPfZC6OF+Yxhw6BJ3OFSjP6lPLWuBNnjP4awkZYtrLwB?=
 =?us-ascii?Q?aJ6csEHXt4XQike89LoeJymSeXVzXwdlhyyD2ErVvrQvcIcH7ms/Z+UY1lm+?=
 =?us-ascii?Q?MCHiLLYDJfvce2kQjINyClyY9ebCGit4WIt63x0uBOPbgE153KPXzTOQrlSr?=
 =?us-ascii?Q?RgcsrhFJo600+qyRevsm5y1FI8LND1tmRkU9/uJgQrXlGeiafrbDaTbb3lqq?=
 =?us-ascii?Q?mkI0mCOmotkNDeopqCHcpTXMV9rjlj1zbuCtp1sXPnu3Xenw6MQzBb9VobCK?=
 =?us-ascii?Q?1DxbQteDOeB3BSZ/DPLoa4XnmJa0QALfUK7Lh5ElfpOwIHFnJAo7wCsNMln8?=
 =?us-ascii?Q?3ps/wbcc20kABRMOj8rCIurpbyQTA/tzydNaE292PhANNtaQeCYG2bvdMmHS?=
 =?us-ascii?Q?SIbSB0W7G1Ml6K00KBpwb32KnfmfZdIDLE8BeyKY1ND1uRiMxGiL9uOS6Crs?=
 =?us-ascii?Q?xsB4898XWNN4V60L5SRYmQgncphNwTgaksWm0T+7UPpWx90rfkMiYcJZIBIJ?=
 =?us-ascii?Q?6Cm3S06Cky0s3mgP6Tbl4j0G8yQMdwAIwAdhLbGzWBhMuHGyb+L2wvI5TBMy?=
 =?us-ascii?Q?RzfkcMrPjeiOSX+NvR4heQ8HwU/omaGlv+56lbWg/vYApuEh0K9jyBGJXvPd?=
 =?us-ascii?Q?iDBUaagMoe5H065XUkvtNHmO1OcAVPsXBK+3GUpABbuSnVZGpPJMz7TMLFxI?=
 =?us-ascii?Q?calXQ4e7JeeTU7lfTpL8Hn+cE60HBY3hFSLcWccOCHXPYMxO5uksgsEGu2gV?=
 =?us-ascii?Q?bd0Jdoez9WdJhEjG7uxuKQR1l+vKX1l/qWGL8bbkFXeJ+6xzLT6fHlPsF8NW?=
 =?us-ascii?Q?X0UYTYXW09w0pSYOFJxM037CSma0fRcxH3zkMW0R8yNCizrbyi4KB4sL7EBe?=
 =?us-ascii?Q?xD+wj3NEWRpRotr+UuvC+fKJQ2eFsu+7Txm4Xh/f9W1P4HnzMl817HziGVf2?=
 =?us-ascii?Q?4Vh7DbY337Adw5gAHAClKK0g/HiKe/u2E5YSYnHer1acSNf3nq9roHnEUayF?=
 =?us-ascii?Q?s9+92lUiGUPpi3oqqds7y3H95Kh2NWeARQICoHF6UwGiEfRTh5UPA4PX/Ip2?=
 =?us-ascii?Q?ozE5bWmVD9VRwX2QIv/2wLghY/SsY2dmNX6lIw22SToEjXiYIUoQOVBkmqzY?=
 =?us-ascii?Q?8t9UqdmrU6S4zgf+5IcNLKgR01uU+Z+zsKzYcELqjOJ9HgMcHLsNsjV290mW?=
 =?us-ascii?Q?GLIcV8AK942JjAoFxAdVOFyIplSb6DfZrmnboU/xoTZfebkHncpS7EiCuY/6?=
 =?us-ascii?Q?se9/qUaZasvdVSlTIF90pCC40GBCO4adf8Ct5jhcWXDHZamnfc1lqlme1Qrz?=
 =?us-ascii?Q?PM9VC7l9HXaSDMKIE5dHdfwQ8RugtY6ulmMnrRIEElNJrlwNW0VPYXrg/3jJ?=
 =?us-ascii?Q?WkyQazO5tWHuCfqpZ5T5PuZ5wB7ai/Lf5ndWtq6TwB9Vz8Ivr4O9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ad8c92-dddd-44c7-d0be-08df130ca466
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:35:13.2622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uhgQDzDPVowdIsHrY8schGWIprU2HbKCRfCfmLGh9Ztjrq810MPruQTKMrHhbHU+cCxEt2dFjdx4u3P7aXTw0EsZycDYMm81jC+Lnx8O628hKZ01M8K5WufZ6ltgC2b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB602044
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, 10 Sep 2026 16:22:16 -0300 Rafael Beims <rafael@beims.me> wrote:

> From: Rafael Beims <rafael.beims@toradex.com>
> 
> Allow CONFIG_OF_UPSTREAM to receive automatic device tree updates for
> the Toradex Aquila iMX95.
> 
> Remove the now obsolete device tree files:
> - imx95-aquila.dtsi
> - imx95-aquila-dev.dts
> 
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
