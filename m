Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70A8C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 18:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBB087959;
	Wed, 25 Oct 2023 20:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fUFsq6S/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523EE8798A; Wed, 25 Oct 2023 20:57:26 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC5287937
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 20:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-779f2718accso8912685a.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698260242; x=1698865042; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OoQBYhvRL+LDq+gxMm3wjYq1JK6napfqANj76ld0bVM=;
 b=fUFsq6S/HKXoO+PoGcn87D9hicg0Cl8xi6+zrTduiqyiHG2jVSUpHfrZKETN8tdcZl
 Xm/G6sxV72etKP6B3HZ129wH7hpe/pFzfyU2sVY9QUcM0JxtRp3ot1B644jQkDvB/dja
 WNRUN1CHrLWr3mi9/F6R0PHmRPgrGYddL+41E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698260242; x=1698865042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OoQBYhvRL+LDq+gxMm3wjYq1JK6napfqANj76ld0bVM=;
 b=O0VF+DGYLbl4pX3WGTsMzqWBXN2dbbfcMpBya9v7x55GS8ZH6m+/wz5Zp/OuOI14Xk
 SFoT0xh5pFqLD1jHnPSJNVB+cVUZ71a1fetnaKR9+xzpysARpgSFixLAQ8GyVWPZgSQC
 u+R5JoIoz9t+L64fonlBUaUVSQR/SYi+XOIaL0zYNcSdrQgMW7A+1UuBMejV7dmFQ7fZ
 wEjiNcb/Y9j0Qb2fKYa5TZoEfSj9aHeYa17zb0FmPCRSvKn1m4SMkUOfr6APuRiwUI9R
 0N/zhHcUeVciJboaaOVW/Lz/dvzWdV3cHrh/g2inI9xWSNluFw/0k63Q09UP6z/sti4x
 h1QQ==
X-Gm-Message-State: AOJu0YxqHyJZ+cb7KdaFjEgNUQH2VOMROJxXK39fvDGe27pHdpBIl4mF
 vOPcO59uuXWSJ9y/l1+T4KMeCQ==
X-Google-Smtp-Source: AGHT+IG+aIYNFVWRWKI3rDs62hmiQHAMhdqiCT1h8gVZEUTTsoaJ9FoWoIobdhDWi14pKUfi1BKv8w==
X-Received: by 2002:a05:620a:8190:b0:775:a3fc:a9d1 with SMTP id
 ot16-20020a05620a819000b00775a3fca9d1mr13201626qkn.23.1698260242315; 
 Wed, 25 Oct 2023 11:57:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a05620a0cc700b00767dc4c539bsm4422101qkj.44.2023.10.25.11.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 11:57:21 -0700 (PDT)
Date: Wed, 25 Oct 2023 14:57:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dylan Corrales <deathcamel58@gmail.com>,
 Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: Pull request efi-2024-01-rc2
Message-ID: <20231025185719.GV496310@bill-the-cat>
References: <d61eb00b-baa8-4804-801a-045eb56ed617@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LlZI8tT/UX4Pdu79"
Content-Disposition: inline
In-Reply-To: <d61eb00b-baa8-4804-801a-045eb56ed617@gmx.de>
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


--LlZI8tT/UX4Pdu79
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 04:20:06AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 5cab3515f8c9796015739c1750b8933291c816=
be:
>=20
>   Merge tag 'u-boot-rockchip-20231024' of
> https://source.denx.de/u-boot/custodians/u-boot-rockchip (2023-10-24
> 09:39:52 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-01-rc2
>=20
> for you to fetch changes up to 916dad34af0e53181dfe21f5764d3a787cb24bdc:
>=20
>   efi_loader: fix EFI_ENTRY point on get_active_pcr_banks (2023-10-24
> 23:56:43 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18293
>=20

So, there's not been enough time for "efi_loader: expose the device-tree
file name" as there's still comments on how to word things there (and
I'm fine taking this eventually for the release, we don't need it
today). And since we're here anyways, "efi_loader: fix efi_dp_from_eth"
isn't needed as with "sandbox: eliminate unused functions from binaries"
we can build sandbox with EFI_LOADER=3Dy NET=3Dn LTO=3Dn (and CMDLINE=3Dn w=
ith
the rest of my v4 + an unrelated to this fix for fastboot) and since I'm
asking for changes anyhow, lets just drop this. Thanks.

--=20
Tom

--LlZI8tT/UX4Pdu79
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5ZQwACgkQFHw5/5Y0
tyysagwAoyPNUvihdCee2j4+JwUrRdLBnRTt0h+I7WLw4LgpwsR6tBLRfszx6Sza
w9zPSaeygi4YSR8Esuf0MepucWh3nOVOydtGrdkMDf0nFDor1JllGRiaqAKA28j/
Br8hFMeku6AicNhVm3WFfJ7apS82fc56GfPmfH7tG7JubPrzCMwGRjT1dj2YWSxC
Rvww8M2QDVK6+AgnvrL/Z9Lae2vr95w9vnXMCloBhh5oqcS9x9N2dHcwgFlXo+eu
rtlcL6rTKOUSBAcuiD2ALWpuEFJ9pYR7m/Tpkx5IHw1D8DFRrdGwgtC5EGiRBM1k
Kw5y5kVqxPnnJXt9PCaq1N+cWZKygMXjriCpb7zeuip5A4UxXKmUAZn7othXALb/
q6eCcJwPFsVyKlVnuG6PAmKjwXfDzhgKCqCPcScCQAKIRODOji8om5nwdn/1pQu2
N30/L3CVskHw4qheQsIT0jrvosd+8elsfBiMEZ5cwN1sq4bNznRYywiSe1LHFSGA
Fnnt3srM
=yAwC
-----END PGP SIGNATURE-----

--LlZI8tT/UX4Pdu79--
