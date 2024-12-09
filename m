Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D9FE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E380F896CB;
	Mon,  9 Dec 2024 16:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZgeuuR7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E5C4896AA; Mon,  9 Dec 2024 16:27:20 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2316896CB
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUGuc0Fr1eBE+ZOb2aGTcZYCYXUohfPHQErN5UgcSC6BdS3TEGk/Y9uKKOuiM/zPrwwd027ZH2fpInsaxpBnxX7D8KDAcvwlU4esHaa0mopEgFpoHegKj8706UbijBsSHEG/rmAqz3z44/w4tk9rCGrG/VUvK8boiIaQ2FvYc7A0D/MSLbaWYBEMVTqoGEpZItzojPRY54roxLXdgO3k3YKn6ii6+i2mKD4JvpnmQl6mQh6yZKOqMPB99ucRp2OtOrfvuPPuYMlh4I6LerEtM1M1sd/QobFkA8Hw9OHt+VqMdiZMC2gguwp2I5FDlo0e2T7gc66whKsUsBhveZV3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHMxpVlECnUD37tR9oIZ2z89cCD607T+pYMyxDeWNK4=;
 b=lBThUWkXq1fXlkM0ytlrc9kcFcP9OEn2dvoRSgg+SBl7sGsdZXcRmaevtgiihNpPtv+JGXv4tqvC6MINADG2T1KV07WTGub4Nb1C032CHU4uqzZDzULvM3qxPIhHO1BBxiwfPioiEtjM6RJc8l4A6U9QGSzsrcVyBA3gvopDkhKk+7G9XEIDMTjJlHBYzf+IUQTtdrvDCMRN2tRrdQ+Zg+hlmb1o1NIBlzjAweKivJp2J8p2OWVUUGOev57sVWW4MQbiwO5eaAlgf6V8FRNKc89muAmRZQkoWY0RT2c2iUrOIFevIIlwsLgxQ/rUJy00usJLWmwtVFaPYiQ8Ger1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHMxpVlECnUD37tR9oIZ2z89cCD607T+pYMyxDeWNK4=;
 b=ZgeuuR7XmsGGdaFHT59YpYAovG0qgWgehcUlyKpuXFpaMtkHKK1Yxm22PjoQ0qqRejAI6BC3ShHhtP7bt18Mub23AlCWNjRUNjYGD7bVwssbpcmknrK8WMLpq4FeuA9N7l95qYruRqnwC+dFCxGP82k4yyKEpA2odlD5lLXA3cY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 15:27:11 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 15:27:11 +0000
