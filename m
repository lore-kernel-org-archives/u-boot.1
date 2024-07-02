Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F008AC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 19:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C81488757;
	Tue,  2 Jul 2024 21:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sLUV6Yrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F5588763; Tue,  2 Jul 2024 21:05:01 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CCC988754
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 21:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d8470bd455so899654b6e.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719947098; x=1720551898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TLRM9DddzIxF5EGSeOhH0YxXpv07xjVP9o6B3TqdWCo=;
 b=sLUV6Yrkse3C9M+JlsgN16fjVA597wYvbrSxUFLgICJjkezM24CSIdJ3TXmK4vAP6U
 5tgteFiWB+yCGWMSzGfS74sbQWdTcxz9ToSRlEc78WU2UhvQmiiizrCoC3dGBC22e/zs
 pStGhLwjZHwMVZHYHT9csDnExAZRvkRvUXFp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719947098; x=1720551898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLRM9DddzIxF5EGSeOhH0YxXpv07xjVP9o6B3TqdWCo=;
 b=eiumT4+y9Cg2lhjCZFl+7Qvq0czLqKWRRO93359xyBl0C2kOubVfVnj8iKbmTMTh07
 N1VnMpjQRMwa/eUICm9ovRWR17+uIyc7WpoNFPBNBdULMFGHR9wnhpznNm0vWfENY+du
 yN0n/dDmwa3rw/fbN86GcMWSTLM8mPP7gGWS9MOtZ6VhHG8gJ+mqx6HrzJ2EMHR434HU
 ewWlThxDuRjGMYOu9jWwxQkrD3p1/VJicBtMxpBBpUZyZGQFpr6nBQ2mFFTDUe/YR4NV
 s3j9+Ir39kIfaJV5EvUVQoCAHe1kVp7m649A7WaEIGdJ+II8L0yOYGlrWTa0+hCyUMVp
 psfA==
X-Gm-Message-State: AOJu0YzrYrDtU3yJLUCPRf8OdEC3zqiI/cAAOdgn8gQJ1LQFGGd7rUqd
 StogrtkCOr7dR6yaYynNDlO3mAIYKuB++NQpNkVAtdWa0F06/A0YH1WhwU4sjBg=
X-Google-Smtp-Source: AGHT+IHRauNpjvOYwSx8De7Ru4IzVB5MTNGKjSImFE/8r7S+WqwTWsaKoj9tbr/A8Ht8cp5QFqJTMg==
X-Received: by 2002:a05:6808:3a15:b0:3d6:342d:6412 with SMTP id
 5614622812f47-3d6b4de2f74mr15441784b6e.40.1719947097991; 
 Tue, 02 Jul 2024 12:04:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-45.totalplay.net.
 [189.203.106.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62fa39edfsm1828221b6e.37.2024.07.02.12.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 12:04:57 -0700 (PDT)
Date: Tue, 2 Jul 2024 13:04:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm/next
Message-ID: <20240702190455.GQ38804@bill-the-cat>
References: <CAFLszTicbbAAcx=Lpt7RxOAktV1Pn9avhLYbT6VXMF3tnZGyQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5k2eRY/WscRqjZ0L"
Content-Disposition: inline
In-Reply-To: <CAFLszTicbbAAcx=Lpt7RxOAktV1Pn9avhLYbT6VXMF3tnZGyQw@mail.gmail.com>
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


--5k2eRY/WscRqjZ0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 04:51:30PM +0100, Simon Glass wrote:

> Hi Tom,
>=20
> This is for -next but we need to figure out the patch I just sent
> first. I can redo the pull if that patch is acceptable, or you can
> pick that up first.

I thought you meant the i.MX9 patch, but with that applied before your
series, CI now fails on those platforms. So yes, lets hold off on
whatever is causing that for now and rebase to exclude it.

--=20
Tom

--5k2eRY/WscRqjZ0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaET1AACgkQFHw5/5Y0
tyy75gwAuUJ4ddiUySsHtOx75iYYMMr9wUks1J2AntFizruMCO5+/behlNmwzjnw
pVAuk3NyayFhsqLgjAboE9vLsUu0zRf5wKUXTqcK0LFjmBInDCYVmDQW0kqIQqV8
5+TnIyKR9zSxHcfQBo6kuz71V1VGF1MKaEHftiDhSbgawAfmIT1ltO7kd9q+MRT1
W3QivWAABYAHSgmsyjViLy37l/iAcFI88aMzrHd0dU/KZj6iJtDCJvjmImnEl2IX
VBweXTDgIbggjeTv14CwJlSCkzxUeZy61jQDC0K3IeHM4ICgmFmn4LAhwaMkizvQ
P7JvJRnB0zKf7frCEao9nrRJdZiMw12njZM+LkC9r2NtfirFyt/Xlbo4RmwyJTer
DbHY7dbHPDhsfpo5Yry3KhOtEKZ/mJkaK4NwR9cDfNzaE5amEDGwO9NFAWTdbJn8
YY6XIV+aLWWZXOxf59zxO09P/i3skiS9jYNxF1RdKbrc7rmGiwT9m3mNop+D66L1
HLtbMDYK
=Yh6V
-----END PGP SIGNATURE-----

--5k2eRY/WscRqjZ0L--
