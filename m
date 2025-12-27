Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B519E92710
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 20:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE4C83B32;
	Sat, 27 Dec 2025 21:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jmFcuAyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CCA483BFE; Sat, 27 Dec 2025 21:30:17 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B54183990
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 21:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3f0ec55ce57so5610952fac.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 12:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766867413; x=1767472213; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QWly5hZadWabptuiIFDCUBjOgCOGPOBm8D/rncbu4Pk=;
 b=jmFcuAyVOFesaDih44OHrTg0Txor3qCL5Pd/K7Gs1DSgwCav2IxlpvKfa9kah7BBB2
 3vSkPJNUd7asmay9VMxfOpvpmGoH6YEOG7UrwYriX5pA3UxDK4exAhdIv20qo/H456ss
 b1kEk6xjsDq2Fo6jf6WbEU0iYHskyBbZQok7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766867413; x=1767472213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWly5hZadWabptuiIFDCUBjOgCOGPOBm8D/rncbu4Pk=;
 b=CVo7YJDghy8Hgbwi9bfrxCZBYJEXVEmNehrkfrevoDt2zT5DfpzIaRZJpYVXi4rI4n
 YYXkakLLy0h2NX6j9PcjKQIUvDT+NPm6cTBPynCdsScRRmPOcoQvstxGb5yaE3AU2pwk
 Vun6bKMphZNWoIHBGdiE83tieOE+tged8pSyfOxZ/Yv1gjMBNdh4HeBNRI/xZPWzhnYR
 KsGC5XZTaqmkvSSB+riCKuLbZHE07AwwIkYN1KIYmgwnM2IqfjNllkmbYcHvXFM4eFfP
 g8mGfjQAPb0HianVYLCunFghuBBbCVysl96jWRDHB9q5JkatIV8JogObe3Fod4PNUdHW
 Y9Ag==
X-Gm-Message-State: AOJu0YyoqDlFevEug5s+MqdhTsfEYLir0SDUSI9gW/Qul2/xbDwv4pD2
 Kjm/3d/j7qjGp6UeXiqq8jQgycMe+YX00uZTo+z7BNPyFTbUXIss/n04V08dK8YSC/4=
X-Gm-Gg: AY/fxX5y54Gmg71PjXPsVmH1GnEMWsbwzTLX+QPTgn/NRMlNZI8eJa2EaM9yX3/dyGE
 0YraMjMaqZuVerC98U8CQkzc1OG+rlRuMcH4kyvODoRjoaYXB4PPdMMBy5b/r1LSK9fJbPXW5vO
 8YgEngNPP0WAWKa3E1w4mlN0BXMY/7jocl/1xX5l4WpQ511QQBhb3GxDE7SR8B4eVmj612sl/gk
 c45IY3IWGESg5rDjp08xZgXv2EI0bPHUWTFbcrZZOhcIjQiljEs+ZCST80AYePI8HlMrJZMMX/g
 fS74/rXz8p7RCfL30+Ed+dEKqYHpE4OPq9C0qbPVsfyQZejPQ0XTMl1/1+V7Q9+K0tK7mh06XO0
 zVnYjUPGbwPDex2YADMPzcu/fPoRiHVj+ZwnKxW384yzn9DwCvIqw/Vn0MA3eeIGqnTxGrl1+/3
 NYdkqxWmfi+Ynw0uWWd7RUlz9XBUGNwFrWw/KYl06C9QLYLRSiDqXNwGZCXFPz
X-Google-Smtp-Source: AGHT+IExyvXi7yMRZpBrOjrqyvhQW8fTrh1/RNZpMwSB98icI/j+FAMokKvY8n/qaA/ywUMDGtvL/Q==
X-Received: by 2002:a05:6870:c18e:b0:3d1:ed5a:1356 with SMTP id
 586e51a60fabf-3fda567b552mr12235749fac.15.1766867412849; 
 Sat, 27 Dec 2025 12:30:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d3585sm16417975fac.2.2025.12.27.12.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 12:30:11 -0800 (PST)
Date: Sat, 27 Dec 2025 14:30:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Anurag Dutta <a-dutta@ti.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH] dm: core: Create ofnode stubs when OF_REAL is disabled
Message-ID: <20251227203009.GM710860@bill-the-cat>
References: <20251201194857.2371332-1-simon.glass@canonical.com>
 <CAFLszTiS_hQbKnguY=ykyNOKk_hsMzBOAZAnOPjn7U49eunuFw@mail.gmail.com>
 <20251227144800.GJ710860@bill-the-cat>
 <CAFLszTib_BXUxdfkNTey0_r+RV9bKLwv6mqMd8P-ab-YevoWLA@mail.gmail.com>
 <20251227150651.GK710860@bill-the-cat>
 <CAFLszTg+yDdJ4TFPJF=_Z9f_aT7M1fuVCBc54sLcYfyfvvd97g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xNFmP7MHQB+4voSJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTg+yDdJ4TFPJF=_Z9f_aT7M1fuVCBc54sLcYfyfvvd97g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--xNFmP7MHQB+4voSJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 11:51:02AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 27 Dec 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Dec 27, 2025 at 07:58:10AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 27 Dec 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Dec 27, 2025 at 04:44:07AM -0700, Simon Glass wrote:
> > > > > Hi,
> > > > >
> > > > > On Mon, 1 Dec 2025 at 12:49, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > When there is no device tree there is not point in trying to fi=
nd nodes,
> > > > > > etc. since they will all be null.
> > > > > >
> > > > > > Add static inlines to skip the code in that case.
> > > > > >
> > > > > > Unfortunately this makes the file a little convoluted and there=
 are
> > > > > > two inlines for ofnode_is_enabled() and ofnode_first/next_subno=
de(). But
> > > > > > it seems better than the alternative.
> > > > > >
> > > > > > We could also consider splitting up the header file.
> > > > > >
> > > > > > Also add a rule in drivers/Makefile to compile ofnode.o when OF=
_REAL is
> > > > > > enabled but DM is not (for kontron-sl-mx6ul) and move the
> > > > > > ofnode_for_each_compatible_node/prop() macros outside the OF_RE=
AL
> > > > > > condition, since they only use functions that have stubs.
> > > > > >
> > > > > > Co-developed-by: Claude <noreply@anthropic.com>
> > > > > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > > > > ---
> > > > > >
> > > > > >  drivers/Makefile      |   4 +
> > > > > >  drivers/core/Makefile |   3 +-
> > > > > >  include/dm/ofnode.h   | 714 ++++++++++++++++++++++++++++++++++=
+++-----
> > > > > >  3 files changed, 641 insertions(+), 80 deletions(-)
> > > > >
> > > > > Any thoughts on this patch, please?
> > > >
> > > > I'm not sure what you're expecting for AI-developed patches after we
> > > > talked on the community call about not doing that.
> > >
> > > I haven't been able to join recently but should be able to join the
> > > one in a few weeks. Which meeting was it?
> >
> > The last call you joined, where you asked about briging up AI, and I
> > explained why I didn't think it was a good idea, and we should at least
> > wait until after kernel summit, which was going to talk about it, before
> > we do anything else.
>=20
> Oh, that call. Yes I heard what you said. I didn't got to plumbers,
> but Marek might have heard something.
>=20
> See this patch for the current state:
>=20
> https://lore.kernel.org/ksummit/20251114183528.1239900-1-dave.hansen@linu=
x.intel.com/
>=20
> There will likely be a discussion next year about which tag to use.
> But I suppose this is relevant too:
>=20
> https://www.linuxfoundation.org/legal/generative-ai

Yes, and there's an LWN article about the summit portion. I also thought
the need to not worry about slop yet since it hasn't happened yet funny,
in light how of much slop gets posted everywhere else. And the comment
about it just reproducing kernel code anyways so no need to worry about
copyright reminded me of https://github.com/ocaml/ocaml/pull/14369 yet
again.

But the huge point was "no AI", which you ignored.

> > > > That absolute briefest review I can give is that it didn't solve the
> > > > problem either, and so you didn't test it correctly.
> > > >
> > > > I was just planning to ignore this, rather than get in to another l=
ong
> > > > thread with you that I suspect few people would read.
> > >
> > > The problem solved is in the commit message. Is that the problem you
> > > are referring to, or is there another one? We can discuss it in the
> > > next call if you prefer.
> >
> > It seems like you forgot why you made this patch. But your patch also
> > doesn't solve the problem it states, which you would have also found if
> > you did more in-depth testing.
> >
> > This patch is I think a great example of why as a project U-Boot should
> > have a "Don't use AI" policy. If with all your experience with the
> > project this is the best you can get I fear others will have even worse
> > quality output.
>=20
> It seems like you have reviewed the patch and have some feedback, but
> you want me to guess what it might be? Is that correct?

Well, that's half correct. I could send along what a friend of mine had
Claude review it and say needs to be done, or what Gemini Pro "thinking"
told me needs to be done. But it also doesn't solve the problem you were
going to solve, because you didn't like Marek's approach. And you then
didn't test the available failure case.

And of course both of the AI reviews start from the premise that your
patch correctly does what it describes, and that it's a good idea to do
what you describe. Neither of which are good assumptions to make for
actual review.

> That patch took quite a while to put together and is fairly ugly. I am
> sure I could split it up, particularly if it doesn't have to be
> bisectable. But it could easily become 10 patches and a few separate
> files, given the current state of ofnode.h
>=20
> But no, I don't know what is wrong with it. If you would like to tell
> me I can take a look.

I'm not sure what the point would be. It doesn't solve the problem that
lead you down this path (I've now pushed the patches that do). The next
problem is the seemingly countless times you've been asked to provide
changes in a reviewable state, of which this patch is not. Finally, if
you had reviewed the outputs you might have noticed and then wondered
how this could result in size growth of the platforms that should see a
size reduction because they don't set OF_REAL.

But really, most critically, the current policy is Don't use AI. It is
producing lower quality work that is difficult to review.

--=20
Tom

--xNFmP7MHQB+4voSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVBBzQAKCRAr4qD1Cr/k
CgALAP95Z7/a5Jixqbv9Faauth9QW7K8+I5Br+u53Gx9gDz0SAEA40vvcPs0hVNf
R3/W1KlEg5BQDBfa/Ajo6jrVgWumwAE=
=9kJ/
-----END PGP SIGNATURE-----

--xNFmP7MHQB+4voSJ--
