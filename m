Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E50CCA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 06:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B907F40528;
	Tue,  6 Oct 2026 06:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SvcdWlpBaCpL; Tue,  6 Oct 2026 06:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 185FD40518
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791267029;
	b=QH+/aBdxAFLLg9jTKJaDL/yR+DAGAcI3+0HWq7D/QizJQUxVVJul/ZIC1sc5PRYpn4lM
	 SltRQ/y5/3e9g9cBB7+R0bT3P1TFmNsSehAP+rV4CpvPrYanAAYXGWcSAdyA13ohUY96U
	 cqQquv/3e4sH0RYwNCsDqcBliiT6N+qLucb5U+VO5JaZaJLEEt8AGKMDCZTBhSj1KXNzn
	 ruQHRr/0zbHdPvqGpEn4NtZtUb2P6vkR7lGl/+hEX2hszMak/rC6B+OfjmkNGBEkbwRIF
	 weArrYe1hWmF/gzZHJ6nQyd9cNEq7TBXcuWExt0uealyBm9yCgLyt70hAp56AZJB3nQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791267029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=8AobL73cJ1P5YkCapyzXAiDlqIGQ2bAKjS0Rk1F2Cz0=;
	b=qsk5dL6E07ivsysLN5F4RTWBuTFP4XMnVakELCOtITM/2mCoqJmmYVKVCBivHTVB7N5W
	 AjfEWta+kPo4vQZQhKfEKEr/vbvcKAoR4Hh0R3lsvGLEFen04EMLD8/x4sY/8GPuHNESs
	 4O300+QXludrT5WpMd3Gh4a+zg0IhPxN+Uwl+yu15WUfsnR+nP2OWzslK+DdetFYuoq4L
	 o55+/9bqKUWH93qQDh1h//dmPbQZDCpLm64cCsIfLFALHgWi2x7ezj5hOdpJggOMmRepz
	 Fy5qBrvehd7p/wOe/gKdnGhiOk6VzeQRsjSCpg2hAaTsW2+uh+fHg3d/XfHPl7NNKCw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=RUR3GazP;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791267029;
	bh=8AobL73cJ1P5YkCapyzXAiDlqIGQ2bAKjS0Rk1F2Cz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a08KoP2TjXO/ySumMnzlakIJcv9dVGGl0nsQJQglXzl5xVuqw2tFn4x6icFhL8rJv
	 eiLt05hQvMkmL/vU8w5t5xoSu2kMjPPliazLjC9zq+etJzylltFIA8OowQpOI25UiJ
	 1rySytTOGhj3YV1FyCm0+DU7vQHU/hHeJmprLVxkOppaM3R0P+OaTBCBuLmi6ZdBj+
	 TapJhK8VHtTywV1hZglcxiWGRRjeE7sctbnpXS4qVhUA0rJSx+gLLl1L5XNV/inN9S
	 AzWYjrIDLcH2bf7hKOIRP++/IFLaj/ckGZDLGt2j4tGABWx6XLWNu3bF2hQ26BliCA
	 zPWvOoaZapiIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 185FD40518;
	Tue,  6 Oct 2026 06:10:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 750FB75
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 05:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5ACE040507
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 05:40:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nrnAZa_kPt8R for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 05:40:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 87B4A40505
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791265254;
 b=JqkKzR2rQMmIHIArOyvG0VMoxxv1UDG58m3g/Ichz4QXYsFeUUPkKH7IasuD1rdcPIST
 cRnG360krOAL4LrOvTINQw5zmdEAF8eeMvL+y9y2Wasmi1CA1SZBfrURfY7qbgP/a5KRS
 BADlDdzp3sXjguB12Os8HLZybYg7DeCGE+WjA1OaNGl/1S6PEDWtaMpUh1DoPidEIoE2R
 Dxk4Rsmp8zMdDdANLFxdWbddaVPUKvrECSk+WOcaynwiMLpo50gKAyGiP93WE9Y4XSSXU
 MYmdc0x5EbuvDF7FoyvG5DkQozgzkTpmpPTcs1FuTt0QlzbTgtz3jnMHJJe6z4Txqfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791265254;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=8AobL73cJ1P5YkCapyzXAiDlqIGQ2bAKjS0Rk1F2Cz0=;
 b=WdaxLSaCCYdI8bOC1nUURZf3YIKczpv9Hk/G9ehXd7F1r6+OD1hyH2j9WFqg7vdak74r
 9yizyF7XcmZJCgNBkbN2pe/MFjkcPbENnz4blL6ofRAKio1b5AFxUG39P7HbxNIQmGlM3
 ETXYqsX/DUqMiwA6vvISWuRLLcTNvHl3IonwEKWNSAwe9nQfch3lKtwxbkeKqiXnbGCBb
 7w0xbwMyyGIje/QmB9qeAbSPkKALNOhDu+5FLTrS2jI7fHS+Edn5qxmEtKbmSKebNdv1t
 qwWAhyrdbjIxal93FuqpcyuEfqwonjqO7Ro6tEmck2b7li92abHD6wfoH2dNU+onGxw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=RUR3GazP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=RUR3GazP
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87B4A40505
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 05:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYf4WIszA3GQzhjZ7WJHdznPXHpHWgT4crukNefRGWN38P1JQWioeM3CDr/AJAPGmTR8VmaB40BLkjtj9USTINnHVJzucrW/jYf3rC88vgRcVaFAtJWup8P4TvYHyapHkD7wNdMSpWxGSb/2gaRHv1UVhIhLZHC9tl0OGJPSezbLBSJjQwgB/YAEaC/b81MM1gPJn6/e0fW+pBtEVGYAUTKyHAdWHNgnWRuQLxIa40K+XuEsqqLpGPUtDoOv1qBrqhCQ11l7oxzXdJwhn/xoWbL/a/YjE+/qqw9On/EJc3GG5LtVtat14yZVE2pQwL+fgnxgZ1rwCSP6UTNfGRLEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AobL73cJ1P5YkCapyzXAiDlqIGQ2bAKjS0Rk1F2Cz0=;
 b=teO8zuEwJv0RMMVN/BQsyrdJZonhyJa/kZRkIWndVqJgCdENSka+QTjKUcSUCGT3ZUoo41854Hem0IcSWg/KeDcngIP6g6XWQXgXH/86FwKO7fuavjSMq57xjavWRfUL2V9YIsTxqN7Sct7+qX9fbFgi8F8Eiocc/dDDtIwl1kYQVQdf2atzJbcy7T2QO6N+a8dbhre7dWMquUaV+uQ801AcXuk1etVgkwSnQrtls4ynjrr11i82FJ12zWyzwWPsRcexLW9LbjDoF7K5x+XU6OraeiYPsMBr5g3iU/d8GSoHKxoEasc1fm06RzAlQsBFvQAMs1EXjIy7wjFHM/wivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AobL73cJ1P5YkCapyzXAiDlqIGQ2bAKjS0Rk1F2Cz0=;
 b=RUR3GazPBzYO6qD3qYZ5VeNvsdKC9QmF8mmZXudb2G41rVTwxpPyubpjPbjje3Gw447F7FMnNqR4FCQpWDPCwwpZzU34E1U5qgmAlk9B6HWLPW0GinDvZ7MSUqG/m3ytz7GbSzn+EmhQ6vyw5J4Uv2cGhLU7/J2VFL4MtWMhQ4E7meXYxPKLmX/a7qhyOI6av4XRO1babwsHu2yHSYw4MgpnmYBLEq1ZeYt6VTXPmSN8D7vhozF97U8bAq4WzWLRDdeXw0spIwVszcp9KgObuF4ykzv1eRsI5WmIdVH7Mj7cScKg36kN+Uo9XEqZGSGWBoG9svqqky1CO+aJYLhpZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by SAWPR03MB989599.namprd03.prod.outlook.com (2603:10b6:806:55c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 05:40:48 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4%4]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 05:40:48 +0000
