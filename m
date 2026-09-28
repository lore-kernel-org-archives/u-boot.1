Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB6ACA5FA7
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49EDF40675;
	Mon, 28 Sep 2026 15:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vljm6Lby7bqT; Mon, 28 Sep 2026 15:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 78AE440611
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790608051;
	b=dlzwsmzCpsQuu26JPiwuO6iZgFC+vbLal4z5fDkc+XoTH2WVZgiIQfSwNX+SlgclpEuK
	 s1dSP4IFChMEerXD+vboIFFGWR2hprQ4QimIrOKkpcApSXbzTlreAO1u8MgWl8Rl9Rx90
	 ++THuJTGnwUAuWQ1NE5aPMGlIsYiWfVWawTiAzZBa0Ur7bjmcmL5jT9F4EJ+iBEc/KYAX
	 CWQCF78zucCq3uldRayLnNW8Dpdnbh7ziKft1+OP16rTPxiRzFekPMkGuNhuwRTP59WPD
	 IWWOmwXfdU/8q/u0z8YJtVpuU8ZkqgOwqUvEXaVO1BF5JnBZDOFRiyVJhOmZ76azWbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608051;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CP9iud/aThPh1BUsHBnauFkXi/F6/PIm29Ago/IVGmI=;
	b=f+pLRTZIfv4RgtOHfPxu0tQHubBeEpA4FeE5XV++ZIdTod8Q+UKn6vP7a7l3NaznJlXS
	 EThnuE2hMBD+0nBs7bSrd7bgTshnz1NW+v927zZpLfwHwdMNeU/dGLH25hyGIbeP61UJX
	 KD4UwA4fbeHEB/ffJIENqNLg+hjA0cgohehBMCfos3Qcq+HGRMJgM1XZgZHwOp8rlr53q
	 zrVKL3oIg1e9+LNp548JUlOkRFh50YDTB5TEXB8gGONNTo2FsjbVaZpqUo+VMCOI7u1N/
	 Yhu6VcD0chS+DgAmXVLKqXmJo/3qCC3mqCr7FACNJvmCwRqVZPV9rKjF6nx22p1Sv3g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608051;
	bh=CP9iud/aThPh1BUsHBnauFkXi/F6/PIm29Ago/IVGmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zLZ4f7xKlCdUUYHbmxCJdyeeAGrehWihO89ZS6u2toOAb+eRDiC3JKbNxPoWcdjwu
	 wHCaFA2t45CMaENRzm2QkaBGJRNNQJWptU0MuyV84UjhDjf9nDd9dIKIM+UKeMwfzH
	 VfmWMRBCIUNf3fGzMB2uMF/C8fI4dg8uZRt9zGw1C3oEdjR3YtshOYf1DuoIDREiXj
	 qqtwm69O35MmR55Kll+MJn46JLoTGb4mp0Tosvyi7DZdL4wnKfkeSCITPapv06qXYj
	 nVd4KVKOI/gQRNbJP8fp5uQJ2/cNMVYYgDGNKMCi8OP7/+FRfmi2EzwhQEcy4zPYWd
	 pkRTurYNyIbjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78AE440611;
	Mon, 28 Sep 2026 15:07:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22568D1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13CDF606C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2vdOXASrdolL for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 29B74606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608047;
 b=JD9qSNXYVypcyOsBgMKlSDLzdXigOh+nWKnJOaHYjrWupnZAxs/hgiIUeteblFkM1zOO
 95KI2j2dGV2vsihVVFh0tAyXxneXKjSvPJkD2ZFsDndiWG+xMcrzq/elCyrYPwBp+pj4i
 dXEjWfYAupomBINDhyKC+hDgGApCdF6OHR0i0w1Mc9MsubuRfqw0ipOfhyIiS4tMmU0pX
 gMwtJZ4RMoi5XC5O1Ng0CAEVNyBIMYNzq/o9K/xaQ87ckPPLoEh/2g+q4wSwsWRaqH7R+
 3rf85+qR9TxuugMxlqYNiU9DhMB43CcAYn9TIrMy5zYsnbWApQofxmOXCF3lyGMPfkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608047;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=CP9iud/aThPh1BUsHBnauFkXi/F6/PIm29Ago/IVGmI=;
 b=Ynpy+1FILswb1AkhXlOvjsER7UFVUXVmg4AQj2V2Yik0AKlcs/S1zKjilAL2Q5UWWnPU
 YTTpLvikC5vmf+Bgper+vZQ4LRJ7i/YLoKJwoK/mK220k0g89PDbIIYJGWjHS/LPMaLsN
 oVUI8mYMTKmTntgUY1qPockpQSlbyIQWjiJ5QhVTYDPuzoD5av2IHcSv2lwUIIKN4d8Rb
 38tvYDmKkyhWuo40cLdRPWGkOHIs8hgPjnt4D51znViSVCEOtTrTR8BOOxnWCtXQN5cL6
 4iS7dKbcpavI/V47OwUeWE/yOvkmp7If10xv7IPhOjAw8f4QGDLePl+iRqLNlD00ttg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=FZNacO30; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=FZNacO30
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29B74606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8OfSqUH50GSmTpfxLJWqZUfCDK6TPc679QEaogrU+1wIetZU9ooMAL/tkXqyEJ5S5JV64gcXm3p4lEgRi3HG3SDFtGHpKk6qTXFgRYrntsaJAGCNwj9id40TaDYnWnyaA0KKwRwcqir386gcxfEeQH3R9Tv0tUGJpH3H224/+Y4r5U0JwjG7WNikL5MXoZKi5jOCLyVvPozmDnru6InRpnhFi9z9JwoY+3DGe/g20lMqPbmD438uAmZbhcrIYHK0daR/g78qqTe1mjPC9uycVdggZxFSUPb4tLU7QVNoGZH5uZSGg4F96STdN2jiTVHws8GIjwPcSHGz6AloEAroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP9iud/aThPh1BUsHBnauFkXi/F6/PIm29Ago/IVGmI=;
 b=v2z8EeViZ9PbgStuyAuaJc10A/n87h5rRUJtQe1a8vYLbmqjqWwePZpy7i8ZZ6wf96JbhpjA5IdTN1LBxTywJ3AFrettQN8e3S3RWH+VgaAsXXySGWymBs91CU4ZDw3P9+9ShNJmjjwViyxR0pemGFW8w6n8S2Li0tGjnPCunkTijpI5OoDoWYGCLigodsZDgr77vby3kVlwhyjXF26mhXufw8PcOwnMMwUWq/xC5ijSJJ9onYKvD3JUDz9Z+kH/s3h44gwMA8u96WXwZjZT7o3GuYewBoFXSVK6OOAPT51Zf4VjDlKpJ+nQe5vJ+Sdht+rZK9rMk0tBdPhHS7ZidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP9iud/aThPh1BUsHBnauFkXi/F6/PIm29Ago/IVGmI=;
 b=FZNacO30QScqk3C/Kb+NyGl5Ik1x6c5skRnKdgj+o6Z9rMs2A5V48Ppr0uVV/4QI914x7QjV5IGeSjsgQHHZJsSlGZz1wFp5GhZWK57nD1UoJ72D585ctKot4DZwHCQ5YqBlrONJ7yd/J44/5r2IR7EZPo9zWJ+8druXbABBFS/OnGCSIBhLtlYzNvR7ZMtG4lhRAmkiWfKUDOHXx9DkDFjIYJUUEVMMdbbPKwz1wnEaE5dl3oCOdg8kPcz1tv/3l1kWqJmQDO5xhcoU3Wgir+alDBLMnrttcOYQlJp0ziy7ihpRGAQ107jVG+oD97lFU/yYfKDg2xTdwuzh9l8UAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM7PR04MB6984.eurprd04.prod.outlook.com (2603:10a6:20b:de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 15:07:20 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:07:20 +0000
Date: Mon, 28 Sep 2026 18:07:16 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 10/10] board: nbxv3: apply sd1 hwconfig before MC starts
Message-ID: <20260928150716.2liwgcwqjidzqchl@skbuf>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-11-vjardin@free.fr>
 <20260928101330.881662-11-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928101330.881662-11-vjardin@free.fr>
 <20260928101330.881662-11-vjardin@free.fr>
