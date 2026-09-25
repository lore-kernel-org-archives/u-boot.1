Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA888C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5758E40CCC;
	Fri, 25 Sep 2026 14:00:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hLxkWAmSY2nv; Fri, 25 Sep 2026 14:00:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2FEF340BAA
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790344855;
	b=hQoRI2rhr13/6MoTmfuCL2NdOQuAO7n2UD7ftakfWI0XXNM5Xuo5xo1DxyYTxh7mbCFb
	 Ko923dkRR3as696+vKwQEe3tsgrkajlWvOA/I01fPgBIq+6jQuPR5rFB5bVb71Y88i4bj
	 17IACKBp5WnQRAe98QZpg8h6Hx08XvQXPZGC6UgWUNq8I8XehX64AP4ePX4C45emBNoop
	 gVyqSv5EWDPRxM5BpPBL+1KlsM70ZmVBAdYNfhJp8oXDK72aFfM1P5ycwluRDQUEhh5sg
	 ZH6njsp3/rfh5HnEbjzN1hcljItxt+c2Oww/0jNCVoYIndWk377K1qhmck2M7/G6FHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344855;
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
	bh=wYQ72jBt2n32wgklj4sdE4i2BwIcMZZCnL8rDbVoCrc=;
	b=Fbjn2TI28CHXanO9kI9IaIvyZedRB2UUYCH7P6XG2U8QblFOEtVdWD2mpfQ3eQz+GaIP
	 Vo0Q+A+TWJFb9eQR5VSp2hfPdjKQgAUcE7SJNlE149d0ga587jhJeqAAhXUrA4A4MMfbP
	 jvU5Ri3ignuTE8HV5IxSxHsb/69Ila22+HTvBRFeYIBLGCu3yMWzECS56Ru1OB/TlwlGe
	 Zg3b6C8ihic8zd0oOJHvfh4rjdUk7IvRp3EVbfih7xh+jkwIC/X+9PC+gbI+aGYPZR87e
	 1Kq8FaT40ZcBArLYSP6TrMkN1FE/gl5+ds7Ta/G0SPVd4xaL19csieeHI0Y1/vEl4vQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344855;
	bh=wYQ72jBt2n32wgklj4sdE4i2BwIcMZZCnL8rDbVoCrc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMvKgtE3sgC1FCMALA6UIOdYWrL83FjrR8i3uiqIFMz0SpBGHf/RMi0HCpYcHKJGV
	 DDk0IpPLGDpHSKky5qMJWjD6LfoXVfHLSBbu07+wbyD9O4sxZ07gjJ9WKX5GLok6DC
	 fPFcZVRZgloRHe4tb71D6L2cKM8pmEG94FsR+6yc2dulubskEA1Rw8lBdrM74e8kE3
	 JpTXgHXW1oTutGhy42V7R5nUDQK4SEYuano2Ygw0m+/ytEG5T2sqwMxiOn2D257L2z
	 WZL3ktX8HdgQmFPA3Zn9EfXnA1PfkNTllDf24SGHH1oAEJHSi0mt6nmETwm21x6imQ
	 ieM3R7AaihOng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FEF340BAA;
	Fri, 25 Sep 2026 14:00:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80EF8332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 663454005E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:00:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gNITJOiarNob for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 14:00:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B061D40180
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344852;
 b=E/E/DhcQGZbv4/1w8OwcdOU3BMl+AxIZXYrtC05D+eG/im3h7dmopjy3PSZTVnJyv2qH
 E4ysdnHb7M9BAL1azJXlDOXyWL/cQ21cCzMN/kYXTc6c6gPbNT7dDKzwWCD4z9yfCGY45
 lzt6Ln1TQCqPy90C1C5p3HSLCITkFqmw9B1BuJ+mRt0oae9EW49wygePBn1RSKFV7Lo+B
 DFbF73/vTORoZ8HWnoh8ZGSFTCUGd+0w0sE65+aVguEaDHCOi/+4ZtI1W7u9xO5w5PvMZ
 1LH7IGkRrZnQDKh0ZFVXMndlhgNgdbShezOiwzJcd9UGH3uH5mIwOAlyz10q3CWSPSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344852;
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
 bh=wYQ72jBt2n32wgklj4sdE4i2BwIcMZZCnL8rDbVoCrc=;
 b=kH38u6Z9qKHB/OLyDbr2YWgkl+PDfv73rHGXGSNvnWmWgwGk8QlA4JjHKuwVIEQu170d
 7WVycFVYOFhFqjgs+KyhJsSdmZwYBuN8Wg5eUnaF3HYSxQWoXcIZuQEZ65Eglt05y+DqW
 ajQyRQOH4aTHIUE32uooG5oWIFa1oAsWRnknVZ7jfkZpl3H8B9mFAiF0/J+cxZiKIPPp4
 KzEjQWaTGwOTm++emkWdCGpeiHTS9ilujtfgZPc7JDZW89XCdvags5Xblr7dAqwm+qagl
 UVRbil5vIKzrzHXu8CZSdCU3LFhnjivybnkh8qvCica1qVjXMa2IjGBKLpEbki2rASA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=16DuvvWW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=16DuvvWW
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B061D40180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPIuaRxWBXwpzZ+2pG++U9i3fzjZklxJ+KhRQqrJuOQeTr9JXpwpeYrAxAGa5tDT4HVP/QgEQXRqpl4+4gXge+7achRjomCLXG1Ne+cTBgJE7qx6ukg4u+c0a1rMMqeGYfueVzTluBYgale3WnFfJJZVB6lSHP1C7w14kn5Ls4Z9wOJWmBSL9VztJ92Uum8vghygKWdRMjKVWsOP0Pfe0cS/EeooIAfiFNknvY5L+T1dKYbiwoHiGChQOxA1KXJV2iAq4bPDKgechcCYnbph4W8XeID4YaDTAk3Ma1AkiRm21llSazDTg5PO52QBz8kGsncvd7fMk259fIOhuEjhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYQ72jBt2n32wgklj4sdE4i2BwIcMZZCnL8rDbVoCrc=;
 b=uDk7tuAOVqU0OGrVjBSesTJ4xaqRoU6p4nioeyvTv9WTC9PVS3tVOMJONJRW20MX0e0urJzAnQAKrC4g5XxzWyt7pxRixixlUZjtsNtkf9ctc2vnmDfvoBx5cJath0fUWnuU6yjn2ivNZzuc7mfpJhqnjBcdgM8ekwU5fVwiJwIu4eTD8DJBQwDCeWaz5NQDeydCc53mEhnD6x8ZlMgXWDgYduDC6VoOpKBM82OpdG/OfpGfgIX70CCHhwKajUDm+LUxlLpk/BB461n6lCxKFXVofEY4y2EFHoa8QaiBgO+N/xbbhjk+V6aukdlkJKLM7I7gNNHP0D0pQ9npe9oDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYQ72jBt2n32wgklj4sdE4i2BwIcMZZCnL8rDbVoCrc=;
 b=16DuvvWW+RAy7vDfL/xHhFR30yLHlrhO3INAq/KH0vKLkwH/pzfAg3RCVJZi0Htz5G9lMFiu1E5NZIi5+WJ229VYmbK14TGBKBROpWVfuvap0A3YZXZf/iZfnvkIzeTB+S4LKUDRstViA1UdD5IHwkcb2joJ/pmWl4IzXKYGwF0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:00:43 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:00:43 +0000
