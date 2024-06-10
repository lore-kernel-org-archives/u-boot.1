Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC1DC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 14:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5D588537;
	Mon, 10 Jun 2024 16:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UsIqpMTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE7418857A; Mon, 10 Jun 2024 16:22:25 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 449BB88537
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f6da06ba24so23468965ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718029342; x=1718634142; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hhNayGUAmEp3/oKkG5SeGivTLOAyTlMgpKRM4QFtnsQ=;
 b=UsIqpMTPS519k0dr7I5IPV69LSUdJWLXdkg6g2j39iIwH4QHSuQ88bWq8eMemEpDJF
 dfyphWH+3P1mGeCYNeL0IAYfoLrHknsO4hOhlHr5JtNOGNOrNsMbLsUl+UgT8YihNNyY
 BmQogbQB4phB+rpdAezUlorjl/vZtDyqjloVKKVuxQ7FmlRC9HLTlnnzz0EJn2u7q/o+
 NCY96KrwZGTUHOyuFEVx5Baga5yTPP7niIYkhsQ0mk4/Oi4T/6VnmxB4mQwlkYga3YAM
 oeaPCqXO6sB3UF8plsGztBjrSVZaM8shyYw8xuvDhVrZVDMJ/UAmOUMO/QrKcATML7XE
 qcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718029342; x=1718634142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hhNayGUAmEp3/oKkG5SeGivTLOAyTlMgpKRM4QFtnsQ=;
 b=aflY1Qp4fBTewKEb0ls2X/UfBVzfWwa4laewnhi+zIEvGx8FkORKbXjgoMGy9HRjNP
 1vj4pbbEHELXUP+856QaoliqrxMSMogN1ppdU1EFGZY7YnSPaiwlkiOeQ+XNx7P9dM7S
 FxW210+D1h38lzN8kqvovEyQt7GnEcNeqvD+kUqfflVsdhWnBltpgDPPCFIr+3DGR1a5
 5r3LZ1CLliOGA2IZunrAezfMuIGB4C9T62pz+Zt8Wp9fblU5W+fbyWCm0tkP38y1YXzE
 nbpW9U6PKglpdq0lVRFeoxpPZOUnJ3fgeppu6zlPuDZWaJnAcUuHEPYhE5IE/urp3aEk
 eCDQ==
X-Gm-Message-State: AOJu0YxFCCSwdT234SIRRpsZi+17MeR5WgOkluf/MgP5rqHjgkFnYwef
 Tj5DMRMxI76XaY/DFF0QwM8FxnMN3Zp4Fmf9XXlwIpHcIMmonrZc5f6O6mJKtrx/Uy46QH+N/Yv
 ltXNs6sp1pdkvX2DtHd76yiIjaT7HOiyeOCOmgQ==
X-Google-Smtp-Source: AGHT+IGGV44xF4CZ3i00n7JwhJ03FUzUEIrSBB4EnKeARWIm0rUr1Brf+C7EkESrH/VngvKGar38i2xZ6mHuARVwnhg=
X-Received: by 2002:a17:902:c102:b0:1f7:92b:4e6f with SMTP id
 d9443c01a7336-1f7092b5094mr29097495ad.29.1718029341587; Mon, 10 Jun 2024
 07:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-10-sughosh.ganu@linaro.org>
 <CAC_iWjJARprGkjPQV4nVGKPWxBL+3iiSAuKcdqUNvn+hKV40XQ@mail.gmail.com>
 <CADg8p95O5FMyyLV3yZkRshrOB4nbKa4VdQwMxrSf4bB9z4e8Yg@mail.gmail.com>
 <CAC_iWjJaWMrv94c_94K_gCaZ0-RaOEz03M-pF4z7qOdryaqbSg@mail.gmail.com>
 <CADg8p96ztLcp80GHghBr2JTeEVcd795LiXarhNks6Ycsf7TjBw@mail.gmail.com>
