Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20103C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780C4871CD;
	Tue, 21 Nov 2023 15:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VZWyj2mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E7B87264; Tue, 21 Nov 2023 15:09:36 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC2087197
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-670e7ae4a2eso24867146d6.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 06:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700575772; x=1701180572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NzHgzlpLVoZ5UkHF4NnwFsRGXxpsmY5b9XKQU6YTQkY=;
 b=VZWyj2mjtQuA/z/zahQMEcZw7+wEWMyZDyxidosPF2fSVswHv/BFKwKpHMU2YSTHkw
 uqTuVkiSfX6aI/8ZFSwecnXWABiNefxIHXL5qZJxtHNSNpF3lerj3xp4QIaR0e5BOSpQ
 +xaivBSsHQBRhNlCBIK3YjLihA9kdaOSTwQFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700575772; x=1701180572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzHgzlpLVoZ5UkHF4NnwFsRGXxpsmY5b9XKQU6YTQkY=;
 b=cFbEwYWiuw5ivuJAK+9+0gDkHyehB4gOVN2T8h1nl9nhkR0IeR7L8+7kyTX2Q7GExj
 VDlr4a/Op+cWEF+ucvbGbxrUhzgFUXozZ8UCLAND1DuQTQVVUhQ433NfRO0Fqu+pACk4
 8DLPnKlHt3oa2vgZAILd3D+bWGFdpfbPB1ZUlJl9bI2FXivXD1SXnMo5jduLGj8kEFvA
 Sw57BaYt4ZijVTm7tTe5Cb0TWJ+CwAzgYPZmcgO40iOuOPxxkP6zw1xPb0BFv6q/2kuG
 NyUm9UARcv7j2c3Th0LbnwC6PSCjPtA5yXNDv35sRNnO06rRc8cwSAMewWDDOHIrQQer
 +Gig==
X-Gm-Message-State: AOJu0Ywj5CiPAvylMF1HFeLKc6udCDtNClUjG1qv4hsQE6XBnwdzkELW
 11MGPJV8SdfeVb+twk0iBhbuyQ==
X-Google-Smtp-Source: AGHT+IGWYtE8ZOo5MoTZ4gi4xRh/qOTVIKHDAUyyWHoH8xASsIfyS/CMSnz4VfvlcsoKexbh5wN6yw==
X-Received: by 2002:ad4:5763:0:b0:679:d38e:3387 with SMTP id
 r3-20020ad45763000000b00679d38e3387mr3931624qvx.11.1700575772377; 
 Tue, 21 Nov 2023 06:09:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a0562141bc500b00679d90922c8sm2000163qvc.131.2023.11.21.06.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 06:09:31 -0800 (PST)
Date: Tue, 21 Nov 2023 09:09:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
Message-ID: <20231121140929.GV2513409@bill-the-cat>
References: <20231120201609.619598-1-trini@konsulko.com>
 <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
 <20231121131551.GP2513409@bill-the-cat>
 <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hNoQF73Icd3x5eaO"
Content-Disposition: inline
In-Reply-To: <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
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


--hNoQF73Icd3x5eaO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 02:46:29PM +0100, Neil Armstrong wrote:
> On 21/11/2023 14:15, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
> > > Hi Tom,
> > >=20
> > > On 20/11/2023 21:16, Tom Rini wrote:
> > > > Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux c=
an
> > > > eventually display this information
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Posting this as this was the easiest platform for me to test some S=
MBIOS
> > > > related patches on and I needed to populate the nodes so I could ch=
eck
> > > > things in dmidecode once Linux was up.
> > >=20
> > > Sorry to be late a the party, but can't this be dynamically found fro=
m DT's compatible & model ?
> > > Since I'll probably need to add this to all boards, it seems like a d=
uplicate of what's already in the DT.
> >=20
> > Part of the "fun" as to why we have the binding here is that while we
> > could use the top-level model property, there's not a corresponding one
> > for manufacturer. I'm fine ignoring the patch I posted here and having a
> > longer discussion about populating SMBIOS more usefully, globally, as I
> > think has been suggested a time or two.
> >=20
>=20
> I'm ok landing it with the same data as from the vendor.
> but couldn't we use the first top-level compatible as default smbios data=
 ?
>=20
> compatible =3D "vendor1,board-name", "vendor1,soc-name";
>=20
> and translate to:
>=20
>=20
> smbios {
> 	system {
> 		manufacturer =3D "vendor1";
> 		product =3D "board-name";
> 	};
>=20
> 	baseboard {
> 		manufacturer =3D "vendor1";
> 		product =3D "board-name";
> 	};
>=20
> 	chassis {
> 		manufacturer =3D "vendor1";
> 		product =3D "board-name";
> 	};
> };
>=20
> since the vendor name should be already documented in the linux
> bindings, same for the board name.
> And we would be free to add some custom data in the DT if needed.
>=20
> Anyway, not sure it's the right place to discuss about that !

That's essentially
https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-2-ili=
as.apalodimas@linaro.org/
which had a bunch of comments on 1/2:
https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-1-ili=
as.apalodimas@linaro.org/

But I think that since then some thoughts on the subject have changed
and that approach might be more welcome now than it was then.

--=20
Tom

--hNoQF73Icd3x5eaO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcuhkACgkQFHw5/5Y0
tyw1HwwAiGhL5ytMB41hDUR0c1kOOvYWALEfr/vwFuTDmxz68yBe4E35by4Zj3gX
5Gl6hRVBALrM/E7z3N0pD4Gr5sWZXiulPSno132ktGLYov7kPKuQiShJe19oRuKs
SGA1DWJJxxXsY1EW4t16EIx/H7+sl4q88SOHUieu1d5OkZcVwYc/9Y2brGYABiYv
BAENcJb1YE0VIEwRRz665r3dmpnXGTX4yUvODBB88hA8ILaUEgcq93gha9yGoOvt
A0OmO1J0MXuc6s/Ui+V0bJBq/pjDTzJcOtlOfFQ59plaiFY5l0i+8NKnwjm1k8xd
Ch+MZEeMDGxyJ7F0zeO0VPQ7LW7qpPIEaiGtvKA08v6xiwKlbKvXaxzDWi3Uz4TU
i5bLY0sWH04pXTYShPhK5KmliGfessaM+y33jWW3XigBH/Hr1wRaQ1tRy40iWd0u
HT47kTAhy4vRx/qjJQ160BAERk2r/vaN3/sO8KD/hNO7WIlsx6gCnZMCZXLEpEVb
Q+efy3Ej
=kboi
-----END PGP SIGNATURE-----

--hNoQF73Icd3x5eaO--
