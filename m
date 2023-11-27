Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C53C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33190877BC;
	Mon, 27 Nov 2023 19:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YTdjRWTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713D5877BD; Mon, 27 Nov 2023 19:31:49 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50CA8877BA
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5cc77e23218so46221157b3.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701109906; x=1701714706; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0zq9i2v4Q23LwuvqhvB2qaOU3ePuHwxTobM7EtHIm5Q=;
 b=YTdjRWTaTb3/V589zG75z/3Ij6fep4ANQH0QE6Xl29ekR4JV7Cwy8+w3Imx/ZX59FG
 QWc4Staf/sCcQHwdFHkES/2WFBY7QpRML4CcClOh45Cd+8LPWT1D/crAtxJA1sNvqfti
 QyPJUSKrGMjoZxmICm9w9URONexF4fhY6CH1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701109906; x=1701714706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zq9i2v4Q23LwuvqhvB2qaOU3ePuHwxTobM7EtHIm5Q=;
 b=gAqe+tfGA8zG/l11OVLDW3zzCa92lLAbD8QO1bgUNDPCLafHnjv5HvTAQRbJPBskNh
 M32e7F76RozH1lyOyoSB4ZyVoGJIydj2azmhV8MAX7nXNMK7vKGFDnB5nyhs5h5N+bQj
 GnW0qqbCjFGVw/HkfuCKxXHHaKjfkeYdTCtr8+JwpKKRbSaqZguRzVw4mcu9Hqvcg6Nd
 RJHpgx5VY4B7GDQBwzXClhiUwZo3R4lTVeBw7vycELp9ogCyFH/jikzF2H7afCEH4vex
 vCAScY9+tsgkgt9lrxgOyFcX5U72+XSiHpBuwicmBD5tWf2/rOolMzfzBfrbz/EIhjmG
 1tlw==
X-Gm-Message-State: AOJu0YyBcjie5D/UfpLGpQVgr//fZDEpvrae0BC4P9ENeKy/G5cYLA1R
 QBF/q09hZL7tgFha1wQAJ5WqAA==
X-Google-Smtp-Source: AGHT+IEaFzbb8YeWF/y2O4oBMw4gRprrfzauIOsEE0a89td+whkTajeqX9dR2gn6w7rp70Jfg1WFOg==
X-Received: by 2002:a0d:e810:0:b0:59b:ec10:915e with SMTP id
 r16-20020a0de810000000b0059bec10915emr13660352ywe.30.1701109906017; 
 Mon, 27 Nov 2023 10:31:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a814813000000b005cb331f463esm3466600ywa.8.2023.11.27.10.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:31:45 -0800 (PST)
Date: Mon, 27 Nov 2023 13:31:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 10/43] net/lwip: implement lwIP port to U-Boot
Message-ID: <20231127183143.GR2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-11-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tdh29abOkV713iqs"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-11-maxim.uvarov@linaro.org>
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


--tdh29abOkV713iqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:56:53PM +0600, Maxim Uvarov wrote:

> Implement port of lwIP stack to the U-Boot. lwIP is well known full IP st=
ack
> which provides wide functionality, various examples, API closer to linux =
userland.
> Rich debug printing and possibility to run lwIP apps under linux make it
> easier to develop and debug apps.
> U-Boot implementation keeps the original file structure widely used for l=
wIP ports.
> (i.e. port/if.c port/sys-arch.c). That should allow us to easy port apps =
to or
> from U-Boot. Multiply ethernet devices are supported and "ethact" env var=
iable
> chooses the active device.
> Having a rich IP stack inside U-Boot will allow us to have such applicati=
ons
> as http or https clients.
[snip]
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 19649517a3..915402e843 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -258,7 +258,7 @@ config REGEX
>  choice
>  	prompt "Pseudo-random library support type"
>  	depends on NET_RANDOM_ETHADDR || RANDOM_UUID || CMD_UUID || \
> -		   RNG_SANDBOX || UT_LIB && AES || FAT_WRITE
> +		   RNG_SANDBOX || UT_LIB && AES || FAT_WRITE || LWIP
>  	default LIB_RAND
>  	help
>  	  Select the library to provide pseudo-random number generator

