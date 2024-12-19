Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45794E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19C18021D;
	Thu, 19 Dec 2024 16:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HQUigtQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F4A8033E; Thu, 19 Dec 2024 16:08:10 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC388021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa67f31a858so155445966b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734620888; x=1735225688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6AJtfmcJRy7XOvS68w0/kb8vGlwYnB5RlcGVpp6wEH4=;
 b=HQUigtQWevgLuCPdO9XED9hfolMoc9EFqEqUg9aaYB7nzjXmkjTWqOsPCAjXx1o8Yw
 06lWag78CLynaDng5rkKYGwNdcG137thgAONzQgLSL1Rspmag2j8+mnd0gJHdypqiF+X
 ozKjVhysSLDK2JEPCn3BNuPsqNCQnFGmtT2MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620888; x=1735225688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AJtfmcJRy7XOvS68w0/kb8vGlwYnB5RlcGVpp6wEH4=;
 b=CuQbYWcbOKbSPS17BqniMmCjRFlOpDvMmzzY7UYNJGFGlC5Rn3Nzd05olTEh6ElHdf
 HgcZzHLVgqrAs4skUux8i3+oo/4O+LEHQZYiyj0MFmFCQa0EH5EgVT46hY9HsQiBQ6Oj
 1nEpBE14lHtuuDBzpSedS1TW98rgNMp9VNvQg/O0OrtDCjZh5MZFon0/8og0suordzXC
 fHkfSdvQAsQRM1k+YjPP6+zImyqzCvmtqhK1QLW2FgzQC+V47+ptvecGpKcEgJZwjbkJ
 nw38K83H7b/VeS5/QPrEeWIjnABNisrbeBgJ74l9sZ4OZRD7oLX68pN5TF+XKNIAoSRr
 lpCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSYGM+IRIsxs9ck2qpaUHf6xb6jYdtwFlXic/s1Drbw/aWhdeAZKgeP4J5IR6Nc79HJeDXxao=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5Zk2YEDlFwVHQ49xE2MVBHYpZyavSsITv+23sWgzR8iq+gApu
 NQiTbMY11eZeHwZlzUUi0nEo8k8gieoUnTxnY8CAh7iWcqB1DpTTHYtfPsKv6bLM7eRuai/7zAj
 6Ae+Hvpv1ud6WYCUpCG7t9CA1JxmA3ndcwseO
X-Gm-Gg: ASbGnctFC2dP1UCdLsV9LXZrDQNHKCydfleQRm577pKh2MOUIRMiFI291MhDEuuiTqC
 3ree3Hwtn10CwWa8vFOSnEIhjXeZ48opNgtnljo8=
X-Google-Smtp-Source: AGHT+IF+x+nqLWIESqoyIlQJs7MqHhBYwRES0krQESApgaYV0OGNa2RJxOLaKZWFWCnbfKS8w89ThP6owyd2sLFQG6U=
X-Received: by 2002:a17:906:3116:b0:aab:eefd:4ceb with SMTP id
 a640c23a62f3a-aac078c01ddmr311520066b.10.1734620887468; Thu, 19 Dec 2024
 07:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
 <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
 <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
 <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
 <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
 <CAFLszTh4hjCHAoqkr+zdeBeq5rCoaO3aSjBVvFyCYVLoccPSUw@mail.gmail.com>
 <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
 <20241216183014.GH1505244@bill-the-cat>
In-Reply-To: <20241216183014.GH1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Dec 2024 08:07:55 -0700
Message-ID: <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
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

Hi,

