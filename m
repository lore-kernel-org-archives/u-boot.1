Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DB5C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 15:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B075680F10;
	Sun, 26 Jan 2025 16:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hf8LpyEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F7580F53; Sun, 26 Jan 2025 16:59:05 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FD880EF4
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 16:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7bcf32a6582so345298685a.1
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 07:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737907141; x=1738511941; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZsMTFfk795rCMGK1yrPShVHNo8KhMv76YfikF9lldq8=;
 b=hf8LpyEuUAf4SQ7mMUmw9yQnecqlAMm+F7gmrq2x97ne34GoOpgujhAzHqzA9VpZIu
 DxICDhPclBaDPw/NYSV193VGQ7qUtLCGzL1S8s2RllULQV7ovecoza10H4oROA074YWp
 sx6gtyNx1WiVWhIrfOiTWsUakcwDHTF6T7fbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737907141; x=1738511941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsMTFfk795rCMGK1yrPShVHNo8KhMv76YfikF9lldq8=;
 b=psFve+PKoXCl4c/TUHtdXNsFpoCkxcKvwOWvyoowSkAugRjINM83unddjnc4rLAAPa
 RFaefG/ce1pCNewosplLiR0V0fSH1uwOi+Jrsy7g/atS38JIxEgElAVK2GDNzM4T3bLa
 0ziWzvELZy0LBg85XwuauodNsqrKxTsIKW2oW6sOo95PbCRK47RJw+r1MTT9CFSU2LPH
 QnTIr2aALV7Ijpy6t7oJp4LW8z+TcZiRETRtaCUx0LC0OOyeEThpYfbiLZ78FFq9ej80
 5OTviqy3EyQGSH3n2ahFc9YlA8wfztI7I89frZAaSPB1Em6LEKsN9XNwS+TKYq7MXokd
 kg6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXWfEn//UPHHBd0zY4W+cz3UY7k9Mh8LiaOAoMnzbZfxvA4R/oU0M/Qr3d37vH9Xqh65HeaE0=@lists.denx.de
X-Gm-Message-State: AOJu0YyrNTBtoYz/31dz5HPeTfrRTuUjQINpCEDvqdcgdKsAp58TJ9iT
 a/yrnWQLn8pIhs5YmQ+tSE+uEqxpUSFJZ4Aa9tJe8quEp6j2summqp3YeauyUwU=
X-Gm-Gg: ASbGncsw0Ym53DHZasoEUQj8MJjYN+VS9nxBjYGhvJlmnSnjeMf+Ccmw/EOF3s30T5a
 w887ZdjCpNOBrQN92cgaiowLkDl4CsFAVtoBfgA5sdcCGaabreL2E6SC5NiGAMfyrVrJCqzN/Cf
 LTfOIbQpVhjhbkQmFJuI9BmxsvH3AlbMlsmdfOlZ0zHps4B3td623X6eVIiUbwivzIeVddW2LvR
 fB4dPBEREO+g1iq1Vjm8DPSu2MgZoujYwWgl3ROsuqkp11FMVoFOXdsucB1LvPC9g21bnpgVQwQ
 ee/T
X-Google-Smtp-Source: AGHT+IGHaibBGm2Y1LrrOn/xUoU9Qgwv5Rs/DznkAT369Q0WXtA/GeLVNoMhArDEddVV5AQd6pPTxw==
X-Received: by 2002:a05:620a:43a4:b0:7bc:ded5:888d with SMTP id
 af79cd13be357-7be63210578mr5973777185a.1.1737907141242; 
 Sun, 26 Jan 2025 07:59:01 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae7dd35sm298943085a.23.2025.01.26.07.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 07:58:59 -0800 (PST)
Date: Sun, 26 Jan 2025 09:58:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, jerome.forissier@linaro.org,
 ilias.apalodimas@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
Message-ID: <20250126155856.GS60249@bill-the-cat>
References: <20241206171835.2403418-1-adriano.cordova@canonical.com>
 <20241206171835.2403418-3-adriano.cordova@canonical.com>
 <1839b1f7-b78c-450a-aa05-78858a4f2d45@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZkAbpg2MbU9kh5ip"
Content-Disposition: inline
In-Reply-To: <1839b1f7-b78c-450a-aa05-78858a4f2d45@gmx.de>
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


