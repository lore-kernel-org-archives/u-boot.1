Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79BBD6CFA4
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 19:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1828839DF;
	Thu, 22 Jan 2026 20:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TmuFPCQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88638397D; Thu, 22 Jan 2026 20:42:46 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 345AF839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 20:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-45e934bb51dso415253b6e.1
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769110963; x=1769715763; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wg/3MdItCLRFTi9qtZ01NI2wWRkID0Z8c8UiNmJ/Fkg=;
 b=TmuFPCQasNJA0XWIx5BbcZCnE1T0mZILXplccQNVHGjgfhUBNoPqdCQPsY2Y2OhUBz
 GVfQMClY34BpECJamfTjh6kmafO9h1gmohWTcK6aT5fyCzf5m99EmTWMSqx/bkGsUx6j
 q+259h00RtehQm3Ot6sFuszWw0fhb+EiSmiEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769110963; x=1769715763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wg/3MdItCLRFTi9qtZ01NI2wWRkID0Z8c8UiNmJ/Fkg=;
 b=L9x6ZQ2/0hbiBRlp6lROvfNTHc43wZsLA2ZYAybeHdnwAvquvMdp/7dFPNRZiDvELY
 SFx7e9CeRGzSwbV2RW4s0S9/mxKcHzwqbXoODD14876Qc13W118y+2UCGBHiQneZJQKV
 4ZtnzGhC+jnK9IxjN9vzCUWorOIzARvPgLJrD1myhwoKZQLdC3F9t1emGJiu3Gf+Svh1
 Kylo11Yk44utamv9jfny2VhxEgeP/OVSBCu4zHo/m6/4DFOCQ1uZ26Ox9IG8RfcF6/xq
 8M152MEU+OqmvrB0uhaNSL98qJvm0Qo1PzivIVahNCPYUtUbh3eXYjuZDyYi0ZH1eLCM
 s41g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2kXiJeHkQ/cgv7//7Yl0uVyzUoeAPjuhPeW3PpXL8ljK5w/fR7ulwzYRMpt0WzRJ12XJ1VKA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5nksHws9yvAxpySEHlQSpSJJkWG6B6r1J3qzcwWiWJT8FJxrj
 Mmf4OLh7C+uWp/iW1lhOYSGWNqMlUaoI/mwc52yqVJlTOlohsp4osZ7jnJG9n7FjcbE=
X-Gm-Gg: AZuq6aLOLTGiNKdrzcaXxklfpeux8pWKOa1mgM11RETvddiYMcqxidRvP0iz/frJHJY
 GAkcPIFE4sdzmSvJ+2TJhr3zDhDPnlfHwhR62bFy6bLWa6T4wGZ+X/qOpQ4bPqCgLOL14NTK9sK
 6HIophVxzDoFKyHmNhqK+3ZdesUvLq4WF2emR7/dN1+U6UMzxgjShvLeqnECOjpbnNThAXjmsLs
 5WTjTaph3UPMQHjXh5hQnZ4sCLORd4U+X1ezyYeJfaO2roUB/CDhOm6SyGTOt4/3woOUtxRZpXO
 Ejfpo99HJAIiaUvv1rCH0hGP6jilH9lq4l1RidBx3LGu44NPQ2MnSgwjov3T07dvXQyAEbkfEzz
 yEMnw5jpllio1vsIRzDpHFmHEITSriVnQw6iCRxSklyNFFhHmal4hPHsw+zl1PpiYb48lNT1K9J
 AZcZokRQzjLNNSk7D7tmG3MOC1qg3RImsrTcZ9qOdkNAAAPs13Iefe0FRilPhG4pqugtU9kLRqu
 jXK0efjqD61SN7OW7AUw294iXqzCOz7o2QnRhM=
X-Received: by 2002:a05:6808:4f0c:b0:45c:8c6c:f3f7 with SMTP id
 5614622812f47-45eb1b23667mr369702b6e.29.1769110962832; 
 Thu, 22 Jan 2026 11:42:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45eb425513asm41412b6e.17.2026.01.22.11.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 11:42:42 -0800 (PST)
Date: Thu, 22 Jan 2026 13:42:39 -0600
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
Message-ID: <20260122194239.GF3416603@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QSiyNgOc4Eug8NUu"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
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


--QSiyNgOc4Eug8NUu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 04:19:55PM -0300, Fabio Estevam wrote:
> On Thu, Jan 22, 2026 at 4:10=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > Can you please share it with my off-list maybe? I'm still confused as to
>=20
> My work-in-progress tree is at:
>=20
> https://github.com/fabioestevam/u-boot/commits/rv1103_prep/
>=20
> This tree boots fine. After rebasing these patches to the top of the
> tree, it fails to boot.

OK. FWIW, I can't reproduce those linker messages about ".sdram" and
".sram", even when I point ROCKCHIP_TPL at the right binary file (per
the docs).

> > Well, where is the dtb ending up in the resulting binary? The addresses
> > are aligned correctly, but the dtb isn't where it's supposed to be,
> > where is it instead? A challenge here is that I could only check the
> > linker script used by about half of the 32bit ARM boards
> > (arch/arm/mach-omap2/u-boot-spl.lds) and not the one used by the other
> > half (arch/arm/cpu/u-boot-spl.lds). The initial error you reported makes
> > me wonder if we can somehow unify these two afterall, which would be
> > good in general to do.
>=20
> The spl/u-boot-spl.bin file is 4 bytes longer in the failing case.
>=20
> Let me know if you need any further clarification or if you'd like me
> to test something.

I think you need to figure out where the mismatch is between where the
device tree is appended in the binary, and where it's expected to be, in
the binary, and then why something is writing it to the incorrect spot.
At run time, in xPL (and this is lib/fdtdec.c) we look at either
_image_binary_end if SEPARATE_BSS is enabled, or __bss_end if not.
Looking at the config, I see we are not SEPARATE_BSS here, so it needs
to be at __bss_end. And in both works and fails branches (my own quick
rebase -q origin/master), for me, __bss_end is the same location.

--=20
Tom

--QSiyNgOc4Eug8NUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXJ9qwAKCRAr4qD1Cr/k
ChlOAP4pnrM6wvdl6JLlP4KqxiS/iPV08FszQhR6nCDXI4R8NQD/fvtcmXeiQofq
hJ2aeNKFF8jROm8QNrUCuLGuoxIRWQE=
=0aQu
-----END PGP SIGNATURE-----

--QSiyNgOc4Eug8NUu--
