Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10BACDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 785E286BB4;
	Tue, 17 Oct 2023 16:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="szhddqj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD4886F03; Tue, 17 Oct 2023 16:07:47 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68FE9803AC
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7a80a96dbso57529967b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697551664; x=1698156464; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PS9K86cBxtow7HsAtjlzx1+fU9QGvsIWI6WsIq2nCUE=;
 b=szhddqj2KAojzdU7VPYYPkfEZJQU6YhuK7XLuvO59PxWwew3A/n3pJxXyZMH3uC/KV
 IzoWcY8yYoPP464DxKnXrXii+zHFx7f2KAExzNxqUg2BfcCu2PuPGLy2aU1rJdRDIV9f
 shrpvP11So+z5++iKwvCu2Dt2TA+PXkCRIZe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551664; x=1698156464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PS9K86cBxtow7HsAtjlzx1+fU9QGvsIWI6WsIq2nCUE=;
 b=Qk5YkCwtt4Ak/CDFU/ZI7GwbIxnmu8IHu5/dQ+FUcuUj7ZFTnyQKRXZ6WpieQ8ZCyd
 tzp0c+VMXj/tmHgFtwT+51bgn5LiZeHAhvzrrPFBfJ2L13lNsANyh/jVAFEXO3JC3VIW
 1dCHaNnDxZUbJz/qBpC9Eqj+Q/HMWRlxvmRJbsoEQds50aE0NEEFE5D0V8jAoAKa2knK
 4FCrK4DeNolWJMpBjGuvotBqZkBZJ+iyY00C+5h8MS3DGf9XBP3Eh0LKPpl47H+OvJH1
 kShHoLwy4Mj0A26rOMLCSua8G1ut5DQboMTeusOys9ZWGjUK7yRMS4XwfWq6SfD+R/yd
 wjjQ==
X-Gm-Message-State: AOJu0YwCqg3wNmy+YrBBMB9MKjUNJEx6FwlyhXhL9ITiwYv1lZxscjB4
 DQNss1HExkoMsqsBzWVyqQDK8KoPLS7vSJzPYSi+2Q==
X-Google-Smtp-Source: AGHT+IEFb6R6Fn1bOgeEeSHWG/34xb5C0hmxovCshijOKics993By3Sx+MRB6aYX5oMOvqBGdA4JLQ==
X-Received: by 2002:a25:7708:0:b0:d9a:483d:8984 with SMTP id
 s8-20020a257708000000b00d9a483d8984mr1399743ybc.17.1697551664190; 
 Tue, 17 Oct 2023 07:07:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 f67-20020a256a46000000b00d7745e2bb19sm537230ybc.29.2023.10.17.07.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:07:43 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:07:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3 19/32] video: Dont require the font command
Message-ID: <20231017140741.GA3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-20-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5nvHGLP41uVej6PF"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-20-sjg@chromium.org>
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


--5nvHGLP41uVej6PF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:10PM -0600, Simon Glass wrote:
> While it is nice to have the font command, using 'select' makes it
> impossible to build the console code without it. Change this to use
> 'imply' instead.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  drivers/video/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index ab927641bb7a..21ea5c860cca 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -180,7 +180,7 @@ config CONSOLE_ROTATION
> =20
>  config CONSOLE_TRUETYPE
>  	bool "Support a console that uses TrueType fonts"
> -	select CMD_SELECT_FONT
> +	imply CMD_SELECT_FONT
>  	help
>  	  TrueTrype fonts can provide outline-drawing capability rather than
>  	  needing to provide a bitmap for each font and size that is needed.

This is one of those cases where "if CMDLINE" makes sense to add
somewhere.

--=20
Tom

--5nvHGLP41uVej6PF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUulS0ACgkQFHw5/5Y0
tywOpAv/U6x9yTmR6gbDDZnc4K5P6Bs/3kGULM+fwXgL40iY5dp/bAUK/VsPCSYB
UhF5MNEYxzdy+uqd+DQRdQdgsoKgjG2AA4SNDSBm1nLZKVKOemTn7jUzzGQFW/2b
uPlxZqDA3qo1H+KDYKr4DdyO/Z/HQ+uqDocdEyYnvCwJ/tB02YKmrqH2bEuSxWj6
tha2+C8O1juU/RGzVdn2tzORM6EBlYkUA+oY3sHLMYpjEenSkunrr+bkj5cNveFQ
N04xPx8QAyQQ9zO1hPLYd+4U2FcSh/FwAlAHTajYtlnqC4qfzWjIG6I/F0u5DE8s
DB3fWwdPs7m3lZBGd/ICpL3kvd0XjD1iE05B+Q9QG1evBAl0jjRGN9kbe2A7GW3/
bN+Qc5vpd8g9Kp/LAIPW3/J48BShKFquN2iSJniYAsQq4rF9TdIMU4b79n4C3gxL
cggYnhLjpT/Ih1Y7wtVtJFZaCghrl4tODaFO9DhtVrMeu92koSwZRa/FRDZ5LMZd
o8Rbwd22
=MhjD
-----END PGP SIGNATURE-----

--5nvHGLP41uVej6PF--
