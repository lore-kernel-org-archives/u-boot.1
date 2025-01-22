Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECE0C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 07:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA9280283;
	Wed, 22 Jan 2025 08:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="aUWZyUch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4528078B; Wed, 22 Jan 2025 08:48:17 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::71f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F7ED801FB
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Tapio.Reijonen@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg9+3D899N/sD/RysDm+s0uvKHSUx/rhWZPVocZynoMSgJJ+wtyeDozDIGsZ+hS9Vutokeu85hmErf8ZM4NT7xYdAf3an0qzxoZWJ2yqtR0GOHw9EitpaaYh60az6eEJDkot9tA17vzaWx4O/HMv3xHl9eWaobxLodHYh2V7mFu63GLwY8YcKWTgSWFJ0h0BoiF95zLOZ9nD6E+HUzCRZzEgrJIDFf5JXwUJDa/xbzHobxlqWgJwn0AwRh9CRrM2enHFGmJEFlPOCEFT6qu5iJqE8nTDgA79B1L9toWviyuSnHQDPSmhfvheGrBwdjwMxqXkgbBap/8WZ3x0k7p/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr1piIxhTnVeX707yoJuASzAdSJgr/6h58HWq02pkeQ=;
 b=x2zb35J1kQVnD/uukVF8HnsStqjZNI3Xpj1porR1zu5BX9mtHcvqDc19nh9a758Ph1x5NGpqCOK1I3MAUjarkBK8DP3qM0f4O+pMVg3uBv0pLCDxTrXKvQFCm77uE94azvE4dHbH3RJrQXpg3ADnfJ0qaj7PumwzhOJnTNaBRRgCjjJAveT+fSh2yWotEz0i4QrkB5W2y0QLB90Vv+KHrMevHgkiwb45DyDhJfDorZbXe4rQkkPGu2pDPSezhJVAaCi33rhSGh9vFymX7zfPWXLwOoTmcjJbMD4+thLo1UFOSIJPlTj39fBdReneQ2gnf1rW4U2db/7+tBbjIdhOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr1piIxhTnVeX707yoJuASzAdSJgr/6h58HWq02pkeQ=;
 b=aUWZyUchvzjowRC+qvbmk1S1TR5YdNvPSKDBElkor1BPEZbDwfoSbm2dlEBuqEdsRLsFgtqC+F+FJKMS2zeOyn+hXF2jg4anAZEH3/dis0UpDaIYqpx7eoqRfThXeViYbGxwRiDUk6x8T8NzIsgy5J+Bj+/JEtNSCceaUFSnQ+MstYb9qRxRIfgF2BLc2Kh++83t7wz3LsSM9CPgNDleneUn1HHIGoOAEFsvZzOAWu9IvRLkzHmQ8QWtiV6Cx1oHADqezNegSbAacImicCOzkdyRUgC1EaIDcMeGAOR3jHTSljXxRekkuqWw8iexVSrtVtfOToOylhSUSQggTFQB/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com (2603:10a6:150:11f::17)
 by PR3PR06MB6729.eurprd06.prod.outlook.com (2603:10a6:102:6d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 07:48:11 +0000
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7]) by GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 07:48:11 +0000
Message-ID: <f7066190-1aac-456a-a407-ee1d8e8f506e@vaisala.com>
Date: Wed, 22 Jan 2025 09:48:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] net: phy: gmii2rgmii: Add support for phy ethernet
 id configuration
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
 <20250116054324.836712-3-tapio.reijonen@vaisala.com>
 <3810ad10-194f-4e59-8abd-ad74b7aa9002@amd.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <3810ad10-194f-4e59-8abd-ad74b7aa9002@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7)
 To GVXPR06MB9065.eurprd06.prod.outlook.com
 (2603:10a6:150:11f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR06MB9065:EE_|PR3PR06MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 4117e3a0-7f0a-4c1f-65ce-08dd3ab91e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkEvUU93c3MxTTVBNkxTMWQ2UmpKUk1TcU1Ub09CRnE3YzdWRzNJSkQrOHI2?=
 =?utf-8?B?d1loeVY5bnlXSi9tV0tlQnhqL3ZUSnloM0xsVkVNVWxyaUhVbFlSYXRQU3NB?=
 =?utf-8?B?aVBsT3k1eGV0ei9hM0h2THJVQnVDWHlma2lVR0lZS1lyNm1VeVNkNWlPLzlM?=
 =?utf-8?B?M3NLaFhHeVVNOTkrVkN3V3VzY2lsakpKcGkrdFY0RFI2UVUzbjRMdm10OEx5?=
 =?utf-8?B?OHZKOWhwRkUxKzVsaG1yUDRkQ1RuMWlhYXo2MHBPWGR5cmkwYXoxdE5aSnRI?=
 =?utf-8?B?ZkQ2TFFZdmRXNks4dHdWSVFTYUNTK09RNWR5UDVjUHdEaTM5NW13VVhxVzdT?=
 =?utf-8?B?U3JjbHJoajV4dWFmL1ovVlRzT0dlY2FDYXU5YjZOczMwS0xsQW9aYkZ2QWhG?=
 =?utf-8?B?UmZad09zYVVsYXFqMnNTelVJT1NjK2xNRDhGempNdmVlZEZPRlRtZE9Zem14?=
 =?utf-8?B?VUdYcmQwOXRRSnRmSWJRRVV1ckFRRG9hSkF0T0VQam04c0pWbTBzYnQrYm1k?=
 =?utf-8?B?UmN2bnl5QWhqOUM5UUhJd3BucGY1aE5ETjVDRVVrRDFXVUpYaFo3SE40Uk5q?=
 =?utf-8?B?SGNqc1FqYkIrQWE0TEFjdS9vQXVTTitlSDVFLysxMnNVc0lHdHJUWEFja3Vh?=
 =?utf-8?B?ZE45OWtRNDVBUXZpekx6dnNYcUFwUjRrd2U4K3l0alZPTUdzdnFOVXdLak9q?=
 =?utf-8?B?UUpyVWpqYWtWZFBnNUlRcVlETmw4Sm1kU2VpYW9McEEzbEhVdWxnQm5rLzQ3?=
 =?utf-8?B?QmxjZGhwU205NzNWTmRjL0NrT2F0RlN5REVXZWZzTjZzM2t6K2ljVWFBM0gw?=
 =?utf-8?B?REhrakxySU1LOTBrUk9NM0NsZFEra0dCT2dhcEkyWW1weVN0aitXajlLYm4v?=
 =?utf-8?B?Skp1WXRjekxiSkVMdkdQcW56MlBNNWE2dW5VakR6M3hRZ1p2L3NNYndweVhh?=
 =?utf-8?B?QTRkdlg0YWJzQ2RxalNsaTVOWmplZGNDclVCVnpYMTVuVkxRbzBsTmNqazQ3?=
 =?utf-8?B?N256a1Qwd2tKNmRPSHBOUVk2R1RVeUlsSU5aQnNKanV2L0V2OU9XaHlxUmVQ?=
 =?utf-8?B?cjVXM2RTKzlZbjdzdzFQZ01XdDZwZThaWldvWmJMa3BYbU05QjVzN3NBUTY3?=
 =?utf-8?B?OCtDdXAyYkhOUld0TXE1bDBLR3JLc0RNMWF4RXV0S1h4VjRRMTE0d1doSWFP?=
 =?utf-8?B?R1F0c1JZc3h6R3JBb1VjWFFRekdEaitRaW8xNEd1dk5BS1hMR2RZWHZIZTJK?=
 =?utf-8?B?NVVkV1lUTlNCSzR5YmtaMXd4SnFWUjlrOUhNYjkwUnpBemlSK2dkQjNmVmxR?=
 =?utf-8?B?TnBtdFpGdkliakJCM3ZTbkg2MmU5S0F1OUk2blFDb3Erck1FU1k3T0ZDT1NV?=
 =?utf-8?B?MUFEckhVZkMydDJyQVhyekNiQmE0eVlsVTNmTkoxcCs4SFVDN3JZcDc2T3pW?=
 =?utf-8?B?eTdXazBoMC9zYmxoVEoweHNBaU50N09McEhUR2pxMk1mZFVwWit1VGtWRnY1?=
 =?utf-8?B?NVRHS1JwcFg5RTAzQVJGU1l6TXY2NWl5ZVJndVhHSXV3bXU2bDM5bmZ0d3Vr?=
 =?utf-8?B?a1ZuR01BOHJ5L1lyeUZudmUrSkR6ZGYzR2pUUVkrM29OVFRLYStta1plRExN?=
 =?utf-8?B?eUJydEFEV0dINTM5c3J4THBvaEl3bjJpOTRmaEJIUkNJYXEvSTFFU2YzejBx?=
 =?utf-8?B?ZWZBWDVVdzNBZTlCSFc5cG9sY0c5NzVxSGZLUXdxZmROWTFUQkIvbDVBNWl4?=
 =?utf-8?B?UnliS21YVmZYYi93MWVYZDNmRzRJRmJhS294LzI4d3Z6eU1rZkE5R3hBSXdj?=
 =?utf-8?B?bkpBUHJmUzBENU8xaFo2dDliZHBkY3JuSzRNUlBpM3hLTFExdjRnM3kxMVpN?=
 =?utf-8?Q?YTw9Kq8mko3pr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR06MB9065.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDdJOUFQVDJDbzBrRVBhc0MzeWswVFpaRFpwYjBGanVrVFdpSG1xK29FUFFa?=
 =?utf-8?B?VlJSdVBFSk84K0xUTWZuelkyZ3R0aTlsM0ZTN0htZHBPTllaL2xsM3hpWXFj?=
 =?utf-8?B?My9ieDJ6T0FRNTlCZGpzMnRWVGRXVzg1cGtZODQ5MjBoU1YvYlEzOHpJRldi?=
 =?utf-8?B?d0tOUmpxM1BiaE1UeWx1NTc1RE00OWh3bG9qRmZyTGJwSTJtdjJyc0x1Qnhl?=
 =?utf-8?B?b1ZnaVlUdUpMWGM0Rk9jZUFVRTU0cUt1RmhLb0RBL1lFUCtYYWRJVVBMZkZD?=
 =?utf-8?B?andWNndZUnVVTlZJRkdQWmFCeVVlTGt0SENHUlhWcGpFN1Z2aGJTOFpTRTdV?=
 =?utf-8?B?RHcwc1VIVjJJTjN3SVRMYzB0ODJhUmVkQmVRSy9VUVpVODRQbmtsZSt6MSt6?=
 =?utf-8?B?djNHb1JaU2VYNmZCdjBVazI1ckRhOEtDSWhrV1BSbWpjd0FCRVdHNFdHb2ph?=
 =?utf-8?B?STZCcVBzSHZ1bVhaN05KWXBuWkdEdzdLeitrMkp6TlEyTUNFZUk5b2ZFcFZq?=
 =?utf-8?B?clZsQXVpWjl1a1I4M3hHcEtaMXh3YnE1bU9CWHBoS3FlRFd2VzJ3YTF4V0Vn?=
 =?utf-8?B?QlE5SHVUUVJuTzUxMTJlZU1RNkhLNExScW8yd3ROYzhJT1FiL1kyYWw1Z2xN?=
 =?utf-8?B?U3g5ZVpnWmUzUWowR2dxTUFkREUrZmd2ajlTajBFeWxZdEZrblF2Wjh5amZl?=
 =?utf-8?B?RVJvUVloaDlVZUpZY2NqTU1ZOEx2OEZhcEEzNmw4ZXQyY1puSjBsWk95MEZN?=
 =?utf-8?B?UXN4Q1ZpT1F5NWE5T2pTbGJZQU0zc1c5cUR4MU50MWpJUWdLL3F4TS9pRUhX?=
 =?utf-8?B?QXcyNDIwVHRxcWZLYUxsYXFtS1RTSk1NdktsN1JDK3VKNHhGRFBLak9SQWZP?=
 =?utf-8?B?cWZybnovWW04a21IRnpuaFJJeitzRE14SDNqY1dSTjJ1VnJ2bWhkMmZVb1Jm?=
 =?utf-8?B?ZFB5dGpnM011SjBueGhTNkN1R0xQMmFQSzczeWJ4WTNwYUczWjkxVFZ6VjFz?=
 =?utf-8?B?ZzFBbm13cTJEdXNBNjlJZlFqTVF3bkZlVHpxZkxvY0Rld1VqeVZmN2NNOTdE?=
 =?utf-8?B?OTB6NjcyK1Qxc1EwYmJGVjAxa3E0L1QzNEdEeEJiQi85VGk0QXB5RVBUY3hk?=
 =?utf-8?B?ZDBKeUxRUHFPQWFOcmNOZjZpbmtZTXN6SkNqeFJGV05WUFNBdkhpOEFDMVdk?=
 =?utf-8?B?TGpjWHVRSlBEUlVrVmVDUzFtVjczYms3Wkh6TmxYUlBwRlNKMStJTCs4eGgx?=
 =?utf-8?B?M0VrdnlrRytzMVhLZ1VhalUxNzNad0VKaEplMnFWdzlzMFp5d2hOVEpRbjE1?=
 =?utf-8?B?U21hVjVMeVBDSnVuRWhrU0dYejJEVDFCcWtxdHF1MUVGUlo2a2twT1VyaXlH?=
 =?utf-8?B?YW51enhxOVRacmtKeU1IL1NDNTZKRG80WjN1S1VWWk5QQ01hS08wd3J6dUtT?=
 =?utf-8?B?VkZYL2dkZGxZbnNXTUE5U3RmOTBUSHpNUWFQdUttVFFQb2RBdGNLZWFhVzhm?=
 =?utf-8?B?aU11MkdTek1TczJ2Tkg3aEpodlNGL0hBMVV3UHFxSlFEbi9CZUF6WWZTaDRM?=
 =?utf-8?B?cnFTY0pUVHJGRjFhY3JoRGFKaHFzVG52Ly93dUhMRDJhUXUrYlBjQkZqdElt?=
 =?utf-8?B?aHBxVFRidVFvVms5NzhHV3hzOGg0NHkxMzhzMUorV0JpS0FvSWZNT0N4TGlG?=
 =?utf-8?B?dmU4clVMdTJDcDd2VlN4ejlGdGJFenRwbmloUVRqQXdIVHRncldBVXdST1Bk?=
 =?utf-8?B?b1ZhaUtrWDZBc0M3OUZramVqRmhveG90YW5DeVhlZy81eWllVmhFN0FOVlBx?=
 =?utf-8?B?UEFmeVZkZTFWSU85TU1xRXpSWDJZZnQzQXZYWG45ODJiSHQ3S3VuOFBQdEkw?=
 =?utf-8?B?Rjd4RmVXMEdXdUFSTFdyS0RIZXdhT0hHUDJQNzBhRzFMU1FUYjY1ZWxLWlp3?=
 =?utf-8?B?RUxZR2RkcVBXV0gzczVvb1R5OGVlWFV0c0FGR3RuRnFxQ3VCbVRYUW9xZE1S?=
 =?utf-8?B?N1hHYzl3Tlg1OWFDUXNKdjN4TVhoUDhBc014ZmV5Qkc2anl0Nm1xSDFuRTky?=
 =?utf-8?B?ZktWTnovTEhpWjh4RzhPUWtjdFhJSjJtVzZHcUpxOVIwdzkrL0hPQmJBYzZY?=
 =?utf-8?B?NEV0UU1vYjlZNUVSbTRqYlBnWWZPRDdVYUFkeVZPZWF6U1RFbG1lemVjWS9Z?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4117e3a0-7f0a-4c1f-65ce-08dd3ab91e78
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB9065.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 07:48:11.3088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S0VaEMVCyiv7l7rzPF627QDPAGTWnNNMYzsJmhwZipjD+o2EydITmjWeZyVjnhYw2cd0TDb0YySw/ZGlQLNskRV/nVSB29yyopR3YFeOmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6729
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

Hi Michal,

On 2025-01-21 15:11, Michal Simek wrote:
> 
> 
> On 1/16/25 06:43, Tapio Reijonen wrote:
>> When Kconfig PHY_ETHERNET_ID is set, create external PHY using via
>> ethernet-phy-id driver to support using starpping resistors
> 
> typo.

starpping -> strapping

> 
>> of the external PHY.
>>
>> Fixes: commit a744a284e354  ("net: phy: Add support for ethernet-phy-id with gpio reset")
> 
> Not correct format.
> 
> Please look at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n145

Fixing format in next version.

> 
> 
> 
>> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
>> ---
>>
>>   drivers/net/phy/xilinx_gmii2rgmii.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
>> index e44b7b75bd5..1d6d204b228 100644
>> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
>> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
>> @@ -18,7 +18,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>   static int xilinxgmiitorgmii_config(struct phy_device *phydev)
>>   {
>>       ofnode node = phy_get_ofnode(phydev);
>> -    struct phy_device *ext_phydev;
>> +    struct phy_device *ext_phydev = NULL;
>>       struct ofnode_phandle_args phandle;
>>       int ext_phyaddr = -1;
>>       int ret;
>> @@ -40,8 +40,13 @@ static int xilinxgmiitorgmii_config(struct phy_device *phydev)
>>           return ret;
>>         ext_phyaddr = ofnode_read_u32_default(phandle.node, "reg", -1);
>> -    ext_phydev = phy_find_by_mask(phydev->bus,
>> -                      1 << ext_phyaddr);
>> +
>> +    if (IS_ENABLED(CONFIG_PHY_ETHERNET_ID))
>> +        ext_phydev = phy_connect_phy_id(phydev->bus, phydev->dev, ext_phyaddr);
> 
> Can you please stay inside 80 chars per line?

Fixing inside 80 chars per line.

> 
>> +
>> +    if (!ext_phydev)
>> +        ext_phydev = phy_find_by_mask(phydev->bus,
>> +                          1 << ext_phyaddr);
>>       if (!ext_phydev) {
>>           printf("%s, No external phy device found\n", __func__);
>>           return -EINVAL;
> 
> The rest looks good to me.
> 

Thanks,
Tapio

> Thanks,
> Michal
