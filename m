Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27356D58CBF
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 22:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8798A83FBC;
	Mon, 23 Mar 2026 23:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="c2T/aLJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07DF1841FA; Mon, 23 Mar 2026 18:12:05 +0100 (CET)
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c206::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36C184180;
 Mon, 23 Mar 2026 18:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=gary@garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVNG9XD3CfW84kyPgidmRt9c23O2SSFYK0i3vXct5KlVZLlZGjYLgG2VY2NsF38L070CvzxPp0E6S+d6UsWVZLl1+3bmOVNpXrPA7nJUKfDZXbGHKWWDxHkaZv6MwCNgRNDWxyklN+5kVcFTB2wyxZ4c4PYGVBXj2XYelAfndcdsuefOPhQ0eCRZocs2iotc08J6n9ZmPgL8iFdvduif/BI3YjAsEEkkdJzhq2ULsMykgLSLfcz2JHNXJv6dEIo0GC9TtUeLjiUx6xN9ie+DpAUOOLLUe1jqI9C/Ptg+fXKmcFuQiX1hGXA6UyZgPO0k2cM8O1cIflsf5jArkg2gVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruahVboODDmPVRaj0qHQCZ5PxKMOF4AyDlH5umWsiOY=;
 b=CPt79gm4gBxGvBBMxYgjBouXBkOmuKycx54UxErN/cdVzF8fh62VIy85wECm8ACpyendDVniMTr09AkZ0W/z7c1Ft2HAzmI1Z9ZidwTazcPoqfNQ5HRALei0YfoPQ8gFIpi///i4x1fk8uV1uOrO8khb0QT29dYtBEkgf1KOMUPuybVtjls4RQ1ojYGUS5cXzctDqrgiqPhUNwvuOIipSe4/dPTtTlEy+V9Z1tZ8gDNE7W3w7Yoa2SG1KPeAwxbLLT4oSELpPzxCck5Aue10w0SgnFnP1VKNwMdeC8iJTuP4vmt6E9rJVzh+gIpYqgPTcIBQ9o3H54nSfSQXX5gVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruahVboODDmPVRaj0qHQCZ5PxKMOF4AyDlH5umWsiOY=;
 b=c2T/aLJoLaT305xoziHOhRZkepDNlRKaS4v/V0HlLLS28aH/98vjC7WS72CosrWvqJPXrmVWs9yqd7KLbnOtAsBb3inwNXlpjY2sWzvw7kXzR5DOcz97qr42sbjsbGgqDK9zNUZdeViSnzIUhglBW+4HseSJGwNNGDLaVZecWSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2583.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:11:58 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 17:11:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 17:11:57 +0000
Message-Id: <DHABV5ZOLJOQ.1H3Q6TEFCTBET@garyguo.net>
Cc: <gary@garyguo.net>, <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <mbrugger@suse.com>, <pbrobinson@gmail.com>,
 <yuya.hamamachi.sx@renesas.com>, <andrew.goodbody@linaro.org>,
 <casey.connolly@linaro.org>, <xypron.glpk@gmx.de>,
 <holger.brunck@hitachienergy.com>, <ilias.apalodimas@linaro.org>,
 <jonas@kwiboo.se>, <kettenis@openbsd.org>, <semen.protsenko@linaro.org>,
 <sughosh.ganu@arm.com>, <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
From: "Gary Guo" <gary@garyguo.net>
To: "Mark Kettenis" <mark.kettenis@xs4all.nl>, "Marek Vasut"
 <marek.vasut@mailbox.org>
X-Mailer: aerc 0.21.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
 <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
