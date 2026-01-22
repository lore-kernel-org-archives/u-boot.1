Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DF4D3EE6B
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 14:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D598397D;
	Thu, 22 Jan 2026 15:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AeaWdcSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE6F83A1E; Thu, 22 Jan 2026 15:23:29 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67EF58341A
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 15:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4041b3c1fa1so343013fac.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 06:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769091806; x=1769696606; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0/kLkxfXOPt5ZsQkHYnv0owhvlfU8SExO7L0d9XxhEU=;
 b=AeaWdcSp2XY9Q1aI4WZQ2zeIxbAGleuYunrhScgjiCcky9E9HYVRbJKzoPaWWJKhXp
 x0Ff7cfolJjk0BJEIMNVcusKYn5Efb6EQTGVxpCF5Nio7ugc0B0Xi2SlAwjML30wiGmn
 WlQ4u4vDaBVUS2kHzbAQbHfKK3AlF8uotNgL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769091806; x=1769696606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/kLkxfXOPt5ZsQkHYnv0owhvlfU8SExO7L0d9XxhEU=;
 b=M6ErFEddAKJ4mERL4myZx1wFt7asTyqE0OoZd1wcNB0QpgjHwIIVM1xuSI+/mZ0WfL
 Z24SqRzZ9hgD6qVLzsHoI9sqRzdPH35hkeUGco2p7IrkNoYqWXY3Q4DTgk6edcO3/Zi8
 qtDUWbrqFmO3dXYGmTc9jJXe5O4oYojelZ/iLx37DHMG2vtdp/AlzNL8hKL9rnEbDS6z
 sAyZC68WTDZB7Xyu36D8IyeuIUcnsmyQ7ATjfz+Hxtn1oMazRywvPu3ssB0hDle/Gqpq
 HwGmqbhj/zzJZECaGOjPM5dgcasvQZo7ZCHDbWV5uBSjXBknbKtHI2qQ3UCNTBANoQjA
 PPAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo80brRo5TP+ZNxI2lCbgmwZkRsDLR41p1Tfo3LwLpnyQ+UKDMi6eKyPT+J4E7vQTOLTgokuU=@lists.denx.de
X-Gm-Message-State: AOJu0YxAHh+bVhJyt7ttqJ0cBkLAUt3rLu7Aw//5n8GA3HNOfRW9Tzrh
 rLVZoU9F0j99ePjJvlLzRRVR9IqSzNduv1UDKCyzuxQ/r1XEUBcUdRBbE2rsPqYx1rg=
X-Gm-Gg: AZuq6aJMXE/SWWBBc5/XFLY5nLks94hz6IRkYBA8et7qFs9L8gb1ko2o8aRO6FPybez
 74rOL6mOXtt3xzZWxqdd6eTec/BSD7EVJq382jny2ICbMEWmzkNMtjrHMJWzw+MPfzxNrApJnaG
 QXhDbqFeSq98ZUcSuJh97eMfWEdfb5twmaK2jJipb9Z0Bks7UVCv73yQcvp2OJe/Kch2/d05T/d
 x9HfKtpgbXQxGBzHAdynvAOFany35Q06lsfVX/eSKTP5HhJp0p7MDnRwJBRe4GMrsIW8zV+hQGO
 cbrdwfqmL/d8bSXCMA9RUB8shaGXsjjkUTMEnA5IcFw5hWY0E5sDGDKsH5a5p2Fnr6r9PaEhO+6
 sMr0CN4uNCmS/CPUZWop/4gPG9QnjvXCHbt5kbWlyuW86gYjhO6jz2454vlfCAFUVQsslgFwIl3
 /k5QCfAo0RmdjkYM+bMAanQ9XuaEKHbRCxKZnnNNGxV0H9GAcTIa/ESO12wwYKfVyMfIZL2pyy0
 goYaoeod+dKDgoITPcbEHw/5TidkWdPU+HJxzI=
X-Received: by 2002:a05:6870:d62a:b0:404:2fe7:e184 with SMTP id
 586e51a60fabf-4044cff2eb4mr9488515fac.43.1769091806065; 
 Thu, 22 Jan 2026 06:23:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-408a00adc20sm466092fac.18.2026.01.22.06.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 06:23:25 -0800 (PST)
Date: Thu, 22 Jan 2026 08:23:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Fabio Estevam <festevam@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260122142323.GX3416603@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YSyuquBVYVj23Lds"
Content-Disposition: inline
In-Reply-To: <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
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


--YSyuquBVYVj23Lds
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 12:22:01PM +0100, Marek Vasut wrote:
> On 1/22/26 4:33 AM, Fabio Estevam wrote:
> > On Thu, Jan 22, 2026 at 12:08=E2=80=AFAM Fabio Estevam <festevam@gmail.=
com> wrote:
> >=20
> > > RV1108 is also an ARMv7 without SPL_SEPARATE_BSS, so I believe it is
> > > also affected by this change.
> >=20
> > The change below restores the boot:
> >=20
> > diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> > index d780a5060774..fc2b7fcb969f 100644
> > --- a/arch/arm/cpu/u-boot-spl.lds
> > +++ b/arch/arm/cpu/u-boot-spl.lds
> > @@ -40,6 +40,7 @@ SECTIONS
> >          .binman_sym_table : {
> >                  __binman_sym_start =3D .;
> >                  KEEP(*(SORT(.binman_sym*)));
> > +               . =3D ALIGN(8);
> >                  __binman_sym_end =3D .;
> >          }
> >=20
> > If you agree, I can send a formal patch.
>=20
> Shouldn't we instead find a way to surely align ONLY the _image_binary_end
> or __bss_end symbols instead of adding random ALIGN(8) into the linker
> scripts ?

We did that, yes. I'm not sure what Fabio is running in to here..

--=20
Tom

--YSyuquBVYVj23Lds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXIy2gAKCRAr4qD1Cr/k
CqRlAP4zX2OXkflBh9UTs5dbAD2Uw0N0G5Jk2MbYeJn3eTaaewEAqDKyp8V2FYk2
JmvItuofBusbYtFbDqrjBZSpIs+17AI=
=IsV1
-----END PGP SIGNATURE-----

--YSyuquBVYVj23Lds--
