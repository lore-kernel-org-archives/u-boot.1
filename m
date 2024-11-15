Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29971D68BCF
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 17:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61EB0890D1;
	Fri, 15 Nov 2024 18:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Amy1dp7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D6B98912E; Fri, 15 Nov 2024 18:52:16 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4451C88EC9
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 18:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b31b66d2e3so105613185a.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 09:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731693133; x=1732297933; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vX/4DUbmLmBLJl7NhmWoESjYwmrjLZKie9iSyEQkh54=;
 b=Amy1dp7fMrWRLIq6rVMWt9M8eoyYley28SPxxFvuIG0PCYqbVzw3wnLCcnE0k6IGT6
 y21i9nakAUToab+2/T6HWYGwaESTqjf7FX+6NHC6cbzXrC4koZLoBsQE+JB3vsi7Y0DM
 1yYq62GyLIH6J67VGiGmoY63oqYK4Ff5fayK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731693133; x=1732297933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vX/4DUbmLmBLJl7NhmWoESjYwmrjLZKie9iSyEQkh54=;
 b=wN5UHB7vUqvt9RWn+Z4TMetUGEWRfsaJ8uwLrmv46UlzYzzSHDg8NhTxFzMp0Zc9Cc
 Fp0A7xvhEkdHBrJ14g7BWczZfQuDb+s/OQisEK4mbnaf4BAMd75d600esgO+NvKxxtHQ
 zc1kInYl4I/8vrKwVdbMbKkkMy3P6Gc9+FbnmsvYiSUtW4nZC1aVItO3RZDafKyKwSB1
 PtcgZTzqva2WFNFzJe6OabAHfelm1QGX8TiNB5cbMdYLzAqRZQ++VXJWwh4+qG3UjXY3
 y+AotuXGUJdJ+jEEXMJMOhsj6SgZ7u5ChHf7V8ttKu7w6anqjRNDs63XYhGzG2MrxvDP
 AFUA==
X-Gm-Message-State: AOJu0YwLiejhBUhhiiYW3WGbUhYd7rp2mNUmtOq2Rii0weXHWYlZ9l/i
 KFfU2gXGleSIrly4y6cpnASXKwtJlLVfrPbt4Dkss+3uBQ0jmhvI00iC+8ojFo0=
X-Google-Smtp-Source: AGHT+IHQ+S+MKrLSP6o3ViEJv9yIFEFol8gQlLEGalCWmceMOCLV9DF5gobE9F4UuR0rOM2L+UNVkA==
X-Received: by 2002:a05:620a:1917:b0:7af:c818:bdd with SMTP id
 af79cd13be357-7b362366220mr516474685a.53.1731693133030; 
 Fri, 15 Nov 2024 09:52:13 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca51c6csm180050785a.101.2024.11.15.09.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 09:52:11 -0800 (PST)
Date: Fri, 15 Nov 2024 11:52:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Maxim Sloyko <maxims@google.com>
Subject: Re: [PATCH 1/3] aspeed: Fix Kconfig logic on "DM_REGULATOR" and
 ASPEED_AST2500
Message-ID: <20241115175208.GY3600562@bill-the-cat>
References: <20241115165400.2486914-1-trini@konsulko.com>
 <CAOMZO5D7JKJ57OzRw5gj5vqPgv4ykfDH7_MWgU+QC2ATJ0+L=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="coui2bnw2CQkh1R6"
Content-Disposition: inline
In-Reply-To: <CAOMZO5D7JKJ57OzRw5gj5vqPgv4ykfDH7_MWgU+QC2ATJ0+L=g@mail.gmail.com>
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


--coui2bnw2CQkh1R6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 02:41:05PM -0300, Fabio Estevam wrote:
> On Fri, Nov 15, 2024 at 1:54=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > It is not the case that we can only pick ASPEED_AST2500 if DM_REGULATOR
> > is enabled, but rather choosing ASPEED_AST2500 means we must select
> > DM_REGULATOR.
>=20
> Do you mean DM_RESET instead?

Yes, yes I did, thanks. I'll fixup when applying if there's no need for
a v2.

--=20
Tom

--coui2bnw2CQkh1R6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3ijwACgkQFHw5/5Y0
tyyOUQv/eYFuiUbH+yC+Q933YJm3SEN7O7isDCiYKLhYvB4GkijFes/+coKXmKZI
TwRvKv75+49vuUClVQmCE4Sx6kAfegS2kO6S5UEehP8coTgvgbBv2znXrEheY5YG
r3JGxb7Ulr9OpeQbqNoLDc2K+qcSVeEEclFxkkZpOKmXnXIJqp0UqrQsX2cAGey0
oPzoIxdmK7xyVbKp4/ZFyerfsxWwfOHS5TmFlq3oP9X6khYswsVFBLJC/1+Li+dI
FfTbaqOlIRCjPIR9Iwn21B7hgPdWYffLWwN55CfZ/yWQrVYe9AYnvYZ/X03KIKoD
1/WZXjNRrwGL+jXHY/gvEoMxGwMZtjtQeezmtmB+ld3xwUqdPAbchW8nlh5UilVN
K7y70NbxabWJn5y9EGOtFivMb80PLLF9pZteCm1LjnDmvhYeOiIKbrelPk1OT6QZ
9b3hZP1xgxcUyuzs1Atwj0iquxTn/NTGJnC9SD8W1bP1e/loDjPyj1xQda3ZIw9b
O26aMUR8
=z9nZ
-----END PGP SIGNATURE-----

--coui2bnw2CQkh1R6--
