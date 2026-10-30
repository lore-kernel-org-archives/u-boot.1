Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457B606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kPNwjAAQ;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=m8hm/lPQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E57D8107D;
	Fri, 30 Oct 2026 10:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WdNN1c7ZPibc; Fri, 30 Oct 2026 10:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9D26810AC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793355174;
	b=hn9NLfjkgRxxwKRKg0DU/V153ZPUuJZeXsVUG6X6SXFK0qWySrl3BcahyvEiw2P23v6s
	 AmWgqQLZrq5m5lsgKWJBvz6ioLc1+oAq29Eiki16hj/rEiHZeMZb3adHmrX9g4/7+/bEv
	 ngi4e/e8chwNp3kVK+Y2gMKADeW09p4gh6fnAoCzbkbSOx5bDaJDb+3PxIpbCa6yCUFjP
	 lOZQCIonf0KIZCd1m48CbDcy5mqcZTnIpZwDKK3sOunyhKGcmLq4y1FYuCtmA04SONDTF
	 6APTMDH2s3tMsMSWvYI/HA40pAK3fRUwbba3eXKi41+D+edNqWCZIXAojme91t6KOdA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793355174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=aZq7Q3J3bGkOp8IF2xUSBgwbGADtSP65SM5xM81aNtY=;
	b=mtm/s2c49YHRYGORph0oXYvMHC1gNjJSBy4WN+AU4BuVor92SHYSqO/XBMgY5I5EcAxd
	 seRceBEN37iuMGA4uak7fbWyyWllauzKhJAOj5ruP0LRzaUupys6xp7HcJ0RxqrCg1zrz
	 IUQpt4tDvpZ9rwQbaGdHNLBUb50d5Oh2qVKoNjtu8gkl6pY0fn72FEjKqsvnv0KiKvX69
	 z0SkPS5nDf3iLi7ZmMB1NMGAcsQxzTXf3kTJe0LJ6OEadsFFyrLfMRV34Btb5XUBAuuBp
	 F7eYcYWKTap+Yi/F00PtImxXcTJ7Pnqv/FH6eIh5OulaAadvg1oZglJyx396XonLGkQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793355173;
	bh=aZq7Q3J3bGkOp8IF2xUSBgwbGADtSP65SM5xM81aNtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kPNwjAAQLY8DBn9zdxHhp6k60iwkfZJq3W4MOFPLtKvU3TMUazSbuMe9F580WHt3A
	 Acn4aSDLE0IYTarQhr0NsZuehQYnzdiUCLUGy3i7GO025BxF3dc/JjC4+UWP/Z/p6P
	 D4zW6WtoGimOX1n/ned/h7pVztR1Dvht/f/qg1sCZLJbtdAcbkS0UM5M7Z6uhx+qK7
	 QBQZ/NejuUqZM0hu8wdklD/Eco6pZAz9oxdxlmJkNd4S4UZv+rAUTyy0GSFmBCJZLV
	 O2pnmg2MW9W6vq9GOBU378m6Rvxag0W8LRkh0UcRPfRysB4Je0rV/mJsVMPOXTgi4g
	 Nti6wDxJcg4Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9D26810AC;
	Fri, 30 Oct 2026 10:12:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 34AEB2C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 225D24009F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:12:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DD0MPTGg7lDS for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 10:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D96F040063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793355171;
 b=Wp9ExVX/aiIa9RPJY41DuZn+ARzgeBtCzqsaXlSQMf3T0ttgdLGJo88F5mnULBIF1d6s
 MU2uxexV6VZMpOlvWmuW6wxoHoBrxCRQAAFzT4KUxJVSOK7AX6TaE39oErbPU6UhOBVtn
 lvMlhEy2MxVhQtB1lmIV2m9zL8ZvK5qJ+PK/0dVkgeEOjpENuk3/PdhUzeJyPUnE1AsEt
 fKeYEtNH63AM8mkIvtvzB9pP2qvASLZ4ADZGwCBEtSCJbY/Z+qZKWjIM7qRQLNETg/PcB
 GMnCcVfatRTCqU7oeKBNeIAyZy4TQcgDLGd/YSNf9mIDRspVEjiDgKVvgpF+Wlnmt7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793355171;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
 bh=aZq7Q3J3bGkOp8IF2xUSBgwbGADtSP65SM5xM81aNtY=;
 b=ag7bJsK/QuZUjDpQYbvLAFDY3WtQrrtB1HhYTL2pErZ3IK7LIV8GfCtsSj4yQc3bOW0/
 IqPC0o+lsQE22VbHc86IMseMopqeoyNAj/02V6OYPBrWF7K8ir9WK2ar4O4p5+OKlLbDG
 Zke1q3hn2WUeurdRdPC01ZApaPMQd5irpMmMgRMKUaLKP9u+NSp/CrhSaG3N6pkc+xhVh
 Upeadr1sk39QtW02uhE1aypCHnx5pc12ydztC2nZmfgOoYp87KaQGlygkTsUGpgE8hGzH
 g5fXOco8bSe5eIpjw/N/0Dn5NNNeCqVJL925l41hg0GhgSQZUCxvZ6eIdeLhh+DcEgA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="m8hm/lPQ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=m8hm/lPQ
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D96F040063
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9EWH/BGj8Fal4wO5lnr8hhn0syb2CKCteChziWgxAwzbUfdnE8dIjX4G6FCM7nH2Q1ZBFCNQKTb2SHcmRTcxIikiVp5Ya6Vm/tHbVnZj3ki20ToY11aYFBWPj4qevM1et1IQSmdNwgcMuPyarF6BGCknflgjzvR1w9MFghzYWNXox0WlMQajbwzvi4iRwK8ES9mnJYkgiL6i6fYVMBKa68b8YOLFDLpiseT4FKRwfhixwzvTKtKmLUMYoEvTzs9CAr+lvX2jaKzODwXHULgvMrclU1Te4LxSmlFAzc+xfCRzj3Pd16SBsIa5ZLCvvc8uD/iIsB4YqQdWyY+Ly+WqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZq7Q3J3bGkOp8IF2xUSBgwbGADtSP65SM5xM81aNtY=;
 b=D37pj4/kmh/Tt6PVjFqLuwuPhk9UI0ghaNBi8H26lrRf0OgAMIc2s9L3eKRGO8lkMqK9J5iO4b6QrF9GJ3Zp9kcCaY9MucCZUdPTA/p5jBDZ2Z/dIvnzEAcG3ulDtSLsCM0m2PUNYzVHqDLq/7m18AsQciyvxlEX5U/WdeAWqek1iVqSMqvnMULu1HEaBBlyCVusNMB+Yia503Y4vFLqjxMc7MNpeIRQFNGgKapkWhBp4KlZADLdzEnrstFwVgCmh5G/U3O4BNNMN708+RsAHB0gvv7AsDrOEHngPYNRvVU9B/tmgzXT+JlKhzDfOdy5NqVc2hL9LpyWyCZp5UeNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZq7Q3J3bGkOp8IF2xUSBgwbGADtSP65SM5xM81aNtY=;
 b=m8hm/lPQIe08erf5yuVZ0cEwnVRtM+3+18z/mOtVYDNhN01cy8+fvgN6BPlnVwZ09Q4874aQrn/TZsnHnctWcNXxmno9AeyPpjNwIbCrc2EfeIjKqGyeatd4ViMdHDUG8MvRd8qiXIyJvmWuK2fzDNxWzcBjokv8U7hiB8sGNdw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DBBPR04MB7993.eurprd04.prod.outlook.com (2603:10a6:10:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 10:12:30 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 10:12:30 +0000
Message-ID: <f0b4c5af-d79e-4dbe-81ac-0c8766ab2000@cherry.de>
Date: Fri, 30 Oct 2026 11:12:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] doc: Replace master with main as primary branch
 name
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20261029-master-main-v2-0-5c2c579e9eb1@gmail.com>
 <20261029-master-main-v2-1-5c2c579e9eb1@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261029-master-main-v2-1-5c2c579e9eb1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DBBPR04MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: fa889314-d3e3-4f84-cd4b-08df366e4ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|261028144727099003|10067099003|261026140227099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: FeqNy5CEEgeqHoZ/jkj5iw+ymczOYCWq6CaBRQ3Q4DwaIGxPUav9+iwQx/uLyuCAPPoO7XaLpFUwFHyVgoMv1skRoG8WDF2UJK2g26MGSn7wAZ2doaF5QqvJnbev7CdsfhwAVmtUkAdmrPIXK2K2YSzZ1ULu+e5g6X1QjLGjZ/0jDutAx9xliiO4e5P2I83Y41h7ZhsEs6p572+6obAyryS1haa3hdgmpzl8v3MuN/6dfNTXJT9Ii+RCvOCF1hnxkE0hhca1+oH7haho4E0DjRQYmrM8cqe59MtX2mkIM07K/b7ztGtdWcHHPwKDpFcug1TmmFLP2UhbGmNtlZiz/SRzPcub6ZjQCr2zKKaffU4eA1OG8TuJxWP2bKZUvrtcJO+BHbr7VBk3sB6lyVsuKHumafEBHuyw572OLB4w6kkoRYUGUX/VquJjT9lJCM6zIbRUcumhEa5gX7RD5ovZMzbVmsIhAZbCzIAtOsnvtNPyh+vwN4hBdj+gcSE6StwgnEzD2lE989RUrP31E9O1LYk3oHd7Xpzs6NZvuHMzcCBMLExDciJpexuQ7IhpK6Qrr6KfiF5EYST6u9DCUBfmzCCxsdBTgCIjRKVIS2Wbopej+sADWbIh1MscaC5x77h1zkWfGrWlhiAW35MjaJd5LSWwfRcFrwkofNIg5gH5LTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(10067099003)(261026140227099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU5lWG9EN2t4S1crVVhrdExzQVpzeExaOWdHNjMwOHpiSmd0REg5OHpGRHhU?=
 =?utf-8?B?bFpKcXhZTVF3V1Yzd2FmSjBTLzhmMFh1blhPTlBTaU9xR3d1bWFmNUhPSUY0?=
 =?utf-8?B?ay9MVkxSNE80RkN4TlhOQVBHZlQvSXh1cUEvU2xJSk9ueC9rR1dBVUFLWnhO?=
 =?utf-8?B?QXJ6c3VNUDd6RHNUVVZ6MkRodEtwQWUxVU9EMm9oSWZhVFZPWVRBdHlsRUZh?=
 =?utf-8?B?Q0wzbExseEgvdklXaWk3dGNGRytqZG9YWkpvL2syNnA1SkNxSlVaVHcwZzRU?=
 =?utf-8?B?ekE0cW9NVHh6dCt0cFpYUldJbFlZSmhoRndOOEgyczFieE8rNTkzZnZiNUxx?=
 =?utf-8?B?WUFCMGR2RkI1U1Urdmcrd3lhYmtYdzloLzZVRUhHZ3FDNThzRXVXSWd1cVBa?=
 =?utf-8?B?SW52Y0czK1RnL21nOHBXTlNKZm9jWDBzUTFqY2dzRUJFejB3VEZadzFZWHVj?=
 =?utf-8?B?Q0J0NVovVUFFL0t0eHpDdFdTZDVrbk9BQXoxZDc2Tm92WGlSNXU5REp0d3RP?=
 =?utf-8?B?R3hZbzZ1allpR1VmWnlnNE1xWDFtM1ExRCtOMU8vQXpkOEJabEdMZytSZ05w?=
 =?utf-8?B?OEZmczdRdXRnWWp5OGlOTk5tazdtWWl3N2VHRHAyU1FiRHhtZCtrZGpzYWhW?=
 =?utf-8?B?YVUwZUlLSmpQdlZEeTErV1A4TytkaTVRWHhOZ0ptRGhtenZuanM4Z2NBY3Mx?=
 =?utf-8?B?L1VyUGFMam5FdkkwQy8zLzJBUS9UMDQwWnNOK1NheWVpSFppWjFKaGQxZ1RF?=
 =?utf-8?B?N0Q1SDMzcFBWWE0wNU41T1BQc3UwNFo5bGtFM1dIMVEranh4d0QzNERvRmxq?=
 =?utf-8?B?MVVyekJtSVYwSkthdWtHN05iNmMwalo0RmhWdVEvREtDbC9BVGNQRGhyVDBQ?=
 =?utf-8?B?dGp2SjBmbEJBZnAwaFpDOXJ5NGFFcERtNHRhbXZPZmpPejdxcTBNdVdwRUFJ?=
 =?utf-8?B?UXN5YWpnWEFYamw0THJyMXMvRVRucEU5S0hVWFIwSHRIUUFqa0Q2Y3pZeHFl?=
 =?utf-8?B?WS9QSzZFUzdNWUhhZGp3bm9wczdMVzZRa3grcXhmWlBEenNNZGFFVFFtU2tK?=
 =?utf-8?B?R3lLZ0lVbzlSSGsxVmxuNGhsdS9jNnVMMEFZRjhtcldmcTRoZUNONUVQVDFL?=
 =?utf-8?B?b2dYcWwyeGNJdGM3blFCV1JuTEw3VVpGR0NIYnZOVTlja0VCbmpJRXhlQkFI?=
 =?utf-8?B?YXFKQnNZV2p6d2J1cGJ6K1FzR24raTU5Q2wyNW93YjNvL3JETXVtMU53UFdN?=
 =?utf-8?B?eHpaNHRIdWRkckZKTFZ3SnE5UVduL2FFbnRBUkFGY1BITUJkUzVEOXRCNG53?=
 =?utf-8?B?L2xPd0FqcURWa1RBMHo1eWRKeFBIdzdpVW92QldYblpjVlZEQ1NNWDZxdEV4?=
 =?utf-8?B?ZUxqSFk0bGh4TzJoYzJUYk9uRDNkanl6NjJEZlRtSURDRzAxYTcrWHNEOTR0?=
 =?utf-8?B?RHJiYVlqVjBnSmpaazB6MUlzVlJSMUVabUxyZjU2TGRzYVBSMFBHMmpyeTM4?=
 =?utf-8?B?UkpxTzZEcGtyS2dKZGZFejh0NXVhdEFwYVNoZ01VaWZicDJUZ3BvYmdEZ21j?=
 =?utf-8?B?d3FBVkNsVDhpejNGbHdEeHZHRDBUVWJmQmRLSmQ2T1dxWE9lam5SYmZxTysx?=
 =?utf-8?B?WlVybmI1TDh5cjQ0N05vVkkxK2Nad1RtSVl3b0FvMUVVWU9rZmxPNWZGVGp3?=
 =?utf-8?B?cFRKaUtYMFo2MTFaaUsxUkNFS0lWQ3dWQ2t5MkZ5STRERWlqUHhwOEFKMURu?=
 =?utf-8?B?bXBweUY3em94bUhOVWErSzU2UjJ0VTlabkJuMm12ZXBTRDFqQWZVV0lneUVT?=
 =?utf-8?B?dHRKMnFvckVqYndqN2lmcFp1UkRzcmpmZzByTitWNWxYL0NjMEppUitUS2FL?=
 =?utf-8?B?SWlaeStZUlRLWUw1NmI4dnRTYnNMK095Sm1EWHhRQ2pWa2d1Vmk2S1pBaWlE?=
 =?utf-8?B?clR2a1RoM3J6Q25JcDBHelk0Mld4SzBYSWw2YkhyNm1DSzJLTll5R3kvVm9i?=
 =?utf-8?B?Mm5jeE8xdTJnUFl0MzJOanBySHI3TDBzYjRvUXYxeW43NWdZaExHeksvTjBR?=
 =?utf-8?B?M1pXU0RVV2N1TlNyb28yQWxnSFVaN1B2aCtLRmoxWGdoRmY1NldXUVJQVFll?=
 =?utf-8?B?OHpSaXhHMVlTVXRaY2QvL1NTR2RVQkVDeHZyMSt6R2N2S2JPN2d1bW9TZTh4?=
 =?utf-8?B?UUllZU5YSnRrUTdSVVZsODh2TlJCa1BIY0RGSVhmOEViRVJPSEt3ektBZWdX?=
 =?utf-8?B?U2hDVlluMVAvb3RCUW5zcWRmWjE2UTRnWXA0YzU2Nkl6R2Y5bDRWdTFQbmdC?=
 =?utf-8?B?MVZTZGRlY3ZmMk9qcVdrLzUwSE0rbTQ3Yk1URlBwMUJXNlNqOWo1UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fa889314-d3e3-4f84-cd4b-08df366e4ea9
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:12:30.4942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EXHyxyEnSLWSeGcdSkcu8d+dUqrkXX/pxtIeqeo+sC9boRgqFqnsMRn3fHXRrJPIM/0PUS5DeTjaohDRX4aOavnyo6l70GQAyMI4APeKDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7993
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 10/29/26 11:15 PM, Massimo Pegorer wrote:
> The primary branch name is main, not master anymore. Update references
> still naming it master in the documentation, replacing master with main.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
