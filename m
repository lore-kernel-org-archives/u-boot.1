Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CA606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fBmZx6z9;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=AbJYO32n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8450E40A55;
	Wed, 11 Nov 2026 10:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6bbZ5YY9TxK; Wed, 11 Nov 2026 10:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9211440A6D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794393629;
	b=s2zYBx/RkqQCF6OSUGXTmGWG6w8c1wtjEcDcUZKUtcTDi0eh8RBh2ht1bSJkC3z3FlJq
	 h3ABGZJ+6iYYy1IZlRqGdQay2dYtCVLUfRVxNLuQra8CNiVnOAMuyKkW/Pxbr5c4E4uy5
	 QDy3ssCOdwx0l4aQIJsJYpRrMJ6uMMDGEN8J2co8vlsQa24Edzv2+JvSxP0B4KrahVPD0
	 UeM56KLPZChagqtHDvmep7L/NrRLKmP+KhruYaiFdJ6j8YYgkO+8swQlgGw2CZXW1bhMt
	 0hK/Hh9L5XhSOfjIXFfWXsgyglKQkEUagLjwLBPJH0N66HvTOu3zeTBsnjB//3Zj8sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794393629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Inm+8Q5aZxffr3PTKYuYomCnUTQ6mUaEtbph7FS3Y0k=;
	b=I4MkJowOvMXNl+WKi+uru2odl1i16q+j1HNk7rpKoo0W8pMv0q4OGbJv9dnz/mNovzWa
	 Li4bJ/P1ajcGx04RfOxwllAUNkf6DscrlGc7BlDlyMI/gb9aJhvqZY78R30uyIzaGZLts
	 +okONchRDkwzKPkPXySKpAKOCZmfCYQU2ysTVwpIh6j8dOQqbSIHATQYkAULJUfuXE2LW
	 XbANc0QXMRNuhtTk18niWAzsgVUSejOF1Poir2x4b40HaVbBCdBRCOoNcTKlLeJgRAEmO
	 dlicvzoPmr7F5kCewDhdUfG7pGXmcDhcy3t21292rQaMZ99P7raHwsDY5IO2J/zqOMQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794393629;
	bh=Inm+8Q5aZxffr3PTKYuYomCnUTQ6mUaEtbph7FS3Y0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fBmZx6z9t/7mFutWoe+ZoCbuGzIsu4YlziuoI9np1hRm7zo5F99Z07QeKlMgiN7GA
	 ZM2TmwLdbc28x0VNMIPiFx1qq60Oyr9UJVGeVrMSpYFmtbHvOBFf2qqGFcGB0bzaHg
	 fMCyNRiN0L2sgE9JSVTuUH6iSNwk4iK1Ln+rz0XJI5s2dZ0eFsbJTKz7A6Bo98ATTj
	 jbF5PRiGokl00MCwkDevT/HcUUVduU8QIB8iq/ksG5QWUnylEFVFR4wUYyz8YPHPWX
	 Fnxn7vkZef/paipmQO4VDbFdDrJEIOHzYyUrhtZE9s/jyhXXD9qsRMW+GoP+2u80oG
	 pdPGfFSIZOdiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9211440A6D;
	Wed, 11 Nov 2026 10:40:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 43DD1731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 295008121F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEB-GAM3NVTk for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BCA6D811A4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:b8b8::bc0b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::bc0b; helo=smtp-bc0b.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=AbJYO32n
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::bc0b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCA6D811A4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:40:25 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPg5f5ZtQzqqW;
 Wed, 11 Nov 2026 11:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794393622;
 bh=Inm+8Q5aZxffr3PTKYuYomCnUTQ6mUaEtbph7FS3Y0k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AbJYO32nHRdJXPijOyAylAqJUZi9bE+Lt2zR2PQRCkBTbD2zkZby5onIwlEu9o8vI
 g1BijlRqkOxgN5wVGPSmsG7X311ZVM0k25Q0mH/jI5AcaGW311bzXOIg4tanbdmCE2
 BED2HbY6DjrtocuyUJIsLMvE6T8kSJXW1fxA2LbPAi1aO+OSaGQEV/lQxUqPN0BEOH
 W2FPkGnhm+JaxKjGhGW7NRlDUqOEtRbvLXg8JNGP0aV6gJ4Dbr9ihHR3tD3ijoChCe
 FW1LIkyLNH94aixMEzwSCMJkHNzMYiz9zzivNP6nTCKNprj1ehIOQYtlxrM6JFakvL
 yLzR1oOqJRGkA==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jPg5d3CtNznxv; 
 Wed, 11 Nov 2026 11:40:21 +0100 (CET)
