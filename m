Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D696DC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65AE181F0B;
	Wed, 19 Mar 2025 16:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MiDo/7E0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DDB881F0B; Wed, 19 Mar 2025 16:40:55 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC25281ED8
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22359001f1aso28375525ad.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742398851; x=1743003651; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CFUyswyzB0ZL9FBvuDhR3wTsROfpP0PyDUZVdkPcV7s=;
 b=MiDo/7E04RGuRTDSxlGdoB/jN+2j6dedvCBFjpEV8vWzvq9ZJmyWnFE2WFZ90xJ5bR
 PDB5e4ZjF94tZeeV06JJZfj10XelX6yuacqsvuYO4eFhWcCIsUg/k52nDS+o/q8P3yNU
 R/EV+x/uz9BX8MOhR6HKEn/rQAHnP0wS0S6S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742398851; x=1743003651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFUyswyzB0ZL9FBvuDhR3wTsROfpP0PyDUZVdkPcV7s=;
 b=TSbc/Accb/jD+A+jVXUbIp4k3FXdCcphiMOzvhH1iq2RAy+dnUWie/05NCynd/dXth
 7RoOHNPbkh8DHBBuay4oxzqusuCniHA2N+Gs0uwuF5zG7T3kX0ZAE3WbgfddyAVvYlbZ
 J3xRlZTzIkL5eDcUZnESrgD8X+9ADlxldFej9pIafoRUPgJ8h7yhbcolAk1OP9cEsdTF
 IqNDkjLnm0ugglC2m+cWWeQEm8RYSDRS4pEHDCaeMEPr9MczHeWfaxJfypcJ5iEOSJpR
 2S2itiSBbGYOhq0JhZY6c8VQsEZiE5Jm777xPmbkYLDXQdm99salfMdMujf4vz2ZROpE
 GKzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMAj+iB7QVP43C9s+MSfP4DubYhFfQUgvwvFsSEUCgqUB/otlybO+SiFdwdHqao1SLVwV9yJQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq+NukswG/PuDsxsGGZSWHSYQ3BLkWFTimz+hOdskjY+uEFXK9
 z5ae65gy0FmTGS+NqdWla4uc+8X5vzlNbYDP07ajz7EDojKp5p3c1nJlcsPuRF4=
X-Gm-Gg: ASbGncsiBjO5JFphvwyOnMEucho8f6XN0bfgpcDMPAWumGYxLNr19ejdpPBi3FIdZSx
 EHwhmuNOvAMn5U3LmZ6QAoV2UjTp5yAB70fLNSMDuaSxRa3pEPNpn88M54I7lXqeVzLsxHr6SfY
 G4AJ/agt2oUDLr/Q7ynzV2O21v8cqrnhIyl9fQdY+o3AvrqzoULcfHKfloSUKOxFohMg1UCcM5N
 yuCaaQPjQ7Nd1qkFGc5hVcushr225MUdpjW5y24JlunMSjmwngsS227jUPivKf+eKKZRO3LwyU+
 azFNQQvcB/MkwIGu7A93SSs5VGaI+VoJRsweenbFNh22Zg==
X-Google-Smtp-Source: AGHT+IGcUWoBjm99FSL1Ms86Rmrv0MCbEHk/TZ8Pu0FBatWiKrhsrvYMQAuArHw9Yk7E49woC/RUZQ==
X-Received: by 2002:a17:903:41ce:b0:224:1ec0:8a1a with SMTP id
 d9443c01a7336-22649caaa83mr41219745ad.51.1742398851211; 
 Wed, 19 Mar 2025 08:40:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68aa66esm116218505ad.91.2025.03.19.08.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 08:40:50 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:40:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
Message-ID: <20250319154047.GM2640854@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250318140400.GX2640854@bill-the-cat>
 <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
 <20250318155256.GA2640854@bill-the-cat>
 <CAFLszTjC47nk3FmEyHw13zaaWwdcEavk3JY5iewKWF65iVqHiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e5kNBYB77wCacN1c"
Content-Disposition: inline
In-Reply-To: <CAFLszTjC47nk3FmEyHw13zaaWwdcEavk3JY5iewKWF65iVqHiA@mail.gmail.com>
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


--e5kNBYB77wCacN1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:03:49PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Mar 2025 at 16:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Mar 18, 2025 at 03:24:02PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 18 Mar 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
> > > >
> > > > > Any 'bootable' flag in a DOS partition causes boostd to only scan
> > > > > bootable partitions for that media. This can mean that extlinux.c=
onf
> > > > > files on the root disk are missed.
> > > > >
> > > > > Put this logic behind a flag and update the documentation.
> > > > >
> > > > > For now, the flag is enabled, to preserve existing behaviour. Fut=
ure
> > > > > work may provide a command (or some other mechanism) to control t=
his.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Isn't this backwards as the existing behavior (prior to bootstd) wa=
s to
> > > > scan and use these files, and so that's the behavior we need to pre=
serve
> > > > by default.
> > >
> > > Not so far as I know, but I've already spent too much time trying to
> > > decode those scripts.
> > >
> > > If you look at scan_dev_for_boot_part, that is what I was trying to
> > > replicate with bootstd.
> >
> > The feedback from the community call where this was brought up was that
> > it used to work and now didn't, I thought. Heinrich, I think you had one
> > of the cases here (something about RISC-V and multiple distros?) or am I
> > misremembering?
>=20
> OK let's see if Heinrich chimes in.
>=20
> Are there notes for the call? It would help me if they could all be in
> a shared document, like we used to use[1].

Yes, they're in email.

--=20
Tom

--e5kNBYB77wCacN1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfa5X4ACgkQFHw5/5Y0
tyzyIAv/Ufcn4bVnbOGGZMWsbWO24XeBbkd4vWih1ZT/unQPrcXndUFgoLHfKFHj
Dz2W9elT97t9C1iAvFzfW5DmRIyglRn8q7t1+MD8QO+Zo8sLf/D8vWKz0h3P8mZm
M12S87zG8fwOdAu/m9epwBnLTNJSUCqoSMhtaF7Xt8Wh5xxTuEV3ycwajOLdOP3W
esx/pAC7TKFmIWJbQxU08FFzpJqK+QW/aEzV/6azU4bLp7rEUchmBSo1W3CFf0Bq
eFgH1q3NfsRjQnKalV3gyZMgcFEjWZGYWm3qhkIj7uNnNMruOmTkuibS/aa3lMxB
OBiQU442LWoy+5xj64r8PQMDLRpGC5IKzUUPjouyVbE5qlWHoXY1Lidptm2MC67s
9Np4bm9rbOZfO0W9IQCgZK9oqVhrf7PMmCdTgFIHb826qtGuiXBoDeJk+6PUdDjR
9mlShvnMYC3zXUYSDEeoIzUBKQSZMYw4pbkH1/v15dscKg9rul0JILILL2CbkiXs
qag9B9Vj
=sUAd
-----END PGP SIGNATURE-----

--e5kNBYB77wCacN1c--
