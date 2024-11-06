Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D761D44D48
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965B488D8D;
	Wed,  6 Nov 2024 11:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q+8KvkYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE328905E; Wed,  6 Nov 2024 11:43:26 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 565D788D35
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb5014e2daso59954991fa.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 02:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730889803; x=1731494603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FrJkToGFEe4AE1T0BhTueKYowMvFO9Q38IsBOFZDY/0=;
 b=q+8KvkYa9hnY5tAOhl5R5kk8pWOLKMoG+SSxd0fNWGyZi6XXLl7HFaeC/dUvHeUpZ5
 3kFNoCWxlVS9LG5qUIWLW9tP6qVrpz8a77pkTPI3fUHTk0D7RRJIbehLZZBvvcyABbci
 RXEzCUO7WGTAkaPssSv9hgm2JK/qw2A5GrYFCg72krBjlnfTi0BQEvP5s95NGUf3aS8X
 BUl+64ZBATDd4pAGfewaVHHNXWQVQOlcCcoVfDmDoN59V0V9mHa2ArOy+W2FiBuUJJUb
 yCRx8Gaz4vPoFNlfaA+SkEyMOAVPsZ8RvamGPRn+UWNEOdOzE20YXpfeb7Fp2OCG+903
 jFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730889803; x=1731494603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FrJkToGFEe4AE1T0BhTueKYowMvFO9Q38IsBOFZDY/0=;
 b=rxzxpKS/Sh9CmqXLQU5WYJg+H0OWRBCCiAhPWIAV780BJYvsQOCRlU7plFMdHQpXO8
 T4zv4NawvWMADhPjDMIc95reiURudPf1LLF+9lv0Q8BOCOWW9/HafupeRt5IhU1rNTKe
 x2Z8vhotgbBuwgWw1o4CPbrEPugcmhjic1Uww2RC/izhWf8AcE8Zwfp804eovGETxLwo
 YIqrpWBPSletTagOyr8mEaxHeKa3tPy2H2CJVrF4nBXqurbRd/CrdQEsl+sM0IR2IiAg
 zQSubIf66wPGJi4I/YNyMa1CrODU0l4he+ACREFx7VKfwWTAnYlyoskuJxq8Mj6VhdcB
 bnhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkq7gJK2+9lRMw2WfRJdjLVozL5lm3onO98yRKRUPoBIeAtawDKKd6BEf3LCnxegFq+tvj0WI=@lists.denx.de
X-Gm-Message-State: AOJu0YxjgARkEwWVdp9e7hHu69OLo5dv4bsgUrBB+ONu0FFIbZaNpZS2
 y7ZqkV7+UnW/PKzzpab/yXs5+/tkgMSChdT1I467FXIUi1l4jeWsgSq4O/7v8WvyvV3KACQoyWO
 +79gKhorvCa7G2uc/ra6tu81BwVuHDxf4y1PQgw==
X-Google-Smtp-Source: AGHT+IG6k5qkdS8O4nsB2JMUjc8nmIy9PO6eybrmWXHYt7JdjK12uzM+G8uSPVbmg3NY2lJScIp8hVTCaUmLwEsOXhg=
X-Received: by 2002:a2e:a9a1:0:b0:2fb:5a7e:504f with SMTP id
 38308e7fff4ca-2fedb7d925fmr97532881fa.35.1730889803374; Wed, 06 Nov 2024
 02:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
 <87v7x63p3c.fsf@bloch.sibelius.xs4all.nl>
 <CADg8p96csvFbyWpgajy_ewZMXRCsKstbhGFMnDUcGnG9e+QA3g@mail.gmail.com>
 <20241103173633.GA664967@robin.jannau.net>
 <CADg8p94t3AQ_tsEwSpQEUu3cc3P0BtbZ=DE8k58Vtp6HFGo-Nw@mail.gmail.com>
 <20241106071337.GB928468@robin.jannau.net>
