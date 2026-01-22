Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EBFD6CFAB
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 23:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 380D4839D5;
	Fri, 23 Jan 2026 00:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c3lcW827";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9859283AEE; Fri, 23 Jan 2026 00:24:16 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4108397D
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 00:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d148ddb583so820451a34.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 15:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769124251; x=1769729051; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FXmKmFXpNK6nIABnQfDmg4oZuJpBA2RcwZFLxgZUWIs=;
 b=c3lcW827Kow7KQo2+VcMe+zmblH88Vt5VnPkPKC1WNTqetVe2Ub/KIMpiX1iLHdGSV
 u+bm6oSdd1uVfqx2AHVUlsFChGrw/X7mI7cDS+uCp5lhTRHqAJLRMRhbcHJvvCf0dpHN
 DSIg3N58jKhgjw2oipjVUZ6Ds0n1mSBl1W9hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769124251; x=1769729051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXmKmFXpNK6nIABnQfDmg4oZuJpBA2RcwZFLxgZUWIs=;
 b=KbSVKNcneob7t5pj9csgA4nfqPp1tEPeALIBdQYHqpW9TsooO2lltQD4CvKjJdfkwq
 NuN/PyL3+1pYGyJgPvNwlxP/BnRKN/ygJWwyiSRK4sFyMcbo2RQMNS4JxB+Rtdsbr4Wv
 87B0rnFzXnhlPkjfHmNs6PVDawm6UFu0VTZotR/Htzs209dqXkRcjJdQgSakU9pw8ivw
 ytH2p7R0D70GUEe37N+de4qFPqgKO9KAbaC3siHSEQTJvMDMrw+BksIZ+uxJDn5rt8rE
 +S6grrKVykCbqMt5pjrEzuIVtmaF+uj4V7SzzZ38GA2M/WSn5rmTFzAY5+8OTGMrJP0D
 nF/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI0GsVOX5N87eukPJVdH1OluMDYtXgRHpLMu5OMz1xYpfYaygSgCHixF9egnHM1wgaQ/u44uw=@lists.denx.de
X-Gm-Message-State: AOJu0YwjOEjOC11DUJdVpy5HhRwKcDSZjXLsn8d8788UIkBWMQhYUw6g
 zTVPg4fCinplcKZ81iM5emmAuXi5BNIGZiUS7bSXE1YQDDj1Q7rmpjRqpt23Wcb0MTM=
X-Gm-Gg: AZuq6aJVpVbmKj5LS0etOzEWAEtVnc2PITzUepYEOY2pQ2qtHyMtF1NBffCIVH35AVV
 4MoV1xEfEKf30oxW0t10sxN50P0DKNgb70VeQsxqgli/vYZDtHQuU0eJOyqBUIHwDFM2Mz9W53V
 AHMiTjmhT7qOU3pbA/d0v61gw165L0BFahw79KknwfN765TsVwrstznqisiYHrxLtNKydMTTbns
 Pvrwv0oODzSJ9Ne36tPBp044/kLzJ7cKatWHGEgHT1AgwRrONiSaIMHxzZp7mt1DX0WzN+ff6Gc
 LoghvJiUmX96dG8D+dt4REG+od2w6ZMrFOtsZwYKa//XzX43an/Vq1treSHUw0Y79aqZrusUb34
 IzI64ss6UqlsPxQWyEmWnMKbi2BthKi8lk1jGtck/p+eqp9yVQiZPBSn7EJTU3guz12aXQIqd56
 0qLZzWruuqqin00uBBj0EjO5dpPhB6xUsqRGadeD1UDqjssu8Znd9qOxJfAw8fBf17sO/F0mB5I
 Gu4DLnl1jpsuARVDxSDNBrjis1GzzJ0e/vCaqB/5qnDnygutw==
X-Received: by 2002:a05:6830:6a85:b0:7cf:da7d:6080 with SMTP id
 46e09a7af769-7d15a643b5bmr632497a34.32.1769124251185; 
 Thu, 22 Jan 2026 15:24:11 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d15b3d31d4sm494904a34.21.2026.01.22.15.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 15:24:10 -0800 (PST)
Date: Thu, 22 Jan 2026 17:24:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260122232407.GG3416603@bill-the-cat>
References: <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
 <20260122194239.GF3416603@bill-the-cat>
 <CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9wgce2GyV8ipLd0n"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com>
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


--9wgce2GyV8ipLd0n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 07:56:26PM -0300, Fabio Estevam wrote:
> On Thu, Jan 22, 2026 at 4:42=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > OK. FWIW, I can't reproduce those linker messages about ".sdram" and
> > ".sram", even when I point ROCKCHIP_TPL at the right binary file (per
> > the docs).
>=20
> I only see these messages if I force SPL_SEPARATE_BSS.
>=20
> The board boots despite these messages.

So with SEPARATE_BSS the dtb is found where it's expected to be? But
that then brings us back to what I'm saying..

> > I think you need to figure out where the mismatch is between where the
> > device tree is appended in the binary, and where it's expected to be, in
> > the binary, and then why something is writing it to the incorrect spot.
> > At run time, in xPL (and this is lib/fdtdec.c) we look at either
> > _image_binary_end if SEPARATE_BSS is enabled, or __bss_end if not.
> > Looking at the config, I see we are not SEPARATE_BSS here, so it needs
> > to be at __bss_end. And in both works and fails branches (my own quick
> > rebase -q origin/master), for me, __bss_end is the same location.
>=20
> The dtb is placed at shifted-by-4 offset after the commit in Subject line:

What's appending the dtb there? With SPL_SEPARATE_BSS off it needs to be
at __bss_end, and that's the same location for me, in both cases.

--=20
Tom

--9wgce2GyV8ipLd0n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXKxkwAKCRAr4qD1Cr/k
Cn9AAP4hwhnYeibwih8fwHNKHEFJNi3AqZFn/hWsYSZvfK5/BAD+I/6V/auI87tw
VlkMkk/jA08jylwMWi1WflwVSf8hdQE=
=LXK6
-----END PGP SIGNATURE-----

--9wgce2GyV8ipLd0n--
