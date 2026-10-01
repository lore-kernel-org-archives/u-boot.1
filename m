Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64220CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 15:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F26C660829;
	Thu,  1 Oct 2026 15:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id btyD_5J3lV_a; Thu,  1 Oct 2026 15:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C2DE60868
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790868115;
	b=nIyjOziGyaHmzKAI8qI08MfhrysZHlhEubW6I8aVa757FpRiwKREbwdXga9Ed4yK9kDR
	 D12nE7lQpmmsUHJz7NDVG8eUBXP7xUSi160xE5t8nEoNjS4id1Ljg6gkLJbrmW6fhrWZT
	 IB90QPkxEe+JFSpgSudlTVP8B9QVzAN8UBlEBGCoXLLYqSVb8NAtZqohv12zw1WXzq9Sn
	 YK1xR689zs3SPj7vq0Sfqs4Q1saNjFhxw+X9dkjE19OnWDToh/nfYKtrsMDO+ADuEkFwr
	 WEviM0S4EmTVdGXN1BTJLEr+shdKiqKij8cS2tuV7FsNJPOlb2DMCTWK2Y71aSfTnsA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790868115;
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
	bh=jtZ+Lz7pKjhz8GAgy7aavTdxF4J+Fgim1dkfnZuTTA0=;
	b=UOZ4QTuXHm8xpUg+a6+3x7qX63ub2iINtOt5Cs/6/GsuwMFYY4eHFZ6tuzmWpytZn6Ai
	 HcqUK46mMQkkmfBFevkqSAhm3NGAaylrmtqScD1t7juB3jQWwUqWS56GG1L8Wrw3rYVYs
	 mcvwhE+6ZWVI1XbwUvqtT5n1Xcl8QjBdmAJeYYg+PA51JErV7Vu64QGwNbAZgJpBDqWu2
	 YTE9ZORcXYT6ZDYBR+adclyO+5pN//QOa69XCSSKJHW6kFYENA76kqoL9IIqsda9CazXD
	 VxhZLJo2WbMlqSYSgmvYI0pZ8MpEx16CZdrg0pPdceaVgBKFbkKJoXY1oZJK6I1P+WA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790868115;
	bh=jtZ+Lz7pKjhz8GAgy7aavTdxF4J+Fgim1dkfnZuTTA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xc5Pz0fZEzqCZtXb6W9l74Iy6K2FDu8a5p3EDPV/MIJfbcMTkN+Kw+k0sZdg9mecH
	 wdqWbqjCTBRNBPjbVV78rDosL/6a4nlyGNZhzeZ0tXwxwQMtQ+ykA1hiNVsLMGs4wi
	 xlQK9N8BVK98NK054+ri31EgKyd5tZ1mzAj4y+xzzsAlDL6/Y1P0yt3u7mEZ1NRUJQ
	 J83ROhD/ds931cir49NXy5vT4OKTxOhKxnZF+Po0O4qJ3kOZeO6lFHlbavQxfUlZTQ
	 I2JO3xc6xHfib4eRxA/+7ece30cVBh0befbGjGCt0T3fvWtdg8tc4r8X4McM/IIhYY
	 VDT6YhxIK13Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C2DE60868;
	Thu,  1 Oct 2026 15:21:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 696F73D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F6AA810DC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:21:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VJolEN00N9cS for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 15:21:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6EB8481222
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790868112;
 b=ktFqLTLrrKgnXDSUJUDGC1ltf7WsNjvwhBCkRaDdyJ69BWlgxtlHimsCj43udXCYcDep
 aSfxocElWbBEKkDq+a7cJzmqU1IPqslqDSroeFwzO7FlARPyQrJ2epZtU/9ocTH4JROo7
 NLSPBUhQiUwrErIFc/EtFEDMv1i/boBpAMNAPX8E63OgiZwnOg8iePx+Sj3lCyUQScKva
 a1xnFehuY5pxpJiGCpsCXnVKZk0Fy7rVCPKezEO5jiVnxbgD3rXGo765Ap4cYuZZKr3yZ
 O1Y9uf5hNVXESHR7AujU8DDybaKco6eUa7iz1AIzsYzrMNms6YBypMrUgZc1UMtFUTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790868112;
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
 bh=jtZ+Lz7pKjhz8GAgy7aavTdxF4J+Fgim1dkfnZuTTA0=;
 b=GqrfRlLo2G1P/tIhY3pZxUSdoNDyEbjwRBQvxHmUJFV0dc+y6601HuxrYT4YATkEeYEn
 P0IvJQcSdQOToNvN2VU3H2wXMsy4wBBLLCVZ0+9gTZ6eOEaIxTQQlxA3PXw94bhoqMDN5
 x5/YtvOIKr0Dku/Tfl6qrAlMhlm+Db0h7W4+W02YFEGZhMqir26igsoM0Fj4jn/55A1n2
 t/uWoMsT/38IVciE2k5ka4yageldFSVVQhwlN+3N3vncVpdnsDfUsUW2/wua0zcT7KAL0
 jYFQe2UaPE5a4YC/rxgcoYi5gAFhjr/SGMOMFa+meEOlVX0IVdquL65tIFGWnLF5Rig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=GGjhU7hA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=GGjhU7hA
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EB8481222
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:21:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hV1JsZNVrU9qJA6zzduocQ0hleg4ESAVZBsLsaMPMe8QxyWioPme9kxLbFXgN1FYAAiVGqtMxuyHi7FZJEaOAN5SLLBqNlXanRjSZq7kZgDi8C9w6MzJn9XyoePaK20upfGbjCQikLKs9PDcd9DpY/0YdBbS9Tc3ylzPHl6RzUWjYgGgPFJYy804w7ar1q1bqY8jwJDU/5eUwCcLT60DpGet923h5dTPSy8sDzx0qmnXa4dK6rmDXp2Q+H0E6KqLFHJhAuyJ0lKpaNty0UuIObLtauU+yMSnwGCjXHwyriqmPnlRewNsX/pTdoGtQMAzF8v8wrYkx415rlFiM99HWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtZ+Lz7pKjhz8GAgy7aavTdxF4J+Fgim1dkfnZuTTA0=;
 b=SdBmibZW+vL+tVyld7jTvhLzUxuO93ksphHxcaoPcS4vfPffN8R17Cc7cL4r1ahjVkL+uj/S4UMKMX63Pujb2yE95jrnKgUBW2VX0WwG7mksygYl0unDDD0MF6+RNmHF1rOnbLhpLJ+YjYMKAM26DKvNVUYrpSV/Y7IlBRwt+Gm1Fq6z4EMfbC3TMO8dKQpEPMvV5o4/c78jkuJ7xp1g235tQOujLMRu7IGwfcK9W+MhQYUBfr72Y9+eD+ta4TnbaQiWiJDAH6o+645qVv9RDJfK3Fs/LyIJrNwWaFLZckRp83bwaUgEJV/9hlB5FSyGdwEjcK1HKS8glp/gUViZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtZ+Lz7pKjhz8GAgy7aavTdxF4J+Fgim1dkfnZuTTA0=;
 b=GGjhU7hAhgvvGxOFHCvarbD3QDYmCAHwmuipUoZtgXj7T0/ALrsQ47ot4XgSRzPMqYgesNAEtVV7tzccwYkMF36B0ajnBay6Wfphf55GealxiOMsMGQ3zCBGQtd3MFZCg0YPUxxgWistvsF1Jt1v9v8W+6lxoDM9WgUpoiBJ5ZMSX4RvGzlN2qOOc4PSrkwgdGNEJBkDuIi3txjyN5UK1gWgdJxCJ/yofERhv6e/SjWmv+pQXrE3cMgPItK1km0MtTNf/BuKJAZNfcJYfMw7Pib7N8WWFyfedhwKmW0EJHJaAUctbBj50Me3iBybMbR1LaWveK27dNbOMt74LejOmg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB12687.eurprd04.prod.outlook.com (2603:10a6:800:346::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 15:21:47 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 15:21:47 +0000
Date: Thu, 1 Oct 2026 18:21:44 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v5 11/13] board: lx2160a: serdes: add serdes1:100g4x10g
Message-ID: <20261001152144.bgrnim6yd4bcalx7@skbuf>
References: <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-12-vjardin@free.fr>
 <20260929175947.1379710-12-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929175947.1379710-12-vjardin@free.fr>
 <20260929175947.1379710-12-vjardin@free.fr>
