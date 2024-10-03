Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4143CF854C
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 00:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A40188CF1;
	Thu,  3 Oct 2024 02:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D79688D3F; Thu,  3 Oct 2024 02:46:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8903388CC3
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 02:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30A7E339;
 Wed,  2 Oct 2024 17:46:34 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C17033F640;
 Wed,  2 Oct 2024 17:46:03 -0700 (PDT)
Date: Thu, 3 Oct 2024 01:45:26 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 8/8] sunxi: Move to text environment
Message-ID: <20241003014526.6963895a@minigeek.lan>
In-Reply-To: <20240901222734.462334-9-sjg@chromium.org>
References: <20240901222734.462334-1-sjg@chromium.org>
 <20240901222734.462334-9-sjg@chromium.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun,  1 Sep 2024 16:27:34 -0600
Simon Glass <sjg@chromium.org> wrote:

Hi Simon,

> Convert these boards to use a text environment.
> 
> For the boards check, the only differences are extra spaces after the
> semicolons in 'dfu_alt_info_ram' and 'partitions', both of which are
> permitted.
> 
> Add in the special boot command for old kernels, dropping the
> unnecessary and confusing hex prefixes.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled
> 
>  board/sunxi/sunxi.env          | 152 ++++++++++++++++++++++++++++++
>  include/configs/sunxi-common.h | 165 ---------------------------------
>  2 files changed, 152 insertions(+), 165 deletions(-)
>  create mode 100644 board/sunxi/sunxi.env
> 
> diff --git a/board/sunxi/sunxi.env b/board/sunxi/sunxi.env
> new file mode 100644
> index 00000000000..6f28e720081
> --- /dev/null
> +++ b/board/sunxi/sunxi.env
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Common sunxi environment
> + *
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + /
> +
> +/****************************************************************************
> + *           environment variables holding default load addresses           *
> + ****************************************************************************/
> +/*
> + * We cannot use expressions here, because expressions won't be evaluated in
> + * autoconf.mk.
> + */
> +#ifdef CONFIG_ARM64
> +/*
> + * Boards seem to come with at least 512MB of DRAM.
> + * The kernel should go at 512K, which is the default text offset (that will
> + * be adjusted at runtime if needed).
> + * There is no compression for arm64 kernels (yet), so leave some space
> + * for really big kernels, say 256MB for now.
> + * Scripts, PXE and DTBs should go afterwards, leaving the rest for the initrd.
> + */
> +#define BOOTM_SIZE        0xa000000
> +#define KERNEL_ADDR_R     SDRAM_OFFSET(0080000)
> +#define KERNEL_COMP_ADDR_R SDRAM_OFFSET(4000000)
> +#define KERNEL_COMP_SIZE  0xb000000
> +#define FDT_ADDR_R        SDRAM_OFFSET(FA00000)
> +#define SCRIPT_ADDR_R     SDRAM_OFFSET(FC00000)
> +#define PXEFILE_ADDR_R    SDRAM_OFFSET(FD00000)
> +#define FDTOVERLAY_ADDR_R SDRAM_OFFSET(FE00000)
> +#define RAMDISK_ADDR_R    SDRAM_OFFSET(FF00000)
> +
> +#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 256)
> +/*
> + * 160M RAM (256M minimum minus 64MB heap + 32MB for u-boot, stack, fb, etc.
> + * 32M uncompressed kernel, 16M compressed kernel, 1M fdt,
> + * 1M script, 1M pxe, 1M dt overlay and the ramdisk at the end.
> + */
> +#define BOOTM_SIZE        0xa000000
> +#define KERNEL_ADDR_R     SDRAM_OFFSET(2000000)
> +#define FDT_ADDR_R        SDRAM_OFFSET(3000000)
> +#define SCRIPT_ADDR_R     SDRAM_OFFSET(3100000)
> +#define PXEFILE_ADDR_R    SDRAM_OFFSET(3200000)
> +#define FDTOVERLAY_ADDR_R SDRAM_OFFSET(3300000)
> +#define RAMDISK_ADDR_R    SDRAM_OFFSET(3400000)
> +
> +#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 64)
> +/*
> + * 64M RAM minus 2MB heap + 16MB for u-boot, stack, fb, etc.
> + * 16M uncompressed kernel, 8M compressed kernel, 1M fdt,
> + * 1M script, 1M pxe, 1M dt overlay and the ramdisk at the end.
> + */
> +#define BOOTM_SIZE        0x2e00000
> +#define KERNEL_ADDR_R     SDRAM_OFFSET(1000000)
> +#define FDT_ADDR_R        SDRAM_OFFSET(1800000)
> +#define SCRIPT_ADDR_R     SDRAM_OFFSET(1900000)
> +#define PXEFILE_ADDR_R    SDRAM_OFFSET(1A00000)
> +#define FDTOVERLAY_ADDR_R SDRAM_OFFSET(1B00000)
> +#define RAMDISK_ADDR_R    SDRAM_OFFSET(1C00000)
> +
> +#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 32)
> +/*
> + * 32M RAM minus 2.5MB for u-boot, heap, stack, etc.
> + * 16M uncompressed kernel, 7M compressed kernel, 128K fdt, 64K script,
> + * 128K DT overlay, 128K PXE and the ramdisk in the rest (max. 5MB)
> + */
> +#define BOOTM_SIZE        0x1700000
> +#define KERNEL_ADDR_R     SDRAM_OFFSET(1000000)
> +#define FDT_ADDR_R        SDRAM_OFFSET(1d50000)
> +#define SCRIPT_ADDR_R     SDRAM_OFFSET(1d40000)
> +#define PXEFILE_ADDR_R    SDRAM_OFFSET(1d00000)
> +#define FDTOVERLAY_ADDR_R SDRAM_OFFSET(1d20000)
> +#define RAMDISK_ADDR_R    SDRAM_OFFSET(1800000)
> +
> +#else
> +#error Need at least 32MB of DRAM. Please adjust load addresses.
> +#endif
> +
> +#define UUID_GPT_ESP ""
> +
> +#ifdef CONFIG_ARM64
> +#define UUID_GPT_SYSTEM b921b045-1df0-41c3-af44-4c6f280d3fae
> +#else
> +#define UUID_GPT_SYSTEM 69dad710-2ce4-4e3c-b16c-21a1d49abed3
> +#endif

