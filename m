Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BA9C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDCF660666;
	Fri, 25 Sep 2026 13:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6hxsiwqZ1qW; Fri, 25 Sep 2026 13:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 12C0A60C09
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790344686;
	b=ptblVYP9Puw2AoRFRzA3WRoz2ySvoXcWslGAl8cpIReIFEfj+VuGJLAGmGdt3d6bG4cQ
	 pQrB6uiG+riysWIBSQO+nOD9ni9PVIdDzQ5QMpTDzW8IDodTtIJDOI/GFT/DzyKqZdinO
	 Ksjh3WRX8FBgOdYiKu7rDAqsLTkQ1cph0p6BPP5vU0KCdmTw9hhfzJCDVPJMyN9B9ifIr
	 OvHWrDgsMIP89nDgQaebtZciL1kVmps24ydceInmdfLlgbS10TCUq9Ze3QIs0z09Lxs5I
	 i0J2u1O4tb7QrloHTDiUV+0Yww9RhilLA2MyqwolSdVvJ9EcRXtNjRZvrma/CErUHAw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344686;
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
	bh=Y1rTad4YOxRskkW/e+RmW/M8J+3jY/HQ9pPUVKyEkCQ=;
	b=hYuNFoES3VgMB8xmjjRgF+48zVVDIPEf6yC0CQ4Ir7wJkZhRW8h/lL28BinhZh7ffjQM
	 Q1uQh9beBOXnYw9u+pi1jDnSScNY1l8NxabEAXUd6csPN+NU6qAzNtLEdGqnHtfjhnJmx
	 hT7hfhU2WT32Wxl6G7xvu7EnLhJ2WWMTtBSNBJnKxe2/Jes+YFzeoklIcHFhlTe51ZScg
	 25Sv618Zmc962LKir++Zm4KJ9W3blzaJOIv7d+QnrN0UNlj711ge51ohZcV29wIS+EwCF
	 HqO+/2DgBT4tYoV/Nnw6SHsc46iRk6KM5sVGArCyL0D7bBc16y389+nPxSTpzbcjE9w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dGGEMgyW;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344686;
	bh=Y1rTad4YOxRskkW/e+RmW/M8J+3jY/HQ9pPUVKyEkCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=asZmu+fqJJ96gdqRTp7b8CFmNRpekn3p2g+WgkcEPVGp2zQXJ+N27/ID+o1Nc74w4
	 VNGMRy7J7ggRdhMZDlg059WwZYQaxzCbGq8KdcxA7YinkecfIsTUSgq/6FDLcpgbqa
	 gU6xV9jyunWKDatBWQW+gxziC8LMAZabO8PAclmVOFIaEu7QKd/yahTmXp9ZMH4UAv
	 rBidir+860/hwwXwNab7QDRf+qOVyFrWKrH1CccSVVMXFKhxp7MuOrRZfii65CIW1v
	 vMlBbtz1CmXYjK1kZPunvGug/UKPuWC/7SFb1ykBonvyw37VaXa2CcwNrQQgOEf2Mh
	 hGieMzmz2ATmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12C0A60C09;
	Fri, 25 Sep 2026 13:58:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C625355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 156A560666
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fo0dLDOQXIZX for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 06E8560D68
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344683;
 b=gjrPmzjJo2EDcwFp6Woi6d5yStRhXXnkdf07xXHvViVkTp+6n/msgjKHco/0gIBgFT63
 KMCP9HfC2Fq/3BP80JvlIxILDbpdmYSjus1LOLe1UITAXdZtvj75Ob2pG+xXoNaKmW6rX
 nIXBFbZzbYgAid9bKnQGCaDmhrKYny0kwpPND0zOi+miNqIhdcsTWeqQiQ6A6Xzsvt8Fp
 utAQ5CbX2shUhahYajFB2H4haZDnGzUZUtNNzT72wajRMBaLoETWfNhOxgcJvlBAuzEIK
 uXFthr+af4RAv4OMPyo2jS+ttw/PQdrqM7Iw2gnZ5IEmFFsF5t9SAKvijpJQ7451w5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344683;
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
 bh=Y1rTad4YOxRskkW/e+RmW/M8J+3jY/HQ9pPUVKyEkCQ=;
 b=dKryjHGfZFaa7k+C1jkEwiAkVKHURRMLRbapSbRCobmcnJqJHa5aiyYcE/TpHzN7s3Oa
 07EphLaP5zQk6f3BLLK0irsasCovRXbRjdUHei4YPHU9OXcoEOlrJ8SclZBBd63l5FDMf
 r3GQE7MUh7/sEHlesPPwnlZy38gKF9/Uef/oDWb9eyuVP6GWMHQz2d7TS6PlyY8Ewm5H6
 bnQwpIgRgzjOozPSNegbrD22Wd1BhAqam1ptKRm6rKKCKwDo2SUGB8cZX1LQ8SAZmG3oE
 86U+zhORd9RqUP8IHTIYUWR/5Yoiv4wbKS7MfKbAcg5l8nmDgBUXLO1hUZI2HC7O8Xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=dGGEMgyW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=dGGEMgyW
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06E8560D68
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnUnMdVyIUwneqHDhHPVttU5Wmp+FG/mALCe8lZpoTll5aTll28nzQ1qFo9UPgW1XTAi6T0bSpwBYORHJhilTUkpI3aTn9NQPS8LfDVxpslSZfvY+GEHrAPlvvuGVicsy9NA5Z31gG/quNDHgN/YNQip5mTM6dxQMPy6YswrVK0zG3R+8w8ywQMw6RFk8KjoY4tfaZruBuOgUPMRjg2IdTHaTDOTI4xNLowa+pHI9JSrGF8mhO7joNVjgU+mp8XUmY751RUDuil9bwir5x35FcLTUuFPJ7ueKV/v+P0L+zyL1JYj7jPHvPQCL9DT1DKdO04NrXnBgYKc9mUk2u6ubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1rTad4YOxRskkW/e+RmW/M8J+3jY/HQ9pPUVKyEkCQ=;
 b=HNTMVxrdcjmRx7mvtyJCB02cvv1EBW7Wxx86Fb3xh2FfgkM6dV/qqihhm3jJFD845N5qD3REFU4HeTmb18HHbVZTGK9jjMY+cW/K7qxB7lWVtc9d/RFxzFl5ng2Yww3czT++N6DZ9DvzC4sfsHAUmCtgHWMF6EywBH9O0yAQs2NyU3Wpt/mcakosTh06s587Oy43NCDmoVYxIYIrSskJXbh7nfswYPyjeSH2uFs3WrlGkrSz4VY2txRbx/JqkWdVnRFm7yw6MMXbROOHgvkdI1UvuknuIUF4qZL6CLYxxKNwOIJ75KYUY8SCEv10oF0bO92MtiMLaBW6HPap994/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1rTad4YOxRskkW/e+RmW/M8J+3jY/HQ9pPUVKyEkCQ=;
 b=dGGEMgyWjIP7RV3kNgy0T9x7MPMiew8tf37pfHo5vI76FtRkTZQsuChujVzuirGKO8uqTDvqM3dmV1bcRJqHXI1erbhQdrhE5tsvnCjjwM70i1249XT1W/K7EPQoeOaQOftQ3hjbUGZZAOe5Dz81y2IiPUjGYHPmOzS4RbUeIeWacWbtua5i4Qydi/2+qYvbm2Fe672vr7AJzOS5DNEYk9WW+DwFyNZlSUkyim8jrTLim0jBmhfY5yqiC91WSCJdnt3+eEEx9jMRXaGxVcPvVgNAnuVuGVFJRaNAe6Qlghm7c1qW4hTEu04KAJrnsL5qWex8Zj8GbqJbjoE6PNQ4FQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by FRWPR04MB11200.eurprd04.prod.outlook.com (2603:10a6:d10:173::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:57:56 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:57:54 +0000
Date: Fri, 25 Sep 2026 16:57:51 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v3 5/5] doc: lx2160a: SerDes 1 runtime lane grouping
Message-ID: <20260925135751.yhiymkswdzcrr6a7@skbuf>
References: <20260916211549.3432913-1-vjardin@free.fr>
 <20260916211549.3432913-6-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916211549.3432913-6-vjardin@free.fr>
