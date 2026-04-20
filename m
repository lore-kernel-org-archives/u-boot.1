Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9AAF588CA
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 14:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 658E0840D8;
	Mon, 20 Apr 2026 16:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iXvvpFS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFAA28419E; Mon, 20 Apr 2026 16:31:36 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823D5840D8
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6501547d7edso2744101d50.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 07:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776695492; cv=none;
 d=google.com; s=arc-20240605;
 b=UqURWdzWA4b/KTW1wwdwBYTa+/ropQDgGu4gMzSN+YKs1TPwsN8OORYV9J9Pt47o0M
 4DEarnvQRstbFzqVXL1JuK+Hinqs1RA4A44KbdreKbBIdq14ZFKLxgj6SbkzQk/JearG
 /xX1pgvIV+pf6+m6F0qhDdUqEADRGMQOtkZ5eAVZoFFfBxTFW+m4VMT7K8dtYoiIf+rp
 QLBLh0AwW4yevM4y+3zFZkMhFFDt0Q1rSMkJaO3B9UlzfBJFikExSBwxwjL+TDO8eW9h
 dqnVuHHZSb50KOhqovklGiCpTGqX3gRI1Wox7u1c8n/vMHx9rIB2h8BABlCzb+YXosX6
 OE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q4t3TEeYKo40yCwYKnJ3DKSR6xqc0Fiwe6Z1KbcpljE=;
 fh=oWj3PiEjG7jS2i0pAB+FO5SFLA4hnjOvsrKchIcQyV4=;
 b=Z/LgknXGg3HmSeHCKHLJVyFxKQuBxZUcgppWgOzYybV+BWxH02aMEFIM54Ok9wE/ir
 jz+LX6j044uT/+uHx7l8nLjnOY2rHzCMpG0ybShm+2fSJrBQ78CMmoDbMK33wrsnbvLN
 abq9pcAznxf+FZXqQVQPqyHhZaIHHj/HjWTQmnwnID++aPa7U2aoxZxfkoCBFKUXJUga
 hf/hUSQKAuzx10UlGnzXUhSjoLmOeX/hG6+Q45xAsXZ4+3pOjbJxFM1P9r6CdFjAI6PK
 UYZOjcDbTexRWGVXRKcLGVkmCjPtQJlmFnjNZ4Pva4ye9VAuZkLPVn5PshsBCAdyW/dX
 OpUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776695492; x=1777300292; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4t3TEeYKo40yCwYKnJ3DKSR6xqc0Fiwe6Z1KbcpljE=;
 b=iXvvpFS2tmBesA80gyWfgfmgRIOIgyjP/fZxu7UliTNpoF6Y90aqqjdqmHKe8UfKbW
 Ngm0A7LxK0ojJwqOXE7O0Pul6he0n3mnkwaC8PIG9R8BV4rf9+xM4kXQpBB8Nd1MxL69
 mdyRWsHWMIZjPXGaJxU/o0dpnwrWa03WhzALszf+lSz11DHfS+J3kBl67anEPJv6QboT
 eGEsNDwE2Usho3BmRRW8naYahxzmUrNk9AaAVHqaMZJ9CK0JcuHdX0RGgMJSbFy1Sxpa
 r19xK4YxhFoQEsTa8d6Sb4scqKywtoMXq5sN9OBFEg1ORMz0IRxy2zFkGdDunWcpNh7H
 KUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776695492; x=1777300292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4t3TEeYKo40yCwYKnJ3DKSR6xqc0Fiwe6Z1KbcpljE=;
 b=PtvF4rXB/MMAv2RWoQ7cejA5ncHRNwFW7DZW7sP20InruWHDOsLf/TonW5dxis1RfD
 +0Qc+kc2LSO5KiwBpudUR/DHc5u6c+eEHJ6ojieOJCzPlih4YLDNxz6wEOj4xsh+rdv2
 v1pHh4GddIMIXyuODepNvV6FX8FEYN1T4/DhjMOP+h9nuB79CpwCxYfNyO561ha4mv8J
 dTAU8A9N4NN6CslcKxxYVI7Aq8PlcG0oV1/dhpoaRPiXbXm/mXV1R87K6mIOhXOLGtUm
 QC85Bxo2N7PaobV2dUQccO7BTC8MXqq0029ShFjScOf8lUJdmhSzHQwXSAatTuygqhmx
 W32g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CibFkvv11wn3bWooml0dS2onrnNYG7VbhqAZy/JpzhSdUQXxRGYUUdK9Sf1JUmFCbYLpzZ/s=@lists.denx.de
