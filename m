Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A212AC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 195B08824C;
	Tue, 18 Jun 2024 16:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8FbqJUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C741882F9; Tue, 18 Jun 2024 16:24:14 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C448812C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIlTvzeEs2Xu06ojc2/4f1iCsU290HppNDtD6duI7U+wzVDIbZbu6RivUjX8bry3ijguyDSZLqvvdtWLKxL53/rGBxvOrt2xR6aVi5y3cEsbZrI1jZ09ynjOcDDfH2B4gy7Gh4720yR8bdE3eB3dmE2/WH3O8ecVJvFvg8t8FoH/8juYhPuYvjJKW1MYDo7KLvsCHRPr/m8s037U1/JTJgqBoVwYWap+3utbEkCZlZORYQu+dAarBxT3OqKiMqoTN/lX6fL9gEta0CiU2tt8FFPAlSAXAK9mDgNaWGAtkaei1ezDWEvrpOVhH3J6WeB2DbGh+/bVoQuHSNrGnWvuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpYeGQJt+/k44ZN6yLu1G1BhANlhnxR3aEx8pJcpqqc=;
 b=VGNEhfLz6pfPzPeuviSCdHpSZdsxofv3bk5JXoMVbnliKPTMZTQ5Bm3MiTN188nzati46/YSqG1CJUdt2irlwICMdPZLJfnvJraxU93j57YFZdwyjJftNLv7hVLwSYVkfCmcz9ZlcwKCBBlXyQisKECy80CwCYtjWBc+fg7vavA/4YoaHRR2xNmhlQpgM4FeDNZ3AcYa5Qu3jDmSmpxiC5+Z68wFoKNGGYeAr81/4jwKYZgtPzuscy6x74kgoLvUkn62h1xcYABGGXGIEk5pdkvODpmKjiM27EN0j/7hgu3KSy3YZMGc98qQc5BYABJfVTMWZyfU1At6T8ek2s44pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpYeGQJt+/k44ZN6yLu1G1BhANlhnxR3aEx8pJcpqqc=;
 b=D8FbqJUKuYbofk7PLJStPawJz3Dbb7ESgOIXvCro8t+FlvVqB2iewrOJuJ185JpLmKsuFnk43etEK7vpgdLbu50QVwi5Oh/js7EjEWABNFogw3HxRw1ONSO2UCajGyXst7gS9bbj/K/O4kHWwQ7CJ2yffr50gUX4GRp4zlK+ys4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 14:24:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 14:24:08 +0000
