Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81845CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 14:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08488393F;
	Thu, 14 Aug 2025 16:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aOyWWTOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC968397B; Thu, 14 Aug 2025 16:28:21 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B489883939
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 16:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3e57376f644so4917185ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755181698; x=1755786498; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TUU5NtEcTpiWMiRRDG7zM3IHrsYLG9Ly9Xj7UnCwPf8=;
 b=aOyWWTOlL7jn+ccgzq1ZBof1cL/5VXidZLSwpmH+0rvKnEgyDeEuibgd0jwucWWtfa
 cA5EeP3FFKLezgeSYhCoF5/biHHqd/6T4ZHuMmLVwJ7EcPtThzj0i2YgB7yuCU7DOITP
 kfShwfN5mhiDpVRyyaD1zUN5ZPzSba0o1GhmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755181698; x=1755786498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUU5NtEcTpiWMiRRDG7zM3IHrsYLG9Ly9Xj7UnCwPf8=;
 b=SaFeagBUzzDCBbAgUCXm9bjzbn3f69iqVeN3TzT+0AyFf63tkjFWFerT0bFQUOHvWh
 QodNpU4gpNHVTkfu4eavbhn1YsNGTkx8XYMFMGPFbKSiBb5vkngZEBGNIYme44bh23OB
 4KHJAyuSUoEkkTe6Dg5k3+jXuR6HoH2/wCLseuFiiDwMcGAa9Vt/q7lBxdcNBDbwR9OU
 gC+iSDUc7RzLTrH+HIEu7L/bxYGnd132ej0nzMeT+ErJih1jThzy+4h4C9ORADd65uY2
 2dC2OvTO4TxGdDFYj3shwbpAuguuXHAI0hExgyvz1CoG8+7RSu9G4nmtJL/aPFBP52XS
 J2GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWims8LuLlEPOF5EP1qQqKLnJGytLqHnUvSCoBoBmPPyXBAa3gViREG0HHujnu1OsA+qearogo=@lists.denx.de
X-Gm-Message-State: AOJu0YwIRIFNnDH0dJAxjA+hRqoWTPs2VvR1rzRt6MbG5FRGWR6ZPPom
 0Efbb7/C+6OUht4yKdwi9iGnVaVMr527PWuLfgZaapD3fFo6N8qpERchtLt3a7RiwkLWwVC7hmD
 TlqRopTk=
X-Gm-Gg: ASbGncv2BWyX2yf/XkSeZXNWi+HROQcajMPrmDplQumLJyJ+aGxIEIjZ6viRuBpqoxn
 GapZ36KHLG9y+ig/v7nTSDasuRR38k5ykU/QcJ/+SekiWbIIyYJGlYmKZvfS3dMGvBfFx80JXTH
 CTh424H1Skx4qdMqqAANrwjhzvGFiT1WVfm2zfBV91sPUC9N08xaRyyZadb83idId/27yNr53iV
 uwIE7FMO+83slyjYlZNexKa4jVDZtP53d2Ny/uEuQHYMCkFQrWfGBq2Xk/qNf9BRG6oh1fiqk0e
 wAD5eFqSNZRU88wZuv9BNxZT4gAzmi570pbx1+zSeMLhC7v1nUD1A0S1I/V7TZ7s6be2dKl4UWB
 1SNoWSmzA7jCkenxLLjTnIMLDoKluYypA7/hJQ0kkIFg3IKl2mvxCQpOo
X-Google-Smtp-Source: AGHT+IExtkc3kGQLAPiAn3vIZxosYQoXuG1U1SF4X8AplBYNSOwkrbowr8m5Cp86Lgox4851vxUoFA==
X-Received: by 2002:a92:c24e:0:b0:3e5:5d59:4cb7 with SMTP id
 e9e14a558f8ab-3e5709a7cb4mr53247905ab.21.1755181698285; 
 Thu, 14 Aug 2025 07:28:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e5455a56cfsm51566645ab.5.2025.08.14.07.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 07:28:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:28:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Martin Schwan <m.schwan@phytec.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] bootstd: Add implementation for bootmeth rauc
Message-ID: <20250814142815.GG124814@bill-the-cat>
References: <20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de>
 <20250602-wip-bootmeth-rauc-v2-1-9d2384131486@phytec.de>
 <b1f83b3e-b5f5-4d7f-ac76-834ecfd6d5f9@phytec.de>
 <1a53cbc0-e929-4e3b-8242-7e35c2d02734@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uk5EMzLBgHw50Hdt"
Content-Disposition: inline
In-Reply-To: <1a53cbc0-e929-4e3b-8242-7e35c2d02734@phytec.de>
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


--uk5EMzLBgHw50Hdt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:46:36AM +0300, Wadim Egorov wrote:
>=20
>=20
> On 8/14/25 11:44 AM, Wadim Egorov wrote:
> > Hi Tom,
> >=20
> > On 6/2/25 2:31 PM, Martin Schwan wrote:
> > > Add a bootmeth driver which supports booting A/B system with RAUC as
> > > their update client.
> > >=20
> > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > ---
> > > =A0 boot/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 51 ++++++
> > > =A0 boot/Makefile=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> > > =A0 boot/bootmeth_rauc.c | 432
> > > +++++++++++++++++++++++++++++++++++++++++ ++++++++++
> > > =A0 3 files changed, 484 insertions(+)
> > >=20
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 30eb5b328d7ad8a73a2e84812dd7853b66039164..a610cf9faf99cd5480f94=
dcac89c3401cca394ae
> > > 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -855,6 +855,57 @@ config EXPO
> > > =A0=A0=A0=A0=A0=A0=A0 The expo can be presented in graphics form usin=
g a
> > > vidconsole, or in
> > > =A0=A0=A0=A0=A0=A0=A0 text form on a serial console.
> > > +config BOOTMETH_RAUC
> > > +=A0=A0=A0 bool "Bootdev support for RAUC A/B systems"
> > > +=A0=A0=A0 default y if BOOTSTD_FULL
> >=20
> > I noticed that the merge 009d7722ffd7 ("Merge patch series "bootstd: New
> > bootmeth for RAUC A/B systems"") deleted the above line.
> >=20
> > Was it on purpose?
>=20
> Nvm, missed your comment
>=20
>   [trini: Don't enable by default].
>=20
> What would be wrong about it to enable it by default?

It is a lot of global size growth. And since the system still needs to
be installed with RAUC in mind, enabling it globally didn't seem worth
the size increase.

--=20
Tom

--uk5EMzLBgHw50Hdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ3yfAAKCRAr4qD1Cr/k
CnpvAQCdKFRLCioXoHu8YJc/G/pczOA3/mfr21SUegzYu7POfAEA0/fVO8Ub+m35
/th92aVDxIctfYymh8MjC+t7SHmBdg0=
=K+wo
-----END PGP SIGNATURE-----

--uk5EMzLBgHw50Hdt--
