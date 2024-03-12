Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC0BC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 19:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB06187ABC;
	Tue, 12 Mar 2024 20:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FI/Eyybm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6585287B2A; Tue, 12 Mar 2024 20:45:24 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81179879A0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 20:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-690d7a8f904so1684026d6.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710272720; x=1710877520; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WiRT1/wPELvHxxkV8MuxgfeCsfz2KTonadQifKv1VAA=;
 b=FI/EyybmsXEhjElUELYlKyuaPVICVn+B2ANg5p/Z/z5FMXOl64tpzVIMPKBZaKq2Uv
 QGbKEmEuo1YgV2LwVsR15fvSGb/klYHqkGX8LesgByCA3tUnE4CXlwT6zTAg5Rti03tT
 S6B7mw5ecZD1KPuTQae4HVhPq+18qDmrRdofE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710272720; x=1710877520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiRT1/wPELvHxxkV8MuxgfeCsfz2KTonadQifKv1VAA=;
 b=ttL0AVBfUG6NWbcWv0cJJ3wSM5sSNkfZrJpMr9SaVx/S7HP2ogbh1aUFiLL4kx3ZeM
 mM99asYJpnlyJkYAe+p75Pwn5lwlhvy5+iLHJ7iu0AjSdVRwXsQIysWZfchkh7XCyq6P
 BLno7u9ezjbckuX+aGXrgBtNTZNUV51ZTqoMwPR+wt0n4DVB8fehW2asSO9s5rz9Jnv2
 z2vtwOccq+mvFq7R+EKnMaGnwFlmybkzF5gzfxj1KLDBPZH4gdi0KWMyKHk3wCR0RmwO
 sMKMR2gWimXpeeQvuOgcwzgh/NrmitKP6xOePUOa98iVEOjMVkT6rQK14n0vbKXoPuLD
 PmWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXQ1BbMvs5ArYpZ/ZDAv6IwdiqqS8+csi8ciPilPtkOsklTf+ovzz6D268PU91h87yFJ/P6ZWOypUafneYjELtCYoE1A==
X-Gm-Message-State: AOJu0Yxb5rc/pgOD2MrHYT4mtwQJcoW19ShXN4yueS5ATZDz1QhywEPQ
 Yq7owwAjr6bM92QX5We8stP8m7OrnjVImLYTob3aownIeBivQYwukX/WdfU9M7Y=
X-Google-Smtp-Source: AGHT+IF2oXcAYJDbqYhlLXWQqgV+JF6uK5GhcdXvc720vzKnsiVRRZlb12BJg118eXyGkETbqGBCqQ==
X-Received: by 2002:a05:6214:2e0f:b0:691:fcd:52e with SMTP id
 mx15-20020a0562142e0f00b006910fcd052emr554091qvb.10.1710272720142; 
 Tue, 12 Mar 2024 12:45:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1003.res6.spectrum.com.
 [2603:6081:7b00:7f::1003]) by smtp.gmail.com with ESMTPSA id
 w2-20020ac857c2000000b0042f541ee072sm1191457qta.4.2024.03.12.12.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 12:45:19 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:45:17 -0400
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?6rCV7ZuI?= <lionkang70@naver.com>
Cc: Kang Lion <hkang70@hotmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "lionkang@wavetc.com" <lionkang@wavetc.com>
Subject: Re: About U-Boot License
Message-ID: <20240312194517.GF1523872@bill-the-cat>
References: <SEYPR01MB5364E20BEC422DCA667399F5A3242@SEYPR01MB5364.apcprd01.prod.exchangelabs.com>
 <20240311182423.GB1523872@bill-the-cat>
 <b5b3a55e992db6abc945a8af234b9c20@cweb001.nm.nfra.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PVtybM/IULJCkVXs"
Content-Disposition: inline
In-Reply-To: <b5b3a55e992db6abc945a8af234b9c20@cweb001.nm.nfra.io>
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


