Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29905F5A8A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 17:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39F28429E;
	Mon, 20 Apr 2026 19:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PXfyv+Am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35BF842E1; Mon, 20 Apr 2026 19:05:36 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4526883BC8
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 19:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so3115357d50.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776704732; cv=none;
 d=google.com; s=arc-20240605;
 b=hzAGox6A630mNO8Qs0xK7B6JzrY0HYaqiCBy7uZzDDft1mBcfqRsUEsWW7JAheM1CU
 I5xEGyV4W0Plym6ml6+xZ24rOlF9Cw8l/FA7HDsTVStFi0Xxv23J+iO3vCrzXP92ScQH
 QImM0rLGCb68dpe1unCxwlzdqpXr+vs6U8WAGCgq9ehj5EcxWx/VNZ9H+QZMWEszmaYm
 /MQVYLBzthyjvryQDYBDFRyubbp0N3EAmFFoXVhBmwuZsQPSgIftoahXJgBrfafoNRoZ
 dOCeUWx/BV/OHXnUPPg8Pg89U3JhiUanrZPBrg9B+lS67Mwf53Bb2PTjanUlWhIhcx1u
 VUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ypQ+4Ft1dyvC+Pp53pJ2O1YLvVGNReBXMqoToRG2YxQ=;
 fh=yYpcp/OFlQT3AprMKCZBAs5xUjNiO7Cstj82F0s2Ins=;
 b=iK1SbEoa3KUu2pPnX+UORfRwJQB8MluXSuLWtfKoI0x2dcMWr+5QR2ufZcpJgwqj0T
 G4SNDlrhCkuf6n3rJOvm8nCbk1llaR8BV+Wlai9lzml32kftLJ+c6pqfEjRlKa2FWwzz
 NlMdA/og1EbyvBcJRQ3BVSorBjPJz5HiWYZyrKSqdBv5K8CE6JBK2IaY9UoBe0GO6nP0
 u/QS2KvvLn4gNnuOV2RR1rGH87ScueFuWGoNckLQpq8hALiViqsRUzDyelv/Uu9vw2MY
 7AE1shHRAV1W+xb1Q0Rpk4Z1LXnzSm13Aa04CzFM3/+a1o/AyzIfYG0eXXUTyW39H0Su
 QOeA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776704732; x=1777309532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ypQ+4Ft1dyvC+Pp53pJ2O1YLvVGNReBXMqoToRG2YxQ=;
 b=PXfyv+Ama+nN/IKWvAozkYKa4mI29IA0FYIwriUSj7YBbpTKDTN/adj6+/k8OtF4J8
 phIGKucTEaj7L1N3IvdAENHlVAvt21CNAxqDDZHFjLF/uydEk73sexXH52zlbUkTJCz0
 i5ZDmxjUdjfT+/tPYIhgPzok5ll5E6KP8kPvXnPJCHdEkILtDtmMH3fHa3cHLHT+t8s5
 xDyYTC6caDGh0lVDDi5cehUWHtRIFVkU/4eRUs7UMVtrHzPNVXtxPq4cGvkyFgZ09VS2
 Sgq8lPYFWJ0AbuXLWC5o+QEDaW+xleoyZ27hFLgnhbbAkt3+kB5rqpB0trUKfb2jET/b
 m1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776704732; x=1777309532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypQ+4Ft1dyvC+Pp53pJ2O1YLvVGNReBXMqoToRG2YxQ=;
 b=BhmOG8t4apL/G7ZaFeevaEsvjhBoy3nsziR85KaWhmlSilLyuAkwO6optoISAo8IoY
 faQ1mamXjcS7osm3S+PJmjXy3qL6AW8eplisfv+FV9J2x9jE7LBwpNgzFx04M430dmrO
 xF2bVZYb1+avU3TWSXJHZ3I30W3FugH2wzFF5wlInh6SNTQMJ6JxhUdHoQ+w+jCACFuN
 saEas0CSeXykfKCKXWxfWnNG/knp5gqqgFnJFEAoRNnRZEargaAJUWNylHALTS7zYPAK
 c3iBwp2MnvzOrJNBjf8FxMYYzEpWYxF/puGv10swNaro0ADZnlKm9s62Lt85r0AUufNI
 kLiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lcZKY0VPRwJda8HuyvkpTr1lOwOPuesoEAnJFguUtMlcTQ6vfXEBC0ISmPy0062osSWYuZj8=@lists.denx.de
