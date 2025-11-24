Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9943BCFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 14:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB81A83BEF;
	Mon, 24 Nov 2025 15:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HOSC74hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3CF783DB6; Mon, 24 Nov 2025 15:17:42 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD6B83B85
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3d70c5bb455so1516971fac.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763993854; x=1764598654; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KiNlO20V4+gME7/XbAIjF14uc4vNplKHiuTe57VT+l4=;
 b=HOSC74hnjnj37cv4/U0p6MeA2rhisFfRsameNYxNumXszPUWspcQ8DFaMHP3sFvr7w
 2I9p6OrlffpRSuPkE4AK68zOKFK0gbjqSev5z72XYzpYRnVRjvpWyw/cVDOIwW/oCbgR
 uL8EexuemuaYOEXvcnRcvLBq/Ete5jU+ttVAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763993854; x=1764598654;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KiNlO20V4+gME7/XbAIjF14uc4vNplKHiuTe57VT+l4=;
 b=DE9z47fUJ2ZB7lOEiqyBGdjgUMhmeMrf9IoloY8afMxfiOXPia+wDteNLv3yYEjkE9
 2hpQp/DVdFgbKYgNz96BrE29iGhuKpuY6FlKpzXsU2wSmhALab0Z6lLJA1vkv119LP08
 SvqfZ4N+ofReHNWJCgVNGo2hQ97Z+SC4VAn7oC5FOCscRxJ1n3fRUVoACIesLSmT8Gr+
 k6Y+oNAqyeCAY7zeULYVfqzUjPtp3XHRcYsPYQGAKnvItwiYwl9IpdNl8dFwZ/d4usH9
 P7LvJV4Rtah1jXcCQj9fDzLfVbcn5Ka8mKkxUiv28N8MhvdirqHEWr/3txIflZMRbBEA
 7NdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVDe+yC+H3gQp2zinrOengGHrl2f/TAaHY8nNUkwi5LSNXPlQRgI6E6TVLcSYFXaVcaAn1yOc=@lists.denx.de
X-Gm-Message-State: AOJu0YymcEnTDypDuEN6nlvQaactMwKj1HkEt+6lMqJEn8EWM3PBUX5s
 yT2XMI5M7fzcbfBwaniAuLObpInlCvfQhH5ov/SGMzK57rPdWgc93jvgVa6P7hHfU2Q=
X-Gm-Gg: ASbGnctowcOFMm79tzd1FKEO0xcfaSoWZ4uRqUGUk7WVzvNKv2CNwbumBfaFsban3hM
 MBxWBv4Q+krvyDUNlBskoW1p1LQ6ZjX2kFesuAISuWF9oEdVfFq0tOba9TxGYvvUqzsfshu/Bnp
 ebuWIclkFK8n5drUD3rndpxkNShjWavSqOjPn4ZWlk8MDcsS894Gqc/1vu9QeaGNnTddGSPgQUS
 upUuGZa5ZEenYWIyqUr38INkUQqi+uwGFh55gPIgSfWjTWE2Bba6SdesrvrhYP3xwLyqXfO+wok
 iCtYr8w+Z91tlOJsEIm+d8i1HEvgoPuZI6qMF7+GTOWsONs71bQQ/dNGuQ9kF9cepHCSRFVrX4j
 eHl2DxsGV4ibIQPDV0vUZPv8gm0+fBLyKutLKQ/k3iXJOetNFAFFbGYUbbbuqAzrpgUop+Rhw/M
 NUsboz8Nyuee+vZjL6D0vIThvkM74TsoG6FojsgVOZTKSrDDUidA==
X-Google-Smtp-Source: AGHT+IHHFriKxP9ywhcObowd6oqi5Vc0DtCfKVn0mDK9MtXTQ0PLoyQq9b6yogT42fKa+h1iaKjAqw==
X-Received: by 2002:a05:6870:648e:b0:3d2:590b:8d12 with SMTP id
 586e51a60fabf-3ecbe5863e7mr4768845fac.45.1763993854348; 
 Mon, 24 Nov 2025 06:17:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9c344676sm6199165fac.6.2025.11.24.06.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:17:33 -0800 (PST)
Date: Mon, 24 Nov 2025 08:17:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 07/19] test: cmd_exit_test depends on CONFIG_HUSH_PARSER
Message-ID: <20251124141730.GJ2125796@bill-the-cat>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
 <20251123225711.227016-8-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n8Cjlm6yVhnIqmzF"
Content-Disposition: inline
In-Reply-To: <20251123225711.227016-8-heinrich.schuchardt@canonical.com>
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


--n8Cjlm6yVhnIqmzF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 11:56:59PM +0100, Heinrich Schuchardt wrote:

> The exit command is not available if CONFIG_HUSH_PARSER=3Dn
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/Kconfig      | 1 +
>  test/cmd/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/test/Kconfig b/test/Kconfig
> index 77e7cad3984..6a4a5fc6708 100644
> --- a/test/Kconfig
> +++ b/test/Kconfig
> @@ -3,6 +3,7 @@ menu "Testing"
>  config UNIT_TEST
>  	bool "Unit tests"
>  	depends on CMDLINE
> +	imply HEXDUMP
>  	help
>  	  Select this to compile in unit tests for various parts of
>  	  U-Boot. Test suites will be subcommands of the "ut" command.

This should be its own commit, or part of the hexdump patch.

--=20
Tom

--n8Cjlm6yVhnIqmzF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSRo9wAKCRAr4qD1Cr/k
CsAeAQDsTprBhzn9WRg6NZ3hpk02KXOFll1d0YtMsuWTkP3OCAEA7MBZFHB3fbI8
1iqNx/JhLoyU4CEfPFNT0El2hqjVNw0=
=YSLn
-----END PGP SIGNATURE-----

--n8Cjlm6yVhnIqmzF--
