Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F8CC36005
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 00:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 658768186D;
	Wed, 26 Mar 2025 01:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="px6M7cp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0716B8186D; Wed, 26 Mar 2025 01:15:29 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5013810E8
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 01:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72b0626c785so4363771a34.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 17:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742948125; x=1743552925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ki15pqjHVnhp73rOZPEcgmm1aqYQv9zowX0+f5GLW9Y=;
 b=px6M7cp1vSJCdcRuURuMeyqtO0jYwEnUwE4R8TnEtGz9YEhHkWgFWwahAUBiGxTsHK
 d35tBUqoEe5DgLaKVajEaQKAF1Gsq8jUXmNhM9f1tIlhLM5MFNQpTyoqpFMpxUc0Hvys
 yFTqbVi70L7an2Q8xvBd4Gawa6zDXmJz4Ubz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742948125; x=1743552925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ki15pqjHVnhp73rOZPEcgmm1aqYQv9zowX0+f5GLW9Y=;
 b=oztKCs1eayUclU057PYrAEp9mxfhaW8H5S6y6QDAJcvMZHKEVWBygN6M9g0myA3xYL
 +9lXfThK6A6y2OHMBvQ0ZwX2E64KD2jE4F55MnaIHMdQZt8Tobc1kkShInQR4fVCtxDq
 AMmnLO/o4BTtudsgOqgUoGKmzPxYq0+PkXotGDb8xdgGPYe7NGVZqgrSq44Nyb2cI19q
 Pj9tbKHQkb0DVPVrPnEG8+3lzt/+VaW6A5asaaUyHomHbHkkGm5pR5wkPsyU4aUzg0L7
 pAo0kk52O+yAvXpJzA+6eGyhGuMuQsD64YNyfDk0dc1+yX5QENBcyb3IaKKHGPltRzDy
 Fzhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqVuGap/qawZebu7nOZctQKniuCts2ivlfpXjczpcTJ9J+HlmyaJYM+W0ollZ7zKT48Um8jvA=@lists.denx.de
X-Gm-Message-State: AOJu0YwAwUZ1l3wkkkasmIMUMHJeMoYMgM7MhmqvttzTVBBjKNqavd8q
 OZ4W+vJqWVM3QAy0spZP0mQtLIYVrNQBzQKXeOp+ygrSYPnZj3BCJZmJBx0FCrg=
X-Gm-Gg: ASbGnctiiXHIWO98IdmxIYSAO621NULd5QM0gNE52vRu0UGw29hA7cFo9TemBhhFXHB
 UAPuc1tKmJKuTnjHEeEHEqWXh6jC8aj9OWLLLxkEAZPNSbhPue0Z6p33jPyZbr+X5qs0KtywLEv
 wRvlXscE40V1DYcapKeosO3WV/cQflEZCcs9K4Y2qFzSbUKEDuQJZdcT/Dxu+Lkyaw9dme/dojH
 3RoV+R5XVW5sgNeB1uqTYJ0PI1umusA41kh5s5hXhLMrS51zM2zRCpWh3f0Av3yz/CMUSX3lw1/
 F2gMe2dc9jT9uIRXQhZ159FKv4d1Y3mzin8nerCv18Q=
X-Google-Smtp-Source: AGHT+IGdCyn0TbGJ3PzdMHMw0hGPFx4wj7JOAKclmW4MrHxA54y1lc2mH9/t4NvFufQV4kdI125STg==
X-Received: by 2002:a05:6830:44ac:b0:72b:9c34:1361 with SMTP id
 46e09a7af769-72c0ae9701amr15045566a34.15.1742948125251; 
 Tue, 25 Mar 2025 17:15:25 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60234851526sm1634498eaf.25.2025.03.25.17.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 17:15:24 -0700 (PDT)
Date: Tue, 25 Mar 2025 18:15:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 4/8] env: Rename SYS_MMC_ENV_DEV to ENV_SDMMC_DEVICE_INDEX
Message-ID: <20250326001521.GN93000@bill-the-cat>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-4-marek.vasut+renesas@mailbox.org>
 <90254a96-5d67-4d34-afe6-772af42ee557@cherry.de>
 <e385568e-59b1-4adf-9fb7-d87b4254eae9@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jiklPNYCcPvzmXlQ"
Content-Disposition: inline
In-Reply-To: <e385568e-59b1-4adf-9fb7-d87b4254eae9@mailbox.org>
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


--jiklPNYCcPvzmXlQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 12:02:08AM +0100, Marek Vasut wrote:
> On 3/24/25 1:39 PM, Quentin Schulz wrote:
> > Hi Marek,
>=20
> Hi,
>=20
> > On 3/22/25 10:55 PM, Marek Vasut wrote:
> > > Rename the variable and add ENV_ prefix, so that all configuration
> > > options which are related to environment would have an CONFIG_ENV_
> > > prefix. No functional change.
> > >=20
> > > Use ENV_SDMMC_DEVICE_INDEX to clarify this is the SD/MMC device
> > > index, a number, as enumerated by U-Boot. Update the help text
> > > accordingly.
> > >=20
> >=20
> > I disagree with this part of the rename (MMC->SDMMC), our drivers all
> > are using mmc (env/mmc.*, drivers/mmc/*, cmd/mmc.c, ...) for both SD and
> > MMC. We also have ENV_IS_IN_MMC which is for both. I don't think it's
> > worth the confusion.
>=20
> My main problem is, that it is confusing to call everything _mmc_ even if
> most of it also applies to SD . There is no way to discern parts which are
> MMC specific from parts which are common to SD and MMC now.

Do we have support for anything using the MMC part of the standard that
is not storage? I certainly agree it's confusingly named atm, but I
think changing some parts but not other parts will make it worse, not
better.

--=20
Tom

--jiklPNYCcPvzmXlQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfjRxUACgkQFHw5/5Y0
tyxu0gv+MLFDcFhsRrB/xmYaJVKN+6KiRE1YrYMyI1/lpEuhPUhLmpzQobUDCW02
onJhSd9iUZvRiI4Mg6uLw3/0zkiZ1wDTdOanG5CVCUg9WSxDdhlDqDapI5SPNawZ
DGP5X9SrwM5s4GgXvpdx6R/h51+qVnimoaOoe1BV14tMLOIUcnzinAZZuSCDevjn
ZiLcjwePTNHpdzPN9LYIO6kqADSdfOWG0CgOCmISVN4IEMN4tof7r9sSB4JALkMB
K7KvqfGHB/pzt5p4TzX2MdF6LiEyhMITizM29sDKdWOhSwSK6KzC+Vqrvri0LMS8
9sUeCX729/QWjUv7q9FeFvTXh1bq1ZmUppzqoRAoeSZociBNYxqdzGsQOIqDSpV5
cWwKkSsw5vZ5kJ08cP/aBw6BPG9rR1McmIQN1i43SEBs7mfkXVwkuONfPHlX40Uo
nDrfsOEfdSPneyMQdRyaRjtUbqVC6bZCgai1n9wLi5nN12Kcw9NQphdWRqcBt5kk
GXRFhRfW
=0052
-----END PGP SIGNATURE-----

--jiklPNYCcPvzmXlQ--
