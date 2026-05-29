Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2019DCD6E4A
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 15:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D475846A3;
	Fri, 29 May 2026 17:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="geoRRMuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF5ED846B4; Fri, 29 May 2026 17:43:26 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E81984671
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 17:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-47c35be02fdso5181028b6e.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780069402; x=1780674202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zs+NZbAA0pGEgCRrM0zi2+npBdPNfVnZE0cN79NObRw=;
 b=geoRRMukDotodMbCOlimREOay66LinV5qSv1AQmCBIxnt3Ob7Cu8js03Mm98E2WAie
 jLwotCtb0OYYPvL7t+Jyh2xhUFOzd/J/GeZX3rcHOs4zsnz/MAq0Q7Afd4DwA83ElOvm
 4kCMvKlhF7kzpYvG+Y38aXvkzmdq9UfTDpOgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780069402; x=1780674202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zs+NZbAA0pGEgCRrM0zi2+npBdPNfVnZE0cN79NObRw=;
 b=m1I7qnc9SKcQQMqDkZHardsCpBIJ3gxWxrXKGMgB2TiJOdpzcYXPUmNj5lm8BvUXBb
 Rk59CH8alOFJHzCvAd30ikU88+sSrK7tvaA0wtIHkBfUphpf//adoeXkfl/81y+/4Sc+
 AT/ZE60aUsN5SSyZP74bbN/K1S4TvFBstmV0476Ha1z/wZENPnxiAzDFs0TsztQoY6/i
 cglag3tQTmAlaXcw85D6y3y3LWbBI5cwKivPbE6aqSdjNuQoSmoJSoB8KkBfeoLeGBBP
 iQqymjcGmCPompUcsti3zzHtdspydsZm+gedF20UW/cXz6yffDzwdKdOsdbxhOz6ys7a
 nIZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ82H2oLu62WhyPwjlWaO2xWpLxsdV6nLZo2auxeKosw9gQZMnrlLgON8dvG8Sh7ApnFtskBA4I=@lists.denx.de
X-Gm-Message-State: AOJu0YzRYuoQq1zJNNm28h2wTdycp5YEPEjvvzptXHOBty8aOQ2DkeEn
 9pY7P+jj3pX8nDh3XSTnxuYzXJkEWTzOAwwW8e34YmdAzAJZx08Riz4p+Flg8jNtEI4GAz9s9RA
 MBA0SMMw=
X-Gm-Gg: Acq92OHOuobYo21K0b176S/BYhxsGSEa3tDR2ZnBfw6i3kV5CuqPaX4HqKWULi6IQ7R
 Eosbu1Mu/b67fFZdXLw6mtth1ZByEA1kbJ+j4FAtG+W0IDNVikZnW9eXnIilOGPj4D3l+JnrFP/
 q6ooH5y7LAXackidp0dhCy4id4Ce6PCaMcNywa/63ismejS3ap7HcNQJ9xa4nZwAiPK+5krWpKs
 tQo2vpXn0MhNe0sIPxXb2LSjJSI+JCN/0FAgTgWyIUNQQbwJI4ehABEaRSRACf8Tl+M90jGfg6z
 HuHf1MAy1AhQQP55FSB2UJxvG5XMIN/8HYDGnYqtW594lbQIHJ+Dmj1QS64aaIPFsFvD7+WhckO
 iaesC2ZLFIAxrDhdDzmRBdOBlFRdUhQRcBac3E2V4sn1l6Gge7KH9qz80wZxq42m+aK2+xDrUBy
 AI1UWYXXuF0wu2jNioc3sKm/1ajD7xNn1IzfaP++B2/UJ+3SL5oKE9oa3TLaGCiWpQbaJ26dyD5
 gu58DAvwXhWVJG2aihRn0tkcgm4D0NsmSf+apjpCHXWmOjMLF0bE0Q7
X-Received: by 2002:a05:6808:c1af:b0:484:c3f6:de69 with SMTP id
 5614622812f47-485e6d0be72mr1821491b6e.37.1780069402591; 
 Fri, 29 May 2026 08:43:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-485ee13b24asm837375b6e.9.2026.05.29.08.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:43:22 -0700 (PDT)
Date: Fri, 29 May 2026 09:43:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: vigneshr@ti.co, u-boot@lists.denx.de, christoph.reiter@evk.biz,
 dlechner@baylibre.com, flaviu.nistor@gmail.com, jeyu@issi.com,
 miquel.raynal@bootlin.com, yangshiji66@outlook.com,
 ssunkkan@gmail.com, vigneshr@ti.com
Subject: Re: [PATCH v2] mtd: spi-nor: Add gd55lb02gf chips
Message-ID: <20260529154319.GB627328@bill-the-cat>
References: <20260510222140.603755-1-vjardin@free.fr>
 <20260520150032.1904130-1-vjardin@free.fr>
 <5a74856d806a4dabad4055498c2c1420@infineon.com>
 <ahmi5u70Ik5h5fBP@L30177.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O0wZq9+YWbZ145Qd"
Content-Disposition: inline
In-Reply-To: <ahmi5u70Ik5h5fBP@L30177.local>
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


--O0wZq9+YWbZ145Qd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 04:29:58PM +0200, Vincent Jardin wrote:
> Hi Tom, u-boot's contributor,
>=20
> > > base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
> > > branch: for-upstream/spi-nor-gd55lb02gf
> >=20
> > Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
>=20
> This is a one-line new-chip addition (without driver changes),
> the patchwork delegates to jagan and SPI-NOR maintainer block
> (Vignesh R) both appear quiet:
> Tom, would you mind picking it up directly ?
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20260520150032.1904130-1=
-vjardin@free.fr/

I will likely pick this up directly to the next branch in time, yes.
It's not been 2 weeks and that's the usual time window. Thanks.

--=20
Tom

--O0wZq9+YWbZ145Qd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahm0FwAKCRAr4qD1Cr/k
CixvAQDkAJlqTMXddJo932/h0uq29rBe88uDjlfJzofAumT7xgEA5u2YscOpAjMP
EYr2WTU8cpcxZkS4+Ezvriw3Ey7pqAc=
=nlxb
-----END PGP SIGNATURE-----

--O0wZq9+YWbZ145Qd--
