Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C9606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WrWmp6T6;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Gd/8cDOt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 522AA40607;
	Wed, 28 Oct 2026 11:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ScWWAi_GCkat; Wed, 28 Oct 2026 11:26:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CCDFA405B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186768;
	b=oiltFWmdZvz9K6WbPYlRCc6xf5G1IC3pndyT1REfu8xllc1rU1Q8CJgMRfVsc9pOw1gu
	 XchsrRdBsWp4vLTvP+3jOj5wK13iqyVfNDtGaLHoGyaSlQPdeMnNgWwtnku1+/1E7VKlC
	 SAG5now5bRp9Npw6n3EUxUxQb1Sp/6TZU8xTqlOLX1CGMrCebavj6b8JB7yA/oYghXov/
	 lrxMCEnVO9uUcmUNPzMq9InutU3QaIgr9SilmvIiyVu+xk+3sFx/j729xvXYTSFzx1IOA
	 eERbVivKFgttYgXbuMEffsZH2U5WFoj7KAZ3IknuiMBbSxBUkXCJ8wJSxPRkHJxU/bw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186768;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rLMiP1W1XMuIXzqtl+ss2ATOytxYrxYC8n2fNX2/oTk=;
	b=DJNYpj0IBXW8HCp+pwJZUbiwJ2Oq8SI9xgQ5tAA7tR9fwmmKGbfjxGrWQiGjQaMbAaQp
	 K1mnG18azCbpq7I1z5HayWYI/ZyKUHThBXbkouoGDOr7DyzSc7iMVlVgJ7bJu12aN+11E
	 5Gj2YkZqE9yDej5SA91YSEf/PwCX9rnXlz613O/n4QJNnLNqNfY/ijdmIYqtzuh2q5hgI
	 ybEYoMtys2Y5ymE3pnbhum7ZZH4yAGpUmA2HhVHhKtJYD0sqiWjyLga6gFnpIC7qe9ecH
	 0ZNokew6OwH/BGs0oygbrnvhMQIXyFKhqc9WlrxnNZhsA2796AgaM2Mjq5RMPN8RN4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793186767;
	bh=rLMiP1W1XMuIXzqtl+ss2ATOytxYrxYC8n2fNX2/oTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WrWmp6T6GPK+VzI4D6RE2zBwmNCEByH4nJgeSSVRg2+oOEvNChWGCUg4iVTeHGSCt
	 I5gnxnqvXokK79BlNUOChvw2TW8XXgWOX33nP3ZNDXNwcNHgjS+Yld3ahNU/q8WBMk
	 2xu61mSMNvyMLQUsl7f2/lhNI+Zrv94d2Y9LubqUiL0DJ9IKv8xHutdPGQozyJgzHW
	 /ITOG6IwvZqSpDR1Qu8rx8631Sug0HfdVCUu0SbSGBsF/WQQw1LnLO5JtDFlbWhaDa
	 u+V0vnacXkhY+4+02eY2pHC043ilzHxCEiTbhNSWWXzi0Zc236d2n6aYzzue/b2Viy
	 +pEZTOODptT6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCDFA405B3;
	Wed, 28 Oct 2026 11:26:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4697C2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C0E040087
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0hXqv7f3UmT for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:26:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C56CC4006F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=45.157.188.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793186764;
 b=lIwXLmgOOGRVqLnE9O61oCXmOURt2IX4PuC7MA5+WC9DjqSwb1lCDAYJnQto3BzCY9qI
 Hph6wh7o5YyLzVtvCJuqVF8qIgh6N3X6sTxEdXmnC3yWVCDdzOnNswpkkaiMVikwNShn3
 Aj/2KL8xoTiOpsoWS46W+3P3tNIykKtZEY/ZMJlzQ6263v3qE+EdUOKYd3cnXnrtcimw+
 jcYOWnB80+mQN2NwE4VVctvYA9M2yG+9BKVjsF/DnfMFW+hcXcDO1RQBzEvxvn/Y+EEwb
 UKgfb2YfjNYIcsPFF9PKq2jv6RZw5fioSgC9pwxp7BqBZgP5WWd3eQWvtqEIB6iH6fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793186764;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=rLMiP1W1XMuIXzqtl+ss2ATOytxYrxYC8n2fNX2/oTk=;
 b=DZv9t2zEWLmN6uH8p2u49Hb5F/sPejkM8vcEYHhZjU5Rnm5TGqa8SkP6jPI7hektsFV1
 X2SO77N4pN7ytL88g2aQHNcJ8nOiRQx/9wtTJxHZ+i7YH87a6sOXuFpU5fdnTtfUrYeuC
 YVLr+69P8U9oe6LGodjnZuPefxKI7Ce/Hs+IIPlhRFUnsI0Hdss887e8m3NSYalWtSN9f
 Y9KFZIY/A31N7R+LjXsjh3o4RLL6XzK88poZIGqlZOxua+ij/MB36kIN99KaWMF2os+FE
 47spkVXDazTYkwpwq3vMyTnE8SRg8xpd6NE00OKWYIFuC7mUOjaZX/pQfCmiplxOpCg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b="Gd/8cDOt"; 
 arc=none smtp.remote-ip=45.157.188.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Gd/8cDOt
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C56CC4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:26:02 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jF4ml3lWCzTkc;
 Wed, 28 Oct 2026 12:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793186759;
 bh=rLMiP1W1XMuIXzqtl+ss2ATOytxYrxYC8n2fNX2/oTk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Gd/8cDOtAFRWpBIaxEWwsOOBjr8FnhwiN97Me1raNu+buUjrUcoa6DouYywLJDCt5
 w/UHTk8kbIHhiBo4WkGpEHFGB2TruiJxnUYODinDTWUoakK3IxY4dA2uKCvIRSVpx5
 qOVgDG53N/qDGrEZQ9iE1DR9HkDGqoaiy+aGN4XTx2idtrUWGqWz5UthFsxvThGDt7
 /sp1NqL1mjEIDRLfUEl5Sms/syJ9FeDDCPD2+KHZydiSkodqi7Ncyr0i2TuAkRG1Gz
 4QcAYuYfh4L0tAJFiDX8w2ONON8+Dig9eed71zsBHaon6PUUTiMeANzFZL/nBd8SHR
 WASu4CE3Jv6wg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jF4mk116hzlY; Wed, 28 Oct 2026 12:25:58 +0100 (CET)
