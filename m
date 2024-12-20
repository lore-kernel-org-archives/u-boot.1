Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EA4E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 15:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6088021A;
	Fri, 20 Dec 2024 16:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jogzk+Gj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732BB80326; Fri, 20 Dec 2024 16:42:35 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70AB480087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 16:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4678664e22fso17653781cf.2
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 07:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734709351; x=1735314151; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zx7McboDtMXgTcF8zXjS9qEeVCyTFRzxcnXA4gluV7I=;
 b=jogzk+GjP6/dpn4xgJ14xAGLIG9KUSqQaFxDf9hcIP7kzUh+JxqVp5lT/RypqNqzKc
 5xDANOv1lDPDbYdF1KZ4iyTbY7gHJVNczVWCPbsLqw1BT617up+iTyqZ/2Vz4HearAPt
 7zWp3hby9mkYfxEqjnP95q/MDOhjc5Tk8cjZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734709351; x=1735314151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zx7McboDtMXgTcF8zXjS9qEeVCyTFRzxcnXA4gluV7I=;
 b=E0Fj66xF0e9o0ZEZcpZiWJhYzNaGNRJFpbwB/VrO/eJ9bwRzfzF133ChhCJnu3icZC
 1y6dBowdYgRXnnP6qh48zX/5EhSwbyF4g3c8tRPOY1u/AkzoWfzLSvGuuCdBeHmR38bc
 rOYN6Av3Vch0oYLSF+YJPYlRiUDETrP2sWApjR8lVKaAxsVymwZ+Hh16oE+++qeXrLEu
 t+b4rIQPAR/t9sjVT09dZOtcMoYnOf9Bd739zJcteDnNZRPrhB7bgPkTh2jTa4fUFRtE
 FEAZPxv1CSP4T+mN6mG3UJujNWaqKB5axmuHNihcTZJvXq0j/frbaV2NX/WDM1S5OE36
 3agg==
X-Gm-Message-State: AOJu0YwMIK/DXzbzgKV2fkdnl8fa79UtVQcPGynlR8WO/yjVoWYDYujA
 0+OuJMfTIJRptXtSyXs+s5OM50mmdoTbJTFlzjOyZGQQf15KQqzkZkWMhCCBQGbY45+2j/NSnas
 iFe8=
X-Gm-Gg: ASbGnculspnEpPKzTke+Ya3EaAfbdKlEnoL5e0775mlyrhep2oUj2Oeza+WgDCBaEbT
 mqMjOtyCMq5/IaR+vNC3/wp8iEPAEOlEOJDufnXLL8zp/BARglSNfUJU2MavygjVhNjAzXwcrjT
 Mik/suxh1+3EAl6rGAq2dbCyu3Gvvo1iGQ8vxbF8OxkIoq4CR2Lt08SrYJtkd1uFb0eg2pRjpiq
 cOqwZ/llp5LqI/nvqwndvQw0EO/3QIx1V0vaN/m7i47cvL4fGZnUO7B
X-Google-Smtp-Source: AGHT+IGEgwnHCFwXZQZwOGpommsDJxAcVcu+OdvMzFz8ZiTydUEjL6dxkrI1DA1L672eIiUREEKz1g==
X-Received: by 2002:a05:622a:14c:b0:466:8616:2553 with SMTP id
 d75a77b69052e-46a4a9a3503mr55928891cf.48.1734709351315; 
 Fri, 20 Dec 2024 07:42:31 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb2c81dsm17714981cf.84.2024.12.20.07.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 07:42:30 -0800 (PST)
Date: Fri, 20 Dec 2024 09:42:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2025.01-rc5 - v2
Message-ID: <20241220154228.GE1505244@bill-the-cat>
References: <4aa0c9ef-d582-44f6-9309-3c3c0c532a56@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D4hNF0a/AhOoNPDf"
Content-Disposition: inline
In-Reply-To: <4aa0c9ef-d582-44f6-9309-3c3c0c532a56@monstr.eu>
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


--D4hNF0a/AhOoNPDf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 12:43:52PM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> I would like to get this patch to 2025.01-rc5. The change is quite minimal
> but enable HW designs with memory mapped above 4GB which is quite useful
>=20
> Thanks,
> Michal
>=20
>=20
> The following changes since commit c06705a9a13d58e799b98927c360e93954b628=
60:
>=20
>   Makefile: Match the full path to ccache for filtering (2024-12-19 12:18=
:57 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2025.01-rc5-v2
>=20
> for you to fetch changes up to 1b70b6c9cc98290fbd46da09c9f5a95f45121148:
>=20
>   common: memtop: Fix the return type for find_ram_top (2024-12-20 09:17:=
43 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--D4hNF0a/AhOoNPDf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdlkF0ACgkQFHw5/5Y0
tyx0AQv7BFl8WlQK4fQmmx6DSSW1k3749Sx/BnuL01rqpZ8XjGLEZRIWYX+cXtPf
SiTC+QRpyuvAMy7KXTYjPGkd8HRoYUQHlPtQTD11SmF726kDXGAHOr6dajIhaweR
xn4xrXjNBDt7ikhM3zdcMdQYGoSUCOl7oYfYAt5jBmcFMj7G/F/6IzN7MjC+/zkM
rC1wEU3P8/CUnDUOvLBuuIIMkALxf4SE8jUSF4hbmt0zI4nFCP1wUrhIRVsymiPW
2zGbCajaeLahiswSuN8maOmf68uLUlHKn5zh6EKqpMXdoZnoInP8lsJSGsXBaaaj
6MiAl5DH3/wNJim9rurHYCNUzHbJKoxsKAWNcZ6JcpKT3n9S0tsbB/cbL/wLjbOh
AdkFP7utJYeyllnqs/T1p2Zd6TWRS3O3azXmF9OzaLvQs1MmsmQO86wrI3WjN/Z4
NGaTOJUBkaaS3pdw82c9AWRA6aTP2QlGfKmJHdl401ZA3ghvfVm6US16oNTUJgPy
AlDN4rFr
=+HI2
-----END PGP SIGNATURE-----

--D4hNF0a/AhOoNPDf--
