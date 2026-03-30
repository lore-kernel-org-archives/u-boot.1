Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC8010D14B6
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 13:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B8283DBF;
	Mon, 30 Mar 2026 15:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jhaT0Bsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C50D783E7A; Mon, 30 Mar 2026 15:34:45 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC8883D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 15:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso45294565e9.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774877683; x=1775482483;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ev8lOo13efgH3zhnGzGGcz2oRE68lgvDHxg+Fbsuoio=;
 b=jhaT0Bsypyp4S2tp6IadtWV6QzMrqYuxZb9AF9pREebAAXbADoWDNZ56vSiTkbt3BT
 VNbg7jay3JGUgjzX28uG7k1BeDEitbj2PrZenXkjwvslazWSKuWIwCdbnHMDJuqFFItY
 Fbl5hiEq1m4GA1vhmlJeeDeYM4iXDytwZyjVruruI0KdQjMlUianRuAifymKIs2kLma/
 mzkKyyYavs80N8ACAKIqIpCrYOUddSFU19Bl7p87DjZMax3boxcCCcit2L/8RYXA1QN0
 QLfgLbwr+akBZKixKu1VnYXqpXLoIH39kYljXqeRLReAaliqi3CUmiHjPT4uJu8UwQSu
 QvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774877683; x=1775482483;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ev8lOo13efgH3zhnGzGGcz2oRE68lgvDHxg+Fbsuoio=;
 b=YG4uDwngg3LVbLmLOSbQIlt0tYJCMGk2VpoMX72odWKPPQ5NcnI6YEOQ96PyEFOr+h
 RqJdGGa0ukRK7bK+lAWTOINV/PnrnmjyFBbQ+/w/NI1DQ2XbTbvH7bsdNOQbCc3km+kN
 M6ghCg5XI3S7j23Io0JB/eeja+aNUANTsUZB22uX0D4Ku6yal7dieUeBRJy0h4hB06bg
 qS/xgTBBLzTQzmKviA5tGC/jkU2o98racbXNwRMEKsjzLmVO79egZUx9vQRqQHZ6Wi3H
 VZJS0lugpLgkWDvHHyYM+FbJF5BuDLs3tIqNpTXLlCTiZgRlzm/sB3s1UeQuPHvQGzK+
 Lscw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFJ3FIkWF4o5/ZaPY57W7RfN4Hk1ta1j/3Q+j6gx+mUMmb6c8s0hWySKs8kpc9UM/s/5MZs4I=@lists.denx.de
X-Gm-Message-State: AOJu0YywSWHI22U+fZ/bgZHKMcdCbhA1kw+pvDXykIQipSQrsAz3EO/G
 h12/MZp18OxWFYps/DiOEXsVpRut6Co+ob185SMeuzo9NjZEUA89eFUkSr90wyhtEZA=
X-Gm-Gg: ATEYQzzNAS/5taVBxjdDlWr5yhcJPvzJHfm8YSA0ATILEJ5N9/nu4ZiGMFprxYHQWKS
 VTSxmQMQhsZdfAF89qzGqcg0Z17O0oqx+Q+FnL2pkvtsxz10smX0IoGePm/2iN2/kUMtq4bEFYy
 5JaItGlK5YwJ6CbzYVSl9gx7Dlb+Nh2aZA1jmYBtwVfWrGtuW+n+wMPzP6nj66JO91VTLQD6Hr0
 co1S8fKr+oeBZKH02smDGzp+BaWVtvdi6TmeBiZVCrFl1ySBCJTg8Cf5o/T+Q+LlxnsC+yc/cpQ
 v8M6XyYcQYooLAPD8G6TtsdBceLD/i2LNouSMjNSigaxZJFmoytLgbgBcUouIKlXZA3bW/Zdm7k
 e3fgkFZzLxwaXcS1DZt7+OD+SZSezMOkJGuJbJgThQbqnkC9hQO311GCQkA7/qn39xt1AHxBFjd
 1AUub1ySA6wxSpBYTE
X-Received: by 2002:a05:600c:4e08:b0:487:1fb4:7b3 with SMTP id
 5b1f17b1804b1-48727ef0cc2mr228187805e9.23.1774877682736; 
 Mon, 30 Mar 2026 06:34:42 -0700 (PDT)
