Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C50C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 18:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63CC988DEB;
	Wed, 21 Aug 2024 20:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Uv+GRwFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB6888E11; Wed, 21 Aug 2024 20:00:27 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A12688BC1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 20:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-273c8514254so148869fac.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724263224; x=1724868024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5pRyG8hcfspt9gV4qca2stmBtfUvalEUYBxG3DquZ0Q=;
 b=Uv+GRwFcry3kCNyWHRDwY2OG8W0bx+OzYTwCCvSqE22vnl5gjf7rJgsDhuc1KlJVBa
 47TFjsbTwTeeY4qoTs+wC8FURv/V9/IEuErfkYudxhftnYjWBsOvz6t/h5mIa6uqQHAD
 PXjmQWl4o0pMW5KIpFbKJ4d+VjUTxmHeTfcnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724263224; x=1724868024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pRyG8hcfspt9gV4qca2stmBtfUvalEUYBxG3DquZ0Q=;
 b=pvxxvPcT2yPcYTj84ffsv894Dzvr4EhG5Wo0tDafmlIxmjUJxN9klusb7ylC82dYv6
 pPCf0/umjv158dPnRPsqEM2CWlfD+SvB8azi80asctX0zqUCco9b780Bkc+b45zrJJY9
 MeIB4E3AekV9u/l+y++eHrpR3NQK6a+qHj9uMpnpJZ6KHkmEiOjrju6jOZAr5JVZiRAY
 mRihGDK3eq+z2rkWcxeIbX8GHpD2hvqrbfm486xNX6j7W1BSEfNFCw3eeSVgJSZ96UVg
 ss/QS/Or6w4o+X/GK+n6vrjggUgpZVar6s7tokJm5T4s7LPW8VWh36Y+7Nkh/lpXEnRj
 tNwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN9ennFrb/xdIvaPIzejEX8VNqk0hrO8zyVv6bfLH+zIGCL7fZxNqtStXEBaFtLjtQrifoWMw=@lists.denx.de
X-Gm-Message-State: AOJu0YwyO/dUXmk3138oS+YydVFO0sDpzxOY5oow9PupqutW9TjBN3sW
 gAIop/gYnl+hKYlorxt+o7EQ4OuMh9sQQK2nBW4tsw9elaRzP64hdO7jGkMxYFc=
X-Google-Smtp-Source: AGHT+IHFnNvIUuzVi0SqlF2BLCODby8GVkcD43GxuobaekGoNBDMKyqbNaPEdCSpqb3SAHTP9TjsAQ==
X-Received: by 2002:a05:6870:7b50:b0:268:9d6b:672 with SMTP id
 586e51a60fabf-2738be91c76mr3465736fac.42.1724263223953; 
 Wed, 21 Aug 2024 11:00:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270046a7394sm4341825fac.28.2024.08.21.11.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 11:00:23 -0700 (PDT)
Date: Wed, 21 Aug 2024 12:00:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: n-francis@ti.com, nm@ti.com, a-limaye@ti.com,
 marcel.ziswiler@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 marex@denx.de, john@phrozen.org, ansuelsmth@gmail.com,
 sumit.garg@linaro.org, u-boot@lists.denx.de, vigneshr@ti.com, srk@ti.com
Subject: Re: [RFC PATCH 1/2] pci: Add TI K3 Cadence PCIe Controller
Message-ID: <20240821180020.GP1626301@bill-the-cat>
References: <20240821145908.3408573-1-s-vadapalli@ti.com>
 <20240821145908.3408573-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dsODNoecQ6E8c82N"
Content-Disposition: inline
In-Reply-To: <20240821145908.3408573-2-s-vadapalli@ti.com>
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


--dsODNoecQ6E8c82N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 08:29:07PM +0530, Siddharth Vadapalli wrote:

> Add support for the Cadence PCIe Controller present on TI's K3 SoCs.
> This driver is an adaptation of the Linux driver.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
[snip]
> diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
> new file mode 100644
> index 0000000000..2b9bba19b4
> --- /dev/null
> +++ b/drivers/pci/pcie_cdns_ti.c
> @@ -0,0 +1,645 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com
> + *
> + * PCIe controller driver for TI's K3 SoCs with Cadence PCIe controller
> + *
> + * Ported from the Linux driver - drivers/pci/controller/cadence/pci-j72=
1e.c
> + *
> + * Author: Siddharth Vadapalli <s-vadapalli@ti.com>
> + *
> + */
> +
> +#include <asm/global_data.h>
> +#include <asm/gpio.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <generic-phy.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +#include <log.h>
> +#include <pci.h>
> +#include <power-domain.h>
> +#include <regmap.h>
> +#include <syscon.h>

Please audit this list to make sure you need everything because..

> +
> +DECLARE_GLOBAL_DATA_PTR;

You don't reference gd in this code at all, so don't need this.

So please also make sure the giant list of defines is needed.
> +#define usleep_range(a, b) udelay((b))

Per checkpatch.pl.conf:
# Not Linux, so we don't recommend usleep_range() over udelay()

--=20
Tom

--dsODNoecQ6E8c82N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbGKy0ACgkQFHw5/5Y0
tyy8dwv/U9THWAzFS1QK9H4fc8GKMbIldp4tu8SEkhD4MddH/Zn2yu3RdQZ6qL+d
IZr/iKw1Y6icFnojB3iLi8zLpS4B3goX6iq1LjRekRyrhebsCO+HOA1AZ6fw553/
80hGhmeQ4m1e+hdgbS9JU5V5rEtmMt2FgbxQmv84q0dYFjEF20MLcIwlNg/AXPtT
aFL7wsRyp3ACv8JpAoU91maL0++mEK8csJv6Xq4UzNzPYpQ8GMm+n3D1VTVYuVl7
nhujLO2rMXZv94LzULN1DaHTc5FyfQxlEUxCp9/17I4bkgknueMi74SY7uTttEVG
kte0KqS0QVSeccGgqVvB3bNmLExbiW7j7hKipN+jKIyFQRwefMKZ/mC3Z7azop83
a/pZt4mO+ITgiCEZ50A/6FCWPI0fk5vvIKgBA2+Y82QaGCz2PEujcKsTvsOJqEJx
pS7uintoQWy1XaZTSGdUKXM0bQjeGBhl89hcrVrGEVoCpzTv+gHZnjHwH2uga/WY
cfb3tCR6
=ht2s
-----END PGP SIGNATURE-----

--dsODNoecQ6E8c82N--
