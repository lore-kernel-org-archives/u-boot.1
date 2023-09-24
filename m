Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AADCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 21:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF8286B16;
	Sun, 24 Sep 2023 23:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BBRV0wUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7172586B26; Sun, 24 Sep 2023 23:14:57 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD5886ACC
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 23:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59c00b5c8b2so62068247b3.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695590094; x=1696194894; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R40ov5YIjNDajsTSxMssT4YhNhCEXXXmNbqEkDq/NW0=;
 b=BBRV0wURksEE9Hj7Tp5d7g+F6rI7aRU5v25AbihQvpNw9M0YZ7MnSrsHSN92OexlsU
 YYcD6ktNr7pJYFzXb5TRWPgVFQ3DAYcQbB84gIWTGs8KtQKdRUDBBgX3TbJZnMlm3EO3
 2h1OtsBY0ewSehiF3YksDt6h4dL8BoIKS34O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695590094; x=1696194894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R40ov5YIjNDajsTSxMssT4YhNhCEXXXmNbqEkDq/NW0=;
 b=R7GrUoXJyOAHRbMRkbED7tUZqmUEdhO+fh3TZwpbMP8uUcZJvPs0g8gG/z/q0HypP4
 mAfnkDt9Bl96Q927hdHU+E4z0TzJIxhj4EY152vITswORYtD9vidsGm3wU8CJp1+iQqB
 r5EYXSSBIa7oFmvCgc4ivFVlTe69J93Qo6nJR+cVz2LbzLLBq5XskY5HAv1p32ELqxeR
 T+M1SfxpJqvbDc2B8M8NBh5D3QPeVMmA+dMSrQ+cQYhQvXcnEl3LoO/VflYYeQ+WYfEn
 3OIKr0jLq1OQrtpVwGJa8Tc5xJ6Xc+JinCDGJVFMsVDwihCtSOqHjWVXYO62xAKJEbNR
 rNmg==
X-Gm-Message-State: AOJu0YwYs9hA4qKbrYpb7vB34gRWptDU1z4661zg7JmXLdurutKl0oRc
 IuKv3xbfnVAuY0RmrT7rmHeL/Q==
X-Google-Smtp-Source: AGHT+IFDlzKe+Wa1UIaT9m+iT1I33qjmbm39qRUraXtjZfvMj4RWQFPTYHOAQnQMP4ALtvgQlpHcag==
X-Received: by 2002:a81:b65e:0:b0:59f:773a:b14c with SMTP id
 h30-20020a81b65e000000b0059f773ab14cmr1413234ywk.37.1695590093895; 
 Sun, 24 Sep 2023 14:14:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 l188-20020a0dc9c5000000b00595394ba941sm2081354ywd.81.2023.09.24.14.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 14:14:53 -0700 (PDT)
Date: Sun, 24 Sep 2023 17:14:51 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm/next
Message-ID: <20230924211451.GK305624@bill-the-cat>
References: <CAPnjgZ32+7B0SVvpE+r_c9ZyCXpkFErRJRf0uCAx-aCMuJc2ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Tg+pD4OBAzOV8Z1V"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ32+7B0SVvpE+r_c9ZyCXpkFErRJRf0uCAx-aCMuJc2ow@mail.gmail.com>
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


--Tg+pD4OBAzOV8Z1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2023 at 01:52:55PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> This is for the -next branch
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17836
>=20
>=20
> The following changes since commit b05a184379631d13c4a49e423aa1324dc1ae61=
58:
>=20
>   Merge tag 'x86-pull-20230922' of
> https://source.denx.de/u-boot/custodians/u-boot-x86 into next
> (2023-09-22 11:16:22 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-next-23sep23
>=20
> for you to fetch changes up to ae84514feee209091d331a8baaa344ed8d8e905b:
>=20
>   kontron_sl28: Use u-boot-update.bin instead of u-boot.update
> (2023-09-23 12:31:25 -0600)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--Tg+pD4OBAzOV8Z1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUQpsAACgkQFHw5/5Y0
tywfxwv/cLvI+CEaslGC4xWuz99C6VzvYlD0wCY7sUwhJWvsIMCRHE4wbnFYZJx3
Rw/2etxIHUolX4mtpRT9f8k1pzH3wd+0KF7DCpZpo64OYQ80RRXRmGsZmJeCeNC0
P9Ol8MRmOghgdNkhStp/rtUVmmZ/Bunw8Opa73EgGdcNQ63jBQVH5Rhon7lyfczl
JUGuWz74/yj9QzwLgSFVhn6hmmLwl5+rub4b+1UQka3Cv89LrwmfdGRo4Ogt+6Nl
Zr2ExEZVxrKPv3Va9CPSNxRXtV5TOJFM0le1IiQw0WrPpTB+3KExgI/495MrHsxx
CXEtJvAcA06gPXp0A0Cm0cs9v5+sMACf+R2H/3xnf5Z86q2pf+xycBaUZCDYhmEK
JRFsazb38sxOfY2M2UyQYjyeDRZH3aQ3ZAstetYPCx04QOs+80dw9u0IlpiDb+Wh
quf9rILBkMSaBcj5fgScBl9NBf6n8TMydl/bt7maV5HISVNHjIfVcJ3/rPU7rTuT
PX2riYfd
=PHoE
-----END PGP SIGNATURE-----

--Tg+pD4OBAzOV8Z1V--
