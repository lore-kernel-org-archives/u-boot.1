Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D890C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BA0288335;
	Thu,  6 Jun 2024 16:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jAjfZEdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02460883C2; Thu,  6 Jun 2024 16:16:53 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96C2288335
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTx/3Oa9/WguGtpRq9wH2iUyJTqbREHnAmi7S+y7B4gcx4uHp6LtUgcFc++5/2HQYpTCkou+aTjt5bQSNd+xb8WPnsxMhsAq5dnUiJQJ6m7MrfSabXQwSMKPGX+Ktyp/u8SV+wZO0c1MR2J0X5tjsOTacD4VTewvBdJ1k2Ff9SmY8K71mNprhHa+VPkSG86F/7CxIRetVsVeBSeChufgjhL0hWrlp6ifuoxZZKS02ghqrEazRybNrAPKFFHZRXaxGSt/nlKAglWakcImlJUExuwy6yIR7ruw0OdoWPJPU8KlOkF25gxyRyCILewmc4iOGeRkjND8VYnKkMNsFuLjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obl8w0FttF7HvTthFr7wyk/yPE9wq8NbmRQWxylbgno=;
 b=eQJ41jhiI2uKMMmsfYABdY763df3+vVPHSCK6uYDKaIRdBamCJLZnucdqZegKXY5VQwMPKGgsMxLYNDNntA9Nz7uT8XTxl7Ko+RzmKrEYo087rhufpA8U4IhDgXKyTxhg/ZdTm4v1iZamZJ6kTdq/7YBDEWIHT/zihfgattijldngWl8Bwuv8HwhMFNZKCU6BSVLLiyR+SGe6N2Sw+DNmdP1iV3BI7yw3hV5AFJxkWi8H024vnWXQqte8IKGw++FyXdQq6/5+1NEXpX5F3YcYlWTvMWf9K6SdL/DfcnVFDW2NeMKrou+nA7UHdp3LOxVTtflxpDbKeuaNDXgzg6pLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obl8w0FttF7HvTthFr7wyk/yPE9wq8NbmRQWxylbgno=;
 b=jAjfZEdzs8YlgB/TJALUqBRnKHVjgCjk4HHHczLXI5gLHEuzoLjSYfuloVVEwVTTpKpBpi2zI3yyD7nkQ/ndAocLvbN1jzGhVKX9pI+NJLIMRilqdn6RiIviPl9JR9OahKAuQw9x4fepbt2Vm/ub4KbUoTDn28jVUyITqDU0GBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 14:16:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 14:16:47 +0000
