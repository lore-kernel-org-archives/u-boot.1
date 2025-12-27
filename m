Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B2EE92713
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 15:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0193083C40;
	Sat, 27 Dec 2025 16:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Damn1bt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A125B83C54; Sat, 27 Dec 2025 16:06:57 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687CD83C39
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 16:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4507605e19aso5308449b6e.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766848014; x=1767452814; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ubNFu4no197NJ+F55Elk/GGcdZZCygQfSPPu6KCBDIY=;
 b=Damn1bt0kflvwhr9m3yJsUom8cORBUC2qir3Qk9UotrxxF/7YA6SE7ACj0mnIHMyx1
 YopQDNU0fkUWSYXUKdbW+EgMd5LNCjGeWqSrjBsuaPgoASk5ZKivFKtb5av7QzdeVAWh
 hX90HJjC2ihrlp/R9V56oI4l4paSEgqspFcjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766848014; x=1767452814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubNFu4no197NJ+F55Elk/GGcdZZCygQfSPPu6KCBDIY=;
 b=H230SxMbpmPtl3j/siuqftC6ruZQEQmP+o1Z5nz07EQNUrfBzAMdbAvFhqI1uVEGgc
 v0+DkHtzgssRaIO+9o+cUIxYmi+iwL0fAFVN/+uVHXXniXUwmBB/a8qTJBT/FFLP+166
 S5ADeM1gmcgt2r8Mn5c7UD8w3uQIWzb2sd/ZWOT+97HNT2Unpwd59OhM8jU9Gh08mTZK
 7Acd9I+F2+z6csjdaQ/0Dey4qNffgl2BvsclVEzA3IP9BTL6E+TNNc8plHLpx7aqEuf5
 lOzw7Jlgq8B3aOgYkrAt6z44oueDTTIvwwv6felxotf3aSR3RIDmbam4psjrYkH43A+x
 BRoA==
X-Gm-Message-State: AOJu0YzaYkc10Suff/4hqtGv7GG3omBU10Ex4bFKeFzdEuzQIxehqXWe
 BPG5r01tWunh+wbcQ9k+TFzxibsWiurqMTSfm4D8JIFhhEPLCGDJUjh2wCRoHcNORNA=
X-Gm-Gg: AY/fxX6KZrnSPiLLE7aGmpIxSBHDvyLHXwhJzVytiwO6yJVcpl6Fe0yfZ2wr56gOMDM
 7IJ76HN0WvoXp2GXYOOzcoYEIINuWuZBw2ZUFl5YACA7SxcVYbAhhBW7LPLxQA+BHrD9LXxTtNQ
 VuCXuFb5DXgL28KfxBreqpsWKrG8MygX+bD7J4+WIsVTVrjV5ldqqCwZpZZ+9uzZ05V83xHyOn/
 Dotou7fJa28IYQb5yzpIsBvrPaxRyG7Pca64cpSl3oJjLWUPXNuDtCtDznkGk9dsXKE3ZJ4QZa3
 EcO7GzOeB63km8x21QQ+uv/XDr/R8ARjAbeOZqpFujisTQGiwWUWW8+nyeHWMvVL/FQVREyyIvZ
 7cvtZMV6GM+GTUBF5eN1UtnhDV3uRN3ADeoDCsBUmu9FM09kYvRWbyCQZfOPlXd8RL/Z0/cyl9w
 KOznrScrRcmAfEvr2S93fMhRJWbFFkDpYWIjBxa67u/vlGOutq/Hq804N1YxP8
X-Google-Smtp-Source: AGHT+IFskMPTfs+igX6h/CQ3iWNP69dEWBjatvMHOwBvEcZ8lDJZhXst6WZiN7qlqTJx2KcNWvoRhA==
X-Received: by 2002:a05:6808:4f69:b0:450:4628:e3ef with SMTP id
 5614622812f47-457b20017c8mr10564556b6e.16.1766848014035; 
 Sat, 27 Dec 2025 07:06:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9201sm17112166a34.26.2025.12.27.07.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 07:06:53 -0800 (PST)