X-ClientProxiedBy: VI1P195CA0045.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::34) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|FRWPR04MB11200:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b07f538-6a53-40d5-a944-08df1b0cff2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|10070799003|23010399003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|4143699003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: htEunwEcnLxEMlTxnshmF0XVj3zG0jDe7lTH/ZKoS3lp5wsR8q91Z6CucNGcTCwdvZldn1aUo+0CZTUhI4YRpsnM6xS9yrcCzPHG4BsGHYUzcAAQzF9JTbYeMtVUk8JDfui6KQDyEukj0/PLW2/3YX2Yp9VI8Q0IklhJE6cPtveM0Af6FnG0p0wx3yIYuWUUVNvyoQYm88ejzDIM22XvQq10s0A7IIEbI+nerwq0CULHf6Lj3zmHWmX5Cwj6TLuI+c9TT7N+V3/D2aLs+Q2+atcqg9dpQzqYfzrQHUxyD1NosPG9TyhzxsO9IVpZ5KST1NpcYqP6O8c98jloqGc8IegNXpd2VEV/I/CyQw5SlMUhhz0Nf7y9Oy6gIgenZJhn/XJtQ/GTEPNsQcrm01LoraQWQ/8dpkf1ReTHgHbi6CLZjyzzMRnOM00nl6n3L3LpOnoutMnygEhhAIVBK0h3pqaF+MWixRQSqYu4wMKCn44BoNNi0DQ4C6m+PvFAAQJdJR9knjtF7FDqRheUo+bs2Eb4bERspT4ewKWA9XHSOGu92Vsod0w6xV6T1qriOWhYDT7McwZ3eeziBa4oOjZ+DfmuPscewW/JHEANRORcBO9ZRm3/YkFl9sUVI+l365UfveyiytwtM/gxIRDBIvGNxtwWF2wXvnZb2Lvy9ey8wvh834CFp4jlqHEoNRViPY+zkL2G3bZLTyaqOVdLzK7RWswhczPu7zIyYJj7QzEiRZW8YR8ir9N1bbMWIw1p7zMP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(10070799003)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A2GXQUXzY2aQH3GWwUSkiJAz9pU9o94iqoq5c3GqRWWdwlSyBlc9PAn6Z/VV?=
 =?us-ascii?Q?R5F8EmLFXZdJJ1VKg0QIgp14bDdZHi/vDCfpWGmgFj1VZWwyCTFqfMaGZeAA?=
 =?us-ascii?Q?mB8ci92gOWfc3VBGS5nt7vBcOyc4UT4PoSwyu/tu97q78AWUs9M11I8LACqT?=
 =?us-ascii?Q?w2BUjUt3KQUJIEnAT7CTAZ4GfgceKp2GKZaD+tdLT7CYggGKmhL3rwhFyLJD?=
 =?us-ascii?Q?PHc25BTxPV92d1AFrToU9qIgKApreHfkZh4w5ifIjI8+UQ3GJgDuNqeU12tZ?=
 =?us-ascii?Q?h0phK3HYjpbXxzq5NziAFxOoIpn6oyG/7Juw+Kkt7Zk1iksiTzZwH2p40iw6?=
 =?us-ascii?Q?jL4RuitvZt7PtFyXU89ZPcGvqvmLFi+HoffTFdIZuQ6l2Iq0rXwNSSsKV4gU?=
 =?us-ascii?Q?KPPuRqJEFIZb5/X9GavbAJMEKc/bztdCThZqzKTV5H3Y7g1JvJbA6AQaE8GU?=
 =?us-ascii?Q?cmlNn0mcXGq/64zZjLGMcQcWuYMc7U7HKqL2BaDuXl1vl2fo6AVbqE+02h4s?=
 =?us-ascii?Q?vCaaBi+jOSTBgCxyB9xt3Or7Ym41a48UL7+5ET6pWQ9WLof70fDo+JMJQUaq?=
 =?us-ascii?Q?gJH07itnv64QqjkOITborEbKYKzmdOiXdmTXjsgqVmzmK83JKuLYeOtbnUJ8?=
 =?us-ascii?Q?QKwdouV5sItRjA1GkuGFSnv3CCF/9VlIT9tQal99NGY9tnk7cts13sJG+dFt?=
 =?us-ascii?Q?rzZRF6gB9ukzPT29u/U01m+d+2mudCRVFISyY18nx5UCg/R0MiCUG99Rmy1o?=
 =?us-ascii?Q?3zwLnG5IuGiGkKLKyHotuyWFYD4pNnEQZqKvS0lTkt5GbDNCo4isOb3Rgu6M?=
 =?us-ascii?Q?BmEtWWWYXYpYcDqgv3m19IEWDADy6IWkQrge6NYJGcE9bLfbhqMSF075fGGO?=
 =?us-ascii?Q?DWfKfKvexBe/QaX0KGnQHsRNaJbGTakETjk3gkND/47dd1kDdKf5Zfu4MJii?=
 =?us-ascii?Q?+0ZruW0IzWSL0oHyDyOtba1NBiIML9e4N6cH+0dpXqSAKNsT059Cqi7g+DQc?=
 =?us-ascii?Q?Fr0bHxlTwOFnmFNfH27VUGPTb4s4GJXVcBaIkb3wtI0RFo+cTVbQgm5r1U2S?=
 =?us-ascii?Q?Kv5Ph3JXP7ITisv4e7o+Yrgw0iI5AeMCmhXiwMhWV/NIlpyBJ5wu2latSvPQ?=
 =?us-ascii?Q?tC9RArvv5nKlZLQ2SUCsAqdhIIFACZnSccDOkfkZWIERXN7UBCZK9aNu6/D/?=
 =?us-ascii?Q?X/CQBgFjs6bWZ9+8dmuJaktbRkeCemwctGoAKTTnlX195tDYF2FbZkHjPgRK?=
 =?us-ascii?Q?JUUxVZRO2KfJcim29hduNTbSbbWH7VjigXuAgA8f8V6Q+SUzzYOuDzwQa5+K?=
 =?us-ascii?Q?FIQ6Xuu7xSgc+MlB7bY+8pY9VnAjX0pm1WvQ+ai1lNrCns55nqou/F9Q3iCX?=
 =?us-ascii?Q?9QfEm2+w8rW6QfucsOUCCjMH6UYRAL9LFPk2AMqliKeT9nQBuBFYkgiJ1VF2?=
 =?us-ascii?Q?AoV8ioMTGKS9kJo7eOQjX637Hgi4rti/89rOPxbQnHdDJAjwgMXD33cnmt8N?=
 =?us-ascii?Q?P5eLivrgzrVtxzw3xybJGAMu/IfmDGeJaL7PDBhdemDwX/GavpoLYjv2G9Ve?=
 =?us-ascii?Q?F+GKLUuKWyGyZHrGo0DF777HemAEB0Nso5KoxXTnQ05zWOFkay/DglmINNIW?=
 =?us-ascii?Q?jB4RFUYLvpOkhLFMaUjUL5xwcrm8tojdWYnn/e6J5woNcZ3oiRXA3hyLTM27?=
 =?us-ascii?Q?bmGg5kClckMVLvcl/N4QRXRS7S7DkT606WN1ESsXzL9I8O1GIngXZmqscBVW?=
 =?us-ascii?Q?yVRulNVUXfYQknAKjcL0ncOhW9QnOQ6NRhZlqPQzfd9k+XT+K2HapzMSF/JN?=
