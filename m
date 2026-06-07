Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DF0CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 05:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D2B68063E;
	Sun,  7 Jun 2026 07:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="m+vp9dA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E9283314; Sun,  7 Jun 2026 07:21:10 +0200 (CEST)
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch
 [79.135.106.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E060880433
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 07:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780809666; x=1781068866;
 bh=2g1rUCu0B95l0AqcsnmL0g203JL9halLBY0KNYt7WSU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=m+vp9dA23QnXoDEtg+sab7/A6NrhJkYctvBI5T6BGChsGbw/OL8nUHYxMa+lzSPta
 MZgKrbk5bHVioD9uKBpbswjuGaqop85QX1Mp+qQFfZLQZVssxZTsiKfQExBfMB//4D
 5/aInh4K/IldmQJ6p0EPtK5sllj14tjzTTuNhFZ676jPDleeajP9vB6SW+pWJ/hOMm
 2gK3BRUfqGttt6mMouHwfOHcv/u+bHvgZ5KrdCYYF/SGaCJjOwo++7GHtvWKwqAOPM
 FiWtEjn5qoIHrYA8Y1PFqrIJjPDDgdSkQ8Ws/orW5XYlkN85ppBak6jQ+mp3ASIUf+
 RqiE2vBL7Kpag==
Date: Sun, 07 Jun 2026 05:21:02 +0000
To: Stephan Gerhold <stephan.gerhold@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>, Brian Sune <briansune@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] mach-snapdragon: formalize APQ8016 debug UART init
Message-ID: <ZjFM7FFWuBpdGeJDr6pvxRY-gwsDcbqbY1M_CvMQbs9BjsHrvPymYQ-86Sk8qWXUslUn6PTG3mSMsvyt8mFWINms-cNpLGPxaBClmy4zoV4=@samcday.com>
In-Reply-To: <aiA5KKi03eF5DHyk@linaro.org>
References: <20260603-apq8016-debug-uart-v1-1-1e46b2cd0fe6@samcday.com>
 <aiA5KKi03eF5DHyk@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: f74d1d49963bbd407403918e08cb74ffd46b6eec
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hey Stephan,

On Thursday, 4 June 2026 at 12:25 AM, Stephan Gerhold <stephan.gerhold@lina=
ro.org> wrote:

> On Wed, Jun 03, 2026 at 08:56:21AM +1000, Sam Day via B4 Relay wrote:
> > From: Sam Day <me@samcday.com>
> >
> > The dragonboard410c (and likely other SB-off devices) can run U-Boot
> > early enough in the boot chain such that UART clock isn't started, and
> > pins aren't configured.
> >
> > APQ8016 has two UART peripherals, each with its own clock and TLMM pins=
.
> >
> > Two new debug-apq8016-uartN.config fragments are provided. Each
> > configures the appropriate UARTDM aperture. The newly introduced
> > DEBUG_UART_APQ8016 Kconfig symbol pulls in MSM debug UART, and enables =
a
> > board-level debug_uart_init function to start the right clock and mux
> > the right TX pin.
> >
> > Signed-off-by: Sam Day <me@samcday.com>
> > ---
> >  arch/arm/mach-snapdragon/Kconfig              |  9 +++++++
> >  arch/arm/mach-snapdragon/Makefile             |  1 +
> >  arch/arm/mach-snapdragon/debug-uart-apq8016.c | 37 +++++++++++++++++++=
++++++++
> >  board/qualcomm/debug-apq8016-uart1.config     |  4 +++
> >  board/qualcomm/debug-apq8016-uart2.config     |  4 +++
> >  drivers/serial/Kconfig                        |  1 +
> >  drivers/serial/serial_msm.c                   | 10 --------
> >  7 files changed, 56 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdrago=
n/Kconfig
> > index d3de8693b5a..43e6fd1bc42 100644
> > --- a/arch/arm/mach-snapdragon/Kconfig
> > +++ b/arch/arm/mach-snapdragon/Kconfig
> > @@ -1,5 +1,14 @@
> >  if ARCH_SNAPDRAGON
> >
> > +config DEBUG_UART_APQ8016
> > +=09bool "APQ8016 early debug initialization"
> > +=09select CLK_QCOM_APQ8016
> > +=09select CONFIG_DEBUG_UART_MSM
> > +=09select DEBUG_UART_BOARD_INIT
> > +=09help
> > +=09  Ensures BLSP UART clocks+pins are setup. Useful when U-Boot is ru=
nning from
> > +=09  aboot (such as on the dragonboard410c).
> > +
> >  config SYS_SOC
> >  =09default "snapdragon"
> >
> > diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdrag=
on/Makefile
> > index 343e825c6fd..824bb4d5daf 100644
> > --- a/arch/arm/mach-snapdragon/Makefile
> > +++ b/arch/arm/mach-snapdragon/Makefile
> > @@ -5,3 +5,4 @@
> >  obj-y +=3D board.o
> >  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D capsule_update.o
> >  obj-$(CONFIG_OF_LIVE) +=3D of_fixup.o
> > +obj-$(CONFIG_DEBUG_UART_APQ8016) +=3D debug-uart-apq8016.o
> > diff --git a/arch/arm/mach-snapdragon/debug-uart-apq8016.c b/arch/arm/m=
ach-snapdragon/debug-uart-apq8016.c
> > new file mode 100644
> > index 00000000000..2de9d99bed5
> > --- /dev/null
> > +++ b/arch/arm/mach-snapdragon/debug-uart-apq8016.c
> > @@ -0,0 +1,37 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * SoC-specific debug UART initialization (clocks/pins) lives here
> > + */
> > +
> > +#include <asm/io.h>
> > +#include <dt-bindings/clock/qcom,gcc-msm8916.h>
> > +
> > +extern int apq8016_clk_init_uart(phys_addr_t gcc_base, unsigned long i=
d);
> > +
> > +#define APQ8016_GCC_BASE=09=09((phys_addr_t)0x01800000)
> > +
> > +#define APQ8016_TLMM_BASE=09=09((phys_addr_t)0x01000000)
> > +#define APQ8016_TLMM_FUNC_BLSP_UART=09(2 << 2)
> > +#define APQ8016_TLMM_DRV_8MA=09=09(3 << 6)
> > +#define APQ8016_TLMM_GPIO_ENABLE=09BIT(9)
> > +#define APQ8016_GPIO_CFG(gpio)=09=09(APQ8016_TLMM_BASE + (phys_addr_t)=
(gpio) * 0x1000)
> > +#define APQ8016_DEBUG_UART_PINCFG=09(APQ8016_TLMM_FUNC_BLSP_UART | \
> > +=09=09=09=09=09 APQ8016_TLMM_DRV_8MA | \
> > +=09=09=09=09=09 APQ8016_TLMM_GPIO_ENABLE)
>=20
> APQ8016_TLMM_GPIO_ENABLE is actually GPIO_OE ("output enable").

Noted, thanks. It'll be renamed in v2.

> I guess
> it makes sense to set this for a TX pin, but I think this is typically
> not set for special-function pins like BLSP_UART. LK doesn't set it
> AFAICT.

Hmm, am I looking at the wrong thing then?

https://github.com/msm8916-mainline/lk2nd/blob/main/platform/msm8916/gpio.c

AFAICT, gpio_config_uart_dm calls gpio_tlmm_config with the exceptionally
confusing GPIO_DISABLE constant (which is defined as "1").=20

Cheers,
-Sam

>=20
> Thanks,
> Stephan
> 
