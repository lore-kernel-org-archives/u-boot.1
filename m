Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88675CA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 13:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CA3740D0F;
	Thu,  1 Oct 2026 13:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dVvutE3uXe_T; Thu,  1 Oct 2026 13:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 88A4640AAD
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790860221;
	b=rI8dla10hH0togAHTU6UdjQFWs2Zsh313bDoutzE9Dp1ZSYLNKdf1p4Ch7JtmL5x30VR
	 1rf34uwtSc1gIZnU6V7u4b98HICInfBPI868Szv6IeLWaX3l/nEEMYhAopiwzsEnpCWSX
	 d9u0X/qlR3MOZ9h67k1BwXL1ex8jqutGRoMF84EmnHywBNjK5T2R0w8ZrZQ8UNePLX4p6
	 d9tJPIZFkEzOqMW5j2EDup3MXy64Q1mDXFagK4CUIRbZRb2tA5afsOu/BRX0/5d8CCo/v
	 +TSGyaR22HntHsJJYQQ+gN7AjGry9krAj4zQlWwHtvdTHP+FycRvTr04AlGjc8gknEA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790860221;
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
	bh=jbWzWCgRxpYMM76kpHFEFrkAldcyyJGPMwYskpxJA6c=;
	b=AiZs1OzkkyTp4gq5v20xxXSw4sF4ozjRNbmOb6n5Z+7iKahx+kFfMCtyWuLcuskfMTUc
	 fr1L87maFFaMoS8JZdUxx1uP1qBCgBd0QU8RkfdCk/d8vo7Tbb3knWeN6AABy7dzgr2Oq
	 epaksG7bOUkXXRosoaGB8whu62ZCvuMHaaLOX8VGl7jbQ9ZjIg7TBlG+PZQV6jXeF3jbU
	 g1kNVe7OOujqO9k8D1lpdDRob97GnN2C0q/hKHDpgxFII2dvWyEJLJ2MI++gBagRnhmrs
	 mrJkAPgceFt4mxrt8vXnIHlxgb/3R2e90Zo44ZPWl1r2qlGsjEGbiseF+5QHN6p2cOQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790860221;
	bh=jbWzWCgRxpYMM76kpHFEFrkAldcyyJGPMwYskpxJA6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a7Fz6njbApjetY0Au7SOhwk9gjLAsT6DIWs0AUKqv27+3u2MHbLUMor2q2LEHhTf+
	 eLnQ1IK3veYxHkizNK/hp3uaJmm79AOmH9UqkU1iFtq22Uwqus2pClJ/rPN0C54HgJ
	 27ZA4Zv8yziSLzgOeaxuMB7VOPFDuh55iV86EBGzGvtBY973+E3Yn72mNdwgXvtqw9
	 BvXqDi3QrqRp24CYAnPLAUrcKZLruZdT2bnXOLsVfTPXiSDEurzhZlQlnhT3FVLff8
	 Stup8ZxTBbsP/255onfuRla4QvACbMZMl0KbBjljS/i3RDuXnBJLDk/alq6Tn0/aFj
	 kItuqfZXE4k+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88A4640AAD;
	Thu,  1 Oct 2026 13:10:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B77C332F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D8868105B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VTJfJ1XuSucx for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 13:10:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AF75D81045
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790860219;
 b=pjtpZAibH+2lb6yDPG6dsza8u7Y72nZV9dWAnk0N7osq9W/0bJDvujZigWeidy4EL6xl
 wYFej6clrn/lGiTiANMu3ZmtgGdFjchFE9vlmHSYDFVysg382G9T7/UjgukbI1Jb1sM0k
 Lm7MM/7+4YEDJeTF3JIrrXiBSeuImCKEvB0lme53ABlVVDTjwldxFdwiLmA2ElZFe/gld
 rxmtGB1PY326GQFmfLFki2SivAyToj9uhL7S/gx6FOpWJU8gyUR7lc+SC0Zfn+6muglRN
 S0Y6YsZjPPf+iP1jXbrWYl+3RGc/X7ADF34aH19PKRY3ntzhwZKfVEsZb8n9s0NwtPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790860219;
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
 bh=jbWzWCgRxpYMM76kpHFEFrkAldcyyJGPMwYskpxJA6c=;
 b=fQ/g3DAMrp5pjNA4gbOcJhTKyya45xghAH1wIc2VMo5R2EquXF5oqNVGU36EgQotTiba
 Sg59kyGJpPa7M+oScDb/d95ssVY5GMyre8d7i9e9sXsiTdpWz/b4HygNWhRazQP2Nxvt/
 ddxdWJT/gVIGrdrEe2ptM7yUuJiEtrZhstpDnDrHCjvHneYqath32+uH2zqgnYEBq9J6F
 ebqHwpZRRE1ek14fvgwY6/kwl4IHrZCT5wEWYgQG2sRJT24XCoNN2l3d2QA+71LZIjyec
 /slz+o8xP+awa/qBqZtb2KbkGBE8pcJlRjBGUiDs75lkFYxyy70uNxQEpU8GXBWxPlw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=GlKvMeQf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=GlKvMeQf
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF75D81045
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWgMHpRQww1T6piTOUaK78eaJ/HM8+ydNNjzOAmRrwBpYbRNvf8WAJ4+Onam/ke3SQ8LefFk4WcjxtwBtrgbXGVmzLO2qNAo0mGyyL5PK4kuG5R+ThLV3LGAYiqVfgfOtnpuwZMd3BtYDIcFpsUWqAHsZ5FBtNMfOY2kN3iuzFSU4CNu06VgcGpb6DpGWokazMGxGFpVxlJXgbXjLr1ZbRvoATdbWBaYSxsIqSfr1shh2L41iOlVnE/IV08KNz4il6BTfSWZfWmYCcYPlJ4ZB/nnAnwv4qzriimlJ4uUs9rqizT7nUtsjGLMBKyNndybXxZfP5X4s0CdwA4NEquopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbWzWCgRxpYMM76kpHFEFrkAldcyyJGPMwYskpxJA6c=;
 b=ZYhx22ox2tUsAqkPeeFiw/f8A+BWZHJsgRvd8B4wPWcTx1AVPQE6Hvcd8Z6TGWU9gR6w8/aU2N7Gci48UmzpqRVJmDbz3hz721b/VNVbkfDpbMPU0kYyQqQkRI/LkwbwI+2H3OfhuR1mv5iXGk9czc6M7YTTzJp25vjMpEnFWukIVY6lrnPwxqAzLq7b0+CdGRQmbXcrweX2ho77t+5OMhDXyXS9P6d9hxO+fC9L/ZxkjKETY9yOY/kUs2bbSoZW+6lf+ch87R/uAFxPxKIKgEMIl/DMPErS/46hF45Dg66XkFcpt6gmDVV0onnZC/iEyxKau98nkbpypKIDu2WTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbWzWCgRxpYMM76kpHFEFrkAldcyyJGPMwYskpxJA6c=;
 b=GlKvMeQffEuBC0Ul1oeyj54baDQK3ujGflIyYa37odxYXnhhBQEupnXgZ7Wf2roN8e7ee88s7MOxy+T5sDspW6dK/ksRj+XQkGdHpYkvNmixpo8Aym17SUs5sNWiL9BwYeKZv74rmvuPPdO6E7rFkc4ddqqymisY/JGIHFlEqbnniBKHHA8lKajrt+HJep8GUYlS+G1rClChKm7OMUEvBguBsnRUSx3q78nloQ/4dnV34QPKp7KEK5D/ikdBfUeg+if4C7hg5NdlvzMU4LG4YeJN2Wu6KCK2w3SHmPPKvDGoQBCABxQ9i8A5CHOk/W7/skAnvngs3Cj1pAfBF8oagw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20)
 by VI0PR04MB10614.eurprd04.prod.outlook.com (2603:10a6:800:260::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 13:10:13 +0000
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6]) by AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 13:10:12 +0000
Date: Thu, 1 Oct 2026 16:10:09 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v5 05/13] board: lx2160a: serdes: set SD1 with a table
Message-ID: <20261001131009.mxyfz4mu3na4q3xg@skbuf>
References: <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-6-vjardin@free.fr>
 <20260929175947.1379710-6-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929175947.1379710-6-vjardin@free.fr>
 <20260929175947.1379710-6-vjardin@free.fr>