Message-ID: <bab7f25d-72f6-4ef5-b187-07c2e723cffa@amd.com>
Date: Fri, 25 Sep 2026 16:00:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: dw_amd: Enable CPM6 host1 and quiesce interrupts on
 init
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com
References: <20260915041717.1956044-1-pranav.sanwal@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260915041717.1956044-1-pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0009.eurprd02.prod.outlook.com
 (2603:10a6:803:14::22) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: e0820789-f24e-440f-e8bb-08df1b0d638a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|22082099003|56012099006|18002099003|260925022911599003|11063799006|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: 9rSBk1DaK4u/VebFoWPF28A0iaoReXqLTgn4RIoaNlrKmznZAT6iDhs9b6PCGiuEOoFm4RZbPHlGEauv2I7BORjxzEM/Vbuqc39leqO0F3hVJgQyzNjdABeHJssVyFbqG9RgZfhcejqmQSNMfbPV5rnu50yIGKItvlVYeM7zrYXP14z2kkIaFRUdQKgTBkiMJf/PqgavBa5jx6t+3Hy8FNIqviElYuseZFLxBws6BLAqf5V57D/fh6W1x9wA0vMTy6GuudSvTg1SAcjTcw1NCddeyQVYiLBh7xrMoTrKgk0CNtEp+6mJTRnLCCyv6PVb0l72o2NS54kBCC4mwKvP2ljF6Z2xNcBUdeb4XL/2UCd2EIMGi2Iya1/ODyVMrvPpo3B8Ab130XV+lJ0nx1HLiNvZxQsilqNqBY5hZowCd8bgO+KTABdUtFdR2VQlk+hqjwdOKojEsHd2MXnAgdaRvQwYcTewRhsJfMPi5Zp0f5VO2walwvvZeoB3aqpVQAYLuu6Ow76nXcjpfbdTaSywKS9HVXnPYvFQ1Kcv/sHjv9DmdzzQgXughzf/1iW14fofM/BwzxTMG9zbGMFTRGGOg6RKvmB3vOaV0oAS04kHg5ppKVJiEjx9qejD6u0tqb4hsXXfrtJ8TUc9dS9Iz3I6QeieBOextp2782j4U4fO6oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(22082099003)(56012099006)(18002099003)(260925022911599003)(11063799006)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZJK0htc3RBQlgyaEdNd05GZGxrc0Y1cFV2V2xIdGl5SDlZalR0d2tYakla?=
 =?utf-8?B?MnZvUXdOOXZIN2ZiTlV1R3hZN1VCVzZyK2dUZzVqUXAvY3dJdXNnanBtNm9a?=
 =?utf-8?B?Vkc4cFRDUnJzVlczTUtyd2RyRk9uNHNkQUwyUWM4RVlkdVA4RVJUS2c0S3pV?=
 =?utf-8?B?QU5YUUVwbTg3OWJVL3NVVGNGWHNiZm5lSDBjWHQ1TTF3TWtjcWRjQitMcmtq?=
 =?utf-8?B?bUZybytZY3MyYlg4bGlCOERGVHFTZW53cnpDM0Q1VGtGZWl3NnBIeFBPQlVJ?=
 =?utf-8?B?WElKSEYrVzB3ajl1MG93TGNtY3k2Slk5MVNaVGVKcngzK0txK3ZaTzZWYjI3?=
 =?utf-8?B?eWRWZGMrUFdLaWhvQTRLZmZpeVZ6NDNKNGN2NXNFY0lqRHl4S3NKOGFGQTVZ?=
 =?utf-8?B?QXJ0aVVMT3pYUS8wKyswYUplT1JCZ0xsYkpKbjVMejNJY1VEbHlNdE1JQWlN?=
 =?utf-8?B?amFTZkMwakdzYlNOV0k4Nkc4NE11dGNHSDgzT3pFdi9vRXQrejlrWjdSZUpj?=
 =?utf-8?B?bWVjdmJIdVpScVI2eStTSEYrQm1Ga0NVZGkydFhnbDhabUJBWCtDMExhMWxS?=
 =?utf-8?B?RzUrbVVPSjVmd1NQMm93UC9GNnl3QmM4Qm4vMGdZYmFxSm5qa2krTGRESlpl?=
 =?utf-8?B?SUxBbCtRRFcrNWtjUUh5T3NXNldTb0JwMWg3Q0hpME5mU0p3VnBpeDNUREZK?=
 =?utf-8?B?Tk9sYUJNejcyRFlJcm1vQnJ5MDhZZ0RYa21UT3F0TmxUK3hMeEtMdGV2REJQ?=
 =?utf-8?B?MG92Mmh1UGsydHZMeC9ieGpXSTNTQnpXOG84QmtQRmZ0STVac1RqajBwYlg5?=
 =?utf-8?B?Uk1YZ25kNlBLditHd2FEbmZkcjVRa05BU2hzZmhNMDRQbi9NTDY0eFBwV0dC?=
 =?utf-8?B?YXJXNmFzUk83VGtLSkVPc1hqdE05dU5oNWFLa1VEb0tzeTcyN1BzMnF3VDF5?=
 =?utf-8?B?dDYrYkE2aU93ZmJqc1FnMytjVkV5VkVRc1RqUmVXcEd3ZnVUQVdvR0hDb0RX?=
 =?utf-8?B?SE9EcG1rcmIwSTFETlNIZHpwTWpWblZNc1JXcXduTmkrWERiWm5KMDczNUl2?=
 =?utf-8?B?WElNb2FwS08wWFVpSjRuL2NvYzZDVUdoWFRsMmlndmRUeDF4MWsxWnkyZHdM?=
 =?utf-8?B?Y2pRWXlBejNsanZtOGFkM3JLVi9JSnIwQ3dNNng0aFlPUUF5Tk5JMjVRb285?=
 =?utf-8?B?Z3ZSL0huY0NJNndHQ25GQk91TWRHVjZHM05iZWZuU3MwQi9QY3phKzRYNTgw?=
 =?utf-8?B?bDZxS1FQVU1yQ3h0V1psUHcxSktSdWtzMU1EdSs0dmIxTVN3K0p6amFWeXdC?=
 =?utf-8?B?Y2Y4dy9wVUZYanBVcjZYLzlZdE9YcnVLamJCVTkwQzlJRWsrWnowUW5Lc1Qr?=
 =?utf-8?B?SHczam1Cc2JZZmpQMXd1Qnh0QUtNTmo1eW11cnlmSjBGcmRDcWprUnVRUlVq?=
 =?utf-8?B?Vlo0MEgrUWg3WE8xRjIrSFI1RmdhbjZOVTUzN3RyOGs2MWJUNDBrOVFKWVpI?=
 =?utf-8?B?djBCbFc1U1NBb3d3bThxelZBYzczTEFmWlVrOXJKbWprYnk0UmlscFpNcGFS?=
 =?utf-8?B?ckFseVFRUVgrUFEzT0h4ZmlkTkZHZmMwMnJ3Wis2T1U1WnYra2UrNnJLTFZk?=
 =?utf-8?B?S0tpRFVRaXI2MlR4dlI1R01idWVmWk1tdTk0Rng3cUMrR3RablhtS3puOFdI?=
 =?utf-8?B?elg2QnUzNlh3Lzc5TzE1MTl6cVJOMWFwc0ZzdUpWaUZGTEFxbVF3WCtSbjdv?=
 =?utf-8?B?MGtuOWI4d2o4aGltL1dDWUpYRVRPUFdSd3pObkhxWkFoN0R3blJpb3kzTTd1?=
 =?utf-8?B?cHpGd2RLUVdMbEFPQlRLb1JlWXdLTmdObU1QZUFaNHZUVU5pZFB4ZG5FRUVH?=
 =?utf-8?B?cTJjcms2Qk5ZcUZ5UlpXTm1ESmlyRmwrYWc3M3hzNC9XU1lwbm5La2s3UFNW?=
 =?utf-8?B?aTRKcVJKaEVUbjljeS9lbTE1SUJuWUFKK1BsTE1MdzZYTDc2WG84aTVnNVM2?=
 =?utf-8?B?OStSN3g3Z0crZW1Dc0RUamJXcGxjeUJGUWplWjdIajMyeENWNlA1QlNCZXZm?=
 =?utf-8?B?Ujl0Snk4ek10UkJvS0JSeWsvVlN2d3JReGdSY0IxLzZOSVhONXdPMkZCTnNJ?=
 =?utf-8?B?WHB6ZWtkRlFic3YyUVh3T3R2d2s5M1QweERXS3JvNUk4Uml1elhuUi9YRVJ0?=
 =?utf-8?B?NlAwM3BsU2g5a0FpbTFnTWdDM3VreVEyR2hwOFJab3RYRFpzRlgrZ1Z6cXNG?=
 =?utf-8?B?L1BmeXFmRlpuWERNbTl3M1M5UlQybHpaSHVCRnlqbDQ5QURET05qNmYyUVVo?=
 =?utf-8?B?a1AvUXMxRTdvN0dKSFlLakM4V1pvK1JQaW5EdEJLVDJ3TDZ3ODNiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0820789-f24e-440f-e8bb-08df1b0d638a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:00:43.5756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cksQMBsJPjCkOl24cVCcUhIbhmvPuoWVO4ed6nSNPsr6mQSsPmrC5xJVM+/ugf9P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
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



