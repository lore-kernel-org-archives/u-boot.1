Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EFBC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 19:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A1CB808C1;
	Mon, 20 Jul 2026 19:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQ7-SDbvHLpg; Mon, 20 Jul 2026 19:14:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F1EE80835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784574885;
	bh=RsY2OqtWMp1B9XezANSQuS29Rv8gnEvtyJUdMZ4f814=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=E5ohKQNE8eY6DKOSuCBFaSQEJKL9w3oIzZTyaIXVKoBtZD5GzNl7URscMSogOFE+3
	 Z0w18N7sTRCOuPe0fO0L0YneFCaFbBKSoupYdGpGed4Herrs/sSqYMFnkveUpBNr9M
	 xjwIBjMlKZJZiaO6T/OvYAOK/OKJlzKzOVTMAcatGMHWlM8j5K8wTRIcEtYSYJWlAf
	 zCi+KFbrnK6wVpd/jQI6cgF2jfWz3LiXV259KmCnI3O+TdRJfOdt7CE1MR2edCPzKK
	 NdFy2P+pvhze4X1aZ3T6HK+x/+NSoledgRM21uakUmeQ0/EhjYHOIhblkCoO7L2ced
	 gqb9kwhUEMvFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F1EE80835;
	Mon, 20 Jul 2026 19:14:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37323313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D1E8606FA
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pBKK2P4uiABW for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 19:14:43 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BD31660681
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD31660681
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD31660681
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:14:42 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033F182991; Mon, 20 Jul 2026 21:14:39 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66116842FC
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 21:14:36 +0200 (CEST)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a1888969ddso6188933eaf.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 12:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784574875; x=1785179675;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RsY2OqtWMp1B9XezANSQuS29Rv8gnEvtyJUdMZ4f814=;
 b=rNGmjUa76y8Z5p+UgUZQDmzhaxwcWsq7EP72SkrB3guai8GB0QekN8BM9eLC/ZY5qL
 zBrx2s2T4JQOAeWL3dAvmbDajCj/cO6oZdDD6kPk6bL4H+Dj3W4YSxVBEHITRqbgNyv/
 5v5g39FRYJpJ9n3xzNqhMsKizu9vSf+3B0dF6tgZ/n94maXYteBAAKpxgj4z2mnDSQb9
 phnBar5wpYVDAT2f4qSp2x5DuGk0T6xJofa85HF+C2Wn9ZBRBpPvH1QB+rnGZj9vtdPE
 iQf3ZQrB27ILaS3E6w68PnKgykOGRsx1uhkOInPNqSgYuYKjLiB0gdeCs3jF/YjHqZXs
 iA5w==
X-Gm-Message-State: AOJu0YyiVPSTFirWZYhPrzGIAzmFo8AxmLaQmm9E4F01ZccO0oEGUhFs
 xwQlbyvzbKL+HGK88pZpewIb1q7TpBOz5nbbo0A0yuow+ZNhL69vpCr93fcQJGMrpZ4=
X-Gm-Gg: AfdE7ckHiN0KSvyDt6dV/BdH7lBH8ZOx1+rvWdY++vYPtEwMqIENIdT4vNeCa+E6xFw
 lH0xChwHgyVT3RWCIGBAGytoWJte2JmdOw1PAvMDhaFclxT5LYzfH0lDS16GUv9tS5KUBUHOQ4Y
 aEnhsw1anIKbfF+Fi012A1wJQ63Z7iHMvHzHeWllS4QGv+jJODRA3Iu38hYDe71R4h+sUTwT4cc
 agF/UPV/WaKhDKxpISxndsr9OudWIDjWwTif7Lr4nm3oxdnTYti2RdgjqYvTqH5UwER/mO8Tdu/
 57ip37BEeIqJ/vMhA48jZoiLRdWDgPONZRBXOlYe2yTrHbTobi6L+Rm9h3VZZLs3/9aLLyl7XcU
 98MP3iMDv4HqURUR3O7BUWHZFwR8hHKyM6qx5sLAHcCg282V3aCOpsfMuOsku/WLGUv5OxbZEn4
 rWkM+BIrH+hcXUlMqxp4lQbBfiyl8XnrwKzgu/fve4Nr/h6O88XJYQ/n04rQHXCy+P461VrYV0X
 ryLck0z3vhp1wPfsQ7oZUCgRVs=
X-Received: by 2002:a05:6820:189b:b0:6a1:7895:658f with SMTP id
 006d021491bc7-6a53683be3emr7410882eaf.41.1784574875102; 
 Mon, 20 Jul 2026 12:14:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e6a8c92sm9186578fac.14.2026.07.20.12.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:14:34 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:14:30 -0600
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>,
 Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH 1/4] bootstd: add a firmware-owned devicetree source
Message-ID: <20260720191430.GG749385@bill-the-cat>
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
 <20260706-ccaione-upstream-ebbr-v1-1-e742cdd6abe5@baylibre.com>
 <20260708171806.GZ749385@bill-the-cat>
 <CADh8LseqgrheGSjHhwXsH=prD1=Tnpnt0ZMx=-9jKV88Gsbumg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HYJcNh5/koaDBXrK"
