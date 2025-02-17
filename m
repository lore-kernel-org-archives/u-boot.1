Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A396BC021AB
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CDCC80104;
	Mon, 17 Feb 2025 14:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aydPdxhm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3A480BAE; Mon, 17 Feb 2025 14:15:34 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 269E780017
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e0516e7a77so1691963a12.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739798131; x=1740402931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j+GrbSInF1OsddnWGXD7dyZtOWSAola46sCn/yxsVVg=;
 b=aydPdxhmOnOa47Q/eR/xK1ws69UNe/Mwv9/YO1csFWj1QAHCZeUtVXoaN+EOFse3cs
 5qs38S5l/DYqLxohg5urMwHjG/+8JDascAQ310gCNYDJKNRD/nkMPLY2vGbeaXHvNQaN
 RtfhIPH4BkRgwyDP+I/DlnsZPzB04K79Tok58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798131; x=1740402931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j+GrbSInF1OsddnWGXD7dyZtOWSAola46sCn/yxsVVg=;
 b=FoVvhVPR8o/7+naTbeKTRHfZh0t21XZBTyqGsqQeqog82pWFXKkq9nmZt2l9UnhMRt
 OlMes8myfgLkVHQG7g7Lyta5KXuEvVxH8T/8FG/VwPyvPTt9+Egfqn1D7Cr2b7On6r97
 VMb7wsqWD05H/Dqtf+5YrxGJN0+nmBfcnOGelYJ3lQ+HCsrMJJTx5jU94nZV9dS8vQdJ
 gkhx1xoXu33Cm7mojbK1lynyW07kxTUGEKuiaTSIn8C+GRNx9oUWxwU7hghwXiWY3qA2
 aUlyVfvUEmslhqY7RwuBGKlEhyWl7oFtkeCwgq5WW0jnTLTtvO7Y98/e/RtykOhSalLw
 H4WQ==
X-Gm-Message-State: AOJu0YxcBdM1r1h55uFMK1uIv/4iWUf6ObV1eqipiIP+ykafjH/aP8oO
 o+WKERBIyEIJtN4ExtkHGG18cs9fIWHlJHT9tVLmLxL2RanZXGDwd3SgJmLzx06aUursDaj1n9/
 ngBrWcFr+ZCS9e+Rq7FLE9CeZkac9QvJlHfzH
X-Gm-Gg: ASbGnct/Uia0UkRciboDrZNXmLb6M2TwTtES1q3B4Sbj3Utd4Z5TjsEdLI5MELX67jM
 cBN94LcABXaroKWZZ8pHYhSGaVw0dVdDMBpFkGriwlf3t/wMSS70y2+ooIfQAjik4HnVocrRtyA
 ==
X-Google-Smtp-Source: AGHT+IGTZ4wfo+m0ImWnZUIE5N9ZoUShBKKyhBxFxexoDvsIl0ESJlBmIJaexTHku9H/67ja6ztCKfrfJkn9DDJkjUY=
X-Received: by 2002:a17:907:72d2:b0:ab3:4c32:aa6c with SMTP id
 a640c23a62f3a-abb70aa62e0mr796539666b.20.1739798131490; Mon, 17 Feb 2025
 05:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
 <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
 <20250215182847.GW1233568@bill-the-cat>
 <CAFLszThDsf322WQ1GCSFNmj=41yhBhLEZisXEaSTyHYjzG6TmQ@mail.gmail.com>
 <20250216150123.GX1233568@bill-the-cat>
 <20250216154801.GZ1233568@bill-the-cat>
In-Reply-To: <20250216154801.GZ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 06:15:19 -0700
X-Gm-Features: AWEUYZn0f4QMUNX0e-nZaw8XskZiuO3JoZbLi9xcB5xn4Igqz4DeMAO9d9fcy1Y
Message-ID: <CAFLszTgRaF-CLO=YN+9Uk3x-WMCg0LjTs3kUoxCwvcGe4F44-A@mail.gmail.com>
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

