Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B7DC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 985A881951;
	Fri, 28 Mar 2025 16:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JMSxP84s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9877481DED; Fri, 28 Mar 2025 16:59:47 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543BC8144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3feaedb6670so1361143b6e.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743177584; x=1743782384; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pkbQjURxNSpSnQEXagz3Npc1lEHptof+73nZmzBBcNQ=;
 b=JMSxP84s+tMRZXGzTcOJeSquPuSw1E64/KUvc/pQLSXdpAsz6WiBfhLDbC4B+5g6Y2
 x0XttvUlGOpzBeJKMAxq4u2gdMhfCa4xUFBm8GbA2ezWxjcpEe8NuFjyQcApsp598Vvn
 w3Z58eteYjtfc19bUpazRFbXBKN62Fahnv+Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743177584; x=1743782384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkbQjURxNSpSnQEXagz3Npc1lEHptof+73nZmzBBcNQ=;
 b=KBu1z42IBWUpkJL03B2QSXbOftm5dYr0q9rL0FwJKN6k3pCJ2iKTJkBkbZ5UCHSRfV
 yEFGQ/yvci21RbUuirakP5SSKkeVfNrwmKIIHLMNiShM8ey9XNM5U1dOsKjn0AC48+U4
 OhWceZ43yvCflb2BMdjN/3zwUmb0T+KM0wrB2PsJ7BqKhMdNxHvyzWntCwqcpyMri+KG
 XytVYkstJPLYP+9/fRev4xRzIPvrLXjnMBQ6Dp9A67YJ17TguQfw/6Fq6pDBANNJjZiY
 rITWxTR48REm42XeeeYKm9KTy6j1+hV6Hm9c2K6Lqn/i4qrdMNSK1z6y9Re0Lcs0M4Gd
 r89Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN1qNL8wnF10KOClyNwKgb/XJeuKEPC21qhNXgEVj///rIBA65SuIZ+gONl0lQgR5dtplty7A=@lists.denx.de
X-Gm-Message-State: AOJu0YzQoxf3PEG+RlnMWXr553HqVQfCFVToQswzMqZNjea05ODAALw+
 7DKdsRYIx4D+M5y06r8VxX55vpZex4/pVdudyoiUd21DScfrlOMsbn0rU9VF20k=
X-Gm-Gg: ASbGnctrvW+zagDupi4JWbwuWOFVJ2tMsC+lxVxqsudpQPx8KtT32yGeJpzBsHItVOW
 XaUYT/XL+a/CHtcJPLMENjgeoX3Pp1/V/l+NbEsKAvvm7F0iVZDOTQJuA1tO6ljEiAEXQpMkA50
 Sg+CbagnSq2cQMhmPRfaWdBJwN4QDjOS0w/9hvGK4TtiuZZMZVB7VqyiB0d9hyOonadW/+Uc24E
 0ShlvFY58UUc4zbI1Fyi8gXuEaljYxSYoylyHatGtnM+w4KDn06xydoLm7Ac78fm3z6mMzSdHMa
 9v41P42Xjsu3tro52oeKPsr3dBYlHRbIOFmfKDhZt+fJ993vbU/y/wpMi3JXmgMq0ahYciFeei7
 GIS5KFg==
X-Google-Smtp-Source: AGHT+IHce1GH7mTDzQyQi4IoqAW3oIMClrWBHN6XCxfn7sf4p8DfQRlBbCrEimJUjW8NZaju3e+pzQ==
X-Received: by 2002:a05:6808:1184:b0:3f6:7e4e:96fb with SMTP id
 5614622812f47-3fefa53efaemr5720767b6e.17.1743177583764; 
 Fri, 28 Mar 2025 08:59:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05278de3sm372965b6e.36.2025.03.28.08.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:59:43 -0700 (PDT)
Date: Fri, 28 Mar 2025 09:59:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] fastboot: lift restrictions on !NET_LWIP for USB
Message-ID: <20250328155941.GW93000@bill-the-cat>
References: <20250312073655.2281377-1-mwalle@kernel.org>
 <87cyecdpf8.fsf@baylibre.com>
 <D8RS34QA63LP.296JEK5L3IREQ@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9xq9DCCrcEFNLG6k"
