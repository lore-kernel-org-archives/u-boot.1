Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71E4F36C5C
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7831C84307;
	Mon, 20 Apr 2026 18:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vnXpmsJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7A38430F; Mon, 20 Apr 2026 18:48:23 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A46084258
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2h/iuEywpCAToOjcpfiKyq4MgiIBTO1/PqRYs1YH5vKewnrY5JrQxXdkjEQjBx6td3KeVrz62r7iBe1VcDz9HorTTV+Uz9hEEIe11dndbsKMPn1PbbgbBnyKVYX4wU6c1oB6mhzidn3B0vl8zkSavc2jX7QlU6J6i6uui37cA2NFLv6LUsq8pIyWXMjkurlz0JwavnAxkpUYNsf981bRBEyO4syt2xHNCA+z9Cpvak9ADi+6NLN1Zf2Cf7tEm6XgL3g9K9unOGJG4EA8rHfhgBCiJUCQeEJCesNyTq67VZPucpUbz/hBIce8ZuXT34PAy2NGIygkHXbxcX4+Jv1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY7KsYmhISiDKDD2loM5CdDDYoPWO/cfbQ2wzQtTYnM=;
 b=dqOlLaYH4zzb76sReUxdSFMHlOo2sTuK9AHku1qxqFXuUgk6qbV4pXDN1kAl6xTliL2BCbzUVKQasRJOdUeHUyWwwgtyh8dhZfv59BmusgeblzBwf2OevPcfJCKtZoEztCmXezaboWcY2hKi5OqWxNDEksfwCHbQv+71EX65hPA4CXZA/gMzLAKFLi3VGkl0CDg+en22UQ3ysFuJZLjpUhWA073+xhBWc2+cu6YZYZx7HP4G+VYdvVsa8HTBhxITmKtwDWokCQb/B64nS890h9wCH8vGMA0Y/xLg87fhJfsLVEtfWByplJ/gMjmdAxGsDNEwPFVrfOimPQOMXt4C3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY7KsYmhISiDKDD2loM5CdDDYoPWO/cfbQ2wzQtTYnM=;
 b=vnXpmsJIYSGrW1kWopGN+WEYHqgak6uRCTqoGxRdX9wRo1CrhA5qmctGReoNY8cnjBxZigP2mVBk1pPO68855l35s0XrqcfXrYVvMe7LkLK2NBBnb5rirOan7rvtRYh+HZLu4Ftnfq4bRQaCr3piPU4Mts2/eSFJYoII985n7dk=
