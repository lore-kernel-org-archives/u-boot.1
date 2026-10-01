Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492E7CA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 14:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA45540D5B;
	Thu,  1 Oct 2026 14:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6aoztfSawbH1; Thu,  1 Oct 2026 14:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D35A140A8C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790866541;
	b=nGHpf3RewVBfisMhSCasBEIjQcqiEnBJvqFLzynVkAcsvOSMluo2fltFHcSNbeCN4BDa
	 lTuFTgqrFNpy/hLppZhzglZTbmINMcF2Rf4Pl0WuHtGShJNRQZvTSLqaVfFiOjSHaYbxl
	 8bfJAMcrgwQQfCTJzF0HV0MggmH/+1NVi8++KIGErEWtv53axS/YLPFhfqNbuS1b8OQUn
	 Ddm/jJC+z8EW8tIbyHvottQbHyo5aMSXMPXO/x3y7vFm4xR/y39nX/ctOo04tZhQq4jKq
	 9gZPcyyFgPOUS+nBA3RNalEyIb82gB7phDCBBau+L6dG8/eoJbvrjodmtHvftbV310A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790866541;
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
	bh=EsOZdcrnutVZNi+8oG1ajXOT5NkG0N3N03VNPH5sExo=;
	b=p/77OvWXqSpS1i+YX/CLiszjo9L47c/Py5ty7p+80pFnkOCcdfmR2L7JSdSfFrIorVNs
	 MJqSq2I5ugwWW5YNQcn0vqtR0hAkmi5m59513FgCi8V9UUuEhtmyYSnS22JyD87xTq7B5
	 YyuYV0XfUVAi1iZxadTkZwlQD+JSNKb8j9FchZFffMZaf4VA26kMwmgvtCT5IXGvd62pD
	 BRsC+zJiUH/q4MMAVydSjcpQ1pLc02tz42YTMuraL/YC8YOF3B9mNxm+vlVIZhcPtQ2U/
	 S6IlHWoj+QNmLHh0873/Csnq8dtPT6Adjk87Ggy8Bqh7IgWz/MtUnVz9x8os0OwkCLg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790866541;
	bh=EsOZdcrnutVZNi+8oG1ajXOT5NkG0N3N03VNPH5sExo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nWDBS7M1QSTURwEdQ6mIa83n9K+bwmoN6XtJIBNtO7Sq80XmfpYhy6VpncF16CZhn
	 tXcqks8vBJl4Z2lwa1wMkP9vX0SyJaAADJKpavLgRIEJmQA02FAXRT+q57tsbtNKJa
	 HFng4gqZPU00FF9/kO0mT21669WzcC61MG+T9KeX85eDProVK9IA3k3Akl0EvIJyPi
	 RKSJPg3YPWqqBMqQnqvZd8uGGP7LaxqwFepd0esd8b1Bow2kniSTs8e0C4RU2681O7
	 mIRgnrTnAJ+roKi5CRgFXoCgVELY7Fn7DBpXDuu86zy1kd4H5ehpUyg7SmTvEplM5e
	 viMTLgC4xcyIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D35A140A8C;
	Thu,  1 Oct 2026 14:55:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60335282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 14:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4623640512
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 14:55:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bj8_bEaKruqP for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 14:55:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CB26E40098
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790866538;
 b=mi7Ad145EC10Gg0tgiYJqBeXhfM1ocQz5xe02qYWRVdzQd60MV9ZVWtu/ts9Tl2J0FEM
 lQUQUj5F1+yuMtYLfZUrIS+q7TL5bws2to4sbP1YpK5HhDshdgpCfzY1M6GorAqAwRN2w
 GylbyJluPgpi7KIZsZc7vrZ1bUX30qcahk3q+kOg/w5lqPK21OJWwIxfRYA+dhRYFbFZR
 CdikHrHUP5oH7v+fXAZNcDbc2ZCYRTTijgMv/t7FKfPfpaEQX/mn71+XUCAk3EpPv/Xfl
 TXdctgvZyv4QgftD+n5Qegx2pcvN46wctkuQZ460CnT9M4rlzs/rA1aZbJW7US8uQ5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790866538;
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
 bh=EsOZdcrnutVZNi+8oG1ajXOT5NkG0N3N03VNPH5sExo=;
 b=dOZZRi7MEWWBnbxig749q/nFhOhIJ4Ef8LYEzIfC6aVzWQ/A6OLY8TBM47SYUXDfy9bH
 l7ohx2bnbFvlMowZ1qxgHJMO3KB/9Ur3Wu+t+WhsrjvJM9ZCcuhDYcMHrVSLwxrv5JUes
 TT9QNNiLi6arJJbksufa1ORCNcBtIPO0a1qGWjrnNjwSbwBefcf7iEC48sLZ3CC9gJdon
 yGCPUakqj9m/WFUlM+WdPDz48mo0ccCkLWpO1b6JZ7pjRP51pUlKSf+AypgZ5MY91dG5G
 TXECDx+mFzfw8nmYSshf8O7d7vH/67T8YqUazQeSXVUODuP7DWGMHWJBLx+UPqguKpQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=I6QOROlq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=I6QOROlq
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB26E40098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 14:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXe8k8exH/0jRgBbBTMNJmofsR3qkhe+oD00HNl9yuNbbw6y5QRbcsrfcXgHPZ5WMiuwU+pq2sAqYiHUWKwaOzby404jm+qEDRQ8CNjB2310OQMiDgkB5c4n1M++zXJE6UiBd30wI3aRv8pjK47LY7615AVAPQXKDZvbsjZC1Xj1WlMJBQtyC5Grg8sDBhUP9vKIBK15MnUX1X6Z6xUDdksfmZdEftxtEtYj4LFPJzl0qwuS5Fpbjwyj5w818jad66EUOGuiu5HMS6RucDjZKR+OmmGAsA6MeMQgGbVGzYVuzmBdLHqJGeL0XDQtAq++dLhsSTBulhl3kncBZOL54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsOZdcrnutVZNi+8oG1ajXOT5NkG0N3N03VNPH5sExo=;
 b=PjQs6cPlYyOtADz0rtahq8JM0QDQgqfbvIJhz4k7DHnQVWScWv1dA+nDrq3A2VKb9ZiL9m2v50o/q+YGcwBHps3OlAz/fxvrLcmRVzYvU8bYDbp2GBClU4bK7Cy6LrK4zTEAgQFi357RjCcbobGKnU6oeDGPt63S5GlLuqVRDWNdp90ss9gLblowBmbmcgK29zzsqJf1cwEQmPS3TKTS2XNfGrmiCGL88cPczJfLuffh1xjypJ3hQT0vlZFhowsD9Cuqr33/El/OG3drXevXd8wXEBW+x9HexzOpsPNy+J7dPox8sauLSTn5VPSPuoneReRsv+ihgRX1CoSJf7Qmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsOZdcrnutVZNi+8oG1ajXOT5NkG0N3N03VNPH5sExo=;
 b=I6QOROlq+a9olWjmfsj+XPrgalX7Iyf2WiYeaTF73uvEUheJ1uiZH+IH+YaFevtwt5w5hP+ZaMYkVrzlCqqyoZpIfbDinpb3XFiKLUhqLdivYjQLjn64sz0cy7nyeUH6Eo/V9q0O+Fa/lfdwR29FQ9it8WuZH67Jd7y9fG2D8sqJAeNf2cRHsNGH4Kjv0g2nIsSinc00W5c83nJBO/i0W3/GndE8yRXw0gzKMnJPgWe0kJdtCVlNrFxBHcA2Pg+Udm9ZcaP1gC4snQStasnTMucleTU6RhZEOuqBwwMoou40+/RPx4Z9JMOjjbcPVwj6ln5U7ak02McKiTiBftiNMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by BR0PR04MB337759.eurprd04.prod.outlook.com (2603:10a6:2c8:60::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:55:32 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 14:55:32 +0000
Date: Thu, 1 Oct 2026 17:55:29 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v5 08/13] board: lx2160a: serdes: add serdes1:2x40g
Message-ID: <20261001145529.k6qqeqdl7ebdwwsg@skbuf>
References: <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-9-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929175947.1379710-9-vjardin@free.fr>
X-ClientProxiedBy: WA3PEPF00000523.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::66d) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|BR0PR04MB337759:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc78116-680e-4635-21e9-08df1fcc0a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|10070799003|1800799024|376014|366016|10067099003|260925021311599003|56012099006|260925022911599003|6133799003|3023799007|4143699003|11063799006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info: vQKK1QxLB/fbzDjGzHCZMO2wbHVfarKXMiE19Mc0lJ4SnSygnu4MvZzLkNtWZe4ivPHWjJLAGcDHVNmuKaW5JOq7ltB6ju7CiRxCby9bpJWrY+wc9zTIQNzcuOmNgONkYG/qJQIl5/RYuwmMq0YFjWY2dW0RPdLHHY0azhV0T8IAiNgRAY4AQzayWL+WzsvbD+5PlrxfGK53rY+0IJDk1jQnfu3+OEHnuD6L6SIYemMjDFZzXfHpoRuhVfJbvQWvqsptLjCX2I6n2MbsDc3s0gMmM8Tnfwk8ZOXkQMq9koTrpRC+DvnhFpWJt9nO4DLAaUrriIBT78/MFqFOE1KtoOxgBC/JmpNYPZxDpU/pKLPCxd0YW02dO6sqz5WYlXMA8dYvYxVIAN2Uf1erJcy/TM+VX9zJXR18kouoZ4TPnmILaEzPvTudBUj9mQyBxpyg65+4mXPjXQ5icCkPNy3/lRlUSYfzYI7PjfNhjlq2iQccNY/ylj77r2lvsMQJ9UHpJv34OB3lRnHmXWtv2O+wepJPiO79mCRwvcx69cjJ88vioZcHfvzWIaedHClDh73GwPuV6aChs95M0ns8SAau3kZz1FRI7xUglfu5T6ZDxQ1pU6ag+KOM21PY7WogZf1U8R2CzSRO6w/2zF82fQHAmIIEoDHRHy0NHxCQXnnJhxQhwx/v1yWaxJDXAbhQQpgJ4xplisDpbwgvIEGU/ZERFsQKPbQM06U/ueZnJmSUXAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(10070799003)(1800799024)(376014)(366016)(10067099003)(260925021311599003)(56012099006)(260925022911599003)(6133799003)(3023799007)(4143699003)(11063799006)(22082099003)(18002099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVU0aoKOZ39lSDgEj4UoUIPTdBqKLOM8P8F90/flFF+WU2D3tCVhzE+bI7Oa?=
 =?us-ascii?Q?PrjjNWXJfROgk88XFCA0AC7Foq6nM5Oo+u9wtrMoXegyONPnDHHtESqe7z0U?=
 =?us-ascii?Q?XAs7jqPkkY3NvQzLkYs1pTSYc7MJ40B0H8rmBs+hJI0juivCxAvQwum6EycY?=
 =?us-ascii?Q?h7FywMZqV1B9X3vE5h3+JntKTxchaXqe6prUBnTIsYKksKy0paWoW+BWYvTw?=
 =?us-ascii?Q?NOc/vmQlVDH4aEV1UHnynrkkE+DVAXL64u0aimOKpsqSWAOaWpUwavIdOhZP?=
 =?us-ascii?Q?86HXEJYEnTs7uGQEfBn2yHuKSyqvj1XtqrK0y+ZFpO1Gk1/yuEedeMBBsAwS?=
 =?us-ascii?Q?TLp/vjuNQwyVebvZAV4Ys3F1dWE9Fafv6nQw2/6z0ZF+xLl78GPJeeLVnvg4?=
 =?us-ascii?Q?s5kqXK8W+W6c0btYggKpzhQkW9Ouq9hQCIYcgIiUvGopxcwBbYIGuSb6VChI?=
 =?us-ascii?Q?dSvGZOJmyE3NnTRjsWOmgiTw0f7Qpib/j9921eW4AvFGeH6oSJi2Ehckiahn?=
 =?us-ascii?Q?YTgCtf2ntGEYTr8ioZURH+mTzSvjwoXjtmdtcDEHevzDIZR86K5AR1kE+5PZ?=
 =?us-ascii?Q?+anjjfpK2FhV2g8QSubvJIqspKa7wdnMBpxCHbGH1b0nvMbaMZHow3IVnuSX?=
 =?us-ascii?Q?TD7uAf8w7Uk+O36VFkFCK3oyRVqkT3jhCA5W0iMagavZAtfnscEZ99awmwbv?=
 =?us-ascii?Q?ZvhD59J8C4nhfkZgP/Pinnuv276GuC/jG0bCTCCN5KaavFD0iA/u3IpcgRrO?=
 =?us-ascii?Q?NpEkbAIaHghCzqyqhWJ2HcIlU1zQ/iZxh9N3jpTPakywwE/i7SCuKkqY7F54?=
 =?us-ascii?Q?qsHZUGrVWqRfSxnPz4ppVDPU+ScyJStfskOlIfTaPS8oBQPWGWjZ9e1l1r2y?=
 =?us-ascii?Q?nIN+PwQSZiFvCOVdFDglTQpb5ylpEHT01xhX1E3HoFUgLB6J4StJRo9E9UD1?=
 =?us-ascii?Q?KTOHJutwO8BgWCUtpjiXyHBhzm9UUpaknwRtSChnP+4yDiOiJCu5syPGTf+0?=
 =?us-ascii?Q?FHIEy4jqUZTMgvktrydvvIMbfOWHpBRDu/2PfsDoEOzoZc2sgJCJqaqpq7pC?=
 =?us-ascii?Q?STYr6GTuDMIvW4p0eI1pC+eMswfxhB9pIV0NjTGB7s5qEwusy/lh456w/e0d?=
 =?us-ascii?Q?jL2HeQgAfqyKw9pK8Ejh/oGN40FL3Tr6kJUwqJFmXAC+H9rOAye3eQ2SNR6j?=
 =?us-ascii?Q?psMn81R7HPYGQ8l4L/AlQUi3QTLVbvZLsIkO23j7N4SmSpxvQk79vuLmyPIv?=
 =?us-ascii?Q?m/Dl8gWPrVeYnvsSEPE1J9XDATCNuKUUC+U9ZQILGRlOoVr/N4U9OXV0RXJA?=
 =?us-ascii?Q?eX6vOaEJ/ARltPkJLsGQxS/GKlqYnGU995tPmMZeS9vvre3vqO2PqNQdc1kB?=
 =?us-ascii?Q?Af0KXBjeGM478/hlTQCD+RHlQbUdX9nS1hWdofkhcR8P4R9DxHT0ZoBHWHW6?=
 =?us-ascii?Q?TcJkpX/kPnZ6o1higZQBt11e57uq6dOZ/oL0ZzKEJ8pc+eDoe5+7ensuxqKZ?=
 =?us-ascii?Q?JTS725OEKPgveF8wsS5LXUZP4YvSUXSayxyQjvRdF7r2NEbV5lrBrOeq1Z/A?=
 =?us-ascii?Q?xkhtsc58NEvr2lk5yqPPqOovYJpeowx/i230kQ7DWnqYwj6IMrIsWkKJ7n4l?=
 =?us-ascii?Q?4d2nySTJakm9JkzYuaEsv4jdowidGFr109dpMpwk9XIpF9H1MDnp0Byfn8O0?=
 =?us-ascii?Q?9O5RP/4oOOdwjNUvBxY8WXUY60gS6Z5/Veg4PgEMtXfFkOJXNxCQZdT46AZP?=
 =?us-ascii?Q?/lycFn8r9O05GWzpL6yc1ST4sNsI7l3vmNfgvgp347h+3bSQFJHy0AjwC+pb?=
X-MS-Exchange-AntiSpam-MessageData-1: XaboLuzpYquaP65qur5yQ0SmlWZlCkh+rUY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc78116-680e-4635-21e9-08df1fcc0a9e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:55:32.4102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ziie+P8pYLtjXohfLl+pK+YFxuQz08ARYQ/pR3C5+Ktt+MCWMHAP4Wzf6vBejbn5FEuMS9YgXJKX275nv5gDrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB337759
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

On Tue, Sep 29, 2026 at 07:59:40PM +0200, Vincent Jardin wrote:
> +/*
> + * 2x40GE (XLAUI-4), dpmac.2 on LNA-LND and dpmac.1 on LNE-LNH,
> + * protocol 20 builds the same.
> + *
> + * 40GE lanes run at 10.3125 Gbaud. LNmTGCR0/LNmRGCR0[BY_N_RATE_SEL] is
> + * the lane rate as a fraction of the PLL clock: 011b (double) for 25G
> + * and 100GE, 000b (full) for 40GE, so the lanes cannot stay on PLLF (fast)
> + * and move to PLLS (slow).

I feel there's a bit of a misunderstanding here. The conclusion is
correct (that 10G/40G lanes can't share the same PLL as 25G/100G lanes)
but the justification is wrong, or at least very twisted.

There is *no problem* with the cited reason that the different BY_N_RATE_SEL
settings are why 10GbE/40GbE and 25GbE/100GbE protocols cannot coexist
on a PLL.

Simplified, a SerDes PLL has an input frequency (called refclk; REFCLK_SEL)
and an output frequency (called clock net; FRATE_SEL). More importantly,
in some cases:
- it can produce its output frequency from two different input values
  (see Table 295. Valid SerDes RCW Encodings and Reference Clocks).
  Example: 10.3125 GHz clock net can be produced from 156.25 MHz, or
  from 161.1328125 MHz refclk
- the same input frequency can be used to produce two different output
  values. Example: 161.1328125 MHz refclk can be used to produce 10.3125
  GHz clock net, or 12.890625 GHz clock net.

Each lane derives its frequency from one PLL's clock net or the other,
and has its own independent BY_N_RATE_SEL divider/multiplier.

The problem is exactly the second bullet: the 10GbE and 40GbE protocols
require 10.3125 GBaud per lane (this is simple math - 10G at 64b/66b
coding = 10G * 66/64). They can obtain this baud rate from the 10.3125
clock net with no divider or multiplier.

Whereas the 25GbE and 100GbE protocols require 25.78125 GBaud (25G *
66/64), which they obtain from a clock net of 12.890625G GHz and
multiplying by 2.

So it's *not* that for 25G you need to multiply by 2 and for 10G you
don't. It's the fact that a single PLL can produce a single clock net
frequency, and no clock net frequency can satisfy both 10G and 25G.

> + *
> + * Protocol 13 powers PLLS down only through PLLnRSTCTL[DIS], which
> + * software can clear.

Technically "does not power PLLS up" rather than "powers it down".

> PLLS then gets the values a board booted with
> + * protocol 20 reads back.

This sentence doesn't make too much grammatical sense; I don't
understand what you mean by it.

> They are for a 161.1328125 MHz reference clock:

So SRDS_PRTCL_S1 does not influence the refclk that the PLL expects,
instead SRDS_PLL_REF_CLK_SEL_S1 does.

How this works is: whenever SRDS_PRTCL_S1 requests a protocol whose
clock net can be derived from 2 different refclk frequencies,
SRDS_PLL_REF_CLK_SEL_S1 decides whether the clock net will be derived
from the lower refclk frequency (if 0) or the higher frequency (if 1).

In the case of 40GbE (the protocol selected by SRDS_PRTCL_S1=20):
- if SRDS_PLL_REF_CLK_SEL_S1=0, PLLS will be expected to have refclk
  156.25 MHz
- if SRDS_PLL_REF_CLK_SEL_S1=1, PLLS will be expected to have refclk
  161.1328125 MHz

So if I understood correctly what you meant to say, it is not quite
correct, because protocol 20 does not exclusively dictate PLLS's
expected refclk.

> the board has to feed PLLS that, which the RCW does not
> + * describe for protocol 13 and which cannot be checked from here.
> + */

Technically, the board does not *have* to feed PLLS a refclk frequency.
We have the SRDS_INTRA_REF_CLK_S1 option, through which PLLS can be told
to internally use PLLF's input frequency. Due to your use of 25GbE/100GbE
on that other PLL, I deduce PLLF is also provisioned for 161 MHz refclk,
thus SRDS_INTRA_REF_CLK_S1 is a viable alternative for this only
configuration that you support.

I'm saying this because your patch is presenting "2x40g" as a single
configuration, when in reality PLLS can also have a 156.25 MHz refclk
and a 10.3125 FRATE_SEL, but (perhaps confusingly to some, who will try
to reuse your work), this configuration will not be supported.

Is this what you intend? It doesn't necessarily read as a conscious decision.
