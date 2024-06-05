Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B2DC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 20:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9158488365;
	Wed,  5 Jun 2024 22:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KyhoGqwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2401388356; Wed,  5 Jun 2024 22:23:29 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEE5C88103
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 22:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5ba68cc920fso563055eaf.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717619005; x=1718223805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1nZWqqAxUESuKpQdmF2Mogf7LJwlQqF23/kGfvvjOZE=;
 b=KyhoGqwgvQ7Dj+MMrvK9HWusqVa7hNtjDuLFyjbWufZaYn37HF5VzmCg4/6hTVNWKq
 52xH1815NfgQviCCwmHWrZm0+Oy2eah+rHDFEdFLZQl05IY0giTUlSj/b0eBOupROExz
 JAaXtjDIohRz+CE0Sa+8AKANQkjKhzasacwS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717619005; x=1718223805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nZWqqAxUESuKpQdmF2Mogf7LJwlQqF23/kGfvvjOZE=;
 b=eMXZdRoJNOexU5+9VVR0FZKrrCZFMtgVzZ71lc4fXtStZ78l0pLAcqFGSz7x2DC2fR
 J5Jktc3wK6MesK/xjmkNK2yBR+vZRblcG2/rCPtl1clQqlG03DvmpLJxpf+3IBV7aStS
 CkuhqxeDW4LoStxCUw1OSzKhxTuhvtX3lsmlO++tU/rXU1g5MCCG5ygcdBKifxj1Q0CS
 SwWy1NV3FQd5/zglA45zBQPTohdVzDWh9P+bsFh9tTRIzuD8siiu5Of1/liagTBoYuVC
 Fcl245NfVb9MXU/pFO/IkZNqTy8lxaF2I3BXvycO/v4bw0dZqKPwkTn7N73a0NLbeMlL
 XfJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViwN28JT9Qrr5vmw+K3ktXlrXXZl1c72IhygBR3+QjuK7R9iQ/azwizjyqwGNTnpIw8vDKVMxZLbpYcxBqvFdj4MQbNQ==
X-Gm-Message-State: AOJu0YxvA0dxM4j8PdHKTD65BeHA+w2g6qsBPJBTGvdXNYZdHicxVKl7
 o4tClvcf4nvQz8Oah0uoQQ1yKPG+FSeiQ5ezrgrPCvXYbE0CEb6oGSaxv3PF1KI=
X-Google-Smtp-Source: AGHT+IFTF56mOdDewqcCFsK3t+lziAdvKsDhdIbKlGF8vCUOGJG+Is9Zg+B7XoeLuHXjdjIRIyeLgQ==
X-Received: by 2002:a05:6870:9709:b0:24f:e09d:3c6f with SMTP id
 586e51a60fabf-2544077a36emr347241fac.23.1717619005344; 
 Wed, 05 Jun 2024 13:23:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25084ee76b8sm4173568fac.1.2024.06.05.13.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 13:23:24 -0700 (PDT)
Date: Wed, 5 Jun 2024 14:23:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dmitry Dunaev <dunaev@tecon.ru>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/7] misc: introduce STATUS LED activity function
Message-ID: <20240605202321.GX68077@bill-the-cat>
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zf0dEVW8gE+6/TQB"
Content-Disposition: inline
In-Reply-To: <20240605192146.19052-1-ansuelsmth@gmail.com>
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


--zf0dEVW8gE+6/TQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 09:21:32PM +0200, Christian Marangi wrote:

> This series expand the STATUS LED framework with a new color
> and a big new feature. One thing that many device need is a way
> to communicate to the user that the device is actually doing
> something.
>=20
> This is especially useful for recovery steps where an
> user (for example) insert an USB drive, keep a button pressed
> and the device autorecover.
>=20
> There is currently no way to signal the user externally that
> the bootloader is processing/recoverying aside from setting
> a LED on.
>=20
> A solid LED on is not enough and won't actually signal any
> kind of progress.
> Solution is the good old blinking LED but uboot doesn't
> suggest (and support) interrupts and almost all the LED
> are usually GPIO LED that doesn't support HW blink.
>=20
> To fix this and handle the problem of device not supporting
> HW blink, expand the STATUS LED framework with new API.
>=20
> We introduce a new config LED_STATUS_ACTIVITY, that similar
> to the RED, GREEN and others, takes the LED ID set in
> the LED_STATUS config and is used as the global LED for activity
> operations.
>=20
> We add status_led_activity() that simulate software blink.
> Any function that signal activity will call this function.
> At each call a counter is increased. When the counter reach
> the freq value, the LED is toggled simulating a blink and
> the counter is zeroed. When the counter reach the freq value
> again, the LED is toggled again and so on...
>=20
> Call to this function is added to the usual operation for
> recovery. Currently added to tftp traffic and mtd spi and
> nand write and erase operation.
>=20
> This also contains a big fixup for the gpio_led driver that
> currently deviates from the Documentation and make the
> coloured status led feature unusable.

Thanks for the work here, this is quite interesting. My only real
feedback is, can you please rewrite doc/README.LED as doc/api/led.rst
(and add it to the index), and then document your new functionality
there as well?

--=20
Tom

--zf0dEVW8gE+6/TQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZgyTkACgkQFHw5/5Y0
tywn9Av+Nt+h5d5KO6Qoq39cFnUcuG7+q99G/21gerMr9COeAPba/e6OsVEpZVpP
EcWQNsXMkXnpoGuSRYtphnQM5TWVlj/mTPSItbhCH1zejuG44nf+JloKGzDsmRW7
NAv7d0ur4Ac/Aku0eFMvnl5gevewARo5WrvICUDv3QD+WoxKJ4i95s/wcZvsDZnR
pTRaftYpBZeTyCX2XlB3IpBo68IjmgSkEqx5vWPx9ByAtNcdJ7mclbicqtcmSYrS
0bEB3/VITlY+Bw7dwXul1aRPM8ECnvjiclxv1Dsz1rgKSSONqgmkT69VNgnKjzDQ
C9dZN2UskVWR4vUU6js4O3o9Apw83dJO8qPAGE5vGGGVAT91/L6P2aBt9mpqI172
EZB/OHMbNKCaWbzL+7V3TQii5rs0W1WyOzfbgUiuMhjCk7f/7uYVVfITfP3gvotv
UEuMCiA0kgoRxkI7Puluh/9KPgdZKbWwOMMkoldem2WrdMaXEF3Us52fjj79N04v
vlqNggfT
=9jYo
-----END PGP SIGNATURE-----

--zf0dEVW8gE+6/TQB--