--PVtybM/IULJCkVXs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To be clear, having both U-Boot and RTEMS on a flash image together is
not considered linking. Having U-Boot start RTEMS by the mechanism that
exists upstream today is also not considered linking.

On Tue, Mar 12, 2024 at 09:37:32AM +0900, =EA=B0=95=ED=9B=88 wrote:
> Dear Tom
>=20
> Thank you for your reply soon.
> You mean only changed U-boot need to comply with the license?
> The proprietary OS no need to disclose(don't care) at this time, even if =
they are merged by one image. right?
>=20
> waiting for your kindly reply.
>=20
> Regards
> Lion
>=20
> -----Original Message-----
> From: "Tom Rini"<trini@konsulko.com>
> To: "Kang Lion"<hkang70@hotmail.com>;
> Cc: "u-boot@lists.denx.de"<u-boot@lists.denx.de>; "HOON KANG"<lionkang70@=
naver.com>; "lionkang@wavetc.com"<lionkang@wavetc.com>;
> Sent: 2024-03-12 (=ED=99=94) 03:24:23 (GMT+09:00)
> Subject: Re: About U-Boot License
>=20
> On Mon, Mar 11, 2024 at 05:40:19AM +0000, Kang Lion wrote:
>=20
> > Dear DAS
> >
> >
> > This is lion. Nice to meet you.
> >
> >
> > I'm sending you an e-mail because I have a question about the U-Boot li=
cense.
> > I would like to know about the obligation to disclose the U-Boot code c=
urrently provided by Xilinx(zynqMP).
> >
> >
> > 1. When we use a commercial OS code called RTEMS, we use U-Boot as the =
bootloader.
> > At this time, even if RTEMS OS is commercial, if we merge an image such=
 as an open source called U-Boot to make a final image and use it, should I=
 release all the codes? I want to know the scope of disclosure.
> >
> > Do we even have to disclose commercial RTEMS OS + Application?
> >
> >
> > 2. Or do you see only U-Boot as a separate image, and since the OS is c=
ommercial, there is no need to interpret it separately and disclose it?
> >
> > At this time, should the U-Boot be disclosed according to the license o=
r not? I wonder.
> >
> >
> > cf) We will just change small part for only definition, but I'm afraid =
that we have to disclosure our every code of RTEMS and Application.
> >
> > That's why I'm questing it now.
> >
> > I know you're busy, but please answer me.
>=20
> This is a question for your company's lawyers. U-Boot can of course be
> used to launch a proprietary OS. Changes you make to U-Boot need to
> comply with the license.
>=20
> --
> Tom
>=20

--=20
Tom

--PVtybM/IULJCkVXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXwsMoACgkQFHw5/5Y0
tyw1Dwv+NzbCxT3owQKvjsSYRkvXk9MrYSH+A8KV3/yB6XkDESQRu4eI3A2jYJdK
SRFL/di69NSonYzMQqnoY5Fsep8zFjIhBd/yPIg4g+6TtCLPayYMGlKoNJM2H8x7
rQ+XNQgo4CaejgkXB74VhQ90AO7EvrcOtHeTlfAojWx6veRHTkNYrnQhDpyy77pv
JU9n4xDZ0At0OqFm1PPj5NInbV44AH8VDEtWVxi1BSy/kEGGZR0IADG0QjonJTYT
WGGRfeYymF+8f3HU8TctUmGyzLO2QYdCqq+otwzokiXzpG/MMtKwwDyaiWQ8IMmo
cfMqdFUqmyVN2h0Yq6va7RIYB0dT2Dld8pOqddrtO74KmH4aIdPrAPpUpNjDXKjj
21R4E/lO7L2055+3dkQDU2Pt331Mk6/vA+9pXF8vkxIkySTJsfkwTaf7NUeZIQmh
rtV3TxXjOAn+VmKTF2D3jVQknZJ5DBbHYn4seGvuIhDAsZ7tZ4Q7/BsabnAxNATT
0Etv8XIY
=4RC7
-----END PGP SIGNATURE-----

--PVtybM/IULJCkVXs--