Message-ID: <96902a24-5027-4344-b1f3-f15742d82a54@amd.com>
Date: Mon, 9 Dec 2024 16:26:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] zynqmp: Add binman description for SOM
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, git@xilinx.com,
 neal.frager@amd.com, Charlie Johnston <charlie.johnston@loftorbital.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
 <CAFLszTh6s5n4nzC7UKhFnQuXFOucGA6amjN1eV4NqwjV6-NEeQ@mail.gmail.com>
 <1048553d-4818-4aba-8bd1-c958dc0b7c5e@amd.com>
 <178d29b0-d82c-4b18-a3ed-3d46dcc02446@amd.com>
 <20241101135220.GJ3600562@bill-the-cat>
 <CAFLszTgSX1cn1y3C=QHuVfvVr4486ezaFAL4pmdPAvi6m==Lcg@mail.gmail.com>
 <c5b1aabb-c9e5-42b8-a73e-1ddab887a774@amd.com>
 <CAFLszTij49uGbacoUaqP315OZRO_JvHY5yLuAdKEuV3WeO2GFQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTij49uGbacoUaqP315OZRO_JvHY5yLuAdKEuV3WeO2GFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:802:2::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: cb56cbf0-0d5d-4fdf-4854-08dd1865f39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXh3LzVtTzJtZGR3aFZnaHJjay9XYmRaQ09aN0hQWTVybUpOK2JOcGl4NDcy?=
 =?utf-8?B?U1lzOFh1SkFCN2k0aU9Yck9YZmx0OVlJYVlpd05EZTRqcVJHNkM2Ykg0aCtG?=
 =?utf-8?B?Vk96VVYzbXpKZnE3aGM3OFRDSG8yREN0aEsvMURzN04vT1FtSm9kRlRjNGVG?=
 =?utf-8?B?T3o2VDVwTml6aFc1ZzJvZlRKSTAyRElsdmdoYVFQYWdvUWVXeGtpZUxJcjhL?=
 =?utf-8?B?dmVnZDhyVTFsb3UxOTZWTGZiU2o2eHdWM2VZbGlJdUlIOEtNeklQd2JFTFlp?=
 =?utf-8?B?R1FqK0hKcWI3MzJkR1o3V2c3ZmFwaytaOGVEZS9Zd0hwTlMyd0MwTEkwdDlo?=
 =?utf-8?B?bFFCSFcrL2NaTGJOcS9yek5QbFdjMTV3VGozQ2JCRThkcFp5TDN4bGFqdW10?=
 =?utf-8?B?ZHpjWG5yQ28xRFNBMWJHL1M2aTgwWFpLaVU3ZkI5UXc4elpCZ2F0cVNoYWxa?=
 =?utf-8?B?Z0hNS0xhSnpiWExRdDUwdmtycVRlY3BSWVZVVksyek4xQitpdmhBZXkxbDJQ?=
 =?utf-8?B?SXVlelFwelpwbnVZRmlNeEFSZkRtbTlmc1ZZQkpyRFliRENIdG5FZTJoc0c3?=
 =?utf-8?B?VTdjNldmcUhRVGlmSWplUDF6OHpOWFIvSU9IQ1BCdlBJZEZ2VTNZNjluQXkx?=
 =?utf-8?B?K0dvaTlNcWhKWDUwRFBsWFpOUG05WC9sQWlnSFRsVmswZ29BT3l1Z1JWZDNu?=
 =?utf-8?B?OXJBbFNhMjJGdElLNU02aHhEOThuM1QrRTk2T3dtTVB5eDg1UDBMeENja2E1?=
 =?utf-8?B?OTV5SitOVzBuVlhJM3ZOSGNWVFc5cnBTM1ZWYTNQWmFKSGJDSVVHNThuaCth?=
 =?utf-8?B?aHZBK0hGQllpejEyZFhnb000SjRqNjdYYWZXOFlPeG10T2NmL0ZHT1dvNEEr?=
 =?utf-8?B?UWFIODhldTAxY0lYRDB6UVFlUENIYzlOWkN1bjlQeWNlajNGT0hjeDNtMTVI?=
 =?utf-8?B?d1p0MWJva2NYSDJhcGd5ZzV3ZjAraWV5NE5YZVlBYmNnbitxZTVObmZlM3hP?=
 =?utf-8?B?RHlPKy9vQ3ZIa1g5Z0dueVZJMTI5dGdVampTdWdtQUZiRG8xUnBGSTRHNFBk?=
 =?utf-8?B?SVhGK1Z6NjRCTzdoeTM4NXNtUjAzVEpQcXZRZkNSUHhvd1c4MEtoTkEvZ1lY?=
 =?utf-8?B?c1pyZ3d4TG0vSzdVYjF6aGp0NGpiclBxS1o4ajAvYnNvSlRmbnV3Z0VyWW1G?=
 =?utf-8?B?OSt4TTVFOHkzeFZnTk4xYnFPMGVZVUhIdEhyM2svSWRDUTFCSHV2MDVwWkI5?=
 =?utf-8?B?USs2OFdUeG9iSU1EZTFlN3hUK0dXOWVwQlZzalNZdk5jZU9wbTZUeGMvRDgv?=
 =?utf-8?B?L1djYTNkMzMxRUFFb2JuckN0UzZ1clk3eFRqb2c4akhwZUE1NTNQaHBJVm5N?=
 =?utf-8?B?QVZnVzJUQlRiNHVLRTlQd3JoSTNtNFBzdE1xMUhjWExrL1NDblBiRlU1MXY4?=
 =?utf-8?B?aFUyR2YwckRSSTBxaGV4blNtdXhOc2pwRGx1cndhcUl5dC8zdEtub1hqNmN5?=
 =?utf-8?B?QXhrS2FXTERQU1NqU2JTdThucVhlNHdZV2ZYOHpqOFErZEw3ckE1ZkxZRmJJ?=
 =?utf-8?B?a2prN3ZRN3pKL29rSlA0NUQ3NExBeWVRZjBVWmR6ZkI1dHBma1JISjJTKzll?=
 =?utf-8?B?bHNxWGVRaWY3bWg3QmthRjgxK1hnRll1Nzg0V25BQnBKNkg3OG5JTjFXeFlW?=
 =?utf-8?B?aHBvWDBKclVxdkZQU3p3OUFVa1JKaEJ1YlNLeUJ0ekR0Q1pQb1JDVGJsc3ZM?=
 =?utf-8?Q?JA9pZiy7u66TPfxUZs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0tkZUs2RWlwd09wdndxTllzN2pESmxmZ2dDQTMrVzFld3FtTlJVNmtBWDN6?=
 =?utf-8?B?VVFXaTZOdStQZjAzZE1YaVV6cmovQ0ZsaTROSWhPeFdON2ZCbFBjSWh6cE5D?=
 =?utf-8?B?R202NDhGWHg4UzZPbVBpYm9pM2NuYjVqVnpDZllqSHpHTGlTdEJ3TnVhS0hE?=
 =?utf-8?B?QVhFcTBlWWdORUFYcTVJNitTZWtJdnZlaitOS2F1Y2tZSzNBc3MvZDFTd3Fq?=
 =?utf-8?B?a3FXUG9aU3FoNlBQVEZmTU1udDRvb3BiWGtpNkxPeHFjMTJnOHNUR294YmxD?=
 =?utf-8?B?SXVBa3RwMkVnbU4yT29aOVg2RWVwbEJJMi9lczVFN05rdW9WVFc5ZUFUOXF4?=
 =?utf-8?B?UGx4dEFBcVJDaHZ2Y1VCcXFKRFFpYTE1dTZPSmRSNzdhVmhDMW9NbmlZeU5l?=
 =?utf-8?B?Um5yd2tLMFk3R1FSbDVnekJFT3Q2V1k5N3FiNWlDQXR2dmVNUjZsUjdZS1BQ?=
 =?utf-8?B?MXVVUkhjVVE4R0VIclFuY2dmQ05ZWGFKRTVTdFJuWWl4d1lwcTB5VFpwSzFt?=
 =?utf-8?B?WlNKb0ppVDR3eW5OVUFiYUtaMDl0TFMxK2Q1KzUydGhneU5xR1FOZ2h5Ym5z?=
 =?utf-8?B?emlYakQ5TzJPdXhwMW1sZUpSR243TzdWOEhFYXpwUkY0bHE4M0htaFRNeEp6?=
 =?utf-8?B?NHh4QjVCaFo0NW5CbHNCTnc2VGROYU5KNVRRYVVjS0lPTEJKVEh1U2kzVDVU?=
 =?utf-8?B?Y2V3MFA1M2VxZnpqTDU1MlVHYk9NVFBFbVdLbHo0ajVnVFFRdXlWdFI5bkR2?=
 =?utf-8?B?MjZoZHBiMEdqNElIaUVDaSs3d2gyMXVaSVFjUmlaeGhyUnF1bUF5M3krbVV4?=
 =?utf-8?B?U0R0VGpENzdyUG5nenlraFd1Y2JiZjV4bG92dkFnRWhVMjl2eFMzb1JtNEJQ?=
 =?utf-8?B?MUpXUGNWRU54dHNmYjBwc3dBb2NXOFRyb0hYQmwveWdwRVFpUVVjK2N6amls?=
 =?utf-8?B?K0xVTjgvNi9UVWhyM3lCV3hUNGFLS2ZCeldJb3Q1UDV2WEVwMitIU3EwU2VS?=
 =?utf-8?B?VVVjMk9ubWV3c1JxUHpTd2RJd3kvdEczVzRlVkhMVkFyOW1WRGRRV3lBWFVx?=
 =?utf-8?B?ZEJQMFRkQTQwWVgzZ2FnUDFmdnhxWW9sSVdNS3JVV2RMTWt2SkUzL1RLNmU3?=
 =?utf-8?B?V2pyL3lFdFNkWE9MOTQ3Ny93WFB5WHgyZi91MFN0THRxZWRCQm5DNzMrNTVV?=
 =?utf-8?B?dUN5YUYzZDlXRDV6RHJQdmVWUjV0OS90TTdHZm1ZbW5ZdnZCZURkU3J5anI4?=
 =?utf-8?B?RGYwbGJHeHhDMklnZGlKWDBnS0FDbzFyYzN3SXJuYTNTaHNFcTE4Z0F1d0Vp?=
 =?utf-8?B?cDBETm85T0FMbHBLSE5NTjhDaWw4K3Z6MzYvWjBUY2krU2MxZlpsU1M5eHRM?=
 =?utf-8?B?ZzAyMGFkbms3dHppV0NGMklRTm83QVpGQjhBK1Q5c1F4dE5VVnZiUTB0QmpD?=
 =?utf-8?B?Tk10ZFNrREsyWUFnT1pjNjM2VTVNcHVNMk5ualNqZndRU0VmVFdvakF1VjVK?=
 =?utf-8?B?eHJ1ZVBxcC9BYjhjN3diS1htemk0TDBjc2NrWjlKOUpVR2lnY1YyMWpQaGxV?=
 =?utf-8?B?d2Y2WVJuQlFRWjFVVEJFMFMxY3QrTkY1TXpIYUs0WUxNSHdFT2dYQ3l0eTVX?=
 =?utf-8?B?cDdQUlF0UHRseVRaUm9qQWs1MjErbDB1RG9WSTFyN20rZE9CR2trbC9kVFd4?=
 =?utf-8?B?SWVGcy9HYmhVV0E4Q2JpRDkyTTMrUGl0RklhMm1kSWRiUUdaWlExQ1Z3UVAy?=
 =?utf-8?B?S1Rjay82N1BSZ0NwenM2SUZQdG9ySGNsbElMU2RsdXB2WEt5TlFuT0x5bkVG?=
 =?utf-8?B?eGlSYU5tNGNybEtIT1krR0prQ2RHVXFOWXhKb0FWUmNvL2pSQUNoNVd3T2Z4?=
 =?utf-8?B?NngvQnNmdjgxUnZmV2Y1Rzd6dzA2ajhOeUZUckxVNU1oeTc0ZGpSMmJ2Y3JI?=
 =?utf-8?B?Uk12bnZZS25jd2VZdGlpSnBEMFdTdlFkMW5HSlJ3dlVkUklVTHhOUjlxN0di?=
 =?utf-8?B?RHJhMjIvdGRqSDFQQWZmbmdGbTI4c2t1SS9oajBYL1lxWXVEY0lKekVwNWFv?=
 =?utf-8?B?VFZlRDZhRXlzTVZRVWJYd1k0YTVSaitpMnlpRUNUSjk3ekVsTC9GRG9qellT?=
 =?utf-8?Q?/qt7FFT214gvB7NDYCTe/2i3E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb56cbf0-0d5d-4fdf-4854-08dd1865f39b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:27:11.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUXLIPnarEc3tk9HcsHYhFdYpltboqN+VSgCfdFwgzpEHxMqFS82imTALhn8nzrK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
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

