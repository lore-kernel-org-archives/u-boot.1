Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194C1CF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65028927F;
	Thu, 19 Sep 2024 16:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i0yqhBWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41638927D; Thu, 19 Sep 2024 16:14:27 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6888891B3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7198de684a7so620398b3a.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755264; x=1727360064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IQlCDOE8CN89Irbt1tKwKYGG49FHAjXUnA3S/UarS0w=;
 b=i0yqhBWFjmHk6uaXBB0bsEg2YcN04t353AztWuvprRaksb/Ubp4I9R7DJxgjRq72gT
 K4d0TivbvuaSF6QpMIjFKMqTThcoRn62baWcHbi0vV/sEQdflfIQiHTXwfBYX1c9mxEy
 D8LKeBbJIHgAp49YIqJ3pKlWbSQaSWHE94r5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755264; x=1727360064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IQlCDOE8CN89Irbt1tKwKYGG49FHAjXUnA3S/UarS0w=;
 b=B0giuzgPVrGrI5Px0lOc3wl10bXTKlafO6RXQ5TRXIA+dSaBEDbYOmZHjwOuvMCdUs
 /TmPSjizmZqqF9hUenfVB6fjSiKC8lamgjUseem17MVJt2Uk9/qGi+HkLsyKxk6UNe65
 UcR/0G6LtRwkPrbb/pv7W1DdNzkzEu5VSbUS7oGUrBhSpm6dcmLFZwsBk/qvsKjN34L4
 nvDT+PDdo7ngpy0aJBWkidwMWyGNPEreZ5owwbLUsVO0xAFemxer0bgZqCekwbrPxGpT
 iCGend55ubftB1PtnE+Ymi8JNLoPsWq8M2XdCDTkML9CcjLjLVg8ITNsbmHoL1rnsini
 vX1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaSP4gqirJ/j47SdXTZ/25dqO8lYNhffd+K9MGYfIANmr9YkLhga0XpYQru7Cl9kw+1GVNlKM=@lists.denx.de
X-Gm-Message-State: AOJu0YySUBihFRgMyg5pd13rSM6o1ZZeWp/+vZ0i6tptbl0PknsLTXUV
 Oca+N/FXP2GrLyRyMQtJKNYAZLlosiSBVreOWscXvYIoH3RLZ0+/KsRekeZAODcuh5Wv2yThfeo
 lvEivIrnznuYbOkl+3r3ZCP8WGBSTZ6Edcvsd
X-Google-Smtp-Source: AGHT+IEHmikCRT9YVMTnUQ0bk1TF9iw0Uy9+gwwbMnCk0/nh8wM5G8oONdrs2CVAy5l7RQyfvaHbpBwwbuYA4ohoJv4=
X-Received: by 2002:a05:6a20:8428:b0:1cf:ff65:3680 with SMTP id
 adf61e73a8af0-1cfff653b08mr41270727637.6.1726755264307; Thu, 19 Sep 2024
 07:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-11-sjg@chromium.org>
 <d421b72a-eb0a-4aa8-be6e-3825c8b08da6@gmx.de>
 <CAFLszTjRSoWr0uncOdMY=6Oc4dnLP7gH2hj0BgDF67ukQEmmdw@mail.gmail.com>
 <20240916163319.GG4252@bill-the-cat>
 <CAFLszTgVi7nzE2AxBb_u73r+dSWny_geSpXmNKG8NR1SQWhXJQ@mail.gmail.com>
 <20240917165958.GM4252@bill-the-cat>
In-Reply-To: <20240917165958.GM4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:14:00 +0200
Message-ID: <CAFLszTjoA-=wSh2qbqHHnhp9taHoVXzamiCNFDFdMvYY7K7j2A@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] efi_loader: Disable ANSI output for tests
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Tue, 17 Sept 2024 at 19:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 17, 2024 at 05:54:36AM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 16 Sept 2024 at 18:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Sep 16, 2024 at 05:42:12PM +0200, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Thu, 12 Sept 2024 at 08:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > On 02.09.24 03:18, Simon Glass wrote:
> > > > > > We don't want ANSI characters written in tests since it is a pain to
> > > > > > check the output with ut_assert_nextline() et al.
> > > > > >
> > > > > > Provide a way to tests to request that ANSI characters not be sent.
> > > > > >
> > > > > > Add a proper function comment while we are here, to encourage others.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > >
> > > > > This patch was already NAKed in the last version.
> > > > >
> > > > > Please, adjust the test framework if you need filtering.
> > > >
> > > > In what way should it be adjusted? I hope you are not suggesting that
> > > > sandbox should try to filter out ANSI characters in its assertions?
> > >
> > > Well, perhaps the pytest framework should be filtering it out? And
> > > again and to be clear, I can't reliably run these tests on _hardware_
> > > because of the ANSI characters tripping things up, this is not a
> > > "sandbox" problem.
> >
> > Honestly, this approach (creating a problem and then dealing with it
> > downstream) is just not the way things should be.
>
> I don't follow, sorry.

I'm not sure I do either. I thought you were saying that the ANSI
characters should be generated and then some other feature should
filter them out, so that tests can pass.

My point then was that it doesn't make any sense to generate something
which causes a problem...just fix the issue at its source and don't
generate the characters.

>
> > As an alternative, I can send a patch to remove the code which blindly
> > sends commands to a terminal which may or may not be there. That would
> > be more correct than what we have today. We can then discuss how to
> > add ANSI back, with due thought to its downstream impact.
>
> I admit I only get as far as "Oh, selftest failed and look at all that
> escape sequence and such in the log" which I take as pytest choked on
> the output. Maybe we have different issues?
>
> > It's not great that  this discussion is still happening on a v5 patch.
> > There has been plenty of opportunity to provide an alternative option.
> > I doubt any exists.
>
> Well, it's _also_ true that people have been providing feedback earlier
> in the series and requesting changes and I don't know if it's missed
> because you were dropped from the list again or buried in your inbox or
> what. But you repost and don't drop / change patches that there's not
> yet agreement on.

I do seem to miss emails every now and then, as I regularly get
dropped from the list and have to re-subscribe.

But in this case the suggestion to add filtering does not make any
sense, so I have rejected it. The solution I have here is the best
approach I can think of.

Regards,
Simon
