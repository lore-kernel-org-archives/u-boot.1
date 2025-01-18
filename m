Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121F1C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 16:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67ED3803CB;
	Sat, 18 Jan 2025 17:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QAoavsgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B4E8063E; Sat, 18 Jan 2025 17:40:45 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F6C80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 17:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d92cd1e811so38920776d6.1
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737218442; x=1737823242; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vXwacP9hLNlL2ytZg+igpjx4VrSNnrKFonJU89HH7og=;
 b=QAoavsgj2Va+hsH1YbvTznYsKm8/BXDCxoi1W6Yivdg30jMrbLg23QRj9f4N82fz5F
 c6ywivQSrqO+odXm46D4zBYCSVI4nMWKvV9Fqg2NEieFgJ736+DLZr6cpg/m/Hm0V8KY
 Bbku+7c9bYPF0DYtxQEtcbdNs2Rb6ZdAX/lvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218442; x=1737823242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXwacP9hLNlL2ytZg+igpjx4VrSNnrKFonJU89HH7og=;
 b=sHuxKrI0AmHPmuHjFTCCoE3aOkw/kGzG1Chn20XKiuncXEheJtC3hXeoSJgbrZ2w9P
 M30H0/s8nGhhsmCoFjk/YXioF7iBn5HQmr/34Si4KBB6v+9da6xpDTX/451lU8cWBKtm
 82J0XaWQQiEJJW5VKHe1TpEvCKnJ5oELZyqbZLS9/pPfwN3wTXQHRTZBnG5saPWOgQaz
 xu/MNZSvR6Xe6hVhF2KIRzih8mnCUfX6avKid1yNXteqRVeJfbZ2yLIQRHSI7GPvWPCA
 XSgmL0IhCqN34p7ed1prV8wW8B/M4lMY2mUJjn2JKexR0zww6NZodnVEenSDuA0Cguza
 JfGg==
X-Gm-Message-State: AOJu0Yzlrj3zM9aDtDOXXteJrhC0wH1hzsje1UUGfPCqAavuoLQwEp/l
 Wuo9Z4Kx89G4942AbKV5Cpz1ao2mcysdLr9K9TCQCY4MOhF1Jb3CkDBll0quyD4=
X-Gm-Gg: ASbGnctbxwUtA9rAEXOvrPSFHEAycDKk3hWbgF67+EcQcJRL0JPxdzrPl0gf6gekZTq
 9qTaxTCqLwNTgKFiH7P2awtw96Sa/9BylRjONp6wP6wHASDY94skvE4ZtozWlqhQ22AVgUSK0m/
 Ou8FY4vsZPWTj3yJiRJf40SrwRHvEyZTnhbonGLmL+4DeYKzk9Y2f1mhcNE3KqocQqqhOgXd/6k
 p7WBRnih359ZvxqSPpD/J3fSvK2a9qHUWygCE0j2jkwd3qCoDTKDWr73HheOmn53WA=
X-Google-Smtp-Source: AGHT+IFK2Kn1TAWzU7y4TkdFvBNyJeK2GD8Z0TcaJrnDAdY3+3lj9XiAI/IkNYf1CHvc2ECimWvY1g==
X-Received: by 2002:a05:6214:5b09:b0:6d8:8a0b:db25 with SMTP id
 6a1803df08f44-6e1b27a47d5mr118257456d6.21.1737218442331; 
 Sat, 18 Jan 2025 08:40:42 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3783sm23150766d6.7.2025.01.18.08.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:40:40 -0800 (PST)
Date: Sat, 18 Jan 2025 10:40:38 -0600
From: Tom Rini <trini@konsulko.com>
To: 1425075683@qq.com
Cc: u-boot@lists.denx.de, Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1] arm: Remove redundant loading of image copy start offse
Message-ID: <20250118164038.GY3476@bill-the-cat>
References: <tencent_78F00D5010A6F5A48D0F464FC0E026DB5906@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XfbsGWCjd3bZQUsh"
Content-Disposition: inline
In-Reply-To: <tencent_78F00D5010A6F5A48D0F464FC0E026DB5906@qq.com>
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


--XfbsGWCjd3bZQUsh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 11:39:18AM +0800, 1425075683@qq.com wrote:

> From: Liya Huang <1425075683@qq.com>
>=20
> Remove redundant loading of image copy start offset.
> Because the beginning is already computed
>=20
> Reviewed-by: Pali Roh=E1r <pali@kernel.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Liya Huang <1425075683@qq.com>
> ---
>=20
> Changes in v1:
> - Due to an error, the patch was resubmitted, leaving the code unchanged
>=20
>  arch/arm/lib/relocate.S | 2 --
>  1 file changed, 2 deletions(-)

I don't understand what you're doing. Please stop posting patches that
have "Reviewed-by" tags on them without pointing to other evidence that
the person in question supplied that tag somewhere else in public.
Thanks.

--=20
Tom

--XfbsGWCjd3bZQUsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeL2YIACgkQFHw5/5Y0
tyx8WgwAgUkP11uom+Uqv34xEtsSEtuNq7qKDmgUL/21v+yqlGCI1DimDOLO8Qda
4l5073GJeOpjj9hnR7U/OrT+K2Pjw6vFUQQSuThGwDuI9NridW5yWWCV1eyB6pud
pYBiT4OpuJoLbYCT/T9RuZJsa93q9VND4rWott8rCKnDEOzz4W0tCbBujDwGBfRD
46lIWA7SrRGNdG3jq1Q0iEqgRUBGr9huyBrSS7VnEZ85snQlMk8goCdo/Y7g95g+
8wZcnZshYj0bt3KQhO8ZB+Lyi35FzfT6YNIc4Oe/gCcqSiBZB5ENef0xQt9BMfTh
X6cStxyHP4C+PtQ8HFv+FM2H/Bvo9YWzNiGep5l5ZDCP74U7EcSAbfWtigZm6Rph
N2S8tZrCkRCUJa2Y+bhehAvHdU4+RA3Hqb5qrwolzFk/zMoYWNUgDALeGj2sspeO
qarxx9nOzhgFTyIUaPVZ45dnnRtaaQoT+JJQ3Vxwm19VpeKOaX670mtswOIvwUke
Lqf0PgI5
=sLTW
-----END PGP SIGNATURE-----

--XfbsGWCjd3bZQUsh--
