Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A5EC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 17:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 081038209C;
	Wed,  7 May 2025 19:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g08V3h2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4590D820EB; Wed,  7 May 2025 19:42:50 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110A881FAB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 19:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4c4eeb36d12so815054137.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746639767; x=1747244567; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AifWgfAedRyf4E+5phh0WWdJsjXP8zAeamw7E48gY0Q=;
 b=g08V3h2BlxfUN14TjQaTlnRtXHF7fEFmVx5CrSHAevlh6L+o2vR9UD7eOnC0iRYTyZ
 fv2r/OYUEkKOmz0D/OpyI0gzi1/u6BoM+L17N7+RceYp/1jBXSgBM8TWsUp1dS/5Aosm
 vXLjZRxsvvFTb5DDxA1jRvSF6G/OAuVldxJ4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746639767; x=1747244567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AifWgfAedRyf4E+5phh0WWdJsjXP8zAeamw7E48gY0Q=;
 b=Jid/6bLEfGTS1vORsqlxoflSt2A0QViLswkD1ymTrkJOTw1YGdcJQNMY+O9A0F1tYx
 TLmUGftG+z5xl2lpH+SU5yZXiPm9bwCaL4oMUTnNXwNa9WyYcQf4U9J891WywpwijJ7i
 Bhqq4d7e/+ykCPpZlg8awWzNHFQJmclmP70PijChTTEN9EU1IosL3LatOHLNz1nAqnjI
 072zQcilB5OejTHHmcAfOSgAEEek0vpc9YPqFq5wHkrPzNVNF+fCC7OmWG/knxUbY/Cp
 X4j+HUYhWzGmsZ7XlPUDmyTGUQTbb83YNK4P9Iz9rMor6XALPdJea5UwHx0c5p5SWmlw
 neqA==
X-Gm-Message-State: AOJu0YzJ8sUgd/IadDkggKugN4Tnd0rwFsc8+b7WQdBzBNBjWx39TpZ2
 MLuRkeBIWzP2ZBwxPiPXyfTyxKAq/+KVABKVkPJA+ypjMbCM9mR1SdatA1UREAK/zvkkn2HP6vs
 0
X-Gm-Gg: ASbGnctlVt3wEYZKcoJ0A8MKcqOSbY1ofyvNvifphQG6o37FMKG3cIUCN2fW6wIMeG4
 hT06It8Nc6EB+XNbZvoe3UQrusgHlBBKtqfDTQ73Pp2JYxUVfmuC0x/u19g1pDJXslWKi4jU+3Q
 fMpQjgGU9wFEty5sAdy7Hs7BIxcpB/3HLlbDrfsN2PmmWcnKsxMW9X/zU9HFdQykQD0gRNmfc43
 DCOZnf8VsJZJ9Epg7mZatXRnfGWd3bRB7EyhF31qsqZap6vPxzn/S7Bw60IQkjnh3wIPGM8sGJF
 Dd3iRBjWsb44JFVeaNACP2DCfnshDAkoBMEgpk+m3l87loksWoXWy5HRZVGMF20LV0a1hIEZ1nG
 nHg==
X-Google-Smtp-Source: AGHT+IHgbDIWZFNt5L01b8m0mS7hxbsfJnwfngIPLetruMTpvDLuIrTCGYeQci/zZvbt5K2WkJVV5w==
X-Received: by 2002:a05:6808:3012:b0:3ec:bf55:e33f with SMTP id
 5614622812f47-4037799ca87mr260096b6e.9.1746639756747; 
 Wed, 07 May 2025 10:42:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f323a49sm649175b6e.3.2025.05.07.10.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 10:42:35 -0700 (PDT)
Date: Wed, 7 May 2025 11:42:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michael Walle <mwalle@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@denx.de>,
 Benedikt Spranger <b.spranger@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 John Ogness <john.ogness@linutronix.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH V3] tiny-printf: Handle formatting of %p with an extra
 Kconfig
Message-ID: <20250507174233.GA491506@bill-the-cat>
References: <20250430103548.4162289-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SjiLQrzCELktegJZ"
Content-Disposition: inline
In-Reply-To: <20250430103548.4162289-1-cniedermaier@dh-electronics.com>
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


--SjiLQrzCELktegJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 12:35:48PM +0200, Christoph Niedermaier wrote:

> The formatting with %pa / %pap behaves like %x, which results in an
> incorrect value being output. To improve this, a new fine-tuning
> Kconfig SPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
> has been added. If it is enabled, the output of %pa / %pap should
> be correct, and if it is disabled, the pointer formatting is
> completely unsupported. In addition to indicate unsupported formatting,
> '?' will be output. This allows enabling pointer formatting only
> when needed. For SPL_NET and NET_LWIP it is selected by default.
> Then it also supports the formatting with %pm, %pM and %pI4.
>=20
> In summery this level of %p support for tiny printf is possible now:
>=20
> 1) The standard tiny printf won't have support for pointer formatting.
>    So it doesn't print misleading values for %pa, instead '?' will be
>    output:
>    %p   =3D> ?
>    %pa  =3D> ?a
>    %pap =3D> ?ap
>=20
> 2) If SPL_USE_TINY_PRINTF_POINTER_SUPPORT is enabled or DEBUG is defined
>    tiny printf supports formatting %p and %pa / %pap.
>=20
> 3) If SPL_NET or NET_LWIP is enabled the support of pointers is extended
>    for %pm, %pM and %pI4.
>=20
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Benedikt Spranger <b.spranger@linutronix.de>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> V2: - Rebase on current master
>     - Extend commit message
>     - Restrict use to SPL
>     - Rename Kconfig to SPL_USE_TINY_PRINTF_POINTER_SUPPORT
>     - Replace _DEBUG with defined(DEBUG)
>     - Output '?' if %pm, %pM and %pI4 isn't available
>     - Add break on case '%'
> V3: - Add missing output '?' for the default case
> ---
>  Kconfig            |  1 +
>  common/spl/Kconfig |  1 +
>  lib/Kconfig        |  8 +++++++
>  lib/tiny-printf.c  | 52 +++++++++++++++++++++++-----------------------
>  4 files changed, 36 insertions(+), 26 deletions(-)
>=20
> diff --git a/Kconfig b/Kconfig
> index 51358633762..b8eec3fc931 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -774,6 +774,7 @@ config NET
> =20
>  config NET_LWIP
>  	bool "Use lwIP for networking stack"
> +	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF
>  	imply NETDEVICES
>  	help
>  	  Include networking support based on the lwIP (lightweight IP)

Sorry I missed this bug until now. This (and the subsequent parts of the
patch referencing lwIP) aren't right. There's no SPL_NET_LWIP support
(and not planned at this point), so what this does is grow platforms
like xilinx_zynq_virt which use lwIP in U-Boot and tiny printf in SPL,
but shouldn't since there's no SPL_NET_LWIP.

--=20
Tom

--SjiLQrzCELktegJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgbm4UACgkQFHw5/5Y0
tyxKCQv/Ul24mHRKT4QOpn0sBKF7Eu0gH7H3p2Kk/9Pm2uGMu4Ol1eM/UjRIiRtD
5hhR9G4mMjB3up5265lGmG11742tMOecGebMsPKpJ7/wGLRkMzzdJDxiGuEpr/Rs
Y1fZpP6W6t9hJTClyZMoi/bht5tpbV9Q/8Qfjd55bZ0UKAN42R+qoIKBPbzzckDH
tGHc8+FhW03FwdkEX9WkO0S3uj1qeU6X0vKhKlMTnEC/9QKc+KTq2lW3GTTn//vY
wgO9HaVrHoag94Km6WirRKhfCV5HNa2dBuNeiJ6hjaGi1Yrkx9Xbq+3KBkV67+pi
K+qs3TBQHwEMS0/ys4QLiTMEbwCskJ7D09H5o0ljmXuGM33bqVVrAgLyuMWjOddy
gSxtQJsNp+HhC2+7nDPTJ3OI63ah+NRyqP6SihXVNWRqTcDjXjqJVCDI2TtYyvaY
CyG4X8WXBtG2LHd4rQMDaVew05b+E0XnlAhaS4tbYvZBAZbIQeBbQAWqXSGf6k+l
H5pYCrmR
=3vVp
-----END PGP SIGNATURE-----

--SjiLQrzCELktegJZ--