Date: Sat, 27 Dec 2025 09:06:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Claude <noreply@anthropic.com>, Anurag Dutta <a-dutta@ti.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH] dm: core: Create ofnode stubs when OF_REAL is disabled
Message-ID: <20251227150651.GK710860@bill-the-cat>
References: <20251201194857.2371332-1-simon.glass@canonical.com>
 <CAFLszTiS_hQbKnguY=ykyNOKk_hsMzBOAZAnOPjn7U49eunuFw@mail.gmail.com>
 <20251227144800.GJ710860@bill-the-cat>
 <CAFLszTib_BXUxdfkNTey0_r+RV9bKLwv6mqMd8P-ab-YevoWLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GeNRDIIi6y2c2PgO"
Content-Disposition: inline
In-Reply-To: <CAFLszTib_BXUxdfkNTey0_r+RV9bKLwv6mqMd8P-ab-YevoWLA@mail.gmail.com>
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


--GeNRDIIi6y2c2PgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 07:58:10AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 27 Dec 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Dec 27, 2025 at 04:44:07AM -0700, Simon Glass wrote:
> > > Hi,
> > >
> > > On Mon, 1 Dec 2025 at 12:49, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > When there is no device tree there is not point in trying to find n=
odes,
> > > > etc. since they will all be null.
> > > >
> > > > Add static inlines to skip the code in that case.
> > > >
> > > > Unfortunately this makes the file a little convoluted and there are
> > > > two inlines for ofnode_is_enabled() and ofnode_first/next_subnode()=
=2E But
> > > > it seems better than the alternative.
> > > >
> > > > We could also consider splitting up the header file.
> > > >
> > > > Also add a rule in drivers/Makefile to compile ofnode.o when OF_REA=
L is
> > > > enabled but DM is not (for kontron-sl-mx6ul) and move the
> > > > ofnode_for_each_compatible_node/prop() macros outside the OF_REAL
> > > > condition, since they only use functions that have stubs.
> > > >
> > > > Co-developed-by: Claude <noreply@anthropic.com>
> > > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > > ---
> > > >
> > > >  drivers/Makefile      |   4 +
> > > >  drivers/core/Makefile |   3 +-
> > > >  include/dm/ofnode.h   | 714 +++++++++++++++++++++++++++++++++++++-=
----
> > > >  3 files changed, 641 insertions(+), 80 deletions(-)
> > >
> > > Any thoughts on this patch, please?
> >
> > I'm not sure what you're expecting for AI-developed patches after we
> > talked on the community call about not doing that.
>=20
> I haven't been able to join recently but should be able to join the
> one in a few weeks. Which meeting was it?

The last call you joined, where you asked about briging up AI, and I
explained why I didn't think it was a good idea, and we should at least
wait until after kernel summit, which was going to talk about it, before
we do anything else.

> > That absolute briefest review I can give is that it didn't solve the
> > problem either, and so you didn't test it correctly.
> >
> > I was just planning to ignore this, rather than get in to another long
> > thread with you that I suspect few people would read.
>=20
> The problem solved is in the commit message. Is that the problem you
> are referring to, or is there another one? We can discuss it in the
> next call if you prefer.

It seems like you forgot why you made this patch. But your patch also
doesn't solve the problem it states, which you would have also found if
you did more in-depth testing.

This patch is I think a great example of why as a project U-Boot should
have a "Don't use AI" policy. If with all your experience with the
project this is the best you can get I fear others will have even worse
quality output.

--=20
Tom

--GeNRDIIi6y2c2PgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU/2BwAKCRAr4qD1Cr/k
CqpiAP9u58g4nTpFogUTFzcG4j4gw+qrvbRLhdwLLLM1fsMplAEAgRTo3k7VasYp
xogCtnXJYqu4zg0oHGc/HFYm/UkK6QM=
=atVZ
-----END PGP SIGNATURE-----

--GeNRDIIi6y2c2PgO--
