Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEAFC9832F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1E9580A50;
	Mon, 28 Sep 2026 09:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IojL9civ0B7c; Mon, 28 Sep 2026 09:30:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D7D3480CC5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790587849;
	b=I+4XaPHsN+z4rdw+4dm9RWZs3fbOsBZrgqzHdp3NnwCu4NGWdX4r1ls9oFKhMCIJG0Fd
	 +w+Pgz03a6subLaiysyDaqXOAgE7xHY3DBd35saqcdoN5glJjjfNRSuUQeSSnyJsBnEfr
	 e3ZFwxtctiMBRVhYkgFdINP0GWieiNDMrpIdTFk5L8Zz+ylMJKvSRYvRs5K7TS4KZWmKJ
	 xsdHEeaJOri0eSByMuR0UJx0ZZyYwBUOWFU7PdtTSA59sD8FvmDRcSsQ/jlWCpEGcOUE3
	 gsTMEHN9A2drfyAP4Eij7xklLYSBtrnN8QYG8RJfff2kti5aAvRDa1gyq2QQ0eBTDzw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587849;
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
	bh=VjBSpP6fDGxlhhH7agTNPuUowewkxBnXiJmUVp9UdZs=;
	b=gi5l06mTnZ7kLuBHx2LoSiIDK3he+z6fa+wNaoyUw8A+Eo6moCAiXkkU4hIYf1NfKip5
	 3zSPFrX/P/16q15633HrIVqyM9ISF5rDkNdobVJ8d/szsoKqXQZoyzYbVrZoqZeHt535c
	 GrbPC8S2Qmu3nGEbRafphoNMk2cnCz+KPEkZFCo3XRbsfWFM0iZKwrxwmFiALzi0YtWOF
	 J81Iw26Ygr0xj48GTVj0EiLWrmGrZKh1xomqtf5f3Sp8c9aTXoT/RPT/2zTD/3A0Ozexs
	 RhKqXrBuna8blKSA+mSb658e16Sww9PCRZTv7E5PViQyBOa4kNh1yFwe12Ka1egDlCg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DIVfKyk5;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587849;
	bh=VjBSpP6fDGxlhhH7agTNPuUowewkxBnXiJmUVp9UdZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WOEMDkqXPODdgbn6it8u/jtmqf/HTtvwc/u+EOhubgIVsa5tpl1WsPUxBHYoR84XS
	 01qVcabVV8eKpkflu2FwSC8+BcTpU1YUk56EM0tmkevwIwvic6fvU3j5jzyJgnOqy1
	 mvNpHc090UmrbVQf+fB8gld+DFqQtDaipXyZVQu3XUE23zoA7hPKV3nIlJZSlbU6Om
	 rirZFsH8umdUulxEasohBkKbPO5ELK2WEEbFw6zjW577khwj7dIi91dbg1SrYaLoz7
	 U+Ec1a8W13XEU62cpuTPw9B74GlSBvWJWTqD0G3+0J6U91PNskkM1jjBzKfCJQS9Wx
	 COBuzIYouZb5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7D3480CC5;
	Mon, 28 Sep 2026 09:30:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58B6B3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C44880C94
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:30:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gKWfg7Kf8mYQ for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:30:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2869480C87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587846;
 b=kcTyztiSIwSAvA1wFrshLM8xxJVbjXZVbGHd/QsQjftsewXLfI4zR1Uj/j8DqDI2TNS/
 mcwFUvteJoZKZaKiG6YxzTOVc+39Wk7DewLY4fu53TvBluo+bLTbvMgiTz23K8kCPJ9+R
 WYg2nU66POAiSVmAbEXs7FK1Vra1RAhoi8nD3r003rMqBjsBNWhUxrU5+v2d9prepWgBu
 qHM1q24UGbMBc9s56ZpLaR0UJ7qkDd4SzoNJQ6tXI4HhU6eWtm9mlXLxEU26piwcri4W2
 2BEx3dXyoJcOCuKcJ0pf3P50omfwdySXT/MvTy+WVZ+0SaM78HKNdg559lADlXhOijQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587846;
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
 bh=VjBSpP6fDGxlhhH7agTNPuUowewkxBnXiJmUVp9UdZs=;
 b=dR7e/Zr/X6EzeDyEpJ+lkL4I6+Jkw3fLtjuDcp5EblMaovpm9zQjSWQKI7O2rV8OLct6
 LoEAfHhODaKp0Ei92W2c+jalQcrlXi1iIR/fQxfcNwom05+D2/n2kXDyxSE0DkDZkPdVq
 w91AKeL28GMqbIOMWlfZ7AsbRDMLle5dhrnowcxMIpvYyrqgMRgVwfddnBd0QdJYIZ045
 aH+xVaUU+j3ULcmyo9hz71By+EvRZ70GYeC/QFiKbIybeJP3WUfD9rk/clJG04Dm+huA8
 y/g16LULLL42l3gVmsSTEX9KV4MyyJpeXaEIo6p+6rudUtQM6WMbFIl/N0rW47ZlCAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=DIVfKyk5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=DIVfKyk5
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2869480C87
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ+Si4zxvQjOpd9sIQog7Sz9UNFSeePDlc+AfaMaoEU6dkhMMLKItlbovgFOaFwe8TGwRjZ34V0xS+yTXETH9AOhVfn49i4AeK7OQvOd7lVlbd6B5OcBONpkk+10cwQ394JO1FqYJy71f2crK1PZ/G8sCQwBIN1hjHuW5VmDuXV9emZvkl8RVrzNchsLbgdpakaqqvMsv7yACK/3On0pd2aZ9G3mPUmtiAqWZ640npg5SajHJ+z2UgpQiMgaXCPz/AA7jciGWr7IxeYv2kU4/UrENVYSB2VjIY55W+uF5+hittRT3o8VZbjLys7D9f0aNHvob2lHyB6s58GOJZ6few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjBSpP6fDGxlhhH7agTNPuUowewkxBnXiJmUVp9UdZs=;
 b=ZAaEMaC+wiq9eYvJUYBPW2u9/BtdYIdeK1xjMsV4YKw7uMjcalO0t/lfKFr2AAbcgOLwcXBgYn0MczbUCwIs9M72ycNoBJvHQfb7FCFlforBCNe0es9q93+gb4LIm5EBqwKFbWF0wjm5DQ2A7HvFGtRjEyPix5tfutvR5usOBdRkzHGL6gmy0QE6pVHRsur4phdt64waymkjIUbBcjxusO+AZy3WUpK0gXaYUxGn6VViv0mPiUZfJ8KS63KqxD8oQjBpmeYbsUZ+5Q9/l5mTPCcPaGeLlfO45YxKyVemXYSXL+qH3k2BvSItf1mpg10Ap/9YT1rujca7fyLXu59ZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjBSpP6fDGxlhhH7agTNPuUowewkxBnXiJmUVp9UdZs=;
 b=DIVfKyk5Xq1Cl45+DkPEbns9sXHrNBBoI9agOpSZR0ds3M7BVlzzqU1KcjySblbV0/7VvX1UrKVj+zW9Ur91nR8lPoP2CHr5aoNy2iYl6lZ95xF0Ut1LYJZrma53copZsZvYn0deNLSW9dpVoA1vp666dinvNs7z3F/J2XK0t/qZlIvrlcIFQtEw+DAoGOaHA+TTF+HExTpYgZRP+ROXuNidid68hsE17XEvdanskqRVnx60PF3zGNAAtlsDxDm/wLhDkKJUlEvdJvFsWeVF69jio7nz437wFZ2u64edOvoCukZNxmDYp+Mh3RVvVNEfpEUYqKZ54gvqrL8MLRfoXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by MIWPR04MB710340.eurprd04.prod.outlook.com (2603:10a6:290:ed::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:30:41 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:30:41 +0000
Date: Mon, 28 Sep 2026 12:30:38 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v2 1/5] lx2160: add lx2160_sd1 100g4x25g and
 lx2160_serdes status
