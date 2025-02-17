Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D74C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11ACE80DF7;
	Mon, 17 Feb 2025 14:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d48Mqm9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B3580EB1; Mon, 17 Feb 2025 14:16:29 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 851EF80CB0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso269773866b.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739798186; x=1740402986; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M4oXacGs+3slk6wE3/MemlE/H3NQ4zUrEUVHon5FkM0=;
 b=d48Mqm9BdC005Xx7Gpa5MhYS1JbW3a2s957JTg5d2f84IGW3KsUHuz3V46PwugMzlL
 QrAFVGzfknMAj5C+mIHsQybY1TXhMVJq/Niov14sN8YlujypFeg3JzHmcOJMlwhwYiZg
 B35hRmP2hQznF9M9EkwWtKJMmPlnBVyYgR69k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798186; x=1740402986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M4oXacGs+3slk6wE3/MemlE/H3NQ4zUrEUVHon5FkM0=;
 b=k77TzghdCRYl53JmVjk9U71FciyW2wp3udJADtprFHLfWmJh8nvazU9c+GBo5DuNBj
 kvPrdvU2mLxygekzRLYkNqwaJ57FZFC+IvrRW3M7N5m4bNGedFem2IL6XqmkG9C4x9+K
 OluA5nK0/rCWyw/EVNIHNye3kzDfOeRhtX/C31qQmsa2TjkaXulPd71nt4XBj2AYY19e
 lWUoVov3SEM06x2e1pWY8K2DVl/MgHtm8M/VkT2uM6Tbjd0QVXn7TvPcvHwgZu6UeYnC
 YIgwtJZo2bUOgRExzBlJ9UMIrQ6PW0XmW3tk/xrxKTY3LqcSR3ZZi7TK5HdMA1sUyqO2
 Qs/w==
X-Gm-Message-State: AOJu0YztXGptdSere/l9hIsbSMFWKbVFziPraCcjq8QJtiBs7y76+Qla
 H+ym0KMBkF4o3vY4XUn2aoa+m9+Rf25MUvkykyQdwVKneKeQ7eFLfsmS1+u37VyynAYpEF9xdK3
 iIrHFJeuuRQkU1pHlyH9yvaWC5HMvU05IfQE1
X-Gm-Gg: ASbGncuX+UWCiYVIDXpNexNNczVsIi1j2TEgEtlf33wMJVCEX7/bHoq4lm5D/uF12eO
 j16/Lv/fwG9irEh8d6OYz57wxs216MOPyN2A4byWIZirD9VkuuB3MLUc1juOAfyANiwfB423fWQ
 ==
X-Google-Smtp-Source: AGHT+IEZRiahJlANRtNYvkek0SsUrDt6uGTOiQRKvXrAb47bpBjFINnMf9zPwKepVivmhL0NrjOlPOKgKCUucYLvFl8=
X-Received: by 2002:a17:906:8a4c:b0:abb:b136:a42c with SMTP id
 a640c23a62f3a-abbb136a71dmr26317766b.4.1739798185828; Mon, 17 Feb 2025
 05:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
 <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
 <20250215182847.GW1233568@bill-the-cat>
 <CAFLszThDsf322WQ1GCSFNmj=41yhBhLEZisXEaSTyHYjzG6TmQ@mail.gmail.com>
 <20250216150123.GX1233568@bill-the-cat>
In-Reply-To: <20250216150123.GX1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 06:16:12 -0700
X-Gm-Features: AWEUYZnhwWDPhdVGXlWqtEqzbHSJLj-y4e5Lv1Dhttj2RRCtMso167s6OKyJZkQ
Message-ID: <CAFLszTjM0xXbHqAHHQa4E+8ojesbE+7jrGrw1-6s33NaFENEZA@mail.gmail.com>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
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

