Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC26D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A5489218;
	Fri, 18 Oct 2024 17:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SVrClvqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E072589261; Fri, 18 Oct 2024 17:03:20 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71EBB89218
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so21085945ad.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263790; x=1729868590; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1RShdV/FhdmmVJ9q0TD/vHCq1Z6Cqt2j3+PNaYnfNJ0=;
 b=SVrClvqoiU8JTwebSbdpdx8FOO1TDOEDd2Ogy0I9XR01kWBpz1kdNWURpJ3w84NxcW
 DF5ATiXzAPVS44NfL4gPSZLACMUlVAhoI0iQiTu7aUn/TYHTQdsYW6rCqs9i+IvzF8+Z
 hy2158KFg6CsuyTEtIXUYdQqcKCGVGB80nIQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263790; x=1729868590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1RShdV/FhdmmVJ9q0TD/vHCq1Z6Cqt2j3+PNaYnfNJ0=;
 b=ZSk0bOx5fIDC45J2FobhN6SiHP/zu2KOy+cl4jBcxtOXuhA5iTeGVE9SRsmiVJGfY6
 KjtaFQJQVNTTn/Zx9IJuwHHusDVs7T93a+zj45FH1dyzUn83NbuIaTVV8L82GykBBQHj
 w2z5Kxa5TeDckvuWDJ7Z6sZeaw716rNyrITCNniKCvnBNTzQUsvWt+wnnAiDtyxqmds1
 ecwa+0epx95uNFHISgwXQoUt1paPQSnZEfCYG79CkBZNyOLX06i2FDYBLO2ui3RKWXBj
 s6EY8E6u1g9gZGB8qvgUxueTToOmUiXEoRi4sea2LcDfc9Bdg1o/wJwVrX9Vi5nfec9n
 7PYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzRaQevyFeLWIXU0n0SUlLr3Ymxuc+kLqm+k8wyYUk1csrSPxAfud/ZviDbns7q2D3D5TX6ho=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1FRV92oG7FO+IWUH0p2XNBm8Wmp61iQhGQ1aGPAYkGkS7x0zn
 got37auYVQ8uqiOO2XzWwHgXP3rKa9jmOnA2QyvkLbDQmLwnYEkmZf3B2euBlwTFWANZ15t+HiM
 8BiLVF2gQrqib8g6g1O/2XEuKP2Abdqblv+tj
X-Google-Smtp-Source: AGHT+IE0lmrff3NS6uNAmF8LbneCOuK676KCXsisvr+R3Pmoaz2YBJhKScbVsXG3yT5I+PlEpzPB0G83z7qDihnhZzA=
X-Received: by 2002:a17:90b:3b4f:b0:2e2:9ffe:6636 with SMTP id
 98e67ed59e1d1-2e5618f9e8dmr2838945a91.26.1729263789470; Fri, 18 Oct 2024
 08:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241018135112.3978130-2-caleb.connolly@linaro.org>
 <CAC_iWjKS+WkJxVszJjRXg9f-uz7=bgt+8z_cT81_s4H7F-XWeA@mail.gmail.com>
In-Reply-To: <CAC_iWjKS+WkJxVszJjRXg9f-uz7=bgt+8z_cT81_s4H7F-XWeA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 09:02:58 -0600
Message-ID: <CAFLszThN145vpZXY0V5qgqEYf-E4Zt2vMxMdDsH5EwnwizK=Tw@mail.gmail.com>
Subject: Re: [PATCH] lmb: notify when adjacent regions are added
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Fri, 18 Oct 2024 at 08:08, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Thanks Caleb,
>
> On Fri, 18 Oct 2024 at 16:53, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >
> > lmb_add_region() returns a positive integer if the added regions causes
> > existing regions to be coalesced. We still want to notify the EFI
> > subsystem about these added regions though, so adjust lmb_add() to only
> > bail on errors.
> >
> > This fixes EFI memory allocation on boards with adjacent memory banks as is the
> > case on several Qualcomm boards like the RB3 Gen 2.
> >
> > Fixes: 2f6191526a13 (lmb: notify of any changes to the LMB memory map)
> > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > ---
> > Cc: u-boot-qcom@groups.io
> > ---
> >  lib/lmb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 78fe2d4de7c6..7e90f178763b 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -486,9 +486,9 @@ long lmb_add(phys_addr_t base, phys_size_t size)
> >         long ret;
> >         struct alist *lmb_rgn_lst = &lmb.free_mem;
> >
> >         ret = lmb_add_region(lmb_rgn_lst, base, size);
> > -       if (ret)
> > +       if (ret < 0)
> >                 return ret;
> >
> >         if (lmb_should_notify(LMB_NONE))
> >                 return lmb_map_update_notify(base, size, MAP_OP_ADD);
> > --
> > 2.46.2
> >
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Is it possible to add a test for this case? It is a good idea to plug
a testing gap when fixing a bug.

Regards,
Simon
