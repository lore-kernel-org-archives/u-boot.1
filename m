Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD4CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 11:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD87680D13;
	Mon, 28 Sep 2026 11:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KHw7nU1opiRX; Mon, 28 Sep 2026 11:18:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 13BE880C12
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790594325;
	b=oyLeEfnWM5sf8JKCfpt+0SoWu/xCl/1fGmgzo4Ztj3mI3750PyM15ytsPX+p5BIGWAXm
	 WIcvaQ9IWdQJuS84jDgwsCLohwDdlCcTvh8rLVsQ170/i/uFCSyw4IIAcaDIVZCTKms2z
	 ayAftJncUw+43WgF7rcvRL3R1yjEq3OLC2wSJK5f1+Azok3LIMvx575yKE15yCuwAkh6J
	 +R045WaWMiAXo/+P47lj/I8coZwLurwnowxJsLsZDOMRYdMSjYnvuqAfLnU4gEj9dahlY
	 C9AvUwOrHsJ5t3QvcvakEKSuvtKrppiRqEzg/6F+/l47LxAPxB3XSwbBJ4r97OtI2Rg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790594325;
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
	bh=2ngrsMgzhgaQiPEvvXNowbZb1iArZOPMnBcLWjC0nBg=;
	b=QrQndFBNgMJu7BtE6G7XWbC0xYSgv1GXUMavEkVzALYXmv6795rK/KeUdgYFp7YmypBX
	 jtvvGPunatEyAE0j6Bon4WhOy/Je35vWx1CbyIYaH2hd8A2KFruqh7PCO+qzgwivZwO1o
	 VyD7CzQ5f2EM+OWw88suxCgJCcE74uy3J6kHxSwhKeb+K9BLmQ5bO/Rg86BTODsepntNs
	 hXwkoum3HgruFANcPS5WGYrKni4hDTGPbi1MNIsk/6qpzUP3dHYNfGg4B4caiMBXdltlD
	 YfCBOEkwr1r5KUo724VfV7vqZ4NA28ECB8TnbWCCA0lgmwtRF5BLKXzGzHrWqheXc7g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jjRGt7s+;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790594325;
	bh=2ngrsMgzhgaQiPEvvXNowbZb1iArZOPMnBcLWjC0nBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fy8lZok8eFTwxukbveO/SztAbtpyQ47OSTIjWpCaZHjKRSnUBwMnWwtjaFMOUjjTl
	 M+Ev8kIJ0qbxBCI2O5+Tk3nMs9kMrVP8pKYXLPlG6r9btGrlRtIO/4n6uB/eccoY4b
	 CyjUr+7WWpzzvnitNmKxqF/RXOv19AhDImMO5yEcaw1rM5u5yqogn0CJeOMsAahaaP
	 SMYdLH/LbyED+ZFUlp/hmGV4ot4mT/VEZhtadrMei+CLpn9c2Z6SGGWGefPdAMY+uY
	 XzqMOuH6tc46Gv1rkq+0P/ruderJ/qnFjcJCiKqevz+k2LgVE3UBQ40kI+al72cE6b
	 bJoJqJ+jNyocA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13BE880C12;
	Mon, 28 Sep 2026 11:18:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CD203D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09A7380C25
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ybtj9PemIXyc for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:18:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 307D780C12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790594323;
 b=kWSATLQ2efbvCzI6PuY9cxp//5q//1qEeBR2uZLliOXDKnDX8I90Z8sjC6xGV34uNFMG
 6wZdaYuz9/5cqd3afhAw2PvgthRMlf1VstirwNC7RSfxyq/RwgwthFNULcqmUV8Kkv0gf
 WO5pVxpYQ7RTZTPP33w0Tjfy24nWewI/t/WlLB8K8LKIinRtkMG9fEME3pB8iSCK7sjr4
 h+NaPt9kBFeQvU2XcWrWmvPtbS3T4ikNEEL66J1GyRqkukqxuIoUWcnKUCP1OQczDURqZ
 fk6k81BIHFVzUqgEBoz/QbfTvimZZLVRKAAu7wGkmjPqllBNlnViYgx/XwqXVZgrMPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790594323;
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
 bh=2ngrsMgzhgaQiPEvvXNowbZb1iArZOPMnBcLWjC0nBg=;
 b=BeL0NFI9mJqUg/y9O+XikGhO26LT98Rn2JueKU9azgc0YQkAfysnpp/oSQ1Inf8NXPgx
 kjIxoUF8mlD8Y2VMcDlYn8jthggQr2h3Ll0Ck3mOFCaN2nlZM3K+vErIgZLGLaHR4e6CP
 ySp5i/f3nkmGcHrW/eP60NP0hZBmL+0nGm9hhzNtgv2cER7h5VKjH9owlRtSk28517afp
 uYLfl0RTQM93zOQCy5L9HzN8l+h8uO39a8p+9YDxVeGZxgeJ+7kI+KxNPDch97YfaOA44
 qBh1kptoZXm0jiJvfUcslq0YkksRPPC4v1toaqPnE2PkEe6T53kV8ae57e6QwLtMkxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=jjRGt7s+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=jjRGt7s+
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 307D780C12
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8zFgaCPkpwUYroumG8vUEPP0W4526qDJNEaOXzACDtrwtF/R4JSKXrf9yv7sYQKF0PNKUelMfyP/ZZ6X6BVA8GHjLTPoCGZWjCODk7/E58qwki5g3VybUnJBOtULstNJEWE9JoJ/I4fH6V+4k5dQnyl1iGGCHiJr7Qcj5SKQQcgcdnAQqW5Q0Tg4OgX4DY8XAuJ2IB+Hr3905oDaSX8UxcWRxlR9atx4E3CBSyRnnAHw5yPkcNIlltjaoLuve2g6rwZQphOKTudd4cXWb1r9sAEnPEK3pyse0k3WD5RZLjMjBI9xfFAxT6RXUaeHw4H+Pn/CEZKW0Sg59odvNopKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ngrsMgzhgaQiPEvvXNowbZb1iArZOPMnBcLWjC0nBg=;
 b=WZkMl2uGokzCMsgoUNWKNdzsSEvbkGsFO2gv6isg+Hfl9kKpZtfZRb7rqQ3ZNXN+lUtoiuxLmY1NQteKEmXJA4YdXiJGeiqSPu9/M9D03Y1tfBTar11iwdkycdIPzOP0V1DbWn96/ocKZgyUoIBlSYFr9Lsbgs7NZ83wV2thAZfHha7qjGpL/tuPygnq29QrdRzh9L9mAAEOMG4Y20RbznJAkwmiTwXefL+D2DqLFrUyk3WwhJ9f88CIWAqsKAS9W+unRss1P7moQncmugrZtIlPwoR5QlDm9GoaigAqtikylDL0C6TlEJWgZjn4r3rGfkE7NlNHqASxR1Tajak5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ngrsMgzhgaQiPEvvXNowbZb1iArZOPMnBcLWjC0nBg=;
 b=jjRGt7s+gkM/GfPdKefuFV5kl4y0Pzuap8/Znc4MAqk63oMEmy8U3YcqtSsEglagHiGKSpJJzCkeo/jXIMPBkuZNu9c4+Aoilf7aHOQKiDevrHZ6Aph4rVUp9mD8MOfO1n8T7J/2Q2YCk9uGN7ZoOIQ0aDdJm7naWss4czEeia4bp0w2tirxGhvtf8fX5XaRwApST33bDGQriNymQWgeDAs3iSEQcvj79kDcRSYVs5Xk402/awOYvDO9+iXZN5n4BwdnuLPQOnaiFTAvrPMpn6PenFM+4sfbc9Svl+EgK0tuATYpL2snrxoSXXjT3mzvTMEHKcVFo6SVdUztTOEcnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:18:38 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:18:37 +0000
