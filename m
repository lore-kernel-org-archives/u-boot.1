Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2651CF9C58
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916E088AE7;
	Fri, 20 Sep 2024 17:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W8U1BSAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15EDD8885D; Fri, 20 Sep 2024 17:58:05 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1386888C6
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-710fe5c3b44so1266383a34.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726847881; x=1727452681; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRNbfQdYXgTH3PA9jdOHbxpP6up/QbaqOhjOwX4BPCM=;
 b=W8U1BSAUsDz6VOHmi9f2jl59teO4HUqqp1a2vlWpKc6U2Uiu3t5g/1UMKqkRV89CVO
 6rQeRax0hlquXLhS4skokwNfu44jyv/vDimty98ME9uhIr+jPtDAF7ial7eD7aRTVVdX
 nYSV0Yie+Roe/g1i8GDRK2CpvSeZsBat3Liso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726847881; x=1727452681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRNbfQdYXgTH3PA9jdOHbxpP6up/QbaqOhjOwX4BPCM=;
 b=eNVoiZnA3Jt+hw+9auuk9IseUk7V+1ujZXDvAv2QiDE2Ik2NDUgq4p0TBhr9KkkELg
 bv2nErkN9n/oIOENOCdFVnr/ss6hNeHiyR6A6VEby/SHOtCTSRruNLpHONXu9KjiS7bc
 Lqmo/wuu3GbkpFD88h6RtIPI01gJteVdxGSPEUkryMpNM2/qSF2dgY0CE5AD3ebBML5q
 YwFjLo3h41+iqHo9Jiv0SYQLniDKPXoKEAE/7NN9CHjrZtql56NnSHye8SwwTQQhCH5o
 X/GcEVLguDjv0hS6l2J3Y//Hd+pkh9GhSemXDHytPSYERYM41POVqPaKWTk/2g7Fbp5b
 jsSQ==
X-Gm-Message-State: AOJu0Ywr3uq4Vx2j9rRihjhwwfYPCDUyLgCXhSqpniuWmvI1BxpFSNb5
 Zh8XY3fHqCDiMBNsPPM1tXD0ndDhFKNhzUxM9emMG8N+lkFlLGynUVcMW05fPicrdtu9Zr2mF/r
 23a4W+22uaVsnO0NbTpR50479UmwG9ff2pUBV
X-Google-Smtp-Source: AGHT+IG5qRElCWQbaWC6alkVvj4FybmM1/AGyOXIXBTqjEXm7VyHj6R4SzvJoaUUpp213i75usP3yhk8ZmosafEX09I=
X-Received: by 2002:a05:6359:4c19:b0:1b8:6074:b4e with SMTP id
 e5c5f4694b2df-1bc975dc5afmr166593755d.9.1726847881687; Fri, 20 Sep 2024
 08:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-23-patrick.rudolph@9elements.com>
 <CAFLszTje9cRMsrQW9DsPZY1FTxZ8t=bU6z5mO_XxfEwTH6Pxpw@mail.gmail.com>
 <CALNFmy1aKyKA9QSA-Xgj2ji-4GL2JUYbuWD=nqW0i_eDrVyL_A@mail.gmail.com>
In-Reply-To: <CALNFmy1aKyKA9QSA-Xgj2ji-4GL2JUYbuWD=nqW0i_eDrVyL_A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 17:57:51 +0200
Message-ID: <CAFLszTijXqF0vvevE+1a8MgjKukeodvBSpCT3CFxqZ7odLB4rw@mail.gmail.com>
Subject: Re: [PATCH v4 22/35] drivers: misc: irq-uclass: Update
 irq_get_by_index
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 20 Sept 2024 at 09:56, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Thu, Sep 19, 2024 at 4:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Support reading the "interrupts" property from the devicetree in case
> > > the "interrupts-extended" property isn't found. As the "interrupts"
> > > property is commonly used, this allows to parse all existing FDT and
> > > makes irq_get_by_index() more useful.
> > >
> > > The "interrupts" property doesn't contain a phandle as "interrupts-ex=
tended"
> > > does, so implement a new method to locate the interrupt-parent called
> > > irq_get_interrupt_parent().
> > >
> > > TEST: Read the interrupts from the GIC node for ACPI MADT generation.
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > ---
> > >  arch/sandbox/dts/test.dts |  3 ++
> > >  drivers/misc/irq-uclass.c | 66 +++++++++++++++++++++++++++++++++++++=
+-
> > >  include/irq.h             | 14 +++++++++
> > >  test/dm/irq.c             | 15 +++++++++
> > >  4 files changed, 97 insertions(+), 1 deletion(-)
> >
> > Is this a new patch? I don't see a change log so I am wondering if I
> > already reviewed it?
> >
> It's a new patch. I had to extend irq_get_by_index() as it is used to
> parse the DT while
> generating MADT subtables solely from DT.

OK thanks

Reviewed-by: Simon Glass <sjg@chromium.org>