Received: from localhost ([195.52.184.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48733c095dbsm113551145e9.0.2026.03.30.06.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 06:34:42 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=5e4d58eda991f6c7e8891e0d4513a418c6cf39945c8cedd90a00bd67fbfb;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 30 Mar 2026 15:34:33 +0200
Message-Id: <DHG5MITAHNOS.3KKMVUI98SAZ0@baylibre.com>
Cc: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, "Andrew
 Goodbody" <andrew.goodbody@linaro.org>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, "Michal Simek" <michal.simek@amd.com>, "Simon
 Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] dm: Respect dma-ranges size
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260315235756.304972-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260315235756.304972-1-marek.vasut+renesas@mailbox.org>
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

--5e4d58eda991f6c7e8891e0d4513a418c6cf39945c8cedd90a00bd67fbfb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Marek,

On Mon Mar 16, 2026 at 12:57 AM CET, Marek Vasut wrote:
> Rework dev_phys_to_bus() and dev_bus_to_phys() to respect the size
> of the area specified in dma-ranges DT property. The area outside
> of ranges is remapped 1:1, while the area in the ranges is remapped
> according to the description in the dma-ranges property.
>
> Adjust the test to test the area within the remapped range, not area
> outside the remapped range, which was incorrect.
>

Should this have a Fixes tag?

> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Not a big expert, but this looks good to me:

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>


One detail inline:

> ---
> Cc: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/core/device.c |  6 +++++-
>  include/dm/device.h   | 17 ++++++-----------
>  include/phys2bus.h    | 12 +++++++++---
>  test/dm/core.c        |  6 +++---
>  test/dm/phys2bus.c    |  4 ++--
>  5 files changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/core/device.c b/drivers/core/device.c
> index 779f371b9d5..d365204ba11 100644
> --- a/drivers/core/device.c
> +++ b/drivers/core/device.c
> @@ -473,7 +473,11 @@ static int device_get_dma_constraints(struct udevice=
 *dev)
>  		return ret;
>  	}
> =20
> -	dev_set_dma_offset(dev, cpu - bus);
> +#if CONFIG_IS_ENABLED(DM_DMA)
> +	dev->dma_cpu =3D cpu;
> +	dev->dma_bus =3D bus;
> +	dev->dma_size =3D size;
> +#endif
> =20
>  	return 0;
>  }
> diff --git a/include/dm/device.h b/include/dm/device.h
> index 678cd83c271..7bcf6df2892 100644
> --- a/include/dm/device.h
> +++ b/include/dm/device.h
> @@ -166,8 +166,9 @@ enum {
>   *		When CONFIG_DEVRES is enabled, devm_kmalloc() and friends will
>   *		add to this list. Memory so-allocated will be freed
>   *		automatically when the device is removed / unbound
> - * @dma_offset: Offset between the physical address space (CPU's) and th=
e
> - *		device's bus address space
> + * @dma_cpu: DMA physical address space (CPU's)
> + * @dma_bus: DMA device's bus address space
> + * @dma_size: DMA window size
>   * @iommu: IOMMU device associated with this device
>   */
>  struct udevice {
> @@ -196,7 +197,9 @@ struct udevice {
>  	struct list_head devres_head;
>  #endif
>  #if CONFIG_IS_ENABLED(DM_DMA)
> -	ulong dma_offset;
> +	phys_addr_t dma_cpu;
> +	dma_addr_t dma_bus;
> +	u64 dma_size;
>  #endif
>  #if CONFIG_IS_ENABLED(IOMMU)
>  	struct udevice *iommu;
> @@ -272,14 +275,6 @@ static inline __attribute_const__ ofnode dev_ofnode(=
const struct udevice *dev)
>  /* Returns non-zero if the device is active (probed and not removed) */
>  #define device_active(dev)	(dev_get_flags(dev) & DM_FLAG_ACTIVATED)
> =20
> -#if CONFIG_IS_ENABLED(DM_DMA)
> -#define dev_set_dma_offset(_dev, _offset)	_dev->dma_offset =3D _offset
> -#define dev_get_dma_offset(_dev)		_dev->dma_offset
> -#else
> -#define dev_set_dma_offset(_dev, _offset)
> -#define dev_get_dma_offset(_dev)		0
> -#endif
> -
>  static inline __attribute_const__ int dev_of_offset(const struct udevice=
 *dev)
>  {
>  #if CONFIG_IS_ENABLED(OF_REAL)
> diff --git a/include/phys2bus.h b/include/phys2bus.h
> index 866b8b51a8c..80fa88adae1 100644
> --- a/include/phys2bus.h
> +++ b/include/phys2bus.h
> @@ -21,17 +21,23 @@ static inline unsigned long bus_to_phys(unsigned long=
 bus)
>  }
>  #endif
> =20
> -#if CONFIG_IS_ENABLED(DM)
> +#if CONFIG_IS_ENABLED(DM_DMA)

This is not related to the code changes right?

Best
Markus

>  #include <dm/device.h>
> =20
>  static inline dma_addr_t dev_phys_to_bus(struct udevice *dev, phys_addr_=
t phys)
>  {
> -	return phys - dev_get_dma_offset(dev);
> +	/* If the PA is in the remap range, apply remap. */
> +	if (phys >=3D dev->dma_cpu && phys < dev->dma_cpu + dev->dma_size)
> +		phys -=3D dev->dma_cpu - dev->dma_bus;
> +	return phys;
>  }
> =20
>  static inline phys_addr_t dev_bus_to_phys(struct udevice *dev, dma_addr_=
t bus)
>  {
> -	return bus + dev_get_dma_offset(dev);
> +	/* If the DA is in the remap range, apply remap. */
> +	if (bus >=3D dev->dma_bus && bus < dev->dma_bus + dev->dma_size)
> +		bus +=3D dev->dma_cpu - dev->dma_bus;
> +	return bus;
>  }
>  #else
>  #define dev_phys_to_bus(_, _addr)	_addr
> diff --git a/test/dm/core.c b/test/dm/core.c
> index 78ee14af228..bb9f526b064 100644
> --- a/test/dm/core.c
> +++ b/test/dm/core.c
> @@ -1248,13 +1248,13 @@ static int dm_test_dma_offset(struct unit_test_st=
ate *uts)
>         node =3D ofnode_path("/mmio-bus@0");
>         ut_assert(ofnode_valid(node));
>         ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_BUS, node, &d=
ev));
> -       ut_asserteq_64(0, dev->dma_offset);
> +       ut_asserteq_64(0, dev->dma_cpu - dev->dma_bus);
> =20
>         /* Device behind a bus with dma-ranges */
>         node =3D ofnode_path("/mmio-bus@0/subnode@0");
>         ut_assert(ofnode_valid(node));
>         ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_FDT, node, &d=
ev));
> -       ut_asserteq_64(-0x10000000ULL, dev->dma_offset);
> +       ut_asserteq_64(-0x10000000ULL, dev->dma_cpu - dev->dma_bus);
> =20
>         /* This one has no dma-ranges */
>         node =3D ofnode_path("/mmio-bus@1");
> @@ -1263,7 +1263,7 @@ static int dm_test_dma_offset(struct unit_test_stat=
e *uts)
>         node =3D ofnode_path("/mmio-bus@1/subnode@0");
>         ut_assert(ofnode_valid(node));
>         ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_FDT, node, &d=
ev));
> -       ut_asserteq_64(0, dev->dma_offset);
> +       ut_asserteq_64(0, dev->dma_cpu - dev->dma_bus);
> =20
>         return 0;
>  }
> diff --git a/test/dm/phys2bus.c b/test/dm/phys2bus.c
> index 0f30c7e37fd..67f33904943 100644
> --- a/test/dm/phys2bus.c
> +++ b/test/dm/phys2bus.c
> @@ -28,8 +28,8 @@ static int dm_test_phys_to_bus(struct unit_test_state *=
uts)
>  	node =3D ofnode_path("/mmio-bus@0/subnode@0");
>  	ut_assert(ofnode_valid(node));
>  	ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_FDT, node, &dev));
> -	ut_asserteq_addr((void*)0x100fffffULL, (void*)dev_phys_to_bus(dev, 0xff=
fff));
> -	ut_asserteq_addr((void*)0xfffffULL, (void*)(ulong)dev_bus_to_phys(dev, =
0x100fffff));
> +	ut_asserteq_addr((void*)0x1003ffffULL, (void*)dev_phys_to_bus(dev, 0x3f=
fff));
> +	ut_asserteq_addr((void*)0x3ffffULL, (void*)(ulong)dev_bus_to_phys(dev, =
0x1003ffff));
> =20
>  	return 0;
>  }


--5e4d58eda991f6c7e8891e0d4513a418c6cf39945c8cedd90a00bd67fbfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCacp76RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOi
eAD/bymFuIctgkJLtaE+mYiRqez/Ygd44srw7YCVqgDt82IA/2ZXb6V6/QycxHtS
Ck/1MQBYTtl7Z/tKnmHrT8JWXBMO
=xzFs
-----END PGP SIGNATURE-----

--5e4d58eda991f6c7e8891e0d4513a418c6cf39945c8cedd90a00bd67fbfb--
