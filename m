Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B807AD58CA3
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 22:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0328483FED;
	Sun, 22 Mar 2026 23:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="h2lD/jah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B5783D71; Sun, 22 Mar 2026 22:15:37 +0100 (CET)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c206::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0762383AC5;
 Sun, 22 Mar 2026 22:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=gary@garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSrGoRFRumfD857mU3/Nm3eq6YlldipvtCgnaLwst5njCOFtLKQlkhxTm3AB+kspxK+n4PIm3MUJ8mhtz0R3qDsmMJc5BRhrDOZ7L0ei5dz1yD2dQvJu71EbfE/uPqWe7s2NWVA+3oFWU1mYx3grbvHCTl4tIX9cSNXSzaqwiqsWcv4XF7QCKh7z3dVkab+EM7Yrr0IDhk7clt1U/OrAemlg8aQK9JD7Wo/+8oBnf+T7vgHyf0t2wvv/E87u5OMl/NSGigpu+m7UzeFZJKzt34qkeVNF3ev0rpEIxLTkARUgir6hcuGI/wB2LyIk/maLiGM92TYF3fHaIOGxop867A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAJj5CgNrjXxBq62hkwOrUyQLLG0KBNVKMvPnTqBMGE=;
 b=Q6pszKpejmm+NdvQPIcaKAecJ1U14FvX7j9EWZ/Qw4SL6fiheRhMSX9atIxHdKrNddMtx+bewAuAl8yihQoDiyQgtkqoriQieStxGFasg5iRRtJPUZhgOn6XlM2BqODV5tLJaOe/rv3ZwUZp+bTshSJe4MaDR+B93MpHwTYbwoGlEGN1cdLVA+kxnCm0X06hiP/+0DlPsmtE5qOInS3TNTl+5swN21qTgW15/KWpBDhhK5M/4Z0apwxLiSVtTOFA1dkSO7ZsNDoqBMP4MUr6x6J+ZtVuOPycbJk0pyOfqIXq4Z9gNrgz5PiWwzTwXP91V196uiFrQ3lpY6+STqP8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAJj5CgNrjXxBq62hkwOrUyQLLG0KBNVKMvPnTqBMGE=;
 b=h2lD/jahHwDOCGvxXBfI0EswybiXACVRLbhvkvB2mzissW6cG/hlvrCjZKGJgy8a5YXw5OPliQRMkOFjJSdVVUy0n3KGK7NrRDHG/9p7cTP2w/eYLjjVnsDP0ub58+s5VYY8/ucgF6vUS1NF+lNnwg6JyAbsQ8gyZQGtr7AXSf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7066.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:321::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 21:15:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Sun, 22 Mar 2026
 21:15:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Mar 2026 21:15:31 +0000
