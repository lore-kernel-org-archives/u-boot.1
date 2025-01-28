Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6C5C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 08:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0102681B4B;
	Tue, 28 Jan 2025 09:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738051405;
	bh=yoMN/G32tpk0AfnDauRdxTPPUPkSkZKRSJ85vvhVCHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yZ01sGQILGOcFw5Mcj+WSkW6FsQ/S5vJWfr9WkxWvVCYsvq/GvUaivbkeWXy7hhnD
	 x/a/wfjW4ZT8IFYZQoUbNwWYgDY+MHoHy5UR+Jz3ZP82b4b9tabDM54YGpGXz7jKjs
	 +TJcPjxkrkCMNLX2XBvP333ms+oUIeY3JuShix1qqF17Q8lnI2xnNxHsFV5vFUD0L4
	 2LoI+y0CBtabs8vLLmcwethMs8pt3QpCySdG79SwbsnT4fSVG0axQwrkDHpyiWGLnr
	 bmxediox1XqRjfAgohi+OjMu7abr7wsetJ+lS+1x3x9PG9yJWeGRfDxkRyVrvMATE2
	 7TCeBJFY4oWnQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E7381CC5; Tue, 28 Jan 2025 09:03:23 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DDDD819B1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 09:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YhyTM2Xthz9sW5;
 Tue, 28 Jan 2025 09:03:19 +0100 (CET)
Message-ID: <cf399fb3-869b-40c1-a2f2-d82126760fe4@denx.de>
Date: Tue, 28 Jan 2025 09:03:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] board: samsung: add initial support for
 coreprimevelte board
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
References: <20250124-coreprimevelte-v3-0-870dd251b1d1@skole.hr>
 <20250124-coreprimevelte-v3-3-870dd251b1d1@skole.hr>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250124-coreprimevelte-v3-3-870dd251b1d1@skole.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YhyTM2Xthz9sW5
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

