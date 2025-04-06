Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AE0C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 22:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6394882C13;
	Mon,  7 Apr 2025 00:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bb/DlPg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D312482C4C; Mon,  7 Apr 2025 00:06:26 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92CA182B8E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 00:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac297cbe017so907526566b.0
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743977184; x=1744581984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=psS+dVYhQg08P2rPyHsTavf39AuwSoh/WFoLzSErmnA=;
 b=Bb/DlPg4tbsTXoe4SRFzIFHRXX+/wQ5vfiNm4FPg6zGihqM2I1XLo9obCEhmOHwdoD
 1XAwRFmcR8npumkt6emwDsUtdkuOXMZdiv+w3x8zykQVGf1MoAWMS9gIwVwTrZQeIMK9
 YWY8DKAitYqtUMFuotnJU34D+lK648OBSdAQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743977184; x=1744581984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=psS+dVYhQg08P2rPyHsTavf39AuwSoh/WFoLzSErmnA=;
 b=gI0y2gKvwNxQ6gSAQ3TgYY1bOl1Q0ZnUoWqsovCAigMw95orUguNDsGDNKycVNrc5P
 3ffuKL0Zix5j7jpT1yP+c2HZLS9U4mTgKB1cUJW+/IJXy3O+K5qq2IIZCBGnLI7rIvVy
 ECELWTERG0sl0a9ecU5TiUfALzAo+yYw8atNgPh1Ec3qhsE9VcRzHEgmBy6ExK0d0G1w
 o5dqKL8qsJ3cFI/bHQFvgTS38Nt51Wr6pyJbWNZ8qSQD5cc9kHNsI1YhAHDxDTO7oeax
 rh4RVYo06wcdCzIyLi6spZF2pDmOr5K0r0j4UoSEtx84SqNmuod9aH1EVLShVBR+BVid
 56VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRm/jd8okCDOQyqTL0S0WqiBlkK7BNGyk2NNaQXO20nivotCvuRtDIVVciugc/DpBltY6kYwM=@lists.denx.de
X-Gm-Message-State: AOJu0YxvZF298WhznX0m2HJv4Pvaslg6Ai+Koki59OsjqXXIyIwl/2nS
 A/PBpJFXxdFaNRPtvICPrgfuKxGxh22sATMUoKKHx/efo3Uw0d7GaKt8ALv0isuaEZSSSH9z1bQ
 rW6cSHWemLe99AxaRYbddbPjM0NfWpXjv2Xpr
X-Gm-Gg: ASbGncujqccPi8OEalCF9ir0l0UsvFYznPKCkcxDa+LuVMhULRRjLh1quCmr2jyDim+
 gUfsXAc5dRe2Hfuoc8gW8nrGVkobs5g8FmFjZMREzFuRGv+JX1r5/PNcutK+lyfLb90RX53LHWq
 znxkHdDMbN+IOhDNHiXoXbWm+ijQ==
X-Google-Smtp-Source: AGHT+IGOlFade5veZnPgy+rIJqvSLDllR/AXtAHA30P8P4GqqIY499pqPRI55PvFRNZ0JE31kiTmMduaOyr2MIYJXB0=
X-Received: by 2002:a17:907:97d6:b0:ac0:4364:4083 with SMTP id
 a640c23a62f3a-ac7d29743fbmr926987366b.0.1743977183742; Sun, 06 Apr 2025
 15:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
 <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
 <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
 <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
 <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
 <CAFLszTjGn1JGdpNAZVL6CC+pQLsOrG6gjmo8kRzjbnR_=6CMvw@mail.gmail.com>
 <20250403215239.GO5495@bill-the-cat>
 <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
 <20250403225058.GQ5495@bill-the-cat>
 <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
 <20250404175710.GU5495@bill-the-cat>
In-Reply-To: <20250404175710.GU5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 10:06:07 +1200
X-Gm-Features: ATxdqUExIZIYw3fTLmlPYDBHyWt4ym4brPx5uoosY_08ApzSUNZqO5Kh90tqo7o
Message-ID: <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
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

On Sat, 5 Apr 2025 at 06:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Glass wrote:
> > > > > > Hi Raymond,
> > > > > >
> > > > > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Raymond,
> > > > > > > >
> > > > > > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Raymond,
> > > > > > > > > >
> > > > > > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Simon,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > > > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > > > > >
> > > > > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > > > > > > > >
> > > > > > > > > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> > > > > > > > > > > mandatorily use bloblist to hand over everything between boot stages
> > > > > > > > > > > including fdt, creating OF_BLOBLIST is not necessary.
> > > > > > > > > >
> > > > > > > > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates that
> > > > > > > > > > there must be a bloblist, not that it must contain a devicetree. So I
> > > > > > > > > > wasn't sure about removing it.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MANDATORY is
> > > > > > > > > selected, we can override any fdt from board or env with the one from
> > > > > > > > > the bloblist.
> > > > > > > >
> > > > > > > > Yes, but we should be explicit about what is going on here. With
> > > > > > > > OF_BLOBLIST we indicate that the devicetree is coming from the
> > > > > > > > bloblist. It becomes one of the sources for devicetree, like
> > > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > > >
> > > > > > >
> > > > > > > BLOBLIST_PASSAGE_MANDATORY indicates the fdt from bloblist will be
> > > > > > > mandatorily used and override other fdt sources like from the board or
> > > > > > > env variables.
> > > > > >
> > > > > > So long as you are OK with OF_BLOBLIST as well, I have no objection to
> > > > > > keeping BLOBLIST_PASSAGE_MANDATORY, although I don't like the name
> > > > > > very much. But I can see why it is called that as my standard passage
> > > > > > series was actually never applied. So I suppose I'll need to have
> > > > > > another try at that.
> > > > > >
> > > > > > So to be clear, I want a separate option for devicetree, called
> > > > > > OF_BLOBLIST, which I can enable/disable as needed, without affecting
> > > > > > your option.
> > > > >
> > > > > Sigh. Can I ask what the use case for this will be? And we are going to
> > > > > get rid of BLOBLIST_FIXED at some point, yes?
> > > >
> > > > I thought we agreed that this was acceptable. We argued the toss for
> > > > months on this point and I would rather not revisit it.
> > > >
> > > > Yes, I will look at removing BLOBLIST_FIXED once this is in. I'm
> > > > pretty sure it can be done. The only tricky bit is coming up with a
> > > > bloblist protocol for x86.
> > >
> > > Yes, I'm stuck between being "flexible and saying yes" and how long we
> > > have to live with what I also think are bad designs.
> > >
> > > So maybe the pre-requisite here is that with "bloblist" and "standard
> > > passage" being divorced, what is the requirement for bloblist again?
> > > Because in practice, all of the problems we've had come down to looking
> > > in fixed address locations before they're valid. You want to handle this
> > > by saying "Ah, we won't look before it's valid with other CONFIG flags"
> > > and I say we should handle this by not using a fixed address to start
> > > with.
> > >
> > > If we have to add OF_BLOBLIST now and delete it in a few months, sigh,
> > > OK. But it shouldn't need to exist long term.
> >
> > For me, OF_BLOBLIST is needed for x86 devices which don't pass the
> > devicetree in the bloblist.
>
> I don't understand why that would become the case when it's not true
> today.

If you look at the top of fdtdec_setup() in your tree you can see the
special-case code related to TPL, that I'm wanting to get rid of.

Regards,
Simon