Message-Id: <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
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
To: "Tom Rini" <trini@konsulko.com>, <u-boot@lists.denx.de>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>
X-Mailer: aerc 0.21.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
In-Reply-To: <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b240415-3607-40cb-7396-08de885826f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Edq+vnUMnEnPpTW/KbaeQjeOSn2YtivXxzHyNEt29uPOzwX1iFx1TKm1GAnAh+k8jRddeiCFbl7yZTcFCUsjd6BfT8FYJaUuib1pZ6H0qAS2A3LwfvCiMoyEBLtyqJa8SCU7JD52GXrcH3gCREjIFrn3hlamQyI/IzmjOJH3Knqy8n9ikpa2Kq9kWe4NhQNgdELZ3F5hfV7mlr5VTwv9MtMqArqs/qWlY9AFJIsyad1VLlRD+yc0PsN7tcyKBD2nMTBj4F0JWyJ8CGgb+MFRBNtGqRx4q/LbFxvrkGNlrNmpPzWA/Qroc/jDs/2ssGGwaqFyKp5leQdI6yY0HbrV5qf29U/cA3YUjxo8LmSyodEII3H9GWt583t8opOqxvC1h+TO6ygqK+6OwkdzkXh2U/9zGWJ8Otu9jVOwEQdf2RqCzygi+pK2Sv51TsiYWYXuAwXi249iN6dSkumS2J2dBXUsT+8BIbk2uNEin/28rbWIYauGgBtf98QczWPZk5ayKvFLEqxeMthk6fqgmHl66+Yo3f40g//xtiREKiPCtkim7TIrK3jaGIguWDzZ1IOc2SfMZ8LRLWTjBY9ZX1QFsuD/TDb+1lL0zWJ3BI220y5szn0KKj5VomcG4hoIkg2uS4tNO8yzQNJvSlOLWBGh9qN5ojrG2u8mWkjnDcJomULz2GHTeZarHIC2XkgvSV+S5o3H4RqTv5MB2whbJl9w98zFB51QmIy/5udEUuuMkH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkRyVUk5OS91NXovdVI0Yk44SmloSStYNlllR3JjRDIwbjNmNEZHUkwwTFFF?=
 =?utf-8?B?NGtHaG1mb1BnM1NxNUFuYlF1bHErbG1ZZXlZU2hua3krVUQ4SnBURVB6VXAy?=
 =?utf-8?B?ZnBSaTRuK0Z2WGRhMTRUd2oyYURybi9VakZ1cG91a1YwVVhwa0dncUtTcDZQ?=
 =?utf-8?B?NkpJcHdpK1dxeGlvV2JPU2pCNmJJVGMrZzgwL2J1SENaUkRObGExK2NUTjg1?=
 =?utf-8?B?SnZiODFjb2Zmd0g0dkdTYzR4V21YMzhibjR6YnNFc0x5a1EwWFB2T1hOZ2Vy?=
 =?utf-8?B?Z0FzVWdvWEFCTHQrR3dvWFpyR0xLaWUrdjVmcDdXQThCLytMNCttT3hMeE9t?=
 =?utf-8?B?aForNGxnNEx2dDROVGo5Z2VWUFQxNjdxRUc2L1hoeTRSQWtlYzdmT3hraWJ2?=
 =?utf-8?B?ZDd2cmRGYzJxcFlBTW43cjhLaWw3NEdKWUkwRjhrbjhDSUxTeFFHYytMKzRE?=
 =?utf-8?B?WDdRWHJJYUprL1M5SU9aMUdEMUVrangwZ1Awa3JMRFJMRDFRWC9kRit6Y01r?=
 =?utf-8?B?clhONWJwVWJkai9uZ1RSNk16SklybDNXM0pUK3ZZQ3AwZTRFVEhQZloyL0or?=
 =?utf-8?B?TXJQaXNncG4zaXNiU2JCQnBiSE4raDVraWU0SlkxN1lWOWNqUG94SkszcFFq?=
 =?utf-8?B?ekhLL3c0dm8wRXZCRzhOSllQLzA5YmV5NWhzNkhocXVTcDAzQjBveVJpeW5h?=
 =?utf-8?B?VXdKVVlxaENDRXF3cWNTVGZGWU93emgwZjIvUXVEeXJLcTNGTzdFRDZNM3FM?=
 =?utf-8?B?bVNxTTMwYlJESy9sVCtCRm9OVUM4SFdmaGRmYlQvSGtmWkNjelF2TDhwTlZy?=
 =?utf-8?B?VXpjem1BeUpuWFlXWmRWTVRqNWhCZkFsK0ZDMUVFbHRFUmhNWUVWVzFBeGNY?=
 =?utf-8?B?Rm5qdk5KeUZHSk8zbEdiRjR1S2hickY0TXE4QStoM2FrQ29uZ1pid0RxR3N3?=
 =?utf-8?B?WXVpdUhMbG5jY0k3WUpBWitMM0RRaUVGd0x1M21PcXNnOWNmNjBsMXcyY2pJ?=
 =?utf-8?B?M3JtTXRHYk9GUWJjUTRRM1BTeUhvejNjSzNaZHRHT2tGL0VmckIrZkJLLzRv?=
 =?utf-8?B?VDBNM1JnUi9TdWZHNVhwY1UySzdiOTg5S256UmNLcUNhbEpQZ0NwaVYzU1gy?=
 =?utf-8?B?VmE1NjY4TmErRVkwRElvZlFRcXpRdmpkT1AwejhZWUw5RmRTTDlUcUlZOFZT?=
 =?utf-8?B?UUFpc09HTGJnOTNuYmNjRW9kUW5tTzJ0SjVRS0lYVUhBTWlVZmp1ZENlRlZX?=
 =?utf-8?B?NjRCdGRnSE5JNGxUcnZxVmZuMUVnZ3BoRTMzM2diY2J3U3FlUU9kNWFLS0lz?=
 =?utf-8?B?UDIzSWJGTkhhN253dkZja0p2bTY1Rlo1YWd4eS92ZkNGS1dpWGo2SFh6bVpD?=
 =?utf-8?B?d3pxZkk4OCttT0FEOUxGd2RveC9xTDhmWGhLa2lyd2c5QnBPNktQa3BacFNF?=
 =?utf-8?B?MGJBK3lrRnhHcUY4MnY0Zm50bzUyUG9yVzBtdTVpeDVVTFVjNTQ4UlpEM1Js?=
 =?utf-8?B?YmhuRmFKWTN4WkJSUmxvZzZ5cTMzUDdQU1gzV1hmY051bnhQVmQ1cGZ1VUhw?=
 =?utf-8?B?bkpvT1dpZ3dndFliMWpCc1ZKVmYwb2dPY2M3OWlJTnZQMjhmUllySmg1SUlv?=
 =?utf-8?B?Q3JhclRXQ2xuZXZ3S0FBZUQ5dXJpdW0xK2hkMkVKSkR0YUUrZ3FzKzRRWnVo?=
 =?utf-8?B?MjNUbFlvcWEzK0FOd3FtWmJlWkw3MkxjWTJFMmdtY0xHcGNaTXRmdlp5TjRD?=
 =?utf-8?B?T3M1a0pDbmZ3a3NGMDN3THVRQngvY3U1VVhHaWduQkluYStxeHNQTk0zOEJk?=
 =?utf-8?B?SWdCQ0lwMDl3UTBINHVMazVMSGhnLzc0bHVmMU5hbEpRM0VVYktrcWdzRGcz?=
 =?utf-8?B?U3I0eTE5dEJOWFJkdEprM204S0FySXQwSnB0SUo0MGQ5NFFSNXJJZ3JqRml5?=
 =?utf-8?B?WkpJSTFGMGhJYzlIb3pPRUorbkJVYTd6eG11ajdJS3E5RHorYUk5YXpHWHBY?=
 =?utf-8?B?Z2ZkWkROTEd5TXc5ZmxpSFNuby9VUFF0TkJuU1FPeFkrWEpoTUxUZkJPbEhr?=
 =?utf-8?B?bXVNYjlHbUtmVjA4Q1loMWhDMUpuNlpTRllwbUN1VDVMY01zUk01Y3lLR0hr?=
 =?utf-8?B?aURCVHhKanYxVWJnMU5DdDFCL2dhZ3FXOUt6ZURrYzBoc00vcHNzbG1Vd0tQ?=
 =?utf-8?B?Uzk5a0RoaDEyemNzTjhEenp1RXpsN1RmS1NXTitBQkxUUEp2LzVaRWtoTEtM?=
 =?utf-8?B?MFlOSlRkOVJsY1BLb1RVQUtsUG4vaElmbjl4OGcwajhJOGg4QTdEVXl0ZmYr?=
 =?utf-8?B?elhVWExpQTdsT2tpOUM2UnVxMngwczk4MnVUUHVJK1o5T01BTzFrdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b240415-3607-40cb-7396-08de885826f0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 21:15:32.5882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0p4G4hVfwOdygom1EZVP3ebzFgKEHX696d7QU5ZTgPO9hvW8KCEU48ZK1ro5EaO/cwRuaPeZCBReEcmy4mMMHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7066
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

