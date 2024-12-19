Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7025EE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A918022B;
	Thu, 19 Dec 2024 16:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q7GKXilg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF848022B; Thu, 19 Dec 2024 16:37:53 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20F78021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7feffe7cdb7so531018a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622669; x=1735227469; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OfyKa4RZioc+FIYT8SDd6c+cEoQk/1sNSsEeW6wLWac=;
 b=Q7GKXilgRJMhjOCAtgeY4Kd/BPB1aRN+KwYWkXDpem+ilNBsba4R7Wrw6lKsiE+jUe
 69rTyF0cU3MhaF40pc+Fli0qO8J2GErpHJsvBgC8IqZGrDHaUhmUcTgylw2Sr3TYVDf8
 sCwNrdppJ/3iHuoY6ajybzvZ5SqpttQElXuqwjT49Emz4IRJTvqGbvJqR4my0eyiHMUI
 tg4+PnhrL/PbdrRP/3m4XgUeFhFG1jNv7kf8Ku+OYTm98qtdRTO0gWSB8FcQmX55jGR4
 UGAFVLOWyAPh/PrPSNTyeFBV9A2SipCCg9RZqVraL1xHT/WzBeV7G2miigAqMAl9pJDW
 eamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622669; x=1735227469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OfyKa4RZioc+FIYT8SDd6c+cEoQk/1sNSsEeW6wLWac=;
 b=w7HZ1SQqu3X404UCo9UeTB7+6wBr6bwl8mdRqIgBOXhlie0oq9GMSuVGGTtjpYgWl6
 ZXfhYkdSGJsfUiN2FCNZNdX0e8aYMPujKAyAeatC6vau9TuY8j/3kvgDUu4RKg9lp/Ch
 61CjxiX+iS36UEoM/EiKTAFglc9qE2H35HLkDP25PHgmEZf4EcrVSOPtF2zjHevd4LqK
 lHCCFBmk4aM6PcX7NmI4Ou03vlGIuyNnbe35Wmwhk05GhfwaImsc/B8aagclmGHqxVHn
 5/TJqMcRKTNnYojJK/d4zJ0Y8a+UmWzn84rU+T2n24XzgSl6268KwjhlCuWx+mo6sZWf
 Thbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXskXYfkNhIXmQaRWZfj8wh1AM8Ps0p/i7gJvRF57+6oPOpWU117FptYaXHK/0HvkZ9SSEQlTk=@lists.denx.de
X-Gm-Message-State: AOJu0YyhL/E5hDSa8y8T3qH6dfMBMdprrHweVUhRLuLn7bU65ykfkLr2
 vDyFwDHBrYenRA/dO+KBFQLdsiybJGuUhlsigGs9iyLKQHXnyXawUlQqQOvZ6TJZqJEdqztjbpw
 ZeB2XgkjPvgYn8+b8n/d9/mmaTRpyvQctXDUVEg==
X-Gm-Gg: ASbGncvsPkgi9+VmsZo4Co66Xa2z8PzR64DhDKUCVbrMYeSIB5vudKZJSXyxBl2NPlP
 9er8g8x0uPNfAOYXRKZbNu6xhA7Qn5LcSoAWJU/S/s4u3/FcaP4YZOQ/2mlTk+nTiul08o8w=
X-Google-Smtp-Source: AGHT+IGvfj4OjOJvMZhoUemy8MfOBOxnD8KBY7ZqNdSAYYnNGPyhEFgXS2KVrvD1eaguGDXMB5AGqnidSAnnSgS1M3E=
X-Received: by 2002:a17:90b:514b:b0:2ee:b2fe:eeeb with SMTP id
 98e67ed59e1d1-2f2e9303936mr8769905a91.22.1734622668937; Thu, 19 Dec 2024
 07:37:48 -0800 (PST)
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
 <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
In-Reply-To: <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 19 Dec 2024 10:37:37 -0500
Message-ID: <CAEfUkUJsdH=YjcN4V8Fe8Vfa2Sdb4PQJZxKe6y9RaRXcJgX_=Q@mail.gmail.com>
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

On Thu, 19 Dec 2024 at 10:08, Simon Glass <sjg@chromium.org> wrote:

> Hi,
>
> On Mon, 16 Dec 2024 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 16, 2024 at 10:37:30AM -0700, Simon Glass wrote:
> > > Hi Raymond,
> > >
> > > On Mon, 16 Dec 2024 at 10:24, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org> wrote:
> > > >>
> > > >> Hi Raymond,
> > > >>
> > > >> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> > > >> >
> > > >> > Hi Simon,
> > > >> >
> > > >> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org>
> wrote:
> > > >> >>
> > > >> >> Hi Raymond,
> > > >> >>
> > > >> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <
> raymond.mao@linaro.org> wrote:
> > > >> >> >
> > > >> >> > Hi Simon,
> > > >> >> >
> > > >> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org>
> wrote:
> > > >> >> >>
> > > >> >> >> Hi Raymond,
> > > >> >> >>
> > > >> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <
> raymond.mao@linaro.org> wrote:
> > > >> >> >> >
> > > >> >> >> > Get tpm event log from bloblist instead of FDT when
> bloblist is
> > > >> >> >> > enabled and valid from previous boot stage.
> > > >> >> >> >
> > > >> >> >> > Note:
> > > >> >> >> > This patch depends on:
> > > >> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> > > >> >> >> >
> https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
> > > >> >> >> >
> > > >> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > >> >> >> > ---
> > > >> >> >> >  lib/tpm_tcg2.c | 7 +++++++
> > > >> >> >> >  1 file changed, 7 insertions(+)
> > > >> >> >> >
> > > >> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > > >> >> >> > index 7f868cc883..acaf0acb88 100644
> > > >> >> >> > --- a/lib/tpm_tcg2.c
> > > >> >> >> > +++ b/lib/tpm_tcg2.c
> > > >> >> >> > @@ -19,6 +19,7 @@
> > > >> >> >> >  #include <linux/unaligned/generic.h>
> > > >> >> >> >  #include <linux/unaligned/le_byteshift.h>
> > > >> >> >> >  #include "tpm-utils.h"
> > > >> >> >> > +#include <bloblist.h>
> > > >> >> >> >
> > > >> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32
> *supported_pcr, u32 *active_pcr,
> > > >> >> >> >                       u32 *pcr_banks)
> > > >> >> >> > @@ -672,6 +673,12 @@ __weak int
> tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
> > > >> >> >> >         *addr = NULL;
> > > >> >> >> >         *size = 0;
> > > >> >> >> >
> > > >> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> !bloblist_maybe_init()) {
> > > >> >> >>
> > > >> >> >> Please drop the second term...the bloblist is inited by
> U-Boot already.
> > > >> >> >>
> > > >> >> >
> > > >> >> > As an independent library, from the tpm library's angle,
> whether the bloblist init was already called or not is agnostic.
> > > >> >> > I think this is the purpose of the "maybe" function.
> > > >> >>
> > > >> >> No. U-Boot does init at the start. We don't want each subsystem
> > > >> >> 'maybe' initing each other subsystem that it uses. If you want to
> > > >> >> check whether bloblist is available, you can use the GD flag.
> > > >> >>
> > > >> >
> > > >> > OK. I can use the gd instead.
> > > >> >
> > > >> >>
> > > >> >> >
> > > >> >> >>
> > > >> >> >> Also please drop the first term. If you find it in the
> bloblist, just use it.
> > > >> >> >>
> > > >> >> >
> > > >> >> > I think here we should have the same logic as the existing one
> in fdtdec:
> > > >> >> > If bloblist is not enabled or errors observed, do a fallback
> to the original process.
> > > >> >> > At least I want to keep the same logic in different places
> before everything is ready from TF-A to U-boot.
> > > >> >>
> > > >> >> Yes, your second line is right. But PRIOR_STAGE doesn't exist,
> nor
> > > >> >> should it. Nor do you need it, since you can just check the
> bloblist
> > > >> >> for what you want. If you don't find it, fall back.
> > > >> >>
> > > >> >
> > > >> > Since Firmware Handoff is still an experimental feature and not
> mandatory yet (at least now),
> > > >> > I put everything under PRIOR_STAGE to allow users to disable it
> by their own decisions.
> > > >> > I saw PRIOR_STAGE in one of Tom's recent patches so I have added
> a dependency claim in my commit message.
> > > >>
> > > >> Yes, but even if Tom does pick his patch, which I object to, by the
> > > >> time your code is called, there will be a bloblist.
> > > >>
> > > >> So the end result of your test is to allow the user to ignore any
> TPM
> > > >> log in the bloblist. If that's what you want (which seems fine to
> me),
> > > >> add a Kconfig for it.
> > > >>
> > > >
> > > > Per my understanding of PRIOR_STAGE, it means we have a bloblist
> from the previous stage and we want to use it (as a Transfer List).
> > > > If this is the case, it is not for DT only but can be applied for
> eventlog or anything for Firmware Handoff in the future.
> > > > That is the reason I use PRIOR_STAGE here, I don't think we need to
> add another kconfig.
> > >
> > > Who knows what it is supposed to mean...anyway, it should not be used
> > > like that. The devicetree is special in that we want to get it from
> > > the bloblist very early, if available. Nothing else (so far) in the
> > > bloblist has this constraint, certainly not the TPM log.
> >
> > Raymond is exactly right, and the device tree is not special.
>
> That is quite wrong IMO. Devicetree is special because we need it
> early and it might come from bloblist before the bloblist has been set
> up by U-Boot. It also controls the whole operation of U-Boot. There is
> nothing else in U-Boot quite like the devicetree.
>
> > The
> > specialness is "do we have a valid bloblist upon entry or not". Which
> > means that also no, this series (since it happens late enough) shouldn't
> > care about if the previous stage had created it or not, merely as you
> > said if the tag for the TPM (or other blob) is found.
>
> I would feel more comfortable having the discussions about what
> previous stages need to pass U-Boot a bloblist once we have that
> situation. This particular patch seems clear enough, and well
> motivated. It just needs to drop the conditions.
>
> I think we still need a condition here indicating that the kconfig of
"handoff via bloblist" is enabled.
And this "handoff via bloblist" kconfig should mean to handoff everything
via bloblist, including DT.


> >
> > And that said, yes, I will be v2'ing what I did, in some manner or
> > another as it's not quite right either in terms of being clear about
> > what the condition is.
>
> Regards,
> Simon
>

Raymond
