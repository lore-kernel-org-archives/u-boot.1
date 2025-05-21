Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAB9C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 15:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 003FC82E31;
	Wed, 21 May 2025 17:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rzAP/CKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0843582E9A; Wed, 21 May 2025 17:12:44 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877F182CD2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 17:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72b82c8230aso2516850a34.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747840360; x=1748445160; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=diyydJLdAxMuRGpDKRcvy3qeLpr8CwNLE+a1p5a1WL8=;
 b=rzAP/CKFgbvgPetkMMKPzCg4Kg4qtpqmMmXVfxGl9IbhU9cR4U9xb9Zl5+47cB7Imj
 0zm8prCicuVWO8TlCQk1kDulXoktSo4qOytFaXnYW+GMS+VKVlXNCeSQr6cA071Ayzf9
 gH9SQxFR6qA/976+Tf6TIAgXBhWB7LxSfq5ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747840360; x=1748445160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diyydJLdAxMuRGpDKRcvy3qeLpr8CwNLE+a1p5a1WL8=;
 b=Id9+XUSx7uLufvJDO4QeB++UEg7/fr6rR4c5BWxVzp+CK2KmWSTxQCg+eDhpUN0xtR
 ZVjp7o53V+Xss9QFqV/TIYpPNuhj8+mxNhXCTkgu/IF1CvlwOn8WtfYZ927X7zZVtDEP
 o++tyXbiOqsr9nRLS93No2AXu0A6VxWZ/5Oyb1Zw3A9J8n6/KM7dJMms2pl6vu88CRu8
 n/F9d5kgicOt9jODA8NKm3ECVHEWvmy/hj6hENTZsWzdOVim+zwhG4X1FKPORPeF9uMR
 e4YklvMsvEPVLVOuVEev77k2plZ9K3+0qkEYC+a6fa/HbmSjNtYd/yjsderpOKVvGzxx
 N8IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSKFBpcI5oi9Bao9Nmq+FyNkidvNi70zO847RgYEBixvcBlMh3LIJ3NjclLJ0FMc4+rAd7tKA=@lists.denx.de
X-Gm-Message-State: AOJu0YzKgYM4xe57MTzOFa1rAfwzJGXrC3bRe7dT7Td2KN+14TkS5XTs
 izBR5Kqf8dllbFEUVyP3tk0FGd4WES75JQSONrnp/s4xv59fdZ/txHHWX9G4JQngB+o=
X-Gm-Gg: ASbGnctMYLgQ+b+rn4BAvc3rdRT8wlGo2Lo2EG3tfCKuPLHpN7ePdpKgQeQ11OUbCrj
 90Mrj43Y195QSTWQ7Fdmz9Fk/K3Hh75DCOz8I5LSBMvjwZ9kb9HrNkINtdU9BV8g4jCGLTQqe1Y
 S7V52CwaqSdluWEBOgzaRiISorG7Ce/Crv8YhH7Z0CZhlbvaAS7FUItSSLCRvxqAW281UNZU2Mw
 kzeDyBlv7Sys3I19bw6d7KGDbg6ZUSz0VuSRaKIBhegtN1zbzwbFz4DdgCm8JqGyEwnpbOYlY7v
 JXEiG7GI4z+CPkF7k4A60/edA3j3/9DFh1E8OOqyp3GxVw7SiwTmXSSUmCnalZAJhPf0LwqOwZ0
 VG0yCwpdXX96g
X-Google-Smtp-Source: AGHT+IEXhXaRbCqHaHZB7Wt8nnBzKi73UGpVnR1gEYUVf1a3JBVXJjRqncI7ExzNq+G2wIe29neCWA==
X-Received: by 2002:a05:6808:6a94:b0:401:e9e:4c11 with SMTP id
 5614622812f47-404d8671d57mr15277874b6e.13.1747840360095; 
 Wed, 21 May 2025 08:12:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98b18a9sm2171800b6e.31.2025.05.21.08.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 08:12:39 -0700 (PDT)
Date: Wed, 21 May 2025 09:12:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: neil.armstrong@linaro.org, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
Message-ID: <20250521151236.GC100073@bill-the-cat>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <174774092427.332438.8643753165301653831.b4-ty@kernel.org>
 <87zff6nhmo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GJ8Gl7RDoVrQVNQI"
Content-Disposition: inline
In-Reply-To: <87zff6nhmo.fsf@kernel.org>
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


--GJ8Gl7RDoVrQVNQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 04:49:35PM +0200, Mattijs Korpershoek wrote:
> Hi Neil,
>=20
> On mar., mai 20, 2025 at 13:35, Mattijs Korpershoek <mkorpershoek@kernel.=
org> wrote:
>=20
> > Hi,
> >
> > On Tue, 06 May 2025 18:10:06 +0200, neil.armstrong@linaro.org wrote:
> >> This serie permits using any block device as target
> >> for fastboot by moving the generic block logic into
> >> a common set of helpers and also use them as generic
> >> backend.
> >>=20
> >> The erase logic has been extended to support software
> >> erase since only 2 block drivers exposes the erase
> >> operation.
> >>=20
> >> [...]
> >
> > Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu =
(u-boot-dfu-next)
> >
> > [1/3] fastboot: blk: introduce fastboot block flashing support
> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/8823=
9b5bb04bea2b58f7bf4c3ea72cf832de818c
> > [2/3] fastboot: blk: switch emmc to use the block helpers
> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/25ab=
5c32c28b9f25fb193f726f239d75af3c365a
> > [3/3] fastboot: integrate block flashing back-end
> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a885=
bd8c969e25d03bf406207d89b1145c9490fb
>=20
> It seems this series cause CI to fail:
> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26238
>=20
> Without the patches applied, it passes:
> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26235
>=20
> Do you have any idea what is going wrong?
> I could not find anything obvious by skimming through the logs.

It's a Kconfig problem then. Some platform is prompting for a value (not
a y/n) and there's no default.

--=20
Tom

--GJ8Gl7RDoVrQVNQI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgt7WAACgkQFHw5/5Y0
tyzb+Av+O51qmAjRNNxvHKXqMmSnpPV0U8rTZDbF5UlMT3K+aJ0Tk8vHyN8Y1lWs
qgz8mJIMO59pkfesd3awa7DnnoWPfeyfikO2meo4TSl3HDnECbNfVxYbop2Lu733
6KjK7VSveVx3jn2Bf8NO/98jzD7qjboTVYML2eXIlu/UssnxDofzQcnn73I2vWfL
o7At9id2rVJz5Bw/CInd7Hfqbim0eERn7AqkLQ8bs6wbaQwhVXQ5UnwzGDgeaXkp
3c4vzdjvcTFJf9pmiBlZu89Mcc+IOy8PiLlLwBYL7eprwGih2dbNihPTh6sViW6y
amFsu9+yIEE+m31KSeWdYa0dhoITUPJypOKnZsGcupqvxcXhzL73vxg/ushGswhb
V4czsZwVgO/3Euxnere6h3yZDCpUwVpgkWtzZpEbWMypDO9sjfPLHRuX4MjBGRhQ
gn4p0Qiz4ih4Nlhe5HJWHBY39in3bNq6iJ2jgWpCNdwSxcJuOxV46k0z0MBXfOkD
CIxvTl6w
=7p9M
-----END PGP SIGNATURE-----

--GJ8Gl7RDoVrQVNQI--
