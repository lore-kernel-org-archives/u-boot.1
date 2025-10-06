Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779F1CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DF783DFA;
	Mon,  6 Oct 2025 17:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mOrpa6ie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9517283D18; Mon,  6 Oct 2025 17:47:55 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5599383DFE
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-42e726431bdso21674725ab.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759765672; x=1760370472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Qckd/wB0wQTWorZl8WClnZafpKR4EdRFz2E5nyBO7w=;
 b=mOrpa6ieb1fphj/nOnQYvOTn/lV1dE1d6cf8ZOAsfeq8+tHsCwwXBwUlM+pbUn++HX
 rX5lSuVEPRk4XSKrPBBAqR8NoyEAlDzGSGKilqwricbnP9ZQoDOHoLAOw7YsupKtoGeK
 r3W33z/JFgBCKSmJ9RNS/EBXaaCSbOQBzAXjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759765672; x=1760370472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Qckd/wB0wQTWorZl8WClnZafpKR4EdRFz2E5nyBO7w=;
 b=X+OsF/xYbMy7bQg/Td8dH4wOZMb7t/HserAXLj8iTD7Y6rN5BhZv/gs1a5toi5d5su
 rOu27W5FuCgggNVZsslP9VaVppj5zHs+ktcO3oC+Y8Y5188fQITEYfocHNyLwQ5R8XMr
 PgQhyc/Eyct4eqnSJpgBZ7oOzqTKiosZqJGPRhbTKg6s4bmvWBAWQDzjqnGOZi+y+sai
 bzhyCU5XHD8UV3nWTs6Vk/mVXIVOkQgahQVpyt4OScbmNyL2dCGnW2O5jpYufQzqXMyj
 neu6oxyxZDYgK/j4WcUU9XOz+YQUMuM4ZtD7doPBwUnS/6uG9Mw1wWfZqfcFN17KoKkg
 MKkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPJ23ZuCdNHTbjxBECJql+tfnxX4ikduiGd4lDijpFIj6PPXP6SPCG8NOptYwhagCLN0JvktI=@lists.denx.de
X-Gm-Message-State: AOJu0YwRAJEDyUPD1zxSybXCnQWnwlEXrWcYfNpKdH8yoY2AOOgZidmO
 8ZFTFX6qkMDbBbIHBERC5jF5amicBvWkhVLIZRwyC27KNFKzza6ufMmF4xwxlcVkNe8=
X-Gm-Gg: ASbGnctbIpvGO3+uv+yxt8Y+h+a3Fzb4wPfsThCx/Rp90jmlh9ND818QvKyugYhkORr
 X0+wkmRK4FSyqrXymbJztm6GuM3qcvDSMSGeYe7Bd1BLZ1m/RSi0uJKBjv7CYoS5NDZErGr+6hq
 Uzu/HtMN9ktwenboM0crGo+Q6br+MlIONRj35x2ohSDnwakditifgKO0wcBvQWrhCsX5D3jFDEp
 r+krkAvy5DmwWZ7DBEOwcJCXMkMeH8TUogTMFbrF73eJFz7Nf0zZAM3MkM5Pl5lhUBrSpu1nSpO
 2T92zRHq6MfTpPMHQ+/udgtEj9mZUY4LMNGS1TFQ3FOJq5fmWCv4zJE8TlruLFfTC8qGq1sUsYu
 tDEwPSeyrwO40OPBNx6xW0b53sKs95LRNWCs1XDmMHi1w8tqM/OOPf7YVGYpYCOYBlo0YYmY832
 Lw7SNkMWle7g==
X-Google-Smtp-Source: AGHT+IFyZZLraOSx6RnlHNNTBB2Irg6wYgPWoKLXOt4KuPiK1is3Q1qdJz0RrLpD1sz8ldljlFf5YQ==
X-Received: by 2002:a05:6e02:b48:b0:425:94f5:5e3 with SMTP id
 e9e14a558f8ab-42f7c384df4mr1091735ab.10.1759765671883; 
 Mon, 06 Oct 2025 08:47:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b2950cfsm53451715ab.35.2025.10.06.08.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:47:50 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:47:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Vitor Soares <vitor.soares@toradex.com>, Wadim Egorov <w.egorov@phytec.de>,
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 open list <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 5/7] doc: make pdfdocs: Update kfigure sphinx
 extension to support inkscape as well
Message-ID: <20251006154747.GE6303@bill-the-cat>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
 <20251005221057.255029-6-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KbuKVXJ4LC0lHpPP"
Content-Disposition: inline
In-Reply-To: <20251005221057.255029-6-adrianocarvalho.pt@gmail.com>
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


