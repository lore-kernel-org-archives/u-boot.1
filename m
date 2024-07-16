Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31473C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC33889A1;
	Tue, 16 Jul 2024 09:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DnYJtrfh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AFE388992; Tue, 16 Jul 2024 09:38:05 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F89889A3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso32620705e9.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115480; x=1721720280;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8JLGNIePd8Vti0MPz2vaTiMw+elPWOkTuCQLkUmRGbE=;
 b=DnYJtrfh00HYbpcsa7WtPn8V9qTkNdNsrcyRT/IOOwpPEEAehVTlWm+Wh44i6L6i8G
 fHAFM31YAXSDYCtWYNCpsNt918e6Th0aAQFbvAjCH1SIdzDdlru9mxgoJJbd4XBU8XUy
 hTDA+EO6Q9BNz7U0g4k9xPErHoJUC+ENcA4gQouXobVc4UoUd6c/UYYcr/tXRN1pllpp
 BAwpVzZZq5gM0cTz0/s5WdKDFI7KIR2r6uA+5USPgRdO9g9eH5QcHGZYnqNzp+Sxb0Fk
 TUOG1RWW7Dgogk165TC5QWyV36y7Ub/k0WPbuQAmR1mvIm9SE6uGA3/iuLZBOBEVcgmk
 eo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115480; x=1721720280;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JLGNIePd8Vti0MPz2vaTiMw+elPWOkTuCQLkUmRGbE=;
 b=oWZOIdVy18aBUWdsz76F5NobiuSiKAmcY6e9GO3ggpkvnTFMko3DeJUvM3VVGqQCE1
 LtfN6p5NHLM93f/7HfXmBWJofD+BBMbj7KEivGu54ClrBXWUgs4Pd16h2uKc+pBdLzsC
 xqRS+J9h7ocx/tpE/VkRhWxZfFroXrbqjQwLRfy+MCdXoJTgsUvRUQePmis5mP4XnLGv
 otzIr27df0+r6TwJCV1POIivDKOOPhsyGFVyTT27URTA4skFfIv7sYadUd28X7Rtfay6
 2BRJVDhmJKK6qPEe10Njo4O4jpkGMcDLndfr96ImXTqly2UIM9zFdNBi2UsQm+WFt2bc
 ag9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm9wliSxM4Vzluv3RjsmXnpB0MrS8rlYjhOUxPmcFEP85XOkS8j9OrkBhM8Sf0OC8B6lmIwFX+okRsRBGLKNIMHynckA==
X-Gm-Message-State: AOJu0YwaBukDe/VA+ryQ7hNxj7Uz5lBFPgBEyEUaHaTRZ29Yt28/zlGv
 4+sVouRFO0Mdm1hKNqARrjCrhAimLf2BDqen2KbQEZ+24oA3HV2BDVIrJNmXrPJ//l8j++WddPY
 LAIiXDA==
X-Google-Smtp-Source: AGHT+IGJmA8wIfM9Bu1deNor0Sda9yQlLOaZnqzzyj5FLOTkD7y5JKvnNIAompp9EcFcohpbZ5dDtQ==
X-Received: by 2002:a05:600c:5488:b0:426:6675:a115 with SMTP id
 5b1f17b1804b1-427ba654735mr7336925e9.22.1721115479606; 
 Tue, 16 Jul 2024 00:37:59 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f276b14sm148378935e9.23.2024.07.16.00.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:37:58 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 04/14] doc: Add a description for bootmeth_extlinux
In-Reply-To: <20240716070419.1897560-5-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-5-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:37:56 +0200
Message-ID: <87wmlln5wr.fsf@baylibre.com>
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

> Add documentation for the extlinux bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Minor nitpicks below, feel free to ignore or apply.

> ---
>
> Changes in v2:
> - Adjustments from Heinrich's comments
>
>  doc/develop/bootstd/extlinux.rst | 28 ++++++++++++++++++++++++++++
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  4 ++--
>  3 files changed, 31 insertions(+), 2 deletions(-)
>  create mode 100644 doc/develop/bootstd/extlinux.rst
>
> diff --git a/doc/develop/bootstd/extlinux.rst b/doc/develop/bootstd/extlinux.rst
> new file mode 100644
> index 00000000000..d87730410ee
> --- /dev/null
> +++ b/doc/develop/bootstd/extlinux.rst
> @@ -0,0 +1,28 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Extlinux Bootmeth
> +=================
> +
> +`Extlinux <https://uapi-group.org/specifications/specs/boot_loader_specification>`_
> +(sometimes called syslinux) allows U-Boot to provide a menu of available
> +operating systems from which the user can choose.
> +
> +U-Boot includes a parser for the `extlinux.conf` file. It consists primarily of
> +a list of named operating systems along with the kernel, initial ramdisk and
> +other settings. The file is stored in the `extlinux/` subdirectory, possibly
> +under the `boot/` subdirectory. This list of prefixes ({"/", "/boot"} by

Can the prefixes also be surrounded by `` (`{"/", "boot"`} to insist
that this is "code listing" as well ?

> +default) can be selected with the `filename-prefixes` property in the bootstd
> +device.
> +
> +Note that the PXE bootmeth uses the same file format, but in a network context.
> +
> +When invoked on a bootdev, this bootmeth searches for the file and creates a
> +bootflow if found.
> +
> +When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
> +context, then pxe_process() to process the file. Depending on the contents, this

same for pxe_setup_ctx and pxe_process

> +may boot an operating system or provide a list of options to the user, perhaps
> +with a timeout.
> +
> +The compatible string "u-boot,extlinux" is used for the driver. It is present
> +if `CONFIG_BOOTMETH_EXTLINUX` is enabled.
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> index f4f87c7787c..5bbb3d633a3 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -7,3 +7,4 @@ Standard Boot
>     :maxdepth: 2
>  
>     overview
> +   extlinux
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index d5051e986bb..7af159b9ca8 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -410,9 +410,9 @@ a good selection of boot options is available.
>  Available bootmeth drivers
>  --------------------------
>  
> -Bootmeth drivers are provided for:
> +Bootmeth drivers are provided for booting from various media:
>  
> -   - extlinux / syslinux boot from a disk
> +   - :doc:`extlinux / syslinux <extlinux>` boot from a storage device
>     - extlinux boot from a network (PXE)
>     - U-Boot scripts from disk, network or SPI flash
>     - EFI boot using bootefi from disk
> -- 
> 2.34.1
