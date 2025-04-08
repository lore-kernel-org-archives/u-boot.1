Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A0DC369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 20:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCF08214F;
	Tue,  8 Apr 2025 22:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="olGQsWX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD3282153; Tue,  8 Apr 2025 22:58:34 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC8A58210F
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 22:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3feaedb531dso1534512b6e.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744145910; x=1744750710; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aumU4Yhwxt6boUeamRlnpWbv09Bpk9y0tOFwGCfCjZ0=;
 b=olGQsWX4QCifS+Fr2Y/kBrefexL023LMQe6g1svn5mP/NT41H2FfXY0n1zGSk63b0E
 nE3NDhE+yYsK3kVaqMIyVnyJWq6tbY6Psd1ASVlmJ/8VvxylfEQFBHeFN5Zk3uERLwKf
 3799c0aPM1FdE8QSZZUNdqs0HfR5WqahHKlN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744145910; x=1744750710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aumU4Yhwxt6boUeamRlnpWbv09Bpk9y0tOFwGCfCjZ0=;
 b=wtpDxg5JLAZtssyTQCQkVhqJ9yk5L809Yjfq6Nq9t8f+HsYh+SxJiNvQTUroMCNaFS
 wXJyEE+EbwSfkMFBavcskkjRiqiNnzJEqZAxgL3UiTkQIS38z2YymeO5owKT8EKh1MVR
 ltYXX5dn2z+AiNt8bHg1uso/sw8SVC49rNtKFUEE4h80zOIH9NTAB7U0zi5Z8ZDAKail
 StIHB5TiL2kRnb34WBlwNXBU6LdKm3om/yIlqzCRmP/2p80GHejUIGk4RpfGm6eNmSb4
 EohPSx/H0A2Uz5R9NQfG2IoINzW4paJx2RunVzrXHweIJ4AN+d0LQtmRh1wDZASe0eam
 Omtw==
X-Gm-Message-State: AOJu0YwmViF2B+aIZ9GGSi5+Ds/rJZHtWs3zOoFDdIgJx3mW7YJ9v0AV
 BEnZDvBR4Uj2O5Jd/fum01U/fLuGFdxblcE6rDbsra2jEPsRbki1u2z0ASQgp+w=
X-Gm-Gg: ASbGncuo01vz04kyMmGXQjzXnUPgoG4+z9bGKDMQ0r5j7OwHp/AmzOUE5R2YPmgGELz
 W9bbc943bGpoWAuMaOU1Oq6Uj+bXBbUmcmw6wYbbwKMcUZ+xKNRCx96X9Y25BVZgl/rjL4OBEvq
 5Hsrgz1wjEtHiLw1sdBstU3iiQPAXHljfN9TY34DM4xy1MgvkryNpooGnjMOe7RALmx5QmBm9xy
 IHRkX2z4e7WGvrwDytQqN4TcB/2DQrKPEjeda/UyS/hV8V8yc0qcTYWgOJrUuDARbiWM9zwQOdw
 YzQ0mBFkEDzIQKbnqeAY1uAU9iDFD/pvJpIRxOSIZdSI02ByylLfOJuDRRb6YeciARvVcFAPwj2
 8a+/ULQ==
X-Google-Smtp-Source: AGHT+IHAdxe9BpjzKWZuyF6Ci87hc1VF6S/GhIHMO5vZOE5mvbgR/vgL43ycrWqLdRa9x4flHaOHcw==
X-Received: by 2002:a05:6808:2182:b0:3f9:640b:793e with SMTP id
 5614622812f47-400740a025amr51058b6e.31.1744145910285; 
 Tue, 08 Apr 2025 13:58:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400690c771fsm589366b6e.7.2025.04.08.13.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 13:58:29 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:58:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michael Walle <mwalle@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@denx.de>,
 Benedikt Spranger <b.spranger@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 John Ogness <john.ogness@linutronix.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tiny-printf: Handle formatting of %p with an extra Kconfig
Message-ID: <20250408205826.GZ5495@bill-the-cat>
References: <20250407085614.126626-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D+fHBm8WIZkxesNm"
Content-Disposition: inline
In-Reply-To: <20250407085614.126626-1-cniedermaier@dh-electronics.com>
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


