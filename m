Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255F6CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8325986F72;
	Wed, 18 Oct 2023 14:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T9yYWTd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD0886F5B; Wed, 18 Oct 2023 14:39:55 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5934E86ED5
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d77ad095f13so6897179276.2
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697632789; x=1698237589; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iHoGxDe9RkJd/jRnUWMqU5HQYl6kPwDLpKKwjwkD9Z0=;
 b=T9yYWTd4xyTdGxo4s3iKYoQWKhd9Z//PiIWN4W7kPuKfpdmfvyji02q5ldsYRi6029
 +3lLAFXgbcufZj6Opuj04ht+7sNIXi6YoE4FKMCpnNWQsQIm4+eIiWo3aktNCm+Pplju
 c+kbLVlPcfvPIRYQ+kl0WTppOQD1s/GRgm120=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697632789; x=1698237589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHoGxDe9RkJd/jRnUWMqU5HQYl6kPwDLpKKwjwkD9Z0=;
 b=KhwKiuOlZ0SNrc3vw2EJm0jMoN75o5gkv8TQkg7/z87r2u8TY9O/opt7ZtBOVTcgTe
 QaCbQSNsARsRXsjNJgqDLj0fClKr1F2RPbjODmP2z7J1l4do2ltQE/fY7HyJuX52lkby
 hQ2HoHMN43BhCYLaSbhUPHENsPTkUlvEgMW/GejOFg+pDj0QcDpfxt9cx8VJ2T5A1fF5
 lWbiKw7GDJqp25W70ukkh1onfOx1CknMQ+/QsxqMbu71iX7GQRbEWl2eyJO4ya822ItQ
 8CW2omqTY8s55R796PaahZ95hSAAZGz3hk/phIprMtssmLWBstNAun/Fk7YUBomovAdr
 0pIg==
X-Gm-Message-State: AOJu0YykWfeYZkc2tIpUfY4RwTWgxmC2zE4B4FwBsSmVm9IjkhEhC5m4
 gP9wkyg5zLV5GB8xIdEqt1oJ74vCGWiwIh/JaNYZTA==
X-Google-Smtp-Source: AGHT+IGowOku/XyAoaMz3sDReAg9kKgouPYj6Hg0yoDSI2Dqc5qH2RlRlBHxP+RahF6ua4oKpWN4Tg==
X-Received: by 2002:a25:d493:0:b0:d9a:4eb8:c2c5 with SMTP id
 m141-20020a25d493000000b00d9a4eb8c2c5mr5532777ybf.36.1697632789483; 
 Wed, 18 Oct 2023 05:39:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u66-20020a25ab48000000b00d9c7bf8f32fsm522192ybi.42.2023.10.18.05.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:39:48 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:39:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 14/32] bootm: Allow building when cleanup functions
 are missing
Message-ID: <20231018123947.GN3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-15-sjg@chromium.org>
 <20231017140216.GW3119521@bill-the-cat>
 <CAPnjgZ0WmpCGbV8a8Ri7+myZTMSw-3R5QjP_kY9qvU3-2JOuKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ok9WnfxBEe3BSgbh"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0WmpCGbV8a8Ri7+myZTMSw-3R5QjP_kY9qvU3-2JOuKg@mail.gmail.com>
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


--Ok9WnfxBEe3BSgbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 09:31:04PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Oct 2023 at 08:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 04:28:05PM -0600, Simon Glass wrote:
> >
> > > There are two cleanup functions needed during boot which depend on
> > > CMD_BOOTM: bootm_disable_interrupts() and board_quiesce_devices()
> > >
> > > Provide static inline versions of these for when commands are not
> > > enabled.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > NAK, these functions need to be available to boot the OS, regardless of
> > command line existing or not.  Unwind things in the other direction
> > please.
>=20
> That won't be a successful strategy. See my other reply on this. I
> have had this idea since 2016 and have looked at it every now and
> then. With bootstd it makes more sense since we actually have a
> framework to boot without the command line. This series enables such
> work, but cannot include it.

I don't understand.  The "cleanup" functions here are to ensure that any
devices that we've touched are in the state the OS needs them to be.
It's not "we ran a command", it's "we loaded something off of USB (or
network or MMC or ..)" and so we must have those called.

--=20
Tom

--Ok9WnfxBEe3BSgbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUv0hMACgkQFHw5/5Y0
tyxSKQv+JHsQ63sunUFsGvKCJ1UdpP6TEeCWci6q/xSAPl89y/NccyC518qy+7K5
JF15J32UpUe+kUREc4mN+YpSaec7OYyeMRYGgukSXAv3jNt5HIS/NaSaRvYBwSVe
dc0nSshKv7G6b+XjvEjczVJDbjEl5Li6nSDYFkbYv2AgWQb1Q6iO+7/LcbNKckWs
9USrNmqET2WNFI1EsPzQzM4voQUcm6xAhouEb4KlUAiWIlNIsRDFsJntGXynQwEO
T8xI8EArIvXdQ33Np3GNQu9v6D6w7+Q3jHygSAi2B3xpBmZ0erPDaOYIBFFH/j+B
4BIBJNQ1DfsehlTOTQuxRQxAWmbVY4Ye/xg3h71P2THoiA7+zsLvNn3+XLqfRR4z
WydhsTfOESS7jGV6y9qN4zG3kSdu7RigIkk0itbodIduNY7V0FeDXKeicB+jAcIE
jK4CEDFoPtdkyX4eXv5rrd9R2ud0S9aAuE/yh0dhUbDSXihK/R4St6lWBT64OEBj
6PYYj9SX
=tg/b
-----END PGP SIGNATURE-----

--Ok9WnfxBEe3BSgbh--
