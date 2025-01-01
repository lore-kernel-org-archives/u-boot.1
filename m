Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204E3E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6BC880431;
	Wed,  1 Jan 2025 23:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="newCo5aD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF8780431; Wed,  1 Jan 2025 23:15:05 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD898066C
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa67333f7d2so1551324366b.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769701; x=1736374501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C6tve5HzExUwGp6xeXseS5Ak4biyWymHhvRqA+jSXx0=;
 b=newCo5aD1CzaoBX2s6WnhfNgsRuXOlm0ufDS3+tNf3m7MpvnBqNXWmcSP+a6XJnl6R
 uIoQQWkAhS9v9nR/e6hXZfacNHt1Eh2qVasu1L0dkFnwBxQtiT1D3IDEvvmihGE6uyg+
 T+Dx33p9o6xqxGLFIiOH+qOPo18Geyw2Igu84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769701; x=1736374501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C6tve5HzExUwGp6xeXseS5Ak4biyWymHhvRqA+jSXx0=;
 b=cOn4mFgU3amrUQN8WqCCWA39/bdaHq5/Pp2UJO+v9pzyF3tRVV/8df3xi6gelzRqM0
 WRf8boBItCECT2BL0rlptUwWjD0sgkQFevUwhnkgN/qsVMVJ3uTAVoZrcWRK3Ag8qqL0
 qO+85xklQFCejxPh+nt4rfzzl5aoyN7cYW5RNyK9vQltXGef9vreVHjKt1HENUQxZmaa
 5sExQlL1OuEq8c/V3Q33ovUu8hHnvsGGBKE5o+2dV8iwrHpHEjL4Sz82fVE46/Slgc9c
 yJwVfo0Rday+u/4TT38F2S6wF9D+FM0ViTNa/YmOeFxWCi+A7pIpYbtpQ/af/ub97XiJ
 hH2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc2b+qAYATDOCYutzPNDwFUqcoyVqo1r5c2DqkNxXp0D6SWZkr+8NReKy2TTpl3VeH9s9s29g=@lists.denx.de
X-Gm-Message-State: AOJu0YyCZlOS2OVKbGY3r5F/XD08ryaQclG2oT9NlSfeV/96cCWmfzMB
 K1soxs+DGSlDonUiq1I1O4Kugbn2hvmiJNu2COueousICfSkJMRybfMIRTzIEhLru1Vw5Td2Jml
 vFBG9DJUe2gMyH9LZExUxTnYFCd7hicmStJIO
X-Gm-Gg: ASbGncupdUJQIynDoM6TYNOJx3w9qF63b8c0+AGysdzc9glOPvMok+uruDLIpfzKdB9
 w6zB+7+sb9davcmV92KzWTu0I9n4wGUgIZ5nv7+gz
X-Google-Smtp-Source: AGHT+IEiDovzJ6ncKrhNvwYtANZHtAR+eJzvsU5w/oak9/3AsHXERJLlAGmzrWcqLPV7aZbEJmimPcPXnF5csYTBzkE=
X-Received: by 2002:a17:906:478f:b0:aa6:6c46:7ca1 with SMTP id
 a640c23a62f3a-aac27038e93mr3853590066b.10.1735769700654; Wed, 01 Jan 2025
 14:15:00 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
 <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
 <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
 <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
 <CAFLszTh4hjCHAoqkr+zdeBeq5rCoaO3aSjBVvFyCYVLoccPSUw@mail.gmail.com>
 <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
 <20241216183014.GH1505244@bill-the-cat>
 <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
 <CAEfUkUJsdH=YjcN4V8Fe8Vfa2Sdb4PQJZxKe6y9RaRXcJgX_=Q@mail.gmail.com>
 <20241219163604.GV1505244@bill-the-cat>
In-Reply-To: <20241219163604.GV1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jan 2025 11:14:51 +1300
Message-ID: <CAFLszThG6SY-BvZQ_FzZ+AT+w0NSVmS_iS+nvCWaqoxVRvv6dg@mail.gmail.com>
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

Hi Tom,

