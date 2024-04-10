Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20502CD129A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 15:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D63E874AC;
	Wed, 10 Apr 2024 17:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CBwG+WVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29BA987572; Wed, 10 Apr 2024 17:29:04 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA27870AB
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 17:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78d743f3654so90554685a.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712762940; x=1713367740; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wdHMvIu+fMNRCLwjutQwKPjyqXtNhbgx7XPjublCCCQ=;
 b=CBwG+WVJ+2QiKaWRr44HNh3weHeCfGJtZtIwd6e+nwXadhu1rJNN2QtohbprhfLD+c
 lpoOBE8nJnra0sG48uJxeyDi8z8eIr6ntqYDf78Rx3PjcuH3bnha44JSkcLk6AI0qJl/
 nP1tg19Jdco/tmqbxspOQOd5HU8kzu/o0Erqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712762940; x=1713367740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdHMvIu+fMNRCLwjutQwKPjyqXtNhbgx7XPjublCCCQ=;
 b=UlaNQ80V4ZwnXv5rZHs8omIr4mhMXqazEKIt5RZo37Fmy3Qu/yXMlbaTr/E29ybZM6
 gzUjtPrhl7ylM+b+dYGY/jfEFxWvrl3ocHN59bgkBTTFxVL/KWjymKDSCw3iDZl4QdCl
 fEqlCc/LL6J0IsB9hw3HZJ+hZ5v01sqXIe2LtT6DzejoksYzj8HdnekjidXAOl72v1TH
 SIIkp4VF8wVvycd+F0NxvbeoNx9tyvuDT3s2AETGl5LwO8SxSCfOAFZej/6AE++BFXMR
 1qLQmyfLQUCJhF96+Gr7XwlBNKOgkE4YCiRAmZPXFj8a06hPDPfIKMcQTxiE4aFw9qTr
 057w==
X-Gm-Message-State: AOJu0YwAQmvWGwa9KWvrYFzgMNq00FeDbi1N6ojLH992EulSO4soNcWa
 I3dWKpqZcpvVmu7JUrlc9xAOc1eL9TpDOGbQQ8+ssbcEkApSt2pzQgSV6vlKkUI=
X-Google-Smtp-Source: AGHT+IFzwaEEqx1NxeZNvc+CMZ2FIogwp3ag4zLcTKW/HMXJrvHq2gSCNpMv53N8SbE6tjEVB8Oyyw==
X-Received: by 2002:a05:620a:1087:b0:78a:6a01:d8d with SMTP id
 g7-20020a05620a108700b0078a6a010d8dmr3194072qkk.65.1712762940087; 
 Wed, 10 Apr 2024 08:29:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 p24-20020a05620a057800b0078d6c4b0b3bsm2006942qkp.26.2024.04.10.08.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 08:28:59 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:28:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH 1/2] lmb: Avoid to add identical region in
 lmb_add_region_flags()
Message-ID: <20240410152856.GA4170860@bill-the-cat>
References: <20240311143918.2927406-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GVUORwRFlfnlZZIr"
Content-Disposition: inline
In-Reply-To: <20240311143918.2927406-1-patrice.chotard@foss.st.com>
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


--GVUORwRFlfnlZZIr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 03:39:17PM +0100, Patrice Chotard wrote:

> In case lmb_add_region_flags() is called with the same parameter than
> an already existing lmb and this lmb is adjacent to its previous lmb with
> different flag, this lmb is added again.
>=20
> Instead breaking the loop, continue, at the next iteration, we are able
> to detect that this region already exist.
>=20
> Issue reproduced on STM32MP157-DK2 with SCMI DT, bdinfo command's output
> shows:
>=20
> Before this patch, the last LMB [0xde000000-0xdfffffff] is duplicated:
> ...
> lmb_dump_all:nnn
>  memory.cnt =3D 0x1 / max =3D 0x2
>  memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
>  reserved.cnt =3D 0x6 / max =3D 0x10
>  reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
>  reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
>  reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
>  reserved[3]    [0xdaadf000-0xdfffffff], 0x05521000 bytes flags: 0
>  reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
>  reserved[5]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
> ...
>=20
> After this patch:
> ...
> lmb_dump_all:
>  memory.cnt =3D 0x1 / max =3D 0x2
>  memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
>  reserved.cnt =3D 0x5 / max =3D 0x10
>  reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
>  reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
>  reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
>  reserved[3]    [0xdaadf000-0xdfffffff], 0x05521000 bytes flags: 0
>  reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
> ...
>=20
> Fixes: 59c0ea5df33f ("lmb: Add support of flags for no-map properties")
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

This series leads to CI failures:
https://source.denx.de/u-boot/u-boot/-/jobs/814084

--=20
Tom

--GVUORwRFlfnlZZIr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYWsDQACgkQFHw5/5Y0
tyy5Qwv+NwcZaWbaM9O6vMWfacaXd64dF33Z1OhtD7XWU+cIqqChbICFBRZEiDpa
EIxjTZcol2+d0O6vX0WGimjAK7xuEXdvKlTw2qEG/8lOECrJ4KGFMDkYii6iwxOz
dW1Lajg+OfwBD5pTZOmOisFV1q3qqdycqV7BgRAU7qPUMMUEjIStoiadxlWUBAoW
gvNikg2+cZqHG8UxvMgp5p1yeEHlcmpYEX0Ett0X+VLGlCADH+i6yazGS0ESYAsc
uj3V8LPZwAEdy7PjyOA1z3iDJl1LYFjAepjiVNHcVyWJZdaAcZZRiDDBh3NwJrwP
vRYThkLPaNkfZuNPk7Ah6ly4P/VK0Y/iJUwMW76rkoYaQRy2B6g1KAeHS8v4IevY
f8YfNyfIRlQVS6cJtgMw7jkW9SBAO9ZkRUJIWayjHJpaJSRM1OdKRs31lkXFfnfk
+12RCHXYBPcByFzU1xrwy3xgHpbQZuvTFtrtWD7yIpCRS94xNnPNueEsOXXhTfJn
++W6AGMk
=Jz0j
-----END PGP SIGNATURE-----

--GVUORwRFlfnlZZIr--
