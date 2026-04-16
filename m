Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D69F8D777
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 20:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DC2383FC0;
	Thu, 16 Apr 2026 22:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RoUzZoXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02ED840AB; Thu, 16 Apr 2026 22:32:39 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F8D183EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWStm+lmWouTVCO0t8bPzO3OZOAiKm8N2kwhvqVzBa+RT8CH4hpXxmWapWNQ3mZhCu952Y5b8Z8bKK8gqNCyjyHp/4zLb71w8ANx9fBb6AcI1/xT7tibfy9uAuHZbJm17Qc5NPyQSvHjl6mfTuKLVqIE0c4LKhP967G6BQg6ihSsFUu+2xcyhdWscSCQ8Lgt9Fz3xXJjXuaG7DF5+90k/Oraa+LPKAvahnenbu4/oiWVpq8mmi/aKXQsXrskq0WpYS47AjWSb6M+s24usC4fxhUZOAT8t6mRG2kDoK63S9LSSQdv6xVnQO/6d7uVoWxTSOdJlrfzRNtn0A/OisSMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqoET6oYg8V5+bXkBYr8rrlKajKHeSd9nTxs7BBlzfU=;
 b=a4SOjFkezc9t7iJoIn5CuYqoNvIFp0pJRhoOuQhMt9FHholFf+SvEOIF75CFYJBv6u+n92MvunRnlx09iuZYX++Qi2Acnc2b+U79fqIlR2tKyP6kbgxvtKvRkmCrN/GWly/7vHDOwvkPz5M9cRW/riLdsZ4mmz7wgxi+S9aUr2vPXDzahjsmY1ynaFiQ0Zw9W+YhGbEhoUs3HIg3wviTIMdXd1j31q2WADhp7NMOwn+KY4Ma289L7OdeaP5CIw3WVML4qoc8x3oNpYLNTRmij+VO4X9U6igzmbO7oX5Lq3+C7jo9ECdgpJ2wqxXQf+SURZlUATKl95hOwhoo12wQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqoET6oYg8V5+bXkBYr8rrlKajKHeSd9nTxs7BBlzfU=;
 b=RoUzZoXQwBlZ2zn6sj7mU59JJkSQKNSDBT3HFqUHZrsWVARtUYU1PgVXDsdICkH/rpIXk8syYrcmDRJ3l7682ZvRuQhbCB/zkEsd5Ki85pU3RdiYCTzlnToGR3Rjsl1Fa3qsYHZjzZ6n0KO4Lfm90q0EwCbsuj4lPcEHflQF7hc=
