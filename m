Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135D5CE7A8B
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 22:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4CB282BBF;
	Mon, 25 Sep 2023 00:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E/0jsvr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 717C286AFB; Mon, 25 Sep 2023 00:59:43 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61E1881420
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 00:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59c215f2f4aso66114607b3.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695596380; x=1696201180; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iOfNYyV69StCDcfKd2yPpxcY8eO2Q8ozqHm/dvegZJk=;
 b=E/0jsvr6aOsUmwttG2wpExKrxtQ0w+SIOBQp9AwY9M72YfSTwjo1dfktmHy8BEjJ8b
 ZOR5Nx12iDZz0FNeq/JK1aBmod4I/YnuBW3/EyyXG0c04sHYhz+BlHabcG+K4f5DbVLv
 81k8Cifq6Q0dwk3LViuKdkejbKGscvEhVtT3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695596380; x=1696201180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOfNYyV69StCDcfKd2yPpxcY8eO2Q8ozqHm/dvegZJk=;
 b=eWtW4Q7D1PyD3Gd9qrSxdHfEDKf5s41jgGdz1DKpi/Hc8SQA+CkX70+yC3crif83s+
 P9aNO+mQWk3WgZOKQyQfNqvg9DANxGwgTa/RxI3EmM4GNSLKoZUOzA3vymSmbODkyoGc
 zjiusNTbLqvVy86l3DETtejt9ioZpQivye4QD5K7Jvq0wYX67bQtaibGsqDA+cN5YoP7
 PBVMoUTmWkkzcSXGER+CH4R5bPIaKjIiyZhnbaM0zfXQ4Op5EU2d/Jk370KqTPkHw11v
 CghdF7twFzssLQVoqvdLtVOXPWXkSCfI8ECC/VueuVYQfNR7LnU6qKiV+fYDkCJeFSAS
 mACw==
X-Gm-Message-State: AOJu0YxKmbNJRuSGAl4ob/WjgQh21ppD/wxyXZFU42M7fAiMGv3OsmAP
 9dPccgdxB1j3Mff15aHqk0rQEQ==
X-Google-Smtp-Source: AGHT+IGQKoOsJoTWLIZxJydmwOd3BO5Oi5vK14Eyxgxc7p6MPBVBadezEekcelfVS8FDk4SQx0uCcA==
X-Received: by 2002:a81:ad49:0:b0:59f:7860:f451 with SMTP id
 l9-20020a81ad49000000b0059f7860f451mr1478553ywk.21.1695596380078; 
 Sun, 24 Sep 2023 15:59:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a81bb47000000b0057a44e20fb8sm2072852ywl.73.2023.09.24.15.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 15:59:39 -0700 (PDT)
Date: Sun, 24 Sep 2023 18:59:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>, Heiko Schocher <hs@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Samuel Holland <samuel@sholland.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 08/25] fastboot: Avoid depending on CMDLINE
Message-ID: <20230924225937.GL305624@bill-the-cat>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5MHL10sHReXZGGcx"
Content-Disposition: inline
In-Reply-To: <20230924203953.1829820-9-sjg@chromium.org>
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


--5MHL10sHReXZGGcx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 02:39:26PM -0600, Simon Glass wrote:

> When CMDLINE is not enabled, this code fails to build. Correct this by
> adding conditions.
>=20
> Note that this should not happen in normal use, since the use of
> 'select CMDLINE' will cause a visible warning. But it is needed for the
> sandbox build to pass without CMDLINE.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  drivers/fastboot/fb_command.c |  3 ++-
>  drivers/fastboot/fb_common.c  | 15 +++++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 71cfaec6e9dc..4e52e6f0f8bf 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -346,7 +346,8 @@ static char g_a_cmd_buff[64];
> =20
>  void fastboot_acmd_complete(void)
>  {
> -	run_command(g_a_cmd_buff, 0);
> +	if (IS_ENABLED(CONFIG_CMDLINE))
> +		run_command(g_a_cmd_buff, 0);
>  }
> =20
>  /**
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 4e9d9b719c6f..35b7aafe5af3 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -132,6 +132,13 @@ void fastboot_boot(void)
>  {
>  	char *s;
> =20
> +	/*
> +	 * Avoid a build error; this will always have generated a Kconfig
> +	 * warning about CMDLINE not being enabled
> +	 */
> +	if (!IS_ENABLED(CONFIG_CMDLINE))
> +		return;
> +
>  	s =3D env_get("fastboot_bootcmd");
>  	if (s) {
>  		run_command(s, CMD_FLAG_ENV);
> @@ -170,8 +177,12 @@ void fastboot_handle_boot(int command, bool success)
> =20
>  	switch (command) {
>  	case FASTBOOT_COMMAND_BOOT:
> -		fastboot_boot();
> -		net_set_state(NETLOOP_SUCCESS);
> +		if (IS_ENABLED(CONFIG_CMDLINE)) {
> +			fastboot_boot();
> +			net_set_state(NETLOOP_SUCCESS);
> +		} else {
> +			net_set_state(NETLOOP_FAIL);
> +		}
>  		break;
> =20
>  	case FASTBOOT_COMMAND_CONTINUE:

All of this just means it now fails to work, yes?

--=20
Tom

--5MHL10sHReXZGGcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUQv1UACgkQFHw5/5Y0
tyzPrQv/fKovnW8IasCExxSoY+kC3itJ3n7GwleW68Z76+I7wCCfMkF4EvrkQXs4
yFeIgvMRXbi1dOYLlz0LSCZAbQNfzR2kZ+vkGOhtvDvCWJ5hFN+ziyGOqiJCZ9+O
GfzHMTwDsQlq9JNS1dKxmSFcYI0cfTKZNV7cQhL+2VEaqEM0h1oobO6MbIgZ7jRN
qtYKiznp5DVgsK/hLD37zDW8K/y/v//VIBJ22W/SiqqxLIJV3P68WwwXTWSepSYy
WyYvsngoSkrBtGNqSq9wWGppMmPcpL5WbIyFuDktcOUq8DKwXAzqJ6xVP6s//KVy
i7NhdYMdEdi2OczuSilflILnfF/+LUgEK5hiGzqo2siNMmFbgAp7AUaazp+gM8R9
9S/r5oBgl/DcVLF0UG/T/k7ZdvfvHQvffzT3G8KFMq6BzftvJigXQ++AvExMrmQI
mGZfSOg5JnSYR1r5TMf2c3adnuEHssGah55UYtTMsRsnA5BKMcE2rfdF8/MYBqzQ
pW/QWeV1
=w1H/
-----END PGP SIGNATURE-----

--5MHL10sHReXZGGcx--
