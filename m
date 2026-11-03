Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FEC606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LTpvnpG8;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=G6JSZaFO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C14B9606E6;
	Tue,  3 Nov 2026 09:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gY0bRYoY94au; Tue,  3 Nov 2026 09:06:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F5706060A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793696807;
	b=FdQVxVMe6Pf3WacmI8+5+4iOHVx8Ja3kg9E0HbmCZz5TMdR9FC+7bNXeQk2qmG2HjgEI
	 zX1fTlhMvZ5pJEEy80HiL8k59sZNYew1srATPp6WHWtUQUr98LbV4cNXZzgp71ZhcvFc4
	 O8xlQctY0zhMX1d3PGiuL5Ha7WuoSZmViF7pZibLQ9GvYcvIIkA+ktPppVnOfGYaQVzoO
	 CCN2LOES5yO4gLbi4fN5rLOy/yAQzBJ1ncV2rsVfNtLvB9z1lb4OOVu0eX37HmbWKjvMq
	 e9603IEVwr8qBROCShQl7g0NbQuPsPKwYzDwFUrL2fZuZ44aah6N+sP12LThu4TJFbw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793696807;
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
	bh=1xWgqjxdUI+egCD7hQ1nA/ZOo4g2jtDgiBDViKJMF9g=;
	b=jwHi/M03rjJezdrZBzrr48cNnEL1Rrj/0KrHwJyLSxxOlF/Jjg5Xv4INPZo27ZwR1tVp
	 gtytrhFKSiOELMTxRXlHh02v/aIOgu4V44qCZapVlEO/k0MhROJA6P4tZ36altbO7+6/X
	 NJZBFrW68qX6NqSQf9SugbQdci27W0Bl4zAMxLZJufDBLMulwXD5Cizs0VkYcrfm8dhLp
	 jLVe+jCOV+Mjeey6LjgWCe2t49oo5Ufv2xSE9KNjGH2DAFXF7parS1dCE3DW9CYvspeyB
	 1PZ0DLHM+lt+7iwxu+EJ/nWjcRkvSFdHNNhwjvzDxnvf02DCg8E886It3To7V67iLUA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793696807;
	bh=1xWgqjxdUI+egCD7hQ1nA/ZOo4g2jtDgiBDViKJMF9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LTpvnpG8TJg6R+i+9yyTdXJs9BArgXg7oE+rxN30Gft9b+xjrN6OjNDe7B6liFMGb
	 H9mCKP7lauOhKDHfvOC4dgg1c/8cvJa3dH8/hpHodl9suGh9cd+AaXrNmTvQ41jdBo
	 9CXve94FBE6Rv4ZT7LtOZYTXnBom196GnLYlxGVVout/tPmBkc1WL7ZLTaR7zHfn/9
	 gRNcdyaLDgiRy6k0zNuRlsnw/Bp+euvsVqArfXgTArczfeL0IhEgi3LJq6nITy5DqE
	 jDHO2Q0h/OgWGqKp0tfFn/EkTwQpGizhK8Vzo3CZ7Dz3v3vSOm34jPawmRBo8nMhlS
	 hRWLjY96gyAUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F5706060A;
	Tue,  3 Nov 2026 09:06:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB6992AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC1B840517
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0GDdowoM9HnD for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7938240514
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793696805;
 b=mjnQw9bOz8O4jEjYDMD5JxPtolOKWZEU/BLZR6XX7bxA2mTqghGB3mA7HoHmWN2KJpVO
 DYAkbipggx3DE+GOrIAIOc1daY/jJFQbWGlB/usPaNsMWqZXGPsnpPyGMyblfvvJn+BOp
 ifwXxNmlyxNrdNmfeFlxEMEtx7cP3tZolq8z9FwuubDFh1TLmXeeWVykCneo9zkLmIk6S
 JGIlIxjenG2iLK3PzxbdgVf4iKm3I8fn2e99jPqQL0Pn3dqhX5dsWp+C2yycTGHmj+z9u
 mNGR5ITRal2w8U8idvA+2UC/l6H+fxAxGm9mKSLAh6SRnJAs+ub2amFoexaokOjcc7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793696805;
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
 bh=1xWgqjxdUI+egCD7hQ1nA/ZOo4g2jtDgiBDViKJMF9g=;
 b=Y0JCLFenIuz2dap+dGu9+CyRFUEHKKoSd7rnIumt+saIsrnrYsdhD6v8vk93TVEalXSa
 rvymIcmFomOLvU+wOX6f0q3z9Fx7xFfG88DSY8k+KBKRwfNIHDQm8/1yX9RF3cIyjxxtu
 LLhYJxBYnqz2Il5XiLYx9XJtXOQR3rxosdULlBOLRvkYsfwvarcPX35SCtmrW1runUkCD
 /N5/rmD/tM06xc8bsWvlAsn6vxjH9j8EUsDTbzv5HIdRs+klfkvlriF2eIHaM+fVoClgQ
 KBS+q73Th3fCr+C7otak3kLSTo//sdA7uJiFlvfqnCgC4aCij+hTqhGDIavGyWvvmHQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=G6JSZaFO;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=G6JSZaFO
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7938240514
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JS7W1/e3er+a0UQFEbUVW+sHfWG+o0eJwng3G3KNgc4x6a7fzpSqS2vFejNok7LqYWG+FBMqtXrLIshKFGr6w3gm+hA5r74iSghRRZH2MwIzX2gElMBauLr2Mo3Veeuq6+a034KmkojlBPNLkzNbrCPmjH1MBQzH8ya2M1XjdUFD1Sr63zYCgVTHfhLdeu9hKVxH57kgdApaa46/68s36QUXLTRp78iIAb3OsRg/tpNeWx+O4qPPVCqo9A9sGIb94wZgolZad0h8d1+oyxNXH2EQN4jZCxRzrFew5Tt6mUoCydlCmK+eKXhgtZl5jb72G4IAG12BrQmAwwm3jCIENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xWgqjxdUI+egCD7hQ1nA/ZOo4g2jtDgiBDViKJMF9g=;
 b=S/iNdJPP7RMegs/P6EaZwtW8wVeg33cdgiunEG9JFL2UQBtffJaNMKatCzLhs1gcJDDbNxhSsNw4tLvflobSSB+FagijULIPZJyF7nv+6MLWpy9aKS9d4QOegHb+ZT/bYQ4Yrq6DHePtZwbwh6LBz0ZXnhyUa+KGIlEQkielZ6R82xcqUS/dCRUWUXB5RGYpW6Xj9EhtN9Eaa5RCED+S61VWk+lRHGTTcmoEMNfof/B+ASByNCO6ndA3drA9a0nuqgUlj0fEhWLE/h67cJwQLcM6kNvcl2pt2pvj5PWrPF8P92fRLQx0EcgWvK4lYOCRRp8mWX+xMMbVLhMVvq2P4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xWgqjxdUI+egCD7hQ1nA/ZOo4g2jtDgiBDViKJMF9g=;
 b=G6JSZaFO4CSIImI6LktgThOXs7PsUkRJIZ/BnebYXJzxIWQ/M/HKdpsl1XWdXSm+6CxhXEPPwUpfeB2Ir4Rra2hKBu8n2hobV0az6w1Gd4fOUGKd6IOKx3/NG04rz04wjwytYhHtn/bLSYOc5ZOL+YoKcmoPj3MRv5E89lgtenDvfkuPesTf/s31UqF80BcD7aORuEZiLbrJio/KiljYpc6kZZdy7ABS+83hlPuLdZXxQiQ8GRKldxeVTwDpMeWc7wdz59WKydjZVWMLc988CvR3XGE3S+td0HrfoSa1NaPxitMDn6SRJ/AXGI4nRm73PEUTWeQ0rW+x/kr7tflT1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by WA4PR04MB081700.eurprd04.prod.outlook.com (2603:10a6:1d0:35::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 09:06:37 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:06:37 +0000
Date: Tue, 3 Nov 2026 17:03:20 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1] pci: layerscape: bind LX2160A rev2 aligned with Linux
 kernel
