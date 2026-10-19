Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27405CCF2D3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEF1A4064A;
	Mon, 19 Oct 2026 11:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UrY_lQx5_4Z; Mon, 19 Oct 2026 11:19:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2A15406F9
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792408755;
	b=BNXCXkD8uFS6FPsqHkL//FBiUEZRztbdnC1kePTd/SSYn0PBqgaGl7Kl8jCymHsQ6hO7
	 EKdgVz8l7KkhBtQcKqFTTuBRoyxTLeO+zKl/CNbbd0U9RbI3bzHfMn5NDBjdzJbShQmrJ
	 lXR4hEu87iYhhjivJ0ekNGssOtDnI4Grznn5j9ofymvH0kjevOaKSx/xZr+x3sTnqaGEP
	 SG0t2tRXKAcZr7zkzx/Z3lpjasmUHvt6DKjH6OdYWNqlv8y4E0SgoScVOphPBrjGTHTF7
	 k3Pa82R1Ct7QayNfmoXtfPqkjSBPhw4kIyRWfYllSQqu0LpoHaIqWVMretwu2Zpxfkg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792408755;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fVX//U6Cis/fbUw4/UwDP0zRAe6+eXqEl+Uh1kNBwzU=;
	b=OANdFv2xo1UHQIPzi/lgBY7KnU5RomyezsrL0ZapiE7xnkLSegFuh6qHt7hftsUbEAJK
	 61AVVXnlYeecPkDqCskQ+7tJScyEc7NvN0oMxBCIk7VL2vziWSyB0whZofHOjjOOW0AGM
	 HpmpEZZqC6TNljX8P6Xx10XkKpK5HX33QmH5qTraVSDXp+r486WbxDeleM3sQwROC7O/S
	 ojfhSdef+9HmJPRhtdAHGYT+CFE4eYj0hrnfDylCq7YnPna3BXKQdNXGfCRGCqySI5Niv
	 bZqCrxBzbQqEP470TbtVks2mksJ05X71zaxmccwN5fpjwYc3w9mMn60UIvKpJsE1Ulg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792408755;
	bh=fVX//U6Cis/fbUw4/UwDP0zRAe6+eXqEl+Uh1kNBwzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xgd9o2RbqvogSQImGAHEWSvQ038lZpkYUY6iWJrjB0s8XzFzZS3TaGYoJcvZzChst
	 qRzZqts2Q9Uvyf4iIWv5cFXxc1W3IiB+U/ohG/ZiEisquVm6gD3DwOMG9wTcINvZf1
	 C5wRPrBG0R8ddCONl3MPEjxxRPb+AmiZp2YSRdpZ5QilpQWyRNIsqPta8R0jvOYzbJ
	 C1+bv3jzzeA57BW+eenMiTLFZSR4DiBGs4mH1lrekjhM+Hv8F6xIN2Xv2iDIj/vsjZ
	 qdw0wbro+XgHTyUsK4oN4IkOq619cF40MNNxRVMyn6H20x2IgDZKJhJiEG/ubfjVdG
	 even1KnhLShqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2A15406F9;
	Mon, 19 Oct 2026 11:19:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C215263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DDE46060D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uRRf2K_pKtQI for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:19:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 320E860603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792408753;
 b=iiWegb8PBevW1FJfZpUBwRnf+3i3/q9J/SPo72/7Tz1aDWMUK/6dCd8XlnCOXv2CK5kR
 YKfwBPTiCO9jFaRfTnnFquibAqxFdXcyg7lSqeIxdsbAraksBApTdGW1LwjYPPBO0ShR9
 0wgIMOyVuWjuXrRLwx8UewxdU1WVsl2alo/YABnIPNKv2mVYtEgsuQOA/aLbeX/cxN6DQ
 yxwjTrwOra5zNSqI120A/vODUVjDjZ/NDziPgUxQncX997gpXQx+yir+MpaTOA55I4huN
 ZjyFEP9QpD2a19hRpeBSJJmPg99jHQnG+dcSzPOIFsYLXraNYHb6Yq952sZyiHiyjRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792408753;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=fVX//U6Cis/fbUw4/UwDP0zRAe6+eXqEl+Uh1kNBwzU=;
 b=D7OF1IroOD/LXw47ntFFvhwrKe0tFYID0tB2TJcjfxwueCEhr4/syTR4/S6c/wkLg0Gx
 i2OE2gy2UStD7oASjw1kzyDQKMqG36wFFrMn6I7UGoRPWhkPi3+c66rN5P14j0sgJjwBE
 fx8svJKhFhDODfHK9oIWJEoyq4JspJLyxa84oQ3nDjrjbldHBQnVj5gGK0WRF5qZyr/jx
 06uzVlq4aIeWZh/FnACzbNhKz3H2MqvJzFLyVmGlsBCF1CKLI1sD6H+ZhKacFNc25Ge7u
 Ro/Dj882kqndTKKslQNRpy8ziwWEaxqdIeTHq+ARGWUb/mb/D4FtisPQF6ft5+ew0lA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=nxp.com;
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=XILynkcI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=XILynkcI
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 320E860603
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTx5XcN5hKOcmOwaVNAmYFfpEGxc75kR/39PXKYLAggcLOE97VgnqtsPTqQepeReTXKghu70EDCIssILq8r7sy/cdIY2IezH027sBBHwqHbkrCJHYnPixtBnp2Qh1Jnqid06O8rE6hRDO+HiMgYZSR26aMfIQT/NWiAMJXGkOyYu+jn5ctGg4WjdESUrxwbAtA+7v0MA1oWcWMYkyHNRzZpV/m7D4irDPP6RHN+M28CLrquPLJBiqw95sQAqhSoq1L/sa+6qGuKvOQssLQ+4H0Vll/bq9JS0UawoPllSoQ45fuVFE+EK5hSqiRgDyQAJ7GMZ03B4XsGjhbCnMLRrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVX//U6Cis/fbUw4/UwDP0zRAe6+eXqEl+Uh1kNBwzU=;
 b=rRRkzFmz2RXlQDG03oWXiKoRvrLJEnOHjZ8hKOhcOWLAPg+KSVkt0rNGyDm+BjBCLQnjceMhhx1xTsQ7/RGJ0n77vFQx/fLeFPCNjYW3nchbcAX/F1GK0c0MtTFfvzU+ONWpIfNNnXUedpkylEN2zhyiT4BlPefgexGzIL2OtvIO0ajsGqYg15ZqGJqMsaH5APJw41QwUuorBQbxLhk602vrmaUR/66Edyxb2RzJ7e2xqDwZ8DJoE0RvaG/QZMor/5rAF8vs36jVFPceOijBfAcgo7XoPe9Fdq9LKPjx2AA41ffwforg+0WEVk5rzHHFsKUnHUlQhYme6h4VCaVDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVX//U6Cis/fbUw4/UwDP0zRAe6+eXqEl+Uh1kNBwzU=;
 b=XILynkcIn5N6JXGU2mfmMm/YUxiYrFcZQ28/waWWfKnj9Zi3bj8RCRa+9qOReS38dufdeeS1gd1Grq/VlVQ6uU0uZAO6QYGGyw5cKIyk6ryPpBUBsDgT2Q7CmpgZgORbvQ/lV9aAuEGxg7ntRb9AkHjn9GsaGU5HSNmbO+jQUwlMGmBH8xSZdo6354gk46Jpw9X8Fjg0Z+pJuGFspDwKztjwngb/s6MWdfFrFJgMbD7ljZGLcbqhAs/D8OBQkDVydjD5sTbwe8QHyNGA+Bsxotwsz4vGBPWNB36b29CIsoKULGB0kfZ80cr4yRBqU11dOIhwoRAtVukDESXY6Yj6fA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by MIWPR04MB139140.eurprd04.prod.outlook.com (2603:10a6:290:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:19:09 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:19:09 +0000
Date: Mon, 19 Oct 2026 14:19:05 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, 
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Tom Rini <trini@konsulko.com>,
 Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v7 00/13] board: lx2160a: runtime SD 1 lane configuration
 for LX2160A boards
