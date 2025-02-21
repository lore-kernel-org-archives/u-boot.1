Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B12DC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AC5280F6F;
	Fri, 21 Feb 2025 18:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f69YFObh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCB380F7B; Fri, 21 Feb 2025 18:09:29 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95FE806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc291f7ddbso3925864a91.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740157765; x=1740762565; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I4G0vR96V1HEoJ3romBUQAT9ibFbS6OivCeWDfHnWq0=;
 b=f69YFObhpS/LcdXRGf/YV7P4DuKnKOCxT6Ah3Q7BtWqjqb+VTgieZW2cwjtk8j8twF
 rtGjZ7tPtFfOu9hrdAGg12aU4O/DSPqlqbVBXqVJMRI9M18es5VYF2m+9km+QlQx3TAc
 F4JxpYRz7n4zxM306EDQVQRiaY7Qqkgnhyt3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157765; x=1740762565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4G0vR96V1HEoJ3romBUQAT9ibFbS6OivCeWDfHnWq0=;
 b=klbZfdFASFI9dBRaJporpCL/9+kfa1BH9Dtu8yGHwf+yGgGzLXUttVK37PFsmn0BuT
 CPshnbyM5W5kjIAcs5RGS6D0gQ2JanzXBam90mDvxo3xcssu+0i6qL4thuhnZJjTYaaf
 zPnK6KZdzNWhWNUxwYw78DgpsZ48R457XpK7HtjbC/colFf+0I6dZwHV5It4HzkR9ach
 If3YssLdXYQgYjfKc4EANdwCuku0VFfQ70pzuwmI1GQe/ntO+D1y6cdTYO/0leBlHo0U
 hQiWzStwaf07RypgOAz1Dj//FTizlvaSl/ArvEwlGffjMY5Q6aWQ/a8b0oGft2zWIMnN
 Umrg==
X-Gm-Message-State: AOJu0YwFD0tsuSNbKdp4/2NpoMHpatByp3eA1vJsMKy1B0UpvSxGvyeb
 MRmpMVDYO8+M/Kgx7hrtS1Lp3mEEdH3TlBPVrwdXXp9sRhLfwa0+IeJRnAOaIuw=
X-Gm-Gg: ASbGncuqy4ucLTJNKpCbE3QOabg96jG6CloujwpRytO2Pq5AgePt/Fmzb77k2tylmbJ
 PXGRMfdtt24T8OnG/fvwBysjxqyfCWU07KqZbJaWVnI50/Ko+sV6jD7YlYCkaZGqwyN//yhr8ze
 2zxkjNZbhkvUTXany1nDUtfUfWXSwdKdlg5zw8uv4goYhvcI3yHudxpwNegwnq/W15HXTSIjg9I
 8d6/thiX1es8cgJgJ4M7Qism1hEBIgcDIBSOnSsa3kwXXzLvWTnsf9lJPNerFYTpL4HkjuPNAez
 wX0pqt6MZLX1VSo9ZAUhpFDK
X-Google-Smtp-Source: AGHT+IFW/1BacrLEAUU6fmhwZGX3MRCZgvxwiStuRURvRIYWrrS6Yq5+t3Xp8Pah692ertcL0noB1Q==
X-Received: by 2002:a17:90b:2710:b0:2ea:356f:51b4 with SMTP id
 98e67ed59e1d1-2fce78ad72fmr6437110a91.13.1740157765474; 
 Fri, 21 Feb 2025 09:09:25 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb0a6902sm1639746a91.48.2025.02.21.09.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:09:24 -0800 (PST)
Date: Fri, 21 Feb 2025 11:09:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] ARM: imx: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD update on
 Data Modul i.MX8M Mini eDM SBC
Message-ID: <20250221170922.GL1233568@bill-the-cat>
References: <20250221170738.184822-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ww7mbE9gkr3MxCzj"
Content-Disposition: inline
In-Reply-To: <20250221170738.184822-1-marex@denx.de>
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


--ww7mbE9gkr3MxCzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 06:07:16PM +0100, Marek Vasut wrote:

> The environment is missing quotes for string variable, add them.
>=20
> Fixes: 940135eea5df ("Kconfig: Move CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfi=
g")
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ww7mbE9gkr3MxCzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme4szcACgkQFHw5/5Y0
tyzG7gwAjaPHaw5uEGpuIX67JfH16pmlMmh/bsAi+lgN8dLpa0501N37gukXPI17
h7XRmJSFIG8o+6U1OQGtILxO1A2W6NY6uUD9PEFicEJOB2k0nwyroeH8MvfFO0Rl
2A/2bdo/H1bRAxQVRtl3ppMCLdwpF6ruXX2jL8vGy2H1Ge++aEp7ICglIdP+gqNY
eO4f8SKtGFLt32p5xrZpER1sRs17CKtMyt9GE311acJP2Og8SbcI1xU605Tb6RKS
NgCLuwPxt1nvOBFYN1y5xay0n2yynDCyXfDaj/lWzOap8rLM34Xhe7mdd9nCfhKo
jesL4HEAccZPCK3PaTW701C12K0CcgbImgivxeYLRvD9vErhWO2IxYv60IghmSfk
BS5bBdZfnDOtUN9UKu7AVr8ThimaTJy81azkpFrwwYdlODtRmJAIYER1Te7TIc1D
Kzo2ZOuHCdt9jLxjs0RTbe+X8AIv797oy7lMfGOfD6qEama0Ahg7+NMcu0o9UMcU
y1k0I1Bo
=eK4J
-----END PGP SIGNATURE-----

--ww7mbE9gkr3MxCzj--