X-ClientProxiedBy: LO4P123CA0184.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2583:EE_
X-MS-Office365-Filtering-Correlation-Id: 836cc13a-946b-4885-944e-08de88ff4a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: dbTIb3WWNVz4xTV3TWdv2/RJvhofjExNt+j45CdIEp2RxI1VRGlGO+V/N7bVy+CDP47glFQvFoIiYPXTv4V3BeFt2K4HyJcq2fvqHNB96lyhvAdVKbonLuOi5rH5jN8ZjU3oQxnjkLntKSfLLPQHBSk9Ha1m0aWX34fe+VB0TfI0ENTpgoh7kICH1pK+k9lKg2nbeACylDZQYw8RmcxTidwRtlNHTkdoT83Ovi3G+Gf1stfNC9A1d3lYlkVHNcA38ec9jOHFWUEgwZLrivPEWG+40B4x8erQpTlaKVNabG7/ReMBebqt4HwQ0IE7qDZRxG8uBh/3cJulhn6xABCtYZVlP/kr1EGlrDAwykMe4x1/0v3y2oGm74VsgLkdaYfQUn9/CHD7c1Mibr8eNDd3MU8tisySK/GEBrgzsImOD9ZiOmLamkjGVt0xfhk/QQz7cU+dmM07ko4RMDnoRFX33t42vLz78Kkrr/jkc3yvuR4sbGvew3AGkORf9zki0p8Ad8EMBwTuVr9ExQONwThcOJVzqg6UHzhxiDnGAprw9ciDp+3mRNSFbir+mbOiElxZnfR9oEI2y77UvAY7ahFlE1MAUjVTCTeuJUOqPK/rB2ST462K6UQLefz5lh//57xxQh90t+8bXTT9mom3A1suc4lN9e35XhfW2aXXzABjPfGKCaItDBh2a2OmtWfnwZMqZD3xx+frYZPK9ZnRmIOwiSMTG6romgZcQlqZ3/lNt3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxuVHpZOTJDQ2ZrTjBhOGZEcnhzWThNdU5yRnhrY0RRcVhHSHNwbmFzY1Y4?=
 =?utf-8?B?ekExMFYrWThhQXBUb1ZqbmwzWUo3QVBGZ21aWXhVVlZ4M0RBVk02Vk9WUDdq?=
 =?utf-8?B?Y2Q1ZzZxOUVxakxBcm55OU9MWHU2aXhDTVhGeEx5WVRYK201NC96VTJER0N0?=
 =?utf-8?B?eWZ0RS9MejJXSmVEYnVLN0dyYkl0WWN0N2hmSmtxaGkrVkw3SXN6VkRBVWR2?=
 =?utf-8?B?RUJkYnhaT3BoY01UbzNLQnlwM0tTUHJKSXZMeG5wMldNdjlOb2dXNlR1VG5x?=
 =?utf-8?B?RkI3T1ZmeHdMS0VTK3dxT0RZT2tkU3RKeHBjMzZ6YnRrRWY4REJVK2hNQm9v?=
 =?utf-8?B?NEgvc3RCeWZMck9lTWxBL0F6ejlUYnBXd0o0c1V2bDUrY283YVRxWXpQVTA5?=
 =?utf-8?B?R0kxZmVBZFNnc1VQNEVLZGl5VDAwbWt2cTZWcW1BODltcFdLOWI2QlUvZ3Vj?=
 =?utf-8?B?WUExR2tCRUNkamhuODlhVEN5YUdBeHdrNlVkQ3BJTEVRZmFtZzlxSXZNU0dm?=
 =?utf-8?B?VkJoYnIrV2FIZFRScDZwQk94QzFsYkFYYWErZEFsT2hrL1JMbU02Ry9IRmFS?=
 =?utf-8?B?WUJOb1lEK2c0SzhaU0N6bWpTdUpzeXN0MklLbzBTQWI4RW1yM3dWQi9YdXVB?=
 =?utf-8?B?ZitHalh1UnM4L0xQRUpYWGNpbzIrYjFXWVd5cW1lQVRvOWVyQUl3cDBLUFlJ?=
 =?utf-8?B?ejVsQTRHQ1Bvenp6WHpMZXdaVC9CMlVZT0hDT0FkYllQREdBZklRb0hYQWpD?=
 =?utf-8?B?anNjUXFSRFhwUldUM3h0RE5BNCs2VzRYdER6TVAvcFVicWl2TjFjNEdXRUEv?=
 =?utf-8?B?K2hQbnFJSHBnTzhIZjM4dXcvUElqdUNBODRLaHRnQkpham9iMHE3Z1NoSTJt?=
 =?utf-8?B?VDM4OGV1VlpTc3B0UFJiM0ZVVko3R2IyQlNxSjJZa2ZMOHJ2c3VSR2ZKSFZV?=
 =?utf-8?B?d3Q4ZkhLLzBhRUFrK0lvQWxyOUM4RjkzejloNTVSQjNKQXVVc3dDVHVHa1d5?=
 =?utf-8?B?Z3JJeHpNczBkTENDQ2hXcDJGZmx0TTFSdC9qWmpCanpFY1F1ZEJkTzRoSGNW?=
 =?utf-8?B?aHozcEVnakpVcnJZdGVpcjZRMitNVENHR1VzS2ZGdmNzOGQ4NTBrK3dvSk1k?=
 =?utf-8?B?cGpITHczN1g2Z3FmRTkxQjhYVkp3Mkd1TDBpSzhVNmhjelRCVkF4Ynh3dWVV?=
 =?utf-8?B?NEhEOEFsbjU5SEZSSHVFV2o4RTlKaEdKcnhPeGgrdlQrNVNiZDBrZ0VrZStK?=
 =?utf-8?B?elVKUjA3QmpseXZuSE5wcjRuZEkzV2FKRTJ1bGJvd3EzbkRxRWt1SEJUMlpK?=
 =?utf-8?B?M3Mwc3ZvTkMzdTNLT1VRTFdpRm1OTWduRnlRaGhjak10NEpQWXBiWmVpYmRr?=
 =?utf-8?B?SWFuRXlWSktuMi81aUNZRVhMRGl0eVViTmcxVEFDZy9jUHBBL1ZQdjdxd1I0?=
 =?utf-8?B?Q1VQY0x3Wng5ek5UQzViTnNVQUExV0NqWGdHUVRzQnJjMnJWeTJCQ0s5ZnJr?=
 =?utf-8?B?UW1nNnFFSHRaTWNvN1RncGN0OGZJL09jMjMzTzlBQUlQQXZGL3F1VldMa1pp?=
 =?utf-8?B?SXNlV1ZWa2RTcFZwTldnbTlkbkNWemw1S1J3TnY3elVhTnhQQ3dJUnFDTEE5?=
 =?utf-8?B?WjJIQ2ZzalVWTzZJY2VnTHZYZDB2QzdKVWVESFdWVjgzL1JWUGNreTdnakxk?=
 =?utf-8?B?c2FWU1JobmtUTFhvMWdIRGV0OFc1eHlQSk0xa2krTnp0SDhmTlVrSXpyS2xD?=
 =?utf-8?B?Y29iNXlOVmhGM2kxSkFsMEx6emdqdm43MisxUThYdmxTV3A0QTRENDI2cVBL?=
 =?utf-8?B?cEZaUWZWRkZhNG96T0RqVGRENDVzWmxvQ1hOUGNuQmVzMHBQVkVDMllzSy9M?=
 =?utf-8?B?TDB6Z3Znd1lvN0hUMGErNmZueXUzMUlkcEJOd2N3Q0M3WEJMZHg2a09rZmZp?=
 =?utf-8?B?TFlkMnZJVXl1c2dMckswOVROam11UFdKNXlUR2RldlRiZHhVN0IvekdoZ1Vz?=
 =?utf-8?B?djJEYWtkcmkzZEdqdm5qNnVlNnFaamludjM0THlzWWh3eldUU3N3S3h0MVhz?=
 =?utf-8?B?c2pQQks2TTdmVERmNDBFeGtSTi8weURkK3Y3RmlLOTQwWUJUaWRXUCtCSTdE?=
 =?utf-8?B?WkhQaktrNExReVhDWWFqRGs2VGo4WTZSZk9sYXVnaFhGYkhYQlZhQ1hkM0xn?=
 =?utf-8?B?VzdkTFNwVC8rT1ZNd3c4RDJCUzFETi9kNFpTaFJRT2kzbHFkNUhhbnd5QkxE?=
 =?utf-8?B?U2hZbDRhMkJnditISjBrRmpOcVdtN3FqaDYyNHlnOTBRSWo5Wm51TFNzcXNM?=
 =?utf-8?B?YXZtTVN0Sm1mdkhPS01kQ1VPRk50eDNJcGIxaTJaWUxYMHl4Qm5RUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 836cc13a-946b-4885-944e-08de88ff4a67
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:11:58.0304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skFb8DsbPgMLaklwGVFWncNbAi+NeZPKeODzV7mIYtvXMGKxhX9A20NngX6j0FsYVfXXTZaOmtIxVyWl68mwJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2583
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