X-Gm-Message-State: AOJu0YyEwRmF3Sacpb6DWk+90VVAQv0z8hWTxKFesjMBaNejVdYP9cZr
 aT4BcEQiC3AIFNYhciNnXz2Umoaez8VEJgfCglnk8OYD9oCwGVM7tZpFXZc4XWMD8LGCJhU4gjS
 alG64YwrZl7S7e8pZobMjFXj81kSMIz5YmuyK64XiCQ==
X-Gm-Gg: AeBDiesdRRziJnCV9ZzcvjcBO4DzhgxXIwL2OHXgDJGO2hQdg5utZ2zrOcNv93GEH5K
 bpCJQoH+hPjD6sB7kDvbZQt47ZyaVZ6h51Q02WAaMo/HtjDFKSOwWVO0djURsA7yxNUvvBu8B8f
 zcKhzIFYf5+rAypzc7JQ9BaqPrQWUznqAPyiXSvlpUgr+p0/pOje0L3fAMMTKTXfSI0LXYhS71o
 tgqHP/1C5YSZ76Y7x1g54lIVAMneG9f4hcjF6BtyOLkPBri2OCrk0lJ6DcQ39owRzsP5YCzRe+o
 oKSGBJPOr+EEgrYCHI2P6glLb1+Q2NcAoM/YqQijQjQY5iyzu9CpQv9iJK0XATsFvgoIaDyzOd3
 aydnCYLQ/GsWKPnLDddEXgbNml+RElNNuwRo3p1LFVDdfX2eZ7MarGUaJVnnvhAey+snZwnl9Gj
 lAOm+5XI2CfC0NbFfbNj8WOJ3C8byFVB0Vqcovvk9ylJhY+Y0AhJx3uWGD7Bn5hZbTWDG4Rl6Gx
 MNJEOhxXmSUaclY8IG/6oiRq5IJ8TngtZt8YwbuAy9wistcZcoO7AmgCbjPDI54Nte77O44kvC1
 YO4g/v2rQ7y0wPRHR6jayjz1B59fXsP7CpQumUNcjCYeZV9Iks5AfkEQoj6Brkv2
X-Received: by 2002:a05:690e:4088:b0:64e:e898:10ff with SMTP id
 956f58d0204a3-65311c49b2bmr10230762d50.40.1776704731731; Mon, 20 Apr 2026
 10:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
 <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
 <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
 <DHUV5T2RE2EW.2QKJXXKF2Z3N@ti.com>
 <CAC_iWj+irf7MajW9OELsx0t1SJ_4jxebbRF0D5Oe=OjMkD+4UQ@mail.gmail.com>
 <DHVL4XXFM4DP.2NI6DUA729U5O@ti.com>
 <CAC_iWj+BGMYWvLCtfFzN+ngkW6UjSoJJMkGz0FHhyW6KmB=G7A@mail.gmail.com>
 <DHY4W2KEPMLJ.GAWHD1NKHEA2@ti.com>