Message-ID: <b102efbe-548b-42b5-bdba-c744449db9e6@0leil.net>
Date: Wed, 28 Oct 2026 12:25:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add Kobol Helios64
To: iav@iav.lv, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261021-b4-helios64-v1-1-74afe8aa6d72@iav.lv>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261021-b4-helios64-v1-1-74afe8aa6d72@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 10/21/26 3:04 AM, Igor Velkov via B4 Relay wrote:
> From: Igor Velkov <iav@iav.lv>
> 
> Add support for the Kobol Helios64, an RK3399 NAS board with 4 GiB of
> LPDDR4, eMMC, SD card, SPI NOR flash, a 1 GbE RTL8211F PHY, a 2.5 GbE
> RTL8156 on USB and a JMB585 SATA controller on PCIe.
> 
> The board uses the upstream device tree. The -u-boot.dtsi adds the
> LPDDR4 timings for the open-source TPL and the vdd_log PWM regulator
> and the vdd_center RK808 buck, which the upstream device tree does not
> describe yet, and sets both rails to 950 mV. RockPro64 sets vdd_center
> the same way, see commit f210cbc1f3d4 ("arm: dts: rk3399-rockpro64:
> slightly increase center voltage").
> 
> Without the vdd_log and vdd_center nodes, Linux 7.3 reset or hung about
> 2.3 s into the boot in 2 of 2 cold boots. With both rails at 950 mV,
> 20 cold boots of Linux 7.3 showed no memory errors.
> 
> Features tested on a Helios64:
> - eMMC boot (TF-A v2.13.0 BL31, open-source TPL)
> - GMAC Ethernet (DHCP, TFTP)
> - USB 3 host
> 
> Not working yet: PCIe (pcie_rockchip fails to request ep-gpios).
> SD card and SPI flash boot are untested.
> 
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> No MAINTAINERS entry on purpose: I cannot commit to maintaining the
> board. It falls under ARM ROCKCHIP via "N: rk3", and
> buildman --maintainer-check passes.

Can we have you as a reviewer at least, so that any patch modifying 
either of the first two helios64-specific patches are sent to you and 
you can review/test them? Is this something you'd be ok with?

> ---
>   arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi | 56 +++++++++++++++++
>   configs/helios64-rk3399_defconfig              | 84 ++++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst                |  1 +
>   3 files changed, 141 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi b/arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi
> new file mode 100644
> index 00000000000..0f8e9353066
> --- /dev/null
> +++ b/arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3399-u-boot.dtsi"
> +#include "rk3399-sdram-lpddr4-100.dtsi"
> +
> +/ {
> +	vdd_log: regulator-vdd-log {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm2 0 25000 1>;
> +		pwm-supply = <&vcc5v0_sys>;
> +		regulator-name = "vdd_log";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <830000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-init-microvolt = <950000>;
> +	};
> +};
> +
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +&rk808 {
> +	regulators {
> +		vdd_center: DCDC_REG1 {
> +			regulator-name = "vdd_center";
> +			regulator-always-on;
> +			regulator-boot-on;
> +			regulator-min-microvolt = <950000>;
> +			regulator-max-microvolt = <950000>;
> +		};
> +	};
> +};
> +

Please work with the Linux kernel to get the vdd_log and vdd_center 
parts reviewed and merged there. Then we can have support for the 
Helios64 in here once merged there and available in devicetree-rebasing 
(https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/).

> +&gpio0 {
> +	bootph-pre-ram;
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +};
> +
> +&sdmmc0_pwr_h {
> +	bootph-pre-ram;
> +};
> +
> +&spiflash {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&vcc3v0_sd {
> +	bootph-pre-ram;
> +};
> diff --git a/configs/helios64-rk3399_defconfig b/configs/helios64-rk3399_defconfig
> new file mode 100644
> index 00000000000..16cddc71e0d
> --- /dev/null
> +++ b/configs/helios64-rk3399_defconfig
> @@ -0,0 +1,84 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=25000000
> +CONFIG_ENV_OFFSET=0x3F8000

This is already the default (except it's a lowercase f by default, hence 
why it appears in the defconfig), please simply write it lowercase so 
it's using the default value.

> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-kobol-helios64"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3399=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y

You said SPI flash boot wasn't tested, maybe don't generate an image 
that we don't know is valid?

> +CONFIG_TARGET_EVB_RK3399=y
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_DEBUG_UART_BASE=0xFF1A0000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-kobol-helios64.dtb"
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000

Considering you didn't test SPI flash boot, I would say this is not a 
good idea. Is the offset used by the Helios64 original support known? We 
should aim to reuse it if specified, so we don't break existing setups 
if they want to upgrade to upstream.

> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y

Are you using the Rockchip bl31 blob as TF-A or upstream? This symbol is 
only required for the Rockchip blob.

> +CONFIG_TPL=y
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_POWEROFF=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_TIME=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"

Please remove clock-names from this here, I prefer we only keep a list 
of things that could be problematic in SPL DTB, and clock-names is not 
one of those (I believe at least).

> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_TYPEC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_RAM_ROCKCHIP_LPDDR4=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_HOST_ETHER=y
> +CONFIG_USB_ETHER_ASIX=y
> +CONFIG_USB_ETHER_ASIX88179=y
> +CONFIG_USB_ETHER_MCS7830=y
> +CONFIG_USB_ETHER_RTL8152=y
> +CONFIG_USB_ETHER_SMSC95XX=y

Are there really that many USB Ethernet adapters on the board? From 
https://wiki.kobol.io/helios64/img/hardware/helios64_block_diagram.png 
there seems to be an RTL8156. Is it properly supported by any of the 
above drivers (maybe CONFIG_USB_ETHER_RTL8152?)? Did you test both 
Ethernet ports in U-Boot?

Cheers,
Quentin
