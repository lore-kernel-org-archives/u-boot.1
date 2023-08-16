Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E58C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2ED1868B6;
	Wed, 16 Aug 2023 17:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dpud0euo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1B2869BF; Wed, 16 Aug 2023 17:14:00 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15339807C9
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58439daf39fso70048117b3.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692198835; x=1692803635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNkpq3MJZZMvEfSGQsCPzLA2Vs2gJAmWNkI2CZ7ydh8=;
 b=dpud0euoHic929qSYNqz3w+gW6IWK/ECe7UD5DHPftN5/5au8xSZjz3rXf3FTHuufr
 93muY/5GnOLr5L9HoFvF21NaCQyb416GORNnDMuMx8A+ha2GkEBwfHTx7MHDD91fHK8c
 goT3PWpbn5sNevRW0hwGfuAd0Y0tbIH/MyM79AbSbt51L76Ww/7PJN3hxApxCmMSVK8j
 7dYSUCi3SLHKVZyUrg8Guyg7uHtM4jaAX9ia967w0UfMghmPDnRLOzvCRl9Pxfk/Y0EF
 w2+lB6CDezjSEi3Wd2EObEvN7LByga52s61iTQUfycDt7YBM2KR2XTKrPlW8Uzout248
 3N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692198835; x=1692803635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNkpq3MJZZMvEfSGQsCPzLA2Vs2gJAmWNkI2CZ7ydh8=;
 b=BHVuzr65zpbQup4P0sOFZT23VnJztoqPmYfZKG26hQPDBIAN6LTp0OcAgEhJJCmcIF
 we3tFOS7cw5lHLYfLuOef9LxaX6XvfbvpIjKESwA+SiwbXV706KfPrbK2GTZ52z8ftv5
 J2xpLKuHDLQoAMiKPp4+D4oLtIfZ+HZwTVwI3zU0BZnonkPMhY9aQ6B2FspXFZTuRExO
 eoUOI9q17q7qmbUbHkTSnMhH4+Iutc9CKaveNoSZP9+Ejc+805ZFBq7XxSFabjS5FViX
 SygkvHVbS7Opsed3mFqW4J9ktp1AtTyqRNVBxl+cAztCcadCh3G4XjfC7MiEn/LlwHzH
 RyEQ==
X-Gm-Message-State: AOJu0Yxic/Wc4aEFwltDCtgM22xRgrmuRuEtKu4HifxMoD48i09Hh2tu
 XHxWsWwKyYDoQcs39LTBd0TCcEVmY4c0z2q+VeW66A==
X-Google-Smtp-Source: AGHT+IG72hLjLP9hMvbt7LQeWH/HUjYJDp2gnfVQcko5mcbEQLFCzcEU9pyrYin96XRdH8drd1yyy+H5gewYpHPTt6c=
X-Received: by 2002:a25:50c8:0:b0:ba8:2e05:3e9c with SMTP id
 e191-20020a2550c8000000b00ba82e053e9cmr2275976ybb.24.1692198835169; Wed, 16
 Aug 2023 08:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2g9JMptku2ZMmWeYxvYeV_MXkFDknL3rTXueVJz3otYhE5hQ@mail.gmail.com>
In-Reply-To: <CAM2g9JMptku2ZMmWeYxvYeV_MXkFDknL3rTXueVJz3otYhE5hQ@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 16 Aug 2023 09:13:36 -0600
Message-ID: <CAPnjgZ1xraxjR56Peyqj8HL-HEg7pZ9EkrW2=NG+6vYG+qVfow@mail.gmail.com>
Subject: Re: FIT Image not working in U-Boot
To: Freddie <fpidev23@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Freddie,

