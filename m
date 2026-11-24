Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A0606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Amf2zh+E;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=n7AaLVQK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1765607DA;
	Tue, 24 Nov 2026 09:37:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9-uSR7Is54I; Tue, 24 Nov 2026 09:37:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B3BC607C3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795513057;
	b=hwZOE4T869JIzPsNUiEY3rlDgAUznq6bPjGYvk7wva/Gpuw4rjjqpHpoIKGgeFnFz9Vc
	 9/tXdV1StMXII4hznJKlBkd3FV+x3IMsrhN4E9+Y5LGt9MtFGnv2cCl7bvIlMJKnms6Sx
	 KisXsYi9jhNWUeo0mRAnRhS5JGHiPEGXBL8snqtXVHqSCMhESjXPhHyTs6N5NdaS+y8hJ
	 O64UxXGYC+rcnfMoJKN0wXC2uY+IFIMpKdnepQH+RKF1ZIFdqCqR8kA/dtZbW+RpUQnmA
	 USp0412eloHMPby9fL58WMyHVYwav4JthqLbTMiCGAdpoQ+5nP2e/RwoPhcdKMqUC6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795513057;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=b7IC1hsl+ADZG/76mT/T3NyL3GNUf9lgvmhwMzCDiL4=;
	b=AGsHaUrchZ8J9n4kjkojkMHSbSG+TNcmgysEWmL8x1mr7pgFh90g3TpZmYqocd/FyCN7
	 BzAsVpMk7ZfyPaE0HSDW5uAilmGF6VA1lAFMyNGMEgGZn/kcPYRnnHEIa8el6HJVAbn9Y
	 djp5FlFBG0ORhIsT2ihQkzh9yY1bl1cY4BfwMhj29K/4L4I7BRzbErFpTtCiPdHB3xzy+
	 Iproelm8dnXYw8c8oR/7WSDNcR5SC/72TL3kQibkWjb0pj9l3jE1aQEcPEiS6lAnreKES
	 fROt345XzdIJmHt7ev1HtdsEMTj9DzajF620yKUx4qO4LfFsqTA6/R10Tib0np1qjyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=n7AaLVQK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795513057;
	bh=b7IC1hsl+ADZG/76mT/T3NyL3GNUf9lgvmhwMzCDiL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Amf2zh+EWPH11A/ty6DXWlKOcW5/bhkVHTkGk7/y6vEYvRm4Jc+4mO7v45eXpqexC
	 yIk/xAcqD3VVUZ9ltdpOn3aJ4cDb2DRwHiJc0vK8E+pA6uyVbuwVvUtFL8e5PpAA2V
	 LfcNDOGESBrBnKtMA/sgjqjF/Yu0ZmcGU5WkptQmBmuQyWcsg0raemT9anVfm06xl3
	 1WkaodaeBD3ccgGWTZshJrSYh536NF3dbVmG7RaUcPb8dSKnypqYSDPGhAPfCC4Win
	 pmorglNUIZPc7Ct79L+SbKMBO13nj/scDoXbKJ8feJcNS64IfVeTvXa3Q8vWdxHa8l
	 ORed9+cPWEtnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B3BC607C3;
	Tue, 24 Nov 2026 09:37:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E0FFFBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B304607B8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKM9AtK7pLD7 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96123605F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=n7AaLVQK
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96123605F3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7IC1hsl+ADZG/76mT/T3NyL3GNUf9lgvmhwMzCDiL4=;
 b=n7AaLVQKP4TGGtPsR1g6jRh32/+Ge9mLssQueZNuP1VpYJSZMz9jMUz5mWmo///rrcb2GiVyBPfmKPws1tFph5Xa9GAFBUdICudIs1EwK+V31x2EftfW7+f2PCVgH0dDTykn0h3NG7qM/E3FOh0e80tWsjEA/1YbRCTS6BE+3uQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB8524.eurprd04.prod.outlook.com (2603:10a6:20b:433::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 09:37:26 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:37:26 +0000
