Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D28EC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F44882D21;
	Thu, 17 Apr 2025 15:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uw/51PhD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 201AD82D32; Thu, 17 Apr 2025 15:14:50 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF96C81F7E
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-acb615228a4so104499266b.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744895687; x=1745500487; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xEgHnZxhh2i0u/3fITlTmIYNDQmreMA7l923ZimZvn8=;
 b=Uw/51PhDuRCF8AIl46jTJ1PCU8VwCM6jE3UWCvMgsG6LdfUy5QE+i1jm51tvKHZF6Z
 Zy5cn5hmrlSSfWZ5ZSIAQSNMz+A8BgHYC0EfhUbpXG+2nGywE7pjtPEKMx5hi9P6L71i
 rmE/6LjgsVh5ZG7CCzel9Of+5Q4NGLaa4t318=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895687; x=1745500487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xEgHnZxhh2i0u/3fITlTmIYNDQmreMA7l923ZimZvn8=;
 b=SHWTIuEX/3JFVPbANLQm7Qd2O4+UDxXf1YMnGwCrot/O+s6xfvUGCyoiUOkd4hUaCJ
 3zgQhiXEpVofzoQs0dj/J85O4N/II7AqN4LBQvHtBeVQTCWRlEpz3hFtb177f6UZvQaN
 J+etqKXLTZKOtQyFjkXE62G1FkxvPlezudUavJBCFVlWAym+A/Nv3swOAyfT70R+zJfX
 w+rWPNgZe556X1J0E/tIO/cZkvTLJvmmegn9NuXroFnGmjffQTDXHMLbmMnfLYJXGySS
 urZ3pkLvMvuIVJ9RJ2AOMF/yAyz+3Cxt0Sv8o+TLjTYmlayYTiXVqe8dl3KfEDS2lH+w
 qIUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyEE4BjQFABpE0vSmUnoqHpv32I3+y93r0kOAeANDnjhwC+WlKqjy5TJDVXYSHgzUagY1G32I=@lists.denx.de
X-Gm-Message-State: AOJu0YzPsWZ9GfUKNrJhSoPta9F5uhpnrRpUIrM43Aj9qB0KqwMiHRfN
 Y/TqlllMhZg1A2Hdfm3D1eyuKutgVTrYVw9yHDZPSNX7DShx25Dy8XiQ3KeHzcQnivwvMKu95nK
 PWZicDuZZChRTXl4VUVTE19aSEj66tWWH0mdd
X-Gm-Gg: ASbGncuvDNpa3MewiWlTZDD+n9ysjEzQdZ/vLzcrRJWWBSxm0+DfDzj4fYG+TswJYD2
 XBlm6v/uOrn+jDYcWZ9vx4yVFAAGf/KG7ZTTLOu4Q0u3IZec3sJiFzBD1SgMS/lUQrYM8VlrIUi
 0DSLhtG2H5IkTvzDAJszEZGd8=
X-Google-Smtp-Source: AGHT+IFB4RJbnThEmkDAMBG7iJyRHzXlNGut8QyqyYVrcL1qU5w1dUIm1eXdktbrIZg7SdSkiZW2OAzBUngJwhw2FOg=
X-Received: by 2002:a17:907:2d91:b0:ac7:b494:8c0c with SMTP id
 a640c23a62f3a-acb5a0e9110mr256215166b.16.1744895687168; Thu, 17 Apr 2025
 06:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250403215239.GO5495@bill-the-cat>
 <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
 <20250403225058.GQ5495@bill-the-cat>
 <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
 <20250404175710.GU5495@bill-the-cat>
 <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
 <20250406223854.GE5495@bill-the-cat>
 <CAFLszTjLugnmipzzCcAttyvZqQdohNV==jDj_mGzs2_1eFJw1w@mail.gmail.com>
 <20250407143056.GL5495@bill-the-cat>
 <CAFLszTjJekLH7Z3NMewpK1hYvMgXfrJ_0TknKhuZ0QRk3ZO3sg@mail.gmail.com>
 <20250414203444.GE5495@bill-the-cat>
In-Reply-To: <20250414203444.GE5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 07:14:35 -0600
X-Gm-Features: ATxdqUGGLIDY3pDPWHwM7Cr_WXDit0tSjVOVhrmd0fHKTdQpw3bjVs0owVS6cUs
Message-ID: <CAFLszTiP9T=j1AAUDcxQDCF=sN82mxsZiEG3h5MbRsNyAFwmgg@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
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