Received: from BL1P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::12)
 by IA4PR10MB8423.namprd10.prod.outlook.com (2603:10b6:208:55c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 16:48:16 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:5b5:cafe::24) by BL1P221CA0037.outlook.office365.com
 (2603:10b6:208:5b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 16:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 16:48:14 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 11:47:59 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 11:47:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 11:47:59 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KGlxgn2983489;
 Mon, 20 Apr 2026 11:47:59 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Apr 2026 11:47:59 -0500
Message-ID: <DHY4W2KEPMLJ.GAWHD1NKHEA2@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
 <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
 <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
 <DHUV5T2RE2EW.2QKJXXKF2Z3N@ti.com>
 <CAC_iWj+irf7MajW9OELsx0t1SJ_4jxebbRF0D5Oe=OjMkD+4UQ@mail.gmail.com>
 <DHVL4XXFM4DP.2NI6DUA729U5O@ti.com>
 <CAC_iWj+BGMYWvLCtfFzN+ngkW6UjSoJJMkGz0FHhyW6KmB=G7A@mail.gmail.com>
In-Reply-To: <CAC_iWj+BGMYWvLCtfFzN+ngkW6UjSoJJMkGz0FHhyW6KmB=G7A@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|IA4PR10MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 455b4ac8-228a-44a8-1f30-08de9efc9ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: hSQE3mbhcmSoU3/OT5nk2o5awiRV1WXnagdSYPbqCKo7qRtj4WDnL8/tWkX+aE2mK7IvlNTLSSqdMV2N4cbfllZb/TlyxxmwIMOLOXjViixEnizKmHuWXdZuRonim6Dr7ilr6dSm1rtJeK86kHsFm2jjyEBVA/ePjSXsB6ey7McwNIr3e3ls5eBP5BCvaOBi8s53RaGFsgqwBxKgaL1DRQkobexGHjLxHIXPIwoUyX89cZkdPGVKtoSxbsTat+ux/enz3rYr3xL25CmYIsunN67Sy9CTDiGjjYdlThKZSpMCIM2qNY2donybkIz2WJaGPTu0axfI8Q3hL9Ftou5Ud9Fi6ylFO7HZ6/+BzkkuS6DHU8C+VG8h68ce9TNpsmqHxQQE9nGDRbmOGiUoAPslGLGtz+0IcGgu4zcUchpyOfKNBsxvXAxG7Vz39n1WMs7dxEe7Mk+WREtxGl/MAtYsuCmhBmalvAPUIB1kHc9c4PZ8RS3HDhsmGibkXiYdXuYqvkZHAC6ngiOBGlde84yCaVauNh8lItm/iUrm8yqkYjbFjceNxtTfmNGulQ5zTmXhd6OJ+TozdvTn/0wYL/fDNQwjBfFGyEnJuX1JRCedrpvodnnfw0oVzChhxjdIzImsppEZ8f3ELd6X6yJQlY7VkeFMqkA9+q9aysrBxk22gFYBoN1yZu0xAPyqy0vXDVyGDd4CH7YiHjUKkwHZQX9tI71UXvmc2WAuH+dyKxst4DiL/5TIcydCL/tcBQzuKRHy+bFySyIjXTsw1VllwmbnzQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BswLNLvRNbPB0+A5QDCViy/EYSpG3vBlnfGHmNf0UDeQAv6Q5tq3e4QaJy1SQ8hUUXrgb+Ly7Vmg8FGaZbZCQ1plmKOnYyfsUa0WIUcWZnwAcx7AktS9OYAstiswpB0J3c0PfLvf3AYRJUMXGSGryaK2v+4F70D8yWxSdakRjXHIQ3jqL6PpWFO7FdxQlyr/76lVpuRLRgwNSCJSQkQmxRqGTegO+3hg74NdrHV+BYgDRs3gzZT1VnJoRcfSmS0qRRLEn05QowHKDc9q9GcEqxjwEFxRYXHAMAaY6XVmZvwfiNPlBomTTZV3e7KZ1LiyP1m9y1vGRLYAMNTTBETG3WZJdF4YpfLhQle0PGG6TOu/BdEyDU390ApesQ6a1YhXB3GBHdC5oe6VvCD8/PW9UlV50BXCZ0rScJnpkrLKULdggPHuAi4jPksSoP0g04ZM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 16:48:14.9613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455b4ac8-228a-44a8-1f30-08de9efc9ddf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8423
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

On Mon Apr 20, 2026 at 9:30 AM CDT, Ilias Apalodimas wrote:
> On Fri, 17 Apr 2026 at 19:53, Randolph Sapp <rs@ti.com> wrote:
>>
>> On Fri Apr 17, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
>> > On Thu, 16 Apr 2026 at 23:32, Randolph Sapp <rs@ti.com> wrote:
>> >>
>> >> On Thu Apr 16, 2026 at 2:54 PM CDT, Ilias Apalodimas wrote:
>> >> > On Thu, 16 Apr 2026 at 22:23, Randolph Sapp <rs@ti.com> wrote:
>> >> >>
>> >> >> On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
>> >> >> > Hi Randolph.
>> >> >> >
>> >> >> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>> >> >> >>
>> >> >> >> From: Randolph Sapp <rs@ti.com>
>> >> >> >>
>> >> >> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim =
them when
>> >> >> >> parsing a new device tree and properly warn people when a reser=
vation
>> >> >> >> overlaps with an existing allocation.
>> >> >> >
>> >> >> > The LMB has a set of regions that clearly describe memory in an
>> >> >> > abstact way, e.g reserved, no overwrite etc.
>> >> >> > I don't think adding we should open the door for treating reserv=
ed
>> >> >> > memory as special. Can't we apply the same fix without adding a =
new
>> >> >> > description?
>> >> >> >
>> >> >> > Thanks
>> >> >> > /Ilias
>> >> >>
>> >> >> I did have an initial implementation using a separate allocation l=
ist for fdt
>> >> >> regions in LMB. It works, but boy it's much more messy. All alloca=
tions and
>> >> >> frees had to check both the regular allocation list and the fdt al=
location list.
>> >> >>
>> >> >> I thought about having the fdt helpers build their own local list =
separate from
>> >> >> LMB, but that's also a little messy in that it means we're either =
double
>> >> >> tracking regions or tying to reach into the guts of LMB to extract=
 information
>> >> >> about that existing allocation region.
>> >> >>
>> >> >> Maybe that's fine considering LMB already reaches out to kick
>> >> >> boot_fdt_add_mem_rsv_regions. Just trying to keep things compartme=
ntalized at
>> >> >> the moment.
>> >> >>
>> >> >> I'll revisit the localized reservation list for image-fdt. I'll ju=
st setup some
>> >> >> goofy linked list to track allocation start and size for the later=
 free. I
>> >> >> assume we prefer a separate set of lmb_region structs for that lis=
t as it's a
>> >> >> little concerning to pass references to an active LMB region outsi=
de of the LMB
>> >> >> core.
>> >> >
>> >> > Can you explain a bit more when the problem happens? Is it because
>> >> > boot_fdt_add_mem_rsv_regions() get called twice in some boot flows?=
 Or
>> >> > is there another reason?
>> >> >
>> >> > Thanks
>> >> > /Ilias
>> >>
>> >> The initial comment explicitly calls out that as the reason they disa=
bled the
>> >> warning, but it should occur any time a device tree is loaded. Intern=
al or
>> >> external.
>> >>
>> >
>> > Yes, but that's requesting to reserve specific address(es) which is
>> > always the same address ranges unless the DTB changes.  In which case
>> > you just have to find and free the reserved-ranges. Keeping in mind
>> > that's rare, you can re-parse the DT with minimal overhead and you
>> > dont have to keep any metadat stored in LMB or anywhere else. and the
>> > LMB subsystem is not the place to do that. The EEXIST basically means
>> > "I've already done that" here so I am trying to understand what can
>> > trigger this problem.
>> >
>> >> That also lead me to believe if one were to load multiple external de=
vice trees
>> >> that you could theoretically trip an OOM with a bunch of non-overlapp=
ing
>> >> reserved regions. I have yet to test that, but culling old allocation=
s seemed
>> >> practical enough without that PoC.
>> >
>> > Yea but that's a user error. You can also load a bigger binary that
>> > your entire DRAM and trigger an OOM
>> >
>> > Thanks
>> > /Ilias
>>
>> The explicit case were I really wish we had this warning was when the u-=
boot
>> stack was creeping into a FDT reserved region. The FDT reservation natur=
ally
>> failed with EEXIST. That error is overloaded as is. We have to track the
>> reservations we successfully create in order to clean them up properly.
>
> Ok, I think we might have a similar issue to the EFI subsystem then,
> were we can unload and replace the DT based on various config options.
> Why don't we just add a function that read the (existing loaded) DT
> and free the LMB regions based on the DT info?
>
> Cheers
> /Ilias

I did think about that for a bit. Issue is, we need to make sure that funct=
ion
gets called in all of the paths this function is expected to be called prio=
r to
the device tree being switched out. It's doable, but it's a little less
foolproof.

I'll play around with that idea a little more, as it's certainly better for
low-mem applications. My localized tracking patch is here if anyone's curio=
us
about that implementation:

https://github.com/StaticRocket/u-boot/commit/d0d86e065c9a3588977f4bebf6fd7=
83936de0c82

>>
>> >>
>> >> >>
>> >> >> >>
>> >> >> >> If we don't at least warn the user of these reservation failure=
s,
>> >> >> >> there's a chance that this region could be freed and reallocate=
d for
>> >> >> >> something important later.
>> >> >> >>
>> >> >> >> This useful warning mechanism was broken in:
>> >> >> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot=
_fdt_reserve_region()")
>> >> >> >>
>> >> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
>> >> >> >> ---
>> >> >> >>  boot/image-fdt.c |  5 ++++-
>> >> >> >>  include/lmb.h    | 14 ++++++++++++++
>> >> >> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>> >> >> >>  3 files changed, 47 insertions(+), 5 deletions(-)
>> >> >> >>
>> >> >> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> >> >> >> index a3a4fb8b558..0f5857f24d2 100644
>> >> >> >> --- a/boot/image-fdt.c
>> >> >> >> +++ b/boot/image-fdt.c
>> >> >> >> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr,=
 u64 size, u32 flags)