Message-ID: <aumjWBQZ9dP97HXC@nxa18884-linux-1.ap.freescale.net>
References: <20261028145705.2407296-1-vjardin@free.fr>
 <auQ5P0e4Fn-64cyl@L30177.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auQ5P0e4Fn-64cyl@L30177.local>
X-ClientProxiedBy: SI3PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:4:297::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|WA4PR04MB081700:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a98b225-ff4f-4ee4-9fe9-08df3989c3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261026140227099003|261022105027099003|261009223027099003|261028144727099003|41080700001;
X-Microsoft-Antispam-Message-Info: 9VZ4T7ggMklgwsKb7ZBrRsne+SzstqxhlOBlV47UsS5dQ9tN74nQ78EKlfNURTtRBW0wjNfH+2CgRnp7pWviUqobC3ha5JkcbZvpANcLSVfD2SZJGnSozNYFXoaYLODLeaR4su82ym56XqpKcMj4Zkyj+KUpZBVMd5VKtA8vG9cEpVNcuuivX5zoHgV9PEUPrS8YyQP+wCsGfLOKY6L/CoQmCzoFPGZIigu7vxnXxMiPbKUueOerxhrSWyJ+X4BpFsUctVXsTVv5y3zr9cXdyeO7cx6/nQ9eWodO/PCkybgLb2ar592iTvLQ1l6A6lRv3W/Mr+xcEqlYH4aPEiA2x91So74LoBs97YgZ/aZrA5PGY55kMPm/9FpjR1b0eBwDuTJWBTjoG16+ZtdWzqMkchLlE8Vaken1HtiNFVl4JLB1tdLM+ob0LlK/BJU16woVFYNbn5V/INgS4rFYhdryvbGsd2GX05yuHN7rZpSg6GJwgcrrcSZuE8ewp786lu3E5QEHX4E/sOzsinfDnM1553y4jGow563Fezp4/UwzNjUqxBT/c46Le35BppqLs8dTEhOUXZbuzIrBo/ZqO58/IBwExjMMrf90Tf8XStD1OxB9SgsP55Ey2DM5gUR0JzeMvJxEDvdkrPjYpHiis3RlgZG66W6UlBKD1/4kY2inUtRGuDkQIuX7aLOTWhIkrDG5JgTNDtQE1BbBp8Hxf9hx6AvxImt7TtAR5KBjQT6O1L0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4UzScqpZ0dzcKhuQf34ENHOGZubvCOlHLQBzHRhXmLE4LpsLUj0jH7v/cCFI?=
 =?us-ascii?Q?Uf2kfcmidoiJPL0YoQW7qBG6FwSN7L6WPduiSVgMo+1Y+09L+aeBJ6g3bXSx?=
 =?us-ascii?Q?ZV1QXONyJTy87rrNADNx8IbdloCz8jH8N86XCIwNPWH7WCwK/6eLcadVLDI1?=
 =?us-ascii?Q?8KXMX4IakqmJHF0esNx2fxGSnbH5B6zkpxvj3ar4BkXxtnDPQHQXLt7sTrDm?=
 =?us-ascii?Q?BUcCDAv4dc3EDcejvNMd2cId0dEdGD8FGbwZhdWFQUG21oLJvBtbhlvJldZf?=
 =?us-ascii?Q?/gAVcmU+IWY+qj+3JMlD6d2Bnw/0OM63rB0cC+Oei3WQSW0JjpY1NOeQm4K5?=
 =?us-ascii?Q?5P1YBP4McSoQgAmV4X2+E5LflWPwCk+5nYLuybPCOSVmYLEOfyxRPw9nTpQ2?=
 =?us-ascii?Q?VofUZB06b1ouTTEtNr2qGGmKZN4LZa/9ur5j1S+sky0YQg3qOjBOhJCs2iUq?=
 =?us-ascii?Q?K/xJkPIe6K3RRURpbS2BHzFNtkWjnMbcyMRv0Ys7FxP+/gek9/xvg0xDtLh0?=
 =?us-ascii?Q?OD24CzDAhNhTiwqiU7zEosJXcR9ALZ5AMPTCHc/tOtH2baCEbEhnSsEUpz2w?=
 =?us-ascii?Q?2VKGEJdOljs3g8AcOdx19z6hllZS51KpssQVkPdNQnq9/u+pkr/7KcD4kERz?=
 =?us-ascii?Q?SS3syyVbRXay90JyS0XxVioxcxNkGsJRyq5z58MkYoBMC7Jc50HbnBu5cOz+?=
 =?us-ascii?Q?iaDp8bp2VdnY0Rm/n02qWYD8PgklPlFo2JxNUtkce6wknNmauGDgfBFumw7o?=
 =?us-ascii?Q?bBwJ3yDbscXNoIpPjnJ9QBLs9GxGwXBkwkz85ksA4wB+NjNhTgmBr0Kn6+Dx?=
 =?us-ascii?Q?IZU9VTn6LGnhMMkUJ6cD/LnMyPjfBljuDbO5C+YpkiG+hA4habEXrSZHqjny?=
 =?us-ascii?Q?Vz8R/QoT72BBPSNryagvofqI7aS+kFRQuwYmRdrq4WTztMowZ4W+wL7mSxtd?=
 =?us-ascii?Q?gt5fK1qTwTmAM2L3VLzBpuxShhNB+jieNO5P5kJQJHWcpV2jBwze7PwPdl6I?=
 =?us-ascii?Q?C+g28hHlBbI/lLpyPpuZdrCoaOJJlciNK7OPfzkT+f6fj3JPKYg6ps/7PfuK?=
 =?us-ascii?Q?ag3fs/80IX3QjjYU6Yogt6Sxgg4aqCiV02OHrmeLC8KuHE12sc2d+Gi5BON5?=
 =?us-ascii?Q?riGAVN/Yf8LnNnF44tWZfb/77ZXlY9L+wYJW7u05hI4MsORV8x1KlN09H/A6?=
 =?us-ascii?Q?sV5K3JiVhJo61NqU7L6VaZmzbWm/VnjUG3yEQ4Gx14TcAn+19eBPQdXWVNMF?=
 =?us-ascii?Q?8jMZG0urfoMBRdIu9eQFS4bV46ba3RpRH2hiuUdhEwh2QvckYsGzvFqhPUph?=
 =?us-ascii?Q?/aCe3LVtIOX4vaNzaaTCybUQ94Ty8pY2I6Daynhg+DowfDiCHc8c5e9UKbsa?=
 =?us-ascii?Q?xWYg7el51YZjUnnjZv1S7LJ0X2bxX/X8KAezREQVucwyNebWexTUIR0eO3KO?=
 =?us-ascii?Q?dHDtUp1siGXS/ejIXPX0LRKYo8gC7r0hU+q9JB9OTTIGzSnLZEHvNxILx40o?=
 =?us-ascii?Q?k9uzkv8QKz/Q62frZW50Gc4hvoW4KEDdfrWhf10yX0Ooas3HOfFMar26FT0h?=
 =?us-ascii?Q?dIfaQasE62iZ2f49qMqt9AmP+46rGV7J2BNDzCpnNHbfdc1GeaKlWw1xyRNp?=
 =?us-ascii?Q?Dj2+OgX21zF+ICAmSLnpUlg0Q3i9Dih0bihmyXhmI5NTR3al/KGEvIsfnaht?=
 =?us-ascii?Q?xRn99rzGdiMLzK7K/NuVtCRSDxPFVqZFW9i7srSNeZdu7rDhGJBnzaa4+l4O?=
 =?us-ascii?Q?vq25s6tf0iP7c8/l1WiXUvqyK2gu4Mvd3nHpSic6O3ND7ls9inhJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a98b225-ff4f-4ee4-9fe9-08df3989c3cb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:06:37.2039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRUDlKS998Ip0YQOzCAAfpzyNUStdGhjlBHLRiV8QZ3J5z4xubg4Czl7xV7OClgCLImBriEO1qMSnVwWHbwuhGt6WxXRudSahu3adydkFf+X95CZOITQQO1tshBsE606
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB081700
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 07:29:19AM +0100, Vincent Jardin wrote:
>Hi Peng, Tom,
>
>I am not used with uboot release cycle/policy, for such small
>case:
>
>> +++ b/drivers/pci/pcie_layerscape_rc.c
>> +	{ .compatible = "fsl,lx2160ar2-pcie", .data = (ulong)&ls1028a_drvdata },
>
>since I posted this after the -rc1, should it wait for next (v2027.04), or
>could it be considered for v2027.01 ?
>
>It only lets uboot bind the LX2160A rev2 PCIe nodes of the upstream
>DTS, and no in-tree board is affected, so I hope it could be acceptable.

I will pick it for rc2.

Regards
Peng

>
>Thank you for sharing your view on it,
>  Vincent
>