Message-ID: <dca9a909-fd07-44f1-85dc-dbfe65ce7da5@0leil.net>
Date: Wed, 11 Nov 2026 11:40:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add 100ASK DshanPi A1
To: Ivan Udalov <iudalov08@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20261108142149.230620-1-iudalov08@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261108142149.230620-1-iudalov08@gmail.com>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ivan,

On 11/8/26 3:21 PM, Ivan Udalov wrote:
> 100ASK DshanPi A1 with Rockchip RK3576 SoC (4x Cortex-A72,
> 4x Cortex-A53, Mali-G52 MC3 GPU, 6 TOPS NPU).
> 
> Features tested on a DshanPi A1:
> - SD-card boot
> - PCIe
> - USB HOST
> 
> Signed-off-by: Ivan Udalov <iudalov08@gmail.com>
> ---
>   arch/arm/mach-rockchip/rk3576/MAINTAINERS |  5 ++
>   configs/dshanpi-a1-rk3576_defconfig       | 75 +++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst           |  1 +
>   3 files changed, 81 insertions(+)
>   create mode 100644 configs/dshanpi-a1-rk3576_defconfig
> 
> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> index baae63fc7b0..6eb00f0de6a 100644
> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> @@ -33,3 +33,8 @@ M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	arch/arm/dts/rk3576-armsom-sige5*
>   F:	configs/sige5-rk3576_defconfig
> +
> +100ASK-DSHANPI-A1-RK3576
> +M:	Ivan Udalov <iudalov08@gmail.com>
> +S:	Maintained
> +F:	configs/dshanpi-a1-rk3576_defconfig
> diff --git a/configs/dshanpi-a1-rk3576_defconfig b/configs/dshanpi-a1-rk3576_defconfig
> new file mode 100644
> index 00000000000..a3ff2e58dfc
> --- /dev/null
> +++ b/configs/dshanpi-a1-rk3576_defconfig
> @@ -0,0 +1,75 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-100ask-dshanpi-a1"
> +CONFIG_ROCKCHIP_RK3576=y
> +CONFIG_SYS_LOAD_ADDR=0x40c00800
> +CONFIG_DEBUG_UART_BASE=0x2AD40000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-100ask-dshanpi-a1.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_DM_RESET=y

question: do you really need SPL_DM_RESET?

I believe this is only required once you have UFS enabled? At least 
according to the Kconfig symbol CONFIG_SPL_RESET_ROCKCHIP helptext.

> +CONFIG_SPL_UFS_SUPPORT=y

issue: unused

UFS is not enabled in Device Tree, so this won't be useful.

> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y

question: do you have anything on PCI?

PCIe only seems to be routed to the m.2 e-key, which we don't have a use 
for in U-Boot no?

> +CONFIG_CMD_UFS=y

issue: unused

UFS is not enabled in Device Tree, so this won't be useful.

> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"

nitpick: remove clock-names from CONFIG_OF_SPL_REMOVE_PROPS.

> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y

question: don't you want CONFIG_BUTTON_ADC too?

You have a bunch of adc-keys in Device Tree, don't you want to use them 
in U-Boot too?

> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y

question: I don't see any LED?

The Device Tree doesn't seem to have any LED defined, what is this 
useful for?

> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_NVME_PCI=y

question: can you really have an NVMe?

The PCIe is routed to the m.2 E-key and I think usually people don't put 
NVMes on E-key, only M- or B-key?

> +CONFIG_PCIE_DW_ROCKCHIP=y

question: if PCI isn't used (as I believe), then this is also unnecessary.

> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_UFS=y
> +CONFIG_UFS_ROCKCHIP=y

issue: unused

UFS is not enabled in Device Tree, so this won't be useful.

Cheers,
Quentin
