Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B5DC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 01:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5540780C3B;
	Tue, 15 Sep 2026 01:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fsiDaB0Pmytm; Tue, 15 Sep 2026 01:53:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5C80880BDD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789437236;
	b=BP/xZPrsWveJB9/Bpj8tFiAjjVKJbrZ0faXvyVa7L8xjyTjPJFF5hHs2c21IP+vSvPoM
	 UxfQ2J/dLObLZ4Piw+rTvfLjg3JXPvIUC7XBLXNBSXlRJfW11Og7fNilEQA1StzWaexD4
	 TE9obSZ6P1ffrrxG9eBS8CWnmcIzMblOEdfbJS3YPV5mpqjhe+w3BqcO5LZZ4MuI2tqxg
	 sLLCiD2Is8D8xk4x+JVhsjwb7q9ziBYo5DQElhjAN3r7tROHRpIpTIiDJhrBxKwhUmN7X
	 gwb/WJ1p4D5Smok11nS6uS5fhoLWsoHV0xbnAVCt8x7FG+OxVcvS4oj6Xx8fcdoRIYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789437236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=5h9gSyd8gkO6kiUXbW2iR82fr8EPfONBE50cXIbsH4E=;
	b=WqVBjOfUOcEOHC43v1J6Pl6K+ve8O1/ZM+FRReWwHB9oJRGjAUaUJIPUUqlG830Gs/WW
	 HyAXMnB/GTN6XJ17WEndZnbfL3pj/+n+fFB/8A+hFJNYCYAk381z44tu6LjHn/ZwV0Yd1
	 r1bTfWRrS0T71TINB9Q4mSgTn+QwfsGTNrTMNfS6HJaaP9AdLUhYgQ7fzVM2dGtRJP736
	 ZfllPEgWaLoFsyi6FdZAWsEhG8rIfVZGXq6DdyRjU1RyEEeIx77L9/q6EKElzRoePBNLv
	 7mRjESfwP4GXP4g3KnSGq8O9Lxs+CfGnZ6Tvhjyf3gMdowalXVRLM3+coGAv5xO4RkQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yDl9dnrZ;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789437236;
	bh=5h9gSyd8gkO6kiUXbW2iR82fr8EPfONBE50cXIbsH4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=op+kxbnYs0UfVrqTx/6gcKMzywnuSNzGxDT4KknSrjNESMcYme3quMRewYwWaNg1n
	 5rMRLJVUzRnm4iIPDl71kyyu279Z4DOFJm3on3NHSrxIXHbouurtI2XRjAg2Jxz/e/
	 URE3IONgO9kc0PbdOuL6UO2LuCJN+obf+5u5ZIuuZ01F3Dq7YgHhXjd9/qppv4Y5vE
	 n2K+uCepYkNgK2oCdBtJ13X7CZklaqs9jdQSwiMN+PC8rHZoDk/+ehc+X+9YxXQwaG
	 0HHpRrrQOMq1ycrs679cJ4ifq/z78B75kS+Q6ZVWs5LtWA+H8GYfjQULpQOkRIeeO+
	 Jgyie5y6hbtEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C80880BDD;
	Tue, 15 Sep 2026 01:53:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78E8F259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 01:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E7C880BDD
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 01:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vyvfWU0EPsbP for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 01:53:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CF7F780BB9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789437234;
 b=LYwnbr4L70PHeWQkAV/K4Q785Nf9TX4l1i5jBejOUwDkHRm2b7TT48tMhey6Rr6Omf1E
 GC5y/OyHYYwLLoGkH0tEwzTXWvHU1KjxPEFaCocYyglJes+aGCeLVLXDEwj7g6CrsWSEd
 5922zdDjWE0KlNEX7mq0n/dRq8e3aPWumuUF05vluB1OecNoPxSBN2u8MYeXZX3jIMieh
 yQyx+65r6/3UVngNfKSFMWlev7Yn4g09x/avlSDAbNK/oGlDJ74AD9G/Ra857lOYpdfX5
 B3dw+BKE6OAaE/9jJOvIsKP2JUU+u3WqCjQDx8liM+jSlKJZADKJwkLwDPMg3b+K+vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789437234;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=5h9gSyd8gkO6kiUXbW2iR82fr8EPfONBE50cXIbsH4E=;
 b=FabYPBjGlNGjq/UHXlWOPKnMnvRPN2F2FeEkWKUO5EJNl6sd2ECL2yG6EQRd+HYSIozq
 ku8Lx1vUfqB8UU11qVYr3CfCmwwUjU7gOmr30Dpmy7c2G/6ArEsNztxiUMs4dzRxMrM21
 FiO8izPmkL0jCGGve/ZBseikIxTe+K0LyJca8AbIo1nGXBcDZSxCB9mAiTdaHgZEsEcF2
 36vJ7wYvpeX6E7wGKHsYHAgm32hfEMmNKVZYmo/D9mreLW+2kkk+rLpgujveX6wPNJmg8
 NUTXvZQFSv3FT5TC4J2ZTSfjn4iYjSBaUtwRxlNydODq5Fdw4u7CozLfIncgl4TeE4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yDl9dnrZ;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yDl9dnrZ
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF7F780BB9
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 01:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7No0TPKowKU/QqRrs1w6rFLzOvipIe5TUZ+3v8NfKXVWkesud+7TbMVEChde+e0hG46CaLT1VBgWe9QO2c5XVsF0IGxaXVznteC4wEUXdzQcGzWa+HduyRBzCoZElWOyxno99hBxr2R+dkLItqfLU4e7qJA6Z0zmAkYAvLF4BDj04Dky3Q/OBZLEKxNDacHmU6A36v3HBCv1Ga9jYklceGg3SsVbCcZHCdJp2FVan/7qU93wIpexJeeYTdQdJTwytNtDCG2AXJw2GfM+1Xn+oUc5MwsDYSMY5azSkrjhHgwBMwrSXn3VHx7Xkf32lOENI7mXTSP6eafq1IHxlwpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h9gSyd8gkO6kiUXbW2iR82fr8EPfONBE50cXIbsH4E=;
 b=lH+3ehYsf9Z2PCTrZJeGDI5eFYcTnMa+8uGKiI7swrRKd8DHbn6JQa2LhJvZAVKKQnZ4XRPPgbpJEb0QvPl6pAv7IhaS97A1H9Ca78ndRcXIf02vi+w4sQpAkANbkTVqM7xQxDLTZevco7KZc8dKY/we3religPhQVdKhozDimlhPHT/C0NlyGW5Mg/mZj1cDAbLtljbbT0UDZTmeBDGpt45NHbbN7b8MUd4/C+99rKRzMzgJwRnZNYGtPk5gloLBEFrJ52aIc0T0zI/H0iZrVoEW5Iqi5UP5gXrf4zK0rz5EyjhJN9RFnLk4FerdTqP0R2VrHUDS/weN/iQ5y6AKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h9gSyd8gkO6kiUXbW2iR82fr8EPfONBE50cXIbsH4E=;
 b=yDl9dnrZks4IS4xgbsXfmCkEsYPx4KkwhQUlKYnR9nN2PyCLt4RCnvv+ALSqIzB5W9r3vl9sjNJ5LAJ8pg0h0uw9MLAY+f0GWymkUGq4nBGu8BjGrRsUqXpF0vb0C5xKZCsgztSfIGSPiQzGNlcx0WqCRj11dUq3e1U0R3MWn5TdCMBSZegSFjZfexVfhry4kpomRmwDWpi/WBAQP+ajQqdt2O1t+dbjsvPcyiXNfCcBdohao48wmxX0fx9toTgXm9mdc46ofuhtDD+FUl17r60n6FSpMzxrWuXnTV575pJW0CqCg4ZJ6yhTQPDXnKnTVy7zmCDuFRVLa9ZpPWLP3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBBPR04MB7883.eurprd04.prod.outlook.com (2603:10a6:10:1e9::23)
 by GVXPR04MB11668.eurprd04.prod.outlook.com (2603:10a6:150:2c0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 01:53:47 +0000
Received: from DBBPR04MB7883.eurprd04.prod.outlook.com
 ([fe80::3a91:cf25:36c9:c3bb]) by DBBPR04MB7883.eurprd04.prod.outlook.com
 ([fe80::3a91:cf25:36c9:c3bb%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 01:53:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/3] board: beacon: Remove i.MX8MM Beacon EmbeddedWorks
 Devkit support
Date: Tue, 15 Sep 2026 09:51:16 +0800
Message-ID: <20260915015125.2737587-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAHCN7xJKwZXdJW_UnVB8rTaAzBfAT+wyua=52Q-iDzz689dZ-A@mail.gmail.com>
References: 
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To DBBPR04MB7883.eurprd04.prod.outlook.com
 (2603:10a6:10:1e9::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7883:EE_|GVXPR04MB11668:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ece543-e18a-4161-e012-08df12cc2dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|1800799024|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DGi4FPL7Ocm4uYY7vW+fBqFWzn0EVSXiQjAvZ70/N40nDvW309jYSWubeWXgr4YgDwu9/rtdyOlRxwHLdIT7X+BmewlTcd9sFjt1A8iRsnpGDUm9iDSqYBQkzzU7UYPO1r9duAnJ4XcyqQbwwrF+j/ItmdpKzzEKA1+d3/Yiv01p/seBpxHA2hIccRAQyVVlWjj+kNnEqSR4LlY5uVzqmeDgqkoOcjo6u3oHO5FwZ4BRA64wAAySMzXcrAp0oq0qzYL2accdqVym7cXktqbWcddjUJ5TKXwPUHPbSRymoBNPBTbkJG0zoHUpq8B7Hra05dMFAPml/CM3AHPk6p/Sl8tginjbln6xBOGQqAhyLjz3cMp+RsEpRz1Gpuk5Zy+tKcjFGV6gEGcxBVCRv+UL6k+ntyuDkXeJ+u9jnbY9Tn85txrPanJ2B2+pKkmRC01da5BH1xIqhGdAdBBDype1vSHhbmhl5qBa5bCuzXxlOXW8RJsUVhurAD2NR69Nk+8V990yYy1aWnZSG+59JcYNJnZsYyERkPANopxn0dCIEC/p1ouYkzRacWIWmBVv+tl2xWKOGydvllooND7nr9arQ0cXHoi5Wai29Fbbw3cPBH7xnS860fHBsJcOn0CTv+k54fjOMbBhi5qSxLopZFUdEicDXx6N4KS6ZgYPtnpHNnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7883.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmR2d1RENFZldEpBMGhXWkNiOVdLczhMeTlRelJudE42T3RRNWpEWWZZMGp6?=
 =?utf-8?B?bnJuUmdURXJJc0diaE40elVjaUhtNy9rS3dya3JwRUo2Q2VJYXJzdXMxUFpm?=
 =?utf-8?B?Y21yT1pkQkRXRlRQQlVuUTV5SE94WTU1KzVNaSt4QmdQZHVvT05WNFdhekg5?=
 =?utf-8?B?NVZOLy9XWldvRWIxKzBQWExSYUdXQVExdWZVc0g0OVdtOEFZVEVHUXN4b0Vm?=
 =?utf-8?B?SEhTYlpHSDJhM1FGenp6dmM3UmVyanhlbUI3L0swRXNveG1tMGlBc3oxdngy?=
 =?utf-8?B?MzhYZWVLeUl1aUNZUkh2cUhUcGcyQUpEZnZLbURHSGVmTEk4cStjUEo4M1NC?=
 =?utf-8?B?aXJLbkQ2VTZBVGp1cE5mV1E4M3E0c2hWbElpd05RU0Vpc0hMWXNUWXQ3Ty9L?=
 =?utf-8?B?bEszWEtWYlp5Z2FYbDhhQmFTYnNhVzA2MWhxUnNqT2NXVnhZUzR3VHYvajQy?=
 =?utf-8?B?aHRsZUl5OWs4aEMyakxUWHpIQXgydXNKb1hOTkJ4QzNCSGtUeWRzUFc0azRV?=
 =?utf-8?B?ZlJGT1FUbjNWUFJsaU9IbFg1dE1hYnBzU1gzMnpWaG5hcldLU0o2cUlkMlQ3?=
 =?utf-8?B?bnBMT0htYVFIL3VERWdBOHltTnhMckovY2c4aDB0czlIUjlhQmhSZ1BzRjRq?=
 =?utf-8?B?OWtsMk1kdVN4c3BGMGVZMSsvNjlGZm4zN2FQWXhuTXJsL1MyWkdNeVlMejIv?=
 =?utf-8?B?dlIxWDYraUJUOFY2Y0hSeENTR1RqTGZNRzFjSVNKclk3dER4YjM1MHBITTUy?=
 =?utf-8?B?aXQ2MmhLV0pvS2xISlZmaGswUHlhNmt5LzlRYi9kTUxTdmZVeEtvaVNtbjYx?=
 =?utf-8?B?a3RIOHV4UVJ4SFQ5UjRWa3ZlcnIrYzdEYmhtbXFtVTBEeGxUSHlMRmJsMzk5?=
 =?utf-8?B?M1ZDL0piR0hnbzkxNy9rdzFmRmlKSndORFFkaHcrT2JrS09pYlVqRXJQL2VK?=
 =?utf-8?B?c3NCOWZTN1dsNVJzbmN1RWJDRGY2V2Z4YmpqSDFWNjhWWUNwdnByWDBWM0du?=
 =?utf-8?B?OVUzTUl1RDc5Y3h2SjRWNS9LMWIyK1JHd0NHd2dNVzY5ZkF1eUloZVBQMDNP?=
 =?utf-8?B?QmVVaDNJWnMrVm5SekdKNkVPb3dWcDB3OEtLUlltSHJoU3dRNDZOZXR4b2tT?=
 =?utf-8?B?RWsrOHEzUTlZeUhnR1lLWVdJYkw1RFN3ZTNwOWN4OEp4aitZSUtXa3JQaEZJ?=
 =?utf-8?B?bTFqR2lYNTc4alpiM2hubU5VZHJTWGF0d0xvT0VBcThicDZLRWMvVkJwZVdX?=
 =?utf-8?B?czhxc1RDdXRSSE9qelozS2RQVXFsVCsvdHFpYmQxSy9ZQ2xPT2tKSU94Ulhm?=
 =?utf-8?B?QVFsZ2RBOTRDWEFjL3hYLzErM0YxTnp0cUp5NjQ2RHBWUWdHREpHeTdlME9v?=
 =?utf-8?B?d05RaWNTVlFpZGR2cjE0MXg4eWpWRnQ4d1lTSmhFYytDUW11VHpBdjRvT3BC?=
 =?utf-8?B?VERZc2ZhVlE2Q0pubGZDV0RtUlhSMy9Haml5QzkzRHRUb0gvN2IzM0llRUYw?=
 =?utf-8?B?eU1qOWczamltVnlTZjRPZmp4RnNxU1MyNFlkUHlmZTMzb1BNcWNhMFVpTHh2?=
 =?utf-8?B?b0M4YW5oYjVMbGs0SlNJbGlXcWRhRVBMRmZ3WU4zZGR1YUQ2K2dHbERHMlZD?=
 =?utf-8?B?YzFxVjV4VTFaTFBjRUlWOGZjUnRQMlVxbFZsRlp0V092bmE2ZWIzOFIvejQ4?=
 =?utf-8?B?R0NZTk1IU0RFNWh4VytpMTNrUjVEUGFjS0dJdTB2SDdCcGxQMkFGWko0NmtU?=
 =?utf-8?B?ZVJPMVBid0xoL0tqVWpzYjFGVGxXOUo1ZWlNNzVKMXUzaU15ZlEwNDNKOCtB?=
 =?utf-8?B?aWE5YVZvb1ltNUFsNTVVeFFSR0lzdHlLcXhZSFIzbzhzbDBTOElBdXU5dCs5?=
 =?utf-8?B?L2gxeGZMS0tqM1oreEtvKzhyUEVERW5tdUNQaU5nSXlXRmVrRFdEOXV4ZEFU?=
 =?utf-8?B?V0lnQ3AyOHQxd0I2UVpCalp5c3JjMHRqZi9EMUxZTjN3MUZnNVRwbVdLcEFw?=
 =?utf-8?B?NTk3S2ZwbDFQcktWa1owQkl1L2lUV2hhb04vdVZJQjNheGtVRTBrdlU0TXVl?=
 =?utf-8?B?enprelRLdkpGS1VYc05wcnozTWRxU2VzbWFlRm03L0p1MFRkS1ZiL0Irb0hX?=
 =?utf-8?B?THcrOWpTSnNlSDNTaWNpOUxRbG03Z09XclhrRVZuemkxSDdUM2J6Yko1Rmlo?=
 =?utf-8?B?MmVsVU50VTJJME1udHVPUGhYc1ViM2lhK3h2N2dENjNmMUt5SVg2M2VFMW1R?=
 =?utf-8?B?cHVKWThRRE9yQStBOW5YZlRMZWhyQ3QwYnNLTkJMUTNrNDJDeXMvMjREOEpp?=
 =?utf-8?B?bEdNdDVrbGpuTXVsQ1AxWUFoQnN4RWpnMUx3OXVJa3Z5eSs2WUVwUjFNQ1pQ?=
 =?utf-8?Q?tZNwu/zmx+TCcBkW5iuN5+vUtKPmMIyDsDHem?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ece543-e18a-4161-e012-08df12cc2dcf
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7883.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 01:53:46.8048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0DbvAYaa+g8LVL4/jb1LkIHT/HCf4XYmF/964M6iOOzOW0ffLZadZvmFA7iVjKy+b3n/UcoFsFjnCd+wJKVFa7eTMdBW2yExVQttiV12CTyVaQVDDAg/750zY28pw9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11668
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

On Sun, 13 Sep 2026 11:24:31 -0500 Adam Ford <aford173@gmail.com> wrote:

> On Sun, Sep 13, 2026 at 11:15 AM Fabio Estevam <festevam@gmail.com> wrote:
> 
> > Hi Adam,
> >
> > On Sun, Sep 13, 2026 at 12:53 PM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > Remove the i.MX8MM Beacon EmbeddedWorks Devkit board support along
> > > with its defconfigs, config header, U-Boot device tree overlay,
> > > documentation and Kconfig target.
> >
> > Please explain the rationale for removing these boards.
> >
> 
> I haven't worked at Beacon aka LogicPD in almost a year.  I have asked that
> someone take over maintenance, but nobody has stepped forward.  I didn't
> want to put that into the official commit message, because I didn't want to
> sound harsh or snarky.

I think mark the board as orphaned should be fine.

Regards
Peng

> 
> adam
> 
> >
> > Thanks
> >
> 

Sent using hkml (https://github.com/sjp38/hackermail)
