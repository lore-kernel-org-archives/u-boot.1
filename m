Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F7DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 23:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5075888C29;
	Sat, 10 Aug 2024 01:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRP1st0I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D82B88C29; Sat, 10 Aug 2024 01:03:57 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947CF88719
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 01:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=virag.david003@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52f04b3cb33so5380928e87.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723244634; x=1723849434; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zT/VaEddr/oR+Ep0Z/j9Vmjkqa5/g1nqv/G9aGLNlVc=;
 b=BRP1st0I8qIO5E784OHC6dA1Qe2kGVSLo1ikoWXX37OBzwptn+ojyb6Or25/e/eWij
 MhIv8niRvCwaeGAaNVxTS4SyYjrtE/9a6ehhaSfuIxQb0kgiyxXDQ1QsDeh5zfC4u13E
 dvQtBg+xTcOazFEPi/8OkS7IkXz3pXOO4E3GKR37oCvk/RlW508QboWwJxUWVx+TWqSg
 TfHBsVlaPRFS0gcyvtbw6sJxFg7piKl22mV5PF4jD/I+UaSknK6cGaydlEWQThSu3/QV
 Tzfj9A9WtuaP97ir/lL+UrqFk8QR6HuiD28FJxSbJoMnTVT06JmPQMWo5szdu5wfRNXE
 UoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723244634; x=1723849434;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zT/VaEddr/oR+Ep0Z/j9Vmjkqa5/g1nqv/G9aGLNlVc=;
 b=l1vJOzIi57d4R1UJCWp3EBG5MkqphLypQxSy32JU3kvEnrqGQqx1YvWnBwMjwz1v5z
 gS2QP8zznPFitXiJa0ifEcKm6jRBF7fHNyOVOWtEKHnaMMrP+kAekS/9t0QN1FzaRfk8
 v4Aw6ZrO6qAKffZTYUH6f2OkgRKssVG/Vz0zQr77/x6Wym4SJ76sbdGnuWWyjMcJLMiZ
 kGjmy9hKBPAj0RWCRj9mXrn+GBnua/ZX/wnWOXnNntv6hLvKaUlJXWt/DE4y++OLrc/0
 tiGldQ9xW+YXYBmxFM7qn8ADTzxmS/V0E5/RtDjU7UY2wk69GfV8SaMFXZDwftFKVMe6
 Vt6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm3Ad76bUUs0FsipPJiZNEyVJdaFm0KnDYqevLcPKGcdes/V3daug3MoG4AvRTlqIIuxgnNiM952gi8vUkcOLro/BFXA==
X-Gm-Message-State: AOJu0Yx9uLVTA+nurWfTh35kq+R3k+Ibhtz7+028ykgU3bEGsH7JtAPg
 3+xsUEfyaBm/uVHIyGJ/UvA0qgfwvzBIBsBlBsFa2gCS//PtDs71dnzk8g==
X-Google-Smtp-Source: AGHT+IGkiFeczZHHVjlRCZXBNwKhueQZUVAlxiOydbGIbiRA3YbCvsK4ca6OQDzLLntSYwu3gWYUiw==
X-Received: by 2002:a05:6512:3a89:b0:530:da96:a990 with SMTP id
 2adb3069b0e04-530ee9a9efamr2168618e87.32.1723244633475; 
 Fri, 09 Aug 2024 16:03:53 -0700 (PDT)
Received: from ?IPv6:2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78?
 ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80bb212bd2sm17525666b.176.2024.08.09.16.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 16:03:53 -0700 (PDT)
Message-ID: <a7bfd187c3769f3e8f50a8cc842a749c67d836a4.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: samsung: Support platforms other than
 EXYNOS4 and EXYNOS5
From: David Virag <virag.david003@gmail.com>
To: Henrik Grimler <henrik@grimler.se>
Cc: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  Caleb Connolly
 <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 u-boot@lists.denx.de
Date: Sat, 10 Aug 2024 01:05:06 +0200
In-Reply-To: <20240809210818.GA14190@l14.localdomain>
References: <20240802191920.132133-1-virag.david003@gmail.com>
 <20240802191920.132133-3-virag.david003@gmail.com>
 <20240809210818.GA14190@l14.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
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

Hi Henrik,

On Fri, 2024-08-09 at 23:08 +0200, Henrik Grimler wrote:
> Hi David,
>=20
> Thinking about this a bit more...
>=20
> On Fri, Aug 02, 2024 at 09:19:16PM +0200, David Virag wrote:
[snip]
> > @@ -9,11 +9,15 @@
> > =C2=A0#include <dm.h>
> > =C2=A0#include <i2c.h>
> > =C2=A0#include <log.h>
> > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
> > =C2=A0#include <asm/arch/clk.h>
> > =C2=A0#include <asm/arch/cpu.h>
> > =C2=A0#include <asm/arch/pinmux.h>
> > +#endif
>=20
> We want to try to move the Exynos 4 and 5 devices to CCF and
> OF_UPSTREAM as well, which will make this messy.=C2=A0 Can we check
> CONFIG_CLK_EXYNOS and CONFIG_PINCTRL_EXYNOS instead?
>=20

Happy to hear that move, but you are a bit late, this got merged into
master not long ago. Sending a patch for changing it should be fine,
the 7885 port I'm working on uses mostly the same things as the E850-
96board (just has some support for 2 boards right now, though I may
submit jackpotlte only first, will see)