In-Reply-To: <CADg8p96ztLcp80GHghBr2JTeEVcd795LiXarhNks6Ycsf7TjBw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 17:21:44 +0300
Message-ID: <CAC_iWjLrak_a-vMz-Fy+UHPN0vg+7xGdqReGh0m7pf9UY9eP9w@mail.gmail.com>
Subject: Re: [RFC PATCH 09/31] lmb: allow for resizing lmb regions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

Hi Sughosh

On Mon, 10 Jun 2024 at 15:57, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 10 Jun 2024 at 18:17, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Mon, 10 Jun 2024 at 15:20, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > hi Ilias,
> > >
> > > On Mon, 10 Jun 2024 at 17:34, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Sughosh
> > > >
> > > >
> > > > On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Allow for resizing of LMB regions if the region attributes match. The
> > > > > current code returns a failure status on detecting an overlapping
> > > > > address. This worked up until now since the LMB calls were not
> > > > > persistent and global -- the LMB memory map was specific and private
> > > > > to a given caller of the LMB API's.
> > > > >
> > > > > With the change in the LMB code to make the LMB reservations
> > > > > persistent, there needs to be a check on whether the memory region can
> > > > > be resized, and then do it if so. To distinguish between memory that
> > > > > cannot be resized, add a new flag, LMB_NOOVERWRITE. Reserving a region
> > > > > of memory with this attribute would indicate that the region cannot be
> > > > > resized.
> > > >
> > > > Can you think of a memory region that needs to be protected from resizing?
> > >
> > > Actually, I think I could use a better term instead of 'resize'. The
> > > aim of this patch is to allow re-allocation/re-reservation of the same
> > > region of memory -- this will only be relevant for the LMB
> > > reservations, as these are used for loading images into memory. All
> > > other allocations(EFI currently) are true allocations in that these
> > > should not get overwritten at all. Memory once allocated, say for
> > > loading an EFI image, cannot be re-requested.
> > >
> > >
> > > > I think we should design this a bit differently.  For example, think
> > > > of someone loading a file in a memory region and then a subsystem
> > > > trying to resize its reserved memory overwriting that region. Instead
> > > > of this flag why don't we add
> > > > - A flag that indicates whether this region can be re-used (IOW
> > > > overwrites it), but only if the 'subsytem id' defined below matches
> > > > - a u32 that indicates the subsystem ID that initiated the transaction
> > > > -- e.g EFI, load command, U-Boot core .. etc
> > > >
> > > > Resizing can be enabled unconditionally in that case as long as there
> > > > is enough space. The only requirement would be that the request comes
> > > > from the same subsystem that reserved the memory in the beginning
> > >
> > > Like I mentioned above, resizing(or rather re-allocations) should only
> > > be allowed for the LMB subsystem. Any other module should not be
> > > returned an already allocated address. Which is why I mark any memory
> > > map update coming from the EFI module as no-overwrite.
> >
> > And what happens if someone tries to overwrite 'load' memory? Won't
> > you still corrupt whatever is loaded on that region as it's not marked
> > for protection?
>
> Yes, but that is the expected behavior in U-Boot for LMB memory.
> Consider the following flow,
>
> 1) load hostfs - $some_addr $some_image
> 2) fs.write $some_addr $some_destination $filesize
> 3) load hostfs - $some_addr $some_other_image
> 4) fs.write $some_addr $some_other_destination $filesize
>
> The above flow is very much valid, and this exercises the same region
> of LMB memory. Which is why we need to allow re-using the same memory
> address for LMB. This worked up until now since all LMB
> allocations/reservations were private. This is user visible behaviour,
> and used in many scripts used by platforms to read and write files. So
> even after making the LMB memory map global and persistent, this
> aspect of re-use of LMB memory must be maintained.

I am not talking about this. I haven't gone through all the patches
yet, so I might be missing something but...
What if a user loads a file to boot and then an EFI subsystem decides
to allocate memory -- e.g the EventLog and that allocation routine
returns memory within the space you just loaded the binary from? Yes
memory should be overwritten to preserve the current behavior, but
only if you perform the same action/command