Message-ID: <16a39440-4ff5-4977-b74e-3e453d83629b@cherry.de>
Date: Tue, 24 Nov 2026 10:37:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ram: rockchip: raise error when configuration is
 unsupported
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-3-fe9fb30a3169@gmail.com>
 <4b4b6b1d-9676-4b02-a10b-506d3169800f@cherry.de>
 <CAC928Haq+ic8E622GsxdoOxFyXn9BHvNKxWTkV2ZsYFvA4HC+w@mail.gmail.com>
 <a7390f3e-f6f1-4617-b7a4-df253673abe3@cherry.de>
 <CAC928HZjdBO1W7_X_+VKHh0fxoBoQahW9nRBfdf4PYMNAmompA@mail.gmail.com>
 <95ab24b7-5cfd-4ac6-8a63-f6fe820e1dff@cherry.de>
 <CAC928HZD3q-Yr8XnPHuc2XDsxtw27dtwjGC3KiQ0KziaBmyznA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAC928HZD3q-Yr8XnPHuc2XDsxtw27dtwjGC3KiQ0KziaBmyznA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VIZP296CA0024.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c281944-65c8-43ee-3b5c-08df4a0e8c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|23010399003|261028144727099003|10067099003|4143699003|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261021130227099003|261022105027099003|261022113327099003|261021133027099003|261009223027099003|261022115727099003|261021135927099003|261022075727099003|261026135527099003|261026140227099003|261026121527099003|261102123227099003|261026130827099003|18002099003|22082099003|6133799003|4133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 1z3iWNtBkVz4bepQUPXD2FxIQGshQ5J+jzpNYUJzBrsR3bO4m9Cq0LXYTiGsWpO/4/jzabrWTLH3rqGDALso9lGkPIckk+oD1HFT2nsbiUs+JcBzu2pQd/UmbVpkky2E7sCcHx4PP6Pa0VE90FKYiob1aVUlT5RbBxngu8hh0l0YohAmUVJ8pwgFm/ljSTCeYj6IpHwzvLpaee4WwEDJ0uLNesJqkp3E4P6v0wp9CGzpv4S/SBtyUMif6y0IQ3Vvfn2QMTHcB/bPj4NguxvSwdczAX4vk5OpIC6onbWsZhx45YKZMD86rp1HUlTKB/zCNYYXg6hL2UzBIn1QCDD33MmDeQ6RutY6QPsGvbFWpbj7AE3DMxzS+s9royPXKdOjNLSPULivatzPpOwyL/BFnwu2yrFtYvJWrvDF9oVmek+3o45zpmRfhA0/Zofsj+RvC2C2hzg5NsjS7oOQM7bpRFT2K3cGa5lS9w7iga1F54hBrn4sS2Ge7e9XBGsQsXR1TTe4pE6liifuw+7K6ozixDc9lqEbyzceKuw8MiXp/P9v+uhBIU+3yG8Ftbyczkuq0kcJNOTGz/M4PW/6Oyv8Rm7LYOtKQNqTVSorsfeuEJRQbtMJ3BFQiQ9Z7H53DYKaS0S1imE7irhMn0m/5BoxkBQBg7j2VCj2cnn0N1z9jQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(23010399003)(261028144727099003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261021130227099003)(261022105027099003)(261022113327099003)(261021133027099003)(261009223027099003)(261022115727099003)(261021135927099003)(261022075727099003)(261026135527099003)(261026140227099003)(261026121527099003)(261102123227099003)(261026130827099003)(18002099003)(22082099003)(6133799003)(4133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emlGNUI1QWw2MWN3ZnlQQzB2dHRnalFCcVB1dWVtb2VNRzh6RFpJcFVhQitE?=
 =?utf-8?B?YVFjN1RUeHVhWlNjNUk3SWJ0K0hLMjBGdWtTbkdDd3FaRS9RS2l0REtOVW9y?=
 =?utf-8?B?UURiNmkrb3FkOFl0N081K24yZkhWT1cwRFA0dE9xVWVUWlA0SWRWdk01MVA4?=
 =?utf-8?B?Z2tjbjZtdVFMcDlIV2h0N1JRVlJNd0pnMkQwUW1IV1MrMzVlTDMyVERSb25v?=
 =?utf-8?B?c3BhL0EzQm9kY2NrQTFSeEtvRmVMenhGK2tKOXhPRkc0Mzg1Wm9hRW84b0cz?=
 =?utf-8?B?Z2JLVlQ2SVVQRHM2OWxBMTU2VG1Bei9QcGFOVnNuenlRbnNwUXRUR0xtU1Iy?=
 =?utf-8?B?VkErUysvdTB4Q1B0Nm9oc1hFZnc3MHlVY0NEdWUzb01QWnhQWkZ1MVY3aXBp?=
 =?utf-8?B?UmI2VWtzVlo0MEdsdmtNZ3B2alhWWG1ISnNYUUxBZGpjY05raTdtZlhia1p6?=
 =?utf-8?B?clJVTHd4Y3J1YnpJMGpobnRmenJMbGZNTVZSSUhITnVrTWJ3SkhVWWRubmc4?=
 =?utf-8?B?S2ZNdHFvZ3RxSDcvbnZRNnhGSTlUUEo0Y3hMVkI1cjVmcUdOWmE2eUN6aG9K?=
 =?utf-8?B?aTZ4RUJ0c0lnRzlnY0ltUzMrM2tJN1RyMDdaaFZwUlNqdDJuMzdpajBLNVYz?=
 =?utf-8?B?Umt2TUp6SHFtbldUT2tVZlVQQ0VObWpxQVhEYlJHOG5XamZySml5MWY3OUlG?=
 =?utf-8?B?ZjhOckNGbGc5eGtYYlYzSEVXbkNmVUQ0V21CNnlpYnhPV2VBSG1HSmNkVWs4?=
 =?utf-8?B?SFpkVXcvc1JUa3Q0amRNbnJUVGdCV21iT3grbmFOWDdBQ1F5NWgzeGFGK3Ex?=
 =?utf-8?B?WkRSc1ZPa3FWYkgybU1yWlRleHZoVzRHQWQ4OFU4VVlSMjVscS9HcGpJRUVx?=
 =?utf-8?B?ZnVCTDFvTjVEZzR5aWVaREpUSmVXRUF4ZXdpemdXVGw0c2svRUpMUC82MHpJ?=
 =?utf-8?B?Vi9hclpuWUQ5VzhOKytuTEJJV21Ock1GY2xwYXhOWk5pb2xiU00zVEQxZ0JZ?=
 =?utf-8?B?N0pNenBHZkJCaDJiQTE4REZlZXhlUEdTT2hYYm15aHRjdGtIMnI3andqdUJF?=
 =?utf-8?B?NThxaGp1ekI0aFU2RWp1ZmhnVFFqV2FWYlhOZGUvbVZzWm56NXBkNHR3Umlt?=
 =?utf-8?B?ZjhobDJCUUk5REFtN3BQYWNXcWErMmhEWEx6MEZIdnNlRUkzMjhNbnM3Y1B2?=
 =?utf-8?B?dnBEMTdSY3JleGpPV3dsdDlvcDBYdUNxUFdQUHUyUnQyd1BSSER5bGdKa3NN?=
 =?utf-8?B?RG5TZzhOMVA2NWhrVHRuRnJNWGVxRW5xam9zTVp0dElwTng0dm9qTnVQa0pI?=
 =?utf-8?B?YmdubE42NmNVMkRENWdQT1FaUFhSMDNTM0M3cCtuaXNKM1lKZVBhenM1M3kz?=
 =?utf-8?B?YTI2WlE4QWxmTGZWMmxRZjhTdmZkaXNSZEdHeTVPL2FicWk5eERrU0pIL2dP?=
 =?utf-8?B?MjlFN0VRSzQvWWlGNUxYQlZJK25ZNllQUjU2NHUzYUs5MDFvQ2xWd21zK1Nj?=
 =?utf-8?B?RkRpbkxLMGpxQ1Q3L1BTeGVBMEpVMFhzWE5JQ0dLd1h6S2lQekFDaEh6TXkx?=
 =?utf-8?B?WWpHS0FPdFptNmFZU2kvODVrNS9XMlpwc0xYU2lna3JXSnR4WGIzUGZTKzNL?=
 =?utf-8?B?dXJlYU0xb3BXRGNZSmZIcG9ZZ0xYTjRBUk5YQ2tiYWtJZDZ1amNTbFhhZkRQ?=
 =?utf-8?B?emJjbTN0Nkg0eGhSazhZNFdhR2NvS3hTMW1oK2ZvUnlhRkRLL0taaDdHUkha?=
 =?utf-8?B?K0xISUJ5aDF1Uld0WEU2eDR5VDRUUWd0c3k5UklMemJMaktCWnFoNGNROHIv?=
 =?utf-8?B?S2NiNUdkQUx5cy83dlNaWXd5YkJnUWh4bkNVNEM4eEVjd0wxUGo4MFJnOFVO?=
 =?utf-8?B?K1RUY2xVNHBGeG94blphZ3ZHbEd3MVJubTlBUnhGQ0YrQXFEQytnREgxTTc5?=
 =?utf-8?B?d1NmaXdzbGNwb0VvM0pjc1BaTmVCUWNBV3V1bExsOVVDSGpyR1BFcDBucStn?=
 =?utf-8?B?YW8xek1TN3ZMSTRNTDN1c2xZcmpRVTZFL3dISnY0WnJsdE40NWprMGNIWlR1?=
 =?utf-8?B?Qmk1K0Z4UmI3UHhNS3lRUGhmbCtGOWo0bXU3U1BlR2V0QkVNWTZvNUkzNUpB?=
 =?utf-8?B?ZFNVNEQzWkRaendhY0lHVEF1MmpBaXZRWTRUMVZsNVd0Qy9Hem9rYXBKbnFW?=
 =?utf-8?B?YjNTTks4WmpBdlM1MU44Q0ZDWGtwNVI1b0FhZlIyTERzWEVxdk1FcXR5ZjFt?=
 =?utf-8?B?MlpFL3dOWlNwaDBSd1lMWjF1K1FuZjVkaGxPNUlSbTNEUkQ1OEtvSk0vWkJZ?=
 =?utf-8?B?Y2hHY3VCZkJxYVBKNy9yNzBxQlMvSVczYzhMTTV3YzU0OWM1M2hDV0NnZGxV?=
 =?utf-8?Q?fb8J1Ez77lZbBRop2FjJ20jbyxQ5/crcSRfK9UXC3BE7m?=
X-MS-Exchange-AntiSpam-MessageData-1: FIuKjRIGdFPyzWi9N1ZHMdKt6JJI2lEGn4g=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c281944-65c8-43ee-3b5c-08df4a0e8c82
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:37:26.2799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loEpU2wGDqFdQ2244E44SlvSzL9X26z/uCio5M/sep3vjIAY1RrxBwsC3CBpNYenVBmk2yxOJre2SmPxkxz3dIyK0QV6Wge2eZrbopHBg40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8524
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 11/23/26 6:35 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno lun 23 nov 2026 alle ore 10:56 Quentin Schulz ha scritto:
>> Hi Massimo,
>>
>> On 11/20/26 8:53 PM, Massimo Pegorer wrote:
>>> Hi Quentin,
>>>
>>> Il giorno gio 19 nov 2026 alle ore 16:14 Quentin Schulz ha scritto:
>>>> Hi Massimo,
>>>>
>>>> On 11/19/26 2:23 PM, Massimo Pegorer wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> Il giorno mar 17 nov 2026 alle ore 17:40 Quentin Schulz
>>>>> <quentin.schulz@cherry.de> ha scritto:
>>>>>>
>>>>>> Hi Massimo,
>>>>>>
>>>>>> On 11/16/26 7:39 PM, Massimo Pegorer wrote:
>>>>>>> The PX30 and RV1126 sdram drivers support more sdram types but only
>>>>>>> one type at a time, really. The type to support is selected through
>>>>>>> RAM_ROCKCHIP_XXX configuration options: raise a compile-time error if
>>>>>>> more than one of these options is selected, instead of relying on a
>>>>>>> debatable and embedded priority order to choose the one to support
>>>>>>> among the selected.
>>>>>>>
>>>>>>
>>>>>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>>
>>>>>> If we add ROCKCHIP_RK3399 to the depends of
>>>>>> RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR4, I think
>>>>>> we should add a similar check in the rk3399 driver to refuse to build if
>>>>>> there's LPDDR4 and either of RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3
>>>>>> enabled. What do you think?
>>>>>
>>>>> Unfortunately I did not come to a clean solution for the RK3399 sdram driver
>>>>> "singularity". At least, not enough clear for my taste. So I left untouched,
>>>>> open to discussion.
>>>>>
>>>>> Let's suppose we also have ROCKCHIP_RK3399 in the dependencies of
>>>>> RAM_ROCKCHIP_LPDDR3 and RAM_ROCKCHIP_DDR3, something like:
>>>>>
>>>>> config RAM_ROCKCHIP_DDR3
>>>>>            depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399 || ROCKCHIP_RV1126
>>>>>
>>>>> config RAM_ROCKCHIP_LPDDR3
>>>>>            depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399
>>>>>
>>>>> Some compile-time checks in the source code can easily be added to raise an
>>>>> error if LPDDR4 is selected but it is not the only one, or if none is selected.
>>>>>
>>>>> The point that annoys me is that, in RK3399's case, the two options
>>>>> RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR3 are the same thing, in the end.
>>>>> If it would be possible to have their values coordinated, I would be happy,
>>>>> but I do not think it is. Using the Kconfig 'select' statement will force
>>>>> one to be true when the other is selected. But unfortunately, this does not
>>>>> work when unselecting options. So, if one is selected but the other is not,
>>>>> what should we do in this case: raise an error, or silently ignore it since
>>>>> it does not affect the build?
>>>>>
>>>>
>>>> I think it's fine if we have DDR3/LPDDR3 selected but will use
>>>> LPDDR3/DDR3 based on Device Tree. We can make them really mean something
>>>> by gating LPDDR3-/DDR3-specific code, but I'm not sure it's that worth
>>>> it right now. Something worth investigating if we need to shed some
>>>> bytes in TPL/SPL.
>>>>
>>>>> An alternative could be to use an RK3399-specific config option, something
>>>>> like RAM_ROCKCHIP_DDR3_LPDDR3 but... ...it's quite disgusting.
>>>>>
>>>>
>>>> Nope, don't want to go this route :)
>>>>
>>>> Another option is to make the RK3399 driver capable of handling
>>>> LPDDR3/DDR3 AND LPDDR4 at the same time (no autodetection of the
>>>> populated DRAM type, still read the type from Device Tree), then it
>>>
>>> This (driver capable of handling all types at the same time) seems to me
>>> the most reasonable due to the fact that, indeed, the SDRAM type and
>>> parameters are read from the Device Tree.
>>>
>>>> becomes less of a headache. You can have LPDDR3/DDR3, and/or LPDDR4, and
>>>> it gets easier in the Kconfig symbols.
>>>>
>>>> I quickly came up with (didn't test aside building):
>>>>
>>>> """
>>>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c
>>>> b/drivers/ram/rockchip/sdram_rk3399.c
>>>> index 6fa8f268770d..22d196f1bec7 100644
>>>> --- a/drivers/ram/rockchip/sdram_rk3399.c
>>>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
>>>> @@ -1632,7 +1632,7 @@ static void set_ddr_stride(struct
>>>> rk3399_pmusgrf_regs *pmusgrf, u32 stride)
>>>>           rk_clrsetreg(&pmusgrf->soc_con4, 0x1f << 10, stride << 10);
>>>>     }
>>>>
>>>> -#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>>>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
>>>> defined(CONFIG_RAM_ROCKCHIP_DDR3)
>>>>     static int data_training_first(struct dram_info *dram, u32 channel, u8
>>>> rank,
>>>>                                  struct rk3399_sdram_params *params)
>>>>     {
>>>> @@ -1723,7 +1723,9 @@ void modify_param(const struct chan_info *chan,
>>>>           clrsetbits_le32(&denali_pi_params[76], 0x1 << 24, 0x1 << 24);
>>>>           clrsetbits_le32(&denali_pi_params[77], 0x1, 0x1);
>>>>     }
>>>> -#else
>>>> +#endif
>>>> +
>>>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>>>>
>>>>     struct rk3399_sdram_params dfs_cfgs_lpddr4[] = {
>>>>     #include "sdram-rk3399-lpddr4-400.inc"
>>>> @@ -2964,9 +2966,11 @@ static int sdram_init(struct dram_info *dram,
>>>>           }
>>>>
>>>>     #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>>>> -       /* LPDDR4 needs to be trained at 400MHz */
>>>> -       lpddr4_set_rate(dram, params, 0);
>>>> -       params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
>>>> +       if (dramtype == LPDDR4) {
>>>> +               /* LPDDR4 needs to be trained at 400MHz */
>>>> +               lpddr4_set_rate(dram, params, 0);
>>>> +               params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
>>>> +       }
>>>>     #endif
>>>>
>>>>           params->base.num_channels = 0;
>>>> @@ -3067,19 +3071,23 @@ static int conv_of_plat(struct udevice *dev)
>>>>     }
>>>>     #endif
>>>>
>>>> -static const struct sdram_rk3399_ops rk3399_ops = {
>>>> -#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>>>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
>>>> defined(CONFIG_RAM_ROCKCHIP_DDR3)
>>>> +static const struct sdram_rk3399_ops rk3399_lpddr3_ddr3_ops = {
>>>>           .data_training_first = data_training_first,
>>>>           .set_rate_index = switch_to_phy_index1,
>>>>           .modify_param = modify_param,
>>>>           .get_phy_index_params = get_phy_index_params,
>>>> -#else
>>>> +};
>>>> +#endif
>>>> +
>>>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>>>> +static const struct sdram_rk3399_ops rk3399_lpddr4_ops = {
>>>>           .data_training_first = lpddr4_mr_detect,
>>>>           .set_rate_index = lpddr4_set_rate,
>>>>           .modify_param = lpddr4_modify_param,
>>>>           .get_phy_index_params = lpddr4_get_phy_index_params,
>>>> -#endif
>>>>     };
>>>> +#endif
>>>>
>>>>     static int rk3399_dmc_init(struct udevice *dev)
>>>>     {
>>>> @@ -3098,7 +3106,21 @@ static int rk3399_dmc_init(struct udevice *dev)
>>>>                   return ret;
>>>>     #endif
>>>>
>>>> -       priv->ops = &rk3399_ops;
>>>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>>>> +       if (params->base.dramtype == LPDDR4)
>>>> +               priv->ops = &rk3399_lpddr4_ops;
>>>> +#endif
>>>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
>>>> defined(CONFIG_RAM_ROCKCHIP_DDR3)
>>>> +       if (params->base.dramtype == LPDDR3 || params->base.dramtype == DDR3)
>>>> +               priv->ops = &rk3399_lpddr3_ddr3_ops;
>>>> +#endif
>>>> +
>>>> +       if (priv->ops == NULL) {
>>>> +               printf("no ops found for requested dramtype (%d)\n",
>>>> +                      params->base.dramtype);
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>>           priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
>>>>           priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>>>>           priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
>>>> """
>>>>
>>>> Of course, we need to update the existing defconfigs to reflect that
>>>> change as !LPDDR4 used to mean LPDDR3/DDR3 but not anymore. An
>>>> intermediary step could be to have DDR3/LPDDR3 default y if !LPDDR4 so
>>>> we avoid changing the defconfigs with the driver patch, and then remove
>>>> the default y in a follow-up commit by making the rk3399 defconfigs
>>>> enable the appropriate one (easy to find based on the Device Tree they
>>>> include).
>>>>
>>>> Finally, with the above diff, you can technically build the RK3399
>>>> driver without any of LPDDR3/DDR3/DDR4 enabled, which can be remediated
>>>> by an ifdef check at the top like you've done for PX30/RV1126, just that
>>>> we *want* to check that their sum is NOT 0, anything else would be fine.
>>>>
>>>> What do you think?
>>>
>>> I look at the RK3399 driver code and at its repository history to provide a
>>> well-founded answer and... honestly, it seems to me a mess. The driver was
>>> born to support all SDRAM types at the same time. Then the LPDDR4 config
>>> option was added by commit b6cf08949d4 because "Supporting LPDDR4 code support
>>> in RK3399 would increases the size of SPL/TPL", and the related ifdeffery
>>> followed. But a lot of LPDDR4 code was already there, and has been left in the
>>
>> RK3399 started with only SPL supported. Then TPL support got added but
>> only for some boards, c.f. RK3399 Puma switched to TPL in commit
>> 2169e29c5a1b ("rockchip: puma-rk3399: migrate to TPL"), "only" four
>> years ago. SO I think the size argument was reasonable for SPL as it
>> probably was already quite big, even for RK3399.
>>
>>> common area, instead of being reorganized properly. Seems everybody added on
>>> top, instead of looking to redesign the driver.
>>>
>>
>> That's usually what people do. Doing bigger reworks are not very fun,
>> and take longer to be reviewed (and sometimes are outright rejected).
> 
> Really? That seems to mean I am quite an "unusual people". I find big reworks
> much more funnier than adding a few lines on top of chaos: I need to spend a
> lot of reasoning and testing to make the simplest thing work well on top of
> chaos. And I will have to spend all of that once again, if I will need to add
> a few more lines just a few months later.
> 

Maybe I'm generalizing too much? There's only so much of your free time 
you can spend everyday, or if it's your day job, there's likely pressure 
to do things quickly (or do many things), so I think it's natural to go 
towards the cheapest available option.

>>
>>> What happens if the driver is built for LPDDR4 only and the value of dramtype
>>> read from Device Tree is DDR3 or LPDDR3? Or vice versa? The simplest thing I
>>> would expect is for the driver to print an error and stop. It doesn't. Instead,
>>> it goes on, without happy ending I suppose.
>>>
>>
>> Yeah, it likely will try to init the DRAM with completely misconfigured
>> DRAM controller.
>>
>>> Another example: looking here and there I came across the gstride_type variable
>>> in the calculate_stride() function: is it there something magic I cannot
>>> understand? I see a local variable initialized and then used for comparisons,
>>> which are all necessarily false.
>>>
>>
>> Yup, and downstream also has the same issue, c.f.
>> https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/ram/rockchip/sdram_rk3399.c
>>
>>> In the end, I wouldn't touch it. But if you prefer, I can integrate in this
>>> series the changes you suggested above, adding the defaults y if !LPDDR4 and
>>> the check for NOT 0.
>>>
>>
>> There's probably a lot of cleanup we can do. I'm suspecting the removal
>> of gstride_type won't do anything to the size of the TPL/SPL as I would
>> hope the compiler identifies those always-true and always-false
>> if-blocks and removes the if check, or the block entirely. It would help
>> with readability though.
>>
>> Up to you, I can also simply send a series with this done myself and you
>> can rebase your changes on top. What do you prefer?
> 
> I prefer to merge your suggestions in my series, not to fragment topic in
> more pieces and to limit patches management effort. A v4 will follow. I will
> add a signed off tag with your name too: correct? Thanks.
> 

Suggested-by or Co-developed-by would work too I guess. Signed-off-by, 
the order matters, so I think I'd need to be mentioned before you 
(assuming you will be the author of the patch). I don't care too much, 
but I'm not sure what'd be proper for someone who would :)

Cheers,
Quentin
