Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E1DCD3445
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08D1286A77;
	Tue, 19 Sep 2023 09:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VmLiVn5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1913086A67; Tue, 19 Sep 2023 09:19:36 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3730B86A3A
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so6503102a12.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107974; x=1695712774; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3bUTVtl0R8Dj1nVUILhKkOaWA2KeqvEHQNPT4zmtpU=;
 b=VmLiVn5GJeQmv9dvxSW6kXxoM/6vlAYxlMGqzm3SS6vCxPS93MReq02+CImnGkI3kF
 XIzzbfATzBk8QI1So9os+IheiZlMlNs1UtXrv0SvwdjWF/eSH4g0AHZaDnMw3u1Gm2BB
 KrCw8Hd86v7tOqjA/fIaOaq0gciiUpZXoCFRt99DgvUzI05qFxx2DFxuKTg9Tb4GMRjX
 u7zzwgy2EKDEhYtoeYabcojgyspMigMT96Lq+7OxQ0Bh7Gx8XrEX1u8WCR2YHVlz6AJ4
 7gtQuX5p60X1/p6/vzqoULZMQkJf7OT2tKVXf2yh/1A7zSp8/4L8EbazNNO9nTZgIqYF
 YIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107974; x=1695712774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3bUTVtl0R8Dj1nVUILhKkOaWA2KeqvEHQNPT4zmtpU=;
 b=Bs6FLfVqKf93gR4WrF0c61gm8CFRK3FV3sP6Oyex7h7FbC3WXPE94KdDLBTvlPPEHe
 m13eek0UJNpKW2iw8es0JiEHIYDwMk68lK8hqJEOWQ7mpzeR8EvffyvTOPn29kYze87A
 nOA93IRewF8gFOBddXO5Z7eVO3XkxpLMvdaJ+DQWZDH4eZMwfVjMQYqJu5PjfxIo9JdQ
 u2n1rgcUDliHQyUgECqiIZdQjnMNjM1JjGe2w8mrWJoZYE0evTl3qxsqBJhtae+f+jvM
 5wCRlgXFHSE83PW+08NAPbRBpniwiIOknT0gu/rSwbYFBTHn3m7E3Txo2QZWhxrxKq+R
 Qy1w==
X-Gm-Message-State: AOJu0YzY5EBHh4QwJmLbdpUWUul4pZu+xt/469jrLEgdFixsPodSVgnW
 JT+gWl5HuKlM/QWIk0J8O6LkFit0oTB0hJ5y2CPQ/cKF
X-Google-Smtp-Source: AGHT+IF061qp7R1m40+BZCXQIEINZV8ABNmdAW6l2s62jtEf4Ii5tkvET+5Te6DpC2EAPK7JZ0aXs+ag0RyYVtktYs0=
X-Received: by 2002:aa7:d68d:0:b0:525:70b3:72c2 with SMTP id
 d13-20020aa7d68d000000b0052570b372c2mr9210124edr.14.1695107973529; Tue, 19
 Sep 2023 00:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-3-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-3-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:21 +0800
