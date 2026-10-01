Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5BECA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 15:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6908C60897;
	Thu,  1 Oct 2026 15:25:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ror1cuh9GBwz; Thu,  1 Oct 2026 15:25:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B65E660A41
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790868330;
	b=QRycUJiDN1cZ2mbg8g210r9Jb/7yg5VjIx2s1O7YrmdBvpa5WyyyluIKkRwk1h7EfcVr
	 D/3kDeze6t/NaQU5+j5odKYEOgp+hx2z52W5HdXwWND1DyWv8WqGTFDQxxTyLbxrdsoSO
	 XT1FUGTC/rxkWTe/qPlyeNSVzWkRDsCkekWyZR80krfLHcsJdbQCDS2nucqDWUvLIeUxv
	 mHrjUd2MMmsHJ8SVjB/rWIZrs/QniE4forQz0VXmRtnUc1F1I60PkZZmJJbMINnfh65Ki
	 LSPsGvLOMV3wgWRQo559uNzHGstfqWSRKeNKdwonS9MpL+B0yzJbuoPu4M1dnzh2WBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790868330;
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
	bh=tF5gzfQcOSXHj7gW2Hu9VSl0Cj4Cp9v13dF35oPOrGc=;
	b=iM3Gj5B0+oRssoAW5nVApdXX7+IMLCPmBkkD7gquLoWvSRgf30u5+kXVNA/mP1BugMNZ
	 mu5KFXLUYoEPJxzcqYwjiX/eWcXEgC3er+B7GbgK3lE5jxCCGOfPsjRaCb2H4zWm6n5w3
	 7JMusJPnIzYPKgk2aAPrf7hsyzJwWARbkKFfnPdkASR1jBSId8rwHSfSqjdPKHg1FcGVq
	 ANjfhkKDBfLM0bsCz8CUcG3PibGCaa1tOgzqm8MpvlrSIg2Txs9eOQMLyMEy10WmtFVQK
	 6uv9Z81aVzZamWIBoYy1xC6bVv5o0tWqWvO4Gm9yGn3B2jmDxuFiLWbs/v2gpNhUWUw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZIzfyxba;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790868330;
	bh=tF5gzfQcOSXHj7gW2Hu9VSl0Cj4Cp9v13dF35oPOrGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QNLEMDTtzM/pe1qPUkL0CH7FrZck0kk6/am1NxjBY5cojChuSRkDxsa/m54rIhiul
	 znsxotSSxTC9Wa9in+W1ck33VbsvfsWK0FbP4OzZSsXOcTn5Wb3HDvXULqnojdDdIs
	 XJcpgJLq4BdNv3JT5Sot/npI9JSF3G70u0bemgLBi01YqoK+75CpI9IyeKuA6gsSHc
	 3ghB9bE9pua+qUncUl9mroN0LWd/PB/vx4FZ2ldQfx8E+OpmFPTpMO8udY5x7guytf
	 cOeR4a1ofjedTJ8AKD8QkupU+iHb/I/C3uNRGUzRYafHcyf0Li4EA8yKdOsYofL4kO
	 T6t5QdwcXlJ0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B65E660A41;
	Thu,  1 Oct 2026 15:25:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 602043D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51A5660897
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:25:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jProj5GCzzyL for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 15:25:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6386560868
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790868328;
 b=IKXx6s49a+FZz0Nzhnt/EX62BREhAiLu7W+6sGOTPvLvScQ3MtLtwabdEXWsxSebG9RM
 xOW/R3TKhqf/crjIS2Fc8TD8en5YvrjfJlavYv4yd4/kc4jDGX0Z2YUtZoovK++wbLHN1
 jNaAWnfDxDWGUXpnM4j9PnYU3NI/TAnRTFYQzGUtbnpx37SrZU3kWCQZIyN6vxEXHZMgW
 mpATo9S3fgpsrT1+AwFAEc1fwgp/ybYRAG7O+NZS8quWYBWq7z3qm+PAG7oH9dQuFV9LB
 XTixX0g3URtp+r1to927/bhMBJokk5BaQb9qoHCz7G5VxvdgD1lTvoS6OrMny4sTBqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790868328;
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
 bh=tF5gzfQcOSXHj7gW2Hu9VSl0Cj4Cp9v13dF35oPOrGc=;
 b=hEmurYNzW0QxhAUQbhj9NKHUojFVYwrsD75cs7YNmCxA61rqBaZkn+4OnEq5GIhgPk5P
 UAZOY46b4Ce6DT3x4q27nKPcEPQKPWA9sjFQqwKL5vnV3aVxzboS+zUSuBql2HpTVYll0
 z67hLIkXEIqPCMcZAE2f5xJFMC51IEVQABrQg2iFvLjv2jY9pvuGxbDpPrphofI8rbINX
 c8oLJ5JaZnMOPiKsALsMMoqtR/4TPd4HYgyjvyjnTzLPyKF0ioPe86wYI/uiYFp+EQDqo
 a99XmKtz0d48fFtS/trn72WyWjNUg+4CZ54R98BMEVWC+ybtW+v9PmyPDqC/1fddoVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=ZIzfyxba; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=ZIzfyxba
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6386560868
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNVUao/LsZSh3KBgCVJiULD/da64ho5kageC6KNPYwuQByKaARKaDfrEBfgMb6hBnCC2O8K+i9wI/LoMfud45eI1VznMUmLlNVSYqoqX7Kk7RKZzfS2FF7AQQNTbCulN4DotGyQEWcVShAW3maakr33l6HYpa5Y9AXml9XjD7eB9TJjYAjU9bYjMDXjJENVisCNcpuKDdnv63ca6wCLN1+ODagcrCh0VkFtrqCDfPpyutH0b6klwONccskrf5PkwZKw85JRiqjZZoWMTKBek8iHmizzl3AMKpG5pf5Ve5fIrHBGrVsppfYAH6UVccHPotBL/sIjnoaHpTCfFr/3wKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF5gzfQcOSXHj7gW2Hu9VSl0Cj4Cp9v13dF35oPOrGc=;
 b=VegSpkUWtzbicNUlIJ1ly6wAU6+Gj1f27dn+AI7WDMfo3cEqxvBgbyWwKB7QrkSU+IlBu0zpsGNe8/P/iyhBOTlSatf9mETKW86/cALa9tS7u/G9kF0vNMAj1CxGzmXd/EfRC4HsuE7kgwsFZUn7QZuHArHSdWDlfmNH6uML6iTzpFJqCT77RY78lxWtU545U1bqQHo1kczDF4W22BfRRirel+p2JMSYURwpHiKrbMk6KqSZiDjRU0xxKp352uareXL6LHvYT0tTQYpin/RWaEHlu5nEWQd8B/MCkR0aRoFnxgW+zOIqCrWCNv2RNtdxaxhfFhIDuxYNbbI1cXSEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF5gzfQcOSXHj7gW2Hu9VSl0Cj4Cp9v13dF35oPOrGc=;
 b=ZIzfyxbaYQ4CFCQJ37njLLHoLrtlki5NYvzu0HpteXF3NFFThzz3UWJLAQid1tB5KdkD1c7Lu9+pNIekFGH+wdklI84Hki0kPb/06gA0Z2Gtg+2jqumwXbwZwtf6DBOjQOAPWhRv2b2V6fThWebwhkAcx78ac9pbOnSU69giD1n4LZUbaUTtGYGBFVKRpxLQqB06UfmtQqkOE4Ek2aEOb+7sUckjoQ7pglD9AwbNcHBTV5AD7RyJjQZBHUJMNVL5VNmUSFWyduchnpD+3uuQUX3vtuJ2+OUhJZ8EbYVAq3IHAMoQTCL51Tpx5SBvzZvBiaQgyGXz8s3kNZpJBt2WPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB12687.eurprd04.prod.outlook.com (2603:10a6:800:346::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 15:25:23 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 15:25:17 +0000
Date: Thu, 1 Oct 2026 18:25:14 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v5 12/13] doc: lx2160a: document the sd1 hwconfig option
Message-ID: <20261001152514.vkcl3mw7gaz67xqo@skbuf>
References: <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-13-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929175947.1379710-13-vjardin@free.fr>
X-ClientProxiedBy: WA1PEPF00005B88.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::636) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB12687:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b1191b-152e-476b-1333-08df1fd032b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|23010399003|10070799003|366016|11063799006|4143699003|3023799007|10067099003|260925022911599003|260925021311599003|56012099006|5023799004|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info: wsEvKGrLWD/R/enoWJgGxCxiWFtrXKql1/01ItIgL0aOVSkSjuJNVNIwTygBgHqcAMjSM6Jf9qSnk90V0fwNYuY7Bt2cRG+2smDwNWRFgBDPtuziV79SnT6gO09kJGAGQbcWWaEJ9hemrtCvGAvhJUAM18V1CHjsx2zc6NmYQZ11X1D/nAgQDbn0HuoN6DuDo+/uOOdgNyRthmu9VlEW4JJfcTtPnqc7RDPmu+KH9Sv+y/+jTz3fatg5mInucZ/jyCf/SajdzKbavkLT+9eqzInT6OioLQkmaKCtuiec/SdWEraCm1CQ+rT48VXpH9zTVkJoH62gXV2GiAKjq2h1XaAwECf1Jxrp9NugYras3OQ6vfme8s8OpLCzkGApB7z8fDf8yrmAfsHIxcrFIxcvwtz7UanZLjLL4bg9kxbI8VKRgPENdPWj5ix0QbBYs9chpcM/HeGtLp2EVFP766q2i3BA1cwvb5jwe4LsfMkA5i5sHPnFG1aAu8eLxjSnwriTZZWrFGYGBEC0ltCryO9iyO1BHI32pklMW5fv5xbkNkyurf8xo/DIHaYCcrsmjZVGhSNpbiEl16Jg1c9iHfaP/Wsxd3QqRq2EblWBzi+HCjg4Sq9KRBHWZhIC33H89mcC8/26k9bKvLF1N1i8ypAglKuh8HUqBo3f+n/KTBr0D9gVgHBbFBlgWtu9P5zK5BAOy6P2ysYAe/+iOadu/gGxxVhmRGqbO5FynOKUMxkvW28=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(10070799003)(366016)(11063799006)(4143699003)(3023799007)(10067099003)(260925022911599003)(260925021311599003)(56012099006)(5023799004)(22082099003)(18002099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAw3Z7SrRq6GRIxbUZc3t5suhNal2NU1xC3pJ1N/DCw0erDtc2hSwpQ5mYfT?=
 =?us-ascii?Q?mj4HAJAwXL586109MngBY3WhOn5bkZAT+LWB3pWlPMoxe6QmInGc4NSj2o/S?=
 =?us-ascii?Q?dd8Tfk9+Lrc4Ys8rGoq2rECIaKV+P4c0rKIkiSPtRe3qtGRr6vUvf6qS6J7E?=
 =?us-ascii?Q?nP0K2SIYHKXvfKr7bRHfSTa4xtGSC03nW+MAKOzr3jUolwuraK0FexMi84U6?=
 =?us-ascii?Q?oCCEVB8RMEL7gw0/GtzPN1aqDwMCrroFxsf15XTO31osrzz/cjKXPXiyWEr1?=
 =?us-ascii?Q?51pa0VsmTg/OaljIgpN2tArQQj7tZRrP9aKPW5XFovuolvN0HqMvw7obgmti?=
 =?us-ascii?Q?XPCjDzmwT5fpHbULF6xrSsVHKNVnc6B4E7xksQrSbY4BSeOdstTWAbD8Hth/?=
 =?us-ascii?Q?RwvZ0Zd/ee1K03yIqKwYuK8Qw5zO59zysdt684Qka9lwwpWpWJ0NNSSc5hmv?=
 =?us-ascii?Q?jqjKt42gleKNkZboSTqSIUndv4/1mtAsqktTT92WVPev0ZnRjUZzbLMvVNqk?=
 =?us-ascii?Q?OcT9PVw6ozpeOdREAQQpyAQ+m4lljJsETyWnealxulw90zgyHRxhYB8COdto?=
 =?us-ascii?Q?N/vwQHvOD3Ud8aGhUxRpq29UQV7hx5JuV3PlAJkEiCQnRiAu5piEdhAHG60U?=
 =?us-ascii?Q?FDKCzoCT920aHBc4z00ExuednirC9ZoAI/O5235hxZwewJoxwJE7Rl1Uw6Sf?=
 =?us-ascii?Q?Iw/epl8V9MF7OpXmIw35IhZl+fFTOBQeBvKgLtyWyWuiJwXIE3dvdlRujxIW?=
 =?us-ascii?Q?da0T4Gef+0dal43mR5nVJcpRhd8HN2ggx7DAT6cuGhUFpQZG5pHXWBtBNPHs?=
 =?us-ascii?Q?5WHaT/h+P6wZ5B4kLlVlK4THY1HVKWTxoNvXFcEpeItSn6ZKQjBfz/4mRzJv?=
 =?us-ascii?Q?TJyNuPkrIsLgLBctSTbcKhuBv+VSBOy4kZSTH3nR/uoSd0T5zjLm5TPaLW1z?=
 =?us-ascii?Q?abonTovL6xz/N5ZLhxsP/0rZSO64iXyMTkKdI7bVYMuF25rwgiwsVmLJkRfE?=
 =?us-ascii?Q?Eg4PFkz18FPVCFJMeIIi6hRYDQ0seiWP1AMjyRAorM1AGGgB2RCZX4/c5sCc?=
 =?us-ascii?Q?mbZm4a5P1sm5ML3BUtVy2NtyzmgBTFqPyKxggVbusOc7OSP7fPO91xmexMlA?=
 =?us-ascii?Q?7gf8nFx5nBvULGxM9wmpL+AS0oPrLS345zXv9INI2xkmIBkSpxV+OJOvnjEJ?=
 =?us-ascii?Q?HThVeSLboR+BuPre+6AKgi0JUlcXPiDHXvRKe9oBITJxWvDVJMpbf+P/3kRo?=
 =?us-ascii?Q?kPrkzY2pvmK1kCkalct1oJYNhZMRJ1URObLqAYrNEtDR1AaY/J2KXig0E02G?=
 =?us-ascii?Q?1wx2PyybD0qq8U3pW3A9ofXGd6UPfSWzdWf0U0KgH32w+8/ayFYCLKyEMc8L?=
 =?us-ascii?Q?jmSh0dFkgE7HkJOAfvIcBW9S5REeEj4uPTus43yCDcp4fEfAE2IBBOTEQhid?=
 =?us-ascii?Q?+CQDOmmGyWRX/B99q6u/Nn2PfCjU0SgY00Fck5uukZYADtYObxul5DwqSTjm?=
 =?us-ascii?Q?7YFq74wwbCR3gI4ZiQu+dwMtmAfnmu0BLovoQ1qo2kovk5wajgqXAqD8/PST?=
 =?us-ascii?Q?Jk7Q8KSbfRXSOayICrqoA5jgSUtHg+jRxKWz2sfMSyOJbOAYmmIcBhbaYGcb?=
 =?us-ascii?Q?K7mKNqzTdbgjNh58H+fLrLAmC7cKL9NDrAKbtCUx47TcSCYSHn9FpKCo8aIM?=
 =?us-ascii?Q?4pD2jMxt0P9UAxa9rVXqNwKAj/bBEsqJiV8B85ZirRV3ZZ1TEe8Wh9ACzdK5?=
 =?us-ascii?Q?zfhHJfRM1RCRlEjmusqq1F/9Em7ImmyyXHHszNbPLQY3uoRA8hUJh94rOobw?=
X-MS-Exchange-AntiSpam-MessageData-1: diau9bKP7mvuoO0Eslm1EXdatrPIdC0CbdE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b1191b-152e-476b-1333-08df1fd032b2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:25:17.5672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7/64wgx3GVoXrzcXgPqnqsJsxTvgGbDrlop5/DvOytvgm4fGXvR74ROedKgumJrmqgs+cV6uOs/i+fvE6Tx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12687
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

On Tue, Sep 29, 2026 at 07:59:44PM +0200, Vincent Jardin wrote:
> +	Initial conditions:
> +
> +	- PLLS must be fed a reference clock from which the 10.3125 GHz
> +	  clock net can be derived: 161.1328125 MHz, which 2x40g,
> +	  40g4x10g and 100g4x10g program PLLS for. Protocol 13 keeps PLLS
> +	  powered down, so nothing checks that clock before these modes
> +	  power it up: the board has to provide it.

Same comments as for patch 8, really. "A reference clock from which
10.3125 GHz clock net can be derived" sounds like it includes 156.25 MHz
too, but the code is hardcoded for 161.1328125 MHz. I had to go look at
the code to check, so I don't think it's sufficiently clear for a README
yet.

(I know it was my suggestion to phrase this way, but in v4 I didn't yet
have a full overview of the assumptions you are making in the code)
