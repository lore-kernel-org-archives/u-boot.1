Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41E1CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B5BE80E4E;
	Mon, 28 Sep 2026 12:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t2dtGcSAlxAH; Mon, 28 Sep 2026 12:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CF6F380E01
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790596977;
	b=pPud+LoSPhxaUPnQ5Bf+9wPFEfZXCiu++RqOYC3uwO+sXIXcN6tgjNifH62CDshiqd4t
	 1YoC1yic1ka5okwVbE5wMp9lC7YaIiO7Oqfqk9tj3AlQsfNRh88vdnuPRjIR4zn3PQV+8
	 WzGs3MCEpPHM0QlhsUkC4+LtD6dn1dTomwy6u2L4j1BeqzEBDSOivsEWw1OHbUearhC0J
	 jNXIjsiKi31FhuAlN++YIhbj/JYMzxgjSeKAd4PVHyKCX9Ekm1oZgdDLYuhwQ6na/Au9d
	 By4cab/EyPc4+LmGpvIK+fv1eR1h3vqEzs6HNY5DkB3SlCEnwKD28v/ZqGWiOmcJLng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596977;
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
	bh=L5Ebc7k0L+M9ZYn5aM56vL1qk7HbsMXMDBPF1w2lfHE=;
	b=B3KA0iJ1Iv+3drtrS/TBgihJV3VR88YLgFXlycZURLmtOToOq5vg953P82OKG3GAqXat
	 htLmmuZECIId7jqae9ib5QaYOwsoSwXUyTdF7XZp49+rquLnhVCThsRiLjUWUpMfoM3uf
	 GeTTUimkutQXokXGUOuYlnjN/Dt7zi1olEgaqwDroEMzH+UwInIICIckgr9vp3zTajIF9
	 tN5hjnBhOIo7u7SvR3wgSHdMLAr+Fca51npNDk3fTo3wbAxfzWM/HcGnUquonbvHjnVm9
	 NaIscnSou1vO1/w12nwDtORbL4jGbys44ScA+o/8lwsFFIYyPqXLD2hq9ziNOsR41aA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596976;
	bh=L5Ebc7k0L+M9ZYn5aM56vL1qk7HbsMXMDBPF1w2lfHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LZ1XwXiboy4zHqabT0oKkh8wut2GRqLiLgyPDy36SxDPmg7PrXRNYNlktpMpC8+yV
	 cgGqF+cJd4FP8VDeg6ccVYLn3cydWlFZjAKvRWvH76nem81w86AZA4kefyCpAYMfR5
	 4eqTY66SmmAylsDd1XueTL6TiIss3Oh/ub8+6K85TApHgYvi4SnbcAHK01r4LSHeV3
	 AceP0iSSw4JTBOUnH2HxJesddKdAdrl5o2PtYFjd9MbudBRfjoIXRS8F6ngksqGX6u
	 YYB6V2oSOGfoyv390n/uitKINdgauA/BaH5zTSz90oKb76TpESMXZgmWsJ7b0tRRjS
	 dbyyxeciwotxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF6F380E01;
	Mon, 28 Sep 2026 12:02:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 806D03D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71E474050C
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9PG8_9I7sh9 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 000EF4050E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596974;
 b=bNhB2tpv3UPNpXMADp7tfo7BSYS4KcDjsI25JgkQROyuTKdhK0NpD+xj1aVaCHifu2f8
 8vgrTKiX5GKGVPZtElTshuR57VvM5RgGpU2OHOB8XgvNiwGmaHr0OdDKfUWu7w5Okaoam
 bqGu/1pn7fxXxyigwbIG8L+9JX2LpUAA/l46F+TLBOJUa+YOFSbJhrqxP+GIRrB5NJOKo
 kvAmRPMfRu+AqXWXezabRV4QvYEYih4yBEL/MYz2Ff4lA3Mj8clWN15gk+c5pEswzHv2t
 zLkyoFmwjpzmGp9O9hDLc161A8l/rZT7fGKLwvCOHYIYzSjj3ZuYlEc26DdZxVbJhHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596974;
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
 bh=L5Ebc7k0L+M9ZYn5aM56vL1qk7HbsMXMDBPF1w2lfHE=;
 b=SBBbnDtnu8MTxavEpIEQ6GafVq1KN1n1j+TkpxggyQ6gGk5O4/h+66En/+VsoJHrc2Rk
 VWSH4PSYQDS+Rsp6/ab1iP8KzGf5PeyHFK7lW27WgPFr7fIsLHXOThQpcKEpN6qvOwsZG
 7uIJG3rqIEOQRobzTlBok6u+MijUE3AWqstG/ANqsjF/uBUinOmjn/hUNVmqTgA0b7pww
 Lycgwdmqj4JwmcDM5jYGw9ejd+IiRBbzodLrE7POAZJ4oZqK5LQW9hbahH3oWVbgTqoVp
 SxepWchbb9wijAfZyJhiJC6fQ/3emMfKJqlw5JTcqdwLEI3DxUNryPp3H2oJxcUCP1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=jbTlDy5K; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=jbTlDy5K
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 000EF4050E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDwKrTSbL4VL8JFI3G3tI6TXGnVlurXiIi8HHgyE/Ko9cJe/G2PbbB4XTzDlvzbvI0LCyB2RX8gyBRsuKv6Hul/bWQKr1dltlNCpW2aCJKnGnfOC9Xgm8ZF0drzwzjUI7JNC8wwtM3bSqxsvyrH5iadjDivC5hK6kAwIyKbDN+wFot81Mk1jeyAuayHg2rNhoEFf+RpbyfAUs/kD8Libc6zRJDaNP4ZyPeGtrQtRJ08tv8xUk+I93GF+F2Li3iQgrAlVKbuRB/rjGZY7xMx1mWsTy9pkXeYo8QE2ZiSV0Hko7NvGJZv8zPgAxuGZk2xlI1erORqLJfoLu8IiUFVGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5Ebc7k0L+M9ZYn5aM56vL1qk7HbsMXMDBPF1w2lfHE=;
 b=lKNgfq0brZ8LrST5XMQWqj/0oLZqNhZLFOohYoRo37SFtdopWrXEDb+UuFlRPQcWUOo5F4z5fHr7GlIYzIPYdRwJZum2sKgkCBSyZQDLwOshSjE0tdlD04J43esHVH0X3aWsIAtpv5W4fxH1/d//8iHNPxP9/KQrDSba09AAOgv3MnMbUY0IBtzg88mxRDWUo/qjNaoRP8bZXBPx2j2PpYcy8ZSAC2MBmkwMCjVwhPjLabaE8qxfWwvQFkJYv41/sAP0/4WLvujCuHpIAbbiyBXyZ5LA7mWgJSpSw5yNHO3VvZkteDnWQUMoyR91OSZOj5a1bfL66P0QixBRMcSPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5Ebc7k0L+M9ZYn5aM56vL1qk7HbsMXMDBPF1w2lfHE=;
 b=jbTlDy5K+WfENGyTexbXXaCyzKFWwnqGTA6pHp529I+gxReRDm1wp65xwiGNQemtJdWHdiIivrWOYbn5mSng5AMe+5LyxyRtIwxFGObEKw9y1ksLs5WflT+m7oXwAUHEgDjWfUBClz8+U3dV7jp4m0+Gz2/IYE/WaVq3xoKNM7bV3Xd2WhOdIMq5CHnBgNAY4oacBehkDaYYVg/h6NnZoapr58eyxLuSeNpb88hKy5IU8F7AAW87ZQCgc/6vXNXea2/X4Vy0NSqGXJ6QIrAtLt53aHCTIr10IhjzR04JDn7VjjuDDTN+LNGCTayRecv35WhQKcR91jilp2Wb/bPiLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GV1PR04MB10701.eurprd04.prod.outlook.com (2603:10a6:150:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:02:43 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:02:43 +0000
Date: Mon, 28 Sep 2026 15:02:39 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 03/10] board: lx2160a: serdes: set SD1 with a table
Message-ID: <20260928120239.fhg75n7ofx6nwhl4@skbuf>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-4-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928101330.881662-4-vjardin@free.fr>
X-ClientProxiedBy: WA2P291CA0031.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::12) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GV1PR04MB10701:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d383b8-ec55-492d-3fa7-08df1d586702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|19092799006|1800799024|23010399003|3023799007|6133799003|10067099003|5023799004|11063799006|56012099006|4143699003|18002099003|22082099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: ExMO8nLHZ4/K7fny/Kf6+trqWX1SxDVM9van8NPsIPIKy4GkwJpHMeF6UwHjMDStl+LvBGyBsyQky7ezBN4j1ze59EvRpGT0YbJFDAQWFmI7WHBbLA/MbBkO1XB1AjySLyAda/WwS8/Uj6kudPpUIM7MqtIzUj7s5MPdSnbBZrUaLMp0ZKqR7euxASJE3El9ZLyC23BivYP1newOus2TP/yZ636GNMErHKws2gKOVsAGMCt3fH0s8DLIEz1dabXXrs7Jaw/yW1vygxOKfI2Sns63MEfquozTsFCVR5Vd1UXX8ZZ/SZyHkQR54Exa0YIxNIGPA1lJGo+VbZUbkbpsNSW5Uz55lDBxtpt94nV+psO3I2GkYwvAgw/GoklPfA6mchM1qySQLlEQS4FyR/Ph5X1aeJUm/vafC25h1fsDqE+uPE8U1o0cZFnerPeivOWi2I7RbG4KVtHVQHvOY1LoAkBCO9yeW0kx1AY8OtNTIv9qkmQeRNdKCvSD4V+wfeCWiA3UlYQq1gIL309A2SoP+FiKFfcUuXFWsMVL9tZ1gMpuqu3MizEnYk1waAL5CzbjaDhNTJ/U1Nn2uysC81AVQsfHrnOtpxzPxUFCBft2d2KGJqznE71p7GmTEgREngIIqFZW+BYXLzPfJqCmkV87hlmQ9Y8UTtfDzbwa5/ORsm9RDHJwcav6ui1VaPY91WwFimYtYy4ZACPg2LA7noZkHf0OtnG3Q94L0bMZrwkSdLu5TxxMMeK26gxFZBI5L8RX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(19092799006)(1800799024)(23010399003)(3023799007)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hut1kOyRrJwkrs+bdaILQI4fzJ9HKXTbb6eiTkiwh5sj2+Mj+2QYd8ZJqTkO?=
 =?us-ascii?Q?RXZ/QiCl5SyQDnEsPCwnVuA/TrlcxB/f4AVPBh9xG8C67B9M4aCtY2+EoDnM?=
 =?us-ascii?Q?1ZRxTo/ap/nodjXOneEL2FOFo3yZp2hmBXBlQCxLzHKuIgLoPtB02jbh+qfn?=
 =?us-ascii?Q?cXnc2v+6Nv++4x2EknXGY3pmFCcClrcIM/pLxF6wPJqxokOXuS5nMdRtUnGm?=
 =?us-ascii?Q?Z+Y0WgBA33JZyd2C1DzY9ys5Kl/GGCvFPXEU3CCQmw5wlpjJVuQP3ZdD0vBP?=
 =?us-ascii?Q?yZIURDNRTgFAPHBjuEPUY5ZF38qdw66fg7QH0Qe65atU5rX6t75vqIglnbYL?=
 =?us-ascii?Q?Ki62Qy9pBaGMjN1JAjpPh/QsR7T41EdIablCxrhclG7xSnU19eBERuxQoP6U?=
 =?us-ascii?Q?AWWKH1DHEMnp8l0zNB5aLWS2OTmnEzUfBOK+aPvd/YJteOv3+6lf8HwX+Bb4?=
 =?us-ascii?Q?J/MDpvbQiv6d+HMrGj1iwvbpwZx/q9bZilMz1wYKCb4GeKXPuMNZDYYTxLOe?=
 =?us-ascii?Q?b26QSabvp4dRnlWZyrljH7+FndlMmUxCsoJ++PdR3Y1tOQe9FgN8gsFwEICg?=
 =?us-ascii?Q?7cEp79ojP8NR1AQPNDpGojXjzn1fSmga5bK65Kz/Ub80ZKkPkxuN2CJ3j5Xc?=
 =?us-ascii?Q?XsQjdnc5GIuVci5Dl34eEVJP6LmiyFklYBIt4gQb5m4eDUY4yIuJ2T+0Bbck?=
 =?us-ascii?Q?C5xZg1eE2HxYj3H/ME9G2SHnXMJEBukP4yh8C94/3nJfBFeDSx8yMdkHOq6L?=
 =?us-ascii?Q?s/Uq920yr71f84NnTQNP+qyNnIIn3nEIBfUixcVbvM964MW5tYuT/I/Pek15?=
 =?us-ascii?Q?YPQgfVljwbcjt616jY3x5KAuRF8qEoTcvNof0Oj4hqJUub7M4cNkt3W+axmD?=
 =?us-ascii?Q?OmrujveayybguKYfEPCBv00xGf35PxvMyPkfWXZT3qoUXQp3oovSg98pknLi?=
 =?us-ascii?Q?6UCmdq+Ow5UYbvYLxZBUqNvepIg91lrmWCgr83miLM3EWChfqs8kDsW/oaAf?=
 =?us-ascii?Q?z13aRI49iwLd544H3QMoezSFHEEwMnzhqGgQ24ENPgUKZJa5avuFXa2UTnLv?=
 =?us-ascii?Q?ZjiCFtn6p5yX2I4Kb1Q5LQDbSsdU0kcg+wlg+UDv3AGFUwZjxMWNsQ6Bngpy?=
 =?us-ascii?Q?lioQo/V2pafR+A8Gq85La1aUTZ0xoWnT+e3M8d/ijah3qgC91UT6Cddfa4KP?=
 =?us-ascii?Q?CAvbhYYSEgkRgIEmlY7Sz6UwH/gGEggzpJ+BZaD2eoir/VLha2j5ddQnyBvW?=
 =?us-ascii?Q?Q6+Mmi+LPlcxA+fBSWBDAs7RQmY5pBKVJQA1QE5+M4HMT54hpG1uh98aioto?=
 =?us-ascii?Q?QDjDUZym8TdFI1udgv873BGEg9W7xxfMHuhB/99aaju1cTLrnOe8pI7bprVC?=
 =?us-ascii?Q?tPWyOl1Rg9vqVJb2ELNeMl3d1D1ZspH2tzBQtdRJPhpDi5hthwSzSh6jaVx/?=
 =?us-ascii?Q?koFk7DGEAHzzQzYBi+B/bBrJ7fnFi69z6hlp+XVW1uQi3MDuGmGZSsgnfKD3?=
 =?us-ascii?Q?yJv9fW3VrWNCI5zZlHIA/xBJtKj4mbHgdARAQHd3+5hotKyQMXE1ZqK8TF0I?=
 =?us-ascii?Q?H3wWHbp0F32gpCS8PFkp6SWiPlZTp3fXrhNwSaPityAUxzIIUrv9cSDlV1Pd?=
 =?us-ascii?Q?o97mxEl/EU7MbCSg3trECudlvJgfjTA8RKPz/HMnbpaKz7UvfJDTH+Pe5HlK?=
 =?us-ascii?Q?00jY9xsNWYPfewicZpsFmu3MOMKVCFayGs1bWii0IzImFhmydwrTVcE1Z5GI?=
 =?us-ascii?Q?UtCBYEtGY1Ov9A1CnG5PvBAFFdkyL4l7GBLdny0Jl0McBkGxp1giP53VZAsl?=
