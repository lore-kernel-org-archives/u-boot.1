Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF53C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 17:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25E687719;
	Sat, 16 Dec 2023 18:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t0VohKQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC1C8771B; Sat, 16 Dec 2023 18:12:34 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB55D876F6
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 18:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b9e6262fccso1239454b6e.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702746750; x=1703351550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gq0ztkLxhfXmZZD7MkCYISAxhrB7Wqrg8BkCpY85W/I=;
 b=t0VohKQ2gFP9+09OeLb9U4DQCNhXOlzI3vY4v4unFv8xc1q8Id7jUnBA+Ed/hZUv+6
 r6AfPBGV9aHa5KqW7Wj0br8XwKXmBTDSValvMBECYfLlVnNQ+VdpooLweRJiTgeZHR9Z
 GXOgHwEg8GZV2o3dGZI/03lji7VFpqCPzgdv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702746750; x=1703351550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gq0ztkLxhfXmZZD7MkCYISAxhrB7Wqrg8BkCpY85W/I=;
 b=gmP2wl6qq2ChlruB0Tek0C49wvAAISm0EE3+rOT5k6DgUvMTfOo5u2a6DkCgdR74ZP
 ywOCd3ZXBW9vMaAft2u38cSNdIt5e73wfNuQAmqR9R8YsWGZhOE/+euiAhQwGk9vtcpV
 Z87lsxa6oYnhLwlnTG23AXYGdFFwUPznfI58exuc4EVQy+vljdFENtAWZXFsaeMMG1vn
 T7hn3sdcNChg7eBFAXwkPEGDbBxE+rOVNMurnBnl+em0RnLOzlyTohFSqYskLth8pYB+
 Vjk1hc1WDANJ+HqU69RpIpTQNXRIbs4G8oIVYJWOgS3seSJt7AiidVPaF1+XAkm9kb30
 V3vA==
X-Gm-Message-State: AOJu0YxqLW366kfykW1jfVzrsLGvLx7UxzIjXT/KjJVcRjHLuo60RHmD
 aLH1Dhy99LRsX7JnRjPXi63U6w==
X-Google-Smtp-Source: AGHT+IGRvFSJE0baahetCR5vl9Llg7o9EOi3Xt1h8ezG9nP4dCPZGbqKcy2EzcPuARp8cMbf0VNTYQ==
X-Received: by 2002:a05:6808:1484:b0:3b8:b103:fd2e with SMTP id
 e4-20020a056808148400b003b8b103fd2emr17190295oiw.16.1702746750298; 
 Sat, 16 Dec 2023 09:12:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 um14-20020a05620a6d8e00b007770673e757sm6947841qkn.94.2023.12.16.09.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 09:12:29 -0800 (PST)
Date: Sat, 16 Dec 2023 12:12:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v3 22/22] bootm: Create a new boot_run() function to
 handle booting
Message-ID: <20231216171227.GS2513409@bill-the-cat>
References: <20231216031446.2222362-1-sjg@chromium.org>
 <20231216031446.2222362-17-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7oe+OhCl1U95pb1T"
Content-Disposition: inline
In-Reply-To: <20231216031446.2222362-17-sjg@chromium.org>
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


