Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BA606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LEp7A7ta;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bDFoBQe2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61B6980D58;
	Wed, 28 Oct 2026 14:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TvLpE_q9eC8w; Wed, 28 Oct 2026 14:25:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F63D80C34
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793197510;
	b=E1gv4sdhCTCHNfQSlK8BDaPhbQs8PUarq9K4pd6+WGUde76EJHhmAScZF9hR9RN4T/f7
	 +Dter2MEPwEq/tezlZfx7KNKoirOfTBVqQBYSdnivrABpbMsAHw0jmXqLJs/FNF80HdM0
	 AuNT73gYT4YKX4DXn93lqFBLlnuOLWt68wvWiyaOIp/BMUPymgGKmiOxGB+l1BDtyt/tU
	 vYmYMyvptRNjh/IVEFjLnNvXGs+IMY7m77pc2quudTrtb/eCvfSwIZROPbYu8YMF5Nutr
	 M76yvJVisPBSx3kiww5/ehBNbUZYONEdjtgoLOLS1owT6ip8L6VqeFKSzsFB07BHfHw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793197510;
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
	bh=+Py7En7Ikxwh4omXuGqxUwh+kVNc39H281CPmcq7YBA=;
	b=CYuEp/0oREROUtjYQgwX8Z2kPy02viW08+vNKdDWDCpEfFG5Uv4J1oWtmdep1RqLKnUe
	 04PvyR5PYpXHWpG9380FBvvD6MEWF8SZer/r0noTbzu4uT0VmPfc5JbFrB9VcpdYM8lcm
	 /fEGXBMA1Y+KzMW4AIhBGNtkXqynPAYsj5fVLmqQhRUY/7/LXnfulAYsfV8vBokHorLsE
	 5mC3ya3hBazVl0RYwV6haSkPlR6Kpzm4GQNehrfekyGVM0lS/ugpo5zpVBoGZtM13o/UE
	 GOhzC+oEOO3YNOfWRAyqs8zS5hY2QiOKIostOMlC5Xl7YJQkHkJ24U7PVXYHLXxtdCg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793197510;
	bh=+Py7En7Ikxwh4omXuGqxUwh+kVNc39H281CPmcq7YBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LEp7A7taw39j4VFM3JqO6sY5mV/uH9JcA0Fz5FVGkg3XLcPUTHRj6wAbPbHw6/mFT
	 UsC+1r204YiKCrksYwPgVc2Ix4a739XykUygp9CK7FrRnRQY9VoiUSGhldfHh25sZj
	 xr9AQlVdBg/hvH5e9hAsTpfNNr/6fiWcuXy5ZmB97Pez8sNhau+XUlVhTDUXGMgqhd
	 9a0L52ZsgX9/bHmea+E0U7J5PKKoTzjqclrzCb3FJbV7hStfvNM6BbdW2D6slK9ZUo
	 FvANcWZE+CMONgwfuk/FXpWR3IZseCcLLAf5Sa1T0S+STbJaBw0raiYuV6KLo0jagj
	 oY4511PcYzxOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F63D80C34;
	Wed, 28 Oct 2026 14:25:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F5F4529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5517C40557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWNmMrsSP_un for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:25:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 443A340539
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793197507;
 b=sj0teaRkOw8UDDeDn035WCuvPu6xXzn6mtRdHzLP5KNwiO8ASL7JSYcSamT7GCaQZJDD
 qJvLyDiwpgSmG8fgdf945B8YYfaheAwqCnttEreBjPVmOAN3JNJe+mLpaPIGjz3VZmoi7
 SDH5SsLCxGiZjY0kLBrUyA5GnyWwZnTSsCp6LO1uEwG3uj2hTBuTb1LcxJ9OSdIFPxElb
 rB2kr4sU4ASNenE744Ed46fnSRabXxCzZg2Z4G+pEviV1YPBOvh8Fkppo2XrQmTxJUicT
 Q82RC5BjQD8eaFnKvNKmfLwYDF5Fco1sXDstUcA72EwgiRCmAOEDqs0tsiWW9uAwW6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197507;
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
 bh=+Py7En7Ikxwh4omXuGqxUwh+kVNc39H281CPmcq7YBA=;
 b=iokQF4fr00XoY0Rn02ngr7XRoG2XdxGFl5qn+bLLR3S8ywf4b3g0/fQc+dxJxeKJDCNq
 AuK/xYbO3I8BiUItaH3YMx4lMQKK4vouzkCgb9xysirCY13QzabS8x1vTcONqVe94BjEZ
 QZqwjdA3HHUvVHy8ri/4F6h6uAlRGn2g25WD1R+WPr6hXyo+g15Vp9vMFxDFh6Bzy5/ib
 Jm8EOWzE84BeqEAKJpBMFouov7yyw6u7oNzV+XyduppsHmMlGdyymsFpKvj+NNm4xA7tM
 kQv+w0J3ZjDf0XfdqLyui1P7nBIgY8yQUk86+MScGF9xGdImQmPqSpe0Iazo2zv/LFg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bDFoBQe2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bDFoBQe2
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 443A340539
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjNTsf54p/62Dz9TZ7ebgEdUicmaVC6jBZvj9CxfXW/HZLugwi2TtQXl13Mea5Z3D8XxgjBpXmUGC+MAw1GZPqrMHh3X5cS9uI5qqFUP09L1rXMG4n8FhbJ0ZugnysGpuTEDMxggoM24vkyMRF7bcX9GGnTWde/jEpIwm/bIfibhYSp3ygOnVCmTnLIPqQEgnwh3WQo5QzVXNx/O612daA7H6S9i6T6UrG65ZlEyFESB/lXDwUCQ9ZUIm1omE6IhYTW4fasOc9F57K8uLqebUMKgwPlnE/HTZvCiqgCpA0oScZ7hcL7HW1brHIIAY1KGs5+2lpzWYW5FgjOqc5FKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Py7En7Ikxwh4omXuGqxUwh+kVNc39H281CPmcq7YBA=;
 b=sHBzYhPuOuPujBqFsJfzjpSAFpP0DtIzzvpacy9xd1u5iThOJgYYXDw0JIoTd7pKDqLM/WtQM0Ghh35sFojnAKlYiWSwJEqC9juhPo9R64hqtRaTGIDeqGxe7PBEU9qRMn35JTAdH4u1uqJrT3SZLCyl2ijZQw4HpUscPZndYNqRj8zrg8g1r+slLW2ppgNaM2FQp37SeJNrOwCDUN7EKDEqjcSl+saCLsnQ7SjYrTyDzmBDmCX02B6IHoklDQ75vhEGIVnkpaRPH8L2sNB0ANecVZ9TM6/6uPzG3LFLM100BwYXDISyYWWV/VQXXqnqVVYLK6iYAMoFnJNDj7sm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Py7En7Ikxwh4omXuGqxUwh+kVNc39H281CPmcq7YBA=;
 b=bDFoBQe2rSmTzcg1N1evwGI9z5MiCLDzM1euwKxeklad10htqSWWMRS11A59RupQzVQHGZlgm2g6Y68mt923zWGAV0BMkzz/4uM4Z1mdn6rAcaPn4ayRgTjQlChwgMLzOP+5ARqOhSCmyTxd8TwSqhMbpBF5Xw3jRs3/xMNKYKY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMDPR04MB11298.eurprd04.prod.outlook.com (2603:10a6:20b:6cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:24:58 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:24:58 +0000
Message-ID: <1bee9457-b560-4077-940d-b9f75426f8b1@cherry.de>
Date: Wed, 28 Oct 2026 15:24:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] video: use bpp conversion helpers consistently
To: Reza Kurniawan <imkyufie@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Eugen Hristev <ehristev@kernel.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Andre Przywara <andre.przywara@arm.com>, Thierry Reding
 <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMDPR04MB11298:EE_
