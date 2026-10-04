Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F99CA5FE6
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 19:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 330AB6070D;
	Sun,  4 Oct 2026 19:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZoutBhr6jmLI; Sun,  4 Oct 2026 19:33:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 29E8A60705
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791142388;
	b=VzutAHj/8vantrKX9VeFFuhlawhwg9HcS4/Ab7KjbDxo0e/vrmCZRCn79pav08bROJNX
	 hlHDEwJSoUYKMWhjGUaNta+Nl/jMW22cTpRO2xsLnbCWnhFQzr7vcugAa9KhejF2mL38k
	 UswUSPa7lQpqN8/It+YbqNLBK3HTjSdGR0zP1UrugIOA8m/8oUZQuv0pHTNGyLh3OhzAx
	 BHsfdy6f+3RGbpUz29aStiBM4AhcfWMbDybNEujLeNlmh1HxWKs3p2yXld0AKbay/uOF+
	 G6LQdgmIFm9rr131Vflg0piSFMddmvjz8HKnrZcg9r/lZ+LpfHL6hSDnfOc8D2+vzgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791142388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z4J4Iq2hhmuy0FXSR+VSAFUN3g+2fVK/VqzIc5Ei1Ag=;
	b=Przy7/2y0Jqsj3eTaKn6TdvB/JhghdedePKGM01ZS5qsYO3YjGwTk2HUSqahoJP5ZCzS
	 mftaHULSr+7e811ib8u99fuINJPZE4c61lQ5wp+o8v+GW5OfRrw7qHrM7w3wB/ExrCFE4
	 tY/2bQS7ETTQIDUMleKD060EQ9pxZWw/6ZpbjqGq8a6zERGy7oK1mvN+3PbKFiKRTySd6
	 nk2E71xCtLIQeAbDN9AToJ4XdDSFNyv6IginlTQGlHMgEl9/wcDrAhpEobjC/JnZr6TgR
	 Ihm/BzsEuyNJkjLTfMIRmfx5KoFXNDmSfkEHe7NHbKXv9JpI+kNSLQgedbpe3PZUoDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791142388;
	bh=z4J4Iq2hhmuy0FXSR+VSAFUN3g+2fVK/VqzIc5Ei1Ag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jeHvKvXfBiGmm+Z6+CCfk+r+7EqedW0LjA3DkB1Dkbph6m97bbDnVc+hs7W9/zw+v
	 h4CJ54wZePc/FQxiPW7paPyemtT0W816FN/mc9V1UqzMGMTWiXmRjBAwx8DHR/NMyb
	 TfDVA8ZMn6Ci3725QQGpIldlC2/6kSPZU8qomjDWMugnbQFrIHcfb7CsUmuOILkKXE
	 UCuugrYpFjhyrCpQyX3dCvhytvWFnp7RfIkovWwbQX7Jc6iOAENxXmbLLJfOEv75Vq
	 G8vhKXkAWv4B2m9vbZyBA64MGAGZU8VNmq+fRT0HUsX+ClAmmoPklU0EixuYRn1GS/
	 ZJFK4ICDpGBOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29E8A60705;
	Sun,  4 Oct 2026 19:33:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CF5A323
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1A8440004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5GDofOpaF-x for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:32:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C89324002B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791142357;
 b=nzUDSBsonWjfsRfWCSh68Ls6vykaTALAfk5i05VM3zGV1jJrq3U/+Gu4kpycknx9J8V/
 JZf6dgUo9NmLOFpdaSH94DUsi3KRbzX2XMr6ssqiPcD8Yy9EBNkRK6+0xJu/ikLmhgHoD
 pTyPk+HbBcYIjfaqst4G55xNcOVdG8xXJjPt/WJbOxa1+RaLhMW/EkeUMNuHRIx6QifSk
 X1wW5JEvIESoujKsc1j+2AqO8FVETMpNs2EiPWdRdG/QePRkFMTD4f3Sq4tVLdB5Peyzy
 f7Rohe97CMiK4Ew6dhds5/0Dj/8g7tBzJ+BgQR3aJjs9FaOb8AEXquTTyaQ0cZZD55w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791142357;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=z4J4Iq2hhmuy0FXSR+VSAFUN3g+2fVK/VqzIc5Ei1Ag=;
 b=dDalpBDpkGhrvGwDPbqFlqqI5syRR5G49OOcSZE8XkctrE2J9rsqzdpM76v4j754P3ax
 9dDLFkFmdlFREGYmjwq4C2YX+qXt6jLDVgLAZ5VtJM9QKhU4dV/Z66IAozigIx+zn44qG
 QqYt+9tRE0E4jry6TFfmOT7scl6aOZhW3Wmagh/ULAxR5jtpr5a4ACq0OyNIWM85OaSLe
 p0saeWyVnQVueX8dlUyvw6Eyd5J/xwUikac0JnbLsIApawaEaigpFFPTStJvIK8AYN896
 iTBfK+nx9bOFXTQ983ujQpv/NW6aySNElVazGRFn6DqoqcCVc1LHg6pOH+iecG+BzXg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=UVEGhFS3; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=UVEGhFS3
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C89324002B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791142354;
 bh=z4J4Iq2hhmuy0FXSR+VSAFUN3g+2fVK/VqzIc5Ei1Ag=;
 b=UVEGhFS3szKeV28FCT63GbhNes1yvUU68HOLCv/gCKRiAa6FMsriw+vFPCdu0l1SACsYMPRsd
 mFI4WNJGU6R5gcaVNwhR+6fprE2abFjsyV0SYPxsuKWFUhxDFPwQD0T1AIIvlCjheh996ZavKjg
 1tWp6/s9+hPPjYnPnPVIWD4FVaoXR7Vw6LtD+T2kX5FEwe0k+yLYxMEPC9pYtEUAZrY2nSar55A
 DhiUUKUv1FLtUGFmmx0mSrhwG/2w7/V6fxThHtkFMpm0utNSSTVHKMBqakeq4C9xnwDX5M1Ju+c
 wazPUt6fJ00atkiM0+wLMPyny8u2s//uisw9M0jc5pow==
