Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6F5D5CCA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFF688C05;
	Wed, 30 Oct 2024 14:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BYpC5MWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC0C88FCB; Wed, 30 Oct 2024 14:14:00 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E0188BB7
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcVuO2Zr5eDOz6Ld9SC0esz63aE7lxsgcp4z7+r6R3V65AwUnMxUGksaJkp95S/A9b8LvFPUBMLV3ZKcgGW3F5ecC/W6Fs/faaiqt3mOdcIM1gAIEiwPSHJnBrW+sLMzE3gQ6xorwa5B2glkZtUHPw2l3t8G5yYvNdpfqhWSSDGAL6dGgnf5fd2On7Rdjg6ZzugpQs9LApeyyDmcDULJfpquAu3DnUa3Vu2AUDPxvnT6Bj8qGASndIsXTF7GeBReyRwiOVgoBltgEMCrYHVZ7jfKPYjcYrSpjpPsREoLb6N8+ZFUUyQuuxCofP6b/8rivBUcnM5pgSS8OModKw8mtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3roik49/V73+fnJXWaAiAS63lTNuwGNaNMNcIuNelw=;
 b=T8Dk9USfRVZdyrBHh3rdTVGM6z9mfgblEfPKZJr5eXYKS4K9tbb/cY30SEWftzmnXeYA9/73pnnFMft4iqWAC4/CwQnR3uwXHdm1jBtGfdS9p0A7VvkgOfpz3r6v8f+GbXS5ucWOC3midhCQ9kj21KaMCN5aNMgqHVqW0aObGXZLmeUZpvUxVgawG9UgCiOosuNHpsp7NF7YyXslNRxO/h5x2/ww7bBr80MRmZKA9Q53PjuWHhxDL1KeonREM4PXnicsdmc6L8j4OtGBxkJWFIpFXI7YhrWZCRu618fpx3ewBIhid/o6dGbroEFoEoEEhHQXlUoMsArT2OWF1rIuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3roik49/V73+fnJXWaAiAS63lTNuwGNaNMNcIuNelw=;
 b=BYpC5MWB7FokuE9Dpnn5PS3kAgnoZOUh6BflvfnIeqsUcnXBW9mSU4w7om3Q6Urc3Tvo9MfUcoM+XH9RHH06RYS73OUE1zFaOImpYBDXavPqZajIyJQZyjZ9cKuPRF/wFxKhBxpKJnAcLbkAZd8YJMakLbivjXU2Rorx01+nO4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 13:13:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 13:13:47 +0000
