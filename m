Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9150C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 15:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9D482F49;
	Mon, 14 Jul 2025 17:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HfbfFopb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB73282FC7; Mon, 14 Jul 2025 17:33:14 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8764982E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 17:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2e95f0b6cb7so1266384fac.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752507191; x=1753111991; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h/fmeP1tzieTyiGnItiKs+gtQY5DhxluZR+YMlORrAU=;
 b=HfbfFopbSYWWmdjLjam5mX9n8cQeICZeYr7qaZHJgiQoiFURYZHPDnKYI/efnT8lD/
 XBc80ZB1gb1/dP/JXVjJosht9zkbyLBIsTvnAUwrYdilKcfEeE2GZDFBiRPF6J7wK9Lt
 PgayMOsk9kErrY64tVyT7dRCKc6NhiLWAQo7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752507191; x=1753111991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/fmeP1tzieTyiGnItiKs+gtQY5DhxluZR+YMlORrAU=;
 b=O/zgEGWq7MZ3ZPpWrY7rYkq8NRF/4QoFizWXiEQgwx74jco1XQtS0ZC/uh61aXfIKu
 nN+reJUzGuGbybePEB6qAC0w65gce7m8Xf0CWyVhgJr0dJmHRUUGFplM1s3F4uGFsybn
 rxGDxJhXM7sXvkcFfeO7A5dtwggpoKFUI9vMtc/SZRT5BGI5bCj9pp/YXfCLCpmvN02Q
 N6D73359IaCXjMs/ON7eydqfyG2HmUfRQZ4CNrCP7xk6+94qmkduRvuRJ0lNu58zTYe1
 5uj/iwi9yeOnFlDYakQrCwclgLdrAaHs/P6S2I2V2rRfbRsR2kJB4GqqfIsERMkGDGKQ
 wktw==
X-Gm-Message-State: AOJu0YyziBdjhMsz6/H9uo8kn2x4QWlpQJgisgvEcFrLE+4d88NlnZjT
 X/j0B4ay5z1tGXGtJiwt8YlegZfncHwu/wLgNtjlNVILuE+JeMTkZaajP2SiR93SbaQ=
X-Gm-Gg: ASbGncvHAtPqFsJG5v02Rm05UlvRWvjLQHa6PTSYZ+4Fi82hTjcU54yzPTtFqQS9bEd
 2eRobMNngM8N/b6vnejmptcn45q1B6V+G1O1ZgaUzYsdXgl9+4FDKVPQyTQFZuOxPN9cnSuMrrA
 DgxqGbELMyDps/c2Ww6QgPowR6PUfmtNT3oK0XRQVYLtsOarsrGa1CenFKIBtqErS2KP68fMLWO
 aSk4ahNUEzdajSdLDzEXUQ4WKPeJIRpInM2JQRS3Os+i0yz0D3BWhD/xU6VKeqaOjVdJo72KAW9
 Mj0DPji8TL4vDEt+Ahx3QJ1V0/RwFZhuBjow9oZf/NgNTLcYzLemFMW+SMX6qT+BrqFKWLyQ/au
 P0bdYJdyggS/PanjZ32yB4m/AYRyKc2aeo61EWZp4IU/dVInWeBx1LUWO
X-Google-Smtp-Source: AGHT+IGnJ15khU+F9AE5O0p/b/7UbhOdQty1wk7/kKkSVba5YF4l61B63efpoaev9IJt/VsyXgvATg==
X-Received: by 2002:a05:6871:ca53:b0:2ff:894d:421f with SMTP id
 586e51a60fabf-2ff894d99abmr898949fac.15.1752507191005; 
 Mon, 14 Jul 2025 08:33:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff8bc75ac3sm67918fac.20.2025.07.14.08.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 08:33:10 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:33:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [PATCH 2/6] km: Kconfig: set KM_RESERVED_PRAM to zero for all
 designs
