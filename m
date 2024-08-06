Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA69AC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683B188A2D;
	Tue,  6 Aug 2024 16:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GSggyPz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 050F088A2F; Tue,  6 Aug 2024 16:16:11 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FDA88A2D
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubucXSSV5Pw8vpSnx5RHX0sUroaKjHmRXEojed3Yi/w04XTw4HW9WqPDu0TTHvF49SGrTRAw0JblXI7pBjM7ye7mZhEiyKexMlGBgI+7G2e1vPQheahByIKVnFAfyiXIixRGwdo3K9dlpIE/IpW/hu+IwdU3q+PL7dv6x/+5gfguUnFm88SeUotqjac8BjhB2f3dAJ9g12OgKNv56ZnLez72L2kv+IlLt0ZjI64E6Rl1Tf/trDPRq19ui4xVO0gSmKnZdZfbZjd+pvGBwxQGZt+Jpt/Tm/IibaYD7uEgfPQ+p9eDVFnlstCh1S/KzMyP2rM9SdIb7tcdH6B5XRtDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBvgXMGWfa8AaqH10g7zBwvY2HytMinRyIEY2yEMi2Q=;
 b=YOP3XYSMhL2cSJnezU8wjy/cVuLW4FnGlxc9O6SCmK89RU9J+4KITlio9CGKmfmDQJsXg8xEl9/GOJJXFNVQS17SAWTZTnzKfDajlurtyeUdaG3jgpTg9D6sN8BhIiUX9p7Y7magTKvuzqm3mjX8PCO76LXux5P/B4xnKhv4kApu/qWoo6xE20NTUokrSpU0ZPmVj7AEuxCMpJNzNsz2ZEYyZaMhA+HSVWXFASSahAnYWk2KFBsu3V2kpg1CydGEBdUCxLI0qdW4BftDomzGm6dZDf3u3UvhZhPAPn7Lu9lxT+WoY+7x3SVYaNJZMIKZ1s6UDQCcN6HPxsRKyktNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBvgXMGWfa8AaqH10g7zBwvY2HytMinRyIEY2yEMi2Q=;
 b=GSggyPz1LA/HGAMCnz984jGCBPx5csZzwDrp0PfG+lAU1vbuLKOBZTTHzQyYkbU3or6u7XF97RF2nuHGD4u4NI356OPGDtaW6gK/YtqIu+GfZ10ncSClOGbuNnb21bO95d5e/3WobeSyJmI76h0vzvV/9fDTDm/0QYpYTZJYJqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 14:16:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 14:16:03 +0000
