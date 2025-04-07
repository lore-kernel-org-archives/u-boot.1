Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23049C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D72830B6;
	Mon,  7 Apr 2025 22:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YGdafZ7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCCB8830E4; Mon,  7 Apr 2025 22:18:00 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 802DF830B3
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abf3d64849dso794281566b.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744057078; x=1744661878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wpOultbIVnrYu4XGTerOUmc2DdeESuOql581CghCyS8=;
 b=YGdafZ7AMwDHu9Rf+IbGZ7py5MQhqppx2aW8uqBn/m1qKCd2t3I//Y8nXj9zW1BBFh
 XufJhz+QegqTV/FD/VAL4CoKrR7ZRoz0XN/lVXPSVTo1Z9TbSDBsMtFDnSE/cCI0cFjO
 yNnoo+cFmAli4ofEK59mGmEH43mPDVWx5R0Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744057078; x=1744661878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wpOultbIVnrYu4XGTerOUmc2DdeESuOql581CghCyS8=;
 b=Zuta86yeoG7NNdJpOYWOXhwzbKa/0R+dM1YwlCiy1BdP3J7sY5EjJ5oILMwo3zZFvd
 46Z4DOXLR3vVwbLlzx1yWqlLWgskdKw1vTeNitfO44dMClQUshhJoE4o6QN5lF9FmrdS
 Zx2JOWHqmq62gTL4a09c90p0apgCmRW4yOnE6QtpuhzHQAF33VlTa9pVBaDmdfd9t2Jg
 miYKsgrD/Xo0vCS326CuvX9Vln2/ymLvGgD70KSFyYoCkQUi35sJfnbq/tFiNoWQy05Y
 w9zxcnkMwwaClJeOz54guTp3S4DRjqqmFrQrccUrIRtUaNN1hDsgy48Eaum+1F7/tQ+1
 umsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1kVj/zL07GnjzGW/XNLV7sr19TFjI3yNPLF0wCOPtltyT07ulC3yfat+a9mGT3cw/74q1Gac=@lists.denx.de
X-Gm-Message-State: AOJu0YwhYM4DY8n7mTNb0XnLXJQtCJafJ1Prih2xYPpR5h0wm2C0ymhS
 1T5aXO/jZL0vPuwfeEiLCMnTyis9QyfZzaKC0FgRXonC9mxc9glHXXqBlmjuHVgWhcbs36KcHt/
 iJmxwIw4K3V7Pa4sn0q31U1oDBn6wJ0GRCncJ
X-Gm-Gg: ASbGncvu9w4b2dkYds5uMy3CTHe7wWE2QshGybG7wHWULRqwqoA2mZl9MuPH6vXCbfA
 n7JyU0Odo6uXtS9T7k2IDXd6RITLFFTHgkCUiCbwhgX3aR47bRMtCcsVRtl+6AfFd0Fmcyd0Nsv
 mLtgSdpclB213eGk3snV+qcTjIiSw=
X-Google-Smtp-Source: AGHT+IF4xxbqcgsktFoLNlH4q/dlJ0xagAp/CWSw5jAc1I1OCQE1+nCDGpc3XTP3MKBqFO/B6ceUNBdF8H3SOwg4tsc=
X-Received: by 2002:a17:907:1ca7:b0:ac4:85b:f973 with SMTP id
 a640c23a62f3a-ac7d1819306mr1026424766b.34.1744057077627; Mon, 07 Apr 2025
 13:17:57 -0700 (PDT)
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
 <CAFLszThqjXZkoZxa7m+WLtSefnHk2zusJiO8re+bx2rYV4BWzA@mail.gmail.com>
 <20250407182235.GM5495@bill-the-cat>
In-Reply-To: <20250407182235.GM5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 14:17:46 -0600
X-Gm-Features: ATxdqUFaQuU93khaQTnpciTA5w9ziT86WGb9PeozyhPJ2AWnJ-P2Q0AMGTDQP08
Message-ID: <CAFLszTiWHTGoN68-eoh6MpHt8ywdXLJ7FbW-KtUstvijY-phnw@mail.gmail.com>
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

On Mon, 7 Apr 2025 at 12:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 07, 2025 at 09:24:16AM -0600, Simon Glass wrote:
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
> > Is there a call tomorrow, or is it next week?
>
> Tomorrow.

OK, do we have somewhere to add things to the agenda? I'd like to
spend some time answering your bloblist questions here.

Regards,
Simon