X-Forward-Email-ID: 6ac2a9ce9f8eebecc588a1ea
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d50c807c-9e70-4541-b710-0cade21b2114@kwiboo.se>
Date: Sun, 4 Oct 2026 21:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] board: rockchip: Add Xunlong Orange Pi 5 Pro
To: Dennis Gilmore <dennis@ausil.us>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261002031334.3285687-1-dennis@ausil.us>
 <20261002031334.3285687-6-dennis@ausil.us>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20261002031334.3285687-6-dennis@ausil.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Dennis,

On 10/2/2026 5:13 AM, Dennis Gilmore wrote:
> The Xunlong Orange Pi 5 Pro is a single-board computer based on the
> Rockchip RK3588S SoC. The board provides many interfaces, including
> two HDMI output ports, a PCIe-attached Motorcomm YT6801 2.5GbE port,
> an M.2 M-Key slot, one USB 3.0 and four USB 2.0 ports.
> 
> Features tested on an Orange Pi 5 Pro 16GB:
> - SD-card boot
> - eMMC boot
> - PCIe/NVMe
> 
> The devicetree is taken from Linux v7.3 via the preceding dts/upstream
> picks.
> 
> The upstream devicetree muxes the PERST# pin of pcie2x1l1 and
> pcie2x1l2 to the controller's dedicated function while also using it
> as reset-gpios. Linux switches the pin to GPIO when it is requested,
> U-Boot does not, and probing pcie2x1l2 then hangs. Override the
> pinctrl in the -u-boot.dtsi to use GPIO function for the reset pins,
> like rk3568-rock-3a-u-boot.dtsi does, until the Linux devicetree is
> fixed.
> 
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> ---
>  .../dts/rk3588s-orangepi-5-pro-u-boot.dtsi    | 25 ++++++
>  board/rockchip/evb_rk3588/MAINTAINERS         |  6 ++
>  configs/orangepi-5-pro-rk3588s_defconfig      | 82 +++++++++++++++++++
>  doc/board/rockchip/rockchip.rst               |  1 +
>  4 files changed, 114 insertions(+)
>  create mode 100644 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
>  create mode 100644 configs/orangepi-5-pro-rk3588s_defconfig
> 
> diff --git a/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
> new file mode 100644
> index 00000000000..142db4a0fcf
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +&pcie2x1l1 {
> +	pinctrl-0 = <&pcie2x1l1_reset_h>, <&pcie30x1m1_1_clkreqn>,
> +		    <&pcie30x1m1_1_waken>;
> +};
> +
> +&pcie2x1l2 {
> +	pinctrl-0 = <&pcie2x1l2_reset_h>, <&pcie20x1m0_clkreqn>,
> +		    <&pcie20x1m0_waken>;
> +};
> +
> +&pinctrl {
> +	pcie {
> +		pcie2x1l1_reset_h: pcie2x1l1-reset-h {
> +			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie2x1l2_reset_h: pcie2x1l2-reset-h {
> +			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index b64dd4947ee..0cc32a6e28e 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -35,6 +35,12 @@ S:	Maintained
>  F:	configs/orangepi-5-rk3588s_defconfig
>  F:	arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
>  
> +ORANGEPI-5-PRO-RK3588S
> +M:	Dennis Gilmore <dennis@ausil.us>

I also have this board, feel free to add me as a reviewer:

	R: Jonas Karlman <jonas@kwiboo.se>

> +S:	Maintained
> +F:	configs/orangepi-5-pro-rk3588s_defconfig
> +F:	arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
> +
>  ORANGEPI-5-MAX-RK3588
>  M:	Ilya Katsnelson <me@0upti.me>
>  S:	Maintained
> diff --git a/configs/orangepi-5-pro-rk3588s_defconfig b/configs/orangepi-5-pro-rk3588s_defconfig
> new file mode 100644
> index 00000000000..f4c6eecf2d5
> --- /dev/null
> +++ b/configs/orangepi-5-pro-rk3588s_defconfig
> @@ -0,0 +1,82 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-orangepi-5-pro"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_EFI_SECURE_BOOT=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="pci enum; usb start; nvme scan;"

There PREBOOT commands should typically not be needed for normal
uninterrupted boot. Please help me understand why use of PREBOOT is
needed for this board, and preferably drop use of PREBOOT.

Also use of 'bootflow scan -G' is likely a better option if finding boot
sources is the issue your are trying to solve with PREBOOT.

> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5-pro.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y

Should not really be needed, seem to print Model and SoC two times:

  U-Boot 2026.10-rc5 (Oct 04 2026 - 17:10:29 +0000)

  Model: Xunlong Orange Pi 5 Pro
  SoC:   RK3588S
  DRAM:  4 GiB
  PMIC:  RK806 (on=0x40, off=0x00)
  Core:  771 devices, 32 uclasses, devicetree: separate
  MMC:   mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
  Loading Environment from nowhere... OK
  In:    serial@feb50000
  Out:   serial@feb50000
  Err:   serial@feb50000
  Model: Xunlong Orange Pi 5 Pro
  SoC:   RK3588S
  Net:   No ethernet found.
  Hit any key to stop autoboot: 0

> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_EFIDEBUG=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_SYSCON=y

Based on DT this should likely also have:

  CONFIG_BUTTON=y
  CONFIG_BUTTON_ADC=y

However, the Recovery key is not hooked up to SARADC, so DT is wrong and
should likely instead define the Maskrom key.

> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y

> +CONFIG_VIDEO=y
> +CONFIG_DISPLAY=y
> +CONFIG_VIDEO_ROCKCHIP=y
> +CONFIG_DISPLAY_ROCKCHIP_HDMI=y

Above 4 options are not supported on RK3588 so not really needed,
please drop them.

> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de2df3046e2..dfaceb40f46 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -179,6 +179,7 @@ List of mainline supported Rockchip boards:
>       - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
>       - Xunlong Orange Pi 5 Max (orangepi-5-max-rk3588)
>       - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
> +     - Xunlong Orange Pi 5 Pro (orangepi-5-pro-rk3588s)
>       - Xunlong Orange Pi 5 Ultra (orangepi-5-ultra-rk3588)
>       - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
>       - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)

With above addressed this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas


