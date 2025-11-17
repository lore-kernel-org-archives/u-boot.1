Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D855CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 10:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90BEF83A3D;
	Mon, 17 Nov 2025 11:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Qb665mLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094E983A8F; Mon, 17 Nov 2025 11:04:00 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF9D839B1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yV0NqcWQ95olWwme81T5v1KNYqLyRGjiE+8uOsjCeZybGhCVNIF/nl5OjEBc0NB8Wme58jC8toPDn+1FMK9BvHSvd+NeA6kp5E2XNbx+uG564QIqr0KGjojvFZlw0zZIGZmzVO39ZjeS80YqBvMD5FKCRyDeG2/gEe0ovPx9vvp80yQVMdYg2kwgq2YITrbG48DpiaFjqBlPEeEhIO+OTU4uM4e1DNgLl7aFoehvD65ViSTcEDFiw9qocWgyPumptjNPChq/2Eo9b11i7l0X5Stuj02d+edLVnOSzP6WLvqbfoD5sIZgJbiPFh4oZPC9HFUGHpkQUfmwkIKdGT5sxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZLnPunJXlGFzcWqZgc0DfUHQYYoKUYCrnJsXDrplNM=;
 b=VPCPF7ODvjF2b1iJmT0N3GZ1b9FvarVbd5WIx1+1/9qaOStr1FakLXf169qDPZb62ohgG95v/zb4j0SWTzrAxvBjI5s49BW0MDu+RSeJsT9HztlPYZxRj5ZXG9Q4chd1m2i8g48M+USxR3oRlIXsWuQb8QNCDnUxp5H3Y+hj4eoyJyxx1bq58+/Az6RfU+2zuDfH6gKP370P9qX81lD6n8FMAaozq0HDvV+5OS5X4UTsrD93VZ9UwtHSW1kH0jwPaeYR1QQT/A+NcLhdCmY1xrZ8Wyeb/e9dEHxc2cebUOktCIyKKf5+tle/Dss55+l6JeZ6pupEFhrTagOTwczLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZLnPunJXlGFzcWqZgc0DfUHQYYoKUYCrnJsXDrplNM=;
 b=Qb665mLb3Ci2JpVQ240JoarDa4zerJtzAdNA70GiywhSaBwEefaaI3jIDbiTNGe3u0TbkrGop+RwzQvURVtSuT+XsOrziX5R0Yolq7AtgoNsyulBoCTKzYgvciTiWWXloLX0ZMMdzCjH87um+ycsNkZTiX8waW87blGsaNVYi3hH7QuOoioVigQiuG0Z1bbEVS8pYTZlhXFULbAR99tyjyFkhrFb+RHOcihORNGYVXh6nwldLS4U6Gv8vSBdW7Yd9D2NWCKzqAlMG3ce1MbP/cYqbqU1t9s6U8FVL59EvusitlKy4FiNTOqHzXo+Booz6Slk+C7IdWiLJCd0uBLUeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA1PR03MB6545.namprd03.prod.outlook.com (2603:10b6:806:1c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 10:03:54 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 10:03:54 +0000
Message-ID: <6d0f08c1-6e83-4245-b88b-07d31a61bf59@altera.com>
Date: Mon, 17 Nov 2025 18:03:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] spi: cadence: Add driver for xSPI
To: Boon Khai Ng <boon.khai.ng@altera.com>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Tien Fong Chee <tien.fong.chee@altera.com>
References: <20251027063654.27188-1-boon.khai.ng@altera.com>
 <20251027063654.27188-2-boon.khai.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251027063654.27188-2-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA1PR03MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 92464b76-8316-4333-5f52-08de25c09d83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmc2cFBkVmtvRUJ1Sm1UWElPZGllTHJSQWx0Nk96RW94d3ZMM2pnRWc2WFFM?=
 =?utf-8?B?Q0ZQNFh4SG9VY0pobWdSU0ZNMm1hbjdjaTdvVk1udEplNWV3RnNuS3ljOFJT?=
 =?utf-8?B?TTFGMk9lSlZUNEdJM3VadXJUTHBFYVhUdTRTQW9iY3V5VWp1RjBGcWo4QmF5?=
 =?utf-8?B?a1FnU0pPRElLOFNRVWl4dXJ4MGIycWZZQ2J1MmlpWVhqN2VJTmEyQWkzRDRU?=
 =?utf-8?B?TTd5YnRJTzJoWnA0Vmw3dkRVSjFqaVhMWGRsZEUxT1VTSWtBcXEwR3JnZzFt?=
 =?utf-8?B?bndNYXJwbU9vY2NMUklIdWwwOVlON2dxVTk1ZU1sZmtMbVM1aFo4cFlHbHI0?=
 =?utf-8?B?WjdpY21TejlFZnFuWEpJbXZjM2xBdDM2MHVRNVc1M0k3NVpsWjN2QkNQQ1BY?=
 =?utf-8?B?TE53Uk5sbldJbk1NeFJGQ2ZoYXViSXJyU1praG9wb3AvR1V3YUx3M1RiTkhP?=
 =?utf-8?B?K2hRTHVnaVJOYXUwbUJtY2JuOTlRL3p1VFM5bHlxUGRwZlJnS0xIalZLSmpO?=
 =?utf-8?B?eXE3WXJVbUlpaEJ4dC93RkxJZE04Wk1kUkpCVkY2QnAwcGVNRWpzWExqNWxW?=
 =?utf-8?B?SjZSeHR3K1FRWDZid1RxRDFVZmF0S3NoaC95RHFwbTNtQmZhbERjM2ROcEtm?=
 =?utf-8?B?T1hGWXNCV0N4c2cvNWZ6Uzc2bzczdFpWVW5RbkFGdWNNNmY1TXlQd1Q1VzVt?=
 =?utf-8?B?SkNVNHUxSzl6UkFQU1o1SVY4MVRnQWtIWnpFd2QxeUZLZTAxb1g5U0Z4YnRw?=
 =?utf-8?B?bW1JY0prM3RGakdlRE1RdG5Eb1Q2ZUtxZzVhTWhpK3RHK1JQWVdWek4wNGtE?=
 =?utf-8?B?SG54T01IV3I4aWtPRWYvSzJlZzBpdkZLdUlhZng2dE5ZV2kyNC84bzUvaGhw?=
 =?utf-8?B?bERsWEx2YUJJY0VDSGxMSEdkTEZOWmZWZTB6dk5TbWM2WlFNUFkrRWJjNFBT?=
 =?utf-8?B?ZktQMWNIck93U0dsbHM4bTl1TThOSFNDb2t3YWo4THpDT2dySlVKdE1oNlJi?=
 =?utf-8?B?UU1KRU5jVmtqaGV3L1laUFBPQzhpU2VaQWwxdEUvdS92ZDVYUnVsWDFSRnY1?=
 =?utf-8?B?M0hheFJTWGpuZE1xbzBPU0J0b09ZdUp6L1BML0lLQjB1OUhIR2pQN2NOcjlT?=
 =?utf-8?B?dlJ6aUFQcmgzcm5ONnlFSWtUVytkMkFWOUtoL25lRkhuVHNZZllWYm16ZUVq?=
 =?utf-8?B?S0E4MUpiWENVOVJBRHRnYlpXcGVqMkM4eStiOEIzL3QwV05vbmZGb0xsYWpk?=
 =?utf-8?B?OC9MdzlqYjUzVldIQ0E3R0lycDcrTk5HVldVeURVM3FFMFNxUkhBeldZNWx5?=
 =?utf-8?B?c24xSWlZNUhlcnFweFVmeHR6dWtiUWhOUy9kVXd5NmMwUUVhYld6YUJNbm15?=
 =?utf-8?B?NE4rVnFlY1QrR1d0SzF3NmREQ3NEajlDTlVpRjhmaEpxTEt3RnoyanBLcmVI?=
 =?utf-8?B?d1Q2TUN1THN2ZzZOM2pwZjgxK3BnZ3h2RjJvdUZNUG9PWTNGb3lUZDJ0UGJ0?=
 =?utf-8?B?QUJjSjgzY1oyVGFXbTVIL2ZRWWgvazBnaWY1aWhieS8rQWdvOUFmV0htSVJR?=
 =?utf-8?B?b1Jsdzd5MW1EbWwxcHpJTTlXZC9raDR1eis0QUFRVG9yeG1HMXN6cTRRT1hS?=
 =?utf-8?B?Q0pzZURaQ09YQ3F2ajh3SXhrS2t6WGsweWFoZ3RJaVFFZ3JWWG9HL0ZuUUgv?=
 =?utf-8?B?VkVWLzBmK0ZibGYvb3Nzc3gxZldSaHloRHl0RlU3Q08zdU04K1htV0ZyWjZS?=
 =?utf-8?B?aEtnUmVJZTlrTnVyN3h6YVhZT3l6VG8rd1A5NDhJTTVXS3poUlJhanFpZEFO?=
 =?utf-8?B?a0tQcjVoWHRwcU5nMjZORGl0YVdRUE9DbGU0Rm9VOUxWYUtUTGhMNG5sbmdo?=
 =?utf-8?B?TXhXdUp5S2tVTys1VUxGNFBNN3JqSkxTRGJNMjBicmpHTmhEMEJOcUhrUlhJ?=
 =?utf-8?B?cENobks3Z1ZOYTVBM1FXUkJVOVpsRERCL2wyYmJiVFJhVjlMUkJRcngzclps?=
 =?utf-8?B?M3lzcHRRNjNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUlRaDc4cVZGVU9NRkk0RHJQaGp0RFJ0UnEwamF3UC9UZ3RLRFlwWFpVWG5Y?=
 =?utf-8?B?MWcrZTV3eGF2bWtkc2FZRHF2bEVSbVo0dzM1OENKa2d0K3FaUzFYaHo1OHU1?=
 =?utf-8?B?WURFR0NFT1JpN3doNzNTV241aHB0cTNJZGx1bCtpQS9uYzF6R25MVHorVzl1?=
 =?utf-8?B?anAyZG1uZS8rTmxOZWUxaTdkU3NEcjAxSjhub2dJU0xBZ3FrRXhXSSs0YnRR?=
 =?utf-8?B?SHhBa2JiNVhQUE1BZjQxQy8rakp2RHFOcG53aXFDQWxRZmtQZzJobktIUjBQ?=
 =?utf-8?B?eFF1L05hbkxpWktxck1jRHgxRVZiMDdsUFV6eFd3a3F6UUI3QVVqTk1vV0Vx?=
 =?utf-8?B?c0ZKV1VpUExUbnB2NjZtSWF2RTdnVHVPamYwZFlvYUZzYlhqaW9LTHRZUStB?=
 =?utf-8?B?U21wSUlzVWtDT0lTUVU2VFZKZlVpd0RVWVZqa1d5ZWZ4ajA1WFh4R1MxVDhD?=
 =?utf-8?B?c3FOa3I2UWRvNFBqVUwyWE52UEw1dEc5YTBhd1RBcG9iRGlQRzFjUDc3SEtx?=
 =?utf-8?B?VitvWmtiNDc4bFBGQUFyNVR5WHdBb09aY1U3VEY3dHY5aHg5TUpZV2REZWZM?=
 =?utf-8?B?ZkFXVmRldHEzVThEeStPaWZVbWd6ODlwQnF3ZisvK2lYZkx0L2JLd0JoQUsr?=
 =?utf-8?B?ZWgybVVqRkpOeUFUNlRNMEd3akd6YzRVVkdYRGFxU2c3UVBMdFp1MnVML2xV?=
 =?utf-8?B?cEt5N1pGc1hhTHFIWk80dk5PcUd3c3FDQjg3UzNEVWlEVHpodHF5ZVNYTmNo?=
 =?utf-8?B?K3Y2bWxDZWhzU1RTUVcyZlR2Mm03ZlBjSWRDY1BWTlJZTHVFUlJmcHdHT3dP?=
 =?utf-8?B?QUt4czJsTGkyVko2VHJ2SCtRWktsNEZ6TDl5dkp6c0haZ0ZwZjdmL1Zqemho?=
 =?utf-8?B?T1ZrYS9iMGNSNkcrcVF2MnB5RkJ1cFo3QmExRzNMUk9RZmV1MWp5aGpZQ2Jh?=
 =?utf-8?B?dVo4RjZGUnRJT3BCcEc5TENseXduVjJkTWQxOXM1QkVqSENlTWNOWFJpdE5l?=
 =?utf-8?B?R1JtNEVjdFRlY29BZWxBYXR6KzBaZVZuUUlSNU9wZ0Zzd2xOUzBjaE1vSVdY?=
 =?utf-8?B?dThPdElTdSsvMndCbDVnOEIzbmhic0dYMC9pQWFEZWxmRDhOT1F6Z2didkdi?=
 =?utf-8?B?dUdNUVE0K0c4ZytRakpSOThuUTdLaTRmUHUzb1BiQ1ZRNWMzRkFTVHBFVVZP?=
 =?utf-8?B?UGVjRENFRFBRSU9hbGhaU1VKMjRVWllVU0dRUUdIclRTTEg1T0pwSXpiNU9R?=
 =?utf-8?B?a3dNbVgwRWtCZWhXdzd1eVFBTk90bW9mM01MNmVFNFNlaVUrenJBLzVhS2Zp?=
 =?utf-8?B?RnRmL0JaSHQ2eElaK1Y4bGdic2NtaTJvRHpYSDEwOEIyWEZoNmQxb3h3RS9C?=
 =?utf-8?B?T0YyUGRVQnlzWUhLTHNUQTNpS1REajJ0UXk1YnBrYUZRQ2lUZHVtVVBDSVpj?=
 =?utf-8?B?VE55czhxVkhXV3huY1FGOVJYcG9oWGRTQjlOUFZlNlBPcnZOMitER2VWNjBz?=
 =?utf-8?B?TFJFSVVkZWFySm9yQjJybDRaU3NzWUc5SmhWamxjZVRabUEzekdGWVNUVGcz?=
 =?utf-8?B?V1ZjRGhLTnZFK0hkL0xEZjd4WlBrTHJTcmxWZDNhcStyckVyNzJqcjJEQ1dt?=
 =?utf-8?B?YXRqNzJlaFZMUUdiWWJLVktHbTFlRU85WlZJTjd3RGpQRFhydG40dGFTRFlS?=
 =?utf-8?B?WENHaXRNMjQwL1VnWi9vNW1IcHRWMHc0ckcyRHk1L1RjRFkzdzBDZ1BncXhn?=
 =?utf-8?B?aW5UcFJOSktoQXpqQndqVzV2UTVWU3ZDMWprUWd0T0JCZ2N0SmpaVUw3TzV4?=
 =?utf-8?B?UGJURWFBVDNPZ0pBZHBZTzdwRUZTMHhnSWR6SWpkV1dNa3lNZkQ2V2FlRS9x?=
 =?utf-8?B?YXB1VzFPc0x1VHhJK1NJam53TmJTREhGK2U1WSs0T3VKL3BsaFBOdjNJOGts?=
 =?utf-8?B?YlFzM1JCaEVTUkxKdXU1RkRlaVB4RW1WMzdTd3NzWTVWVW9CVm4zK2g0OVZB?=
 =?utf-8?B?VU56L1I2TWw4Q2IzVlJtREo2OEVhTU9KNDZueXZBNWw0emJpNTQwMGJDU1Br?=
 =?utf-8?B?R0trZThIQzRTU3RNMmt5T3hvVHFRaHpFTDRUSUlrLzVBaTlxT1FFMFg0bGlP?=
 =?utf-8?B?aloxa2hHM0xQN3AxbmlYOXIzbjdLQmk5cDhQUWNGK2NlOGlvcVl4Um5wbXpp?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92464b76-8316-4333-5f52-08de25c09d83
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:03:54.4549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvBaoXnbFnWS0BBb2R5y0PPbnhgcyPXxfE5M8ZPRQBYXypWyc6XfKx32CPV1CktXhz7dlMvGSiKpfmhQmZ/oM4UX/EuSMoZbGDF7GpdLiqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6545
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