X-ClientProxiedBy: BE1P281CA0490.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::6) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB12687:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4f00cd-837a-4d91-48ce-08df1fcfb532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|19092799006|376014|1800799024|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: tata7Cro9PH/OUMe1s3Mi6gwvOtiEqIY7/W7j+31rQciBjwkcaySkZLC9KaAVCt870P0P20CBUPptIy22qXy87Dr/MaszqKcIiKgsLJJiGmIGKbCfYEJc5a4kYdxE7WZS2dm04CIwRgdnaT0WYuwxmwgldi4nNZxzWNmQsORsqZTCkQLh9AJUWaUboiRdJ1Ow0Z6VFe80DVm6JEp/Jc43X5Jt2OGn0bFg2SAUFFLkuWo5FMg5MiE65s8bU1aH4n6ryz1UZOsNOD/lgSEw2hwG0SzMJUoxS5Vcvw5p5DESNl6qQGeK09YzNCvibcr1vy8NzQ5i9Q+zlElF0WQ1NiIu7eKHp9l8Awjcfszj8AnvZNy4eBrpsQ+fgg4lHAMSt6hbg2/hlPOYOL4nwLWwR2PIBWfms/kfNUZXfSbDIcQZS1KfeYHAD3NQYozQ07IO808JO+0VEWBrTspX45/5E1nX4rG20YP1wJnmu+eYvEw7TsM6SaFqsyX48397KBqWAPZstDYFDKXUipdF2XltqO/wEjsNzQag7k5TBM26WwyTn/4+iTItRGgfN0NH+hSizuOv8DboECqUPpYTmS+aaarQxQK4SRfyGhgm/kxoApUyK3VR5pvgNMg1YyY8we30YAWHiZF4Fx0H1CzR8uvf7rMOqctFkprG25jq/PqyC/ZcWGJWlsSRqKozpVWgr7L4l/mwAIx+1Yfcj7nl6xbMbPGz32OIQPKsswGC8JmD8BsLi95ntd78k8kVAE5WAol53zC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(19092799006)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2erofCc1DnyFhbtfExuQxVlBGR0kZV9XJWs0PqTLx2ij7xFdVeE9IV7CDncG?=
 =?us-ascii?Q?VmpEmhhmPYb9UEnSWtxPgkzXdhKeEuJAMeL35AF8Omt84+Z71lb/fUSsMxdo?=
 =?us-ascii?Q?t+cS02Wf37rqWy0aZkTd7rl8KhlT6ZczA3mET+oYIcrNHxofkHg4T8Si6DxS?=
 =?us-ascii?Q?R0s0/3ckfbcdwjyR57h8wKHYkvRUf1dD2IkiHHjEBiWgfkAePiWbJA2Am3FC?=
 =?us-ascii?Q?Xsf6TwI3QJ27eP8ZNGsyFCdouEs/dqOhFWfIUiAPakPaSWLSm/gDdaDdOoMB?=
 =?us-ascii?Q?Qz9/NvOp5VXRAv5IVXkqZ0zSiiab3HPBOdua7Kw2qsHBPHEzuwbl2myYf4Nu?=
 =?us-ascii?Q?EYcH/maKCA8XepTls2SkRbKVGkV5kaFKPufcgQrYnBl/YXVIIjHuX8B09OtC?=
 =?us-ascii?Q?YlUfANbUrNauvdlCnn5X8OItfnHiBhJfew61LEC4Btd50cD9I2e02AJUGXvi?=
 =?us-ascii?Q?F+N2J1hKHwrB/bxfzfFdst/gWnUIYOInbPYMIDkmIh0RDbWy2880x0tNZspt?=
 =?us-ascii?Q?3udRTwwQjurwDUj6/8ey/iXnXxiWV8yNl205JdC6Ei86BSl5xKx6aFnQdI+E?=
 =?us-ascii?Q?zdphJRyWoAk07a67MYbCZjcmfKuIPBrXRLX/sV8mpjjX7qwCaSvb6Yt6x3n2?=
 =?us-ascii?Q?R17fF1C4GKQL2vqhviDj0ZYEZfpcO0zvCrALYNeIyVReMycUvukaTwqAFrt2?=
 =?us-ascii?Q?0wtxyDUfhu1hjH4xze0XoKpIClz2D+1R6jCjF6x9zpCnzxFKn4zuKP4ok9Pe?=
 =?us-ascii?Q?xbrUkjUibJMTOayzq8dZvvCZ2z7v1GbZWQKMNH+9cOmzzJMQ0bKa4zRqEgVy?=
 =?us-ascii?Q?0FVZU37jLajbUIq9SnljzSwDrb+tXoLOVEpU4+5GFylfbQtCBct76AsDTmGc?=
 =?us-ascii?Q?9cjxocx++MBKWtzHVmvGOWVdFIvMcRt5IqDA3QOvtv2o4jI+yhWFFG8rBjO7?=
 =?us-ascii?Q?6AoxUxSD6EoBpFAS7ULKRU0wEzNlEl3bKvLOFNx4blHWCCujyuCHm+nzc9fy?=
 =?us-ascii?Q?+EsV6PcXwr6WgrPIE6wdGLaNzSTP+hEBexKMpECu7jMprmQGNIecVHoFPxpa?=
 =?us-ascii?Q?ON7XsleJgAT/UHcp5SonQeAGLjr0yHoB2wTw3t0QLSDly+sAe7BJDLJWQpkZ?=
 =?us-ascii?Q?wuQKrcM+MbME+Sli5aoW7gD4VoCiCp2oROB11UeLKMpAVUD2De3Sz6DrMmYt?=
 =?us-ascii?Q?mg4JxqKNCO1ez5wpvYeKRyyeCB5a/LrvzZu7yzs40MgBJn8NHu0EwWRs7YCt?=
 =?us-ascii?Q?0AYtynin9OmIVWkvP+vNPL+s1s8xAN0DvfahANrCy1/gBAUEuRN9T3ZlgxSC?=
 =?us-ascii?Q?S9jJ/VpgERiHnqa/U921We0QgcDQC4yCdKJY4BE0snBDkYTPyWGXyh4BqjUw?=
 =?us-ascii?Q?Z8lLnyUymDTdEsKdrQ6Qb/lFWoBj9sV0L3Zh/2Mcl10S5K16IPAmcZjVtVhX?=
 =?us-ascii?Q?yborjc8ByG/X20qnEK2cYJf8sgIviR79moBmbdbQG7umhMA3uFFteMjqKRvF?=
 =?us-ascii?Q?S/8LpCKVijQPQJnOREmAWMHtt8XRhyaQF0kmWeRrx3yZ/0Qjj3oyJmpU+Eck?=
 =?us-ascii?Q?8HuSwo6XS3DAA0xNvxCGO9NlAkisiK0OrOW0Aaa/8FlBpsmhdFBDxzTYdiGT?=
 =?us-ascii?Q?C7/IXawQFwSVAYZVrF7rHjfMVkiLRJyQHrlgOmgjcSK21dfYP5BGgLQtHZsP?=
 =?us-ascii?Q?1pODT2OLhNbqWUCbwQ8x0d9P0CkE1+EzKJHmVkandHUAyrfPr0Q68JEdTp32?=
 =?us-ascii?Q?cg5Y6JjkWEKx9zGRsndEBvMglkg6TmQLUShrS32CcpSdcOFMpJh4UIj/KuB0?=
X-MS-Exchange-AntiSpam-MessageData-1: bPs6zdFP6dXLTsvNbSjj58fQtezFl8qmXyc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4f00cd-837a-4d91-48ce-08df1fcfb532
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:21:46.9868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzAV9Bg6Mz36HJx9aSeLBtWeh1dlJ2gS/oy2xnSYMyxWkCadEewTtUbOkLWUY7xz5bQfRSOEEj9tmtt52YItMQ==
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

On Tue, Sep 29, 2026 at 07:59:43PM +0200, Vincent Jardin wrote:
> Add the SD1 mode that keeps dpmac.2 as 100GE on LNA-LND and makes
> LNE-LNH four XFI ports, dpmac.3-6.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