Content-Disposition: inline
In-Reply-To: <CADh8LseqgrheGSjHhwXsH=prD1=Tnpnt0ZMx=-9jKV88Gsbumg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784574875; x=1785179675; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RsY2OqtWMp1B9XezANSQuS29Rv8gnEvtyJUdMZ4f814=;
 b=daUM3ENnVNOukSk4VnwTA3YJYoiMmM0rrOKOP9KaTDoCvIzJyTY+YREzP5b/o7jBQn
 fnmcySCBtOVqUpmLBrFlpIsijwrQfEXp/EjUuU6Wqanw6I14UtELXMouXqOn5yZj9JdS
 SEOskoLrQgr+mZPCjH8v+Oub+Xza/hHbOKf+Q=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=daUM3ENn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="daUM3ENn";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--HYJcNh5/koaDBXrK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 10:36:06AM +0200, Carlo Caione wrote:
> On Wed, Jul 8, 2026 at 7:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>=20
> > I think I wasn't clear enough on the RFC, sorry. We need to get this
> > binding approved over in https://github.com/devicetree-org/dt-schema/
> > and I strongly suspect that barebox would be able to make use of this
> > too, so a u-boot prefix would be inappropriate.
>=20
> Addressing also the comment from David:
>=20
> > I have some doubts that it is safe to add arbitrary child nodes to
> > arbitrary storage controller devices like this. Many of these devices
> > already define child nodes in their bindings, so this could break
> > drivers that expect a certain type of child node already. (And also
> > break validation against the binding schemas.)
> >
> > So it seems like it should go under /bootstd if this is u-boot-only
> > or /options [1] if we want to try to make it generic for other bootload=
ers.
> > And it could just have a phandle to reference the target block device
> > provider or just reference it by name (to match using alias).
>=20
> Thank you both for the review.
>=20
> I would like to split this into two parts:
>=20
> 1. The on-media contract: a firmware-owned devicetree FIT manifest
> where configurations describe the valid base+overlay combinations and,
> when signed, authenticate the whole combination.
>=20
> 2. The bootloader-local locator: how a particular bootloader finds
> that FIT container on its platform.
>=20
> The first part is the piece that looks useful beyond U-Boot. The
> second part is bootloader policy (IMO).
>=20
> For the U-Boot-local locator, I would like to follow the existing FWU
> metadata precedent. FWU metadata solves a similar problem:
> firmware-owned data whose storage location the bootloader must find,
> using GPT and MTD backends. It uses a standalone U-Boot control-DT
> node, not a child of the storage controller, and points to the storage
> provider by phandle:
>=20
>     fwu-mdata {
>         compatible =3D "u-boot,fwu-mdata-gpt";
>         fwu-mdata-store =3D <&sdmmc1>;
>     };
>=20
> Modeled the same way, the firmware-devicetree source would become a
> standalone U-Boot control-DT node, per backend:
>=20
>     /* eMMC / SD (GPT) */
>     firmware-fdt {
>         compatible =3D "u-boot,firmware-fdt-block";
>         firmware-fdt-store =3D <&mmc0>;
>         partition-type-uuid =3D "384e979b-eb76-435a-a3a6-1a071dbad91d";
>         partition-name =3D "firmware";
>         filename =3D "fdt.itb";
>     };
>=20
>     /* SPI-NOR / UBI */
>     firmware-fdt {
>         compatible =3D "u-boot,firmware-fdt-mtd";
>         firmware-fdt-store =3D <&spi_nor>;
>         ubi-volume =3D "firmware";
>         filename =3D "fdt.itb";
>     };
>=20
> (please note that for the sake of simplification in the patchset we
> are only implementing the `u-boot,firmware-fdt-block` backend, `-mtd`
> variant to follow).
>=20
> This fixes the child-node problem David raised: the controller node is
> untouched and only referenced by a phandle. It also keeps this as
> U-Boot control-DT policy, matching the existing FWU metadata pattern,
> rather than defining a new cross-bootloader locator ABI in this series
> (so exonerating us from dealing with dt-schema at all, considering
> also that we would deal with that for each different
> `u-boot,firmware-fdt-*` backend that we would introduce).
>=20
> What I think is genuinely shareable with barebox is the on-media
> contract: the `fdt.itb` FIT layout, configuration semantics, signing
> model, and whatever partition or volume naming convention the platform
> or specification defines. That seems like the right thing to document
> at the EBBR level, where barebox could adopt the same container
> convention independently of how each bootloader locates it. So we
> share and define the 'what' but how then barebox (or any other
> bootloader) would source `ftd.itb` (the what) is not part of the ABI
> and very much bootloader specific.
>=20
> Does following the existing U-Boot FWU-metadata precedent work if we
> scope this binding explicitly as U-Boot control-DT policy?

I was hoping that someone on the FWU side of things would chime in by
now, but I assume people have been too busy. This is I suppose a
reasonable starting path and will give people time to chime in if they
see a problem with it.

--=20
Tom

--HYJcNh5/koaDBXrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal5zkQAKCRAr4qD1Cr/k
Cv5sAP4sb6wlpRNonHoR9H0HqcNrN9m1dZ7hFrNxOiU/cSp2SQD+JUpLKca28Clm
2njJAGjSlOiiewoHXvGPvFHEwVr+Ewo=
=9RDL
-----END PGP SIGNATURE-----

--HYJcNh5/koaDBXrK--
