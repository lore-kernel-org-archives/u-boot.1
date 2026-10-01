Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFF4CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 13:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C5DD40926;
	Thu,  1 Oct 2026 13:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bv1LmOZ5UCWL; Thu,  1 Oct 2026 13:08:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A81F40A5B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790860083;
	b=CIm7wOqZuusL1UuS7X/JHp1SMIZjfS+t70csjlhkYrPy8ihbXoMnUvWFHW1KKxsESnxs
	 uL79fVjhRhw0RwTpl0BONRHi4bCXcJatQbTkLuJQVUx34mZkYJffqGVk1Zd2OyRCNFfHv
	 nfYYImABydBmqSip3Bf0g61q/fMwRzvBWmqh6s3TmfOGuyFCaI2Gxzp/pUPLMFYhrZm3H
	 athuEb+nZUu3LHTVS6eduZBcyN2Pe64PwHgWagw2adsAC8EsIfExHGfNXg7zvABvD5Fe/
	 Krk0g4Kog6x3HSthQq0edq8Ut4WdDD7y1BlzoqBojeBRAcmZUCyjs8MjSaP98hOA7Wg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790860083;
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
	bh=WBTU+lJ3R7KsU9CbtGEukbdGAZD3YqpYfEwB76pPB00=;
	b=SzM8e1OYqGU0bKjPtgHU/JNZdwPpJ+cWC6oBMGv+exz5PNXPrWcj0kk6UUZDAz4hDk7w
	 +OFllGMGeuqYIIB8alTMp4PK4dGfizxfcPPO46Zt1Uspm63sA0B0LXAyK96ERCtpOtS6T
	 SGYHUO5vvU5K+ws9YP9AufCNCiV74/5yL/DRyKQ2a1jbcK2y+Fa/TzxPemUC/5Ci/s8Gr
	 tZGFCDig65HdaKerZwPz1YJUCDVENUxjDMCujOWECHW3ag23pIDUuO5SN13p2tjZVtZQ2
	 riBYJ8/SFyMrLfbWl1hrFcEp+GiG+FgHR9GegcRhzlAORx1v15QMddohrS8CFWcyddw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nprFiuKF;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790860083;
	bh=WBTU+lJ3R7KsU9CbtGEukbdGAZD3YqpYfEwB76pPB00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yx0hMcglV2jkRN7oDZCgCUCsHNslOP4CAJRpXo/b2mx43yJA8xGonZKHCX1DS7Zuc
	 0qXeVUipHo4S1BhUHt5VIG0yFOr/qrQvbTGw0Ip3MwOvK6Hlzu6nWFv9qOjZaGoez8
	 7jX5SFfxNciQtPkEDkx2dF6yf9u4+YagbKuMdvGWxGTDEQBeZUHiBTgBziu976wt1+
	 N+GFtI5Suqqlg/hxdNV9WVeUzpBfn7qjjPHAKSMaKO+C9e+EthXjVeVRSnagNaXzm4
	 Omov7nNf5zUKncgWjT2d1165fgvVDDbdcQKfhORv2/e5oTcyAO8GFyGlRN9Kz4leyH
	 VhPvH6nfyg+5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A81F40A5B;
	Thu,  1 Oct 2026 13:08:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A35A1282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9570D40A5B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:08:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ed1pkmS_2Wp for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 13:08:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AEA0740926
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790860081;
 b=YBlW31i65/m0MGhm3K6PMnyMLZL4GUkQyP+Q7gLaAmsLuTVHIbdgkPqNSprmAh5HrUxi
 La+v/CoutzneQvY0dSOHLdtlU8CQRHzSy/k9a54Iq/32ny8M+HfG6W/SLMTb0iEMYBatg
 gC98kUPUUg3sniWUhom34Y5MCPNv4UA3VXvlpCASouA/qM1tTv9TprD6PSIJ2PKrJbZyf
 sgAAL0TIc2c9YEJCmlOUNFLoIsAWvwMQV8VoNQlzP+uZgPPqYednp3e1Uz09I4aW6sS0Q
 OKrBDaXdcAcGy+XRMEMB880xic+BQAvEaK1NYixV09Gy4HUUnU0ywYDQMr3VVqojsZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790860081;
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
 bh=WBTU+lJ3R7KsU9CbtGEukbdGAZD3YqpYfEwB76pPB00=;
 b=DmOoiqujR64qwgQ6yJZhEEJj5FWWwuyqaD0AohRwdp7S6afTfpuepL5ohc0+S9y1+m+E
 WaiOrV5AN9RoCm5SGc1HAI59fp5oZGS431gHwYUo8RG1wVOx3hAbhgSK9YbkOBT87DOI4
 XuK8cCGwaUkw3PlBZEaENtuQwA72HTGsyBGhkQSmWgJ/LF5hZefqCNxvN1zu/m98vYBY8
 7F959a8ptRcJYpgoSqpD87P6juYDiu9Oq36TIg5ZbY7xfulvM+1IqzetRHne6i09imW+k
 WC4YLLuddTbILQhiZ4/JmemJXm33EwE5QxbUsLmpjG65bK5NlWeZoh8WvPdLXj5WkYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=nprFiuKF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=nprFiuKF
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEA0740926
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqrgyy2VWg+RQ/YT2FhhSi5QIJKu9gh52YAsdv4YkHyc+lcK+w1MDx6Nxw5zp9a+77Ign1DrqcQdFWR4JLZueZafliDOgqBf3rw5q8AzQvaYZYrqovvGdJrTP0fm7zwQjzlVGnT3M54FH5fHp+8591+PLM/gCZt3d8cDjPuVQ3nol08h87iq0rmPJXzEiVn9enOBC0lWoSOg5PnSjPaqw8q4nDeUXUFQ7uyd6q9eSy+tPoWI8NIqb/rVyl1oTg4rzMBbguwHK2NqhadmiSlW72Xxy/D2OF8Rm3eePJ/4DJU3vx68OoYQKniodgGl26w+zHLMiQMU2mP6q4VDbluwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBTU+lJ3R7KsU9CbtGEukbdGAZD3YqpYfEwB76pPB00=;
 b=nFTsOd3L2rt9B141y1sSpukuhb+kfS2S62fzhwmD3S2Lj7ZtiRne81lHuEkQzKc81fnqRVoxFPT05lB1d7RpvV3UhwaELzjWzLHJC8tgAVE1Yp/4Rlqf0MTXfmVsfMphxQM326Hs0S9x9gDI40fPGYBND5xF5jkPsXCV4Hb4V3lRX2LBNvtrquxDl3miGyPiWJzDe+sMLV+SSNdlmnrkKAgGzT76oRtxgCbRls+1DqjrylVxCkN/wXna2goCodmsOy+ejglDo2K/lL87lfmVhT2D3nQKeldn6qwht4knc9WrqThJQuzgdsKs+NCGv6fzrKqLljcEpETKcOYAZWtNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBTU+lJ3R7KsU9CbtGEukbdGAZD3YqpYfEwB76pPB00=;
 b=nprFiuKFXLsRpgII0GL7/jCoeJ6q2z7ue9XEVjGkBgsFNS/yukGNALD+yh2aIH6/YrucnBajrjdcSvT1k1YtinJaeTbn2j8igQGkBsNJIw3OlBIKKZsL2MxVwUlPz1GRpm5SFRuWTAVivW7O1ggLu1ZaqksRg19DcJMFQcaYIyIFeM5+YL0WNL31i7JZ1NgMX5E6AdMyzwV7XzXnYBHBRm+4IQxbb1ahYR2urr4ELBht7X+I8mz/uUDKrXEpbQ7ymST9PaLWMIJxYtEdqQkwBB9Oavyzu3vR1kkMV5FAU2FkqYxRD54T+8nycaVXK5I7jel02eERCC05B3DWpDh5fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 13:07:53 +0000
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6]) by AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 13:07:53 +0000
Date: Thu, 1 Oct 2026 16:07:49 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v5 04/13] board: lx2160a: serdes: move the SD1 halt and
 reset into helpers