Received: from SA0PR11CA0084.namprd11.prod.outlook.com (2603:10b6:806:d2::29)
 by BY5PR10MB4276.namprd10.prod.outlook.com (2603:10b6:a03:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 20:32:34 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::29) by SA0PR11CA0084.outlook.office365.com
 (2603:10b6:806:d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 20:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 20:32:33 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 15:32:31 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 15:32:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 15:32:31 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63GKWVgt666122;
 Thu, 16 Apr 2026 15:32:31 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Apr 2026 15:32:31 -0500
Message-ID: <DHUV5T2RE2EW.2QKJXXKF2Z3N@ti.com>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
 <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
 <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
In-Reply-To: <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BY5PR10MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dbfa3a-6b72-4fa3-d9d4-08de9bf74a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: F1pbGqjMqqJW/AJtWrNUcJ8xfxIOXG36rL5yrwqVA2wktcNGEAPZxfVfpAoNp/zCIx2Iaz6J5StimVAuwzt4H+qLJfu5sjxZnG9FpuLUu5yt3R/QD0DN8lFWH5fgjM79kQI5DgmdixWi0xzOErvU46B/5AVcq4PMC+UD3mpNO4TXEGftvoLoxGHUR9cOi0WlStI4hH8j/RbMQe7HInyW1NJ0Y0bpqojEUOnS6/gl5Ex/hzjJiWnZk5NOKSQIbbSNUxDy9NOsHBna96UK5HJUyHDDgz7rrBkSqrBq52ATmdqvGsuKqManmNtwrD35RP4ieyfTbKYQlAfqMjmIUiybU0jaCrT2g1kmrXUfh6O6cThHN13Mt6jNhVN1yhROFnjJIZSWrrJ2t7BiORoUFhxxhOaW8gNop7lKosaFpY58Jaw9swZ0xeImJ0VGt6ZTwPqNWcn7got7oG6dORl0Lb8y1uYV0loz2q5RfQ/H5lnfsQGllzvv6I3yZH1w0GlUKVGLwszBx7iAuS0qSKrwgAzRgAyj1vuU3PXLziqDBZDtgiW4NBGSaCJntkyk182rxx8doPycPXrXg6H9neMI8xnEHvKgqwthFNoXK6FgFQWdckbO7NNGg5uAbqeYPb9J7C1r9ln7XyxH+JctnsxM3hN7Mbk4GpBtc8l51S8upoQsc9fiDbKxjBsjcAGLzpohz4gH3YBtb23RidRZrg50UY7FpN8cwDXcC0/tOfMuTdhpl+bPR3f/X7U29ZiUaKJ6Et8Dls3n6S82z5gFRHdW56Mn+g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cKDfiQdkAyuLEGwXkG+xJDNqMZRldWY/powEWNhSG8tA8KDZjcmin3F6urFw4d9KkCKP5RlmEJuhsPbpHYNtx7TobKFECezGNsODT2bUFkdENsoWt2HxzwnKKNf7LAZUmhnEBjl7W+qhbLG0tyJh1oeAO646OkGdRyVHDN2JOpZpsBuiCIpGSRH2V8ySqGul/Wm0+X7P8Q2bajB4ACl+2ya6vLgrrEJkGQ/AsJWSaptvMeA719DiptE79sGBcq/lJPVUwqd/D0jqZW3iVRodgnweRX3OssraAZbPy4BpYbkCa11V83IF/zDxe/q05F+jNCnV8KwLs20g7vii5gdOTp7M6N7qTzQFpVbrzZiOAT365zFMcvAfsbMtgflfMXUoMLcn3Q66+OyftjmpMRs3cY8DZ9s5Hrw7fFLbmdOhayMtMmHLwl4MRvhYspeKB8fG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 20:32:33.6807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dbfa3a-6b72-4fa3-d9d4-08de9bf74a36
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4276
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

On Thu Apr 16, 2026 at 2:54 PM CDT, Ilias Apalodimas wrote:
> On Thu, 16 Apr 2026 at 22:23, Randolph Sapp <rs@ti.com> wrote:
>>
>> On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
>> > Hi Randolph.
>> >
>> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>> >>
>> >> From: Randolph Sapp <rs@ti.com>
>> >>
>> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them w=
hen
>> >> parsing a new device tree and properly warn people when a reservation
>> >> overlaps with an existing allocation.
>> >
>> > The LMB has a set of regions that clearly describe memory in an
>> > abstact way, e.g reserved, no overwrite etc.
>> > I don't think adding we should open the door for treating reserved
>> > memory as special. Can't we apply the same fix without adding a new
>> > description?
>> >
>> > Thanks
>> > /Ilias
>>
>> I did have an initial implementation using a separate allocation list fo=
r fdt
>> regions in LMB. It works, but boy it's much more messy. All allocations =
and
>> frees had to check both the regular allocation list and the fdt allocati=
on list.
>>
>> I thought about having the fdt helpers build their own local list separa=
te from
>> LMB, but that's also a little messy in that it means we're either double
>> tracking regions or tying to reach into the guts of LMB to extract infor=
mation
>> about that existing allocation region.
>>
>> Maybe that's fine considering LMB already reaches out to kick
>> boot_fdt_add_mem_rsv_regions. Just trying to keep things compartmentaliz=
ed at
>> the moment.
>>
>> I'll revisit the localized reservation list for image-fdt. I'll just set=
up some
>> goofy linked list to track allocation start and size for the later free.=
 I
>> assume we prefer a separate set of lmb_region structs for that list as i=
t's a
>> little concerning to pass references to an active LMB region outside of =
the LMB
>> core.
>
> Can you explain a bit more when the problem happens? Is it because
> boot_fdt_add_mem_rsv_regions() get called twice in some boot flows? Or
> is there another reason?
>
> Thanks
> /Ilias

The initial comment explicitly calls out that as the reason they disabled t=
he
warning, but it should occur any time a device tree is loaded. Internal or
external.

That also lead me to believe if one were to load multiple external device t=
rees
that you could theoretically trip an OOM with a bunch of non-overlapping
reserved regions. I have yet to test that, but culling old allocations seem=
ed
practical enough without that PoC.

>>
>> >>
>> >> If we don't at least warn the user of these reservation failures,
>> >> there's a chance that this region could be freed and reallocated for
>> >> something important later.
>> >>
>> >> This useful warning mechanism was broken in:
>> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_r=
eserve_region()")
>> >>
>> >> Signed-off-by: Randolph Sapp <rs@ti.com>
>> >> ---
>> >>  boot/image-fdt.c |  5 ++++-
>> >>  include/lmb.h    | 14 ++++++++++++++
>> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>> >>  3 files changed, 47 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> >> index a3a4fb8b558..0f5857f24d2 100644
>> >> --- a/boot/image-fdt.c
>> >> +++ b/boot/image-fdt.c
>> >> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 s=
ize, u32 flags)
>> >>  {
>> >>         long ret;
>> >>         phys_addr_t rsv_addr;
>> >> +       flags |=3D LMB_FDT;
>> >>
>> >>         rsv_addr =3D (phys_addr_t)addr;
>> >>         ret =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size,=
 flags);
