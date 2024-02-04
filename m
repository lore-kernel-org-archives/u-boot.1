Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A8FC4828F
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 12:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4902287186;
	Sun,  4 Feb 2024 13:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QhSaft4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3C5878FF; Sun,  4 Feb 2024 13:32:08 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA77B86564
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 13:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marietto2008@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5113303e664so3423406e87.0
 for <u-boot@lists.denx.de>; Sun, 04 Feb 2024 04:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707049925; x=1707654725; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=quneEN6msWDHzSZqD1f3wgzUjvtVUpPZnuPjvyVpd0Y=;
 b=QhSaft4ksjqXU0ICu6ljvrkwNRYlUnYQheEP5FrjUqQs+s0gVf2wraOQW4YEjRS3nV
 NRzcB7atiVDLnyQT7CXuWMsuYw9LPJD8ZWlxCZRCy6Y0oEEAFrm9Ioplda9Ps0vG+lY/
 XqfkrdtaBmGtO0/TJv4FMPWlOXCMpFB/8ahy+LB6JmqhECDXopDj4w4cM38v9e7JWO0Q
 ReCNR3rqbUc/pCokP6P2wJ9NxNO8vvOlDj0p7T3l/Mc7PMnOi4AU315gOV5Qm/EgSLMZ
 rgOIwN6v/vx1gaVxStO3Ne7bwG9XaisP3PWVUfdmlmyde7JNqm60zBbdAFU9AeYVBDW8
 Vqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707049925; x=1707654725;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=quneEN6msWDHzSZqD1f3wgzUjvtVUpPZnuPjvyVpd0Y=;
 b=tFhIIgkklV3l3b6jVhHmxbjlO8V5/2e/n/cVH1suJnd743AYl688ZKU9/c6b3VZisY
 16T1zKZBV8K2D1yi3H7sWfmxZOLEiihFU4gZoBpFzn9+txYj+oYytYfVyPCA+zk9WvT4
 kXT7XLaIQF/1UGmx7/Z0gEJZICfimfsfwNIgHGkMVBNa0NYFwkPNbJz9Dx9YWBzfK2sJ
 6LcHy/oe0xKyhWt6j9E7bLntN/qK72FhRazSpq2cPIP3aZJqHmv4fGkolCo1BbVNv+3g
 Zde7E2B1qWqiO7DE5GuakAvQ93gfu9WJcZC5I9sti7ch7q6xp1tK2OwiS7pOzc5pwU6+
 IRgQ==
X-Gm-Message-State: AOJu0YwK+/6HFIX9BJ+W0NNOajXO/cxQdeOhS9og+a+MJdlNY/7OHQb0
 5v51/0XFSvxa3gv4+T/y748t02AZ+5z5vs51FqETj4rC88QNJYfN0FL3x9VeGmgUzmbQMPVPqQW
 FPYr/kHZkqBCr9oOgM9U4bkgo2aWPRjHYBN8=
X-Google-Smtp-Source: AGHT+IHAeSyfiLeaxpvmTdt4SukQ+1XMjGJYG29rYFDShrUqMmjm8njTUPmN2B9P2dIQIeeQQwcVBSkzlMSjZ350EDI=
X-Received: by 2002:ac2:592d:0:b0:511:3460:925c with SMTP id
 v13-20020ac2592d000000b005113460925cmr4430690lfi.65.1707049924554; Sun, 04
 Feb 2024 04:32:04 -0800 (PST)
MIME-Version: 1.0
From: Mario Marietto <marietto2008@gmail.com>
Date: Sun, 4 Feb 2024 13:31:27 +0100
Message-ID: <CA+1FSigjsoCu+E5fsRqdvAcDCzN7HN1+U=MXSb7fhG46_1r=+Q@mail.gmail.com>
Subject: I'm trying to create a new nv_uboot-snow-usb.kpart file changing some
 parameters inside the file snow.h file,
 but the modifications I made aren't detected.
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello.

My ARM Chromebook SNOW model has the mmc slot broken,but I've realized

that I can boot Linux using the USB port ! To enable the booting of Linux
via USB

I have modified this file :


https://github.com/virtualopensystems/u-boot/blob/eecfeb578e296ef3b739ac918a39b6c177dff58a/include/configs/snow.h#L101


in this way :

/*
 * Copyright (C) 2013 - Virtual Open Systems
 * Author: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License, version 2, as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#ifndef __configs_snow_h__
#define __configs_snow_h__

#include <configs/smdk5250.h>

#undef CONFIG_DEFAULT_DEVICE_TREE
#define CONFIG_DEFAULT_DEVICE_TREE      exynos5250-snow

/* Generally verified boot needs more heap space */
#undef CONFIG_SYS_MALLOC_LEN
#define CONFIG_SYS_MALLOC_LEN	(32 << 20)

#define CONFIG_INITRD_ADDRESS 0x44000000

#include <configs/chromeos.h>

/* Disable ChromeOS specifics */
#undef CONFIG_CHROMEOS

