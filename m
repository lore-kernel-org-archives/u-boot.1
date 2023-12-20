Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50EDC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 13:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC1587509;
	Wed, 20 Dec 2023 14:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="flrZo2/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA97876D5; Wed, 20 Dec 2023 14:14:26 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AD44874B1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 14:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5e7d306ee27so14274337b3.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703078063; x=1703682863; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UIAk7S3Ofw1fVwSd7loRrora3zGhXQPhGL7t0sXHoQ8=;
 b=flrZo2/Iod565ncUwotvw0zvg8I1MWOxHxhL3hoUiVw/k3HwcFZ7AtQavZCuDA6wUm
 w29yDxGUqWdigrVkxqBTL4IWWgBc9G9xxBoKjzuTfnND17woC3F0lBUaaX5bJnaPkTOq
 RhkCHGPC4Q+oIzc9suipGBjEmRl3VeZpscGsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703078063; x=1703682863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIAk7S3Ofw1fVwSd7loRrora3zGhXQPhGL7t0sXHoQ8=;
 b=oZoBZZSCjU3u0TmxsmWjR+vsVWfkZYX13N4SZB+81dUSwquT5PiN/39ty8u37An/y/
 N5GdRacEC/w0Did6Cgu4mubuODNflnNc9M/FWXifOszlm3UI/WsFWIeOoT6IpwQwNPQc
 eKrl5st8ZQjMsVb9KTUie5nw6cmY97RwG8UPF8yJPQNGpzxQYi49pItH2o8FCiY6NZCq
 Zm59F/msKO1BAfh54gPM/ra+Fa/0aRWbIpZIw8I+hA6/cfD2hE3/ork2u2WcPPjKTr/Q
 EDE1C4qsOKKYwTDgklEcgpgl77WwejLX301PwcVEKhzi0zi9vHpw3d6gdoywJSAYHFCr
 6JvQ==
X-Gm-Message-State: AOJu0YyvY1nV3jgKB0LidjIycpR7xm/TNzj1zILD9TX5J/J55edoBP8o
 oKpmzWf1WgJsz77ZNZd0n+Q3ZQ==
X-Google-Smtp-Source: AGHT+IGylPkpHnGHmwqmOKn5u4kuEZbs5fjro9p6f4awPUr/Xoxim1oA6M/TrBzfX4oSd++do40DLQ==
X-Received: by 2002:a0d:eb10:0:b0:5e7:d248:6b86 with SMTP id
 u16-20020a0deb10000000b005e7d2486b86mr1763720ywe.19.1703078062911; 
 Wed, 20 Dec 2023 05:14:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a0df504000000b005d746ac7f6bsm10502555ywf.69.2023.12.20.05.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 05:14:21 -0800 (PST)
Date: Wed, 20 Dec 2023 08:14:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-tegra staging
Message-ID: <20231220131420.GI2513409@bill-the-cat>
References: <20231219201353.433090-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jOqp/V5c7m5Pl+BI"
Content-Disposition: inline
In-Reply-To: <20231219201353.433090-1-clamor95@gmail.com>
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


--jOqp/V5c7m5Pl+BI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:13:53PM +0200, Svyatoslav Ryhel wrote:

> Dear Tom,
>=20
> The following changes since commit 936d0f9dd713a913fe952eae576c893e1d5ecb=
d1:
>=20
>   Merge patch series "Fix J7200 kernel boot when using upstream u-boot" (=
2023-12-19 11:42:03 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
>=20
> for you to fetch changes up to 4989628c1d2b6ea19a38aae34b1c08b12141c64b:
>=20
>   board: compal: paz00: clean up the board (2023-12-19 21:24:30 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--jOqp/V5c7m5Pl+BI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWC6KIACgkQFHw5/5Y0
tywiEgwAhVfgZweFsFmXrViocn3hG3nocX7Hi4kwSt/385wO1BN5XF4F1qMXiSST
9K0EA7UN6AbfdL56jzsR+vgP4bRxCvPkKgygc9tG5SEu06DGQymPoZJP+y+V+Viu
J3x0GLi4EsKfWn9pu9TJz5qRYxcPGCV8dt7H4TFrBTizSxkGieEXMGVwSvsuGaWC
20KAoYNRKiaO35H7ImMoGmH4BlzFAXE8YBwLhNylkPZDfHXhVTmnBBnklFXWfth4
TOAEg1WCFQqSHYtXLIVdPW1Ba/B/11H7qo48v3QrzNAhbcyvOpBwQLIQnQJkx29v
0b6l5h0/I1vAdi5S6mZ1r/qlpOWKY2nzvexZSWeSBb3KKhtFtaKhhHMmHMJk+E4X
iqNbx6Kzvkz5ygR893tlqb1ihXjl/M2Mw8riDWLJZCaiIsvcv3O+SXQgsqGfcvpe
qrbDK/u9CaydF/dBLeA5fs0GS9Hs8YPjlHMR9IpqVGKUvt7NpLhHbB3R7+nVGESs
0ag0+qly
=I6F4
-----END PGP SIGNATURE-----

--jOqp/V5c7m5Pl+BI--
