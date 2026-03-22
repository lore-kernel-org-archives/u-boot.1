Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6925BD58CA3
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 22:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89346840B5;
	Sun, 22 Mar 2026 23:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="cn1REL1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD5583D71; Sun, 22 Mar 2026 23:27:47 +0100 (CET)
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c205::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A0A83AC5;
 Sun, 22 Mar 2026 23:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=gary@garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyfdh8HRheorEt7kGMlRvlo/6a6pxZ9LrWI4UvopJAgy4W3XlQRYsQ1Cqcod9pg2YwuTjDTmXF0AY5jzjDbdiB9yTLEJo7LPwwh0yjbW9w+QRnGtXF4ePZihUE2MC+fk9H5cBMpoY5k1yoZUpaqp0tkrsrJoVLiJ3b+dTIGP33mdQAvGB04y8dSDLra+B8uQBWxOoiQYS7U50h3WP1ViIg3CxwwJYxIUBdn8mqlWU1kSOgt974mqGQaKQwapUVIjFGfa2mZ8fGu0gfanSXmyR9dd8/zAhabQvv7KI/nNvlA8okKLlLH+rOABKwhkqEMYbAbVnxRDr5mjJ6Qh4Z/z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00WEgnFc93/XrPn1Usp4ho0mgyeLyXgcx4XVz+oVuqg=;
 b=SOUayU5LUDlva2h7/3cDn2j1/Y6lqsAq90egtZnPtxZwadFp7lyycrSN+Ntb4Q6OiMKdL3OxcPn09pgNRzL2eiTEV1XTdPfxB/eCtKeqUNmGYNFvoqmf+sjAhLcFJsUnK3FgGkycUZidARz9z3ZeWgCz584SnpVvQ9shHwy6UR3NvHN/Q4uHPJKy0fMH988ll9zhimUWKsjKqSJhAoA9eNoiRnokQtQ6QmJ+deSy4nomc8LYSSZ87P9bfxXeVRwuCyleKt7cAVPvyBUDEjd3MqjdCW8SjqJFjfQYq9Hjk9wNU6aKAjnTQgYb7s39yTDr3GWfQdPlwcJ4Uv9g5uuaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00WEgnFc93/XrPn1Usp4ho0mgyeLyXgcx4XVz+oVuqg=;
 b=cn1REL1e4itWwJqUrMf+gJdUiPamIWssLcJlCm4VvfI2Y9ZMfiIToEFZ0Zw7pmyIy2UjzETUHyuZo5wYVoSraOY8qEfcK5YGY8xfQUf1eVnabOjGUq2iZVNPmdGcreXm5Axjq777+noov12My1TGyfqRCcQaPqtkcd7Mp91hT0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2573.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 22:27:43 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Sun, 22 Mar 2026
 22:27:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Mar 2026 22:27:42 +0000
Message-Id: <DH9NYDQ96F1Q.1AFM2MHWL5TMX@garyguo.net>
Cc: "Matthias Brugger" <mbrugger@suse.com>, "Peter Robinson"
 <pbrobinson@gmail.com>, "Yuya Hamamachi" <yuya.hamamachi.sx@renesas.com>,
 "Andrew Goodbody" <andrew.goodbody@linaro.org>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Holger Brunck" <holger.brunck@hitachienergy.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Jonas Karlman" <jonas@kwiboo.se>, "Mark
 Kettenis" <kettenis@openbsd.org>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Sughosh Ganu" <sughosh.ganu@arm.com>,
 "U-Boot" <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
From: "Gary Guo" <gary@garyguo.net>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Gary Guo" <gary@garyguo.net>,
 "Tom Rini" <trini@konsulko.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
