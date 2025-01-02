Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03798E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 15:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297288007D;
	Thu,  2 Jan 2025 16:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B30yico3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF17880196; Thu,  2 Jan 2025 16:25:31 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 107E18001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 16:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so15585186a91.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735831526; x=1736436326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gaIelP9iOUO2JBYa2tsAYY0sxQNpinfWE4SQvanPBR8=;
 b=B30yico3fZbwo3c7HAmAr2D5IB7nsYbfpG3fgOUOppLYOwve9L44/Sid74N/qilPXd
 lbKHx2lBoXfwfnOFLOKfU+nNOZj3uckdEhgDoq0XUjkd9TgLcfIuWiCgX3J9mZC2QrRi
 qhNGlTMMDLbX3X5Nnx46oUkihPZLcISOIfjg2gmrjEjW5IyTMrxALxx9yeC6Hf5zEu0+
 Qi3ZuqGQ9jvtPHVrku050l9mApBKCQ6WglFg3J+nFYwP3oxovZy39sBKnykvIVn6yn6h
 RjqP8jOyaz539ShCTJF0EtxLMxkTFu7tZqkmGRuhHGZD4woIMzZGzCjX9OX3LFY/Xtpo
 619Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735831526; x=1736436326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gaIelP9iOUO2JBYa2tsAYY0sxQNpinfWE4SQvanPBR8=;
 b=AIW7DzCVDBVzvv9VIsoopO6fvUyi6DbTcafm5PMqz1HYLZWbldFpn6gZJKzf4pCCKC
 lJoHIh9Nlx9h8ygpYr9Zc8uc7xCbw+A7Yb4RGO/5ioGR11HixNIV+fY82Xc6xtqdgPfp
 83mTe71kWAC8tb7OctaRGIvoMIm4zlFvFD9lf0s/XAex4K7ixqoj//rV5algwMS3O1qy
 lMcfsxyEZetMiFLvogpsX1yd7cAQb4N+uFxfUz2ggAZj2xzI5rOrrfKPv3MsHsvO4Bmz
 HsEE3t5PSfrsGfGXj1pK/AuXLjqQmOPBQoWEcDSCF0sWi9iPwbOnuIjZ7R+VIYO4iOJ3
 Tnyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP6v3f8NzcvLZ3d12/X/RKfh3AibYqHg61Q07Lre0SW7/0reGoC7R5suTtqQlc6m1ZOOUcEmk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp8rZHF5LnDjhX6+5EsWIgiYaZzyb/n/sEq/D8QNJgL7QnldKi
 4V+al7ZCjFtbpi6ycSPGuCI2yZcTXTeqWYK4RVZseT36Q1Jbl8ccvDDjub+4Hzm3HBW2F+G83RC
 eOEij2Fk8yBsK4eJrQp90R3Dm/ykUjn1IJyeZKw==
X-Gm-Gg: ASbGncv43ZS5ZUYiBKFMdsSw7tM6zoSxI3ZDtEsppbQgqVlz5hNsSIWSCciHOk9Uiup
 xF2BFCPH82Myg9iMlUZxslibkAZFS2o3Z1Esedjmaj+aaxQcOzWJvxqdVeurwlLQeau0E1lE=
X-Google-Smtp-Source: AGHT+IFCRoMkBOz4D5zxkPGqPXrSebmI4Z9n7VPytG/yKYdV9RSc8YKxTYpIncfyvxefWtF6cvmUvwb1YCd8LYS/16s=
X-Received: by 2002:a17:90b:2dc3:b0:2ee:b2be:f398 with SMTP id
 98e67ed59e1d1-2f452dfd095mr64460750a91.2.1735831526418; Thu, 02 Jan 2025
 07:25:26 -0800 (PST)
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
 <CAFLszThG6SY-BvZQ_FzZ+AT+w0NSVmS_iS+nvCWaqoxVRvv6dg@mail.gmail.com>
In-Reply-To: <CAFLszThG6SY-BvZQ_FzZ+AT+w0NSVmS_iS+nvCWaqoxVRvv6dg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 2 Jan 2025 10:25:15 -0500
Message-ID: <CAEfUkUJhuCB-5dXt1+FKMAk1t_N_sO6qAZHMK5NJrV7coGH6MA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Wed, 1 Jan 2025 at 17:15, Simon Glass <sjg@chromium.org> wrote:

> Hi Tom,
>
> On Fri, 20 Dec 2024 at 05:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 19, 2024 at 10:37:37AM -0500, Raymond Mao wrote:
> > > Hi Simon,
> > >
> > > On Thu, 19 Dec 2024 at 10:08, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > > Hi,
> > > >
> > > > On Mon, 16 Dec 2024 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 16, 2024 at 10:37:30AM -0700, Simon Glass wrote:
> > > > > > Hi Raymond,
> > > > > >
> > > > > > On Mon, 16 Dec 2024 at 10:24, Raymond Mao <
> raymond.mao@linaro.org>
> > > > wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org>
> wrote:
> > > > > > >>
> > > > > > >> Hi Raymond,
> > > > > > >>
> > > > > > >> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <
> raymond.mao@linaro.org>
> > > > wrote:
> > > > > > >> >
> > > > > > >> > Hi Simon,
> > > > > > >> >
> > > > > > >> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org
> >
> > > > wrote:
> > > > > > >> >>
> > > > > > >> >> Hi Raymond,
> > > > > > >> >>
> > > > > > >> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <
> > > > raymond.mao@linaro.org> wrote:
> > > > > > >> >> >
> > > > > > >> >> > Hi Simon,
> > > > > > >> >> >
> > > > > > >> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <
> sjg@chromium.org>
> > > > wrote:
> > > > > > >> >> >>
> > > > > > >> >> >> Hi Raymond,
> > > > > > >> >> >>
> > > > > > >> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <
> > > > raymond.mao@linaro.org> wrote:
> > > > > > >> >> >> >
> > > > > > >> >> >> > Get tpm event log from bloblist instead of FDT when
> > > > bloblist is
> > > > > > >> >> >> > enabled and valid from previous boot stage.
> > > > > > >> >> >> >
> > > > > > >> >> >> > Note:
> > > > > > >> >> >> > This patch depends on:
> > > > > > >> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE
> options
> > > > > > >> >> >> >
> > > >
> https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
> > > > > > >> >> >> >
> > > > > > >> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > > >> >> >> > ---
> > > > > > >> >> >> >  lib/tpm_tcg2.c | 7 +++++++
> > > > > > >> >> >> >  1 file changed, 7 insertions(+)
> > > > > > >> >> >> >
> > > > > > >> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > > > > > >> >> >> > index 7f868cc883..acaf0acb88 100644
> > > > > > >> >> >> > --- a/lib/tpm_tcg2.c
> > > > > > >> >> >> > +++ b/lib/tpm_tcg2.c
> > > > > > >> >> >> > @@ -19,6 +19,7 @@
> > > > > > >> >> >> >  #include <linux/unaligned/generic.h>
> > > > > > >> >> >> >  #include <linux/unaligned/le_byteshift.h>
> > > > > > >> >> >> >  #include "tpm-utils.h"
> > > > > > >> >> >> > +#include <bloblist.h>
> > > > > > >> >> >> >
> > > > > > >> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32
> > > > *supported_pcr, u32 *active_pcr,
> > > > > > >> >> >> >                       u32 *pcr_banks)
> > > > > > >> >> >> > @@ -672,6 +673,12 @@ __weak int
> > > > tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
> > > > > > >> >> >> >         *addr = NULL;
> > > > > > >> >> >> >         *size = 0;
> > > > > > >> >> >> >
> > > > > > >> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> > > > !bloblist_maybe_init()) {
> > > > > > >> >> >>
> > > > > > >> >> >> Please drop the second term...the bloblist is inited by
> > > > U-Boot already.
> > > > > > >> >> >>
> > > > > > >> >> >
> > > > > > >> >> > As an independent library, from the tpm library's angle,
> > > > whether the bloblist init was already called or not is agnostic.
> > > > > > >> >> > I think this is the purpose of the "maybe" function.
> > > > > > >> >>
> > > > > > >> >> No. U-Boot does init at the start. We don't want each
> subsystem
> > > > > > >> >> 'maybe' initing each other subsystem that it uses. If you
> want to
> > > > > > >> >> check whether bloblist is available, you can use the GD
> flag.
> > > > > > >> >>
> > > > > > >> >
> > > > > > >> > OK. I can use the gd instead.
> > > > > > >> >
> > > > > > >> >>
> > > > > > >> >> >
> > > > > > >> >> >>
> > > > > > >> >> >> Also please drop the first term. If you find it in the
> > > > bloblist, just use it.
> > > > > > >> >> >>
> > > > > > >> >> >
> > > > > > >> >> > I think here we should have the same logic as the
> existing one
> > > > in fdtdec:
> > > > > > >> >> > If bloblist is not enabled or errors observed, do a
> fallback
> > > > to the original process.
> > > > > > >> >> > At least I want to keep the same logic in different
> places
> > > > before everything is ready from TF-A to U-boot.
> > > > > > >> >>
> > > > > > >> >> Yes, your second line is right. But PRIOR_STAGE doesn't
> exist,
> > > > nor
> > > > > > >> >> should it. Nor do you need it, since you can just check the
> > > > bloblist
> > > > > > >> >> for what you want. If you don't find it, fall back.
> > > > > > >> >>
> > > > > > >> >
> > > > > > >> > Since Firmware Handoff is still an experimental feature and
> not
> > > > mandatory yet (at least now),
> > > > > > >> > I put everything under PRIOR_STAGE to allow users to
> disable it
> > > > by their own decisions.
> > > > > > >> > I saw PRIOR_STAGE in one of Tom's recent patches so I have
> added
> > > > a dependency claim in my commit message.
> > > > > > >>
> > > > > > >> Yes, but even if Tom does pick his patch, which I object to,
> by the
> > > > > > >> time your code is called, there will be a bloblist.
> > > > > > >>
> > > > > > >> So the end result of your test is to allow the user to ignore
> any
> > > > TPM
> > > > > > >> log in the bloblist. If that's what you want (which seems
> fine to
> > > > me),
> > > > > > >> add a Kconfig for it.
> > > > > > >>
> > > > > > >
> > > > > > > Per my understanding of PRIOR_STAGE, it means we have a
> bloblist
> > > > from the previous stage and we want to use it (as a Transfer List).
> > > > > > > If this is the case, it is not for DT only but can be applied
> for
> > > > eventlog or anything for Firmware Handoff in the future.
> > > > > > > That is the reason I use PRIOR_STAGE here, I don't think we
> need to
> > > > add another kconfig.
> > > > > >
> > > > > > Who knows what it is supposed to mean...anyway, it should not be
> used
> > > > > > like that. The devicetree is special in that we want to get it
> from
> > > > > > the bloblist very early, if available. Nothing else (so far) in
> the
> > > > > > bloblist has this constraint, certainly not the TPM log.
> > > > >
> > > > > Raymond is exactly right, and the device tree is not special.
> > > >
> > > > That is quite wrong IMO. Devicetree is special because we need it
> > > > early and it might come from bloblist before the bloblist has been
> set
> > > > up by U-Boot. It also controls the whole operation of U-Boot. There
> is
> > > > nothing else in U-Boot quite like the devicetree.
> > > >
> > > > > The
> > > > > specialness is "do we have a valid bloblist upon entry or not".
> Which
> > > > > means that also no, this series (since it happens late enough)
> shouldn't
> > > > > care about if the previous stage had created it or not, merely as
> you
> > > > > said if the tag for the TPM (or other blob) is found.
> > > >
> > > > I would feel more comfortable having the discussions about what
> > > > previous stages need to pass U-Boot a bloblist once we have that
> > > > situation. This particular patch seems clear enough, and well
> > > > motivated. It just needs to drop the conditions.
> > > >
> > > I think we still need a condition here indicating that the kconfig of
> > > "handoff via bloblist" is enabled.
> > > And this "handoff via bloblist" kconfig should mean to handoff
> everything
> > > via bloblist, including DT.
>
> No, I don't agree with that at all.
>
> What actually breaks if you look for the TPM log in the bloblist?
> Please answer this question.
>
>
As I said, we need an kconfig here to decide whether a user should look for
TPM log (and all other handoff information defined by the Firmware Handoff
specification) from the bloblist or not.
We don't have such kconfig now.


> >
> > There's at least two sets of challenges here. One, being solved by
> > vexpress64 right now, is that we didn't have CONFIG_BLOBLIST_PASSAGE as
> > an actual option. And in that case, there's no U-Boot before full U-Boot
> > and the bloblist exists for us. Two, U-Boot is what is creating the
> > bloblist. The contentious parts are *when* it's created and *where* it
> > resides prior to full U-Boot seeing it.
>
> There isn't contention, so far as I am aware. The normal case is that
> U-Boot creates and uses the bloblist itself. Pre-U-Boot blobs (like
> TF-A, sadly) are not the normal case and should be discouraged in an
> open-source project. That doesn't mean we shouldn't support them, but
> it is the tail wagging the dog.
>
> TBH, I am confused with this statement which means we should not use the
bloblist library from the beginning to hand over data from the previous
stage.
If U-Boot bloblist only intends to consume the data created by itself, we
have to introduce another library to do the handoff, like what was done in
TF-A and OP-TEE -
then finally we can have a standard handoff library that can be used in all
projects and keep bloblist as it was.

[snip]

Regards,
Raymond