Date: Mon, 28 Sep 2026 14:18:35 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 02/10] board: lx2160a: serdes: rename serdes1:split to
 serdes1:100g4x25g
Message-ID: <20260928111835.4dnd3ud6f4vlbbmz@skbuf>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-3-vjardin@free.fr>
 <20260928101330.881662-3-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928101330.881662-3-vjardin@free.fr>
 <20260928101330.881662-3-vjardin@free.fr>
X-ClientProxiedBy: VIVP296CA0034.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:356::10) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb658cf-3211-46da-03f2-08df1d523e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|10070799003|376014|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: DzO89YgsvX+C22S+jeiMESIj7bPMgzuz3VD9hK/2kpd9sYowIZHGromUmXOI/he/a7GBz0RKgSi1JLkKUiEkdx7DcJRY7nH/NaoH76kNbSBi+ZNHaa47G+CoU+pZKrLUVGU6ehSqquEw8oiblAliCyTWBR8aRqu+bkL2Qy2tjo5uFlOdqffpMpNNdn1uhzBTTrvfMulleJaJfyTNKbh2Bs9VElQN7QjEL1qATp6VSl/T2zH4UR7OlLw2RERz+/Z++KXmLcYEm5qRPFvKsQLmBjG9o5MGM7/kEv8JCTbInNkcXVXx22ND5lUixYgniEwJpQcEDFerfPWrPacYmCUaoslcuXShc2cSROeezXS4B+9w/MgysovlB8pDQUq86xK0GTl1FO6hlLBA3kxgQkIJT8LK7gZOl0N/bXg4axm6XcL+8RszJUxsOkWsyD+Y3IjrcBcDdYBXFmWJfQkFKmgEdVXZIKcqfbxDNkJJzFw2+I5l6nFnkgcLbmyEmIr0K1ff+poBT7Hjywp7EYMjKUXp42HgrJOhAFm3EPkBYKl6UV9ePfk/b5wYbAIaNE5LH6ddUu1pAPYmyVraiv3emNQ971pL/q5cohgMJeBQkBRfwydNovgnhEs6kAOHRvhgz80sU1enBH3nEMcuCkRviDmwLyAmLaXZgNuCSFgNow2UeXgTE4KHSU41asHU/MPfh9nuE1jCTp16WrLeQPTZHBkumQ69iLx230pTVD2weftSAAG+ymhjQYd/uNzQI3j2J4UV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(10070799003)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?elxzGEMTEDVWYMRfhC2cYiWxRf3bEuZ8fqZ7306XmFNfLjpGdT6LIVDQGn/9?=
 =?us-ascii?Q?srMucy3GX7HdEVXwdqSGUpTJGnOiE8okSzAFIMtn4uPuJMNKj79Bgf0OM/Rx?=
 =?us-ascii?Q?b17hpksjmb5tP/upItpi5aBylfLV77jOCgkpNyYzYDJE2hBfNmBjTtHOS/DI?=
 =?us-ascii?Q?PaTa3cwBfecnGmoEoPU172uhtXpXM10f6JVoSFKsaBt4HL97lkSFFmXv7S8z?=
 =?us-ascii?Q?IsNuKzBHUrGR1fuxaaUIdveFAjefGl9iqlkLBOqAnmH/gYPoYfo7w4af8e66?=
 =?us-ascii?Q?GngUtWLZmgyTuvrj1EwDx2SMFP+yXJuDszsItFbYbcgxLa/G0IJcW0XQQL/6?=
 =?us-ascii?Q?FkG/66MEq+Fs5wDAye4FWZzg+Ce4lp4lbrjgLbSmnGD0mLCmiluJs7T4t1Yd?=
 =?us-ascii?Q?l64HvSRhgX8W9Q5jyfSX/XquoyM1kNTgUtrVwD9uv4vBY5j7ZJRSDBuEzTiH?=
 =?us-ascii?Q?y16ZsSRFuIL/3332v68ZkmY2bgeVSCPTA+t2qEnrj0wPdmyJYFpolbliUhoW?=
 =?us-ascii?Q?6issechRmpl0kYTmT+vHuKjKhgjQv3zOMn10r5AaLnHFjdF92FI1rDy6gAqH?=
 =?us-ascii?Q?9Y8hgpK4btV1u5EMP8uJc+ozGcptEWFKjylTttKBiAaKqOwwQZ//0fuBw6FE?=
 =?us-ascii?Q?dvN7vKaU3GktmB8//y2ud+gI37m2zRABZUj8pnTDzTbLL5TbyRsxJdU3E721?=
 =?us-ascii?Q?fB+AHgM7pJC3PVV3IVwVBdctz+n1h8i3NT0FU1Zgv2CqNHN1zekpJ+8AaTxU?=
 =?us-ascii?Q?bmzyWj48kWAENfF7wHdR2DfnmcpWLb1SD3ANcno2LfrjPPJqku6v0hRYuN1c?=
 =?us-ascii?Q?xoK19mD1aDx7M5JY65xBfxraq6XEW1Zeun2WAIbEn8QVDeqPaVFVN9LSs1vI?=
 =?us-ascii?Q?Rbe0SkRaM/dP0xAaw4iUVEzSjmF0LLH5GEx/YPtXefZqRXF5RWe2h2VuuYBK?=
 =?us-ascii?Q?z+9lx4uP4bTbPdcXO7bdCRqUHCDrocIYGYgxSOAA0V5uw3ex3fvEb3U5s+zF?=
 =?us-ascii?Q?4X5wko6ZvL6TUmA1GqYDLZieDk5MEq0wMXVYdzQix+yaqzeSL/SxjtVQxwPn?=
 =?us-ascii?Q?m1yYbj1e1FiZl9PTnN8R+NAHaxvClWHBq+h3Q/ZkZQFCHkXa2Ed+lMfDuag0?=
 =?us-ascii?Q?tnw+vP8e2gNVc6q8XJ3zV0qDQT5sguB6Gfeqa53qA7sz1LaZA76UZxJdeGth?=
 =?us-ascii?Q?urs40suAyYsqo9WSDmMSyLGKCzg3Gh2GuU84QSetzZs1B1MXZ+WJAwgDdGF+?=
 =?us-ascii?Q?jjEaxEdWoj5f6iA6FiJ0bi1KbbmFREhw+zc8vYueMtVqtNegFVEy3Sheczxs?=
 =?us-ascii?Q?N2zyoIalayo56nCGZWJXP/qW9psMTu9Sx7YRSHqo+TqKwmsk9sOWr58Z/NOm?=
 =?us-ascii?Q?4tXMCD488ai9DSt3DWj4KlAbvQVrzZozJkKczjcIuViEgCkpZjyc/H6aLq/H?=
 =?us-ascii?Q?spRBcO4jqhVV6wYzYuWWXYF9qUbcvRjkKXIfJbwHd2RRp69OPy+MWgvhmQHP?=
 =?us-ascii?Q?PDf0XhbZtIDLnDDIDTrjdoS0eJPmw07LzULm6t6wRUftZUps5uco4ErRfh1D?=
 =?us-ascii?Q?IUzdPsBdevdqz5ZvVcOjLsS7P47eT7NnExQ3WY4zBjuJw+chZFUzisUEOcTX?=
 =?us-ascii?Q?ouTe/I1uSkwllrKjDk4QmCLyIr3xW6ufLKPwQvRccrYSJ5lk2qKCle+kjPnP?=
 =?us-ascii?Q?KUaT4bBJzZ2OmJNkfWr1o+FofhNsouXK5aUJGaLefqjjkmDu252loZy1N6wr?=
 =?us-ascii?Q?4Te0vWkawVu6p+2fQzmhb9mA0WR5c1agLhgvcYOLnikG9m8Gb7PbPjv+WcBx?=
X-MS-Exchange-AntiSpam-MessageData-1: nRlaZg8rwlhq5pTdTEKTDcq8SggbGhr6H94=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb658cf-3211-46da-03f2-08df1d523e2d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:18:37.9226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pam3LlNkoLlm7S/l34tbrisMIcujT7SXvNBx7dsi3BxlCMQJePxkg197vaFQYe/SadILIMM+H0nq46Emr+jhFQ==
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

On Mon, Sep 28, 2026 at 12:13:21PM +0200, Vincent Jardin wrote:
> The following patches will be adding other cases for SD1 lanes:
>   2x 40GE, 1x 40GE + 4x 10G and 1x 100GE + 4x 10G.
> 
> So "split" is not longer meaningfull.

Nitpick: meaningful

> 
> Let's name each hwconfig value based on the SD1's lanes settings:
>   1x 100GE + 4x 25G.
> 
> note: serdes1:split has only been in next, never in a release, so
> we should not need a compatibility alias.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---
> 
> Changes in v4:
> - New patch

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