/* Force reading the environment */
#undef CONFIG_OF_LOAD_ENVIRONMENT

#define CONFIG_CHROMEOS_USB

/* Support vboot flag reading from GPIO hardwrae */
#define CONFIG_CHROMEOS_GPIO_FLAG

/* Support vboot flag reading from EC */
#define CONFIG_CHROMEOS_MKBP_FLAG

/* Use the default arch_phys_memset implementation */
#define CONFIG_PHYSMEM

/* Adjust the display resolution. */
#undef MAIN_VRESOL_VAL
#undef MAIN_HRESOL_VAL
#define MAIN_VRESOL_VAL 0x300
#define MAIN_HRESOL_VAL 0x556
#undef LCD_XRES
#undef LCD_YRES
#define LCD_XRES 1366
#define LCD_YRES 768
#define CONFIG_SYS_WHITE_ON_BLACK

/*
 * Extra bootargs used for direct booting, but not for vboot.
 * - console of the board
 * - debug and earlyprintk: easier to debug; they could be removed later
 */
#define CONFIG_DIRECT_BOOTARGS \
	"console=tty1 debug clk_ignore_unused"

/* Standard input, output and error device of U-Boot console. */
#define CONFIG_STD_DEVICES_SETTINGS 	EXYNOS_DEVICE_SETTINGS

#define CONFIG_CHROMEOS_SD_TO_SPI \
	"sd_to_spi=echo Flashing U-Boot from SD card to SPI flash; " \
	"if mmc dev 1 && " \
	"mmc rescan && " \
	"mmc read 40008000 1 1000 && " \
	"sf probe 1:0 && " \
	"sf update 40008000 0 80000; then " \
	"echo Flash completed; else " \
	"echo Flash failed; " \
	"fi\0"

/* Replace default CONFIG_EXTRA_ENV_SETTINGS */
#ifdef CONFIG_EXTRA_ENV_SETTINGS
#undef CONFIG_EXTRA_ENV_SETTINGS
#endif
#define CONFIG_EXTRA_ENV_SETTINGS \
	EXYNOS_DEVICE_SETTINGS \
	"dtaddr=0x43000000\0"\
	"initrdaddr=0x44000000\0"\
	"boot_noinitrd=usb start ; usb dev 0 ; ext2load usb 0:2 ${loadaddr}
uImage ; ext2load usb 0:2 ${dtaddr} exynos5250-snow.dtb ; bootm
${loadaddr} - ${dtaddr}\0"\
	"boot_initrd=usb start ; usb dev 0 ; ext2load usb 0:2 ${loadaddr}
uImage ; ext2load usb 0:2 ${initrdaddr} initrd ; ext2load usb 0:2
${dtaddr} exynos5250-snow.dtb ; bootm ${loadaddr} ${initrdaddr}
${dtaddr}\0"\
	"bootdelay=10\0"

#ifdef CONFIG_BOOTARGS
#undef CONFIG_BOOTARGS
#endif
#define CONFIG_BOOTARGS \
	"console=tty1 root=/dev/da0p4 rw rootwait clk_ignore_unused --no-log"

/* Replace default CONFIG_BOOTCOMMAND */
#ifdef CONFIG_BOOTCOMMAND
#undef CONFIG_BOOTCOMMAND
#endif
#define CONFIG_BOOTCOMMAND \
	"run boot_noinitrd"

/* Enable splash screens */
#define CONFIG_CROS_SPLASH

/* Enable simple framebuffer */
#define CONFIG_SIMPLEFB

/* Enable writing on a FAT formatted filesystem */
#define CONFIG_FAT_WRITE

/* Enable virt mode commands */
#define CONFIG_ARMV7_VIRT

/* Disable d-cache */
#define CONFIG_SYS_DCACHE_OFF

#endif /* __configs_snow_h__ */

I have modified mmc with usb 0 and I've changed the timeout from
"bootdelay=3\0"

to "bootdelay=10\0" and I ran the script that located here :


https://github.com/virtualopensystems/u-boot/blob/eecfeb578e296ef3b739ac918a39b6c177dff58a/scripts/build.sh


that creates a new : nv_uboot-snow-usb.kpart file,that I install on the sd
card where

I have installed Linux,using the following commands :


# dd if=/dev/zero of=/dev/sdi1
dd: writing to '/dev/sdi1': No space left on device
32769+0 records in
32768+0 records out
16777216 bytes (17 MB, 16 MiB) copied, 2.07775 s, 8.1 MB/s

# sudo dd if=nv_uboot-snow-usb.kpart of=/dev/sdi1


At this point I attach the usb to sd card converter on the Chromebook and I
try to

boot Linux,but to my surprise I see that the bootloader is still set to 3
seconds.

It means that for some reason,the new nv_uboot-snow-usb.kpart is not
detected,

because when I have recompiled it,I have chosen 10 seconds of timeout for
u-boot.

I really don't have any idea of the reasons why the new settings aren't
applied.
-- 
Mario.
