Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B342C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 09:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62CC881760;
	Tue, 17 Jun 2025 11:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZAmtjzvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39DB82B0F; Tue, 17 Jun 2025 11:20:54 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1A980C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 11:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfjkKYMjHSsSRQvbVI5+HqjBwPjuHGhAd+WH2sUpM6bK9l5Ub4rQmsbHb8ZG1YaL9pnTBt5x4emfZk/mHUZn+VmnT040mOmz9CnN82ZSkQbWx3bGsUyH4N4dEptNa24dXxK+7TIcjz/ZUc/ljMjAz2gq/AjTWG3VBNcdxD3YQS8iFZ48LWnDo1kD2ijpeqLflq6A1N6MABJMDfuN/pRZxa31wWl7WdJ2gD8d0ITfr533xm3BmmEvhy+HWCbcDwojYJE7bYil0lRdqew7g8holx6B701u7MkJgWYvhA3onv5vLDxEQtPUKHakYNlTrbL44UyDnF6/glSZk2VsrIuLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3hdJJcuMEkV9bKI35zuxLJPOF+Z7XaH2o9AG3PjCaY=;
 b=m6xiFEFSoHkwqXCkENpFb5CnWEslwHkixag4Of1jzm5we6bVmJR+5WrxkCPlMiVH0WBPMVZt2HP6ZVxlF1q0rPrLXUgZXuSLMjgj1YEiZGjXk9dItgiMuQTKAbpLCY3xmTzEIwxDPmNYtq8V8iWqOYPKNSSG/y4JGeejwrjM/4WdplKmiBGPOSHMClEx63S9sYXgh/G+BsJH8G0NE6v7E86v7WKba18nK45BIvukx9QTUIUW16qlbCz/I3R4D9Dcltb8/LC8lsgUp73qOkt6Rz/2zkRhTKAseAX/lpcR1pOT4BM270eplaKlz1h5mrw7Na3eLvzO5KLD273qGWN/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3hdJJcuMEkV9bKI35zuxLJPOF+Z7XaH2o9AG3PjCaY=;
 b=ZAmtjzvixawyFnjpbHcFbfuczPPt/WPz6jAqv9oPh0tBeLua6WZfmEBmT4ZWf8FuJNnBM2SRn2/2gGuXplAubP9BiAEGFXFz9+5g/CNgdgh5HM3v1sTkJKXRV5J3hTYjzWNR14xjsCnRMsEZBIxscX0bDYa7Z/s/+yrZFxcUgGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8435.eurprd04.prod.outlook.com (2603:10a6:20b:344::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 09:20:50 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 09:20:50 +0000
Message-ID: <c259053b-41a7-42b9-a42e-ca2141efc8e6@cherry.de>
Date: Tue, 17 Jun 2025 11:20:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: unblock CAN bus in spl_board_init on
 Jaguar
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de
References: <20250617084253.1756035-1-jakob.unterwurzacher@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250617084253.1756035-1-jakob.unterwurzacher@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0030.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 84394d92-a0fc-4507-d050-08ddad804024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0hQKzdrdVNxbnlBNHpTdE5tcDNXeWo0dmszYnFZcXMyRzdOTTcyNXA2aWlN?=
 =?utf-8?B?TjY0NHM5Rk53RlZGREt2UEc0aU01OWpHMXFxNlFTc1FSazBxdmFxaXBzTUF4?=
 =?utf-8?B?SEJYeHdUK2ZBQWx3Y0FVV1Z1czA3OVRwN0s1Y015QXNQYjE0UDBGNkJRZU9L?=
 =?utf-8?B?U1U1RXRJRllLeDBGektTQS8yUmR0MHNuUW5DVVljMmkzcGpZQjBQWnRPeVRo?=
 =?utf-8?B?VDBqeFdyYk1LU0Q5WGxoTWlhd05YcHZQcldQRHVPY1ptdTF0QmllamRBK1ha?=
 =?utf-8?B?Z0d4Q0gyTVNhYnRmSHpzVm5JbU9RaWtjWlFLaGZQS05hYVkxZVVnaGpVQWlF?=
 =?utf-8?B?NGZDZi9DY25UVXNXTWlIamFaMWxmU0d3SitDSjBnREFrQ01LOHZsSHFMUUwr?=
 =?utf-8?B?cnh4MUhuZDVmdXU5MktCNlJiSGhacTNXYXZpaWxsT09XUEh6aDVjMFdZUmx2?=
 =?utf-8?B?V1B5U3VYbW1VWE0rUDJyd1VCUWlpQnFJWldZK1NIMUM1b28wMmhsWkRvQ1E1?=
 =?utf-8?B?TGdxUU81eExaQUNUc2VrRDQwWHJieHhyRzlTQkNGYys2N3ZyMjhYVzZ5d09E?=
 =?utf-8?B?bDlINU55Wk1TS3B5VzE5enpwTFhBYklyY0ZUMHg4akN5SG1VMFFWL1ZobWls?=
 =?utf-8?B?OHJOanZyN0QySXFWQjYvempuS0Nsa3IyNUtyMnJYWmRVcnR1ZGpEMmZZOXdU?=
 =?utf-8?B?cDF5VGFBVXBPeGxDRytXTlczU3FmV2R5bUp6eTZFQjhQc3lUaFpWZkM5VjZr?=
 =?utf-8?B?TXRTZlVhd21iRnEwRldWQ0ROSFFmbGlNbVVnRHZSTjJnaVZNdThxVVRlRDVj?=
 =?utf-8?B?ODdINmUyc1B5cHdDMVBzNjVMcms3T0Uvd29vMUFPNE91RjgyWXJCcDNpRll3?=
 =?utf-8?B?NjRtQUVnRXZPVC9TODU4WnQxTm1MRm9NOUk5L1gzWVZ5Wk1PYmlneEk3UTRD?=
 =?utf-8?B?WWxWQXZTMkZmYkJMUklCbFRNdFNyZmJKNnNUZVBBS2Exb1FUYy9neGg3UXdu?=
 =?utf-8?B?YzA1elBTV28wMkU2dnFmSGQvN00rM29rZkI2SVZtd0JuenlvZHZmRGRHaGxn?=
 =?utf-8?B?THNLajdLTFNkbWxTN0JVUG9Iem9tZ3paeStUc2FYWDRaRklyWHV2WUphbk95?=
 =?utf-8?B?MXpwUHEvbzk3eTFHclljTHVGOU1pZU9nQkwwSEdrMWw4K3VBMnN3NVpDdlpZ?=
 =?utf-8?B?Qkt6MVhxN2Z3S0NhZDk2NS9heXJFTmZrRXg0K0VvdDRyWWhvcHN5KzN2Ly91?=
 =?utf-8?B?Z2hnK3ovM25JbzgyQUJraEM4cmZmYUZtMnYxanB4cEsxdDJjTmE2bnFraURL?=
 =?utf-8?B?WGhVOWsyWGVZYVMxTko0WERlZjRVOUZJdG41M3FCeUFCd0V3SS9PZkhlbEJa?=
 =?utf-8?B?Q3NKT3FpdmRZcEFHcXhXd2VtNjNvemJxZmllZXNOYk5FTUxMRTNnSTZHMi9E?=
 =?utf-8?B?eG90dDI4SVk1VTB0UGZFL2VkZlFBTXJRSTN4UnJ0aXgrWWpha0p0Um5kTjQ4?=
 =?utf-8?B?aGhBV0djcEpGYWRyTTRsTGVRN2piM3gwL1hXT3hsb0dLYStIZ0xpTVlqLzV3?=
 =?utf-8?B?M1hOcEFXeGxlNUdDQ2NSRXJ5TUlXcDQ3YmM4RkVnbVA2bFdLbU56cGhmVlBi?=
 =?utf-8?B?bk9vVjNvcE9RQ1FTMitNMDFOb2ZLMUE3NFY0UmF1bnVuektxbWU0NStqVTl5?=
 =?utf-8?B?eEI5ZUlNK05pbXVLYy9DcFpCekVKZmVYS0g5MjZJWHo0eXQyS2pua3N4SVkw?=
 =?utf-8?B?WWtSU0ZRWHp2YndaSHcyakJvK0EvZUI4QUVzZ2JhcW0zcFFtem9NbmRaVmZn?=
 =?utf-8?B?Y2JYQTJ0bGRwdEJkRVNwMFZrVlh2bHBFc0RpUERDSGVGV0JJK1BCZ2FUVTF6?=
 =?utf-8?B?OUM0YWVQN1E2bmp2UC9RM3diUjdVYURXUkc4bk83ZnFzZm0xSWU3cmExRTkx?=
 =?utf-8?Q?/JOsS0MsDl8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzlVSGVhUHAwdWVDQ0lTQTJRTGxPaklKaW43OUlZMktmcWpxanJZcUttTjNn?=
 =?utf-8?B?SkI0bFlXSENvbGxSN1UzRkNQVks2REpSVmFxTUNFZ3ZZYkE0UXNqWml4MUwv?=
 =?utf-8?B?NXBaSk1zWjNoU0ViQ1FTaFN2Z2ZXQkFobUgxVnEzT1R6TXNzeVE2QlI3VDZS?=
 =?utf-8?B?N1F2cXc1Yk1LWDhOamcyZzRMR0ljS3l1SS9GeTBVVXVPWGpweElGVmR3Z0JE?=
 =?utf-8?B?RGRrOVhTVGNUZSthOE5SVHlPamlrdURYVVRsc0xhQnlVZTFEMFFpNXlkSW0x?=
 =?utf-8?B?MWZzV1hJV05LMGRUbzN5NzEwQU9oTTNqdE4vUkRiUncvdTBWWGNsMEdTcWUy?=
 =?utf-8?B?RVo4OFlUZWRYZlJEZk9OeG5QVzN3ZE9zbHRmOWFsNkh5U20veVZWK1BkWlVV?=
 =?utf-8?B?NW9RcVcySkF3Mkptc1ZOWVZEb1g1Zzd5L2FoSFdtdWkxS1JzTUV2MUJHZTdF?=
 =?utf-8?B?MjBld1NKdEk0TnBDd0dlRHhlRmlsaHFPd3pVZm0yVjE2b0RyTWQySDVNbkRi?=
 =?utf-8?B?Zkk0V0NsRTVJbFpFMGxzcUVpQTk4L3pDMHRoTm5NYlQ2TllndTFWa2lzVFFX?=
 =?utf-8?B?SjJMU3BobWZSdnl2L2Q1YUhETndxYzlRTEJXQjZiMWFxUXJEenV6N1ZmZGR2?=
 =?utf-8?B?NDE0eXkxZmRiMWd3TjZLVWpzZzVCb0s4UHVEWW5ieGI4U1RIR1ZJZlNOMGNT?=
 =?utf-8?B?a0ZtVDYybmxoU2hmenoxOVRGRU1GSjdqUTRHcDI2NXZZUmNvVDNRRjZoQmV2?=
 =?utf-8?B?c0lRT0tpUU8wZTY5U1kyTGNMSy9ySk9qZUNBMUlUS2pJZ0xXclhyY2tPS0pi?=
 =?utf-8?B?TlZZUU1LM0s4VldDaHFTK1pRa2F4cW1jYnk1L0J4M01mTlE4UUZYb0Z4QjN0?=
 =?utf-8?B?WTQxS3ZLeHNtRnI2aXZSQ054NXQ5TUVlc05IcUkycFBBWXFabTNDRFhBU0NH?=
 =?utf-8?B?Z3JTdkdZcWFuemw4TjgyUFpwY0hlT3J3V0ZZSDUwWUU3cHUyWWdlY2YxTzgz?=
 =?utf-8?B?cUJXMSs2VjRlVE1lZVhXZUo1WndHSzdaM0YxaFh2MmswVXNZWDVpbmlMcWVZ?=
 =?utf-8?B?dVBadmxPVzc1S1h3ZktuY1IrSEJQeTFJcmJKdmhiS3pFSW5oSFFtNXFKUjYy?=
 =?utf-8?B?T2h5WmMyL2syOHd2YVpDOWFGTjdQeGFaZjRWMGhwcEZ4UlQ2UVZUb0FyRDBl?=
 =?utf-8?B?L2dEQUhLUGV2Tm5ETnpSYWw4UW9xVzNOTm05QWNHMzB3bS80UlpQRGNvRTVo?=
 =?utf-8?B?bHE4WnJ1MnA3eEo3L2t6OHd1MjFVZDh0V0ZGbjFhWUducGhUQnFlMi9hV3Ix?=
 =?utf-8?B?Zm5ycU0wWURWMytVNlZWZ0ZnQVM2eHBHS3YrS3I4U3pCaXJYKzZnWnl1c1cw?=
 =?utf-8?B?c3ppOGorcGYwdHNhV2pzU3BnakErMDVpRFhjUTlnRE9HQ0IxNDYxYnNNeThr?=
 =?utf-8?B?SFV4Q29kUk9BRjdKVSt4NVNpWDlYd0MzUEt6OTFneFpzNmxJRGhzWEIxT1d2?=
 =?utf-8?B?c0ZkR1R2d0ViNXdhZUQyL3lUNHdkYjg3SjlrZ1o2U3V1L1FXd00xWVRyWmhV?=
 =?utf-8?B?MDFOaWtnMHFXNDQ0U0pmK1NxTTlUS0k0aDF5QWtuVkQ3TXhta0wzbDdIQVlX?=
 =?utf-8?B?b1ZXdHBxdG1xdTlSNjVMRUt0UXd2TzFzTjhrdmtNRnd6ZHZDVUJyeXJzTEp3?=
 =?utf-8?B?UjBja2ROS2hqalNHbWVHWFZRRmlTYWdZNEdaZnNOTWttUC9BaWZQMnI2d3Qx?=
 =?utf-8?B?bStaSWE1eFJxVm1rV1FmUmtOeWpTTlJjTXFNTVlrZ0VRZE5JZk5vOTBQUUVH?=
 =?utf-8?B?WGdTZVhNSnY5M3kxcXE1R2Y4Vk9FOUo5VjAyQmc2enhzUEI5QUZPbnlXanNS?=
 =?utf-8?B?enBDeVlBU0UwN3IzZVoxR2pEQVpvNHlnZ2I2SEdZYnhMcTZuYi9KZFpsQVFZ?=
 =?utf-8?B?TjJFWGtsMkpyenBuMG9XdXp5RldmZUpVY2wvdGlQUDBPOFlGQmZWemc1NnZU?=
 =?utf-8?B?WVJXbjdJNHBzZzllZDhYSkkyMHJQQ21zS0d5angyUS9yUWlJSkZhaWs2RkVU?=
 =?utf-8?B?TDRTa3RXVzNIbGMvcVB4N2dJekF1V1Y5aXZaN2dvaW9EMWpnVnlxdkdhVms1?=
 =?utf-8?B?cVUzTk5iUTNKMm1kR3lkWjhpMzYzUU5Nbk1wM3U3VVlUL2VJMTVCdUhsMG1l?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 84394d92-a0fc-4507-d050-08ddad804024
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:20:50.2853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbMa7BYGKso5EjgVVXe3E8iMA7XTXmoQldU26dU2YLsKDt+PuNFFbQ6OgJWj8t0ZGiuEoEOULYRoCBNoCrk/9IDeAcgFgMBrArE1ki75xcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8435
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Jakob,

On 6/17/25 10:42 AM, Jakob Unterwurzacher wrote:
> GPIO0_B7 is routed to TXI of the on-board CAN transceiver. The
> line has a pull-down per SoC default.
> 
> This means the CAN transceiver transmits a dominant zero
> and blocks the CAN bus until Linux boots and reconfigures the pin.
> 
> Let's switch to pull-up as soon as we can (i.e. in SPL).
> This cuts down the "bus is blocked" time from 10 seconds to < 1 second.
> 
> Of course, to this needs CONFIG_SPL_BOARD_INIT, so enable it

-this

(No need to send a v2 just for that)

> the Jaguar defconfig.
> 
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

If we ever have an open DRAM init in U-Boot, we should move this to TPL 
so it's as early as possible in the boot process.

Thanks!
Quentin
