Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0709DCF11F5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 13:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 847E188995;
	Thu, 10 Oct 2024 15:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bk9fJRR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 456D088997; Thu, 10 Oct 2024 15:54:18 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D410F88770
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 15:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6e214c3d045so8231777b3.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728568454; x=1729173254; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VnTBQjXMJYeenJZMvO/e1ZSzg0YqneNpu+AQHdS2Mik=;
 b=bk9fJRR6R78dywsGvT3s7FH18Sba2oxjS7r5sQPheYYzuy/AtLP8QQ2xkbRsqCcD7U
 2BFDuAIJFV2vGUMzmCw1fK9jQLzwP9J4G/jKaRo4VE2gqARXXbfi3VjD/1N7yHaNERM2
 ivw7tTU4d7C1PhQMuVCN7rGhcBV+gc4NyVhgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728568454; x=1729173254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnTBQjXMJYeenJZMvO/e1ZSzg0YqneNpu+AQHdS2Mik=;
 b=PxmpchWCEAdNxPLateAmmQUW/7vFFkitP4WSvROwC2KCk7s2nVTb590yA9ZWLm+iUZ
 Ghyr0/P6+/zHWNNDSgrHZPJPSrKvjAcfx3poUsytncqxDFd/Qb9iFSN8Z32lCkg/mHO2
 1YpNDzGuSq7o2r+ho6ZqyDFbZhcQk4/vYmA103SBvLQ6YOxLRxxaP8zXmy0LlfrdVag5
 HZNND1FnTReJodjFjOZR7QSX8xaLjKxOSZDrfYk+5l/iIPYPrjGpJj9llwFjoK98dg3w
 TLdpmiGrh8MF1zrbYhOB2B07DFOU1YhWi9wzOLQb9Gth9VebHvffoq5nhYg4I/KlnLZY
 Gsqw==
X-Gm-Message-State: AOJu0YwWJr0W44ImDLE/PCz9fw3SLdtSYaUDoDmjdnCdap6gRFixySE6
 krThdbOFr0HSCfcYs5/36vQJAhE7HZIuXjIioCkloiYUGQl3rqHZQv/qBb0drP4=
X-Google-Smtp-Source: AGHT+IFiBYvUEjQ+eW7v5ERMhYqLu6b2dtJsb98+eVxe8QS2LxP7YSs1XBDT6N2YY7D5C2HidVGHcQ==
X-Received: by 2002:a05:690c:f85:b0:6e2:ada7:ab3e with SMTP id
 00721157ae682-6e32217aec7mr62907367b3.30.1728568454579; 
 Thu, 10 Oct 2024 06:54:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8679d3csm5471366d6.137.2024.10.10.06.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 06:54:14 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:54:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: Pull request efi-2025-01-rc1
Message-ID: <20241010135411.GO14210@bill-the-cat>
References: <fbb5acff-f3b3-4c3d-8d96-bc95bfe470a8@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LZ9okY9ZEZTOOcFU"
Content-Disposition: inline
In-Reply-To: <fbb5acff-f3b3-4c3d-8d96-bc95bfe470a8@canonical.com>
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


--LZ9okY9ZEZTOOcFU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 11:40:38PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit fbe16bc28014dc1ed957f5fee7e53d6eee781a=
a9:
>=20
>   arch: arm: dts: k3-j7200-r5-evm: Enable AVS feature (2024-10-08 10:23:36
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-01-rc1
>=20
> for you to fetch changes up to be5e7c11ff7df70b7c2adfdfd114ae25573996c8:
>=20
>   sandbox: enable clk command on the sandbox (2024-10-09 15:48:42 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22597
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--LZ9okY9ZEZTOOcFU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcH3HUACgkQFHw5/5Y0
tywh7wwAp1zEOh0VES469sNOUs45p/e8+C3ciqVqCxDhJFnsbCadqtn4uMXufETk
Nk9DFHWrw/72I85hdx7PcRR5/x4O1Wtb+3wiyd3Xi9e3bIvvMnwR+J/YveHy3CxZ
WNoiUtA1laA9UEKlroYNb0KApX8Pdz+789eC0MgRW9iP86qTQYpDMTu+vJUaS6HR
B3sSKHw72DGFRWv6qJbCO596JaKr8F+IIb1hg5Y4e67Q603PkAgkW3FL0Q8X26Q8
AEo/1yXs/0Y/asQM1rrZjjaHKUrQShYpHGMphJQSGCoRC6b0j/TXYreZph2rxw5j
XKX6LRbbisYh+EM0rlPpITeaRu+89y3OebCTD+JYJy5ibG7nV3myJ37grBm9dxGW
+SCY2lR3XLLvZe4YtkoaX2Nw7OjmbXailQGR33u2HWuZy+Y5+YtEPMA6faFaYXUS
yRT+mql2miMdeYL0FrodoYCIfKZe3NLqJ+2HoG6P9UcfCgBtc9/BQMpyLXRr4H5g
kEvcpUFz
=EaQS
-----END PGP SIGNATURE-----

--LZ9okY9ZEZTOOcFU--
