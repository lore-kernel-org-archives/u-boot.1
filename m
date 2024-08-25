Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F94C5472D
	for <u-boot@archiver.kernel.org>; Sun, 25 Aug 2024 01:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D7FE88852;
	Sun, 25 Aug 2024 03:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XfCzk41G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732588888F; Sun, 25 Aug 2024 03:36:40 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 242218870E
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 03:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7a1d5f6c56fso210958485a.0
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 18:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724549797; x=1725154597; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bItCpRTXv1gaMRcMBz2B2HFt3Pnqsgg0hMCqA0UawEg=;
 b=XfCzk41GKTVkbxxdnt6bfYqRn0fvLmbeRa6TEEFoRbGYW6NYOALQtYrflo6ZzDot2V
 MAPDGHTI1oKKHTOcraHJpSbYjyWGTBICZOps7WDpFytdjv8XrEZVxBFJ5qP6JSk0laYw
 gP9vAO7VmQ15pq0HjrA9bCUrm9yypENI2JIyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724549797; x=1725154597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bItCpRTXv1gaMRcMBz2B2HFt3Pnqsgg0hMCqA0UawEg=;
 b=SSDmwWWoeMDHDaBBXIu9iQAKid+iAHwh4vlYeiEl0ZScCM4y5D9qec9Rcmbow4yLkY
 g5OVR87FMcBxYyyYJSVEtbBDBQel1qfEvZWbKBl86JTfS4UMLxd0cHEHjf8VVf31Rq4g
 l4LNmm6pYiunLnO/jyD71jYqUazglRVivyiIQJg1cf3klX/r9iUYL7ZD5BvxqDbhEaAO
 Olo4uMeL3DSvaTY4seZBioik977nq/W90y4n3D5zWAj3zRPkmoKyeL8txdtk2oQWdRo6
 30MzRWkLLcul/UlY20si04eVQAmZtk2VS3o8HG7APG4BNSbNuyyBNMD7swNfvvcFq8Pm
 75jQ==
X-Gm-Message-State: AOJu0YxPiPvlPf3XgPZOamOdbcMWtqMA3zsfmtgOnddZsPiAe+IS6wMN
 fz97ehywXu/NgrI304LSJO0SdbQWmbItojcsRoy0ET+PN72U23lmHkcEQAHBisU=
X-Google-Smtp-Source: AGHT+IFb36OsIWvjvLAMVXdSr5XTr4mwoo1+iJ+IlVDrubRZYGTKqfjfZvnc1QFu3CLdhYZs8yG5Gg==
X-Received: by 2002:a05:620a:1a83:b0:79e:f9ca:4631 with SMTP id
 af79cd13be357-7a6896e39f5mr838585285a.1.1724549796615; 
 Sat, 24 Aug 2024 18:36:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f362739sm323351785a.68.2024.08.24.18.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2024 18:36:35 -0700 (PDT)
Date: Sat, 24 Aug 2024 19:36:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>
Subject: Re: [PULL MASTER] Pull request efi-2024-10-rc4
Message-ID: <20240825013632.GE2479150@bill-the-cat>
References: <dd9352a4-767d-4aef-9d19-08cf301ee8f7@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iRxxtPD+GTPi4yvZ"
Content-Disposition: inline
In-Reply-To: <dd9352a4-767d-4aef-9d19-08cf301ee8f7@gmx.de>
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


--iRxxtPD+GTPi4yvZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 09:06:56PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit a481740629af5e51732b86b6ead61dc5aa5a44=
0d:
>=20
>   Merge tag 'u-boot-dfu-20240822' of
> https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-08-22 08:14:48
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-10-rc4
>=20
> for you to fetch changes up to dcd1b63b7072749f98ea0a87565d0ae5c8ddfb65:
>=20
>   efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all architectures
> (2024-08-24 11:41:23 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22104
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--iRxxtPD+GTPi4yvZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbKip0ACgkQFHw5/5Y0
tyzVrAwAuQP1PiLqoXacnAZRjyEc3oihszDfK/6U2TVj0MuY3Wl7T0hTY13vcLrk
dDK+1qeOVe1V8s2iYEyobZps4p+t03fMvcsAhm4x7kXjp38jBDpQGtTYlIW2WI+Y
9Rm23y1DK6bngsuYVOABQQuQ3DebJVZslGAg3R+XEZI2nXc+gMDuz1GwfcfDdvw0
OExkH9h7calCJ6l3GSIY6fpTod+V7C694s3HgkP53/F5q+ewle1XbdhrKlLCvDKv
uajPfTmnxv8qEXLES8YytRHGtBUvlKoGtfNPfr682MHethI9SCsldtz59I3Dab9/
ydRaVUx/hzL2PQhvYpVTsfXRpKsgr+NuEA1Uwa2bFLQaXSUuKNTNHSHARhlqlDbP
1mTE7cElfSMI6XF7w88P++shdlURRC1VMniQcSb8bKIlzEi+PptpzHv0oUY4bEaF
MyVurg/iShAEphl1xJWzaqiVMr6rELqOnRQCcIasfjsNzExmZG8MPxIl+sFcT/yn
vMhSACUW
=T0vN
-----END PGP SIGNATURE-----

--iRxxtPD+GTPi4yvZ--
