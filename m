Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B20FCD5BD4
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8431186AC6;
	Tue, 19 Sep 2023 17:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LT7/sYlj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 768B886A82; Tue, 19 Sep 2023 17:14:41 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D6C86A33
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59c2ca01f27so34101967b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695136477; x=1695741277; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2pzPyvQkbOjzAbHydDue4idkADx2HKJsRtrbLEoVTcw=;
 b=LT7/sYljOKfh8Q7fb1ibYlcJnjeeMb1J9EODthvMPgh3lSX8ZHyZc9yEiM+juq0Rt4
 QAKTSFK7DHD+cWy3rEEoRN/XIIT8oNt/XfK0zHYDEBV5z8fYF/GWEVedMsQ6taJkzsmp
 WxMCADjXTw34UomzVu3+N/r6ZsRuWb8fZAeA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136477; x=1695741277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pzPyvQkbOjzAbHydDue4idkADx2HKJsRtrbLEoVTcw=;
 b=ebsTZPb4yK//PQOsK2mBAduIdb9IaHIJ9bY2rM6VxNZXjMos4Zly+OXy/frGqhvei6
 F+rtYxLuTuiOvO8AeuhNp2bbi4HvJH6sN7mj/GkGeBvIAxErFUHYehZ4GNC6MirDxVTS
 4AxwWL5lMi2DhZYfWCa12lD3v5dAk/wnlhNbtUQnyjNsx5oYtCUv5OL7W5aj1GKsxaJj
 cDZqOeZNfgF13UmzsPHh7QEyr0gN9WhAeUPGP/0rq8Rk0Xl4ZJxTZda7/M7/Gfx7NvUj
 mzAIDPgF/dtR9S6mWl5arExL7QN09dbDfq1oi3JG/jiX83xVE52vxnkymq1ryui4oLTd
 bdmQ==
X-Gm-Message-State: AOJu0YwK1Jj3muv/PlAIMWDozz4IItbHLXx8ABQNqwo0VZrI6rk8zJ/+
 zZab7s3CNZjdYx2fIG8cpYtLAA==
X-Google-Smtp-Source: AGHT+IFSl2L2kUsQthgjUMoM2EfYpSo60eb24OvyPjaMwjgOOQgtqggQtJJf+H0/42ANAQ8lN4axBQ==
X-Received: by 2002:a0d:da85:0:b0:595:320d:c9e2 with SMTP id
 c127-20020a0dda85000000b00595320dc9e2mr13693065ywe.24.1695136476682; 
 Tue, 19 Sep 2023 08:14:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-715d-a992-91e3-9182.res6.spectrum.com.
 [2603:6081:7b00:6400:715d:a992:91e3:9182])
 by smtp.gmail.com with ESMTPSA id
 w65-20020a0dd444000000b0058c55d40765sm3202050ywd.106.2023.09.19.08.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:14:35 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:14:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Reid Tonking <reidt@ti.com>
Cc: u-boot@lists.denx.de, nm@ti.com, u-kumar1@ti.com, vigneshr@ti.com,
 m-chawdhry@ti.com, Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH] drivers: misc: k3_avs: Add Linux compatibles to maintain
 sync
Message-ID: <20230919151434.GH305624@bill-the-cat>
References: <20230907180635.89011-1-reidt@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4vHnNC5CE7fi+ZWL"
Content-Disposition: inline
In-Reply-To: <20230907180635.89011-1-reidt@ti.com>
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


--4vHnNC5CE7fi+ZWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 01:06:35PM -0500, Reid Tonking wrote:

> The ti,j7200-vtm and ti,j721e-vtm compatibles are used for voltage
> and thermal monitoring (VTM) by (drivers/thermal/k3_j72xx_bandgap.c)
> in Linux, but the same hardware is used for adaptive voltage scaling
> (AVS) in u-boot, This brings both drivers in line with the same
> compatibles.
>=20
> Since the j7200 uses the config as the j721e, the data is inherited
> from j721e vs creating a duplicate
>=20
> Signed-off-by: Neha Francis <n-francis@ti.com>
> Signed-off-by: Reid Tonking <reidt@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--4vHnNC5CE7fi+ZWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUJutkACgkQFHw5/5Y0
tywnoAwAmg9NVY1Xm4zJeYFQo6qbQ81h5RAbPHo5NcH3jdnWh77l96PIXFFX4ApR
28+2SulX3E0eWLzpAbwCtMgnOUcdacmCTg8L3g4kU2oCqu2/Ui5eZBnA1F2nQapl
snKvyST6ljfS+2M6g+eDFnrqi9RV/j1ftNlSom36Ut5R4AM8GY91cDzvsY521WrK
H0Qm3OgEh3v0RstsFEk4df4V0F5/YI+/UazUu2nsECuuJDKdmJAr+fWNkKCEq6LA
nLfOS7NPm+b+e+AVu2zF418T3Dl0WqcHHOnOLLbsu4fq/ZDQbJ07akw4LaYxhPF6
RFDfyQvZhcpQjQY93hnMCAD8mF0EV4/NoL90Ypaj5SznW9baISVCGVJpA1tLRsyb
bYqC4q6CpMMWB5DRQJuG+aOMQXmRSGF1QxYNDYoA+ATwnWLp6IkJFIRDYdz0SFxD
S/7xhB2OWwsEEUYbN2dDNvBLbWYsW361qwRDwrPFdjJU0iEG9C4GAkEHjYt32S5U
dOFZBrp8
=kWa9
-----END PGP SIGNATURE-----

--4vHnNC5CE7fi+ZWL--
