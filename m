Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63081C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 14:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A6EF87E23;
	Thu, 15 Feb 2024 15:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mklc2mWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FBEA87DFD; Thu, 15 Feb 2024 15:01:16 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340EA87E03
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 15:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dc6cbe1ac75so669080276.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 06:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708005669; x=1708610469; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ytTRNhS2DvdioZna4173bRukvIocRF4gfZFTnQFizVI=;
 b=mklc2mWW18e3ssbnCCEUhVpbaxEKsqPikHfqbozN/tnwAZy8Ipt+3f6PNzymcAsFw3
 bRgeT6v84omeZhMU+i0ktYsS8Ix1QJhQ5VqkJQVOamBV4RTKiS3DNUudpX6Wn/wevjnp
 SRtreBPJa6QXJ+tkOjnGQwJ/qS6n0gfguzNpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708005669; x=1708610469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytTRNhS2DvdioZna4173bRukvIocRF4gfZFTnQFizVI=;
 b=s+Pw4VWxJCVvymEW4K6o9UgtzJnUGHzqY0g833dVtt7400pMtXON+GgkjD+BCkY6W0
 eJpbd7vgyVbb9dYSk42Ng07SEUhKLN9GsXYuRAqBsy0P7YoWbjRQG4pLzUE6NWAnLjly
 W2yNvFiLd7pZPOMST5VudUywwynrAUA6bL+CTflb+qyLCeMcqnbnNhhHkDYxv4iuiioX
 ngYWdFFi54bV8PBE/IiAU1PVU/HUFyeHA+yewJVRnFjaT65ZUTYCX6r8KzbnkmnCb/8G
 8J58a5OkEaJa8+JbZkQeKDbXuv6pkAW1dlADXKw4zXcPLOu43by5a4Zqda8NNFp1NPSy
 RKMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVil+aj3jxOwT3eGpZUzr/ZsVq/no5wX2LGr4zmnfXZTyF3EAjeqsU6MtoUmELRdE5fU9/Tmg1fmqmxxZoHf+D4ff7zwA==
X-Gm-Message-State: AOJu0Ywg7xAIMFrA/7iRxNF5rFdh4psP31OJDERTzHkzX2cvf5JqaQ7L
 azd02VUf4DayvAWM6eo2k2jkcYTJbemwF48JRB97RYkB3FWQG2O90DZKHRX1izE=
X-Google-Smtp-Source: AGHT+IHPc0OcygYV8arbd9+2ezpidGqEZ9Qe90oOhQ4HF9a/2OyqrOVdvr9KHYaab828p/uWUk99Hg==
X-Received: by 2002:a25:2e4d:0:b0:dcd:a731:a097 with SMTP id
 b13-20020a252e4d000000b00dcda731a097mr3831997ybn.2.1708005668941; 
 Thu, 15 Feb 2024 06:01:08 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 k25-20020a25b299000000b00dbdb2966f67sm194112ybj.24.2024.02.15.06.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 06:01:08 -0800 (PST)
Date: Thu, 15 Feb 2024 09:01:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Frieder Schrempf <frieder@fris.de>,
 Kongyang Liu <seashell11234455@gmail.com>, Nishanth Menon <nm@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, u-boot@lists.denx.de,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v3 3/3] doc: board: Add minimal documentation for Sielaff
 i.MX6 Solo board
Message-ID: <20240215140106.GD3040305@bill-the-cat>
References: <20240215133527.216126-1-frieder@fris.de>
 <20240215133527.216126-3-frieder@fris.de>
 <a2e98f0f-f28e-457a-af95-0a33b6a75c4a@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DTP2az8SySAkAOjQ"
Content-Disposition: inline
In-Reply-To: <a2e98f0f-f28e-457a-af95-0a33b6a75c4a@gmx.de>
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


--DTP2az8SySAkAOjQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 02:53:12PM +0100, Heinrich Schuchardt wrote:
> On 15.02.24 2:35 PM, Frieder Schrempf wrote:
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >=20
> > Describe how to build and boot for the Sielaff i.MX6 Solo board.
> >=20
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
[snip]
> > +Build U-Boot
> > +^^^^^^^^^^^^
> > +
> > +.. code-block:: bash
> > +
> > +   $ make imx6dl_sielaff_defconfig
> > +   $ make CROSS_COMPILE=3Darm-none-linux-gnueabihf-
>=20
> U-Boot does not use floats.
>=20
> make CROSS_COMPILE=3Darm-linux-gnueabi-

It's not about floats or not (we pass the right flags) but consistency.
And in that case, yes, we should say arm-linux-gnueabi- but also we
really need to expand doc/build/{gcc,clang}.rst to be generic enough for
platforms to refer back to rather than repeating in slightly different
ways what's in those files.

--=20
Tom

--DTP2az8SySAkAOjQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXOGR8ACgkQFHw5/5Y0
tyxGKQv/Vr2SAiY5L/7+7hSuW5/i921a0whIJB/mba3lqiyTKF/7JRaaoWElusZp
yvN4eFMUS5Tt6V2iazjIGj3VhpS4zylIBPwRIYZC2RAojDCcpsHFpxcBLDb/0RnL
UWP3+GktlWXHbDA920Mm0U81YLn02Z2H1j4aOtLA4I5YAnW0vbRQWQGncGr+epdD
XZCvxkcWbc8ZS8LGqPkM/ijNI8eWvGvaEbO2Hcuc+Gtq0huxbeyp3x/WN7Nz6ut6
YssB82vtyApp1J00cWFO682HVi0yt84qcG+iSBoE+BLouIBUQIO+WAeh7WZsFSff
GCQY7ick/o9HzkBAgTPc9N1/vD69+gzJnaHOvwbMH/GLJ3rMFzooQ0NuMO0/K8D7
oiAxZHxv2lBA6mXEpPRe1mtBYJ113D9siQNvgj9H8UB0OK+28DBTLJ//2Wa6lwvg
J9Sxr54bX1R3Y4etCVjDviUXqd/RXAUNBKKugxP1mvEiYRIIEQ3NCcX5LicIaAEK
lx5mafpf
=CqHT
-----END PGP SIGNATURE-----

--DTP2az8SySAkAOjQ--
