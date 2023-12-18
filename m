Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97094C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 16:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4AC4870DF;
	Mon, 18 Dec 2023 17:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VHjuSX0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D144870D4; Mon, 18 Dec 2023 17:59:17 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 374848718A
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 17:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-67f0d22e4faso28130056d6.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702918751; x=1703523551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5s+UXh76TDcnlPHU2xeRgm9WdkA6X5cOO+l/EDjH0Yc=;
 b=VHjuSX0hX7WRY7kBHP2EUf7KKvVv6MBwXys11xXWRonSDyP96FNmFvikrY61WrDXBg
 Ei0xLilq0wNDZDQVOjxBQRzIZj57+vTCXqIO9PmKaSfgYqwpLy97k7k6+42dpg2RW8m0
 Jq3OCdIugYH+2uXHuHl/tvfayHrULxsIfggCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702918751; x=1703523551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5s+UXh76TDcnlPHU2xeRgm9WdkA6X5cOO+l/EDjH0Yc=;
 b=m2hQB3slOnpSNTd4hbDjDRaM1vbFj4BnshS1go+YSpEg6EgErNRFGV6iaLxFG/Gj2X
 Ns7MmLADz1knnyKBYLyNmtjrH5fkMxtqw1cp21Nxadq1IwZZiTu3vElIUZkrRZ3NDN/s
 Ju/hru+J1leduaYLOrL2szt8ZXrX8LonHtkxl6k53g1/eua3ErRP+/f3jp+1z9y60uwQ
 J92As8OAiFDRKUZ4S6IZ//l1NmUTa4pyIGKVSfkVSsJHFDnMMmxyw8Ez9WjJ81j17yoz
 o9UL+ZcDnDB80SD/T0+60uBjyJ8r9y1JZQKcB8dQoodv1SotknlyAdmnl0kgd4ynqHVU
 7h2Q==
X-Gm-Message-State: AOJu0YwOp87tKs4C7KdEfbQHykpNQcIxjF3q4dhGFw135qqPBwkkPqE2
 OaCcI+05hL0dY+OT2zTiGgVW3w==
X-Google-Smtp-Source: AGHT+IGDlxLy1Nof/jOAqKEm1QJPMVovHDO8vAbDZcAnn+DuaywD/fCHDD056KXGob5mBjANgvrb4Q==
X-Received: by 2002:a05:6214:234f:b0:67f:1889:65ea with SMTP id
 hu15-20020a056214234f00b0067f188965eamr8788303qvb.126.1702918750888; 
 Mon, 18 Dec 2023 08:59:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a72b-a3fc-ffa6-9927.res6.spectrum.com.
 [2603:6081:7b00:6400:a72b:a3fc:ffa6:9927])
 by smtp.gmail.com with ESMTPSA id
 db11-20020a056214170b00b0067f475241b3sm1012514qvb.83.2023.12.18.08.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 08:59:10 -0800 (PST)
Date: Mon, 18 Dec 2023 11:59:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-spi/master [for-next]
Message-ID: <20231218165908.GJ2513409@bill-the-cat>
References: <20231218102625.1050191-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b/sE0oFx++yhR7Or"
Content-Disposition: inline
In-Reply-To: <20231218102625.1050191-1-jagan@amarulasolutions.com>
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


--b/sE0oFx++yhR7Or
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 03:56:25PM +0530, Jagan Teki wrote:

> Hi Tom,
>=20
> Please pull this PR for next.
>=20
> Summary:
> - spi_nor_read_sfdp_dma_unsafe (Vaishnav)
> - w25q01/02 (Jim)
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-spi/-/pipelines/18995
>=20
> thanks,
> Jagan.
>=20
> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b=
63:
>=20
>   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-spi master
>=20
> for you to fetch changes up to 959a4a0838acf7ef733e000d1304cea6711b8945:
>=20
>   spi: cadence-quadspi: Fix error message on stuck busy state (2023-12-14=
 23:56:19 +0530)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--b/sE0oFx++yhR7Or
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWAelIACgkQFHw5/5Y0
tyxYygwAuScKfqw3MIqwV6DuJl9MEtVFw3VafTlcuAjUYOtva/k7c+Ax+Qud6t8X
btBTQculvaiH+3DSTbx/UJ+7SQaG2uW2QzBD/VK7zepwwzrD7JzLS0p46gtWOpRT
GlUJSvp/yxc+c+eYWpqolN7zUhmwMI16yHBVuLACUPM7IoQfJWbiU6mO1EpIKMi1
UXmbRGJ+zF+ORUk8pw4Z7+a29fdUxMzz5kezDQuT3COCuxZHQCUi0x7t/Hi0LP66
ysGUJ9x/LvkXCp6qDBYdso4aH7qtLmfPnf2af+XgZf7BbIkMsSsUCbfDUGf/2ENw
wzk3PhP9j0SPVi83C6UxmRoncFBIAp03ujlhK4AuQkl5QmPrEfIyv16fTA+i81vm
egXZqpdTHiP8SJzbIlECVv7kCMsbegt6SNpCJ/xkljMactgeCQdnMKaPfWZ80BNu
3BaF4LniQUzdhu+1zLS4bcYWsF44MztpyWLO8TnGeV87WcyFmnoE//FgN86Zij+L
r9BFtM0l
=LPA6
-----END PGP SIGNATURE-----

--b/sE0oFx++yhR7Or--
