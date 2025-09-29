Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B24CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 20:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95714833E9;
	Mon, 29 Sep 2025 22:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P4hghtL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 241B58341C; Mon, 29 Sep 2025 22:55:29 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D79A28329F
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 22:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7b7325d8fb5so1278846a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 13:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759179325; x=1759784125; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hJRen3WJ8Gz5s2N0JNw9EUfPOPVMdkiKN9gdRdgBwJA=;
 b=P4hghtL64zVMsnI2nd7WRmc8qLiatFsRAd/oMhu4lHyFzIXVDIWMQq1uLtP8+i2CNz
 8Fhf5XQr7Air02ofHBDBcSRaYQlVwcYLDksNEQwwO9KLH94Am5d9WLZiomToRU9XTmyT
 ofQNGZMarygA7sitT+KDSdUjcf60WoKNw5wZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759179325; x=1759784125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJRen3WJ8Gz5s2N0JNw9EUfPOPVMdkiKN9gdRdgBwJA=;
 b=wthyCScGxi40X9D+ZTsUpfZKTOu2838uPQ9Ucqj+4KxfuGXzlmvmQlmhmJX+2JL4/j
 L3bal7SsEn0WsblSTgYlLCpFZwmrfxQhRHgsEGJ9wOSs7DUVCcjAShH91IbhikK6CXKF
 EY8iIwvP2yTBXKVY/GfY98q2/J5RCb9spuGSZPQQkNOaxnPjXQJM3i2SYoVQGHF3sY4t
 hlN+HaUWbpeVlj2eb55m/9cGzN0qIPiFKJHAFurVTCaTehTk87RI1dt6Ct2sxJUQCwjf
 KAw2Ngk4w/2RUIkUfaqJC+BRTltoWbrPAByPPu885ThXWjDRj6OG/xOBNQNKtosw+aLg
 PRLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVIj8sEs3Ja78Op4hM2wPgnffx7k6XMqC2GZrSuAaoQg02Vimm7dBufyU7qzTFb6YXf4aRmIM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+0aZSiJwz5fx+yvjCyWKGwgu6DhKzsXQV6FUqGIJe8lE3rFE6
 YsdPf+M+TREeDhL0O2jeOA3jdZUp91wWakNV0zmNZLr9tVKXsoljvvtAHc5xnU16ljcNmFTroLU
 qzgJmpYU=
X-Gm-Gg: ASbGncvqUsSsr5KmhU8OHV2nus7e+ht3XbgQulkOakZ4arziuvzRlYtveOIU1R64OQb
 IoMVL8sXk99nT6L7KoOD6IrWYQeqcnou0SX5OdTZo5yILHM7wdeeo6GBvkM1AHu4PV9z30g2vVE
 IgAFX401t+cAHjlga7TI9Aey78C9JQpWhquIkM/kuchUy74Q3UnyeIT9zuQOtXsz/bkleJUDlkM
 ue02NbRAhretqtSV6DS4PK+OLUW2XNNSHaWfitIylzlqk9LFr6oO56hkgclOTLMM0szP2iI0gtt
 2Dsvyr7yvsLL+gEVeJrvyQOl8wg2+MnQ9l5gH7V5353zGlfUBR1/904GrE9iauZ3UEJ8jbCc2bq
 n/hvI3blSimSfSxBEe2wYop63/mGNtG4FavjX1Q4wZ8ot+usehi7ueUYjgj0sTEof3ZE=
X-Google-Smtp-Source: AGHT+IER/sPD7WNoHN0bkgtjncXGLOWE9GDfPQdV4Gql8p5CR6+BIvanov/oWIyazK/eQx1Rq2Wt2Q==
X-Received: by 2002:a05:6830:6ad5:b0:746:3226:c68f with SMTP id
 46e09a7af769-7a801bde497mr9511786a34.4.1759179325558; 
 Mon, 29 Sep 2025 13:55:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a6dc805845sm2454049a34.6.2025.09.29.13.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 13:55:24 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:55:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
Cc: Beiyan Yun <root@infi.wang>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND 4/4] doc: bindings: add Aquantia PHY node's
 "firmware-name" binding
Message-ID: <20250929205523.GQ6093@bill-the-cat>
References: <20250923071315.276114-1-root@infi.wang>
 <20250923071315.276114-5-root@infi.wang> <aNKWLNH0ZhqFckNl@pie>
 <A93BFAC5-DB33-43E5-973B-58AF65EC23D2@infi.wang>
 <6689E83F-4029-4BD5-8AE9-20B9BC3D1A5C@infi.wang>
 <aNkyUAyL2mXvQ-KN@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c3PPTtj+b4nApoKs"
Content-Disposition: inline
In-Reply-To: <aNkyUAyL2mXvQ-KN@pie>
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