On 9/15/26 06:17, Pranav Sanwal wrote:
> Add the amd,versal2-cpm6-host1 compatible to support the second CPM6
> PCIe host controller, alongside the existing MDB5 and CPM6 host0.
> 
> On init, disable and clear pending interrupts.
> 
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> Message-ID: <1d855c8127c24e3423e62671a4a5c08a9e4a6e32.1789111144.git.pranav.sanwal@amd.com>
> ---
>   drivers/pci/pcie_dw_amd.c | 116 ++++++++++++++++++++++++++++++++------
>   1 file changed, 98 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_amd.c b/drivers/pci/pcie_dw_amd.c
> index 944458e668c..9e545d6ec7e 100644
> --- a/drivers/pci/pcie_dw_amd.c
> +++ b/drivers/pci/pcie_dw_amd.c
> @@ -19,14 +19,23 @@
>   
>   #include "pcie_dw_common.h"
>   
> -/*
> - * SLCR (System Level Control Register) Interrupt Register Offsets
> - * These are relative to the SLCR base address from device tree
> - */
> +/* MDB5 SLCR (System Level Control Register) interrupt register offsets */
>   #define AMD_DW_TLP_IR_STATUS_MISC	0x4c0
>   #define AMD_DW_TLP_IR_DISABLE_MISC	0x4cc
>   
> -/* Interrupt bit definitions */
> +/* CPM6 per-host MISC_EVENT registers, in the separate "intr" region */
> +#define AMD_CPM6_MISC_EVENT_STATUS	0x514
> +#define AMD_CPM6_MISC_EVENT_DISABLE	0x520
> +
> +/* CPM6 shared aggregators in the "slcr" region, common to both hosts */
> +#define AMD_CPM6_PS_MISC_IR_STATUS	0x340
> +#define AMD_CPM6_PS_IR_MERGED		BIT(21)
> +#define AMD_CPM6_MERGED_STATUS		0x648
> +#define AMD_CPM6_MERGED_DISABLE		0x654
> +#define AMD_CPM6_MERGED_MISC_EVENT_HOST0	14
> +#define AMD_CPM6_MERGED_MISC_EVENT_HOST1	17
> +
> +/* MDB5 TLP_IR interrupt bit definitions */
>   #define AMD_DW_PCIE_INTR_CMPL_TIMEOUT		15
>   #define AMD_DW_PCIE_INTR_PM_PME_RCVD		24
>   #define AMD_DW_PCIE_INTR_PME_TO_ACK_RCVD	25
> @@ -45,6 +54,8 @@
>   	 BIT(AMD_DW_PCIE_INTR_FATAL)		| \
>   	 AMD_DW_PCIE_INTR_INTX_MASK)
>   
> +#define AMD_CPM6_PCIE_INTR_MASK			BIT(22)
> +
>   /* DW PCIe Debug Registers (in DBI space) */
>   #define AMD_DW_PCIE_PORT_DEBUG1			0x72c
>   #define AMD_DW_PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
> @@ -58,31 +69,88 @@
>   #define PCIE_RESET_CONFIG_WAIT_MS	100
>   #define PCIE_T_PERST_WAIT_MS		1
>   
> +/**
> + * enum amd_dw_pcie_version - AMD DesignWare PCIe controller variant
> + * @AMD_DW_PCIE_MDB5: amd,versal2-mdb-host
> + * @AMD_DW_PCIE_CPM6_HOST0: amd,versal2-cpm6-host
> + * @AMD_DW_PCIE_CPM6_HOST1: amd,versal2-cpm6-host1
> + */
> +enum amd_dw_pcie_version {
> +	AMD_DW_PCIE_MDB5,
> +	AMD_DW_PCIE_CPM6_HOST0,
> +	AMD_DW_PCIE_CPM6_HOST1,
> +};
> +
>   /**
>    * struct amd_dw_pcie - AMD DesignWare PCIe controller private data
>    * @dw: DesignWare PCIe common structure
> - * @slcr_base: System Level Control Register base (for interrupts)
> + * @slcr_base: System Level Control Register base (IR block on MDB5, MERGED aggregator on CPM6)
> + * @intr_base: Per-host interrupt register base (aliases @slcr_base on MDB5)
> + * @version: Matched compatible variant
>    */
>   struct amd_dw_pcie {
>   	struct pcie_dw dw;
>   	void __iomem *slcr_base;
> +	void __iomem *intr_base;
> +	enum amd_dw_pcie_version version;
>   };
>   
> -static void amd_dw_pcie_init_port(struct amd_dw_pcie *pcie)
> +static void amd_dw_pcie_init_port_mdb5(struct amd_dw_pcie *pcie)
>   {
>   	u32 val;
>   
> -	if (!pcie->slcr_base)
> -		return;
> -
>   	/* Disable all TLP interrupts */
>   	writel(AMD_DW_PCIE_IMR_ALL_MASK,
> -	       pcie->slcr_base + AMD_DW_TLP_IR_DISABLE_MISC);
> +	       pcie->intr_base + AMD_DW_TLP_IR_DISABLE_MISC);
>   
>   	/* Clear any pending TLP interrupts */
> -	val = readl(pcie->slcr_base + AMD_DW_TLP_IR_STATUS_MISC);
> +	val = readl(pcie->intr_base + AMD_DW_TLP_IR_STATUS_MISC);
>   	val &= AMD_DW_PCIE_IMR_ALL_MASK;
> -	writel(val, pcie->slcr_base + AMD_DW_TLP_IR_STATUS_MISC);
> +	writel(val, pcie->intr_base + AMD_DW_TLP_IR_STATUS_MISC);
> +}
> +
> +static void amd_dw_pcie_init_port_cpm6(struct amd_dw_pcie *pcie)
> +{
> +	u32 host_bit;
> +	u32 val;
> +
> +	writel(AMD_CPM6_PCIE_INTR_MASK,
> +	       pcie->intr_base + AMD_CPM6_MISC_EVENT_DISABLE);
> +
> +	/* Clear every pending MISC_EVENT bit, not just the ones this driver knows */
> +	val = readl(pcie->intr_base + AMD_CPM6_MISC_EVENT_STATUS);
> +	writel(val, pcie->intr_base + AMD_CPM6_MISC_EVENT_STATUS);
> +
> +	if (!pcie->slcr_base)
> +		return;
> +
> +	switch (pcie->version) {
> +	case AMD_DW_PCIE_CPM6_HOST1:
> +		host_bit = AMD_CPM6_MERGED_MISC_EVENT_HOST1;
> +		break;
> +	default:
> +		host_bit = AMD_CPM6_MERGED_MISC_EVENT_HOST0;
> +		break;
> +	}
> +
> +	/* Mask this host's bit in the shared MERGED aggregator */
> +	writel(BIT(host_bit), pcie->slcr_base + AMD_CPM6_MERGED_DISABLE);
> +
> +	/* Clear the latched aggregate: this host's MERGED bit and PS_MISC's MERGED bit */
> +	writel(BIT(host_bit), pcie->slcr_base + AMD_CPM6_MERGED_STATUS);
> +	writel(AMD_CPM6_PS_IR_MERGED,
> +	       pcie->slcr_base + AMD_CPM6_PS_MISC_IR_STATUS);
> +}
> +
> +static void amd_dw_pcie_init_port(struct amd_dw_pcie *pcie)
> +{
> +	if (!pcie->intr_base)
> +		return;
> +
> +	if (pcie->version == AMD_DW_PCIE_MDB5)
> +		amd_dw_pcie_init_port_mdb5(pcie);
> +	else
> +		amd_dw_pcie_init_port_cpm6(pcie);
>   }
>   
>   static void amd_dw_pcie_start_link(struct amd_dw_pcie *pcie)
> @@ -179,9 +247,20 @@ static int amd_dw_pcie_of_to_plat(struct udevice *dev)
>   		pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>   	}
>   
> +	pcie->version = (enum amd_dw_pcie_version)dev_get_driver_data(dev);
> +
>   	pcie->slcr_base = dev_read_addr_name_ptr(dev, "slcr");
>   	if (!pcie->slcr_base)
> -		dev_dbg(dev, "No 'slcr' region, interrupt features disabled\n");
> +		dev_dbg(dev, "No 'slcr' region available\n");
> +
> +	if (pcie->version == AMD_DW_PCIE_MDB5) {
> +		/* MDB5 has no separate 'intr' region; it aliases 'slcr' */
> +		pcie->intr_base = pcie->slcr_base;
> +	} else {
> +		pcie->intr_base = dev_read_addr_name_ptr(dev, "intr");
> +		if (!pcie->intr_base)
> +			dev_dbg(dev, "No 'intr' region, interrupt features disabled\n");
> +	}
>   
>   	ret = pci_get_regions(dev, &io_region, &mem_region, &pref_region);
>   	if (ret < 0) {
> @@ -222,9 +301,9 @@ static int amd_dw_pcie_probe(struct udevice *dev)
>   		dev_warn(dev, "No MEM region configured!\n");
>   	}
>   
> -	dev_dbg(dev, "dbi: 0x%lx | config: 0x%lx | atu: 0x%lx | slcr: 0x%lx\n",
> +	dev_dbg(dev, "dbi: 0x%lx | config: 0x%lx | atu: 0x%lx | slcr: 0x%lx | intr: 0x%lx\n",
>   		(long)pci->dbi_base, (long)pci->cfg_base,
> -		(long)pci->atu_base, (long)pcie->slcr_base);
> +		(long)pci->atu_base, (long)pcie->slcr_base, (long)pcie->intr_base);
>   
>   	return 0;
>   }
> @@ -235,8 +314,9 @@ static const struct dm_pci_ops amd_dw_pcie_ops = {
>   };
>   
>   static const struct udevice_id amd_dw_pcie_ids[] = {
> -	{ .compatible = "amd,versal2-mdb-host" },
> -	{ .compatible = "amd,versal2-cpm6-host" },
> +	{ .compatible = "amd,versal2-mdb-host", .data = AMD_DW_PCIE_MDB5 },
> +	{ .compatible = "amd,versal2-cpm6-host", .data = AMD_DW_PCIE_CPM6_HOST0 },
> +	{ .compatible = "amd,versal2-cpm6-host1", .data = AMD_DW_PCIE_CPM6_HOST1 },
>   	{ }
>   };
>   

Applied.
M
