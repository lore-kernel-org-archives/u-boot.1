Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E9FCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 18:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACB7836A3;
	Fri, 24 Oct 2025 20:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XJF1PLxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A5C83837; Fri, 24 Oct 2025 20:02:27 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F3E83678
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 20:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c278c25aefso2197461a34.1
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761328944; x=1761933744; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=erNSFKjnelB7llLR+6gN0MjdRlGwfbwvjKpt8y7Yfq8=;
 b=XJF1PLxHz51OX8lSSFPWk2SRojeCeTIsN5Pg+SSYeZJ7GwKoviqdgNYzz8YOnSnpsq
 GpA6SIA68CBDUE11qTzPPpz5h2eQLTiDtfJwQIJho+E+0V08Y+r5MyLIx8nNfzYbzIws
 Cren1QRZk3g2BCjpfL7ww7NGoZ2mjtDnuRBUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761328944; x=1761933744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erNSFKjnelB7llLR+6gN0MjdRlGwfbwvjKpt8y7Yfq8=;
 b=K5XbEC+lIOWwa8l6KZMuCzVZ9cxR42FLGtJPHHV896tXBcsV5PZbL9EqdgPa6szXeS
 aqHqtGydut9OgqJUKRd4xrXwErCtgu7qv/cEaoH/XxerAosYzga69o7EztkTZDbKBqK8
 SzZ037incQdxo46DpLkql4r3Awh22marCYwNN/iNbqi+cfGxLcmJOvjmyisHhzhP2KaA
 EzkAm+tTzNxrujFqOj6D3oUXmbQ372PKlbfB95lQysihMwS9NlM1b/IYmVwtDkpCnMxg
 1TGR0cblLeA/Ximx6HfPa36XMc7tTqdWaNw8jWYSojapKrkkF1eD+3bWcsO0242+P447
 kbew==
X-Gm-Message-State: AOJu0Yzp7xkJAjNMl/vFfAGSaLTlyXf0puZbGOCjQDuCQQYA16NYGoqN
 7K7OO+aZ58l12BQokEA/25JG6CqdxEhhGpo8xghN6LCDq2dxTZZgabkZUHZu7YTOr3I=
X-Gm-Gg: ASbGnctE7CiLGgcqNm5WXJacykE769DF8Tsu3+Rk3gCr7z2f1+OE2qq9Q9h/36pONdU
 Xc5/LSTrvUNhv/33C5JFCqcTfauy2IYO6AJOw0y+xCaRYAElrbFrw6bW/BiF7mRUyicjS6S3gWq
 E7wECHZouEjGUvF7A6inzMMdtdQJeBVHfDV0hx8/YqreoCq8ayySdW2Hh/FThREKLF+jeq0Qa2z
 fuidDv89H3Cz8a1r/TGmta1fDAFVyvf7csbksEJNECNx/zzJktQBx8F3aKSux045x7OhMoSsQ+c
 eTfx7R6RSQwp85kBAbZ/U/Ocwo5IJGIiebhEF4bS7M8JrFFU8GyNQ9xu8W0vAqysE0S6nYi6c8Q
 wZlHlmCOr/tgK4DRJErhCLljt6C2gFiemw+4nE04xSx20HJNDl5dWgiZ+COAI22lk20W5Qa76/5
 tekgRu6eBrnS/8IIRcBTvjS0AIEykveFCoaxOKF3c=
X-Google-Smtp-Source: AGHT+IFjKLL0pCN+MubD3D8yPkXO5GWC19AnEK3JtSj6YuQXcQBQBLJhNEnjf6AqU1UeErxAVNe0Mw==
X-Received: by 2002:a05:6830:6732:b0:7bf:6f5e:ea3 with SMTP id
 46e09a7af769-7c27ca2826amr18687468a34.10.1761328943687; 
 Fri, 24 Oct 2025 11:02:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c51b0598e2sm1736211a34.31.2025.10.24.11.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 11:02:22 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:02:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Beleswar Padhi <b-padhi@ti.com>,
 Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/8] Add support for TI AM6254atl SiP
Message-ID: <20251024180219.GS6688@bill-the-cat>
References: <20251024-62sip_support-v2-0-23d4948af70c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vUpIySyEjqXSXV/c"
Content-Disposition: inline
In-Reply-To: <20251024-62sip_support-v2-0-23d4948af70c@ti.com>
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


--vUpIySyEjqXSXV/c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 02:02:54PM +0530, Anshul Dalal wrote:

> Hi all,
>=20
> This patch series adds support for AM6254atl SiP (or AM62x SiP for
> short) to U-Boot.
>=20
> The OPN (Orderable Part Number) 'AM6254atl' expands as follows[1]:
>=20
> AM6254atl
>      ||||
>      |||+-- Feature Lookup (L indicates 512MiB of integrated LPDDR4)
>      ||+--- Device Speed Grade (T indicates 1.25GHz on A53 cores)
>      |+---- Silicon PG Revision (A indicates SR 1.0)
>      +----- Core configuration (4 indicates A53's in Quad core config)
>=20
> AM62x SiP provides the existing AM62x SoC with 512MiB of DDR
> integrated in a single packages. The first 4 patches in the series
> are cherry-picked from the devicetree-rebasing repository at
> 'v6.18-rc2-dts'.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes in v2:
> - Add a new-line at the end of env file
> - Update the dependencies and rebase to master
> - Remove bloblist addr from the A53 defconfig
> - Link to v1:
> https://lore.kernel.org/r/20251022-62sip_support-v1-0-eed08d15e76d@ti.com
>=20
> ---
> Anshul Dalal (7):
>       arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
>       arm64: dts: ti: Introduce base support for AM6254atl SiP
>       arm64: dts: ti: Add support for AM6254atl SiP SK

These are cherry-picks and should be separate and as-is, good.

>       arm: dts: add support for AM6254atl at R5 SPL
>       configs: add defconfigs for AM6254atl
>       board: am62x: add env file for AM6254atl
>       doc: add documentation for AM6254atl SiP

This should just be a commit that adds AM6254atl SiP support, not 4
commits.

> Beleswar Padhi (1):
>       arm64: dts: ti: k3-am6*-boards: Add label to reserved-memory node

And this being separate makes sense.

--=20
Tom

--vUpIySyEjqXSXV/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPu/KAAKCRAr4qD1Cr/k
CryTAP9qYXzsVxkzVYZ4BEoQqWPNQnczv6Hoepfge6qehLNx9gEAsUAUrpC7Z8wB
c+UYWM0zSfPAJ9qBP3ghgdXH93ZnJwo=
=8xq7
-----END PGP SIGNATURE-----

--vUpIySyEjqXSXV/c--