X-MS-Exchange-AntiSpam-MessageData-1: uLicH8c1cEpEZQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b07f538-6a53-40d5-a944-08df1b0cff2a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:57:54.5589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vm/EScxCbDdSrOiaKi5RWO2Anrmgy72pQL9leSfzlAOyOlrQYvzViiV3S+BmySwf9uDtteRQaemA33v0PIC2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11200
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

On Wed, Sep 16, 2026 at 11:15:49PM +0200, Vincent Jardin wrote:
> Add the 'serdes1' hwconfig option to README.fsl-hwconfig and a short
> note to the Layerscape README.soc.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
> 
> (no changes since v1)
> 
>  .../cpu/armv8/fsl-layerscape/doc/README.soc   | 10 ++++++++
>  doc/README.fsl-hwconfig                       | 25 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
> index f2efd4cc1d7..a6f729059a1 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
> @@ -332,6 +332,16 @@ LX2160A SoC has 2 more similar SoC personalities
>         a) Eight 64-bit ARM v8 Cortex-A72 CPUs
>  
>  
> +SerDes 1 runtime lane grouping
> +  The SerDes 1 protocol selected by the RCW (SRDS_PRTCL_S1) is latched
> +  at reset and cannot be changed afterwards. On the LX2160A boards under
> +  board/nxp/lx2160a/, U-Boot can nevertheless re-group the eight SerDes 1
> +  lanes before the management complex starts: 2x 100GE can become
> +  1x 100GE + 4x 25G, 2x 40GE, 1x 40GE + 4x 10G or 1x 100GE + 4x 10G.
> +  See the 'lx2160_sd1' and 'lx2160_serdes' commands and the 'serdes1'
> +  option in doc/README.fsl-hwconfig.
> +
> +
>  LS1028A
>  --------
>  The QorIQ LS1028A processor integrates two 64-bit Arm Cortex-A72 cores with
> diff --git a/doc/README.fsl-hwconfig b/doc/README.fsl-hwconfig
> index e752505da49..605a5fd0d77 100644
> --- a/doc/README.fsl-hwconfig
> +++ b/doc/README.fsl-hwconfig
> @@ -44,3 +44,28 @@ usb
>  		usb1:dr_mode=host;usb2:dr_mode=peripheral'
>  
>  		usb1:dr_mode=host,phy_type=utmi;usb2:dr_mode=host'
> +
> +serdes1
> +	Specific to the LX2160A boards under board/nxp/lx2160a/.
> +
> +	This option re-groups the eight lanes of SerDes 1 at boot, before
> +	the DPAA2 management complex latches the protocol converters. The
> +	RCW-selected SerDes 1 protocol (SRDS_PRTCL_S1) is latched at reset
> +	and cannot be changed; these modes change what the lanes carry
> +	while keeping that protocol number. The same modes are available
> +	at the prompt through the 'lx2160_sd1' command, and 'lx2160_serdes
> +	status' shows the resulting lane grouping.
> +
> +	'serdes1:100g4x25g'
> +		2x 100GE -> 1x 100GE + 4x 25G
> +
> +	'serdes1:2x40g'
> +		2x 100GE -> 2x 40GE
> +
> +	'serdes1:40g4x10g'
> +		1x 40GE + 4x 10G (converts to 2x 40GE first if needed)
> +
> +	'serdes1:100g4x10g'
> +		1x 100GE + 4x 10G
> +
> +	Only one of them applies; '100g4x25g' wins if several are given.
> -- 
> 2.43.0
>

This is way under-specified - lx2160a_serdes_apply_hwconfig() cannot
fulfill the hwconfig setting from any initial conditions, but you do not
mention what the expected initial conditions are (initial SRDS_PRTCL_S1
value and PLL refclk frequencies).

The current documentation reads as if the hwconfig can always be fulfilled,
which is misleading and false.