In-Reply-To: <DHY4W2KEPMLJ.GAWHD1NKHEA2@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Apr 2026 20:04:54 +0300
X-Gm-Features: AQROBzBfCJsB_Df_ma9qgTiRlShBeNsa07dC5MbduGo6f2b11wo-_NS1G0NQfSo
Message-ID: <CAC_iWj+H9Wv-kx5Zo3ekr3zsz4VFzH-ths7J=3G+koV8JYaruQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 20 Apr 2026 at 19:48, Randolph Sapp <rs@ti.com> wrote:
>
> On Mon Apr 20, 2026 at 9:30 AM CDT, Ilias Apalodimas wrote:
> > On Fri, 17 Apr 2026 at 19:53, Randolph Sapp <rs@ti.com> wrote:
> >>
> >> On Fri Apr 17, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
> >> > On Thu, 16 Apr 2026 at 23:32, Randolph Sapp <rs@ti.com> wrote:
> >> >>
> >> >> On Thu Apr 16, 2026 at 2:54 PM CDT, Ilias Apalodimas wrote:
> >> >> > On Thu, 16 Apr 2026 at 22:23, Randolph Sapp <rs@ti.com> wrote:
> >> >> >>
> >> >> >> On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
> >> >> >> > Hi Randolph.
> >> >> >> >
> >> >> >> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
> >> >> >> >>
> >> >> >> >> From: Randolph Sapp <rs@ti.com>
> >> >> >> >>
> >> >> >> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> >> >> >> >> parsing a new device tree and properly warn people when a reservation
> >> >> >> >> overlaps with an existing allocation.
> >> >> >> >
> >> >> >> > The LMB has a set of regions that clearly describe memory in an
> >> >> >> > abstact way, e.g reserved, no overwrite etc.
> >> >> >> > I don't think adding we should open the door for treating reserved
> >> >> >> > memory as special. Can't we apply the same fix without adding a new
> >> >> >> > description?
> >> >> >> >
> >> >> >> > Thanks
> >> >> >> > /Ilias
> >> >> >>
> >> >> >> I did have an initial implementation using a separate allocation list for fdt
> >> >> >> regions in LMB. It works, but boy it's much more messy. All allocations and
> >> >> >> frees had to check both the regular allocation list and the fdt allocation list.
> >> >> >>
> >> >> >> I thought about having the fdt helpers build their own local list separate from
> >> >> >> LMB, but that's also a little messy in that it means we're either double
> >> >> >> tracking regions or tying to reach into the guts of LMB to extract information
> >> >> >> about that existing allocation region.
> >> >> >>
> >> >> >> Maybe that's fine considering LMB already reaches out to kick
> >> >> >> boot_fdt_add_mem_rsv_regions. Just trying to keep things compartmentalized at
> >> >> >> the moment.
> >> >> >>
> >> >> >> I'll revisit the localized reservation list for image-fdt. I'll just setup some
> >> >> >> goofy linked list to track allocation start and size for the later free. I
> >> >> >> assume we prefer a separate set of lmb_region structs for that list as it's a
> >> >> >> little concerning to pass references to an active LMB region outside of the LMB
> >> >> >> core.
> >> >> >
> >> >> > Can you explain a bit more when the problem happens? Is it because
> >> >> > boot_fdt_add_mem_rsv_regions() get called twice in some boot flows? Or
> >> >> > is there another reason?
> >> >> >
> >> >> > Thanks
> >> >> > /Ilias
> >> >>
> >> >> The initial comment explicitly calls out that as the reason they disabled the
> >> >> warning, but it should occur any time a device tree is loaded. Internal or
> >> >> external.
> >> >>
> >> >
> >> > Yes, but that's requesting to reserve specific address(es) which is
> >> > always the same address ranges unless the DTB changes.  In which case
> >> > you just have to find and free the reserved-ranges. Keeping in mind
> >> > that's rare, you can re-parse the DT with minimal overhead and you
> >> > dont have to keep any metadat stored in LMB or anywhere else. and the
> >> > LMB subsystem is not the place to do that. The EEXIST basically means
> >> > "I've already done that" here so I am trying to understand what can
> >> > trigger this problem.
> >> >
> >> >> That also lead me to believe if one were to load multiple external device trees
> >> >> that you could theoretically trip an OOM with a bunch of non-overlapping
> >> >> reserved regions. I have yet to test that, but culling old allocations seemed
> >> >> practical enough without that PoC.
> >> >
> >> > Yea but that's a user error. You can also load a bigger binary that
> >> > your entire DRAM and trigger an OOM
> >> >
> >> > Thanks
> >> > /Ilias
> >>
> >> The explicit case were I really wish we had this warning was when the u-boot
> >> stack was creeping into a FDT reserved region. The FDT reservation naturally
> >> failed with EEXIST. That error is overloaded as is. We have to track the
> >> reservations we successfully create in order to clean them up properly.
> >
> > Ok, I think we might have a similar issue to the EFI subsystem then,
> > were we can unload and replace the DT based on various config options.
> > Why don't we just add a function that read the (existing loaded) DT
> > and free the LMB regions based on the DT info?
> >
> > Cheers
> > /Ilias
>
> I did think about that for a bit. Issue is, we need to make sure that function
> gets called in all of the paths this function is expected to be called prior to
> the device tree being switched out. It's doable, but it's a little less
> foolproof.

