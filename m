Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7BDC47DA2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 16:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035B6874D5;
	Tue, 16 Jan 2024 17:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QUXji2jX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC888786C; Tue, 16 Jan 2024 17:49:07 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAC5B87078
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5f8cf76ef5bso89131217b3.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705423743; x=1706028543; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NpMW47TV5HMcwX3eqK9meqaLjJvRbxr0Qy5ACLTKnMk=;
 b=QUXji2jXi3mJZD+s4KlNr1GTWPRaPgj/aO6l5OA2jtwcPU0C2qvjzgVeLNScezMEmD
 QosDJKUKgzgUIDznMahzHE2mZS3qkBYiACHf41A3mz02FdVpGWDbYX04k23tWH2NCaD3
 oaKYg2heG9RuPslPoJv65eetfHwnyy49B0hVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705423743; x=1706028543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpMW47TV5HMcwX3eqK9meqaLjJvRbxr0Qy5ACLTKnMk=;
 b=BP0wyplbHv5ZhHHruk8etP1U9IItNIeh6hvhZJ3lXqACiKEwVgwaVA06aL4pgGtVnF
 YVO9eMUS9n3muj+uURspFuXiMd0C5tmXIlKuWzfIUkkaQ+utma1/B+sdedpXEab+xcgj
 rvelKj9XN6SlVVmQMd+VWoSQdgeDcs+Sd5L3hONVklKJH5G+M0Nbv4q3AyjvFRlMQb9p
 SURtRYMgBeKe31Q2SR+m75e8dY8F3r3DAAt48eN7Wl5s63dFjZ9F2pOJOT90qD/J5yGN
 GcHFoDl6GyBhC0AVW/3OllxO1otdCR+Vu8Xs97rJphB42uyxhqbWg9o5ZFnHbYfqHEDA
 myrw==
X-Gm-Message-State: AOJu0YyToULTUocP8QzQfSH+S20nepyJuds3AwowNda9nD+oLdh2twvm
 sY4fP+g7dwhBRPR7eHMKT5yhgT+hMOxmHRg2J4gyVv6xxYM=
X-Google-Smtp-Source: AGHT+IGXUZjP82XDoiPheLb4rjn9HVp98igeQAcTqcYK/Q/4i0NTndD6SBdK3NQ36GMHc4ieFUEEMQ==
X-Received: by 2002:a0d:db56:0:b0:5ff:4f04:f868 with SMTP id
 d83-20020a0ddb56000000b005ff4f04f868mr1564755ywe.67.1705423743527; 
 Tue, 16 Jan 2024 08:49:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 fr3-20020a05690c358300b005ff4c76ceb3sm791151ywb.145.2024.01.16.08.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 08:49:02 -0800 (PST)
Date: Tue, 16 Jan 2024 11:49:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Roger Quadros <rogerq@kernel.org>, U-Boot-Denx <u-boot@lists.denx.de>
Subject: Re: [PULL] Pull request for u-boot-nand-20240115
Message-ID: <20240116164900.GD12635@bill-the-cat>
References: <CABGWkvo7ERgbNViKy=mYAyiHkemULT-8qXWQr3yprzQnL7cDYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BCaofcFzdiUrFbht"
Content-Disposition: inline
In-Reply-To: <CABGWkvo7ERgbNViKy=mYAyiHkemULT-8qXWQr3yprzQnL7cDYg@mail.gmail.com>
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


--BCaofcFzdiUrFbht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 11:48:12AM +0100, Dario Binacchi wrote:

> Hello Tom,
>=20
> The following changes since commit 697758e7c81131da6db0e3b10515019fe3aca8=
c9:
>=20
>   Merge branch 'master-sync-dts-663' of
> https://source.denx.de/u-boot/custodians/u-boot-sh (2024-01-14
> 18:07:49 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/u-boot.git u-boot-nand-20240115

For next time, you passed a wrong parameter to request-pull I think,
this should be
https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git

> for you to fetch changes up to 4dfa08af79097d068d6657a4c77e7d474733b796:
>=20
>   arm: mach-k3: am642: Define NAND boot device (2024-01-15 08:58:24 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/19=
322
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--BCaofcFzdiUrFbht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWms3kACgkQFHw5/5Y0
tyxWcQv7Bd5Q2VbgaC6QHNMl88vl03b5ny2inee1PW8kwyskiVjx5oB0nVdW47bd
x5NhduDYN8tStH3XOjj58MAWiN9+w7zzr5IbIMP9wpTRk7enhHFEbuA/nTuEpMCe
SVWks4kXNilpRdOrS1jzaot6gRrZefchRl72a6x40CwTltlWECH3efa7wHPjRKsR
Xv4gSdf5pkjsX9D5dR2hh/RNekJ9KLE1J2e8G/4y1T8Kjpx0wgcwZDmDItYAIj8M
G728SZ4s4DIYZrVRcmMC+6+peioYg66LUIX26AGqG/O+ARy0NnMwQRp93eKtifNI
SvxB4Q6v1naTCK58I7z6xXSik8x0huZ8/wqYvzpN6ElMl01swZBpykTJRUOS6amp
S5HWJ0xzhIFVDgQYEMf6Z471wvXu1atN2H+qm2Sb+k9vcbMh5swb9clIL3OSGLQL
f4KtQ4ikdT/OIKFQo4NWHaWpUo5O9pIG+9T1AkhhppyINfYbsKaqEMOimxuMl/Xx
rxO9YWWq
=wu2L
-----END PGP SIGNATURE-----

--BCaofcFzdiUrFbht--