Message-ID: <c6ad234b-e756-4ea3-8381-63ffca1c2c5c@amd.com>
Date: Wed, 30 Oct 2024 14:13:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de, sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20241029185814.7937-1-vassilisamir@gmail.com>
 <20241029185814.7937-2-vassilisamir@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241029185814.7937-2-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbb4caa-c295-495f-72f6-08dcf8e4b018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0VVdDdvK2FxZ2gzSGtDdk5EVnNWdUFtakhLQmViQWxJeE9SbDJ5elpiVUFm?=
 =?utf-8?B?bUJhQlZlaWowS2xvS0dHbVF0ZDdaWHRuczJVcWF1cFBPTjNMRDFzTndLendk?=
 =?utf-8?B?R1lkUEJQUFJmWlR1ek9rLzk2VHByVklETTk1UmcxWFN0MkRQWmNZZEtvYzJ2?=
 =?utf-8?B?RWNoMG5UVXJjZkF2czZkTWNleHBGWFU1V05lTVZ1Q3YvWm91ZGliTVpHcXdE?=
 =?utf-8?B?a09wUEFWNFRZUVlWY0FaaWZtOWI1UHVrTEtKdVNpbkw5TUxTS1JjTDBvMnlO?=
 =?utf-8?B?V0FSUjJvZWJpWGw5aGxtTWlCRFVRZSs2R1kzZ1JXMWRxbXI2TXZmUmRyZW5S?=
 =?utf-8?B?cWZibXN5Rk9odmFKeTY1SVIwcm50YlNzbEp5M1A1UTBQamEyM2RicFV6Ulg5?=
 =?utf-8?B?WjFOckJ0R1RRcis1aVExUDJHNmZOWC80eDdIMGJ2SlduTUZCNDlkZHg3cC9r?=
 =?utf-8?B?MUpBYVQ0Yi8xZlJhcUdmRnNjVUJ2SXZEUEdQVkt3U1djclVTWDRsNEIwNzUy?=
 =?utf-8?B?UC9vRmhueUtVdTJtU0FYb2Qwd0VyVDJ3VVNSdjFrT0cxTnBuYzdnUG1GU2J3?=
 =?utf-8?B?bUtXQVAxVVVlNXBxekhKR3ViM2NIaERtR1EyMTZSTDhzdDJkTVRjR3FGZnF6?=
 =?utf-8?B?aVc1cEVVQk1zSS9SeW41ZzhFZXlyc21LMzVhbi9rV2N0dFNDbTdEMFJnU29Y?=
 =?utf-8?B?TStIbEhRaXNWVlZrc3k5d2kyN2JIeVR4YWhSUVVrZlVjZkZ4UWhROGR0OGpM?=
 =?utf-8?B?ZlpDTmZ2SnFEK1NWb1o0VVhoUk53MFA0bTI2YmFqU1F6bHBOZVl4KzQrTjV3?=
 =?utf-8?B?eURwRGJvOXlWc3puazVjaUpXYkFzSDZDMFRiNjdyVlNZVS93Q0FXWW1LdVdm?=
 =?utf-8?B?SVplTGRwTjc2aWhtblBLTTdTcFJvS0hFV1lENGlwQk1sVHVZZTI3cnRDYWNh?=
 =?utf-8?B?VlpzWTBWbUZzZng5eUZIWHRRN1lxRG50N2cwSUZNZk0ycXpSUWtPNEFFN3Ex?=
 =?utf-8?B?ek5nSk9mRGkzN2xiVTl6WHdyRlNqcXVmQ3NjMkNuTjBORGtCK3RDbkZta0RE?=
 =?utf-8?B?SkJtM2xZNmVQQkVWTUYxSE5RWlBFOHRtRzErajdnWm1nZ2NJTzNNWTZVOVJE?=
 =?utf-8?B?VW82Wlp5cW9pYk9pK1VyT2JJZG5QakNmY1JuZVpMUVg0N2IwV0ZNSU12Yllp?=
 =?utf-8?B?NGdJSnRhUnorUWdUMTROOUwxbis2cldKSm04c2dVaTU0WnY0WHdSbEU0cnFu?=
 =?utf-8?B?emRWMXdybVNoL1BjOXBSek5CemZVR0ZUMzQ4ZUhhZUsvSnU5NzA3ekg5YnZh?=
 =?utf-8?B?YUZpaE1BcXZNbWpnNGVFZURnWVZKQytWSzkzeFRETFh5RXlGejBIRC9CaHB0?=
 =?utf-8?B?d2d5RG5vcENZZS9JVTI1bVN0dW5RbExyc0hiTnh2RFVEMFZuTDV0MWJEREM0?=
 =?utf-8?B?ZDYxNDZVMzhSaE1neXZYS1lUblFzUVhpdFp5Ylc2UzNpTllZU0tNY2RWUVo5?=
 =?utf-8?B?SEJtSHBZaGhXWk8yTUcyRWM0MWdsaXVQcnEwZWFhWEhRY3dTL2JyT2p3bitY?=
 =?utf-8?B?SjBUaXRWM0VCbmw0WU9DTHNwL0xGZWE2UllCbHFpbWYrRERaeUlsZ1FCT2I0?=
 =?utf-8?B?bFZ0MHV0K1VBa0ZSUUNhUDliWkR4N0gwN2JNSHB6R05vekpNVnplOEs4azZR?=
 =?utf-8?B?QnB1WC8xekRjNjR4Z0NRZUQxMmhqYW00cXRLN0hsSVEyOUxieEkrMHpyZjJG?=
 =?utf-8?Q?mzSG2J0yftOD2YyTH0tLmsc3ez/KFfnxJGQz4Yq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ZOYm45ckZwSkdxM2xoM1dNZVNEMXZEbThhbGZuVDdzZnpidGxNYWxpNEhM?=
 =?utf-8?B?N016dHpoWngxd0xheDJaT0JFTTdNL0FiWWVMOVd1WUdlRHBMbjBhaWhYNXFE?=
 =?utf-8?B?ZG9pamcwei9WYXNySHlic21BbWg0empkZngxeU0rbHV2bzY2VUdDb1hDWDZH?=
 =?utf-8?B?dXhiQlhYeTZmOTJBQzg3TStEb21zQnY5YUViNm1WajhzeXg2SWlTQm83Ni8v?=
 =?utf-8?B?a2V2MmhpWGVSMVh3MnBOa0NxVW4wNHY5cmk3Rllaa3liUlliejQ5UCt1QitC?=
 =?utf-8?B?ams4dW1zaEN5ZFVBMjBaMHQvQXB6VUl0d1hUZmtjVXZVeWVOMGpJdXVzdU1T?=
 =?utf-8?B?YU44OUlwSXBEcmlrMEJ3TVNhbENrTHYrYll5d3A5SFZ1MU5nR0d5ZEEzUmVz?=
 =?utf-8?B?eEFLRTJQSVNRb3JjaWZpWktQQ3FiclRFalJlYU1ET29QZ0ZGNVEzMUZlSFZW?=
 =?utf-8?B?NjBmbGV4TllPMmZmbFZ6MnlGSmwvZFNuUzQrTmM4Z3hYQ2h5eHdsVStNZ1Bt?=
 =?utf-8?B?b3BGTDc3OXVJS1hqY0Z4K3RGcWhmc3dIaE50Uk9xNDJMT00zd25Hd0gzR2JV?=
 =?utf-8?B?ZVNNTzlmdFk5OTRrZkF5SHk3TG5jcDlLYmZoL3RUVTVjYzc0RVRaTUkrSU9t?=
 =?utf-8?B?RjhOemZtWlVpOEd2UXl4elRIVUVua0JxbEF5cnhGN25Yc2VtaHpyV21jR3RK?=
 =?utf-8?B?ZThWL3dvY3dqSUJuUjMwRUdyVXRHUXRRRUZrZ0hNS0FxUVdMZXBaa0QzNWFq?=
 =?utf-8?B?QXNRYWg0djNzc3dERGt4YkZMR1F1eGsyazZrMVd2TkFMSzZKTTZkODYva0NZ?=
 =?utf-8?B?TW9tZ3Q2bFBmNVZDWkovWnZpd2NNNkZ0T0xwbDY2Q0Z6M2VqYkN2SXR4Rm56?=
 =?utf-8?B?YkdsZWlzMXJpN3BUTnM2KzBWOS9taVh1eVZ6SUorL29hKzdDRG1PalNYZHdZ?=
 =?utf-8?B?Zk4ybzRxWitOME52NURqd2F1WlJDOGkxaFpyQzYvMElMaVdiNlZuWEl0bG1x?=
 =?utf-8?B?Um1RV2t6NzBVMUxrWlNHWklSQm9UK0NsYkpUYkFqZkxYQnNhWWYzclZ2U0V6?=
 =?utf-8?B?L2swNGtZNlB3YzE2RmRBa3pJTUxwS1hGSXJUSkFnWkJSMlZ2aDJnaU9OdkZy?=
 =?utf-8?B?ekFlSXl6ZXNqQ0hqTDQ0U2JFMGpPYmxSVGRiV05HOUxDVDJHUm5aOW01ZFp1?=
 =?utf-8?B?T3ZJdk5IOHZvdlhmQjl3QUlDcGYxVFV4czBldHZaYURRelpZanJjZVZzSXpH?=
 =?utf-8?B?VkJpR1N4bUdaTytTQVNRODNNVTY0WGxxVVNVc1dDbGRwUFJQYnBPOVcwMlN1?=
 =?utf-8?B?SDRRNFQ5K2QwUWc0Z1AzcTc1cHBRWjhpVFVtWlo0d0ZEelZNdnpyREdHbFlI?=
 =?utf-8?B?Nm1NcXNPcDM0MkxDL0VSNGVZVHJSMVdGV2RGditVVTA4V1VsdytQZjkvVnpQ?=
 =?utf-8?B?WjRjdnVvOGNsT0RUSGdQTzJBVjhHSGM3SXE2Wnh4TGV4QWt4b1FDcVJNVHlt?=
 =?utf-8?B?UEUxSVNsYUhRR0lsSzNXS0FOM0FQMlBuTC9KOXJvanB3NWltWXRmb0VCdHND?=
 =?utf-8?B?cUN0dDBNUzVBelpWbStKQTdkck9ITElscUNQbmNNMTNRTG05VWlTUWJGTGln?=
 =?utf-8?B?VUV0TCtyRGhaVFZSaTQxeUJVK0o5WjllN2NBMkpoSDlCZ01LOGM3WEdpeENR?=
 =?utf-8?B?Z2tGa1hxMEliVU9Vb3ZIdkxpM2xQYlFGbkxpVSt5RXVVS1JZTm1naHBRLzRr?=
 =?utf-8?B?YnlyZDdiUmh2YXB3cVNsS2Q5dnUydmRQZFRNZkt3Y2tIT0d5SXN3TTdodnNx?=
 =?utf-8?B?ZlJZcndCbzdXTjArKytXYkU5a0Z0Uk5WOU9DUm5OSzI5bklXb1B3RGJFR0pH?=
 =?utf-8?B?blhBNjU1RkpDOUN0TFNvL0x2WEJOMUwvU0FaS210NkpMOXlaaFNYOHh1OXZT?=
 =?utf-8?B?d1A3RjhJSmNBVVNjZk9RVU9acVZNcmo5bm1wNFhFRFoxSEpVUi85RWp4UDFD?=
 =?utf-8?B?WmpQcWZab0dxSUZHMUpRWHErZzcweVN6VkhCQ0VWbjMvenprK3JKTDlOakNv?=
 =?utf-8?B?WnZINnhqTUJtUlhPOEdUK2JISExlTEFsaXFpWlBucXlSMkhGOW9YRFhQbTdS?=
 =?utf-8?Q?m/1+DCtVKxLGzX7ZVdt81dBwD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbb4caa-c295-495f-72f6-08dcf8e4b018
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 13:13:47.1372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6ucbdL7a3rVaFHxWkJ6y7rqVFRVwM4Bfy4i895bmyWzPJf2bIVtfzMToMpxe+Wc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
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