Message-ID: <r3kt43nnzryirjsyagyhmjo7r5af7mvzfmzkgoqfi7gowoehn3@wuvhinr7pr6r>
References: <20261008224228.512353-1-vjardin@free.fr>
 <atCCAEjYE5zyCTqW@L30177.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atCCAEjYE5zyCTqW@L30177.local>
X-ClientProxiedBy: AS4PR09CA0027.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::17) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|MIWPR04MB139140:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a38cc0-b62c-40ed-4bbf-08df2dd2cbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|23010399003|1800799024|10067099003|56012099006|3023799007|22082099003|18002099003|4143699003|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info: ISd4zmQaMx/fqAK3nfOMb9ZJuPhecLXdmfm2KvIS9QgaNHDyLPKF18RLQXw34EGVdDYGobnwCJiIVqNdwF2/xzTQCjjI+ZBBl1RwCeJtxvMKZ837oIzp+kzM4OsTolWydoCgg9ly+M23zIpPCtjecr+QmGCzz2K0zRbWLYiO/M8k3C2xLQM6Mrw3vi03dSzXfv7XvvDSrm2QJV06DQrOiKQimwoh3CmBdjY/m0r36TrzzPn/fwHfnu8zK6yyjwBEo0jaCDifR8jKhoHawi1Ti+NIeTjVlZdSYs3N3Ru8uZdf9EJzTCtkESvAmXNhEp85+JdBRYOy7X2tr/oTPj+F3lQn9fy2KDDID3JcMnaMrVtMjccLlJWDiQ/rHkCIGhILF1fObXj7bfAMzMVrNPm44z2ZtfHD83Dqdo6GDDwGFdYBTCVj40TLgegbPkepKV8mlmYX31VjdSr5tlQ96ZyKNu4MDXMlA4IGO6Q+OwR4INgW+OIKq8/W+hdXGTzw+86by9xFWzGu8frT0XgENzFMzA4HCyrWlGJpZIhdEbFDm2VkxoaZzjPCxkWealrW/u2Xi1KynvVCm5VI90xUKygItB2EMmp1q6m6Nei8r+NerdD+sqB+ZPU+DLKTYUtA3IR4Eue6L0tEQcWxDAfokOvAZn/zzmWwbQ6DxwY+5t6XFf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSqHhk1R5BnjZQEoXPKlFJJpLWVK55iprJsuiL6gcEGyKbKrkYIRJRF512im?=
 =?us-ascii?Q?IRJFpfTxrunSMKB32XmrQGNwykmCZwKQD9f5dywdUxQl4RpZC5FPsmjfi082?=
 =?us-ascii?Q?z/TdZeNNn3N59Uc3ZSaJeLeNXcEOWq4V1qgs5dP+RGRjvvri+Dh9hiTjabK2?=
 =?us-ascii?Q?9CNoPfO2Vw1Nf6vp3L9GIoedLXwpNqwR7PZea6etpMYqxcz3du1bsFlJHfW6?=
 =?us-ascii?Q?cS92XjDqzYyXO7p87EEuLRuGT77lftuXLWbYshk9xomjefe+FQSoIFG5IeSo?=
 =?us-ascii?Q?WaMn/PFNjli3hdKlJp61IIfg+fsGsnzL1ONUl8KyVLtZVarkfpTA/8m8OnE3?=
 =?us-ascii?Q?rdsn3F8AW7MY57xcjYRrOjmtYfikOtCxO5YzFuy6DxO8tCGu3FIEJvGB97s9?=
 =?us-ascii?Q?N4zDNfAi2KQMdzUYcYpNg6F2M24TWnGX8PMpRHt5b1WcLkLVT/xMaUYVHkbc?=
 =?us-ascii?Q?b4RMYJVvFcFLRMcQlsRzMEpUYGUq/PDZCDhR/0V8svxtcsupIB9oW4adRB/I?=
 =?us-ascii?Q?OBMTeR7WplLjWVUO67LpHCqc2LXGmJn0b8vHgnQxGrIg4+iZhy1KkmT7q81f?=
 =?us-ascii?Q?dffkZUdQYvs5C/Cr8LqQtzB20bztmCmkVuHo1YlW27udP/EbYKgI6ST6JqZU?=
 =?us-ascii?Q?mP7IyVpAw83XATDH/PUT7saMA2DJluiZvBoiuVDtozIM/LzRPW7/42vLECyV?=
 =?us-ascii?Q?2kn3HmuvUOUnvfUYHjMXx0rHMbPZRRedu4oNTwbLtxgWgJMplld72X5VfnFQ?=
 =?us-ascii?Q?uj8F3a9a3j7erdY2I0P+7k5lYwy062D0JtZV6tTI2YF4BBfPIEtbD6hHSMBm?=
 =?us-ascii?Q?UQaVbPrGHwR0VQOF1s2RhPT5KSWFURKlbvzozht5Zsp0iJa0ATUPApr4Y9Cz?=
 =?us-ascii?Q?z8gYaw6rkVAfGHDcRibtvp3X8tSd0jP30Uz2kZCH45l8zDCZAKPOlSCbvV2f?=
 =?us-ascii?Q?QDkUYDu0GENEY/VtTYXx5EDwH0q7UkiqRJ3ScwM17irD2QcjJT1kHuST6O9V?=
 =?us-ascii?Q?9QhzWrTThHG1bMDPVQ4eqo86/hIw5rXgKCGsh/IHRP1cZ/OkDBheaE5gs4Ts?=
 =?us-ascii?Q?P6XNHktA/pw12cv66un0cjSNTcW4rjZrj8Hc/0dEp0pJ9BU4CHVUr7K5W7py?=
 =?us-ascii?Q?ZrNrsyHLVFdptm5VAP5Qjf1+O6NOgF4VRS9pUgOVxvDtCfyCUBekn+AnopSo?=
 =?us-ascii?Q?TXidec6xvmIxylpvpQ5VcOGqjOql/3DkyTQd7aht5zlKjUuliLfa39jXiQhB?=
 =?us-ascii?Q?6tGA++fOIup8L7vUcl6KbPdJXDp4fl9MkDe3XFci5VBFphPvUwFwxuNEYbJv?=
 =?us-ascii?Q?vV8VJaZE/WelD8M6rVwPpj5Xa6TA6INfMOMlwSdClHETBXRwv+GMvspMArcp?=
 =?us-ascii?Q?oE+C8IGqhpe8rNkdciwVPhM+QYHfVnNgymofa25B+2QTfvvb2V4LvEDoYe0W?=
 =?us-ascii?Q?hZQZgVODxrSLxiaUBPt4/jIFLzyzG9yGYv1vQSqG55/4zTJB++u7QLYMQo41?=
 =?us-ascii?Q?tyO4WFpSMsvTYEMrZ8p5MPZn8jHM9dZi+sSmIP+2SLRDuxXWHcFxKvEvXhQh?=
 =?us-ascii?Q?skMHsGgLvgYkSMQeJY6XYqFq4wtQG4/MPifqimjIrX4iDkMLvpAp51O7wgqr?=
 =?us-ascii?Q?eRPmDd+P59GwzC4eDM2oeYfavvvp1njy/UNpWUReSvkAEsECSQwZ7b4pb7n7?=
 =?us-ascii?Q?jC1n5TIZF+e4rGkp+qt+ENkLYIBGOm3nHLNn1JTOFK4uzXhRVFep9du9UXL1?=
 =?us-ascii?Q?Eeji2vRjAw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a38cc0-b62c-40ed-4bbf-08df2dd2cbc1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:19:09.6360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAXWKPyNZnfKIcJSyOOWTyAKWKdo2zfq/akCzAmujCsiRjUvQpZbkYxAcL6cRQMNtPkoMuLSOurTRyAGEH/mtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB139140
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

On Thu, Oct 15, 2026 at 09:34:24AM +0200, Vincent Jardin wrote:
> Hi Vladimir,
> 
> Gentle ping on v7:
>   https://patchwork.ozlabs.org/project/uboot/list/?series=527129
> patches 01-09 and 13 have your Reviewed-by, but 10 to 12 are missing
> your reviews I'd like to get when you'll have time ?
> 
> - 10 and 11: only the lanes E to H are reset now, as you suggested.
> - 12: 2x40g from protocol 13 or 20
> 
> Could you have a look when you have time?

Sorry, I was out of office at the end of last week. Reviewed them now,
looks good. Thanks for the perseverence!
