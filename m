Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44782D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D924689597;
	Tue, 19 Nov 2024 14:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Om6GUrXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60969895A1; Tue, 19 Nov 2024 14:36:34 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0259289596
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuXnN48py28tBqFHFWf1OH50RKGMHordsdcegq7ToFBMcPl6T3R/CfZ2FhioNy4jOeFgtAleP7ZvFk/HaXxf7t3PI5UI+dhqdgvDS04b1RdwBzIy4nsxo8lLg5b4mpWAn7D/yh/VNQ3h1vDUWa0/kkogvtNNSk20iH9d7pAVebBASXjxdi3BL41Dnrr3IDCS/Ypwlurjm/z4NN+w3sMZCU4QIyqtGKjDtq/oOf8yC/faSENceHeXPCexpuLrdH4+JKb+vbxW7gO5ATlbEgtN1bQ1wxdu7vLQtMnSlc9s8sziayUoSWvTUZZE/gRUkkBC7XFReCCJt+2/Gjkp1iol/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHbR3uLSf66wAyphDuzU6eWEcPRBBPsJJ8FIQAm0NaQ=;
 b=TdMx/sOoW/iVsqo8X/x78Efys8dxtJxpzfMOsd6UmD3thokZsICq2EnrCtfs6nR80sV7Fy7O18JFKXFDzdQwoTPRgcQcoImhAJ0D7S6aIqeenIhlV749MXFEdZXHHZFJZcYsqx9ffaFZdGdqbsyXOgd2As60sQrJxJVev4/fGCTztL5Vc5IMJ/ZsmhwFsokdh6cSW6lVY5hUVHAacsAAV9ucBZKbNtSHdx2pG6pey0iIXUl44Bm5GQ4KS5BcDxyoXD+DDDMOTu6eUony/DhReURAprs+K0DQnSInpxvgMHYFB7JyM6ddIC0+nQj8L4n0JkmElctfxt+cZNrRC4l3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHbR3uLSf66wAyphDuzU6eWEcPRBBPsJJ8FIQAm0NaQ=;
 b=Om6GUrXASKLrLZSqF5uFAgiTsT/W9s4muD0HcEhSHvnswRuy8lwZbLC9BdBcpkoPUq/pCveDbQAzNSSq2GyFBMVGiJ6pc+l/NAkJFS4HBHKXpYW+sdnBEHYMlBuIGxJmkwseFkUiGmjG1Bu2Fb4QBqEPec37MiH/8UO2X5kmU1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 13:36:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 13:36:27 +0000
