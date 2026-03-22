Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F951D58CA1
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 22:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A118408D;
	Sun, 22 Mar 2026 23:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="ZucER2mJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0841083D71; Sun, 22 Mar 2026 22:45:37 +0100 (CET)
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c205::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18798366F;
 Sun, 22 Mar 2026 22:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=gary@garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjYInTQ6F0G/1K0qdNVQVh949cB/EdrcNbjTcDhuwEnOQIWBaNjpfZKIFSZiTxYgoBKU+7ni8QG9cLvg8BKU3Wb+G+pmZ1XzWEv3YlQ4+56NTEtZwqofay2oSEgLNllVLiiHyLc8lHiW7jWcLzDtSnxlfRCcM4pSQr8F11hREam/hiGRGFCXOnyWrul2kRKj2mDXCM/GVBTsDNUpsZEEq9gV+31xbwSsLXnu2cDJ1VifX/3eND9k2bYHGK/C6qaUjmoC4uOm2fA4I1vBXwjpHzk96NVJBn0XaBPM/U4Cek5C1gplkZS2ipxplxo+tM1ZMNz9tM79ld1uEicvlkE4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp7dZ+0EgMMPN/Iz9OXpk8kd6djMNnktqvqgYS+u1Vs=;
 b=wb0nXWiXjiGnFuxXYxW8xbIo96u5IaXgLpCCZgfxGa43GusTkdhcC64P7KVEPrMOuqD88KKpw2cSc+7Jw8anKhuSHMB3XABvfKlEWTaaWUbYS6DuLPMHuPjm0kLojvMd+84gxfSZGoUhQQaJIWRUrS/gFzR16wUdy2HlQM1BQDCzpVdh7fHqbJJEdyhbjF7fUcjnEii25600XHqJWCjwf/9ZX9FNKMJkzP+M/R5//S0oE+qgCB7COe9ckj29sLq8F3adJmquU9w0dVw/IJAq4JcrCjzwd/RYDnLRTfBOGTEswqceyzSI2vUbO62Wco3pp3Wea6bIvoptX30ea3zkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp7dZ+0EgMMPN/Iz9OXpk8kd6djMNnktqvqgYS+u1Vs=;
 b=ZucER2mJxrl5+nSZ3msOEwyyOn+AgkkxWjMhNY4pbCZRbIu1wTpV+RARangEmVGgOAG0dwPmcxfWxENYm/wKExhKZSxgddOJ7F1MVnYx3KtWUkW8BWe+AYbXpknDjVzx2IQBArBEP1Pz0lRCA29nO6UqXWZtbIboEhwJLjTezkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5601.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 21:45:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Sun, 22 Mar 2026
 21:45:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Mar 2026 21:45:32 +0000
