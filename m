Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE260C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DCD280762;
	Mon,  3 Feb 2025 10:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ci67Vckz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB9B6807B9; Mon,  3 Feb 2025 10:20:11 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 265AE8070F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mahw/6Gx2gMYCbOvdFaHZ7OfpxOLfiVC0S+KhOt8QCq+Q/jUUWTqUH0BWBBQKiGKgu1tLupMzlwQiJn9PwCElrgPkRLNoHp27Y6IeduTU1Jw1pkxaJ7F0Bes6xLQIEnZCTOUgJ1q/bG3BKYDbuVpi8PWKLcnz/yRKQeIHRvrWa+Y82xj2tVZo2SYMB38OZjv7MerH2oabXTVq+JkVN1GwYXk5QN3C4kAZS10veWxeolp3ird71avT+juFuf96Ayu37nVsM20jXPM1j6DB1bRPYJvpGYHe7u968ZSTMloVoA4KYd6IrPh+CFU+XhovRfi4qbuNN/Qybl/S5X2MI+s6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nojfaJXX5qiHNpXSjm6rwLvJ9x7lax0B7+idfOrbYw=;
 b=HLHSEHdMTEMvP2MRW1Ec3LMD1INaRsxQPgZ1GYEdsAqZSAJJ2N8dHlQkxSRaxe2jS71mR0fBa9D8YgfwtVj60IZcEtVXUDupR0Vrz5ffsRCfo8EkyGyAtRHcrcNOjbye0eNmgTTzvkpw5THGeXX36Ymp7rIk1KTewdgFYi5nvjcEBY3kPaD2d4p6RLCJpW5JfH7AF4I8mye+BNREVPiNBOb7QCcgFQVJi8QffSqYOsAb3dIY80AW2P0A1opcPtSj4nD7T1urDRLhp6ZTmqUl7LUTeosSKiv3Mvj/TscMl4NtVjSxGm7IZw+F/OZNl4LQZ9nV7pivqHtGjo9VspYdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nojfaJXX5qiHNpXSjm6rwLvJ9x7lax0B7+idfOrbYw=;
 b=ci67VckzNZ14zDqx4d5OhJn9ehlTCDI/+4SYD3IjmuxNjte2Quy2Ff2c+Ikv1IIEodIvn8Y7f79lgtLyqYlRqOBzedcsA9kpBBvraLKIJjpniNS7JyCb7eKVyzNs1P8gVeN0kF0mVQHQR5iOs/UWXUqlY3qFlokiToH6daRhrV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 09:20:06 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 09:20:06 +0000
