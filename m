Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC07DFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EFFC840AB;
	Sat, 25 Apr 2026 19:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VlpW4ddQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F7B0842BF; Sat, 25 Apr 2026 19:02:27 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E3E580087
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-362ddc1de56so1862286a91.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777136544; x=1777741344; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O7TtxyxFXFkfRnjj/wzyKATo8ENPdXnEmenWmHaRghs=;
 b=VlpW4ddQNuXOSL2cPzkJ4XNWsW8PuKY2za6xzp7xJiTIZCs4lWeB+tC2rQNGJMYGZs
 JWVpkyOHCLwzH+3zxHHVPjgmL/zcDMCoR1q2duUHZ3s2x8kg3a5b8eQ6mFBLwTUedYP7
 Wf9WGXad0HKFy9/5k4CUhxRiGyHFNeWoyJW2QJcVsoJ3fwQ2ZXFxbZxMBiNliX4feczQ
 vMW8El40jgNS3hdS1XYjIqB5N9K+tBggYjaUE3xOtq6JV916HX/QA2LWARnZtSyZdsf2
 KpVFA/kk/Hzu58TAjHm7tcJkNwb7m6WdL6TnHcxDV9OGEcp65jVJejKlx9qczyLLsJv0
 VRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777136544; x=1777741344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7TtxyxFXFkfRnjj/wzyKATo8ENPdXnEmenWmHaRghs=;
 b=rg2+0mZz6NQ4WWrV6EM9/bl+d6cABLSrYTac0bRHQZYVpp3my8Ndp9HfXa1+c//4p/
 /1y6fR4oI+nSbFhKpwWVgnjiYvN1uXyOHR8KD+Ar4dxmJcoONGo8XYX+5X5uFdOq195S
 RfzCKrGBaSAPplO+SJeKQl6T56NR9GM8DDroe94f3z6eUbWepvI1qomSh46BT0pGUVbW
 SjkaKv78rxVaK3QBFJijzODvElxK2Kn5g5uKzmAqVyEbsBwOGg3aXChK9zeAaVxuRalr
 CejBmxfSsyGHihBQ/YI9I7FgpB5YPFvlv36sC4Z5u63+Egvf77BLB+2I3UeNanRRWb5x
 kfFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cnBsScOGyXer8xWYgutjbWHlIVMHsf6fsWhKhYRx9u3uRT6icWhD5dt2aOIYN1uX9Buazz/U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/C12z8qlY3/RTp8TK3wdFyuanYW3KbVu0XdNLQE79ATz9EhXi
 w1mx4gvVFGA1tiUjyO7kJyEdsnRQ90XXq2tS7cXqzIodd4tL+WTbNRgzQlCVKQ==
X-Gm-Gg: AeBDieu/RY0ZTTkyUvwSDvPIsxHTFcSUWcfmb9N3fq8Ce/a1FZTHDXGxCDlAJWg8O5M
 566e6P0oLy/NhePfW0HjYSEsZ88o0bQcGL6SnOzGXPwju/4CIgoNQpJZAE7j/iKhh/Z637R4s5y
 rTjKgzsgNF0/jChi4r/vpSaCaqW2B9tdLSkv4nwPh+78SajwN/MY0iJuSGMWLl6AEwGVeNm1XXe
 dO+ROXupNySmL7qipPzOcQ+gWe1AyOtT9WdmucYY8tcOYep6zw93PE24VQlmyWLdfotZzl9aw5L
 eQbCj29EMzq5uXgZL2XNLgPpdDcK1D6ftlylQc+M968KRBoGFoh3CkCZL0xT6LCZzf01+VV8NKN
 B/S2yyom/gBh8OkT4mURkVBcNIXK/+2a3CgZmAGG0D4N8xaOPDYPW+gl2gQcbAdQVlA/DMOYg2m
 SpzkpNu1X2hhId1issEEuPwVLtXBU6ftTMNNUDZBgyBSyA1lTotaI4RNHWi5s+XDUWbB+OB6i4v
 uw1QnMJzQl88w==
X-Received: by 2002:a17:90b:3504:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-3614046f76amr40664848a91.18.1777136543482; 
 Sat, 25 Apr 2026 10:02:23 -0700 (PDT)
