Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E05CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7302383020;
	Mon, 11 Aug 2025 17:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AcXu8ALP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E591483093; Mon, 11 Aug 2025 17:44:56 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA04682F8F
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcdRjUHW+mDoxt1KeuJnH7Kgz1FHNVBeaEKtDCp9tLbOyhfdInj/+hR9WlwFUui2mCwBlap0YIT/LTqUwrbFtboWrIi1ZN6m3OlBPPe8fiwAUwAgVRlAcRv+m1Fgj4Mzh02uJw2Ni2vC6Iqx0yzTYLGkMM/wE4aV7QX7SK5ZV4KFQRmu3azpFj1k/9yNqUj2sBQCON8ak70FsYGiZeKfEYXwSy9GRJRx7TBIHRkzb5/1DkQdFfC2iCbJWGWXH1sTCyJqWY85iwO19/Sv/TWf5p2jOzEEHeDcou5/uJdJYZQ/MRGUIx/WYRG9VySR19gWbyNeEfb0dJX7egTuF827Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTVZaoFOjmoIhluD+oH7xeu+OAnWHBffHaA801ZdC7s=;
 b=UwxT7pKp4dtw0nPsa1+nB8dcTfNzxFMLE8KkiK4EFImk1S7fd2XjqCdhMt2/w3eQbJNuqsNOe6HxR2T128P2AOJwAPWaGzz5KsN2rXBPlq5Lbhhqj43ZJq01DuGRJHv1+1knzySfBIUBKV6YZBU3QiqCCByToBnpXyO6YfeZn8tw/XWdvxGegUycnQ5vHVpAFikO0tcXkmx1/TY8nUQ1Vu6Kv7bK3mP0mgWPS7oUQLNrr6qSYMcQ0DiNJ/lozYAg3oodh/r3Yk/nH7MruKA4N3fqRmf3+yogi0u7NOwVhpPwo8Y6CT7ZQ/bGcGE0p0oJj89GTkir6Pf45CiSdwRtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTVZaoFOjmoIhluD+oH7xeu+OAnWHBffHaA801ZdC7s=;
 b=AcXu8ALPGJsDnhB3p8tynCBcCAR5QklSt85atjndfPq37gaLqJxs8FFUyoW3qkA/C2h3TvJ+++go2j8QFHBcd2BJ3+BV8gfYP7FKxMWpLLBJCdkF8SA34a1cOwW6Rk43HAKejwFiVu8NxFXEeegLXVgf+oLveZiWfW9OqdaRacM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 15:44:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 15:44:52 +0000