On Fri, 20 Dec 2024 at 05:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 19, 2024 at 10:37:37AM -0500, Raymond Mao wrote:
> > Hi Simon,
> >
> > On Thu, 19 Dec 2024 at 10:08, Simon Glass <sjg@chromium.org> wrote:
> >
> > > Hi,
> > >
> > > On Mon, 16 Dec 2024 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 16, 2024 at 10:37:30AM -0700, Simon Glass wrote:
> > > > > Hi Raymond,
> > > > >
> > > > > On Mon, 16 Dec 2024 at 10:24, Raymond Mao <raymond.mao@linaro.org>
> > > wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org> wrote:
> > > > > >>
> > > > > >> Hi Raymond,
> > > > > >>
> > > > > >> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <raymond.mao@linaro.org>
> > > wrote:
> > > > > >> >
> > > > > >> > Hi Simon,
> > > > > >> >
> > > > > >> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org>
> > > wrote:
> > > > > >> >>
> > > > > >> >> Hi Raymond,
> > > > > >> >>
> > > > > >> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <
> > > raymond.mao@linaro.org> wrote:
> > > > > >> >> >
> > > > > >> >> > Hi Simon,
> > > > > >> >> >
> > > > > >> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org>
> > > wrote:
> > > > > >> >> >>
> > > > > >> >> >> Hi Raymond,
> > > > > >> >> >>
> > > > > >> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <
> > > raymond.mao@linaro.org> wrote:
> > > > > >> >> >> >
> > > > > >> >> >> > Get tpm event log from bloblist instead of FDT when
> > > bloblist is
> > > > > >> >> >> > enabled and valid from previous boot stage.
> > > > > >> >> >> >
> > > > > >> >> >> > Note:
> > > > > >> >> >> > This patch depends on:
> > > > > >> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> > > > > >> >> >> >
> > > https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
> > > > > >> >> >> >
> > > > > >> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > >> >> >> > ---
> > > > > >> >> >> >  lib/tpm_tcg2.c | 7 +++++++
> > > > > >> >> >> >  1 file changed, 7 insertions(+)
> > > > > >> >> >> >
> > > > > >> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > > > > >> >> >> > index 7f868cc883..acaf0acb88 100644
> > > > > >> >> >> > --- a/lib/tpm_tcg2.c
> > > > > >> >> >> > +++ b/lib/tpm_tcg2.c
> > > > > >> >> >> > @@ -19,6 +19,7 @@
> > > > > >> >> >> >  #include <linux/unaligned/generic.h>
> > > > > >> >> >> >  #include <linux/unaligned/le_byteshift.h>
> > > > > >> >> >> >  #include "tpm-utils.h"
> > > > > >> >> >> > +#include <bloblist.h>
> > > > > >> >> >> >
> > > > > >> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32
> > > *supported_pcr, u32 *active_pcr,
> > > > > >> >> >> >                       u32 *pcr_banks)
> > > > > >> >> >> > @@ -672,6 +673,12 @@ __weak int
> > > tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
> > > > > >> >> >> >         *addr = NULL;
> > > > > >> >> >> >         *size = 0;
> > > > > >> >> >> >
> > > > > >> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> > > !bloblist_maybe_init()) {
> > > > > >> >> >>
> > > > > >> >> >> Please drop the second term...the bloblist is inited by
> > > U-Boot already.
> > > > > >> >> >>
> > > > > >> >> >
> > > > > >> >> > As an independent library, from the tpm library's angle,
> > > whether the bloblist init was already called or not is agnostic.
> > > > > >> >> > I think this is the purpose of the "maybe" function.
> > > > > >> >>
> > > > > >> >> No. U-Boot does init at the start. We don't want each subsystem
> > > > > >> >> 'maybe' initing each other subsystem that it uses. If you want to
> > > > > >> >> check whether bloblist is available, you can use the GD flag.
> > > > > >> >>
> > > > > >> >
> > > > > >> > OK. I can use the gd instead.
> > > > > >> >
> > > > > >> >>
> > > > > >> >> >
> > > > > >> >> >>
> > > > > >> >> >> Also please drop the first term. If you find it in the
> > > bloblist, just use it.
> > > > > >> >> >>
> > > > > >> >> >
> > > > > >> >> > I think here we should have the same logic as the existing one
> > > in fdtdec:
> > > > > >> >> > If bloblist is not enabled or errors observed, do a fallback
> > > to the original process.
> > > > > >> >> > At least I want to keep the same logic in different places
> > > before everything is ready from TF-A to U-boot.
> > > > > >> >>
> > > > > >> >> Yes, your second line is right. But PRIOR_STAGE doesn't exist,
> > > nor
> > > > > >> >> should it. Nor do you need it, since you can just check the
> > > bloblist
> > > > > >> >> for what you want. If you don't find it, fall back.
> > > > > >> >>
> > > > > >> >
> > > > > >> > Since Firmware Handoff is still an experimental feature and not
> > > mandatory yet (at least now),
> > > > > >> > I put everything under PRIOR_STAGE to allow users to disable it
> > > by their own decisions.
> > > > > >> > I saw PRIOR_STAGE in one of Tom's recent patches so I have added
> > > a dependency claim in my commit message.
> > > > > >>
> > > > > >> Yes, but even if Tom does pick his patch, which I object to, by the
> > > > > >> time your code is called, there will be a bloblist.
> > > > > >>
> > > > > >> So the end result of your test is to allow the user to ignore any
> > > TPM
> > > > > >> log in the bloblist. If that's what you want (which seems fine to
> > > me),
> > > > > >> add a Kconfig for it.
> > > > > >>
> > > > > >
> > > > > > Per my understanding of PRIOR_STAGE, it means we have a bloblist
> > > from the previous stage and we want to use it (as a Transfer List).
> > > > > > If this is the case, it is not for DT only but can be applied for
> > > eventlog or anything for Firmware Handoff in the future.
> > > > > > That is the reason I use PRIOR_STAGE here, I don't think we need to
> > > add another kconfig.
> > > > >
> > > > > Who knows what it is supposed to mean...anyway, it should not be used
> > > > > like that. The devicetree is special in that we want to get it from
> > > > > the bloblist very early, if available. Nothing else (so far) in the
> > > > > bloblist has this constraint, certainly not the TPM log.
> > > >
> > > > Raymond is exactly right, and the device tree is not special.
> > >
> > > That is quite wrong IMO. Devicetree is special because we need it
> > > early and it might come from bloblist before the bloblist has been set
> > > up by U-Boot. It also controls the whole operation of U-Boot. There is
> > > nothing else in U-Boot quite like the devicetree.
> > >
> > > > The
> > > > specialness is "do we have a valid bloblist upon entry or not". Which
> > > > means that also no, this series (since it happens late enough) shouldn't
> > > > care about if the previous stage had created it or not, merely as you
> > > > said if the tag for the TPM (or other blob) is found.
> > >
> > > I would feel more comfortable having the discussions about what
> > > previous stages need to pass U-Boot a bloblist once we have that
> > > situation. This particular patch seems clear enough, and well
> > > motivated. It just needs to drop the conditions.
> > >
> > I think we still need a condition here indicating that the kconfig of
> > "handoff via bloblist" is enabled.
> > And this "handoff via bloblist" kconfig should mean to handoff everything
> > via bloblist, including DT.

No, I don't agree with that at all.

What actually breaks if you look for the TPM log in the bloblist?
Please answer this question.

>
> There's at least two sets of challenges here. One, being solved by
> vexpress64 right now, is that we didn't have CONFIG_BLOBLIST_PASSAGE as
> an actual option. And in that case, there's no U-Boot before full U-Boot
> and the bloblist exists for us. Two, U-Boot is what is creating the
> bloblist. The contentious parts are *when* it's created and *where* it
> resides prior to full U-Boot seeing it.

There isn't contention, so far as I am aware. The normal case is that
U-Boot creates and uses the bloblist itself. Pre-U-Boot blobs (like
TF-A, sadly) are not the normal case and should be discouraged in an
open-source project. That doesn't mean we shouldn't support them, but
it is the tail wagging the dog.

>
> In both cases, full U-Boot will copy the bloblist to where it likes.
>
> And this is separate from "bloblist has device tree or we hang()".

Yes, well that has been the case in mainline for over a year with
several of my boards, so it is a bit late to start worrying about it
now. I have OF_BLOBLIST and it works fine.

Regards,
Simon
