Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C2AD58CBF
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 22:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4DFC83FE1;
	Mon, 23 Mar 2026 23:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="fXvjliGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094638412F; Mon, 23 Mar 2026 19:07:56 +0100 (CET)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c206::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFBF84099;
 Mon, 23 Mar 2026 19:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=gary@garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6CW0Gw7Ovb9Y6HAfjyLV1XAWXsiIt7rVYZkO9O1DsqL7omC7nJAt5br8s5ENkmZwej//2T3NjRrO5wnYSuFcgnNkBjLuTRILG1Pr/NakXToas1QRDAATnMQClU9l75Q3gv5ad4WiI78qegLNZj3QKdungPOLp8C0bW3p9GL8AV8rqo/V+7bh8W4tycAJcs2Us6cVLelPldxHTgcD7d1XvDum4WvTG3iAb3x6sdWqzCbmt8vbpmKB5wX/IQvbRQVO2Rr1aHMsSN+HDMiJG+pl5ZnqUW49pM2Jc44wzLnPFYt+xhQR1HLUudH/T3fcINHWsJ3sr2DwVHxEMDZiz4lLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsQEoiEb+SB3hXz+OjOj05SSmkGVMhxAI+owG7th7JM=;
 b=d7U2H4sE6EUrGyb4RL4D97WGmkMpJfyqKMr483LoDBBmVoKc6aDCCyFrWKHwLymqRZ2BqJR1czyMO5uc0IT9gOJX7v7qs9jT98f5UMSdPmkL4I5Fs441cqf+7TEqc8nIi3rEUo2Nxw2BT9sy6eOxneAQGiJnFfO197tMVsz7/UvhnI7dHzqRnv8bY+G5zP+2G3Y1Bnl/jTBEkQdmJ/UWRKPKl9UGDtf11W1fUt1YGrfqsxP4Tt4SXMzagGDXpC9UO6XcaRk9wma9c8858XAQiZifRIXqoOX43eiNZGSNOzMQ+aGiX2sWACka8P5vRpbPG2fyYSmlGQFR2IW9zeJBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsQEoiEb+SB3hXz+OjOj05SSmkGVMhxAI+owG7th7JM=;
 b=fXvjliGNEyOuXeEHv/SczX7wlZciVBwWzTsSKMoO8MhzqUwFqTdmL37VTTXme55RZJKQuLvS5Im61I9OSw04Xn29bM35HiSt5Qz796ZPZKAWQz+VEzsLgd912Xcqa1MuIAIPRYQTPvjFOsqMb7aw4k7WtZomdGCec851T4AN7ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5602.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 18:07:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 18:07:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 18:07:50 +0000
Message-Id: <DHAD1Y4YFJGF.223KKI69PZKC0@garyguo.net>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
From: "Gary Guo" <gary@garyguo.net>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Gary Guo" <gary@garyguo.net>,
 "Mark Kettenis" <mark.kettenis@xs4all.nl>
Cc: <trini@konsulko.com>, <u-boot@lists.denx.de>, <mbrugger@suse.com>,
 <pbrobinson@gmail.com>, <yuya.hamamachi.sx@renesas.com>,
 <andrew.goodbody@linaro.org>, <casey.connolly@linaro.org>,
 <xypron.glpk@gmx.de>, <holger.brunck@hitachienergy.com>,
 <ilias.apalodimas@linaro.org>, <jonas@kwiboo.se>, <kettenis@openbsd.org>,
 <semen.protsenko@linaro.org>, <sughosh.ganu@arm.com>,
 <u-boot-bounces@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
 <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
 <DHABV5ZOLJOQ.1H3Q6TEFCTBET@garyguo.net>
 <f2e7af73-569a-49fd-95ea-011c37d21cf1@mailbox.org>