--ZkAbpg2MbU9kh5ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 04, 2025 at 12:05:24AM +0100, Heinrich Schuchardt wrote:
> On 06.12.24 18:18, Adriano Cordova wrote:
> > This commit fixes an use after free introduced in Commit e55a4acb54
> > (" efi_loader: net: set EFI bootdevice device path to HTTP when loaded
> > from wget"). The logic in efi_net_set_dp is reworked so that when the
> > function is invoked it not only changes the value of the static variable
> > net_dp (this is how the function was implemented in e55a4acb54) but also
> > updates the protocol interface of the device path protocol in case efi
> > has started.
> >=20
> > Fixes: e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path t=
o HTTP when loaded from wget")
> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > ---
> > Changes in v2: use reinstall_protocol_interface() and new_net_dp in the=
 body of efi_net_set_dp()
> >=20
> >   lib/efi_loader/efi_net.c | 61 ++++++++++++++++++++++++++++++++++------
> >   1 file changed, 52 insertions(+), 9 deletions(-)
[snip]
> > @@ -1055,18 +1058,58 @@ out_of_resources:
> >    */
> >   efi_status_t efi_net_set_dp(const char *dev, const char *server)
> >   {
> > -	efi_free_pool(net_dp);
> > +	efi_status_t ret;
> > +	struct efi_handler *phandler;
> > +	struct efi_device_path *old_net_dp, *new_net_dp;
> >=20
> > -	net_dp =3D NULL;
> > +	old_net_dp =3D net_dp;
> > +	new_net_dp =3D NULL;
> >   	if (!strcmp(dev, "Net"))
> > -		net_dp =3D efi_dp_from_eth();
> > +		new_net_dp =3D efi_dp_from_eth();
> >   	else if (!strcmp(dev, "Http"))
> > -		net_dp =3D efi_dp_from_http(server);
> > +		new_net_dp =3D efi_dp_from_http(server);
> >=20
> > -	if (!net_dp)
> > +	if (!new_net_dp) {
> >   		return EFI_OUT_OF_RESOURCES;
> > +	}
> > +
> > +	// If netobj is not started yet, end here.
> > +	if (!netobj) {
> > +		goto exit;
>=20
> This leads to a build failure with clang as you have not initialized
> variable ret.
>=20
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/987832
>=20
> > +	}
> > +
> > +	phandler =3D NULL;
> > +	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler=
);
> > +
> > +	// If the device path protocol is not yet installed, install it
> > +	if (!phandler)
> > +		goto add;
> > +
> > +	// If it is already installed, try to update it
> > +	ret =3D efi_reinstall_protocol_interface(&netobj->header, &efi_guid_d=
evice_path,
> > +					       old_net_dp, new_net_dp);
> > +	if (ret !=3D EFI_SUCCESS)
> > +		goto error;
> > +
> > +	net_dp =3D new_net_dp;
> > +	efi_free_pool(old_net_dp);
> >=20
> >   	return EFI_SUCCESS;
> > +add:
> > +	ret =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> > +			       new_net_dp);
> > +	if (ret !=3D EFI_SUCCESS)
> > +		goto error;
> > +exit:
> > +	net_dp =3D new_net_dp;
>=20
> Why should we set net_dp if there is no net_obj?

Because prior to this patch we set net_dp =3D NULL at the start of the
function and with this patch nothing is updating net_dp until much later
in the function.

> Instead of jumping to exit, we can jump to error: with
>=20
> ret =3D EFI_DEVICE_ERROR.

I'm not entirely sure what you mean by that. But can you perhaps v3
this? I still can't re-enable CONFIG_CMD_BOOTEFI_SELFTEST on any of my
platforms due to this problem.

--=20
Tom

--ZkAbpg2MbU9kh5ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeWW70ACgkQFHw5/5Y0
tyzFqgwApLIeYoJYYjEb82pIS9usff3Tey/dmw9apyNsuO05u6PZg2f6Osnf1VsA
o5joAbuV1PtwJs1Rc3LAEGiK8tX0jcE6t/hn18vJ8O/HX8mwCEBsdHRD/EnELseO
MtHHC1BnosWs5VsLkhgARvHENEMDPUVnFwoJIzYCwvddocCoKRWgHyCKZfLswwz2
wwsLDy5XBVUGfx+UKAZd9pvLOigB+VsnXjW0ygH/cinTfkefKLCVeC42xMnswKie
TFz/0ovBL+LSPrZR6fDqOP/4qNsFLRM7asYtkkb5poYnxF0WBb8nF9p4/XNQHtGj
Sr+6yB3+Ee+JuucYJFPk+XM1qLEB3NSNKku44QrPjEYJORSzaYIVQzUqKvTrwq+W
uhkVFeJ/dnyGvk8dUr9+yMtKhkprCRkOa15HiSAsOJZV7Y1HflGCcaLXuiCPvkMW
kGcUMIgSQ5gKL03h+2SjlzlKrYJ3ezatdr4QJsdBsUCfe7hQbh31XxKc904WWApj
qmwe0eYU
=mHvn
-----END PGP SIGNATURE-----

--ZkAbpg2MbU9kh5ip--