Message-ID: <26e965b2-f1aa-4b33-ac64-1c16d1ea2313@amd.com>
Date: Tue, 18 Jun 2024 16:23:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd: versal2: Use U_BOOT_LONGHELP macro
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
References: <9fc5f9c3d92a45f0603e6e912394655f42e96173.1718716595.git.michal.simek@amd.com>
 <20240618141839.GP68077@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240618141839.GP68077@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:803:50::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5215ae35-787e-481e-430a-08dc8fa250b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzVIdjRMVWJNWEdHVFdveHRsWkUwWVY3RHk0N0k5dXozSTVwZ1RSZmJtNXNN?=
 =?utf-8?B?aTJ5b0M5dnJvaGNoVTQ2d0xaUXdJd0xya3J2T0p6UC9SbFk3bEU3a2UyT0x2?=
 =?utf-8?B?N2x0ZjUvZVJPLzZNZHB2WFcyT0lCRWZuelpJTGs3aHg4dVhldUJkNVh5bDla?=
 =?utf-8?B?WCt3STFETTU2WG9FV3Y4MlBSeE9xZWtZQTlKOXdjb0RkeGtuK1l2MDgxblJV?=
 =?utf-8?B?NUVXT3ZwMXdCRGtaWlVEdEpkOXNmcGtTRTVPV0hpeEJZZzNYV2Y1U0RraVRl?=
 =?utf-8?B?aHlLMmkyZlg5cExldGRqU080d1hGLzI1YytKUlVFUXMyVHJBN3Vqa0JxbGhp?=
 =?utf-8?B?aW11N2c3Sno0NU1qR2l6d0RkbklVbWhFSUowQ25kayt6RzRCQUM2U3JTRWZo?=
 =?utf-8?B?ek54NEw5UVQxWVdZdURKRkgwTjlidmprbnovKzFiaDFPdUZYVG1IUU8vcW04?=
 =?utf-8?B?dGV4WmpKMmRsbUdLc3p5MUcwa3h6aWJlRUxiK0xDZjdOQ2JaMFVSVWhqYnUx?=
 =?utf-8?B?MmF2THdtZ2ozVVVlaUo2YThkd2JpbmdlUDh0d0pRTUk1M3JCa29vQVdWWURJ?=
 =?utf-8?B?dDFOTFROZzIvZFVQNjFBK24wSnNidVloSE9rSHV2RDNyUVZZcjVWYzZpNVp2?=
 =?utf-8?B?SFpqZmFyWGRXS2ZWZndOUnE1dmE2ZFBmMS9EbmVNMStpODhsc3ZqUy96NFNw?=
 =?utf-8?B?Zis2R3AvUUk1QTdUSGlLaWFXTVdjcllUZ0toS2NFblJmRVE0dE5ZYnNjSTZK?=
 =?utf-8?B?a3JPU3pOYlFrU08zeVdqbHBaSkFoenE3bStvQlRIOVVTOHZSNE1jeEx2Z0dC?=
 =?utf-8?B?UXcwWnc5NjQrQitNS1puZ3B2SW1lV0lENEx6ZDc1bmhHZkQrbUE0cVpYenRX?=
 =?utf-8?B?UVEzNFFPbEZJekE4OXRkOHIyM3h5VjdpNCs0bGFMWG1KQW5BbG1sMUlWQXVk?=
 =?utf-8?B?UXlSVWdFUXhHaGVmamtvQ0RPNHBiLzluVEVMMFhrNUQ1VW13SXBaczNOZGVF?=
 =?utf-8?B?OEtMTlNHNnZCbmlua1AybHZ0c0JjMVUxQWU1bEk0K01EMXlhN3NCNFcvdjdX?=
 =?utf-8?B?TnFxTkNWUENMSFRWUWpkbHNwWjJUYVBBQzZuZ2h5K3YxcEJtSW94cTc1REpa?=
 =?utf-8?B?d3U1Vm9qd1hGTDVPK2NiMDZuVlZ3anBieit1b0ZYa091RDEwSExUQTZOcEVD?=
 =?utf-8?B?Nkl1WUhLOWowS2FoU0c5bWFYYVFBeVBnMyt5REZ3ais5TDE1VThjVnoyT1gx?=
 =?utf-8?B?b3EvL2FHVDhWODVMWXI0MCtKZ2NiaFQzNlVMamFIVnYzTUtBVHVzU2pKWWJK?=
 =?utf-8?B?SzhpTHhZUURjM1JSbmhrUHkwVVpqcEhxUVpjalhnTnNmaGU5NjlJL05WZ3Zv?=
 =?utf-8?B?M3JIbXF1dkNXOXQ5cVhjVHFQUENGM2tqeFhncmc3U0xGMHV3OWZDQmJ4QXhy?=
 =?utf-8?B?U2h1MHUrbkZuSTZIL3B6UThaaGZpc3cxWWR5TlEzN3ZwU1BISFMwZjRTKzdz?=
 =?utf-8?B?aUNyRGpuQlFFZHJGZUhZMnJXMSttUzNEYUVFUk5FK3FZQ29MVHkwUVIwamFl?=
 =?utf-8?B?VUFHbHRUOEVtaWxjZkFDR3kzZ0tpQk5NOUZERzdRdVloVC9SMnZFbVlhVENV?=
 =?utf-8?B?SDRxOW5aQVhOdDlLa0xSc2Y1QlJ1TWZoNURXT3haQkEwV0VqalcrVkNONTlq?=
 =?utf-8?B?eFNBaEpmY3lWcDgvZHRkMXRRV2VoVkM4cW8wZi83dWNYL0M2VUU2WWM1SUdt?=
 =?utf-8?Q?hIxlhOtUZ7tOFaDHFNxQcWDPCazAqStQCpIw3HM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzZab28vR0RxUGxzMmtZMDZ4Qk5tNWYzcG9VeVpWVE5Kc0k0R0pJSis3RXNv?=
 =?utf-8?B?N0hQOWkwdnF0dTRYS2Zycm9FZVp0a2Y3UzBSc2xEVGxnRlA2Mm1kQ1c2VzJV?=
 =?utf-8?B?TWdmaEZQL0JaSXYxcnNYOVErNUhMWkVoV0xqaGUxeHB3bFJwRncvVURGVGxm?=
 =?utf-8?B?bVM5Y2hadEZiTUozSiswVkJzTHZwK250SzRreGJoTm9PSXZIbnN1dnhTalN3?=
 =?utf-8?B?ZGZ3U2ZFb1laUE9QTlRZUnlEbkpYOVk0a1RMbTdEU05JdXUya2U2elNJNzlE?=
 =?utf-8?B?eGsrTUxwMTk0RGV6YXZjelA2MGxhc3c4aHcxRXh6OWhnWDNBQ3hQcERmQmk5?=
 =?utf-8?B?ZUYwZG52cXVYKzJoSGR5UXgveWxEUEI1bGNEN1EzNlZISVFNZEc2RGxaNEVL?=
 =?utf-8?B?S0lLNlMrMU94Uyt1OTUzRkM1a2ZOekNGUk8xYzl3Ry9NOUxOQjhXTlZod2RK?=
 =?utf-8?B?VytSYVFVa1NMc21EVUNmYWdwdWhJTWc5S1Q5WTRvTkJLWHVtRENlOXJlT2Jr?=
 =?utf-8?B?aUVLZWhlWkR1cWgxd3JzMkxwVVI3N254d3RNejVkTHg0T3owbXdYdTF5Y3JP?=
 =?utf-8?B?MGYvK3BzVmJRdzBiMUcvUHRLaklYYjlxVVFLM0ltNGo0OHFMRHVQK283bEdx?=
 =?utf-8?B?N1BsQ3VVb2tOL0Y2TFRyUUZGSDV3UGtrMm01Uk14dVk3U3dNQm94NlFJWVcv?=
 =?utf-8?B?VkEvaFBHWDd2ZWNZemJkZ3h5NzBITlBDeEhPSStqcHdYSFhEblh2TGZ6OFpR?=
 =?utf-8?B?TmVxU1lrVU1ibzhlVTNRbjdxa2NwUU1KTnczZlV4SzExVmFnK3h4YXJLQ3I1?=
 =?utf-8?B?aERzZ3VSZWdiU3NHdWdHWXZBSDdUQW1DZWlpLytIQ2MvblMvd1lZQ3pTdGNz?=
 =?utf-8?B?RTJHd2JMMGprNVB2cWRmSzZxL0NCTW9SODhna0tYYWk0ZUhpTjRzU2V2T3NC?=
 =?utf-8?B?QjMxRi95NDBiRmpFblNySGNwbXIxZ0lIS3BOL1RDTDhZeGdPd0grVWFWWHdK?=
 =?utf-8?B?ZUhrQWF1Qmx6eG1ZUVBLWTBxN2VBc3ZySHdBNy9wOGJqY0VnRnFmVEJ1djVu?=
 =?utf-8?B?TFk1TVFQcFFuRDd2Z3FUbzNjaWx3UXcybUhHRFBLOFhBRGdpTUx0RW05cGRX?=
 =?utf-8?B?OVR5ZHlmeEtoUnFWY2RKMjNPTVBpV0c3N0xPNEUzWEJ2blFMQXUxUGw2T1NE?=
 =?utf-8?B?WEJMbExZMjBwK1VjM3MrZUlVakZDaUdlYW5nOG9tY09nTk5sWWFYcXR4bUQ2?=
 =?utf-8?B?cWk2aW5nT0wrT0tFS0hGRWVjdnZCZ0I3bnY3OHNzUGI5OVlGYmRWN0ZBdWZk?=
 =?utf-8?B?aVBEYnNIYzhhSFpySGNTOU1ka1FxcVo4UkRxOUgvVy9iRC9JenpXYk90cGlt?=
 =?utf-8?B?U280STJ4RDlQSEEraGdEVjVJRGQ0MC9GTE5QUWc4VzN2cjA5Zy96ZE5qMUVn?=
 =?utf-8?B?VWowbUl4VXN3MzRMenErL2RkSUhKbzVXa0ZtRzZaWlNybjMyM3lpWWZtSkNG?=
 =?utf-8?B?RlR1TytyTFpoVnovMTVGMlVZZXcyVGE1NVdrUXQ2UkQ5MG4zQ0ZrVm83bCti?=
 =?utf-8?B?N1BSU2F0eHUveHNQaHJFMkY1OVdMVkNJc1FyUkRRMWpwb2pBei9kZUFxU3Ns?=
 =?utf-8?B?OHZRSStIVnlYU1ZhZXA3eWNYOGpvMGFXWEdUNDVCbURjZkxqSWFqK2JoeGQ1?=
 =?utf-8?B?dWcxYUV3RndSc0UrRk5hVUVJd1lQYjNOZU1reWhjMXNwRWFBK2ZDOFdnekxM?=
 =?utf-8?B?TmFKMVl0eHUvZ1FxNWROa1AxVktNZGxyYU5tbTV4cnpNQW53eHg2RVJ2VU95?=
 =?utf-8?B?bldIQXdzNnJwQzY4anBPbE92SjQxWnp3OW1WN2lzaEFsNlR1ZzlJRnZ2NGt2?=
 =?utf-8?B?TjFvNDNFYTA1OFRvMk1NMnFUejRhLzB2OEtqd3lGd2xPajVOU3dhcVFXUmRi?=
 =?utf-8?B?b1pvVkZMZGVNY1p6b3YyNUVIWHVFZ0g4aytNQUNxVjhaUkp6bXdzM01XYkJ2?=
 =?utf-8?B?bGJadUg0aXpsblR0dmZNUTE3cUNxeElCdnJQazRFUHZmUVgyMWw0SGYxd3ln?=
 =?utf-8?B?U05lcitCUDliclV1T0hoSTFJSUFVNmI2S0FKR2I5R2o2elhveURaS0Vya2tY?=
 =?utf-8?Q?BPrCfl+sCgxVx/CeDR0p4CNbt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5215ae35-787e-481e-430a-08dc8fa250b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 14:24:08.3537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxLrb8voS04LAie6HTRGT0+/TWj5xbc2qQhOhjQb41NCBFanSC3cu0Z66Hxl7IQ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
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



