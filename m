Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B773C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 14:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DDE2833E9;
	Thu, 17 Jul 2025 16:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AZy2o6XE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1DE833EB; Thu, 17 Jul 2025 16:45:57 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71F12833D0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 16:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73ce2761272so555607a34.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752763554; x=1753368354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7yyVGN5Hy53v4z/FNuEYTRIG+iNc56W7XgnHBWUhpI0=;
 b=AZy2o6XEmbz00M5+CIZH+qExgVDp7RdHDsCAuU8kdqbz86h/S0H81wb85xTWNj/8qs
 IyQTWJoB2eadkQcw1LFjo0JpX3WjRH74GmTU7cauOAqtIaXD0NrbXckl6XXkTKKQv2VS
 ybpJvNlSAkRKe6Hx11V9o9keeFBL2gIsXMvIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752763554; x=1753368354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yyVGN5Hy53v4z/FNuEYTRIG+iNc56W7XgnHBWUhpI0=;
 b=Hh0YS226r2it3gb0MWlteekS0Rqe/rWKtr4EYpYhxj/uVwE8Ty51E+/RfVPKrLr/np
 C2NBa0ug+peSZxzo0DDr+ltU9u5aF2qMcU8bxOvlppjz+T9fILf9s/98amKcHNFyxxcI
 AbPgRojhG5JaKmtolLTGpC72BPdQiA/9Yc83FqNxppQoyUNHmE1pFtrND9O15nZLs342
 +cAWMw1da2t3JoeJMk7+qRoPJ5VBMQTTHyqXzxaH23CahYg6LqLh6b7MBadIie6PVZOY
 NAq84507W9n+Bhu/TylnGzFvtSl9kV+RFqaNArB33QAVzi0NrRPqSpror+tnizFiK0C4
 G3Ng==
X-Gm-Message-State: AOJu0YwHIQACCBzY9RgRedFE2wZgjVcE49+4BWka5SYGeT7oE+V5aQ9p
 rDbx8o65sUjSQkQAn6FIK8jfhzxb0f0TYRy2Qet5DA35WtTm02AF0XRDb+XOleOBbB4=
X-Gm-Gg: ASbGncu0luMHBwWIDWeDBZyDTVws7oGa3uhOjw4dyh3kvjgJOuBEqHCBNWHYyndbGrA
 FKuU1FWcJ0ScgNSTdbEImZjpZoe0fCg1bTdiqEL7xE8kGGI8J9UQ336RkW52HErbK+ccWJ9yvwQ
 guLBiky1tbBjWl/Dk7i30Y3B4amaa1IRng+CS7LNVbv4G737DlpsDxNB1ua0IQutJ4T33P40goB
 vVlGyYz80boYqgpCNedJLFByxLnl6YgKNOfMUfLhV/YdyfZV0PDb8/ulXUAZGdymvOiAJs2IzeL
 Yty4nqL8y0b2luZJYpbTfCATfqceM8KAvCUyqlqGLD81Ml5HPmSNmukuOjlJv8KlDkS0QKieKyX
 /ouxuYJUqYQB6G4RJ6pGgLSZ0tIybet12W9opeym5JwaPRoS73DHajwXe
X-Google-Smtp-Source: AGHT+IETiiHdKX9DKaEpx2TZRTlhYBmhitQmiKJj3eTmxxhN85EG5n4GQ4P8EuO3+7Du276pdla8uw==
X-Received: by 2002:a05:6830:2b06:b0:72a:1ec6:d47b with SMTP id
 46e09a7af769-73e64ac1aabmr5948715a34.22.1752763553683; 
 Thu, 17 Jul 2025 07:45:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1064f51sm3869799a34.3.2025.07.17.07.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 07:45:52 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:45:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Holzmayr <josef.holzmayr@northern.tech>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>,
 liviu.dudau@foss.arm.com
Subject: Re: [PATCH] board: vexpress_ca9x4: Enable D-cache and MMU
Message-ID: <20250717144550.GK193579@bill-the-cat>
References: <20250712185227.17100-1-kettenis@openbsd.org>
 <175270411042.2648161.17574452616601901369.b4-ty@konsulko.com>
 <CA+AKJpHxRGD6Bvdv8FmC4_mn94nUjU6N2X5wivyBRpzQ_x0Zvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NgTqLinMdbgwi3UL"
Content-Disposition: inline
In-Reply-To: <CA+AKJpHxRGD6Bvdv8FmC4_mn94nUjU6N2X5wivyBRpzQ_x0Zvw@mail.gmail.com>
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


--NgTqLinMdbgwi3UL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 11:27:28AM +0200, Josef Holzmayr wrote:

> Thanks Mark and Tom!
>=20
> Just so I understand it correctly, this patch means that after the next
> u-boot release we can continue to use the  vexpress-ca9 emulation as long
> as we also make sure QEMU is current? If so, do you happen to know which
> minimum version would apply?

The change is backwards compatible, it just fixes relying on undefined
behavior that's not allowed now in QEMU.

--=20
Tom

--NgTqLinMdbgwi3UL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh5DJsACgkQFHw5/5Y0
tyzddQv+MnwXAyqEopxxrbzr0DfbwN844IUZRkfWHqRtEGKhf7E8qwQmTYgWgETo
wc/yz8qGjzNxytUBssg4gLzchXYIVoUaq0pdR77+mXzG2HvWmPU19I0YN/k51t1j
h/7O1nihRiGWWvP8vCuTjwQSbORED52KUkuc+Mbnts8MUCzEGr+xG+vnp+QN8cSL
RCH+ZOA1yTihEOCZWlXDLfStAX08EgfxCivZGrrDDTQ3+2uwXHBG6Uu0CChW0g7S
Clhxyq4u/0738hjNkbXwcuztNSsVfGI2FNlTdcG5vGs4rjIKqtfngUxb0Plc2o0m
ln6J/aB4eusaqv9Ow+emoLMGCGdws9HaGnVXbZC9BSogxv5yyOsB3OF+uUh1tbc4
9JUJTZDQm7Di/JOkPvYwnNCahpG8XdYjZxFmevCVDXPkoNBEpfKhsBdqej8a9Sq8
hkSFUOnl6nkPLMc9iaW8tQRy4kiQULz/NivE9x83YGJYrmVl++Bu5NhMxmUOeUfK
idsT5rJL
=hB+G
-----END PGP SIGNATURE-----

--NgTqLinMdbgwi3UL--
