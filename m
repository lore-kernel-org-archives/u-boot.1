Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E82D78321
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 14:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C20F89183;
	Mon,  2 Dec 2024 15:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f4pm7HAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA0C78919F; Mon,  2 Dec 2024 15:11:53 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489E289100
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 15:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6ef6a67834fso20488407b3.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733148710; x=1733753510; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qg9gkzuIvhDpAeEuuQYmozRPaAjMRHM6x5QhKkh+MyI=;
 b=f4pm7HAZ8A2Mx1M1vjeKBWQRa7Dk++wSJkCNbaid3dVa5cT+hVjOftBqDvI8y2ir4k
 Cw0Qgqus2HhY8OQogLuBBJQotjLHvAYGVD4mH41xp+PH9LfeQEagA7YfmFtIcPed29oX
 hGlqyyqJs/uwBo6tWs+Aoked57q+pKrJ3xPaFmM1Bu5HMFI//g9JJApdoMUlk4FsVaQd
 Ny0FsE02GNWyt6x4JHwC7VFjW6SUlcFzZkS/9gAzRYCoAJ/Y6k1ZOLY/3hOt5WxWYAfm
 LoAas60ad8HQFwe7Pks53STqSqX8mBq+WwPDURhcLDN+y9Mt9+RjAqLF0RJ44fI/r64r
 X0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733148710; x=1733753510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qg9gkzuIvhDpAeEuuQYmozRPaAjMRHM6x5QhKkh+MyI=;
 b=v0aTc3zUGIsR82Xuo3D0oJdr2V3NdJcVcxAM8EYwKtBzpw+YkfaMjwI80Yp8G+LV3o
 seqn8le1nZQYH35XkRtM7d0sYBZjRxdw+IRyCSqYDa57pztwobVGop1nW5EqpYLGYl41
 gckbd0QVMmuxn17aDM5g+OnxpaOaI0ksdLR7HTy+ihBfwipWJw3c3E+EKvRKIiHPxMw4
 TJwhxTIZFfPKRYbapxeilMRDExVHoUHCY8Fna5zlD8e3rQjxciTOC7qJW4FDZTEPaedq
 DFDf/A2L60F5oLN1pRGW571TMsk6EAww2VC4bxCb4CZmoIOkdSzPEUX9GIaleayzSbHY
 3E8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCFZ9kv/yBpmc7tl2iFTH4LfI8P0KnAIrvNsZfyvSuBHjuu3tmIkrOOmbNO5Kvw80Cr6X8B54=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/6h0O9tEJhG77RsRLikZnNDKUyRMVm5nPwoMjvYx7nxUqvUyp
 ltrxFVHi9u4YvhyVlTUPaYAqabbST+JIkNi6aThujfQMUHb9jn2UrRRG0FP0ySgE/MWJh1EQCDt
 DO8IKQ1Jmei52uKPXLzqT5jh0EBiNV1AMgCGPYQ==
X-Gm-Gg: ASbGnctzlbx/1mgxDOQgRjZjtuC/JLBW/SUkt62KVlsU3BBpNf8plPJNOYBFIzLVKW7
 rYuw5Wqqe6bkNhn7h+jHyJl9pq0esito=
X-Google-Smtp-Source: AGHT+IH+K0HMdREfXKgYhUuw0ZV+nwgxbmRRcZEfEZ2Ar30XIUQ6o9jBbLz1CKVt6Z0ikMQYXxn5m+ifKHDmrMcTlwc=
X-Received: by 2002:a05:690c:4a04:b0:6ef:86db:4356 with SMTP id
 00721157ae682-6ef86db43dbmr55589277b3.18.1733148704253; Mon, 02 Dec 2024
 06:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20241128114926.458728-1-ilias.apalodimas@linaro.org>
 <58f70517-8ed4-40df-ab36-7f5595ff1e71@gmx.de>
In-Reply-To: <58f70517-8ed4-40df-ab36-7f5595ff1e71@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 2 Dec 2024 16:11:08 +0200
Message-ID: <CAC_iWj+wTMO8ceVy8b_nx2vQO+srfuK1JsdvMXc_pn_rL7VtFQ@mail.gmail.com>
Subject: Re: [PATCH] lmb: Fix the allocation of overlapping memory areas with
 !LMB_NONE
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Mon, 2 Dec 2024 at 15:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.11.24 12:49, Ilias Apalodimas wrote:
> > At the moment the LMB allocator will return 'success' immediately on two
> > consecutive allocations if the second one is smaller and the flags match
> > without resizing the reserved area.
> >
> > This is problematic for two reasons, first of all the new updated
> > allocation won't update the size and we end up holding more memory than
> > needed, but most importantly it breaks the EFI SCT tests since EFI
> > now allocates via LMB.
> >
> > More specifically when EFI requests a specific address twice with the
> > EFI_ALLOCATE_ADDRESS flag set, the first allocation will succeed and
> > update the EFI memory map. Due to the LMB behavior the second allocation
> > will also succeed but the address ranges are already in the EFI memory
> > map due the first allocation. EFI will then fail to update the memory map,
> > returning EFI_OUT_OF_RESOURCES instead of EFI_NOT_FOUND which break EFI
> > conformance.
> >
> > So let's remove the fast check with is problematic anyway and leave LMB
> > resize and calculate address properly. LMB will now
> > - try to resize the reservations for LMB_NONE
> > - return -1 if the memory is not LMB_NONE and already reserved
> >
> > The LMB code needs some cleanup in that part, but since we are close to
> > 2025.01 do the easy fix and plan to refactor it later.
> > Also update the dm tests with the new behavior.
> >
> > Fixes: commit 22f2c9ed9f53 ("efi: memory: use the LMB API's for allocating and freeing memory")
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/lmb.c      |  9 ---------
> >   test/lib/lmb.c | 22 +++++++++++++++++++++-
> >   2 files changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 14b9b8466ff2..3a765c11bee6 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -201,15 +201,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> >               phys_addr_t rgnbase = rgn[i].base;
> >               phys_size_t rgnsize = rgn[i].size;
> >               phys_size_t rgnflags = rgn[i].flags;
> > -             phys_addr_t end = base + size - 1;
> > -             phys_addr_t rgnend = rgnbase + rgnsize - 1;
> > -             if (rgnbase <= base && end <= rgnend) {
> > -                     if (flags == rgnflags)
> > -                             /* Already have this region, so we're done */
> > -                             return 0;
> > -                     else
> > -                             return -1; /* regions with new flags */
> > -             }
> >
> >               ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> >               if (ret > 0) {
> > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > index c917115b7b66..bc44dd21192f 100644
> > --- a/test/lib/lmb.c
> > +++ b/test/lib/lmb.c
> > @@ -529,6 +529,26 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
> >       ret = lmb_add(ram, ram_size);
> >       ut_asserteq(ret, 0);
> >
> > +     /* Try to allocate a page twice */
> > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
> > +     ut_asserteq(b, alloc_addr_a);
> > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> > +     ut_asserteq(b, 0);
> > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
> > +     ut_asserteq(b, alloc_addr_a);
> > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x2000, LMB_NONE);
> > +     ut_asserteq(b, alloc_addr_a);
> > +     ret = lmb_free(alloc_addr_a, 0x2000);
> > +     ut_asserteq(ret, 0);
> > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> > +     ut_asserteq(b, alloc_addr_a);
> > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NONE);
> > +     ut_asserteq(b, 0);
> > +     b = lmb_alloc_addr_flags(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> > +     ut_asserteq(b, 0);
> > +     ret = lmb_free(alloc_addr_a, 0x1000);
> > +     ut_asserteq(ret, 0);
> > +
> >       /*  reserve 3 blocks */
> >       ret = lmb_reserve(alloc_addr_a, 0x10000);
> >       ut_asserteq(ret, 0);
> > @@ -734,7 +754,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
> >
> >       /* reserve again, same flag */
> >       ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
> > -     ut_asserteq(ret, 0);
> > +     ut_asserteq(ret, 0xffffffff);
>
> lmb_reserve_flags() should return a long value < 0 on failure. Why do
> you expect 0xffffffff?

lmb_alloc_addr_flags has  a phys_addr_t (unsigned long), I can rewrite
this as ut_asserteq(ret, -1); which is probably correct for 32/64bit

Cheers
/Ilias
>
> Best regards
>
> Heinrich
>
> >       ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
> >                  0, 0, 0, 0);
> >
>
