Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D728C56202
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 14:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0084183C39;
	Fri, 20 Feb 2026 15:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LoOngQcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB9683D3D; Fri, 20 Feb 2026 15:39:37 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E8783AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 15:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4042fe53946so896335fac.3
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771598373; x=1772203173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FoCxcRUDJ37RNoAadFyUE/Ab1UadRl7Y6119jxkA9mY=;
 b=LoOngQcxwvttBIXdVk5DUYejdTqJzhEnQWtSqSBIrW+6/OUnrGLDorUovzl88ftSek
 vKaugETUbiXZd/xm0g5zTP16yad8//IfzIbHosHFnvs9XEXXvxGJ6mhWP9O881S5SshB
 VCkiDH/tDhKJBe+AJL85rng6YT4lceVXiXobY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771598373; x=1772203173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoCxcRUDJ37RNoAadFyUE/Ab1UadRl7Y6119jxkA9mY=;
 b=aCiDkXwRZzNYs1dXd8lBPnxf8bwLIAnAG8ml0X204Ni/ANTvvicCYs2xLEP71YR6FA
 gZZ2teT8Z1xvDUe6XMzwVbSHcs3ydUXXyHI9NkGCSMfNQHquZgrhGfzvCG67aIDbyQNU
 OhCKFVHHBKxgBhZzebZsD8pV5DsEVPgrwdHGlpqw4HuS+aB4wBZCRX2t2J9McT4dqvej
 zPClSn1vgCkRuIGkV9H/HQJudJsY4nXBEF8ViaKu2/V1qgB98awLR4Im84gvqCMM/vBm
 yH89nJVK7MWkLtnz//O/OTwd7mAIXcw5G0m4CzmDd3Z8UVUJdGiiIPht2bPocu+8XaYd
 8aoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxFg2R/VmtGbigcKwVcxG72A76xvgLppNhdVXC9jRyXiuBdZrl9chabGdtyVoJAIy0jEOaxsY=@lists.denx.de
X-Gm-Message-State: AOJu0YxO84Kx6F6MwvhyvKWlOcI47zNuey4hPZNR+yYUFB5l8hNyXyAI
 jdpb6+1plRcZb81fGyxSDA3ZIZhQfuSWU+4bemoBt/JMqdVb2Bd/zwGlCHazKh3h4s8=
X-Gm-Gg: AZuq6aLb+PPQvUI7bkHmJFZ7gvpXpJCz90V3Bd6qfT0BgTcWpuXQC8OBPGKQ7SiJMdX
 337iRSsC8rWYUzefHORQB3CKU4Up77nfrkZv/hUqZPS5KpDa2sGCcjRr4yad97IceQ9EopSRrtv
 CXluxCAzq929VQDsWw3SV6duYGl+DV0Ggso5M56PTdPVZiuceqVMA7F3S5FcincKyuFNVdBjD3J
 wPK4x1jyreUC9Axk+H4QNPrAAKE+md3xZcJ+zRTbvAORm13eRtISOwqQsqaqh+/yh3IHE7TvsJ7
 guIQKCLqHFCOrRUGtG4SQfVzB+WFDK5qTOwgmqjAsN7d51C/7rLBTIPrkeOr/XCFmfn0XnotBcj
 wSM9jwmLMYd3m8uBWC03iQOoy9bFtZ0l3lOfEJL/O+L2PgccoZvdtvFhU3BSXraGH6z1QW7oMxL
 QUk5JDc78pvKCEQ6g/ObcsB6MgeYeXYUoNQRxHLcYgBzBp4023WFqOBqwJWH/Bl/OsPnHTkenx8
 FoJD3ozP4FJ4Mmzbi7eiTvACjwapgDS3yt98j/eP+OeQhz1xIw=
X-Received: by 2002:a05:6871:828:b0:40f:c84:e59b with SMTP id
 586e51a60fabf-40f0d8d9522mr11801784fac.30.1771598373235; 
 Fri, 20 Feb 2026 06:39:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40f18df8a64sm18636558fac.14.2026.02.20.06.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 06:39:32 -0800 (PST)
Date: Fri, 20 Feb 2026 08:39:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 George Chan <gchan9527@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] boot: availability of command mii for NET_LWIP
Message-ID: <20260220143930.GR3233182@bill-the-cat>
References: <20260220143311.36196-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DcfYAOqad4phtBX1"
Content-Disposition: inline
In-Reply-To: <20260220143311.36196-1-heinrich.schuchardt@canonical.com>
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


--DcfYAOqad4phtBX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 03:33:11PM +0100, Heinrich Schuchardt wrote:

> If we are using the legacy or the LWIP network stack,
> should not influence our decision to provide command `mii`.
>=20
> Let BOOT_DEFAULTS_CMDS imply MII if either of the network
> stacks is available.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index e5db165424a..3f8f3e7cf35 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -435,7 +435,7 @@ config BOOT_DEFAULTS_CMDS
>  	select CMD_PXE if CMD_NET
>  	select CMD_BOOTI if ARM64
>  	select CMD_BOOTZ if ARM && !ARM64
> -	imply CMD_MII if NET
> +	imply CMD_MII if NET || NET_LWIP
> =20
>  config BOOT_DEFAULTS
>  	bool  # Common defaults for standard boot and distroboot

This is fine, yes. Quentin, have you had more time for your series that
introduces a symbol to use for "networking is enabled" and separates
legacy from NET ?

--=20
Tom

--DcfYAOqad4phtBX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZhyIQAKCRAr4qD1Cr/k
CkqCAQChV3nWs+S9VPbWYfk3Lc7/LslMHQNDRpbEceJQKdyDhwD+LeRRcshsiFLu
Z7Ig4tUufDLg3CY55PSxtvf6OE1wTw4=
=vqpP
-----END PGP SIGNATURE-----

--DcfYAOqad4phtBX1--