Hi Simon,

On 12/6/24 20:17, Simon Glass wrote:
> Hi Michal,
> 
> On Mon, 4 Nov 2024 at 01:32, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Hi Simon,
>>
>> On 11/2/24 17:28, Simon Glass wrote:
>>> Hi Michal,
>>>
>>> On Fri, 1 Nov 2024 at 14:52, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Fri, Nov 01, 2024 at 02:09:38PM +0100, Michal Simek wrote:
>>>>> Hi Simon,
>>>>>
>>>>> On 11/1/24 09:27, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 10/31/24 19:03, Simon Glass wrote:
>>>>>>> Hi Michal,
>>>>>>>
>>>>>>> On Wed, 9 Oct 2024 at 10:33, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>
>>>>>>>> There is necessary to do some steps to compose boot images. These steps
>>>>>>>> were in scripts in layers for a while. That's why introduce description via
>>>>>>>> binman to simplify wiring and remove all scripting around.
>>>>>>>> This should make sure that everybody is up2date with the latest versions.
>>>>>>>>
>>>>>>>> The first step is to create fit image with DTBs with descriptions in
>>>>>>>> configuration node which is written as regular expression to match all SOM
>>>>>>>> versions.
>>>>>>>> Description is there for k24 and k26 in spite of low level psu_init
>>>>>>>> configuration is different. The reason is that it goes to u-boot.itb image
>>>>>>>> which is the same for k24 and k26.
>>>>>>>> u-boot.itb is another image which is generated. It is normally generated
>>>>>>>> via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
>>>>>>>> be deprecated.
>>>>>>>> FIT image by purpose is using 64bit addresses to have default option to
>>>>>>>> move images to high DDR (above 4GB). TF-A and TEE are optional components
>>>>>>>> but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
>>>>>>>> by some configurations too.
>>>>>>>>
>>>>>>>> 3rd generated image is boot.bin with updated user field which contains
>>>>>>>> version number. This image can be used with updated Image Selector
>>>>>>>> which supports A/B update mechanisms with rollback protection.
>>>>>>>>
>>>>>>>> 4th image is image.bin which binary file which contains boot.bin and
>>>>>>>> u-boot.itb together and can be programmed via origin Image Selector.
>>>>>>>> This image can be also used for creating one capsule which contains both
>>>>>>>> boot images (in SPL boot flow).
>>>>>>>>
>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Currently I have this for testing purpose only to find missing bits and
>>>>>>>> pieces in binman for cases I want to support.
>>>>>>>>
>>>>>>>> This patch depends on
>>>>>>>> https://lore.kernel.org/r/ fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com
>>>>>>>>
>>>>>>>> ---
>>>>>>>>     arch/arm/dts/Makefile                |   1 +
>>>>>>>>     arch/arm/dts/zynqmp-som-binman.dts   | 224 +++++++++++++++++++++++++++
>>>>>>>>     arch/arm/mach-zynqmp/Kconfig         |  17 ++
>>>>>>>>     configs/xilinx_zynqmp_kria_defconfig |   2 +
>>>>>>>>     4 files changed, 244 insertions(+)
>>>>>>>>     create mode 100644 arch/arm/dts/zynqmp-som-binman.dts
>>>>>>>
>>>>>>> I'm pleased to see this. My only suggestion is to use '/bits/ 64'
>>>>>>> instead of the macros, for 64-bit values.
>>>>>>
>>>>>> When I was playing with it some time ago it didn't work but it works now
>>>>>> that's why no issue with it.
>>>>>
>>>>> One more thing on this one. I pretty much dislike that images are generated
>>>>> to u-boot root folder. Isn't there a way that they will be written to
>>>>> separate folder (deploy for example)?
>>>>
>>>> Or perhaps $(obj) ?
>>>
>>> Yes $(obj) is where they end up today. I consider output files from
>>> binman to be on the same level as other files created by the build.
>>> Then again, it does end up a bit of a mess, when mixed with the output
>>> files.
>>
>> Some cleanup would be good. I remember a lot of discussion about if people
>> should be using u-boot or u-boot.elf. Answer was simple but if output images are
>> in separate folder it would IMHO better to understand.
>>
>>> I am not keen on 'deploy' as it nothing is being deployed - also it
>>> sounds like a satellite or military attack.
>>
>> No problem with different name.
>>
>>>
>>> One long-standing issue is that intermediate files are created in the
>>> same directory. Perhaps we could put those in a binman-tmp directory?
>>> They are necessary when things go wrong, but don't need to be used all
>>> the time.
>>
>> +1
>>
>> But I think we should try to move also that images which users should be using
>> to separate folder completely. Again it doesn't need to be done by default but a
>> way to configure it would be good.
> 
> Perhaps file an issue for this? I haven't got to it yet.

File through what? Do we have any task list somewhere?

Thanks,
Michal

