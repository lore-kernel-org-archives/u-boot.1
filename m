Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF7DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4148868E;
	Thu, 18 Apr 2024 20:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WIiBfdoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5D38868B; Thu, 18 Apr 2024 20:13:28 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06578868E
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 20:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-437846c4ceaso7244621cf.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713464005; x=1714068805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R/V2Mw3xPugZFIYWgN5xgmtcfvdk4TJwXs4n7L/Jw+w=;
 b=WIiBfdohVFoPyMLyjEVT9Wrs3CkXPmj0/Fnvhmh3T2xjVoIAznwG783EgCAGK6hRxx
 OWcbw4bTKTrqGGajx7Rf5l8UDy7JEIAPQTmu2ewXjPXdJmCuRe9oiS3fMsRFPTggWVan
 EBtifEaDwsOcioePJYAjOqZjhppRO/s7YJaOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713464005; x=1714068805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/V2Mw3xPugZFIYWgN5xgmtcfvdk4TJwXs4n7L/Jw+w=;
 b=CMfySSp1waWtV7Fu01Ck21HrFjwO61NXGvdouG0Xk/ZZDZ5ASJ4+FP5BlBpHgS6Lzr
 Sv4T71YWfNL+9J0I88I6JvhtYrxCygHgeIPa4QFnkxg1VfZJ8mnqQ/tdZIXSNgWMT3OB
 e6KUWGCbziVPXRNIRX94P7spFucylw0LIRwr1NY1V9j4TyOG6Fh2pd2s39cHLcouPOpo
 FFYbM36nvFANXuf3BF2HUspQWyuejfn3JkyIzErnyAlNPEJ8l/uS8Q4vYSI2TiL5zj2v
 zOPNF+4JUJleDZrx8sWoH4DFzxGT7U/KI2HAg3ccrzk8/U4Uj7304XYFogBWClH5kteh
 MrDQ==
X-Gm-Message-State: AOJu0Yz5nlyaBaIGOgr8b2/8DTjO1YdchFH4VggVkngwuALPxmJTqFys
 4G0dti6howzzOVJPIBGrMaSctJlOYbxfAmj/+2jLS40GkXyHXl1P87vvhHtOMsM=
X-Google-Smtp-Source: AGHT+IHGFDzyLpzHcskhoqMe+F1FAJrKbBFkeZ0B64Cs6PR0NTkup3mN/LentMVrVxn2k3+huLqwCA==
X-Received: by 2002:a05:622a:290:b0:432:d620:6d47 with SMTP id
 z16-20020a05622a029000b00432d6206d47mr4209377qtw.52.1713464004716; 
 Thu, 18 Apr 2024 11:13:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 bl10-20020a05620a1a8a00b0078d68c42962sm838470qkb.83.2024.04.18.11.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 11:13:24 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:13:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 CASAUBON Jean-Michel <jean-michel.casaubon@csgroup.eu>,
 TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>
Subject: Re: [GIT PULL] Please pull u-boot-mpc8xx
Message-ID: <20240418181321.GK1054907@bill-the-cat>
References: <c7025d62-5cd9-445b-90aa-506c20228834@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pWLnP7Vl3Y722/hO"
Content-Disposition: inline
In-Reply-To: <c7025d62-5cd9-445b-90aa-506c20228834@csgroup.eu>
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


--pWLnP7Vl3Y722/hO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 04:03:28PM +0000, Christophe Leroy wrote:

> Hi Tom,
>=20
> This pull request adds support for temperature sensors et FPGA loading=20
> on boards from CS GROUP France.
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-mpc8xx/-/pipelines/20=
416
>=20
> Thanks
> Christophe
>=20
> The following changes since commit 2c3fa4b8add3cb6a440184ab67debc6867d383=
c0:
>=20
>    sandbox: don't call os_close with invalid file descriptor (2024-04-17=
=20
> 17:06:16 -0600)
>=20
> are available in the Git repository at:
>=20
>    git@source.denx.de:u-boot/custodians/u-boot-mpc8xx.git for-2024.07
>=20
> for you to fetch changes up to 741e30e8c2b837dc92ee2eedec5478afdd83a316:
>=20
>    board: cssi: Read and display MCR board address (2024-04-18 15:47:46=
=20
> +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--pWLnP7Vl3Y722/hO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYhYsEACgkQFHw5/5Y0
tyxIQAv/Z5snlwecMusIvb+DIZZuiqYQYlAG0BKBZUuI7nKs+Eo1RBc5awT2gpBK
NmEWWuxpyzI8OgzJEqhjSFxShrlwo4dc8nfTVkyq0wU1GIwnotiXP3HFV1K8PyhF
OUo3clmagrSQeOhn1OO1tjrnQACX+OsavjZa+Nqf2p8qXcNQ6zmmQWFqNpZ1ijjz
UvOrwB0s3fp3SNU0tUzTJDpH/b7RRt6TCiz5YDQUJu9kV4PjVuvybMhiHZlXZ+lH
l1WaRULaJ6tn4yCoFYmyvYjpHaOfy6niVyZXhzecepaTQhyv5U5pMEVfjiLfKOal
m0rdz9+Hplu6ur6hCXFYztbU1IKcO5ACkTyJnmSnPUXGIpcGtUZFHi6wvJjn5hGz
ZB7XcjCWSxySPyCPYqHte7cFyGRLsoolcmoAFVe4s8GOTxcViyZGUeDDWEwHrF2S
yw/V0JeokG7Qwx1iNAVwjwM382bC2D0FGW4LwADkhn/kKMIuNYEd0H4UouksLSsC
wtoMSoAW
=5oky
-----END PGP SIGNATURE-----

--pWLnP7Vl3Y722/hO--