Do we really need those definitions? In the header file those were
later used in the actual (lower case) variable assignment, but here the
UUIDs are assigned directly (below)?

> +
> +stdin=serial
> +#ifdef CONFIG_USB_KEYBOARD
> +stdin+=,usbkbd
> +#endif
> +
> +stdout=serial
> +stderr=serial
> +#ifdef CONFIG_VIDEO
> +stdout+=,vidconsole
> +stderr+=,vidconsole
> +#endif
> +
> +bootm_size=BOOTM_SIZE
> +kernel_addr_r=KERNEL_ADDR_R
> +fdt_addr_r=FDT_ADDR_R
> +scriptaddr=SCRIPT_ADDR_R
> +pxefile_addr_r=PXEFILE_ADDR_R
> +fdtoverlay_addr_r=FDTOVERLAY_ADDR_R
> +ramdisk_addr_r=RAMDISK_ADDR_R
> +
> +#ifdef CONFIG_ARM64
> +kernel_comp_addr_r=KERNEL_COMP_ADDR_R
> +kernel_comp_size=KERNEL_COMP_SIZE
> +#endif
> +
> +dfu_alt_info_ram=
> +  kernel ram KERNEL_ADDR_R 0x1000000;
> +  fdt ram FDT_ADDR_R 0x100000;
> +  ramdisk ram RAMDISK_ADDR_R 0x4000000
> +
> +#ifdef CONFIG_ARM64
> +fdtfile=allwinner/DEFAULT_DEVICE_TREE.dtb

