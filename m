Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610FFCAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 16:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726EF8319C;
	Mon, 29 Sep 2025 18:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K3w1v84m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C0CE8319C; Mon, 29 Sep 2025 18:04:06 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB39F82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7af791b28b9so1678519a34.2
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759161842; x=1759766642; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AKZeAlEBqDKJDn3vnOqMLsaYLDLPhok/Fd9I4S3XDxQ=;
 b=K3w1v84muvcnrDGtpPn00qgLb2ALMjccgWsOs/NwfUbG4J7+QOzGZeFWy8fy9ga100
 XSuOp4vzoFMn71isNXDJ9Y9t9yUBOF3DYvuIeqbvcVuNlWJkMVWinzbfmO80e2iB6VoL
 XuD/1gvXkPyZ50pFleBE/agJlINI8orYvqSyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161842; x=1759766642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKZeAlEBqDKJDn3vnOqMLsaYLDLPhok/Fd9I4S3XDxQ=;
 b=dr/KWFPAynQ21Oa73KphwTZG8IVPzDyTUCtFr9ek2JY1w/Y0LrErjTqcKJVqjWLpMX
 wUbLbFDC5NvrLwhUDPuYHx6TIbYH7R99wuDaXcAbfov9B+gVfa9QrTXbOHBMskDN5V/I
 IflmHNpkroBeN51ntIulHmNqdL+7+JyOzeqlkUTrklp6f4CbdbZ//PFF8G0lOaL6TdQE
 qXxf/u+9m+rIaVbQBvxQoBKf6oRFv/7KDLmwMUeCQeaS10Xrnio0dNMc26GxY3h1A9pU
 oPo6citrb2mdJDRCd05shO7OiGbX32ETojOfdtNu4YxBwLDstu9O3qD/3d2zK9c9XBSd
 CRew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvnkI98rI/nOYjEs63BmpKF9ylZwhzdTKOold3kAYm+UUkuDIP/g8Ym5h+J0ZeI0cxQG1a+x8=@lists.denx.de
X-Gm-Message-State: AOJu0YyPo60fkpLwg38y5q40tq3xRtEP9VW2bZK9lUlhEoTiIMe5zVVF
 uwK1DS6iK7M5TECPoiz5z+WiXPJ8rjHdmdfpKw44VQxKoenbPtR1QCkPDtHs8aluFQ96q8nWx8g
 tvDBuYhE=
X-Gm-Gg: ASbGncsBkJb4rmM4lNa3dglePpdk+1qO9AeyhDoWhJWi9xkI4rhIERuyfQagx9MH8eR
 kn7+b+zEcomT0PO5KiBUKWbOND8tP7QDe8WGnn1WvMrDEwxX0PvLPfbgSowjxP1KG9Txf94xXfI
 G8erZ86L/Qubb3CVJgL9PKKhXUUDMxN7P6E6eF+K33ihQuhTa0sW6gF5n8AHWWCeU1Q8P2duxqa
 DRV7Om+lAhWhODrLd3kOjw8JdhuBN2U2vlVfwl9cr05CeprGxdXP5VsqXo+bbxoPDPd08C85G/V
 uQUCIqhrnG5lTUArZlld+YakhM7o/QhrL1sg1aXvW5DRVOKc3PtINQmQX0Nt2oa1oI+avBo7Tf+
 laJfZuD4VZ0pKbW1QvhfQKii9JNriRHBRagFaobJBP2tRjlmG9gabXKQO
X-Google-Smtp-Source: AGHT+IHBvUfDHWGYDyryXUo0Uvf4JcwA3AkH9SNyqAuUUVNPGAVo9/liQqAKlfE8mezti5PFnn9wcA==
X-Received: by 2002:a05:6830:2813:b0:79f:19f:7f5 with SMTP id
 46e09a7af769-7a044bce4e5mr11127402a34.6.1759161842398; 
 Mon, 29 Sep 2025 09:04:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23e168631sm2698462a34.28.2025.09.29.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:04:01 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:03:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3: Remove redundant test
Message-ID: <20250929160359.GH6093@bill-the-cat>
References: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
 <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
 <02ef127e-f789-4cc6-9592-eb4b75f1b0ea@linaro.org>
 <59d4ef95-e030-4508-8e1e-ae37a0df6c29@mailbox.org>
 <cb3ad7f4-6e02-4a59-b763-887ead2c338d@linaro.org>
 <20250929141507.GE6093@bill-the-cat>
 <20250929-fuzzy-attentive-dogfish-60df26@lemur>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gaa3GgrHWmlCTil7"
Content-Disposition: inline
In-Reply-To: <20250929-fuzzy-attentive-dogfish-60df26@lemur>
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


--Gaa3GgrHWmlCTil7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:32:38AM -0400, Konstantin Ryabitsev wrote:
> On Mon, Sep 29, 2025 at 08:15:07AM -0600, Tom Rini wrote:
> > > So it looks like the default command used by b4 for the Cc: section is
> > > "scripts/get_maintainer.pl --nogit --nogit-fallback --nogit-chief-pen=
guins
> > > --norolestats --nom" which causes recent signers to not be included d=
ue to
> > > the '--nogit' argument.
> > >=20
> > > I have added the following to my git config file.
> > >=20
> > > [b4]
> > > 	send-auto-cc-cmd =3D scripts/get_maintainer.pl --nogit-fallback
> > > --nogit-chief-penguins --norolestats --nom
> > >=20
> > > This will mean that from now on recent signers will be added to the C=
c:
> > > list. I hope that this is what is expected.
> > >=20
> > > I will resend this patch with the expanded Cc: list.
> >=20
> > A while back someone submitted a .b4.conf (or .b4.config? I forget...)
>=20
> .b4-config
>=20
> > patch, but at the time it wasn't setting anything non-standard I
> > thought. However, is the above something that can be configured there?
> > If so, that would be good to put in a project-wide b4 config file, and
> > if it's not it'd be a good feature request for upstream.
>=20
> Yeah, we try to walk a fine balance between being newbie-friendly but also
> allowing power users to tweak things. The decision to add --nogit by defa=
ult
> was because for most subsystems this returns a list of CC's that is way t=
oo
> huge and actually trips up some MTAs to refuse delivery with "too many
> recipients."
>=20
> The biggest downside of providing settings in the toplevel .b4-config is =
that
> it can't currently be done per-subsystem, so projects like the kernel can=
not
> carry a .b4-config without it clashing between what different subsystems =
want
> to set as defaults. I've not yet come up with a good way to solve this.

Ah, thanks for explaining. Yes, there are some challenges with co-opting
kernel tooling for our own needs :) In another part of the thread Andrew
just now pointed out that
https://patchwork.ozlabs.org/project/uboot/patch/20240717-b4-config-v1-1-0b=
c9e80ef582@flygoat.com/
does handle this for us.

--=20
Tom

--Gaa3GgrHWmlCTil7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNqt7wAKCRAr4qD1Cr/k
CpFTAP9oTOq2a1y2fJJMH/jp+OefRiD6C5WqyQjKGaAY/LtYwwD/f/c7zjkm0X1D
dV0V8aVjYXZvcriR3BWx1PxBmN8hUwY=
=JXOh
-----END PGP SIGNATURE-----

--Gaa3GgrHWmlCTil7--
