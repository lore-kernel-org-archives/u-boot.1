Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2AFE677ED
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 16:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 355B483D1A;
	Mon, 22 Dec 2025 17:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RPM35cXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19F083C28; Mon, 22 Dec 2025 17:08:36 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5E683B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 17:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3e12fd71984so3055151fac.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 08:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766419713; x=1767024513; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=21GL9O3h20uBjtt0jIoseY1cEQCU46OsoQrE0eMLdrE=;
 b=RPM35cXSL5AGAz/jPNXCRkN+jxN0IfU1wHKp3ds+sk4PXxh8XOndu73cVR7bMLNAE+
 R1tvS7mst0qPMVTD1m9YoqjUSRXmMKzQrxUe7aDgxsibLOazl69bYhL2gFEvkRQlVI4v
 FBQEoa9D6QROuQeZkPolietCkCpXXwCnArgSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766419713; x=1767024513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21GL9O3h20uBjtt0jIoseY1cEQCU46OsoQrE0eMLdrE=;
 b=TgaQsqF7xgmaO2BWTVmQ+rr2wxGZQx3NRhkpyTYDox0tuGQUkPyfewKXZKm2zPotcz
 7UNkwmHx0Cx4TEu9G75ATBkrf8jFsfS1cnR1QPJ2846uCALaS6olGOyznY4HgfHd/cCR
 PM4s1MT31ScdyZZOI3GP5Fo05UQ2YHeXCGxpeZ8xVN7F1Z7ZI4BVsyTmKlnsJQSER+XM
 2lhytc+yue0szYOb14dB2CG3lVRV7r99oMYVexPQprpx5A1lh/hdaVqjaxOMTE7y9b51
 0YVarX+fCPWzgZPaBgfmTq6O9fug1YeHdPUILBIaKv9fTN1DlrN0pm+uqB+zUhGT3K/a
 A8jg==
X-Gm-Message-State: AOJu0YxX0wYkRcPCa47rgsV3sY2Buyzx/mehZHQDV1W0oBI5XYXGAS5A
 MSVnf0hy+TrX0PCy6Vkp3tXF2VPx/iIfau/bxj1+yfOj33a6upKqDPyeB/0Kdi106xU=
X-Gm-Gg: AY/fxX4TDK3tOltb17wN6AYjC0PNdLs2+98Vd5HCF/5431728lJ8L8efYscq9kncbLP
 P/q1O2UJzs5KvHqsneAcOxK643APBF7Yk5EPhXLXdC3TShfWkN9/C6LSJQbBRcApua38hJ/OXRH
 IsTi5J801tcNxpsYC6dfNtKIFrDn7C7VlGbWCdJEbVJU67A88Fuh1PJDALi1ncPdolB7mLg8GPG
 qVt4TFf7OHyKV1zn59GWs74xzubvWe+5oe2RQkvFhVGg0kMF2pTetpTImyjnI0YH8JorKwgDTYF
 MZsNU7FgFO1yHfRzmDaFWJxghg+Ci92zgJE/+kGqjUASV8gz3RruLF8KuIJs3vbQhAh1n+AOb2x
 wvfQ2Bye9sJyqYdL8pg/lIYTxUa8IssyQgqrAYUDgOcvQWrJOYveLnByzRGasyv78AWVTW8AkIx
 BJS597QaEJfcKZ3oea9D3MUxnqTNH6CrJyQSEy7jnuHF88EikAeA==
X-Google-Smtp-Source: AGHT+IEH86jrMKhdY9P89D9azFg+Jmk4UpQuMTbVHLCmEV11OLob9lOCNOwiS6e2W3ptc0yMPltU/g==
X-Received: by 2002:a05:6820:f029:b0:65d:2ed:6be8 with SMTP id
 006d021491bc7-65d0e97a1e6mr5916474eaf.23.1766419713146; 
 Mon, 22 Dec 2025 08:08:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f723ab6sm7216463eaf.17.2025.12.22.08.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 08:08:32 -0800 (PST)
Date: Mon, 22 Dec 2025 10:08:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Subject: Re: [PATCH v1] fix PL330 CMD supported target
Message-ID: <20251222160830.GX303283@bill-the-cat>
References: <20251222142744.74707-1-briansune@gmail.com>
 <20251222145627.GW303283@bill-the-cat>
 <CAN7C2SCOMVjujtDk6kwpQWkWNxM6fkM8TbS60+fF=LSkwSjORA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iiKdQNLWRUw1ZoHs"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCOMVjujtDk6kwpQWkWNxM6fkM8TbS60+fF=LSkwSjORA@mail.gmail.com>
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


--iiKdQNLWRUw1ZoHs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 11:10:32PM +0800, Sune Brian wrote:
> Hi Tom,
>=20
> On Mon, Dec 22, 2025 at 10:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Mon, Dec 22, 2025 at 10:27:44PM +0800, Brian Sune wrote:
> >
> > > The config is wrongly written, result
> > > in only support socdk board.
> > >
> > > Fixes: 92dcb3ad5d98 ("cmd/dma: implement dmareset command")
> > > Signed-off-by: Brian Sune <briansune@gmail.com>
> > > ---
> > >  cmd/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > index 5b9c13d85e7..5c611fb3016 100644
> > > --- a/cmd/Kconfig
> > > +++ b/cmd/Kconfig
> > > @@ -1849,7 +1849,7 @@ menu "Shell scripting commands"
> > >
> > >  config CMD_C5_PL330_DMA
> > >       bool "Release Reset DMA Channels for PL330 Handshake"
> > > -     depends on TARGET_SOCFPGA_CYCLONE5_SOCDK
> > > +     depends on TARGET_SOCFPGA_CYCLONE5
> > >       help
> > >         Provides access to Reset Manager Per2ModRst. Enables DMA
> > >         channels for ARM PrimeCell PL330 via reset release.
> >
> > Now that I see how mach-socfpga is abusing the TARGET namespace, I get
> > why this patch is needed, so:
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > But really TARGET_SOCFPGA_CYCLONE5 should be "SOCFPGA_CYCLONE5" or
> > something as it's not a board to build for.
>=20
> How to properly improve or fix these TARGET things?

Well, the TARGET namespace is for machines / boards / what-have-you that
we're building U-Boot for. Symbols that designate architecture or SoC
generally just say their name, hence my thinking "SOCFPGA_CYCLONE5" for
what to me looks like the architecture family of Cyclone V and the
things common to all platforms. And TARGET_SOCFPGA_GEN5 should become
SOCFPGA_GEN5, or maybe omitted entirely (and it all goes under
SOCFPGA_CYCLONE5), I don't know the parts well enough to say what makes
sense there.

--=20
Tom

--iiKdQNLWRUw1ZoHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUls+gAKCRAr4qD1Cr/k
CrQTAP0cl518TSGrMRZlXpcw1nRUxdC3LlnCNToQZM9cpCRLLgD/ROszMzhqPo14
aS0/lJDHopsgBh2r9isercHpwI3f7gc=
=FAQE
-----END PGP SIGNATURE-----

--iiKdQNLWRUw1ZoHs--