Message-ID: <b425c5e0-47e1-467d-a678-cfa5b853d9a2@amd.com>
Date: Tue, 19 Nov 2024 14:36:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal: Enable defconfig for Micron octal flashes
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
References: <20241114051047.13700-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241114051047.13700-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd04e4d-fc76-4c60-debc-08dd089f2ace
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTlpSys1UjNRVFZGeE1jd3Z5S080YXJoSXlGTHNySWl3bnVnLzVwUVgvTVlm?=
 =?utf-8?B?dnF2VEVxRkFJT21EUnBrbk5vQzFLNGJUZkZJVE8xdXY0Tlg0YjgvTFdsSDY2?=
 =?utf-8?B?ZlJ2Q2dEa2I0bWFRQ3N1VVZ3eUhuTFFhUnFyMUxNdWRtdEczWGo2anpCNHJn?=
 =?utf-8?B?Y2U2ais5Zk5ySEtLclBsUWF0c1RpNkZsaCswME9uWGRzU0VRdjExa2dwSkUv?=
 =?utf-8?B?R2dHTTFRUGs2Z0pnWWxqRlVoaDUzUHZCaHFNbkQrdk5mVE5wTzJNam5tTkti?=
 =?utf-8?B?VG9iV04zRTBYR1JEMFBuTUxsT29xbmo2Nk9wMVcwVDk1UHhWZHhUWWYrRHZ0?=
 =?utf-8?B?c0EycmQrUWV4V2JlSGR3emNQOHErdmE1UFBNR1pCRGF3NHdRTjhDQklIdlVS?=
 =?utf-8?B?VGR4c1F2dnliaXNhMXFOQWJ1dHdOUnhITjRiUlkzZDRmbjN1KzlhczVtSEJV?=
 =?utf-8?B?VHdrOHcxRWgycGphOUNLRTBYWG9rTDNhdmQyK0swZmtyN3JaOFFTMENBOWcv?=
 =?utf-8?B?NnduaHdERGxQaXc0OWpIbkpUcjVkYXl1Sk9rYzdobXpBUXJQRUdtNzNwdW9o?=
 =?utf-8?B?cDZpZ0FnNk5tRGFrSzJzL1plRVJmdCt1ZWFCNGRDdVBnbGtoTjNKQ0dmU0lJ?=
 =?utf-8?B?allYdkozYkJmaFM1WEQ0MEZVMFRwNjdKVmdqMUNtVkJqZnI3WGlsbXBxempt?=
 =?utf-8?B?MHRxcjI0aWFDaFVtaXo3Q3hXVjFnUzh2bFJ3OG9nZGJQRHc3MmhCb3hidlU2?=
 =?utf-8?B?TkdJeTBqMDNMM2ZzbmxZODlPaTcrd2M2ZnBiKzZ4enkzTE5CMUx0OHprblZC?=
 =?utf-8?B?Q0trWGlYUXI2S1ZDaU94M1pnSHhZK1I5QTk5WDlxbkJZY2xjbWpGbEJWQ3JZ?=
 =?utf-8?B?RGZLVlovOHZ3QWJiS01OSTJ1QzF3MGR2V08vbUc1L0lrTHhmTlNFTElXdEdO?=
 =?utf-8?B?WXBocjIwZU94YjNhcHBkTk45RW9DYkhYMDdJaHBGRkZVVVpVcWVoYzd6SENv?=
 =?utf-8?B?T1FNVWFhVVdLNmQvWXpyYnJjTnNNalVQeGJLa0RibTYxYTUzQ2w2S0ZESEF2?=
 =?utf-8?B?RE5kY1N2OGpiS2oxMzVza0hJVFdsem90Lzl4Wm1NN25iZXJ5c2FKZmpLUkZV?=
 =?utf-8?B?NERnMDNES2N0ZS9mNXE1YzVaYWh1NDhmLys3VGcwc2NiVnp1ZnJraWUwUnFE?=
 =?utf-8?B?OG1ZcEtvMVhMc2pyV0N4NEJCUDd1em9vK01leklaQWFLbEw3cy9vQXJ3VDhm?=
 =?utf-8?B?bENEZFhHNis2ZmRQUGhaUEVkS2k2ZVdyY0tOejUyam10UHVtWWVhWVpFc3lN?=
 =?utf-8?B?Z21ERUdJRUYxTEdrd0M3bmQrb2pKU2JpeXRaOTZ6ZlU1VWVBMEFGYmpYZ1Fq?=
 =?utf-8?B?M2ptaUNkb0UrYTBZdmJGdkFpR1JiazJPRWtuODY0YWZVVGM2bHpFUjF3a2pH?=
 =?utf-8?B?eGFSYmlleG8rU1pvL0oweWhHVGlHaERDdEFScVZTYllGbDhjc0orRXVXeXBt?=
 =?utf-8?B?dVJIS0d5NnR1MGNrT0hDQ05BaE91SXlTQ0FkR043VHlHU0ppSTdlVjJ1WGJ5?=
 =?utf-8?B?YjhmU2l0a1pOQTlEVzNCcjVqSWRaSjVveUEyY01DQStDYjhtb1RUWjBQbXBJ?=
 =?utf-8?B?Z0JseXpGWHBNelRWMjhZT2lYbWRmeFhJejdGbTFEclU5VkhPcWdUZGdGd0JW?=
 =?utf-8?B?ci9oRDJEUUQwU2phSlpMMitvcWMyc1Y3MkUxUHFaYTlCcWJvWFJZTHBwcE9M?=
 =?utf-8?Q?8e9ysKMcR6LokJJeS9c10JUY7ysbXlJ7n80SBgd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWhjT1oyQjAyT210S1JpWlRLRFlRUW50MGVsVXMxVlNOak9uT3hGeGt4Rnl0?=
 =?utf-8?B?WEwxOGNJejVTcXZ0dENrRmw2NVJONFhSYS9va3BBRkN5c3lPYTJ1UnFxZStD?=
 =?utf-8?B?Q3JoeFZkR09QS1UyWHY3dVVXeGZmakZhM1A4RUM3NXVXUnBITytnbElpaXpv?=
 =?utf-8?B?bGdVT3ZLRG5LMUQxMFFpVWdFQXQ4S0ZjWDlVZ0pRb0lBaE9sSy95V09HVm0v?=
 =?utf-8?B?Kzl0cDRzdDJiblhrRlkzY08wMjFTNWI5VDQ2VzhZd0Q2OHFoMFBYajhUY0sx?=
 =?utf-8?B?UkUxTFVadGRzbGtwbW10ZkF3TE4zdWFlc0x4K1RoOXo2aGRIckczTWpYSkxn?=
 =?utf-8?B?RDlLcTF4VEVzb2RJYVBKOWt3b1NuUHpWTU9oRWlUQ1I1NmVpWHhZeFFDZmN2?=
 =?utf-8?B?YThrUzZPcHhLTlZCcjV5QnFJS1Z5QlRUWlNUeEoyOXN6cjJxdWEvWGl1RTRX?=
 =?utf-8?B?TDlVdEhrRG1mT1VTMmhxWjkrYjNLUE5SUG9zSWl2ZW10MVlhNHR3amZ3TkRs?=
 =?utf-8?B?cTl1S2RjNDIrT0JMQkhOdGpJcUd5SkxsY2NZN2dDRkRJZUlMNkxVVVU0dTV2?=
 =?utf-8?B?UTNMUDJuaHRaUzZRT1dFemlHVkZYcWlrU1M2M0k1NUtHVjlRZTlwQ0lFOW9m?=
 =?utf-8?B?YjBJbFdsbk5VdStTajA2SzBiWnhhMUt3UkY1bWFYOUFlS3lZRVdtQ0RWVlFP?=
 =?utf-8?B?cFd0cmFTM3kwck05SGU4dDZmRHhMemd6aXJseEljQXRXQUltb3FzcFpTaEtP?=
 =?utf-8?B?MXNzOEdrMFFQR1cwYUI0MU9QcnVhOXBydXhXUnNOS0NUUWZEOFdrYlFVK203?=
 =?utf-8?B?WlByeEkwNFNvOFlXbGxvRzA2UllLZUJLMXVyYytVNWJvNGhJbSszTVBlRDJL?=
 =?utf-8?B?KzlvemNXUEdlaG4zeDd1K0lEajlSSC96Z09ON1FsNWwwWTlJbDlhRDltSVIy?=
 =?utf-8?B?WFkwQTBsSk9IQUJYb1BrWFNpMUtFbCtKY3lSdmZCaFArVUtZdTNoRzZkQ21U?=
 =?utf-8?B?YWhaUHlabUFvQ2FYUjFCMC9McjlYNHU1bDhJRm1vV0dyNDYzYzJSSlo4VmMz?=
 =?utf-8?B?UGRJWTAzK2lXQmYvZ2Nzb3BDK0FTRUFhbUcxVEUwbnZHcTdlSGFXay90Qm4v?=
 =?utf-8?B?YWFQK084SlpKMnZwMVl1MXJnRTM3QzEydlhWRVhmU2JOTWU0dHhTcWp0a2g0?=
 =?utf-8?B?amgyQ3dKbWcrVDRoVGpTT0FCMUxpWmVaRXBxVG43NkZWYmdhMmZIRlRwVzBu?=
 =?utf-8?B?ZHVFRzg5RG5UUzhodS9zMzVZZ3Z1V3VaMzhyUHJOaTViWkNZSStYU1lHMUVl?=
 =?utf-8?B?NXFoVU0vM0dpelBrM3JHU21Cek54amdlTUR6aVN4ZlJhTzdxSXZaN1ZyMERI?=
 =?utf-8?B?RnFDUDF3a0IrT2RmSW1jdTRmZXRJdzV6eVFZek91STdCQitxL2JEcHRjTVZ6?=
 =?utf-8?B?WXlCV2d5TjZ5THprS00yaDI0Vm1vcHJxdFduR0pnenZIbWJyMmNTcnZmbkpx?=
 =?utf-8?B?bUs4ZUt0ZmhTUk9Xbll3SkhzMGJ3YXRwaUY3TmUzSVYvaW4vOUFoTGYxTEpr?=
 =?utf-8?B?VUdzR0ZkYmdSTVFLYUw5K0Q0cDYvR1p3eFZETEJCTzJxSFZxRnpFOUl4SHk5?=
 =?utf-8?B?M2tHV0craitjanYwZ2hIeWNWSWZPZjFYeEVGbS9veXFEclV1aGJDS3pzNnho?=
 =?utf-8?B?M2FZSjFkMmtXYU1ZcVJVZXRyM2RtNktQSmo3R0RJdGU2NkpnUHk3MGwzcjJG?=
 =?utf-8?B?aGY4TVFsTEo4ZVBDMkJFWnNNSVdNd2V2eWM0RGNFTjJTNmg2aElkQTR3ZGor?=
 =?utf-8?B?YkM4OFFNbndDRlNQaWlYVXkxNWpncG5NUEZHMzJ1YjFLVU0vR3ZnWWtJMUlq?=
 =?utf-8?B?RVVYNHF0dFVWeGZKeG15alk2alY4SzVSMUNiMEUrUlAya2diZGFJeHFaWGJS?=
 =?utf-8?B?aE1zVHZoamRvRnBNMWYxbTQ1dlE2MGVEaWI4d2o1dzRyV3dWK3pjQi9KOXlq?=
 =?utf-8?B?RCtSRWZQZFlNdWJCbW41dWZyUThYMENGRmkwVGZOTm4yYzdZQmd0Q3JzelNy?=
 =?utf-8?B?K25yMEJHZGZjNkhlK3pWT1N4TFVRNGp5WGVQc0l0aDFjQThYamRDaGJZM2pm?=
 =?utf-8?Q?rTBQ4jCESw9OYaFaNj9TC/gtU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd04e4d-fc76-4c60-debc-08dd089f2ace
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:36:26.9859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ps0hNOgFNvvWW/riqf2il7XLn/pkMCt8zWWDpdEiBA7E7nEX3nYrdu6iBKOEGtRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
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



On 11/14/24 06:10, Venkatesh Yadav Abbarapu wrote:
> The Micron MT35 series octal flashes can be activated
> through the configuration option CONFIG_SPI_FLASH_MT35XU.
> To ensure their detection, enable this option in the
> default defconfig for octal flashes.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/xilinx_versal_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index f220cc0254..fe25b518de 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -104,6 +104,7 @@ CONFIG_SPI_FLASH_ISSI=y
>   CONFIG_SPI_FLASH_MACRONIX=y
>   CONFIG_SPI_FLASH_SPANSION=y
>   CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
>   CONFIG_SPI_FLASH_SST=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set

Applied.
M
