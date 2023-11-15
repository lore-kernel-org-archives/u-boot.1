Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC525C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B57987465;
	Wed, 15 Nov 2023 23:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DRGwcTrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A9787454; Wed, 15 Nov 2023 23:37:15 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 913F8869F7
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a84204e7aeso1669537b3.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087832; x=1700692632; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zgaRvPJx4QKlZPOhUeWQTbVYJemn7tRofUhAc75hP2Q=;
 b=DRGwcTrNlt3QO9D/wld9yXwD9Twc+/Ho85a/fCmt9ppimcaJzyya2lnyQ3uLjAXa5V
 T90rvv0F4ACYQZr1fJnVhbKcBXaKzQiwZXF1qyAHCrO8rjg46ASMnHCutUnlfod3rqGg
 opgYGc18zWSgs/dNIozMccomUjwO1af9nk7tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087832; x=1700692632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgaRvPJx4QKlZPOhUeWQTbVYJemn7tRofUhAc75hP2Q=;
 b=JnfqGKWhUbF2UGUVh5bpMKtyUTrij3wtA2XOaATvAYxGG+TZbtS9A/BG59C6EZNJNh
 osh7MBVpZgW0Vi0NF02gD+M5miwbt6HR3FELfbExK8LrmztkK5gcK9n0KnsW8UMVWfly
 ZC0WLUjhwXJiVWxhkQ5Cn4waIcmZ5aWNchwEaEOvnKgg1vi543J0YfZvSZTe8yF0l3D6
 mbMA78N0MnyFSqdAiCXg0Fetve5QPgEWYIq7VkAZ5aJooy5vmJkAJ4Wa3nA5qFeM8VfS
 Rhu5pgJwXALSDbuyxvhxMMrObt+/qlX6DG1xGerkoS6rQSERI91I0hzH43x3lYtk8YYT
 +wsA==
X-Gm-Message-State: AOJu0Yx/e9A5+Cwb+ytsxAoiRuBsjylB9TXxwKsDhZg1eN02WBplAAVX
 5pue18mQQ1XTYKxhlKCF8p8MNA==
X-Google-Smtp-Source: AGHT+IH1nQEbRD4m6j8OgYE2wGgFIDrqiDSSwFNolyEAmMc8nLUYPBe7AJnuoA6qjZNvmgoZjaeZ0A==
X-Received: by 2002:a0d:f9c7:0:b0:5a7:b819:648f with SMTP id
 j190-20020a0df9c7000000b005a7b819648fmr15258632ywf.4.1700087832323; 
 Wed, 15 Nov 2023 14:37:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 mm9-20020a0562145e8900b0065b0d9b4ee7sm877117qvb.20.2023.11.15.14.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:37:11 -0800 (PST)
Date: Wed, 15 Nov 2023 17:37:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 15/29] bootm: Move error printing out of boot_get_kernel()
Message-ID: <20231115223709.GW6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-16-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xzp85FY56AQWOOqE"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-16-sjg@chromium.org>
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


--Xzp85FY56AQWOOqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:00PM -0700, Simon Glass wrote:

> The same error message is printed in two places. Move it out to the
> caller so we can avoid passing in the command name. Leave the bootstage
> handling where it is.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> @@ -322,9 +316,12 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int =
flag, int argc,
>  	int ret;
> =20
>  	/* get kernel image header, start address and length */
> -	ret =3D boot_get_kernel("bootm", argv[0], &images, &images.os.image_sta=
rt,
> +	ret =3D boot_get_kernel(argv[0], &images, &images.os.image_start,
>  			      &images.os.image_len, &os_hdr);
>  	if (ret) {
> +		if (ret =3D=3D -EPROTOTYPE)
> +			printf("Wrong Image Type for bootm command\n");


This compounds what I said on the earlier patch, yes? Or can we not
actually get here via booti/bootz as their header checking kicks in
earlier?

--=20
Tom

--Xzp85FY56AQWOOqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSBUACgkQFHw5/5Y0
tyyrTgwAszHO0JGVzrM6phrGtyxADdM9dsCi0tR9Om35hBQU6D4etfSlXP1p/rk6
E9qA5IjThQllx6ay2iTEBx0LVMiyOcV7bek/xgb/pLe/CuOmyEMnwbzs+9RirSB3
mOWlZVkY+K0js0cOMUJpY7A06ygyT8gfF+3yfwggPyqXj1jHSo8Rk3FML7j6o/nl
i6QewtKSoaSTI6gbS0Fcevbyw4Uz5QrxBhNsmMRUpPPucqmcEKpHB3ynQ0ZJLFM4
XMimsZo1eDQnNE0+AD3WX/1+F5GpeaaOUW1fkeaVGdZ54UxD2BXmeSsZWElsiRSu
3/n4TbCJptUc0yHEmDhGHS1Eb/+V97KChLMj4q5gQoSz+Rc3vhLWdytI6ulbsnDv
HRMm2y8K7HEyLPSwwuWHeIpRbHepldEMuEEVy5WAavkKhcWlqSMR9aMfL9RB5S5M
odP+/zRWOnB/lq3P7JBu2fbzlE2WyOK2Quw4yfJy9lkq7LNLS4qyHjUYnA9nQze0
LWazYnBv
=dvN9
-----END PGP SIGNATURE-----

--Xzp85FY56AQWOOqE--
