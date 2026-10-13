Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADF2CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 160694066F;
	Tue, 13 Oct 2026 08:16:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3sdISc25YkK; Tue, 13 Oct 2026 08:16:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EDC3D40627
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791879412;
	b=KT3opaYRGkid1JQ9zIKcCNvwoiu32Y6WHK4I1Szh6pOIAOwgA+naiF4sb1zZjVam9L9m
	 Zr8NHQN4p14JYGsioLu7sLqmP5M2kpBFvIoUZQZtE7wdTS10XsP4PFFWkdGIGEp1PR+oK
	 je1oCR00RH2o395VhpgiuYxvdI7PTGhg8LFGTV+PWWrCyf1TcTVnSwPLeTvMnQ1WfE4f0
	 CiUSnLY8dewAjzNcTmgsJkRViFbOU1BwZo/HUChkUcDIE5XrfNSnxoHacbqB65Q6U95O0
	 sLvFX5X3oYZ42GaK574hKlO1j+4GBR/O42f77GPMYVlgK1qjcGo+OI4rlBJOeLflAxg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791879412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
	b=i/WPaAnl7tSvOzfiyZTwuigVQDxJEmRTSmBXoBlwlY4elLg6/0w+4kaziuOnrcaPugI6
	 /jpvDhlTmwX3NRsebmCUgaI+4hlv/MiDRo9+pM4uNAO+xxY5zyy85GkKyjTnTgW/oneH5
	 aWcBwNMk0tnN/kV4ynYk2sN+at9MrkmwTY98f+Jmg2ZIlUbr8hY5MEC5EgNX5U5dbfcLs
	 rPVLh9/9CPvaUiI5kV6Nx3S2BzuVVgtyDz1/ZZM/wWiDXPTJtRN+DD/CDSIgPMeqwQMq+
	 arBgrDLlVcqvKWQdju4kKrAnQL5aeyt2V/+TQPSKH5mBdAxYVr049h+LrzmhlmwDm8w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791879412;
	bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HqwXftH2FrdtAadAE0SAvKy0SZ2Hrap4zt+UaVQBF2LjX3FV1Iu//vEeFnL9zjhIE
	 WsvRw/C+DoAwEc6CNODbWqu3+2qU2pc7TYwsejHNwHvWo/ltdmGYQ+2TJAE8hCHpNH
	 lTbp9n8B65pl0lJozZTKFaG7b3b/l/s5Qk6CnVordly0exbi2aJu+Gzrxm1x7PFl2k
	 ZaoLuQHwPTDpZ5t/cRRGlV5s0AjBcDuobri5/otvXeK+5MQgSY27WXzfXfbiqDtmc3
	 1TnhUd4JWEGLfg/hgwnq0LDu5hrkF2/p0bBnH9OVdfzeLsvYzzwcrHFfQabM+yHLEj
	 s5KeiyXrRGKMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDC3D40627;
	Tue, 13 Oct 2026 08:16:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 305BF788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2268480CA4
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GTYCx_oDPl02 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:16:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96BCA80C70
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791879409;
 b=Jwu5IEGFLZUW9VB71RsSATxyDwDL5R5Y5t0Rx8hXFYS9WyrTo9CnM0W6l6AwF2pT5UTC
 iF16MFHZ9O+al2xaWpHyabNuse4CENKrSH+L+qjs0W/FW1JNJhH3if0d5wQQqZePyXUAn
 svRij7njrpeiloulRixRCEClMZV2p2D93cPD1h7lSm9Y3kcpMjiGjqTay3rqyZMZ4AsC0
 nQ7ItvhhdxNHwT2PUReRVFypqdlsK7MWCNTf8y+cbUDeKfnq4hi/StwhTZRb2ZtYT+xJT
 o6ZhqAZ7kijWsVqUgzgENjY/aJpjx6agf0om5qzlSMDeYyYAPIH6lWWqnM8XprAaVIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791879409;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
 b=j6vbjsvm4KRwo6od7sCJq0WKd8ojBx0PS/hhgQLT8BRlL9hFHqhbRc92SXoOBcPb6Djh
 RYdgd48Dkrji6/UhrYY5T9N0s0kiUrL0CX65JjJkIKwuGyagByWYjpyVbLj/MrNJcJT48
 u5ny5H4jMW7P+ghWNggAhNBBZcHxIIsXImYUrNKDIUjqXIkEj5oVAUT6YpuK0mq+KEgXX
 JAYHgNX18ytXjDLDFKL4am6ywXxfEC0Yam/Vi4zN2y6gfDNDx9VQl+gqiReaDEKVwVvAm
 9+NUb5FxTY0qnDHlh29ZKplu89sK6cRRdMnriQoWjKcwbJGyXB+0MTaOeTUCK21Dnew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=acFFoUUZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=acFFoUUZ
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96BCA80C70
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hpb7cTBnZDDH6Nat7lR3dXuOOSsNx7mPN3zWHc6I/zbXtOu3zc5B5P3AtF7tZunUM7tN/K6XXqkc9ZhdIe1Qh4LzUJN19qJyozkXVUmv5SMIOxi/EeYrhpgj1v6/BtBEqDYXhbxNaYWWPmZnX9ipLGbrv9+fd8YV4NdEu7mdZou73p+AYz+zJ+a8javS3aUQkkBWBn0sgOuElPA0y4S82Jot8tdA8+HcVpr/jZtJe4kgDdovCVh9KevO1NGMxRVX5PSVTzrN0WxILJdanbX7Qvr1AX/kCyyEpM52LaktJP29RTjMNlVfgP5n5qdL60MVSm/Vm4IA07akWcEeDGOsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
 b=Oo87ltSFkmEQCG6nMRGTF9A2yLUCWwPVBBhHT1VEHYyRcAWSaUxDUsbcR9Sn2d71rt4Ocp+goRdwTvL4841qy8w6JGZGOfKSyPk0pZqOwISj8WXdJH8PEu7NUUgCxOPbm8kW9QBYBSgspchtZaGoHJPDvHPXL4ocnAii3mGRvlRcNWNR/zGPbmwwUtEWn5ljyftdsYO994fGMwryNjzbiwG+OYU5mtABcXlUsh+uUik8mogFKK/6YNkW7poX7Zefvdout64pafsUhPuC2m9veux6Ho8QivyDtW2iPvylEs4IywdgUotzE0o8ZKF0klr7n3BRNzdBswLYgPRwYd2vGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bny+ICFvtIssagcSAuKNTK6niHxKPO39z4xgZe0xHk=;
 b=acFFoUUZlLS9q/SCN+W0B5w5CubZExB/D6YPIzkSeT6O1k5BErFNiMOBqTlX86+5GHcgBxFpLq0vq1P/MY7/jLnfHhMXN2lWAMu4xDZsaNfZCEPgQR0JMtpxY+73xAUZ9TFCN1VoVs+QZ2BH1yJrpriaOYLF99h2Kyle2AGRQdM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:16:41 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 08:16:41 +0000