On Mon, 14 Apr 2025 at 14:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 14, 2025 at 01:34:10PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 7 Apr 2025 at 08:31, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Apr 07, 2025 at 12:35:15PM +1200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 7 Apr 2025 at 10:38, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Apr 07, 2025 at 10:06:07AM +1200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 5 Apr 2025 at 06:57, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Glass wrote:
> > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > > > > > > > > > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > > > > > > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > > > > > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > > > > > > > > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> > > > > > > > > > > > > > > > > mandatorily use bloblist to hand over everything between boot stages
> > > > > > > > > > > > > > > > > including fdt, creating OF_BLOBLIST is not necessary.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates that
> > > > > > > > > > > > > > > > there must be a bloblist, not that it must contain a devicetree. So I
> > > > > > > > > > > > > > > > wasn't sure about removing it.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MANDATORY is
> > > > > > > > > > > > > > > selected, we can override any fdt from board or env with the one from
> > > > > > > > > > > > > > > the bloblist.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, but we should be explicit about what is going on here. With
> > > > > > > > > > > > > > OF_BLOBLIST we indicate that the devicetree is coming from the
> > > > > > > > > > > > > > bloblist. It becomes one of the sources for devicetree, like
> > > > > > > > > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > BLOBLIST_PASSAGE_MANDATORY indicates the fdt from bloblist will be
> > > > > > > > > > > > > mandatorily used and override other fdt sources like from the board or
> > > > > > > > > > > > > env variables.
> > > > > > > > > > > >
> > > > > > > > > > > > So long as you are OK with OF_BLOBLIST as well, I have no objection to
> > > > > > > > > > > > keeping BLOBLIST_PASSAGE_MANDATORY, although I don't like the name
> > > > > > > > > > > > very much. But I can see why it is called that as my standard passage
> > > > > > > > > > > > series was actually never applied. So I suppose I'll need to have
> > > > > > > > > > > > another try at that.
> > > > > > > > > > > >
> > > > > > > > > > > > So to be clear, I want a separate option for devicetree, called
> > > > > > > > > > > > OF_BLOBLIST, which I can enable/disable as needed, without affecting
> > > > > > > > > > > > your option.
> > > > > > > > > > >
> > > > > > > > > > > Sigh. Can I ask what the use case for this will be? And we are going to
> > > > > > > > > > > get rid of BLOBLIST_FIXED at some point, yes?
> > > > > > > > > >
> > > > > > > > > > I thought we agreed that this was acceptable. We argued the toss for
> > > > > > > > > > months on this point and I would rather not revisit it.
> > > > > > > > > >
> > > > > > > > > > Yes, I will look at removing BLOBLIST_FIXED once this is in. I'm
> > > > > > > > > > pretty sure it can be done. The only tricky bit is coming up with a
> > > > > > > > > > bloblist protocol for x86.
> > > > > > > > >
> > > > > > > > > Yes, I'm stuck between being "flexible and saying yes" and how long we
> > > > > > > > > have to live with what I also think are bad designs.
> > > > > > > > >
> > > > > > > > > So maybe the pre-requisite here is that with "bloblist" and "standard
> > > > > > > > > passage" being divorced, what is the requirement for bloblist again?
> > > > > > > > > Because in practice, all of the problems we've had come down to looking
> > > > > > > > > in fixed address locations before they're valid. You want to handle this
> > > > > > > > > by saying "Ah, we won't look before it's valid with other CONFIG flags"
> > > > > > > > > and I say we should handle this by not using a fixed address to start
> > > > > > > > > with.
> > > > > > > > >
> > > > > > > > > If we have to add OF_BLOBLIST now and delete it in a few months, sigh,
> > > > > > > > > OK. But it shouldn't need to exist long term.
> > > > > > > >
> > > > > > > > For me, OF_BLOBLIST is needed for x86 devices which don't pass the
> > > > > > > > devicetree in the bloblist.
> > > > > > >
> > > > > > > I don't understand why that would become the case when it's not true
> > > > > > > today.
> > > > > >
> > > > > > If you look at the top obbfdtdec_setup() in your tree you can see the
> > > > > > special-case code related to TPL, that I'm wanting to get rid of.
> > > > >
> > > > > OK, but all of that too is for the case of a fixed bloblist being in
> > > > > uninitialized memory. Which is why I don't like BLOBLIST_FIXED and want
> > > > > to see passing of the bloblist from xPL -> PPL be implemented and so xPL
> > > > > can allocate a bloblist (or grow a passed one if needed).
> > > >
> > > > We are going around in circles though. Having it is registers doesn't
> > > > help with the problem that there isn't an FDT in the bloblist.
> > >
> > > Sure it does. If we're passed a bloblist in a register we can then see
> > > if it has a DT (and use it) or not (and move to the next DT location).
> > >
> > > > Also, I thought you decided that I could maintain bloblist. Have you
> > > > changed your mind?
> > >
> > > You just mis-understood me. Yes, you can maintain bloblist. But also,
> > > Yes, I need to understand what you're doing. The root of the OF_BLOBLIST
> > > problems is that no one understood you.
> >
> > No, that's not actually true. The problem is that no one would listen
> > and everyone was sure I was wrong.
>
> That's another way of saying "no one understood you", IMO.
>
> > I sent the series on the basis that you were open to my maintaining
> > bloblist in your tree. I didn't know there were extra conditions. So
> > please let me know which way you want to go on this.
>
> I thought we had made progress on the community call, but now you're
> sending this so I don't know?
>
> You need to:
> - Not break handoff spec. Raymond is telling you how to get a QEMU that
>   uses that now, and I'm actively waiting on Harrison Mutai to answer
>   one last question I had before adding vexpress_fvp to our CI. So this
>   should be a reasonable requirement.
> - You were going to add register passing of bloblist location for x86,
>   and then add register passing of bloblist between U-Boot phases
>   without relying on BLOBLIST_FiXED.
> - Some amount of un-tangling "do we have a bloblist" from "did we get a
>   bloblist" is needed, so we can just check "Did we get a bloblist? Y/N"
>   in lib/fdtdec.c::fdtdec_setup(). With that, we can add OF_BLOBLIST as
>   a choice with OF_SEPARATE / OF_EMBEDED and we can remove a bunch of
>   the logic at the top of lib/fdtdec.c::fdtdec_setup() too.

That seems very much like a list of instructions. So in fact you still
want to be the maintainer?

To be clear, I don't disagree with the list here but I am not willing
to argue with people anymore about how it should work. I designed it
and I know how it should work.

Also I think I now understand what you are saying about bloblist and
standard passage being split. It's because most of my standard passage
series from a few years back was never applied.

So I'd like to go back and revisit that and get it applied, including
the gitlab test for the new qemu_arm/64_spl

Regards,
Simon
