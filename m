Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6CDE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 01:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769B780381;
	Fri,  3 Jan 2025 02:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a77O6sa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788258036D; Fri,  3 Jan 2025 02:41:16 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F6680196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 02:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa692211331so2245085566b.1
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 17:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735868473; x=1736473273; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cejCCJoTFxeMy5y06Dc2SvxrRRQZD6rrEUVLdvAmBtg=;
 b=a77O6sa5FwmNoHWLzfB7scsSwn02azU1YDHa06A7iKuTLRko7ENZ1MnYcuTfqyeijS
 iUtCDjOU2i9jePjEyw7yFjmBk90vik8iPDW2qxX9h1Y7kgEJqexkjXoUYpSpgspahCNo
 FRP0E3cr5+uZF1yUnpInov4hPRdYdcnGI4cns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735868473; x=1736473273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cejCCJoTFxeMy5y06Dc2SvxrRRQZD6rrEUVLdvAmBtg=;
 b=XUdKC13fVtJbqJjGNWjXnXnvGZ/yowE5/DJO3AL3nTwL3lCeqCbkApCFmtylCj5DoY
 GiIreUu48IJ1cAXD6oXfCGmPbEqji1eMFjujnQcxme6ZPIlPobIgQ6v1qr0resq689tJ
 ls4cfSYYXPdV5M9+UViw2B/00mBTZpFHNbK2sXcfoaEQEb+qzCBwf8/avvAN+G2kKGyz
 ZOe5CDg1S2NI4/LlLiqwuV5b9zkbUuVnnFmLwcsZx3rs87p1bh7DKqEZfnGQtVJveY6/
 dQTuzb3db4WNdDM1x2HE5VQvSg7aZJLQPOe21rQj3aYvT/yUO1E6X9Znm0qFxE5dPWHZ
 ZObQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt0E8iEGwSSrf4024BqgDRUwljJV1VIxBZKKg+9HR4kX0LmjJ/IkbRMv5wIQMgyjI/JsToPvE=@lists.denx.de
X-Gm-Message-State: AOJu0YziC8B0mGFGz7DQiThGNuyC0Qjxrj+s9/nzaIpt4Ex6lqxF3Ewo
 pG/lD0sf52LpbxE86lvXwzrWCR7hwbwYUqLBdM/qbuvOVyBmMaMkyUaJmITg6IPBEpd9gYkK41y
 Ry1DP5rVk0WOtJEe9O/Bu3GQb+sKjmU08XEUe
X-Gm-Gg: ASbGnctYxhDqYwWW178CBT/mWni1r8ygYflyjPDTVJHW2sz0BlRo4VSuHHi4geoqAtD
 zEtVwxLsAJudci56TzfsiMbrwuUKEPYPFizQ2Xjc/
X-Google-Smtp-Source: AGHT+IG0Mct4wpOTtL9tJmqykHuaV1OE1aLrcbH7wtD+cj4kNaZ5dYoLwSFxiBX0J92lbLT3QZApMpkW1FjctDKOtZc=
X-Received: by 2002:a17:907:9691:b0:aac:333:a0a1 with SMTP id
 a640c23a62f3a-aac349d3092mr3745656666b.32.1735868473159; Thu, 02 Jan 2025
 17:41:13 -0800 (PST)
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
 <CAEfUkUJhuCB-5dXt1+FKMAk1t_N_sO6qAZHMK5NJrV7coGH6MA@mail.gmail.com>
In-Reply-To: <CAEfUkUJhuCB-5dXt1+FKMAk1t_N_sO6qAZHMK5NJrV7coGH6MA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Jan 2025 14:41:03 +1300
Message-ID: <CAFLszTiDXFm5bg8Gge+RoD8HXz-bV_t5R3hDTtvvzaRfhWs6ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
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

Hi Raymond, Tom,