Message-ID: <00b2dc5c-799c-4df7-b283-52ffe45862a1@altera.com>
Date: Tue, 6 Oct 2026 11:10:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mmc: k1: handle a missing max-frequency and
 clk_set_rate()'s return value
To: Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0038.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::8) To BN9PR03MB6204.namprd03.prod.outlook.com
 (2603:10b6:408:101::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|SAWPR03MB989599:EE_
X-MS-Office365-Filtering-Correlation-Id: 500941d4-4ea8-4a7c-eefb-08df236c5fcf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|10067099003|22082099003|55112099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: HJiq8+NLneRNsBUyl7eTImbCmAzxIPVscWqBRYGxb0RGQx26MBajgAF2CEgVRmNeBpb3K9CCgiCpHfiVZ5HrMJ9YHCaYSZT0VGs7QMuKay+ZQ7ZxphUekcNekE3UOgj/JdX6U7HT3J5vtqcXAAYr1nrCqHJLAJRQqf8Lys9f/HjVMljTMzkCG/C9M8qCQnBglMb9awxg8BTJPgrY+h4h/DJ/0t4X4VMyfHbknZfk2yiN9dCo43Ys8na4lOQhHyAFGiqi6k5Ba6QuQSEDrgftBW5gKXtE64k9p7Sy3oS6mONJVHeEWG//ntryoS4gHCelW3SD04dLq1N9EQZvoW13ufg0a8nBCwuaN5Z2w0OvWHfL78B8L2WA/9PhCVAXqTrzY7xHXUwqR87aXMwb5+DxQGte3e6u31qj+b/UDAgv/mPfIA9sFqu6MGC15jHNvklmaxEfCS2bEwkVgbKtN2zmWnMQ2oLWEZaIzgGBLhIhjk1CNkYiUpa+BY5UzkcfqUtg1Md0v3G/6qhVCu25j0EltVSjOsyjw+fkEkIf2Xi/4YP/YnYjTsUu1kk5RHijvqdg3rJJHMPAsrBF1iE6f8l6eRTgddMnD4B1t3Nsa2eC63+qSUU/cR1nTf6HMdouvydvh5yZ4AGugYgfZvckta82LwgTF525R06CTvNcamOX6G4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(55112099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjhYMGRvVHpmdWJPQm1FTXErcThIUnR4MWhLL0JkTVBlVVdhUHB5UmVHaExW?=
 =?utf-8?B?WDFnRUswRmdMdFhPRHhoN0FxMXFuU2Fwbi9BV1VEWEUzek9EOHpWcHNBdDky?=
 =?utf-8?B?Zit5dXVXMGRiNGpmRmErTjc2LzVadlVMNlZLMkFJUEZmYXNFcEtQV3BpT2JK?=
 =?utf-8?B?SUwyeFQrMjUrVkVzbjd3NXgrVzg5L295SWlQRU53cnR6Z0h4UFRURU9IaGp1?=
 =?utf-8?B?dFQyYVliSW5tMmNOaXgzZmVjYldDMHpkdm4xdXVxU0ttckEyUVFKek84R1Mx?=
 =?utf-8?B?Q0dWS0M0RHZPdlhaSXRzWG42QnJKK1ZXa25NQ2RDbnNkT2NTbC9CWCswR1o0?=
 =?utf-8?B?R1ZDb3NDc1hzcC93MVJLdXlwRVR4L2QrOTcvcm85VmR1NjZxSWZxdjNOOWsy?=
 =?utf-8?B?QTFJMllDajJ6aml3WTJLWmtZVEVMLzVKTktWam5Zd2dQTkorT3YrMG0xLy83?=
 =?utf-8?B?eEdySU9MN1ZyZUUxaUp3WDg0cVNZcEwxcTlxK0VLUDFGNlBaeXh3Z1lFTXkz?=
 =?utf-8?B?OTRiS3lKa3p4Nzd3dFFYb2VJKzRGVUx6OUM0YW9IbW5xU0hETG8zY2dsdmhw?=
 =?utf-8?B?aHpuV2VmeFBwZE4vNTVHRHg0cWcvMDBmZHdTSyswdlpPNHRCaDhpbytpZkVM?=
 =?utf-8?B?RzR6c0J1NDFPQU5UUEhHQ2hvZldnS1pvc1Z6Yk14Rm1zc3diOEU5TUNrUmdB?=
 =?utf-8?B?aEd6VC9nQTN6RWN5dDFGRVQ1VUF0SjVOV09BSHZVRyszVnlma2hCU1N6elYw?=
 =?utf-8?B?NnM2ZXEzamhzU2grVWg2MnNiSmlJdDRQeVpxeFZVdCtiMGZURjNQYS9VRjE1?=
 =?utf-8?B?ZHJzK0czNFBiZmJsSXBnMVJjQjRuS2JLNGM3WWUxL3I3R2x2M2ZYbHRrYk1v?=
 =?utf-8?B?bE0ybHpNdDB3UnVBaXUydENiMFVOOGRsSGUwMERDUG1ZUkoxMG0zWGViWk5L?=
 =?utf-8?B?M2pSa1JraU9KaG5pTnF5SUY1OTJsVmFZMkRtRkZLaklxTEVqVS9GZFlRclRW?=
 =?utf-8?B?d0RyWXpaMXVkNHkrWC9CR0E0V3kycGQ3SGw5cFJEd2dNWHlmQ2U1Ri9wVlFw?=
 =?utf-8?B?NEFTdHVrVUxBV2lxUjRSTHBxWktweTMzREJBRDB1bloyMjBWWGpaaFVtUlNS?=
 =?utf-8?B?Y1Vqb0h0TnNUQkFhb2pzZ3ZacjJOZkVJMjRFRWEyY0k1Q3YyUTlOeVAybkdX?=
 =?utf-8?B?Z2MzVGZ2c1dpdDc0b050Z2N3R2ZFbDlnNXM3S1RMOUhNUW84YU94SWN0VGJR?=
 =?utf-8?B?akppNnNiTUY0S3RCckRzV016NVRRWjZjN1VqMkRXU3ZIajN0bUdMZU5BS3lO?=
 =?utf-8?B?RndzV1R6QjY0cXJBN2tTSUVtTUtjUXlHMk5ieWZZOExnRkpvS1dUKy9ia1c2?=
 =?utf-8?B?c25mTnc0cDd6eG54WUF5cjhhaFZyU0d3U3ZHNWFJZlpGZ0ZKMUc2YURlcy84?=
 =?utf-8?B?TzloSkdCcFJoZkNZODQ0OGhqZTRveDE4VCtueXBhVE4vb216L2J5VlQ3ekVJ?=
 =?utf-8?B?N2hsSEVXQnRadUFUYXljVVUvaWhUenFROEhDYkk3eTRURi9GUHJQK05pV2k0?=
 =?utf-8?B?Zy8rY0pVRW9sUVhpQ1JUREJOeUxnTlBmOGhOMit4RDZTNzd5SSttYzBIUUht?=
 =?utf-8?B?QkQ3ZjJwQ2V0WncrMHhVa1RNYk1jWnMxZ1pRMVFuNEFuV0k0LzllQ1VtcmlT?=
 =?utf-8?B?T3N3T2RtRGY3c24wMmtQWTA5UDlSaEFFSytqVnIwYWRsMEhualV3Rm1YRjlW?=
 =?utf-8?B?NGJwaW5sM25qOVBJVTZuMFZGQ096WUdyejRaMVBxTXkyRy80R2VTTXFNWGhw?=
 =?utf-8?B?SjhyVUJzeDBoM0lFZ2FkVmxaNkYzb2x5YXVzbXA4RVRseXhLeUJHUWxadUNI?=
 =?utf-8?B?dEttU2Iwei8yenBTOFlIVW81d2d4NlA3YVo2MUNvdHJoT1RFS09zUUQ3T0hR?=
 =?utf-8?B?TWdzempNdDRUQjNITGE5TVlDS28zS21IZWxVck5CekFQVkhDN205eTR3OW0r?=
 =?utf-8?B?MFYyUUZNME1QSXFzZlJVOUZtY2ZZZFRpa3NBdyt4ZzJKd2duOUNQWS82WnVk?=
 =?utf-8?B?WUNaWXlPd1NDMnB4YmFWR1NqLzdNVm13TTNTSnAvUFZUdStjdXBmaU9oMk1U?=
 =?utf-8?B?V0xGMVdKZndGQzRGWkc0RDRsK1pDb0pzaE94aXNjRzR5K092eU85ZTJjWVBs?=
 =?utf-8?B?eG1PQkdpcW9ETWc2YnVCZnFWU0lISURJVG5SbUp6WDZ4S0pJbWhMVnZUc1FM?=
 =?utf-8?B?bzlGTkVPc1hRT2MzT3ZzOTNGd1dEMXJSSk8wQjRZMlg3WEFDUVVuOWl0bitL?=
 =?utf-8?B?b2l6YXRGSU4vTmNaNFJPVGlTSDJadkY3dUk4aENPQlFyKzNWemxUaklhSjR5?=
 =?utf-8?Q?dFXqNONcCfvgy710=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500941d4-4ea8-4a7c-eefb-08df236c5fcf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6204.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 05:40:48.1954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAwyznALVmFyGFCho4DjZorYM2u2MVYMiTJrfKMlIsOZaqNFBC/Y/ndRln+36gpdGLIOD33ql78Y6raE4JUAEaHlXtsmpRLEJjCPAX3zntU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR03MB989599
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


On 05-10-2026 23:25, Dave Klotz wrote:
> The driver sets the io clock to the max-frequency the device tree gives
> and fails the probe on any non-zero return from clk_set_rate(). Two
> problems follow:
>
> - clk_set_rate() returns the new rate on success and a negative error
>    code on failure. The SpacemiT clock driver happens to return 0, but
>    any clock driver that reports the rate makes the probe fail.
> - A node without max-frequency asks for 0 Hz. On the K1 clock driver
>    that picks no divider at all and writes whatever the calculation left
>    behind into the io clock's divider field; host->max_clk is then 0,
>    the capabilities register gives no base clock either, and the probe
>    fails in sdhci_setup_cfg().
>
> Treat only a negative return as an error. Without max-frequency, leave
> the io clock as an earlier stage set it and run from its current rate.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