X-MS-Exchange-AntiSpam-MessageData-1: McZEFoUH1DZORd/SRUcouKvicOAcCwEKBhc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d383b8-ec55-492d-3fa7-08df1d586702
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:02:43.3856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dgu1Uz1C8WOHd6gOZ4i3/GOhRLqfErgJhLHTWfQeAYg3vfRS1avy/f8VNvkKlWSjAJPOdfIBN8cXdt7LXEVyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10701
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

On Mon, Sep 28, 2026 at 12:13:22PM +0200, Vincent Jardin wrote:
> The SD1 lane configuration can support many cases, not just the
> 1x100GE + 4x25G split.
> 
> Let's describe each one as an entry of a table.
> Then, let's check the serdes1:<mode> of hwconfig.
> 
> The master-lane lookup, the halt and the reset of the split become
> helpers.
> 
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Still hard to review due to unrelated changes mixed here.

> 
> Changes in v4:
> - New patch
> 
>  board/nxp/lx2160a/serdes_split.c | 272 +++++++++++++++++++++----------
>  board/nxp/lx2160a/serdes_split.h |  16 +-
>  2 files changed, 192 insertions(+), 96 deletions(-)
> 
> diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
> index 1a5c44e7740..11bec35fd22 100644
> --- a/board/nxp/lx2160a/serdes_split.c
> +++ b/board/nxp/lx2160a/serdes_split.c
> @@ -12,6 +12,7 @@
>  #include <asm/arch/fsl_serdes.h>
>  #include <asm/arch/immap_lsch3.h>
>  #include <asm/arch/soc.h>		/* gur_in32() picks the GUR endianness */
> +#include <linux/bitmap.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  #include <linux/delay.h>
> @@ -245,16 +246,22 @@ static void print_rcw_view(int sd)
>  
>  #if defined(CONFIG_ARCH_LX2160A)
>  
> -/*
> - * The split itself.
> - *
> - * This is NXP's e100g1_split.rcw sequence, moved from the PBI into
> - * U-Boot.
> - */
> -#define SPLIT_FIRST_LANE	4	/* LNE */
> -#define SPLIT_LAST_LANE		7	/* LNH */
> +struct sd1_mode {
> +	const char *name;			/* hwconfig serdes1:<name> */
> +	const char *desc;
> +	const char *from;
> +	bool (*is_active)(unsigned long base);
> +	int (*enter)(unsigned long base);
> +};
> +
> +#define SD1_LNE_LNH		GENMASK(7, 4)
> +
> +#define SRDS_POLL_US		10000		/* NXP waits ~100 cycles   */
>  
>  /*
> + * 1x 100GE + 4x 25G. This is NXP's e100g1_split.rcw sequence, adapted
> + * from the PBI sequence to U-Boot.
> + *
>   * PROTO_SEL=11010b (25G/50G/100G, shared) + IF_WIDTH=100b (40-bit),
>   * PORT_RST_LEFT=0 and PORT_LN0_B=0 so every lane becomes its own
>   * single-lane port. Only those last two bits actually change: the
> @@ -264,31 +271,24 @@ static void print_rcw_view(int sd)
>  #define SPLIT_PCCE		0x00000100	/* E100Ga off, E100Gb on   */
>  #define SPLIT_PCCD		0x11110000	/* E25Ga..E25Gd on         */
>  
> -#define SPLIT_POLL_US		10000		/* NXP waits ~100 cycles   */
> -
> -static bool srds1_split_state(unsigned long base)
> +static bool sd1_is_2x100g(unsigned long base)
>  {
>  	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
>  	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
>  
> -	return PCCE_E100GA_CFG(pcce) == 0 &&
> -	       PCCD_E25G_CFG(pccd, 0) && PCCD_E25G_CFG(pccd, 1) &&
> -	       PCCD_E25G_CFG(pccd, 2) && PCCD_E25G_CFG(pccd, 3);
> -}
> -
> -bool lx2160a_serdes1_is_split(void)
> -{
> -	return srds1_split_state(srds_base(FSL_SRDS_1));
> +	return PCCE_E100GA_CFG(pcce) != 0 && PCCE_E100GB_CFG(pcce) != 0 &&
> +	       PCCD_E25G_CFG(pccd, 0) == 0 && PCCD_E25G_CFG(pccd, 1) == 0 &&
> +	       PCCD_E25G_CFG(pccd, 2) == 0 && PCCD_E25G_CFG(pccd, 3) == 0;
>  }
>  
> -static bool srds1_is_unsplit(unsigned long base)
> +static bool sd1_is_100g4x25g(unsigned long base)
>  {
>  	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
>  	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
>  
> -	return PCCE_E100GA_CFG(pcce) != 0 && PCCE_E100GB_CFG(pcce) != 0 &&
> -	       PCCD_E25G_CFG(pccd, 0) == 0 && PCCD_E25G_CFG(pccd, 1) == 0 &&
> -	       PCCD_E25G_CFG(pccd, 2) == 0 && PCCD_E25G_CFG(pccd, 3) == 0;
> +	return PCCE_E100GA_CFG(pcce) == 0 &&
> +	       PCCD_E25G_CFG(pccd, 0) && PCCD_E25G_CFG(pccd, 1) &&
> +	       PCCD_E25G_CFG(pccd, 2) && PCCD_E25G_CFG(pccd, 3);

It is not immediately obvious that the old 'split' configuration
corresponds to '100g4x25g' and 'unsplit' to '2x100g'. Better to
explicitly say this, so that reviewers can follow along.

And then, the diff looks kind of bad here, because you reverse the order
of the is_active() expressions. In the old code, 'split' was first then
'unsplit'. In the new code, '2x100g' comes first (aka unsplit), followed
by '100g4x25g' (aka split). So it looks as if the logic is changing,
plus there are gratuitous diff lines in the commit.

Not easy to review at all, and not obviously correct.

>  }
>  
>  /*
> @@ -298,7 +298,7 @@ static bool srds1_is_unsplit(unsigned long base)
>   */
>  static int poll_clear(unsigned long reg, u32 bit)
>  {
> -	int us = SPLIT_POLL_US;
> +	int us = SRDS_POLL_US;

Renaming SPLIT_POLL_US to SRDS_POLL_US is noise which can be isolated to
its own change.

>  
>  	while (us--) {
>  		if (!(in_le32((void __iomem *)reg) & bit))
> @@ -309,79 +309,82 @@ static int poll_clear(unsigned long reg, u32 bit)
>  	return -ETIMEDOUT;
>  }
>  
> -int lx2160a_serdes1_split(void)
> +static int sd1_port_master(unsigned long base, unsigned long lanes)
>  {
> -	unsigned long base = srds_base(FSL_SRDS_1);
> -	int m, master = -1, ret = 0;
> -
> -	if (srds1_split_state(base)) {
> -		debug("lx2160a serdes: SD1 already split, nothing to do\n");
> -		return 0;
> -	}
> +	int m, master = -1;
>  
> -	if (!srds1_is_unsplit(base)) {
> -		printf("lx2160a serdes: SD1 is in neither the split nor the unsplit state (PCCD=%08x PCCE=%08x), refusing\n",
> -		       in_le32((void __iomem *)SRDS_PCCD(base)),
> -		       in_le32((void __iomem *)SRDS_PCCE(base)));
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Halt. "Halt only has meaning on the master source
> -	 * clock lane of a port (LNmGCR0[PORT_LN0_B]=0)". Lanes E-H are one
> -	 * 100G port at this point, so exactly one of them is the master and
> -	 * the other three requests are ignored. Issue all four anyway
> -	 * (that is what NXP's sequence does) but only wait on the lane
> -	 * where the bit can actually clear.
> -	 */
> -	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
> +	for_each_set_bit(m, &lanes, SRDS_LANES)
>  		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
>  		      GCR0_PORT_LN0_B))
>  			master = m;
> +
> +	if (master < 0)
> +		printf("lx2160a serdes: no master lane among LN%c-LN%c, refusing\n",
> +		       'A' + (int)__ffs(lanes), 'A' + (int)__fls(lanes));
> +
> +	return master;
> +}
> +
> +/*
> + * Halt the port made of @lanes.
> + *
> + * "Halt only has meaning on the master source clock lane of a port
> + * (LNmGCR0[PORT_LN0_B]=0)", so the request goes to every lane, as
> + * NXP's sequence does, and only the master is waited on:
> + * it is the one lane where the bit can clear.
> + *
> + *  -EINVAL means nothing was touched
> + *  -ETIMEDOUT is only a warning
> + */
> +static int sd1_halt_port(unsigned long base, unsigned long lanes)

Can you create sd1_halt_port() as a helper in a preparatory change?

> +{
> +	int m, master = sd1_port_master(base, lanes);
> +
> +	if (master < 0)
> +		return -EINVAL;
> +
> +	for_each_set_bit(m, &lanes, SRDS_LANES) {
>  		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
>  			 RSTCTL_HLT_REQ);
>  		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
>  			 RSTCTL_HLT_REQ);
>  	}
>  
> -	if (master < 0) {
> -		printf("lx2160a serdes: no master lane among LNE-LNH, refusing\n");
> -		return -EINVAL;
> -	}
> -
>  	if (poll_clear(SRDS_LNmTRSTCTL(base, master), RSTCTL_HLT_REQ) ||
>  	    poll_clear(SRDS_LNmRRSTCTL(base, master), RSTCTL_HLT_REQ)) {
>  		printf("lx2160a serdes: LN%c did not halt within %d us, continuing\n",
> -		       'A' + master, SPLIT_POLL_US);
> -		ret = -ETIMEDOUT;
> +		       'A' + master, SRDS_POLL_US);
> +		return -ETIMEDOUT;
>  	}
>  
> -	/*
> -	 * Reconfigure while halted: four one-lane ports instead of one
> -	 * four-lane port. Everything else about the lane is unchanged.
> -	 */
> -	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++)
> -		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), SPLIT_GCR0);
> +	return 0;
> +}
>  
> -	/* Re-point the protocol converters. */
> -	out_le32((void __iomem *)SRDS_PCCE(base), SPLIT_PCCE);
> -	out_le32((void __iomem *)SRDS_PCCD(base), SPLIT_PCCD);
> +static void sd1_reset_req(unsigned long base, unsigned long lanes, int skip)