Message-ID: <20260928093038.utkw3zpq5sikbxkx@skbuf>
References: <20260914170417.3052423-1-vjardin@free.fr>
 <20260914170417.3052423-2-vjardin@free.fr>
 <20260925134846.4tazuavdyax5zdze@skbuf>
 <arem7uLl5jR5QydT@L30177.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arem7uLl5jR5QydT@L30177.local>
X-ClientProxiedBy: WA1PEPF00005B8C.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::625) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|MIWPR04MB710340:EE_
X-MS-Office365-Filtering-Correlation-Id: b63461dc-2910-4bac-4c9e-08df1d4329c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|366016|23010399003|10070799003|3023799007|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: Rxuv1QlgbPtud9Aj2JCEnolvXsR6QfgTYuPiUKnNBWjTbE2iZP8uaHUWMDGXLAtw1meIawFQ2WdTvFagdE4hiTqxP5AfzTOADV4N210dttc2Ai1W1U/oCarpOQGkIgORewsKprh4KIBxDoeg99P/Smvyf/7/nyfwqwvqRCS1HP0n1EfT4e5Enzs0LzXrvAagrtpSRAA3wsqASwhhtXnVMLhe2uJhOy7izWHtGw1HEcyq2o48TLRYBLfiQHhKPa9vVp56HcuQ45LtqFTW4ucV3iMbUxcq2id0NLXNYGn43WHvaw/U3lSNBDC5hWlgXla4pEeW8CsP6c5H8SR75VxpxE0OytzWevgzSrYa4oj5WjIItsbhVWVrh+9tm156izMYziASC8Yqk2w1Q3D+ul0aXEtsxpE8IqrDzVd29zq1OHJK/VJWH7s28HV825qO6U67678OzGVozMvrRiGhumPoYjXRK+6KuoV201wiMI3odovpJGEsKR2B04rbnzOSSevRp9I5KXC71HBIGK+6osQrN2ovQrZjII4qCazieqR5Ak4BjvuNPddce0GaTaZ11jdCy+1airK+xx3reDp7XDSf5lT8Fxikp4zuBdqxca5HY2HIQEb0QUg8hps6S6uYwb334q5cfuzxrKFByN/MIOVrXWm4jaj72EYmfRUXKDYhHRnPi+KeYhQNH7S2G8K02PnnHAohwwV85QOmtXbpJtYvcxatl1NCymyCBePTudu05PQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(23010399003)(10070799003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G+spcCi252QdYiMc5pBm4WVotshBvbEfHv8iABxV3SZZYlTu1YTJDIdWgXUj?=
 =?us-ascii?Q?iRuhXmEIt21hpNslN5eyWW2TQIPbYr3XAQGEdnHuaRqCzDEBcp/y8kEdAv+/?=
 =?us-ascii?Q?1Yv0FLum1DoEXhmUJTV32+zaw5ehwNHcJsf91omgXHU/2GTFaybcuJjfdNsM?=
 =?us-ascii?Q?s1ZtZ6UJ0qk17My0AoQKpOARiS9KueTtHb7dad3Zdc6jMb8jQxkG2/2tw0zB?=
 =?us-ascii?Q?n/N+wyKCpsV8OfGs4ORZCjKqfYAuwseWBZWC0HlutnyQrAzgzvyGpDZt0BPf?=
 =?us-ascii?Q?z06C+5him7lvx/8FzR5qxyUqI3kDzIquIGtBDDFI/sodIPu9eKVhvoIj3dCY?=
 =?us-ascii?Q?dlkT+bgv5L1aXqc9KYkUqB8leRoPvIAl5ZikiFJNqP+l3Rjf9UG2ewdlQehX?=
 =?us-ascii?Q?tILNVk0zhikJDGedlbKCssj7SKC9rPgyJkZqQKCAxJSjj8mUHUY3R8tekk1g?=
 =?us-ascii?Q?TQkoAEntMXkklDEoABggm8V6pcsH1FD+eq6Rj0GIS4rLiPO1eLThuKNahJ5G?=
 =?us-ascii?Q?3kYIVCuhzIX56VqNgei67iEUN4xPoIthGKnFPxAI7vEPC1ZF+lOi+8kty2zO?=
 =?us-ascii?Q?CJsBswBFS/qrZBiMRaMDmNNwvHLEKcTPODAt9nd2ypd8xmIUxfi0zCAY+NQu?=
 =?us-ascii?Q?6rFNKqlAbD9AoRH+kuG8RRaJJESjOty4Ei5rT+NM+lOvhYcM5d+eUVTqt7A/?=
 =?us-ascii?Q?CIC8gaBTBpNhN1AH9gPVkwS4M8JLIE4WGYqnMym5Wv57dJJQAauNXwR3WAtr?=
 =?us-ascii?Q?AdHrZxAevG/vBCLK/RdO6I4H6TeCGJ+X5CAhlQyGQzXpkKT134FB20a0QE33?=
 =?us-ascii?Q?NDY3Sj9orpfjv+8Abwk4GFOfAKLKdBvIQd63QIxIp0sH1DFCF3/Aod8ZfCwL?=
 =?us-ascii?Q?5winlQMgml368GZ5YHXJEMgBPwbdH1ZNnw6xlFx5xokdmPywCB+WI2nbl5Hf?=
 =?us-ascii?Q?VrdFChXrDDN4YMAmvZ5kc48k4omKrBw9MtqRAqzvqvZpUhLKlUHNRiWgqIR5?=
 =?us-ascii?Q?wAeW8f7GH8SFDM/8lUclUMj8DNuG2rN59nVjebNVqO6x6AEsRw5BbBC6hepa?=
 =?us-ascii?Q?kNtdM98pBwNu9oyHoGFglBWgmMFd5xGLEnGv8EUZRADnCvpU/3CWpfNJG3iG?=
 =?us-ascii?Q?9RpiGO0wIVn/VLjTdeqACoXMA5AUxj8yEaSohJjrBODUSEAN4sDB6klgd2VF?=
 =?us-ascii?Q?1rI78bEzGJ2dNRTUOTmyjKoD8IHdWLiqqARu/ySXyUX4yN79ObILvxzbLaRV?=
 =?us-ascii?Q?yxM4geAoo6/kpPBrNhYuFv2yA7VSPjVSgla4WqnksQbX5kWBzqdNOOjwS+sd?=
 =?us-ascii?Q?GusEoiEYrkllSSr5JPVKfa7PgSC/Tv1uTslNwkQv4YyJ1zCUdCdgFcExRKGG?=
 =?us-ascii?Q?EzJU25YBgWTBdyoE1chvujcEAml7Nks9reyENMcDVLBQrVNo7mVpXz3+XajM?=
 =?us-ascii?Q?r18IQ8l2Rx3fyiwuUc6e+U9XBzD5jtQ4cE1Esc4zCeGCn5GoP39lHYe27nhb?=
 =?us-ascii?Q?HOmNKTOEK2HJI6DjP3SDFnJ2qFag6EJ25ZDtBbutpYV46+7de9oiXTD2d5hU?=
 =?us-ascii?Q?SozuvKQ3a366P23WsPsvf7KSu9VtmvI1xfNWRxROsnFqRNn5+bOt0FsqDcS9?=
 =?us-ascii?Q?7yXTLOIq3chwhH1CeZ73I+MbS56ep7R3kKCAE0mS0CVG31/gvUeJVmN6OjyG?=
 =?us-ascii?Q?B+NSSolG9lgFHOtKTDXerMVMgBT3aHksAqF8tU5vVJYX4BAz3xBE2X87PocQ?=
 =?us-ascii?Q?PWJHtl7Ayvee3avrTkP16LHGVHvZ04YJc7DrNeEgFW/EEfEKUGw8QbwqRtx3?=
X-MS-Exchange-AntiSpam-MessageData-1: suq7qGWVAS9JhrWgP+Im947o9LFGdaY53JQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63461dc-2910-4bac-4c9e-08df1d4329c7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:30:41.2379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAORGn205rgXXoA41vqjB4Z+EDeFvBHpAmUpXiJuGsd2YKG2WkVEqJcL4lHu5V8tiSpaLOZMk8DIdC6eAOcpYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB710340
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

On Sat, Sep 26, 2026 at 01:05:18PM +0200, Vincent Jardin wrote:
> Hi Vladimir,
> 
> First, thanks for your reviews despite some structure issues of those
> series.
> 
> > Why specifically for QDS? QDS has the board_fit_config_name_match()
> > implementation which picks a device tree with mezzanine cards based on
> > RCWSR28. If the SerDes protocol has been modified by splitting/unsplitting,
> > all assumptions in that device tree selection process are wrong.
> > At least, I'm not sure how both mechanisms could coexist in a sane way.
> >
> > Why not for the nbxv3 board only?
> 
> The QDS was the board I looked initially for such support before the
> nbxv3 board and I was trying to highlight that it is a generic capability
> of the lx2160 CPU's serdes that I was able to field confirm, it is not just
> specific to the nbxv3 board.
> I no longer have access to a QDS, so I can focus on nbxv3
> but I believe it is worth keepting it on QDS too.
> 
> I did miss that point: you are right board_fit_config_name_match() selects
> the QDS' DTS from the SerDes protocol number that had been set into the RCW.
> The case 13 is missing (2x100G for SD1).
> 
> So for the next updates I will focus on nbxv3, and I'll check to reconsider
> lx2160a_serdes_apply_hwconfig() that I did use to make it "hw independent"
> following some other "freescale/nxp" cases.
> 
> I would still like to keep a way to use it on QDS along with nbxv3,
> so the generic code remains in board/nxp/lx2160a/
> 
> Would that be acceptable to you, or would you rather drop it from
> QDS entirely, but then how to highlight it can work for lx2160a ?

I just pointed out that the two mechanisms do not combine well at all.

I do not really have the bandwidth to make any changes and subsequently
retest the mezzanine card setups, but I suppose a more flexible
board_fit_config_name_match() implementation could be found, where it
does not assume certain mezzanine cards are present in certain IO slots
just based on the SerDes protocol. Extend hwconfig to store what is
inserted in each IO slot? I'm really not sure.

In any case, the current QDS board setup has U-Boot networking working
on those ports, and I'm not entirely sure the same thing can be said in
your design, at least as long as you permit this lx2160_sd1 to change
the DPMAC assignments at any time. For the QDS it is a clear functional
regression and I don't want it to be permitted without serious sanity
checks. On the Nodebox I'm not sure, you set the expectations.