Content-Disposition: inline
In-Reply-To: <D8RS34QA63LP.296JEK5L3IREQ@kernel.org>
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


--9xq9DCCrcEFNLG6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 10:06:12AM +0100, Michael Walle wrote:
> Hi Mattijs,
>=20
> > > Fastboot works either over TCP, UDP or USB. The latter doesn't have
> > > anything to do with networking, thus should work just fine with
> > > regardless which network stack is selected. In practice, header symbo=
ls
> > > are used inside common code paths. Add some ifdeffery to guard against
> > > that.
> > >
> > > This will make fastboot over USB work with the new LWIP stack.
> > >
> > > Signed-off-by: Michael Walle <mwalle@kernel.org>
> >
> > checkpatch.pl reports some issues with this:
> >
> > $ ./scripts/checkpatch.pl --strict --u-boot --git HEAD^..HEAD
> >
> > <snip>
> > WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' wh=
ere possible
> > <snip>
> >
> > Some occurences below could be fixed. Could you please have a look?
>=20
> I've seen these. More below.

That is also my least favorite checkpatch warning, and it's a warning
not an error. Best judgement is needed about making things readable
rather than just silencing checkpatch.

>=20
> >
> > > ---
> > > Alternatively, we could add the defines and stub functions to the lwip
> > > header.
>=20
> This is relevant :)
>=20
> > > ---
> > >  cmd/fastboot.c               | 4 ++++
> > >  drivers/fastboot/Kconfig     | 1 -
> > >  drivers/fastboot/fb_common.c | 4 ++++
> > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> > > index d4cfc0c7a28..be84a482b81 100644
> > > --- a/cmd/fastboot.c
> > > +++ b/cmd/fastboot.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/printk.h>
> > >  #include <linux/stringify.h>
> > > =20
> > > +#if CONFIG_IS_ENABLED(NET)
> >
> > I think this can be dropped. I hope that since it's a static function,
> > -if there are no users in the file- the compiler will optimize it out.
> > Note: I have not verified this, so I might be wrong.
> >
> > If you measure and see size changes between keeping the #if and not
> > keeping it, please ignore this comment.
>=20
> No, because net_loop(), net_set_state() and NETLOOP_SUCCESS is only
> defined in net-legacy.h. Thus we need this ifdeffery.. Unless of
> course, we add the enums and function stubs to the new lwip net
> inlcude. I don't know if that's a good idea though.

Yeah, I'm not sure that's worth it either, or at least as maybe only a
future clean-up or investigate more. Perhaps filing an issue on
source.denx.de on the -net tree so it's not forgotten?

--=20
Tom

--9xq9DCCrcEFNLG6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmx20ACgkQFHw5/5Y0
tyzxlwv/VUxBlN5ipwPnhOD2weec55YfANkRkn5HXqW7AfCyHrxiToFYGft+0ZE+
nbDU+T64UJnRGks5PB62RyGwZ0wH0HC1nt7JFLaFhNxaSGnhUkY6G2MkEy3kF0jf
7ShOGPHG21WzV4MidrfIvzS56lG1p0/NXw11LbdWBBvRJUTG0IG/Y/P06q+bkDeV
Rc5x3cAMmnxDVgZWBuCDkEhCgHD030GCUvvRsUsBTRvjG6qOEd5csF5+onuEyAT9
tOatZuve/VYrgZgQEmehs+rCwNUhyB2FTl5cT6dr41BTiRQ7+xevCpaw+wL8eRdk
xSQa6cl5dCSiERXUpqUmIz5AoJHvvJR6d0iUyXMJMn1sKqzXSHYPqgxsALXlnrEm
qQ750MaEU5B7sGrEMjtiOk3Jt8N6nWkvp14fu6oCyFAI/pzSHoLLnqQYcqbXBujs
V71Lqashieir0bcv9uGVC6MrI0Dyccgou+euxGEG++p16l8GXGzt5wCKTW1Ref3k
TUoE9I6B
=KfGf
-----END PGP SIGNATURE-----

--9xq9DCCrcEFNLG6k--
