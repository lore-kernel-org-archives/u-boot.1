Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D112ACCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 812434064A;
	Mon, 19 Oct 2026 11:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BvdWmMciK3vn; Mon, 19 Oct 2026 11:17:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE11D4064E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792408677;
	b=EzZOI8s836kACzth7X5A97529x5yXmM1D2OiDlEbvMkaH/I5Ja14eSDPoE8T3Mkc2Oyt
	 J7NuEhBapfDiO9wHTi/xPDf0p1W6ImKUaVe7Nc5YSfZSVRBxG1JKSyOMZgD2k0h9aqPTw
	 H2QAJsb5y3918u1NSGU5VG+hnsYxPrMVVWUqgWrGFqgu8rVBOMRTcCQ+PPw6xdAYOgiO3
	 9DLONAdXD/xNKMx1xe6xr8YEw2ayb/B2XmenlZxV9i17QhmoGcfxJv/2txysEl0hS1PsA
	 p9aGTqsQvo8LZj975ZRkz7owqqvDL8aRmQ1N66Dyy76hxTDi3q87WHq6HC5rkCEpN4w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792408677;
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
	bh=5SZoWTf857P/W0VpPOMCHQrR84Kmv6drMmsjA2pkSiI=;
	b=sFjKUuKWy7V5iTainLh6emFvf8WKIogw3yRKK4eWj4aXCtO1O/MLkWMds+bdi9XwobRn
	 /+mGXJRnL115StuJXBZcj0VbThA96qaUekGarsovesegNWeCckUeBHFLvh4hve6lyIOG6
	 3mSQdaOcVxQjx7IbdGpbnJElgLvkHtTUbSwnKT7WCvSiuMZWrenUJn6v7WSyFeZMMy+Gj
	 hxerSU2p8MfMG5q7wXvpLnXF/mAXGxQGYmHyy0n+LvvM0bzBVHbwgyJCSETE7jGcjpogV
	 tjBM/XhB9mY5Rzddty/ABgTeKJb8FiHexKc/+ntMAUQo2AeTd6dCAoR+IxnNhZcDQaQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792408676;
	bh=5SZoWTf857P/W0VpPOMCHQrR84Kmv6drMmsjA2pkSiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r74ocqP1NtLN8ITgYKstKWfrcTXdki9REVTvw/dGV3oll571QyeUyKRiFTz2P+P5j
	 seIlgBvF0FBZPhNZuiyLunfNftNH7BiSCiBO1I24ifXlzOWqykW86ey9QTHEZoelNu
	 v6F6vsmVK3JG0PloSY6pH2KgzQ3EwN9MulxFSaFDqbgO31iPE1XXcutbf6clx9FDd2
	 sKCduMN3Z0mF2rvQjdPRv9ACkmHcmVaLYTxjDJFlHGybczSOwQ1uHL84WhTad8fR34
	 pfSYmdUmEATNIoDXQpNj339RUJUauB369weY+kjkvl4gpC8N4WVNY38znGt0DS0HvA
	 tj2v34TGDCP0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE11D4064E;
	Mon, 19 Oct 2026 11:17:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F2C31E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 009DF40080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:17:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WA6B2ZxqYDuU for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:17:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BF63040079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792408674;
 b=LHe2STpP/FPs6wgW6Jjlv0WvqpDe1er71tQf4D20HgZ0KyJU/gIPCpKEDExO2XrJuDXH
 Wny7ERZvSO32ShUUqcg+gop90Qpqza0J5oka5CbWOMxeGsNDlOnabLl5hR8upi0ibIVYK
 0RYgwsAQDpiBDCEFAzNG7Npl85xs8jqIJ1KCuOUfI4fxjaHyvd8khR15rHibPI4NPqced
 O347t6IEP85fd5TB2NQq2UjxVU2wvRpR9O31pP5njKYuEjRFQ1gOMyb4bAW3oX+LHuE/U
 E4mf1yaQ9C4K4koQSMPicnn4tvgqELYK5vvmsIgB/uhQAYZ5ucuJHjAUhtSs5YYaHgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792408674;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=5SZoWTf857P/W0VpPOMCHQrR84Kmv6drMmsjA2pkSiI=;
 b=W2i9wneESwESbh1I6AEQ/UaALlzQeYb3nytjkW48Lsvcj318yUFytm6yWoFKn/dOnOKo
 ZY2gfApKhtbTs5GspGcgQ83d6II+qxouvL833QMqReG/HtYSO4npQSsdY9qW6ux2aponG
 fOPQcCvbE4XpTsoxpz2sW37LFb+nG3u38BbE3ct4ZzvxyOhlVVZPOPpeXkZYXs6QFJJr7
 2QRoub5ITdGiyqx0QNLa5N3ClKpRiDXV3PY+uMdZYtq38k/VR7cYCbZovoQn64Ub3SlTf
 kvPRiC+GrG0epRgppiSddUoLnnkIN8JDwxg8Qm0eObO8u6hBEXpmeENzL1eam9dJFJA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=nxp.com;
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=D1Ip5rQ6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=D1Ip5rQ6
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF63040079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVuuMk2XIjifXjsedrmYyjgBN7EcTNySijQwmGsH2VA8OB0yILp3tVWhra9ucvVcFWyZhtdB/ZMp6FlsKAXkG7AI/qLaYOc+ZUjsqsdZYKgH6QD4buikdp6ZBV+TToJ64pM6YyqxFQWXW/biTogUfMQh7c9jrVTUd2XekbWHKVQPGChLmID7WaufemL/vibH2+6qHl0xV1GM+ZSpySr/OROAgoROt6uuqsj8gAXCp4tkQtTSsnXwNwayo+Q8MuocSKig4m5l3uPASYM66lz/6Xf9zFeRISf3fIf0W6VHovgnns5lc5/MwxOm4NPq6zEZ0sbdPbvOSIfbrPPnFZ+7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SZoWTf857P/W0VpPOMCHQrR84Kmv6drMmsjA2pkSiI=;
 b=VaaXMc+sPWQ+XS+A+eoEIberOHg1JI07OjigMdRLT1YYprNcSP38oEtGJTYxBgvO8NFJmnnqCSs8LAL1A13mXL+C18lN1MwMAM0nOo0fR0IJxzXNEVVWxJDlannFVCFGb64rIi1YYths02M4295qL7sZpSx32Qbn5V78iMIz4DKeYMYqxW6bfHFVTevsbeeu2AA/djbbjtJ9+qSDCF8yr4OjhvGEJoPhMPnGP1UFRjgUYHqj2XcQt058BMSXIoADyRLqvaMXMBlvw2yHXk6mqA6T1ZsxonfERULbij0K3w1xc+UJ5eXIYXRzkDYciis5AVOy2JFEVBLl9463plviAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SZoWTf857P/W0VpPOMCHQrR84Kmv6drMmsjA2pkSiI=;
 b=D1Ip5rQ6hUqh/i2MiIcLuzci9V+51a4r9XxlvmdWzyRB+Fi26Vanf2atUajWl3jBbRRYx1gMDytS2IeQodRax5juQ602eb40ZG/Jg+b6hl0HY2Z5eIxQeLUSMm09pAqrDfB2zd77jVZxTleW5gYtArSkwNM6mJnlPBqOD5/SEZ9TrVT10ZcZdKAbfpzTJJe+1sWWtBmtUiiJLw3gh/PqbaAoXzfrBAVLBfkBZecP8maX1cgFW9yAwmib9x1SfP7QLcimxjAkF4aKEKhhudt3ClQUp6JM3kJAgQfGmN3N/QoxNe+kX27X8gB41MBvkLz5+XHzV4ofYSR+98bQWk/ULQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by MIWPR04MB139140.eurprd04.prod.outlook.com (2603:10a6:290:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:17:46 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:17:46 +0000
Date: Mon, 19 Oct 2026 14:17:42 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, 
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Tom Rini <trini@konsulko.com>,
 Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v7 12/13] doc: lx2160a: document the sd1 hwconfig option