--7oe+OhCl1U95pb1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 08:14:26PM -0700, Simon Glass wrote:
> Create a common function used by the three existing bootz/i/m_run()
> functions, to reduce duplicated code.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
>=20
> Changes in v3:
> - Add new boot_run() function
>=20
>  boot/bootm.c    | 40 ++++++++++++++--------------------------
>  include/bootm.h | 18 ++++++++++++++++++
>  2 files changed, 32 insertions(+), 26 deletions(-)
>=20
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 53236136f489..6a4cebcf7a08 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -1123,47 +1123,35 @@ err:
>  	return ret;
>  }
> =20
> -int bootm_run(struct bootm_info *bmi)
> +int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states)
>  {
>  	int states;
> =20
> -	bmi->cmd_name =3D "bootm";
> -	states =3D BOOTM_STATE_START | BOOTM_STATE_FINDOS | BOOTM_STATE_PRE_LOA=
D |
> -		BOOTM_STATE_FINDOTHER | BOOTM_STATE_LOADOS |
> -		BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
> -		BOOTM_STATE_OS_GO | BOOTM_STATE_MEASURE;
> +	bmi->cmd_name =3D cmd;
> +	states =3D BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
> +		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
>  	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
>  		states |=3D BOOTM_STATE_RAMDISK;
> -	if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
> -		states |=3D BOOTM_STATE_OS_CMDLINE;
> +	states |=3D extra_states;
> =20
>  	return bootm_run_states(bmi, states);
>  }
> =20
> -int bootz_run(struct bootm_info *bmi)
> +int bootm_run(struct bootm_info *bmi)
>  {
> -	int states;
> -
> -	bmi->cmd_name =3D "bootz";
> -	states =3D BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
> -		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
> -	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
> -		states |=3D BOOTM_STATE_RAMDISK;
> +	return boot_run(bmi, "bootm", BOOTM_STATE_START | BOOTM_STATE_FINDOS |
> +			BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOTHER |
> +			BOOTM_STATE_LOADOS);
> +}
> =20
> -	return bootm_run_states(bmi, states);
> +int bootz_run(struct bootm_info *bmi)
> +{
> +	return boot_run(bmi, "bootz", 0);
>  }
> =20
>  int booti_run(struct bootm_info *bmi)
>  {
> -	int states;
> -
> -	bmi->cmd_name =3D "booti";
> -	states =3D BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
> -		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
> -	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
> -		states |=3D BOOTM_STATE_RAMDISK;
> -
> -	return bootm_run_states(bmi, states);
> +	return boot_run(bmi, "booti", 0);
>  }
> =20
>  int bootm_boot_start(ulong addr, const char *cmdline)
> diff --git a/include/bootm.h b/include/bootm.h
> index eba35b33b4e5..9e0f8d60de0a 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -150,6 +150,24 @@ int bootm_measure(struct bootm_headers *images);
>   */
>  int bootm_run_states(struct bootm_info *bmi, int states);
> =20
> +/**
> + * boot_run() - Run the entire bootm/booti/bootz process
> + *
> + * This runs through the boot process from start to finish, with a base =
set of
> + * states, along with the extra ones supplied.
> + *
> + * This uses bootm_run_states().
> + *
> + * Note that it is normally easier to use bootm_run(), etc. since they h=
andle
> + * the extra states correctly.
> + *
> + * @bmi: bootm information
> + * @cmd: command being run, NULL if none
> + * @extra_states: Mask of extra states to use for the boot
> + * Return: 0 if ok, something else on error
> + */
> +int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states);
> +
>  /**
>   * bootm_run() - Run the entire bootm process
>   *

Overall good, thanks. My question is, should we mark the others as
static, or is this new helper static and not to be called externally?

--=20
Tom

--7oe+OhCl1U95pb1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV92nsACgkQFHw5/5Y0
tyz9lwv/TQ6yjiLm8SV0wB/Dm7z+aDuGspOmfVzILGTvbo5jb1CgE5fSUg4bwtlD
bK9JqI3OS4ZZnN0F+QHFqP40ubS6gFlQLvY0/qZfVNURdKweEORgEhx/mqcERqTb
lhc+ZFrGktcVg78zQJKluKXhScJZ70QcRkkjo+SMSpc+Mx+TYRioUq9/68LjeOoh
+E8hiCeNd375iGlqGHBtOKqDZ94HmulemHGjeQBi/27qXyIzdRH0TG1atDpkGMkZ
FJkEkaV92aMygEQP52MFaqwxT7cdklD/kHAD6KQjSYkTX0zuyDTHXx0DjTmIymDb
V3emdp2Dfnp7ITcBOZkTz/buv4VrFB5pEoi8QoTnckqg+qKmGk2mfT9gjUMF99OU
YtoBZZYo2p0qyqVyVc1ftd3azDxKItb62X33aX3OZMnUa2+/BFSbM3YJYTqNKhkQ
IgYJv70oxZGz1NNsSNsvrJJaJvIOk25WemHFgvQ+DJHFGSXjWH0bQGVW8pvqPbyW
behfoQ6K
=fUpV
-----END PGP SIGNATURE-----

--7oe+OhCl1U95pb1T--