> > =C2=A0#include <asm/global_data.h>
> > +#include <asm/io.h>
> > =C2=A0#include <linux/delay.h>
> > +#include <clk.h>
> > =C2=A0#include "s3c24x0_i2c.h"
> > =C2=A0
> > =C2=A0DECLARE_GLOBAL_DATA_PTR;
> > @@ -137,15 +141,26 @@ static int hsi2c_wait_for_trx(struct
> > exynos5_hsi2c *i2c)
> > =C2=A0	return I2C_NOK_TOUT;
> > =C2=A0}
> > =C2=A0
> > -static int hsi2c_get_clk_details(struct s3c24x0_i2c_bus *i2c_bus)
> > +static int hsi2c_get_clk_details(struct udevice *dev)
> > =C2=A0{
> > +	struct s3c24x0_i2c_bus *i2c_bus =3D dev_get_priv(dev);
> > =C2=A0	struct exynos5_hsi2c *hsregs =3D i2c_bus->hsregs;
> > =C2=A0	ulong clkin;
> > =C2=A0	unsigned int op_clk =3D i2c_bus->clock_frequency;
> > =C2=A0	unsigned int i =3D 0, utemp0 =3D 0, utemp1 =3D 0;
> > =C2=A0	unsigned int t_ftl_cycle;
> > =C2=A0
> > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
>=20
> As above, can we check CONFIG_CLK_EXYNOS instead?
>=20

Should be fine

> > =C2=A0	clkin =3D get_i2c_clk();
> > +#else
> > +	struct clk clk;
> > +	int ret;
> > +
> > +	ret =3D clk_get_by_name(dev, "hsi2c", &clk);
> > +	if (ret < 0)
> > +		return ret;
> > +	clkin =3D clk_get_rate(&clk);
> > +#endif
> > =C2=A0	/* FPCLK / FI2C =3D
> > =C2=A0	 * (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2) + 8 + 2 *
> > FLT_CYCLE
> > =C2=A0	 * uTemp0 =3D (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2)
> > @@ -487,7 +502,7 @@ static int s3c24x0_i2c_set_bus_speed(struct
> > udevice *dev, unsigned int speed)
> > =C2=A0
> > =C2=A0	i2c_bus->clock_frequency =3D speed;
> > =C2=A0
> > -	if (hsi2c_get_clk_details(i2c_bus))
> > +	if (hsi2c_get_clk_details(dev))
> > =C2=A0		return -EFAULT;
> > =C2=A0	hsi2c_ch_init(i2c_bus);
> > =C2=A0
> > @@ -514,7 +529,9 @@ static int s3c24x0_i2c_probe(struct udevice
> > *dev, uint chip, uint chip_flags)
> > =C2=A0
> > =C2=A0static int s3c_i2c_of_to_plat(struct udevice *dev)
> > =C2=A0{
> > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
> > =C2=A0	const void *blob =3D gd->fdt_blob;
> > +#endif
> > =C2=A0	struct s3c24x0_i2c_bus *i2c_bus =3D dev_get_priv(dev);
> > =C2=A0	int node;
> > =C2=A0
> > @@ -522,7 +539,9 @@ static int s3c_i2c_of_to_plat(struct udevice
> > *dev)
> > =C2=A0
> > =C2=A0	i2c_bus->hsregs =3D dev_read_addr_ptr(dev);
> > =C2=A0
> > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
> > =C2=A0	i2c_bus->id =3D pinmux_decode_periph_id(blob, node);
> > +#endif
> > =C2=A0
> > =C2=A0	i2c_bus->clock_frequency =3D
> > =C2=A0		dev_read_u32_default(dev, "clock-frequency",
> > @@ -530,7 +549,9 @@ static int s3c_i2c_of_to_plat(struct udevice
> > *dev)
> > =C2=A0	i2c_bus->node =3D node;
> > =C2=A0	i2c_bus->bus_num =3D dev_seq(dev);
> > =C2=A0
> > +#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) ||
> > IS_ENABLED(CONFIG_ARCH_EXYNOS5)
> > =C2=A0	exynos_pinmux_config(i2c_bus->id, PINMUX_FLAG_HS_MODE);
> > +#endif
>=20
> I think these three #if def's can be consolidated in one #if def
> group
> towards the end of s3c_i2c_of_to_plat to make it easier to follow.

Hm, sounds good, though I don't know if moving the variable declaration
from the top would work. I don't know which C standard uboot is
compiled with, but I do know that some don't like that. If it works, it
works.

>=20
> Also, can we check CONFIG_PINCTRL_EXYNOS instead?=C2=A0 That would make i=
t
> easier when migrating Exynos 4 and 5 devices to pinctrl driver and
> OF_UPSTREAM.

Yeah, that works too.
Only reason I used EXYNOS4/5 is that that's really what it directly
depends on, and I didn't know it was planned to move Exynos4/5 specific
stuff to CCF/pinctrl.

My only real nitpick is that these changes would mean we'd have to
reintroduce the dependency on exynos platforms, since if we say "if we
don't have exynos ccf driver, use exynos specific stuff", then if we
just add the driver to some other non-exynos platform without exynos
ccf driver enabled for some reason, it would not compile, since it'd be
trying to use the old exynos4/5 stuff.
Though for now it should be fine if we limit it to Exynos only.

>=20
> Same comments apply to s3c24x0_i2c.c below.
>=20
> Best regards,
> Henrik Grimler
>=20
>=20

Best regards,
David