Nitpick: the skip logic is not needed as of this patch.

> +{
> +	int m;
>  
> -	/* Reset. Every lane is its own master now, so all four count. */
> -	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
> +	for_each_set_bit(m, &lanes, SRDS_LANES) {
> +		if (m == skip)
> +			continue;
>  		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
>  			 RSTCTL_RST_REQ);
>  		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
>  			 RSTCTL_RST_REQ);
>  	}
> +}
> +
> +static int sd1_reset_wait(unsigned long base, unsigned long lanes)
> +{
> +	int m, ret = 0;
>  
> -	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
> +	for_each_set_bit(m, &lanes, SRDS_LANES) {
>  		u32 t, r;
>  
>  		if (poll_clear(SRDS_LNmTRSTCTL(base, m), RSTCTL_RST_REQ) ||
>  		    poll_clear(SRDS_LNmRRSTCTL(base, m), RSTCTL_RST_REQ)) {
>  			printf("lx2160a serdes: LN%c reset did not complete within %d us\n",
> -			       'A' + m, SPLIT_POLL_US);
> +			       'A' + m, SRDS_POLL_US);
>  			ret = -ETIMEDOUT;
>  			continue;
>  		}
> @@ -395,33 +398,138 @@ int lx2160a_serdes1_split(void)
>  		}
>  	}
>  
> -	if (!srds1_split_state(base)) {
> -		printf("lx2160a serdes: split did not take (PCCD=%08x PCCE=%08x)\n",
> -		       in_le32((void __iomem *)SRDS_PCCD(base)),
> -		       in_le32((void __iomem *)SRDS_PCCE(base)));
> -		return -EIO;
> +	return ret;
> +}
> +
> +static int sd1_enter_100g4x25g(unsigned long base)
> +{
> +	unsigned long lanes = SD1_LNE_LNH;
> +	int m, ret, err;
> +
> +	ret = sd1_halt_port(base, lanes);
> +	if (ret == -EINVAL)
> +		return ret;
> +
> +	/*
> +	 * Reconfigure while halted: four 1-lane ports instead of one
> +	 * 4-lane port. Everything else about the lane is unchanged.
> +	 */
> +	for_each_set_bit(m, &lanes, SRDS_LANES)
> +		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), SPLIT_GCR0);
> +
> +	/* Re-point the protocol converters. */
> +	out_le32((void __iomem *)SRDS_PCCE(base), SPLIT_PCCE);
> +	out_le32((void __iomem *)SRDS_PCCD(base), SPLIT_PCCD);
> +
> +	/* Reset. Every lane is its own master now, so all four count. */
> +	sd1_reset_req(base, lanes, -1);
> +	err = sd1_reset_wait(base, lanes);
> +
> +	return err ? err : ret;
> +}
> +
> +static const struct sd1_mode sd1_modes[] = {
> +	{
> +		.name = "2x100g",
> +		.desc = "2x 100GE",
> +		.is_active = sd1_is_2x100g,
> +	},
> +	{
> +		.name = "100g4x25g",
> +		.desc = "1x 100GE + 4x 25G",
> +		.from = "2x100g",
> +		.is_active = sd1_is_100g4x25g,
> +		.enter = sd1_enter_100g4x25g,
> +	},
> +};
> +
> +static const struct sd1_mode *sd1_mode_find(const char *name)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sd1_modes); i++)
> +		if (!strcmp(sd1_modes[i].name, name))
> +			return &sd1_modes[i];
> +
> +	return NULL;
> +}
> +
> +static void sd1_print_pcc(unsigned long base)
> +{
> +	printf("PCCC=%08x PCCD=%08x PCCE=%08x",
> +	       in_le32((void __iomem *)SRDS_PCCC(base)),
> +	       in_le32((void __iomem *)SRDS_PCCD(base)),
> +	       in_le32((void __iomem *)SRDS_PCCE(base)));
> +}
> +
> +/* Put SD1 in @mode, for serdes1:@target */
> +static int sd1_enter(const struct sd1_mode *mode,
> +		     const struct sd1_mode *target, int depth)