I am confused, shouldn't that be CONFIG_DEFAULT_DEVICE_TREE? Or is
there more magic involved? And it looks like something is prepending
the directory name already:
(comparing the env between current master and after these patches)
-fdtcontroladdr=fbf0b090
-fdtfile=allwinner/sun50i-h618-orangepi-zero3.dtb
+fdtcontroladdr=fbf0aa30
+fdtfile=allwinner/allwinner/sun50i-h618-orangepi-zero3.dtb

(Or is this a problem with the switch to dts/upstream for the H616 I
have in my tree already?)

> +#else
> +fdtfile=DEFAULT_DEVICE_TREE.dtb
> +#endif
> +
> +console=ttyS0,115200
> +
> +uuid_gpt_esp=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
> +#ifdef CONFIG_ARM64
> +uuid_gpt_system=b921b045-1df0-41c3-af44-4c6f280d3fae
> +#else
> +uuid_gpt_system=69dad710-2ce4-4e3c-b16c-21a1d49abed3
> +#endif
> +
> +partitions=
> +  name=loader1,start=8k,size=32k,uuid=${uuid_gpt_loader1};
> +  name=loader2,size=984k,uuid=${uuid_gpt_loader2};
> +  name=esp,size=128M,bootable,uuid=${uuid_gpt_esp};
> +  name=system,size=-,uuid=${uuid_gpt_system};
> +
> +/* support booting a very old kernel */
> +#ifdef CONFIG_OLD_SUNXI_KERNEL_COMPAT
> +bootcmd_sunxi_compat=
> +  setenv root /dev/mmcblk0p3 rootwait;
> +  if ext2load mmc 0 44000000 uEnv.txt; then
> +          "echo Loaded environment from uEnv.txt;
> +          "env import -t 44000000 ${filesize};

is the indentation and the initial quotation for those two lines a
leftover from the old file?

The rest seems to be the same as before, effectively.
Other than those nits I like the new way much better, didn't know we
could now do this.

Cheers,
Andre