X-ClientProxiedBy: BE0P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::21) To AM7PR04MB6902.eurprd04.prod.outlook.com
 (2603:10a6:20b:107::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB6902:EE_|VI0PR04MB10614:EE_
X-MS-Office365-Filtering-Correlation-Id: d7cc03a3-d5fc-4c56-cd46-08df1fbd53ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|376014|10070799003|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: 0EqCoPZckW3gByf55BWHmKUq8wQH99V5a0H42LbCZZWWOiJ8M/r+w/OYb3+46LNf/aT3zPWKue0b2ZihpRiKOSfwA4Yfth6J20plSU9ITg1IV/FJzvmC+8C3tGh9ToTkhuGlBtD12cMHP+hEq/e2q9Habk4pvz5j/RIq7GJrYOpoqdbE9FzsRgJ3mqOWOIL7MpFNja/j/XmLj4dK1mOzkzEWvS1jzwidsSwcr1vEACcE0B+U9XQN0S2Qopdwu65bxFiMTYlnvWQDtWtsN04xKoqdRsKK31XEuluoOGHnC1yDDF1zVANruGO6egx3FSGKgnHoFjpC+XgTbgNevcOCdqesssn2rbDm7AgDvShbQY1ImvkWE8sta6cGvyKcuXmEhUdm4TE6+T5dSjspnk8upmNQHQp04bxzF/xgOA6x9Zt+UkUklKj5Yvgk4QQI3Uf96yCYN97507yKgARRR7eTJPbRUJd6PNFbEEU3MunBV/Punx0mesqJEMC0dddWVj7F+MImOnTyiBnm/SNMtYE8uaynN7ZBHd9CvOaYR+7uRKm1/Jqb4mY9zIxR/AebDiIMmlJtoPQJO+u4nH5WDj9KsnlN6JwUizXQPFiWufihM0Qig7r0fIieZKaTNnYhFWff/RVsoDEb2BIpmpHHGZVqCGT3hojXMB1Sy6ufvoNV7pke9gWFOyO/lWjqOtJbRH591266s2pDcFzkjqq20Cxa5Gx7xBcLBTaGsyd0zfN89S1S2hd8w0yGaaJrLgzJqrHA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6902.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wire/d63pLAUJoR4UmcAnWsN36cn8LRlmh/mAevJ4kgxwP7vBdDEBJnbLb1L?=
 =?us-ascii?Q?diZ9K/p0R/kqcpDqZqZAy52r2Lj50ayfR0j0rikU19sosUMY/XfONJo207gQ?=
 =?us-ascii?Q?7Mf7uBweuBa61M5/01tMfQIvfB9lQILr3xVa7IpAbVcX/HVtbfO4iY2J+rsi?=
 =?us-ascii?Q?Zn4ELcmvdW9Y3+lPqMg0QuR2UagsYsd77zSGX394BHefSspGhY3souTG/+ox?=
 =?us-ascii?Q?/Xfa2sIQRMY72i3ri+6udSA8sRIDZ592R+/6Eh/ls94Ltt48V4S8wRPZUIOu?=
 =?us-ascii?Q?kCW2uW4ryzrNpOn2uUQk7kwXeiIq6Pu9OAZCU+1ET38P4RQb5dFTLfBn8H52?=
 =?us-ascii?Q?encVB6J5VrOWpw1fi+3Ms/o7SKfpgGsq0dk+la3+UHgprsed0yrKsgMsLkDo?=
 =?us-ascii?Q?1m7ddq4P6cwEWINc1Jf4xVNpb+249iKey1iRgn/mwNOO0w/cpRAxOzD8sJPT?=
 =?us-ascii?Q?j0XgVTDQkr2RnrKOah+GgF8ZmqqCJ9+enRiNiNhFAn0PHqZoB69UQaNUl8UM?=
 =?us-ascii?Q?asGVfMOhqOSgn7lJrvezZNU0yIeD0IbKKQWb8R5VV08RPMAIksiDgNDPqlVu?=
 =?us-ascii?Q?TssnE/NpwxswSR1v8kKF77+QC3vTCMXU5HQGUu8kTObiMMLTNMGqjWjSj6nN?=
 =?us-ascii?Q?RoKQyWDwh0qnCrXrMvI19Ym0O4R5J9ScogYhWwPrp2vnAEknoIFNiKJbevlh?=
 =?us-ascii?Q?QE0WXRVVZ+1jOE4i4vARJpwiNfD7oXXszFH9y+f63cBlZVh+Fx+mX1kUPI65?=
 =?us-ascii?Q?FqUvcyd5Qr7w9Zc1O0FXTscCgzlYERFJVlj/I2i10pcQKRD0HOB+6Y62yH3c?=
 =?us-ascii?Q?X6VJ0Ha+iXPwJps72vby+QGyzCVqmaVqRMIBXZlCgXnngUAmiT5hbTp76MVW?=
 =?us-ascii?Q?bfnR1AKrb1QdL3Wvrypwv0JARTvEmOQy/wJ/J3zLtJ9ByMganx2H6xL4ctIB?=
 =?us-ascii?Q?SBJvBCYRxb0Q3S2/vt8vIgt9NAk7ao5mAKABHd2lJwrEulnexxPWXYKPhjxr?=
 =?us-ascii?Q?YXkF6MifIzAI/7I5Qp7pSaLMcIQR5Bmq3cR0BZ8fguaLqC7szqe3NW0pf6eS?=
 =?us-ascii?Q?G5j5Inpviqua5p3oB/ePOqGk9FzqqeXltcXJy2X3yrisTlgvVwZUSrc8f+FY?=
 =?us-ascii?Q?I3Mveb3JBXAUXZaPFgucYw8NmSX9m4JUlOP+yj4jHZshsBZoZNrG8N/rhdfV?=
 =?us-ascii?Q?qs5pEPH15YvGMZKT97zzE0ERLOWECf74rCKp4H1aoXaGMk+7ZD/nJT+MHHfJ?=
 =?us-ascii?Q?O0UODYWvHG+f3NIuY/lR+zTx2vVOY7tjUeULPSpCK/cIUlBlyszLkv2I4hGv?=
 =?us-ascii?Q?+nJQcuQ//xvy9Qb6ZxZz8ia6OcKvj4EMfKiMM3Tb7AlQFj28YoxxgCGNrQ4V?=
 =?us-ascii?Q?TkVJ9Ic/TOhX82agTdd20+Oz6DZd3hblLqd0vE3aSFEizkBBBPto5h/1zbUr?=
 =?us-ascii?Q?U/R/++ds1fyDhbCLDKkjmKX3QWgCXj8+dqKL87eBGIlJUmltKI6gRFs/WfgL?=
 =?us-ascii?Q?J8YYq/1T3eRQtF5gIZOn1n3C7Tu1BhdpEre1511vmrZb46q06bBGSZ3gj0Z8?=
 =?us-ascii?Q?AalhFnQkQBb6U0u+sJd2trkHnKRdFEuGS2n/eRiCGYcihHeE6TjM+haoyL06?=
 =?us-ascii?Q?Jvs0LZpb3DUBgeRKEODKJRtVTZTVyqVfPabXboGD54JRKXaQyjWk83pS64ly?=
 =?us-ascii?Q?QbGB0Fb6qUBJWK1WyLy6jtG9gEI7wnSjNWOewoxrJvW78JQN7klXnxrRe23G?=
 =?us-ascii?Q?5C2EXCkg2e8uC57X/ezBj4HUHz6NY+U0GKbN5WEMAc57EI2AYK7GeeaT3JgB?=
X-MS-Exchange-AntiSpam-MessageData-1: Iz0Z2XLCDXme+9S3QNvvLXQiDhN54ARhK0g=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cc03a3-d5fc-4c56-cd46-08df1fbd53ac
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:10:12.4536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peGXx1l/vLR8YPNWI04tk3mMS6guKLo6TR+PmOmhGBbwTTlIQUecMX2ECHSFGh0l0JKGjfrU8xVJeMxG3blkTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10614
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

On Tue, Sep 29, 2026 at 07:59:37PM +0200, Vincent Jardin wrote:
> The SD1 lanes can be set in more cases than the 1x100GE + 4x25G
> split. Describe each case as a mode, an entry of a table:
>   - its hwconfig name
>   - how to tell SD1 is in it
>   - the mode it is entered from
>   - the sequence that enters it
> 
> The two existing states become the first two modes, under their
> serdes1 names:
>   - the "split" state, 1x100GE + 4x25G, is 100g4x25g
>   - the "unsplit" state, 2x100GE, is 2x100g
> 
> A mode is entered only when SD1 is in the mode it starts from, as
> the split required the unsplit state. The serdes1 value is a single
> mode name, read with hwconfig_arg().
> 
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