Message-ID: <d52842f9-d15a-4c62-99f4-66fc13150e5e@amd.com>
Date: Tue, 13 Oct 2026 10:16:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: versalpl: move PDI load operation into firmware
 helper
To: Akshay Belsare <akshay.belsare@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com, Padmarao.Begari@amd.com, Tom Rini <trini@konsulko.com>
References: <20260921185822.3493122-1-akshay.belsare@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260921185822.3493122-1-akshay.belsare@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0132.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::30) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: aabd32b6-baaa-48af-da56-08df29024fce
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|260925022911599003|260925021311599003|260925021911599003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: ADErbcqljx7Yeu5TWZ1/5uuPZ33XIazQaPzUctMEMpwQiMlug1Xda3wquzoQS4aIGHKKjU83hiTQADjjpAFp4U7xtTkWnC6L8nGo094zetJlY6Rx67JrllEtRF5jiaZ0pbVY2nofvx+AzJ+9l9AZddXNSMZ3KD9DzMdO+tiyIaK+PDizqwJnCptB2aUoUBHKFcZ5vS5eFJuhVc8wvHkWnHKn3thUfAMMjEBN7UXJrdDvFL3Er87jWVvQi9bY1+nSkujoipb/16nIpaHbuFFKQve4kCEUNpw2v/icWLh6lWJe7A5qqpIXLrwjOIuhAkUZ/dh00luZ3AMN7AEYMqz/dvzYCNkStmjzq1abUt79jh/vCWc3FfHpSS38zy8zwdKlEyxpcuuM5+lek8S2Ev06bH+AWdXECj+XsLbX2moYAKRgJOdpDtl8kfAmBQ+IWudNBJgzBQ47LsftvgAYWblJsorNRcMkQcyrNYV6lUwqFGN4fNY96wQD2/joUiCvKyosgFu7yaHNwq7a+uPL7jiWnqDjBBASxCzFW6uMqMO/Nd0z8c3WxGD6eTXW47kKgY79VRl5tRb2jK7KqT2HrKRCqs+lWyIySHjj7WpsqXiyun+XfDJC4O10PwtL5CxDUaEH3zq1m9mtRhiEPmKJ0VhJikK7xaXZCpeZ9wYZ9kINP34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(260925022911599003)(260925021311599003)(260925021911599003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHNYa0VKSDNhMjZkMSt3SE94QmFxSGd2am84VlpkYTVOMHhmUVRMTHVuQjVY?=
 =?utf-8?B?eXNhZDczalB4SGVxRlo2MEhLK25tYlE0T3ZWOExzTGtGUHd6M1RVdWZNYzlW?=
 =?utf-8?B?Y0lnR2RyR2svTnpHbVRKMCtjVUV0M0lyWGlsZ21VVkNyQVhoSFcxYm9SVXNG?=
 =?utf-8?B?ZVNNQjNSSWEzcExWb1BKeHMxQUc2Y1ZFZitUdURzZlhuM3czenA3N0pOT3Rr?=
 =?utf-8?B?TjVSRkRwWDM2dVltSlFReXpTZEFaNmpzTmQzYURuakZkanF6bEJyR29kRzdS?=
 =?utf-8?B?UzFhZnJzV25uRzFnOTJDNXZJditzSno0RlptL2xjN1hrVGZBMk5Xd1lqSGZ2?=
 =?utf-8?B?RENodGtZKzlHdGMwWmtBZ2JZbmVWV3A1bjVNajZvalVoZUxOWnpIRXRIR0t5?=
 =?utf-8?B?QnlBbk9KbU1WS3FIblB3V1kwNmk0SytxQkFrUGRUbmlzZmFTY25hajR6VHVo?=
 =?utf-8?B?OWlreUtSVkxRNVQrMEkrK0tBNmFRSlZxOFlGdUhqRFh0TzM4ZTZySnpyMUsv?=
 =?utf-8?B?RUsvb2p6VjdRUkhweC9mUnNDZWRJM2IxSjg3RVJYRmlWSWRpamVRNGNXMmFj?=
 =?utf-8?B?K1FENHB4YUt2RURCekxPakFnYTl3Z3J4TU8zMFpVYUdVYTU1cWFXMnhwVE5l?=
 =?utf-8?B?ZE5GUXJ0SDJnZFNacER2OXlZV0VETTdGNnRMVHk2OUdWcURDc1hEL0JCelg2?=
 =?utf-8?B?S2ttY0NWWkdINVY1VzJHNFpKeWVuOHhyR2ExbVByOTdDU0lCVUxlcnhiZVRm?=
 =?utf-8?B?YzVVclFGVXR2ZnJjUHRjWWRpTG1BSW5xczM3ZGVZSEIxS3g3TkI1NUJ3VGhw?=
 =?utf-8?B?YlphZlI1ekZXTm50WUR5RTZ1NW8xQ2JkUzF3WWJ2QUhwa1dubTRLOHlrWVJT?=
 =?utf-8?B?SHV2TVNleVdZK3Q4bWlmYTRSdUQxYnIzWEJPa1IvRFR2YzBaeUdIMEVBYTBR?=
 =?utf-8?B?eE1xVTUzU2VXQUFoV3BkN0RiR1MwL08vSytUUDhaL2UwTEo3eXp3V2FFVDQ1?=
 =?utf-8?B?MUdXc3d4bEJScVRuQmc3WGVDUWJwd1NuMW5JWUNLSDhqWE1ZSk9uaTFwNDl1?=
 =?utf-8?B?NStuTHhIRG52bE52a2dWYkJOTHBjMkpFOVdJdlRoZzI0ZndrRmIxbXU5dTNh?=
 =?utf-8?B?cE1FY0lKL3VZY2NCTFR1TU9PZ3NjM0lMMXd1ai9yelcwQUN0Q1UwamFvZEl0?=
 =?utf-8?B?b0lESkp4UHFabWVGN2NEaENadGRYYWp3TVNaSkpSZVhqb29jbHNrSTVHV05u?=
 =?utf-8?B?WG9KdllERVRBWjFZTUtJaExGZTVrbmJHVVpLZ0F5bndmTnVVQSs4bFRoM2l1?=
 =?utf-8?B?M0JrdW82RDRzZHUwNG9taHE5c3BsM1BjRGFWZW9DMlpQRkRTeWpoQTI1LzVN?=
 =?utf-8?B?MjVaMk9kdm9Vcm1BRWI0eWZ5anl1MlpscEdFZWlGT1gxNHhDT3ArUko2cjNY?=
 =?utf-8?B?WXNoR2w3UTZRekZvS0RzSjE4WG15TUZ0aTFxRVNNTVN6dkdwNnV0Q1hteHd4?=
 =?utf-8?B?QU5Dc3NWYnAzb0JEUHVabGZLMEsxNVdaZzRzZ09RMkMwQW5SK1hQTjl6alpr?=
 =?utf-8?B?Y0ZjakgwaUZFc1lnM1RDUFZlTitjMUkzbklxaDcwYVZ6VVBZY2d5YnZTblR5?=
 =?utf-8?B?RmFMdllYc1h4RDMyaG82WXNIZFluWGNTMTc0NUVCRkp6T2d3Q2gwNS9Bd29t?=
 =?utf-8?B?SDRwZW5ka1hZaHFKZlNUMnA3SzdPMk82TG5NT1NvVzJZZ1h2cDRweHNMdWdS?=
 =?utf-8?B?UHBBM0x4djJLTG5KUFZVK2gxaXVSS1BCc3ZWUlFRbzhJRTU4SDJuMkFGeXpy?=
 =?utf-8?B?Qm4rYjlFOVJDSHJWL25QalhhMUZRNUpMRUd1Ui9qQnNlU3hYS2JCK2VoR21u?=
 =?utf-8?B?Nlg3VS9PVUFkd3RBbG5wdTR4dHZUVDkvc3FnbDRnVFJHRXYvZ05TcVR3Ukw2?=
 =?utf-8?B?UmhjamlpaUVwUmg2NFhTbUlJcXpUdlE0OTViMDdkZWtHVHQrc2d5YXlJV1ZH?=
 =?utf-8?B?SGpqbDQzUXFubmtZYmJDNDJpelYzQWszOU4vVUVmZ0NSY0dRQUN1VDhJS254?=
 =?utf-8?B?Q1drM1ROZ0N1SEREQ0ZYanBNbm1VN0d4VFFLaE9ZSEpHeWNEOFppV2wzdm5y?=
 =?utf-8?B?L2VqT3JmdzI0YmFVbFJ1QzNhbm5lWU15bHAzY0pQV3B3NHdnVlpZNUcxNXRU?=
 =?utf-8?B?aFFQMktDWWh2cXhBYVhWNWcxSTBybDNHaXA4dzQyRHFVS2V2bTJkKzZyRVho?=
 =?utf-8?B?V1REd0pEbmE5bVVsOS9lWU4rdnZyZkxoU2VicUhFbWFGTWs2Z21YUkxqb20y?=
 =?utf-8?B?NzZwZE14cmpZeE9WcllEU2R0Rm1YZWE3MkVBaEswenlrSnFBRmRsdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabd32b6-baaa-48af-da56-08df29024fce
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:16:41.7184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTEfU396QSFpE7BQmb1A2MUIXPs+jaZhUcwOrghxuCD02lLshwii1T6RcfZdUjT8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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



On 9/21/26 20:58, Akshay Belsare wrote:
> versal_load() calls xilinx_pm_request() directly for the PDI load
> IOCTL, including Versal Gen 2-specific buffer address handling.
> 
> Move it into zynqmp_pm_fpga_load() in firmware-zynqmp.c. The Gen 2
> buffer ordering now uses IS_ENABLED(CONFIG_ARCH_VERSAL2) instead of a
> runtime desc->family check, which is equivalent since U-Boot builds
> one board per image.
> 
> Also add a weak no-op default in versalpl.c so the driver still links
> when CONFIG_ZYNQMP_FIRMWARE is disabled.
> 
> Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
> ---
>   drivers/firmware/firmware-zynqmp.c | 15 +++++++++++++++
>   drivers/fpga/versalpl.c            | 20 +++++++-------------
>   include/zynqmp_firmware.h          |  1 +
>   3 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index fae66ccb3d8..ddfdb0cb195 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -14,6 +14,7 @@
>   #include <dm/device_compat.h>
>   #include <dm/lists.h>
>   #include <log.h>
> +#include <versalpl.h>
>   #include <zynqmp_firmware.h>
>   #include <asm/cache.h>
>   #include <asm/ptrace.h>
> @@ -175,6 +176,20 @@ unsigned int zynqmp_firmware_version(void)
>   	return pm_api_version;
>   };
>   
> +int zynqmp_pm_fpga_load(u64 address)
> +{
> +	u32 buf_lo = lower_32_bits(address);
> +	u32 buf_hi = upper_32_bits(address);
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (IS_ENABLED(CONFIG_ARCH_VERSAL2))
> +		return xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE,
> +					 buf_hi, buf_lo, 0, 0, 0, ret_payload);
> +
> +	return xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE,
> +				 buf_lo, buf_hi, 0, 0, 0, ret_payload);
> +}
> +
>   #if defined(CONFIG_ARCH_VERSAL2)
>   /*
>    * Poll the M-PHY TX/RX config-ready status until it settles or @timeout_us
> diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
> index 3cb56cc0dc9..29d2a389fd9 100644
> --- a/drivers/fpga/versalpl.c
> +++ b/drivers/fpga/versalpl.c
> @@ -10,6 +10,7 @@
>   #include <versalpl.h>
>   #include <zynqmp_firmware.h>
>   #include <asm/cache.h>
> +#include <linux/errno.h>
>   
>   static ulong versal_align_dma_buffer(ulong *buf, u32 len)
>   {
> @@ -24,30 +25,23 @@ static ulong versal_align_dma_buffer(ulong *buf, u32 len)
>   	return (ulong)buf;
>   }
>   
> +__weak int zynqmp_pm_fpga_load(u64 address)
> +{
> +	return -ENOSYS;
> +}
> +
>   static int versal_load(xilinx_desc *desc, const void *buf, size_t bsize,
>   		       bitstream_type bstype, int flags)
>   {
>   	ulong bin_buf;
>   	int ret;
> -	u32 buf_lo, buf_hi;
> -	u32 ret_payload[PAYLOAD_ARG_CNT];
>   
>   	bin_buf = versal_align_dma_buffer((ulong *)buf, bsize);
>   
>   	debug("%s called!\n", __func__);
>   	flush_dcache_range(bin_buf, bin_buf + bsize);
>   
> -	buf_lo = lower_32_bits(bin_buf);
> -	buf_hi = upper_32_bits(bin_buf);
> -
> -	if (desc->family == xilinx_versal2) {
> -		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_hi,
> -					buf_lo, 0, 0, 0, ret_payload);
> -	} else {
> -		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_lo,
> -					buf_hi, 0, 0, 0, ret_payload);
> -	}
> -
> +	ret = zynqmp_pm_fpga_load(bin_buf);
>   	if (ret)
>   		printf("PL FPGA LOAD failed with err: 0x%08x\n", ret);
>   
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index f753a67ac27..e0759359846 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -467,6 +467,7 @@ int zynqmp_pm_feature(const u32 api_id);
>   u32 zynqmp_pm_get_bootmode_reg(void);
>   u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
>   u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
> +int zynqmp_pm_fpga_load(u64 address);
>   
>   /* Type of Config Object */
>   #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U

Applied.
M