Message-ID: <211f91aa-e6c4-4d5f-9b84-b835872bcb33@amd.com>
Date: Thu, 6 Jun 2024 16:16:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] soc: xilinx: zynqmp: Use zynqmp_pm_get_chipid() to
 get chip revision
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
 <20240604142741.425307-6-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240604142741.425307-6-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0021.eurprd05.prod.outlook.com
 (2603:10a6:803:1::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 157714e9-ea34-4a96-0063-08dc86334ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFpUSDhOU2VDZXpNSVcyNVNPTnAvNjFXOVdKWmd2NGJoMytyNmNnTkxrenk5?=
 =?utf-8?B?UlVUakdUYjNSY01FYThmNUhJKzVNaE1FcEcrTlRnQ1JINjF4bjNwYlBJajRZ?=
 =?utf-8?B?T29yTEMyS2puazR2a0FyT0Y2aU5qenhIZW8rdndDVnNsSEtEMThDZUtiZkwx?=
 =?utf-8?B?bGlPelYrUlBzYmF6dURSQ3N5TEpRY0NuazZ0UllmNTVFb2JvS09NYU02SGQ0?=
 =?utf-8?B?SzhXVC9zNUIyNXgrdkVMZjJCQmhndkZNLzAveEpkUFMrQ3I3TFJINnRVRXNa?=
 =?utf-8?B?WDQ1NUxOeUlwalNiRU9jUUovMmVXdzBaaWxiZ2tRc01YeSttNkVyeDNCaDI5?=
 =?utf-8?B?R0RhUFJ4bWlZb3cyVlZjekUvVUdzbVI4OVpvYkVJTGdjdnEzaFArWWNveEdn?=
 =?utf-8?B?L0duWWFhbno2THNFemdmNjMzSDBCcG9kZ1piYks5VTcyRnlTRUh3Yjl2Y2NH?=
 =?utf-8?B?YlpEcWVmQ1ZMeElBd2Q0N1luNnpPSXo5ZW1qd2VXSUgzQWN4NHdJS3hJbS9Y?=
 =?utf-8?B?MXNHT0NzQnBVUHZhSUFXcmZSM3J3Yy9Xc1VpamFJWStySVZyLy9nNFNpMVVp?=
 =?utf-8?B?WmJldGxyYjVTQUlzZkNhbWdxZ3VMY3lZNWgxV3crV2ZMV3JjL2pIQ1FERjBG?=
 =?utf-8?B?OFUrNjhKUWpHVXJXR2dkSVhodFl6SlhDV2t5L2puMi82WnNUa1YvVzRvYm42?=
 =?utf-8?B?eUk4WGttR2pWSkxkQm0wT3RFdlhPYXFiNzdBSURwMmZKVGl1YjRSUGJRWDNt?=
 =?utf-8?B?dDNGNG1Mc0pxQnJ3ZUJmT2xkUkhmZzJuQzkvMk1zd3ZjZmsxYi9KSFdCM3ZM?=
 =?utf-8?B?NXNCbU9ObDlVckVTYlI1cXpyYXdyL2R4ekc1WGNNNThKSnA5UlVaakpzSHN5?=
 =?utf-8?B?UnhKNFBxcjNDN1QycThXTy9LZjRNYlBvZHFYTmhTcGhmQUNHOFFnaEE4WHpX?=
 =?utf-8?B?RFh1NW92eVVKejBVanZkdmtCYUE5ZXp0YXVUOHJOZ25zaktvaGZPWDN5dEdv?=
 =?utf-8?B?MlFyME9kbmlwS1BsQnNkRW9TaHVaUGJhWGNqck9zNFJMRURCUXVvZ1NuTjdF?=
 =?utf-8?B?bk11TU9TZ2puTUFMZDROOVRTZ25hZ3ovTGRFWmFMU0pUZHpDZ2wzT2kvVm9l?=
 =?utf-8?B?ekswWDR5SlduN3BmWWNMVXErdFVndzZVa0JLSzk0YkZIN0Vsb3VOWUxWcEFY?=
 =?utf-8?B?YU96WGg1YlhLaXNLRzdkVFNwNDNNQlM4R3lNZWZtbzcxY3hmbXVHZE5BUjlJ?=
 =?utf-8?B?QVJMQktHV1dhTWNIUXRCMlM3djh1RU1EQWpHeTIzUlRESm1YSWg3TzBBQzRo?=
 =?utf-8?B?Sjc5NnQxdVNSMkdVeE92VUpDZm9sbFZlWER4azdIRFdRK0VvUSt0a3o0T2g0?=
 =?utf-8?B?cndKVlZiQ0FaTkFRUEpDU3RCbnZvRmxsYTd1TFNqTEd2S3gxbzNTTVFjQm9h?=
 =?utf-8?B?cnVtcFVIUnNLTkt2Y3B1NkZYb2cxWWJNS2pNZFpvbXB1akFVcFB6SDIzZTNZ?=
 =?utf-8?B?cWNDdXh1bU83N3lidXJJSDBqSkRLS25wM2pndXIzQm5iRnIzdU5MMjYwZFdn?=
 =?utf-8?B?VFhBN3B2Z0Z0M3J3d2xzVEtoL2VjaU1jTEpLckF0ZmFmWjUyamcyVE9KREZR?=
 =?utf-8?B?WVMrL0V5NkNVVFUxSUFJc0tERHMrdklHZzZFY1JKK0FUU0pIRVRzK1NmZkQz?=
 =?utf-8?B?cnM0b2xyamZNNGVPa2s2TE5vRjRlN2JSYUZ4VUY4U2dvSS9yZVN0T0FzOG9w?=
 =?utf-8?Q?asvL1hHQNu5ymXuzU7pQU0lgLfHStcjvfCGzpDW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVN6NWFLb2dNRG00VVYxRmtuK0xhekE5aURVSTI3NDdmbHZuemQvV0wrekp5?=
 =?utf-8?B?K0VJamlNeFZQcklMbjYweDc0NG5SdkNpMlBiV25RNWRwWUYwbC9sZUtCa1N1?=
 =?utf-8?B?RWxPWEpGcVc4UkVsU3V6Y2lQVEExdnhiT0FkN2lqcE1UVXZqQlAxa1FXRW9D?=
 =?utf-8?B?aHBRN3VHWFdZV1hqQzhWWGEvaXlBckxuZStyV2lpQ095cVNWb25Wb1V6bFpt?=
 =?utf-8?B?WjlkTW1SK2NKeHBWN0wwK0RDUi81QkpVV1VqM0NGT3BEMDdRQ3RRUUZyVzlQ?=
 =?utf-8?B?alozWXNIalpaSHNyTW93OUgzYnNhVlBsVnVITWZUTjBSZVNRLzRReHVpWEkz?=
 =?utf-8?B?Q1VhaG5SNVY3K0UxbDZKRnV4bTR5VFM2bmtONlN1dy9PTWZ0aVI3SUh4eW1O?=
 =?utf-8?B?c3E0b1JZWDE1dlJ5RzRXdWRDS01XeUJXYksrNFlIcFp3eFpzM1VyMno0SWlX?=
 =?utf-8?B?UEFMSmlZN0JKUjI5T09ZZ2sxSWJMNjlORWJJZ1dLc3luL1pkT1ZkTWZ1VEhY?=
 =?utf-8?B?dTZMQ1dsS0RnYmlLRGozeWdXQVZSZjV5c0EzeVV4ZDVqQTViYU9YVitjZHNw?=
 =?utf-8?B?SHJjaFVnY25Na2tjdG1yWW5rMVdDdXdyS0xxaHhQYzY0bWJhdnZFZ2RIMkhN?=
 =?utf-8?B?N0F4Y0NqZm9CR2QvZHZKdmJTQWZBSFFRRy9FK1RZaFE5UmMra1FUckZONFZz?=
 =?utf-8?B?YW9Hdk1jQmcvRVRiZGVWSTI1MWlORG9FVFI3MXRKNGpmYmdNN2VlT0pFRGw2?=
 =?utf-8?B?THlTdFd1cWRoN1ptTlE5aEVpdHBQODNwUEI5My9zQ2QwaEFBeC9yYXNNK2Q4?=
 =?utf-8?B?by9mckdBTEx4cS84YndHbk1PTFdQem1RUjZRTS9ZZVdrR0FTdW91Szh4KzVv?=
 =?utf-8?B?UmVhT21RSDgvaHBUVzRKZThpcjkwdzdWNEtYeEVnTEFQTFl4eE5oS3o4UXAr?=
 =?utf-8?B?SFpxTmRMeHM4NGNCTkw4cHR6cUsvVW1NWUF0bkdrc0t1azZEdkQzSWRkZENU?=
 =?utf-8?B?YUMzL1dIYW1STDJTRGk5RFJGYTVuOC84cW1LQjJWUVNwSTcweWR1R0pKNDRQ?=
 =?utf-8?B?bUo3ZTRUSDJhWEFtMXV1MjlLM0VQb3pIcGQwNy9YWWpHei9XaEt6ZUZSQ3c4?=
 =?utf-8?B?SEh0SXIyVERVbnZucCt3ZVZYUnQ5TkxHcVRXUEVHYlp3bHpsU1JhL0FQZlJa?=
 =?utf-8?B?QTh1SzlWVVVJYzBwejNkbHJSVktNbGxQWFZ3VjF3UUk0UDVsSUE0dEVEZW8r?=
 =?utf-8?B?S0RwR1NrZHNQZFBhNFFrY1FZYUNrMklnejdZdlZMbXNKTWttcDFzRGtEU1Qw?=
 =?utf-8?B?V3FHK2xjTEdFQ1Q3R1NQc2FGOWNmQU1Vd0szd2JRZGlwWXFXUUNjWEZYR3g4?=
 =?utf-8?B?V1dRb3JFdHAyamlBNkZHOVVFSTUrUTF3bHhYd1NmZGtDSHRCZVpxdGMzVDJ0?=
 =?utf-8?B?bGhQeFFQVVZYWFJnRUluZGpZaGErdEhGWHdFZXRUM3NPbmhTUFhjc3NjaHUv?=
 =?utf-8?B?UGNkeEROTG9HalVTcUpCWWdrc1UxZ2t0RW1kclNpOXZDd2pOZEoyckVidk1i?=
 =?utf-8?B?U1FwQjkzWENHZ3Y4Ri9BbklwRHQ1VEIrNnJkYXEwaE1XZlVMU2JIdFlVcTRF?=
 =?utf-8?B?NHN4R09ubHhyYncxeXBZWnBnNDg2bk1URnN1THlqNDFtYlZ2SlR2R0JIS2g0?=
 =?utf-8?B?MWoxWHh5bDlJM00xTWVHbDJkcTlJQjdHalVaT3QxTmJxUi9aaTdtQmlpRlR1?=
 =?utf-8?B?S2YwRHBTbmJ1RFRTU0wrUXJyVWx1bnhEUzVrckdkeGJES3BLSUhyYUxrRllX?=
 =?utf-8?B?eUpPSlNzNEI2Ujl2L0VSVFl3MHdBZHhDU3AwRUhsL2NrWUVIR09BNkIvUVhx?=
 =?utf-8?B?QmFYN1c5TWUyRlNFeVVzN3hwc2VZVGVQelNnS05SZjdVNGZGODZOS1BkSzFF?=
 =?utf-8?B?Zmg5aXQxOXpvR2lGMUg2NGJnUE41MzFZM0pwZDNXZXNqZWVVbStjelFNaW5m?=
 =?utf-8?B?K1p0Yng5bEJabGh1dkh1ZzhRSkYvLzNvdUdtQ1JsRjRrdTJQN3JZeHNxVndj?=
 =?utf-8?B?TlkxWHlCdUhhb3VqVEd4NXFoNE5LNmh5Vkx0MWtpL2wwQTh6RnF3WWw3Ni81?=
 =?utf-8?Q?JdhT1R0AIZDuWshSOqK6qxdtH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157714e9-ea34-4a96-0063-08dc86334ce4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:16:47.3563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkmTToCXG3jU0T04uuYUISqDPJcvHMeG0Ky8/f2jUJsD3NPK7y+G5zyXMRd5/iCU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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



On 6/4/24 16:27, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Use common zynqmp_pm_get_chipid() function to get the chip revision
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> (no changes since v1)
> 
>   drivers/soc/soc_xilinx_zynqmp.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
> index d8b4f172a39..8a65810b7d7 100644
> --- a/drivers/soc/soc_xilinx_zynqmp.c
> +++ b/drivers/soc/soc_xilinx_zynqmp.c
> @@ -346,22 +346,21 @@ static const struct soc_ops soc_xilinx_zynqmp_ops = {
>   static int soc_xilinx_zynqmp_probe(struct udevice *dev)
>   {
>   	struct soc_xilinx_zynqmp_priv *priv = dev_get_priv(dev);
> -	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	u32 idcode, version;
>   	int ret;
>   
>   	priv->family = zynqmp_family;
>   
> -	if (!IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
> -		ret = zynqmp_mmio_read(ZYNQMP_PS_VERSION, &ret_payload[2]);
> +	if (!CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE))
> +		ret = zynqmp_mmio_read(ZYNQMP_PS_VERSION, &version);
>   	else
> -		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
> -					ret_payload);
> +		ret = zynqmp_pm_get_chipid(&idcode, &version);
>   	if (ret < 0)
>   		return ret;
>   
> -	priv->revision = ret_payload[2] & ZYNQMP_PS_VER_MASK;
> +	priv->revision = version & ZYNQMP_PS_VER_MASK;
>   
> -	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
> +	if (CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
>   		/*
>   		 * Firmware returns:
>   		 * payload[0][31:0] = status of the operation
> @@ -370,11 +369,9 @@ static int soc_xilinx_zynqmp_probe(struct udevice *dev)
>   		 * payload[2][28:20] = EXTENDED_IDCODE
>   		 * payload[2][29] = PL_INIT
>   		 */
> -		u32 idcode = ret_payload[1];
> -		u32 idcode2 = ret_payload[2] >>
> -				   ZYNQMP_CSU_VERSION_EMPTY_SHIFT;
> -		dev_dbg(dev, "IDCODE: 0x%0x, IDCODE2: 0x%0x\n", idcode,
> -			idcode2);
> +		u32 idcode2 = version >> ZYNQMP_CSU_VERSION_EMPTY_SHIFT;
> +
> +		dev_dbg(dev, "IDCODE: 0x%0x, IDCODE2: 0x%0x\n", idcode, idcode2);
>   
>   		ret = soc_xilinx_zynqmp_detect_machine(dev, idcode, idcode2);
>   		if (ret)

Looks good.
Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
