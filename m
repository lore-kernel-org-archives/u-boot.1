Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30182F433D6
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E56483FC0;
	Fri, 17 Apr 2026 10:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JaYG90PJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A2AC841C2; Fri, 17 Apr 2026 10:12:42 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E5CB83B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6501c4857b2so229105d50.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 01:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776413558; cv=none;
 d=google.com; s=arc-20240605;
 b=I/99D93fomhEmLbotjsABz2sMpVeRdoCCQP/XGLmTftEB8GsmDCllltQLwfLDnB4i+
 950P/FrKhenPEJOc5TObTEn2mb4s88gZCEtSuN+l11aum80fG2c3Yq+q+zMLdnl1vzeg
 noLnvi+cI5DZz8dYWmDJ996D++S3k9l3Vt8kDyohUmxQIkNmDAjIFdrsgmROV5vmYdgh
 nsbkjeebciUGgOZ7kFRKG+c7PPKLd/uYR4LFEeMcw8ba+KMlxjEp4TszyU/3c4p3qdgU
 iyIfSAJ95PFBx00FEQYW7/kiw3TXiYD0Y2d5aYD7XPlPY0iQEtpcFZ7SWtvrN2FMPABb
 kkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7+e88/6cUTXqD55vuUZDH/VNrq+J6SHjQ2yX8F6QG0I=;
 fh=zwh/DxfLZaqMmr90NsWG4Ryiq2U4GcnmO/kQU9ErmtE=;
 b=JOHDh/0061jhhZOtojPKQDpVN9iE1iS00qIMu0PyZTCFl3N7jbUzsdQj17Xc35eC4U
 Ntb6OfdAtjSlCrqyh34kS+5+pYupMG2E1Y9ZSH5BbReH9gj9KUzdnVXA5p7t2kYWeSRG
 1NYCYuDbl0MKswK7kAO5FDPxEub6ON6tt+pWlp/5vpCMG/5oB+Ew0y66IW3LxsacTqbO
 W1XbHluVOgBysQobQDwSi/1iZmBnrMJ1hDyCdUb+o5RfGUj1cmO9Up42yUcWCOjbj4pG
 g362oCi+c00udDvKI0xLNEv3G14RrCB+enPVSSmPZbAGJ1DKWHiLZccaWnLjYfClxAv9
 Yy5Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776413558; x=1777018358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7+e88/6cUTXqD55vuUZDH/VNrq+J6SHjQ2yX8F6QG0I=;
 b=JaYG90PJGkiex2CF9AlUuGn583W1CkHJASL/CaR1pH1PczFmGTMvyPNMndpc8D7449
 ScS+zFv6um44h8Jx238j/vrU52EvmpFtqPCAYRAhQFC3ALX1Wip//NVtdU7Clamu6I7D
 +oM3emoAim+NGkuUWRqR9QFp2ak9QoGGr5jGRWKgzrbRGirznZFxhLMqHqtkTtdnsKcs
 kNhWXdPB5mA9ie+Q1NyYF4y64dOVm17kYAfV5A0bpTJUVPapmxP0zKGrLphnsfDvrfbB
 NSmXHwUjJV2HMEEIebNsV2qqYhue/7Oeixzj7NSgriO7L6xAro9Oy41a54GnV69sbWTq
 YS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776413558; x=1777018358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+e88/6cUTXqD55vuUZDH/VNrq+J6SHjQ2yX8F6QG0I=;
 b=ChntWKx/FBaoc8+BsFvqsxIq3eycf3gosbRzxACCcdwTN90ucIq4YCQBIvxcpqqhkf
 P8PYNZgVHmjuCB+lQIscsv/xjc0g4/01LJi4sIkL9xn6SGqtgARtJ1hpAgBkdJHYDzKJ
 RPr8Z+tH/Z+mrC0HR3fScbzrQ3j9wtEM4k5Zk9a78qjMPq6DYC46jYAd5kyYZwSuV9RV
 QS1zMA7+sJc1mhn00xi0/x9JwybwQxu+Spszdutcqu2wWWCqb1h0A40HoMgrO49csgzc
 0dOz2hKdeeyY08za2ZXjaklFvF7yfdy6JxrlFN5c8aVkZaWZqQt84cw4DAb6U4HcrfKZ
 buqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HuZohbVSofUi0Y4ayoVk9KRJOWhG/29HNazAsdSHsQkCc+Js/XtyTGfIY15BRK1QODvmVAcM=@lists.denx.de
