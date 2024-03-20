Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A878AC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1903887F39;
	Wed, 20 Mar 2024 13:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eO5rpKDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E26887F4F; Wed, 20 Mar 2024 13:38:20 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F0887D83
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-609fd5fbe50so70880317b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710938296; x=1711543096; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sxlcYfKPMPmjQP+gPe1S0G57XAtUsNEhoQfISnGZo98=;
 b=eO5rpKDvI1FOOuGnEyfRiMr+G3XwontGWjzeFxcApa09n4JC7GksCJ2w4hLiOnxELo
 BBaqi6jm/cyt69nfzPOuDcuoXSMUxJ/V/kVMnu868CdaBmxDr20H9o7HJzqGnCcUWAeM
 xRuNA/1sVzZt2Y9/ez5aN0U1KaA48aNS5ZC00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938296; x=1711543096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxlcYfKPMPmjQP+gPe1S0G57XAtUsNEhoQfISnGZo98=;
 b=f3hMfUb2SXa4FU9C4My0Ai6k/FSLywMY2V/ThmPcBH6xroYnz39wVU7VpKkmNJeimb
 MbYciD9ekStCw2XIVk3EpbObhzIlNNdgazor1nljlmYHIzoTQloLF2qP6PrG0x3ksS3+
 Qe4+oZADjjeg3CoLwO1TFq3OJ4LK4ziIYyWXDbS5sAyvaHGb1JkEqSRXNt0nATQiG1zj
 RFkGsscG2sbibkY1ZTxXhgo4ySrrqnV2Tt+U97LUQU4hdUR8RRTT2Ri/eqWMEHSaxPJ5
 yvPwYGY/qAdtRPlr89borKbnTelV9byMeBuSVn34pqf0abcpUT46PdpUcAkjGpnYHV8P
 u5yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3rxizDqEIf9UTENriJ9lf1YkadMvhrl725Nyk9tT3oTNnDDGKYDYJ6hy4UUDm4CXyL6bBYPHzTzn9kUP7PGWCRBPqBQ==
X-Gm-Message-State: AOJu0YzD1xzE0b3GVr5rO2Exl5vuctNxEUdhBYzoyu4rJ/4QoYtlLVzb
 qU5Cl+Khn8/ksGr2rPJqrX83LYhXXADaymWFMEocLoOM8E5lFPXQ2HoTapQzCFA7GI858DN45kF
 E
X-Google-Smtp-Source: AGHT+IE+uabOi6CVZYQOcU8ijXce6hsexT9VaBiEEUp9FDB8J3UNKeB0NPOyq6yS74uebmNkZtKYVQ==
X-Received: by 2002:a0d:e286:0:b0:609:33dd:c63f with SMTP id
 l128-20020a0de286000000b0060933ddc63fmr17489610ywe.34.1710938295954; 
 Wed, 20 Mar 2024 05:38:15 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 bx16-20020a05690c081000b00610f1cf0527sm378680ywb.1.2024.03.20.05.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:38:15 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:38:13 -0400
From: Tom Rini <trini@konsulko.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v6] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Message-ID: <20240320123813.GL3442575@bill-the-cat>
References: <20240228120645.958316-1-danishanwar@ti.com>
 <20240319224032.GA1686480@bill-the-cat>
 <3b588cc0-225e-466d-9257-f0f4ef592cf3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+6NEH1kT/CrzRSdZ"
Content-Disposition: inline
In-Reply-To: <3b588cc0-225e-466d-9257-f0f4ef592cf3@ti.com>
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


--+6NEH1kT/CrzRSdZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:19:01AM +0530, MD Danish Anwar wrote:
> Hi Tom,
>=20
> On 20/03/24 4:10 am, Tom Rini wrote:
> > On Wed, Feb 28, 2024 at 05:36:45PM +0530, MD Danish Anwar wrote:
> >=20
> >> Add APIs to set a firmware_name to a rproc and boot the rproc with the
> >> same firmware.
> >>
> >> Clients can call rproc_set_firmware() API to set firmware_name for a r=
proc
> >> whereas rproc_boot() will load the firmware set by rproc_set_firmware(=
) to
> >> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
> >> load the firmware file to the remote processor and start the remote
> >> processor.
> >>
> >> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER=
 in
