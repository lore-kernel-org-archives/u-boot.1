Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F0C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 08:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43BE480D30;
	Mon,  3 Aug 2026 08:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4D7_fo5Tki7; Mon,  3 Aug 2026 08:03:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62F2080D15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785744203;
	bh=3Y52wDPGUs8CtirjmbhHPPC1fijpWc364A1e9gmIgV0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rXKO4HQoQj3sAKNY4WKgIWob5AecV340SMhH/w/yh79ZkKNFNytPdxkIlR3MhisDR
	 aJHvcCt0G6n8DvHi92r4YbocZZxfTqH5txheAdFqZ+U7MTS411yeCKiWQexiPe/SAj
	 O+GhKZgVSoQoHiHXwGnaaFM5XKQwtKs9WItFrU/4QhmQ+R8pGuSLV4Pj1D8ynGOq1p
	 MkswegS+D2znYSsMX1lo6EnVPEy4PvXNtTQTvIrGqvBfi0WzJO6hIY+eUstaOSyxFO
	 zVniUA38/sB+4GgOWAZVlDyKedgVb2iJept0GsS9mEZLxw0ciTkVFZAnRtO5oXR4FP
	 qq5swx1ZNmfDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62F2080D15;
	Mon,  3 Aug 2026 08:03:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD9153A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 08:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A39FC40563
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 08:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sxUy_stxtOAZ for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 08:03:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E98754055D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E98754055D
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E98754055D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 08:03:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD49A846E2; Mon,  3 Aug 2026 10:03:14 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A8980087
 for <u-boot@lists.denx.de>; Mon,  3 Aug 2026 10:03:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckvNljM6MtDM6+M+WYHKhtaPWngg3hif40/Z29hwCvhhasC7CGsqUIgTKvyV35IM96OYF6zazGJtmkQw42oJHAmumyFkZOJRh9z87ExHjuJagQr9HtakXk37H0jO/rGRLrhcpDgomQO/StX0mUOZwVaECAsRtmv2FqRLyZTiHBYp34mivpozfqzaFP65SMkTboUve8LSs+8PrxIamhFZVe/NGbsqyWQTJzpPOw8c4QVqTBJhwXwvHZC5U0CZP0UyvYAM0AEwEIk81jWOY5mgThs3kdbIcgwOSEYbj6HidoipAV0IBlR5yazSiKr798dcClw3w5PJpDRTChT9DlPHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y52wDPGUs8CtirjmbhHPPC1fijpWc364A1e9gmIgV0=;
 b=Vz4VFDu20fY8SqrTJACQJkUr+JDajN2wefOzRcCjBYBpSr56/OqnUVrkdgzHk+muzASgp2b+EjWYCk2YiA+aIJFGen8H9wg33tZdqDG1yCxvChS10OXPy+x4kV1WHxacR3kLezJTK+mjACUxvjFMBiPs0NJ/eg3ebCIZWbLgrQaB3BINCdv2xSziNtGrrJB5G2AqV7IWQFbU5guJSjtffRgVQ54E50UHXiorSxPYOuX8fKJkdg4IcruluFkckXWDxNbpkghiuPvtntFV+IbkrMmjJd+/u+9SahIyJbmowKOwBbRFuPT6SS7xqG3OmMrqkiIfvjM0Y9JWiB8wKElPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from SJ0PR03MB989361.namprd03.prod.outlook.com
 (2603:10b6:a03:40c::13) by SJ0PR03MB989459.namprd03.prod.outlook.com
 (2603:10b6:a03:40f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 08:03:08 +0000
Received: from SJ0PR03MB989361.namprd03.prod.outlook.com
 ([fe80::7201:e646:2c04:6cf9]) by SJ0PR03MB989361.namprd03.prod.outlook.com
 ([fe80::7201:e646:2c04:6cf9%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 08:03:08 +0000
Message-ID: <995ff0e3-1b37-4bc6-b72d-cd43b7c3383f@altera.com>
Date: Mon, 3 Aug 2026 16:03:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: socfpga_common: Add fatscript env for optional
 U-Boot script
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
References: <20260507005358.2340-1-dinesh.maniyam@altera.com>
Content-Language: en-US
In-Reply-To: <20260507005358.2340-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:295::10) To SJ0PR03MB989361.namprd03.prod.outlook.com
 (2603:10b6:a03:40c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB989361:EE_|SJ0PR03MB989459:EE_
X-MS-Office365-Filtering-Correlation-Id: d1712581-15b9-45bd-a0d1-08def135a7b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: gCoZ/dNHRVLuuazqYRmQYLA63q65nci7HeXD5ODjx6tGS6nh97OqH6v8Qg4BOKUWqnA//h5EtwgkTAY5NU5WBnO3SnCPX+niRR2MQ2qPQOsQe1iIhppyWYQRDtw94GpUtd/gvrOmWLUqtVpccaksBxGhQMaMW2/+5y8qaNWLo00JYhQR+Oes99Kxo07+XPNMjyp3q/6h/dJy0AfzIzfrJSSkDi96UUte6bU+znWPpB0a+kopw3tYUkENIXqgm2eDpUKSrn46ds4xgISGA+eETJui4D1AwHUOgCQDBXXkaWDYdy5t4WR3GPX6Xl74ys4Wos408aB5dhUEPJD2Dz7ndcWMQDE/90oCF6cMhmTkNxYgdh5xGPKXLraBLyPG1cUOGqPtO3xfzlRGKktlICQMFn7Sdg2g4nF5dHzYBrZ1zGB/G8Xgzw/mqqW1Br0S3OXBPYJNfsim7ywePzzjUOBlEIzvX9HQSWXBPTsunzqm1+d8JdrAwUbWIpoJA2H6v7P/tnTshFW7/8Zz5DVf3vaVWxe3VSaz1k9EsAs/tOESioakEEujjBeVCJPqVgAISKV8vGBXyGtVzYN2QbUSG1gapkoc8T7obTD0Bm3Ztn0SgfMHh2r+WxT448zLEQj/w4NtTYFT+IXEfETeYYpjsSZV5g2wYaEuab6ny8gEqhuUVG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB989361.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDVkUm1KUEZyU2tWbVZZcUFWVkdmZ1FTTWNzUzlGdkZ3Q1NsaGZDM2J1T25K?=
 =?utf-8?B?MllaVXJsTlc0NWJVaE1wOGtlTSt4a0JqRCtMcVVIdDdZYUU1Y3h1UE5LT3Ex?=
 =?utf-8?B?amN5a3ZkUURoQ3pMekVPQ0I1N3N4OU42WCtKZGpabFpKRURmcE5ORmh1OWdo?=
 =?utf-8?B?enFhdVNKckFSTGRFck8vaXc1SVZHdTV2VjJxZ25Dd3FyWnQrK0ZkTGVjeU5u?=
 =?utf-8?B?SzBFaTY3Z0lZVGVhaVFnemNFQUd5a0pDME1wSm5DS0JNdlljU21jUDQ5SG1R?=
 =?utf-8?B?eXVIeGJaT1ZhclVnVWhCclJQRkxoVXR3L1N0TmJ3SXI0bGszVHlEMXRkNXk4?=
 =?utf-8?B?S2ljbDNJUWV3WXpxS3ZWZ0hwWTBSQkdGWDlVc0JrS3ZnZFRnN0k2a3B4Mzk4?=
 =?utf-8?B?ZzZqTGk1MHdBRDA2RFp5VmVnMS90alkxNDd6RlR1V3crREliNVoxc2taRjM1?=
 =?utf-8?B?NlFscjRUUTI3SC9VSGFVWU1OZzVmV1BXazYvbUtTWGFMOW82K2Jjb2hKNGNL?=
 =?utf-8?B?SWREZVMwMEVCS0lMbGFpR053Y3RqL1JpaWJmd0Q3VFQyV2wrY1pKRnlQTU4r?=
 =?utf-8?B?bUVsSnZEWHlsVlJIQzllbnpZZHhNY2FhOHhBTTM2RDZOS0N3aHJFb05abUZx?=
 =?utf-8?B?bkJtNC9hdnVXRUZVazg1cFpPYXV6WXZYZmlZU2RsQ0d1L2VCOUJEek1RS0ND?=
 =?utf-8?B?WkhGc1BwZVR3ZC96bGY5NWdoeEJneVNXR0Y1bzZSbmhIeEltaWNHQUxWRnJq?=
 =?utf-8?B?SG5VUXFUcXF2czJ3MzRuYkdUZ0pybEpLRHJEM3hOeTB1S05Vajh4V3M4VmZV?=
 =?utf-8?B?NGUzZGhaQk9zdm5wT1B5cDltVG9EenZrSWFBMUdkV1Z1V1NFOTh6Mk1NOXRi?=
 =?utf-8?B?YWgycGo5b0piK044OEZHcHdaRS9peTdPdXJzQU1jcXRIazJ6NmFBWDFxSWpi?=
 =?utf-8?B?S1A0eVdxV2Q2ZWNhOFk0U21yMWtNMmhmMmxxeFJjanVMQWxJcU5tdTlzNWRW?=
 =?utf-8?B?NzFaY0RBT25uY2RrbFE1UWxUeXJkRXQ0THJ0MXdadHJBbm55K1FnOWxTVkQ5?=
 =?utf-8?B?OThmY2o1MEhnSjVqWjBkaVdqSXhjWC9yV09sMnRZdjJFMW1obnBqWG9VclNa?=
 =?utf-8?B?S2llTndFYlFVSTlXMnZqc1JhUDlqMkdGamtSbGZrTExDTG1zMTN4NjdGWEFl?=
 =?utf-8?B?RDBzb2tlaEJSYS9BTXAvQzQrcDN0M29QWDRWVWgyTzFzeFZFUFVJRDU5cy9O?=
 =?utf-8?B?R0ErM21sMkRXdXMwZFRjWFhPaHVETCtVNDU2RUdUOWJvci9mYXNpUW96cTdB?=
 =?utf-8?B?M0hXaytoQm9IbGlTQk10Q2U3ZUpOaDdHem90N1lZTy9qbjczVFNXbkQxeDQy?=
 =?utf-8?B?bVBEeTkwcHNJSU44UlN6TVBmVFhsc1BzZDAvdDlaeDNqUnVBK1BMeXJ3Vmpk?=
 =?utf-8?B?dDdpMDRRK0o1ZGpwSEp3S05uR0tNcUxLaklIWEdQQjlEd2FaMllJUzZaeWFm?=
 =?utf-8?B?aERyODZDbktxUGNheUFMYm4xeHdHY1FkZ0NvVHp2TTRjbWMrSCtPRFpUS2hZ?=
 =?utf-8?B?Q053ZnA3Vkl5eFJ3QXBwcTJmUVJUMVdnV2psRktQQ0h3RHRMVlByMTRnU3c3?=
 =?utf-8?B?NTArUVZQV1Zablc5VlBONm1pUnBqeTZERmZLUUhNcFlET0MvZEowNkRtNTgr?=
 =?utf-8?B?VmdUUXgreXg1cTdYNXVNcm1RdU5ZaDZzNzV4N3d2TTdiOUxlMzlEdDJxdXBG?=
 =?utf-8?B?ZjBIeklKdTRLWTlCZGk3NnFrdzN6em0rYklqOUFtcTNwM01haTdyTTNHRWh5?=
 =?utf-8?B?L0dHYVh5eUkyOFQydE9FUGxIZy9weEtzWU8zWTdHZTc2aFptNFhwUVhSbEl6?=
 =?utf-8?B?MGs4emZ3TE9qaitlMm9TR3FUQmJYNk5uRzNXS1NQWkhoZ2paU25RQlNwamxa?=
 =?utf-8?B?WVc2eFhpVXFYMnp3cXRaQ3VhVXRVUEhDdnRGUjkzcExObTM1TjdVUFFzQ2lU?=
 =?utf-8?B?L0hsbFFJOUxVTVNxdHZxNno1Vlk3U2JjNTZiVFFubnRvSE0ycnJyYWZyK01s?=
 =?utf-8?B?am5Kc3JrNUVNWkMybUorWWtmN3NhbnY3Lzh5QU14c0hsWWJ1RDRSWUhOTkZj?=
 =?utf-8?B?Y0JYL0U0Wk9DUnFKV1RLUVBIbTRFMGJrckppaE5kV05oaDd4TDM4WmtzSzlx?=
 =?utf-8?B?MDUyWTdNb1dGdFVPTHNOQUVkK3NCYUxEN1hIVUZ1eSt6MGJHb1JjT0pjM1RW?=
 =?utf-8?B?czljNlR4Z3k4TkZNaUVQL3Q5aFhLSW5WS09rNW5ZaWlBQXJUZ1VBU3RpYTV4?=
 =?utf-8?B?QkVqR2hUNHpvaEk5Tnd1MDJOWm1sOUVqc1hzYURvaWVKa2hFbVR6NURMb1Z3?=
 =?utf-8?Q?aV8tetvdWMje1+Xs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1712581-15b9-45bd-a0d1-08def135a7b4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB989361.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 08:03:08.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iP3qd0srZV7JkM7que50XtSbv+p8DxC0ZXjSWMWWsQpVmbdBV+y5YZTXBF/cc4L+eoEdpDHufpFG8AvfmLaC/V1Q2b1t/voMJs4b3f9M5rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB989459
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y52wDPGUs8CtirjmbhHPPC1fijpWc364A1e9gmIgV0=;
 b=XucRCZ1fmxOcX+YoFdL9id4JoLltELtlrzLGvX592V0HNH2pE9D1OeGh1G6JVj+jPN2IOlo6KpQPoalm4/luvGlegQwddVdIjqDa4NDI08QmrxqyzKogBmi/bdD3TbI7DN5+830rW0K3nTedBn8mrHQRuU3IqA34wg88GRvNKrwyQGQsTG04YDW+r90zABGVLl3XrA2MFzSPnArXksly3xXYJxOct6Lm5VDBMtylPFEMFRoV9MmLXrDpo9vO6lHlgbd0nCSlqPChOUqwK51HIbcBj3zlTzQx5SlCs2UyCPoS52/snT3XLCHMTyraem0wwr2j6R6J9aHWqKkstmYsQA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=XucRCZ1f
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tien.fong.chee@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="XucRCZ1f"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Chee, Tien Fong via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Dinesh,

On Thu, 07 May 2026 08:53:58 +0800, dinesh.maniyam@altera.com wrote:

> Add 'scriptfile' and 'fatscript' environment variables to the SoCFPGA
> common config so that users can drop an optional U-Boot script
> (u-boot.scr) on MMC partition 0:1 and execute it without modifying
> the source code. This is useful for board-specific customisation such
> as register tweaks at boot time. The script is optional and not
> required for normal booting; users can invoke it manually with
> "run fatscript" or include it in their bootcmd as desired.

Commit message understates default-boot activation of fatscript.

The commit body says the script is optional/not required for normal 
booting and that users can invoke it manually with "run fatscript" or 
include it in bootcmd as desired. On upstream master tip parent, 
socfpga_cyclone5_defconfig, socfpga_ac501soc_defconfig, and 
socfpga_ac550soc_defconfig already set CONFIG_BOOTCOMMAND="run 
fatscript;bridge enable; run distro_bootcmd" while parent 
socfpga_common.h has no scriptfile/fatscript. Those boards include 
configs/socfpga_common.h. This patch therefore supplies the missing env 
for an already-wired default boot path (graceful no-op if u-boot.scr is 
absent via the if fatload ... then source ... fi form), not merely an 
optional manual helper. Respin the commit message to state that it 
completes existing BOOTCOMMAND consumers and describe the no-file no-op 
behavior.

Please: Rewrite commit message: mention cyclone5/ac501/ac550 BOOTCOMMAND 
already runs fatscript; env is required for those defaults; missing file 
remains a no-op.


Please send a v2 with the commit message updated as above.

Best regards,
Tien Fong
