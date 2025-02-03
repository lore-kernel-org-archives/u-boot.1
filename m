Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B75C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3B180137;
	Mon,  3 Feb 2025 21:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JWafO/j7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C1F801BE; Mon,  3 Feb 2025 21:08:12 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD9F801C3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7be49f6b331so456308085a.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613287; x=1739218087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UBo0ZdFu0Mcv+qVWj7FRW0TXExM0+reDRZBLTXsG4Aw=;
 b=JWafO/j7f1pT7rqFf8lUYqTmI6rEpvnBTOGQOZrCpsXb2+ce3w6E97NuPQZBZizPFh
 LxSEHcJ8YkEb4slNzJ9GSOjyJaW3AIf/DWDz+fvCFBhFxBgLYSWiVBPmwK+gBN/dHSES
 +RMCOHPA/Xt/1Y6YgGZmtv1VHCWTRN80mK1O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613287; x=1739218087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBo0ZdFu0Mcv+qVWj7FRW0TXExM0+reDRZBLTXsG4Aw=;
 b=l/MQgNBuCEGJN8BNs3bAffR8WGMhERKX8Utm1ILwFXPSZ9l4IR++d+xF++XAvhM5zP
 +OjezvdkvDAyQ9HvuWCEIAvVcH/oa8ISzteje7Gmkuf8D3zFFMWyLZZ5T1vFJDxK2FlD
 ZRvYMk/fo8dEjfaAeoIFKKCLsYyudBUQFtTS9KGTVRdphGzoQ6ZMpoS2CpE7Wltmq6RW
 T7DomNdguxKlhxHe+Hah7YVMmWdy0OoqULu5nfksJ0RuygrC5BLDZnHQIqUeJKCcCWN9
 p5vyKTdX2fQHt9fH1wo6ZGbS06+G9tc5i5xKpNsOvng8dhLBVpEUjLoIxJ9yKIuyAlvD
 N1Og==
X-Gm-Message-State: AOJu0YygY7HZPnFnwvip882fCw6Pvq3G9DLNaq56OYagfySDdJABdqSi
 5nOnts8E9na84UTzkFMSh8jkqb4esn9Fz7Y0+V7WdjdpdmCUkznjrArPOk8YeEM=
X-Gm-Gg: ASbGncsol+mLEbo93BnslEOQnWnPTdaMIVUAioytwo3yQpp/FGQjibRtQlJzQ4rCioe
 Q1pKd31BNpdrzc0KKD2uox9ucIF2cv4Zfpb0ZO0MDapfvquMQ9xfVoqM1hw7dvz4y1EAmZp7soE
 vpF5MF/0yYt2njAuUVoYck1MTOPwtPxh5M3LNUp/h1/wGnAQO+iIncOBqrg9J4L0Lv351hTd8rk
 unEUmzgnSBWpF33lWxjwpyWpvFLAu2xMQaqno1AeAIIo9pAInNY/flZ6RNwcFEsXSwsr3sYMbNW
 g2hn9gWN+IiqQGY=
X-Google-Smtp-Source: AGHT+IG/5+vbBiJKkZzbJ8+12nvaj7BbtMhxaUQ0hlTSx1OGYvdqZOrev6kgNV6/76U9EAzRM15d9A==
X-Received: by 2002:a05:620a:404d:b0:7b6:d4b9:b5a7 with SMTP id
 af79cd13be357-7bffccc5d1bmr3734437385a.6.1738613286598; 
 Mon, 03 Feb 2025 12:08:06 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf18a602sm52017731cf.79.2025.02.03.12.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:08:05 -0800 (PST)
Date: Mon, 3 Feb 2025 14:08:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Anton Bambura <jenneron@protonmail.com>, Heiko Schocher <hs@denx.de>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 03/32] video: Move vesa_setup_video_priv() into its own
 file
Message-ID: <20250203200802.GB1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6R+5xWBvk24ORIAL"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-4-sjg@chromium.org>
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


--6R+5xWBvk24ORIAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:41:56AM -0700, Simon Glass wrote:
> This helper is used by the EFI driver and we would like to use that on
> ARM. Move the helper function into its own file, separate from PCI ROMs,
> which are an x86 thing.
>=20
> Add a forward declaration for struct udevice so that the header can be
> included directly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> diff --git a/drivers/video/vesa_helper.c b/drivers/video/vesa_helper.c
> new file mode 100644
> index 00000000000..dde8797e765
> --- /dev/null
> +++ b/drivers/video/vesa_helper.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025, Simon Glass <simon.glass@canonical.com>
> + */
> +

If we have to add copyright and not just license information here, you
need to copy what's in drivers/pci/pci_rom.c where yes, you added that
function in 2016, and it's based on coreboot at the time.

--=20
Tom

--6R+5xWBvk24ORIAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIiIACgkQFHw5/5Y0
tyxnEAv/YRsTdyAakM2em4q/Cs+4tBXPbdf/kL4bHZBtOIpOp63nqP3vAX8qcr6P
FM9mUnP/Cc9t4ko3OLz3KOlZ6tGOaX6a5aS8q1ZcNk+HvpgI40VQrP3wyhatPt0y
oxQOUFTR+qe1B//2vEN2TwAy5fH7KH9/IQk8wgHzU1YvcryC601uJHOzPhoEGfBf
gPXMK6076zUfbcd2yL0lMRMDZyW7EJQYyk1MZwNs2g1cHyZVddjzGPIM5rtbLsX0
RgC3D2BLeW6qbGxIpCkbbGR1A+JsBOvBMNu8mmUmFTpwS5val8Ef0U40BRCJ21UQ
zQs2eXNb5IaSYO3k08tkB9zLyE38WtLE+0+teVGz87P0VB7s5sFDzQs3j5kh0/6M
WlXKFll6dyC1g+CZuvCkDhb6CrMXfjsCXZbxVhfMYk4XfxVrEXzUInGG9ViV+zwZ
xqr6mzVqrZHR+XAz3egkeEucSXzYGlRfQaQWUGpqLA3IioYVyjhRDyMKDUYsSCtI
y7DESE/P
=F8t1
-----END PGP SIGNATURE-----

--6R+5xWBvk24ORIAL--
