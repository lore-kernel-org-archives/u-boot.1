Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44038CE7A8B
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 00:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3DC886BA6;
	Mon, 25 Sep 2023 02:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lYrT2kqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89ED186BA8; Mon, 25 Sep 2023 02:43:52 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800D786B03
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 02:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d815a5eee40so5944568276.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 17:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695602629; x=1696207429; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5lqgJBCXaS60Y4TITUCCNxwMiCVkAtAODG7gHaJgp2I=;
 b=lYrT2kqIcTY/aWFByB9sS0441hhff5vuSwPWkXtejpeNj8XPVp5tJeMwL/qj07Qph+
 ysfpFkBTbQrqf4nIbZr+8LwvVXfK0DMXqPZ666zEpOuEwG5Pik+0kPMSz7jo+DNqsPsR
 YuGT1AAQrCF+9BbaoeGKxi4mS+zjDWRw94u/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695602629; x=1696207429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lqgJBCXaS60Y4TITUCCNxwMiCVkAtAODG7gHaJgp2I=;
 b=q5xH9uWWPSSBiuRQugPPFTkjZI5C8AH0grjbac4eYTO3fKUwjXlq2+vE+6AkHK37IM
 uHFcy5PV7wUaj6Abs4lJbyFfOf5g9+8+ukY1ki+lzCh5rj2Y0A+O0nkRyPRNb9M8HLwS
 6jfAIdHPK5UT6ZI6lPiDKbkfPuQ0m6Jaq6xOsz9/PmBhxopOrNi2MSta+Q8vnjQQ0mXy
 vGeqzW/GC55Bd38oDcf1kK2j7N2zp+8WsvzVxUUZAFnPAZU2lAE+wtZxN4PFZ2BlxhtD
 izCQ9zK+q/RgIt0De8NloqaaV4rDhVyrndVCkmxCL7HUnNJrSaaeDXzDvwBJMoa0mMp0
 TDYw==
X-Gm-Message-State: AOJu0YyAi9BApXun2dwnrF+2I8/DLNbQJMQQV+qUFgbrOwQne11Y7G33
 BBzBvLRlZzjsXsQz0MiwV9Ozaw==
X-Google-Smtp-Source: AGHT+IFJ6ooU2YGmUuH6/7COKWCuRO5KFN4VFnbZ0fVcU8E5BSvsNq6Ud/OdtRVOhFjqu4GLHNElGw==
X-Received: by 2002:a5b:7c8:0:b0:d0f:6f1d:89ec with SMTP id
 t8-20020a5b07c8000000b00d0f6f1d89ecmr5365302ybq.35.1695602629285; 
 Sun, 24 Sep 2023 17:43:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a258c85000000b00d72176bdc5csm1110365ybl.40.2023.09.24.17.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 17:43:48 -0700 (PDT)
Date: Sun, 24 Sep 2023 20:43:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Warren <twarren@nvidia.com>
Subject: Re: [PATCH 07/25] tegra: Change #ifdef for nop
Message-ID: <20230925004346.GP305624@bill-the-cat>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O0jP/vtJllrKR2hd"
Content-Disposition: inline
In-Reply-To: <20230924203953.1829820-8-sjg@chromium.org>
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


--O0jP/vtJllrKR2hd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 02:39:25PM -0600, Simon Glass wrote:

> This code is normally compiled for Tegra, but sandbox can also compile
> it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
> possible to disable UNIT_TEST for sandbox.
>=20
> Correct the condition.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  include/k210/pll.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/k210/pll.h b/include/k210/pll.h
> index fd16a89cb203..6dd60b2eb4fc 100644
> --- a/include/k210/pll.h
> +++ b/include/k210/pll.h
> @@ -13,7 +13,7 @@ struct k210_pll_config {
>  	u8 od;
>  };
> =20
> -#ifdef CONFIG_UNIT_TEST
> +#ifdef CONFIG_SANDBOX
>  TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
>  				     struct k210_pll_config *best);
>  #ifndef nop

Tegra? Do you mean sifive?  That's where CLK_K210 stuff is... but it
also seems wrong, you can run unit test on real hardware, and this is a
test that could (should?) be run on that platform.

--=20
Tom

--O0jP/vtJllrKR2hd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUQ18IACgkQFHw5/5Y0
tyz8VgwAgFdtOI5CafZNfhuZ384rE1lRtMVgSu4iQ+75ADwO1TD0bpRpPqv4bP0V
4a5W6J+9587PG8sn1TSuGM1rW2eFQ8UxTUdUWl4GxArRm2mJFmf5llGLuXSmG6gp
JnxRQ6CDfziVgMaBV4Q05YZ7Dbmbn5Z2II3ApfsSyeoy/iP01wJZM9Ie1Uvejj5J
idp5ZteVdjmLNggDn7DHdPSVVrTaqLC1SjGYOdcOFT0VcQChDOaB6SQlJCMKW7CF
u3Rbk3ZamsyNjkTR+yAc6qvNo49kr05wPoyqgWEuYvQ9lz+f6TGwmVkzmUFw1S4p
NX3WzPnLBHFXjjRSU3pvb7kexFUPRDjggwXBx8gdec1kRqz5C7xWQbhpO3syDbin
MjfXMDgkUfdeshL3NpkL0ZIch2RQweSQLeVyrdQY02mlu5D0d5XEzNkMCusEuXVW
6pvkCHfpO6K+9hS6FMIc3cnkXDjdALHPnEh9DdxE18DIEAf3Fnffzql/qPzFm3GE
lKzGOw0J
=arI5
-----END PGP SIGNATURE-----

--O0jP/vtJllrKR2hd--
