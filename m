Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02CBC98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 898FD81309;
	Fri, 25 Sep 2026 14:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MXIZXyUCvpri; Fri, 25 Sep 2026 14:09:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D3A308130B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790345399;
	b=SLkLAjoeexzTNOXQk7GmgB2Opl/uMP5VMU7Fvsbh6WjZfxu37jwEDXyieuG4vkYrJjsW
	 JhhbN3u+tpA3Rh9S+ltNsHA96L24XtEPvk+75kQ2DWCxCBiuF+dtRSkrE5roAw//KNxIe
	 6ZmAQFD4VuG1d+Ig8xrJX/GBFKeajSj+XbAZJ6I4z8LF6rckgdSxxdEA4VFca2VDTDjqv
	 SZUI1kl3eDykddyLJP882PhxNni70c/6frsfb8vG2H0c3g25oK3DYswPkDGtb1O5WNXSO
	 TdwCGNDi4IROzkcvksjV2Nh5UyotTKqWnOuHNUE4gfG711nZzyQnjyfWUZHIFdAWqaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790345399;
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
	bh=RdsXOb3+2au3Tc8q6wM9UUqAqe9pcQ2RoLRPr18O3io=;
	b=nQ0RKeAMolFXXZZYBZ3BYjYT3Zb+YDSqo6HVccZXJIBjLGceckIYx21XcuHWeEcn7D/h
	 D4FshrbxQ9Xx+Min8PMAWIU9QkDckpFD6iJi/kuPosp2p5XRpDgatW0jpWFS/DkLBTyHk
	 IY6Lbn5DRsRVWcD98WZ0wX9tx4Fd06VwblmDWW6Y0M5fCBIeTKZSVAZQMUoJQabRDP3Eb
	 mW0aLhoY4nEJ2qHIya4Y8R5Qx3w00g8TKCpXWYYW0lFYGzUITq11N5Tn5ZqkwmALvv5Vu
	 TPe8JEA+PLag7NIPYYRrMyyWBu4pGMpJiYCEuOjEah5/NLhifRmS3mZkVrl2AWopM0A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790345399;
	bh=RdsXOb3+2au3Tc8q6wM9UUqAqe9pcQ2RoLRPr18O3io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H93bt7SSJSvK4a6N0+7q0qwrz/mJYwMdGQzHzZMyokjDbpJDIsY0L06Bc9EIWu4re
	 GRSwHP9mDaKI/7qHxmDt1uA4VTwd/ZOXO65pWSjQfNWdZJn5nBbkNz85QbustQcwUl
	 IAaoFSOTgT8HmE6GjU/KN84vyyMMPOEBqgfV3GelEsPL87xxWb2kSMRzxTPeZUHc07
	 TH2Tt2XK8wun+l63u0yNvAsUFfFxiAnsDHeznO6+nlFlDi3AHynE9HrAatq5uclBrK
	 2zX45cifM/9mSvYE2H5DUMhjumLpkO6d8yevIerotcmWsLrvWLhr6BciPeXykv3TSz
	 jZabnYIufB42w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3A308130B;
	Fri, 25 Sep 2026 14:09:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DA5C194
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F63A4016B
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5p1ZL8JsUPe for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 14:09:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D6C354005E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790345397;
 b=EucOzrFHUVhnsuiqIX5O0oeAWMoEmR+WiEkGG22z6FySJVHrzl5a89FGPI7uRIQEpurE
 tyrWj7WvBE7KxdVeuJnGeCbh7NEqJR3ee7kQDsoIjH8Q/VMJ4n83XxiBcQz9Gf26SET+C
 7bLsD1PFvh1YdAyMKhFvzrzqC3i97Gs5l4tyHUrmaf7/oDAZyUVdKxW9Nz8avdu8X8GLo
 UqZLYc5de+z8PCr4K1lJkp9+oFSTy1+VQMEaNjYQm7zdz/jwDphyD+Izz7GKx+GoPBZdq
 DfBelNb7Nr2xUNJCrysPbeYOT4NhEAFQntYnL2p9ry/yEr6HQoruV13Wyt4CmIHkGsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790345397;
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
 bh=RdsXOb3+2au3Tc8q6wM9UUqAqe9pcQ2RoLRPr18O3io=;
 b=jVBG0gFPB+teWVBqP6pcV/37HfuW9OhxtEGd/HqrSN5an8EdznFseqh3C/paz7Bwupkz
 Dqcj1/ptwuhINels7wuF0sABzRAarMYcpeiNm7yyxpWC20B0wWkyCYdt6NygQYEcaQpS9
 nGl5znz2PciRbk6xOeCw2mDFCFPcfZGFZXqVxJ2P0NveLBBdFL/VkqdwRCtzlVT0iRoxB
 RrfejNLd986EkOLAQZ3wB7vVSH+lg1xV/2Z3qbsx3/xy0AHnAWTD6nf6enrBE9Tio2fuX
 8UkLBmfgnzwko4aJjPb4u1jonHzQUWi/VOd0Fn3tTuda+HMEDJat0u5H3oqsPYp1n+Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=g1E9erJu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=g1E9erJu
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6C354005E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGX4WqlXJiwSMqTmj7YxVOZdYFmhIevnifmKV2JHiGJZD8hgdNwVr1Acn27Ed5FbVlllPbu26gMjsWdxCMYRqgZugMfgazQhFzHqO6KwKSZP9r4eYF2ahZNIiOMK6H5Us0nRMRU8zHrdXA3wNsIRYtSUYW4obkXfuU453sQnLvEc7ugIWchuPtrTNZ7P0VVP17oYA7q7vKJandNbGlxNW1/iJVKD0hNm6bDlrAH5FZvg/keXetpUHkN0uDmJVaYvB63HNL+ksVcfNgKUVI7wNxK1wmGKY85rbjXKbQ91+YuK9QXm8d3ICkXhu4z2ZxQ0UMc2AgwfWkxXqJ2UDHd85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdsXOb3+2au3Tc8q6wM9UUqAqe9pcQ2RoLRPr18O3io=;
 b=D624EXltgSg712B2YCmfPRb3OJL93m1S/7o6L9ymXqjYJ0Ik/RWswCSpVjzf73WV/kuq0CP6pS8/mievcalLT/HBhRNyymZQuOwnrfZpeCzbCopN5sfFQkkvacoue/8XOZ0yNIqr2vLmW8qJdYHzBzwFfOvf0hTzlw8fKfD5SgRBGi7sd12GG1Mrl/87KwRsYdcTgcz2fus0XladdHWSb0BFqWRVzUpxxsijPo5zw+CLBgXjn0jTF66Xj8uP91KClcVvKEFhCOuh4nX5HH3AKbpg3jE/3epsD5nl6wppKQToVdaw5MhkKsrG4ICsRKKZW1oHjprApMUpdpGuPknT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdsXOb3+2au3Tc8q6wM9UUqAqe9pcQ2RoLRPr18O3io=;
 b=g1E9erJuFGNfqc8C1kbHzjAswyVTb/bkQtWA4CLYrERpC9EewSvWcLGKAlWWCvUgUj4fUnuoyIzQ0u2UBM9AEbftEfkGuRexRB0FO99YrwonDeWcpK9GQDSB9SNosMqp5QLefLI2SMbA/RiShBLgDBXs4gsvlx5aOSUQJB7F27UykHClhtnFzNHW8PFnPEBKvE9BM36ZXnrTo0Gx9/9DUeu3ouptBYo9UcFxr2c6N35yG+lflPIiro01wDZI+WxXQlhtRIrnSdxB4R5lNBIwa67nLeQ3FytDB9ZjXanccGO2EUog9CQMJN3MJ18RrYHTlJWG0uA6TEw6KoHbnv9UoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM0PR04MB238523.eurprd04.prod.outlook.com (2603:10a6:20b:7f9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:09:52 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:09:52 +0000
Date: Fri, 25 Sep 2026 17:09:49 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v3 1/5] board: lx2160a: lx2160_serdes to lx2160_sd1 and
 lx2160_serdes