Message-ID: <20250714153308.GH13084@bill-the-cat>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
 <20250714132221.2471558-2-holger.brunck@hitachienergy.com>
 <20250714145212.GF13084@bill-the-cat>
 <AM9PR06MB7843D024FB26194DC5AE943CF754A@AM9PR06MB7843.eurprd06.prod.outlook.com>
 <20250714145821.GG13084@bill-the-cat>
 <AM9PR06MB78434DBE25572F3CCF32A25DF754A@AM9PR06MB7843.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KW5J607uqVDwhGDK"
Content-Disposition: inline
In-Reply-To: <AM9PR06MB78434DBE25572F3CCF32A25DF754A@AM9PR06MB7843.eurprd06.prod.outlook.com>
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


--KW5J607uqVDwhGDK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 03:27:32PM +0000, Holger Brunck wrote:
> > On Mon, Jul 14, 2025 at 02:57:41PM +0000, Holger Brunck wrote:
> > > > On Mon, Jul 14, 2025 at 03:22:17PM +0200, Holger Brunck wrote:
> > > >
> > > > > This area was used for special purposes on kirkwood. On the
> > > > > current designs we don't need this anymore.
> > > > >
> > > > > Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> > > > > ---
> > > > >  board/keymile/Kconfig | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig index
> > > > > 41458813858..3a66b2915ac 100644
> > > > > --- a/board/keymile/Kconfig
> > > > > +++ b/board/keymile/Kconfig
> > > > > @@ -31,8 +31,7 @@ config KM_PHRAM
> > > > >
> > > > >  config KM_RESERVED_PRAM
> > > > >  	hex "Reserved RAM"
> > > > > -	default 0x0 if MPC83xx
> > > > > -	default 0x1000 if MPC85xx || ARCH_LS1021A
> > > > > +	default 0x0
> > > > >  	depends on !ARCH_SOCFPGA
> > > > >  	help
> > > > >  	  Reserved physical RAM area at the end of memory for special
> > > > purposes.
> > > >
> > > > Can the whole thing be removed then? Thanks.
> > > >
> > >
> > > Good point, I can drop it completely. Should I send a v2 for the whole
> > > series then or only for this one?
> >=20
> > Assuming there's no conflicts, v2 of just this patch is fine.
> >=20
>=20
> Ok done. Unfortunately, the patch shows up as a new patch.
> I used the message id from patchwork to keep the relation with:
> --in-reply-to=3D20250714132221.2471558-2-holger.brunck@hitachienergy.com
> =20
> Isn't that the right way to do it?

That looks right yes, oh well. We'll see what b4 does when I apply it,
it likely will do the right thing.

--=20
Tom

--KW5J607uqVDwhGDK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh1IzAACgkQFHw5/5Y0
tyxxDAv/Xslfl5KIE9WBEQOmiA60+LxlBuxHMr4mhTn9efH4CIXR7jfy91xGbFrE
zsfZlDfpEXQbn8qqhCTSTkmktyHvAYoyk9NJCZq1thlioCfotlbBD1617x80OfRv
KuNbpfVHssdAcDNag/7gnoaDMTfpjpxYzTQpagC4nYUapXSGwr/Ls/mYVLv5RknT
Vp71kfPi/ZZUXikX1kMapscRtKEBLY9Y6ii1LoNHFPiZLvbP0X1SdFcHqBR+ww+Z
aG3cNUKZMy83uFJIjoqD1/FC+1o7cpnWel1mw4jf3qo1gLGsXTv2MX6XIwRH6TAx
ik6vcB78THoKSgnEZXVMQ/a7YItDESuPmPZQJpnoPc21iPHBOvKRgwDHampSqSTH
jubh2eKBX9zRdwMYXyE+sB6hsmpIc5PkMsa3KIAFr1aDtFtXczBoRgmbY/xQrHeu
6Ly85P92g4NGHEQy8Ceo1k2F0Fqhk1DBaA1m8Jph+W7LM6LguKL6jDu9vuQEObwz
tDZYsPHV
=PmRk
-----END PGP SIGNATURE-----

--KW5J607uqVDwhGDK--