Message-ID: <a3432713-f5ad-4da1-8ea6-279174c14a49@amd.com>
Date: Mon, 3 Feb 2025 10:19:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: Avoid ignored-qualifiers warning
To: Alexander Dahl <ada@thorsis.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 open list <u-boot@lists.denx.de>
References: <20250121162213.1477506-1-ada@thorsis.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250121162213.1477506-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: d34f9e88-bca7-4735-1ebc-08dd4433f2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXI4L0cwNEJxZ083SW83ZlRkZy9aMGJjU1FrUkpwSStaN2lUOStlRnBWa24x?=
 =?utf-8?B?aDQ4K2dxWXRLTFZvVXJiS2d3MWxCaWR5Rk90KzEwc0huVlc3RGJhSnhFWGNJ?=
 =?utf-8?B?YVVscFVMUHBhOXhNdHJoSTUySGtqeVJGVk1DYXVLYXphR1E1K1ZaNTNOcnhx?=
 =?utf-8?B?S1RNSmZwMU5oYTYxRjVpRU1hNVUzY2pvTEwxZFRZT0lHZ2NiT3drMVlMeEJw?=
 =?utf-8?B?cDJjRXNuWVROWFZKNWZsMWZ6WnFub0VlRDAzSHlsdndUeVovV25JVE1hcUp0?=
 =?utf-8?B?UjFXU3NJZXhhWm8yd1gwZ2gwRnlBRkNNUFoyTlBjL096V0tHY0hVTHp5K1RB?=
 =?utf-8?B?WTArZlZ5SkpwZThGcThMY0xHK2U4RnpkdStNUW5sVjZqaHlzSzRya2NGN3B0?=
 =?utf-8?B?WXRydk95SlhZbWFJRVlWUE1yK0dzYTdNSSsrK0NZTytQcUgzV3R5eU1ZWXZU?=
 =?utf-8?B?d0tDd0dNRTVxLzVBYnpXY0pTSlgxNERnU2NCNHVPYzl3OVlyVW9RK0J3aWto?=
 =?utf-8?B?dTNZZzJVb0VDdU5BSlBjd0VYR01qNjFDcFBkbUNxbkZJYW50KzlCL0hYZmtj?=
 =?utf-8?B?UldZSDFWMzFtdW42cmswWWhxMkNsbWZHK25zdEhjK09LNzlLNUVkUlpKUnRq?=
 =?utf-8?B?RzZuUlVVSWpqTllrUFdvNmxabVczdVVNUE1sZ3Fsb1R2SmwvbWR4WTlVU283?=
 =?utf-8?B?Tm1sN0JRaFFIbG9mdDZRZFFRZDJqdkFrdGI4NUp6OUR2UEZIMlVqcUFBZVhn?=
 =?utf-8?B?Y2VqeWFvTG1md0Y1eWdHVE45eW9NYzlvWnlrckROR256bmpVQldXZi9DQ3hV?=
 =?utf-8?B?RnRGV2FyaXhSL01nWSthOE9uajEwSFkwRm9vVUFJOWhMNE5KSVc5UncraHBr?=
 =?utf-8?B?VE1JWWtIVU5Ma2wvdFp2Z1kvRlpGZXlMUEJXSkpMTWRGVWdpQktpRjNReFlq?=
 =?utf-8?B?eFZ5bmJ4c003a0hlaTNRYmtCOFZ5UENLZm4yTThRV3B2ZEJGRDJhZU5Ed0xW?=
 =?utf-8?B?QXFrNkJFU1dEZDBxdHVVcHR6RmoxSm4zOHRkdFZNd2d1Y2VJemU3M1QvZk5w?=
 =?utf-8?B?ZTR6VDFWWjBGYkpvWExMRTA4eTZZSTd3SGRCUytyWENIMmp1SzA0c0Fjc0lJ?=
 =?utf-8?B?WXdpM1Znc2EwVE5yWDczRDQvUXNNN0JKTXY5bVVIQ1FUSjU2V2JvTEo1RDBj?=
 =?utf-8?B?UVQzL3hWZUpQeUM0cTBQNlBLalhSZ3F5a1M4anAxTkF0MUpLR1JUN09ncFR6?=
 =?utf-8?B?OXIrR3N0MFpSSmFMdGQxNlo1ZHV5anByOGNncHBCWW9FRVhQUDc5czczbTFW?=
 =?utf-8?B?RFNkc3VUSlB2ZkEvcDdiS1VaYURMSncxRlVoVUc5THFRSTJ3MDFxVVFsdXVC?=
 =?utf-8?B?SE44ZnQzc1hZQzdMbDdBU3FRbFUxVHJOSDJDL3l5TkVtN3IwQk1BK256U3Bs?=
 =?utf-8?B?TzU1cmQvb0VaSkQ2bnpxU25WUWZrSXg0NVlDVlVLODQ5SkVMZFpkT1c4ZFdF?=
 =?utf-8?B?cG9uVW94WEp3VzdUczlnYk5VSjVvRWg5QkMwVWY1Q1NZb0wwWlljN3RSSktR?=
 =?utf-8?B?bFRaTjl3NThQVzFlR1Fnb01WWkU0VGsrQ3RjbW1FNzVia3JFbDNhQ1NtVlRY?=
 =?utf-8?B?YzdWM1ZZR3V4NFFRRWVPZ1ZwZlc1K3hjc29KY09HdHNSb1pRNGIyOU5BNU9y?=
 =?utf-8?B?NVBIaW42alBmS0NYTTlGbXZOSFNHQU9Lck5KZVQ2OHNJQTh5WW5wWHpyU1lM?=
 =?utf-8?B?ZzNsdllYOU0xMjM3amRBV1BiNEpqVmp5cjdDQjBqc3YrTnZDU2dGYjdpM3hY?=
 =?utf-8?B?T1NRZG44ZXVwM0VLanp0NVVSdUxBWHRWZVVXRVJPSnBMS1Q2Y2xUMVdvV2xG?=
 =?utf-8?Q?I06uzioZAF0gd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V05zYjNtdjRSS0NkNFhLWEVQWHUwcC9EOFNEenpkZGNPMmc4Y2JXaTJ4Z3pi?=
 =?utf-8?B?clZpZjRpT2RxV1UwQ2Zpai9KZHRsZW5ROUF1K1dOYzEvSEVFYkJRT3RreGtH?=
 =?utf-8?B?Ny96ckMyWDBkVVh1akFUYTBTa01uWFBQUnVzOXlNSjdmSG96ekNvUk5kMlFz?=
 =?utf-8?B?QUMrd2Y4VGRuazFVMElnd3BtUFprM0VzR3FYaERYZDcrWFp1ZXZYb1NxenJP?=
 =?utf-8?B?eXlNMU9SdmoxbHZnUUdRUEFRSWJQVGNxQXZUaS9FNFZ1Vngrd1Vtc296MHpl?=
 =?utf-8?B?QlJ6TkpuWDMxYnRaVmUzd0ZCNHVOL0x5WVZ2alV0NmtsWW1EOThtZU50Vnlh?=
 =?utf-8?B?L05vR2FSZXpXVXZLNUhqNUZManpBRW12akMzeDBoZk1GLzBGcDdtcGJCQ01G?=
 =?utf-8?B?RXBkZndzYS9uYjhlUWM5RGc4cWdibVhQQlpUSjdRclZHQ0QyRDVnOXlQSkRQ?=
 =?utf-8?B?N3ZBMHFpcXczSjg5R2k2V0VvRGcvVmpXaTA2TnE0TmZtZ0lFYmtKdWNhWGhX?=
 =?utf-8?B?S0N0MGRUeW13MHhIb3pLQWdKTFU4WkdwNHo1Tjc5cHBFc2FwRGw5YVNUOWlE?=
 =?utf-8?B?Wm9CN0tQeXV6ZEJkcGtpY250SStYRnQ1RkdJTmM2RGYxZVZNUlJjckpIRVZJ?=
 =?utf-8?B?L1JSVTllZzFIZFppeE5jSEE5L1VRSGZBNGhLUFdHbFFEZG5MN3RIZ3VoTkZi?=
 =?utf-8?B?UnVrVlVzZ0xFbnZIZGd1TE1sc1hWa24xdkZtdGJ2RGlmd1lCQy81WFBrelZO?=
 =?utf-8?B?RWNWUU81ZjZSQUNQTkdOWXZMWElRRko5bHVSVzRYN3NCQkZmTTducHNvYmsw?=
 =?utf-8?B?akVhUVhCSnp6VWh2amxQSk5XTEJuak8ycVM4Sk5SSjl6Z2VuNnRUeXZvNmtl?=
 =?utf-8?B?dXk2YnF5S2ZQTmRQQzFpNFBRanNhcGlxWWVwYzFRQkZWR3g2cDE3SmFpcTEx?=
 =?utf-8?B?WnV6eHdUQVVIaTkzWDU3VFVML3c5YmRPNHBTb2RIbzRSL3doRVBzV1dtY0ZJ?=
 =?utf-8?B?NHU0aTJaY3A1djJxUXVGVitXUFJhVk13U3RINWJDeFUzNTI3aWRsMlJNSys1?=
 =?utf-8?B?RHJWNXUvODJVNnVxbk5SZ3FHL081anNqWFFYSkVFeU1TMXc0alFXYmFSUFVV?=
 =?utf-8?B?eGczTUVKQ2tvTFZET01UaUlhQldTeTZJd0NnTDZtM3lqM2p3OHI3aEpDek5I?=
 =?utf-8?B?RlhyZ0JWK3NDTnBtSE93UmdGaTVldDJLMDdmTlRvU2ZBV2VHWjBaSzEyd2to?=
 =?utf-8?B?OFIrUzBjSWFvNHgzWHpic2RBRk1VeDFaNk0wRE1ubTZldEVaODJ6emNyYW5y?=
 =?utf-8?B?ZEJIaXFvejhyREF6cmE2SitaNnprenRDM0ZaQXg0ZFVEV2M1NzU1T3lvYjhz?=
 =?utf-8?B?Y0RDQ0tXeG9mZlE1cktFdkdRNUpxaU1nckFnYnA0bjRTcXRKZUE5eVBzVnBN?=
 =?utf-8?B?Q1ZDWCtDcGczdmM1dHJWdVNreHY0eGVxT0NSQ3ZtakhWeTAyOTVFTEFUdFJ4?=
 =?utf-8?B?Mm1CbHNxK3YxaktWMXIzWWN6R2hiZ1hQc0J0NUx5ZjRTMDB4YkhuNFdHQnFM?=
 =?utf-8?B?aHVjMHgrNm1rOHFqWnV2TGpyVlFDb2piaTJxbUtaZXlnNUJyNXhvZTZKUWlm?=
 =?utf-8?B?Y0dYWEpnSXVvd2ZMT2N6Z25IbUxGSXJCL1V5RzVuNDc5aS9XUGNUTkRCK1pY?=
 =?utf-8?B?SHFRb1FCVDZ0eGZ4U3BWK0szcXl0OHpqcnpFTUlBNkJIQklFSklFaUxjWTEy?=
 =?utf-8?B?V2pKNzFnNW1Hdnp0d05kOE9jY1F6NG5ZOC8xWGFRdnRodlRaR0ExVjJKL0NN?=
 =?utf-8?B?eUxzelRvWm8yaGhBd3hjYkQ5SUdsWk04R3JZVGNmOUhoVHcxdE9Ob3orZW5i?=
 =?utf-8?B?dm5Ycld0UWVoNjdiNWFXR2xRbkZkSHk4elpxa0F2enVuakhBb3ZKR3JzU0Nt?=
 =?utf-8?B?YkxhUEVuRklTS1BiRU84cFJ4T0NQbVU4ZnNCNUJ2NkRGM1J5RGQ1NWoybTdo?=
 =?utf-8?B?VndBQWxkUlFUUmZTdHFINUhwK0RjaHJSN1d4SGZ1S0g0N0t6amU3blZWVUU5?=
 =?utf-8?B?TUpHNVhhZHlFZWtPclZYeHhyTlNaeXBFemlqNVFlcnllNXgwNVl1Ry9raU5B?=
 =?utf-8?Q?y7ranRZMkbRR/Ju8qnKKN5Ati?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34f9e88-bca7-4735-1ebc-08dd4433f2ac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:20:06.4054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lcg+VgRZx1a7ns2rZAvMFjHn/lKvKgE/2UndQa7BjQxM+1tOAakzT0hNMzijpumQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
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



