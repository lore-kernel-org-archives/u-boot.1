Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FF606EE83
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nA/4jvqk;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=erWWwYaf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5E794064B;
	Thu,  5 Nov 2026 18:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9OCz2utw5zRy; Thu,  5 Nov 2026 18:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C8D84081D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793904970;
	b=D696Jo63WbpVg/RkynRkTrIN5bq3eydZPXLJmb6PJydiNCKpLC2/Rphx54OmBiKJ/Bgt
	 k/7yS5JZyPQkStWFKnsW7ydrUUUXH7JfdVH+e0g4DUGvNcegJv5oKakZZd6NXje3FaPIG
	 7oXrB+Dmn+l8nZYuC32jMMziSp0+a5nImnsvZYSBL7uo6vlMpLDXvN91Wts1PoGZE6tv3
	 sczM43axwJYQgTtUsXcaSl+GcFtxsVStjxVby4kNiebZ7pdh6PKvDUBA/RC+Z5zTp+aOC
	 xOTEeaKUd8p+V92ay4KDDvep3wGMWYEBX8d9OV4VhnJTCEoraHm2RDYjc9Vc35hCByQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793904970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BGIlfdCwHL4JN4k9cbnbY88ZBXkjTxsddRbeqdpMxTM=;
	b=F2gJNv73vLcDnuQyn+wYhR2Mx+/fgbXGAPaxIWSOWxwUa3uTenR2LTLe13r1n/YtOoRp
	 jBaD3PbBn4v7LfBc2tPBJkZSbBRNPJ9RU9U1X7v6GpeX66QcJ+gzACwUAuICjkdvqvCgv
	 0hwET+WLKYNAa2s5nwgVR1Betl/NuFcZAddGxRK2CKMjMtWEPqzM7/fWEBKA1wLOx5DYa
	 dOmGba0QK2VPgEwiJ3dpM5MVR92TRcJwFUzToqyo58lOQgrqZoftsK0mt4LrDb6EeHvRy
	 p/w5x9icDMPqAM9hheMfe5T7s9+7fRP/yBri3PaCiVaDnO14JymD2q03FTe7genBlYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=hotmail.com;
	spf=fail smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=erWWwYaf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793904970;
	bh=BGIlfdCwHL4JN4k9cbnbY88ZBXkjTxsddRbeqdpMxTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nA/4jvqkkEA5clKcFTAa2hnt1F4fYN+QzaP119JXeA3XaYfH67Bjf73WzmRwOuIW5
	 ++/wkm1OU3IzhkNeFoH1SymO3+2Eo8Q50/amXSPtfBAFkicqy0E/91WqBrblCd0pD6
	 2Ib38lDNT4xg4Nzorek8PUdx587F6KoA4FDI+TzQ3wDxL1qBtgUB4GISVnX0ddaSdm
	 FbH4+8/KHl6capB8drmtiPVR0KEN+jZl6PjBh63sqKcUG9FleFbG+lxqBhc4tYuvGz
	 fPZ1lnlRjcuyIMLT9zqlybDArO0J9KBTyqMeoovGAuRJtPmxOg2TJH87rQkM3HFL6Y
	 8zUelIgj573MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C8D84081D;
	Thu,  5 Nov 2026 18:56:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 77C471779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D5904087C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:32:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85m36zGNIcLv for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:32:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D85A64085F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=macromorgan@hotmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=hotmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=erWWwYaf
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D85A64085F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:32:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173A18482A; Thu,  5 Nov 2026 18:32:44 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azolkn190110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d116::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A292784820
 for <u-boot@lists.denx.de>; Thu,  5 Nov 2026 18:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGIlfdCwHL4JN4k9cbnbY88ZBXkjTxsddRbeqdpMxTM=;
 b=erWWwYaficFjF9L+vENXXGVW+u+KGPzU9fa9ny6Ou4INAvyGYN8sExc3eExhWrSGG5F4CMm5lUvCaWyW5olXGEauhtzr3MfZfD1ZRjfsCDclrYIbdogH2arYNMm7fusLndBRyfFgvdSr29PzBPj99OFVXb151uX9YgW6SEiD0Kikc7TSrroErB+hrwYD3zHoLuV41RAgddyV9Fvwnhkf7WDF+u2ksOzPtoubqNFsdFP0lEY/XuhiqbVBEhcTbIrYHA94r7oEMyMrv5mLNMBQs86TgMf+HPIP5xq2s5+alOAFPpvct8+o7v27p6h39l40nWbHS3QNRPrlCSBVLVO+Jg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SN4PR19MB997553.namprd19.prod.outlook.com
 (2603:10b6:806:505::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:32:32 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 17:32:31 +0000
Date: Thu, 5 Nov 2026 11:32:25 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 clamor95@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, chenjh@rock-chips.com,
 zhangqing@rock-chips.com, kever.yang@rock-chips.com
Subject: Re: [PATCH] power: pmic: rk8xx: Don't set RK817_POWER_EN_SAVE bits
Message-ID: <PH0PR19MB99733827DB66CA431B1BD7DA94A5772@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20261105151057.477529-1-macroalpha82@gmail.com>
 <cb2be9fa-19b9-4d02-9696-bb89c1e713fe@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2be9fa-19b9-4d02-9696-bb89c1e713fe@cherry.de>
X-ClientProxiedBy: SN7PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:806:120::20) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <auy9qYFmBI-umZG0@wintermute.localhost.fail>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SN4PR19MB997553:EE_
X-MS-Office365-Filtering-Correlation-Id: 69eddc94-9100-4c25-d556-08df3b62c541
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|12121999013|5072599009|37011999003|8060799015|6090799003|24021099003|55001999006|39105399006|25031999004|23021999003|22141099003|19110799012|25010399006|4140399003|440099028|3412199025|56899033|10035399007|11031999003|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ih2kVTRkvlX+Rz1TfC7mJo0KYQHKQmI8/ZqSFO3VZBuo2+Dp7yHZyGUHfSMZ?=
 =?us-ascii?Q?n+5Mie9OHnutYPTZbx6sKp59UMfRI2zrQeDzNTzbXqbfV0u819aBKtSN9LT6?=
 =?us-ascii?Q?jdRlh3OUw2m6gyiYCxz92MARYMh6nXBqKV1pPyiyVznA09nEejMAL4MRRQI4?=
 =?us-ascii?Q?xAhqFAeo2aLduc4Yw/XOfYZNgYDNMZKrcxHo5hSzHsGCKa08inAk1EGtop3C?=
 =?us-ascii?Q?qbvmpa4xM30XJq6rKCLULxA4+1li+W2+eXsoEHFMC2iZvr2XZHzYYmrd+B/b?=
 =?us-ascii?Q?W9oBAD5tBaOiHAu+HXVRYYPx/S2yYEbhGXM1WLEMtJPYBRqvW1JPaGkYCMNU?=
 =?us-ascii?Q?oiDPckojxrCs0HfWbeUCm5G7LQ9y5D24keDKjYmxC5zvKp1GmAKHrTQj2E9P?=
 =?us-ascii?Q?A1f2ij01LT+cpgJDzY/dS7cZKxXa6y2Tg6R3ibN2jOWelaJ79N0aOWQzre6M?=
 =?us-ascii?Q?eLeog9+3DQLI3zC+/ZRGii1ynlPB/VQRfO/mLyL6MvJu9CzjBk6WOnn9Ylhi?=
 =?us-ascii?Q?bQfTC+oXYSam1hvAv+BemNJ/hEBxVDsPAyP27Yo+yOn0nt3ST5gtcc8r72U3?=
 =?us-ascii?Q?mrzijrOla9SLkj45i1/D3ok+Y49Fd40d5iBop8XvRvcg1QfhpdquLAZuJ2r/?=
 =?us-ascii?Q?uMh8dksIp8CiQVLSDr2sCa/u3VwWFDW1l2BoamJ6vuPrhoZ1uyFz9VPQNE+K?=
 =?us-ascii?Q?2RnK4TsDBgX1Tt6cLS5oVi9J8YlfFDZjuHva5oY0PxJdAezNK4wktFdEudwt?=
 =?us-ascii?Q?Wm+OtALUeHWaJpS54G1gsofcvvpyHKxJ/kRDugxBfDgGn8OBEzgo4zt0/os0?=
 =?us-ascii?Q?4BWDPQRyYBJbDyW+mKYqRDRAilBy3McjksJUkav+3gaf6fjGyDe7v2tHGkW+?=
 =?us-ascii?Q?gQmfzZDDUJDJXVXRRYYQLEI9NAKBM78RN2b0Yaw54ZKf11Blg9bNZIJPdzNf?=
 =?us-ascii?Q?BNnRs4uizEWuWsE9hvQKSHDR1vv+fyI2zWVgcDG/56ULUY4jGEzvLlB9vtRg?=
 =?us-ascii?Q?68Q/t8hRS6uPrFa0XIQRVEeybccHjwxbDG1fnOlDtkkSCX1FH5vCHLSGgnvz?=
 =?us-ascii?Q?QQAqOjcJXYYKE5E6zr8XH9mdmXG9PoALqHdDK38bT+0W9s7lIp7GOPEcTUvX?=
 =?us-ascii?Q?lmg9mQzS8uhwQqwNfhu+ShwnXJJf+heVjt2w01n/w3unVXwOAY4upGg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twf56hsyRmMXRA6sBfyaGjH+e2CXpzPhAuFQlj5wOxEgTg2T14lE7yiPheIn?=
 =?us-ascii?Q?FwR/vqB+5r2MkwsJd3yIXwv0yo0GSFz0gzQuaCO4RV4UkwxPRvsbgtzIjtm7?=
 =?us-ascii?Q?TYkank7ORGqKqR3bf5E7DCfP29ii1b64Qfr259pZFPA0ZOhtFAPhTEID8xt2?=
 =?us-ascii?Q?RHtNLYhQfP+XKUdx0ooWihRnhXq1hlB5MmPlNqoBb5mVl734zv6juvCyalCp?=
 =?us-ascii?Q?NdmeRJZeOwEc0Qw63MB9hObVTo2ueAF6unU9Kx3ix6ghjKgGnisArPgu5jcz?=
 =?us-ascii?Q?tvgBYGzaZhsK76hMk9nL7Ckcu6pDdqZxzfijQAzOfnVKLCRXLLVDjkmLB7bX?=
 =?us-ascii?Q?9w8r7W/BxBfJzrPLJXa41g+MHGiVncKN9LUbbGSyn8gf5yhiGnHzwjl2U+HZ?=
 =?us-ascii?Q?03umufj/pddjK5oeKL/xpeYccsXtnszMDBpox2nwrfZ85Wvy0+dCoqOqmbqQ?=
 =?us-ascii?Q?PRwMRRrvA3lIuh3Df3a9strDM1uQ+s4budJ/lsQkR3+YTVqLAtLrzqkZxqAE?=
 =?us-ascii?Q?vNnnXbfob1iuyysANnBllkB/crap10H7Yq3sW6GQVh9+Djng63U/G5snT+wo?=
 =?us-ascii?Q?eR7I1l/GDfg7iM2m/A0rVdYAatmmeq6cqTAE+t1/0E5qxNpqS6cc8Sk5h1EW?=
 =?us-ascii?Q?6HV196uo6PxlYVCOZBVgm3LBkh38LVNj8XqowYaG8tF2Rq3NcdQqccHdfKmq?=
 =?us-ascii?Q?fKOOuf8AwXKKZYv4fWO9la9d/vvj/JnW1qdNd0nUjHkus033hh1dCVDGK/nd?=
 =?us-ascii?Q?iq9EsB3x4OyaKY0rouQ97O3YM60rdtnJU9aYXUvejlkfzn0quufoB7/z3YXb?=
 =?us-ascii?Q?+EDeSRQdLSIA23lYWgwCwx+z+Oq7My0H0n2sFUyPLTCm3PvJCcW5pdeufr6U?=
 =?us-ascii?Q?PjT4oh0gN07xf3S/xHgAbaKV5oXvwkJiuLtT0srqa0vxsC2iRrz2ZsyIolvf?=
 =?us-ascii?Q?SMAQYi8L3prXJ6zvhEa8CtP1GfFmdRowYc0dxqAxB4pNmi3P+r4uTkP9sUG2?=
 =?us-ascii?Q?4GJGmpAwdPish/+L/DUNLOlqz2TmbPuT1Z5em+0xqLDC9+qsPAodQwNPudq7?=
 =?us-ascii?Q?S/A35FBi4+jFKcsYsRHfPChkUuL6iwZgxE6/MA9gm0oDD6l89clWIScGO8By?=
 =?us-ascii?Q?eFJPjh4S0rwU/WO4oG9PLp48sboM2ydUG21qjjTnANkQ6WklUefDcttcIuk3?=
 =?us-ascii?Q?rKsgBCOVB5qAs9ZcYdO2jr5SWe7jrzaplbS9egpln5g3uFIn02JOFXGA1UUp?=
 =?us-ascii?Q?H1zd+lnpurqCAIvqiPi64KsUh22Lmok9iATm+t2wF7qFJZ76CbsVHJTDHus6?=
 =?us-ascii?Q?w8yI6Sloo7yFG8gDQHNsspkyH1IgHAdJEyfSplzS5BNYF6G6IlC5OJRdqrQn?=
 =?us-ascii?Q?wrr7RsEBynsuyRnkfdR6nftNj1F7?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eddc94-9100-4c25-d556-08df3b62c541
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:32:31.6296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB997553
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 05 Nov 2026 18:56:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_FAIL,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 05:13:48PM +0100, Quentin Schulz wrote:
> Hi Chris,
> 
> On 11/5/26 4:10 PM, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Don't set the RK817_POWER_EN_SAVE0 or RK817_POWER_EN_SAVE1 bits. These
> > bits are not used by mainline Linux and actively setting them in U-boot
> > interferes with their function for BSP kernels, causing systems to
> > hang when regulators are enabled or disabled incorrectly. [1]
> > 
> 
> More information in the commit log would be welcome, in the event the gist
> ever disappears.
> 
> In essence, those two registers are used to store the current state of the
> regulators (why? don't know and not explained in the gist, do you have some
> info maybe Chris? Anbernic seems to be ignoring it anyway but we don't know
> if there are actual users of it). They aren't meant for that at all, but
> that's what they are used for. Downstream kernels then read those registers
> and configure the regulators at boot based on the saved values. In upstream
> U-Boot, these registers are set at PMIC driver probe time, which doesn't
> make a lot of sense since no regulators would have been configured by then
> (although, they may have if the PMIC driver was probed and used in xPL and
> U-Boot proper then save the state as configured by xPL).
> 
> I'm a bit worried other downstream kernels may actually be expecting these
> registers to be set. But considering we probably are misconfiguring the save
> registers anyway (by saving too early), I guess that's fine?
> 
> Please expand the commit log to contain summarized information from the
> gist, and that would be an:
> 
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Considering this has been the case forever, I'm tempted to get this into
> 2027.04 rather than 2027.01 as it's not a new regression. That would leave
> enough time for people to complain about it (though I'm not sure may people
> are actually testing upstream -rc on Rockchip?). At the same time, we're
> still relatively early in the 2027.01 rcs so maybe that's acceptable too.
> 
> Thanks!
> Quentin
>

