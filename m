Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF60C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66AF866D0;
	Thu, 24 Aug 2023 16:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i/c1QUZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C74086667; Thu, 24 Aug 2023 16:54:57 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C37EF86681
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-58cf42a32b9so74944597b3.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692888893; x=1693493693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+Vz3FJ3349/cHs6cz7XpCsicVb+xnRw0lJkVL572Mw=;
 b=i/c1QUZlU7I+gpegmzvU49TyXbki3Tod3SAOiNSbW6ieSWdiibDSUvuxvWJ31SX6k/
 NcZHxuBNqO9Pt6K1fWXxvzymRbPQ5L9eUXSuSvgENfLLC5c4DAh8t1uO1hK42mKNWFiG
 mQZayHeMUhITc4Qt9m9BXzUrRJGop4UDnvGhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888893; x=1693493693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+Vz3FJ3349/cHs6cz7XpCsicVb+xnRw0lJkVL572Mw=;
 b=IJNpneHnlrX4jAdiSnX9KjxCcgvWZRgPgRZvQ/cTTrlWYvNaWh8hZcyWo36K6ZW2v9
 ha3Q4To2OB6CXbspJO6EBZn2k/erCKJbE9p5VKyWvnRa3VJh8G4pJmazCSKL5/Sus3+f
 DqCRynMD7VdrZKYqov4A/xH69Eo1NvxzOIo4+dR+TRNFdcK5ZOp3hzXTk6A8Dnx9z1ng
 fynkGhvC/LHXBYC5Jzf9oL3R9AIPGtV5gbxr4v40IRo3klQsp06a60FBM8WnGJU6Vj/C
 qNhuXuz5IcBHn4NFtehK+nt9/FKI2D6FN1gMLKqRa4kuJwi57FicW9Tm1j1C4/F/gF0p
 IKgA==
X-Gm-Message-State: AOJu0YxyrGR6V7zvaQvJjRHc8oeGVXOkZ6vXsBagI2i534CnFOvDkWSZ
 lEHFRymv7wQKfiKwa7BYdRhoUw==
X-Google-Smtp-Source: AGHT+IG8nRe3z3u8l92n/uA+0CRyq6M/qCcKC2EIpHoXLjn99SqYWZN24A1MEpmqkER/CAANv9ghwQ==
X-Received: by 2002:a0d:d654:0:b0:576:9d2e:ef2b with SMTP id
 y81-20020a0dd654000000b005769d2eef2bmr14310665ywd.10.1692888892787; 
 Thu, 24 Aug 2023 07:54:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 u184-20020a8147c1000000b005832ca42ba6sm3962843ywa.3.2023.08.24.07.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:54:52 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:54:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V5 06/17] include: configs: am62x_evm: Drop
 distro_bootcmd usage
Message-ID: <20230824145450.GS3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-7-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m2rU/aeK2Hl4BnRv"
Content-Disposition: inline
In-Reply-To: <20230824031101.3460411-7-nm@ti.com>
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


--m2rU/aeK2Hl4BnRv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:10:50PM -0500, Nishanth Menon wrote:

> Now that BOOTSTD is used by default, drop un-used header file
> inclusion.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--m2rU/aeK2Hl4BnRv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnbzoACgkQFHw5/5Y0
tyxoxgwAuOWGvaxBWQ3/A5P61eLZ6FwWnWdc1oQ/QcKv0puZDB5fa54MPh6qIgZu
6cKn/TT8xD3gwgIj6uQAdROuGsE1EFm3Fu96AsqjAP8SDMlXTS+HBf+W0fZHUCHC
63Zg5RM6jA5MUxeoj5YLWclNnVOopeGKhdbF6bhZl+7/gfCrS/acTJ8HVRNW+cSS
0xRFlQJx6sIfpteSIahgnEwO0e3J84j9eEEirG2F0QzaalfjYO0k7EwuQfl9d+U1
xyLF5O138UwnYQSI1ZFGNb4NQOnkHpsYMjo9A8Eyr2uneo5UJnxPaifl9LgqWJV9
3HOo4651zOHB94X5s2MtRQGp4/pmYqcdzbKZyqQFW5lSX9zeGax9lXztm5zh5FfT
JZ/HwigAjQKZCwe4jYA5irSQ/6qRcD/tzr4w3IYai5/5ke0jOQ3vLmW8Ws25ELhf
Wy4sZcpuvM1osHCwFf+fmrivyECYF1yE5KIwXEOGVrKB+XvWlAd/+H9y68BS+V2m
GaSi2ec4
=HX/A
-----END PGP SIGNATURE-----

--m2rU/aeK2Hl4BnRv--