> +  fi;
> +  setenv bootargs console=${console} root=${root} ${extraargs};
> +  ext2load mmc 0 43000000 script.bin &&
> +  ext2load mmc 0 48000000 uImage &&
> +  bootm 48000000
> +#endif
> diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
> index 666553ccadb..ceea26494ad 100644
> --- a/include/configs/sunxi-common.h
> +++ b/include/configs/sunxi-common.h
> @@ -61,169 +61,4 @@
>  #define PHYS_SDRAM_0			CFG_SYS_SDRAM_BASE
>  #define PHYS_SDRAM_0_SIZE		0x80000000 /* 2 GiB */
>  
> -/****************************************************************************
> - *           environment variables holding default load addresses           *
> - ****************************************************************************/
> -/*
> - * We cannot use expressions here, because expressions won't be evaluated in
> - * autoconf.mk.
> - */
> -#ifdef CONFIG_ARM64
> -/*
> - * Boards seem to come with at least 512MB of DRAM.
> - * The kernel should go at 512K, which is the default text offset (that will
> - * be adjusted at runtime if needed).
> - * There is no compression for arm64 kernels (yet), so leave some space
> - * for really big kernels, say 256MB for now.
> - * Scripts, PXE and DTBs should go afterwards, leaving the rest for the initrd.
> - */
> -#define BOOTM_SIZE        __stringify(0xa000000)
> -#define KERNEL_ADDR_R     __stringify(SDRAM_OFFSET(0080000))
> -#define KERNEL_COMP_ADDR_R __stringify(SDRAM_OFFSET(4000000))
> -#define KERNEL_COMP_SIZE  __stringify(0xb000000)
> -#define FDT_ADDR_R        __stringify(SDRAM_OFFSET(FA00000))
> -#define SCRIPT_ADDR_R     __stringify(SDRAM_OFFSET(FC00000))
> -#define PXEFILE_ADDR_R    __stringify(SDRAM_OFFSET(FD00000))
> -#define FDTOVERLAY_ADDR_R __stringify(SDRAM_OFFSET(FE00000))
> -#define RAMDISK_ADDR_R    __stringify(SDRAM_OFFSET(FF00000))
> -
> -#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 256)
> -/*
> - * 160M RAM (256M minimum minus 64MB heap + 32MB for u-boot, stack, fb, etc.
> - * 32M uncompressed kernel, 16M compressed kernel, 1M fdt,
> - * 1M script, 1M pxe, 1M dt overlay and the ramdisk at the end.
> - */
> -#define BOOTM_SIZE        __stringify(0xa000000)
> -#define KERNEL_ADDR_R     __stringify(SDRAM_OFFSET(2000000))
> -#define FDT_ADDR_R        __stringify(SDRAM_OFFSET(3000000))
> -#define SCRIPT_ADDR_R     __stringify(SDRAM_OFFSET(3100000))
> -#define PXEFILE_ADDR_R    __stringify(SDRAM_OFFSET(3200000))
> -#define FDTOVERLAY_ADDR_R __stringify(SDRAM_OFFSET(3300000))
> -#define RAMDISK_ADDR_R    __stringify(SDRAM_OFFSET(3400000))
> -
> -#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 64)
> -/*
> - * 64M RAM minus 2MB heap + 16MB for u-boot, stack, fb, etc.
> - * 16M uncompressed kernel, 8M compressed kernel, 1M fdt,
> - * 1M script, 1M pxe, 1M dt overlay and the ramdisk at the end.
> - */
> -#define BOOTM_SIZE        __stringify(0x2e00000)
> -#define KERNEL_ADDR_R     __stringify(SDRAM_OFFSET(1000000))
> -#define FDT_ADDR_R        __stringify(SDRAM_OFFSET(1800000))
> -#define SCRIPT_ADDR_R     __stringify(SDRAM_OFFSET(1900000))
> -#define PXEFILE_ADDR_R    __stringify(SDRAM_OFFSET(1A00000))
> -#define FDTOVERLAY_ADDR_R __stringify(SDRAM_OFFSET(1B00000))
> -#define RAMDISK_ADDR_R    __stringify(SDRAM_OFFSET(1C00000))
> -
> -#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 32)
> -/*
> - * 32M RAM minus 2.5MB for u-boot, heap, stack, etc.
> - * 16M uncompressed kernel, 7M compressed kernel, 128K fdt, 64K script,
> - * 128K DT overlay, 128K PXE and the ramdisk in the rest (max. 5MB)
> - */
> -#define BOOTM_SIZE        __stringify(0x1700000)
> -#define KERNEL_ADDR_R     __stringify(SDRAM_OFFSET(1000000))
> -#define FDT_ADDR_R        __stringify(SDRAM_OFFSET(1d50000))
> -#define SCRIPT_ADDR_R     __stringify(SDRAM_OFFSET(1d40000))
> -#define PXEFILE_ADDR_R    __stringify(SDRAM_OFFSET(1d00000))
> -#define FDTOVERLAY_ADDR_R __stringify(SDRAM_OFFSET(1d20000))
> -#define RAMDISK_ADDR_R    __stringify(SDRAM_OFFSET(1800000))
> -
> -#else
> -#error Need at least 32MB of DRAM. Please adjust load addresses.
> -#endif
> -
> -#define MEM_LAYOUT_ENV_SETTINGS \
> -	"bootm_size=" BOOTM_SIZE "\0" \
> -	"kernel_addr_r=" KERNEL_ADDR_R "\0" \
> -	"fdt_addr_r=" FDT_ADDR_R "\0" \
> -	"scriptaddr=" SCRIPT_ADDR_R "\0" \
> -	"pxefile_addr_r=" PXEFILE_ADDR_R "\0" \
> -	"fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
> -	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0"
> -
> -#ifdef CONFIG_ARM64
> -#define MEM_LAYOUT_ENV_EXTRA_SETTINGS \
> -	"kernel_comp_addr_r=" KERNEL_COMP_ADDR_R "\0" \
> -	"kernel_comp_size=" KERNEL_COMP_SIZE "\0"
> -#else
> -#define MEM_LAYOUT_ENV_EXTRA_SETTINGS ""
> -#endif
> -
> -#define DFU_ALT_INFO_RAM \
> -	"dfu_alt_info_ram=" \
> -	"kernel ram " KERNEL_ADDR_R " 0x1000000;" \
> -	"fdt ram " FDT_ADDR_R " 0x100000;" \
> -	"ramdisk ram " RAMDISK_ADDR_R " 0x4000000\0"
> -
> -#ifdef CONFIG_OLD_SUNXI_KERNEL_COMPAT
> -#define BOOTCMD_SUNXI_COMPAT \
> -	"bootcmd_sunxi_compat=" \
> -		"setenv root /dev/mmcblk0p3 rootwait; " \
> -		"if ext2load mmc 0 0x44000000 uEnv.txt; then " \
> -			"echo Loaded environment from uEnv.txt; " \
> -			"env import -t 0x44000000 ${filesize}; " \
> -		"fi; " \
> -		"setenv bootargs console=${console} root=${root} ${extraargs}; " \
> -		"ext2load mmc 0 0x43000000 script.bin && " \
> -		"ext2load mmc 0 0x48000000 uImage && " \
> -		"bootm 0x48000000\0"
> -#else
> -#define BOOTCMD_SUNXI_COMPAT
> -#endif
> -
> -#ifdef CONFIG_USB_KEYBOARD
> -#define CONSOLE_STDIN_SETTINGS \
> -	"stdin=serial,usbkbd\0"
> -#else
> -#define CONSOLE_STDIN_SETTINGS \
> -	"stdin=serial\0"
> -#endif
> -
> -#ifdef CONFIG_VIDEO
> -#define CONSOLE_STDOUT_SETTINGS \
> -	"stdout=serial,vidconsole\0" \
> -	"stderr=serial,vidconsole\0"
> -#else
> -#define CONSOLE_STDOUT_SETTINGS \
> -	"stdout=serial\0" \
> -	"stderr=serial\0"
> -#endif
> -
> -#define PARTS_DEFAULT \
> -	"name=loader1,start=8k,size=32k,uuid=${uuid_gpt_loader1};" \
> -	"name=loader2,size=984k,uuid=${uuid_gpt_loader2};" \
> -	"name=esp,size=128M,bootable,uuid=${uuid_gpt_esp};" \
> -	"name=system,size=-,uuid=${uuid_gpt_system};"
> -
> -#define UUID_GPT_ESP "c12a7328-f81f-11d2-ba4b-00a0c93ec93b"
> -
> -#ifdef CONFIG_ARM64
> -#define UUID_GPT_SYSTEM "b921b045-1df0-41c3-af44-4c6f280d3fae"
> -#else
> -#define UUID_GPT_SYSTEM "69dad710-2ce4-4e3c-b16c-21a1d49abed3"
> -#endif
> -
> -#define CONSOLE_ENV_SETTINGS \
> -	CONSOLE_STDIN_SETTINGS \
> -	CONSOLE_STDOUT_SETTINGS
> -
> -#ifdef CONFIG_ARM64
> -#define FDTFILE "allwinner/" CONFIG_DEFAULT_DEVICE_TREE ".dtb"
> -#else
> -#define FDTFILE CONFIG_DEFAULT_DEVICE_TREE ".dtb"
> -#endif
> -
> -#define CFG_EXTRA_ENV_SETTINGS \
> -	CONSOLE_ENV_SETTINGS \
> -	MEM_LAYOUT_ENV_SETTINGS \
> -	MEM_LAYOUT_ENV_EXTRA_SETTINGS \
> -	DFU_ALT_INFO_RAM \
> -	"fdtfile=" FDTFILE "\0" \
> -	"console=ttyS0,115200\0" \
> -	"uuid_gpt_esp=" UUID_GPT_ESP "\0" \
> -	"uuid_gpt_system=" UUID_GPT_SYSTEM "\0" \
> -	"partitions=" PARTS_DEFAULT "\0" \
> -	BOOTCMD_SUNXI_COMPAT
> -
>  #endif /* _SUNXI_COMMON_CONFIG_H */

