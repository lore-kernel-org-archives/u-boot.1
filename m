Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5669C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 17:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EA88834B;
	Mon,  3 Jun 2024 19:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dMdEPfbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0E3882AF; Mon,  3 Jun 2024 19:23:29 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18233881B8
 for <U-Boot@lists.denx.de>; Mon,  3 Jun 2024 19:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b997b8a7efso1812641eaf.0
 for <U-Boot@lists.denx.de>; Mon, 03 Jun 2024 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717435406; x=1718040206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6945geK3tzfz6UpAJEM/+V9Ur85Yv0uoTksn4xtVGwk=;
 b=dMdEPfbbytivx8Utc9WLALTKaPSPOIiUrqGO/ROO+bY3lRGSYfsUkpZvaNxhPcXLER
 +brMWbxEt1Vy6tDx67hMLZp+FiIZOxi9BT1PXSbX6vgiwM50IkGhE98hqXROrLfWBO/R
 pHfsLGDBaeYmm7qWQSYPtWH0Wf+6bmyGwzTtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717435406; x=1718040206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6945geK3tzfz6UpAJEM/+V9Ur85Yv0uoTksn4xtVGwk=;
 b=e+pKHS+rvf43Np+BQttV9zEfBJDYtH9ebZ/VCKn5yOQe7XHZAwEF1pYGfvXepFQVYa
 FoT3gAf4YZRB5M6/jKDyKeWMkIREcpwssQskSQrEHP/Q/6svxfCZ6WaWs4ELab1XxjeM
 anctfpsPaT/XuAuoALA83C61ifzzLMlzUs7ePP5nNuqBvlOC2C3EVMdJmVUPBiLmvUBf
 UTKklTgxDBSOc5iiaxrf5TE0Yz2rDM3p1ChCQMBYLyTnI6zITMe+KulcI7xPpkLSv297
 qsKBhyXmstqHcn6UZOYJPDe3dogc5OBgIi7M/15OJvnWWwgZ0Eox6euSwfpmMmmxDOU8
 +DeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyQRwpahVMNggnmcTAT+71Ng4K/tjkrPZyVEWD6zlSCEvM5uAnoJuGyi0q1B6d/n+49amNvxoY0NmeDlrWvXX2sVf55Q==
X-Gm-Message-State: AOJu0YwDG7r4ekw2WA9KDAREi/chQ02PtSB4m3zL0rVv5okXsNInzV1i
 ASjeZnxFmQZvQ3qWmpWHdDyvzvbcyAc3HCRvQtlM3EvBvWVLyT3zXEND8KWwqkg=
X-Google-Smtp-Source: AGHT+IExbwW7J78ScBq8BjNbKpQS4klghipXngOUZn6ZoVhTmftN3RRz0dBguYeMYW9pEKVkcHpI7g==
X-Received: by 2002:a05:6820:60e:b0:5b9:f5fc:c8fb with SMTP id
 006d021491bc7-5ba05c4c937mr10090632eaf.5.1717435405634; 
 Mon, 03 Jun 2024 10:23:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba003993d5sm1500275eaf.15.2024.06.03.10.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:23:25 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:23:22 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240603172322.GA68077@bill-the-cat>
References: <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
 <20240527160708.GJ2568172@bill-the-cat>
 <DM4PR11MB52966C57EFE2BE722B9E8DC1E3F32@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240531160258.GN3714513@bill-the-cat>
 <DM4PR11MB5296624D138053E9457054B8E3FE2@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U0Qzp/+n14tN33bH"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5296624D138053E9457054B8E3FE2@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--U0Qzp/+n14tN33bH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 12:16:38AM +0000, Brunham, Kalen wrote:
> Thanks Tom.
>=20
> Can you suggest who is the existing owner of this code I could work with?

You should CC Heinrich for sure once you have things working.

>=20
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>=20
> Sent: Friday, May 31, 2024 12:03 PM
> To: Brunham, Kalen <kalen.brunham@intel.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypron.gl=
pk@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@lists.de=
nx.de
> Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
>=20
> On Thu, May 30, 2024 at 02:53:17PM +0000, Brunham, Kalen wrote:
>=20
> > Hi Tom,
> >=20
> > What are next steps on this change?
> >=20
> > I'm committed to the idea of EFI apps opposed to examples/standalone.
> > EFI currently requires block devices which is not enabled when only usi=
ng flash.
> >=20
> > Should config BLK be updated to include DM_SPI_FLASH?
> > Should we explore how to remove BLK as a dependency for EFI_LOADER?
>=20
> Yes, someone needs to explore how to cleanly make BLK optional for EFI_LO=
ADER.
>=20
> --
> Tom

--=20
Tom

--U0Qzp/+n14tN33bH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZd/AQACgkQFHw5/5Y0
tyx/vQv/RYO1H5p6ddWR411HYaio5lj1SCKN/FQN1u/4x6zhrg5YHY9GpRPVX9eq
kOAcGGrnd/V51tIP6NpsQWgMWnbXP4vNUppdnTnQxli0KgRdf8BPWYzV9G/+AJkj
0zeklYT+ddMOkNIC4XJsUszxVgDcV3ttXKubxa6uZqeG4DtoSrK3jrG6LwYNk9lY
e3qTCrnHsrSR3KrgTrjhszs5MbZ6Vu2ZK7BAKH5IdHfpvFx/w0SX1Yinbvln2jS2
6WvJZCmSsJATq8POge1v5jgTdP+izv0cbIEUpElujA0EJmBh0OvJqQ2nS4M9ROto
Ot9s9Wr2rgXx3JSw+maw2nRPmgYk0c3BIyw7M1plu2VLYPm/EoU6ythPM+faxzjk
O1+qsAquBwpiY95QSabCuSnJHtUS9dCasn9PofrkyjRT8OjEwzDwnnF0HicckUke
D/6n94e4rhVGMYL3IcQ9XEie7M01NEyj2CSiFslQL7UsUGEIvYD5O98WssTE9mkg
g5XQiTt0
=ZI2l
-----END PGP SIGNATURE-----

--U0Qzp/+n14tN33bH--