>> >> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 s=
ize, u32 flags)
>> >>                 debug("   reserving fdt memory region: addr=3D%llx si=
ze=3D%llx flags=3D%x\n",
>> >>                       (unsigned long long)addr,
>> >>                       (unsigned long long)size, flags);
>> >> -       } else if (ret !=3D -EEXIST && ret !=3D -EINVAL) {
>> >> +       } else if (ret !=3D -EINVAL) {
>> >>                 puts("ERROR: reserving fdt memory region failed ");
>> >>                 printf("(addr=3D%llx size=3D%llx flags=3D%x)\n",
>> >>                        (unsigned long long)addr,
>> >> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
>> >>         if (fdt_check_header(fdt_blob) !=3D 0)
>> >>                 return;
>> >>
>> >> +       lmb_free_fdt_regions();
>> >> +
>> >>         /* process memreserve sections */
>> >>         total =3D fdt_num_mem_rsv(fdt_blob);
>> >>         for (i =3D 0; i < total; i++) {
>> >> diff --git a/include/lmb.h b/include/lmb.h
>> >> index 427d701bc30..c6a1fc1ca47 100644
>> >> --- a/include/lmb.h
>> >> +++ b/include/lmb.h
>> >> @@ -51,6 +51,15 @@
>> >>   */
>> >>  #define LMB_NONOTIFY BIT(3)
>> >>
>> >> +/**
>> >> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regions()
>> >> + *
>> >> + * LMB Memory region attribute flag to indicate that the region will=
 be
>> >> + * reclaimed with lmb_free_fdt_regions(). This allows device tree re=
servations
>> >> + * to be cleaned up and tracked more granularly.
>> >> + */
>> >> +#define LMB_FDT BIT(4)
>> >> +
>> >>  /**
>> >>   * enum lmb_mem_type - type of memory allocation request
>> >>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of me=
mory
>> >> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phy=
s_size_t size, ulong align);
>> >>   */
>> >>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t s=
ize);
>> >>
>> >> +/**
>> >> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved reg=
ions
>> >> + */
>> >> +void lmb_free_fdt_regions(void);
>> >> +
>> >>  #endif /* __KERNEL__ */
>> >>
>> >>  #endif /* _LINUX_LMB_H */
>> >> diff --git a/lib/lmb.c b/lib/lmb.c
>> >> index 8f12c6ad8e5..7ecc548d831 100644
>> >> --- a/lib/lmb.c
>> >> +++ b/lib/lmb.c
>> >> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t ad=
dr, phys_size_t size,
>> >>
>> >>  static void lmb_print_region_flags(u32 flags)
>> >>  {
>> >> -       const char * const flag_str[] =3D { "none", "no-map", "no-ove=
rwrite",
>> >> -                                         "no-notify" };
>> >> -       unsigned int pflags =3D flags &
>> >> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONO=
TIFY);
>> >> +       const char *const flag_str[] =3D { "none", "no-map", "no-over=
write",
>> >> +                                        "no-notify", "fdt" };
>> >> +       unsigned int pflags =3D
>> >> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY |=
 LMB_FDT);
>> >>
>> >>         if (flags !=3D pflags) {
>> >>                 printf("invalid %#x\n", flags);
>> >> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size=
, u32 flags)
>> >>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, fla=
gs);
>> >>  }
>> >>
>> >> +void lmb_free_fdt_regions(void)
>> >> +{
>> >> +       struct alist *lmb_rgn_lst =3D &lmb.used_mem;
>> >> +       struct lmb_region *rgn =3D lmb_rgn_lst->data;
>> >> +       long ret;
>> >> +       int i =3D 0;
>> >> +
>> >> +       while (i < lmb_rgn_lst->count) {
>> >> +               phys_addr_t base =3D rgn[i].base;
>> >> +               phys_size_t size =3D rgn[i].size;
>> >> +               u32 flags =3D rgn[i].flags;
>> >> +
>> >> +               if (flags & LMB_FDT) {
>> >> +                       ret =3D lmb_free(base, size, flags);
>> >> +                       if (ret < 0) {
>> >> +                               printf("Unable to free FDT memory at =
0x%08lx\n",
>> >> +                                      (ulong)base);
>> >> +                               i++;
>> >> +                       }
>> >> +               } else {
>> >> +                       i++;
>> >> +               }
>> >> +       }
>> >> +}
>> >> +
>> >>  static int _lmb_alloc_base(phys_size_t size, ulong align,
>> >>                            phys_addr_t *addr, u32 flags)
>> >>  {
>> >> --
>> >> 2.53.0
>> >>
>>