X-Gm-Message-State: AOJu0YyA4mSh1/PJc/x4kYe0y/9UCbtcYPsTrBGfWS20tCbHPm6luR/D
 kvDJkWF7HTOdoRV/ADzhhXGlYuFNtW3gWKFUoFeuizZ6Z54hY9T+ClAeCJSKn+a7fCMUxE2duYb
 PJ32mnuDAAa5brZHILkno+vWHvWpznD0Ej+HAzzcusCk/MqnysMIP
X-Gm-Gg: AeBDieuwijQ94ACWQ2jOnH4DDycFgd1RfolWipCi/hW+nm4uq3oojxU7NzkTeNM/9Cu
 J+5YvJE9u3aZ7lkdf3lJ9Vt2d5GLayMfuQT/YznFqwmBCUVLQ2DTzKprdThfqukMrL9mXSa5rn9
 0c0/O1LcTbP2L+ne/8bL+ZELvRC8fJ9kUGOenCWsq7IwpG0c+LzwtaS418wJMO5VP9I94cYNqQI
 cLMsUjM1kRD75PcapIuYXJPLPigEfGdUzDkZvTgwze4EFX/1FKwR2iIQuk3q7bTQB7a4Kvp9qLo
 DpEyNRvIdz4UqEcjXVVEIXR9ytKO2n0v7df3yuEVf876zG+S84BJbDZRCZsQuCJpn6WEbvuN3fM
 oCZb+7s6hpRTqSUXfzzQbnxTNagtf9qLpOq4zWYbNpcSfYd/az4FByWTz6daNkhXhZgqX6BN+oE
 3Kc56jSBV4j400mc8KUyqn3ZM5f954gcw+KxUCIAr49060f342Zdnpr3yUE1fijCdVgOuwpGTJm
 B9pnv0Q1aJyYJnFvqtWjx1bk3AUrt/gRTDeixtuzyKxPq1dd8RYaacMs0JM7DvGyqzXQYM/xzHV
 qk+bL5oUyDAuUn962W4hGzd19xFP3DdDMVb+DDNMhpDW6G2cf73SzgE=
X-Received: by 2002:a53:e945:0:b0:650:dbb:e79c with SMTP id
 956f58d0204a3-65310a278bdmr9424495d50.40.1776695491972; Mon, 20 Apr 2026
 07:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
 <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
 <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
 <DHUV5T2RE2EW.2QKJXXKF2Z3N@ti.com>
 <CAC_iWj+irf7MajW9OELsx0t1SJ_4jxebbRF0D5Oe=OjMkD+4UQ@mail.gmail.com>
 <DHVL4XXFM4DP.2NI6DUA729U5O@ti.com>
In-Reply-To: <DHVL4XXFM4DP.2NI6DUA729U5O@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Apr 2026 17:30:55 +0300
X-Gm-Features: AQROBzDBE7usUcyImJK9_ngEH-OMsftVSLg8vPJ_TAwXqsht2zn-L9KrcfasEqo
Message-ID: <CAC_iWj+BGMYWvLCtfFzN+ngkW6UjSoJJMkGz0FHhyW6KmB=G7A@mail.gmail.com>
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

