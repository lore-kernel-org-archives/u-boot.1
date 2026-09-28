Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7ADCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 11:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A49480986;
	Mon, 28 Sep 2026 11:17:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzicHRePMsye; Mon, 28 Sep 2026 11:17:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5866880A5C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790594260;
	b=sqFAMPw690CKFkxz5XIHQN1WIXqVh0ebu0s6BPqIEDBkWtMKc8bjURapdeRLTMLWdcdn
	 2inXhjJaHR5bMclueFcuv9UeZI3tImGTkPtHZHMgjCNklFTrguAGWtZGOwao3U9GJ6AkT
	 DpuoVfDuV//4/pLm2qJQcLhr2YmEVeBRpH0MreVQAKV3XHZ8bHs5qA2n2WeAcRR86mNMv
	 QV2rPGpQSTT596x176y4zTvwY2bxIMfcDZf0o4QRpwCSsdZCfT6vun6IMQ7hI31gJk/wk
	 O8l78M9Li8MiK5F68R9yHMSr6nTkVdHsKGVnsCByryz3QuVcvpbXrueggifV6MJ4tAg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790594260;
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
	bh=xNATPclNHDY3auchXsJbMaJELmFyFyXGbnAU0G3Wv00=;
	b=k4ZsntYkvk5cqjdyzBsWEezf9QnT7lczckeNOd0XMYjw85jCRlc94nJCSKV3mbxm3Mo0
	 mPV3U/ce4u9luk1mtomw2qOxl/U1WP+XH5f2u3paG8VmeRIZE2vUHHeQ2KinWIveM3+Yz
	 eiYvI/T1riYDOEYz65Z5mddxM+LyFkebwRSquaTr+/pRUV3H7xeD4cEDt/mT7cnefAZr2
	 sm82W9miuBi+lEflko2CYUl2RZ/EJ0Vn0iHVgM0ekteUtoTo6Xn9cBhaziHbr3UBbXFy5
	 WCOYP2lzhURNOjITc3NsvV4CK700huPDsimkXSoFPYdKmgy4IuYYP3d1HewY1p/X+Bw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790594260;
	bh=xNATPclNHDY3auchXsJbMaJELmFyFyXGbnAU0G3Wv00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MTzSRqszH6LPhWb6SELkacmn67SL8m2SgnCk5Bf5Rr6F5poYd1Y/8J8lE8OzbX1oS
	 YFy6Vd2qSvfVgq9eWhxxFCbFibA+M4Bt2KHWt6yPM4OTIgeEk7MIf15e43fQx/itmR
	 R874beUBm3C6ynnrrlmHliRQQfZrkonbrHiidiIw2cO1B8rM7LImcN1pyYkz5vuaWF
	 rPGfoeT2yGpKdZkNZNT6J2HrCDyeKdKOzZU/6jIaNsp6lf4C45uqW+4eMygP1KB5xO
	 +o8Sd1Q/8kqDbJ5VW8GWNZuwt+vsgLOZ4nxzsszsJEt5yvSEzxrdjjL/pdPXqauHUw
	 MPcp8i0zC6tow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5866880A5C;
	Mon, 28 Sep 2026 11:17:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E1783D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C544404C1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkiFv3YKTvko for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2F68B404A8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790594257;
 b=S3LduXsoPU4bf9pwEunMtC7j3WbyogshSCPkasGFxE5opSyiasUKZSgrF4n6nyGrzeFQ
 y3IRpA0BiR9EItcZR4mnWXOpFDsucbQPg+6eUYcp/VU4q0yl6CT+5gfcUFwKf3mWhgcs3
 2ol3QRxsvkLvCPxySSmln//WRPebq5gXQj/SalM46h+xg5L2siTP+JZgjTsVwuyy0PJrr
 w/bO2/aInerNV30l8uKxQ9TP8BOw91HLAE8TzBgzxbDpSQfg2C5x9SkXp00gXpjYBrYtU
 K+AqEgdPt5gKJ9hmC8HvIkeXLjtlmCD9cH/8u3e/p6s+yCBMoWpdyUTQ7b1F95+g+sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790594257;
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
 bh=xNATPclNHDY3auchXsJbMaJELmFyFyXGbnAU0G3Wv00=;
 b=A026jLjJToMn3oXUFP7pV0x+Wgffn0P5RqUyGBmIhkrkFbC62w1BYNHbNDVhtMIlD6EC
 Cem44H/yQpt+pVCorfIjDumZlug1thUEaUa20cW/QNT/zrx11uExq4V25WHASwz1oXxfs
 eDf70AswjFVLuuKmuviYXBGlwasVDudb53oOtC5zh3Ln7WZvSW/GlXsMowQSfdMMPVKUo
 5yBkmT8mWGpp6RiLDiKKWFjCp85ygDOcBK6HxPnfuSrlijwQiYyBFG8zREmfoW7QKA+tg
 qx8RhpBmD/o3PIvfDyx/0UD6f8ePZBzXCGptQP36QiuaBaXsrEg3x2ytUNyyx8/Yo8w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=WPAKCx4u; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=WPAKCx4u
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F68B404A8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ybe97AhV/mIiouFe8NNX9XISsKlogMN9pJt5slJlejmBHV8TXgMxFxsnMGlOFE7ax8VilY46zUHPicSeNJ0bj33mHPqdi5+pd/ruOI2kkCrfK6Zzdiaz1TzFM6o3ZQLcizqR2573ZtGbAgUa+wSZHFcXtf+CeE/TsmjmvtVhky3U0LDddXalGgjEeRBj+WCvdRM/Bjffo79jHi6R0eSUk7uUOKUQCTZXjKXa1IPMk3cOY+Att7dg7nUxNag3qNHytUFkLVLK4Ut4sZLnqSKy3XcJnwttzaTpQjhB+hP/Re/L9cRaVM/gkrt4KFQjBNkr380L2UCzweBYwDj1YHIs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNATPclNHDY3auchXsJbMaJELmFyFyXGbnAU0G3Wv00=;
 b=kA1XvdH+bZG/SXF99FeBbFnzAOP5KpdCDGocHtT2cQtPoDhBgDUDMVXOviyz0A3+w1i9kxsh3fRmraxWY6OoGl/4uMlRQhf528unIZojOUauBivE3X8L+hd7M4w5OB5tnbtIzKCBhS/QXCTLVpw/tIBiGrAtB9BPneabjYR/WgnRA4FbambenfIrKUkaX4bB4/VsUvO4t3lk8l0BWuhsToUvypuy29wB3U/tuFtaTVLiL4nEwro7hoWO9L9W+368hNsUO/iu7p1/Yn+ghKY2McMuXhKP/v/rWgh9ooawfgCflonr8VInlRsTAozLRKwgrVERItgyjnow+OcX0gz7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNATPclNHDY3auchXsJbMaJELmFyFyXGbnAU0G3Wv00=;
 b=WPAKCx4uQWphMOR71rapfiE83TWnKgvfO9YHdDP2KlAnL82001gPT1GK0slQJMmDPeTMZU5gVwt6TkF7Pn08HdPPIbe0xqr1X1MejhHucHsNpzRqgXexyavbMeS2eLfgDZUCyuePxFmICeaoKhqGpvlDtVwIRkKlxnsUR0jrOjnshbqkvFghnvdjWsouoCLbHUfPR6P/C2yQuH5CZEIWax/2rE/Z+bPQew2ZR9gNTw/blV0l+waxINo5eSXt2Siqp8OV/iNtygQWd/T52iEp/sVUju0srBvZ+8w5yNUmMvzUWebsqMS+/BDrW0xNu+0zAygp0mp+FC1RmyWn4NtyTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:17:30 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:17:30 +0000
Date: Mon, 28 Sep 2026 14:17:27 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 01/10] board: lx2160a: serdes: drop the split subcommand
Message-ID: <20260928111727.jq75dsw67es6j66n@skbuf>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-2-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928101330.881662-2-vjardin@free.fr>
X-ClientProxiedBy: VI6PEPF00000222.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f8) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: e085b1f4-29d7-435e-63b7-08df1d5215bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|10070799003|376014|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: kjeJH9nq8Jb9F8pQRYYz+pvCdwEvYfVtcPWmrCB/G2MoxiQ46PqjssWfm1ltWtmhmTHhR8GbdZfwqG3IHSqX/pO3EErjfHMrwosFJmloVhYbKHAguBiyQpO8V0WJqDVn27ol3jOTunC5FKIExbE9s3+jvSZh5RlM8aPIrJ0S03Ev2AFODgcBW4Yl0fFmk6BB9q811yD3rIEFYEnW37dg1tLR4v5T9TWgfWVbqFL99zr/s/tMZSofM7XUnIfWBnqqZ6h3MakDLJbSFWtispjAnrVfWXTslbw3UlrWg41Q76AuKIDwA52GOIdeyK+Q6Dv1k3TafugxhJvEkTKkoJDSH59+6u2KSdMb0BxdakZR7oU38WbBfqWIDjcQybZRsXfP2DACsjjmvakR9KukuhqaHBNs9kOfLOW96YLPxHeWJYMwDhXlaYxuk5GaBK/SmJzTTtCqGFLnr1ruY6+egNuKz0CmqTGN6cvYAV66IMBduNgnPNt+OXSI8sCai4kyCq56N7vlXvVb5ERc8NPtFYYZAdBE8Gt2efuaxq8/wfC3g9oRqfuJGflCnvQunlwgf7qlwy0d6BBgs3yxrue3ENZUfAFYHAWNbV6/3ll/gYkt+9yJvVdNuzlsXQ1ED7RMHi38erPzxlH9cW5k0Q0TjxS4G9AlNXHGJTUoUdbND+J8ju0Gg3Hv3o+DEgwgFZxXVFJ1GJNm/ozbfTrvP905njaKUHNTbZ7XbT0yH5sGaaP9rLuE32sZAXzQ+L0l0sxcPyhY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(10070799003)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FGXVPyXn2FEVpvlSI0RloP1Ur7Zv4ajEYryovbU72S93M9t0lZSUkyqLyX7F?=
 =?us-ascii?Q?GVVhzsaZ/Uxxb7qwB+EqH5S7/hCh7RCclVLOyiUbwZmmwElnF8EhMN0RjMAc?=
 =?us-ascii?Q?VVp+RMJLgp/Afh1lTKQqOvZWdb2uPx67DWvgjm5uZy52936PliL5X2nd23sS?=
 =?us-ascii?Q?VGH/8c535LtItFqXXEWw2IjwNNG+SbMLSXAOPn7j1O9xNCvALcbT81wFU0l+?=
 =?us-ascii?Q?VuCXubsgsuT7o7hRArKqshYYNdsmV4eKeGssz4SSTevlxSZK4rxYBxVahgGb?=
 =?us-ascii?Q?9w15Qw0KiIC8mT3HwJqfyI6W2ZIqNYeLbrB6JA1OnAfnCkanbgtjQzIZ32uA?=
 =?us-ascii?Q?W2J/ADlNJuaqIUaHxIoMdPOY7VWLwwWl1rE7UX5rwIthiuSgKZfj1iJJiuQJ?=
 =?us-ascii?Q?dcCkV7bSI8/+RxWZ8rByP7kHbeILnmWOl+OEOnn9R5E/+0OoDGVWBMAt4dXG?=
 =?us-ascii?Q?1C3sI2HecCKmlShWm8mjqYwVrimkwAPPpVxXSK90BHW41OFhBDyW4Amy3IR6?=
 =?us-ascii?Q?OZUiOHIxZVhDk0RDXeI1jgpB+MmZczdQdCNeT8biesHaXfIIFBS8xYwo8Bq+?=
 =?us-ascii?Q?krmovzCgZ5HAJwBW5Ntc+62U1GHWXmuQAjzPeT352NFj59qmeidHS2up/KZO?=
 =?us-ascii?Q?T45tBRlWyjJJhZ8d/H52IAUP5F1DfuLye3TdUCkn1E9R9MAiZiLOH/UKUfUL?=
 =?us-ascii?Q?ZJ8gIcj99bQT26E4Hsc70q3RpF2fvTBnmiIFxcmwJz7PpXXAkxcgAC15aMmL?=
 =?us-ascii?Q?OC9yRYjqcvjxys1ZYN40lavTobZfnUbI5F1NKiDq0BDmG3mOIe/o506o7Vpm?=
 =?us-ascii?Q?CW2+nw4VU5RtEWdA6DW3CFIXrzQGLNb6/Tn6z+3/G+MxsTHw9As5f4QYHVtY?=
 =?us-ascii?Q?JWcFnnugb93agqsZgE2liA/0FcJWbQ8qgFyHRRgnvVNXezBEJJHiVubuUHce?=
 =?us-ascii?Q?9SeYxkPaRsg9S/l9oO2LcWG8Idgvq3M442qIs2DBrbj9mPFWqwMJ5KKwVXFY?=
 =?us-ascii?Q?kY51OPQ1re9MFbnB9EjLMlIfVlEqDZWVrxTPDWLS9NavdstGJlmx9Wg1J2tr?=
 =?us-ascii?Q?2zO4RbBBMcF/7ZWgTwkl9cuLoCpEcnUHPl3TcmIzg69BFbFV4tostwW/AHZH?=
 =?us-ascii?Q?aC9+8CrTeSCe2nQRbbxlHynBfGF4ufdb6E4XZAmnuKxGhvyEh/SZr8THjd/G?=
 =?us-ascii?Q?0WSqmyMmTuPCHjosGLRowCA+EIGg579E0gY0GkKgnWlGMYoVd4pRp8+SDIXL?=
 =?us-ascii?Q?0u5igk+6QZWKZy3Fm85/hCMn+Z7VKcjfW+8Jy25Hp0+QY/tDkL3o5DBoXqUZ?=
 =?us-ascii?Q?YjeBP5NWiOcAdHWfR0qEXSwh/9dcikryiqGzfCdE4MQiNbeNWuxXzSC2xIka?=
 =?us-ascii?Q?6byDhrj2JyVszEkr6MbSfO4qdbJoZlizT4JJjmHPCsObYkDd0ewecqvAoIkQ?=
 =?us-ascii?Q?VB3dvBX9we70+pkwRcHj1WCSOAsIMqZzyuDN+KY9H/N+DFObK5XNJaWl67h3?=
 =?us-ascii?Q?W384gfi5mqB0xE3wOvy2zYjx/DE4Jr5lGbb371uAWDxrkBNVZU8Mddjmu4Nh?=
 =?us-ascii?Q?uIE26Z4jvYlxPJ/vlALAfu+yCRE8rI4uoHyaIf30udLNR5an5HFAz73SK5cJ?=
 =?us-ascii?Q?c79QVamP7ZXkdq2+jqrNzO5rKjrijwyzzt2oaQ0GFnbvnFPsC+W40A2k4s5k?=
 =?us-ascii?Q?lwkP/dLW3TgJdGNF0dcZ0xWwCOCNQ7NpuhDe5HRbC/IzRnTDRKE7v1KO0zkk?=
 =?us-ascii?Q?2hDRdc+qMtHsy4U3g+e4qWqBCuhHfH+F3u8s1zFSvZo5KOw9beEGXY7xdc/b?=
X-MS-Exchange-AntiSpam-MessageData-1: 5TVR+W4A7mVQon8RQMbFzjj5hqiVnowQLzA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e085b1f4-29d7-435e-63b7-08df1d5215bb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:17:30.1438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxzFAFHllZ5Ygo45KI7vpV3w14K2rlXKDNxuCQwKbD+WBBxhE+tijsxuF+rA8vnFnR2uP/Igvu4VC3mkEyeapw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338
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

On Mon, Sep 28, 2026 at 12:13:20PM +0200, Vincent Jardin wrote:
> lx2160_serdes split command configure SD1 lanes from the U-Boot prompt.
> 
> But the MC firmware has very likely normally been started already.
> 
> The split must be before the MC starts. That is the purpose of
>   hwconfig=serdes1:split
> 
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---
> 
> Changes in v4:
> - New patch

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
