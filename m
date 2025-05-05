Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E41BC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 18:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E85A82161;
	Mon,  5 May 2025 20:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PxLYh/S+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F1082163; Mon,  5 May 2025 20:14:28 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A348215B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 20:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2d54b936ad9so2182598fac.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746468865; x=1747073665; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2v7dsHWbSAJP/hlWf40hpylgHFQjhAmaN9dui2hqhAQ=;
 b=PxLYh/S+lBS2fIj85facYkFWoL3vTqxP7s/u0q8cid+nNK8nyiIIwdyFBkoXc1vE/j
 Au97Z8lY+sjlGCEQ4AhHky1KU1jD+V/Q+qaVtg13SlqyppjGWMY0wn3JZO56W0M13nZQ
 xKdkgb3VsqTdYjP9ygrL3UZzTbK1R1/NvnRVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746468865; x=1747073665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2v7dsHWbSAJP/hlWf40hpylgHFQjhAmaN9dui2hqhAQ=;
 b=ZDjOkva1nCRb5FwDrnx+DT0dCAipHKHd2cHE+xdTwR6DRnELk+JTRNx9sl1dIAJp0p
 hCxCah2K9n2r7LKEw3eU8nEd52N3UfPtBuqgWdrNofMosLXSou1/E8msnZscHO+N3cdU
 4Z1qlH8ABjAvR/JD6TDVfu/S+7mES4l8hvW2SvezgYhIRvcVj9sOfwZTkL9hb0AB4rXz
 CsNUkZOmHAJgHokJ1MiBC3MCsOtgbUSDF89h8PCjyxfHaREcC1TYishjVka5Dz4y5C3s
 ckAsCSuG6WXOR0PsDMYFtwtDkBENyXjhtqYnrnY+Mcc2g+TOUBYM4g8jAg/8RZK80/ri
 NzbQ==
X-Gm-Message-State: AOJu0YxR/TrRdLHtBOx6ej54B7Jj/Ga4cxUj01uCOQDDiCM3rdeSbCCd
 lFjDb25u+StxwkALgGlcaYmenzbRLGuni6yWM5C/EDlsqwuT2UUpVuMkVn7kvDw=
X-Gm-Gg: ASbGncuZE3WMRGysik+jbMGp1UsOAyURFAzPIBRP2Ga4edhw/PZjIEhfcNNduIZs4zT
 hJiB7ebkOf/E9T26jAgExCwF79Zah4CkyPwYYWqLoJSifxuwa/J8fw1T9tqf0qSyJYQQqNM+N5e
 5STuA1dOs+bvCNTLktnyrM2aJSRmmebuTyeN25aaCMqvOAHIXYBPHKN1x9C4IXojvBUvdQtnzMz
 XE2ophqc25UN3y13YJtITpYq6x5d4dg85WSZd+7+TCbvSYYhOWGUunzGES1PJRKSOO68silBNi+
 M7xG9E7pY+958FKCaeKOYEj1JTJwd3yDngIT5UvVi1hv4zji4j9cexOV+e19YWu8Z907q/W6/ng
 2Pw==
X-Google-Smtp-Source: AGHT+IH8uuBXaKpZNmaYHxdI1KPH/y0XdZxhI66bxgM7kopLII0VKgm1Awh4kXMuzZ1OkK0mJfJF5Q==
X-Received: by 2002:a05:6870:898e:b0:2c2:519e:d9a9 with SMTP id
 586e51a60fabf-2dad6b7aa30mr5439709fac.24.1746468865178; 
 Mon, 05 May 2025 11:14:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0f8bc79sm2062166fac.29.2025.05.05.11.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 11:14:24 -0700 (PDT)
Date: Mon, 5 May 2025 12:14:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
Message-ID: <20250505181421.GI5430@bill-the-cat>
References: <20250501131858.2160756-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J+zPPgULtLR75B2R"
Content-Disposition: inline
In-Reply-To: <20250501131858.2160756-1-sjg@chromium.org>
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


--J+zPPgULtLR75B2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 07:18:32AM -0600, Simon Glass wrote:

> This series restores the original behaviour of extlinux booting linux
> 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
> a limit of 10x the compressed size.
>=20
> It also adds RISC-V support, since it uses a similar format to ARM64.
>=20
> Future work should integrate the code in 'booti' into main 'bootm'
> logic.

I don't like "in the future we'll remove duplicated code". I also don't
like not seeing that what we really need to do, in all cases (not just
booti) handle decompression like we do for FIT images, and ask LMB to
give us a space to use. A problem is that CONFIG_SYS_BOOTM_LEN was never
intended to be the limit on *decompression* as it's the limit on what
we're loading to memory from disk. That's what getting me unhappy with
this part of the series.

--=20
Tom

--J+zPPgULtLR75B2R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgY//0ACgkQFHw5/5Y0
tyyXkAv/Ww/0Wemt0iZq1jtNhX41u2C2UEq1MJlufGfbmW6ZIFogLBgPnfamJAwZ
HApj+I3yOluIh7/MivKkpo/7TTUCb0VdGE6AAkFpsATy6zxMjNuJjME0QG5dPNvu
AHaPFKJf3jY1yVJqedvXFWUujYy8B+rxVlA8WmEVdIjMhcgUWKHfZ0AhrcJAF+Vc
pbcGt6r2JaPpcPC1W8naFzz7YmlDb8wfmA3Pfw2mUYdVH82+W74E+8VVDHtuzOww
pABd9Li0XSGvJfwnF+FK1LUMC1aACcl/b7WTF1WBxEj37J0DSZOJd6MSGf1MAhUK
JJKJA9ZwIe1KpvY8ReL7AE08bAsVwv8Hk51yCLlbSFIiuq1g9LbZH7xPfV+OktCS
sCwypg3B4XMrli0OzaZr1SYGSVikbG94K0XCe9dPC0yKl3pbWCUgXUkLRWr3HU3S
yn/KWsoOa0yI4XlsgHrFlqTH8IbV3jSkpkn4Yq3LZVbwbmNxZmUkt50DjJiDXgfk
+26S9gf0
=yJcu
-----END PGP SIGNATURE-----

--J+zPPgULtLR75B2R--