Message-ID: <1b1ad33a-3004-480d-9d32-3ea05e7eaf63@cherry.de>
Date: Mon, 11 Aug 2025 17:44:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250810222644.4095072-1-jonas@kwiboo.se>
 <20250810222644.4095072-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250810222644.4095072-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: a009be0c-f92e-4c32-421d-08ddd8ee0358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU5GZGlxN2RFNVZ1cy9xa3ZzUVBrWEo5ZGZmOXlnZFNueVdZWWwvc0p3MFV1?=
 =?utf-8?B?TlVLczI4UHVyNlEzMFNRSzBWc01SL2hrWGxORi9uQWt5VmdvYnQ5emtKdlFk?=
 =?utf-8?B?ZjcwRk5CU0dxMHY2MU5SaFhSV1ZwZmphU0cvL0NkS2tGZEZxNXIxeHhEdEs0?=
 =?utf-8?B?dFJ1R2JxUHJLazgxVTFHQmMxVzFqcTllVXRjenpqSFIydnc4aUtOVGlJZExB?=
 =?utf-8?B?azJFbTFFRXk4ZlFiQ2M1dk1qelRCSDgrVm8xVlMvNEd0bFJzK29Hb1BmZHVr?=
 =?utf-8?B?eG5pS0NjV2Y5RWZpcUNVdThhWWQ4M1VtYmZSaHJIb0NxaW9ueFdvT29yVEtV?=
 =?utf-8?B?U2ZLTVBTc2dNeDJsZlpKS1VBVkYrd1p1K3RhMzNEMmZQVjZlS1FXQXVjRDll?=
 =?utf-8?B?YWRDMnh4K3RwaTJBZEpHVmk2VEsvT0lDdDdCN1R6M29NVFZJK0pOV0dzWXZG?=
 =?utf-8?B?N09UY3pVRSttZTRkUFFXMy9uVXloeFdXSUpqdE1YRUVncU9vRE90d1BhYkRy?=
 =?utf-8?B?dlVxbktnNlQvVnRHQXJDdzNlMGpLbUxGR3J4QjhLdlFTTUpKN21yclVwMzVo?=
 =?utf-8?B?NmZhdjJIM21ZeFVyalh1d2NaelhPeTIvSEd0RWt5NTl5eGpWZTdoUE02TW0v?=
 =?utf-8?B?WVlGaFFRcXdpUEJtWlQyZXUxT1dwMEFFZTNEWFhldXhHb2xSZEd5MThCMzJp?=
 =?utf-8?B?MVJIUlRVclVuWDNGWGVtNDFkQzdVOVVQQW00aW5iQmdSbEY4RldnSHRFN3N2?=
 =?utf-8?B?cUY1VVVscXVGTVRrZkpsblNjclFKN3ZVemNBNkZEaUhmTWVOL2ROQTd0ZVov?=
 =?utf-8?B?cXRrb00rVWpzMDlFdEVxa01GVTdqOXB5ekVQRjl4VGN0cHRqWWhtTEFQemh6?=
 =?utf-8?B?N1E0R2hZYkowTnNoa2lKbUJMSjFweFdjOXBUMFFZZzRsTzBNK1hVS1dZd1pK?=
 =?utf-8?B?dUhHMkh4TUxTbTFyL1ppSTcvUWRVTFg0NjY5RW1OM0pZT0EraGhoeWJ5VWg3?=
 =?utf-8?B?ZTJ0OGtpVFBPNWorcGVjbUFJNWNWcHlaNVJIcmJoUWc4WTNmSlFWOGVoU2l6?=
 =?utf-8?B?MWtiY08ySlR5TGNVbTlOUUdTWXgzT1AwTlp6eXNvT0l3a1BqNVN6RS9OMGVj?=
 =?utf-8?B?ZTRXS0tWTHJYbDlkdzlxRHYzM2VsMW13TnR2R0dXYjZ3OVJhbm04SUl5ajIz?=
 =?utf-8?B?NUo0WVJ0T3dKbUhnMk5JTkk3RGlERzBZbzUyamR1cnpMb0ZPanQ2SzF1TTUr?=
 =?utf-8?B?d05LWHY1MnlOamhkR1ZzdXo0OHFWMUFxZTQyRzRyMllZMjNURHpxMm1ZMGJr?=
 =?utf-8?B?azYwZG5QSS9aazZwQnl4VG5kOXFKMjljek5XVnpLVHR4NlgwT3hFTDB0K1BD?=
 =?utf-8?B?OGJidlpxWHVOVmVvL29ma2IramM0aSthSzJhTE5SZEJ0eXdhd21DaFJSMDRL?=
 =?utf-8?B?YVZGKzFsQitJbFMxR04yWk80SUFlNFdtY0pqZXJJT3c5b3I0VDMyMUsxWDIw?=
 =?utf-8?B?K1FzdC9LdmxoTEVySENLSVNidU9KaERDdTNqM3ZzRVZZOCtQWVdNQ0grWDIr?=
 =?utf-8?B?MXloSmRQYURtNnFseUs0SlNoNHVkYmt0ajUvdVVqcGZPekhuNVFISnFrVjZ0?=
 =?utf-8?B?eFl4U0hGRTlLYU9LdVJEaGRaaFQ3eVZQTXFDYUMrWUt0SmFtWitDenBBVERp?=
 =?utf-8?B?dFBWLysrTWYrMkl6NE5DVlg2c2tPSmJSU2I0bUl3N1AwQWtVMFlnOG1vL2FJ?=
 =?utf-8?B?azJwUGEyMlIyenVGY1NZSngxOUtuOEZ5Q2VFeXI1Q3VrSXYyY1o0VUxpbmZ5?=
 =?utf-8?B?WWNVQng3aWZqaFlqUkhFaHNNVVVtNmVPSTBEMEJHaUhyZnBZWVBodlNKNkNW?=
 =?utf-8?B?NzZOczBWamVVa2pvQlZBTHYwWDFHR1F4K0xMZVdvVjNneFFSZlZDUytFcEVR?=
 =?utf-8?Q?QycmCW8TzYE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SndYMmg5RDlpb3d4UkNvSTFVWWxUcU5UZFJlcGpLaHNCVHp1aXVYOWxtclF2?=
 =?utf-8?B?Z2VQeHora0hsNGZZSkVJcFl4a3kraStlS1RnTDBHbWNxVWdjTW1rU2N5OTVr?=
 =?utf-8?B?Y2ZLQ0RSNTBHdEZEOUtQc1A0RWtPL3BadXJyNGhGYk0rSVdjOFppNEFydkZC?=
 =?utf-8?B?OVhzbXlWZDNsRW5CYUkxRWVDWHRhN08rNzBrMk53VnYwdEE1d2psZnUwaDR5?=
 =?utf-8?B?c2xaNlZFYnRCUXVYdkNpOE9WK0diT1FtclptaklWRGRTcy83TVZySTM5QVdm?=
 =?utf-8?B?QkxIa2hFaFkxN2s0YzZFWHhOdi80bEtUcysxcENaN2tIVXVTWVZkNEwzNEpp?=
 =?utf-8?B?aXNLMDVGZEVZdml3aXhKd1ZRQXdoU3hDTHlSa3JYbkNiN005cjBkSUZlZVB4?=
 =?utf-8?B?WEVocFdlaHptSnBHV2I4cHFMZlBUV3I2S2t0OW9KdHN4a2xMMGIzd3hHZ29w?=
 =?utf-8?B?MitxN3ZwR3N3VVR4QjFmZE5yQi9QOG1yekcwdUV4eERXMWZMSFJTS0xEcTNj?=
 =?utf-8?B?eE82eU9DU0FJYUJ3Tlp2RzdiVHJlT2lQYjlWMCt3U1gxTWoyWXpuM205Ri8z?=
 =?utf-8?B?emI3OWVWeU4wNnlodEMzc2NsL0FrZEZDcDkwNG43ajQ0N3dwdnMzMXZXbTVa?=
 =?utf-8?B?K2llcGczeDU3dmFTY05URmwwR0dpRjJzcWVkUmlNRTBZWGdjWGFsdGQ5YVV3?=
 =?utf-8?B?WVVyczlUSytLNW9VUzBqQUtHK3h2UlFLVmRDbkhSR2EzYkdOc2JYUFhFVlZF?=
 =?utf-8?B?TDBVUHZSWnJJY3c2cUo2a3g5c0pkVWRsaVV1RzVLWU5oMnYwYnFvWTY5OVo3?=
 =?utf-8?B?MnVyOHlCMFZJcXFLN3c5OE9CcXo1Zy9teXV6SDRhOUhLU3dxcDhyZTRlMjBS?=
 =?utf-8?B?aktyMndCanl1OHVDMjNOY2Z3VVhnSWxFd21ncDloSUJXVFVMRHJ6cmoreDdt?=
 =?utf-8?B?S0NBMzVGR3hqL2hDTGFXMlZ4aTBqUkwrOWhvWmVUMkFJSTdIS1ZRQm82UmV6?=
 =?utf-8?B?bGFvbk82RnZDdEhaQW1HNFBscDRNTzQ5ODdQVHQ3SnZROWxGYlhZTmJkSDZ6?=
 =?utf-8?B?dEx0dkRLZTdoSFdOTHAxZUtzdVV4T3RrWFlYMmVqc04vZHJkdnVFNVAraFdy?=
 =?utf-8?B?bGNyTDVnNzlKeUFCenR5eWZkNlY3NWF1SGN4a0lKMm5YQ25pbmd5WnhBejdZ?=
 =?utf-8?B?VmRVZFZndVBMY3V1QUt1WXU5cjMrNlpGREZnZ3VBTlJER1NaOUpwM1M1elZM?=
 =?utf-8?B?dEdXN0Rrb0NZMXBKTHhFL3J6dEsxRlNSeDV1TG1mMkdablF4YkQ5V2RLQlNk?=
 =?utf-8?B?Uzk4Zm0zSXZ5SjZxNmtkQmQ1VVJRQ1NMZ1hYR3U1empMNWg3NTBFZGIweThl?=
 =?utf-8?B?Ui96d2t4VnZhNjMrZ1ZhWDIxTTZPemgyNTl1Tmt1bW53NjBnS2ZQZFJ2Tmt3?=
 =?utf-8?B?SXowMERqZUJqbjluS3hWM29UbUxLa3QvMlNNRjF2N2daWUFNMnFUMUdHNkZ5?=
 =?utf-8?B?NmYwRWp1K05oTVBBdisreCtodDhnend5R2hYL1cxQzFNcERtdExLdis3c2dt?=
 =?utf-8?B?MUsrYVNHYVFPS2xzL1RVcERMMGlob3FrbG84VzR4Vkkzd3dDUzl6WFBBdjVZ?=
 =?utf-8?B?NUtFbGRTMkpGc1lTVXVXN204MVZkYkUxbXpPYnU0cHZMbHgvOVhNZXoyZ0NM?=
 =?utf-8?B?UTczUkh4NjNMcEpza1U2eHJNUjVmUkIwb01LdlEya2RDRm1sbC9ySTlmcC85?=
 =?utf-8?B?RGpSRkxCYlduNGQxSnRsNUxSQnFTSVQ3d2R4NzBEZmFvSVMvem94bFA4NjNK?=
 =?utf-8?B?QmFGR05WQjhJY1JVSlBUZE1Xdkh5RjNKc0NqS3hrdXU0Yzk4TkgyVFdKbVZo?=
 =?utf-8?B?UjBnS3FGU3RZcEIvQ2hsRnFtZGtFRzFJTVQ4TVNIWVZWRFQ2NGhURmE1SStI?=
 =?utf-8?B?L2Y3N2h4RS9PQlFWUnJkd2MwWGU0WFdIellNWjNlV3pZNGlDT2VkR1BramtT?=
 =?utf-8?B?S1JZSHVBb1ZGVmlLRzF4cHo4T1AwYUt0M0V0YllHWWRpVnNRTllzbS8xSlh0?=
 =?utf-8?B?aXk3SmY1SC8zYjg3L1hxbW5FOHNNUU9SR0tXYXNScCtFU1FtMko2ODRURHFR?=
 =?utf-8?B?TU1zbXdlc2lNdEtrK3JEYzQxaHNKSzlIT0NLNDFnN2tmSC9wai9KUHRHbU5M?=
 =?utf-8?B?NGFPcU1YRmJiYW4reFVSYitWeDUrZ2hORlphVFpXait0bWx0SHJ0M0JvekpN?=
 =?utf-8?B?czhuUGxhY1E1a3NRN08vWnQrRVN3PT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a009be0c-f92e-4c32-421d-08ddd8ee0358
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:44:52.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+Y9nif/PZ2a3eBDqPBmvfdaJb/waT+q5hup/q+Z04/DZq7e0EMcKNCj5sTBRpqVQfyP1hRmpyOKtOuyhDWlr/oamhqpcHAoLab7hZVoMJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384
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

Hi Jonas,

On 8/11/25 12:26 AM, Jonas Karlman wrote:
> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
> What blocks are disabled/non-working is indicated by ip-state in OTP.
> 
> This add initial support for RK3582 by using ft_system_setup() to mark
> any cpu and/or vdec/venc node with status=fail as indicated by ip-state.
> 
> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
> cores and one vdec/venc core is always failed/disabled.
> 
> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
> the required DT fixups for RK3582 board variants.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v3:
> - Apply same policy for RK3582/RK3583 to match vendor U-Boot
>    linux-6.1-stan-rkr6 tag, allow use of the GPU and one vdec core.

Isn't the GPU supposed to be possibly non-fonctional on RK3582/RK3583? 
If we don't disable it in the DT, how will the system actually behave?

@Kever may have more official info on that?

See remarks on v2 otherwise, most of them still apply.

> - Update rkvdec node name to match latest mainling Linux DT patches.

Should we rather wait for the patches to be actually merged before 
trying to patch the device tree nodes that do not exist yet?

Cheers,
Quentin
