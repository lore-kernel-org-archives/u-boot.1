Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31515C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E209487686;
	Sat,  9 Dec 2023 19:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f7IGs2KX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A338187687; Sat,  9 Dec 2023 19:39:34 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA8887686
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5d3758fdd2eso29900567b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702147171; x=1702751971; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u6EpbRSSN9oQbYOURABbcOQG27reo8MixcejocfMsm4=;
 b=f7IGs2KXOeJodIoae31NbrKL6OgTe81P2LCGN45nkVa8KimSmBk711/MEIKKn39mPu
 tYvY9BxPuTD+Y6KJIxc2efb2RF7F6+e5TaVSuOcxMknY+CFBchjfPRpAGuNQyBN+ltBe
 NOrZ+v28GgTDyL36dK88VFnbMbJnTSwVpvqls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702147171; x=1702751971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6EpbRSSN9oQbYOURABbcOQG27reo8MixcejocfMsm4=;
 b=UhBi80Q6HBxrR4xGBI3u3B7+nN0Yrl4+SC25OGjZOIVfBtx54Pcm6gvEuublzpk9X9
 FS79iyINS1kSMWSQJyNz5QbtIfYsXy7eQjlIBVeoPnZ3zqC3qTc1NodbRrAAGZepPejZ
 kgliohcqc57yKCmRAASNinbrLrzxTtG9y8wHpI3DKWyJlT5ztCsHYRa4KlFzsXT6L8po
 gVxrrjHANNumNIETYH81VDa9MQw8qkOo8Yf45JMrjnClkEMtkpsv7ohwnOTuNkacQUDi
 CJO7YeviZFxj74T9aJZVe8kQOFRTSdYA+H3mchjQqwMyfNlek/hDvnJmPcoiB/v60pg+
 qTew==
X-Gm-Message-State: AOJu0YynUcjp/B+hSZd9ytdsyNH8yDHoRNgvXeoN+jEsNe4uO8B2o/aa
 EM96mUbakmrnKoPq3i1JknUKfhGZR0UmZ+Ur9toD3g==
X-Google-Smtp-Source: AGHT+IHtBej3HtC/8IwkExWA6c52Ep0enLKTIl0DLSyJ+92n2a7Ni0ugqSW/xtZC1l599e+N++g49g==
X-Received: by 2002:a81:4a45:0:b0:5d7:1941:3562 with SMTP id
 x66-20020a814a45000000b005d719413562mr1582001ywa.73.1702147171205; 
 Sat, 09 Dec 2023 10:39:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a81d24e000000b005d8bb479c51sm1637179ywl.11.2023.12.09.10.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:39:30 -0800 (PST)
Date: Sat, 9 Dec 2023 13:39:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 07/14] bootm: Make cmdline optional with bootm_boot_start()
Message-ID: <20231209183928.GW2513409@bill-the-cat>
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XjfoEcMs4gf5HI5a"
Content-Disposition: inline
In-Reply-To: <20231204003144.899097-7-sjg@chromium.org>
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


--XjfoEcMs4gf5HI5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:31:31PM -0700, Simon Glass wrote:

> Allow the default command line to be used when booting the OS. This is
> needed by fastboot.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/bootm.c    | 10 ++++++----
>  include/bootm.h |  2 +-
>  2 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/boot/bootm.c b/boot/bootm.c
> index f630b8c1a9c3..4a5da2a3bebf 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -1187,10 +1187,12 @@ int bootm_boot_start(ulong addr, const char *cmdl=
ine)
> =20
>  	snprintf(addr_str, sizeof(addr_str), "%lx", addr);
> =20
> -	ret =3D env_set("bootargs", cmdline);
> -	if (ret) {
> -		printf("Failed to set cmdline\n");
> -		return ret;
> +	if (cmdline) {
> +		ret =3D env_set("bootargs", cmdline);
> +		if (ret) {
> +			printf("Failed to set cmdline\n");
> +			return ret;
> +		}
>  	}
>  	memset(&bmi, '\0', sizeof(bmi));
>  	bmi.addr_fit =3D addr_str;

env_set handles NULL today. If there's some problem with fastboot with
CMDLINE=3Dn without this patch I worry there's a functional problem being
obscured here. Or it's not a problem at this point in the code to set
bootargs to empty and we need to allow for that in general.

--=20
Tom

--XjfoEcMs4gf5HI5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0tGAACgkQFHw5/5Y0
tyxcfQv/Zgf85MtiSosts84K/z/MUHonDFxB5fMHoVMLHwZg5pDgnalRMPzygxV5
AkBD5/M5jQKwBI9icsPruj7nVAwLU9hmzou+BzjRO1SUjgk1ujBISTjtZdlV8x1R
5ojv8SMcWC/o87GlUzrREZIxXLzCXdEJ1n690BT9t/jmQ8ELE5IfFdr72KsCIxLl
vXt6fwp2vsOTNMY79E4wgqMAILmStXT4aMWYgsutgMleJ5agBo151JevV3XosRkk
b05NudYm3qvMK1ErHAlX02deRJpi/29QtYM9qxs7voxzgT2A6eQBySBJFaSTTUQl
wSIDvbeCL1f6NQAo2bxrI1+VhxKvx4sxRqNIgWTq7qFInt7QwwGFfmKxe+bI8p9B
3Fut4oiVgimQYi6qrvnLSx0EpBtoEEtQLkHk6DDCx7LOeQsv6WOIk2r0RCg+zdsK
IgtMT3A/YQkBakh4Zfz8PpygFszlh+ijU1g8UuuZtjUKZoHT5QrcB32LR1QlgkPW
fIfU3bL8
=vo1Y
-----END PGP SIGNATURE-----

--XjfoEcMs4gf5HI5a--