X-ClientProxiedBy: WA2PEPF000008C1.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::69b) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM7PR04MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: b03ba56c-64c7-47b0-c8dd-08df1d72315e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|1800799024|19092799006|10067099003|11063799006|18002099003|22082099003|4143699003|56012099006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: GYvKrIwcIQ7sYGFJnv0k2ueU+CnYCSdyZC5p/kBXZh8lTk3+Olwja1KnRce8FV2M9rH03PIdPUuW7vkB9Vfv0A6k9vyUlP1qB7BTWAobaHMOI/sWvxKzLHlwWO6XKDzWukNh/fnTt/nltAi0Ya55//1acB5sc4ygNK36/mZJx84QsNXYJDEowbMejphZvv2ueI5MhMTepTcKfg1c4OEd6UphWwwkuwDe941fJCDvGxeiLPPdp5bMXIzrpWvd4cMY1XWanxgmloymIYOGPcYd9n7GUg7xU1COP01N6+uyl0PCLzLG7EeuPcC8qbLYHbi/0z+wlR0GfcimOFA047C16OYEPYIVlBzGzkEde1cVdjdck6lbcV+jotFiDrKEdoBn4pc8LS91bTJ3nk/F4eT3ddN1ZlsEPkwRR+zqaJtnceOMHlnzN5sEWPdIo3YvNkP7gIvIVXvgGD51ybFRCRuf1VB3Em3qNiSTTKvSWPRS++APSc+XgZKl5bSlewTQ9ps4rGiapoBnmTpytj12Q+laXgo//vTl9rHnAZzX5HyzqRpASbms2oXtt4LMl618AH1ywDapZFlyDmWvMCL4o7vyOxoQefgRrMTj/0jItalsEAwWfNK6WMSwsEN9QIlgWRId3uul0EsYzRhB9UFG2USOJWY445hGnwQiG32lbbL+DaKwW4wa9eOFJ3kTL0NXe5O2IMHIejQwnMa7Xrt4Y+8FhXax8S0vhelQmHiTNKZ3VbQl6DTnhpjQV/zVnr/MVqzT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(1800799024)(19092799006)(10067099003)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aOFOU07HAMbp6mUoyZTvjfvUF3+lhcDbTu/HVP/YEjXs8WVQhs+RojUZE+yX?=
 =?us-ascii?Q?jPWmPDgR7wVYK1VaN9QGaFIPiVaBtWy8RTbsmVSkv50xWFdZ442iBC5vhxjj?=
 =?us-ascii?Q?7hHHJKHDIth00oe173rx4h1HH6a3IRMevVbVeCveaQQ0/UC1hb55EDmN5W3E?=
 =?us-ascii?Q?TRD0l7n2GdCuPHqxxv7lLojn97984mr8rsAKpnY3WSxhkAdChf4TfWB2w/Aj?=
 =?us-ascii?Q?7Cu9VqQgDuUniKQXfAlVkEm8VqyWD4l8ovnn/NOGu/lwKHaiz3izJU/qtNy5?=
 =?us-ascii?Q?9ewKe3AAhE6ZheM2rX9z9ibc2TIPy4lZ/XBdALSOo2LfsbRzSVaa+z+D1X7n?=
 =?us-ascii?Q?f/sLOqnZPHDYnXBjM00Tb+lgqForn8sN5xrG+19ubQfGmY8TMDDKXnlHA/9+?=
 =?us-ascii?Q?QZTI0N2f1G4q+w0ZoLFMpg434SbnnG2z7QYYZLkL7xckfXnlEsDZomM2BlRo?=
 =?us-ascii?Q?/Req0Yw2h0yaukTcuD5rxMn209LkbMZ1FRTE/EE7TyfFX+GD3/05VBAKjSLu?=
 =?us-ascii?Q?RvHuulrO48YVinfhzbe7kVrpEnqsLLWn+QPyPAMgHDOW4D6mfPHulqZZn8bf?=
 =?us-ascii?Q?MY3M92SWjwXzkH5z0ti6Oswf2nxQ92m4zehVgk1JsH4z/ICJm+uAS3710y1J?=
 =?us-ascii?Q?lCiuMU+kxmGpaI9p1MnawZz8P6sKxLkdgj0Xyca7By4APuiR3iUrBKxe33lX?=
 =?us-ascii?Q?zN2ezbXMdBbE0lQmd8HMzU0H/oAUZBtvw8BDE/du1OjMURgpLxXrYE8cvRwd?=
 =?us-ascii?Q?ibAfWU2OMihXzNkCLwZ5SF+9RtMd3pPJCRFnM9ElbuSGPWlI5pTXr01Gm8EG?=
 =?us-ascii?Q?8XNcERb05yAKwKwHeyjzWVS77VjXSfLr+HHyQnOdmIZipO/3sREJZhUkpZrI?=
 =?us-ascii?Q?J2eSiYeV6J8aCLZDB7Z7JXmAkhjASmOrpItDW/bXBwP+cVOveQIMgg47sJ38?=
 =?us-ascii?Q?mTBijqKhEKITIyx/R1xekwuP+gSFe8tJKdDrEIgsf3zu7TjEGv0Mo5iO+bel?=
 =?us-ascii?Q?2rf5jfYBCGGhLYQfGeqsUYSPgOxrSVBsMQgqxaLFqfQ3P3dkBN/Sa9tpf3P9?=
 =?us-ascii?Q?P4ASMGzVU/HC4h6CXX4jna7a85Jp1aR/Q7FJgOVRDY1IYV0gWvHJr/MSO/7X?=
 =?us-ascii?Q?7Kbs62PFkEuWOZzaX8NUOJ8ELQu21e0Vtpc6xpev6tW+eUULhLov+yyumkhA?=
 =?us-ascii?Q?mUqPzr0Y7iumHURqflMf+6bjbHewgzp7qHvV5eYO4z2vj+SoHewpxsZ8uGAw?=
 =?us-ascii?Q?TT89Ktk/Ey78Iwg9jLxGfuxfdaR/SOBfoqt1x7homHhiqie7Xt/bE5bQcq+N?=
 =?us-ascii?Q?+WxF8Ke7hNN7rVHWmKdR5bIKjEojILzmR4L4zaUJzPdrvO0jMkWzi/jqZPOT?=
 =?us-ascii?Q?pS13MczHwzBSKEUv2Zf/qg0OmQLjxHfGVZqQ0WE2g9ApP73/TshTAY7H5iwa?=
 =?us-ascii?Q?oZV0FTrn7AM5XaV57vn43d0KTUpnZ2Gt02CY7EEdDlv0f2/3cdvfE2fIbSqo?=
 =?us-ascii?Q?Tq2A/tRcTim6LiCATN0shP7vqIiPGzLC268q3fabB1g3yVreS5Wvm9aXr6IX?=
 =?us-ascii?Q?ic8WNbrhI8iCWgSbgVxZvVk0ayeVBrfiLLmA8A/iELYyr2wHrxIBl7cbcPgR?=
 =?us-ascii?Q?0CAuQ9o0C/DTL1vXQvRNq+qM2qouWvdobJdnaI6Uqq4dXfOf+3E7UHRZGqPP?=
 =?us-ascii?Q?CVT+K70uBt+5apNyHyGcMGCDPIVdBAwGuECKfFU3OYRBcpj9Pcap6Kzt+ilG?=
 =?us-ascii?Q?5HrQ49zBq/llmbe7gBwzh3hIRtnSOpCLa+xIOBfA1nymRBxuzrykOa0MlFPb?=
