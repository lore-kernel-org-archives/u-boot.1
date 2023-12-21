Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7A6C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139CE8786C;
	Thu, 21 Dec 2023 15:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qM9fxl1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618B48786C; Thu, 21 Dec 2023 15:32:16 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B03D876C6
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78117c8b6ccso51290485a.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703169133; x=1703773933; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=brxwcEUCubIR+ToXpyVoOcMlxQAy3J4RSPVYFTJL2UQ=;
 b=qM9fxl1UYUoBeokAbcZO7OHw0IwFgVq0vYS6AYRtwf+HiJ56+Xt80S13cyvvSNaS+M
 L6pXP+3tapRMLEUAWjElt9GbqTti1c0s080dvBYH45lfekkN1qgAzgB33u5V1QAfjZ4Y
 bZE7n8JZjGc8HMccTJZFUA82x0NYfw1PP8qcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703169133; x=1703773933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brxwcEUCubIR+ToXpyVoOcMlxQAy3J4RSPVYFTJL2UQ=;
 b=K52NRYgzRgWaWJ+h6a7KhNq50N0WB7qwuGP2a8OhGxMvpwOUqn+GCpUUVi5jjV/bQI
 z71Lc0vm+RUOIZIEpxhPFX9R5Y3IcbaoDnBJLuVqhwY3rOTWyEMDouYUQlESw7phtA2l
 VbVaTCMgz4ex24irtdm7ym59ZcKufiy3ok+VFuMz7D7rSzakihyLRcMHfF0Z/MSgrEmx
 aqE65XfOOHqUc1/3sCeS7Xwa7DcIfOf0YiT8Sl4tJwZArWNTq+eB6j0KO1GnCqI9e+e/
 GfFIlDsvYsYXE8NcTzpqLzaoC/qNuOfqxXbyRw2bZZplPOIzKUbObzp9sCekpoMChku0
 ceaw==
X-Gm-Message-State: AOJu0YyZ4J3sj9IBWI7g7gs3nDpqUcOFJ8Yi5I35g/jVueiZeq50Dlrb
 Ic+6GX+AWQpQjZbHJB04Tq41Hs0NAaX9iGpFpH0=
X-Google-Smtp-Source: AGHT+IH1Nhbw+xAEc8X6VUetI8PyXF7AzObkBFNdixcBO14TpfSPjcPsxRt1rJF3JuWXggI9SJSJTw==
X-Received: by 2002:ae9:f442:0:b0:781:2245:e006 with SMTP id
 z2-20020ae9f442000000b007812245e006mr659082qkl.34.1703169132825; 
 Thu, 21 Dec 2023 06:32:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 bi5-20020a05620a318500b0077efb969151sm680145qkb.59.2023.12.21.06.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 06:32:12 -0800 (PST)
Date: Thu, 21 Dec 2023 09:32:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd: fdt: check fdt address
Message-ID: <20231221143209.GH2513409@bill-the-cat>
References: <20231221000011.297145-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f8vz+9D9IupCXKwl"
Content-Disposition: inline
In-Reply-To: <20231221000011.297145-1-heinrich.schuchardt@canonical.com>
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


--f8vz+9D9IupCXKwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 01:00:11AM +0100, Heinrich Schuchardt wrote:

> Trying to read a device-tree from an illegal address leads to a crash.
>=20
> Check that the parameter passed to 'fdt addr' is within the RAM area and
> non-zero.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/fdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/cmd/fdt.c b/cmd/fdt.c
> index 331564c13b..dc954ea7d5 100644
> --- a/cmd/fdt.c
> +++ b/cmd/fdt.c
> @@ -193,6 +193,11 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, i=
nt argc, char *const argv[])
>  		}
> =20
>  		addr =3D hextoul(argv[0], NULL);
> +		if (!addr || addr < gd->ram_base || addr >=3D gd->ram_top) {
> +			printf("Invalid address\n");
> +			return CMD_RET_FAILURE;
> +		}
> +
>  		blob =3D map_sysmem(addr, 0);
>  		if ((quiet && fdt_check_header(blob)) ||
>  		    (!quiet && !fdt_valid(&blob)))

As I mentioned on IRC, we don't sanity check addresses being within
memory normally. The problem (and one that is making me cranky) is that
it seems a number of RISC-V platforms have invalid kernel/fdt/initrd
addresses set in the environment and then have PREBOOT used to fix
fdt_addr_r so that distro_bootcmd doesn't blow up.

--=20
Tom

--f8vz+9D9IupCXKwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWETGkACgkQFHw5/5Y0
tyyDowwAqvozXTOF5YmEuBpO5PSETtvYX/ZimU4Lb0lACy5eA8DolsSYrAYIbpQ1
leE2FvZ3BTtjct4pqc/PKnXE2WoNL436lOb6ZSvvBpXzrU7sPSqH+SBf81ALx4J0
GWXRxmpehfxMusn0s/Qo1q0A2ndekDrM7gNYO47i49Ll3vHLgDN56y+wMWvDR0MR
TioYfcsrv7UZrqxruZNH2esAYR6Gq1Noc2m1cpulBZij5lqUaLPN3F4zroWiTBmT
oIrwe8aaJAlkLPOBgysdvsV8P9LaQoGdcCY8n8t3By8NwCyVsVYV5O9q86WJP1+A
BhTeVEAAW6732c5Y0wt941+MXW3mQ8lMpvcjjBwk3FkZCSYXsFitdbScyn8RJbDN
KJN7IecWJJswDPxuOaZLKZHEnxbMKJNC+ZhOJA44TvQG5uvG9qWy3J1VWfBI38KG
C3C28lpIiVK+SfB9ckMgCyKRED5A4Rf7krT2FSY4Y4XO05kVd7hsFc3oyof1I5ix
U2/BIzpg
=jZhW
-----END PGP SIGNATURE-----

--f8vz+9D9IupCXKwl--
