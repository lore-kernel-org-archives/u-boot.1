Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545FDC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA48F88A38;
	Wed, 31 Jul 2024 16:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="s17BWunJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E484888A39; Wed, 31 Jul 2024 16:51:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A8F288A05
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72bb=PA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: Subject: From: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722437457;
 bh=w7w+423OXBLKijVIU7nQDL5b65DXbu5t0GCm/XhcNpw=;
 b=s17BWunJYzNtl2wTW0OK+g/7KvX52WCPWS8H+RL7J9oo2tQqRjvAOcKrl+j8xpztvbY2SR3Oq
 LL1PcJiu7QVsUhBO8S2SwZWzlSpKKYN6YpG+uvk+6tyBuHJJFUbo0pX1vsFi9wB8uFV6Sto+O4E
 ThfYUsxGVDKKgkVM5K2689DhHWiFO+eWesE6zdsZMuwzT/AunX8MGJyxqF1F97MM1Tqku+AXIAI
 sEoko6LW92SLHrMUNBOvdMScHOWmJ/HgV9hruQyDxN07wev3kr8Jxhe16jAq5YqUcAYxppbSjcO
 U983XjjwD7uIIgZWAGNaV1KEuTWS1TWllm6MN0OgSsUw==
Message-ID: <a5e735b2-73fa-49f9-91a3-832cdd6ba1ce@kwiboo.se>
Date: Wed, 31 Jul 2024 16:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 2/2] board: rockchip: Add Xunlong Orange Pi 3B
To: Quentin Schulz <quentin.schulz@cherry.de>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ricardo Pardini <ricardo@pardini.net>, Sumit Garg
 <sumit.garg@linaro.org>, u-boot@lists.denx.de
References: <20240731090336.1269391-1-jonas@kwiboo.se>
 <20240731090336.1269391-3-jonas@kwiboo.se>
 <7208a42b-4309-4216-ab64-16a5a82eced8.a73bd9c8-8cbe-42e2-876b-4c548d837fba.5253e527-6fcc-4cef-934f-5ce842752e21@emailsignatures365.codetwo.com>
 <8e6f3cb1-b48e-4007-96fc-db7194aa3a29@cherry.de>
Content-Language: en-US
In-Reply-To: <8e6f3cb1-b48e-4007-96fc-db7194aa3a29@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66aa4f4e06984f15edfb5908
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

Hi Quentin,

