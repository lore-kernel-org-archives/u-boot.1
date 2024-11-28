Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D837D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C8C89D34;
	Thu, 28 Nov 2024 16:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lq0hanT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA76A89C67; Thu, 28 Nov 2024 16:46:27 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2B189877
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-724e113c821so917062b3a.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808783; x=1733413583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fD+E8jXR9TOcUn+d31zbrZvAcy29v2/Agi2nFX8NfDQ=;
 b=lq0hanT4EZJk+zcQdEcLF7BybXq3+dWPp+oCXMAiWFHwsgNuHPfwZh28VZJeYEvEPj
 LN6SaVWUzSj13TY7lCl1e6N7C9r96bxbKFRqH3FJ4aCQjeGeftps4QAaIc5ZNVfvfrfv
 l3iBcuJifJBL/2uoTooydP09K6vc/ZuFfqGxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808783; x=1733413583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fD+E8jXR9TOcUn+d31zbrZvAcy29v2/Agi2nFX8NfDQ=;
 b=UJGUtKOYG1djH8bdldtlTVbocvSM3ivuopD595SLmCm15jn/pWfg58P8MRJvKFB3w3
 Pqcus2ZdVTTCZM9JuD/06XSzkyVCHpFuSBv8ppd/QGB2/Cq+g1/+sYiBO6srBisy7bYn
 r7g6/4F1TeR++8f7A2q09kcshAjYN3zyG5yuFO4NlxRI0XVFm3p3U31wsZBLhkoDVUiz
 uo7voOh6/ihI8Q6Bz1nLUYNQ3nRJFwiAq+IXYIVLv+r+3QCf0HbMBiX7yb4iOP0Kd2g6
 il42kFdgifzL4diFASvH2CU5NV28rI3hBdzE5Uv9jt473XonONsROafrFpJAyDGiQL9t
 Auyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAN8CX7dtc6+dXcUUxW+gCPVUr3Danmxk39Zid25K2vwwxkDHFNBNUf6sNrJlB5OgEGrsRXbo=@lists.denx.de
X-Gm-Message-State: AOJu0YwTEjbh0dxAi8o08XlOUhqYm5aMMD8Hbe1Kah0W/LhS1HAeSWWA
 pKRwLjxYLc3hxap38AEPqsj2eN/G6FTN0dzx/BiWVUakcBPxl6kkEYm622pAm/s+u3CN5o/IKUR
 yPBJTPMh6vNNOQ1wwOydyx7Mf81+/hAvPBVEB
X-Gm-Gg: ASbGncunON3pJC90f7YU+hw5QdH6CdumZqqEkpg2ZqWHLPWkoU/SerDWo9RKZj+hsNr
 tAcqwC1yfOQMQB6SrLb0J7HuVthW/2bg=
X-Google-Smtp-Source: AGHT+IHPkWbSr3UP+8tLJl3Dzc+QH0lq5/xluR6UL+8I6y72EjDw4WLFx8HrxyY5Hk3dekPiLZZ+O5Gp1Wo9w9BCspo=
X-Received: by 2002:a17:90b:1d81:b0:2ea:4e9e:df87 with SMTP id
 98e67ed59e1d1-2ee08eb62b0mr9362888a91.19.1732808783227; Thu, 28 Nov 2024
 07:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20241113052050.1862420-1-caleb.connolly@linaro.org>
 <CAFLszThAmn_NU-PoYopjx17Bk6QxgbFaCWJjKdMAG5JzLJWdEg@mail.gmail.com>
 <d89d7d04-8ff9-460d-844f-c85129c5ba77@linaro.org>
 <CAFLszThmRJZHzecSH1A9zS7f3oiS+kCB=jBarHOZG7RGv3gL_A@mail.gmail.com>
 <482ea637-f8e2-4880-9125-19c7eba517a2@linaro.org>
In-Reply-To: <482ea637-f8e2-4880-9125-19c7eba517a2@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 08:46:08 -0700
Message-ID: <CAFLszTgL+=e0AtyoLYWO--BYJf8+O0ndifg5P96NGs98CkoW+A@mail.gmail.com>
Subject: Re: [PATCH] dm: core: ofnode: safely fallback in ofnode_lookup_fdt
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Caleb,

