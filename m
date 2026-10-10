Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925EACA9EC0
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E26960669;
	Sat, 10 Oct 2026 19:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ssFFFZWobMEX; Sat, 10 Oct 2026 19:28:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23BDD60639
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791660483;
	b=OSqFCRL/jdxNaZTC9W00vYs8PXtrzEwP4R+zHLqAEvS6OwGD1C+DzdelzpZ8hk7kLmuZ
	 Vfh4eupd1CXLZx01n+dPXTfigFZUgcszDUPmeky5bxNsW4kry2ttHnnhZbaukQ9BQE62O
	 xm3b9INNy6PmhvGa3ZJQXbyto6WEnLN4ycSPYg13QWXQYs17PURWXUeExHnFIrP4kmNKP
	 lh/E95N9ehmyvh2IPExfVp6ASkPX2ZFkVd5e+Ramk9eG50ANpgzAn/tpQDurUKvYO3iIj
	 FL/fQwlEvfBgWZVgS58dePWzq/WtfLHSy10j9aCswnk8kW5Js0BPDCRv9u/taYdT6Lg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791660483;
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
	bh=T3DP+8iODqsKlHh+ScZzIlcmqS3ZmpclFnb10MO2fTU=;
	b=tF5J8MmbSdnNotUgujvaCMNHsvdDIsMKP8TbB/gOBAt/cTIw3QjK6M5v7T/caI4eUjh+
	 xB0D9dOMa6kx/922lsmetLuXSUoKP02+UowIdbUKWhJK1OMJLuD8+ZR2NmQWcHBpRJ3it
	 2Se3y30E+e6ufoc6Gf1t/KnSgjl4lTk/uWN8av6YqEOxpUtgNwj+dbv5eyXFacIPznhwS
	 Bs1hZMA56AJbtMdjYUIqZDJnwuLuZ7DibzOJ6RPfiWGF79XzrfJ242IOHQekA1JpkPogq
	 3Or3A22wD+C0BAYYF0bN4ZgEvpfDgl0yPBVQJHPvURihamaL1vDHo1hnxubGTF1gC0w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=XgHIkmA8;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791660483;
	bh=T3DP+8iODqsKlHh+ScZzIlcmqS3ZmpclFnb10MO2fTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ypnKcPJhOSTeezzO8tHTy1OpmGrDg0ULWF54QbqZDFCP0fIoVmIcTi2GeeZ+M5ouQ
	 swCKRc2ZxDoTLmXRwXcC6Bo4EPMpA7x80n8CVzqOjQcJcWFC+ScoDwVM8982E1xLGO
	 bQTr5K3WEY2tLzUs5qBsleTDxc7ED3hWwisMGwSXZ1lECOXQKnEDZaxQqlpfe1DODU
	 7J1oHk3vXHWBjv+M1strQ38ng+zflyFkYR2oN/1FyFyVy00/iylv9k5Z2h+WDu1jCv
	 ARPG9bAVjsIGiiFFof+iDf7E7BvBzhus6CgTcB0XSbBPrfBasMvAousRCPN5bVrHpC
	 sw3LIVZk+Rxfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23BDD60639;
	Sat, 10 Oct 2026 19:28:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD11B356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 19:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A341E60639
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 19:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 54Ty7RY2mILj for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 19:28:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F2A060634
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791660480;
 b=XBc5hqxDLR7XD1J1EevLZ3Nx/JKKSq4zm2zJWEzaOnvduHOOf7mqHewB4GU5HiHsnv5G
 ZAqtc6oUdeHezbrHY4B/ndID2IR9eT8V7biqcFpFm2F6NFgnVXhvO3PtbjCNDp4n2/2WB
 7WM27BkNrzFh4CPRuSr56AdO6+ygWu2udvU+b70BZx8dgiTbMW/Vauw/udaMsycAJL5UK
 wACZxRw99APOuxI8XXo3oImNHimiDVudEeJZs2UDLNRzjzUFbD82TTACrkiEgQoz50Bwq
 I9m/FwgCQHcFp8f+8l2KmkajAaZjsjqNAqm5/ID7T3+iiblf2h63na8a+092906Ne4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791660480;
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
 bh=T3DP+8iODqsKlHh+ScZzIlcmqS3ZmpclFnb10MO2fTU=;
 b=KZd/3nbkwdo+CvivBQy+saug9n1KDZm6x7a9KQqy5DkhgeOgRuyIBq6NWWplKHT+MR48
 b/H6l5phvPEhJ1iLql21ZB3uLcpTWTM4Vb+aQhJp1SJQRYU3wTmhXQv1uT2QeXYwmaoTm
 yOcVjPqAZuyCoipBLJRp6t/Z6GfZ4AtDbFrZLo+aEjHJZ8tm1HUCQZ4DRj9AhyrQ+Jytc
 prF9mzr+TbPUHVFafCvyjO4KMskUbVqY25fIATJpw6XL4qHBFPx9u/w36LTODWz5/Hzjg
 xSMWDakWAi3nmguFxuOEE5ExdJU1y40x/Z7EY8h1ItEOM3Kp2Zv56KqAm8yEbyHKFFw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=XgHIkmA8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=XgHIkmA8
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F2A060634
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 19:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsWG5VEQHq/eaZMEepGpCJqCMRXnhLHLTS0k9Y8EEL+1s86eA6Kg+WUgaaykU3n+8GApBHquzIxWJRSLemJUsfzhaxw1zWneRRwKtNB5kbXDC1eyM/G5OazTXSNnV7a3RBuvW+xosQIenOcsPEu+ZadJ3H1ohSRplfSbhojaDewXpVKHTrrwlDgIviOfluPf8RqzSU7drd7jo2yg1a70n11d+6WY2pTRwpCCzw5x93QvrsW+ilJ1KTRMZfeT88u4DPtTac3XERVjC5/2jD3IF7cJzKzTTsuXMkda+XcGctWEm2rA1jAVU+PXElCtGDYPMS6Ak9mrCYL3+99hh0Sqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3DP+8iODqsKlHh+ScZzIlcmqS3ZmpclFnb10MO2fTU=;
 b=y9bo4KOyWJGq+D/n164yIKcxqVSuXOT7aej0CPMENPSUc5YAgv5c/OvIu2X0clEng0EtbQXQqvMQ05/oLZPnsZb03xibMIxULucYxlVp1m2zvNWS/xhpI8fvIVofBisuGlcr35j/6K1pzn3APWX1JG9HjaSHlU3koECglKXKF4xIBe2tzdzlb4Qbjr6bcq4ZWw2SQQB4uJLLeRxdtxKqOa7bTUeqmK25ONVoMGebMbMIKopVhYmjliFnHCPUhGV9CxjnAhfmX556rJguhN49A+yBK3gDc8bj3igPm7K3SC/HCKs5PvGWuqApj6wYBWiscunqoIqRpxZYLADQG61gBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3DP+8iODqsKlHh+ScZzIlcmqS3ZmpclFnb10MO2fTU=;
 b=XgHIkmA891QBZ6Jv1Jcekw4MleK9ccCxeYfJfPSll+Qw04VZXc1Nn2i9LAyQiDv6Hf4VFyud7UVLxU6RrXV+hkCUd3jHgooC+XH36vDBgYjvcSgdDa9Yly9WxmArOtOzOOraHfz76mmzCCpLezpK20mUsBRke3eLaaWDMGRwAd5eZ9WQNXpw5rnnMhbxvDsbzQs21HQ/F1yMqWN11hnQKuQVSvHMoRaO8yrfLSqZcs+dMehF+ZR+ZBvPoJzXsONsYvNJvKKSylwn6+59sd45MWOOFkABosF1I5oT37MJHWHgl9lDxmi7tZblTgUL+OYaI1pNjmHnEJd1ritb5XPlLQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH5PR03MB7958.namprd03.prod.outlook.com (2603:10b6:610:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 19:27:55 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 19:27:55 +0000
Message-ID: <3bfa079a-3447-4fbe-9c61-a57a8271a3de@altera.com>
Date: Sun, 11 Oct 2026 00:57:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: k1: do not release the shared AXI clock and
 reset on probe failure
To: Yixun Lan <dlan@kernel.org>, Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T140306-0400.mmc-v2-0003.DaveWK225@protonmail.com>
 <20261010071423-GKC26088@kernel.org>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261010071423-GKC26088@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0090.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH5PR03MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 08498fea-dda0-4c91-e3dc-08df2704952b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003|55112099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jhEyeWkxnpvF71S4rdeIMdIdQhLYb9Ub+MxDtemevD9N9EG8YbxslKgFnYs999+Kg6qyfjQCmfhRSOMdP9bwVI3UrphLCGLWYbtxAQdxhsosgsEInB8WrhgPFyVrgQDWIFOha3DpC7eBc4iez4l5yy8NqpfpYVewawhYWdd/7R1tS+K/B8ntTnSNaNYrID225I6NoxMQPNNMi/rHzJXS0NzA+GxFwwKVwx9aU3R3tnE6iLbyBAyUBp6tHC+1SjePA0/fbTCbDmrkTypn94wmf7CT60g/+70o/ldCjHvpTU9ZAn2wTB4smpYDeOKumJslfvG5OiVpH7rDuWZofdw7LechnBCeOWIrvmQHAoUDTW4jcdyvzCxelgS9xIsj7ld0hA0MB2F5FP9D9QUaTES+zkiWMLAtmQFB6Q9XaGeAfMBzvFLZqB6d2jTRTZM3Jwzn3URq4LBZvTryIyTnxD0AlePnHKRzducIbpPj++O/KVI31QM5qTNqVPncvOPqZCdzwrwZ8kcTTG9phYZIIbusa5lNbFnkr8RyO+T4Q47pfphe6Lwr0rBXcjo+fEbVSxyykVOsrU4aghC8rBoqBOc2TwWGkGxoGWxVO8zihSr5d6O6QbMlEmDRpbpiCN5Ef/Ge
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003)(55112099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnl3UlQwTHQ0QWtadDhGMllKNDcrdkpBRnNibCtPZHBYMDFoeWxXcXRFTk1G?=
 =?utf-8?B?ejNDUE00VmJQL0VXcFpUU2piRG5iNFdKU2I4a2dCU09KV2huRmJvWWxKMStS?=
 =?utf-8?B?WTJKK1BPaW5qUFNEb3dHa2dWVnZ5eXMzekc2VlUxb1dZYXBHMlpVYTh4ZkRP?=
 =?utf-8?B?anV2RlBqSzZFWDJTZGRHMGMxaUN0WUExakFmNXdOMFlHMFc3VzlqRE1QazlU?=
 =?utf-8?B?VWpoKytvUVdzMmxnalBFVjJiU1VVSXpuV0c3N3VIMDJSR2VHUXpjcWZHTHJG?=
 =?utf-8?B?Q0Izem5DeGUyWTcvbU84TUMvS09YUWJoOE5KbXEycmRGK2MybFIxMEVweDRJ?=
 =?utf-8?B?YXRwcGlFZkdZSHRiWkFPMkh0MmMwOGNsaHJVcm51c0dldXAxUXZsanJNVzM4?=
 =?utf-8?B?cFpKdWx0UGN2SnFYaGUwT2hZOUI3ano1eDRkaVYwUEdDMmxzRjZkSE9oeXND?=
 =?utf-8?B?ZEM1aW02K3QrOUJvSUtaMW1uL3RSTVVrdjUvMjc3YnRLZkl6YlRiYUIzcVc5?=
 =?utf-8?B?UFNMb0t1NVBPdVFHMzBkbzNYVjVzWXY1UitZc2dReXBsN2h5SkQ1TE4zKzlF?=
 =?utf-8?B?eU9vZ2NqZ1pzaFkwM0Vtejk2N2ZKcW9nLzlYdG5jM1loM3V5bld2M3J6cXlw?=
 =?utf-8?B?aTA3cFNuQmNROUUwUEVIWEdPaWdpamwzNXROaWNldDAwa1UxT3VFb1ZtZ2k5?=
 =?utf-8?B?Zk1zd2ZzOG5XWGVNZVRNNmhFQ2RLQXNCY0d0bVd3S3Y5NjVFemVkd3MwV3pG?=
 =?utf-8?B?RWpISmcxSHNsa3hjU3FtMjlBcllVSUVaRnc1b0tqMWVMYTkzcitSWEpYeHBz?=
 =?utf-8?B?QTdyVlZaL3I0NWRrSS9ROVVOazJreTlPdEZWZGFoK2EvY2lNTk1hZXVMSFI3?=
 =?utf-8?B?a0VwRlBuSXM1WjE5WXRUWnRRa2VjVVA1L3lya1FEUDNjM3ovNHJJYmVEbXRV?=
 =?utf-8?B?MCt2UzZNSE96NkNpRjcwKzlEb2MyV0pxeFZMMGdCQll6MW9TNURXWGZHRy9J?=
 =?utf-8?B?cis0ZWVudk9kcy93OXFsYTVlZ3RZbWQ1SEVNUlVGVElsWEkwTHFKeVdhQm5a?=
 =?utf-8?B?VlVmNDIzU0p3RnlOT2dFdlBZK1BEa3IwZFl5NndJRGg1R3EwVitsMjN5Q05M?=
 =?utf-8?B?ODJrRTJ0RGtWK0x3K0l4THVPeUl1bytHc0ErRDNuRTN1dkpVQlhYdTRCNEZh?=
 =?utf-8?B?MDZBeHEyclhkR096Q1pvNC9QWUNQNHNncll2K2lRTFpvMndvbFVpaUg5Mnkr?=
 =?utf-8?B?VjRTczlTaTBLMDRJb01qVVVjbnNVaXFSNWo5bjF5NEthUFJWRzMzaWlUZmsx?=
 =?utf-8?B?TkJjcHgvYXJSRlZ4UDYvcWRvdmtYYVZCVWozQ0VNTytWOXRLQW1JMjJ3UG1t?=
 =?utf-8?B?WWZFa0I5OXkvTzdYQnFCR3lkUGhwZmJRcFJkN1FMYXI4YXhTaEZsWTRBYmVO?=
 =?utf-8?B?WDBRcGVRRWFoOXduei83a04zTGoxeFY5akZvZUIraFVlNndsS2Jla24wRDNO?=
 =?utf-8?B?VjkwV2xBbG1wNzBON1VhajUrMkRoYjZNL2hMUkRMODhEa1pWUzNtYTBmRG93?=
 =?utf-8?B?aHhtdGtYaFJ0SjR5SGkrSVBTT0hEdVZ5YzUxMm1HUHl1R3R0bnVPK0tBdEkz?=
 =?utf-8?B?MXZmcSt2SHJpU21pZXlueVczYm9mWko3ckVMZkJDYmtRMmxkOEp6K01hQnFs?=
 =?utf-8?B?ZDdzYnBsbk1jaE9VSkRzZ3Myenp5anNXY0JVR1IyUVVINEQ5dE41WVNZYmRX?=
 =?utf-8?B?R3IxMldwWko4aGdjeGdPNEJhbWlMZjA2cWhFdm5Vd0xOMFRxUDFIWFFVcU9U?=
 =?utf-8?B?QlUwb3hKUTY3WmxjQTdLMktRTXpadUpZUVBySGhSc2lLd3FUdk8zSG1xZTNw?=
 =?utf-8?B?SUk5RzFhWDNmVmdUcWdxRG1kY2VUT21uZlRJSEZpUU1sNUYzeGhYWFAxRjM4?=
 =?utf-8?B?NlUrRWpCVVcvbTQ4c2VmeldPRHZXVUM0SXdGRnNucUI1cUFhU1YrU1VNWlNw?=
 =?utf-8?B?eEtyUkRaOVpWL0pWT3NMVGRVeXQyNWMybzNOcFhBZnhibXk5WWJFY2R0SkRl?=
 =?utf-8?B?aExYQU9VT1ovUVRNczRTQlNpRnp6UWNXSzRzVVMwd3J5OC9lVTJ6NDI2Umgy?=
 =?utf-8?B?NVM1dHBDTnFVb3RzK0lGSS8vSWVMZlpmTE02UFh6eno2QXF5OHJTcHlqMld1?=
 =?utf-8?B?SFRjZ1poSnVZMjM1WE1OQVh1SEhxNG5tZXFiUEQrRTFzMytJNGxvTUQzRUNj?=
 =?utf-8?B?c2luSE5iOEN2UTZUTGZZS2JDMlVNK2FuUU5GS043VTJhQ29Ram0wa3k1VHEr?=
 =?utf-8?B?bGJhaUxqaEtqYnhXK3ZlMEpQc3cza05DYjh2Z0svdFFIMHhLYllBU0pWK05a?=
 =?utf-8?Q?msLJYZss4jg8oBQA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08498fea-dda0-4c91-e3dc-08df2704952b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 19:27:54.8848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tH+JAy057unYQzX/DnviUH7edYrwmpt6hd/aYNqgmO047KUfWUc/bV0T2seK2y8Cubpeob2l7ulAXV1LOYLSbnjqH1R+csFl6qaMZk2oYdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7958
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


On 10-10-2026 12:44, Yixun Lan wrote:
> Hi Dave,
>
> On 18:11 Mon 05 Oct     , Dave Klotz wrote:
>> When the probe fails, the driver releases its clock and reset bulks.
>> clk_release_bulk() disables every clock and reset_release_bulk()
>> asserts every reset, and the first entry of each is the SDH AXI bus
>> clock and reset, which all three SDHCI controllers of the K1 share.
>>
>> One controller failing to probe therefore stops the bus of the others,
>> and the next register access to any of them hangs the hart. On an
>> OrangePi RV2, whose device tree enables the eMMC controller without a
>> max-frequency, the eMMC probe failed in sdhci_setup_cfg() and U-Boot
>> then hung at "MMC:" probing the microSD controller.
>>
>> Keep the clocks running and the resets deasserted on failure.
>>
> For the clock part:
>
> This doesn't make sense to me, but I've not put my hands on board to
> test and actually replicate the case myself..
>
> It occur to me the clk driver should take care of the consumers and
> only disable the clock once 'enable_count' drop to zero, see
>
> https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/blob/main/drivers/clk/clk-uclass.c?ref_type=heads#L744
>
>
> For the reset part:
> As I checked the code, it seems exactly match what you described here,
> where there is no enable count tracking mechanism, so release() will
> trigger an assert() operation in hardware layer
>
> so, would this issue only relate to reset?
>

Given Dlan’s finding, I would withdraw the Reviewed-by pending that
test or a narrower reset-only revision.

