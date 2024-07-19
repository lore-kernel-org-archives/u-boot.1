Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E10BC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E163A88B81;
	Fri, 19 Jul 2024 17:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sgXZfZOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3ED88B8B; Fri, 19 Jul 2024 17:12:46 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CD888005
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d9e13ef8edso1222538b6e.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721401963; x=1722006763; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=esz43Ta7zVl9mw3ppCZKoaOrPOLkcPPtrA/c2OtokTg=;
 b=sgXZfZOTyOS+GnDrrEsOkn+UDP9CgeQlZ5E+S9FaxGjvR92ggMoEIAaotSz197U+4P
 3ie8CopnCbRTweRLD9POXyKewbETK/Wy8ueapSMqzb8+No9yoJaNsezKbrmtkweAgtxP
 jWpgZW5xzjOqR7Q1L9eum343nefwPmjyS5tqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401963; x=1722006763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esz43Ta7zVl9mw3ppCZKoaOrPOLkcPPtrA/c2OtokTg=;
 b=RQU+AMOM3O2RzhTOoO6yTkdf59AMs1VEoR30/kHs+hbV+dJYnWaSqK3dU54WbIdHBW
 I42J32v4RdSfAC/UDZp+8ZfwZe53w2VO2YTKIyj0Lg2gWF6rEit74ICu138oAQ5yIoq0
 JVBzLNIGr4bCPgXa3rI92FPflIvDmJybPo7Kn+yTLmlrtvX3LROp7nl1p0gV7bfHB+bU
 9xemQ3vvc95WtwitF6SFasC9d0zdMgb2gH6vPJDkTHCqZd0B3kzaAOVronpNKLoAD8o/
 smYKItJLv+0PbZnyfN+25zx2dYoT9XD2BEWQMqZqmqTEcKopyNTIsUPBchulxmyNUiEV
 hHHw==
X-Gm-Message-State: AOJu0YxjI6UgAJknp3g90FEUPuqrbAH+911Vi4hZiKGLSI+7sxFgW6Ji
 lwnGtc6DLWMWVD5At/GypT7LZQ6Ld3Y1rv1VPH+CgD5bixqr+CHPvXYlADSkqFI=
X-Google-Smtp-Source: AGHT+IE5E6oR9+TPijHpoDtMVXjF+W8N6PgQkrfhmI01WLu7+yqYohUfYazQotWMIxNDuZ+T4e4zPw==
X-Received: by 2002:a05:6808:1595:b0:3d6:4eb3:3c54 with SMTP id
 5614622812f47-3dae629b9a3mr117252b6e.11.1721401963269; 
 Fri, 19 Jul 2024 08:12:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f617399csm315996a34.60.2024.07.19.08.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 08:12:42 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:12:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sumit.garg@linaro.org,
	jerome.forissier@linaro.org
Subject: Re: [PATCH] tools: Add script to update git subtree projects
Message-ID: <20240719151240.GA561963@bill-the-cat>
References: <20240719141245.49186-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="my2T8t0Dm6qPKtaw"
Content-Disposition: inline
In-Reply-To: <20240719141245.49186-1-raymond.mao@linaro.org>
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


--my2T8t0Dm6qPKtaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 07:12:43AM -0700, Raymond Mao wrote:

> Recently we are introducing multiple git subtree projects and
> it is the right time to have a universal script to update
> various subtrees and replace the dts/update-dts-subtree.sh.
>=20
> update-subtree.sh is a wrapper of git subtree commands.
>=20
> Usage: From U-Boot top directory,
> run
> $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> for pulling a tag from the upstream.
> Or run
> $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> for cherry-pick a commit from the upstream.
>=20
> Currently <subtree-name> supports dts, mbedtls and lwip.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  dts/update-dts-subtree.sh | 48 ----------------------
>  tools/update-subtree.sh   | 86 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 48 deletions(-)
>  delete mode 100755 dts/update-dts-subtree.sh
>  create mode 100755 tools/update-subtree.sh

This looks good, but please update the documentation as well.
We reference dts/update-dts-subtree.sh in doc/develop/devicetree/control.rst

--=20
Tom

--my2T8t0Dm6qPKtaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaagmEACgkQFHw5/5Y0
tyw+CAv/X7qZVKrPJJgP/jY7/71BC+vMkL2oPh8TdgzTryHlX7qaiaIf4NsR9zzQ
9MW7L2prXH4QUreqmurXPY1pms2YNay5fN/ein8qJwrQWMIBxBI9XR6zadogxrmI
Q7U6YqGGDNfgvX6e69juSBJOHPOYdkDTQPv1zffNSj1uyYN8gou5ihoqAo0DU7t1
mQ54BAxJAYat01nyn3E9AcgJRqEo2MByNC0cbHyPKriHK7fMhaqcV0Pv2AodUDHe
53pgoH983ONHN/+ZY8uRMfaJKAF1uePdWRq4oK/l38HUiSFvM+eZr87NlQDt+b3/
rm9skYtQlULRuHLdX15moFNQMxGTNW7FQi5hkzVZvg+WLZFkB9t/3NClMPKq7grr
j6cff0aDRIRsECYle9lM6HJF6moCP1N5IZjd0o7HI+0R2F59pRM/IxCXH5tiET5w
j6LrIBf1YJJAfoRBVDCHmxo+mYqv1BWwsZlj8Wp3TDXdkFUVBqpfdkAi2WRjT0yT
yY7flh6u
=WhTY
-----END PGP SIGNATURE-----

--my2T8t0Dm6qPKtaw--