> >> Kconfig so that we can call request_firmware_into_buf() from remoteproc
> >> driver.
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> >> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> >> ---
> >> Changes from v5 to v6:
> >> *) Collected Acked-by tag from Ravi Gunasekaran <r-gunasekaran@ti.com>
> >> *) Fixed few typos as pointed out by Roger Quadros <rogerq@kernel.org>
> >> *) Added if condition to check if uc_pdata->fw_name exists and free it
> >>    before the strndup as suggested by Roger Quadros <rogerq@kernel.org>
> >>
> >> Changes from v4 to v5:
> >> *) Added Kconfig option REMOTEPROC_MAX_FW_SIZE to set max firmware size
> >>    that can be loaded to a rproc.
> >> *) Added freeing of address in rproc_boot() as pointed out by Ravi.
> >> *) Allocating the address at a later point in rproc_boot()
> >> *) Rebased on latest u-boot/master [commit=20
> >>    9e00b6993f724da9699ef12573307afea8c19284]
> >>
> >> Changes from v3 to v4:
> >> *) No functional change. Splitted the patch out of the series as sugge=
sted
> >>    by Nishant.
> >> *) Droppped the RFC tag.
> >>
> >> v5: https://lore.kernel.org/all/20240217122602.3402774-1-danishanwar@t=
i.com/
> >> v4: https://lore.kernel.org/all/20240130063322.2345057-1-danishanwar@t=
i.com/
> >> v3: https://lore.kernel.org/all/20240124064930.1787929-4-danishanwar@t=
i.com/
> >>
> >>  drivers/remoteproc/Kconfig        |   8 +++
> >>  drivers/remoteproc/rproc-uclass.c | 102 ++++++++++++++++++++++++++++++
> >>  include/remoteproc.h              |  34 ++++++++++
> >>  3 files changed, 144 insertions(+)
> >>
> >> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >> index 781de530af..9f9877931c 100644
> >> --- a/drivers/remoteproc/Kconfig
> >> +++ b/drivers/remoteproc/Kconfig
> >> @@ -10,6 +10,7 @@ menu "Remote Processor drivers"
> >>  # All users should depend on DM
> >>  config REMOTEPROC
> >>  	bool
> >> +	select FS_LOADER
> >>  	depends on DM
> >> =20
> >>  # Please keep the configuration alphabetically sorted.
> >=20
> > Can we not make the FS_LOADER portion optional? I didn't realize how
> > many non-TI platforms this impacted. And even then it's possible I
> > assume that custom designs will load the firmwares in other manners.
> >=20
>=20
> Yes we can. We can wrap the remoteproc APIs using FS_LOADER in #ifdef
> CONFIG_FS_LOADER. And instead of REMOTEPROC driver selecting FS_LOADER,
> the clinet driver (ICSSG in this case) who is calling those remoteproc
> APIs will select FS_LOADER and enable it.
>=20
> This will make sure that other platforms (ti or non-ti) that doesn't
> support ICSSG but enables Remoteproc, will not enable FS_LOADER. This
> way we are not forcing other platforms using remoteproc to enable
> FS_LOADER. In this case the APIs will not get built.
>=20
> Now FS_LOADER will only be enabled when there is a client driver that
> uses rproc_boot() APIs. It's upto the client driver to enable FS_LOADER
>=20
> below is the diff,
>=20
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 9f9877931c..a49802c132 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -10,7 +10,6 @@ menu "Remote Processor drivers"
>  # All users should depend on DM
>  config REMOTEPROC
>         bool
> -       select FS_LOADER
>         depends on DM
>=20
>  # Please keep the configuration alphabetically sorted.
> diff --git a/drivers/remoteproc/rproc-uclass.c
> b/drivers/remoteproc/rproc-uclass.c
> index f4f22a3851..a6a8be5009 100644
> --- a/drivers/remoteproc/rproc-uclass.c
> +++ b/drivers/remoteproc/rproc-uclass.c
> @@ -994,6 +994,7 @@ int rproc_set_firmware(struct udevice *rproc_dev,
> const char *fw_name)
>         return 0;
>  }
>=20
> +#ifdef CONFIG_FS_LOADER
>  int rproc_boot(struct udevice *rproc_dev)
>  {
>         struct dm_rproc_uclass_pdata *uc_pdata;
> @@ -1063,3 +1064,4 @@ free_buffer:
>         free(addr);
>         return ret;
>  }
> +#endif
>=20
> Let me know if this looks ok. If it's ok I will post v7 with this change.

Yes please, thanks.

--=20
Tom

--+6NEH1kT/CrzRSdZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62KsACgkQFHw5/5Y0
tywZPAwAiINuizWTGsJD/DS6rjXGUgSQibra3PDDOmgu8Rm1n5R1sYFhlwx2HA/3
TiSBlWJkyTkL5+L7ndMJfP19qdZB2o7Cx+eneTgLvd8IGizLzSiUDccURXPWJUnt
PDLqcNtsEpwyNbWb+BIGsxiWBs+INj/ulUFKhPdzwHfCUVdPQzWbWlEj8SzC2Bst
bx1TYkffPpsy/a36HHnq3l5aNDIdJaRfTNqL3M3COn61DNMYaWV/N+n5CEEVdfMY
DIfVOy8uO4GC4h+qgZCYvLCETPMEIMs9UeyGibiK8J7loZO0auci3SsMG/1lckFH
Qtqu+YvWSQj3jmxlBbDZjOj0vJx6S9AiS0hdxHQ1X2Lz9D4m1E6X5iAUJcw4e/3R
x2LsruI9FtgKDARmf/SFkBbWjNrNJtSwLYo5HuV5fSClmOchEVpIgklZorIWwq6t
d8FMZlUkoU3YL1RQZRpM6sheiDnlrfKegpufm/VcT8zxeAOjure3kpvRIJdTvo8T
0W89bY58
=broC
-----END PGP SIGNATURE-----

--+6NEH1kT/CrzRSdZ--