X-Gm-Message-State: AOJu0YxbXq5CaGM75cTM6qQqLwatjrO/MihBjiL4VsFjf4fjv9n2Q6hO
 pGv0GbceaOwwWPLzp0Trd+910LtNJykOHbWgDTem57WsKeYvdQDrvkiXy8H8KVPWHFopopIL6yK
 WK1uDUVO/DFN/frZGGGzOXf4M+iktbZX2Oybp7RQR8A==
X-Gm-Gg: AeBDieu14AIGq/Qdq2Q1X8Iv7wvZ9kYixUdhBr6VHwqvh69qicv4Y95YGznVJq4W8e0
 LIWXnKqJmJHiv/cY4h94US13s/fTgXhqMuutsewOS9htJ7zyATM2F8XMQU/d0uXZ9+FEeioqiYZ
 cJIa+Tma2ag9WfqiqSh2rSARbwfS7oYnUJCJA3dNjD8/nHUnqDTcOwVBoRlltqZKBMg5wg91Tsy
 h3UXfg5GFvKG2dHrfxGF1BcX9ybV47KI00C0GYmdIViNpB9TbI51dk7ff0bPoebk8wdEUcFjote
 wo7I/xN5Tku8pWOkYw+88IzB4i0Krb0RmNZldvVdXWPDiDkBdyj5ygTqLdCMnov8LDLGuVHmOmu
 oz9ou+C2yBlwhY/CFsQLs8gBlhhao6nl8R7mFmZaKo6rfUUqGg3YNggc6fJXL+c+z1wJRVduTy6
 VyCPqfArHPTxQE40XFnQ0LFD2hr6LO3obj3YhsbmpBn56C4BWhwQqnfRtFRh/BeiqOl1zI/ks/S
 07ONWlxVBfyMJk+I6gw2RwdjaPu0Mphla/IFnJaH0JqkMRNH6n1luYm7FMrCeQ1uYOML1gGohVH
 SmpxucWrkuI1a+7U74pZdoAoPajV+ooIlQippws4u7yAlRzVscVHkPk=
X-Received: by 2002:a05:690e:d42:b0:64e:e896:a7c with SMTP id
 956f58d0204a3-65310acebf1mr1288156d50.55.1776413558053; Fri, 17 Apr 2026
 01:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
 <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
 <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
 <DHUV5T2RE2EW.2QKJXXKF2Z3N@ti.com>
In-Reply-To: <DHUV5T2RE2EW.2QKJXXKF2Z3N@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Apr 2026 11:12:01 +0300
X-Gm-Features: AQROBzBFYPFlkHXmBu0NNZ4VD2rJi-mBoQdUskzG1qa_0Z_p5_MyF61kYe1kjl4
Message-ID: <CAC_iWj+irf7MajW9OELsx0t1SJ_4jxebbRF0D5Oe=OjMkD+4UQ@mail.gmail.com>
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