On 27/10/2025 2:36 pm, Boon Khai Ng wrote:
> This patch ports the Cadence xSPI controller driver from
> the Linux kernel. The controller supports three operating modes:
>
> 1. ACMD (Auto Command) mode
>     - Includes PIO and CDMA submodes.
>     - CDMA mode uses linked descriptors for high-performance,
>       low-overhead operation.
>     - PIO mode is suitable for simple, single-command transactions.
>
> 2. STIG (Software Triggered Instruction Generator) mode
>     - Issues low-level 128-bit instructions to memory.
>     - Uses the Slave DMA interface for data transfers.
>
> 3. Direct mode
>     - Enables direct data access through the slave interface
>       without commands.
>
> Currently, only the STIG work mode is enabled. Additional modes will be
> supported in future updates.
>
> At the same time, also enabling the kconfig option for xSPI driver.
>
> This driver has been ported and functionally verified on the Intel Simics
> platform. It is intended for evaluation and experimental use at this stage.
>
> Link: https://lore.kernel.org/all/1632038734-23999-1-git-send-email-pthombar@cadence.com/
>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>   drivers/spi/Kconfig        |  15 ++
>   drivers/spi/Makefile       |   1 +
>   drivers/spi/cadence_xspi.c | 449 +++++++++++++++++++++++++++++++++++++
>   drivers/spi/cadence_xspi.h | 226 +++++++++++++++++++
>   4 files changed, 691 insertions(+)
>   create mode 100644 drivers/spi/cadence_xspi.c
>   create mode 100644 drivers/spi/cadence_xspi.h


[...]


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