X-MS-Office365-Filtering-Correlation-Id: edd6e49a-c02f-4197-b237-08df34ff3e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|56012099006|261009223027099003|261022105027099003|261026140227099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: a6jmBwbT77Wik2t4U1rsAa9rw49i/Qlxd5iDSksJ4oCMaTT/lD0ZV+ABkWGZ9Ic7tS+i0n71G8wDwJtt8OjGG2mPDYHl4zamKoXZaITfpEeVBN9dql+K1Y1rQuMqr8GpsptayU2bLB9yQwKpCOYV55MCykYtRavhmE+orYWc8zf35kvly2m/NVSNQASom2x8FFyUke2hTV3GdHamMTcEkNkvULt+AvJkXLpi7x5Vzp6LZNn1OOhXy38QmPnSkdLJh/6hZTzF7611XKKW9gRkMe7LVen7S6JHmfuqRIi6tcvHSH9aEDv22FLYp1b3dUeViIh5lloCIA1gavxZNZtUcn/hFI1IZnt1F2KNdNLninQbG91AbxeZ9sd+VvRbFNv89ZvYKjzPvXB09oukIbzAaKtn2UvFquVDUX6V9X0VGDa1yVgRvXOq2AQGujA9lr36AUGQhi9+ot5JrdFlk6mH5USbU/iaflsLqp6kzkqGr/Jcr8/6hstQNaXCROZXMk1fn76bP+kMG9MzkdVqmhFbo5lgpMRgccsLBJcGY/bKvbuqvwNJkJMM4+Gm8QCxttD3wA/jwRKmovUMVB7er8lUIKvuoK2hIgB56RL2ae5g2PZ+7tozM8OkDEiHTB8FthFm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxVV3M1K25uRlI0MkpRcUZiNml0bU0vU3NrNHlKZWNvUDFvQnNQblpwYW10?=
 =?utf-8?B?algxaS9zeXVCbGVBK3hHbThwS0dyRG5TbkdKN3lrU0k3Tm56SzJpQTgrM1I2?=
 =?utf-8?B?Ti9oazZNclBkQXpYaTNqS3MxVVhmMkljSWJZYXlycWVZRmZXTlF2YWV2cGNj?=
 =?utf-8?B?NlNUUjNTcFRBaWd4amR3ZE11Qy9QR2EyNUpkcndlbSt1bGp6TjBnK05WWkFk?=
 =?utf-8?B?dlU0TjNkeUlRblVxTlU5bHhrb3BSOG1pQ0c3SjcwSEkvK040ZnZ2eFR4cE1D?=
 =?utf-8?B?SlYwcW9WZVB6KytqdkV6NU9PNEU5QVpRRFBHYlFOUHg2YVdpT2gwNCtreG5z?=
 =?utf-8?B?VWdmMHJ2cjM4dDNJbWhZZ2pTeU5zRVFFVStuSm5aVThqU1h2cW1UQ2hsQUpZ?=
 =?utf-8?B?N3lEeDk5VDlUb252eTkwM04zMmxLMXFvZklmUUZ5SWFEbjBoNDM5S3htSVhy?=
 =?utf-8?B?WW1vU24wZEQxTGc3a3VHVGJ2dGJneHVjU1FPK3pLNVpVc2hHVmtZRXNMemlZ?=
 =?utf-8?B?Unh2YnQzZjkyY05BdjUwQ0xKeCt0RllLZndOYittUG1HVFdvclFndythSXNN?=
 =?utf-8?B?Sk9oUngzVVVPZnZmNFMvWDJEQnNRZ1UwbE1tNyswR2hBZ2Q3VzhEVGZmQ3pu?=
 =?utf-8?B?bFBsT0lIRUw0VFFHRmI5OUE2Q3NDcjhpbWUvQUtiZDY4M0pNOTZEMFBhMlpj?=
 =?utf-8?B?RENNeTJtUGNBeWo0ZHEwZWZIcmpXb1QyNkRLalNMN2FPaDN1dVdUUWc5NDg4?=
 =?utf-8?B?aE9JclBBaEZiWXIxTjVrazQ3ZERMUG9PbDgrWmtQdWl2Q3NKakJkakhzcXNB?=
 =?utf-8?B?RjgxTzBQL29UUyt4eXZjNGYzUjQ0ZDZBOHF4WHZNMDZ4ZG1YM3lsUkh3L0pE?=
 =?utf-8?B?TDk5SjhXR201QlRNbWRGSVh5SFAvaUtjOEcrMWo4WG1OVnN6eUF5QlR4UURs?=
 =?utf-8?B?YkxHUlQ5QXBlMFgyQUpoank4dFJHRVlSOHJ0eWh6UXZ2dVRoeFNsSERSR1hC?=
 =?utf-8?B?N3NIa29kbVEvQVBzMWRKY1FKbHJmVE9rT3diWWo3NE0zbmdZbWk3bk9aL1JR?=
 =?utf-8?B?MnhBZVBzQm45UG5UdzhOVzJTU3lra2NQKzBuSnRNQzh5YzRISUs2UWNxV3Rn?=
 =?utf-8?B?K2xnWWZnMjk4VzFaRUlNZXdqcXl3ZHdIbmdPZC9STGRETE94eHg3MzNFZDIy?=
 =?utf-8?B?MHd0RnM4TU1CRFp6ejlzaFMvSHEzSzgrd29FWFVJN3NlNWxBWUtUWjBBeDZv?=
 =?utf-8?B?dWJ1WnZORk1SZ3NmZ0VuZjdpQmtENzJYd0ZhYVliV01obm5YRTJpVG9EL2d1?=
 =?utf-8?B?ZVZCdFFtaWJlSE9CZ21MZ1Q0cWRhMFBFSjFsM1VmWU5xVW5Fb0JLMnNiZHpU?=
 =?utf-8?B?TEVVaEVmZDY2S25USldWNHlOY3dKa1pZRmFuTzVPNTBPVlJUeG1wcmpraVNr?=
 =?utf-8?B?K0xTY2VSc0dVZk9yNmxIODlKVkFZbUZrZlFyUmUveTdCbHgzellpNWxwU2w1?=
 =?utf-8?B?cEIvUVNtQzhMZ3RJNjlUcXlTZnk3OWJGUktiNjJSbkJsM0E4dzRLbCtkcmJZ?=
 =?utf-8?B?MldoTEYzakRsSENDNjBwYVV0YTBnaGtiSlBSekpaRWo0dHVDaTdMTEsxclpk?=
 =?utf-8?B?T2gwOGhET2dlem5OU1VkQTdmaVZyV2pna3dGejRQdDlYS0RoNS94V1Bmc3Fo?=
 =?utf-8?B?anJRVE1jbVdOQnZoVjA2Y1hjOXVIYXVOZlRaVkJnUjRiVWpZUGMyK1AwWVZ2?=
 =?utf-8?B?MFM4ZVZ2SFgwb2gzYnBwUVBpZGRRVXh6emVBeVdOdjBLRUF5TkgvVWVHUW5O?=
 =?utf-8?B?akpJMnlJNk1XbFp3UmRWTlp0SFVSVVI1QTFZeExWREFVcHc3cDB2R090MFA5?=
 =?utf-8?B?ZFlFeVRDTDZiQUsxZVpmNmhHSE1tVnBzN3RNSHNEczJqUE1Vd0F5RnZKVUJp?=
 =?utf-8?B?eHRKRnFJZHBLdnZKenFsN2pFRDJRbCsyT3k0VytvZVg4R3BHcXJEMFNURFpm?=
 =?utf-8?B?cktnbmo0WFc2ejNScjN5cDJPNk8wTTR6MUorWS90b0JjWUl4aUxxVHdVMHBn?=
 =?utf-8?B?azhyUzkwUDUwT1JaNFl4MGxZZ3JidHVsbU9LUENxRnNmU2ZZNTZXaGkwYTBt?=
 =?utf-8?B?enZPSFFsRVNFbnljY1hzR2tPaS8zMXozclhmS1U1dElSb2JzTzNPVlc4Uy9v?=
 =?utf-8?B?c2xrcWNOamZPQWRHZ0ZuUGNVNE42Z3BHN2QxWGVCbVdzMjNWeUxMVUhORkRM?=
 =?utf-8?B?Slhsa3lsZWFpdUVheXg4T3RKRFFBNmNiclJpem1wOHlpVWhMT1RFQmlRbWlD?=
 =?utf-8?B?Rk16b3QzQTFMbVN2c2tqd0lDeU1WNE0vN2RBcGtYZ25ycVBqdC8xdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: edd6e49a-c02f-4197-b237-08df34ff3e72
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:24:58.0591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElWVIezq1GYP7pCvVWz60WxWXKeAzlDqs22jTykI05mXDaEJfN96XUaZ5vdxhLbjb/+S1iWQ9GXFtZVS7BqPQ/0adU1NH+S3BkaloR9YS/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11298
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Reza,

