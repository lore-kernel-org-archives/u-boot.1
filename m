Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D2AC3DA61
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 01:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763A08893A;
	Thu, 25 Jul 2024 03:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="htItPw6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E804889D3; Thu, 25 Jul 2024 01:08:01 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F246A889C8
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 01:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3daf0e73a5bso216015b6e.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721862478; x=1722467278; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YNnSQdEtyHbqhg/Ez8xdvDNmKGv5WZevN8heQJi1Vxw=;
 b=htItPw6i28FFi9LyjjKcZnuUs2ld1w5ZrqEhWxOZZ/j5KyLVmDpHyZMpze4+BeDV9g
 3o7ZF2fVXeBpZYxbk8Qbmywm+BBbfbqPPv2przEqTeV4tlO5n6wO+efxo8KM6tAqn6M6
 14/tFZ1ot468EL4hMxmnjfBATBnUKNBIGXZKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721862478; x=1722467278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNnSQdEtyHbqhg/Ez8xdvDNmKGv5WZevN8heQJi1Vxw=;
 b=Lt1Zz9MfA7qIsTtsMctCcA0+kWfAShvKZOQSf1Oo9yiT8bhuAv00u69Eg4T4fL9PA5
 8BHeRXrtN80Q0MvxqKGcjdqnXGYvtaCtPiGCexCer1TeMP4sbg/lYAN6MWYN+Bf+562E
 bt4L4hHkxMLx6miUDe6CCmjsgq9FahEBPig1F4Y2x0n6pBe19omLCjn6DBuCHYn2D0wt
 t0EHCOWRYrq5eO3TthTeiXSvs4N15RkYNLtOjc6WDbFDWsSAU20DHGsmzXlPM4C5J/Jo
 +aAarQT6Em1K/SBOmF/xFJhysBrR4a4L6mE6R2bMR7hxReJC+aOAk2KZ0uVzuUFGJxyd
 YwEg==
X-Gm-Message-State: AOJu0YwKwIDUMd3EeOfReShm8ApYfAoU380nKcvls1gN2rB9biLsFWrN
 wP0XdrBcB9GW+iE/ndLs40JY6gHkekkYGgRifGp4WWYK8Vq2QwSgea1Tpoq6dEQ=
X-Google-Smtp-Source: AGHT+IEM5HQRTZttG75Qvtn/6xq5bA4JVjb7ezmK/30fLEBbAnWwqKp9p4SBV307/YwY2DBBi5B+Xw==
X-Received: by 2002:a05:6870:c6a8:b0:25a:eca3:6b59 with SMTP id
 586e51a60fabf-266ede16c92mr257200fac.40.1721862477565; 
 Wed, 24 Jul 2024 16:07:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653cfcf7edsm70732fac.3.2024.07.24.16.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 16:07:57 -0700 (PDT)
Date: Wed, 24 Jul 2024 17:07:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Aaron Williams <awilliams@marvell.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Anatolij Gustschin <agust@denx.de>, Andrew Davis <afd@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Enrico Leto <enrico.leto@siemens.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan Wang <alison.wang@nxp.com>, Ilko Iliev <iliev@ronetix.at>,
 Ion Agorria <ion@agorria.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 MD Danish Anwar <danishanwar@ti.com>, Mario Six <mario.six@gdsys.cc>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Stefan Bosch <stefan_b@posteo.net>, Stefano Babic <sbabic@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Troy Kisky <troykiskyboundary@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH 00/35] global_data: Reduce size of struct global_data
Message-ID: <20240724230753.GS989285@bill-the-cat>
References: <20240724150922.2343249-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HDW8Ax9korKIENGd"
Content-Disposition: inline
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 25 Jul 2024 03:43:02 +0200
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


--HDW8Ax9korKIENGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 09:08:47AM -0600, Simon Glass wrote:

> The global data structure has grown quite a lot over the years, being
> the best place to put an important pointer or something that must be
> accessed before and after relocation.
>=20
> This series attempts to reduce the size a little, by moving some things
> out and shrinking and aligning some fields.
>=20
> Some fields are needed during init but not afterwards. To deal with this
> a new 'boardf' structure is created, which sits on the stack and is only
> present during board_init_f(). It is possible that more fields could
> move to this struct, but for now only 4 are moved.
>=20
> An assumption is made that an int is 32-bits wide on all architectures,
> which seems to be true, but maintainers should be able to confirm.
>=20
> Mostly the code-size impact is neutral, but the patch
> 'Use less space for environment fields' does increase U-Boot's size by
> about 30 bytes on aarch64.
>=20
> For firefly-rk3399 (64-bit) the size of global reduces from 456 to 368
> bytes. For SPL it reduces from 416 to 272 bytes.
>=20
> There are other things which could be attempted, for example:
> - Using hlist instead of list for some lists
> - Checking that only necessary fields are present in SPL

This is good, thanks for doing this. I'm planning to grab this in to
-next once I open it.

--=20
Tom

--HDW8Ax9korKIENGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmahiUUACgkQFHw5/5Y0
tyza2gv+OfaC8X/9Hfdu//t5+GgEhlID01weLd8DvBviW/GXAhcOqjles/R31RNi
qZA/9R1Y11wYE7gVt55ekZQyNBfMec7v2xdhoPzm4xor0Tz6YIujDqnd/yOU5H7n
cKWEcFIaiWMRU5/kAD62be8bf41XurMq9rYq6U6TPhtHwxrkFvSGFp09FhYrmAyl
cWk4+O8O/gOqNaalRFHwXJpJQNT0Hmqa5rznrkowaHI2HEpRotHQfQdlpRPXs+XQ
wgxm+Ii4JHV0HmemChdAcrgZ4xlkTtSkd42BtRIr+ATLXuhKBDYCAUz4A/4Pihjd
AbchbhEukQFXvZFwiHBABSioSfjGdhjoY5F6VhoFSpReXxAIv72rQZ+5nBvLy+EH
CDGyb5GU4cu7OTf0LQU8frPKOw1wN9QBk9yo8h7ksGIiB6P+whmfQgfFd5yMw1nP
qDOa0lBApu1uXVkWJ8n6Z0NvrVb4YiBSBvnRTvInlDGMjktKNMY7BqlbpWM92HR0
l7URf8RS
=8ucK
-----END PGP SIGNATURE-----

--HDW8Ax9korKIENGd--
