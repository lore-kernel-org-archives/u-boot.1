Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1425D44151
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 01:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F64D89065;
	Wed, 20 Nov 2024 02:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SCycw+Id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE9C78907E; Wed, 20 Nov 2024 02:23:43 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2F589065
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b18da94ba9so36429985a.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 17:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732065818; x=1732670618; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X309anatGonQjwfZNm/NEjg4Eywb16dGGsj0YiqRnWk=;
 b=SCycw+IdH7VurBOZRjab96OFioRF2YHtG5mlc+Fshv/8bxDzaHVVvtj9pl4IG2e8rN
 uPWH/BV2SBZ/rvIH1daPkjExOLcAAP45ZZR5C7Bb2q70PtuuYRuxwlXCG2CvDSCx3h/W
 Yo1TKKkdO+nTUJrbIRF3Fu6q29enS7/gg8DOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732065818; x=1732670618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X309anatGonQjwfZNm/NEjg4Eywb16dGGsj0YiqRnWk=;
 b=RCKcXI/fKrwp7HX1XRy1rJJ5WRf1k0LnwJuvqPTtX+5yUD70+KJJxOsdY79aMbiBLr
 ztKOLnN6O5EUgKRl45t8EqHpDvWSswriNUnA6r7oZK/24APu1bVd4q7YmlvOHVZ5+uFP
 IUk+86lqjrzpVEXEvgK/Jc/Q1QksVsKCew0trHdyiFGkrJV0Fx9Ayg/b4I5EIsspN8nS
 Iq+4jJ6wq9Vhp5i9H2ah92aRi4HNCfLctTayb19vzZmGQ8jOItO0ko8XvUg/mjbU+Z6D
 6zza7Ash6DAqlZ/syUOCcCvm8X8UCqR5nBXm2IOr8hj9zuxhUgRvU1XOx31Zbefasf7e
 F58Q==
X-Gm-Message-State: AOJu0YyOzHo6v6kNfl4UVvGBq6TZJgiii5jRY6CLQGBPl/VRgB9He5vX
 iNP4R936S7k8hpaYK3XsnrZHrJAECM5DLHJdq+UwyUIpf03gxm0UiFJrHtO8EmE=
X-Google-Smtp-Source: AGHT+IFMlDGZjqVt3P+k9DmE6V6RXiPpJJb3TTJAgd4v7ajRaTQMtUumYfJ1XETv4zooHMD9fb30vA==
X-Received: by 2002:a05:620a:414c:b0:7a9:ba35:1863 with SMTP id
 af79cd13be357-7b41e410587mr226575585a.13.1732065818445; 
 Tue, 19 Nov 2024 17:23:38 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b485226c9csm28101685a.71.2024.11.19.17.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 17:23:36 -0800 (PST)
Date: Tue, 19 Nov 2024 19:23:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>,
 Alexander Dahl <ada@thorsis.com>, Fabio Estevam <festevam@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Robert Marko <robimarko@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>
Subject: Re: [PATCH] arm: mvebu: Add Allied Telesis x250 board
Message-ID: <20241120012332.GZ3600562@bill-the-cat>
References: <20241120131556.1.I395d95af213e80340ae53152f6a49fc86c5f0c69@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sit6l9kpAcN9IdKp"
Content-Disposition: inline
In-Reply-To: <20241120131556.1.I395d95af213e80340ae53152f6a49fc86c5f0c69@changeid>
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


--Sit6l9kpAcN9IdKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 01:16:00PM +1300, Chris Packham wrote:

> The x250 and SE240 are series of 10G L2+ switches from Allied Telesis.
> There are a number of them in the range but as far as U-Boot is
> concerned all the CPU block components are the same so there's only one
> board defined.
>=20
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
[snip]
> diff --git a/include/configs/x250.h b/include/configs/x250.h
> new file mode 100644
> index 000000000000..5a3f445e218c
> --- /dev/null
> +++ b/include/configs/x250.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2024 Allied Telesis
> + */
> +
> +#ifndef __X250_H_
> +#define __X250_H_
> +
> +/*
> + * High Level Configuration Options (easy to change)
> + */
> +#define CFG_SYS_TCLK		250000000	/* 250MHz */
> +
> +/* additions for new ARM relocation support */
> +#define CFG_SYS_SDRAM_BASE	0x00000000
> +
> +/* auto boot */
> +
> +#define CFG_SYS_BAUDRATE_TABLE   { 9600, 19200, 38400, 57600, \
> +				      115200, 230400, 460800, 921600 }

We really can't use the default table?

> +
> +/*
> + * Other required minimal configurations
> + */
> +
> +/* When runtime detection fails this is the default */
> +
> +/* USB ethernet */

Dead comments.

> +
> +/*
> + * PCI configuration
> + */

Probably doesn't apply to this section..

> +#ifdef CONFIG_DISTRO_DEFAULTS
> +#define BOOT_TARGET_DEVICES(func) \
> +	func(USB, usb, 0) \
> +	func(SCSI, scsi, 0) \
> +	func(PXE, pxe, na) \
> +	func(DHCP, dhcp, na)
> +
> +#include <config_distro_bootcmd.h>
> +#else
> +#define BOOTENV
> +#endif

And you should move to bootstd.

--=20
Tom

--Sit6l9kpAcN9IdKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc9OgkACgkQFHw5/5Y0
tyyqKAwAgx/m3wPstq9q6K9i9bekK/aQMNMUBkzh3miDJYs2V7rAHJPAJP42LwZu
7wJzrRdLtirstX8587ZggJ6kL+rXl6HHA+GacbI1+aoIuJq5iGujEGhMAP/M6CQ7
yU2PnHxYkB+mXKEtV95DyAdroMjGT5cG0UCRL2qSBEz99LqCC2Qg2/dDq5IkW/0H
Og49b5YF8TKwrhSTo0OYALJeQ+rFwgFK4uyyT//5uwRlqGrREMROU4gHuTzr7Ieh
lhJPn0dKF8xWoSQliE/JtDavksYPJfO1psqnDMuEBydz6bqapSpHD/TZ4RA7wRYy
gwHSpQz6hZlZE5sSUqfKM32rGIz9Kgj2GuvQPWEJ0Uykx0nJuD1XWHSR01rGoTho
zV/gZGbLEm/nooP84Me2ABc4M4fSsUZnUluz095Mulh+QvASu0Gcq+8UU+/oFItq
gzTkriMFzNwowCC1LusuOl3j7WZNwukI2K3bA0f8lc4TX4BolyOT22rQoCyvYNBP
mywfn/WU
=PJOH
-----END PGP SIGNATURE-----

--Sit6l9kpAcN9IdKp--