On Thu, 16 Apr 2026 at 23:32, Randolph Sapp <rs@ti.com> wrote:
>
> On Thu Apr 16, 2026 at 2:54 PM CDT, Ilias Apalodimas wrote:
> > On Thu, 16 Apr 2026 at 22:23, Randolph Sapp <rs@ti.com> wrote:
> >>
> >> On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
> >> > Hi Randolph.
> >> >
> >> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
> >> >>
> >> >> From: Randolph Sapp <rs@ti.com>
> >> >>
> >> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> >> >> parsing a new device tree and properly warn people when a reservation
> >> >> overlaps with an existing allocation.
> >> >
> >> > The LMB has a set of regions that clearly describe memory in an
> >> > abstact way, e.g reserved, no overwrite etc.
> >> > I don't think adding we should open the door for treating reserved
> >> > memory as special. Can't we apply the same fix without adding a new
> >> > description?
> >> >
> >> > Thanks
> >> > /Ilias
> >>
> >> I did have an initial implementation using a separate allocation list for fdt
> >> regions in LMB. It works, but boy it's much more messy. All allocations and
> >> frees had to check both the regular allocation list and the fdt allocation list.
> >>
> >> I thought about having the fdt helpers build their own local list separate from
> >> LMB, but that's also a little messy in that it means we're either double
> >> tracking regions or tying to reach into the guts of LMB to extract information
> >> about that existing allocation region.
> >>
> >> Maybe that's fine considering LMB already reaches out to kick
> >> boot_fdt_add_mem_rsv_regions. Just trying to keep things compartmentalized at
> >> the moment.
> >>
> >> I'll revisit the localized reservation list for image-fdt. I'll just setup some
> >> goofy linked list to track allocation start and size for the later free. I
> >> assume we prefer a separate set of lmb_region structs for that list as it's a
> >> little concerning to pass references to an active LMB region outside of the LMB
> >> core.
> >
> > Can you explain a bit more when the problem happens? Is it because
> > boot_fdt_add_mem_rsv_regions() get called twice in some boot flows? Or
> > is there another reason?
> >
> > Thanks
> > /Ilias
>
> The initial comment explicitly calls out that as the reason they disabled the
> warning, but it should occur any time a device tree is loaded. Internal or
> external.
>

Yes, but that's requesting to reserve specific address(es) which is
always the same address ranges unless the DTB changes.  In which case
you just have to find and free the reserved-ranges. Keeping in mind
that's rare, you can re-parse the DT with minimal overhead and you
dont have to keep any metadat stored in LMB or anywhere else. and the
LMB subsystem is not the place to do that. The EEXIST basically means
"I've already done that" here so I am trying to understand what can
trigger this problem.

> That also lead me to believe if one were to load multiple external device trees
> that you could theoretically trip an OOM with a bunch of non-overlapping
> reserved regions. I have yet to test that, but culling old allocations seemed
> practical enough without that PoC.

Yea but that's a user error. You can also load a bigger binary that
your entire DRAM and trigger an OOM