This recursive sd1_enter() also deserves its own change. It's a bit
strange to pack it together with a change titled "set SD1 with a table",
when it permits the code to do something which it couldn't do before:
change SerDes protocols between A and B hop by hop, as long as there
exists a chain of intermediary states which is at most ARRAY_SIZE(sd1_modes)
nodes deep. Interesting idea for sure, but it isn't going to have the
proper review if it's buried so deep as it is now.

> +{
> +	unsigned long base = srds_base(FSL_SRDS_1);
> +	const struct sd1_mode *from;
> +	int ret;
> +
> +	if (mode->is_active(base))
> +		return 0;
> +
> +	if (!mode->enter) {
> +		printf("lx2160a serdes: serdes1:%s needs SD1 to be %s, it is not (",
> +		       target->name, mode->desc);
> +		sd1_print_pcc(base);
> +		printf("), refusing\n");
> +		return -EINVAL;
> +	}
> +
> +	from = sd1_mode_find(mode->from);
> +	if (!from || depth >= ARRAY_SIZE(sd1_modes))
> +		return -EINVAL;
> +
> +	ret = sd1_enter(from, target, depth + 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = mode->enter(base);
> +	if (!mode->is_active(base)) {
> +		printf("lx2160a serdes: SD1 is not %s (", mode->desc);
> +		sd1_print_pcc(base);
> +		printf("), stopping\n");
> +		return ret ? ret : -EIO;
>  	}
>  
> -	printf("lx2160a serdes: SD1 100GE.1 split into 4x 25G%s\n",
> +	printf("lx2160a serdes: SD1 now %s%s\n", mode->desc,
>  	       ret ? " (with warnings above)" : "");
>  
> -	return ret;
> +	return 0;
>  }
