Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8128CC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 13:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AE6846FD;
	Mon,  6 Jul 2026 15:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OxlxHccc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E7D84852; Mon,  6 Jul 2026 15:54:58 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FECA846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 15:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e9dc546f40so2241324a34.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783346095; x=1783950895; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7s3tMovnAiNX4vLTd7IJiyVU0hU7sEAlqGybNhAG7VQ=;
 b=OxlxHccckK0djKqGMxdwFwRtFozaQ8hRlcD/HjTVccXQtI8UBPmQVVLQmz0OB7yJLU
 5wbYPOjMxTqxSr66Kj3J5ryJvuQQ3em5zok8XY33DSLyDiaxRT5xCmBVkWZCKnHQ5pnU
 TYirKfmY38w4OjRBoZLOq6e+ks32NURs7YwbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783346095; x=1783950895;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7s3tMovnAiNX4vLTd7IJiyVU0hU7sEAlqGybNhAG7VQ=;
 b=ZXxjJ8tbnMJYOrP8fK5jbibuzram3HRL3AcJKOOvie/ekz4uiyq4JS1WDYeWyy0bKM
 BcTlzYWFZO9tTdPyUCW5vDxQIiniU2Qgr0en5w8k1eAqkKo9jw0ojiGuKjlRVrvc14nV
 VP91y6lhdhS0SpbA542OqxVeyheE6E9Qu3bB+dWILtxh6egFvcMxrg93u0Z+yfspoI8t
 mLi711r1jrrLf6sl/FAXAzt9zGf4nOObQqWtUEHVJEtblpd+lksts7le7H3S8wj1m6WJ
 wtcE1tMIwZnsJkxcpRUSl2y/GVG4t39YnPbQ9hVaMtJjJZ9oi/DyRhrkaKx0U22vj22A
 GoIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uOCGFX0x+bwqP+HRRLvRhUlo5GUcW8BjcBCmzEspOrD+qtwNhHQY0e2tGmOS1aMleh7pLsqs=@lists.denx.de
X-Gm-Message-State: AOJu0YwBhCa6TXrQKMFJMYjZBKv5YvtYrcIcLqxtB+8+e2Oypm6QaBwA
 JiN3GpWaIYjZ97uD7nO4TGCuCDyoRFOrRUX1sR1ibN4nqDi5RhA6LCYQyohGk/XGT3/eexvxxZD
 nBTaFTFA=
X-Gm-Gg: AfdE7cl5tsALbRdhgz2e71GB/M0nKTCd1JrBqYG9zn4kD9IXyxVXngajkGhVuVMLVv1
 RVrSOQ+ATIR7FBjxAojisVbHllQD0bqlfmXRN/iuyYrHd3tJb/+cvlGW51at42BjYHNivg+o9QM
 FuidV4Z4pg4fAkowLZzQGOzqchR8w1D5dYnUEnfXQGZjY+riXoXWlP9haP7t9WlqajK8XFUOm9u
 7JTOfVSu6i3lNSlyH3560svDPS50iFBdsgI5mFO22zxlx4zEELPklphdYZzZuYbWNksEFSe77rB
 EbjgOkcao/Ck+rgXCYMpVLdO1UczZHdgjlCA6pmb9uPZ3SlkVvU3d9ZZ8+ZbeODYIyO2drcPMeW
 Bbac7s7XqrVvOZ63vbf3fhhTFebrpDQsr79/We7+9Nn8uLJ23LRAhMXXS5BDTpF7rIDe9WxvvKb
 ymV0Z1QaJBXxtGaqK3oy9288CB2NSOEBHPGDBhchVanwWyAfO8uphkOnkoA5QJdoRUZsxhb4OXv
 PlARR16KMZY6+zjXyxWf98NyzMfNRPwJi+Iq+fXGPbHGqzG
X-Received: by 2002:a05:6830:3e10:b0:7d7:45b7:ed8a with SMTP id
 46e09a7af769-7eb6845a6a5mr5178277a34.5.1783346094620; 
 Mon, 06 Jul 2026 06:54:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb544ef7a0sm11743564a34.20.2026.07.06.06.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 06:54:53 -0700 (PDT)
Date: Mon, 6 Jul 2026 07:54:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, kever.yang@rock-chips.com,
 jonas@kwiboo.se, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH v2 0/7] ARM: Add RV1103B Omega4 board support
Message-ID: <20260706135451.GU749385@bill-the-cat>
References: <20260208212624.3413494-1-festevam@gmail.com>
 <CAFLszTgP0wCfQOZ=DJhbdPWC4k8e66XmNtF9cO8z97oqPetdRw@mail.gmail.com>
 <CAOMZO5D9NuWVkJ3PH1-wmTmvzq76=zrEKEekYozoPRY8ZjcrpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g0CPuG6LIjGAz2A7"
Content-Disposition: inline
In-Reply-To: <CAOMZO5D9NuWVkJ3PH1-wmTmvzq76=zrEKEekYozoPRY8ZjcrpQ@mail.gmail.com>
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


--g0CPuG6LIjGAz2A7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 09:31:11AM -0300, Fabio Estevam wrote:
> Hi Simon,
>=20
> On Mon, Jul 6, 2026 at 9:27=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>=20
> > I recently got one of these boards and have it running in my lab at a
> > basic level (boot to prompt, SPI-NAND and MMC).
> >
> > Are you still planning to send a v3? If not I could handle Jonas's
> > feedback and send out a v3?
>=20
> Please go ahead and submit a v3.

Until the situation with u-boot.org is resolved, it would be better for
you to handle a v3 Fabio, thanks.

--=20
Tom

--g0CPuG6LIjGAz2A7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakuzqAAKCRAr4qD1Cr/k
CtvJAQDfSnrvbDWGAfvFu+m6TLlWgf4FJHW5NmFOYC2vgCV41gEA8X8jSJRPGSiy
oK2siTCBH7nNLw0Mw17L7Hj62G/NrwU=
=AOi/
-----END PGP SIGNATURE-----

--g0CPuG6LIjGAz2A7--