Thanks
/Ilias
>
> >>
> >> >>
> >> >> If we don't at least warn the user of these reservation failures,
> >> >> there's a chance that this region could be freed and reallocated for
> >> >> something important later.
> >> >>
> >> >> This useful warning mechanism was broken in:
> >> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
> >> >>
> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> >> ---
> >> >>  boot/image-fdt.c |  5 ++++-
> >> >>  include/lmb.h    | 14 ++++++++++++++
> >> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
> >> >>  3 files changed, 47 insertions(+), 5 deletions(-)
> >> >>
> >> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> >> >> index a3a4fb8b558..0f5857f24d2 100644
> >> >> --- a/boot/image-fdt.c
> >> >> +++ b/boot/image-fdt.c
> >> >> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >> >>  {
> >> >>         long ret;
> >> >>         phys_addr_t rsv_addr;
> >> >> +       flags |= LMB_FDT;
> >> >>
> >> >>         rsv_addr = (phys_addr_t)addr;
> >> >>         ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
> >> >> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >> >>                 debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
> >> >>                       (unsigned long long)addr,
> >> >>                       (unsigned long long)size, flags);
> >> >> -       } else if (ret != -EEXIST && ret != -EINVAL) {
> >> >> +       } else if (ret != -EINVAL) {
> >> >>                 puts("ERROR: reserving fdt memory region failed ");
> >> >>                 printf("(addr=%llx size=%llx flags=%x)\n",
> >> >>                        (unsigned long long)addr,
> >> >> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
> >> >>         if (fdt_check_header(fdt_blob) != 0)
> >> >>                 return;
> >> >>
> >> >> +       lmb_free_fdt_regions();
> >> >> +
> >> >>         /* process memreserve sections */
> >> >>         total = fdt_num_mem_rsv(fdt_blob);
> >> >>         for (i = 0; i < total; i++) {
> >> >> diff --git a/include/lmb.h b/include/lmb.h
> >> >> index 427d701bc30..c6a1fc1ca47 100644
> >> >> --- a/include/lmb.h
> >> >> +++ b/include/lmb.h
> >> >> @@ -51,6 +51,15 @@
> >> >>   */
> >> >>  #define LMB_NONOTIFY BIT(3)
> >> >>
> >> >> +/**
> >> >> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regions()
> >> >> + *
> >> >> + * LMB Memory region attribute flag to indicate that the region will be
> >> >> + * reclaimed with lmb_free_fdt_regions(). This allows device tree reservations
> >> >> + * to be cleaned up and tracked more granularly.
> >> >> + */
> >> >> +#define LMB_FDT BIT(4)
> >> >> +
> >> >>  /**
> >> >>   * enum lmb_mem_type - type of memory allocation request
> >> >>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of memory
> >> >> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
> >> >>   */
> >> >>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
> >> >>
> >> >> +/**
> >> >> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved regions
> >> >> + */
> >> >> +void lmb_free_fdt_regions(void);
> >> >> +
> >> >>  #endif /* __KERNEL__ */
> >> >>
> >> >>  #endif /* _LINUX_LMB_H */
> >> >> diff --git a/lib/lmb.c b/lib/lmb.c
> >> >> index 8f12c6ad8e5..7ecc548d831 100644
> >> >> --- a/lib/lmb.c
> >> >> +++ b/lib/lmb.c
> >> >> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
> >> >>
> >> >>  static void lmb_print_region_flags(u32 flags)
> >> >>  {
> >> >> -       const char * const flag_str[] = { "none", "no-map", "no-overwrite",
> >> >> -                                         "no-notify" };
> >> >> -       unsigned int pflags = flags &
> >> >> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
> >> >> +       const char *const flag_str[] = { "none", "no-map", "no-overwrite",
> >> >> +                                        "no-notify", "fdt" };
> >> >> +       unsigned int pflags =
> >> >> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY | LMB_FDT);
> >> >>
> >> >>         if (flags != pflags) {
> >> >>                 printf("invalid %#x\n", flags);
> >> >> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
> >> >>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
> >> >>  }
> >> >>
> >> >> +void lmb_free_fdt_regions(void)
> >> >> +{
> >> >> +       struct alist *lmb_rgn_lst = &lmb.used_mem;
> >> >> +       struct lmb_region *rgn = lmb_rgn_lst->data;
> >> >> +       long ret;
> >> >> +       int i = 0;
> >> >> +
> >> >> +       while (i < lmb_rgn_lst->count) {
> >> >> +               phys_addr_t base = rgn[i].base;
> >> >> +               phys_size_t size = rgn[i].size;
> >> >> +               u32 flags = rgn[i].flags;
> >> >> +
> >> >> +               if (flags & LMB_FDT) {
> >> >> +                       ret = lmb_free(base, size, flags);
> >> >> +                       if (ret < 0) {
> >> >> +                               printf("Unable to free FDT memory at 0x%08lx\n",
> >> >> +                                      (ulong)base);
> >> >> +                               i++;
> >> >> +                       }
> >> >> +               } else {
> >> >> +                       i++;
> >> >> +               }
> >> >> +       }
> >> >> +}
> >> >> +
> >> >>  static int _lmb_alloc_base(phys_size_t size, ulong align,
> >> >>                            phys_addr_t *addr, u32 flags)
> >> >>  {
> >> >> --
> >> >> 2.53.0
> >> >>
> >>
>
