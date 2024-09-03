Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E30ACD37AA
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 18:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704508871E;
	Tue,  3 Sep 2024 20:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EWpVjJsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C27D887EB; Tue,  3 Sep 2024 20:54:03 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457EF886E5
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 20:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dff1ccdc17bso18197276.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725389640; x=1725994440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QXlCmTZG4cUeqzSsvO5Nr0h4rrLfjbL7mDA9KYOERvo=;
 b=EWpVjJsBGHqzVjfyA9WqczoCnmElpBSJ41UldFIbXG/ZefqQ+kRUfEYpbkc/e9ptAC
 akeEQduxtuu6JVKv6qvjonkuedhLWxXk+EST1G5/Xn7PnV9TxQn1BBEGfjIv7jQgwW4j
 fFStsgaJ3v2LtcugLBl+kKZESuolkQ/Z3K3dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725389640; x=1725994440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXlCmTZG4cUeqzSsvO5Nr0h4rrLfjbL7mDA9KYOERvo=;
 b=i6SPbLcN9zJAqIznufQSwugDI2KemS2DqnXpy55x0tK0SHoIWBhGH+6v2jlumbnt0E
 aUAdgw77zoAWk1wf12IkOskmlKCfOCsFBCbRAmwX3HgeOH+JruPfGiPkcamWqgFGBe7u
 YI9M1sddkqAjzf8kMKKXNtQ67wvRTJ75E0KikWn2vk1JIG3MgTTHCGDzzpxy/TBnzGA5
 AMiAd/EYhJ4FmAyr+ylBiW+xX03HaW4VbUZJYfRpt20TkimVnjdjywViQXU5Ls2uOKOI
 yRPyFh9PUcPVWDTfIyvaXyjRveseYauUQfc8dPguTCq3LpXiIKBa2KSlzqryeKXNCIWG
 ck0w==
X-Gm-Message-State: AOJu0Yy+40choUdi3QA6lNUR9yYqqh4IG5ImZiDseXhzDdmPOldz/RvH
 NZHJEXBsNmypzai3ALJzlE2t2pVHMaWswUkIH2uFRGQx5VUEgDO/7y5yuA9AmH8=
X-Google-Smtp-Source: AGHT+IGf8aS4BWoQh6ZkPXObKVUK2O2PRXNfLYFVHQaVVOTR6tEqOJcPh6021cFnW8CeHAH2MnBJtQ==
X-Received: by 2002:a05:6902:200f:b0:e1c:f239:4dd5 with SMTP id
 3f1490d57ef6-e1cf2394e02mr4194668276.29.1725389639909; 
 Tue, 03 Sep 2024 11:53:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c36b785a34sm20739636d6.46.2024.09.03.11.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 11:53:59 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:53:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
Message-ID: <20240903185356.GL2479150@bill-the-cat>
References: <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
 <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
 <c63147f4-d364-4568-8f6e-c0348914446a@linaro.org>
 <CAFLszTgzM-FT64AYTy6FXwUw3FQg-3MQ7x0TZc6xBhX5c+bXEg@mail.gmail.com>
 <20240829152052.GE2479150@bill-the-cat>
 <CAFLszTjqVsZ1owvpCaOer7U-k0ZvtDfLC9g+kFPW8gJJeQ1Ktw@mail.gmail.com>
 <20240830151327.GU2479150@bill-the-cat>
 <CAFLszTiMTRenX_g6jBr3snv5mC50gK2HwCHHgWVjQU-4Dwfiuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MJYjlX/7Slmk88ej"
Content-Disposition: inline
In-Reply-To: <CAFLszTiMTRenX_g6jBr3snv5mC50gK2HwCHHgWVjQU-4Dwfiuw@mail.gmail.com>
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


--MJYjlX/7Slmk88ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2024 at 02:09:47PM -0600, Simon Glass wrote:

[snip]
> > As an aside, please review the ti,am625 stuff with some TI folks, that's
> > both far too specific (you're going to need to add different am62 and
> > am64 and am69 and j7... and on and on cases) and I forget if there's
> > some work to have a slightly easier way to know what file to use going
> > on.
>=20
> Well, perhaps they can take it over and get everything working? I have
> done the hard yards, e.g. supporting two builds together.

While I'm still hopeful about getting TI to run our pytests in their
lab, currently there's not much hope in getting them augment their
kernelci lab (which I think does use labgrid not LAVA) to also do
U-Boot, so no, I don't think they're likely to pick up and work on this
part. Given that things are described for binman I thought you might be
wanting to look harder at things there.

--=20
Tom

--MJYjlX/7Slmk88ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXW0QACgkQFHw5/5Y0
tyy5qQv8Cx1WKavs1dpd6s9XUmas4Z05E9vEC7jFN60/YRqWjeeIMqD7Ho4Hnp8M
6jGDpS7eJZPgzEbsGFmrtAzwH3mOnuA2FKRFpSs/OtAGfpTb5WPzKmAUlAKnTOH/
XA0UxPv/NUvcy10ZM6W4tP75zl8u8e3zDNgSnITlq6Kbpsm3ZxZ2YaMluERiD2dy
2zNZ63NQYu3wMtlNtnVcADAv+BLYeHvYmcJIRKTFYiRAzkROWVvFwudgUlh5rDW5
xtwOR44XpbujLqdPlDeHAc4mdS4oOKFSwm4D82EailcgNZbW1tmchNWT79Rbi09C
kcTXhd5fHZIYv5PKSL6Mj+iH9vwjhOV8WzJQRWrZXSVuzstKAF53AE+seI6s2n8G
3T8RccpSncL/aBrfFDt43ltFIKroLXAy4Ybo2SBbF6OIzOqkT8ujxcSlBLy+MYMc
R/x5/aTcQjnLejBRwhCBbR6kMIzMs615VKvC/jhOnEDbAZyX/y8SXheagvVUe1Sr
2DAR/uUS
=Xxz6
-----END PGP SIGNATURE-----

--MJYjlX/7Slmk88ej--