Message-Id: <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Gary Guo" <gary@garyguo.net>,
 "Tom Rini" <trini@konsulko.com>, <u-boot@lists.denx.de>
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
X-Mailer: aerc 0.21.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
In-Reply-To: <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
X-ClientProxiedBy: LO6P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f0819f-926f-4f18-b70b-08de885c57db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Sw4r+1CCJziEe2h/UQUIlvCOGGt7559zOL7Z/XwWB4QnfhYN8LcY0d89nDq83t6lzdG4OYtjVs5GM2WoCrLXbQ+DD4WP4ystJCkjejlzziL02ONsA+qgFY56O0N+FdW2VvaTK/ziuuCY7UUaK15nqTxk5yMjW/dbusi/71qJ9vDMWlYbYEqWUA25qp1HOgiCxEDvVb/oPSgJehw2sWSx23XD5AHJZvbVECP4LQ20/nFglGneue6+vDaYUePvShEe8Zx/LVdxL8m55By0AlPQxB8sbfT2+vEnPK85bXjml5iCuLkoOWmqOqlzZRKxpC8HwFJoCUSW5eJKVPiYs3OJddxQAfChvC+3WuGLlhpLOWKo0WF+Ux1keNl4dFvKXm6ChefYz+GB8Ufqg5/mQDgLXr8w7fYgphTQ34DcvmcQ20hq6/gxJSfz5RM+hQzNy0hY3MTlA94g0ujlUkmHc7cLjkJtrUtHQ7sqzHoA1cO3Rb8AMu5Uzc6+qm5lIiOkH15mh6RO+aov3izx/MXJkNPuvdFbgF0PDN+69RxhXPBwEA2GlBBzdMtVcpIgP2UFIjA0ExlyEB222lqVlkfMxSOOH5L9nwYmDf2syMtEWv6KKj6w/6rgJko5IvUfUUufLWp+Vmg7j/ZkdsFBXdREgAG0H590OZBRiXujUCjDZlGTGZnnF7YXTjGw0ErAXxft3H+wfHZxHVUmV9PibtK3QMkkHJqg0HkYJ/l17pmeZV+DKhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVuWFJ3Yjc5WVpwNE8wZ09hbGtJWWxnckdJUW1FY0NQOVFmM1hTTDhEdXpi?=
 =?utf-8?B?MzBJeFlJb2Q5YVhjdVM2eEhoOFI0RUlPbTVRNjhOWms4dlI5Yy9jQmtGZFJH?=
 =?utf-8?B?Y1NCUVJIUnJJU3cyME15bkdUTlp1djk1bkUrQ1BqdGh2QjBKNjROMkFsejVv?=
 =?utf-8?B?U0FQQ3lrdE1ydHVJVUJjTjJWVDhGUGh5dnhTUHVMUk1rcStlOFQ0c0o0Mkg4?=
 =?utf-8?B?TGlzeUxtSHhDdGFuUW5kZ3czL0dkc2NadWRaV1JDeW9lRVRKakhNbTYrci9D?=
 =?utf-8?B?SW5KeE9vd0dhZldyQ3ZUNUNwVVNONzM2ZEhnbmltV05VN0JCVkdWbDN2Yjdo?=
 =?utf-8?B?WXNxc3FZRzg2VUFDZ2FWNkpwNitUSTlMS3MwNkVHT2RJZmZUT3RLR0dDd01X?=
 =?utf-8?B?QkRpM2Rhdko2anE5MTQrOHZtR21lT0VLeVlMdlRrSjU5YVAvT1luM3FIemRa?=
 =?utf-8?B?RVhZZkUyUStlb3FRUHVsWnkyUU5KaDBkMmpzcUxiYnFyRlZackVTaWxweWNp?=
 =?utf-8?B?blNGbWEyS3NYTDlOYUNvdkZQY3ppdm9UcG5mYTIvVjhBNlArdUdob2N5SC9I?=
 =?utf-8?B?ZUxDQllCSEZNSE5rd1Q0aDNQU21hUGZkdmhlb3lKNU9JZ2pzMnltaTlMd2ZK?=
 =?utf-8?B?NUhEeERwVGl5WlZEamszOVdVVnBUVlBRaUlvQVBydnlZY0txOXRkdnZVbXYx?=
 =?utf-8?B?c21UUktwVldOVHEvbGhlNHh4eWt4bGprOFF1NE96UFE0a3NHNFdGc1BrM2lr?=
 =?utf-8?B?Z2FqKzVSTEIvTnFzQjRDRkp4bW5BVTdnRXJtekZKSUVhV0U1YS9oWGU3VCt1?=
 =?utf-8?B?aVVHZjcvZzdnZ2JGL2dyeEVYTUxnWEIxRUJTa0FCZ0Q4cTVpUmFwZDVvQm5p?=
 =?utf-8?B?M0FPMlIzOXphZzZQUUkyYzE4Qmk5ZUs4N0tGcTB6M2FYQXh2TzloU2N3Yno5?=
 =?utf-8?B?M08zVnBnWDJIdWZkSHQrQUVnRmsvTFR0empBZVhxaEdpSi9aa2s4anp0eTRp?=
 =?utf-8?B?OEtVVFpZN1dpTW9yVU1HUTVUWHYwb0VzOW51OXVaUVNMM1FoQVVmbExQNHlt?=
 =?utf-8?B?N0dJbSttYUV4bTErQ2E2OXk4Ykg2eVZuZHBSVTlHZjRLNjVFSFVybVRSa0Vx?=
 =?utf-8?B?TUp0bnN6Y1lDc0hQQ1l4VC9sUkltVXhOTTI3Z0xPUnhTd0xtS25jNm41cGJC?=
 =?utf-8?B?bjJVWFNpdnozcTlrMVAwRkQvM0dCak1IbkxUQnBJUm5vZjRjL1h5bCtST3RR?=
 =?utf-8?B?MnBITE42Rm5OWmpGb0NlV3lBbDBDNXhia1JqN2VwZ0lGVUZEWEphaEovMmM2?=
 =?utf-8?B?UW9SLy9rekRXbDFpSFdTUW1oMjBmUit4Y0V2UklZUnFtdlpuL0RtbiszMC82?=
 =?utf-8?B?aHROZEVxR3hUVmdRWEMrR21CcDFjK1FBQTdiSXZZM2pRMnRBZTNZT0RPczFj?=
 =?utf-8?B?ZmFXazhtMHZGSlZIYmsvaXhxSlBzQ0RtRXdwenMzOXhsSzg1SjkwV0c5Nnpv?=
 =?utf-8?B?ci8vZzhoOFhDeDk0R01wck1IRC9GbjF5bWJWUHJISnpDZnlIQnFTOGtZaWZZ?=
 =?utf-8?B?K1V4OGo1a1p3bi9WQ1VCMk1nbFVzMXhEZGtGS1lLOXEwRlQrdDIyVXdrVmZH?=
 =?utf-8?B?SWdYcnRLdnNjNGRDU0IyT2lIYjFIK1VUak05RGlzRGFEMzRFY1ZjbmJzcnRQ?=
 =?utf-8?B?QWF3MEwrQzQ1Rng3cjNLbG81QjEwTE9Rc3l0TUdOQUJhVFA2cjBZYm1OSW9P?=
 =?utf-8?B?SmJxYjd4M1h0SGZiTC81TnkzOGV2OERYK0dPRUhyTlJQMFhUaEx2UzVHRzZY?=
 =?utf-8?B?UmZpR1VTNXBFVnRxSWtGZ3NTRkt0QzJWRm9JVUcyVDIxZ2xnTHNaTlJwUS9L?=
 =?utf-8?B?cVNjZG5DbEFHTFhlTEkrQmZjQWI4MENzM1U5bEluRUd6ZGpCem43Z3d4K3hp?=
 =?utf-8?B?RFgzYkdWTWJ2MFpPN1FIZHBvQ09QcXlITXZMdG1ja2t5TnRObUZ0bVIranUw?=
 =?utf-8?B?YktCVGpjM0FnRTVHNkpnTitPNEoyNEZzU3JtZWxyOXZIN1pOL3owUndsaWZk?=
 =?utf-8?B?ZVNxVUYvY0kzdm5YdzBHd0ZGZzc3SEFvSi8zU05PdjhveHMwYWd5a3BpRWdN?=
 =?utf-8?B?YlBEZFV4ZXVxSU9VaXdGVTRZMXZKVGlBckhuZGFYcTdOWmNiczBtblZnTVZi?=
 =?utf-8?B?TlNKY0dZTXpKWk9mb3hUTXNJRjlINW8zT3grTWxyZ2JKMlA2ZkN6ZzV4Rmtu?=
 =?utf-8?B?N1RlMXpxQTVSWU1LRHpkTEFwZHFISG5ocWR1N0N1dUhVYllOU1p3ZldYUVVE?=
 =?utf-8?B?V0IwUHJjSjN6TGNQQkNXQS9FSDBtUlhPVWwwbHV3NW41U2cxOUJTUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f0819f-926f-4f18-b70b-08de885c57db
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 21:45:32.6884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQF3IRKS/0dwSJBSznY0+b4OMIln7Evzsl5b1ULFwslPidzagwPGiZnuOL2gzZivs8ugJhlmi6YyNacCf2q4ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5601
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