In-Reply-To: <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2573:EE_
X-MS-Office365-Filtering-Correlation-Id: 65064ccb-8c67-4cd1-5b7b-08de88623c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3sR0pl4QHvg1TXMes/Dp5lK1yzDXHKoq5ofCbHCSAwkH4AXyF+yjXGPaf+3gn/Kmp1/7bvNV0FaS5j+6bX3tIk7SqycDQtLiLhy1JWXYr2AJZaKQJOfsAHNTFk4bB1qMO4n2DO5tPQCE/qUjdXtfvlhpp7OH9AxyZahS+ehYTWBruwlQSL6L8UE8dR+5cBbQLbeCpSbrgKoK2YfM7O36Grkokp699GcZYJuMxwUxk6IjgVaCyjBtjriGokhevCRfO7++0qkBy9gUhOzgM6ZcKR0saheHKVW1fN2iUHITOOqO7SuDRF7WLhJmE/r+AcGDJk0mQ2vwFVfwnbGtFB40/PTUOBDclCy4Lu87rbkgZ4cfCqIzH/B5L3qXjYnB3SlgO2ilG7cQsR1lngSiiFnjqx9hs+42/Umt/AtBRBO7rijDZu1GDhmrAZWNfd7ZqlzmrLSQ+8bVDluXZt1f6nwDJnD2/wtX46mVKYTPg/WDXovrWzm5AKjggOl5c6W9PcPWcZ7N0824MPYdqVChRUlGYWF9xcz6/dC4+1IeWpJfdcaS9SknUppa1J+zMtP4wiY1qMrSkqgMAtlUdExDN/8Um+nqsSCTzCShqu/kYJhJz/zFBf4HDpAE/eYqtkcdMmKEsN5C103Onxb5BfLtF0s1tZeNGeakydvl1f+FPwa4beGKHMKBLfxAH8Wxb1T0cfGRbuv0xUi86JDSQhj7iUQDBKQlmDx7MQhQ94X2mQpE44A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmVLSTBkcUgxclViV3NlSHRmNitJNTVKaWpSNy9wUGh0KzNVMGdIN1YxWkhw?=
 =?utf-8?B?K1hUajc4MEVMdUduTGFuTE1XM0ZucTAremZDNGJiSkwzL0NMeWt4aDZrNTFr?=
 =?utf-8?B?dng3YnBKQjNmSjkwUW9wdndFd3JzZjJraWtUKzY0eDRBVVZ1N0t1TFViRXJs?=
 =?utf-8?B?WW1YdkRYbGxoVElwS3VWUmdnNVR1ZVNRbFBtS3VIMW5Ld2FSOENISTRrOUl0?=
 =?utf-8?B?ajkxRVlncVJIOW41b0hiUDZVY3ZZaEtzOVdlUTMvOGxuejVDbkxOSzc2eFdC?=
 =?utf-8?B?UWJzTGZ4eHBGdGppSlNneTdJNWJYYTZJWkd3eTJwRzZhRkgxU1VkOGcvNjMw?=
 =?utf-8?B?K29Mbk45VjZlNkc4Vm9jMGZ6b1ErTmM4ZU8rRDJZY2xKSnZsSFRVZG1ON2s2?=
 =?utf-8?B?OXNNMDNSTGtOMFhYYTIvL0l2L2kyY0ZXL1A3Slhvb3NITGtaQ2llTHVjYy9D?=
 =?utf-8?B?c2w1YXZMaUNxQlM1QXZndm91dWI0TnRFZlp1Qk9ER0FqeXhxa1p1bTVtUUc2?=
 =?utf-8?B?dkRNZlhtS3F3QjdZdTJnY2svTThXUFNuN29JMzlSbDBaQnZuZytCWllLNUN6?=
 =?utf-8?B?bXRJaTNDOG5VNC9vbkMzdmxaeW92OWdFUzI3L3UreDZaZTQ2VTNmU0ZiblFs?=
 =?utf-8?B?TFFqZyt5dEhKeXZvMnBiQUoybGNPQzY1d2VFcUFiWG80UkZneU9TbU81MWto?=
 =?utf-8?B?V3FTK3ZCcWl3RTlwY3VURjUvTEsxTGxzSTgwNmVpRVB4WDVLQmw1VEl3MVBJ?=
 =?utf-8?B?S2NmUkl2bFMwdXRKWUhTWCtEVkNwK25lQXowQi9sd1RYUTlJMHlIRkF0K3ZH?=
 =?utf-8?B?UVlUeVlYRXFkcS82NlQva0lwd1BrekJUYm5zbzgxTk9kMVRtZWkwK3ZmeDAr?=
 =?utf-8?B?cFZKRmxGR3BWejlzZFIzZjN1cDFxOUVqQUpiUE9UZy9Ud0t6LzhIbU1OZFdr?=
 =?utf-8?B?b082aTZxcmdCaTdvYjB4Mms5bkFLSldoU1dmWFF6NjJuQWd6NXkzOVZzL2Rq?=
 =?utf-8?B?eEFpeVY5d3JZL05LdkVLbFNKamNtNUFGUzF3U0E4aGl5YzZpQzFQV3dJRnVv?=
 =?utf-8?B?NUFXMXdtMk9GMmFGdXUwc2ZWSHByenlNV25yVzBlY1p6bGk0VFpBeHpYUFR2?=
 =?utf-8?B?WVBycjQ1Sks5ZDRpWlpndVFKQ1ZrS3B3V003dVdzQW05clZERDVyeS9pSlla?=
 =?utf-8?B?TlBtTExPSTBTcEl4OXc3dytXSnlGYW5IWjdKM0YwbklXR2Vzdi9MMHpnT1FR?=
 =?utf-8?B?OWpoQmxRcExYQWJpQTdCYlBISVNIampzZ3EvczNHdU9YZDlKQmdMa1lKL0Qx?=
 =?utf-8?B?d21BMDFmQ1V1ZzZGc3JpM0NTQmF0dHZhUUdqS0wzYWpSUURMZHN6NEpiODBo?=
 =?utf-8?B?ajZQVXNaaE1uMkJwa051b0MxWWxSRVJZVUZoeWZJZEdQclhERmk2ek05VXRH?=
 =?utf-8?B?bkdUUUpjMDA4RnRhY1BkVkxmMWFJSnJvdEp0d3RROE4yMWlvU09iNlIvbEpI?=
 =?utf-8?B?ekluWllsdHhsaytObExFZjljNVNkemJRbzdMaFBHc1Yrclp0S0ZCTzA1UWts?=
 =?utf-8?B?U2NsMGJxbEJpSEpYcGVsblhMM3g1Q2hRbmE0R0trS09kR3JWZms5ditNWGxU?=
 =?utf-8?B?V3hVSlRlaUU0M2ZnVVN4UnlyUXU0MDlSNUhlVDd0QmhKaERDZWthNUcvbFlI?=
 =?utf-8?B?S3lWSHVFZlFJSjgrVkhoQ3ZWNVZZL0ZJNUJSYjFyK1hoc1QvNndxZWxvaGFz?=
 =?utf-8?B?ekJXRjJSTDhSb0pOem1CQzVNNXpDZVI0MWxPTVdkdFhkN2dKVmRiRWNXZkNC?=
 =?utf-8?B?TXdqV1RuUzV0MG80bnM2aGRtTk5WYlBoV2Z3OXZiMGZXc0ZxZUlqaG8ybVpr?=
 =?utf-8?B?UERpQ3lnUEJ0R0l1ZGlXNng3UCtiRkZnTkEwTExDZ2gyRkJRREFuY1VWeEMv?=
 =?utf-8?B?Q3lVRUNLOVhKa3BjeDIwZmZHd09IM0NIRGZOOGdPeHNxZzhoaTVVR21MSVI1?=
 =?utf-8?B?aUFJMnlxNUdsdU5VNk1sSVE1ZHZCMUxMVktCOWJmT2tLZGFrL1Y2L3o2bUJD?=
 =?utf-8?B?ZUxCK2MyZDF3NENnOXBWeU9NQWJ5c3V0SjEwN05oZ2pxNmpHcWdZY1lBZTBI?=
 =?utf-8?B?VzBsb3pEVm5mR3VuMzM3dVUyVXVPY1dUZmpmaFJJaXJIUkQ4eW5uRlZBQ3Jq?=
 =?utf-8?B?MXRGSHBwMHBVNUgwclhSZmFsM0FzN3hTQWZsbzVnS3B0UGh5ZVREVUFDQWw0?=
 =?utf-8?B?YVZXQjBCQUR0TEM2OTJhRTlnc1ROeFVIQ1JVajlKVjBuY25VMkNZOFUxYWdH?=
 =?utf-8?B?K1RBbjNPSWNYUnNtODlaTE9SbVcrcEtKSHY4WHcwM0E0SklzdnZvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 65064ccb-8c67-4cd1-5b7b-08de88623c53
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 22:27:43.4397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCoAWPyAuHPQkiiPhomJbPJalNLqTUu50VwcSR5USgQIgdN6J+I97VGK0WsnUz7JKtt48TI9UZajD75pta7Y9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2573
X-Mailman-Approved-At: Sun, 22 Mar 2026 23:53:49 +0100
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