In-Reply-To: <f2e7af73-569a-49fd-95ea-011c37d21cf1@mailbox.org>
X-ClientProxiedBy: LO2P265CA0386.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edcd439-1a22-4182-23bb-08de890718bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PnEPpyzk67cXqH39ncG0Lm5oGw4wAaIE4XOP0NQFiva7Lx/uUXcDJJL33rRclo/hYQL/00UXkUfTne85r8HkWHXej4r2HwcQnxJ9WI+SeG1YSyzpvrCH8AKdxcwC0dJxczoj2oPaRYz5M8Y1rqw2VY3TaY/AfKyX9HEiK0ZPycFgKdqFnTtpSpV66tR8gSvizDX3nwVO5N/Vt5TIK5uRzK4uN3yLbXU6tja4gNWJ+u14gfPaOZxF/nk4jazJ2Q4gO7tzrCY9YgxND/auEoU0w6XVQ3yio5JqCEi6ejFxdyKr8P6hMGoytRhGX4KrLQ7AwJwMNoC2I4HyjeRmKDITgRPpMFJW2044/RqAeBrHFlVWEY1tr5c1D2RLU+XuQ1GDmiTO758DcrkKbEZWvQq1tHajzlJioBKYZ/PTvJtySpiYAPZ9/MPQz/A2J9cFaslWMPQYiVXldQKZ4mSne4W5afoPma5WZyiW3ulkisujJCy4VHwN0yNzjw8K5Z8wcAnxjBLJg/DsmlSG/xW94+m83pZHsCCCMoRfex1HEhzGL9dTI8yJuSFjFinYQ88v6qotHXjLubw9RrXT+sDwwrWFtmfTyCjbq6VKwbo/NVMXG18VdRhBBbwdm/K4MuVDAsicDjVLBnWihfj7+RSNJw8rwaRJ8VxLksonYnpBYalEL38lJIJHR233+/xhnalVffYHjEdxXOv2ZkVldP4H7ZDhP9t1RIurdZrkarFClSguLOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ViaGpJN3MveWdvVUVkb0E3dkM2UlZja200SmlxVDIzb1RFK3NYRUFrWUxM?=
 =?utf-8?B?R0JuSFJna3l3SFlrR1RaTW1pZDBFRm1lOVc3MnN1NkNRMGdxbEZXckFVazEv?=
 =?utf-8?B?MFZBMzIxL3dZYXZUUDRwU1NZOFNkbEwxcHVaQ1dvT1BVc3N3T1oydTdtWjFm?=
 =?utf-8?B?bS9LTUVOUmVDckdwTnFRQ2lGamFHdVQxYnpldEE4cEs0OGFLZXFXSFphdS9P?=
 =?utf-8?B?OHl4ME5kUW9oaWpndXFKOUdyR2x1UlcvUkNqZDkyUWd5NmZGRWFTNjF1K2NJ?=
 =?utf-8?B?N2FBdEg2REg0bk1PbnVEM1hFbmJJZjVaOHl3eEY1RXQwNjZLNGtCRUlCRCs5?=
 =?utf-8?B?dUdKdHUzcTk3YVV2RTdrU1FGZDFhYU1NWG9qVVJlYzM1Nzlkc3lSYzFqa29Z?=
 =?utf-8?B?ZHB6U2hyUFd5aVo0Mm9LYUtVMG16RlplYlBkOEFtMEkzbWl0cUltdW5TMkh4?=
 =?utf-8?B?UHhYUWp6bXhwMWdrVklTTWZEQUxhNVhTKzBGZm5OTGxTOW81TWF6WEdTTlNT?=
 =?utf-8?B?d0pEdE5Ba0ZCN2NORDZsUG0yaldSdjF5cUExSnpselBlQzMxTlNoK1BqQXhW?=
 =?utf-8?B?UlZ1Rit5NFAvUHFyOENKV2Vaa2NSOUh3a2JDa1p2aVY2Ky9NL1dYY0FZMzc1?=
 =?utf-8?B?NTFNWjI0clJ4V3I1b0dYdTNUQWRJZmV1NVpyZHE0NmljWmlkbnlnV3ZweVZr?=
 =?utf-8?B?aDBHekJFSzFjUlkxRlFJVENoTW44N3BQSXBqamdSOVR3T3lhNUxUbW9WYjh1?=
 =?utf-8?B?Mm9MSUNMNTlXRWVWNVFObGJqaFY0UjR3YTFNbmhWOXVJK210a3A1NGkrY0VC?=
 =?utf-8?B?Zk5qN2d5OG1YRlVFU0pobDBrWmVJaVZYdFdXVlB2TVZrdGY2UThyS1h4R0VX?=
 =?utf-8?B?SnZZUG83MFQwQ3BrT3lUSkNPenVpcEVWR3dGdWNOMi9aKzZFL01NUDJYZ1dV?=
 =?utf-8?B?N0V1ZVk4dlBkTTc5SUYzSkxyYW1DWXU5SEJLR2FoRHR5V0IwN2FHRmZHd0lO?=
 =?utf-8?B?NXorYnlJcXpjT1N1NWZBYUtiWWhKMlVqNmFYSGcwd2hiWSs2MTJNdmtObGxE?=
 =?utf-8?B?ZkRSclR3UytYN2xIM1ROclRFc2JFZnBHbnpVM2xYRWdOYkJuUWxVR3I5V2ZI?=
 =?utf-8?B?K3lqbW9jaUJHOW5GbThsbno5S1lSWFR5QTBRMlN0LzJQMzh6L3pYTTZpSkNq?=
 =?utf-8?B?YXZqN2JPa0dwMjczQlNXdytETWE3QnBQV2cxc2l2YWpMdHFlbHVzb2o2Yndo?=
 =?utf-8?B?TnZvdUR5WmhhdmxrM2NmQStMdEU4Mlp3TDVIckwyUDJvM2s5SVF3U0Q1bkJB?=
 =?utf-8?B?MlJxcXRLNXRxMXV6YUh3UVpSbjhFajN3eGV6VXgybWVIcVA0YjJUbElBT3VX?=
 =?utf-8?B?aWhkTG1ldCtydGV5b2hTenRVa2hkK0p5Uk5uL2JJM3pjQmJvNkFLY1F3STNi?=
 =?utf-8?B?SDhEamhpUExjWkppRlNDMHZGWjFFUEFzL3JzTWsxRDZFdTJHdDYxYzkrbVZy?=
 =?utf-8?B?blA4Z0c5eG1jN2RvTTFCcHgxQjMza1V0WmFTUjRZZHZnYWZWeER5ZHVTcmJ1?=
 =?utf-8?B?WWFheWNpbkJSQlNib1hjb3I4czlYc2MwK3AzYW9DYmpCSHAyQ3VEbzJYajhz?=
 =?utf-8?B?eE41TENNOE5lWWdXUkZOTGpvVEFIUVlJd0JqTTdpUVVJUy9ZNTRZazU1dWFi?=
 =?utf-8?B?NHJMYUNBSEVMY0RsNTBzR1RTVldVS0NYUVpuUDlzMnkxWEFyeUs4dnRLdFl2?=
 =?utf-8?B?SUhUOGxMSzdQdmtSSnFQd2ZlTmhnczVITmFCR2FLY1NNNS9OK2xscUg0c0xM?=
 =?utf-8?B?SVB6SmNrYjNCK0U0SlR2ZjU1L3Y5R2VhUmY4eGtZK2cxWUxxb3JoK2x3Z3V2?=
 =?utf-8?B?enhMd0FHYjBkaE9qdnd0MFVxOUh5dnB3YnFUWmVCS0VYYVF5ZEFjdzVwRWRp?=
 =?utf-8?B?Zi9KY0RYK2pjVW9mVUpRMlZ5UFBDb1E1NjJQS0FPOFBJWEdROTBkNkJWRk95?=
 =?utf-8?B?T1hMK0xVSjZpYVp5L1BBVWFCU1BZMG9VbTNBaStqMVg5eUdPY0gvY00vWFMv?=
 =?utf-8?B?NE81TmtCSkJQdHRuY0N6L1lWbTh4YlBnMkI4YmFCZVFQcHRVMllDT0hsLzJs?=
 =?utf-8?B?OCsyc0ZuU2ZjZTkyN1lyRCtScFc3K2FHKzJaWlJkaW1wdkZvN2VBMGMzU21w?=
 =?utf-8?B?Zm1uUW1yWEFxcHpkVkhaOTJQa0NFK1AyY2Z6TFJCckFwZFNqdGxqMlhLREcv?=
 =?utf-8?B?TUpqRnAzazV0VmpudTJkRVBZYkxMUEkydWRaWjk1M2FpTVp2aW5GY1FRTklq?=
 =?utf-8?B?YUxoMVdQYWR2RGRWSE9yZjd1dUlFNWo4YnVlV1EzYnhYajloVWlDQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edcd439-1a22-4182-23bb-08de890718bf
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:07:50.7116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcMKCtax8fst0/RI0UtlUNpb7mM/4nJPdMBw+weUX0z2k2Qe+LmudD3NLlDeI7tv8ZFwgWMZRKC3soIxOOG6LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5602
X-Mailman-Approved-At: Mon, 23 Mar 2026 23:56:16 +0100
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