On 10/29/24 19:58, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> 
> Add native support of the bootcount mechanism in the ZynqMP by utilising internal
> PMU registers. The Persistent Global Storage Registers of the Platform Management
> Unit can keep their value during reboot cycles unless there is a POR reset, making
> them appropriate for the bootcount mechanism.
> 
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> ---
>   drivers/bootcount/Kconfig            |  4 ++++
>   drivers/bootcount/Makefile           |  1 +
>   drivers/bootcount/bootcount_zynqmp.c | 28 ++++++++++++++++++++++++++++
>   3 files changed, 33 insertions(+)
>   create mode 100644 drivers/bootcount/bootcount_zynqmp.c
> 
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index fa6d8e7128..95b6a9541a 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -82,6 +82,10 @@ config BOOTCOUNT_AT91
>   	bool "Boot counter for Atmel AT91SAM9XE"
>   	depends on AT91SAM9XE
>   
> +config BOOTCOUNT_ZYNQMP
> +	bool "Boot counter for Zynq UltraScale+ MPSoC"
> +	depends on ARCH_ZYNQMP


help would help to also described where that count is stored.

And why not to have it under DM/U_BOOT_DRIVER?
You don't need to create compatible string for it just instantiate it.

Look at:

U_BOOT_DRVINFO(soc_xilinx_zynqmp) = {
          .name = "soc_xilinx_zynqmp",
};