Message-ID: <20260925140949.yeaukfrv6copdjiy@skbuf>
References: <20260916211549.3432913-1-vjardin@free.fr>
 <20260916211549.3432913-2-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916211549.3432913-2-vjardin@free.fr>
X-ClientProxiedBy: VIVP296CA0013.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::6) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM0PR04MB238523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce75248-5592-4822-906f-08df1b0eab13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|19092799006|10070799003|56012099006|11063799006|3023799007|10067099003|4143699003|22082099003|18002099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: VzekOCzprFdg9h3DQpJciF8mRL/vWBnNTV1oNnNQhZKsp6+aRBZ+N1c4fi+oUPdeW+doPtdSSH0PmM2bnrIP5C4TV1SX7hAuqvCazP3OYljrRsGCuh2/wtPL4fiyiez67ABBbwWo6vbt3+d/Giz+JPX1jyZrohju0nfGl6biAqsHsaS75k343oWkygCy1mQgUCt5pd5u1wDN6zmBwlCFF6JcXbcA4HRd1GfPCdN0P5qlgsUupgCdaFFm8c2XyKeFnwHZe4VY8ZfjLBvTC0lCpfFBkT6NIzgjYRstr4w3Iq7bFMKpOEln/OE2YstWZsN74zjVgD6abCbGdzsg6D4S813BnCoxYDhFTI0EOPqn8g/F4NqvGceNcpVvw2HjVSRjDrJMZ8kqsabPsUd8F6xB2ljkyosENyF9ydl4Jg9OpLTbzuTmmrZe+3eV4/CjVrvWkLPFwiNLCstJ5f05ms5/yRrNhAULTMF32XKCUV2/nCpKtqr6RHomQrAg18SzCSGlJ0ggB0dMvJlrxAdbw6AO1FTllK/WBsszk9aNbypsFgwmPge5tTuvVg/xzaJ+g3lewQ8xktC9usw1PGQwa8S8TpyFxKHHFFp8Cr0n0+qHYdPLBVHCi0SHJjK2TTy8fwOW9Em8BDLq4Oc1ejZ82VPfOl6aKxhjUYVVbVGiDICGID2bY+EkZFQyTcyUn76MpA84mZEym+XwG7DiZCrKQKozL2hKW9LEWt2A484igdFnWrDvC4TXVIsU2GD/aJ/1p0hl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(10070799003)(56012099006)(11063799006)(3023799007)(10067099003)(4143699003)(22082099003)(18002099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8TAhjCHGTcrZVjrsKxMTJ5gAHD8ySJUqE5XkyUto9d0Xe+5+ytEDpr6uXWE?=
 =?us-ascii?Q?7i2zYoAQj7fz3DQQQHrI+p3ANWAg2X1QAkxY1fVpIP1y46NnNz3T1C+qvzaf?=
 =?us-ascii?Q?cpHP0XKwujjS4NhF1WZDqtVlS/xfuCCJLyHDvb72gWA4ACFcMf1texL6UOvT?=
 =?us-ascii?Q?VgbVKDaxp6Dg3BzTjhWloZZtqnhlxihiEwneuco/C9zp/z5YhaXHVMpT9hhU?=
 =?us-ascii?Q?9Nn6XHPGit9FR25N8uCx+waRa10bt4/Ti1tgYyGUvxs00rPyYwZP/PVYFT81?=
 =?us-ascii?Q?j79aYziHlHi4aS8kGZdMhjrxvf7arIu2Jv+I3IC85mo5VIssr1HydBjVyRRw?=
 =?us-ascii?Q?F4LoVRU51CEirHBkLGMhsWY26zgk1VrlvRaEmRIBt1tvHg9uZvSmaGcgwY8t?=
 =?us-ascii?Q?CtZ9AremBwhrHYG4qr/gzCgp3/WZUrIr8+xNpfTSfvb3uSwNwZFjNRUEhETg?=
 =?us-ascii?Q?gBoPtrSLspDNEmw3BRNxTUCnozxbYGEbrrps6lzl0K9Zr7Ikx7yXCvDL+nvc?=
 =?us-ascii?Q?UOegiY9g91pL/0mOldgjtyTis2B0pFQBdRXTV4sDBpu4X3DWSeuyDd02fqU3?=
 =?us-ascii?Q?/x8bBP98s1x0pu4933o8B7NKqTb1yGyilzzUZgWvAHy0yMFSARMH0A9ARqMv?=
 =?us-ascii?Q?ToREbCxjxjB+8EAJBwkmDNsDoVIczYcrQdIRb9qviiMl1zbd0hKSeb1Q+9VF?=
 =?us-ascii?Q?WYXpkbi0Qw7sUUMcqLIbusoXCg5E2ioRvBUIIjV481zl+JNKSQShjokV0SLx?=
 =?us-ascii?Q?MILqKD+WL/qjSP6r1s7iEQ9pvfEweV5pI8CE6675SGW3iwiw8OAhprT+OzeO?=
 =?us-ascii?Q?eyj8eVRbC+uD23qrZcOqMK3W6+4iXsVaDd4ndlVp8RgahBBtzRGZ1X10Mj/J?=
 =?us-ascii?Q?Ls0RkU7CfJDgxRkHAAN++Saio2tbD7omojomANehf5GMO5F3kAkiIaGa+ZIR?=
 =?us-ascii?Q?ErKCOtZCPDcJg9/iQkNYAxMLkRjyUlabRo4SNfxYz5cdpXFCUMp1qNzlrFvF?=
 =?us-ascii?Q?KFgg/XCMN9gRiGNb776LsVp60IEagJ7q+2cAWmDa/8XswutnTLrmRE/kxf6n?=
 =?us-ascii?Q?A27l8xvxSdO5JyY4TlL43EQko2hiB7FuVDsY1gK1n5UhIpW6TWgSAjK5e6Rm?=
 =?us-ascii?Q?AerYiepD86Ijr/NgnFsdcFWaZDVvPhS+rAYHSmIXnZkHXwgcX5PrHQiFBYgW?=
 =?us-ascii?Q?65H6kAlNXKPupg1D5me83TqYou69PkwO/Kv9HWamUZHvmb2yIyM6LllLDkh+?=
 =?us-ascii?Q?7fGZqgOMsLV/N/VPnSeL1EbhrMDRXAjz9C535jIki+9VXNZhJo2mZh0vzh99?=
 =?us-ascii?Q?hc7eGGtdSqUM3tOh8o5Wk7ixjY3z5oDZUjrZ546m05R1N67eFgWLPwI4Mz7N?=
 =?us-ascii?Q?JxjYDxUbM6GUFrpC4rpwSUphbYPZ30rj9GH5ZyLj5ME08iDCujyEZNOwB0W8?=
 =?us-ascii?Q?8vv01neK57gk/dhqkazBS8ja0PJ+rVf+TFuamUXUFRvIcph8PRR5GYZ5oqXb?=
 =?us-ascii?Q?gDAptjZwaHRcR/V4LK9xck79tKQMtrpuUfmUYWFAQbpmARaTB/LMe2ckxCSn?=
 =?us-ascii?Q?6q5KZNLiQmZXtZl88c1memNLfcq09af6S3Pll8EZuN8xsFmGoIIio1a/CoVB?=
 =?us-ascii?Q?9iFiODkKZKkMzJ+4ZpkQPSvYJogZg2zkUH/TVD9NrPsfkymsZC3/CxqEztxc?=
 =?us-ascii?Q?+Onu8nLTT9Xlp490ta0ivYrESTjsl8fsnc1XqzV8/gm6AcINPIqIUCbt17F+?=
 =?us-ascii?Q?G5ASFE9C8A5jcGCmM8NeK7AXKWdpyT/TZYDcpNWp0nvFhBm4QqsjG2TImVru?=
X-MS-Exchange-AntiSpam-MessageData-1: DUPq9P13pdbUnQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce75248-5592-4822-906f-08df1b0eab13
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:09:52.4900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/31cEnk3jXo+cx2tJDmDrbiEsAE53zpO9tVM9AwfCvuc5rWocJIIpR/Zh/M3r5baF2qH3Y1N2hQWD+LTTO1Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB238523
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

Hi Vincent,

Please don't take this in a bad way, but please be the first reviewer of
your own code.

This is just a mechanical paste of v3 over v2 which shows the raw delta,
the majority of which is just gratuitous formatting change. It is very
difficult to review.

On Wed, Sep 16, 2026 at 11:15:45PM +0200, Vincent Jardin wrote:
> Fix the commit
>   035d68fc36b5 ("lx2160: add lx2160_serdes split and management")
> which is in next.

I'd suggest picking a different word than 'fix', which means something
was broken.

Best is to have one single logical change per patch, and to make it
obvious to the reviewer through the commit message that the change is
justified and correct.

> It leads to the following commands which are more explicit:
> 
>   lx2160_sd1 100g4x25g
>         CHANGES the SerDes 1 Ethernet mode: it re-groups SD1's
>         eight lanes and re-points its protocol converters.
> 
>   lx2160_serdes status [1|2|3]
>         only READS, any of the three SerDes, unchanged syntax.
> 
> In order to prepare the next commits, this mode should be:
>   100g4x25g (1x 100G + 4x 25G),
> instead of "split", same for its hwconfig key:
> 
>   setenv hwconfig serdes1:100g4x25g && saveenv
> 
> The follow-up patches will add more SerDes 1 modes under the lx2160_sd1.
> 
> The SerDes 3 and LX2160A-only branches use IS_ENABLED() instead of
> preprocessor conditionals, and the header no longer wraps its
> declarations in CONFIG_ARCH_LX2160A: the definitions stay guarded in
> serdes_split.c.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