On Wed, 16 Aug 2023 at 08:25, Freddie <fpidev23@gmail.com> wrote:
>
> Hi,
>
> I am trying to attempt to build a verified boot solution using Flattened
> Image Trees on a Raspberry Pi 3B +
> I have looked at a couple of guides online about how to do this, however
> they seem quite out of date and it hasn't worked.
>
> The two main guides I have looked at:
> #3066 <https://github.com/OP-TEE/optee_os/issues/3066>
> https://github.com/NVISOsecurity/VerifiedBootRPi3/blob/master/instruction=
s.md
>
> I initially tried building a standard system following the instructions o=
n
> the official OP-TEE documentation, which worked. However I have not been
> able to boot from a FIT file.
>
> I have very closely followed the instructions from the first link above,
> but no matter what I have changed so far, I get the error:
> Wrong Image Format for bootm command
> ERROR: can't get kernel image!
>
> This error occurs both when trying to autoboot and when trying to manuall=
y
> boot (using fatload and bootm in the command line).
>
> I have tried for around 2-3 weeks to attempt to solve this error, so I
> would really appreciate any advice or suggestions.
>
> I have tried both signed and unsigned FIT images and neither of them have
> worked.
>
> I have included the contents of my image.its, uboot.env.txt,
> rpi_3_defconfig and rpi.h files below as well as the logs from when I try
> and boot my system, please let me know if there is any other information
> that could help with solving this.
>
>
>
> /fit/image.its:
>
> / {
>         description =3D "RPi FIT Image";
>         #address-cells =3D <1>;
>         images {
>                 kernel-1 {
>                         description =3D "default kernel";
>                         data =3D /incbin/("kernel8.img");
>                         type =3D "kernel";
>                         arch =3D "arm64";
>                         os =3D "linux";
>                         compression =3D "none";
>                         load =3D  <0x12000000>;
>                         entry =3D <0x12000000>;
>                         hash-1 {
>                                 algo =3D "sha1";
>                         };
>                 };
>                 tee-1 {
>                         description =3D "atf";
>                         data =3D /incbin/("armstub8.bin");
>                         type =3D "standalone";
>                         arch =3D "arm64";
>                         compression =3D "none";
>                         load =3D  <0x08400000>;
>                         entry =3D <0x08400000>;
>                         hash-1 {
>                                 algo =3D "sha1";
>                         };
>                 };
>                 fdt-1 {
>                         description =3D "device tree";
>                         data =3D /incbin/("bcm2710-rpi-3-b-plus.dtb");
>                         type =3D "flat_dt";
>                         arch =3D "arm64";
>                         compression =3D "none";
>                         load =3D <0x01000000>;
>                         entry =3D <0x01000000>;
>                         hash-1 {
>                                 algo =3D "sha1";
>                         };
>                 };
>         };
>         configurations {
>                 default =3D "config-1";
>                 config-1 {
>                         description =3D "default configuration";
>                         kernel =3D "kernel-1";
>                         loadables =3D "tee-1";
>                         fdt =3D "fdt-1";
>                         signature-1 {
>                                 algo =3D "sha1,rsa2048";
>                                 key-name-hint =3D "dev";
>                                 sign-images =3D "fdt", "kernel", "loadabl=
es";
>                         };
>                 };
>         };
> };
>
>
>
>
>
>
> /optee/u-boot/configs/RPI_3_DEFCONFIG:
>
> CONFIG_ARM=3Dy
> CONFIG_ARCH_CPU_INIT=3Dy
> CONFIG_ARCH_BCM283X=3Dy
> CONFIG_SYS_TEXT_BASE=3D0x00080000
> CONFIG_TARGET_RPI_3=3Dy
> CONFIG_SYS_MALLOC_F_LEN=3D0x2000
> CONFIG_NR_DRAM_BANKS=3D1
> CONFIG_ENV_SIZE=3D0x4000
> CONFIG_DISTRO_DEFAULTS=3Dy
> CONFIG_OF_BOARD_SETUP=3Dy
> CONFIG_USE_PREBOOT=3Dy
> # CONFIG_DISPLAY_CPUINFO is not set
> CONFIG_DEFAULT_DEVICE_TREE=3D"bcm2837-rpi-3-b-plus"
> CONFIG_OF_CONTROL=3Dy
> CONFIG_FIT=3Dy
> CONFIG_FIT_SIGNATURE=3Dy
> CONFIG_RSA=3Dy
> CONFIG_FIT_VERBOSE=3Dy
> CONFIG_OF_LIBFDT=3Dy
> # CONFIG_DISPLAY_BOARDINFO is not set
> CONFIG_MISC_INIT_R=3Dy
> CONFIG_SYS_PROMPT=3D"U-Boot> "
> CONFIG_CMD_GPIO=3Dy
> CONFIG_CMD_MMC=3Dy
> CONFIG_CMD_USB=3Dy
> CONFIG_CMD_FS_UUID=3Dy
> CONFIG_OF_EMBED=3Dy
> CONFIG_ENV_FAT_DEVICE_AND_PART=3D"0:1"
> CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
> CONFIG_TFTP_TSIZE=3Dy
> CONFIG_MMC_SDHCI=3Dy
> CONFIG_MMC_SDHCI_BCM2835=3Dy
> CONFIG_PHYLIB=3DyONFIG_ARM=3Dy
> CONFIG_ARCH_CPU_INIT=3Dy
> CONFIG_ARCH_BCM283X=3Dy
> CONFIG_SYS_TEXT_BASE=3D0x00080000
> CONFIG_TARGET_RPI_3=3Dy
> CONFIG_SYS_MALLOC_F_LEN=3D0x2000
> CONFIG_NR_DRAM_BANKS=3D1
> CONFIG_ENV_SIZE=3D0x4000
> CONFIG_DISTRO_DEFAULTS=3Dy
> CONFIG_OF_BOARD_SETUP=3Dy
> CONFIG_USE_PREBOOT=3Dy`
> CONFIG_DM_ETH=3Dy
> CONFIG_PINCTRL=3Dy
> # CONFIG_PINCTRL_GENERIC is not set
> # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> CONFIG_SYSINFO=3Dy
> CONFIG_SYSINFO_SMBIOS=3Dy
> CONFIG_USB=3Dy
> CONFIG_USB_DWC2=3Dy
> CONFIG_USB_KEYBOARD=3Dy
> CONFIG_USB_HOST_ETHER=3Dy
> CONFIG_USB_ETHER_LAN78XX=3Dy
> CONFIG_USB_ETHER_SMSC95XX=3Dy
> CONFIG_DM_VIDEO=3Dy
> # CONFIG_VIDEO_BPP8 is not set
> # CONFIG_VIDEO_BPP16 is not set
> CONFIG_SYS_WHITE_ON_BLACK=3Dy
> CONFIG_CONSOLE_SCROLL_LINES=3D10
> CONFIG_PHYS_TO_BUS=3Dy
> CONFIG_OF_LIBFDT_OVERLAY=3Dy
>
>
>
>
>
>
> /optee/build/rpi3/firmware/uboot.env.txt:
>
>
> # generic params
> bootdelay=3D3
> stderr=3Dserial,lcd
> stdin=3Dserial,usbkbd
> stdout=3Dserial,lcd
>
> # CPU config
> cpu=3Darmv8
> smp=3Don
>
> # Console config
> baudrate=3D115200
> sttyconsole=3DttyS0
> ttyconsole=3Dtty0
>
> # Kernel/dtb filenames & load addresses
> boot_fit=3Dbootm ${fit_addr}
> fdt_addr_r=3D0x01000000
> fit_addr=3D0x02000000
> fdtfile=3Dbcm2710-rpi-3-b-plus.dtb
> load_fit=3Dfatload mmc 0:1 ${fit_addr} image.itb
> mmcboot=3Drun load_fit; run set_bootargs_tty set_bootargs_mmc
> set_common_args; run boot_fit
>
>
> # NFS/TFTP boot configuraton
> gatewayip=3D192.168.1.1
> netmask=3D255.255.255.0
> nfsserverip=3D192.168.1.100
> nfspath=3D/srv/nfs/rpi
>
> # bootcmd & bootargs configuration
> preboot=3Dusb start
> bootcmd=3Drun mmcboot
> nfsboot=3Drun load_kernel; run set_bootargs_tty set_bootargs_nfs
> set_common_args; run boot_it
> set_bootargs_tty=3Dsetenv bootargs console=3D${ttyconsole}
> console=3D${sttyconsole},${baudrate}
> set_bootargs_nfs=3Dsetenv bootargs ${bootargs} root=3D/dev/nfs rw
> rootfstype=3Dnfs nfsroot=3D${nfsserverip}:${nfspath},udp,vers=3D3 ip=3Ddh=
cp
> set_bootargs_mmc=3Dsetenv bootargs ${bootargs} root=3D/dev/mmcblk0p2 rw r=
ootfs=3Dext4
> set_common_args=3Dsetenv bootargs ${bootargs}
> smsc95xx.macaddr=3D${ethaddr} 'ignore_loglevel dma.dmachans=3D0x7f35
> rootwait 8250.nr_uarts=3D1 elevator=3Ddeadline fsck.repair=3Dyes
> bcm2708_fb.fbwidth=3D1920 bcm2708_fb.fbheight=3D1080
> vc_mem.mem_base=3D0x3ec00000 vc_mem.mem_size=3D0x40000000
> dwc_otg.fiq_enable=3D0 dwc_otg.fiq_fsm_enable=3D0 dwc_otg.nak_holdoff=3D0=
'
>
>
>
>
>
>
> /optee/u-boot/include/configs/rpi.h:
>
> /* SPDX-License-Identifier: GPL-2.0 */
> /*
>  * (C) Copyright 2012-2016 Stephen Warren
>  */
>
> #ifndef __CONFIG_H
> #define __CONFIG_H
>
> #include <linux/sizes.h>
> #include <asm/arch/timer.h>
>
> #ifndef __ASSEMBLY__
> #include <asm/arch/base.h>
> #endif
>
> #if defined(CONFIG_TARGET_RPI_2) || defined(CONFIG_TARGET_RPI_3_32B)
> #define CONFIG_SKIP_LOWLEVEL_INIT
> #endif
>
> /* Architecture, CPU, etc.*/
>
> /* Use SoC timer for AArch32, but architected timer for AArch64 */
> #ifndef CONFIG_ARM64
> #define CONFIG_SYS_TIMER_RATE           1000000
> #define CONFIG_SYS_TIMER_COUNTER        \
>         (&((struct bcm2835_timer_regs *)BCM2835_TIMER_PHYSADDR)->clo)
> #endif
>
> /*
>  * 2835 is a SKU in a series for which the 27```08 is the first or primar=
y SoC,
>  * so 2708 has historically been used rather than a dedicated 2835 ID.
>  *
>  * We don't define a machine type for bcm2709/bcm2836 since the RPi Found=
ation
>  * chose to use someone else's previously registered machine ID (3139, MX=
51_GGC)
>  * rather than obtaining a valid ID:-/
>  *
>  * For the bcm2837, hopefully a machine type is not needed, since everyth=
ing
>  * is DT.
>  */
> #ifdef CONFIG_BCM2835
> #define CONFIG_MACH_TYPE                MACH_TYPE_BCM2708
> #endif
>
> /* Memory layout */
> #define CONFIG_SYS_SDRAM_BASE           0x00000000
> #define CONFIG_SYS_UBOOT_BASE           CONFIG_SYS_TEXT_BASE
> /*
>  * The board really has 256M. However, the VC (VideoCore co-processor) sh=
ares
>  * the RAM, and uses a configurable portion at the top. We tell U-Boot th=
at a
>  * smaller amount of RAM is present in order to avoid stomping on the are=
a
>  * the VC uses.
>  */
> #define CONFIG_SYS_SDRAM_SIZE           SZ_128M
> #define CONFIG_SYS_INIT_SP_ADDR         (CONFIG_SYS_SDRAM_BASE + \
>                                          CONFIG_SYS_SDRAM_SIZE - \
>                                          GENERATED_GBL_DATA_SIZE)
> #define CONFIG_SYS_MALLOC_LEN           SZ_4M
> #define CONFIG_LOADADDR                 0x00200000
>
> #ifdef CONFIG_ARM64
> #endif
>
> /* Devices */
> /* GPIO */
> #define CONFIG_BCM2835_GPIO
> /* LCD */
> #define CONFIG_LCD_DT_SIMPLEFB
> #define CONFIG_VIDEO_BCM2835
>
> /* DFU over USB/UDC */
> #ifdef CONFIG_CMD_DFU
> #ifdef CONFIG_ARM64
> #define KERNEL_FILENAME         "Image"
> #else
> #define KERNEL_FILENAME         "zImage"
> #endif
>
> #define ENV_DFU_SETTINGS \
>         "dfu_alt_info=3Du-boot.bin fat 0 1;uboot.env fat 0 1;" \
>                       "config.txt fat 0 1;" \
>                       KERNEL_FILENAME " fat 0 1\0"
> #else
> #define ENV_DFU_SETTINGS ""
> #endif
>
> /* Console configuration */
> #define CONFIG_SYS_CBSIZE               1024
>
> /* Environment */
> #define CONFIG_SYS_LOAD_ADDR            0x1000000
>
> /* Shell */
>
> /* ATAGs support for bootm/bootz */
> #define CONFIG_SETUP_MEMORY_TAGS
> #define CONFIG_CMDLINE_TAG
> #define CONFIG_INITRD_TAG
> #define CONFIG_SYS_BOOTM_LEN (16 << 20)
>
> /* Environment */
> #define ENV_DEVICE_SETTINGS \
>         "stdin=3Dserial,usbkbd\0" \
>         "stdout=3Dserial,vidconsole\0" \
>         "stderr=3Dserial,vidconsole\0"
>
> #ifdef CONFIG_ARM64
> #define FDT_HIGH "ffffffffffffffff"
> #define INITRD_HIGH "ffffffffffffffff"
> #else
> #define FDT_HIGH "ffffffff"
> #define INITRD_HIGH "ffffffff"
> #endif
>
> /*
>  * Memory layout for where various images get loaded by boot scripts:
>  *
>  * I suspect address 0 is used as the SMP pen on the RPi2, so avoid this.
>  *
>  * Older versions of the boot firmware place the firmware-loaded DTB at 0=
x100,
>  * newer versions place it in high memory. So prevent U-Boot from doing i=
ts own
>  * DTB + initrd relocation so that we won't accidentally relocate the ini=
trd
>  * over the firmware-loaded DTB and generally try to lay out things start=
ing
>  * from the bottom of RAM.
>  *
>  * kernel_addr_r has different constraints on ARM and Aarch64.  For 32-bi=
t ARM,
>  * it must be within the first 128M of RAM in order for the kernel's
>  * CONFIG_AUTO_ZRELADDR option to work. The kernel itself will be decompr=
essed
>  * to 0x8000 but the decompressor clobbers 0x4000-0x8000 as well. The
>  * decompressor also likes to relocate itself to right past the end of th=
e
>  * decompressed kernel, so in total the sum of the compressed and and
>  * decompressed kernel needs to be reserved.
>  *
>  *   For Aarch64, the kernel image is uncompressed and must be loaded at
>  *   text_offset bytes (specified in the header of the Image) into a 2MB
>  *   boundary. The 'booti' command relocates the image if necessary. Linu=
x uses
>  *   a default text_offset of 0x80000.  In summary, loading at 0x80000
>  *   satisfies all these constraints and reserving memory up to 0x0240000=
0
>  *   permits fairly large (roughly 36M) kernels.
>  *
>  * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
>  * conflict with something else. Reserving 1M for each of them at
>  * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
>  *
>  * On ARM, both the DTB and any possible initrd must be loaded such that =
they
>  * fit inside the lowmem mapping in Linux. In practice, this usually mean=
s not
>  * more than ~700M away from the start of the kernel image but this numbe=
r can
>  * be larger OR smaller depending on e.g. the 'vmalloc=3DxxxM' command li=
ne
>  * parameter given to the kernel. So reserving memory from low to high
>  * satisfies this constraint again. Reserving 1M at 0x02600000-0x02700000=
 for
>  * the DTB leaves rest of the free RAM to the initrd starting at 0x027000=
00.
>  * Even with the smallest possible CPU-GPU memory split of the CPU gettin=
g
>  * only 64M, the remaining 25M starting at 0x02700000 should allow quite
>  * large initrds before they start colliding with U-Boot.
>  */
> #define ENV_MEM_LAYOUT_SETTINGS \
>         "fdt_high=3D" FDT_HIGH "\0" \
>         "initrd_high=3D" INITRD_HIGH "\0" \
>         "kernel_addr_r=3D0x00080000\0" \
>         "scriptaddr=3D0x02400000\0" \
>         "pxefile_addr_r=3D0x02500000\0" \
>         "fdt_addr_r=3D0x02600000\0" \
>         "ramdisk_addr_r=3D0x02700000\0"
>
> #if CONFIG_IS_ENABLED(CMD_MMC)
>         #define BOOT_TARGET_MMC(func) \
>                 func(MMC, mmc, 0) \
>                 func(MMC, mmc, 1)
> #else
>         #define BOOT_TARGET_MMC(func)
> #endif
>
> #if CONFIG_IS_ENABLED(CMD_USB)
>         #define BOOT_TARGET_USB(func) func(USB, usb, 0)
> #else
>         #define BOOT_TARGET_USB(func)
> #endif
>
> #if CONFIG_IS_ENABLED(CMD_PXE)
>         #define BOOT_TARGET_PXE(func) func(PXE, pxe, na)
> #else
>         #define BOOT_TARGET_PXE(func)
> #endif
>
> #if CONFIG_IS_ENABLED(CMD_DHCP)
>         #define BOOT_TARGET_DHCP(func) func(DHCP, dhcp, na)
> #else
>         #define BOOT_TARGET_DHCP(func)
> #endif
>
> #define BOOT_TARGET_DEVICES(func) \
>         BOOT_TARGET_MMC(func) \
>         BOOT_TARGET_USB(func) \
>         BOOT_TARGET_PXE(func) \
>         BOOT_TARGET_DHCP(func)
>
> #include <config_distro_bootcmd.h>
>
> #define CONFIG_EXTRA_ENV_SETTINGS \
>         "dhcpuboot=3Dusb start; dhcp u-boot.uimg; bootm\0" \
>         ENV_DEVICE_SETTINGS \
>         ENV_DFU_SETTINGS \
>         ENV_MEM_LAYOUT_SETTINGS \
>         BOOTENV
>
>
> #endif
>
>
>
> * Boot Logs:*
>
> NOTICE:  Booting Trusted Firmware
> NOTICE:  BL1: v2.6(debug):v2.6
> NOTICE:  BL1: Built : 13:06:25, Aug  3 2023
> INFO:    BL1: RAM 0x100ee000 - 0x100f7000
> INFO:    BL1: cortex_a53: CPU workaround for 843419 was applied
> INFO:    BL1: cortex_a53: CPU workaround for 855873 was applied
> WARNING: BL1: cortex_a53: CPU workaround for 1530924 was missing!
> NOTICE:  rpi3: Detected: Raspberry Pi 3 Model B+ (1GB, Sony, UK) [0x00a02=
0d3]
> INFO:    BL1: Loading BL2
> INFO:    Loading image id=3D1 at address 0x100b4000
> INFO:    Image id=3D1 loaded: 0x100b4000 - 0x100bc419
> NOTICE:  BL1: Booting BL2
> INFO:    Entry point address =3D 0x100b4000
> INFO:    SPSR =3D 0x3c5
> NOTICE:  BL2: v2.6(debug):v2.6
> NOTICE:  BL2: Built : 13:06:25, Aug  3 2023
> INFO:    BL2: Doing platform setup
> INFO:    BL2: Loading image id 3
> INFO:    Loading image id=3D3 at address 0x100e0000
> INFO:    Image id=3D3 loaded: 0x100e0000 - 0x100ea073
> INFO:    BL2: Loading image id 4
> INFO:    Loading image id=3D4 at address 0x10100000
> INFO:    Image id=3D4 loaded: 0x10100000 - 0x1010001c
> INFO:    OPTEE ep=3D0x10100000
> INFO:    OPTEE header info:
> INFO:          magic=3D0x4554504f
> INFO:          version=3D0x2
> INFO:          arch=3D0x1
> INFO:          flags=3D0x0
> INFO:          nb_images=3D0x1
> INFO:    BL2: Loading image id 21
> INFO:    Loading image id=3D21 at address 0x10100000
> INFO:    Image id=3D21 loaded: 0x10100000 - 0x1017be98
> INFO:    BL2: Skip loading image id 22
> INFO:    BL2: Loading image id 5
> INFO:    Loading image id=3D5 at address 0x11000000
> INFO:    Image id=3D5 loaded: 0x11000000 - 0x11084b90
> NOTICE:  BL1: Booting BL31
> INFO:    Entry point address =3D 0x100e0000
> INFO:    SPSR =3D 0x3cd
> NOTICE:  BL31: v2.6(debug):v2.6
> NOTICE:  BL31: Built : 13:06:26, Aug  3 2023
> INFO:    rpi3: Checking DTB...
> INFO:    BL31: Initializing runtime services
> INFO:    BL31: cortex_a53: CPU workaround for 843419 was applied
> INFO:    BL31: cortex_a53: CPU workaround for 855873 was applied
> WARNING: BL31: cortex_a53: CPU workaround for 1530924 was missing!
> INFO:    BL31: Initializing BL32
> D/TC:0   plat_get_aslr_seed:118 Warning: no ASLR seed
> D/TC:0   add_phys_mem:665 VCORE_UNPG_RX_PA type TEE_RAM_RX 0x10100000
> size 0x00078000
> D/TC:0   add_phys_mem:665 VCORE_UNPG_RW_PA type TEE_RAM_RW 0x10178000
> size 0x00688000
> D/TC:0   add_phys_mem:665 ta_base type TA_RAM 0x10800000 size 0x00800000
> D/TC:0   add_phys_mem:665 CONSOLE_UART_BASE type IO_NSEC 0x3f200000
> size 0x00200000
> D/TC:0   add_phys_mem:665 TEE_SHMEM_START type NSEC_SHM 0x08000000
> size 0x00400000
> D/TC:0   add_va_space:705 type RES_VASPACE size 0x00a00000
> D/TC:0   add_va_space:705 type SHM_VASPACE size 0x02000000
> D/TC:0   dump_mmap_table:831 type TEE_RAM_RX   va
> 0x10100000..0x10177fff pa 0x10100000..0x10177fff size 0x00078000
> (smallpg)
> D/TC:0   dump_mmap_table:831 type TEE_RAM_RW   va
> 0x10178000..0x107fffff pa 0x10178000..0x107fffff size 0x00688000
> (smallpg)
> D/TC:0   dump_mmap_table:831 type RES_VASPACE  va
> 0x10800000..0x111fffff pa 0x00000000..0x009fffff size 0x00a00000
> (pgdir)
> D/TC:0   dump_mmap_table:831 type SHM_VASPACE  va
> 0x11200000..0x131fffff pa 0x00000000..0x01ffffff size 0x02000000
> (pgdir)
> D/TC:0   dump_mmap_table:831 type NSEC_SHM     va
> 0x13200000..0x135fffff pa 0x08000000..0x083fffff size 0x00400000
> (pgdir)
> D/TC:0   dump_mmap_table:831 type TA_RAM       va
> 0x13600000..0x13dfffff pa 0x10800000..0x10ffffff size 0x00800000
> (pgdir)
> D/TC:0   dump_mmap_table:831 type IO_NSEC      va
> 0x13e00000..0x13ffffff pa 0x3f200000..0x3f3fffff size 0x00200000
> (pgdir)
> D/TC:0   core_mmu_xlat_table_alloc:526 xlat tables used 1 / 8
> D/TC:0   core_mmu_xlat_table_alloc:526 xlat tables used 2 / 8
> I/TC:
> I/TC: OP-TEE version: 3.22.0 (gcc version 11.3.1 20220712 (Arm GNU
> Toolchain 11.3.Rel1)) #1 Thu Aug  3 11:35:50 UTC 2023 aarch64
> I/TC: WARNING: This OP-TEE configuration might be insecure!
> I/TC: WARNING: Please check
> https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.ht=
ml
> I/TC: Primary CPU initializing
> D/TC:0 0 boot_init_primary_late:1478 Executing at offset 0 with
> virtual load address 0x10100000
> D/TC:0 0 call_preinitcalls:21 level 2 mobj_mapped_shm_init()
> D/TC:0 0 mobj_mapped_shm_init:470 Shared memory address range:
> 11200000, 13200000
> D/TC:0 0 call_initcalls:40 level 1 register_time_source()
> D/TC:0 0 call_initcalls:40 level 1 teecore_init_pub_ram()
> D/TC:0 0 call_initcalls:40 level 3 check_ta_store()
> D/TC:0 0 check_ta_store:417 TA store: "early TA"
> D/TC:0 0 check_ta_store:417 TA store: "Secure Storage TA"
> D/TC:0 0 check_ta_store:417 TA store: "REE"
> D/TC:0 0 call_initcalls:40 level 3 early_ta_init()
> D/TC:0 0 early_ta_init:56 Early TA
> f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c size 47637 (compressed,
> uncompressed 109256)
> D/TC:0 0 call_initcalls:40 level 3 verify_pseudo_tas_conformance()
> D/TC:0 0 call_initcalls:40 level 3 tee_cryp_init()
> D/TC:0 0 call_initcalls:40 level 4 tee_fs_init_key_manager()
> D/TC:0 0 call_initcalls:40 level 6 mobj_init()
> D/TC:0 0 call_initcalls:40 level 6 default_mobj_init()
> D/TC:0 0 call_initcalls:40 level 6 ftmn_boot_tests()
> D/TC:0 0 ftmn_boot_tests:198 Calling simple_call()
> D/TC:0 0 ftmn_boot_tests:198 Return from simple_call()
> D/TC:0 0 ftmn_boot_tests:199 Calling two_level_call()
> D/TC:0 0 ftmn_boot_tests:199 Return from two_level_call()
> D/TC:0 0 ftmn_boot_tests:200 Calling chained_calls()
> D/TC:0 0 ftmn_boot_tests:200 Return from chained_calls()
> D/TC:0 0 ftmn_boot_tests:202 ********************************************=
*****
> D/TC:0 0 ftmn_boot_tests:203 **************  Tests complete  ************=
*****
> D/TC:0 0 ftmn_boot_tests:204 ********************************************=
*****
> I/TC: Primary CPU switching to normal world boot
> INFO:    BL31: Preparing for EL3 exit to normal world
> INFO:    Entry point address =3D 0x11000000
> INFO:    SPSR =3D 0x3c9
>
>
> U-Boot 2021.10 (Aug 03 2023 - 13:51:18 +0100)
>
> DRAM:  948 MiB
> RPI 3 Model B+ (0xa020d3)
> MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
> Loading Environment from FAT... OK
> In:    serial
> Out:   serial
> Err:   serial
> Net:   No ethernet found.
> starting USB...
> Bus usb@7e980000: USB DWC2
> scanning bus usb@7e980000 for devices...
> Error: lan78xx_eth address not set.
> 3 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> Hit any key to stop autoboot:  3 =EF=BF=BD=EF=BF=BD=EF=BF=BD 2 =EF=BF=BD=
=EF=BF=BD=EF=BF=BD 1 =EF=BF=BD=EF=BF=BD=EF=BF=BD 0
> 22161708 bytes read in 920 ms (23 MiB/s)
> Wrong Image Format for bootm command
> ERROR: can't get kernel image!
> U-Boot>

I don't think those instructions are right. You need to enabled
CONFIG_FIT in the defconfig

That message is printed by boot_get_kernel() when it doesn't use one
of the enabled formats (Legacy uImage, FIT, Android).

Regards,
Simon