On Sun, 16 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 07:10:31AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 15 Feb 2025 at 11:28, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 15, 2025 at 10:24:50AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
> > > > > > > > > >
> > > > > > > > > > > The logic of this has become too confusing.
> > > > > > > > > > >
> > > > > > > > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > > > > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > > > > > > > phases can then use that bloblist.
> > > > > > > > > > >
> > > > > > > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > > > > > > >
> > > > > > > > > > > Reverting this commit seems like a better starting point for getting
> > > > > > > > > > > things working for all use-cases.
> > > > > > > > > > >
> > > > > > > > > > > Note: The work to tidy this up is apparently underway. For this series,
> > > > > > > > > > > a revert is the easiest path.
> > > > > > > > > > >
> > > > > > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > > > > > > > >
> > > > > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > (no changes since v1)
> > > > > > > > > > >
> > > > > > > > > > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > > > > > > > > > >  include/bloblist.h | 10 --------
> > > > > > > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > > > > > >
> > > > > > > > > > We aren't reverting this change so if you plan to move this series out of
> > > > > > > > > > your downstream fork you should start from that and stop posting it,
> > > > > > > > > > that just leads to confusion.
> > > > > > > > >
> > > > > > > > > Who is 'we', and start from what?
> > > > > > > >
> > > > > > > > We, being the community, in here, the community mainline U-Boot project
> > > > > > > > tree.
> > > > > > > >
> > > > > > > > > My goal with this series is to have something that actually boots on a
> > > > > > > > > real board, so the bloblist changes are needed for that, particularly
> > > > > > > > > as the 'vbe' board in the lab tests this on the hardware. I
> > > > > > > > > deliberately put these two patches at the end of the series so you can
> > > > > > > > > ignore them if you'd like.
> > > > > > > > >
> > > > > > > > > But for now, as I understand it, there are no users of standard
> > > > > > > > > passage in tree, so actually it would be fine to apply them.
> > > > > > > >
> > > > > > > > And you can ignore all the feedback you like for your downstream fork,
> > > > > > > > sure.
> > > > > > > >
> > > > > > > > Part of the feedback in this series already was "Yes, we can clean this
> > > > > > > > up a bit more if bloblist will do its own thing instead".
> > > > > > >
> > > > > > > So I see that Raymond's patch is a significant rewrite of what is
> > > > > > > there today, with multiple aims and changes. I would rather add my
> > > > > > > revert and start from a cleaner place.
> > > > > >
> > > > > > Also, I forgot to mention that U-Boot doesn't seem to support the
> > > > > > firmware handoff protocol in SPL? If so, could you point me to the
> > > > > > code?
> > > > >
> > > > > Yes, you never implemented handoff between stages in U-Boot via
> > > > > register. That's not a use case for the platforms that don't use U-Boot
> > > > > for SPL.
> > > >
> > > > If you let me own bloblist, I'll own it, but for now I am staying away.
> > >
> > > Would you be working against mainline again, and not breaking standard
> > > passage (as it's been split off) ?
> >
> > Sure. The only reason I have my tree is because (I feel that) parts of
> > U-Boot have become no-go for me. So if you'd like me to maintain
> > bloblist again, I would be delighted to do so.
> >
> > Steps I see:
> > - Get my boards working again
>
> Already done. I'm waiting for Kever to pick up Jonas' small series that
> brings back output prior to that statement from DM.

OK good.

>
> > - Add standard passage from SPL->PPL
>
> By who? PPL (and xPL) already reads standard passage via register.

I mean implement it in SPL, so it can create the info and pass it to PPL.

>
> > - Figure out what to do on x86 to also use standard passage
>
> Standard passage, or bloblist?

Well, bloblist today, but I hope we can come up with a standard
passage for x86 too.

>
> > I'm not quite sure that BLOBLIST_FIXED can be removed, as it needs
> > more thought. The phase that creates the bloblist initially needs to
> > know where to put it.
>
> When a phase is running it already has to know what memory is available
> right now or not, and can allocate as much of a list as it needs now.
> Later phases can move/grow it.

So you mean xPL should use malloc() / simple_malloc() rather than a
fixed address? Or are you suggesting doing something in
board_init_f_alloc_reserve()?

Regards,
Simon