Message-ID: <q2hnhbnokzeesvxwkv4f74jo2hihwyqrpkeeu3zbdmqz3xggri@okdhulade5xc>
References: <20261008224228.512353-1-vjardin@free.fr>
 <20261008224228.512353-1-vjardin@free.fr>
 <20261008224228.512353-13-vjardin@free.fr>
 <20261008224228.512353-13-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008224228.512353-13-vjardin@free.fr>
 <20261008224228.512353-13-vjardin@free.fr>
X-ClientProxiedBy: AM0PR10CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::22) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|MIWPR04MB139140:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc9bbe5-810f-47ab-4009-08df2dd299fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|23010399003|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: KFWKPH2uS5w9uxZQmoKVYVQ85yRsXYu/+gxtSWhGK6jg5czlBOoDEljINfIpNAo/zU8gmXHgs2lX2cvmB4DLt9Ht9Sb9Gd0uLzXyB0uaiP9Ail5qUFbPwZTZ5qeE3NhUDd/R8l7GFbrlwPsdbNlaeIZ1hETHQBaUFRpPAvkXtlzvkh8ATEsUREihIwXiZF6+llvW8ia7CwnZuLaz15VMUQH906fT+ihPfKPMlcIzPDE0wMqlZHJ2j1YmMM8xFDlvfXJkWakpJkwBAGF3B0kuChC5qoRiGLHSoyigazRCzehJgaL3Bkq1xYBgc32Q7pPQdVoESqagsKF53o5KGpQrzCHb13lzmZF/wy2VCZxnBvRP8cMb0cIhzsCpTYu8B0m6JF7+6iboaMN9CGTnQp8TygsezYl2MxcgVQlnt4liF6rrVB861XSZHLEKeUKCwEcg2NytT0v50krlrLEh79Xa1d0zQN7m5I+NInDWRF9vIJByvZoS7mMtujRA4UNRTfWbEnojph8wUKUANpc33PVvSPMMW7sfq2iXRldwBkARX3YdxyiuPEY26rQJRIqPndqyQriQ/I3mzxFLjn+KzRlE5cz+3X8ZkuBYDQsbA1tZq/K73DBtHt1lYnJH59+fMaxcYheZJMC2bQHBagENXsDRpYSsxq/zrjL6YhVuwE33T11Jnk1DuSJXOMStC3ALvtIuEASF1m4z+JvArqUXHePBGDh3qdVJtqNQhs6xKXJQc+kNpXd2HZTuu73oWRGmqMx1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4V5xRhCYHOvaPWpVZFChjDv+YOFqr/v5Y+M++25Dd/5Pp3LEAf1W3LddSYvB?=
 =?us-ascii?Q?j0PfvXY6zjyAWVqZ1LxnOF6eLr9Cy3vqBd4AqE8LFkM9x5YDPeH5hRx9Afnv?=
 =?us-ascii?Q?DwYUqP5Ib/Ye1Dz7qubmJymh0vH1lOpCW6B0mgs2lCI4w8FFODfkZaZsWbLm?=
 =?us-ascii?Q?V3yZTeh9Ak6giXltQNB00NQEZgITFg3LPWdQ0Y9zKkrePaV0ucy3XcrCYBqK?=
 =?us-ascii?Q?1sV9XuCTXj++rV6RE+phEpj667Vnik7slFNS0BOBpPhNg++eKSNOaFFo/LfS?=
 =?us-ascii?Q?0L5Y/9JOJBQq+DWUkjn8vIMVQkj63xSyDUtNFQPs4Rk+ICFzV3462y1FUyDo?=
 =?us-ascii?Q?657zbJ7Q3xGmCgSsKeTmH92U3Jn5R5TIM1Uk1pWBe53nGSAK19BvhyLslyAG?=
 =?us-ascii?Q?MWn5EdLC3NYI1OZQ10pghp2FBIsG5co1hSAmNxR4aIGnF5qoRQU3WNSvPwT3?=
 =?us-ascii?Q?J78sQDU/DU1kKEbwOjp27XuBHZK67lKiMbBcdju7XO/7TSJni4NNU3rsxjLl?=
 =?us-ascii?Q?dbMlvf+OCjqF6yviPnsjcELE+5SZL3K8DWGwBWouDXTZqq8rVoj9yOwz2d5U?=
 =?us-ascii?Q?AVcjSDZZTNoElK9h2At6X3b97nhpJktf7oO0XJZoW4nTcHgbTMBOm5ZwkPZb?=
 =?us-ascii?Q?Xa72puzhBSljsNmOMz8JOqP3ADi0a7Uege5ZBhdT3x0EDg1T3pA42FdkdawO?=
 =?us-ascii?Q?kNZlS3Lb2DounJ3ZFVWfWfzYjbMnmLv71fgZLTVg56ZGWCv3Fpn2Iz0Yv0na?=
 =?us-ascii?Q?8AJ0e/47w+MkmGAsSKv3riCcGwghkhK4xmu9fuiEahzh0vOPCmerxAB6Aoy6?=
 =?us-ascii?Q?Bxv0oaQnqsmQaOVAUOpF154LM20+3mD8/dp0jc5hNoWMkfUO4jAKqro1jO6p?=
 =?us-ascii?Q?iGVUtNgD/c6MvokLBTGZFjQSRN/cj8PxNaWJvg4kVPKAzeq/OxoTz9vmYSO2?=
 =?us-ascii?Q?gHViUaqW5j+kKt8ozifGh6SWQa7EpNHsZCfYVUiS6+i13HOB5dXKvuxYGzI6?=
 =?us-ascii?Q?E26WjW2qQ2q5ZLolLAeGgLWvthHWayeW7GZy8TXOx573tBDpc4aIWPNe94ZY?=
 =?us-ascii?Q?+9//WTJnCO0wB1hSjw65Wv6cJblaELQI9PfFMAFZs0UjlFpqIIFwV2u//ujx?=
 =?us-ascii?Q?rEh9nOkUYhE55f1802g5cK8oFkazJgNgAgUsCJ6Gp2izHRrTz0wwHtQrCPVS?=
 =?us-ascii?Q?Yze2IdDuBLGGSBuHT1azWl5uBtGD08/9FGesqQdik3Xam903hdIF8+SgtXbW?=
 =?us-ascii?Q?dim9TMHrAYkHwzgEu+iatBDsdG+1FsmREkBjtsXjKBhhGPFwN6MOsy4J6Ccs?=
 =?us-ascii?Q?Th8lF49fOHJYGswAIDy79v7aeS79E2cWiBQLHOiPvGLx2spBr68edBoQjxUa?=
 =?us-ascii?Q?oFLx/KOgBikJ9o46xzlzM7PgD0UaUcYom/pHkwNl2I8UxAlwv3ZuoaIN90ys?=
 =?us-ascii?Q?vu0ShVU+cwF6F/+Ed+H/4oSSyQ+E8ajZdBUfHQoIkPvlzzpfv8lZYmQKrCIP?=
 =?us-ascii?Q?ww5qu2oM6iOy5EfEnaSe2+Nlg0rdVLdD8w8xpa8olM6VVqzjMlhfRk7u5aD5?=
 =?us-ascii?Q?dUDsM0mtXShDeJhFU9+Q3ZqO+OKw/4Ig+HYo1vnrDJqm/lCjoko7q45nogBt?=
 =?us-ascii?Q?Q0FX+D9Rvw+ukcveimwF18SLQXgGPnLOg6531yitOeb5IsXn/7quEE/5JVJG?=
 =?us-ascii?Q?1BA3MVkElMurMF5Gi65wVkv034BnfXzWRqJ3i/2oyOuUxVwyjLoca63iPpy4?=
 =?us-ascii?Q?jAY+YXM+iA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc9bbe5-810f-47ab-4009-08df2dd299fc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:17:46.1953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWuWVPWJpPhHBKJ3BX5pphWAUcBHIrq9K+ZjfnUZGHe/iRwYoRv6jJSpiJbrG93ozhnH7ff34lRVHrg2WxiuRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB139140
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

On Fri, Oct 09, 2026 at 12:42:25AM +0200, Vincent Jardin wrote:
> Enrich README.fsl-hwconfig with this sd1 reconfiguration scenarios.
> Add a reference to the Layerscape README.soc.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
