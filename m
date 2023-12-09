Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73456C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 20:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7EC871CF;
	Sat,  9 Dec 2023 21:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UVhmjoUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB09874B7; Sat,  9 Dec 2023 21:21:36 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D2B68717E
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b8b782e142so2528178b6e.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 12:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702153293; x=1702758093; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qe1I1cDIRt/wDw7IRNLrkgVJJX450YMWe3winLEudJo=;
 b=UVhmjoUSaH7HiIuhNj0oKib5/8XxMK9Uu3+7lV6lIsiUhijK1g9IilPoMkvmSUP8Av
 ufwGKcrJQrbUXI23+tULTOdbdraiN2lT8+uDF0FOTRTKoYx+OI32NzC9v9xi/762gIUo
 2M0abpVJM4CwrHYovUK2xDoMw0q2KenJOVLSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702153293; x=1702758093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qe1I1cDIRt/wDw7IRNLrkgVJJX450YMWe3winLEudJo=;
 b=UyAE90R7u3eaq3+CWWV4uJECZyuaYlnI4Cy8HEoz4nr+TPHz6NBvwp+zj2hxSMpNjs
 d0whYsLIXsZQBw4BBE8W24Yl/8/EPXzNObCtjKJJzTbO/+GXnCyciw+Sp3+v5gCeOwMu
 PjeXFZFXvW7qZOPcFTYbLjpuPnHGjic6i6R3vklEjZox3j1ecSPh+r8m8xK47RGuKZR5
 B6RV7etucxKF1nR43GfWFZjlOlz1jkeBYYb7FPClWwVQi06qTQIqbXqlxPfr9JeuWS0B
 vGXNVSQlb4EyiWcep7ohITlffQzZvK5BHrCVbGrBWF/8ZC74sC4P+pdj9UuWY7/E0zam
 yobg==
X-Gm-Message-State: AOJu0YwjESqnbcFggE2u7+RQ16ABZB4qSgVQ4OoHrsooU/bMVyrmF5HR
 +6W279Uvx3t0nt00pkRD3rtO5g==
X-Google-Smtp-Source: AGHT+IFRY2GbRnNxgzv0B1ULNq7eKrR113lxvd7wgnkW+K4EdkCEbEMjD47jk2SXBe7iRMaFYEuXKg==
X-Received: by 2002:a05:6808:2f0f:b0:3b9:d99f:c8f1 with SMTP id
 gu15-20020a0568082f0f00b003b9d99fc8f1mr3180690oib.37.1702153293209; 
 Sat, 09 Dec 2023 12:21:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a5b0b05000000b00da0c63aa9f1sm1447754ybp.20.2023.12.09.12.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 12:21:32 -0800 (PST)
Date: Sat, 9 Dec 2023 15:21:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Soeren Moch <smoch@web.de>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, goldsimon@gmx.de
Subject: Re: [PATHv11 26/43] configs/tbs2910_defconfig inc limit
Message-ID: <20231209202130.GD2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-27-maxim.uvarov@linaro.org>
 <20231127131129.GD2513409@bill-the-cat>
 <c7022ef3-ad0c-4f89-ad47-a0f7df2a24c6@web.de>
 <CAD8XO3aVLzpqV=MDVO2mJBP=sLzSieXhrV8GUPYPpu76mRKjeQ@mail.gmail.com>
 <CAD8XO3Y4_=8wDQcFNJW1MT1yiyDmbQxP3UCRWWWPZzuJkZp88g@mail.gmail.com>
 <1402b942-9ce9-4bc3-9fac-0eb438b23e77@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d3REqqFGyuCsTQDA"
Content-Disposition: inline
In-Reply-To: <1402b942-9ce9-4bc3-9fac-0eb438b23e77@web.de>
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


--d3REqqFGyuCsTQDA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 04:49:47PM +0100, Soeren Moch wrote:
> On 05.12.23 14:15, Maxim Uvarov wrote:
> > I think I solved the size issue on all the boards.
> >=20
> > Key changes:
> > 1. remove compilation of original ping.c and tftp.c (tftp had also
> > server code, so I will partially bring it back.)
> Interesting.
> @Tom: Is there other server code in u-boot, that is enabled by default
> (and can be used to reclaim code space)?
> Fur sure I do not need u-boot to act as server for tftp (maye nfs, others=
).

Note that we disabled NFS for everyone recently (I think it will be
default off in v2024.01), and CMD_TFTPSRV isn't enabled by default for
anyone. At this point, anything which could have an impact on size
should be in Kconfig so examining the whole .config file might give
other suggestions on what could be disabled for size.

> > 2. LTO=3Dy
> > 3. CONFIG_LOGLEVEL=3D3 instead of 4.
> > 4. CONFIG_CMD_DATE is not set
> > 5. CONFIG_CMD_LICENSE is not set
> > 6. CONFIG_CMD_PING (if 1-6 did not help).
> >=20
> > And these changes were enough for CI tagrets to build.
> > I also tested that Raspberry PI 4B works fine (dhcp, ping). Looking
> > for other boards to test.
> >=20
> > For example for this tbs2910 board changes are:
> Disabling CMD_DATE is unfortunate. This can help to debug RTC problems
> (already used it for this purpose).
> And, if we are that close to the size limit, than maybe we can get away
> for this series, but for sure will run into trouble for every other
> small change to u-boot core/driver code.

In general, I would suggest disabling CMD_LICENSE before disabling
CMD_DATE as well. But I see that's already done here. The same would be
with CONFIG_BOOTM_VXWORKS, but that's also off here.

Maybe disable the memtest command? It's not that good of a tester as it
is. Or maybe CONFIG_MMC_VERBOSE=3Dy can be turned off?

--=20
Tom

--d3REqqFGyuCsTQDA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0zEEACgkQFHw5/5Y0
tyzxAgwAgTl2VZ2A8wgMRRDmE83hMjqidgqehQTVMB4S7/HFwjmdqVRoMAEWBENA
aZV+NYk21Nux2g2pv6encW2+Zjl8vDXleq6uAgK80Wns5IUlXMkkXqbmaPlO2Gzy
rxY2ClT2FCcSQZpYyEdHp8tzW3pOP+vzhNpeTYEPKq2LXW1cvdSVIixTIlmoMM7/
HmcBZyrwwiIMAxViKsUR3npUhYMWtNMACD0nrfjAG4TYKT/k34icsyeIEQi83UKo
6Gbg3yy/hUxq19iCxJ6aTMUg+yciaTOR4fnV5xoJkmJqXzJHmCvCggPWykjGP99h
RXuj/eXPhuJ8u/1YLf72/WOus69Li3OeGfsCJk/SXL4w1bAT6Dc2kJQM1krNicBp
VjhoF/ZTVGaA+FPYAh0dKLtGhxAFNZpSy1zhXj6r7bhr5GO6ENblCXdHAi83pUZN
wodarJFP7U2BOwv3wIQk7PxKumAC5jkZmWKGbqnlSSn53F6FaGg6CmVDoVBll9Vu
HSHJ9Glj
=0jqY
-----END PGP SIGNATURE-----

--d3REqqFGyuCsTQDA--