Message-ID: <94949f6b-9f82-452c-9d38-5c8683a21ddd@cherry.de>
Date: Tue, 6 Aug 2024 16:16:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] log: Avoid including function names by default
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-8-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS4PR04MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbe57fc-4707-4184-8235-08dcb6224dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0Fub05sS0tudUNhUVNGYTNVRnZnRzUyR3I1TUswaHFPQXg3eVhFdHF6UGNj?=
 =?utf-8?B?ZE02L0FBRGhPa3E1RC95WkJIbVlRSmh6T0xWK3lyNTkwTGYzY28zcW9nZFdm?=
 =?utf-8?B?c3ZLcy9McU8xSUdpQUFYVmRDQU1JUUJmaEV3cFdMQTdMWW05NllQS2RDZ1My?=
 =?utf-8?B?dkFkRTVWUmNPc2tiN0YybGlJUncxelhQN21CT1p4MzZ3U1cxejFUYUZmakZk?=
 =?utf-8?B?YTVDUUovZ0x1MTF4K29lVWdiMndYTEp4MU1DSTFlb2VMOWVDYTdpTnJSRHp1?=
 =?utf-8?B?T0Y3UDEzeC9aVkdxOStucGgwaWlYOW1TeXgrZTQ3bEJmS2g1TkxPaGZTK1lP?=
 =?utf-8?B?TUdTSmh5UmcySGNkVlZxQ3MySVd4QXkyZHBZZ2MzZVZtcnNobi81RUNSblVB?=
 =?utf-8?B?Uld1MDhxQ3F0MW9paXBsZUFRaml2YUltTTliWWhmckM0UkdBOUxRZlp3UW9V?=
 =?utf-8?B?RTRyRHljME9sMjdnRFhucEdNNnJLQU02Q0dXNSsrdnU0TjhZY2FnTjU0Wk5L?=
 =?utf-8?B?WDhKUjZQTHJBZUl6SFNmUzJOWWh2L0w4b2dBMTdZN3VnSG5pZFhxKy8rMERp?=
 =?utf-8?B?Q2plNHEzc050bnBRUHBJK3N0NGxOYzErcFNLd2Y0eCs3MndmbDRxNXg0ZGk5?=
 =?utf-8?B?WklleEQ3U1l5U2VRMWVGWUlzazdRZVQvdFJaUktRbmJNNmdWU09GelVtb3JF?=
 =?utf-8?B?dTZ0ZWlLajVZdnZOZ1pPRlp1T3hBeHNsOFkxNllkZXFOK3hxKzlQNTUxanRJ?=
 =?utf-8?B?cEFEYjZoaHR6WWgyT2cxVkRQcFFkQzMrd0xGQWlxOXY5TWxCblBVTDJwOHhV?=
 =?utf-8?B?cHJvQTZKT084WUVRYnpSY1hOQ1dNcWxJQzBZWHV2SGNjaGZFVlBCMFA4Skln?=
 =?utf-8?B?OE1xNWVhQjhPbkZTaTliQytBS1NTYTkySXYralRONHZ0dU5tQThJL09XNE9i?=
 =?utf-8?B?YUduMzVJZUN1UW03KzBEL3hITVhITGplcUpZZU0zWUR2Rk1nVmlwT1ZRS3gw?=
 =?utf-8?B?QVVLd005Y3NLZWJycllqS0dQL3B0Zng0OGF5eCszZFdzT1lVelZyYjZjb3M3?=
 =?utf-8?B?VUd3RWdIVDlucWkwcFN5WWpPVjcvbmlwRUVpaFFpeDNaRjhRKzdhVnFNTmp3?=
 =?utf-8?B?NlhLbUpGNG1OckxSbDNEd05EclVGQ1owbENFampYc2t3MWFIMFh6c0tBMUIr?=
 =?utf-8?B?aWNmSklYeG93a0lCaVcvVkVhYTdnSFQ3WnRTOFNwT25pTzdxbndyTWM4dndl?=
 =?utf-8?B?anRUendvTkw5aWNrSWpOalJucldrek1WZjBhL090VWdvSVZiSWVydXRndTND?=
 =?utf-8?B?Ui91aG9wcjJIYkVvUTlrdzB1QmFJak9wNnZSeHpmd3NCeTZKQmg5dnRqb1kv?=
 =?utf-8?B?NzJ1MUFWNzZkdWxhSTF0dThscENySHVLeDZYSVNDaGVQM1Q0Wi9EYlRGWS92?=
 =?utf-8?B?eURtVm1kN0dDSW5ralZMcmQ0dlI3cjR5bTRzam5Mdjk3RDJyWVBWMDdXQmNU?=
 =?utf-8?B?TFNxMjFGYnlTdmxNdDJiR0V3cU9PL2ZFcXZGTGRYY3dBaFFralNIeGZsSlJ4?=
 =?utf-8?B?cUVJU1kzaE9OQmdpV09sZWVDK3BVcVJvYk0vazJiWEp4eENvK3NvQkNtaXE1?=
 =?utf-8?B?K2ZMYm90eWlMeE9jVDBJM0JNay9Qc1NGS29JWUp2elNtZFFTdWlxUEVtek5a?=
 =?utf-8?B?cjNaQVNZdFRoZHhmbHdjQlhlWXJDWHFHWDgzbFVrVXpQcmJiUWE4aXpCMnRz?=
 =?utf-8?B?dnpxNWZBazkyKytmTk1KNEJWWW5EYkZOMHFSYjRIOU9zZURoMzY5VjhwT1Q0?=
 =?utf-8?B?dXVzYkFjSVZPdmJKR3ZPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZTUjZ1UDQrK3dQLzdPR3hJRldWdEc0dGJqaUJkb2hER2l6UysvcGEreVZk?=
 =?utf-8?B?dDhPM3N3VzY5RWlyRExvZTIvclcrNEJvaEVLWHpkTG5WUENBNTJ6TWxyMVF1?=
 =?utf-8?B?RE1UOWhsbDJmZ25nMU5Sd25XZ0ZaLzNibDIyTnlyZFVjbDVkejVOdDNEN1dS?=
 =?utf-8?B?THVlT1pwVlFVVDA3aTBMM01McWxEcC9zYm90dURXcklUWFMwN3ZlVm1kYldx?=
 =?utf-8?B?MndDUTgxUnluczBoTHZjQmIxZFMzRnp0eDF6d2hjT09ydzhENTVIc1hLa1Vx?=
 =?utf-8?B?MmJLUDAzck9EMFZhMnh2UXNqQVZ5eXorcEMyY21XbFVybG9FVG1CNS9UL2JZ?=
 =?utf-8?B?blMyRnYxVEJ0Y1hVZEYvR1dFS2QxcXlqcmN3TzNUWU5pSDVoUU9zWDRCUFJn?=
 =?utf-8?B?MUh3M3MzQytYbWprZ2Z5cXhtU2ZSZ3RQRjYxVlJFTThpZ0ZaQWRyZ1BWYU4x?=
 =?utf-8?B?QXZIdUdlVW1ERW1Wb2Z4T0VmTG5oMHdQVnAvRjk0VVZ2NkU5S1NRenhUNjFH?=
 =?utf-8?B?WVBIelNGY1E3eDBqckczTmhSZnd5dlR4L2svbk81RnB0VFNwMmxTUlB1d3hS?=
 =?utf-8?B?UlVJenZpVHNsR0NGdmJIai9URTNoQ1lna2IwV2RDanZ3aEpYWFJJYmgzb1A4?=
 =?utf-8?B?TVE5TnlxUkpINTNtQ2hKUis5MlhVekJRL2lNd2M2L3FRekdZMEZBWGhFT3o1?=
 =?utf-8?B?SHkvVVJLeitJdkVvYTdTeWc4RFRIdnI5akxwd2kxYkNPb21HRmJaVU1KWXJn?=
 =?utf-8?B?eGx2SHRyTnRKbG5HelJJUFdqVGljUjZOYzVTbTlhNlVoREpQYndoRENPRTFv?=
 =?utf-8?B?V2l6RVFhTG03VDBoMWF0cFc1TlF2L0N2OUtHQnBVM1lnR3dPZWt3V2hScVNB?=
 =?utf-8?B?UzBrSmJ3d3lvMUhXM3BieEZJWnAyQVJORCswM1BTWUErdmxDSnpLN2NzSkJu?=
 =?utf-8?B?UWtEZjVwaFpsUWxzaGw4SGRqeDFzTFUxaDdNTUZ2ZG05b0J2ZmRxc3FKZW9M?=
 =?utf-8?B?OUhFRSt1Mmxzc0RXUUZRMzA4M0JIdmJZQ0dDbHlvdkJra09xUWNhQmlIWU5V?=
 =?utf-8?B?ZFdnaUFRNHM4UW5udVZpc2NYSG5IaFJucjFKRmZCQmJaSERwbml4RHM3NDk5?=
 =?utf-8?B?aWxvMFRTai9PN09hYjEzdVFKaUFtZ2JibldtMmFsRUtPU2NsL3JTSWF4aE9O?=
 =?utf-8?B?Z20xbkN3SEhuOVhXVE9iaXJYTjF2aU1rdzZVaTNqVXJxYzZ1U1J2VkNWbEYw?=
 =?utf-8?B?N2xwZ0hNU3p3bTY1ZXJFRFhtK2JDZ2svYWZ4bytMV1M2TVFibjVrL0lKK3ZT?=
 =?utf-8?B?d1hRNDVyYXA0cmpzOXNGQnA2OTFyaXh3WXIvYm5scWxFdDQvSm1OVC8xN3oy?=
 =?utf-8?B?eWVkV1pTcW9TU2ZTK3pYdVI3YnpINEtOcXh0TVk1bGhrZklBdzdhQSsrVk5x?=
 =?utf-8?B?MVZsSGxweWxpQmlqZVFJZE1KNnhGT3RwSjBmaTI1bVJLK29XTVRtMEVCUEVJ?=
 =?utf-8?B?YWFhY2FFbTVsZ1pGQlhNMDdINmZRVVlCbE5wN2krMEVzL1JrVnpEcG9od0JI?=
 =?utf-8?B?cy9hM0xpTTFXaURReG5wcythSG0xNkF2Y0d3cStVeGgvWlJZZU5FeC9KbVZM?=
 =?utf-8?B?TDR5ckc4ZS9QM2xXSjNvMDQ3UWUwRDlWclgvTVYxZUhNRHU2VFoweDNzcnhh?=
 =?utf-8?B?a0pUOHBxOHBWcGhQZXdwTW5kam9KMkJsOHIrSTFEdjJiRllrTnlKQWlLZ0pZ?=
 =?utf-8?B?VjJoaXViZFJyT2RicUJzTE5JUzBkQko2SW9CVnFpUng3S2pnUTYvUG5wZitu?=
 =?utf-8?B?OENxM3FBeFNnbUd4aDZJSmdZdXZaM3dLZXo5QjAyUzdodWEvMXlrcU42MXQ0?=
 =?utf-8?B?VzVMaE15RmwvZzg0UVFnRW5GbTlRTmxZQ3dUcHQvUjF0SHFMQ3dsSk5jVnAx?=
 =?utf-8?B?NGQ2SmpMcnBqNlhqWlNUWmZIOXBkZHZJODI1NFhHSTF2VmRUd2prSDJWdTF2?=
 =?utf-8?B?OFQ3VVA1SG9wY0xRdTRnT09TcWhMOThlTmNTbGJrVnA1NUtPVWxMZ3N3Rkk5?=
 =?utf-8?B?bTJ4d0Q1QmdyWmNvZTJlVzFDd3MvODVERktmR25HTzZhRWF3bnJZMXRsTTFX?=
 =?utf-8?B?azl5T3RBcDBqeU94dmY5SGZ3OS9NbHNGME00YllQbCt3cEF1QW4zRW8zdm94?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbe57fc-4707-4184-8235-08dcb6224dcf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:16:03.1487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY4i5WpQW1dUD68/dcootUgKn7rBFzqk57wklN37ARHt9NM+1mWBPRW4O1mYFRSBXG6zbyaDbDWri931hCPkzjm9JrMpOzhyelJGKVXFtuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363
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

