Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BFACF9C71
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 20:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7021588BAE;
	Mon, 23 Sep 2024 22:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gIHtRxwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E97E88BAE; Mon, 23 Sep 2024 22:35:36 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E2EB88B86
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 22:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a99e4417c3so425441985a.1
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727123733; x=1727728533; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lRPWmKSQaaM565AsWDdHjS58KUqc+I+kVlSJUlKl7GY=;
 b=gIHtRxwouq917l+szogPqM+Do62M+LrpMa4b6iTlXqT40SOIb94AyxNV1uzRDyuoqq
 t+ZS0Q0mg8xKEonkQZ3PTlgDuax6/mWGm5IVbsI63sm3aCrfBLgyMXap2VtQdR0Wkqz+
 CjM+4p7eqMigUINSdYfyCPp3DBMu2/AL2gBNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727123733; x=1727728533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRPWmKSQaaM565AsWDdHjS58KUqc+I+kVlSJUlKl7GY=;
 b=r4v/91In9selDrYMkjOtKNFaiAzHsDkdfAgCF58PtMwyb9KE0TYLMCFzPwClqCwN0c
 Mi4jlBeGlU2wb+nC67e8i/6oodgSPtuWm/Wu18HP3rZ/7KuoLO63L086P16NLrIhiVue
 O/eUIHX+pwHlnGfBfnlvTXyqO0iNhG7/5Nv0q3eRV6TKeZIU47nEJp0BC2+MNm4yv6Q7
 lmzKqSal3ltviCS1HNNdoArVjzGGDUYh0uPJToCoQKJXrdYZ/iPqoAboEn6bytTYwbOh
 nC6OIegaZdEGy4Ti62e0fW/UhUeDm1P3NiYf2xRsCEtAJWAhMR8ok/zd0e+1E28uNp0f
 9pfQ==
X-Gm-Message-State: AOJu0YzWKvNoywgyomaYLeHQUOhwa+4a/LWbjb47Z0/6xOsX7yVkMLz9
 ThQ5pTOYHqlq1K81MlC7RvVIyckVII4TPnzek/Rm+MAWg/rBFLyYq93Cc5p3giW2IqK816aGxHq
 r
X-Google-Smtp-Source: AGHT+IGyeU9pImLvvn3ilo0gI5Kf2bVhnoPTn/jskExrLNPAlmPOhQEbuByc4o20j8hjrbRk4xGquA==
X-Received: by 2002:a05:620a:4688:b0:7a9:a917:2680 with SMTP id
 af79cd13be357-7acb8222974mr2175160085a.64.1727123732903; 
 Mon, 23 Sep 2024 13:35:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde5cb9a6sm3210885a.74.2024.09.23.13.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 13:35:31 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:35:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 04/19] test: Allow connecting to a running board
Message-ID: <20240923203528.GS4252@bill-the-cat>
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fQO1jeQC1WAz0FVc"
Content-Disposition: inline
In-Reply-To: <20240920060158.106612-5-sjg@chromium.org>
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


--fQO1jeQC1WAz0FVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 08:01:39AM +0200, Simon Glass wrote:

> Sometimes we know that the board is already running the right software,
> so provide an option to allow running of tests directly, without first
> resetting the board.
>=20
> This saves time when re-running a test where only the Python code is
> changing.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  test/py/conftest.py                   |  3 +++
>  test/py/u_boot_console_base.py        | 14 ++++++++++----
>  test/py/u_boot_console_exec_attach.py | 21 ++++++++++++---------
>  3 files changed, 25 insertions(+), 13 deletions(-)
>=20
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index fc9dd3a83f8..ca66b9d9e61 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -79,6 +79,8 @@ def pytest_addoption(parser):
>      parser.addoption('--gdbserver', default=3DNone,
>          help=3D'Run sandbox under gdbserver. The argument is the channel=
 '+
>          'over which gdbserver should communicate, e.g. localhost:1234')
> +    parser.addoption('--no-prompt-wait', default=3DFalse, action=3D'stor=
e_true',
> +        help=3D"Assume that U-Boot is ready and don't wait for a prompt")

I don't think this is the right name for what the commit message says we
have? Maybe something like --use-running-system or otherwise make it
clear we're using the board as it's already up and ready to go?

--=20
Tom

--fQO1jeQC1WAz0FVc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbx0RAACgkQFHw5/5Y0
tyyiiAwAr/9uPo8V9osltgwtNfbQPf6uDwaIFGF0HgMcBL5H8ziTU8iHBPSZon7k
Gklk+KC02/rW/b6USlKKoRvd6zQVjIK77JuCOLqP8u6WSjZNpAyWEt9xiXcydHxa
ch+7LjLKEv8XBk8VPG2WmE5DRwFMiZ7MLVPufLpTJ2ieeK3OT0kB0Fn3bzDnaPDe
cXzEEpXyIwBiKr7kIJh59hycC6Bf0OxzbHR77G3SmK6cbgE5BBaTCwgv+ul/rp+g
2muzdNry3++k9LXr/7tghe3j+CkZoqOOjdjFTgjvpZWvdNf0tNOy6rZmglXb+7jv
crAdaQnzqdb96hur7gxpRnf2m86BS2KFbAHzknKZIpShlUJnWujAU8+36i3y3MJh
lJHn0v/CN2jwiBIJsL8MWvEFkFrzthIJ3SLtesGYWwTBgVw8X3jA5M2gPTJi6V/6
oHy3GWEqsN7LUTCnfRkd6sAgArcs6+Ln48MfV21p+YHONhG9q0MNBaOx6yB1GBBl
SPbEAYlO
=xTV9
-----END PGP SIGNATURE-----

--fQO1jeQC1WAz0FVc--