On Fri, 3 Jan 2025 at 04:25, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 1 Jan 2025 at 17:15, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Tom,
>>
>> On Fri, 20 Dec 2024 at 05:36, Tom Rini <trini@konsulko.com> wrote:
>> >
>> > On Thu, Dec 19, 2024 at 10:37:37AM -0500, Raymond Mao wrote:
>> > > Hi Simon,
>> > >
>> > > On Thu, 19 Dec 2024 at 10:08, Simon Glass <sjg@chromium.org> wrote:
>> > >
>> > > > Hi,
>> > > >
>> > > > On Mon, 16 Dec 2024 at 11:30, Tom Rini <trini@konsulko.com> wrote:
>> > > > >
>> > > > > On Mon, Dec 16, 2024 at 10:37:30AM -0700, Simon Glass wrote:
>> > > > > > Hi Raymond,
>> > > > > >
>> > > > > > On Mon, 16 Dec 2024 at 10:24, Raymond Mao <raymond.mao@linaro.org>
>> > > > wrote:
>> > > > > > >
>> > > > > > > Hi Simon,
>> > > > > > >
>> > > > > > > On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org> wrote:
>> > > > > > >>
>> > > > > > >> Hi Raymond,
>> > > > > > >>
>> > > > > > >> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <raymond.mao@linaro.org>
>> > > > wrote:
>> > > > > > >> >
>> > > > > > >> > Hi Simon,
>> > > > > > >> >
>> > > > > > >> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org>
>> > > > wrote:
>> > > > > > >> >>
>> > > > > > >> >> Hi Raymond,
>> > > > > > >> >>
>> > > > > > >> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <
>> > > > raymond.mao@linaro.org> wrote:
>> > > > > > >> >> >
>> > > > > > >> >> > Hi Simon,
>> > > > > > >> >> >
>> > > > > > >> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org>
>> > > > wrote:
>> > > > > > >> >> >>
>> > > > > > >> >> >> Hi Raymond,
>> > > > > > >> >> >>
>> > > > > > >> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <
>> > > > raymond.mao@linaro.org> wrote:
>> > > > > > >> >> >> >
>> > > > > > >> >> >> > Get tpm event log from bloblist instead of FDT when
>> > > > bloblist is
>> > > > > > >> >> >> > enabled and valid from previous boot stage.
>> > > > > > >> >> >> >
>> > > > > > >> >> >> > Note:
>> > > > > > >> >> >> > This patch depends on:
>> > > > > > >> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
>> > > > > > >> >> >> >
>> > > > https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
>> > > > > > >> >> >> >
>> > > > > > >> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > > > > > >> >> >> > ---
>> > > > > > >> >> >> >  lib/tpm_tcg2.c | 7 +++++++
>> > > > > > >> >> >> >  1 file changed, 7 insertions(+)
>> > > > > > >> >> >> >
>> > > > > > >> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
>> > > > > > >> >> >> > index 7f868cc883..acaf0acb88 100644
>> > > > > > >> >> >> > --- a/lib/tpm_tcg2.c
>> > > > > > >> >> >> > +++ b/lib/tpm_tcg2.c
>> > > > > > >> >> >> > @@ -19,6 +19,7 @@
>> > > > > > >> >> >> >  #include <linux/unaligned/generic.h>
>> > > > > > >> >> >> >  #include <linux/unaligned/le_byteshift.h>
>> > > > > > >> >> >> >  #include "tpm-utils.h"
>> > > > > > >> >> >> > +#include <bloblist.h>
>> > > > > > >> >> >> >
>> > > > > > >> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32
>> > > > *supported_pcr, u32 *active_pcr,
>> > > > > > >> >> >> >                       u32 *pcr_banks)
>> > > > > > >> >> >> > @@ -672,6 +673,12 @@ __weak int
>> > > > tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>> > > > > > >> >> >> >         *addr = NULL;
>> > > > > > >> >> >> >         *size = 0;
>> > > > > > >> >> >> >
>> > > > > > >> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
>> > > > !bloblist_maybe_init()) {
>> > > > > > >> >> >>
>> > > > > > >> >> >> Please drop the second term...the bloblist is inited by
>> > > > U-Boot already.
>> > > > > > >> >> >>
>> > > > > > >> >> >
>> > > > > > >> >> > As an independent library, from the tpm library's angle,
>> > > > whether the bloblist init was already called or not is agnostic.
>> > > > > > >> >> > I think this is the purpose of the "maybe" function.
>> > > > > > >> >>
>> > > > > > >> >> No. U-Boot does init at the start. We don't want each subsystem
>> > > > > > >> >> 'maybe' initing each other subsystem that it uses. If you want to
>> > > > > > >> >> check whether bloblist is available, you can use the GD flag.
>> > > > > > >> >>
>> > > > > > >> >
>> > > > > > >> > OK. I can use the gd instead.
>> > > > > > >> >
>> > > > > > >> >>
>> > > > > > >> >> >
>> > > > > > >> >> >>
>> > > > > > >> >> >> Also please drop the first term. If you find it in the
>> > > > bloblist, just use it.
>> > > > > > >> >> >>
>> > > > > > >> >> >
>> > > > > > >> >> > I think here we should have the same logic as the existing one
>> > > > in fdtdec:
>> > > > > > >> >> > If bloblist is not enabled or errors observed, do a fallback
>> > > > to the original process.
>> > > > > > >> >> > At least I want to keep the same logic in different places
>> > > > before everything is ready from TF-A to U-boot.
>> > > > > > >> >>
>> > > > > > >> >> Yes, your second line is right. But PRIOR_STAGE doesn't exist,
>> > > > nor
>> > > > > > >> >> should it. Nor do you need it, since you can just check the
>> > > > bloblist
>> > > > > > >> >> for what you want. If you don't find it, fall back.
>> > > > > > >> >>
>> > > > > > >> >
>> > > > > > >> > Since Firmware Handoff is still an experimental feature and not
>> > > > mandatory yet (at least now),
>> > > > > > >> > I put everything under PRIOR_STAGE to allow users to disable it
>> > > > by their own decisions.
>> > > > > > >> > I saw PRIOR_STAGE in one of Tom's recent patches so I have added
>> > > > a dependency claim in my commit message.
>> > > > > > >>
>> > > > > > >> Yes, but even if Tom does pick his patch, which I object to, by the
>> > > > > > >> time your code is called, there will be a bloblist.
>> > > > > > >>
>> > > > > > >> So the end result of your test is to allow the user to ignore any
>> > > > TPM
>> > > > > > >> log in the bloblist. If that's what you want (which seems fine to
>> > > > me),
>> > > > > > >> add a Kconfig for it.
>> > > > > > >>
>> > > > > > >
>> > > > > > > Per my understanding of PRIOR_STAGE, it means we have a bloblist
>> > > > from the previous stage and we want to use it (as a Transfer List).
>> > > > > > > If this is the case, it is not for DT only but can be applied for
>> > > > eventlog or anything for Firmware Handoff in the future.
>> > > > > > > That is the reason I use PRIOR_STAGE here, I don't think we need to
>> > > > add another kconfig.
>> > > > > >
>> > > > > > Who knows what it is supposed to mean...anyway, it should not be used
>> > > > > > like that. The devicetree is special in that we want to get it from
>> > > > > > the bloblist very early, if available. Nothing else (so far) in the
>> > > > > > bloblist has this constraint, certainly not the TPM log.
>> > > > >
>> > > > > Raymond is exactly right, and the device tree is not special.
>> > > >
>> > > > That is quite wrong IMO. Devicetree is special because we need it
>> > > > early and it might come from bloblist before the bloblist has been set
>> > > > up by U-Boot. It also controls the whole operation of U-Boot. There is
>> > > > nothing else in U-Boot quite like the devicetree.
>> > > >
>> > > > > The
>> > > > > specialness is "do we have a valid bloblist upon entry or not". Which
>> > > > > means that also no, this series (since it happens late enough) shouldn't
>> > > > > care about if the previous stage had created it or not, merely as you
>> > > > > said if the tag for the TPM (or other blob) is found.
>> > > >
>> > > > I would feel more comfortable having the discussions about what
>> > > > previous stages need to pass U-Boot a bloblist once we have that
>> > > > situation. This particular patch seems clear enough, and well
>> > > > motivated. It just needs to drop the conditions.
>> > > >
>> > > I think we still need a condition here indicating that the kconfig of
>> > > "handoff via bloblist" is enabled.
>> > > And this "handoff via bloblist" kconfig should mean to handoff everything
>> > > via bloblist, including DT.
>>
>> No, I don't agree with that at all.
>>
>> What actually breaks if you look for the TPM log in the bloblist?
>> Please answer this question.
>>
>
> As I said, we need an kconfig here to decide whether a user should look for TPM log (and all other handoff information defined by the Firmware Handoff specification) from the bloblist or not.
> We don't have such kconfig now.