>> >> >> >>  {
>> >> >> >>         long ret;
>> >> >> >>         phys_addr_t rsv_addr;
>> >> >> >> +       flags |=3D LMB_FDT;
>> >> >> >>
>> >> >> >>         rsv_addr =3D (phys_addr_t)addr;
>> >> >> >>         ret =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr,=
 size, flags);
>> >> >> >> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr,=
 u64 size, u32 flags)
>> >> >> >>                 debug("   reserving fdt memory region: addr=3D%=
llx size=3D%llx flags=3D%x\n",
>> >> >> >>                       (unsigned long long)addr,
>> >> >> >>                       (unsigned long long)size, flags);
>> >> >> >> -       } else if (ret !=3D -EEXIST && ret !=3D -EINVAL) {
>> >> >> >> +       } else if (ret !=3D -EINVAL) {
>> >> >> >>                 puts("ERROR: reserving fdt memory region failed=
 ");
>> >> >> >>                 printf("(addr=3D%llx size=3D%llx flags=3D%x)\n"=
,
>> >> >> >>                        (unsigned long long)addr,
>> >> >> >> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt=
_blob)
>> >> >> >>         if (fdt_check_header(fdt_blob) !=3D 0)
>> >> >> >>                 return;
>> >> >> >>
>> >> >> >> +       lmb_free_fdt_regions();
>> >> >> >> +
>> >> >> >>         /* process memreserve sections */
>> >> >> >>         total =3D fdt_num_mem_rsv(fdt_blob);
>> >> >> >>         for (i =3D 0; i < total; i++) {
>> >> >> >> diff --git a/include/lmb.h b/include/lmb.h
>> >> >> >> index 427d701bc30..c6a1fc1ca47 100644
>> >> >> >> --- a/include/lmb.h
>> >> >> >> +++ b/include/lmb.h
>> >> >> >> @@ -51,6 +51,15 @@
>> >> >> >>   */
>> >> >> >>  #define LMB_NONOTIFY BIT(3)
>> >> >> >>
>> >> >> >> +/**
>> >> >> >> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regi=
ons()
>> >> >> >> + *
>> >> >> >> + * LMB Memory region attribute flag to indicate that the regio=
n will be
>> >> >> >> + * reclaimed with lmb_free_fdt_regions(). This allows device t=
ree reservations
>> >> >> >> + * to be cleaned up and tracked more granularly.
>> >> >> >> + */
>> >> >> >> +#define LMB_FDT BIT(4)
>> >> >> >> +
>> >> >> >>  /**
>> >> >> >>   * enum lmb_mem_type - type of memory allocation request
>> >> >> >>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region=
 of memory
>> >> >> >> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lm=
b, phys_size_t size, ulong align);
>> >> >> >>   */
>> >> >> >>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_si=
ze_t size);
>> >> >> >>
>> >> >> >> +/**
>> >> >> >> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserv=
ed regions
>> >> >> >> + */
>> >> >> >> +void lmb_free_fdt_regions(void);
>> >> >> >> +
>> >> >> >>  #endif /* __KERNEL__ */
>> >> >> >>
>> >> >> >>  #endif /* _LINUX_LMB_H */
>> >> >> >> diff --git a/lib/lmb.c b/lib/lmb.c
>> >> >> >> index 8f12c6ad8e5..7ecc548d831 100644
>> >> >> >> --- a/lib/lmb.c
>> >> >> >> +++ b/lib/lmb.c
>> >> >> >> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_add=
r_t addr, phys_size_t size,
>> >> >> >>
>> >> >> >>  static void lmb_print_region_flags(u32 flags)
>> >> >> >>  {
>> >> >> >> -       const char * const flag_str[] =3D { "none", "no-map", "=
no-overwrite",
>> >> >> >> -                                         "no-notify" };
>> >> >> >> -       unsigned int pflags =3D flags &
>> >> >> >> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LM=
B_NONOTIFY);
>> >> >> >> +       const char *const flag_str[] =3D { "none", "no-map", "n=
o-overwrite",
>> >> >> >> +                                        "no-notify", "fdt" };
>> >> >> >> +       unsigned int pflags =3D
>> >> >> >> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONO=
TIFY | LMB_FDT);
>> >> >> >>
>> >> >> >>         if (flags !=3D pflags) {
>> >> >> >>                 printf("invalid %#x\n", flags);
>> >> >> >> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_=
t size, u32 flags)
>> >> >> >>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FRE=
E, flags);
>> >> >> >>  }
>> >> >> >>
>> >> >> >> +void lmb_free_fdt_regions(void)
>> >> >> >> +{
>> >> >> >> +       struct alist *lmb_rgn_lst =3D &lmb.used_mem;
>> >> >> >> +       struct lmb_region *rgn =3D lmb_rgn_lst->data;
>> >> >> >> +       long ret;
>> >> >> >> +       int i =3D 0;
>> >> >> >> +
>> >> >> >> +       while (i < lmb_rgn_lst->count) {
>> >> >> >> +               phys_addr_t base =3D rgn[i].base;
>> >> >> >> +               phys_size_t size =3D rgn[i].size;
>> >> >> >> +               u32 flags =3D rgn[i].flags;
>> >> >> >> +
>> >> >> >> +               if (flags & LMB_FDT) {
>> >> >> >> +                       ret =3D lmb_free(base, size, flags);
>> >> >> >> +                       if (ret < 0) {
>> >> >> >> +                               printf("Unable to free FDT memo=
ry at 0x%08lx\n",
>> >> >> >> +                                      (ulong)base);
>> >> >> >> +                               i++;
>> >> >> >> +                       }
>> >> >> >> +               } else {
>> >> >> >> +                       i++;
>> >> >> >> +               }
>> >> >> >> +       }
>> >> >> >> +}
>> >> >> >> +
>> >> >> >>  static int _lmb_alloc_base(phys_size_t size, ulong align,
>> >> >> >>                            phys_addr_t *addr, u32 flags)
>> >> >> >>  {
>> >> >> >> --
>> >> >> >> 2.53.0
>> >> >> >>
>> >> >>
>> >>
>>