X-MS-Exchange-AntiSpam-MessageData-1: k1lrUblBxLJotcgJeRNT+18uX/UoVFpe+lQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03ba56c-64c7-47b0-c8dd-08df1d72315e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:07:20.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkmLUJkozJcI66hu9WRKxKElDqzHXJF1hsATcC0niatOt+17gm+gVDG19PG6vDwzpiJvtbL4yRSJQlNBCRXpOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6984
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

On Mon, Sep 28, 2026 at 12:13:29PM +0200, Vincent Jardin wrote:
> Apply this feature to the nbxv3 board too.
> 
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---
> 
> Changes in v4:
> - New patch
> 
>  board/nxp/lx2160a/nbxv3/eth_nbxv3.c | 3 +++
>  doc/README.fsl-hwconfig             | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
> index a8d249c5cac..69873909733 100644
> --- a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
> +++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
> @@ -15,6 +15,7 @@
>  #include <fsl-mc/fsl_mc.h>
>  
>  #include "carrier.h"
> +#include "../serdes_split.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -34,6 +35,8 @@ void reset_phy(void)
>  	 */
>  	nbxv3_carrier_env_init();
>  
> +	lx2160a_serdes_apply_hwconfig();
> +
>  	if (IS_ENABLED(CONFIG_FSL_MC_ENET))
>  		mc_env_boot();
>  }
> diff --git a/doc/README.fsl-hwconfig b/doc/README.fsl-hwconfig
> index 3f9d2ddad75..dab24009f0f 100644
> --- a/doc/README.fsl-hwconfig
> +++ b/doc/README.fsl-hwconfig
> @@ -47,7 +47,8 @@ usb
>  
>  serdes1
>  	Specific to the LX2160A boards whose reset_phy() calls
> -	lx2160a_serdes_apply_hwconfig() before mc_env_boot(): lx2160aqds.
> +	lx2160a_serdes_apply_hwconfig() before mc_env_boot(): lx2160aqds,
> +	nbxv3.

Nitpick: cross-referencing boards like this is exactly the kind of thing
that bit rots very easily once more boards add support.

>  
>  	SRDS_PRTCL_S1 is latched at reset, but the eight SD1 (SerDes) lanes
>  	can still be configured before the DPAA2 management complex (MC) starts.
> -- 
> 2.43.0
>

Nonetheless:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
