Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD17C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 12:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CDB886DC;
	Wed,  1 May 2024 14:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wns5LgRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F54A88840; Wed,  1 May 2024 14:28:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE76A886AE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 14:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=373c=MF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714566505;
 bh=JFePwJBfYnQDIVyoha7zw5w+WjK+JmdXmPjFHV+tGWk=;
 b=wns5LgRXzOmuLmZfC/kDSKqzd6R6757gqNUXmqfPLWR9d+aS3AN/Jgss41NMM9Cw0SCjqPlGP
 xM08BlRVwczNl0Zq8tr8BXbRcemoMCeAfspR5JhTuy0CkgkcnrN2IIHHTQRi5DJjt4wnaj/X1De
 IgIHn9RGAc21M51hAAO8oefNh9L3HOfznOqIwlwXP1fjXFiy2THMo9BVN34/pLIeHiDzEwoY3eS
 8YEvm6K8235lOyyvMEdyNtabPWr16qsRKbFvouzNRteQ02gTtATXzevH+IR8ScRAEPRRDvAp6v4
 FvxFREwRK8txZHgO0K5gP8ZR8/FsmO9ioMv1KX1BfiDg==
Message-ID: <7f039d21-de2f-45c9-aec1-66de33c7dd1a@kwiboo.se>
Date: Wed, 1 May 2024 14:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/31] rockchip: rk3399-rock960: Sync device tree from
 linux v6.8
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-27-jonas@kwiboo.se>
 <CALeDE9NoNE5AocQvuKuvzbWM6y+wYqdOiT7=1SpBzaN7-VV8Cg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CALeDE9NoNE5AocQvuKuvzbWM6y+wYqdOiT7=1SpBzaN7-VV8Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66323566ab9e3c23aeb90c79
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

Hi Peter,

On 2024-04-03 06:53, Peter Robinson wrote:
> On Sun, 31 Mar 2024 at 21:34, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Sync rk3399-rock960 related device tree from linux v6.8.
> 
> TBH I wouldn't class this as "Sync device tree from linux v6.8", it
> does a dozen other things as well!

Agree, I have updated the commit subject to "Sync DT from v6.8 and
update defconfig" in v2, not sure that will fully address your concern.

This series tries to update all rk3399 boards to v6.8 DT and enable a
few similar options (when DT node exists) across all RK3399 boards.

Some boards was missing a lot of features/options that already is
supported on other RK3399 boards and having a bigger "get up to date"
commit makes sense to me :-)

> 
>> Add DM_RESET=y to support reset signals.
>>
>> Add PCI=y, CMD_PCI=y and NVME_PCI=y to support PCIe and NVMe boot.
>>
>> Add AHCI=y, SCSI_AHCI=y, AHCI_PCI=y and SCSI=y to support PCIe SATA boot.
>>
>> Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.
>>
>> Remove CONFIG_NET_RANDOM_ETHADDR=y, ethaddr and eth1addr is set based on
>> cpuid read from eFUSE.
>>
>> Add MMC_SDHCI_SDMA=y to use DMA transfer for eMMC.
>>
>> Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.
>>
>> Add PHY_ROCKCHIP_INNO_USB2=y and PHY_ROCKCHIP_TYPEC=y to support USB PHY.
>>
>> Remove REGULATOR_PWM=y and DM_REGULATOR_GPIO=y, boards does not use
>> pwm-regulator or regulator-gpio compatible.
>>
>> Add USB_XHCI_HCD=y, USB_DWC3=y and USB_DWC3_GENERIC=y to support USB3.
>>
>> Remove USE_PREBOOT=y to speed up booting, standard boot will init USB
>> after faster boot media has been evaluated.
> 
> Does it init nvme and friends?

Yes, it should init nvme and friends after it has tried to find
extlinux/script/efi on faster boot media (sdhci/sdmmc).

> 
>> Add CMD_ROCKUSB=y, CMD_USB_MASS_STORAGE=y and USB_GADGET=y to support
>> RockUSB and UMS gadget.
> 
> Does this have effect on boot speed?

It should not affect boot speed, end-user will have to run a rockusb/ums
cmd on cli to use this feature.

