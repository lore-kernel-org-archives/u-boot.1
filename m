Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9736C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 16:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7D0812C8;
	Mon, 27 Jan 2025 17:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TIQz6i+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89D881417; Mon, 27 Jan 2025 17:08:50 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC52B81292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 17:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8ece4937fso42048346d6.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737994127; x=1738598927; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vHag+rTZiEpO/94GBrLDJqv9D4wZIyoid4fh1tQNQQg=;
 b=TIQz6i+A79WY46Rnq0OxX7EcxG+y16uCKtjTP8vlbjtKK4LiNdxHyOBPLoVpoqExV6
 gV+TGomrZIYIU9rio6eDQ0MKLoI8KB8YmExSsOoodOznujh0SYGiThbZb+jibWzpNy8d
 QvL1Gl2CIJeqoeZfGwacw9T5ZOVz4McPbUPJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737994127; x=1738598927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHag+rTZiEpO/94GBrLDJqv9D4wZIyoid4fh1tQNQQg=;
 b=Evy7S8tJp65+jxyoNkh7A4KbS4R5VshMm1xctPLnzApQdOMpYW5/3UP8DFNt6IQgEq
 5Gp/ltu7ZieMu/tZbt1N2iJdrd4Sxa+os3udKJn+4VlUmdn//B7rrpptqAvsFeDYXD7j
 G0dN3xKlPIteUYh+CUBhaSaetxWvVZNo7AriTjr9eQwoppdmVe3kSYkFIHoZIwRvmlZn
 5uNG/1uduhdPlWuQPDpF29a7rp1hI7w0HKL2G4KnfKv/b9bRuNS0sxUoghjdIK68Rheb
 2bMK8EMSx/1WKLzEFxuvZoDcyJrP7llr5SBIH1KDadRq1ggkwMmbM53fE9kixg1hVzbt
 HMYw==
X-Gm-Message-State: AOJu0Yz70uDnw7dGpniX8MfwYddKyafNLxsDK0WLiObm0Hk9lzOLDwvw
 tPHspWGEzaGEMTVlSKGY0UqJ6srJ1RINg13mbTGP+mSRPD1z3/NEqZL0soXnvaw=
X-Gm-Gg: ASbGnct4aFgEJj0qiwlqwsxQA2KUjWFytVEKSeMKTAUiPwj3tn4JNyVs1aaO8lHITlv
 DQJcQeO9VeyxCPnVsJt/f9eW+ftF7g6u7rGeEhS7VL/7KcyA8cIMeCLKfZkTIJSdeAbMHZTXteO
 oHrzPdTQkGglHLEjRS+b4GkUE+FR2XJiZV1jTzsyBiiQ3cm0k9h3WZDDka6rUSI3Ewz/54NX1eb
 desCEhQbmmN333LTbaCmkUdYg6gt3ywfZSY5NsK/PMPJWzy+GVMzuuZyxLUMRwAhJXDqsCZ2qwk
 W1Ph
X-Google-Smtp-Source: AGHT+IHR3nVxNmk8K9DXTKDr2yJDxBXjStxins+jpudby6/3bKZGAR6C8A3T2Dtw4gTnfD/tq9v4tQ==
X-Received: by 2002:a05:6214:2a4c:b0:6df:97a3:5e5a with SMTP id
 6a1803df08f44-6e1b224cf9bmr704720936d6.28.1737994127605; 
 Mon, 27 Jan 2025 08:08:47 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c2328sm35832736d6.95.2025.01.27.08.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 08:08:46 -0800 (PST)
Date: Mon, 27 Jan 2025 10:08:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3] test/py: Add a report show test durations
Message-ID: <20250127160844.GE1233568@bill-the-cat>
References: <20250127145256.1133143-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0cwb7jKThQRnjXo2"
Content-Disposition: inline
In-Reply-To: <20250127145256.1133143-1-sjg@chromium.org>
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


--0cwb7jKThQRnjXo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 07:52:54AM -0700, Simon Glass wrote:

> Execution time varies widely with the existing tests. Provides a way to
> produce a summary of the time taken for each test, along with a
> histogram.
>=20
> This is enabled with the --timing flag.
>=20
> Enable it for sandbox in CI.
>=20
> Example:
>=20
>    Duration : Number of tests
>    =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>        <1ms :  1
>        <8ms :  1
>       <20ms : # 20
>       <30ms : ######## 127
>       <50ms : ######################################## 582
>       <75ms : ####### 102
>      <100ms : ## 39
>      <200ms : ##### 86
>      <300ms : # 29
>      <500ms : ## 42
>      <750ms : # 16
>       <1.0s : # 15
>       <2.0s : # 23
>       <3.0s :  13
>       <5.0s :  9
>       <7.5s :  1
>      <10.0s :  6
>      <20.0s :  12
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0cwb7jKThQRnjXo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeXr4wACgkQFHw5/5Y0
tywNXwv/QC9dmP3jEoPqaYs78RcTEDXyoFWOTuU/DV8VyNt/GUmcUUj2+k0yqknh
/pjeCuzS2q35TShqXXXNandbwtWHCqw/4UBo+s4tEQf4Dyi6Yg5TXK6ae/9Uui9e
Vy9AcIjHJW+G+AjrqvKhVXJLRLwNUiGONxRI6VyyH+9Br1u+bRPSIAVadwuUmilZ
v1TANft5FdNKlXnkV6gJ8v5Uo4RFzm72bR4BB22vZHX3Gasvli/OfNd30G31hAGL
hKSEVjK69WxmSNxaLLW8p2Tj8nGi1TKiB0W48IgtVcHtWDvYsrHspzlaw1RVjDoW
nTeP7iDiiRqk9Er+o1jufVae9wWoNFVRQEfxiKwNPAOmPYlNkWMoo8UXNlkP+AC2
4sJqJAiF8Ls4RAKugQkC0Ll/cF62K4oqTBopmEtJCSLHRdIZWp4//TPoakFZl1EM
n7eG5E1c0NgYp2pN41RBAs0ZldTUnb4SI6z3xh7aVgYNu+d0z+cUnUSZAbYPK8RL
bCIHMOTF
=6RpC
-----END PGP SIGNATURE-----

--0cwb7jKThQRnjXo2--