On 6/18/24 16:18, Tom Rini wrote:
> On Tue, Jun 18, 2024 at 03:16:38PM +0200, Michal Simek wrote:
> 
>> It is defined as __maybe_unused variable which fix issue when long help is
>> disabled.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   board/amd/versal2/cmds.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/board/amd/versal2/cmds.c b/board/amd/versal2/cmds.c
>> index fbd99918a7f4..56ae39bc6a1e 100644
>> --- a/board/amd/versal2/cmds.c
>> +++ b/board/amd/versal2/cmds.c
>> @@ -71,10 +71,9 @@ static int do_versal2_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
>>   	return cmd_process_error(cmdtp, ret);
>>   }
>>   
>> -static char versal2_help_text[] =
>> +U_BOOT_LONGHELP(versal2,
>>   	"loadpdi addr len - Load pdi image\n"
>> -	"load pdi image at ddr address 'addr' with pdi image size 'len'\n"
>> -;
>> +	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
>>   
>>   U_BOOT_CMD_WITH_SUBCMDS(versal2, "Versal Gen 2 sub-system", versal2_help_text,
>>   			U_BOOT_SUBCMD_MKENT(loadpdi, 3, 1,
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> Ah, any chance you can work up something to checkpatch to catch that? I
> had gone through a while ago and fixed up the cases which should have
> been using that macro but I see a few more have slipped in, again.

yes there are some more again and as I see even one ours.
I will add that checkpatch part to our todo list but no promise.
And will fix that others.

Thanks,
Michal

