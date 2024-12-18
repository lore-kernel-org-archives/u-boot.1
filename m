Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0778E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 09:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F593802EF;
	Wed, 18 Dec 2024 10:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z/U7Ox56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 441F580288; Wed, 18 Dec 2024 10:57:40 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235EB8027E
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a766b475so65240655e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 01:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734515857; x=1735120657;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4uNAnDJRPU0z0wl86iE7QkAjjPQIsBp3PGHjTvpzY1o=;
 b=Z/U7Ox56ZPa8MQCYrPqXeOrSTvDZDPlLFxsgM6bdf8BIvG3QU1w0cmBCxp1XYGaixG
 fZ/HxGJwjWLyc6TZXu0RAd0THfe96Hxc6BCspmfo1gfnTLyRj+IUq//EX8IOMTnfJN/R
 EyYGktIJbWNZa5AwmKeQFWax0aeHum58uT6DCIY2YexBno+UL6R8AQ3IgraFFnJ+CwN1
 6X72nmBUKHXbliQLsrh4Rv3cyZ2hBIjDxuJduU9sKli6tdMzOfxUPuQCvlk7T+R0yjq8
 /VGYfmKdk+rASl649gJa++Zuqt3aFULX7s1TGIIOqi1Ga0Yg31AdJ3lP1Tl02dMAD2J8
 y4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734515857; x=1735120657;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uNAnDJRPU0z0wl86iE7QkAjjPQIsBp3PGHjTvpzY1o=;
 b=DGG49t63XdoAUawIZj80AAsnvpX1r9510a/1ZsIUjBqBFDuDXiV/BBxiRzzwbB99Gn
 1q6Ap3sr+u18ruWQbGIqJMRTsGAqob7LLqex7n2GCn4DPjNgWls2RXBj5vtuXfJBKhpl
 +fxdo6vZ09nhXIweG4qVwRzBYKK4qr3/XeByFw6B8LawsFAAhGd4NBtvaYbLPlRtAvI2
 htYMnhzY9AoVsUh7L6LEhh3dhW31FrxjFfNY6a5ByrFPWM7k/NEMJ8j9+tvdOqRN+mRc
 mYOZc8twiNLS4xkZpzHqxiw0jUbP4L7twT+HpLzIbeug7kovVoOUl2prn2oLKmrm0ByF
 SGiw==
X-Gm-Message-State: AOJu0YzpMvliL1vNJIMJCJvZhbSMl6qs/0ID7JfkSOcaM/DQt5rmhNsZ
 SOMtPiWMxcbvFSpnFwW+Abx+SDhxLCGANaseLQs7XnKMyEMYgmTbwGKcauHApZ8=
X-Gm-Gg: ASbGncvJz2PI9LwAsdyJZymicRrGkQBfccSXMhHt1td0ioUGeaX/XA99PkqXc2nFskM
 hivYWJRV9OPg5gWgszP+WzVr+5nigs4ZHTo3sW9jNKIcEjIW9YPr6eCx3WH+b/OHloJtntTDw8R
 x5AIrZPzJpADCL2yEgVJ37E2DFnsG60ngvKIrwDz1Y0f6SmY4bFsFu3B3lnO+q7Yn8VcRcyan5a
 81smoC5wcEnHLxrO8NdwAt4oqVqDoCcxV34qTOZTwXawAEUkKnV/uT8TFobgPeTRw==
X-Google-Smtp-Source: AGHT+IEigsCSJr2VAQ9e/bDOrrMmlv/w8QmqsvWM6Fh62H6gtjfk7Hx/Ia9sNUCJqzcoObByq6xduQ==
X-Received: by 2002:a05:600c:4586:b0:434:a1d3:a306 with SMTP id
 5b1f17b1804b1-4365534535bmr16418145e9.5.1734515857513; 
 Wed, 18 Dec 2024 01:57:37 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b441bbsm14728055e9.40.2024.12.18.01.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 01:57:37 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH 2/4] board: ti: am62px: env: include environment for DFU
 Boot
In-Reply-To: <20241217131658.2920799-3-s-vadapalli@ti.com>
References: <20241217131658.2920799-1-s-vadapalli@ti.com>
 <20241217131658.2920799-3-s-vadapalli@ti.com>
Date: Wed, 18 Dec 2024 10:57:36 +0100
Message-ID: <87y10dwbxr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Siddharth,

Thank you for the patch.

On mar., d=C3=A9c. 17, 2024 at 18:46, Siddharth Vadapalli <s-vadapalli@ti.c=
om> wrote:

> Include the TI K3 DFU environment to support DFU Boot and DFU Flash.
> Also add "usb" to the list of "boot_targets".
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  board/ti/am62px/am62px.env | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
> index 7ef54079aa8..e0838196e3a 100644
> --- a/board/ti/am62px/am62px.env
> +++ b/board/ti/am62px/am62px.env
> @@ -1,5 +1,6 @@
>  #include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
> +#include <env/ti/k3_dfu.env>
>
>  name_kern=3DImage
>  console=3DttyS2,115200n8
> @@ -7,7 +8,7 @@ args_all=3Dsetenv optargs ${optargs} earlycon=3Dns16550a,=
mmio32,0x02800000
>  	${mtdparts}
>  run_kern=3Dbooti ${loadaddr} ${rd_spec} ${fdtaddr}
>
> -boot_targets=3Dmmc1 mmc0 pxe dhcp
> +boot_targets=3Dmmc1 mmc0 usb pxe dhcp
>  boot=3Dmmc
>  mmcdev=3D1
>  bootpart=3D1:2
> @@ -17,4 +18,4 @@ rd_spec=3D-
>  #if CONFIG_BOOTMETH_ANDROID
>  #include <env/ti/android.env>
>  adtb_idx=3D3
> -#endif
> \ No newline at end of file
> +#endif

This change seems un-related, is it needed?

Also, looking at Martyn's/Sjoerd's series, I see a couple of things
missing:
1. Documentation. now that am62px is compatible with the
   am62x_r5_usbdfu.config fragment, we need to document this in the board
   docs. See: commit def64b493748 ("doc: board: Add document for DFU boot o=
n am62x SoCs")

2. Including configs/am62x_a53_usbdfu.config in configs/am62px_evm_a53_defc=
onfig.
   This is how it's done for am62x, see:
   commit dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU support")

Note that If we don't do 2), we cannot use USB gadget from a U-Boot that
has been booted over DFU:

    =3D> fastboot usb 0
    No USB device found
    USB init failed: -19
    =3D> usb list
    USB is stopped. Please issue 'usb start' first.
    =3D> usb start
    starting USB...
    No USB controllers found
    =3D>

For 2, this diff fixes it:

diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defc=
onfig
index 9635beb1b27e..81f433c997b5 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -183,3 +183,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
 CONFIG_EFI_SET_TIME=3Dy
=20
 #include <configs/k3_efi_capsule.config>
+#include <configs/am62x_a53_usbdfu.config>

In my opinion, 2) is a valid use case:
1. On a blank board, we boot the bootloaders over DFU
2. Once U-Boot is started, we start fastboot to flash all images to eMMC.

Could this be added for v2, please?

Thanks,
Mattijs

> --
> 2.43.0
