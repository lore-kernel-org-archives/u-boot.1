Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB8CC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A483A889BA;
	Tue, 16 Jul 2024 09:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ObRs6/Zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3166B889C2; Tue, 16 Jul 2024 09:41:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7BE889AD
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-427b8571820so5670255e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115682; x=1721720482;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2DpPX/j+RGKAThDdw8wtX0/CNKFNuNosW3OUsj51B8=;
 b=ObRs6/ZrjhfWlpcoAZXgf+dnsoZFJtbnwO5ja9BunZhK6FYl+TfyRQzApn5OmolE2N
 BJH3c7PHA5F6m4UPiI/QH2gZe0H3csOnBbp6f40boJAS+vzNnsRxpjr1AGB6d6Izwx6T
 NWSxiC2h7fzS9fZnFVWB+cq9JjvQBbvLggitxgjAuPNV/bN+TkVTUAKDzgZswaNJ1/jX
 mo2UCF04mn2Q84FnjemnzVVpFiH7/3o5LU8wU3Mg2Po+sVXHCEMoRmN4U21ddsjNJWuY
 T4fI+ey3nGtw9735V0qgSaKnOWJSyz0/roYOK2kjHU+4YFyhbl+CXWyPyrdUMvN7P/c/
 ttrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115682; x=1721720482;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2DpPX/j+RGKAThDdw8wtX0/CNKFNuNosW3OUsj51B8=;
 b=b0+gPAteCzhdkhhDnO9PpdWVnUDWa6XIAAopXmvWxPiyEOGD31mF4ZoMj5bKV/tYD5
 U2RwFjoMAHmUXb2AK07wEkAhrUAki//HT8oX+L+UC0fzdAqsdsIiL9yPlciyaktv5Q4Z
 xSfdHCNUlJNKyaWiEns4/X2O+9JHTkQeu41MV8uspEAJej22fCufwxBCA5xwt92kCmOz
 KOZztiO9Nyqku+3hpuESukdB12ViTyTwy+AqKH5rQNb7IiZzfrzR9Fw+4LCI7YZuheiu
 Hr/6zAQmhl658EsJ90ZULUjKgVf8P9ttntwTTU2pJVR8wqlWuTdy8RzPnxaXqrnSI0+y
 hG9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBuu+Dj2oydqGZ4PBmwD03kPtFQMfb9sRV1fZIVhcgIG8uKcEKIlEcT4KYkpiYhmtDqYkWUzr7Gt3Lflfc8qeWP2ZVQQ==
X-Gm-Message-State: AOJu0YwYEbb21J29sd5jBN9AbtvnkaGiErqec6t7yX2UKPiT7ujoIMT0
 8UM3P/oia1AglQHzS6Px5dYsFNbWkYDh79wwBfHnkNdoLd34rRPeL+o6DBMLu0o=
X-Google-Smtp-Source: AGHT+IHBHpDufHkEqUEdWpaZNpbG9hv3F6yiqeExSfdcXFbqYRsL+RZ4utWyVE2F83rmC78lFfwCFg==
X-Received: by 2002:a05:600c:450b:b0:426:5c36:207c with SMTP id
 5b1f17b1804b1-427ba7158acmr11051135e9.25.1721115682064; 
 Tue, 16 Jul 2024 00:41:22 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef57aesm110674505e9.45.2024.07.16.00.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:41:21 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 07/14] doc: Add a description for bootmeth_cros
In-Reply-To: <20240716070419.1897560-8-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-8-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:41:18 +0200
Message-ID: <87o76xn5r5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On mar., juil. 16, 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:

> Add documentation for the cros bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - Adjustments from Heinrich's comments
>
>  doc/develop/bootstd/cros.rst     | 33 ++++++++++++++++++++++++++++++++
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  1 +
>  3 files changed, 35 insertions(+)
>  create mode 100644 doc/develop/bootstd/cros.rst
>
> diff --git a/doc/develop/bootstd/cros.rst b/doc/develop/bootstd/cros.rst
> new file mode 100644
> index 00000000000..92b83729150
> --- /dev/null
> +++ b/doc/develop/bootstd/cros.rst
> @@ -0,0 +1,33 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +ChromiumOS Bootmeth
> +===================
> +
> +ChromiumOS provides a mechanism for booting its Operating System from a block
> +device, described
> +`here <https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/>`_.
> +
> +U-Boot includes support for reading the associated data structures from the
> +device and identifying a bootable ChromiumOS image. This structure includes the
> +kernel itself, boot arguments (kernel command line), as well as the x86 setup
> +block (for x86 only).
> +
> +When invoked on a bootdev, this bootmeth searches for kernel partitions with
> +the appropriate GUID (Globally Unique Identifier). When found, the information
> +is loaded and a bootflow is created.
> +
> +When the bootflow is booted, the bootmeth reads the kernel and boot arguments.
> +It then boots the kernel using zboot (on x86) or bootm (on ARM). The boot
> +arguments are adjusted to replace %U with the UUID of the selected kernel
> +partition. This results in the correct root disk being used, which is the next
> +partition after the kernel partition.
> +
> +For ARM, a :doc:`/usage/fit/index` is used. The `CONFIG_FIT_BEST_MATCH` option
> +must be enabled for U-Boot to select the correct devicetree to boot with.
> +
> +Note that a ChromiumOS image typically has two copies of the Operating System,
> +each with its own kernel and root disk. There is no initial ramdisk (initrd).
> +This means that this bootmeth typically locates two separate images.
> +
> +The compatible string "u-boot,cros" is used for the driver. It is present
> +if `CONFIG_BOOTMETH_CROS` is enabled.
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> index f8fce7207ce..69fd3c2d2eb 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -10,3 +10,4 @@ Standard Boot
>     extlinux
>     pxelinux
>     qfw
> +   cros
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index f23e344546d..9b50b5593c4 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -417,6 +417,7 @@ Bootmeth drivers are provided for booting from various media:
>     - U-Boot scripts from disk, network or SPI flash
>     - EFI boot using bootefi from disk
>     - VBE
> +   - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
>     - EFI boot using boot manager
>     - :doc:`QFW <qfw>`: QEMU firmware interface
>  
> -- 
> 2.34.1