> +
>   config DM_BOOTCOUNT
>           bool "Boot counter in a device-model device"
>   	help
> diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> index 245f879633..487adc1212 100644
> --- a/drivers/bootcount/Makefile
> +++ b/drivers/bootcount/Makefile
> @@ -3,6 +3,7 @@
>   obj-$(CONFIG_BOOTCOUNT_GENERIC)	+= bootcount.o
>   obj-$(CONFIG_BOOTCOUNT_MEM)	+= bootcount.o
>   obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
> +obj-$(CONFIG_BOOTCOUNT_ZYNQMP)  += bootcount_zynqmp.o

please put it to the end of CONFIG_BOOTCOUNT to have it at least in correct location

>   obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
>   obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
>   obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
> diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
> new file mode 100644
> index 0000000000..9bb801e188
> --- /dev/null
> +++ b/drivers/bootcount/bootcount_zynqmp.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// SPDX-FileCopyrightText: 2024 CERN (home.cern)
> +
> +#include <bootcount.h>
> +#include <stdio.h>
> +#include <zynqmp_firmware.h>
> +
> +#define PMU_PERS_GLOB_GEN_STORAGE0 0x00FFD80050

In arch/arm/mach-zynqmp/include/mach/hardware.h
there is already structure defined and gen_storage0 is there too.
Please use it.

Regarding this location. Exception in PMUFW is using this reg.
It means at the end of day it is up to you if you want to use it or not.

> +
> +void bootcount_store(ulong a)
> +{
> +	int ret;
> +
> +	ret = zynqmp_mmio_write(PMU_PERS_GLOB_GEN_STORAGE0, 0xFF, a);
> +	if (ret)
> +		printf("Failed: mmio write\n");
> +}
> +
> +ulong bootcount_load(void)
> +{
> +	int ret;
> +	u32 val;

as was said val should be initialized here too.

> +
> +	ret = zynqmp_mmio_read(PMU_PERS_GLOB_GEN_STORAGE0, &val);
> +	if (ret)
> +		printf("Failed: mmio read\n");
> +	return val;
> +}

Anyway I expect this driver to be under DM that v2 will change.

Thanks,
Michal