On 10/16/26 8:30 AM, Reza Kurniawan wrote:
> Many places open-code the conversion between log2 bits-per-pixel and
> the actual number of bits or bytes per pixel, using expressions such as
> "1 << bpix", "(1 << bpix) / 8" and "((1 << bpix) >> 3)". Meanwhile,
> <video.h> already provides VNBITS() and VNBYTES() helpers for exactly
> these conversions. Replace the open-coded expressions with the helpers.
> 
> Using the helpers makes the intent of the expression clear, removes
> duplicated bit manipulation, and reduces the reliance on the specially
> crafted VIDEO_BPP* enum values, since callers no longer need to know
> that those values are log2 quantities which is also important for
> future extensions.
> 
> Note that VNBYTES() is only correct for 8bpp and above, since it returns
> a whole number of bytes per pixel and cannot represent sub-byte pixel
> sizes. Every site converted to VNBYTES() here uses 16bpp or 32bpp, so
> the result is identical to the original expression.
> 
> No functional change is made.
> 
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---
> Changes in v2:
> - Convert uncaught conversion cases in the following files:
>    - arch/sandbox/cpu/sdl.c
>    - boot/fdt_simplefb.c
>    - drivers/video/atmel_lcdfb.c
>    - drivers/video/rockchip/rk_vop.c
>    - drivers/video/sunxi/sunxi_de2.c
>    - drivers/video/tegra/tegra124/display.c
> - Updated commit message
> - Link to v1: https://patch.msgid.link/20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com
> ---
>   arch/sandbox/cpu/sdl.c                 | 4 ++--
>   boot/fdt_simplefb.c                    | 2 +-
>   cmd/bdinfo.c                           | 2 +-
>   drivers/video/atmel_hlcdfb.c           | 2 +-
>   drivers/video/atmel_lcdfb.c            | 4 ++--
>   drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
>   drivers/video/meson/meson_vpu.c        | 4 ++--
>   drivers/video/mvebu_lcd.c              | 2 +-
>   drivers/video/rockchip/rk_vop.c        | 4 ++--

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de> # Rockchip

Cheers,
Quentin
