Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15DBC79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 11:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FE4B60615;
	Wed,  9 Sep 2026 11:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id voVP12Ty5XV9; Wed,  9 Sep 2026 11:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8B51C60639
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788954378;
	b=Xg+KCYB+GGFtgcd4EelwXKlaNyU+DQK8Io+FdrblXOCxO9+znd/7j5VpepbMwXnKA5SZ
	 Hl7lqzji+dmp1x2/9fw722enqaGBjLRizUXMdFF3ap6Fc2opcA4V4EK5xS1feDbUvKLvT
	 QaQq/IocQgN239voNPe4FnV2ZWpCuEr3wcLTPufh3k2v1Z5HuM3aJLuLx9kt0Dn7dY3Xj
	 /77MH4B8ojM3WVRK34Ap+FVXN+Bgt4U6mroCYDps/Qnhafxx7FQ7O0FpAZIa9/8Es2ExS
	 Khr8sZUupj9Ym1L+nmRI8hqNHg0UnTtRruJ9UyIQXk628JNvM1+SUbYTBij84PJjBfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788954378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=udAVizj3ZMYJGbayNAw90j/KzlC8U9veShibFdSAWos=;
	b=CWwarN63XFKin3LAX+WqXe7tQ65FbeNQEY9o0rLoqDu6GyAPRKOcaEedKMJ3hYz5+dv6
	 qln1D9wFdTwhFxcwVft1Leyt7Uv17j8nZ++WrU7E3H/oVasL57PGAs8q0xQ6B+ZATiLmc
	 wBXX6d0zC73EaT65HJONEUrriXFtaxUrScHZMJf737ZV1za8YSup2UnEAI/10vRw8yXTd
	 oeiUlE7fQQDs3pNkxw833qDjDu9A8sGNFaVfr0VjKqyKhrrD4GTkJkUN2avfVpRZ0Oleu
	 Dct56hj5AL5LxKmS4t1mJIPJJfB6q5nA+GggQSgkHbZ+bi6FCYfnWqD3TyIybsZvrag==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=eBMtuDWD;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788954378;
	bh=udAVizj3ZMYJGbayNAw90j/KzlC8U9veShibFdSAWos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sk4XNwLKXCTnS5EBgwo9KGN481zl35GDPzj9olCvMA+2a4DfD9hjHikvv4Fl+G+mU
	 J6Z29KJhTtfpzncYTYV8e6dCxi5qWrspc2x9xCXOQny1Vb0LD0dHmn2zdSPraGpuj2
	 q9YjVaStg073xwD2AuMn7PCCb7yaA3UJvJoF6NHwZbLneFk71w7Z606GMwoUXJtNc2
	 uWwVJiCqoJXqnQLx13In8Inc0d/zC19+dMklwrv+Bss5iZyUs4REjTO1fxDGu1GB72
	 MkS5Z/1P7VdmUypjkm/PaQH3X4hKdYm34bHWjglW6CjDq3LWquO16L0YyXlyhe+WUS
	 Lmn+I7R9bjlew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B51C60639;
	Wed,  9 Sep 2026 11:46:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78B2849D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 11:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5ED1E60639
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 11:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tk2OjhQHZaYl for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 11:46:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 95B7F60615
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788954376;
 b=i1H8eVcer+vUlzZvzzUm2ILv2lpoa1bMmx06DzfD1SJ30DgHiwKVcz/67j5dE9lLedkv
 xCjtG747jkdPNesjf9RAG84J6Cc/1khpEjHshQe3pk1bkUYLTWQuRoKom07a/f8Oplihw
 J4CaiOjey7X8YdGqcM4Ciz2Iyv3wZPpyXMe8dut84lhUuudUpCN1X/VhaviA/j3M+3Hle
 N6jDAmkrb/GgSqzuKLrGedWaYha4eeBjLCOntLn67qu4QySa2yQ5QKLHVVaY3dPglQgea
 xUeZt2FXuCIwylwTb55r6ltlGNUoJZM1hVFEza0tuNfGnlLsgK0lemd1k9fOAkE6m8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788954376;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=udAVizj3ZMYJGbayNAw90j/KzlC8U9veShibFdSAWos=;
 b=FgFmukKQH6JAXBKKJIzd8zvUIwyTfxznqshGo0cFW5aWhOqf0PEMfX5VJiDFiCc7Nmqo
 AkcvzqTtZo00UWAwMRPKkj1GmFFXP+CkFIY4vEFfkwIcaWaC4q5/WtckuDl/BAkwNyqWi
 610wOPyqWWGZrO5o6S2H72dMiuQ+Be3xA6eoRaqfJ+B/NCQMpGJZNX1yD49zz0zx1cj1G
 7tH9eaNs2Ry+zgzyWPoIESGJ0d97vlLjigpYQF7FEvj8kqLkgFQft4FNzQHTYef2QpvPs
 fmTvv+3uVktcj+Nl5meoMdsZbF8BA08y2GAo58G8nlC3KNy4qtbqvEKtJtAE7kp8kEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=eBMtuDWD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=eBMtuDWD
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 95B7F60615
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 11:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcnRA592u+H20iJvTHMfSf9Jn/WFwjmB3Y9/jBPBMwRdM+Gad02J4scFpTXWYkefi58warkU4J87GktJE7hPjQDtTuBlDpdxz6EoD2B8f42R55uvCFMOwtzv6udH1JPoVSjWbdBnN/bZdLc13MnYN9VJ1H0utyj+pPE/5tJYQ/6XhrGRsqxiCJo6hpz4uBNNluTZuqszzKT0N/0N6TubZObslFPwhl+q/Tf24BssPBZDEcsDaN7TNEfYCblH+uAzsI/B1crJn2UYLGP4TKukZPzWZtrTQlFj9bko0uskD8QYU4Z9BI5i62TP7AJ+79u0POedwLA1jwi1YSgv3YUwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udAVizj3ZMYJGbayNAw90j/KzlC8U9veShibFdSAWos=;
 b=V4TYZz1iTNtNgZjviiHom4w1Vsz1ddKPlMzsdnF5POo3SJGWQKHI22l3GfUCW9nuuDFlA677mztrV2FMY3fOP2Clx5fHPYkGKINWM38sDj8UhVz5Xn51tFL9wGiX3rrRRKNF/krYp9avC3dRojHx6DQ2Ei6pTdSW+N498G01xd4TakKzOCexhcDWwvNnz9sOf7iQ/ywCd4FdvTFLrUdJyqU/4AeYdNMMeoRyki7FsJJb7ccD7CeuNIM0+QBzK0RVD5kRBsmHiJAZc+WdewSIBITsUzF+8sfNhI8/GO75pnTe35ETA5CM2bENsV0gfyizFCivNXLH0NNrlSb7MNQ8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udAVizj3ZMYJGbayNAw90j/KzlC8U9veShibFdSAWos=;
 b=eBMtuDWD/t9rm2rNoEODaaHJqM9orZI+mjcGrsSBN0lOKq1GI9gBWtPlp7RQkVEBmrdFOHf54eXAj9QEBdv8H3Meh1EelCxeGEHmE2SaBp5pRBp2aCNUVczjpqDdl4NVXH1vCSad1BvpwZZrqeGmHDTATQ/B/tFcSuAIyVeJGE6gF057rU5+62GZZ2/+ZxyJSSP9KotPJIty2nuBQ9QrkS+SjsR/gNIcvxQSqKHFjq7LfBlttPGrPDQ5Zb2nfCmjD2SM1dnXbXGL+dt6u5XrhrKstBkJdfMWppXWq+X/BdaxGcw3uxNobtUF1P37AWhK7YwTDlNgWAmp8M5LH/8BFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB890448.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1f1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 9 Sep
 2026 11:46:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 11:46:08 +0000