On Thu, 28 Nov 2024 at 05:33, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 27/11/2024 18:51, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Wed, 27 Nov 2024 at 10:12, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 27/11/2024 17:52, Simon Glass wrote:
> >>> Hi Caleb,
> >>>
> >>> On Tue, 12 Nov 2024 at 22:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> Under some conditions it's possible to hit the null condition here like
> >>>> when running with OF_LIVE and using the ofnode API before
> >>>> initr_of_live() is called. There is very little null
> >>>> checking for this in the FDT framework, so returning null here can
> >>>> result in weird null pointer conditions.
> >>>>
> >>>> Instead let's return the control FDT in the fallback case, this is
> >>>> usually what the user was expecting.
> >>>>
> >>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>>> ---
> >>>>  drivers/core/ofnode.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> >>>> index 950895e72a99..7a7f25fc537c 100644
> >>>> --- a/drivers/core/ofnode.c
> >>>> +++ b/drivers/core/ofnode.c
> >>>> @@ -152,9 +152,9 @@ void *ofnode_lookup_fdt(ofnode node)
> >>>>                 uint i = OFTREE_TREE_ID(node.of_offset);
> >>>>
> >>>>                 if (i >= oftree_count) {
> >>>>                         log_debug("Invalid tree ID %x\n", i);
> >>>> -                       return NULL;
> >>>> +                       return (void *)gd->fdt_blob;
> >>>>                 }
> >>>>
> >>>>                 return oftree_list[i];
> >>>>         } else {
> >>>> --
> >>>> 2.47.0
> >>>>
> >>>
> >>> Eek I really don't like that, since it will silently return an
> >>> unexpected value.
> >> What's the unexpected value? The only caller for this is ofnode_to_fdt()
> >> and the return value for that is never checked. It seems clear to me
> >> that in practise NULL is the unexpected value here.
> >
> > Firstly, it looks like ofnode_lookup_fdt() should be static
> >
> > If a node offset cannot be found, that suggests that oftree_list[] is
> > empty, which suggests that oftree_reset() has not been called yet.
> >
> > oftree_reset() is called after relocation. Before relocation, it just
> > assumes that the control FDT is being used.
> >
> > I wonder if you are hitting this problem after relocation, in one of
> > the functions in init_sequence_r[] before initr_dm()?
>
> aha! Now I remember, mach-snapdragon has it's own enable_caches() which
> looks at the DT to determine if we should do some additional work to
> carve out reserved memory regions which some platforms might otherwise
> speculate on triggering a crash.
>
> I think this is also specific to some non-upstream patches I have which
> use the ofnode API, since the current compatible check uses fdt_blob
> directly.
>
> Disabling OFNODE_MULTI_TREE works around the crash, which would be fine
> since we don't currently use it on Qualcomm (I think?).
>
> but it would be nice to solve this.
>
> What about if we called oftree_reset() immediately after initr_reloc?

Well, we don't have malloc() running so can't create the livetree that early.

Could you pick up that info from the DT before relocation and store
the info somewhere? It seems like that would be a pain, from my
reading of carve_out_reserved_memory()

So another idea would be to add a gd flag indicating that multi-tree
is available. Before that we return the control FDT, similar to your
patch. But it would be deterministic.


> >
> > In any case this does seem like a bug that we should fix.
> >
> >>
> >>> I think we should panic. Do you know what code path
> >>> gets you here?
> >>
> >> Hmm, I don't exactly recall. Should really have made a note when I wrote
> >> this patch :/
> >
> > Yes, I know that feeling :-(
> >
> >>
> >> Guess I'll drop this from my dev branch and come back when I figure this
> >> out again.
> >
> > Yes OK. A patch which panics would be fine for now, if you like.
> >
> >
> >>>
> >>> More work is needed in livetree to sort of the rough edges, sadly...

Regards,
SImon