I'll resubmit tomorrow with more information in the commit message, as
requested. I'll save the ack so you can confirm if you think it's
good.

I don't know that we have a good answer as to why those regulators are
stored. The BSP U-Boot driver (assuming it wasn't modified by Anbernic)
would check the device-tree for a "not-save-power-en" parameter and if
it was not set at 1 it would save the contents of registers
RK817_POWER_EN0 through RK817_POWER_EN3 and then save the contents to
RK817_POWER_EN_SAVE0 (0x99) and RK817_POWER_EN_SAVE1 (0xa4). These
values would be saved at probe time which would be very early in the
boot process. The BSP kernel driver would then read the
RK817_POWER_EN_SAVE0 register and if it was not 0 it would then read
RK817_POWER_EN_SAVE1 and write all of those saved values back to the
PMIC as part of the reboot-notifier.

So basically it looks like as part of the reboot/shutdown process for
BSP kernel and bootloader, the initial values for what is on/off is
getting written back to the regulators unless not-save-power-en is
set in U-Boot. This process breaks down for boards where the BSP
bootloader sets not-save-power-en.

Since mainline Linux doesn't use these registers at all and there is
no parameter to control their use in mainline U-Boot like there is in
BSP U-Boot, we should just drop them so they don't interfere with the
BSP kernel.

Thank you,
Chris
 
> > [1] https://gist.github.com/fr0z3n-cs/047b24a6fd430e816fe02a877ad7ab8c
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   drivers/power/pmic/rk8xx.c | 11 -----------
> >   1 file changed, 11 deletions(-)
> > 
> > diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> > index 95b71d2fe49..16b3dc7cb1c 100644
> > --- a/drivers/power/pmic/rk8xx.c
> > +++ b/drivers/power/pmic/rk8xx.c
> > @@ -251,8 +251,6 @@ static int rk8xx_probe(struct udevice *dev)
> >   	int ret = 0, i, show_variant;
> >   	u8 msb, lsb, id_msb, id_lsb;
> >   	u8 on_source = 0, off_source = 0;
> > -	u8 power_en0, power_en1, power_en2, power_en3;
> > -	u8 value;
> >   	/* read Chip variant */
> >   	if (device_is_compatible(dev, "rockchip,rk817") ||
> > @@ -293,15 +291,6 @@ static int rk8xx_probe(struct udevice *dev)
> >   		off_source = RK817_OFF_SOURCE;
> >   		init_data = rk817_init_reg;
> >   		init_data_num = ARRAY_SIZE(rk817_init_reg);
> > -		power_en0 = pmic_reg_read(dev, RK817_POWER_EN0);
> > -		power_en1 = pmic_reg_read(dev, RK817_POWER_EN1);
> > -		power_en2 = pmic_reg_read(dev, RK817_POWER_EN2);
> > -		power_en3 = pmic_reg_read(dev, RK817_POWER_EN3);
> > -
> > -		value = (power_en0 & 0x0f) | ((power_en1 & 0x0f) << 4);
> > -		pmic_reg_write(dev, RK817_POWER_EN_SAVE0, value);
> > -		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
> > -		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
> >   		break;
> >   	case RK806_ID: {
> >   		u32 rst_fun = 2;
> 
