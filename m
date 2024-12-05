Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B23FE77171
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 23:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D3989576;
	Fri,  6 Dec 2024 00:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zjowfdla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3E3389512; Thu,  5 Dec 2024 21:36:43 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C81689566
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 21:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d34030ebb2so1093238a12.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 12:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733431001; x=1734035801; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ErnfF7RWGVXMzxD4OMo+c92vkyV1dMgkv6BNzNEOBoc=;
 b=Zjowfdla/MQCO8YNEMfMNuwhUEpsWnvkRK4xxsgp+4Y2Keuax/nKp2yK6FWE0KYHIp
 +YOSJHq/+XVLn/XyYbXT32UVybazMYeyrMO16Y9Wl2WFU2NqlmWROUANeJXdoRxfnQK4
 pZ+L4sX3ktRSYrSdMwE2LnZqNbmPWuYRlVirfsV8N+REUxD6Kn/dGG2rptS2clhibNYm
 FFzFNO6oHjWRjAfoJPaomE1q5P09iulQq7H0rwxzhEsh9H3S04/QUZb2RxRE4CuLEq2R
 aG7LUjSPoeVHDN6CGzqP7WjZOuoc0NHyi3De/MGOfmpC4X3OKJh4e9y/aQZjBeQmxpSj
 QcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733431001; x=1734035801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ErnfF7RWGVXMzxD4OMo+c92vkyV1dMgkv6BNzNEOBoc=;
 b=fa34IA1fhtfjBbNIvtJziNJM+MmMtkOg1shq5WChewIAybEusF5pWeO6nn38Unx+OP
 0Ytm9Xffko2GgeMnUGiHY+lBo2aSGEzKBDIJ0eiugC0RsK6ANMRGWKSQKysgu+ITtLwH
 bPK73Xju4L3mEJLZ6cVVZVoG6C4S4+fKE4TgCcDZybBHz0XCdVjO/uPE1uWRNHS8LWa3
 3snDy1cAaxY/ujBJ76uz7qI/dbmeqNaHKS4f2R3bfUvns5BhuK3HIWXaCZqOshLz+Ohh
 mHlGwIc+ejXvuDZB3dyAvfZc69gti/ia+R48IvEQsD36bfBUnLe7cz/0OmEP1ggHqeUl
 9Y4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2hepDMnKh6nVBymKwY6j0MsH9du6aWP+j7zcnCroorqk9nPpD1gEKzmap71/Awnfb1FQTQaA=@lists.denx.de
X-Gm-Message-State: AOJu0YwNBogMcrqlDy85gSEiK30A8XyycFgFqNeLLzFVVD1RLHTSdxnW
 /Pbe5pEX6WahJ39/vJrcTdp6lHuqCqbyc7X2TYJ20IzhB+OkzFTpDXKMuchntfS7vWHcdcEvh0P
 Hs0D98uKcdYoYnQ2Tyh/1hiIsuJ0=
X-Gm-Gg: ASbGncubjacY3WeN9GZ2eeNUeWclamsJQZq44uM7w8e6G+I04DNM8bIp+RjhNDcgI1l
 mzXmTwisLk20+NCIdZJtz++QTD2igJho=
X-Google-Smtp-Source: AGHT+IGOEg1bcxanvSrWaA4zFrHEFmhdylAZcntVFvlZ8ltTXWNgpFA7ZtOF1rryzIs22LPJQzUy3eyJFIdwhzKMdBE=
X-Received: by 2002:a05:6402:3582:b0:5cf:c33c:34cf with SMTP id
 4fb4d7f45d1cf-5d3be691c10mr576117a12.15.1733431000498; Thu, 05 Dec 2024
 12:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
 <CAFLszTito2+-qgOc=7bc3i9WmBZZCcAVWSY5hoH0neGjTg6zEQ@mail.gmail.com>
 <CALeDE9MORdUY440JAgHNXdoqWfJy5V9bC=TK5U242QG4Lc1Ptg@mail.gmail.com>
 <20241203194847.GA4022002@bill-the-cat>
 <CAFLszTgZiJuWMKZg6q--LEp+58Exgs8P+KaeCBgqmTd+B=SNSA@mail.gmail.com>
In-Reply-To: <CAFLszTgZiJuWMKZg6q--LEp+58Exgs8P+KaeCBgqmTd+B=SNSA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 5 Dec 2024 20:36:29 +0000
Message-ID: <CALeDE9M1aZwVM40gbhMRWsvhKZXL=m1GOeLhDgzR5H2bTShFuw@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] led: Remove old status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, 
 Alison Wang <alison.wang@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>, 
 uboot-stm32@st-md-mailman.stormreply.com
X-Mailman-Approved-At: Fri, 06 Dec 2024 00:38:30 +0100
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

On Tue, 3 Dec 2024 at 19:51, Simon Glass <sjg@chromium.org> wrote:

> Hi Tom,
>
> On Tue, 3 Dec 2024 at 12:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Nov 07, 2024 at 07:33:51PM +0000, Peter Robinson wrote:
> > > Hi Simon,
> > >
> > > > On Tue, 5 Nov 2024 at 07:18, Peter Robinson <pbrobinson@gmail.com>
> wrote:
> > > > >
> > > > > On Sun, 3 Nov 2024 at 00:34, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > There has been an LED framework in U-Boot which uses driver
> model for
> > > > > > about 9 years now. Recent work is underway to improve it and
> provide
> > > > > > more features. It is probably a good time to drop the old code,
> which
> > > > > > is only used by 5 boards:
> > > > >
> > > > > I don't believe, from what I can tell, they are feature
> comparable, at
> > > > > the very least I have not been able to get the Pinephone working
> with
> > > > > this so as it stands I still don't think this patch set is ready
> yet.
> > > >
> > > > I don't have that hardware, nor the other 4, so cannot do anything
> > > > with this feedback.
> > >
> > > Don't you have any HW that has a LED on it that you can substitute to
> > > see what it does?
> > >
> > > > Can you please be clear what you are asking me to do?
> > >
> > > Either produce patches that work on the the pinephone, or docs I, or
> > > other developers, can use to implement the functionality.
> > >
> > > Currently on the Pinephone the green LED lights up in the TPL/SPL
> > > (very early before ATF) stage and is lit up right through the the
> > > various FW stages, with your patch set I get no LED what so ever.
> >
> > Please note that needing to confirm that we have equivalent
> > functionality between old and new frameworks (and
> > https://lore.kernel.org/all/20241110115054.2555-1-ansuelsmth@gmail.com/
> > might cover that) is why this series isn't ready for -next at this time.
>
> Yes, I'm not sure if Peter saw that, so I sent him the link.
>

I have seen it, I have not had the chance to dig out my pinephone to test
it again because I was traveling and had competing priorities on my time
(and I do this as a hobby).

But also I think we have a little time on this, the new functionality only
landed recently and we've had a LOT of deprecated functionality hang around
for a lot longer than that. I think we should get this right rather than
jam it through.

Peter