In-Reply-To: <20241106071337.GB928468@robin.jannau.net>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 6 Nov 2024 16:13:12 +0530
Message-ID: <CADg8p97L9jgfKBBzxo2kk1fM4Rqi4hxdiu12Y60gnh6i+LWb1Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
To: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, trini@konsulko.com,
 kettenis@openbsd.org, sjg@chromium.org, u-boot@lists.denx.de
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

On Wed, 6 Nov 2024 at 12:43, Janne Grunau <j@jannau.net> wrote:
>
> On Wed, Nov 06, 2024 at 12:43:01AM +0530, Sughosh Ganu wrote:
> > On Sun, 3 Nov 2024 at 23:06, Janne Grunau <j@jannau.net> wrote:
> > >
> > > On Sun, Nov 03, 2024 at 07:53:36PM +0530, Sughosh Ganu wrote:
> > > > On Sat, 2 Nov 2024 at 16:00, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > > > >
> > > > > > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > Date: Fri, 1 Nov 2024 17:17:22 +0530
> > > > > >
> > > > > > On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
> > > > > > >
> > > > > > > The changes in "Make LMB memory map global and persistent" [1] break
> > > > > > > mapping DMA memory in the USB xHCI driver when using the apple_dart
> > > > > > > iommu present on Apple silicon systems.
> > > > > > >
> > > > > > > The IOVA space used by the u-boot driver (low 4GB) and physical memory
> > > > > > > do not overlap. The physical memory on this systems starts depending on
> > > > > > > the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
> > > > > > > manage these distinct regions in a single LMB map. In addition every
> > > > > > > device has its own iommu and IO address space so sharing a single memory
> > > > > > > map between all iommu instances is not necessary.
> > > > > > >
> > > > > > > To fix this issue restore the used subset (add, alloc and free) of the
> > > > > > > previous pointer based LMB interface with "io_" as prefix.
> > > > > > >
> > > > > > > To ensure that low level lmb functions do not use the global LMB
> > > > > > > variable reorder lib/lmb.c so that the variable is not visible.
> > > > > > >
> > > > > > > Tested with patches from my "Fix device removal order for Apple dart
> > > > > > > iommu" series [2] to fix a separate issue.
> > > > > > >
> > > > > > > The cosmetic commit has two checkpatch warnings in existing code which I
> > > > > > > ignored.
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@linaro.org/
> > > > > > > [2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net/
> > > > > > >
> > > > > > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > > > > > ---
> > > > > > > Janne Grunau (4):
> > > > > > >       lmb: Do not use global LMB variable in _lmb_free()
> > > > > > >       lmb: cosmetic: reorder functions and global LMB variable
> > > > > > >       lmb: Add basic io_lmb functionality
> > > > > > >       iommu: apple: Manage IOVA separately from global LMB mem map
> > > > > >
> > > > > > Thanks for these changes. I am currently on leave, but will take a
> > > > > > look at this in detail next week. But on a cursory glance, I have to
> > > > > > say that I am not entirely satisfied with this solution as well. With
> > > > > > these patches, we now have a disparity in terms on how we view the LMB
> > > > > > memory map -- we have a global map for RAM address range, but a per
> > > > > > device one for IOVA's. I understand that IOVA's are supposed to be
> > > > > > per-device,
> > > > >
> > > > > The IVOA's are per-stream.  Multiple devices might share a single
> > > > > stream.
> > > > >
> > > > > > but then I think that perhaps LMB is not the right way to
> > > > > > solve this. This was fine earlier, when the entire LMB implementation
> > > > > > in U-Boot was local, but that is not the case now. I wonder if there
> > > > > > can be a different, non-LMB way to implement this.
> > > > >
> > > > > Of course there can be a different implementation.  But why add a
> > > > > separate implementation for what is essentially the same problem:
> > > > > allocate blocks out of an address space.
> > > >
> > > > My primary concern here is to prevent setting a precedent that it is
> > > > okay to have a local, per caller lmb instance.
> > >
> > > I think the issue is thinking this is per caller. It is not (primarily)
> > > by caller. It is one LMB instance per managed independent address space
> > > block. Apple silicon SoCs have multiple independent iommus. Each iommu
> > > can handle multiple address spaces (streams, only partially implemented
> > > in the u-boot driver.
> > >
> > > > If it is allowed for
> > > > one caller, it becomes difficult to say no to someone proposing a
> > > > similar approach later. In any case, based on how the allocation logic
> > > > works, with all the addresses being allocated from the IOMMU driver's
> > > > map function callback, why can there not be a single instance of an
> > > > iova lmb structure. That would at least ensure some kind of parity on
> > > > how the lmb maps are maintained.
> > >
> > > There are multiple fully independent IOVA spaces. I doesn't make sense
> > > to allocate them from a single pool.
> > >
> > > > > Before you changed the goal posts, lmb did exactly that.  The only
> > > > > problem was that there were multiple lmb instances covering the same
> > > > > "main memory" address space.
> > > >
> > > > I had provided an explanation of the situation that existed prior to
> > > > these changes in a writeup [1]. And that writeup had clearly provided
> > > > the two possible solutions to fix the issue with EFI allocated memory
> > > > working with LMB. And it was decided through discussion on that
> > > > writeup as well as on the mailing list that this was the approach to
> > > > be taken.
> > >
> > > That document missed due to unfortunate circumstances one special case
> > > in the LMB usage. Consolidating all struct lmb referring main memory
> > > into a single opaque object is useful. Please let's move on to fix the
> > > single usage which broke due to the change.
> > >
> > > From my point of view it's clear that "io_lmb*" is separate from the
> > > main memory lmb.
> >
> > Yes, that is my view as well. Which is why I was proposing a different
> > mechanism for the IOVA allocations.
>
> It's not clear to me what you mean with "different mechanism". My
> understanding was that it would be completely separate from lmb but that
> is at conflict with the statement of code reuse below.

Yeah, I thought I was a little ambivalent on this point. Yes, I would
personally prefer a different implementation from lmb for these
allocations. But based on the comments from Mark, and also the fact
that Tom has given his R-b on your patches, I guess we will go ahead
with this approach.

>
> > > It manages the IO virtual address space of devices and
> > > it is fine that there as many (io_)lmb instances as there are IO virtual
> > > address spaces. These do not have to be managed via struct lmb and
> > > looking at the minimal io_lmb* API a simpler implementation would work.
> >
> > Okay. Although I wonder, given your explanation of multiple, per
> > device IO VA spaces, how would these spaces be identified, if not
> > through an instance of the lmb structure.
>
> If the u-boot driver would gain support for that, each IOVA space would
> have its own lmb instance. On iommu side the IOVA spaces are called
> stream and the driver would have one lmb structure for each stream.
>
> > > An alternative implementation would be duplicated code and reusing the
> > > existing tested lmb code is desireable.
> >
> > Yes, I agree.
> >
> > > If we want a stronger distinction between lmb and io_lmb we could hide
> > > struct lmb from io_lmb.
> >
> > Okay, but I am not sure how you would be able to achieve that. Are you
> > proposing using the region lists directly? If so, I would say that if
> > we are using the LMB code for the allocations, we might as well use
> > the structure.
>
> The most basic way would be a struct io_lmb which just embeds struct
> lmb and the io_lmb_* API would use struct io_lmb pointers as arguments.
> This would provide some type safety but I don't think it is necessary as
> the lmb API doesn't use struct lmb pointers (with the exception of
> lmb_push/lmb_pop);

We can use the lmb structure, as the API signature for the IOVA use
case is different, along with the fact that the API's have symbol
names starting with io_lmb_*.

-sughosh

>
> best regards,
> Janne