Message-ID: <20261001130749.xcelzhjxwox5kshf@skbuf>
References: <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-5-vjardin@free.fr>
 <20260929175947.1379710-5-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929175947.1379710-5-vjardin@free.fr>
 <20260929175947.1379710-5-vjardin@free.fr>
X-ClientProxiedBy: WA2PEPF000008C0.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::69a) To AM7PR04MB6902.eurprd04.prod.outlook.com
 (2603:10a6:20b:107::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB6902:EE_|DBAPR04MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cff036e-6a7f-4fda-9a4c-08df1fbd008d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|10070799003|376014|1800799024|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: FgUONujXJTcb9f3JOxqgEHNiudVn/gJvYTcaUPL9vC0PzJfJULNvRQnnic4HNoArFFwPHbTceIEcTp2yYqr2bMIQfSkaM2PgtYKgGrCcS2yFqVGr3cNb9HV32flr6tNC8ZrmXYTAjjNsTdPQGO1eOYAj17cAVgxXhRCwsSI47YQWgXD7PogZgrSTTk3yR31p03fCNdlr99ixZgiQ4toJvIC+4EPphPeTddSoTtCGQDVfSz/iSdx8eqzpHpEBNLut9o7/ANOTBajCYPWYFlCEiOzcg3BwThc/pZSC9cF4apBL7ry7yiTWF1MYE+kMv2RyVMnZw8xH3Yi7OTvjw3kHmeUMa8/i5K/mcBLBvd95vPOBb9K0pPIL3/nCIBVXzgYnL9x7hehap2+smSIqxFwoePIJuKaxxbsXod9ZoylN41zhIMAM4JDyAiZduXh0mp5QMa0NzhN7tpQgphYZtOndrwaip+DI91cMmDdZQrF3SmEwn0rG6nW/UTyu32/IcN0Qe8EUF23TVPJQSQEK5+1q+3bjuT4KhNE+sBNQAgC723VOAALlaLsS9iZ5Qzbufcxdtf54h8xU7xPgwSV5sjIvc8YwQlCXSUpj0rxDZRZUqdGd1YtoprOfFqXV5Yv0fH1jQZYLjLh3oh7BLaViy93yVbNOcYTAU5ZGp3LfFXeUXG4uCIMMyigwSjVaGHbwH/CGXjGfPDeTtdUoeXrd6eddDNu55w1Hk7pGmdye76ezvNvLY3aOrSElwPTMx51taKdT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6902.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(10070799003)(376014)(1800799024)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdiqhPlqDCBIyKh+BwhNO+2/Y1yEdl9p2nHXfDa+2X6JpCIrg+fpMadUSQMa?=
 =?us-ascii?Q?7thQXY9jNxsW/9xWqEb1mYArhoCfIKu1R52KTHOj+WKGI8zez6Kw0weEX191?=
 =?us-ascii?Q?XKcaZJpttqzS2j5Gz24D2LnlgfkvNsfupqrPIxD0sx1DHCASm1PnTxBfkTIB?=
 =?us-ascii?Q?YGyQPvYwsox1tWSV7JALPcU504L0MkPWCL4LQxKhJvQax3Clm0x0VeVJBUaU?=
 =?us-ascii?Q?Tdl+ZQcHEPMHmb40yHYephbfnJd5vjrjlw9ILkRYdDs+VMr0zEpymc0qrQnS?=
 =?us-ascii?Q?UszO5upFIc4Cyrt9LKh2TSDFCrgw6eRxmsTaptQZqh/qwZjcO1iHMscVl07h?=
 =?us-ascii?Q?hNxxqk2tXVwePq+hZySpaDt3vAkg0IidtnmDiiN8FUBUUFh8EViHSxiP0xto?=
 =?us-ascii?Q?GRZBT5MkuJU3QrPJplD8BFe8+72P65n/a3QH/MZ+GaP4LFuB5QBp3+wQ9zVT?=
 =?us-ascii?Q?4+49qzVaUcCgauPREj7ez2S2a6Xv3kl1WB2ZkbxWSehi0s42vx91DsA/pEMu?=
 =?us-ascii?Q?+cEMMzMQ8v6DRvj7FXaCu0mc6vYWOXxXU8EVgsRL3wH2IWxKrw6V9pMPvKzZ?=
 =?us-ascii?Q?TbH8T1hJOak7yvd60yW8nfKVpECHvfD8xRhbB5zC/+FI3EQVv+hkw2INp+mR?=
 =?us-ascii?Q?3+/5jTS3oMvEZhUBjA9DRQ6zz/MneSLM0q3JbLO0p3Oxx42T5XZJnRCLF+z9?=
 =?us-ascii?Q?Ib7wAtpYXfwB6++TwWYtYsuBHIZo8JdyZlUxdwKcgl6Gq9EkIDZhUfxX4nLL?=
 =?us-ascii?Q?/6TGPjCND6pxpfmnpOzF8Yfn1enUZXl2EyGHzPs+rmtGd2csmp8tI2Uxj3db?=
 =?us-ascii?Q?GTU4BQNI3JWyg53aIa5fkvkV3BmO2vt6x8fOZaLUmXdclFrSrQYkvDjRl2/+?=
 =?us-ascii?Q?dK0ihvAiT935cKkDajvzo/itepdvB3ylH/hXSsksOjp6zIVn13Cqp11QrclY?=
 =?us-ascii?Q?l/bOvODXWQna+2O6ss5ZEYUKg6WiT5qJeDe+YWKVCap/5h2LwTfeHvUWWe+n?=
 =?us-ascii?Q?4KxNb1cccbYKuEtVEaTCVrCxYw21t176G2Q/IhMwn+SRMGj01lWYqtgkhyH2?=
 =?us-ascii?Q?4B2sp4OElPEVn/eYUwlfoVsfapu8Fr+JejsYZ7vYyGFSu4/hFB8vc4fxQka0?=
 =?us-ascii?Q?L3D6SCB0GeMmhZ8Kxt2UWw7ewrLOBMtCof5/LjS6FBg3G92oVHZgms/+RPOS?=
 =?us-ascii?Q?PjQVfhRDfGlTFrNLeXJ32pmFDlPAKYvUgbtH8GKy4mJReRxUyiO9do8QtJrP?=
 =?us-ascii?Q?+kdKybbZucWcQLD6aS8RCLraQZvp6hYT+cX+1jlMHimZwKfcvhiq35ika/Uq?=
 =?us-ascii?Q?Zw5mb+CyGLgM50i4KmBy+08KhIrnApakYHMsTwBOoLCdlZ9nLzb9kVnBjL7i?=
 =?us-ascii?Q?mh3TvIqFoZr4Z6wcVOAcSKjEfLG3glSpTRExevDGRpIdZNEatzcVVP5RmhCs?=
 =?us-ascii?Q?TzsGsuf5/St3FWxUnTT1t1y0aJBM30xp965VLMtO1jYNY8VorZ1PZH0Q8olW?=
 =?us-ascii?Q?r2DW2GCCZbUtQ8Pann7684/knX0HnCUhUK+3ItFlgylNXPy1IUlHnb9z49Yr?=
 =?us-ascii?Q?LOZqWtMCxEb0N0yn3b1Gzw31jQenRKQCQa/86KxlhAFKU5t3Jq57Zy24GLKr?=
 =?us-ascii?Q?XDxr0b6uMF2496MvTPU9hwlb3dWlrz/hSaAAEu9RRIUWxj/0+GXdzUPwILy/?=
 =?us-ascii?Q?wrWPIdnGgzuVbZw/xlrwCwGPalncWwhQymiw4wdVDvkJ30xh2Hav1c3mApwS?=
 =?us-ascii?Q?Vrj7WUYEvpmhwvD8SKJ8Ts7nANt7IbYLqPnLpKWsjSaajVccmM3w+yO6ucKR?=
X-MS-Exchange-AntiSpam-MessageData-1: 1JXMNl4fX2Y5UsrEBEPJrz3SaEj8MwP1zpc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cff036e-6a7f-4fda-9a4c-08df1fbd008d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:07:52.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8I6J00xsI16k8jAKXM7BXpCfmV/7nwanasHgb9NU5gjha02mC7wmqCTIcZDTFIoiFZfD2ijpl8XhVwz+cIcTWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237
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

On Tue, Sep 29, 2026 at 07:59:36PM +0200, Vincent Jardin wrote:
> The split halts the 100GE port on LNE-LNH, reconfigures its lanes,
> then resets. The following patches do the same halt and reset on
> other lanes, for the other SD1 modes.
> 
> Move them into helpers.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
