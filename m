Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D446C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E5A885BE;
	Fri, 26 Apr 2024 17:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vxh7FNrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53EEB885CF; Fri, 26 Apr 2024 17:52:01 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D87C1885B4
 for <U-Boot@lists.denx.de>; Fri, 26 Apr 2024 17:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-617cd7bd929so24217437b3.3
 for <U-Boot@lists.denx.de>; Fri, 26 Apr 2024 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714146718; x=1714751518; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xsaf7nrqOSciVz20MtppYbgREs0pIEBWA5rl9lDpAEc=;
 b=Vxh7FNrR5z+pxl3qRhaa/2TuIzH7qhtn6d4AFrZvG2ZbjJjI6OuVXabfgEHvdvp97L
 jPsfLVCragfKFmyWLjMkPyAriE7/DstJwJTEbjK0S+8fXBObm7pUXF5nHsBLDq0trkQL
 eGEEVyWZTkeuTaLwgQf2U1kWLXYLtRpkxo5Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714146718; x=1714751518;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xsaf7nrqOSciVz20MtppYbgREs0pIEBWA5rl9lDpAEc=;
 b=n9beltDDdqqVQTh7/rbgls9HAvFtUFzTH4iuCtba9r4JM1zd6yZGByc2lQLeAua9kJ
 pPIYWx6DoGTADTwO0yAs+UL0uLiO3vDZ87Fc2C02Vohb22Y3MySqabzoGpENKtBbifL8
 5/qLWw2ihqoYJIMGi+iUvslz2zKNnAj5tRY1AhzXG4zBhC6zm8IhEmAv6tmO5Ig3VjYj
 c7IxZNb76PketWbopPDJcdMcotba4jnSGG7ZzpgjtfSsohzf9Ut3irU1pvime1EosczJ
 6WJ/Q6c9kU+o6w3CtnEy0b5/jiUcrxH5o3mSZPBPELVWwu13sUZZ1alnJapbtGNTXgjm
 ArpA==
X-Gm-Message-State: AOJu0YzuW5iiFZiJCr0oAlJcbjwWnQWkYciEJ+NM3cdGW9b1KuWKL0RU
 iI4LgNaOp9rQiYZvjSScCoslVPDu0jYlWkN9jzXglTs2K5wfuG9hE10hYojSh6g=
X-Google-Smtp-Source: AGHT+IHrA6Zp5RR4KN8lY0COWk0YHw95UeZvmeuq8CpMtoXMwbN2j095F+L/hc9lnpLBNm08ewfeFg==
X-Received: by 2002:a05:690c:ed0:b0:615:15c7:9d6b with SMTP id
 cs16-20020a05690c0ed000b0061515c79d6bmr3582169ywb.4.1714146717673; 
 Fri, 26 Apr 2024 08:51:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 jv9-20020a05622aa08900b004366d3eef03sm7967938qtb.68.2024.04.26.08.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:51:57 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:51:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: U-Boot Mailing List <U-Boot@lists.denx.de>,
 maximilian.brune@9elements.com, curtis.machida@intel.com,
 Jonas Karlman <jonas@kwiboo.se>, greg.malysa@timesys.com,
 ian.roberts@timesys.com, Jae hoon Chung <jh80.chung@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, sheng.tan@9elements.com
Subject: Re: [GIT PULL] Please pull u-boot-mmc master
Message-ID: <20240426155154.GK1054907@bill-the-cat>
References: <CGME20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b@epcas1p3.samsung.com>
 <e6c74bd0-de66-42ef-a6af-0d5c058b12a0@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qEQSiBJcrglmA9eh"
Content-Disposition: inline
In-Reply-To: <e6c74bd0-de66-42ef-a6af-0d5c058b12a0@samsung.com>
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


--qEQSiBJcrglmA9eh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 07:38:30PM +0900, Jaehoon Chung wrote:

> Dear Tom,
>=20
> Please pull u-boot-mmc master into u-boot master branch.
> If there is any problem, let me know, plz
>=20
> Best Regards,
> Jaehoon Chung
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/20547
>=20
> The following changes since commit d097f9e1299a3bdb7de468f0d9bbc63932f461=
cd:
>=20
>   Merge tag 'fsl-qoriq-2024-4-24' of https://source.denx.de/u-boot/custod=
ians/u-boot-fsl-qoriq (2024-04-23 17:53:06 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-mmc.git master
>=20
> for you to fetch changes up to 1776213dadef4b578f98bcf18beb152f8975a8bf:
>=20
>   mmc: arm_pl180: Limit data transfer to U16_MAX (2024-04-26 15:32:06 +09=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--qEQSiBJcrglmA9eh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYrzZoACgkQFHw5/5Y0
tyzGhAwArPxnfHjmtzHr4nsM3K6h1UR7NeZNIv9xJCfbjldvqaYkrjakeQIGdqOX
VXiXm3Jx8EjvxmdOZ10gXGGb88RGJM5DT/LhEQKZ2tWIshIDQamb6snzg2r2PoUF
D2Ih8fquM/exnE0jsCgMw6OjYmopIEBxZhnI3qv8vUwEpr2PInAwYNbEgfP5qSwY
SNRZTizWvdiujqUioJ0GjCC14t5YDBcDp/J6kiQqUChQLbXFuwIiY91KyjB4J1qg
W+k0Lb/oJAXpzL+U57yXkg6A2HBBjR1FaVtnKIh+KTHGZIW6xtlW0C42sMAEB5CZ
rnEplqTBMWD1QCoq1jfxsm0Ko5somU+G0W8ge57Y0jMzBV7OkqfJ0nOLaLJqpmJ2
5vwLgg4qjXkdJxyeAB9qEoOpbISnxioerccP7WA7bNLO5h7AfBFQobUpa5UJcpf4
z4LeYaQnij2vRTi10od7vBduMKOJElgtIKBhtOdzfhy6mqU4lzJCU3+HzluVDAxp
u207zp49
=5wAk
-----END PGP SIGNATURE-----

--qEQSiBJcrglmA9eh--