On Mon, 16 Dec 2024 at 11:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 16, 2024 at 10:37:30AM -0700, Simon Glass wrote:
> > Hi Raymond,
> >
> > On Mon, 16 Dec 2024 at 10:24, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> Hi Raymond,
> > >>
> > >> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >> >
> > >> > Hi Simon,
> > >> >
> > >> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org> wrote:
> > >> >>
> > >> >> Hi Raymond,
> > >> >>
> > >> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >> >> >
> > >> >> > Hi Simon,
> > >> >> >
> > >> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org> wrote:
> > >> >> >>
> > >> >> >> Hi Raymond,
> > >> >> >>
> > >> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >> >> >> >
> > >> >> >> > Get tpm event log from bloblist instead of FDT when bloblist is
> > >> >> >> > enabled and valid from previous boot stage.
> > >> >> >> >
> > >> >> >> > Note:
> > >> >> >> > This patch depends on:
> > >> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> > >> >> >> > https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
> > >> >> >> >
> > >> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > >> >> >> > ---
> > >> >> >> >  lib/tpm_tcg2.c | 7 +++++++
> > >> >> >> >  1 file changed, 7 insertions(+)
> > >> >> >> >
> > >> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > >> >> >> > index 7f868cc883..acaf0acb88 100644
> > >> >> >> > --- a/lib/tpm_tcg2.c
> > >> >> >> > +++ b/lib/tpm_tcg2.c
> > >> >> >> > @@ -19,6 +19,7 @@
> > >> >> >> >  #include <linux/unaligned/generic.h>
> > >> >> >> >  #include <linux/unaligned/le_byteshift.h>
> > >> >> >> >  #include "tpm-utils.h"
> > >> >> >> > +#include <bloblist.h>
> > >> >> >> >
> > >> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
> > >> >> >> >                       u32 *pcr_banks)
> > >> >> >> > @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
> > >> >> >> >         *addr = NULL;
> > >> >> >> >         *size = 0;
> > >> >> >> >
> > >> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) && !bloblist_maybe_init()) {
> > >> >> >>
> > >> >> >> Please drop the second term...the bloblist is inited by U-Boot already.
> > >> >> >>
> > >> >> >
> > >> >> > As an independent library, from the tpm library's angle, whether the bloblist init was already called or not is agnostic.
> > >> >> > I think this is the purpose of the "maybe" function.
> > >> >>
> > >> >> No. U-Boot does init at the start. We don't want each subsystem
> > >> >> 'maybe' initing each other subsystem that it uses. If you want to
> > >> >> check whether bloblist is available, you can use the GD flag.
> > >> >>
> > >> >
> > >> > OK. I can use the gd instead.
> > >> >
> > >> >>
> > >> >> >
> > >> >> >>
> > >> >> >> Also please drop the first term. If you find it in the bloblist, just use it.
> > >> >> >>
> > >> >> >
> > >> >> > I think here we should have the same logic as the existing one in fdtdec:
> > >> >> > If bloblist is not enabled or errors observed, do a fallback to the original process.
> > >> >> > At least I want to keep the same logic in different places before everything is ready from TF-A to U-boot.
> > >> >>
> > >> >> Yes, your second line is right. But PRIOR_STAGE doesn't exist, nor
> > >> >> should it. Nor do you need it, since you can just check the bloblist
> > >> >> for what you want. If you don't find it, fall back.
> > >> >>
> > >> >
> > >> > Since Firmware Handoff is still an experimental feature and not mandatory yet (at least now),
> > >> > I put everything under PRIOR_STAGE to allow users to disable it by their own decisions.
> > >> > I saw PRIOR_STAGE in one of Tom's recent patches so I have added a dependency claim in my commit message.
> > >>
> > >> Yes, but even if Tom does pick his patch, which I object to, by the
> > >> time your code is called, there will be a bloblist.
> > >>
> > >> So the end result of your test is to allow the user to ignore any TPM
> > >> log in the bloblist. If that's what you want (which seems fine to me),
> > >> add a Kconfig for it.
> > >>
> > >
> > > Per my understanding of PRIOR_STAGE, it means we have a bloblist from the previous stage and we want to use it (as a Transfer List).
> > > If this is the case, it is not for DT only but can be applied for eventlog or anything for Firmware Handoff in the future.
> > > That is the reason I use PRIOR_STAGE here, I don't think we need to add another kconfig.
> >
> > Who knows what it is supposed to mean...anyway, it should not be used
> > like that. The devicetree is special in that we want to get it from
> > the bloblist very early, if available. Nothing else (so far) in the
> > bloblist has this constraint, certainly not the TPM log.
>
> Raymond is exactly right, and the device tree is not special.

That is quite wrong IMO. Devicetree is special because we need it
early and it might come from bloblist before the bloblist has been set
up by U-Boot. It also controls the whole operation of U-Boot. There is
nothing else in U-Boot quite like the devicetree.

> The
> specialness is "do we have a valid bloblist upon entry or not". Which
> means that also no, this series (since it happens late enough) shouldn't
> care about if the previous stage had created it or not, merely as you
> said if the tag for the TPM (or other blob) is found.

I would feel more comfortable having the discussions about what
previous stages need to pass U-Boot a bloblist once we have that
situation. This particular patch seems clear enough, and well
motivated. It just needs to drop the conditions.

>
> And that said, yes, I will be v2'ing what I did, in some manner or
> another as it's not quite right either in terms of being clear about
> what the condition is.

Regards,
Simon