On Sun Mar 22, 2026 at 9:30 PM GMT, Marek Vasut wrote:
> On 3/22/26 10:15 PM, Gary Guo wrote:
>> On Fri Mar 13, 2026 at 8:54 PM GMT, Tom Rini wrote:
>>> On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
>>>
>>>> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top=
")
>>>> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even=
 from
>>>> same bank"). These are based on incorrect premise of the first commit,=
 that
>>>> "U-Boot does not use memory above ram_top". While U-Boot itself indeed=
 does
>>>> not and should not use memory above ram_top, user can perfectly well u=
se
>>>> that memory from the U-Boot shell, for example to load content in ther=
e.
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/next, thanks!
>>>
>>> [1/1] lmb: Reinstate access to memory above ram_top
>>>        commit: a3075db94d49f415658bf7e961e1eae90d9abc33
>>=20
>> (Cc RPI maintainers)
>>=20
>> Hi Tom,
>>=20
>> I'm testing out latest u-boot/next on my Raspberry Pi 5 8GB, and I am ru=
nning
>> into issues caused by this patch.

For some additional context, my setup is a fairly standard u-boot ->
systemd-boot -> Linux bootflow, with u-boot built on eb00c710508d with
rpi_arm64_defconfig, booting from SD card.

>>=20
>> I have EFI enabled, and efi_allocate_pages will call into lmb to allocat=
e pages
>> and start accessing them. However on RPI5, only 1G is mapped, so I got h=
it with
>> an "Synchronous Abort" triggered at address 0x1_ffff_f000.
>>=20
>> Now, that is easy to fix with the following diff:
>>=20
>> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
>> index 7a1de22e0aef..1db2e37c44f4 100644
>> --- a/arch/arm/mach-bcm283x/init.c
>> +++ b/arch/arm/mach-bcm283x/init.c
>> @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_=
ENTRIES] =3D {
>>  =20
>>   static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] =3D {
>>   	{
>> -		/* First 1GB of DRAM */
>> -		.virt =3D 0x00000000UL,
>> -		.phys =3D 0x00000000UL,
>> -		.size =3D 0x40000000UL,
>> +		/* 16GB of DRAM max */
>> +		.virt =3D 0x000000000UL,
>> +		.phys =3D 0x000000000UL,
>> +		.size =3D 0x400000000UL,
>>   		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>   			 PTE_BLOCK_INNER_SHARE
>>   	}, {
>>=20
>> and that indeed makes my system go past the init. However, I found that =
while it
>> is fine to boot into systemd-boot, systemd-boot cannot boot into kernel.=
 After
>> some investigation, it turns out that efi_load_image_from_file uses
>> efi_allocate_pages to allocate pages, and then feed this to f->read. Thi=
s all
>> eventually trickles down to the MMC driver, and MMC is doing a 32-bit DM=
A and it
>> fails to write to the buffer allocated (which is above 4G).
>>=20
>> This could be all fixed by having dma_map_single use a bounce buffer and=
 copy
>> back the contents on unmap similar to kernel's swiotlb, but that's going=
 to be
>> some major work.
>
> The DMA32 allocator is on my list of things to fix.
>
>> In the mean time, I think this patch should be reverted. I can confirm t=
hat my
>> system boots fine with this reverted.

> Is your malloc area by any chance above the 4 GiB boundary ? Or how come=
=20
> does EFI allocate pages from above 4 GiB range? It should not be doing=20
> that and that is what should be fixed, at least until the DMA32=20
> allocator is in place.
>
> Please keep in mind, that revering this patch breaks other use cases,=20
> like loading into the DRAM above 4 GiB.

Code in lib/efi_loader uses efi_allocate_pool (in lib/efi_loader/efi_memory=
.c)
whenever it allocates, which calls efi_allocate_pages, which calls into
lmb_alloc_mem. There's no malloc here.

Best,
Gary