Thanks
/Ilias
>
> -sughosh
>
> >
> > /Ilias
> > >
> > > -sughosh
> > > >
> > > > Thanks
> > > > /Ilias
> > > >
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > >  include/lmb.h |   1 +
> > > > >  lib/lmb.c     | 120 ++++++++++++++++++++++++++++++++++++++++++++------
> > > > >  2 files changed, 107 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/include/lmb.h b/include/lmb.h
> > > > > index 03bce2a50c..1d4cd255d2 100644
> > > > > --- a/include/lmb.h
> > > > > +++ b/include/lmb.h
> > > > > @@ -20,6 +20,7 @@
> > > > >  enum lmb_flags {
> > > > >         LMB_NONE                = 0x0,
> > > > >         LMB_NOMAP               = 0x4,
> > > > > +       LMB_NOOVERWRITE         = 0x8,
> > > > >  };
> > > > >
> > > > >  /**
> > > > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > > > index de5a2cf23b..0a4f3d5bcd 100644
> > > > > --- a/lib/lmb.c
> > > > > +++ b/lib/lmb.c
> > > > > @@ -260,12 +260,88 @@ void lmb_add_memory(struct bd_info *bd)
> > > > >         }
> > > > >  }
> > > > >
> > > > > +static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned long r1,
> > > > > +                                  enum lmb_flags flags)
> > > > > +{
> > > > > +       return rgn->region[r1].flags == flags;
> > > > > +}
> > > > > +
> > > > > +static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned long i,
> > > > > +                                     phys_addr_t base, phys_size_t size,
> > > > > +                                     enum lmb_flags flags)
> > > > > +{
> > > > > +       phys_size_t rgnsize;
> > > > > +       unsigned long rgn_cnt, idx;
> > > > > +       phys_addr_t rgnbase, rgnend;
> > > > > +       phys_addr_t mergebase, mergeend;
> > > > > +
> > > > > +       rgn_cnt = 0;
> > > > > +       idx = i;
> > > > > +       /*
> > > > > +        * First thing to do is to identify how many regions does
> > > > > +        * the requested region overlap.
> > > > > +        * If the flags match, combine all these overlapping
> > > > > +        * regions into a single region, and remove the merged
> > > > > +        * regions.
> > > > > +        */
> > > > > +       while (idx < rgn->cnt - 1) {
> > > > > +               rgnbase = rgn->region[idx].base;
> > > > > +               rgnsize = rgn->region[idx].size;
> > > > > +
> > > > > +               if (lmb_addrs_overlap(base, size, rgnbase,
> > > > > +                                     rgnsize)) {
> > > > > +                       if (!lmb_region_flags_match(rgn, idx, flags))
> > > > > +                               return -1;
> > > > > +                       rgn_cnt++;
> > > > > +                       idx++;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > > +       /* The merged region's base and size */
> > > > > +       rgnbase = rgn->region[i].base;
> > > > > +       mergebase = min(base, rgnbase);
> > > > > +       rgnend = rgn->region[idx].base + rgn->region[idx].size;
> > > > > +       mergeend = max(rgnend, (base + size));
> > > > > +
> > > > > +       rgn->region[i].base = mergebase;
> > > > > +       rgn->region[i].size = mergeend - mergebase;
> > > > > +
> > > > > +       /* Now remove the merged regions */
> > > > > +       while (--rgn_cnt)
> > > > > +               lmb_remove_region(rgn, i + 1);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static long lmb_resize_regions(struct lmb_region *rgn, unsigned long i,
> > > > > +                              phys_addr_t base, phys_size_t size,
> > > > > +                              enum lmb_flags flags)
> > > > > +{
> > > > > +       long ret = 0;
> > > > > +       phys_addr_t rgnend;
> > > > > +
> > > > > +       if (i == rgn->cnt - 1 ||
> > > > > +               base + size < rgn->region[i + 1].base) {
> > > > > +               if (!lmb_region_flags_match(rgn, i, flags))
> > > > > +                       return -1;
> > > > > +
> > > > > +               rgnend = rgn->region[i].base + rgn->region[i].size;
> > > > > +               rgn->region[i].base = min(base, rgn->region[i].base);
> > > > > +               rgnend = max(base + size, rgnend);
> > > > > +               rgn->region[i].size = rgnend - rgn->region[i].base;
> > > > > +       } else {
> > > > > +               ret = lmb_merge_overlap_regions(rgn, i, base, size, flags);
> > > > > +       }
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > >  /* This routine called with relocation disabled. */
> > > > >  static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> > > > >                                  phys_size_t size, enum lmb_flags flags)
> > > > >  {
> > > > >         unsigned long coalesced = 0;
> > > > > -       long adjacent, i;
> > > > > +       long ret, i;
> > > > >
> > > > >         if (rgn->cnt == 0) {
> > > > >                 rgn->region[0].base = base;
> > > > > @@ -290,23 +366,32 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> > > > >                                 return -1; /* regions with new flags */
> > > > >                 }
> > > > >
> > > > > -               adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> > > > > -               if (adjacent > 0) {
> > > > > +               ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> > > > > +               if (ret > 0) {
> > > > >                         if (flags != rgnflags)
> > > > >                                 break;
> > > > >                         rgn->region[i].base -= size;
> > > > >                         rgn->region[i].size += size;
> > > > >                         coalesced++;
> > > > >                         break;
> > > > > -               } else if (adjacent < 0) {
> > > > > +               } else if (ret < 0) {
> > > > >                         if (flags != rgnflags)
> > > > >                                 break;
> > > > >                         rgn->region[i].size += size;
> > > > >                         coalesced++;
> > > > >                         break;
> > > > >                 } else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> > > > > -                       /* regions overlap */
> > > > > -                       return -1;
> > > > > +                       if (flags == LMB_NONE) {
> > > > > +                               ret = lmb_resize_regions(rgn, i, base, size,
> > > > > +                                                        flags);
> > > > > +                               if (ret < 0)
> > > > > +                                       return -1;
> > > > > +
> > > > > +                               coalesced++;
> > > > > +                               break;
> > > > > +                       } else {
> > > > > +                               return -1;
> > > > > +                       }
> > > > >                 }
> > > > >         }
> > > > >
> > > > > @@ -448,7 +533,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
> > > > >  }
> > > > >
> > > > >  static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
> > > > > -                                   phys_addr_t max_addr)
> > > > > +                                   phys_addr_t max_addr, enum lmb_flags flags)
> > > > >  {
> > > > >         long i, rgn;
> > > > >         phys_addr_t base = 0;
> > > > > @@ -498,7 +583,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
> > > > >  {
> > > > >         phys_addr_t alloc;
> > > > >
> > > > > -       alloc = __lmb_alloc_base(size, align, max_addr);
> > > > > +       alloc = __lmb_alloc_base(size, align, max_addr, LMB_NONE);
> > > > >
> > > > >         if (alloc == 0)
> > > > >                 printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> > > > > @@ -507,11 +592,8 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
> > > > >         return alloc;
> > > > >  }
> > > > >
> > > > > -/*
> > > > > - * Try to allocate a specific address range: must be in defined memory but not
> > > > > - * reserved
> > > > > - */
> > > > > -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> > > > > +static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> > > > > +                                   enum lmb_flags flags)
> > > > >  {
> > > > >         long rgn;
> > > > >
> > > > > @@ -526,13 +608,23 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> > > > >                                       lmb.memory.region[rgn].size,
> > > > >                                       base + size - 1, 1)) {
> > > > >                         /* ok, reserve the memory */
> > > > > -                       if (lmb_reserve(base, size) >= 0)
> > > > > +                       if (lmb_reserve_flags(base, size, flags) >= 0)
> > > > >                                 return base;
> > > > >                 }
> > > > >         }
> > > > > +
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * Try to allocate a specific address range: must be in defined memory but not
> > > > > + * reserved
> > > > > + */
> > > > > +phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> > > > > +{
> > > > > +       return __lmb_alloc_addr(base, size, LMB_NONE);
> > > > > +}
> > > > > +
> > > > >  /* Return number of bytes from a given address that are free */
> > > > >  phys_size_t lmb_get_free_size(phys_addr_t addr)
> > > > >  {
> > > > > --
> > > > > 2.34.1
> > > > >