On 7/21/24 5:25 PM, Simon Glass wrote:
> Unless function names are requested, the logging system should not
> compile these into the code. Adjust the macros to handle this.
> 
> This means that turning on function names at runtime won't work unless
> CONFIG_LOGF_FUNC is enabled. We could perhaps split this into a
> separate option if that is a problem.
> 
> Enable CONFIG_LOGF_FUNC logging for sandbox since the tests expect the
> function names to be included. Fix up the pinmux test which checks a
> logging statement.
> 

I now understand the statement in patches earlier in this series :)

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Update commit message to mention the runtime impact
> - Leave assert() alone since it is only compiled in with LOG_DEBUG
> 
>   common/log_console.c      |  4 ++--
>   configs/sandbox_defconfig |  1 +
>   include/log.h             | 16 +++++++++++-----
>   test/cmd/pinmux.c         |  8 +++++++-
>   test/log/log_test.c       |  4 ++--
>   5 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/common/log_console.c b/common/log_console.c
> index c27101b8fe2..9376baad664 100644
> --- a/common/log_console.c
> +++ b/common/log_console.c
> @@ -38,10 +38,10 @@ static int log_console_emit(struct log_device *ldev, struct log_rec *rec)
>   			printf("%d-", rec->line);
>   		if (fmt & BIT(LOGF_FUNC)) {
>   			if (CONFIG_IS_ENABLED(USE_TINY_PRINTF)) {
> -				printf("%s()", rec->func);
> +				printf("%s()", rec->func ?: "?");

What about setting _log_func to "?" if LOGF_FUNC isn't set?

>   			} else {
>   				printf("%*s()", CONFIG_LOGF_FUNC_PAD,
> -				       rec->func);
> +				       rec->func ?: "?");

I think you missed a similar change in common/log_syslog.c if I can 
trust my grep-fu?

Cheers,
Quentin