On 24.01.25 16:47, Duje Mihanović wrote:
> Samsung Galaxy Core Prime VE LTE is an entry-level PXA1908-based
> smartphone. It has 1GB of DRAM, 8GB eMMC and USB connectivity.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/dts/Makefile                           |  2 +
>   arch/arm/dts/pxa1908-samsung-coreprimevelte.dts | 74 +++++++++++++++++++++++++
>   arch/arm/mach-mmp/Kconfig                       |  6 ++
>   board/samsung/coreprimevelte/Kconfig            | 12 ++++
>   board/samsung/coreprimevelte/MAINTAINERS        |  6 ++
>   configs/coreprimevelte_defconfig                | 18 ++++++
>   6 files changed, 118 insertions(+)
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index b7df72453ac45636f3c69e854721144ab821bf62..0bf3697bdbe0813ed84cf45aeac4bf138d1944fb 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1226,6 +1226,8 @@ dtb-$(CONFIG_ARCH_QEMU) += qemu-arm.dtb qemu-arm64.dtb
>   dtb-$(CONFIG_TARGET_CORSTONE1000) += corstone1000-mps3.dtb \
>   				corstone1000-fvp.dtb
>   
> +dtb-$(CONFIG_TARGET_COREPRIMEVELTE) += pxa1908-samsung-coreprimevelte.dtb
> +
>   include $(srctree)/scripts/Makefile.dts
>   
>   # Add any required device tree compiler flags here
> diff --git a/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts b/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..588e39e92650f9217e02bb332dcdcd5f74cc7fce
> --- /dev/null
> +++ b/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "pxa1908.dtsi"
> +
> +/ {
> +	pxa,rev-id = <3928 2>;
> +	model = "Samsung Galaxy Core Prime VE LTE";
> +	compatible = "samsung,coreprimevelte", "marvell,pxa1908";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		stdout-path = "serial0:115200n8";
> +
> +		/* S-Boot places the initramfs here */
> +		linux,initrd-start = <0x4d70000>;
> +		linux,initrd-end = <0x5000000>;
> +
> +		fb0: framebuffer@17177000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x17177000 0 (480 * 800 * 4)>;
> +			width = <480>;
> +			height = <800>;
> +			stride = <(480 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0x1000000 0 0x3f000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer@17000000 {
> +			reg = <0 0x17000000 0 0x1800000>;
> +			no-map;
> +		};
> +
> +		gpu@9000000 {
> +			reg = <0 0x9000000 0 0x1000000>;
> +		};
> +
> +		/* Communications processor, aka modem */
> +		cp@5000000 {
> +			reg = <0 0x5000000 0 0x3000000>;
> +		};
> +
> +		cm3@a000000 {
> +			reg = <0 0xa000000 0 0x80000>;
> +		};
> +
> +		seclog@8000000 {
> +			reg = <0 0x8000000 0 0x100000>;
> +		};
> +
> +		ramoops@8100000 {
> +			compatible = "ramoops";
> +			reg = <0 0x8100000 0 0x40000>;
> +			record-size = <0x8000>;
> +			console-size = <0x20000>;
> +			max-reason = <5>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index b9438c6facb2e7f29f608bc72e97657d97a0d7dc..889f127fe82b8110e16c8fdef2908842e1635ebb 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -1,6 +1,12 @@
>   if ARCH_MMP
>   
> +config TARGET_COREPRIMEVELTE
> +	bool "Support coreprimevelte"
> +	select LINUX_KERNEL_IMAGE_HEADER
> +
>   config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>   	default TEXT_BASE
>   
> +source "board/samsung/coreprimevelte/Kconfig"
> +
>   endif
> diff --git a/board/samsung/coreprimevelte/Kconfig b/board/samsung/coreprimevelte/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..78a803796054ae9c43374eabebc14361d8561211
> --- /dev/null
> +++ b/board/samsung/coreprimevelte/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_COREPRIMEVELTE
> +
> +config SYS_BOARD
> +	default "coreprimevelte"
> +
> +config SYS_VENDOR
> +	default "samsung"
> +
> +config SYS_CONFIG_NAME
> +	default "pxa1908"
> +
> +endif
> diff --git a/board/samsung/coreprimevelte/MAINTAINERS b/board/samsung/coreprimevelte/MAINTAINERS
> new file mode 100644
> index 0000000000000000000000000000000000000000..0902117e8b3dc9da782e61728ad9b10ee077229c
> --- /dev/null
> +++ b/board/samsung/coreprimevelte/MAINTAINERS
> @@ -0,0 +1,6 @@
> +Samsung Galaxy Core Prime VE LTE support
> +M:	Duje Mihanović <duje.mihanovic@skole.hr>
> +S:	Maintained
> +T:	git git://git.dujemihanovic.xyz/u-boot.git
> +F:	board/samsung/coreprimevelte/
> +F:	configs/coreprimevelte_defconfig
> diff --git a/configs/coreprimevelte_defconfig b/configs/coreprimevelte_defconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..05116669200b3f1393518c8f9d1d0d5b9f90db6f
> --- /dev/null
> +++ b/configs/coreprimevelte_defconfig
> @@ -0,0 +1,18 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=26000000
> +CONFIG_ARCH_CPU_INIT=y
> +CONFIG_ARCH_MMP=y
> +CONFIG_TEXT_BASE=0x1000000
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_DEFAULT_DEVICE_TREE="pxa1908-samsung-coreprimevelte"
> +CONFIG_TARGET_COREPRIMEVELTE=y
> +CONFIG_SYS_LOAD_ADDR=0x1000000
> +CONFIG_ARMV8_PSCI=y
> +CONFIG_FIT=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_DM=y
> +CONFIG_OF_BOARD=y
> +CONFIG_SYS_NS16550=y
> +CONFIG_SYS_NS16550_MEM32=y
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