--D+fHBm8WIZkxesNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 10:56:14AM +0200, Christoph Niedermaier wrote:

> The formatting with %pa / %pap behaves like %x, which results in an
> incorrect value being output. To improve this, a new fine-tuning
> Kconfig XPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
> has been added. If it is enabled, the output of %pa / %pap should
> be correct, and if it is disabled, the pointer formatting is
> completely unsupported. In addition to indicate unsupported formatting,
> '?' will be output. This allows enabling pointer formatting only
> when needed. For SPL_NET and NET_LWIP it is selected by default.
> Then it also supports the formatting with %pm, %pM and %pI4.
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
>  Kconfig            |  1 +
>  common/spl/Kconfig |  1 +
>  lib/Kconfig        |  8 ++++++++
>  lib/tiny-printf.c  | 45 +++++++++++++++++++--------------------------
>  4 files changed, 29 insertions(+), 26 deletions(-)
>=20
> diff --git a/Kconfig b/Kconfig
> index 6379a454166..4d13717294c 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -757,6 +757,7 @@ config NET
> =20
>  config NET_LWIP
>  	bool "Use lwIP for networking stack"
> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF || TP=
L_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
>  	imply NETDEVICES
>  	help
>  	  Include networking support based on the lwIP (lightweight IP)
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 94e118f8465..72736dbecf5 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1096,6 +1096,7 @@ config SPL_DM_SPI_FLASH
>  config SPL_NET
>  	bool "Support networking"
>  	depends on !NET_LWIP
> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF || TP=
L_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
>  	help
>  	  Enable support for network devices (such as Ethernet) in SPL.
>  	  This permits SPL to load U-Boot over a network link rather than
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1a683dea670..62e28d4a1f3 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -253,6 +253,14 @@ config VPL_USE_TINY_PRINTF
> =20
>  	  The supported format specifiers are %c, %s, %u/%d and %x.
> =20
> +config XPL_USE_TINY_PRINTF_POINTER_SUPPORT
> +	bool "Extend tiny printf with the pointer formatting %p"
> +	depends on SPL_USE_TINY_PRINTF || TPL_USE_TINY_PRINTF || VPL_USE_TINY_P=
RINTF
> +	help
> +	  This option enables the formatting of pointers %p. It supports
> +	  %p and %pa / %pap. If this option is selected by SPL_NET or NET_LWIP
> +	  it also supports the formatting with %pm, %pM and %pI4.

This isn't quite what I'd like to see. I don't want to start using the
literal XPL namespace as that will lead to confusion down the line.
Since we only have SPL_NET, I think we should name this symbol
SPL_USE_TINY_PRINTF_POINTER_SUPPORT, not ask about it (so bool without
"prompt text" following), and select from SPL_NET if
SPL_USE_TINY_PRINTF.

--=20
Tom

--D+fHBm8WIZkxesNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf1jfIACgkQFHw5/5Y0
tyzprgv/Zdsjon0pJ/WvXd8d6s89yqhABE4MMBrzBPljsJIWS8RmR7rfHLwVQloy
iMHdvJfBgwGmiuoD52XFKKO8QK5kT6/Q4sK3C9uZha59whXiljAwljVoUnmNct4j
FCG1X52L8fXCVHPC/0w8+DbGjI0jn1PH7HGF1SaJ9BzH1COXL0mSzwlgrtIR6v0q
IRgWIvz2KdEhAakx35hJOCvEq76HSyrnlsh5S2xQIU1Fi+GpOEFOTrkIYxm0MBhu
tEEjXV1EHJUgJi6d7ZDlYP1E3wqe0e8b0f2qz8kEF0TJvJcOd7WjoLOSpeq8Cu3J
f2B0ZRUQDlU5VmZ2S66vsePYhncEsOtf2Gm0TqoyzZQJ4WQ1wdRocdmrNzGhE01A
sP0l3BOwGoNCKHY4z9BFVmp9pMqlv9l6gvyouxUkcddZD/Lcvg5Hv7ZdKnwoDjYW
9OFdYtPSvOrJy/hegKDo4pXAWpq2dQI/9mm6dOorJY+51IvvcOgRkuzE7vt0LOGy
2BjIgORP
=B82D
-----END PGP SIGNATURE-----

--D+fHBm8WIZkxesNm--