Regards,
Jonas

> 
>> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  arch/arm/dts/rk3399-ficus.dts    |  4 ++++
>>  arch/arm/dts/rk3399-rock960.dtsi |  5 ++++-
>>  configs/ficus-rk3399_defconfig   | 22 +++++++++++++++++-----
>>  configs/rock960-rk3399_defconfig | 14 +++++++++++---
>>  4 files changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/dts/rk3399-ficus.dts b/arch/arm/dts/rk3399-ficus.dts
>> index 1ce85a5816e4..30e4879f322c 100644
>> --- a/arch/arm/dts/rk3399-ficus.dts
>> +++ b/arch/arm/dts/rk3399-ficus.dts
>> @@ -13,6 +13,10 @@
>>         model = "96boards RK3399 Ficus";
>>         compatible = "vamrs,ficus", "rockchip,rk3399";
>>
>> +       aliases {
>> +               ethernet0 = &gmac;
>> +       };
>> +
>>         chosen {
>>                 stdout-path = "serial2:1500000n8";
>>         };
>> diff --git a/arch/arm/dts/rk3399-rock960.dtsi b/arch/arm/dts/rk3399-rock960.dtsi
>> index 25dc61c26a94..c920ddf44baf 100644
>> --- a/arch/arm/dts/rk3399-rock960.dtsi
>> +++ b/arch/arm/dts/rk3399-rock960.dtsi
>> @@ -7,6 +7,7 @@
>>
>>  #include "rk3399.dtsi"
>>  #include "rk3399-opp.dtsi"
>> +#include <dt-bindings/interrupt-controller/irq.h>
>>
>>  / {
>>         aliases {
>> @@ -127,6 +128,8 @@
>>  };
>>
>>  &hdmi {
>> +       avdd-0v9-supply = <&vcca0v9_hdmi>;
>> +       avdd-1v8-supply = <&vcca1v8_hdmi>;
>>         ddc-i2c-bus = <&i2c3>;
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&hdmi_cec>;
>> @@ -528,7 +531,7 @@
>>                 compatible = "brcm,bcm4329-fmac";
>>                 reg = <1>;
>>                 interrupt-parent = <&gpio0>;
>> -               interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
>> +               interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
>>                 interrupt-names = "host-wake";
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&wifi_host_wake_l>;
>> diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
>> index f4e3ebba8f46..0d97b7ecb3c7 100644
>> --- a/configs/ficus-rk3399_defconfig
>> +++ b/configs/ficus-rk3399_defconfig
>> @@ -5,15 +5,18 @@ CONFIG_ARCH_ROCKCHIP=y
>>  CONFIG_SF_DEFAULT_SPEED=20000000
>>  CONFIG_ENV_OFFSET=0x3F8000
>>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-ficus"
>> +CONFIG_DM_RESET=y
>>  CONFIG_ROCKCHIP_RK3399=y
>>  CONFIG_TARGET_ROCK960_RK3399=y
>>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>>  CONFIG_DEBUG_UART_CLOCK=24000000
>>  CONFIG_SYS_LOAD_ADDR=0x800800
>> +CONFIG_PCI=y
>>  CONFIG_DEBUG_UART=y
>> +CONFIG_AHCI=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-ficus.dtb"
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_SPL_MAX_SIZE=0x2e000
>> +CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>> @@ -21,6 +24,7 @@ CONFIG_TPL=y
>>  CONFIG_CMD_BOOTZ=y
>>  CONFIG_CMD_GPT=y
>>  CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PCI=y
>>  CONFIG_CMD_USB=y
>>  # CONFIG_CMD_SETEXPR is not set
>>  CONFIG_CMD_TIME=y
>> @@ -29,27 +33,35 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
>>  CONFIG_ENV_IS_IN_MMC=y
>>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>  CONFIG_SYS_MMC_ENV_DEV=1
>> -CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_SCSI_AHCI=y
>> +CONFIG_AHCI_PCI=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>>  CONFIG_ROCKCHIP_IODOMAIN=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>>  CONFIG_MMC_SDHCI_ROCKCHIP=y
>> +CONFIG_PHY_REALTEK=y
>> +CONFIG_DM_ETH_PHY=y
>>  CONFIG_ETH_DESIGNWARE=y
>> -CONFIG_RGMII=y
>>  CONFIG_GMAC_ROCKCHIP=y
>> +CONFIG_NVME_PCI=y
>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>> +CONFIG_PHY_ROCKCHIP_TYPEC=y
>>  CONFIG_PMIC_RK8XX=y
>> -CONFIG_REGULATOR_PWM=y
>> -CONFIG_DM_REGULATOR_GPIO=y
>>  CONFIG_REGULATOR_RK8XX=y
>>  CONFIG_PWM_ROCKCHIP=y
>> +CONFIG_SCSI=y
>>  CONFIG_BAUDRATE=1500000
>>  CONFIG_DEBUG_UART_SHIFT=2
>>  CONFIG_SYS_NS16550_MEM32=y
>>  CONFIG_SYSRESET=y
>>  CONFIG_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>>  CONFIG_USB_EHCI_HCD=y
>>  CONFIG_USB_EHCI_GENERIC=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GENERIC=y
>>  CONFIG_ERRNO_STR=y
>> diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
>> index 3b5ab7dc5781..e19b28753156 100644
>> --- a/configs/rock960-rk3399_defconfig
>> +++ b/configs/rock960-rk3399_defconfig
>> @@ -12,11 +12,11 @@ CONFIG_DEBUG_UART_CLOCK=24000000
>>  CONFIG_SYS_LOAD_ADDR=0x800800
>>  CONFIG_PCI=y
>>  CONFIG_DEBUG_UART=y
>> -CONFIG_USE_PREBOOT=y
>> +CONFIG_AHCI=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock960.dtb"
>>  CONFIG_SYS_PBSIZE=1052
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_SPL_MAX_SIZE=0x2e000
>> +CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>> @@ -28,6 +28,8 @@ CONFIG_CMD_MMC=y
>>  CONFIG_CMD_PCI=y
>>  # CONFIG_CMD_SF is not set
>>  CONFIG_CMD_USB=y
>> +CONFIG_CMD_ROCKUSB=y
>> +CONFIG_CMD_USB_MASS_STORAGE=y
>>  # CONFIG_CMD_SETEXPR is not set
>>  CONFIG_CMD_TIME=y
>>  CONFIG_CMD_PMIC=y
>> @@ -37,6 +39,9 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
>>  CONFIG_ENV_IS_IN_MMC=y
>>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>  CONFIG_SYS_MMC_ENV_DEV=1
>> +CONFIG_SCSI_AHCI=y
>> +CONFIG_AHCI_PCI=y
>> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>>  CONFIG_ROCKCHIP_IODOMAIN=y
>> @@ -52,6 +57,7 @@ CONFIG_PMIC_RK8XX=y
>>  CONFIG_REGULATOR_PWM=y
>>  CONFIG_REGULATOR_RK8XX=y
>>  CONFIG_PWM_ROCKCHIP=y
>> +CONFIG_SCSI=y
>>  CONFIG_BAUDRATE=1500000
>>  CONFIG_DEBUG_UART_SHIFT=2
>>  CONFIG_SYS_NS16550_MEM32=y
>> @@ -71,9 +77,11 @@ CONFIG_USB_ETHER_ASIX88179=y
>>  CONFIG_USB_ETHER_MCS7830=y
>>  CONFIG_USB_ETHER_RTL8152=y
>>  CONFIG_USB_ETHER_SMSC95XX=y
>> +CONFIG_USB_GADGET=y
>> +CONFIG_USB_GADGET_DOWNLOAD=y
>> +CONFIG_USB_FUNCTION_ROCKUSB=y
>>  CONFIG_VIDEO=y
>>  CONFIG_DISPLAY=y
>>  CONFIG_VIDEO_ROCKCHIP=y
>>  CONFIG_DISPLAY_ROCKCHIP_HDMI=y
>> -CONFIG_SPL_TINY_MEMSET=y
>>  CONFIG_ERRNO_STR=y
>> --
>> 2.43.2
>>