On Sun Mar 22, 2026 at 11:25 PM GMT, Mark Kettenis wrote:
>> Date: Sun, 22 Mar 2026 22:59:53 +0100
>>=20
>> On 3/22/26 10:45 PM, Gary Guo wrote:
>>=20
>> [...]
>>=20
>> >> Is your malloc area by any chance above the 4 GiB boundary ? Or how c=
ome
>> >> does EFI allocate pages from above 4 GiB range? It should not be doin=
g
>> >> that and that is what should be fixed, at least until the DMA32
>> >> allocator is in place.
>> >>
>> >> Please keep in mind, that revering this patch breaks other use cases,
>> >> like loading into the DRAM above 4 GiB.
>
> Well, technically it doesn't break things as this is new
> functionality.
>
>> > Code in lib/efi_loader uses efi_allocate_pool (in lib/efi_loader/efi_m=
emory.c)
>> > whenever it allocates, which calls efi_allocate_pages, which calls int=
o
>> > lmb_alloc_mem. There's no malloc here.
>> Does something like this make the issue go away ?
>>=20
>> "
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index b77c2f980cc..44eccc0cf35 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum=20
>> efi_allocate_type type,
>>          flags =3D LMB_NOOVERWRITE | LMB_NONOTIFY;
>>          switch (type) {
>>          case EFI_ALLOCATE_ANY_PAGES:
>> +               addr =3D map_to_sysmem((void *)(uintptr_t)0xffff0000);
>> +
>>                  /* Any page */
>> -               err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, =
&addr,
>> +               err =3D lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, =
&addr,
>>                                      len, flags);
>>                  if (err)
>>                          return EFI_OUT_OF_RESOURCES;
>> "
>>=20
>> If so, then maybe we need a temporary config option which limits the=20
>> EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitations.
>
> Note that some arm64 systems (e.g. Apple Silicon) have *no* memory
> below 4 GiB.  So that change must indeed be behind a config option and
> care must be taken on what systems to enabled it.

Perhaps a good short-term fix it to use gd->ram_top here rather than hardco=
ding
4 GiB. This way it should work on all systems without a config option.

Best,
Gary