On Sun, 16 Feb 2025 at 08:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 09:01:23AM -0600, Tom Rini wrote:
> > On Sun, Feb 16, 2025 at 07:10:31AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 15 Feb 2025 at 11:28, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 15, 2025 at 10:24:50AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
> > > > > > > > > > >
> > > > > > > > > > > > The logic of this has become too confusing.
> > > > > > > > > > > >
> > > > > > > > > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > > > > > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > > > > > > > > phases can then use that bloblist.
> > > > > > > > > > > >
> > > > > > > > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > > > > > > > >
> > > > > > > > > > > > Reverting this commit seems like a better starting point for getting
> > > > > > > > > > > > things working for all use-cases.
> > > > > > > > > > > >
> > > > > > > > > > > > Note: The work to tidy this up is apparently underway. For this series,
> > > > > > > > > > > > a revert is the easiest path.
> > > > > > > > > > > >
> > > > > > > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > > > > > > > > >
> > > > > > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > >
> > > > > > > > > > > >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> > > > > > > > > > > >  include/bloblist.h | 10 --------
> > > > > > > > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > We aren't reverting this change so if you plan to move this series out of
> > > > > > > > > > > your downstream fork you should start from that and stop posting it,
> > > > > > > > > > > that just leads to confusion.
> > > > > > > > > >
> > > > > > > > > > Who is 'we', and start from what?
> > > > > > > > >
> > > > > > > > > We, being the community, in here, the community mainline U-Boot project
> > > > > > > > > tree.
> > > > > > > > >
> > > > > > > > > > My goal with this series is to have something that actually boots on a
> > > > > > > > > > real board, so the bloblist changes are needed for that, particularly
> > > > > > > > > > as the 'vbe' board in the lab tests this on the hardware. I
> > > > > > > > > > deliberately put these two patches at the end of the series so you can
> > > > > > > > > > ignore them if you'd like.
> > > > > > > > > >
> > > > > > > > > > But for now, as I understand it, there are no users of standard
> > > > > > > > > > passage in tree, so actually it would be fine to apply them.
> > > > > > > > >
> > > > > > > > > And you can ignore all the feedback you like for your downstream fork,
> > > > > > > > > sure.
> > > > > > > > >
> > > > > > > > > Part of the feedback in this series already was "Yes, we can clean this
> > > > > > > > > up a bit more if bloblist will do its own thing instead".
> > > > > > > >
> > > > > > > > So I see that Raymond's patch is a significant rewrite of what is
> > > > > > > > there today, with multiple aims and changes. I would rather add my
> > > > > > > > revert and start from a cleaner place.
> > > > > > >
> > > > > > > Also, I forgot to mention that U-Boot doesn't seem to support the
> > > > > > > firmware handoff protocol in SPL? If so, could you point me to the
> > > > > > > code?
> > > > > >
> > > > > > Yes, you never implemented handoff between stages in U-Boot via
> > > > > > register. That's not a use case for the platforms that don't use U-Boot
> > > > > > for SPL.
> > > > >
> > > > > If you let me own bloblist, I'll own it, but for now I am staying away.
> > > >
> > > > Would you be working against mainline again, and not breaking standard
> > > > passage (as it's been split off) ?
> > >
> > > Sure. The only reason I have my tree is because (I feel that) parts of
> > > U-Boot have become no-go for me. So if you'd like me to maintain
> > > bloblist again, I would be delighted to do so.
> > >
> > > Steps I see:
> > > - Get my boards working again
> >
> > Already done. I'm waiting for Kever to pick up Jonas' small series that
> > brings back output prior to that statement from DM.
> >
> > > - Add standard passage from SPL->PPL
> >
> > By who? PPL (and xPL) already reads standard passage via register.
> >
> > > - Figure out what to do on x86 to also use standard passage
> >
> > Standard passage, or bloblist?
> >
> > > I'm not quite sure that BLOBLIST_FIXED can be removed, as it needs
> > > more thought. The phase that creates the bloblist initially needs to
> > > know where to put it.
> >
> > When a phase is running it already has to know what memory is available
> > right now or not, and can allocate as much of a list as it needs now.
> > Later phases can move/grow it.
>
> Actually, let me elaborate and then concede.
>
> What I think the best design for BLOBLIST would be is:
> - Uncouple "was I passed a bloblist" from "create a bloblist"
> - Only allow passing bloblist via register(s).
> - No bloblist contents can be globally mandatory until PPL.
>   - Platforms may declare something mandatory (ie very first phase shall
>     init certain clocks and hand that off to next stage) if necessary.
> - A bloblist *should* be dynamically allocated but that's not required.
>
> I believe this solves problems such as:
> - We don't need OF_BLOBLIST because if we were not passed a bloblist we
>   don't go and create one at a possibly inaccessible location.
> - With fixed locations discouraged we wouldn't be forcing ourselves to
>   choose between limited on-chip RAM or DRAM for everything prior to PPL
>   relocating it.
>
> With all that, if we untie standard passage from bloblist (and maybe we
> want to revisit that in a year or two), bloblist can do what it likes so
> long as standard passage isn't broken. And with it being uncoupled, it
> should not get broken. I'll stop trying to convince you of a better
> design.

If you can convince people to let me act as maintainer (with the final
say) for bloblist then I'm happy to do so and I can work towards the
design above.

I think we have the same end point, but perhaps disagree on whether it
all needs to be done at once. The only question I have is about the
'mandatory' stuff. I worry that this is an attempt to make it
impossible for U-Boot to use its own devicetree, even as an option. So
long as it isn't, fine.

My general issue with bloblist is that it has been broken for me for
over a year and it just takes too much energy to get changes in. The
OF_BLOBLIST thing was just the worst and I would rather not repeat it.
I just looked at your tree and there is no OF_BLOBLIST.

Regards,
Simon