On Fri, 17 Apr 2026 at 19:53, Randolph Sapp <rs@ti.com> wrote:
>
> On Fri Apr 17, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
> > On Thu, 16 Apr 2026 at 23:32, Randolph Sapp <rs@ti.com> wrote:
> >>
> >> On Thu Apr 16, 2026 at 2:54 PM CDT, Ilias Apalodimas wrote:
> >> > On Thu, 16 Apr 2026 at 22:23, Randolph Sapp <rs@ti.com> wrote:
> >> >>
> >> >> On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
> >> >> > Hi Randolph.
> >> >> >
> >> >> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
> >> >> >>
> >> >> >> From: Randolph Sapp <rs@ti.com>
> >> >> >>
> >> >> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> >> >> >> parsing a new device tree and properly warn people when a reservation
> >> >> >> overlaps with an existing allocation.
> >> >> >
> >> >> > The LMB has a set of regions that clearly describe memory in an
> >> >> > abstact way, e.g reserved, no overwrite etc.
> >> >> > I don't think adding we should open the door for treating reserved
> >> >> > memory as special. Can't we apply the same fix without adding a new
> >> >> > description?
> >> >> >
> >> >> > Thanks
> >> >> > /Ilias
> >> >>
> >> >> I did have an initial implementation using a separate allocation list for fdt
> >> >> regions in LMB. It works, but boy it's much more messy. All allocations and
> >> >> frees had to check both the regular allocation list and the fdt allocation list.
> >> >>
> >> >> I thought about having the fdt helpers build their own local list separate from
> >> >> LMB, but that's also a little messy in that it means we're either double
> >> >> tracking regions or tying to reach into the guts of LMB to extract information
> >> >> about that existing allocation region.
> >> >>
> >> >> Maybe that's fine considering LMB already reaches out to kick
> >> >> boot_fdt_add_mem_rsv_regions. Just trying to keep things compartmentalized at
> >> >> the moment.
> >> >>
> >> >> I'll revisit the localized reservation list for image-fdt. I'll just setup some
> >> >> goofy linked list to track allocation start and size for the later free. I
> >> >> assume we prefer a separate set of lmb_region structs for that list as it's a
> >> >> little concerning to pass references to an active LMB region outside of the LMB
> >> >> core.
> >> >
> >> > Can you explain a bit more when the problem happens? Is it because
> >> > boot_fdt_add_mem_rsv_regions() get called twice in some boot flows? Or
> >> > is there another reason?
> >> >
> >> > Thanks
> >> > /Ilias
> >>
> >> The initial comment explicitly calls out that as the reason they disabled the
> >> warning, but it should occur any time a device tree is loaded. Internal or
> >> external.
> >>
> >
> > Yes, but that's requesting to reserve specific address(es) which is
> > always the same address ranges unless the DTB changes.  In which case
> > you just have to find and free the reserved-ranges. Keeping in mind
> > that's rare, you can re-parse the DT with minimal overhead and you
> > dont have to keep any metadat stored in LMB or anywhere else. and the
> > LMB subsystem is not the place to do that. The EEXIST basically means
> > "I've already done that" here so I am trying to understand what can
> > trigger this problem.
> >
> >> That also lead me to believe if one were to load multiple external device trees
> >> that you could theoretically trip an OOM with a bunch of non-overlapping
> >> reserved regions. I have yet to test that, but culling old allocations seemed
> >> practical enough without that PoC.
> >
> > Yea but that's a user error. You can also load a bigger binary that
> > your entire DRAM and trigger an OOM
> >
> > Thanks
> > /Ilias
>
> The explicit case were I really wish we had this warning was when the u-boot
> stack was creeping into a FDT reserved region. The FDT reservation naturally
> failed with EEXIST. That error is overloaded as is. We have to track the
> reservations we successfully create in order to clean them up properly.

Ok, I think we might have a similar issue to the EFI subsystem then,
were we can unload and replace the DT based on various config options.
Why don't we just add a function that read the (existing loaded) DT
and free the LMB regions based on the DT info?