That wasn't my question, though. If you look for the log and it isn't
there, what breaks? Why do we need a Kconfig flag for that? In the
case of devicetree we need it because we can't (yet, without further
patches) look at the bloblist before it has been created. But what is
wrong with just creating a new TPM log if there isn't already one in
the bloblist, for example? Really just saying that I am trying to
understand the use case.

>
>>
>> >
>> > There's at least two sets of challenges here. One, being solved by
>> > vexpress64 right now, is that we didn't have CONFIG_BLOBLIST_PASSAGE as
>> > an actual option. And in that case, there's no U-Boot before full U-Boot
>> > and the bloblist exists for us. Two, U-Boot is what is creating the
>> > bloblist. The contentious parts are *when* it's created and *where* it
>> > resides prior to full U-Boot seeing it.
>>
>> There isn't contention, so far as I am aware. The normal case is that
>> U-Boot creates and uses the bloblist itself. Pre-U-Boot blobs (like
>> TF-A, sadly) are not the normal case and should be discouraged in an
>> open-source project. That doesn't mean we shouldn't support them, but
>> it is the tail wagging the dog.
>>
> TBH, I am confused with this statement which means we should not use the bloblist library from the beginning to hand over data from the previous stage.
> If U-Boot bloblist only intends to consume the data created by itself, we have to introduce another library to do the handoff, like what was done in TF-A and OP-TEE -
> then finally we can have a standard handoff library that can be used in all projects and keep bloblist as it was.

I am confused by your response, TBH. Where did I say that 'we should
not use the bloblist library from the beginning to hand over data from
the previous stage'? Just to be clear, we *should* use the bloblist
library from the beginning to hand over data from the previous stage.

My comment was entirely directed to making it easy for open source
projects to work together, and U-Boot to work with different phases of
itself. If we are adding convoluted hooks to U-Boot to deal with a
blob, we should be careful. E.g. adding Kconfig options.

I'm going to bow out of this conversation as I don't have anything
further to add. What Tom says below seems right to me.

Regards,
SImon
