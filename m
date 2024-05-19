Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85472C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 22:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82354881F4;
	Mon, 20 May 2024 00:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iT8x97Q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91AF1881F4; Mon, 20 May 2024 00:47:52 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E372880F8
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 00:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c9a0042e7dso922625b6e.0
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716158869; x=1716763669; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tBiuKLDIn2wDn9vnh7O7TF651u6aPGSXuqkX/zPM8Aw=;
 b=iT8x97Q9IUAbVnVieRq4FBEvMR10StevnNxzKl/UAaUtSucx9VNKxRNpLqdBj4M/rZ
 CSSZIzCXbzniLSCfJThUwoKph7+Q/5Pzr4RG0SZfMLQ34zkiXOH+7pcCEGoy+ffefrZY
 fFQr5Y6nKucwXO8Ut+nuoLnAElxD0+f/WPvZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716158869; x=1716763669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBiuKLDIn2wDn9vnh7O7TF651u6aPGSXuqkX/zPM8Aw=;
 b=I1+JOFtUUR18GmIOe2SM2JlmIMhm+ve26zjtagnp1XDUnMSAGnqw+ywS5SAVkgSG8Q
 qkxkhMzfrLrDoFOmXi90zes0RSYMZvhj0Hx2HHONCc/PZ0D0bL35zdLHoWkYNAAD6tQ7
 FDaVmAxFiujIEtYl1u8+55xDZlOYkrOjMKWwo+QX+SaSAorf71lCD1VRGSrsX+lkqmdK
 tMilCRJs5iTVePVjhuqWfbT9ZYeUvAnNtqNCLLGf/xT9uk1RWKMVFFCa4yXAbQ3d99CG
 XVgXs9coeKcPCrr0A5dJuXCNLPnOKU18Zid/491h/Kiu20R26g8InZG9SarEPeMzk0Qo
 Il5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOu9MgVw3FUfi4V1KzSeweJnj9aGakEfeTvJFuumeNGnplnFgHHCo2H1sTH7Kv9b2op6tVLNhbu3W30Vz/bbI7BaHGfQ==
X-Gm-Message-State: AOJu0YxxzyJCs2r5m77HE8Z7MZZRFRh6v3zUj0mcOO6m3pAc/1Oarwro
 0jaOfm94zQL4uwg/lU4rhWYEEpMMisT2u5T3IBDq/M/bI8hXdHcraQYkkGX9LOM=
X-Google-Smtp-Source: AGHT+IEpApHCgYMB1o5HdVFvZFHdYdmztta7TLdnGVZrGu+Ln4djU2M0WYw2G9cQWi7Un8fdwSfkxQ==
X-Received: by 2002:a05:6808:30a4:b0:3c7:48ba:2190 with SMTP id
 5614622812f47-3c9970cfacamr30783880b6e.57.1716158869068; 
 Sun, 19 May 2024 15:47:49 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df54d59f4sm138464691cf.21.2024.05.19.15.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 15:47:48 -0700 (PDT)
Date: Sun, 19 May 2024 16:47:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 11/12] MIPS: boston: Migrate to OF_UPSTREAM
Message-ID: <20240519224745.GP2568172@bill-the-cat>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-11-1ea7d23f4a1d@flygoat.com>
 <05c8e427-0bb3-489f-915c-d6a7e743f63c@gmail.com>
 <56e0d09f-2499-4f04-9e52-8c122a40921a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="okwTTXk+eq/PYpel"
Content-Disposition: inline
In-Reply-To: <56e0d09f-2499-4f04-9e52-8c122a40921a@app.fastmail.com>
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


--okwTTXk+eq/PYpel
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 09:57:03PM +0100, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B45=E6=9C=8819=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=887:20=EF=BC=8CDaniel Schwierzeck=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> >
> Hi Daniel,
>=20
> Thanks for reviewing the series.
> >
> [...]
> >
> > should be 'select' because the switch to upstream DTS is permanent and=
=20
> > it does not make sense for the user to be able to deselect this option
> >
>=20
> Do you want me to send another version or are you going to fix
> it as you apply the patch?

So, in the case of OF_UPTREAM, it's "imply OF_UPSTREAM" everywhere else
and while there's a case to be made it should be select instead, that's
probably a future clean-up for all users.

--=20
Tom

--okwTTXk+eq/PYpel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZKgY4ACgkQFHw5/5Y0
tyz0uQwAr14fL/+vRQVMnz8hxb4BzHNNzhKQmYn2M2MmX9rFCPopUCcX9Rx+/zjt
oZ0caBGTBzTzIvyrsgQ9bhUwn7rysJYbdVtUAf4RU35bStG7Jf7NCB9QxXJ/G+58
I5lONDRuJQms9KMRiMnZ2nbFv8yoR+yfo2UeeSv2A0y6ZB66GivbuIrL4Wkmi6Ht
10jcnQabCZdQJc9cR2PoL+krBBklgtEaIwgReEvfpnGbsN7L7Cc9az1ykDw+ji4e
qHAFi7/MBTFU+junCkz+pAWCTv4lq/iw6sbdFPvrcSiOlKrp4+ZVkGQ1qccqOXCz
ONJ7L0ulbslBhVp2ODKkC74sxML5PXj3MALh7CcOUxniCo9RaMUXX3NjaDXXoACY
DTdGcPskai7nL3FcZpNvNJzLVeIxj5UrP93MO5R9DrWIaUTlyMuSo5uc/Wc33xHW
pZDzgLQSptmrlw57nHcq+fR8T5s5zlvtfRs7r/Ac+Nmd+hiyWKrF9psk9/QWdwNm
gWepJZeA
=1Hl+
-----END PGP SIGNATURE-----

--okwTTXk+eq/PYpel--
