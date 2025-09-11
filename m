Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8E1CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 905D2833ED;
	Thu, 11 Sep 2025 19:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="szZ5uJXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9E0833F9; Thu, 11 Sep 2025 19:32:17 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A89833BF
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-319c2a87a5aso351373fac.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757611933; x=1758216733; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cmZKaEv+gkjFPZ8ejKtiEQrqsWaRkOz4aY/34hK+f2c=;
 b=szZ5uJXxyec/VVBtzxDBAAqxWlVtc9j6GxzylXHg7/fxNdyrvBSB3fRMxl5G1IfKCi
 UA2Jm6vg6m43Bmb+d59yzJ35N+xHHy58xbcC5wFN6nSqGzVg64lDo6uAH15XEGUleziO
 Rx11ubQ+eW8d5ZWyCzyV5Xua4MvZ9t3zuXzug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757611933; x=1758216733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmZKaEv+gkjFPZ8ejKtiEQrqsWaRkOz4aY/34hK+f2c=;
 b=fDLXMfTC/1kwp96OtRZYDM5FOTQenTaEx6bBWS28bGxzd0FL57TxIX9xHjhTwr6ioN
 +OxIG6o1j8F2Fj13PD+KHXAoxWp7PpNs/3AtTcJkfKdMvH+ofbOV8xOAiCQDWbuKXgxx
 T2j2hpYYgTvPvtF5k0IFg8865wk6DxXnokewwZ+KVHsi8cEN6/GlMHz4+AdZsnrYB88f
 jle1c999Ubm6OOVK4WvfOxMq97g+bDd+hC1kZKbehJHwX0Vr300grk+s5BZOT6uq/vLp
 YAa//Q997LMsZx17Sgkim0QUy72mqHk2LhujcitwuXtDBS1hmBwJVPggdK2cuIBWjgkJ
 l6LA==
X-Gm-Message-State: AOJu0YzKMMxFkTGhPusyCCeZQwbe4Nvfxh+r2HWRv0PJ5iFG48LHcFeK
 f6eQ7K8fR0aM0T8K4QFJFR5B4vyMhH+mxbk6n+hktlFcQotXVE8NNfeVCC8Z+Dhp4XA=
X-Gm-Gg: ASbGncsA2SHE+nbW//30MvYcRD7TmNopqzrb30lIrZRdfVevSStJnMz8YMYShrXkrUv
 6sl1nkvauHYvZz8BbisPTTmgB5tyhbrZt2M6LraafXZNsGsH2BiPN8erxEcYGEYTqh0LQQj7s3P
 liunztuMLqpNCWEP4dMg8P50q/8AN2gUv9j6VOt8sLP37nw2nxr/A4c+C0n++zsCxveSaXwPGwx
 QkOS4WuLPyn/+tdwFxFjjRPyIWEd2QQK+A6p5/QWhQjWYJ2qGzrOdDpLlVusgTAr72JL1I8XWVy
 BKLUSDqvi191wfuz0A1eVPjqVWz7eaZMQva2H1B5DK+ZIoBleTqNjqJndc+/k04lLKyyUV5AV6c
 rdVx52kUgC1RjqWV5mGYsfaDr/lWGsF8HObyTbBGzfh3kRWFWKM6+T7OnPnyB97FeaoU=
X-Google-Smtp-Source: AGHT+IEUmwa74k7jXP+KKCgqHJKI9ZBhkB7/uxk9YjDBURr+5hLL3KXrzms7z1Roc2EjK7nDDzbDEg==
X-Received: by 2002:a05:6871:4b09:b0:31d:655c:4ac4 with SMTP id
 586e51a60fabf-32e55081cb0mr23812fac.19.1757611932708; 
 Thu, 11 Sep 2025 10:32:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d357d2f9fsm544625fac.24.2025.09.11.10.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:32:11 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:32:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH RFT v1 16/17] Kconfig: disable raw image boot in secure
 falcon mode
Message-ID: <20250911173209.GZ124814@bill-the-cat>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-17-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J7FtZ2q5CKVdV8uk"
Content-Disposition: inline
In-Reply-To: <20250911131414.3296697-17-anshuld@ti.com>
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


--J7FtZ2q5CKVdV8uk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 06:44:12PM +0530, Anshul Dalal wrote:

> CMD_BOOTI and CMD_BOOZ enable support for booting raw kernel images in
> falcon mode. This is insecure since raw images can not be authenticated,
> therefore disable those configs when SPL_OS_BOOT_SECURE is set.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  boot/Kconfig | 4 ++--
>  cmd/Kconfig  | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 124f6db3e6e..ddb7a82b374 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -422,8 +422,8 @@ config BOOT_DEFAULTS_CMDS
>  	select CMD_DHCP if CMD_NET
>  	select CMD_PING if CMD_NET
>  	select CMD_PXE if CMD_NET
> -	select CMD_BOOTI if ARM64
> -	select CMD_BOOTZ if ARM && !ARM64
> +	select CMD_BOOTI if ARM64 && !SPL_OS_BOOT_SECURE
> +	select CMD_BOOTZ if ARM && !ARM64 && !SPL_OS_BOOT_SECURE
>  	imply CMD_MII if NET
> =20
>  config BOOT_DEFAULTS
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 29de857ba7c..c4828ed90a4 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -360,12 +360,13 @@ config BOOTM_ELF
> =20
>  config CMD_BOOTZ
>  	bool "bootz"
> +	depends on !SPL_OS_BOOT_SECURE
>  	help
>  	  Boot the Linux zImage
> =20
>  config CMD_BOOTI
>  	bool "booti"
> -	depends on ARM64 || RISCV || SANDBOX
> +	depends on (ARM64 || RISCV || SANDBOX) && !SPL_OS_BOOT_SECURE
>  	default y
>  	help
>  	  Boot an AArch64 Linux Kernel image from memory.

You need to think about this in another way, commands aren't present in
SPL binaries. What's probably the best starting path is to ignore this
particular problem, U-Boot has tons of security breaking options, and
then a follow-up would be to figure out how to build (and also for
binman/etc, package!) only SPL. Since really you don't want to flash a
full U-Boot itself when falcon mode will panic if fail and not fall back
to U-Boot.

--=20
Tom

--J7FtZ2q5CKVdV8uk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMHmQAKCRAr4qD1Cr/k
CmK3AP9myRPBShoh/0ZqkbeF7n2fEHDe3wNDUB3zbxO3Fna0kAD9GnaQAmEybmvi
5awhd6UGzdDcnHuX1mm98RvNkH0Ojwk=
=Fnjn
-----END PGP SIGNATURE-----

--J7FtZ2q5CKVdV8uk--