So here we say that you must configure one of the "random" providers,
either software-based or hardware-based.

> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index 3d0ec91dfa..f57da423f5 100644
> --- a/net/eth-uclass.c
> +++ b/net/eth-uclass.c
[snip]
> @@ -587,18 +602,26 @@ static int eth_post_probe(struct udevice *dev)
>  		/* Override the ROM MAC address */
>  		memcpy(pdata->enetaddr, env_enetaddr, ARP_HLEN);
>  	} else if (is_valid_ethaddr(pdata->enetaddr)) {
> -		eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
> -					      pdata->enetaddr);
> +		ret =3D eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
> +						    pdata->enetaddr);
> +		if (ret) {
> +			log_err("Error update env for eth%d\n", dev_seq(dev));
> +			return -EINVAL;
> +		}
>  	} else if (is_zero_ethaddr(pdata->enetaddr) ||
>  		   !is_valid_ethaddr(pdata->enetaddr)) {
>  #ifdef CONFIG_NET_RANDOM_ETHADDR
>  		net_random_ethaddr(pdata->enetaddr);
>  		printf("\nWarning: %s (eth%d) using random MAC address - %pM\n",
>  		       dev->name, dev_seq(dev), pdata->enetaddr);
> -		eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
> -					      pdata->enetaddr);
> +		ret =3D eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
> +						    pdata->enetaddr);
> +		if (ret) {
> +			log_err("Error update env for eth%d\n", dev_seq(dev));
> +			return -EINVAL;
> +		}
>  #else
> -		printf("\nError: %s No valid MAC address found.\n",
> +		log_err("\nError: %s No valid MAC address found.\n",
>  		       dev->name);
>  		return -EINVAL;
>  #endif

This is a general fix, yes?

> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
> index 295261a042..9135dee6b4 100644
> --- a/net/lwip/Kconfig
> +++ b/net/lwip/Kconfig
> @@ -1,6 +1,7 @@
>  menu "lwIP"
>  config LWIP
>  	bool "Support LWIP library"
> +	select LIB_RAND
>  	help
>  	  Enable the lwIP library code with
>  	  all dependencies (commands are implemented with lwIP

And this part is wrong. We don't _need_ anything here due to the change
in lib/Kconfig.

--=20
Tom

--tdh29abOkV713iqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk4I8ACgkQFHw5/5Y0
tywDpQv+OVUrCcMeYRSumO76RO+82aeUvG7qAIm8D6pA2ypfMvCyw0FScxnUSe12
uCNTVK8gGzJJV1s+6RU9lkwzeTlbWXjT088iVsWpuhKfmZjh0mZJ+tG84nA00ujc
eXmVNmp9bDHoifxtwh1U+3MzbsVGt0sC8j2QHIKbyfbRJExfeyFXr5Atjq8XkA9P
c/VUa4tzJ+EQ/Ig3ASF51TP4hR6NXwP3HE0fT/yRPRmWOWDun/epnAKr0X3Xi1w1
3nHPhrKohlhjJ0Eh2kO6QPso7EWL7xgDdwJpqb3D0jRU71S3CYF8yXj/Rqwy4LFy
KTE8G/ek8qyHIb4w53aZPwfGJXsNXvQwXk7xaXwwYSSGl20oCulCR2KuI5UT2Hk4
J4G2KdAaldyXxbpOY9aeNtV1JqST4uQWqSXEHsYi2imSxNY11Mq0TZv3ok8/sFAg
K5Nsdn8u8Yuw1OQ1JwMDol4slNny9bCIRPGHhaFOYCMre3GmhloUM460y/AJuesC
8iWq1RCX
=sWdI
-----END PGP SIGNATURE-----

--tdh29abOkV713iqs--