On 2024-07-31 14:56, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/31/24 11:03 AM, Jonas Karlman wrote:
>  > From: Ricardo Pardini <ricardo@pardini.net>
>  >
>  > The Xunlong Orange Pi 3B is a single-board computer based on the
>  > Rockchip RK3566 SoC.
>  >
>  > The two hw revisions use different io-voltage for Ethernet PHY and can
>  > be identified using GPIO4_C4:
>  > - v1.1.1: x (internal pull-down)
>  > - v2.1:   PHY_RESET (external pull-up)
>  >
>  > Implement rk_board_late_init() to set correct fdtfile env var and
>  > board_fit_config_name_match() to load correct FIT config based on what
>  > board is detected at runtime so a single board target can be used for
>  > both hw revisions.
>  >
>  > Minimal DTs that includ DT from dts/upstream is added to support booting
>  > from both hw revision and only set Ethernet PHY io-voltage when the hw
>  > revision is detected at runtime. A side-affect of this is that defconfig
>  > show OF_UPSTREAM=n, however dts/upstream DTs is used for this board.
>  >
>  > Features tested on Orange Pi 3B 4GB (v1.1.1 and v2.1):
>  > - SD-card boot
>  > - eMMC boot
>  > - SPI Flash boot
>  > - Ethernet
>  > - PCIe/NVMe
>  > - USB host
>  >
>  > Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
>  > Co-developed-by: Jonas Karlman <jonas@kwiboo.se>
>  > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>  > ---
>  >   arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi   | 14 +++
>  >   .../dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi   |  3 +
>  >   arch/arm/dts/rk3566-orangepi-3b-v1.1.dts      |  3 +
>  >   .../dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi   |  3 +
>  >   arch/arm/dts/rk3566-orangepi-3b-v2.1.dts      |  3 +
>  >   arch/arm/dts/rk3566-orangepi-3b.dts           |  5 +
>  >   arch/arm/mach-rockchip/rk3568/Kconfig         |  6 ++
>  >   board/xunlong/orangepi-3b-rk3566/Kconfig      | 12 +++
>  >   board/xunlong/orangepi-3b-rk3566/MAINTAINERS  |  6 ++
>  >   board/xunlong/orangepi-3b-rk3566/Makefile     |  3 +
>  >   .../orangepi-3b-rk3566/orangepi-3b-rk3566.c   | 77 +++++++++++++++
>  >   configs/orangepi-3b-rk3566_defconfig          | 98 +++++++++++++++++++
>  >   doc/board/rockchip/rockchip.rst               |  1 +
>  >   13 files changed, 234 insertions(+)
>  >   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi
>  >   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi
>  >   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
>  >   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi
>  >   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
>  >   create mode 100644 arch/arm/dts/rk3566-orangepi-3b.dts
>  >   create mode 100644 board/xunlong/orangepi-3b-rk3566/Kconfig
>  >   create mode 100644 board/xunlong/orangepi-3b-rk3566/MAINTAINERS
>  >   create mode 100644 board/xunlong/orangepi-3b-rk3566/Makefile
>  >   create mode 100644 board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c
>  >   create mode 100644 configs/orangepi-3b-rk3566_defconfig
>  >
>  > diff --git a/arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi 
> b/arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi
>  > new file mode 100644
>  > index 000000000000..e44b699af720
>  > --- /dev/null
>  > +++ b/arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi
>  > @@ -0,0 +1,14 @@
>  > +// SPDX-License-Identifier: GPL-2.0+
>  > +
>  > +#include "rk356x-u-boot.dtsi"
>  > +
>  > +&gpio4 {
>  > +     bootph-pre-ram;
>  > +};
>  > +
>  > +&sfc {
>  > +     flash@0 {
>  > +             bootph-pre-ram;
>  > +             bootph-some-ram;
>  > +     };
>  > +};
>  > diff --git a/arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi 
> b/arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi
>  > new file mode 100644
>  > index 000000000000..50ea6ede7285
>  > --- /dev/null
>  > +++ b/arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi
>  > @@ -0,0 +1,3 @@
>  > +// SPDX-License-Identifier: GPL-2.0+
>  > +
>  > +#include "rk3566-orangepi-3b-u-boot.dtsi"
>  > diff --git a/arch/arm/dts/rk3566-orangepi-3b-v1.1.dts 
> b/arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
>  > new file mode 100644
>  > index 000000000000..f97e33bd8108
>  > --- /dev/null
>  > +++ b/arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
>  > @@ -0,0 +1,3 @@
>  > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  > +
>  > +#include <arm64/rockchip/rk3566-orangepi-3b-v1.1.dts>
>  > diff --git a/arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi 
> b/arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi
>  > new file mode 100644
>  > index 000000000000..50ea6ede7285
>  > --- /dev/null
>  > +++ b/arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi
>  > @@ -0,0 +1,3 @@
>  > +// SPDX-License-Identifier: GPL-2.0+
>  > +
>  > +#include "rk3566-orangepi-3b-u-boot.dtsi"
>  > diff --git a/arch/arm/dts/rk3566-orangepi-3b-v2.1.dts 
> b/arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
>  > new file mode 100644
>  > index 000000000000..0031e2477abf
>  > --- /dev/null
>  > +++ b/arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
>  > @@ -0,0 +1,3 @@
>  > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  > +
>  > +#include <arm64/rockchip/rk3566-orangepi-3b-v2.1.dts>
>  > diff --git a/arch/arm/dts/rk3566-orangepi-3b.dts 
> b/arch/arm/dts/rk3566-orangepi-3b.dts
>  > new file mode 100644
>  > index 000000000000..44b9a9c89f0b
>  > --- /dev/null
>  > +++ b/arch/arm/dts/rk3566-orangepi-3b.dts
>  > @@ -0,0 +1,5 @@
>  > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  > +
>  > +/dts-v1/;
>  > +
>  > +#include <arm64/rockchip/rk3566-orangepi-3b.dtsi>
>  > diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig 
> b/arch/arm/mach-rockchip/rk3568/Kconfig
>  > index 0f32f243be4e..899cf909fbb9 100644
>  > --- a/arch/arm/mach-rockchip/rk3568/Kconfig
>  > +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
>  > @@ -37,6 +37,11 @@ config TARGET_RADXA_ZERO_3_RK3566
>  >        help
>  >          Radxa ZERO 3W/3E single board computers with a RK3566 SoC.
>  >
>  > +config TARGET_ORANGEPI_3B_RK3566
>  > +     bool "Xunlong Orange Pi 3B"
>  > +     help
>  > +       Xunlong Orange Pi 3B single board computer with a RK3566 SoC.
>  > +
>  >   endchoice
>  >
>  >   config ROCKCHIP_BOOT_MODE_REG
>  > @@ -60,5 +65,6 @@ source "board/hardkernel/odroid_m1/Kconfig"
>  >   source "board/pine64/quartz64_rk3566/Kconfig"
>  >   source "board/powkiddy/x55/Kconfig"
>  >   source "board/radxa/zero3-rk3566/Kconfig"
>  > +source "board/xunlong/orangepi-3b-rk3566/Kconfig"
>  >
>  >   endif
>  > diff --git a/board/xunlong/orangepi-3b-rk3566/Kconfig 
> b/board/xunlong/orangepi-3b-rk3566/Kconfig
>  > new file mode 100644
>  > index 000000000000..36ccc056c620
>  > --- /dev/null
>  > +++ b/board/xunlong/orangepi-3b-rk3566/Kconfig
>  > @@ -0,0 +1,12 @@
>  > +if TARGET_ORANGEPI_3B_RK3566
>  > +
>  > +config SYS_BOARD
>  > +     default "orangepi-3b-rk3566"
>  > +
>  > +config SYS_VENDOR
>  > +     default "xunlong"
>  > +
>  > +config SYS_CONFIG_NAME
>  > +     default "evb_rk3568"
>  > +
>  > +endif
>  > diff --git a/board/xunlong/orangepi-3b-rk3566/MAINTAINERS 
> b/board/xunlong/orangepi-3b-rk3566/MAINTAINERS
>  > new file mode 100644
>  > index 000000000000..6e1df1052ba2
>  > --- /dev/null
>  > +++ b/board/xunlong/orangepi-3b-rk3566/MAINTAINERS
>  > @@ -0,0 +1,6 @@
>  > +ORANGEPI-3B-RK3566
>  > +M:   Jonas Karlman <jonas@kwiboo.se>
>  > +S:   Maintained
>  > +F:   board/xunlong/orangepi-3b-rk3566
>  > +F:   configs/orangepi-3b-rk3566_defconfig
>  > +F:   arch/arm/dts/rk3566-orangepi-3b*
>  > diff --git a/board/xunlong/orangepi-3b-rk3566/Makefile 
> b/board/xunlong/orangepi-3b-rk3566/Makefile
>  > new file mode 100644
>  > index 000000000000..9ce25549e21e
>  > --- /dev/null
>  > +++ b/board/xunlong/orangepi-3b-rk3566/Makefile
>  > @@ -0,0 +1,3 @@
>  > +# SPDX-License-Identifier: GPL-2.0+
>  > +
>  > +obj-y += orangepi-3b-rk3566.o
>  > diff --git a/board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c 
> b/board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c
>  > new file mode 100644
>  > index 000000000000..d05c33adefaa
>  > --- /dev/null
>  > +++ b/board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c
>  > @@ -0,0 +1,77 @@
>  > +// SPDX-License-Identifier: GPL-2.0+
>  > +
>  > +#include <env.h>
>  > +#include <asm/gpio.h>
>  > +
>  > +struct board_model {
>  > +     int value;
>  > +     const char *fdtfile;
>  > +     const char *config;
>  > +};
>  > +
>  > +static const struct board_model board_models[] = {
>  > +     { 0, "rockchip/rk3566-orangepi-3b-v1.1.dtb", 
> "rk3566-orangepi-3b-v1.1.dtb" },
>  > +     { 1, "rockchip/rk3566-orangepi-3b-v2.1.dtb", 
> "rk3566-orangepi-3b-v2.1.dtb" },
>  > +};
>  > +
>  > +static int get_board_value(void)
>  > +{
>  > +     struct gpio_desc desc;
>  > +     int ret;
>  > +
>  > +     /*
>  > +      * GPIO4_C4 (E20):
>  > +      * v1.1.1: x (internal pull-down)
>  > +      * v2.1:   PHY_RESET (external pull-up)
>  > +      */
>  > +     ret = dm_gpio_lookup_name("E20", &desc);
>  > +     if (ret)
>  > +             return ret;
>  > +
>  > +     ret = dm_gpio_request(&desc, "phy_reset");
>  > +     if (ret && ret != -EBUSY)
>  > +             return ret;
>  > +
>  > +     dm_gpio_set_dir_flags(&desc, GPIOD_IS_IN);
>  > +     ret = dm_gpio_get_value(&desc);
>  > +     dm_gpio_free(desc.dev, &desc);
>  > +
> 
> Shouldn't we read the current configuration and write it back after this
> hack? I also assume this is guaranteed to happen before the network is
> configured otherwise we may have some issue with it resetting the
> Ethernet PHY for example?

Yes, this should only be called in SPL and prior to Ethernet is
initialized in U-Boot proper.

Not sure we need to do that, we request the gpio pin, read the value and
then free/release the pin so that it can be claimed/requested later by
the Ethernet PHY driver.

Using gpio status cmd in U-Boot proper on v2.1 hw revision:

  E20: output: 1 [x] ethernet-phy@1.reset-gpios

and on v1.1.1 hw revision:

  E20: input: 0 [ ]

on v1.1.1 another pin is used for Ethernet PHY reset:

  D18: output: 1 [x] ethernet-phy@1.reset-gpios

So the reset pin gets successfully requested by the Ethernet PHY driver
in U-Boot proper without this interfering.

> 
>  > +     return ret;
>  > +}
>  > +
>  > +static const struct board_model *get_board_model(void)
>  > +{
>  > +     int i, val;
>  > +
>  > +     val = get_board_value();
>  > +     if (val < 0)
> 
> You probably want at least some debug message here?

I do not think that is fully necessary, we will see during the boot what
board FDT was loaded and if none was found it will be possible to use
regular gpio status cmd to see what value GPIO4_C4 (E20) has.

> 
>  > +             return NULL;
>  > +
>  > +     for (i = 0; i < ARRAY_SIZE(board_models); i++) {
>  > +             if (val == board_models[i].value)
>  > +                     return &board_models[i];
>  > +     }
>  > +
>  > +     return NULL;
>  > +}
>  > +
>  > +int rk_board_late_init(void)
>  > +{
>  > +     const struct board_model *model = get_board_model();
>  > +
>  > +     if (model)
>  > +             env_set("fdtfile", model->fdtfile);
>  > +
> 
> I would recommend to have U-Boot print the board version too as part of
> its normal boot log, c.f.:
> https://elixir.bootlin.com/u-boot/v2024.07/source/board/wandboard/wandboard.c#L450

Because this affects what FIT configuration is used, the correct FDT and
board model DT property will be used in U-Boot proper, and the normal
Model: prompt already show what model was loaded, e.g.:

  U-Boot 2024.10-rc1 (Jul 31 2024 - 08:21:29 +0000)

  Model: Xunlong Orange Pi 3B v2.1
  DRAM:  4 GiB

or:

  U-Boot 2024.10-rc1 (Jul 31 2024 - 08:21:29 +0000)

  Model: Xunlong Orange Pi 3B v1.1
  DRAM:  4 GiB

The FIT contains these configurations:

 Default Configuration: 'config-1'
 Configuration 0 (config-1)
  Description:  rk3566-orangepi-3b.dtb
  Kernel:       unavailable
  Firmware:     atf-1
  FDT:          fdt-1
  Loadables:    u-boot
                atf-2
                atf-3
                atf-4
                atf-5
                atf-6
 Configuration 1 (config-2)
  Description:  rk3566-orangepi-3b-v1.1.dtb
  Kernel:       unavailable
  Firmware:     atf-1
  FDT:          fdt-2
  Loadables:    u-boot
                atf-2
                atf-3
                atf-4
                atf-5
                atf-6
 Configuration 2 (config-3)
  Description:  rk3566-orangepi-3b-v2.1.dtb
  Kernel:       unavailable
  Firmware:     atf-1
  FDT:          fdt-3
  Loadables:    u-boot
                atf-2
                atf-3
                atf-4
                atf-5
                atf-6

The default one, config-1, will be used when the value of
GPIO4_C4 (E20) cannot be determined/read.

Regards,
Jonas

> 
> Cheers,
> Quentin


