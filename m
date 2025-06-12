Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8172C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 17:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E52382B97;
	Thu, 12 Jun 2025 19:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ij+Xz5iM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1468882BD9; Thu, 12 Jun 2025 19:58:44 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81AC582B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 19:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-40905ae04e4so428772b6e.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749751120; x=1750355920; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B/F5L9/wcaZCkC2sjYVWXckq05BCQIl4kmtiFVJjLVI=;
 b=ij+Xz5iMKFDcQMGxDN1yC/PpLOgtlUeZLkLDZ3g4cebpTSzRUACwyxDSgn35Zd/z+c
 2aUhQfZZuasgoiLZkeJN5o4MX0ZdcFQ6xoLftUtG+xYxU0VOo3VdcpB12z2uwd/Odxee
 ZK76wV8Ltj7KOSITB+d9Um1Z+f3JPCDxhYUJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749751120; x=1750355920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/F5L9/wcaZCkC2sjYVWXckq05BCQIl4kmtiFVJjLVI=;
 b=AVx96ZNVBk3rJlx0PEeErB4IYZZeHPKOf99bokZiSaMlHID2ZPyUDSFleO6V3J9mDN
 Bos9mOJPZKpYjs7Oyrc8aCyrz4WE/+Tubd+Jlj6NxkhfbtZ6pMq4o7w4rnZqXtjVINC6
 3P5yFTqnO6tn0H5WPKcNljyZok3z0pYVCUeSeAgyM+BTaol0b6YhnkhYjNzlPWlB5iyO
 M0SfmhVg/kUEcaf/zVP16jlO+/E5q7KXonoc3p8hZTg0nUgzJCFWAgV4nBBs0u9XtdLS
 bn7e9FGYhep/uNwsJrl2Ugz+HawtEyDU2NAWmbcSGAb47CUiDuyOugpdXyQxa4BwlCJq
 3YYA==
X-Gm-Message-State: AOJu0Yz8m7xqmwupaLlff8hqc7oo2TTTf0V1zAIWR3obxrFtDoiPB05o
 Qo4hvsVXUwyUZgAZzLwLje/a3rQrYAuXu8a5o6AwwWJgybNQiEPh+PZVkmLvtXA68yFDhndjLgj
 GLXpBxzU=
X-Gm-Gg: ASbGncsOh0071fqGcZSarOlwkxs/0SXs1OFh0hjqNmUhR1PAODiDqPsts4cV7VXq2ig
 minr5PKYz6JqWgcV19nrOj0jVWQn4FzmeIN+g4EpEGAoQDmR1z5MbYuN2byvEYvmCjYKtliyJq7
 BCmPWDVrA5fPAsJppLlWLMMdweegig64vrydux8kxYOJmUoxWpn4aMs1WAqfO5AGa/ejo6Ng2y2
 FC23VYMvID3OdT42wQk/+qwdzPO7YwuQCSdKJGi8PSFuLYUJfYaqKd2PQwr3cZoJ0m5azckN9QK
 d9a4lxgYrdpjaVvDny4d6Q4W59SZQcnaNd3sGN5RzAI5hE54nqn3npnAIrjiPZz7cH8DuG29Db+
 qjL9LZOQ9O0PKcRWgEybPuHY=
X-Google-Smtp-Source: AGHT+IEnpFy191itLcoB//AnH3megdJZpyCSPbCOgwUg9kkXA2KerFuhOqOhJ+x/qxcDh/YjF64puA==
X-Received: by 2002:a05:6808:2022:b0:409:f8e:72a4 with SMTP id
 5614622812f47-40a71d94b1fmr257274b6e.2.1749751120206; 
 Thu, 12 Jun 2025 10:58:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a6820168dsm378704b6e.4.2025.06.12.10.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:58:39 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:58:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 patrice.chotard@foss.st.com, Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v3 0/3] Restore support of short name for type UUID
 parameter
Message-ID: <20250612175836.GA237915@bill-the-cat>
References: <20250602135935.232370-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="weP8gKlYmH0yDAcZ"
Content-Disposition: inline
In-Reply-To: <20250602135935.232370-1-patrick.delaunay@foss.st.com>
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


--weP8gKlYmH0yDAcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 03:59:31PM +0200, Patrick Delaunay wrote:

> V3 version solve issue for "ESP" support when
> CONFIG_CMD_EFIDEBUG and CONFIG_EFI is not activated
> for example for test with qemu-arm-sbsa defconfig
>=20
> Fix and add documentation/tests for selection by string for known
> partition type GUID introduced by bcb41dcaefac ("uuid: add
> selection by string for known partition type GUID"):
>=20
> - split list_guid for short name (used also for partiton
>   description with type parameter) and full name to display
>   information
>=20
> - as the function are uuid_str_to_bin() / uuid_guid_get_str()
>   are no more under CONFIG_PARTITION_TYPE_GUID,  since commit
>   31ce367cd100 ("lib/uuid.c: change prototype of uuid_guid_get_str()")
>   and commit c1528f324c60 ("lib: compile uuid_guid_get_str if
>   CONFIG_LIB_UUID=3Dy") move the content of array under EFI_PARTITION
>   and linker will remove it is not used it (in SPL)
>=20
> - Add and fix documentation for gpt command
>=20
> - Add test test_gpt_write_part_type to test "type=3D" parameters
>=20
> This first patch solves an issue for the "system" shortcut for ESP,
> removed by commit d54e1004b8b1 ("lib/uuid.c: use unique name
> for PARTITION_SYSTEM_GUID") but used in 2 location (at least):
>=20
> 1- board/samsung/e850-96/e850-96.env:10:
>=20
> partitions=3Dname=3Desp,start=3D512K,size=3D128M,bootable,type=3Dsystem;
> partitions+=3Dname=3Drootfs,size=3D-,bootable,type=3Dlinux
>=20
> 2- arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:1151
>=20
> 			case PART_ESP:
> 				/* EFI System Partition */
> 				type_str =3D "system"
> ....
> 			offset +=3D snprintf(buf + offset,
> 					   buflen - offset,
> 					   ",type=3D%s", type_str);
>=20
>=20
> Changes in v3:
> - The definition for ESP =3D "system" partition in list_guid[]
>   is no more under CONFIG_CMD_EFIDEBUG or CONFIG_EFI flags,
>   and restore the initial level (always support for display)
>   as it is done for MBR partition or when U-Boot is a UEFI
>   loader (CONFIG_CMD_BOOTEFI).

This still has CI failures:
https://source.denx.de/u-boot/u-boot/-/jobs/1168239

Thanks.

--=20
Tom

--weP8gKlYmH0yDAcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhLFUkACgkQFHw5/5Y0
tyz3PgwAo2EtVz10B4+yJb3mUJIW4ZAM8rbxn45RA7xutcVD5iwgGFIxAehrB0Lk
c3RI+BIo/xdk+lcqThtLcp0tMkK0HhkPPymKpK7SSbgNUaDKhpBEcML92OTxMbRh
77KVGcyXMocckJ+CsaOTzDKxvGhLERTKcnHswwT9Ag1irMafrIQlKnMtiVYVW+1o
LisjTPjzFKSNn7xGaMLqCTB0yTtaKo18KRKbEpdyQUHxukUlJrHKYbL0nPQfQ5QG
EglaoqRjV1doGZElToEZCGnCEzroc6WQv4eEl2FMmCZf0SdOTbAk/0294z8p0N33
n8Ldnev8zPuCD9UgjSPVQ2E15miOcb1asBlzPvfupu+Pw9ExKTmMtI96n6vSjkY9
5f8Bew1dvRC3psdSSmNMg0WyY7EhMOF+nNlRC5P5sRxtJXeSWC17Udvv9czLlX7t
kjNRi7PZ2XXEn07Zh8vtxAlYN0JGgO1V6OilJA0fhZ+Po4OtuztOFmEGshguH07P
KVWQzA+N
=pzQO
-----END PGP SIGNATURE-----

--weP8gKlYmH0yDAcZ--
