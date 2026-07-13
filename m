Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E76AC44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 03:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9BDB848EB;
	Mon, 13 Jul 2026 05:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1628490A; Mon, 13 Jul 2026 05:53:01 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86318848A1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpip4t1783914706t9722c822
X-QQ-Originating-IP: Fh6y2eWMw7+Viux/TjJligZQqZrRPn6F3VfRfX0u1tY=
Received: from [IPv6:240f:10b:7440:1:ec1d:be03 ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 13 Jul 2026 11:51:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11080239488667176317
Message-ID: <C560616500933C79+f537d44c96dfe324b89b26599bc5a98da547ea0b.camel@radxa.com>
Subject: Re: [PATCH] rockchip: Add support for Radxa E52C
From: FUKAUMI Naok <naoki@radxa.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, 
 trini@konsulko.com, jonas@kwiboo.se, heiko@sntech.de, 
 christopher.obbard@linaro.org, cnsztl@gmail.com, xuhui.lin@rock-chips.com
Date: Mon, 13 Jul 2026 12:51:42 +0900
In-Reply-To: <a4a0d7e5-f117-456c-a25f-2f05373c09da@cherry.de>
References: <20260110011505.36915-1-naoki@radxa.com>
 <a4a0d7e5-f117-456c-a25f-2f05373c09da@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OVUlm4mSYM05pkMOL2/rQ9l1lLA94uh4E7TSohHTCOFUvsATPR/02Exl
 6MqPAQhXRrIKzZpOw8aro0X18RzLZUXj31UyWZ8YRlTP8RSPBcVAMcj9ZxMrnGJ9SqZz4Cu
 /wP/TKRRtKuetIYXG9FdedrUU2wEwGoXypEuNhyFzOqfIvdpDeHBf34P6Nodgdck16d96vj
 t8vB6vPehQo8RzfWyAHf2nm5BJ6NP74Zml6gZW+1qfVHMRx7u55nlZ1v1zNQZcaBcxriJfq
 vlxOSq55n2aU+/w4UqEoFp2uGrS9dFz4qrib79fWoDhjtv0v/BqnWJk4Gxw7c0B3Kyaxs3V
 0SOar0Mh1H2e6P0OneBOGT4DBkJMVBEtGrlntwezcbU3CD6oXPYE9kKYrdu5gxvus1ifUyH
 +LAPIy0BFhIFY3I1oWgn+chdnxqkq85Lrw6cJ94ctgmG/Pm5jUlbkTb/5gfu1CzHp6K3WZB
 o1AgDG7OwEWjugRaENPiyGPjRXgJkB0dBWT3knOyglpZXQLVgnTaLgPGxQiVC+EbFY5zjPI
 1Iz2qxRvIDhkWjNVO2/Y3uU/RjO5dv7ukVNz/ZZybWk3rX/7K+jncWgZ9tuQ+Fb7m+U5LjC
 E8M8gaa4w01qoAmNUSZCqlJNjlw8j4YjJ9D1gA37MjDNe+D1zrH373wgM7gO2AG1NWYFX67
 z93Jvcw7S/rE5vAxNjkUy0+eSbu15liWAYo+PY0pr3Cyf4AuVLkIR9inQBlD6ISihY4hZU1
 cnwAoUdo6e7I0yuRUpjHTwDOCvZ/bsPaP1KDvkh2m8SKmhpp0+JDi1nKEF7nNLXaXOiFf3k
 +Mwnwo0Vt8qOz5bwPQknyNJq05XX8opsbOeSo0bph24QUw6C84738XQTwIPjgrND94Ni0G1
 Cpn9WTwMhFmmvT8DM3YEI4SM8Yu+fvl2f3K6NDhlSjScRNO2B6wB7fKAuGQBV09wX24i2ji
 UHH43AZPO99fMFZgfeBMbExyG4OKRFSlq6+wnmBP0VzzJcsNqGc2xhxU2akkGALv5XAE4En
 zXCxjAWkd9fjuah2AFYmZD6qVUyvwy2VPiVWpmMg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

I won't be able to do it right away, but I plan to keep working on it.
Please give me a little more time.

Best regards,

--=20
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On Fri, 2026-07-10 at 11:46 +0200, Quentin Schulz wrote:
> Hi Naoki,
>=20
> Just to let you know that this patch will not be merged as-is due to=20
> review provided by Jonas. Please send a v2 with the feedback taken
> into=20
> account (or continue the discussion on this thread if you disagree
> with=20
> Jonas on his feedback) if you're still interested in adding support
> for=20
> the E52C, thanks!
>=20
> On 1/10/26 2:15 AM, FUKAUMI Naoki wrote:
> > The Radxa E52C is a compact network computer developed by Radxa,
> > based
> > on the Rockchip RK3582 SoC. [1]
> >=20
> > Specification:
> > - Dual Cortex-A76 and Quad Cortex-A55 cores
> > - 5TOPS NPU
> > - Up to 8GB LPDDR4x RAM
> > - Up to 64GB eMMC
> > - microSD card slot
> > - USB 3.0 Type-A OTG port
> > - USB Type-C debug port (USB-UART)
> > - USB Type-C power port (5V)
> > - 2x Gigabit Ethernet ports
> > - Maskrom and User buttons
> > - Aluminum alloy case
> >=20
> > [1] https://dl.radxa.com/e/e52c/radxa_e52c_product_brief.pdf
> >=20
> > Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> > ---
> > This patch depends on
> > =C2=A0
> > https://patchwork.ozlabs.org/project/uboot/patch/20260107230747.3552391=
-2-jonas@kwiboo.se/
> > ---
> > =C2=A0 arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi | 24 +++++++
> > =C2=A0 configs/radxa-e52c-rk3582_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 77
> > ++++++++++++++++++++++
> > =C2=A0 doc/board/rockchip/rockchip.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0 3 files changed, 102 insertions(+)
> > =C2=A0 create mode 100644 arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> > =C2=A0 create mode 100644 configs/radxa-e52c-rk3582_defconfig
> >=20
> > diff --git a/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> > b/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..dd65cdd250f
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2026 Radxa Computer (Shenzhen) Co., Ltd.
> > + */
> > +
> > +#include "rk3588s-u-boot.dtsi"
> > +
> > +/ {
> > +	leds-0 {
> > +		led-1 {
> > +			default-state =3D "on";
> > +			gpios =3D <&gpio4 RK_PB2 GPIO_ACTIVE_LOW>;
> > +		};
> > +
> > +		led-2 {
> > +			default-state =3D "on";
> > +			gpios =3D <&gpio4 RK_PB4 GPIO_ACTIVE_LOW>;
> > +		};
> > +	};
> > +};
> > +
> > +&sdhci {
> > +	mmc-hs200-1_8v;
> > +};
> > diff --git a/configs/radxa-e52c-rk3582_defconfig b/configs/radxa-
> > e52c-rk3582_defconfig
> > new file mode 100644
> > index 00000000000..5c1056867f2
> > --- /dev/null
> > +++ b/configs/radxa-e52c-rk3582_defconfig
> > @@ -0,0 +1,77 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> > +CONFIG_SYS_HAS_NONCACHED_MEMORY=3Dy
> > +CONFIG_COUNTER_FREQUENCY=3D24000000
> > +CONFIG_ARCH_ROCKCHIP=3Dy
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3582-radxa-e52c"
> > +CONFIG_ROCKCHIP_RK3588=3Dy
> > +CONFIG_SPL_SERIAL=3Dy
> > +CONFIG_TARGET_EVB_RK3588=3Dy
> > +CONFIG_SYS_LOAD_ADDR=3D0xc00800
> > +CONFIG_DEBUG_UART_BASE=3D0xFEB50000
> > +CONFIG_DEBUG_UART_CLOCK=3D24000000
> > +CONFIG_PCI=3Dy
> > +CONFIG_DEBUG_UART=3Dy
> > +CONFIG_FIT=3Dy
> > +CONFIG_FIT_VERBOSE=3Dy
> > +CONFIG_SPL_FIT_SIGNATURE=3Dy
> > +CONFIG_SPL_LOAD_FIT=3Dy
> > +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> > +CONFIG_OF_SYSTEM_SETUP=3Dy
> > +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3582-radxa-e52c.dtb"
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_SPL_MAX_SIZE=3D0x40000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_SPL_ATF=3Dy
> > +CONFIG_CMD_MEMINFO=3Dy
> > +CONFIG_CMD_MEMINFO_MAP=3Dy
> > +CONFIG_CMD_GPIO=3Dy
> > +CONFIG_CMD_GPT=3Dy
> > +CONFIG_CMD_MISC=3Dy
> > +CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_PCI=3Dy
> > +CONFIG_CMD_USB=3Dy
> > +# CONFIG_CMD_SETEXPR is not set
> > +CONFIG_CMD_RNG=3Dy
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=3Dy
> > +CONFIG_OF_LIVE=3Dy
> > +CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-
> > clocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
> > +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > +CONFIG_SPL_REGMAP=3Dy
> > +CONFIG_SPL_SYSCON=3Dy
> > +# CONFIG_ADC is not set
> > +CONFIG_SPL_CLK=3Dy
> > +CONFIG_ROCKCHIP_GPIO=3Dy
> > +CONFIG_LED=3Dy
> > +CONFIG_LED_GPIO=3Dy
> > +CONFIG_MISC=3Dy
> > +CONFIG_SUPPORT_EMMC_RPMB=3Dy
> > +CONFIG_MMC_DW=3Dy
> > +CONFIG_MMC_DW_ROCKCHIP=3Dy
> > +CONFIG_MMC_SDHCI=3Dy
> > +CONFIG_MMC_SDHCI_SDMA=3Dy
> > +CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> > +CONFIG_PHYLIB=3Dy
> > +CONFIG_RTL8169=3Dy
> > +CONFIG_PCIE_DW_ROCKCHIP=3Dy
> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> > +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=3Dy
> > +CONFIG_PHY_ROCKCHIP_USBDP=3Dy
> > +CONFIG_SPL_PINCTRL=3Dy
> > +CONFIG_DM_PMIC=3Dy
> > +CONFIG_PMIC_RK8XX=3Dy
> > +CONFIG_REGULATOR_RK8XX=3Dy
> > +CONFIG_SPL_RAM=3Dy
> > +CONFIG_BAUDRATE=3D1500000
> > +CONFIG_DEBUG_UART_SHIFT=3D2
> > +CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_ROCKCHIP_SPI=3Dy
> > +CONFIG_SYSRESET=3Dy
> > +CONFIG_SYSRESET_PSCI=3Dy
> > +CONFIG_USB=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_DWC3=3Dy
> > +CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_ERRNO_STR=3Dy
> > diff --git a/doc/board/rockchip/rockchip.rst
> > b/doc/board/rockchip/rockchip.rst
> > index 7a8532b49fc..2fd7d687d2e 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -160,6 +160,7 @@ List of mainline supported Rockchip boards:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Khadas Edge2 (khadas-edge2-rk358=
8s)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - MNT Reform2 (mnt-reform2-rk3588)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Pine64 QuartzPro64 (quartzpro64-=
rk3588)
> > +=C2=A0=C2=A0=C2=A0=C2=A0 - Radxa E52C (radxa-e52c-rk3582)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Radxa ROCK 5 ITX (rock-5-itx-rk3=
588)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Radxa ROCK 5A (rock5a-rk3588s)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Radxa ROCK 5B/5B+/5T (rock5b-rk3=
588)
>=20