Message-ID: <CAEUhbmUjM_3HfEUaZLJRgCSbDj__iL0n9_gdDnFES0SQ7uFK_Q@mail.gmail.com>
Subject: Re: [PATCH v4 02/20] x86: coreboot: Enable standard boot
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Enable bootstd options and provide instructions on how to boot a linux
> distro using coreboot.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  configs/coreboot64_defconfig    | 14 ++------------
>  configs/coreboot_defconfig      |  1 +
>  doc/board/coreboot/coreboot.rst | 16 ++++++++++++++--
>  3 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
> index a456547a25d..5623197f6be 100644
> --- a/configs/coreboot64_defconfig
> +++ b/configs/coreboot64_defconfig
> @@ -10,39 +10,29 @@ CONFIG_VENDOR_COREBOOT=3Dy
>  CONFIG_TARGET_COREBOOT=3Dy
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_SIGNATURE=3Dy
> +CONFIG_BOOTSTD_FULL=3Dy
> +CONFIG_BOOTSTD_DEFAULTS=3Dy
>  CONFIG_SYS_MONITOR_BASE=3D0x01120000
>  CONFIG_SHOW_BOOT_PROGRESS=3Dy
>  CONFIG_USE_BOOTARGS=3Dy
>  CONFIG_BOOTARGS=3D"root=3D/dev/sdb3 init=3D/sbin/init rootwait ro"
> -CONFIG_USE_BOOTCOMMAND=3Dy
> -CONFIG_BOOTCOMMAND=3D"ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01=
000000"
>  CONFIG_PRE_CONSOLE_BUFFER=3Dy
>  CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> -CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_PBSIZE=3D532
>  CONFIG_CMD_IDE=3Dy
>  CONFIG_CMD_MMC=3Dy
> -CONFIG_CMD_PART=3Dy
>  CONFIG_CMD_SATA=3Dy
>  CONFIG_CMD_USB=3Dy
>  # CONFIG_CMD_SETEXPR is not set
> -CONFIG_CMD_DHCP=3Dy
>  CONFIG_BOOTP_BOOTFILESIZE=3Dy
> -CONFIG_CMD_PING=3Dy
>  CONFIG_CMD_TIME=3Dy
>  CONFIG_CMD_SOUND=3Dy
> -CONFIG_CMD_EXT2=3Dy
> -CONFIG_CMD_EXT4=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
> -CONFIG_CMD_FAT=3Dy
> -CONFIG_CMD_FS_GENERIC=3Dy
>  CONFIG_MAC_PARTITION=3Dy
>  # CONFIG_SPL_MAC_PARTITION is not set
>  # CONFIG_SPL_DOS_PARTITION is not set
> -CONFIG_ISO_PARTITION=3Dy
> -CONFIG_EFI_PARTITION=3Dy
>  # CONFIG_SPL_EFI_PARTITION is not set
>  CONFIG_ENV_OVERWRITE=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
> index aedad4c93c3..311ca6672cb 100644
> --- a/configs/coreboot_defconfig
> +++ b/configs/coreboot_defconfig
> @@ -10,6 +10,7 @@ CONFIG_TARGET_COREBOOT=3Dy
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_SIGNATURE=3Dy
>  CONFIG_BOOTSTD_FULL=3Dy
> +CONFIG_BOOTSTD_DEFAULTS=3Dy
>  CONFIG_SYS_MONITOR_BASE=3D0x01110000
>  CONFIG_SHOW_BOOT_PROGRESS=3Dy
>  CONFIG_USE_BOOTARGS=3Dy
> diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboo=
t.rst
> index be5b0de5495..88437c27740 100644
> --- a/doc/board/coreboot/coreboot.rst
> +++ b/doc/board/coreboot/coreboot.rst
> @@ -67,9 +67,21 @@ To use 4GB of memory, typically necessary for booting =
Linux distros, add
>  In addition to the 32-bit 'coreboot' build there is a 'coreboot64' build=
. This
>  produces an image which can be booted from coreboot (32-bit). Internally=
 it
>  works by using a 32-bit SPL binary to switch to 64-bit for running U-Boo=
t. It
> -can be useful for running UEFI applications, for example.
> +can be useful for running UEFI applications, for example with the corebo=
ot
> +build in `$CBDIR`::
> +
> +   DISK=3Dubuntu-23.04-desktop-amd64.iso
> +   CBDIR=3D~/coreboot/build
> +
> +   cp $CBDIR/coreboot.rom.in coreboot.rom
> +   cbfstool coreboot.rom add-flat-binary -f u-boot-x86-with-spl.bin \
> +      -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000

nits: lzma, to be consistent with the existing doc

> +
> +   qemu-system-x86_64 -m 2G -smp 4 -bios coreboot.rom \
> +      -drive id=3Ddisk,file=3D$DISK,if=3Dnone \
> +      -device ahci,id=3Dahci \
> +      -device ide-hd,drive=3Ddisk,bus=3Dahci.0 \
>
> -This has only been lightly tested.
>
>  CBFS access
>  -----------
> --

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin
