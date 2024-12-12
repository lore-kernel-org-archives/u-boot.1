Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D443E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 19:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57BEA801BE;
	Thu, 12 Dec 2024 20:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i2zZtLNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E012B801F5; Thu, 12 Dec 2024 20:18:22 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C7B80141
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 20:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4677675abd5so5738721cf.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734031099; x=1734635899; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GbNAtwLIbysnNdUuq+XtsC2dnUaZQRne1bn+sNjWlPI=;
 b=i2zZtLNmZJWws/KRX3UypGuj6e8xL6ErSVtqqiQ6EW8aD2tJ8WDW3FIsaxrpRcBe9E
 mfgc6LM3OMb9Z0NsuhaoxiIOIWnhsV253HLE2o2dd8Hrkq7cDdhkfeoC6yovZnTgYkFS
 xdy2uUoDCGGwQob9rR7vJhSgpfkyPgC+N3xdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031099; x=1734635899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbNAtwLIbysnNdUuq+XtsC2dnUaZQRne1bn+sNjWlPI=;
 b=ugJWQs5h4S4tM6hxqf1noyTRl1M1H76zj7VmPWf6JJt690TvqnlZJuML64me8XlZVm
 nuOrR9tgYB4q4hI8fkB6B/q9LdbH6jM4IuxlYv4rnpUmAuR/aK+qs0eL+NwHoUH235hd
 +C5of7qV/6O59+sj6Kz8nv9PXGLnS2lJR/aMfSgxmQHx77vhdI2u3/JQTIgAZsI1Yl/x
 zVUzXW3HixNLlCLMPuIAzOzmFcFzsow/tzl1Y0VzveJKH51gaSWQJ9bwu0hbgS2egYS1
 k+Yz7Lq60QOaMuc6cWmXhksMh4ob2gmSh4SjNA/v9HvCxq9nFOZTtL+1kJCiGLsKRAyP
 O5Og==
X-Gm-Message-State: AOJu0Ywmbm6On91B6k+BL1N1gm97suVgaOfOmVT1AwJESBrHPsfB/gDO
 F7BEy87+qcDm8EP1TsF29Oio7Ohm2MWfyNgAPlq1GmkIeW25BemrAxuUYwSOr4WJu1e8tU+fnpv
 U
X-Gm-Gg: ASbGncu53yxlHQ5swtA+J8qUkKNC1mF3Dv70+F6gA5NDZ5nAioguwIJbThTg2aSr45V
 tCYnrnitzbL4kPZYjZ2mcr82+AqZgCWgfCxEWl0wSsAkbVtChbn/Mp2w09+3+7F7+psu/WADz7O
 s6zdj84/YqSrzeEzFlFn30TB0aVKdqReiOPto9/6wLlZxHiDMpW0n5ifslkOr28+EsAflSZ954D
 z1bxEGIXx1zGTIpVIIkLw2G+EDNi8W8UCDYru69bvK5AFVjWaVXbyAy
X-Google-Smtp-Source: AGHT+IGZrrSq7jrZz1FutqULeNLDMct0rJggsADx8RUa/a4RItMN/+gqMpdZn9OZrJKy3gk7qpUk+A==
X-Received: by 2002:a05:622a:2d2:b0:467:65d4:7e07 with SMTP id
 d75a77b69052e-467a165863emr24044851cf.53.1734031099434; 
 Thu, 12 Dec 2024 11:18:19 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46789105216sm22564471cf.11.2024.12.12.11.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 11:18:18 -0800 (PST)
Date: Thu, 12 Dec 2024 13:18:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20241212191815.GJ1505244@bill-the-cat>
References: <20241212114911.21435-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="50u2Ejbw9csY7KDC"
Content-Disposition: inline
In-Reply-To: <20241212114911.21435-1-marex@denx.de>
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


--50u2Ejbw9csY7KDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:49:08PM +0100, Marek Vasut wrote:

> The following changes since commit b841e559cd26ffcb20f22e8ee75debed9616c0=
02:
>=20
>   Prepare v2025.01-rc4 (2024-12-09 16:09:28 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 0e24474cc323a9012bf1f0942f46d1053e326b3f:
>=20
>   usb: onboard-hub: Update the bind function based on peer-hub property (=
2024-12-11 08:22:17 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--50u2Ejbw9csY7KDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbNvcACgkQFHw5/5Y0
tywuxwwAraRwMLhMK+zA80kGKHCrfPdanFDjIVjfHM0oCe5CL/ArFQ1nzA4WWe4g
75KdPY9dfzpFwUQSCUYE03/EDRSslIe9vNXpxcKrwVF/mp91+Bwrclnj1xhg+poD
oyepfUtJjsfw4whHZM/Rz3YJ5KmJmY8wJ0F2A/NcLtcqNZnQ8Zf6BV4+WAcayng1
DUyEa7bJmM6FZburUVb6/kNoJ38MbrYFXkCfyI06JbvUiYjWKKCNnO8+ZExpK/Ch
K58iNMehCnDmgYyu96x3d6+kdKF+9GUzrwCnA8eNIg3U+refbbmQ9sNNHq+axoED
/ukIXOB69p6TCoz381255xQSH+WlSQJc7djGfJEDzqknHkEf2o04q6j8EHM/wuTh
tUAtlOpmI8Wi/OEqyLs0Jgg+TXu2FlePeWDB0cJJszYmp00p+elFtjaTVtec/FAn
6fRTYfyu3wWxgXCh5tIr2d1WHW/NxMyR3Qn25NRCb1YU6+wyIJmdqtfiM991aVXC
rsFksq+B
=JMzT
-----END PGP SIGNATURE-----

--50u2Ejbw9csY7KDC--
