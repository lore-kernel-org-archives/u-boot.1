Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318CCC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 17:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7177484A52;
	Tue, 30 Jun 2026 19:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="T9wqr/SK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C0B84AC0; Tue, 30 Jun 2026 19:40:57 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD1CF84A3C
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 19:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0oUJdFd/Sa7yvgKn52v2H5uyOQVu3SXHfMOVVKdNvxx2xSEL2XJsEJ57M6yGEJWI9xbcfgWV9CJWCAXtD6JsTqRS/Ra7BlB/6UHvBHW/znEHiDwg+VFd2Y9ouVvxIoZq1nLrRmAOmFnvuP1l9v0MGI2IueBos6LSd6w3lFdiWvSFBZ8snBgDZYY2wKYCrjQyA+CZhwx/4Bm+wddQDwjmr9jBJeS9976qNvNQMALjLP5ElZkujw+4r0oUfwQttAyytpYLVj6VEtKpdXFd9dABVbB7XsgT9NVZKkAzyhckmS2IzbcI2mA+XH6TNCdarVg6TSErdWqPGmip8/pRHikcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DSvxn4MKdkog0NeBQk0AFWn2GtEbL0k0m2fvdzfbcs=;
 b=wpMpGq3rZ1oy4bHFAEuoluqaLqnTuteQr6Fj6oEN2GOT9LIkdQobdcd6qNj7hMjvvD6ebsCGSKZ7CI0u6Izt5U0ldFIW4mZds1kbpk63av5a5f060dwj71NT/hupCT61SqIyRFIy7uYut2MchgbxBS1yCj8o+Igl7NgqppmX2PcZLz2YFnqIfeveI7xrXUcn+hfGFHPyKxYR6J4moznyabvr2ObQMu7BhjZjke6azsbowHudtWm7qFzHe7gE2jF/wtivDXzR6FKlaZ6VWj6/vqyObl/1FL/uaON4om56ZKuUjx/Gruy0cDF1oPxLYE0CHv+a3cGhQxOJxrYjSD0peQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DSvxn4MKdkog0NeBQk0AFWn2GtEbL0k0m2fvdzfbcs=;
 b=T9wqr/SKphG3/SB7riTjQRvyyv2u0y+9eWLYCcbBztQxMKF4GAWaFmeWydXnULzSktCGUOzpBcv1IOxr22zsNnFLQrcxzWPjyV5CjNlbASVMkoIkGGpivyfZPZ3OFH4ZyG0VeLgGor1UI+joqWtcKosURb8q0jHbaKUjfwbE1G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB11627.eurprd04.prod.outlook.com (2603:10a6:10:60c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 17:40:53 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 17:40:53 +0000
Message-ID: <93681631-c365-4733-b057-162b22d658de@cherry.de>
Date: Tue, 30 Jun 2026 19:40:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: doc: fix typo evb-rk3288-rk808_defconfig
To: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <d0f7ce27-ad87-4910-be25-e867b5af4956@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d0f7ce27-ad87-4910-be25-e867b5af4956@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0055.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::44) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB11627:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6787ee-4e58-4b1f-9d6d-08ded6cebbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: lOmJwrm0rFCX0846pR+uRnk7cvM/SxRbhngcug0KONbMAjnLf1ldaaAWeKZF9r/ZX5aqMf10NrjnbZc1qUOIhaCZ2ChwCBcaJkl6v31TjsGBkDkulx4kvLbNoKm5wrwPFem9TvTc6lyHrhrDHeQS+ZzL2Cjcib4N8O0fAihm5JWbs9hJPgacJ+eImAZMnB6Ccb10NWIOsot+T7p99awUpjkR5eHVWvhLay30BrFTE+6BPy/Ye5AqZa2WTKkck+LshNB+nYFv+PNhxnZwNMJ0wF3VCRPf/vzk5RyUD/LSE/OKtgF3dxTxLYaS3XDwcv7FljLYvJOGWRDj5P096spkwiRSZTLMhafkf+5WyzcXVyhT5R6uyGNLUbHFnEXq/Yc1ZJUv1dU6bBCM7FmEzxFFfPy9YJFvbDCYZmyG8RItzAjj4kQhzigiqsymGkD+tjuP4oBjqB7jR56MM/XZWnYDDV3YfMd/r7Zl7Eoy+Y5YRDaq400m3TMyIfeK6QvbK9yb5tnxPqRU1m6APJ73kZvYM08hBDXaJUEKK0L/LpBMq4GXz7CY9miXNUGVV1KFVsqN6jtFEzBGx2GaJ+Bgcf5CohplSdVZRLQMHe5I7FepgcpdAQ++kLMM/ZVGuSFrfgrk4o4F05KnUry3USQEZdH2ExuxIPt3g8S6aSS+DVqfuxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dIV0FDanAzSkRSeXRxT0p5NTk5OC85bW9QTUJEK3Z4R2VvOXNCVnlKTHh5?=
 =?utf-8?B?cGI4cXVuNkVMM3EwNHZqN2VjYWhXdE5IWE5CaGw5K0JWOUhLTFFlK2pPZjdn?=
 =?utf-8?B?V1NaaXZqSFVTYnVSRE04NlBNRVJtT3ZydDVMVUVBemxYVHBoRTRaZ0ZXa2F4?=
 =?utf-8?B?eTUva2VhZXdKWWlHRW5Db2diVGFZWFVNeWFERVlLMENaRzhvVzdOdGFWMzRC?=
 =?utf-8?B?akVNUjNtbmJSZHY3dEFSTytwTVdZMWY5b3UvaU5yS1pNZml0eFhrRE9ZUFNm?=
 =?utf-8?B?cWNzS2VGa0JNQTlvZENWRGRYcEJWZ3V0V3VIbGU1ODdaTWdxOUMyK2U1MWhG?=
 =?utf-8?B?a2FvRXI5QmJvVDNQYitvWFM0c0hyb05yWWhDTnNob3BVZFREYUVoRUN2NnVi?=
 =?utf-8?B?dy9GOU5HV05WZFRkUXAzMTd5dWl6RjA2bmZlb0xlcXkwcjZ5QUYxaVh4Ryt0?=
 =?utf-8?B?TG9pVW9lOWlCb3VnSnNmVm9rUUVEWlNUTXBieHBiUzJnS0J5dXpSdTQ2MDhW?=
 =?utf-8?B?SnFIZXJPVW5FVVZFb1Y5RE1JaS90LzJmc0N6Y0Zrejg4Z1ZXVEh5R1RVa0hx?=
 =?utf-8?B?My81YmdCbHAwaysxS2xRZkFnOWpRYndtMmZEbmowOHdWRktYZXhNdE1lWDVr?=
 =?utf-8?B?OE1yUjIvdHlmcFVhQzd6U1kydDduL2xCM2FnN3FDQjB3OWkzK0RkdTMwb0lQ?=
 =?utf-8?B?aVM3RXpvd0dlOVcySktpTmpYaWVGQVQ2dHF1K3FuSDdGSkk3M0xmRVNRTUQ2?=
 =?utf-8?B?NUNLUDJ3TnBuSEp4dVFVdG1FOEREa2JSdWFWREVlV0V0WGhPWitPaDVCYnFi?=
 =?utf-8?B?ZEhRdGhlc3VpWUN6L1A0OGsySlQ5Uy9RS09IdzhFWFlSSTJUcFBRaHZtUmx0?=
 =?utf-8?B?M3cvU1h5amJQMTFoREFoa1hBNUhhMkJjL2dHanpMOGpxbVBaVmI0bjI3THUz?=
 =?utf-8?B?SjE1bWRWSTk5bTNtY2tkZEhSSDhWMW5OazhHSzRFK0srbzAzL2lsMzh1NSs4?=
 =?utf-8?B?N3hqd3lYcWczek5SRnlxRjNXRUJIRG1YeVczN0tIUE1wdWU5b1phRDJjZngx?=
 =?utf-8?B?WHpzL2ZpaWQwUlNEYSt4QjJjc1lCTWJmTExGcUY3WDZpOW5aWERUbFZUUys5?=
 =?utf-8?B?Z2JJNnBNWU5BWEozZm9TWVoxcFNoQVpJZndPZzVQWWNVSWlTUGZ3QTQvb3pH?=
 =?utf-8?B?SlRpRlJSc08wY0ZldW9MQzRvK2lZb2lQRmRvemNiNFdKR25XU0swdmEzemEr?=
 =?utf-8?B?RUJzQldBMUZlSWNNbXI5RjBEaEsyaUlvQXlwNWxqczNJcG8wWlY3K29oaWJ2?=
 =?utf-8?B?cWJ1ODBZdmwvNm9TM3BuTW9HcTlMcXMwTFdISEhhZHpEbWtYemhaa0xSeU9W?=
 =?utf-8?B?WmZ5ZVB4Wk03MXVqb2NWZ3hFZXNmQjZCN0RvMjNHVWNHVFdKTENaMmpqNFBC?=
 =?utf-8?B?TTRtaHBrTEpvQkM2QVRIdFFrYVJtcmY4TFhYWkQ3VTc5R2hIdlZWaWlUYTJG?=
 =?utf-8?B?eExlNVhrK3NCYmRVQjVwNWRDTk5jTFhlRCsvVHZTV3hIQlQzejRkejlMRUcz?=
 =?utf-8?B?eDIzQ0RTZ3N6RE9LdXJldmdqSmg2b09LMkF4VHlSNFJGSE8vVkJHWkw3a3Ri?=
 =?utf-8?B?YTd4QkEzV2lOVk1rdTR1Njh2c0FLM0toWGY1bWpXb1pYcXc4cGx0YVlidkpJ?=
 =?utf-8?B?ZzNkRkhsb1NwTlpRekhDc0NDRXJnZGFlOEVyQ0FlRFVQVVl5RDVYL3V2TmVl?=
 =?utf-8?B?aCtyRnhBcGJLMnlXaThDZjJXOGlEaTI3bHkrK3RrdjJ1cUExcU9JbHFGVnk0?=
 =?utf-8?B?S2EwSGhXZWlxS2h1RDJxWklXbzU4UDFpcHFrKzhVVDdlam5QemxSb3ZRaFZy?=
 =?utf-8?B?ZGgrMmpodmhnTFA2eVZvREtiMms3SlVJeWYwWUxBOGxVTm8veUNWdzl1SnZO?=
 =?utf-8?B?RUZjYTlsekdsRzdOdWFvdnA4Tk1xUk5VU0piNzM0c2xGQUdQMnUrTC9RM2J0?=
 =?utf-8?B?eGNwN2hKMDYwRTRsT0VkS1hXbU5LV3lMU2FLamsrMFRTdXdVaFlUQXBlZ0dh?=
 =?utf-8?B?UkorTGt1T2I5dkxEalFuMnZHYU9Vb1BaVkgrVVUyWlNpazhxU3daQ2lqM1BO?=
 =?utf-8?B?dTRKTS9rcjVnOWdqY3lDMVNWejYrNEFRUk03WHpRNlQ5MEZlbW5hbG9leWND?=
 =?utf-8?B?eGgvZCtFNU0wK2U1elNlSTkxSis3V3U2RkpFa2VNaDhaekJweHhNK0dXZi9M?=
 =?utf-8?B?V2FpQjBsVUhZVVBoOEJJVWRjOUNIbTlWb3RmUjMySUFpZyszcWNxM0YvUjdS?=
 =?utf-8?B?ODZkMmE4VndZTFB4UFJqK1l1djJHaU1KSEVuSHZRSlpvZHV0ZDVQZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6787ee-4e58-4b1f-9d6d-08ded6cebbb6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 17:40:53.6988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Js98ku64NdMzNwdxJss+0HfIamfcDayWRl2umrIUbRtx7o6sFZ70eQT7K4mhIxQvHsLBphbO3nceU4Dpb4ctRIoMb89UQRdkLysIZK6TMuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11627
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

Hi Johan,

On 6/30/26 4:01 PM, Johan Jonker wrote:
> Use correct defconfig name for evb-rk3288-rk808.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