On Sun Mar 22, 2026 at 9:59 PM GMT, Marek Vasut wrote:
> On 3/22/26 10:45 PM, Gary Guo wrote:
>
> [...]
>
>>> Is your malloc area by any chance above the 4 GiB boundary ? Or how com=
e
>>> does EFI allocate pages from above 4 GiB range? It should not be doing
>>> that and that is what should be fixed, at least until the DMA32
>>> allocator is in place.
>>>
>>> Please keep in mind, that revering this patch breaks other use cases,
>>> like loading into the DRAM above 4 GiB.
>>=20
>> Code in lib/efi_loader uses efi_allocate_pool (in lib/efi_loader/efi_mem=
ory.c)
>> whenever it allocates, which calls efi_allocate_pages, which calls into
>> lmb_alloc_mem. There's no malloc here.
> Does something like this make the issue go away ?
>
> "
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index b77c2f980cc..44eccc0cf35 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum=20
> efi_allocate_type type,
>          flags =3D LMB_NOOVERWRITE | LMB_NONOTIFY;
>          switch (type) {
>          case EFI_ALLOCATE_ANY_PAGES:
> +               addr =3D map_to_sysmem((void *)(uintptr_t)0xffff0000);
> +
>                  /* Any page */
> -               err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &=
addr,
> +               err =3D lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &=
addr,
>                                      len, flags);
>                  if (err)
>                          return EFI_OUT_OF_RESOURCES;
> "
>
> If so, then maybe we need a temporary config option which limits the=20
> EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitations.

My system is indeed booting with this diff + the RPI5 memory map diff that =
I
included in my previous email.

Tested-by: Gary Guo <gary@garyguo.net>

Thanks,
Gary
