Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AEBD6D227
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 18:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2091894D9;
	Wed, 27 Nov 2024 19:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LQjoM/C+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6C1894D9; Wed, 27 Nov 2024 19:54:58 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676A489608
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 19:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so4035185a.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732733695; x=1733338495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=voEd3iYUnYWLCuEQqci6i3eGpFxrvn9hjw/BRVKWajU=;
 b=LQjoM/C+SmWsgRW1jKTXtP85wFsxIsAS6Ikj1u/JGbPqMkdg3yo93G6nXZYY26Yogl
 M/0m7J9kHnXwoveAji+Z1T2A8ht9Fj6sc7mBgQfdsv0FIbdiSqxpj1v1X0rfGbJ6sbTa
 9tceHGoePRstFx/U5VCUAcf8TTl224IOg0+2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732733695; x=1733338495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voEd3iYUnYWLCuEQqci6i3eGpFxrvn9hjw/BRVKWajU=;
 b=q4kZr74W61EXMy7j1bCDIsfBXO+uVR8rAzjS/VbZ+fYGd3Qvpa8obBCLwLhDzOXOTu
 us52dWpdskKXzra7yMh4hqWMB4L8sCpB1OfcFzOXpcFJ170bffBXaq/IlJbnpWcE21GX
 GMEt7LQcSUEIBxtVpcQfntHhf/TBRH4urn72H2/L8gFhWxVcXKqr0NjYiKpDk+brC0Fd
 L6MyvkffWBk9xugDci0gPDNXVtuMu0du1FUjuiRwoLAU+ZMUH4FqMvaLuTnSz3VjBicH
 wIIc/Ts8YGAN5GYWMtDfbm40IS9E2I+BciwNdv73WJn201MRMFGDsrAhltKZir25d7AT
 HSbw==
X-Gm-Message-State: AOJu0YwcrSwIGgBzCzhfmekSK+IKX2L9NHZimZ8HtffGuJqs8aT2WX//
 aI5BDsa2RmfsVZ6g0eMOMGkRL7wWK4XLFsZhGEomZTvqxwa4aV2ppYTkfxQoGjQ8jEhj4Lc8lva
 8s7I=
X-Gm-Gg: ASbGncvdukly9I0YUMqp8pNsnzpMGW6m5NFAMUGsEClG+CQGQf/4icgMOr8eyr5fqI7
 0YBKEXJ9T9QSx+avx9KkgRjxp3vG8XEvqm/+uhkHmnN/yOXZp4I7jrygVt1tkcdrDQ21aWvFOQW
 283AzZvj6i6f3ZlyaP3dLh+i3krLPETShkpr3TIsb9yo5yOLbEdHEM0gYJ7VbQVfwKES1OK6dsT
 24YUsf+vOIEjWifUnxkvHAlERWaEoDlthi1VjZ+EEShdhtyHQ==
X-Google-Smtp-Source: AGHT+IEVOJtCHOIt+oXlZfT6LNNgbvpsUDAbxleU/QtrWGO9Mbj1MwXkXCoo/1YpIeifrAMVcA0Sug==
X-Received: by 2002:a05:620a:4085:b0:7ac:dfed:65ee with SMTP id
 af79cd13be357-7b67c2568efmr470806185a.3.1732733695230; 
 Wed, 27 Nov 2024 10:54:55 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b67a76dcc7sm124584885a.30.2024.11.27.10.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 10:54:54 -0800 (PST)
Date: Wed, 27 Nov 2024 12:54:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20241127185451.GC3600562@bill-the-cat>
References: <Z0cZ274duxXqZ-9r@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mso9HhrG1bGEMOEZ"
Content-Disposition: inline
In-Reply-To: <Z0cZ274duxXqZ-9r@swlinux02>
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


--mso9HhrG1bGEMOEZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 09:08:43PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 3881c6b90350b0b04085ad46ef64989b43967e=
ef:
>=20
>   configs: Resync with savedefconfig (2024-11-26 08:17:35 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to bdca70632dad38a1f7830c955771c0bd88ce7ae0:
>=20
>   configs: enable CONFIG_PCI_REGION_MULTI_ENTRY=3Dy in sifive_unmatched_d=
efconfig (2024-11-27 19:58:08 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/23592

Applied to u-boot/master, thanks!

--=20
Tom

--mso9HhrG1bGEMOEZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdHavsACgkQFHw5/5Y0
tywxoQwAkcYkr8VAWBcWIFCh5251s/3MR1CnsKVwAzja8RwE28WV/udqojk5pp5y
yLYazrM6WerGiillOzxCI/XHPhaMVfwG3xJDFa6fq+nPshtlj2XjWxStNnZebeK3
vltlN2lDn07eO5W8ds9Jt99pjdJzRMg+NDw6lhrhn9+CVWEqhjacu0F8+gp/3Zg9
vEhrbCDjyf2INn78E+iYYzIFfwydkdwZwtKIYDQ8cMCx1B8DHkKcbspI1TxN2Rzs
dqdWCx2FZU6LShEmMxakxENfPvMQN7kHaXPaY+HbGOVrfew2FquIT12exk8jVk1b
FCzpTZex550HIvn0+jU1DYGm2N90IsKoADOCSW+mMkS5Utq8nZEbYzqsug0HxdHn
/hCCTe4zxW1clWNtE4v7/CfVNyiQG29Xuvzcq7XpyNn8Pt4yJVWY6nHhlBKNwACH
hv92d178uP4IZRAUSTcWiNOw2UHcxWjpzu9pj/GNvaBKi1ZFogiBDmcuu9fntQUe
bYCiHZbC
=meAF
-----END PGP SIGNATURE-----

--mso9HhrG1bGEMOEZ--
