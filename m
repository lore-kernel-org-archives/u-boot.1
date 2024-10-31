Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E14D767F8
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA6188E5C;
	Thu, 31 Oct 2024 19:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qjxOnrhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24DB488E0F; Thu, 31 Oct 2024 19:42:19 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C3F889EF
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbcc2bd800so11466496d6.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730400136; x=1731004936; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=864fePx335VbrErew+jST/qynt+cujdGn2z03ZxQfqM=;
 b=qjxOnrhgXOxo1pEupbnQzCBLZr822yp5qRF8OKCSC5Rxz3KSC/5BMQm8WPVVJRNh+0
 lTIj/YxqFqOLdoKUjMlAX+ruuoGrSX2pnLXjeyD5iXZWzuPjzLsUrXV1BoRv1OujdhYS
 K5U/mZVuN4RX5d+sLkTRLPAdiIIvNpZr2oj9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730400136; x=1731004936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=864fePx335VbrErew+jST/qynt+cujdGn2z03ZxQfqM=;
 b=ETPUakG8Wu/cld/oFQBnH/zmkEiSPeUJAC0dLfYXqAeWjNYWnDjZMUuZ3hNK6ouEhN
 0ssfi9+V5FseNYqUmer5ajt2UWPnFPifin1gZXeGxEMii0TFLlJztIZ4saouZuk+JTxF
 v/Zl3sPwow21n0hFl55/G79/JFfFRHlBA3TRdvVBPPCKRGGGUlzrZ8t7P4kXbm9yQvS/
 M/hkFnrNj886EZ5CFLLTgQ8Hmcpkt8WTHczVAcQ9idVNgqE9YUgDxrUM1PQJLiHeJdQ2
 ktR7I4SwVjbIL5KaOsh4xWARb4DIM4YtRUX8J/DwCW17HGDANabtGg4Hy7lJvClI7ws1
 LD9Q==
X-Gm-Message-State: AOJu0YzscMajr6swbuof3UnSPOyLV8tZfYSw5LJ3CRa4bujo5vc660E1
 jp9dYw36UqSygZtJD+KWFq6zpD1rva2Rrqzy8TZC9XCE/Zbb+dTrmybWRkMqYCQ=
X-Google-Smtp-Source: AGHT+IE9JwynespdLjGdPORn0QvRCXwREcpIURUPKcj/lOnSKZnxaPmptS8t28BrgmhcQClpNVTSxA==
X-Received: by 2002:a05:6214:1c0c:b0:6cb:e6f4:dc47 with SMTP id
 6a1803df08f44-6d35b95111bmr17018306d6.16.1730400135852; 
 Thu, 31 Oct 2024 11:42:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9e9absm10633456d6.7.2024.10.31.11.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 11:42:15 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:42:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 03/11] test: Allow connecting to a running board
Message-ID: <20241031184212.GD3600562@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-4-sjg@chromium.org>
 <20241029235308.GD2558755@bill-the-cat>
 <CAFLszTiuA_-xZZoca=DpXZTd2GRsdJb4Z2O3nO5Ab7bjaAxXfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yyY8n7QsWcBIEQgU"
Content-Disposition: inline
In-Reply-To: <CAFLszTiuA_-xZZoca=DpXZTd2GRsdJb4Z2O3nO5Ab7bjaAxXfQ@mail.gmail.com>
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


--yyY8n7QsWcBIEQgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 07:00:24PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 07:51:37PM -0600, Simon Glass wrote:
> >
> > > Sometimes we know that the board is already running the right softwar=
e,
> > > so provide an option to allow running of tests directly, without first
> > > resetting the board.
> > >
> > > This saves time when re-running a test where only the Python code is
> > > changing.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > I'm not NAK'ing this, but this is not a open to errors kind of change
> > that I like. It also feels like an unrelated "I find this change useful"
> > kind of change.
>=20
> Are you saying this change is open to errors?
>=20
> It just avoids needing to reset the board when I know it is already in
> a good state. So it is a time-saver.

Yes, I'm saying it's open to errors since your assumption is "the board
is running what I want to test". As a human, I've violated that
assumption in the past running tests and short-circuiting the loop to
just re-test what's running.

--=20
Tom

--yyY8n7QsWcBIEQgU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjz4QACgkQFHw5/5Y0
tyxl2wv/VDixMRiUBUX/IBr3Zq85VwOX4K+ZV4Fk9CZFaecR01AvOeP82rwMzhl8
iJJ+NbkVJbRMlUxrOfXhqv6WAELreKAi+K0Djo8HHAcAgelCBvyAC3Dm1WO4uiEo
ad0L7UU9nuo3VgSPKZ1/2Q32Lgl+pElkABJCys1QHelqYKn3s2il5CklHoHg3GV7
LRI+0YT52Nvfk5y6S41WNn5T/ASjDNqQsTio+SdQCpDyWsqB5JdSIB74eQlTkzf8
bexoTX3SU9awNeR6ZngJPxevcI1utFdgfZ9cgm+BwReuibeQZqCmzOrsfF381A6v
yKVn4SxginPsHncrcMfbFgG1BZ59LfQca6e+/wLmnvcSPsSTYbONtwhE5MYt07uc
W0xMm7cAazQBSm1Ji4hp3VPqNESIYaJrKGq5eVdnlo/d2llSMQLhShXUN1gxu2lc
7pirDyBxnMujupE+pfjqNodnDQ4KuYqF8hvU9GLqYSpFajnbjnZHq6802saMHz/o
0umJpzvf
=BT3b
-----END PGP SIGNATURE-----

--yyY8n7QsWcBIEQgU--