On Fri Mar 13, 2026 at 8:54 PM GMT, Tom Rini wrote:
> On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
>
>> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
>> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even f=
rom
>> same bank"). These are based on incorrect premise of the first commit, t=
hat
>> "U-Boot does not use memory above ram_top". While U-Boot itself indeed d=
oes
>> not and should not use memory above ram_top, user can perfectly well use
>> that memory from the U-Boot shell, for example to load content in there.
>>=20
>> [...]
>
> Applied to u-boot/next, thanks!
>
> [1/1] lmb: Reinstate access to memory above ram_top
>       commit: a3075db94d49f415658bf7e961e1eae90d9abc33

(Cc RPI maintainers)

Hi Tom,

I'm testing out latest u-boot/next on my Raspberry Pi 5 8GB, and I am runni=
ng
into issues caused by this patch.

I have EFI enabled, and efi_allocate_pages will call into lmb to allocate p=
ages
and start accessing them. However on RPI5, only 1G is mapped, so I got hit =
with
an "Synchronous Abort" triggered at address 0x1_ffff_f000.

Now, that is easy to fix with the following diff:

diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 7a1de22e0aef..1db2e37c44f4 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENT=
RIES] =3D {
=20
 static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] =3D {
 	{
-		/* First 1GB of DRAM */
-		.virt =3D 0x00000000UL,
-		.phys =3D 0x00000000UL,
-		.size =3D 0x40000000UL,
+		/* 16GB of DRAM max */
+		.virt =3D 0x000000000UL,
+		.phys =3D 0x000000000UL,
+		.size =3D 0x400000000UL,
 		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {

and that indeed makes my system go past the init. However, I found that whi=
le it
is fine to boot into systemd-boot, systemd-boot cannot boot into kernel. Af=
ter
some investigation, it turns out that efi_load_image_from_file uses
efi_allocate_pages to allocate pages, and then feed this to f->read. This a=
ll
eventually trickles down to the MMC driver, and MMC is doing a 32-bit DMA a=
nd it
fails to write to the buffer allocated (which is above 4G).

This could be all fixed by having dma_map_single use a bounce buffer and co=
py
back the contents on unmap similar to kernel's swiotlb, but that's going to=
 be
some major work.

In the mean time, I think this patch should be reverted. I can confirm that=
 my
system boots fine with this reverted.

Best,
Gary
