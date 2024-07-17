Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EF8C3DA62
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 18:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E82C882FA;
	Wed, 17 Jul 2024 20:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BLIjxt+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C8287E2E; Wed, 17 Jul 2024 20:05:07 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB45B88AA7
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 20:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5b9778bb7c8so647332eaf.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721239503; x=1721844303; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=739IPBGnIodjTRZ3mLwgHoBubFT5VmNm3E5LTs35/O0=;
 b=BLIjxt+iab/eE3kyvsK0vF9dQf/XEPdLNXJyaCSrAxocCLfpTJWVfKKKDMluaoYmGv
 FM018MklA7td/QJsnY4mzmaauEqJMAbgy1LIqQ9xbLu5z0RKmoYJGT9XwxbzR0eBHxKn
 +dbI3t9w2Br8vW55GEojz44FhsRAhWtewdNpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721239503; x=1721844303;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=739IPBGnIodjTRZ3mLwgHoBubFT5VmNm3E5LTs35/O0=;
 b=DoAz1SjXa4cbNK1f8Gq9uo0INOuPREzv5gQCJ4fgP5XYd7WmtEQl8u218mdLiL8eTC
 /ramdG4QSDLj3Mimx99A3sdytOcqHGlD+taaRt2nL8iJSRpMQK+YNotNYLPAMii8pnuV
 qGqZPNddLOs+AmggVJq5GB1dHP8jHs3LIwSxEBeLZu/dSnkSZCgQ+L5hx1npqLrs12nS
 H7xBKvlR2IblYTYN9Io9a6UTfiF+MnoXjUBO5EQFlmbAXURty3mxKlu0LDshbZai/tV0
 vq8dry1M6jlcbVtA//x44Tgl3O3xalbki+7IppFw3SGu4WglaLp/wHSALa5NBFT9Rpvl
 HHOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt1c5rPqeTJZHJnvdFLXwFph31R5MJjwAqPnLhMXWNC4WA1AHTepYix8bc5BCKR1B/07DVX+mq3Sm6uNbhFqsGvkEFNA==
X-Gm-Message-State: AOJu0Ywki1H/AN4UaXWn54edQdLOE/xxFjdDfyez80CAzvX1KSpaBJJp
 06EmMPlerPisK4wG2vhbFlUfcFjztPHzW3grNiXM3zumpH6ByrfJDgmUYFtmA1i1iL0zfIgPT2w
 1
X-Google-Smtp-Source: AGHT+IGlwmSKddCV4m6lpm92IVngMzOT0yqhptrdYcdd8tNK65IJ59EmaJtOQnqu1pjv2GUOp3lbhQ==
X-Received: by 2002:a4a:ee95:0:b0:5ce:d2e3:b18 with SMTP id
 006d021491bc7-5d41d796ab7mr2230088eaf.8.1721239503300; 
 Wed, 17 Jul 2024 11:05:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d3cc6b7d92sm367871eaf.43.2024.07.17.11.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 11:05:02 -0700 (PDT)
Date: Wed, 17 Jul 2024 12:05:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] b4-config: configure `b4` for U-Boot
Message-ID: <20240717180500.GT561963@bill-the-cat>
References: <20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com>
 <9caf5b15-971f-43e6-be8a-c6a2f4bd0bb1@cherry.de>
 <f7dca457-d947-4fe4-972d-2ce388d4311e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4DcJPLVlYA1vgSQS"
Content-Disposition: inline
In-Reply-To: <f7dca457-d947-4fe4-972d-2ce388d4311e@app.fastmail.com>
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


--4DcJPLVlYA1vgSQS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:44:03AM +0800, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B47=E6=9C=8817=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=
=E5=8D=8811:26=EF=BC=8CQuentin Schulz=E5=86=99=E9=81=93=EF=BC=9A
> > Hi Juaxun,
> >
> > On 7/17/24 5:12 PM, Jiaxun Yang wrote:
> >> `b4` is a commandline tool to make patch-based development easier[1]
> >>=20
> >> Provide a .b4-config file to match U-Boot's patch preference so it will
> >> be easier for people to use b4 with U-Boot development.
> >>=20
> >
> > I've been using b4 with the default settings for a few months already=
=20
> > (i.e. without arguments, without .b4-config), is there something=20
> > specific that made you want to override the default values?
> Hi Quentin,
>=20
> As per U-Boot's contributing guide [1], it is preferred to send patches to
> u-boot@lists.denx.de and cc custodians.
>=20
> But B4's default behaviour is sending patches to custodians and Ccing
> mailing list.
>=20
> Thanks
> [1]: https://docs.u-boot.org/en/latest/develop/sending_patches.html

Honestly, it's not a big deal these days I think.

--=20
Tom

--4DcJPLVlYA1vgSQS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaYB8wACgkQFHw5/5Y0
tyxZIAv9EosjD931qbso1ur0XuJoKzABlpOP2i+gXoOVzHbcuZl0g75MDKO5tQvk
2PW4ETEL23TaI1t1ysWIVE+tDQXopymgxrn2/EFnLfNy1Us1iwFv4nHBrDSwzbrV
H8hcfWErWyhLgnarp2cxJlOjj7C3WYId+hFgoBjHe3IMz6AJHxmH5autfXTMHg4/
6Sl8Qbp746Hq6rsPJqWrFaGj+YUBMaPHwN9UpFzeDhaPdHx3Q+08UCkijmQGRrDL
sc9d0mjgWMMJ3E0ndugJuj9NsN2rWfIvO3wAGGQuEwRN94D6oegLl0bR2k4RkTrE
UZ84zBqbMhkIP6xGRk01tB1bJny+zy6YHK5u45BlmQTPO51K0S6HVOwHKoeOk7q+
6M7CX+nB5MvS90zt/5YfGGtIYPsxsYYsfTdLeQ/3+4N/+54AHZkkhzYdYN64aZie
VB6nVZ2KZgegiLDbsDxmZvy324sF2SF3/ZRfMxCLKKMjNTd5hQLNQq7yOzaquETv
ruqGYbIo
=qSOE
-----END PGP SIGNATURE-----

--4DcJPLVlYA1vgSQS--
