Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748F4C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F069889FC;
	Tue, 16 Jul 2024 09:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DpV84TvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A9888A08; Tue, 16 Jul 2024 09:05:06 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D67889CD
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b5dfa44f24so28376236d6.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113497; x=1721718297; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XVlEk8xbBvHXVU2J9XA7XEMr5S3SrBU0bui0VbtU+ag=;
 b=DpV84TvC+U9g7QxPt1U4bfE6Z1DyXqJsyRmyyl6I09DPedw4GsJhugHgzDiBb4f2gu
 vYRL4P47UUpdyvA86C0XAQyw2NvMc3pPKllQocHAXbWSyrIYpQ6Ate0yqek7gUxotFen
 qd7hHV3Kzu6yyJrwFLMkxmiNTmLNyXW3lhpL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113497; x=1721718297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XVlEk8xbBvHXVU2J9XA7XEMr5S3SrBU0bui0VbtU+ag=;
 b=e/7PIAVkP7u6JWqOelTO2SJWXzYgX2+INfIrX5TPUdfSzzv556/viYcx/FdAMS7imd
 IFXd9iRDTRSpxvkkh0kTB52YBjTbeDjuMpTMTvy3SH7A/EwFSQTWPb0W531TZFA5eX2/
 fIwFkY9c+nkU/iz+Hjwrch7dvE26DzKFcLn7FyHbYhZsYHNoeHw/g6aBKzjYFsvTNK4p
 gDIpO1TX7Yary/G9zyeNeI4MmOfkgk8hn2iLHagG3QSMVSGxZscg+tAPl9XC0mFIP+iJ
 ER96aMXC/tSRjs9GJ/xL8Fs8aF1I0pW5gdRnjCkv8eHYBykJKXrFAuLOZtV5Ob25Yk+6
 dAWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbtUvPA+uFv2qAeyTp48t51bRX+hQL6M+b6oP9FpO7x8xiwjdm5GyNx3FIbgKMEJE6FXUVevjyK1Fwe+NvkqfKdt++NA==
X-Gm-Message-State: AOJu0YzDCHhBB9OPVWXjzWxhLrrEV4TY1luUOOGDqHj2ftm5PBYTScgu
 BoY7lCTnghEmge0l5yQiI9+rC0ti1C6ggnEeLk/69MS4ROg7pDLRKXSuHBULN++DC6u9SI6+ion
 kGNbtUBTxGZIFvHR2Si3hQteYbndEibHHxlFX
X-Google-Smtp-Source: AGHT+IExT9X/ak3y9LHcfj5HaIHMa/oSVV3Ao29F5hvp6w+zP+5mX4cJVkXG5U6Tjz01KIyKArBlYp7Fj1fZg3om/vc=
X-Received: by 2002:ad4:5de7:0:b0:6b5:3b00:7e62 with SMTP id
 6a1803df08f44-6b77f4b6ab8mr20816116d6.8.1721113496766; Tue, 16 Jul 2024
 00:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240716024032.22254-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240716024032.22254-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Jul 2024 08:04:45 +0100
Message-ID: <CAFLszTgSE-Zd1OpoisD4pCi6mFw2KgYzfFwpOsstUw08LGO-Qg@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: provide CONFIG_BOOTMETH_QFW Kconfig parameter
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Tue, 16 Jul 2024 at 03:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> U-Boot is often used conjunction with QEMU to boot via EFI or syslinux.
> Here the QFW boot method is not needed.
>
> At least for qemu-riscv64_smode_defconfig the kernel parameter is used
> to specify the U-Boot binary. Trying to run U-Boot as a kernel makes
> no sense.
>
> Provide Kconfig parameter CONFIG_BOOTMETH_QFW to decide if the QFW boot
> method shall be provided.
>
> Disable the QFW boot method for all architectures but the sandbox by
> default.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/Kconfig  | 9 +++++++++
>  boot/Makefile | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 95300b008c5..d7e034c89e7 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -568,6 +568,15 @@ config BOOTMETH_EFI_BOOTMGR
>           the EFI binary to be launched is determined. To set the EFI variables
>           use the eficonfig command.
>
> +config BOOTMETH_QFW
> +       bool "Boot method using QEMU parameters"
> +       depends on QFW
> +       default y if SANDBOX
> +       help
> +        Use QEMU parameters -kernel, -initrd, -append to determine the kernel,
> +        initial RAM disk, and kernel command line parameters to boot an
> +        operating system. U-Boot's control device-tree is passed to the kernel.

I added the bootmeth to deal with this part of the old qemu-arm.h :

/* Try files from QEMU's -kernel/-initrd, through the QEMU firmware device. */
#define BOOTENV_DEV_QFW(devtypeu, devtypel, instance) \
"bootcmd_qfw= " \
"if qfw load $kernel_addr_r $ramdisk_addr_r; then " \
"  booti $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr; " \
"  if test $? -eq 1; then " \
"    bootz $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr; " \
"  fi ; " \
"fi\0"
#define BOOTENV_DEV_NAME_QFW(devtypeu, devtypel, instance) "qfw "

Are you sure this is not used?

> +
>  config BOOTMETH_VBE
>         bool "Bootdev support for Verified Boot for Embedded"
>         depends on FIT
> diff --git a/boot/Makefile b/boot/Makefile
> index 84ccfeaecec..92e6adb887c 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -11,7 +11,6 @@ obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
>  obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
>
>  obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
> -obj-$(CONFIG_QFW) += bootmeth_qfw.o
>
>  endif
>
> @@ -31,6 +30,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
> +obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_QFW) += bootmeth_qfw.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
>  obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
> --
> 2.45.2
>

Regards,
Simon
