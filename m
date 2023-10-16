Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20747CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0321886A3C;
	Mon, 16 Oct 2023 23:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ni80RLQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE36B86BC8; Mon, 16 Oct 2023 23:31:40 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DC9886A27
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d9ac43d3b71so5309366276.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491896; x=1698096696; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C0tTaAShIB+usWTMCyhN4/7O0V2Swe8EO/IrCjbThJ8=;
 b=ni80RLQWUL2lKVab7ihoWejKATQBEc8F3vaTwpZdgCsKo7nGJcPQ+QvfotJ2CMAYYh
 WhXJqUSYPwgbtYHJBSnIh6ZRPZcyDM6Bv2ac5IPXloGuhmjg+sY73+zaN/kh32zXfvRC
 yKVW0CQTVCLFBSOHm73rKVTN+YU04dslWmKkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491896; x=1698096696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0tTaAShIB+usWTMCyhN4/7O0V2Swe8EO/IrCjbThJ8=;
 b=VVwfPBGyoNP5qsM/uV/nowHruPpdFg9NmqGiaeT3uz8Z7tCBEwmwJLOhewOJALw0CE
 Oz0BQZz59OlPUUoLN4xg9iAaEbu2iBVrsqRunFkKCWYsoxDThZCs1tfLxJteCzG3Yl6h
 /nWQ7jclwy42+FtID0vuaNQaIhqUdtm/topzzFWMUujzRRRJZ/lVdfJse9MXKjG/SVxm
 p6M/LPskd2+HEDxiprdyG9V8teZVYqAeLBsInIfCFVeD+f8QYZPl9/D/uklhd5EE53AJ
 p+J6twDscOrlgXpxaE9MiD5ehK19Cf+nLYiHnzdAdU42nuZjpwseiR98jnyBT7Ip428r
 qaTA==
X-Gm-Message-State: AOJu0YwwlKOIuYPPNOC2ez++WHipsOxZLGpzL4/2O+H8l0xQyqqO5kHB
 sKuneRIA0A8iihsT6nvJvoVxuw==
X-Google-Smtp-Source: AGHT+IE2/HyVwnC1PG9Wz0y4WMSKlocpO7ot6oZIGrLxYRnVMeLv648y3Di5ZMp5ZIYj4LEPf228OA==
X-Received: by 2002:a25:f303:0:b0:d9b:4bfd:b75 with SMTP id
 c3-20020a25f303000000b00d9b4bfd0b75mr211799ybs.18.1697491896327; 
 Mon, 16 Oct 2023 14:31:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 d14-20020a5b0c4e000000b00d89679f6d22sm2556ybr.64.2023.10.16.14.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:31:35 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:31:33 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] cmd: move mac command
Message-ID: <20231016213133.GH3119521@bill-the-cat>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
 <20230930120147.59482-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dMP2HV/sg8HOAlCY"
Content-Disposition: inline
In-Reply-To: <20230930120147.59482-2-heinrich.schuchardt@canonical.com>
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


--dMP2HV/sg8HOAlCY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 02:01:42PM +0200, Heinrich Schuchardt wrote:

> Board specific implementations of the 'mac' command differ concerning the
> supported sub-commands.
>=20
> Move the Freescale specific mac command definition to the board code.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--dMP2HV/sg8HOAlCY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq7UACgkQFHw5/5Y0
tyx10gwAqSAVdoWw//rBgTk5d4X50k7kha6+gLAcuUUfjCHoAD2ybnywoJ1tYuqH
7yGOrvX3Pu4wvZotIYlHxekTW7MDVtrNbIlFqx/fah40C005QIO9emOzCnr2oFQG
OHCX/Ru1WA3kaLGcG4a9zhxeiPrj21cETJPig5CzF3oOWdQYwaHiMz95cyddtshr
Go4YrJ6nDAQ3z2juh1FNQEOYQcb6PnCR+aAUF5zUncDYsUUe+YqH7dpOyWxuBwwg
C50/KF9+W55rGgPvgPRG9UAwg1dBwu8+5W/EKHHhBaMOR8L8SvvCkynjN5rWLmRn
gBEx1wLkPGIcHtfBdTQDZWXdbJj1zpJes92S/HQOeXd97Z1IQ6mysmQmpqI6p8j/
bqNaDlMXWrwSuNi13d7FCt1pUbJ2CG8Kiuilm4Kx35EtkqEx1JnK8RQ9Ing1Wxuk
xKF3jpFlmYPp3ux6Liuc5elsFOk4bLliGW1dfBbTgWyhzXXPyFevmc8h/9HgUqaB
8caXTGcG
=kHQu
-----END PGP SIGNATURE-----

--dMP2HV/sg8HOAlCY--