On Mon Mar 23, 2026 at 5:26 PM GMT, Marek Vasut wrote:
> On 3/23/26 6:11 PM, Gary Guo wrote:
>> On Sun Mar 22, 2026 at 11:25 PM GMT, Mark Kettenis wrote:
>>>> Does something like this make the issue go away ?
>>>>
>>>> "
>>>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>>>> index b77c2f980cc..44eccc0cf35 100644
>>>> --- a/lib/efi_loader/efi_memory.c
>>>> +++ b/lib/efi_loader/efi_memory.c
>>>> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum
>>>> efi_allocate_type type,
>>>>           flags =3D LMB_NOOVERWRITE | LMB_NONOTIFY;
>>>>           switch (type) {
>>>>           case EFI_ALLOCATE_ANY_PAGES:
>>>> +               addr =3D map_to_sysmem((void *)(uintptr_t)0xffff0000);
>>>> +
>>>>                   /* Any page */
>>>> -               err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE=
, &addr,
>>>> +               err =3D lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE=
, &addr,
>>>>                                       len, flags);
>>>>                   if (err)
>>>>                           return EFI_OUT_OF_RESOURCES;
>>>> "
>>>>
>>>> If so, then maybe we need a temporary config option which limits the
>>>> EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitation=
s.
>>>
>>> Note that some arm64 systems (e.g. Apple Silicon) have *no* memory
>>> below 4 GiB.  So that change must indeed be behind a config option and
>>> care must be taken on what systems to enabled it.
>>=20
>> Perhaps a good short-term fix it to use gd->ram_top here rather than har=
dcoding
>> 4 GiB. This way it should work on all systems without a config option.
> Looking at my notes from last DMA32 investigation, this may indeed do=20
> the trick in the meantime. But it would be really good to have this=20
> temporary workaround guarded by some Kconfig symbol, so it can be fixed=20
> up once the DMA32 allocator is available.
>
> Does the gd->ram_top fix the RPi5 too ?

Yes, I can boot my RPi5 with the following diff, which makes sense as it ha=
s
ram_top of 0x3fc00000. Testing on devices with ram_top > 4 GiB would be nee=
ded
to know if this is a proper fix.

Best,
Gary

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b77c2f980cc0..76ae89e31f47 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type=
 type,
 	flags =3D LMB_NOOVERWRITE | LMB_NONOTIFY;
 	switch (type) {
 	case EFI_ALLOCATE_ANY_PAGES:
+		addr =3D map_to_sysmem((void *)gd->ram_top);
+
 		/* Any page */
-		err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &addr,
+		err =3D lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &addr,
 				    len, flags);
 		if (err)
 			return EFI_OUT_OF_RESOURCES;