On 1/21/25 17:22, Alexander Dahl wrote:
> Fixes annoying warnings of the following type when built with W=1 (for
> each file including fpga.h):
> 
>        CC      drivers/fpga/fpga.o
>      In file included from /mnt/data/adahl/src/u-boot/include/xilinx.h:7,
>                       from /mnt/data/adahl/src/u-boot/drivers/fpga/fpga.c:10:
>      /mnt/data/adahl/src/u-boot/include/fpga.h:61:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>         61 | const fpga_desc *const fpga_get_desc(int devnum);
>            | ^~~~~
>      /mnt/data/adahl/src/u-boot/include/fpga.h:81:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>         81 | const fpga_desc *const fpga_validate(int devnum, const void *buf,
>            | ^~~~~
>      /mnt/data/adahl/src/u-boot/drivers/fpga/fpga.c:36:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>         36 | const fpga_desc *const fpga_get_desc(int devnum)
>            | ^~~~~
>      /mnt/data/adahl/src/u-boot/drivers/fpga/fpga.c:53:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>         53 | const fpga_desc *const fpga_validate(int devnum, const void *buf,
>            | ^~~~~
> 
> Do some type and cast cleanup on that fpga_desc type file at it.
> 
> Link: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wignored-qualifiers
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>   drivers/fpga/fpga.c | 14 +++++++-------
>   include/fpga.h      |  6 +++---
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/fpga/fpga.c b/drivers/fpga/fpga.c
> index 1f6782537de..f88267e01b6 100644
> --- a/drivers/fpga/fpga.c
> +++ b/drivers/fpga/fpga.c
> @@ -33,9 +33,9 @@ static void fpga_no_sup(char *fn, char *msg)
>   /* fpga_get_desc
>    *	map a device number to a descriptor
>    */
> -const fpga_desc *const fpga_get_desc(int devnum)
> +const fpga_desc *fpga_get_desc(int devnum)
>   {
> -	fpga_desc *desc = (fpga_desc *)NULL;
> +	const fpga_desc *desc = NULL;
>   
>   	if ((devnum >= 0) && (devnum < next_desc)) {
>   		desc = &desc_table[devnum];
> @@ -50,8 +50,8 @@ const fpga_desc *const fpga_get_desc(int devnum)
>    * fpga_validate
>    *	generic parameter checking code
>    */
> -const fpga_desc *const fpga_validate(int devnum, const void *buf,
> -				     size_t bsize, char *fn)
> +const fpga_desc *fpga_validate(int devnum, const void *buf,
> +			       size_t bsize, char *fn)
>   {
>   	const fpga_desc *desc = fpga_get_desc(devnum);
>   
> @@ -60,7 +60,7 @@ const fpga_desc *const fpga_validate(int devnum, const void *buf,
>   
>   	if (!buf) {
>   		printf("%s: Null buffer.\n", fn);
> -		return (fpga_desc * const)NULL;
> +		return NULL;
>   	}
>   	return desc;
>   }
> @@ -72,7 +72,7 @@ const fpga_desc *const fpga_validate(int devnum, const void *buf,
>   static int fpga_dev_info(int devnum)
>   {
>   	int ret_val = FPGA_FAIL; /* assume failure */
> -	const fpga_desc * const desc = fpga_get_desc(devnum);
> +	const fpga_desc *desc = fpga_get_desc(devnum);
>   
>   	if (desc) {
>   		debug("%s: Device Descriptor @ 0x%p\n",
> @@ -374,7 +374,7 @@ int fpga_info(int devnum)
>   #if CONFIG_IS_ENABLED(FPGA_LOAD_SECURE)
>   int fpga_compatible2flag(int devnum, const char *compatible)
>   {
> -	const fpga_desc * const desc = fpga_get_desc(devnum);
> +	const fpga_desc *desc = fpga_get_desc(devnum);
>   
>   	if (!desc)
>   		return 0;
> diff --git a/include/fpga.h b/include/fpga.h
> index 44f2755a3f1..4cc44164b2f 100644
> --- a/include/fpga.h
> +++ b/include/fpga.h
> @@ -58,7 +58,7 @@ typedef enum {
>   void fpga_init(void);
>   int fpga_add(fpga_type devtype, void *desc);
>   int fpga_count(void);
> -const fpga_desc *const fpga_get_desc(int devnum);
> +const fpga_desc *fpga_get_desc(int devnum);
>   int fpga_is_partial_data(int devnum, size_t img_len);
>   #if CONFIG_IS_ENABLED(FPGA)
>   int fpga_load(int devnum, const void *buf, size_t bsize,
> @@ -78,8 +78,8 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
>   		       bitstream_type bstype);
>   int fpga_dump(int devnum, const void *buf, size_t bsize);
>   int fpga_info(int devnum);
> -const fpga_desc *const fpga_validate(int devnum, const void *buf,
> -				     size_t bsize, char *fn);
> +const fpga_desc *fpga_validate(int devnum, const void *buf,
> +			       size_t bsize, char *fn);
>   int fpga_compatible2flag(int devnum, const char *compatible);
>   
>   #endif	/* _FPGA_H_ */
> 
> base-commit: 5d5ce5f25708077e354a5627ec92b643145992cc

Applied and fixed commit message as was reported by author.

M
