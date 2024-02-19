Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEE0C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 17:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2343787F27;
	Mon, 19 Feb 2024 18:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WhSgDUbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC5787DDA; Mon, 19 Feb 2024 18:05:58 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B43887F4B
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 18:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-60495209415so42918087b3.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708362349; x=1708967149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fq+gVZksoRTysesvie9ffhT6dUVPQAYRU0Pg4xpCOzM=;
 b=WhSgDUbdZCFZtjeexpYdDWgFmhIYVvvjcmIa13iJSysaYp9k/5ZvTDafS6QCR3Zsyu
 aCTPf7xJD2ecdHno3RVKJLltQIUgkUJ2J9Vj82S/L2uTc6SnoECMfyYF37/TydqWwtG0
 sx00Pg0rKKh/fpJCWU5TULU0z/iIFqQ2kJ/mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708362349; x=1708967149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fq+gVZksoRTysesvie9ffhT6dUVPQAYRU0Pg4xpCOzM=;
 b=EpQup/olmVZSwMIfOhHGV66dWlA+ro/pmXbpny6Wdrz+F72z0e5hU8ntW6Js3ST0uO
 VoJxW8TA5XHyepROuEISX6if2GaGJ1utVduGQ1kqCZVJNuzSguzZHUE4sKxiw+z+tXbw
 tzpScE3Y4pcBLo1YG/fAsENvoh4q4UgjVSGHwjhhcheisjCWbY7u3woDlSkF+URlqlqP
 gc5iBle3oYvBGtNW9k6Wb6Bh5US3IhSzpI54eIXu8zLKQFYSbaHe0HedZn8l9aiHIobO
 ytIEiOayMoCqHFAxaALYdfYL6GsB4SDY7WYt5q39cS0yU/AXzcWPbwUAhPG8nMDuT9ia
 L37w==
X-Gm-Message-State: AOJu0YwAsJdnIaHwIZBuy/xedK1bFHb9xstFaXPJWQB3TrMKZz+gLiL/
 GqocH387vqPa8ZU0Fq0doUjM5cAR7UawcP7cyth7QbicfUl4i5FJffOy1HIJstH8QfkhtvGSB7y
 h
X-Google-Smtp-Source: AGHT+IHz0LAE66GiSGTvUWQzisBIWbzTSUn5A8VQj5vYH6CrO7Zl6Jc2JhzO0F0f7jdu841S9Brp7A==
X-Received: by 2002:a81:4853:0:b0:607:8472:f33d with SMTP id
 v80-20020a814853000000b006078472f33dmr11306386ywa.25.1708362348740; 
 Mon, 19 Feb 2024 09:05:48 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 m8-20020a81ae08000000b00607b6c0065fsm1703885ywh.43.2024.02.19.09.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 09:05:48 -0800 (PST)
Date: Mon, 19 Feb 2024 12:05:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240219
Message-ID: <20240219170546.GM3040305@bill-the-cat>
References: <20240219131006.391634-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hB5obqd0OOw/Bex7"
Content-Disposition: inline
In-Reply-To: <20240219131006.391634-1-festevam@gmail.com>
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


--hB5obqd0OOw/Bex7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 10:10:06AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx, thanks.
>=20
> The following changes since commit e4013bcb10f604ec1dfe955634d57e1fc336b1=
5f:
>=20
>   Merge branch 'master-porter' of https://source.denx.de/u-boot/custodian=
s/u-boot-sh (2024-02-17 18:37:07 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240219
>=20
> for you to fetch changes up to 0cfc2e9225fb682a1a5b3e5d49af8ebf8d893cef:
>=20
>   doc: board: Add minimal documentation for Sielaff i.MX6 Solo board (202=
4-02-19 08:19:39 -0300)
>=20
> u-boot-imx-master-20240219

Applied to u-boot/master, thanks!

--=20
Tom

--hB5obqd0OOw/Bex7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXTimMACgkQFHw5/5Y0
tyw/PQv+O4VrSrHcWrWNi/qL3Aekvp5uaohkBZWnI+UMKlzRO/QqGmm5sgma+pwW
4ZAFbqZlMwHcUgDhrRwu5YWWD4RwBSmbiuf6A+0AVv9+Ah9vJ/5/yrU1Dj0sZxYD
8p78+cHXQMPIJtCNbNn2AgNgiCg8Qwu+3SOFYJaFZcQojW95qiPkrlkWaoJTXqZ6
AvPtYXLbAhzJyzWA+VxyTE+cfXn/TsXJtnlenshpa/V1tqzSsTEK4oKzsa3STcKG
wygoW0f0oEh1zrJF8PAwT2IbmPZBlXj2kOo2/QxjY4IxDj+E06YXGnLUK1PNUAtl
Yv8rysID/bB2OyCGn+elIB1hHk7nuTwSSJ93QzdrdUcWRX+2oqdv9ydJxudb27iD
f/zRDFjF7Ff+Lrb/2BhHgIHoRoDTtCg403sSPWLzZEQrasBKvMFezi6p2mlpLGt1
86u87J+A4tNUvl+878kdN+Uta3/wyAFfx8EdJtlzeFNXv8r1tOSrireLLsFGOHUl
dyZ1YDYe
=MM5K
-----END PGP SIGNATURE-----

--hB5obqd0OOw/Bex7--