Yea, but we can add an event in the future when a DT in uloaded and trigger it.

>
> I'll play around with that idea a little more, as it's certainly better for
> low-mem applications. My localized tracking patch is here if anyone's curious
> about that implementation:
>
> https://github.com/StaticRocket/u-boot/commit/d0d86e065c9a3588977f4bebf6fd783936de0c82

Thanks for the patience on this. You just need to reverse what the
adding function already does. Maybe with a bool for add/remove?

Cheers
/Ilias
>
> >>
> >> >>
> >> >> >>
> >> >> >> >>
> >> >> >> >> If we don't at least warn the user of these reservation failures,
> >> >> >> >> there's a chance that this region could be freed and reallocated for
> >> >> >> >> something important later.
> >> >> >> >>
> >> >> >> >> This useful warning mechanism was broken in:
> >> >> >> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
> >> >> >> >>
> >> >> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> >> >> >> ---
> >> >> >> >>  boot/image-fdt.c |  5 ++++-
> >> >> >> >>  include/lmb.h    | 14 ++++++++++++++
> >> >> >> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
> >> >> >> >>  3 files changed, 47 insertions(+), 5 deletions(-)
> >> >> >> >>
> >> >> >> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> >> >> >> >> index a3a4fb8b558..0f5857f24d2 100644
> >> >> >> >> --- a/boot/image-fdt.c
> >> >> >> >> +++ b/boot/image-fdt.c
> >> >> >> >> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >> >> >> >>  {
> >> >> >> >>         long ret;
> >> >> >> >>         phys_addr_t rsv_addr;
> >> >> >> >> +       flags |= LMB_FDT;
> >> >> >> >>
> >> >> >> >>         rsv_addr = (phys_addr_t)addr;
> >> >> >> >>         ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
> >> >> >> >> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >> >> >> >>                 debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
> >> >> >> >>                       (unsigned long long)addr,
> >> >> >> >>                       (unsigned long long)size, flags);
> >> >> >> >> -       } else if (ret != -EEXIST && ret != -EINVAL) {
> >> >> >> >> +       } else if (ret != -EINVAL) {
> >> >> >> >>                 puts("ERROR: reserving fdt memory region failed ");
> >> >> >> >>                 printf("(addr=%llx size=%llx flags=%x)\n",
> >> >> >> >>                        (unsigned long long)addr,
> >> >> >> >> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
> >> >> >> >>         if (fdt_check_header(fdt_blob) != 0)
> >> >> >> >>                 return;
> >> >> >> >>
> >> >> >> >> +       lmb_free_fdt_regions();
> >> >> >> >> +
> >> >> >> >>         /* process memreserve sections */
> >> >> >> >>         total = fdt_num_mem_rsv(fdt_blob);
> >> >> >> >>         for (i = 0; i < total; i++) {
> >> >> >> >> diff --git a/include/lmb.h b/include/lmb.h
> >> >> >> >> index 427d701bc30..c6a1fc1ca47 100644
> >> >> >> >> --- a/include/lmb.h
> >> >> >> >> +++ b/include/lmb.h
> >> >> >> >> @@ -51,6 +51,15 @@
> >> >> >> >>   */
> >> >> >> >>  #define LMB_NONOTIFY BIT(3)
> >> >> >> >>
> >> >> >> >> +/**
> >> >> >> >> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regions()
> >> >> >> >> + *
> >> >> >> >> + * LMB Memory region attribute flag to indicate that the region will be
> >> >> >> >> + * reclaimed with lmb_free_fdt_regions(). This allows device tree reservations
> >> >> >> >> + * to be cleaned up and tracked more granularly.
> >> >> >> >> + */
> >> >> >> >> +#define LMB_FDT BIT(4)
> >> >> >> >> +
> >> >> >> >>  /**
> >> >> >> >>   * enum lmb_mem_type - type of memory allocation request
> >> >> >> >>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of memory
> >> >> >> >> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
> >> >> >> >>   */
> >> >> >> >>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
> >> >> >> >>
> >> >> >> >> +/**
> >> >> >> >> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved regions
> >> >> >> >> + */
> >> >> >> >> +void lmb_free_fdt_regions(void);
> >> >> >> >> +
> >> >> >> >>  #endif /* __KERNEL__ */
> >> >> >> >>
> >> >> >> >>  #endif /* _LINUX_LMB_H */
> >> >> >> >> diff --git a/lib/lmb.c b/lib/lmb.c
> >> >> >> >> index 8f12c6ad8e5..7ecc548d831 100644
> >> >> >> >> --- a/lib/lmb.c
> >> >> >> >> +++ b/lib/lmb.c
> >> >> >> >> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
> >> >> >> >>
> >> >> >> >>  static void lmb_print_region_flags(u32 flags)
> >> >> >> >>  {
> >> >> >> >> -       const char * const flag_str[] = { "none", "no-map", "no-overwrite",
> >> >> >> >> -                                         "no-notify" };
> >> >> >> >> -       unsigned int pflags = flags &
> >> >> >> >> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
> >> >> >> >> +       const char *const flag_str[] = { "none", "no-map", "no-overwrite",
> >> >> >> >> +                                        "no-notify", "fdt" };
> >> >> >> >> +       unsigned int pflags =
> >> >> >> >> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY | LMB_FDT);
> >> >> >> >>
> >> >> >> >>         if (flags != pflags) {
> >> >> >> >>                 printf("invalid %#x\n", flags);
> >> >> >> >> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
> >> >> >> >>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
> >> >> >> >>  }
> >> >> >> >>
> >> >> >> >> +void lmb_free_fdt_regions(void)
> >> >> >> >> +{
> >> >> >> >> +       struct alist *lmb_rgn_lst = &lmb.used_mem;
> >> >> >> >> +       struct lmb_region *rgn = lmb_rgn_lst->data;
> >> >> >> >> +       long ret;
> >> >> >> >> +       int i = 0;
> >> >> >> >> +
> >> >> >> >> +       while (i < lmb_rgn_lst->count) {
> >> >> >> >> +               phys_addr_t base = rgn[i].base;
> >> >> >> >> +               phys_size_t size = rgn[i].size;
> >> >> >> >> +               u32 flags = rgn[i].flags;
> >> >> >> >> +
> >> >> >> >> +               if (flags & LMB_FDT) {
> >> >> >> >> +                       ret = lmb_free(base, size, flags);
> >> >> >> >> +                       if (ret < 0) {
> >> >> >> >> +                               printf("Unable to free FDT memory at 0x%08lx\n",
> >> >> >> >> +                                      (ulong)base);
> >> >> >> >> +                               i++;
> >> >> >> >> +                       }
> >> >> >> >> +               } else {
> >> >> >> >> +                       i++;
> >> >> >> >> +               }
> >> >> >> >> +       }
> >> >> >> >> +}
> >> >> >> >> +
> >> >> >> >>  static int _lmb_alloc_base(phys_size_t size, ulong align,
> >> >> >> >>                            phys_addr_t *addr, u32 flags)
> >> >> >> >>  {
> >> >> >> >> --
> >> >> >> >> 2.53.0
> >> >> >> >>
> >> >> >>
> >> >>
> >>
>
