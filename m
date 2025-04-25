Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D313BC369D7
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA778212A;
	Fri, 25 Apr 2025 16:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H9ydA4ZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5503810EB; Fri, 25 Apr 2025 16:17:48 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8126C810EB
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3feaedb39e9so779740b6e.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745590664; x=1746195464; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PRDAJa/9OdS9xzNclxrX8NhhSczVwjTqOntXKSBOWnA=;
 b=H9ydA4ZEJMxWlYAk7eIXl5eD9DdIEsgitcx6sp4/5FD+3DM8gJ1PaHrxdijPJQnVYg
 DH2rD+el9bviZhvdwRGcSn/oQf866pIC0YPFqCKKdSvSzsMt9+cQUpmjBvUqQIncXbnw
 Bx/Y/JFNh69Ue6Zvxe7zngd2g932H21lGmE6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745590664; x=1746195464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRDAJa/9OdS9xzNclxrX8NhhSczVwjTqOntXKSBOWnA=;
 b=edNedKsFm2BoAv2eMVWPQkynBXvTB7rdlRncRGbv2pn8P9FdaN8m+op2MqRwxvoStj
 2dOjMLa1JrAYa6i2Y6YZYUbUOZbRYh7s+zY4WttgfNIDvnWSUn0J8rxypsVln0CYOeRn
 JukatWw6S1Wk2BD9CybWuNq2Jm863P8ED4nT5AFe++53alT1ZPnY68QyopJWvPINncYI
 FmX72Y2jy+4jTaNK9H2VHjDMqaQW7T0UiQNsz2V1kGcc4Di2Ypssu0NIYnp6ZNlOPmSN
 jgJgm4egK3C9FBV6L3+OlNxJ/PLNIVe0YRXDp+wpJeyrLspfINdBajqAycIxNmX1mAqm
 iZ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnioxIAd5DEZ6yngQki/JRaTUcJekXvt971/f16yAEBd8S2VJLLdLALNgwUZu+q2RIUN+on5g=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0whmvBLToXDpvCJ+WJ6bLV6Tqk7PAxz6sjGBBnvBowtkUDr2C
 4oZraIDTnLxz6yW2TIY4ldx8fMpb5ScPudCsO5TD+9zRDOTYj/bIAihEeWxXuvY=
X-Gm-Gg: ASbGncv+dsi1HqzDHUmeAj5QfKUu/7hVUU+B+2CjSBy1iPCrMEzH7R9sUDh/GE+lInv
 LXYei1LK1K2FysS8IsiSDe3PsqZCY+HU3cxWoPXwBFeZNLI6e285F70ZMAXkA0X0giQTdHceWE1
 YnKnjYCcLV9HVwSW7aORVzPeEF7lezl0ybgPmMjyXV/uD0MuEjzNVJ53si237jSU/CV0PysQk/0
 duzRd1wkuUyDe/cuJWlMlV+ujZruhSt3E/FQBdG+aF6N1Iedzs5tK0hxt9wGAeN5q3s9qeUEEoI
 Pww/Y00kiNg89p03y3MUEQ1fY6HyBbBBidcapAUstKCQKmoP20NMfYI9yhSvt52C/s0d0y0oQc6
 5uQ==
X-Google-Smtp-Source: AGHT+IF5bOYm0Zqz+BJKxOP9kpgEAKTc/erg+3jXoJaAtPmYxrOBsviLpFJxmoCqxEggMWrs7zMm2g==
X-Received: by 2002:a05:6808:5:b0:401:ea99:544 with SMTP id
 5614622812f47-401f28887ffmr1235212b6e.11.1745590664227; 
 Fri, 25 Apr 2025 07:17:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-606468a16a7sm734197eaf.22.2025.04.25.07.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 07:17:43 -0700 (PDT)
Date: Fri, 25 Apr 2025 08:17:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: marex@denx.de, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/4] build: Respect CONFIG_SPL_BUILD in DT sources
Message-ID: <20250425141741.GS5495@bill-the-cat>
References: <20250425135220.1929510-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="68UbDihwBlsZFlbF"
Content-Disposition: inline
In-Reply-To: <20250425135220.1929510-1-festevam@gmail.com>
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


--68UbDihwBlsZFlbF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:52:17AM -0300, Fabio Estevam wrote:

> From: Marek Vasut <marex@denx.de>
>=20
> Currently the U-Boot SPL build uses the same DTBs that were generated
> during U-Boot proper build, and calls 'fdtgrep' on those DTBs to filter
> out uninteresting nodes and properties. Those U-Boot proper DTBs are
> built from DTS which are first preprocessed by CPP, but that CPP is
> invoked in U-Boot proper build context and effectively ignores the
> CONFIG_SPL_BUILD macro. In case the CONFIG_SPL_BUILD macro is used
> in any .dts file, the content of the macro is removed by CPP.
>=20
> Fix this by building a separate set of DTBs for the SPL, which are
> preprocessed by CPP with -DCONFIG_SPL_BUILD set. Use the same way
> for the other PLs.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  dts/Makefile         |  5 ++++-
>  scripts/Makefile.lib | 11 +++++++++++
>  scripts/Makefile.xpl |  7 ++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)

There's already a thread here:
https://lore.kernel.org/u-boot/20250305183544.40525-1-hd@os-cillation.de/
saying that we shouldn't be doing what this patch adds.

--=20
Tom

--68UbDihwBlsZFlbF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgLmYEACgkQFHw5/5Y0
tyw6qwv8DzDyZuYUpzaXZjlQzqgioz0oopsEYVzPVcM+LciWBA5aIjZNiwZTtwEI
Wrs2Gw50pVhFd+YZR0nu1F+VJE8BkxSnNfT603b77MBWt2QkDtJEg0FeWknb2TDw
Rbg2txJvaNMaFSTduZx9hkVeQWiOYYASDPYEVoMax/I5hGV4cAZ3Rfok1iuNgBPw
Q0mb7mUsO/5r9KfqhhGzg3FgdxVPxbtyNPMrboC10IU2wCviFbJPH4wkbOaEIWhr
o8cnKDbNLfucxW0DbHo3A209qx7oJoGpSlgAekAYFFAUS8X0aP0TG/weHWuJ35KJ
61fMAtAve0DVpeSxi0infS6S24k0Ic1aRWadr62aS8xo3wc6q8VnCx2S7TwFvc2Z
VJrkWskSYCKQwOVG1VPyZnftE2aTb9wNpt8ZGsXHEmC+fX0M9yYfpjUCIQ2bPeWE
+PEcrAfUZK9NLLM6nUnbcrrOmd6pVSi6RQ9c0S+i7RdUlgoozWJo314tRmMgSGx6
Dfd0poTO
=cADN
-----END PGP SIGNATURE-----

--68UbDihwBlsZFlbF--