Message-ID: <7eacb72e-e147-4ca6-a704-25a7753f02fa@siemens.com>
Date: Wed, 9 Sep 2026 13:46:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] mmc: Call back to optee after a successful mmc_init
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <cover.1788879818.git.jan.kiszka@siemens.com>
 <598cd2523e3b2a8b7a613468747fe740b1f35fbd.1788879818.git.jan.kiszka@siemens.com>
 <CAC_iWjL9fOYDdyfHRh+LHAeAh_AjNA6tajAFsjb59V6PccLwPg@mail.gmail.com>
 <f78cecea-5651-44b8-a817-18c084001354@siemens.com>
 <CAC_iWjKsyfFQA+ASq4WQvQf1t2uKqsa0CTCdLvXP7MuuRuTYrw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAC_iWjKsyfFQA+ASq4WQvQf1t2uKqsa0CTCdLvXP7MuuRuTYrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB890448:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b0e9c1-a0ef-4652-5b9a-08df0e67f031
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|10067099003|18002099003|55112099003|6133799003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: HbfRhNBYXwCO5N2S7EMpXC9KWTqZgKmPbQIkGQXCT5feq4ENwzf3kTyu8j2Wvzts5NOxkVY5LunXsj1CmzozGtTQdSJRBm1ToBoTZK4g9Bjkuuyf2moSNDVSuGIrf30UlTP/ykTVIF6a53dmmfniHaToKrsg3HtxavTH5z72AIQz2/zIwCqRgjqG9wz/T4p9YwrdaAYgNZBLwYLqp3NRxHfQeNoEnimg56dfSWcaua506vPoUVDuLgz/tZwzeh3d6j6kdxz6tbZ4nNKi2/P0P+tcDkc0BnOCIDZRw7RzSlI2mpri33jsGlEA8OOpV0tWmvrW8GXHMK57Mfdf16F1oA8PCh1i+jOsB/ncYi67NJlHZGv+ftINlpQfqovh+g8mAa2Xk6M3e6XtWCa+mazf761L/hMqp6TbSrtWFDAE1SPqEUiisEwu9Iw5+kSm96Q7V5POR6CtKbFyH3cX6a+df39lC60biPIgMNYwKK2rD6yevynKzyKDAOiyTPW5dlStCmODVis4vIzf2BxgJrkMj5R52PR7YWhm9i1AXMJlr7xAI/ctzIjMQl/bwKy5j3sVLm9cN3DzeXbYHWDPzg4Vs8e8d1jHFCAgXT9Xm6/cVeddVqjUrYxVrjZYT4XZUbexe29CKw+fdx+ZF5NxPSTlqum6OZCSIbQFbUqrCBhIXHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(10067099003)(18002099003)(55112099003)(6133799003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW5jSzZTandQUjhwbUl3VkFWZDJKUkNDTzdzME4zaTI4enVucGJDSE9PQkNE?=
 =?utf-8?B?bStDbzAxUmlCYUcySUg4ZDVkNk13bHZiYjdYb1JxMHIxeFU0amU3ZnE4Qk1a?=
 =?utf-8?B?ZmlvR25wU0t6N0ZDMWhtL0FFRzZxS3FleUFHamlFYWs2b3pLYWoyWGdCNFpL?=
 =?utf-8?B?b3FVa1c3WXNuV05GdStwUWZOaG1tR0d2ME5EQjJIbmMvR0hzTnd2blBEWEg0?=
 =?utf-8?B?eDMveTMyQXRSK3RCUi8rRTE0MFlabUJCdEtid2FDVlRqU0tTZ1lDbWdTbkRO?=
 =?utf-8?B?b3lSMGJybHJERjVxU2RQOSsyQXpLazBiYUtoSUZ3eVQ1WFlKRmpNKysrYVNy?=
 =?utf-8?B?L1BuVVRrZmdnbG5XU2RtbGFKMERhQzVTOTZQUENQbXI0eEhuUXdvVVhqdEZx?=
 =?utf-8?B?b2IzV3pSbEFzdU1tekxJZ1ZMaFphdWhjYWlPanpseVlxd0hITXdTOFlVNnJm?=
 =?utf-8?B?ZHNiczZzdGxySjhHSVpEWVN2VGpGbFYrY0VIQmcxVHVtNTRCSXdEQWFoYld1?=
 =?utf-8?B?cmxqNmN5UDJ2N24wanFlcTVLWVJ5MlEyYUtwdlhINVpOSVh5TlZYK3QrYzJ2?=
 =?utf-8?B?M1ZqTEpMazQzMVRXRDRBODFCNVRHeG92ZlhMZlp3bUd4L0x4d0ZjMjJBaHBQ?=
 =?utf-8?B?ZVR1bWlkeEZSYnZLbWFzMWxuaDJsc2t6cTVqZG9Ob3FDcHFDaFcvblZhYXFm?=
 =?utf-8?B?VEwwNGdhTWVORlJDcHBlVVJ5UXBnTTNkdmZ4VkdkdjVBeFBGUytmWFloMnZj?=
 =?utf-8?B?RENaZVc2T3BFT2dZR0xBUWZpbCthWFFxMXNseWtwWWRrUjJxYm5uL3Jmam43?=
 =?utf-8?B?dXlIMGJoelN2azVHajIvNTFqR2cvbzg0a2gzVkU3MFJkYVJtUUpSLzRTWkk1?=
 =?utf-8?B?UDBrV29TbzhRSFMyVkhSbzhVcjFXWEttWVpqQ3h6N29WTWNaZ3hPc291dWl3?=
 =?utf-8?B?WHYxR041eTQzdjExa1hTWGp1NXZaWHdacVUrNTJBVXVpVE90bEduOHh0Zk1o?=
 =?utf-8?B?Nm9aQ0JqaU0zbVVtU2FJbnUrRFRaZGJJeUQ4NjB2eXRReHo4M1J4aFBKU3k0?=
 =?utf-8?B?MU56TWxNMEZLd2FmQnhXU0NBUFFucUZLbGNiSURGdWFCNXNjdG9GWTJKL0xM?=
 =?utf-8?B?aGdtUXh5VDkwQlNtVVVTc1U4a1dlZWhoZm5YcmRRamp5WGxzdEFqUkcwS2p5?=
 =?utf-8?B?YTRkUk15UGwrdCtNTXl1bjZLbXZuVUMrNTVHZ0ZRZGo3YWNhTzZjeFhNMkUv?=
 =?utf-8?B?WVlxeDd1SGRLbkRmYURsT1UzUkZZQUNBT2lzVlR6cTZBRWZUeTJ3VWo1WHhR?=
 =?utf-8?B?SXorNHcxQTByblpGLytzMVJwL1E5L2RDYi8vTTR1MGdqNUo2KzBwdmVpNVVC?=
 =?utf-8?B?M242Rzc0YjlzbzBlR2dYRXNxQ2lwQ0lEcEJ5Vnh3OGp4RC9YMzZVY0pMdTB2?=
 =?utf-8?B?cE0wMkxTdWhXR0xvd3FvUFBWY2VoSWMvQSs5MjNVTTdwdmRzcUxSN3pVbm1G?=
 =?utf-8?B?MW9KVnFjWG0rVHFsWkZLVjdzenA0QS9NQzJldmloSTByVkdiM3JCSnpHK0tE?=
 =?utf-8?B?azYzVURUTVpXOWJnY29xbnczWTQrQUtSZHJraW9XVVpReGw2cFlYc2NibnpF?=
 =?utf-8?B?emtqc0ZPR2ZSTnNyMkFoMEpjYitsWGg4T3V1RWZPdVFUUHozbjVub0VrZmxy?=
 =?utf-8?B?cVg0eDEzOWYvU3R1NGdvVHRVQnBUU3NTQTJ0TXRnNmZCU21pQW1XbitTZ1hh?=
 =?utf-8?B?U1VLQ1dCT2doQ29tcmdtanNHMFVnVUtrc0FUeUtJMG9rRFZVRHUxTjB1Wkxh?=
 =?utf-8?B?WHBKR21WNk9lS2grdnRLa0F1ZHpPajZ3VXhheGlNR0RMWjBoTWhmVW8zb2NW?=
 =?utf-8?B?L2JBMlpkK0J3ZnoxM2l1eGY1bTRqZnJ1QVNFNkJqbGJKM1o2SmtyeUNMWFRB?=
 =?utf-8?B?QjNKN2dsQTZseCt0bFZBWEJZZEp0NEV1ZjVPcFUxVWVHV2Irdnp0c0dGeGpN?=
 =?utf-8?B?RHVIYTVldzN2MGtKczBTOEdYdm00SUxLaklrUEFmRWYrWm0vSkc0UmxpcHZH?=
 =?utf-8?B?SHlRUG41YUxRbFRBamNHRWlXNXlLKzQ3ZGVFMFBsTXpNNFRuNEMwYjAzMWE3?=
 =?utf-8?B?SnkyUmJrMHZhRUFFYnFxVVBielhXb2NUUlMzdUd4NGpzWEdYb2VjcjkzRytW?=
 =?utf-8?B?eDR4U3ZVR1p0NmhNa1Q5T0t1TEtqYlh6Z1pFcm81STJEdnB5UzE4LzBKa04y?=
 =?utf-8?B?ZDhaZmU5eHIzTitmN0VFdmFvQ2hwMU1PUFNVUTJoZk1JWnNJN3IrOFFGYnBr?=
 =?utf-8?B?MDRoUHJtQ05XTFFEbXJjOHVmUGRkTVY1QnloMDhFTUdMYmhpZ05OQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b0e9c1-a0ef-4652-5b9a-08df0e67f031
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:46:08.5566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHfqXGDSx+BaIUN2EH75R2RUrOeqd3YWOkRGAzpNVprWo4tPWs20TtYH36dNwjAYJ8Wl+4LPhJecCcfgE+ZROg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB890448
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

On 09.09.26 12:04, Ilias Apalodimas wrote:
> On Wed, 9 Sept 2026 at 12:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 09.09.26 09:50, Ilias Apalodimas wrote:
>>> Hi Jan
>>>
>>> [...]
>>>
>>>> --- a/drivers/mmc/mmc.c
>>>> +++ b/drivers/mmc/mmc.c
>>>> @@ -27,6 +27,7 @@
>>>>  #include <linux/list.h>
>>>>  #include <linux/printk.h>
>>>>  #include <div64.h>
>>>> +#include <tee/optee.h>
>>>>  #include "mmc_private.h"
>>>>
>>>>  #define DEFAULT_CMD6_TIMEOUT_MS  500
>>>> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
>>>>                                 mmc->cfg->name);
>>>>         }
>>>>
>>>> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
>>>> +               optee_rpmb_available();
>>>
>>> With this we'll end up calling the optee bind methods again for
>>> discovered devices calling bind_service_list(). I haven't tested this
>>> locally yet, but is there any chance this ends up binding the devices
>>> that depend on an RPMB twice?
>>
>> I don't think we will have an issue here: Either OP-TEE isn't ready yet,
>> or RPMB wasn't yet when we called it first. So I do not see yet who
>> actual successful listing could be done twice.
> 
> The question is what happens if OP-TEE & the RPMB is ready and you
> issue an mmc rescan. That will force optee_rpmb_available() to re-run
> and rediscover all the devices no?

Hmm, let me check...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