--KbuKVXJ4LC0lHpPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 05, 2025 at 11:10:12PM +0100, Adriano Carvalho wrote:

> As it is right now, kfigure relies on ImageMagick's convert. It,
> however, fails to convert some SVG files (see below). With this change,
> inkscape support is added. If present, inkscape is preferred over
> ImageMagick's convert.
>=20
> With this change kfigure.py is an exact copy of the Linux kernel's at
> v6.17. I reviewed all the changes and, it seems to me that, only one
> change may cause trouble: logging uses a slightly different approach
> (logger v. kernellog).
>=20
> inkscape is also added as a dependency. Dockerfile updated as well.
>=20
> Without this change, this is what I get with
> docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
>=20
> [...]
> convert: unrecognized color `context-stroke' @ warning/color.c/GetColorCo=
mpliance/1057.
> convert: non-conforming drawing primitive definition `stroke' @ error/dra=
w.c/RenderMVGContent/4414.
> WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/d=
evelop/pics/spl_before_reloc.svg /home/uboot/u-boot/doc/output/latex/spl_be=
fore_reloc.pdf
> convert: unrecognized color `context-stroke' @ warning/color.c/GetColorCo=
mpliance/1057.
> convert: non-conforming drawing primitive definition `stroke' @ error/dra=
w.c/RenderMVGContent/4414.
> WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/d=
evelop/pics/spl_after_reloc.svg /home/uboot/u-boot/doc/output/latex/spl_aft=
er_reloc.pdf
> convert: non-conforming drawing primitive definition `Liberation' @ error=
/draw.c/RenderMVGContent/4414.
> WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/b=
oard/ti/img/ospi_sysfw2.svg /home/uboot/u-boot/doc/output/latex/ospi_sysfw2=
=2Epdf
> convert: non-conforming drawing primitive definition `Liberation' @ error=
/draw.c/RenderMVGContent/4414.
> WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/b=
oard/ti/img/ospi_sysfw-am64.svg /home/uboot/u-boot/doc/output/latex/ospi_sy=
sfw-am64.pdf
> convert: non-conforming drawing primitive definition `Liberation' @ error=
/draw.c/RenderMVGContent/4414.
> WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/b=
oard/ti/img/emmc_am65x_evm_boot0.svg /home/uboot/u-boot/doc/output/latex/em=
mc_am65x_evm_boot0.pdf
> convert: non-conforming drawing primitive definition `Liberation' @ error=
/draw.c/RenderMVGContent/4414.
> WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/b=
oard/ti/img/ospi_sysfw.svg /home/uboot/u-boot/doc/output/latex/ospi_sysfw.p=
df
> convert: non-conforming drawing primitive definition `Liberation' @ error=
/draw.c/RenderMVGContent/4414.
> WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/b=
oard/ti/img/emmc_j7200_evm_boot01.svg /home/uboot/u-boot/doc/output/latex/e=
mmc_j7200_evm_boot01.pdf
> convert: non-conforming drawing primitive definition `Liberation' @ error=
/draw.c/RenderMVGContent/4414.
> WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/b=
oard/ti/img/emmc_j7200_evm_udafs.svg /home/uboot/u-boot/doc/output/latex/em=
mc_j7200_evm_udafs.pdf
> convert: non-conforming drawing primitive definition `Liberation' @ error=
/draw.c/RenderMVGContent/4414.
> WARNING: Error #1 when calling: /usr/bin/convert /home/uboot/u-boot/doc/b=
oard/ti/img/ospi_sysfw3.svg /home/uboot/u-boot/doc/output/latex/ospi_sysfw3=
=2Epdf
> [...]
> build finished with problems, 9 warnings (with warnings treated as errors=
).
> make[1]: *** [doc/Makefile:84: latexdocs] Error 1
> make: *** [Makefile:2687: pdfdocs] Error 2
>=20
> To get the above the following line in /etc/ImageMagick-6/policy.xml
> needs to be deleted or commented out:
>=20
> <policy domain=3D"coder" rights=3D"none" pattern=3D"PDF" />
>=20
> Otherwise, we'll get:
>=20
> convert: attempt to perform an operation not allowed by the security poli=
cy `PDF' @ error/constitute.c/IsCoderAuthorized/426.
>=20
> inkscape has the added advantage of this not being necessary.
>=20
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--KbuKVXJ4LC0lHpPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOPkowAKCRAr4qD1Cr/k
CuohAQCDwuoROrEbl5BVwUjGoV9Yz1RF6NVPiZaIauaOBG6CwwEAnRv40O58sKcP
aN4lMi4LUelJYRJQi5gorl7oSv343A0=
=0LjV
-----END PGP SIGNATURE-----

--KbuKVXJ4LC0lHpPP--