Received: from google.com (61-230-36-6.dynamic-ip.hinet.net. [61.230.36.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bafa9sm26946189a91.15.2026.04.25.10.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 10:02:23 -0700 (PDT)
Date: Sun, 26 Apr 2026 01:02:20 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH 5/9] configs: stmark2: add support for mmc
Message-ID: <aezznOpfVei-LZF8@google.com>
References: <20260416121431.20852-1-angelo@kernel-space.org>
 <20260416121431.20852-5-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416121431.20852-5-angelo@kernel-space.org>
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

Hi Angelo,

On Thu, Apr 16, 2026 at 02:14:27PM +0200, Angelo Dureghello wrote:
> Add support for mmc.
> 
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

it looks like the changes to stmark2_defconfig were edited manually.
Could you please use make savedefconfig to generate this file?

Regards,
Kuan-Wei

$ make stmark2_defconfig
$ make savedefconfig
$ diff -u configs/stmark2_defconfig defconfig
--- configs/stmark2_defconfig   2026-04-25 17:01:03.607521115 +0000
+++ defconfig   2026-04-25 17:01:11.186044050 +0000
@@ -28,18 +28,17 @@
 # CONFIG_CMD_IMPORTENV is not set
 CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=spi-flash.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:1m(u-boot),7m(kernel),-(rootfs)"
-CONFIG_CMD_MMC=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_DOS_PARTITION=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nor0=spi-flash.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:1m(u-boot),7m(kernel),-(rootfs)"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_CS=1
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -48,9 +47,8 @@
 CONFIG_NO_NET=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
-CONFIG_MTD=y
 CONFIG_MMC=y
-CONFIG_FSL_ESDHC_IMX=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MTD=y

> ---
>  configs/stmark2_defconfig | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/configs/stmark2_defconfig b/configs/stmark2_defconfig
> index ae1fa34df2a..763cbac158d 100644
> --- a/configs/stmark2_defconfig
> +++ b/configs/stmark2_defconfig
> @@ -3,19 +3,19 @@ CONFIG_TEXT_BASE=0x47E00000
>  CONFIG_SYS_MALLOC_LEN=0x40000
>  CONFIG_SF_DEFAULT_SPEED=50000000
>  CONFIG_ENV_SIZE=0x2000
> -CONFIG_ENV_OFFSET=0x40000
> +CONFIG_ENV_OFFSET=0x80000
>  CONFIG_ENV_SECT_SIZE=0x10000
>  CONFIG_DEFAULT_DEVICE_TREE="stmark2"
> -CONFIG_SYS_MONITOR_LEN=262144
> -CONFIG_SYS_LOAD_ADDR=0x40010000
> +CONFIG_SYS_MONITOR_LEN=327680
> +CONFIG_SYS_LOAD_ADDR=0x42000000
>  CONFIG_TARGET_STMARK2=y
>  CONFIG_SYS_BARGSIZE=256
>  CONFIG_SYS_MONITOR_BASE=0x47E00400
>  CONFIG_TIMESTAMP=y
>  CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 rw rootfstype=ramfs rdinit=/bin/init devtmpfs.mount=1"
> +CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 rw rootfstype=ramfs rdinit=/sbin/init devtmpfs.mount=1"
>  CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="sf probe 0:1 50000000; sf read ${loadaddr} 0x100000 ${kern_size}; bootm ${loadaddr}"
> +CONFIG_BOOTCOMMAND="run boot_sd; bootm ${loadaddr} ${loadaddr_ramfs}"
>  CONFIG_SYS_PBSIZE=283
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SYS_MALLOC_BOOTPARAMS=y
> @@ -34,6 +34,12 @@ CONFIG_CMD_CACHE=y
>  CONFIG_CMD_MTDPARTS=y
>  CONFIG_MTDIDS_DEFAULT="nor0=spi-flash.0"
>  CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:1m(u-boot),7m(kernel),-(rootfs)"
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_EXT2=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_DOS_PARTITION=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_ENV_SPI_CS=1
>  CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> @@ -43,6 +49,8 @@ CONFIG_NO_NET=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_FSL=y
>  CONFIG_MTD=y
> +CONFIG_MMC=y
> +CONFIG_FSL_ESDHC_IMX=y
>  CONFIG_DM_SPI_FLASH=y
>  CONFIG_SPI_FLASH_ISSI=y
>  CONFIG_SPI_FLASH_MTD=y
> -- 
> 2.53.0
> 
