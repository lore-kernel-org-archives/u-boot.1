Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274E1C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 21:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF6D86529;
	Wed, 30 Aug 2023 23:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sx+Qql4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ABC986521; Wed, 30 Aug 2023 23:37:45 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49DF28653E
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 23:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59209b12c50so3194697b3.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693431459; x=1694036259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YVw0P8ZqrqnbI8f8qdkC7qnW0RChVOiS5Khb2nBhugg=;
 b=Sx+Qql4dM/AC+ZJPefr12lynq3WkmehvM+l9rFvjbrzEpoEPIQAxnX5VAGTL/Rwt/y
 JE6CZFHz87m2BVNAPHKqdOdNKKumqjHK+MTwqPdlqUrAfPPb21+RGyW9rnCjdsg9dt27
 BNBCVyF/QOvFjsW8Lew2PVTeKR0IKCCLAGNjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693431459; x=1694036259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVw0P8ZqrqnbI8f8qdkC7qnW0RChVOiS5Khb2nBhugg=;
 b=M5x2i8LaWlqPsdM/4jNYCVKtQ0anPWyIqv1X0U1NoPSSen6Z2gkpljvKm13NZobwr1
 ccgmL0shJfxL9VLsuMqDnSiGQucJAeKXVB7mGQf4lfVwDyAkNpUYgz8ZBh1/Xtxw6xG7
 8nXUtIXnuPmCxrOiC6eEUA6RZmab2+e2cg38qywtp8XDPKZIgyy7IfW+TVe7GQPdCzGR
 etB7wGn1GUJsdrP20FtmE8KcOSkn1x1sQVD80ImJL+Tlyksor7BXIQATqNIiEY/nwoZ/
 OPcA/39TAqW/q9ktUUv/Xr/dsC8DdgAGNv3TPOQMxlOvlikI+Z3PJhGv0+gjAF5RntTO
 gl0w==
X-Gm-Message-State: AOJu0YzVWFmJRQq1vR3bSFcFKJ7a2YDh42Ygvp6SRFkzqY9xNwNfM9gh
 C8CPN+s3NMSMe9dia7a+MT9Cc7CpZn0DtoNvPJmo1A==
X-Google-Smtp-Source: AGHT+IGvs7TZ2tKoyoNPhNnoLqXTftv38R57kxOxhP9VilfjM0bGaql4bsewZQo7s5/kbLm0iJiRRg==
X-Received: by 2002:a81:478b:0:b0:58c:d87b:b028 with SMTP id
 u133-20020a81478b000000b0058cd87bb028mr3397138ywa.16.1693431458963; 
 Wed, 30 Aug 2023 14:37:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 m64-20020a0dca43000000b0057a57a9a932sm26474ywd.107.2023.08.30.14.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 14:37:38 -0700 (PDT)
Date: Wed, 30 Aug 2023 17:37:35 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Elena Popa <elena.popa@nxp.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Mario Kicherer <dev@kicherer.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
 Roger Quadros <rogerq@kernel.org>,
 Simone CIANNI <simone.cianni@bticino.it>, Stefan Roese <sr@denx.de>,
 Thomas Weber <weber@corscience.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom McLeod <tom.mcleod@opalkelly.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 03/32] spl: Rename SYS_SPL_ARGS_ADDR to SPL_SYS_ARGS_ADDR
Message-ID: <20230830213735.GK3101304@bill-the-cat>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xj3qLXjgI81c/IIY"
Content-Disposition: inline
In-Reply-To: <20230830180524.315916-4-sjg@chromium.org>
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


--Xj3qLXjgI81c/IIY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 12:04:34PM -0600, Simon Glass wrote:

> Rename this so that SPL is first, as per U-Boot convention.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> index a569d1a2951..fbf8c10e47e 100644
> --- a/doc/develop/falcon.rst
> +++ b/doc/develop/falcon.rst
> @@ -63,7 +63,7 @@ CONFIG_CMD_SPL
>      Enable the "spl export" command.
>      The command "spl export" is then available in U-Boot mode.
> =20
> -CONFIG_SYS_SPL_ARGS_ADDR
> +CONFIG_SPL_SYS_ARGS_ADDR
>      Address in RAM where the parameters must be copied by SPL.
>      In most cases, it is <start_of_ram> + 0x100.

This was intentionally "CONFIG_SYS_SPL_ARGS_ADDR" and not the other way
around, for semi-dubious reasons.  We should instead try and give this
perhaps a better name to describe that it is where in memory the
parameters for our payload have been stored.

--=20
Tom

--Xj3qLXjgI81c/IIY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvtp8ACgkQFHw5/5Y0
tyymRQv8Ct72SE2Em8ev+YoC8icLcOKe4CJS7oYE7pW3LEoinBAY1W0YuzvcjgI6
obwghSA2vZJJgX+8Af9NXecoq4Wn1g/yUfQKurtZCYWGKtktrwFYFKqabBgZ9Wsx
hXnjfHtSYD4ycJ2Bj9zTLhaz5aopaHQpK12O4VRXhKsyMJS0H2aika1KXV84XWmd
P4pUCf625kzVOlMV7fJc0ND5Hrnbk5nDc56/ufmSQMZxwLC3oSp+UsRN+FUslxmD
GZIX3XaeQuYmmM2refaG6hAV7ZEqTMk2PNN7p+ASeNXWl66NEAo0bV7QPXoIo8QC
hUmiD+N5ByOY3+icXSsDjZUO3Cl953s8Fs1doN9y9mx3iGFx2n7klyeX4Y7LEH6x
OYgeX4VaQ1LBRdy7ZuWF2sK/l2VS2QarCPp/yW+4lEZ0vvoVFbjkKBByZ5lvdsIs
cIqcnPwyx9KcybDOBBqtPklcF5h2zkWS4QLyxrspa449qzQZ0ZIpJioxQRFFrEMq
eUMwcic8
=oZKB
-----END PGP SIGNATURE-----

--Xj3qLXjgI81c/IIY--
