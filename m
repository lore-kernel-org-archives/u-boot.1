Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898BDC83F35
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 17:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C5F865AB;
	Thu, 31 Aug 2023 19:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q9qfGV9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771E6865AB; Thu, 31 Aug 2023 19:51:02 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B871286553
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 19:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-58fa51a0d97so12268567b3.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693504258; x=1694109058; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r786V2MlLU7w+ofcoyd65Dh+499Kzo97mxiblWLnDpM=;
 b=Q9qfGV9EQ7AoRg8k3dwk0/8/tTVrwSlh3py2gw6CrgaeGabC2F9kRrLX0F8iyKXpdT
 xphmIlkT9OocPNNZ0XTraAJe3awg0t9aaLtrD/NyV6D1duaIPxYgSE+doi6rDjvzAzKb
 U783ADqsNhb4YVN38j3G9Sv1VYGAExC+aSWjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693504258; x=1694109058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r786V2MlLU7w+ofcoyd65Dh+499Kzo97mxiblWLnDpM=;
 b=S+y0+2q5vovSW7+hIqFRa/BTKGa/d7voEkEbuBRa286XbQ+WL1DOkJyN9KRfE8U5pP
 xv+XPT8GKBEuoeAfJ2eJOMZx+VsgSmGT3HAxJdHIWvM/Bula1Gk39Ex/SkSQLCwBbyao
 Wma3DDF3zZ+pMl09Najo6DmF/HLgqGzbey1DGZ9qIB80rMr/mr9/qCimRQqao/y3t1v6
 XUbDTRdcWCTzl67Ecl7oIvFT0K+UgqEBdavmn7pG2hYe7BsQOj7VeBxkPS9u6DNNzWzZ
 +Pv1/2G18ZqzL97UI/+0vEWytD8bWhj1Cp+m0cJWSQH5hpJzFKd8GuKXF3g6bi8JZHtO
 e3lw==
X-Gm-Message-State: AOJu0Yz/jZ/VdzBVvDZJ8kjhh0zOvvjqSowQYGZYpoJV0NgmhqpYxn1c
 mGjRYIUWkI4usjpwZRQmOFq+ag==
X-Google-Smtp-Source: AGHT+IFkTmGx83SkpRLsmf0lVm7ZopZX/wVB1PIG1OcDlGecRTjBY9UhZZOqMKB9XJpuPr70sU2Tdg==
X-Received: by 2002:a81:9191:0:b0:589:fb81:dcde with SMTP id
 i139-20020a819191000000b00589fb81dcdemr159367ywg.11.1693504258482; 
 Thu, 31 Aug 2023 10:50:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 y191-20020a81a1c8000000b005928fe005e3sm557951ywg.25.2023.08.31.10.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 10:50:57 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:50:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Andy Fleming <afleming@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 05/32] spl: mx6: powerpc: Drop the condition on
 timer_init()
Message-ID: <20230831175055.GN3101304@bill-the-cat>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VDrd2RvldM0gnqn9"
Content-Disposition: inline
In-Reply-To: <20230830180524.315916-6-sjg@chromium.org>
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


--VDrd2RvldM0gnqn9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 12:04:36PM -0600, Simon Glass wrote:

> It doesn't make sense to have some boards do this differently. Drop the
> condition in the hope that the maintainers can figure out any run-time
> problems.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/spl/spl.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 78db9ef5318..3f513b0563a 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -766,13 +766,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>  		if (spl_init())
>  			hang();
>  	}
> -#if !defined(CONFIG_PPC) && !defined(CONFIG_ARCH_MX6)
> -	/*
> -	 * timer_init() does not exist on PPC systems. The timer is initialized
> -	 * and enabled (decrementer) in interrupt_init() here.
> -	 */
>  	timer_init();
> -#endif

PowerPC might be a little tricky, did qemu-ppce500 run?  And please
reach out to some of the iMX folks instead of just dropping this and
hoping it works.

--=20
Tom

--VDrd2RvldM0gnqn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTw0v8ACgkQFHw5/5Y0
tywWGAv/aSAY7GAbqYb+vqMOxWS3fziyg17loWaMJkCy4YAvvmrjgnHhJRlWqTQh
j2uFc8BSqYoWym3WwRkhxf11r7CZQEWKVm5Hl/0xW7AcwKLmzwYpCu+KA2AInMbO
INtMCL13LmjtgAHcFCQuuFTyKl8eMjKaTsM734oXlTs2TKAwtKIVbbIgljWwjFjc
+Cy/wif3TlrkRqq4AvhyjFijTOH9Egv4CzME/qsVB+zao7m8ZrmtY0nvnq9M3Dpo
g5ahxtlo4Vtr0eYWQgcwlJX1Gn3WuyhsFlegrTf1o0bhHhKLosvTCL+BdkKs74tV
dQDyuozBMZkeYjgHCrfNHzt6ulQBeN/c+5pPdMMJO0F77i6ZKTI6w0seXE185Yad
socsq//y4GG3awk1hky1arHdoEO7M1NVME7y/pYUxVTKD+v+/Yc9OG8OZVVJLS+O
UWzvkNlaw3gMf6w2CXv7wAvjkQO/+csuanAZ3FfJ9R/EtnvwSw9QoOtZlrWKtilJ
n/pXXK/n
=YMJO
-----END PGP SIGNATURE-----

--VDrd2RvldM0gnqn9--
