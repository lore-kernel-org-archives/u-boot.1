Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F97EC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01068898B;
	Tue, 16 Jul 2024 09:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M/v5yQCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D918898B; Tue, 16 Jul 2024 09:17:37 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80BF8878A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2eede876fccso38203011fa.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721114254; x=1721719054;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=97GhZn7gnFJQMTK4zXW1CmZ7otlS6AJrpGcixKp5XDI=;
 b=M/v5yQCz0nx/Ic1ZNYB0Kx8fE6g9kIKBMXgaUTkrt3o6kHVFqB+rdR5fMlXW2wRneE
 mADU2AiQoIKYDSzFsJFT6Eo+RFAVmS0LWMMu9ShtViTY2aninOFkZSmO2VRwepVdx0ZP
 rx4MfqN4f7vfigfkjukDnXGCoR+Owdj2pPH4xcJh5+w19ftTgGj8QnycL5B1eGLoo4El
 faAuVU+BNwvbwMwJJj5IAyO+pynhW8dHSLAK300RwhHeMDF4ZqYOV7CcgfEKzqBNJ65K
 +t5Gj+dzYnl+Ez6aATm0FL8x1sdyCkIKcZwh2b0jKd+9mv9KsQ4yeTUz+/sqhi7i6HfI
 aNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114254; x=1721719054;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97GhZn7gnFJQMTK4zXW1CmZ7otlS6AJrpGcixKp5XDI=;
 b=fds0aJ/xcFILi7AHQNJmoKmpL1/0TL4UEN5C/1llogOPNci1UnYnTtfMGGZmToJ2HH
 6k1o/HeYziEW+5xtetnjLAgvvcrd1PWFon206mgY6NdRpUr1SVqjrGR7JlZb9PqQjkem
 Koz/X9FrDiMKr8TeCbAIJeH/DZfia3dPB1z0pZgf/08Af+aFs4l1YbJ7mqtMP+7j9AyN
 KQzVSw3oUtHdFETYDfLchOFjEd6XUHISFKB+ChD+QXDQZO8HJnbwKdybT9ZgSLGQje8B
 w1pqsghoQh0l9GK4KcdOWedfZagI9ABoVgKpYAusOCkzRWLfIq/t5hP4xG0DLldn+ob8
 Mczg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmHsLmgC2jrktr+12JaYjnv5uVPTpNf6/eKJ5lDQ2Kf9ZfA8YVTfFvw/KOUAkZiKdH2YUNG5cInmxA7mseONsxFfpWVg==
X-Gm-Message-State: AOJu0YyT6LGXdtXhgliZTFXy6yVTCzhmaiKqoM3cfbfoKnel3rvthTdS
 yKLnAfPyesNkorR9huCeCy+UpJK5uDT7mhhd3A1WdvravNNu4knPxpcFo1b0ALk=
X-Google-Smtp-Source: AGHT+IG+rAeUfnq5zW0XIkdgoD7bEXBefMz4R29YySYACxRAZEfhkmWZWV75hbyxBxC62WIEOoU23Q==
X-Received: by 2002:a2e:961a:0:b0:2ee:7b7d:66df with SMTP id
 38308e7fff4ca-2eef4160428mr8542781fa.9.1721114253639; 
 Tue, 16 Jul 2024 00:17:33 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm112006105e9.46.2024.07.16.00.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:17:32 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Bin Meng
 <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao
 <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 03/13] doc: Add a description for bootmeth_extlinux
In-Reply-To: <20240715101354.97895-4-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-4-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:17:30 +0200
Message-ID: <87jzhlolf9.fsf@baylibre.com>
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

On lun., juil. 15, 2024 at 11:13, Simon Glass <sjg@chromium.org> wrote:

> Add documentation for the extlinux bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Minor nitpicks below, feel free to ignore or apply.

> ---
>
>  doc/develop/bootstd/extlinux.rst | 27 +++++++++++++++++++++++++++
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  2 +-
>  3 files changed, 29 insertions(+), 1 deletion(-)
>  create mode 100644 doc/develop/bootstd/extlinux.rst
>
> diff --git a/doc/develop/bootstd/extlinux.rst b/doc/develop/bootstd/extlinux.rst
> new file mode 100644
> index 00000000000..28490f38899
> --- /dev/null
> +++ b/doc/develop/bootstd/extlinux.rst
> @@ -0,0 +1,27 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Extlinux Bootmeth
> +=================
> +
> +`Extlinux <https://uapi-group.org/specifications/specs/boot_loader_specification>`_
> +(sometimes called syslinux) allows U-Boot to provide a menu of possible
> +Operating Systems from which the user can choose.
> +
> +U-Boot includes a parser for the `extlinux.conf` file. It consists primarily of
> +a list of named OSes along with the kernel, initial ramdisk and other settings.
> +The file is stored in the `extlinux/` subdirectory, possibly under the `boot/`
> +subdirectory. This list of prefixes ({"/", "/boot"} by default) can be selected

Can the prefixes also be surrounded by `` (`{"/", "boot"`} to insist
that this is "code listing" as well ?

> +with the `filename-prefixes` property in the bootstd device.
> +
> +Note that PXE (Preboot eXecution-Environment) uses the same file format, but in
> +a network context.
> +
> +When invoked on a bootdev, this bootmeth searches for the file and creates a
> +bootflow if found.
> +
> +When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
> +context, then pxe_process() to process the file. Depending on the contents, this

same for pxe_setup_ctx and pxe_process

> +may boot an OS or provide a list of options to the user, perhaps with a timeout.
> +
> +The compatible string "u-boot,extlinux" is used for the driver. The driver is
> +automatically instantiated if there are no bootmeth drivers in the devicetree.
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
> index 761f61a573b..086a0b1281d 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -412,7 +412,7 @@ Available bootmeth drivers
>  
>  Bootmeth drivers are provided for:
>  
> -   - extlinux / syslinux boot from a disk
> +   - :doc:`extlinux / syslinux <extlinux>` boot from a disk
>     - extlinux boot from a network (PXE)
>     - U-Boot scripts from disk, network or SPI flash
>     - EFI boot using bootefi from disk
> -- 
> 2.34.1