Cheers
/Ilias
>
> >>
> >> >>
> >> >> >>
> >> >> >> If we don't at least warn the user of these reservation failures,
> >> >> >> there's a chance that this region could be freed and reallocated for
> >> >> >> something important later.
> >> >> >>
> >> >> >> This useful warning mechanism was broken in:
> >> >> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
> >> >> >>
> >> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> >> >> ---
> >> >> >>  boot/image-fdt.c |  5 ++++-
> >> >> >>  include/lmb.h    | 14 ++++++++++++++
> >> >> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
> >> >> >>  3 files changed, 47 insertions(+), 5 deletions(-)
> >> >> >>
> >> >> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> >> >> >> index a3a4fb8b558..0f5857f24d2 100644
> >> >> >> --- a/boot/image-fdt.c
> >> >> >> +++ b/boot/image-fdt.c
> >> >> >> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >> >> >>  {
> >> >> >>         long ret;
> >> >> >>         phys_addr_t rsv_addr;
> >> >> >> +       flags |= LMB_FDT;
> >> >> >>
> >> >> >>         rsv_addr = (phys_addr_t)addr;
> >> >> >>         ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
> >> >> >> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >> >> >>                 debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
> >> >> >>                       (unsigned long long)addr,
> >> >> >>                       (unsigned long long)size, flags);
> >> >> >> -       } else if (ret != -EEXIST && ret != -EINVAL) {
> >> >> >> +       } else if (ret != -EINVAL) {
> >> >> >>                 puts("ERROR: reserving fdt memory region failed ");
> >> >> >>                 printf("(addr=%llx size=%llx flags=%x)\n",
> >> >> >>                        (unsigned long long)addr,
> >> >> >> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
> >> >> >>         if (fdt_check_header(fdt_blob) != 0)
> >> >> >>                 return;
> >> >> >>
> >> >> >> +       lmb_free_fdt_regions();
> >> >> >> +
> >> >> >>         /* process memreserve sections */
> >> >> >>         total = fdt_num_mem_rsv(fdt_blob);
> >> >> >>         for (i = 0; i < total; i++) {
> >> >> >> diff --git a/include/lmb.h b/include/lmb.h
> >> >> >> index 427d701bc30..c6a1fc1ca47 100644
> >> >> >> --- a/include/lmb.h
> >> >> >> +++ b/include/lmb.h
> >> >> >> @@ -51,6 +51,15 @@
> >> >> >>   */
> >> >> >>  #define LMB_NONOTIFY BIT(3)
> >> >> >>
> >> >> >> +/**
> >> >> >> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regions()
> >> >> >> + *
> >> >> >> + * LMB Memory region attribute flag to indicate that the region will be
> >> >> >> + * reclaimed with lmb_free_fdt_regions(). This allows device tree reservations
> >> >> >> + * to be cleaned up and tracked more granularly.
> >> >> >> + */
> >> >> >> +#define LMB_FDT BIT(4)
> >> >> >> +
> >> >> >>  /**
> >> >> >>   * enum lmb_mem_type - type of memory allocation request
> >> >> >>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of memory
> >> >> >> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
> >> >> >>   */
> >> >> >>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
> >> >> >>
> >> >> >> +/**
> >> >> >> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved regions
> >> >> >> + */
> >> >> >> +void lmb_free_fdt_regions(void);
> >> >> >> +
> >> >> >>  #endif /* __KERNEL__ */
> >> >> >>
> >> >> >>  #endif /* _LINUX_LMB_H */
> >> >> >> diff --git a/lib/lmb.c b/lib/lmb.c
> >> >> >> index 8f12c6ad8e5..7ecc548d831 100644
> >> >> >> --- a/lib/lmb.c
> >> >> >> +++ b/lib/lmb.c
> >> >> >> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
> >> >> >>
> >> >> >>  static void lmb_print_region_flags(u32 flags)
> >> >> >>  {
> >> >> >> -       const char * const flag_str[] = { "none", "no-map", "no-overwrite",
> >> >> >> -                                         "no-notify" };
> >> >> >> -       unsigned int pflags = flags &
> >> >> >> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
> >> >> >> +       const char *const flag_str[] = { "none", "no-map", "no-overwrite",
> >> >> >> +                                        "no-notify", "fdt" };
> >> >> >> +       unsigned int pflags =
> >> >> >> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY | LMB_FDT);
> >> >> >>
> >> >> >>         if (flags != pflags) {
> >> >> >>                 printf("invalid %#x\n", flags);
> >> >> >> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
> >> >> >>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
> >> >> >>  }
> >> >> >>
> >> >> >> +void lmb_free_fdt_regions(void)
> >> >> >> +{
> >> >> >> +       struct alist *lmb_rgn_lst = &lmb.used_mem;
> >> >> >> +       struct lmb_region *rgn = lmb_rgn_lst->data;
> >> >> >> +       long ret;
> >> >> >> +       int i = 0;
> >> >> >> +
> >> >> >> +       while (i < lmb_rgn_lst->count) {
> >> >> >> +               phys_addr_t base = rgn[i].base;
> >> >> >> +               phys_size_t size = rgn[i].size;
> >> >> >> +               u32 flags = rgn[i].flags;
> >> >> >> +
> >> >> >> +               if (flags & LMB_FDT) {
> >> >> >> +                       ret = lmb_free(base, size, flags);
> >> >> >> +                       if (ret < 0) {
> >> >> >> +                               printf("Unable to free FDT memory at 0x%08lx\n",
> >> >> >> +                                      (ulong)base);
> >> >> >> +                               i++;
> >> >> >> +                       }
> >> >> >> +               } else {
> >> >> >> +                       i++;
> >> >> >> +               }
> >> >> >> +       }
> >> >> >> +}
> >> >> >> +
> >> >> >>  static int _lmb_alloc_base(phys_size_t size, ulong align,
> >> >> >>                            phys_addr_t *addr, u32 flags)
> >> >> >>  {
> >> >> >> --
> >> >> >> 2.53.0
> >> >> >>
> >> >>
> >>
>