--c3PPTtj+b4nApoKs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 01:04:16PM +0000, Yao Zi wrote:
> On Fri, Sep 26, 2025 at 05:30:03PM +0800, Beiyan Yun wrote:
> >=20
> >=20
> > > On 26 Sep 2025, at 4:22=E2=80=AFPM, Beiyan Yun <root@infi.wang> wrote:
> > >=20
> > >=20
> > >=20
> > >> On 23 Sep 2025, at 8:44=E2=80=AFPM, Yao Zi <ziyao@disroot.org <mailt=
o:ziyao@disroot.org>> wrote:
> > >>=20
> > >> On Tue, Sep 23, 2025 at 03:13:01PM +0800, Beiyan Yun wrote:
> > >>> With the switch to generic firmware loader, "firmware-name" binding
> > >>> was introduced to define the firmware filename.
> > >>> Provide the document and usage examples.
> > >>>=20
> > >>> Signed-off-by: Beiyan Yun <root@infi.wang <mailto:root@infi.wang> <=
mailto:root@infi.wang>>
> > >>=20
> > >> IMO this patch should go before the driver change.
> > >>=20
> > >>> ---
> > >>>=20
> > >>> doc/device-tree-bindings/net/aquantia-phy.txt | 30 ++++++++++++++++=
+++
> > >>> 1 file changed, 30 insertions(+)
> > >>>=20
> > >>> diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt b/doc/de=
vice-tree-bindings/net/aquantia-phy.txt
> > >>> index 7dd3d45df12..1227c04d04f 100644
> > >>> --- a/doc/device-tree-bindings/net/aquantia-phy.txt
> > >>> +++ b/doc/device-tree-bindings/net/aquantia-phy.txt
> > >>> @@ -11,15 +11,45 @@ a custom firmware is needed for each integratio=
n of a PHY.
> > >>> Several optional bindings are defined that allow these configuratio=
n points to
> > >>> be driven by the PHY driver and reduce dependency on specific FW ve=
rsions.
> > >>>=20
> > >>> +Aquantia PHY's firmware is often provided by PHY-resident SPI flas=
h; if absent
> > >>> +or outdated, U-Boot can upload firmware over MDIO during PHY initi=
alization.
> > >>> +The driver uploads only when the PHY reports missing firmware or a=
 fault.
> > >>> +
> > >>> Optional properties:
> > >>> mdi-reversal: 0 or 1 indicating that reversal must be disabled/enab=
led.
> > >>>              Firmware default is used if the property is missing.
> > >>> smb-addr:     I2C/SMBus address to use, firmware default is used if=
 the property
> > >>>              is missing.
> > >>> +firmware-name: String containing the filename of the PHY firmware =
to load
> > >>> +               (only when CONFIG_PHY_AQUANTIA_UPLOAD_FW is enabled=
).
> > >>=20
> > >> This looks good to me, but I have a question: should we switch to the
> > >> upstream binding for aquantia phys? It's already documented as
> > >> marvell,aquantia.yaml, and we could avoid the burden of maintaining a
> > >> separate binding file.
> > >>=20
> > >> The "firmware-name" property is already described in the upstream
> > >> marvell,aquantia.yaml, and it only misses the smb-addr property. The
> > >> only U-Boot boards making use of this property are fsl-sch-30841 and
> > >> fsl-sch-30842, thus such conversion shouldn't be a big job.
> > >=20
> > > Good point. I=E2=80=99ll add a bit more info in related Kconfig optio=
ns and drop the doc.
> >=20
> > Hmm, I=E2=80=99m a bit lost. Here=E2=80=99s some of my concerns:
> >=20
> > - Upstream binding has an optional nvmem cell as firmware source, such =
mechanism
> >    simply doesn=E2=80=99t exist in U-Boot. This could be misleading.
>=20
> I think it's okay to support part of the binding in U-Boot: the goal is
> to reuse upstream binding, avoiding the burden of maintaining a
> duplication, and making it possible to share devicetree between kernel
> and firmware (same binding means same ABI).
>=20
> I did a brief search in the upstream dts tree, and found no consumer
> of this nvmem-cells property, thus I don't think it's a problem, at
> least for now.
>=20
> > - About =E2=80=9Csmb-addr=E2=80=9D, what=E2=80=99s the best move? Do we=
 upstream them to Linux?
>=20
> Yes, if it's really necesary for the phy to work. If you decide to
> adapt the upstream binding in the series, then I suggest upstreaming the
> property to dt-bindings first.
>=20
> Anyway I think your original patch looks good to me as well, it isn't a
> must (at least to me) to switch to the upstream binding.

Figuring out how to use the upstream binding, and addressing issues /
short-comings there is the best path forward. Maybe U-Boot will need
some method for being able to load firmware blobs from nvme cells in the
future for example.

--=20
Tom

--c3PPTtj+b4nApoKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNryOgAKCRAr4qD1Cr/k
Cv3MAQD0CmRplZVtPVTYXdCqWu7rdKhVQe1LVnkMEU9Qv3yZtgD/XUroNvSp+zWC
b9uLanJBnd+yjaOFoQA1R5G5N19dkQs=
=vipA
-----END PGP SIGNATURE-----

--c3PPTtj+b4nApoKs--
