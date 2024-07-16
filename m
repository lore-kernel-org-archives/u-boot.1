Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37539C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CB9F8878A;
	Tue, 16 Jul 2024 09:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bc+ehexl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185D688962; Tue, 16 Jul 2024 09:29:04 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A748D8875C
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-59559ea9cfdso6656471a12.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721114937; x=1721719737;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VnlLCje9wSV8W5OljqL+hvaGX0sqDH8m9t/RTyQEPJM=;
 b=Bc+ehexlJLcZmZGcec+mWGHMOvrPfyKdIaqwIV3bnQPj+mJpmoGSkkz+R6iqClNQ4n
 yujKJp+zpfqtFX2hAwKROxTe7AMS3kUVhHJ3vrH3emilX7ArtovE0b2I0TJ/+ro67SF+
 Bqrnuqqjpttt5LX+n2U447ipzBcGKA/b9X6sdaNkeeYp6vjqXceW9Oawts2AmIB/Cm2h
 21F/ArIcSBppM4eCmxDyNbDwo+QGP9kDo/XQsANOKCQLfrnTOxDEGxlehx2ROx3niLDB
 lmGYidGC+zA0p45NVaPi156sR87qrifpwLnuruBegF2G6QV4DUDYYQCyF9R8Zlkfgwpv
 Q8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114937; x=1721719737;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnlLCje9wSV8W5OljqL+hvaGX0sqDH8m9t/RTyQEPJM=;
 b=oIhvA9XZvv6xpqIfVCoBHoVMLPvVLfDkoei01lutOslztxhmTdcn9xLxz0cg15gQ9C
 wiiIECCxLrHaDAupMmbExHI0bdGE5ETfXuZgUvviJgKYIgFQd+gNFO1GOacro0KzUWR+
 pwpPWFlUPkCgMAldAtQ7gYafMQS+RVo1BHfQIzKsBLS5SBopu5r4RHkPawxaCMr/WW3K
 V7KRxNOH4Rc912kIAeC87NoXibuTQhPwBqoMb0poWiFF2MKWSmhbkVX++f8CDISDVj0j
 s8Ui+2e+A00xzW5sU3ttEtWY1aiallpIPWG/1YCc/YYpCeA8tCOsI9qW71d2gMDDmHME
 zgMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYdirAiMtE80G3/TInrHfsAr86lwt2+8J1WG9f96WhCR47pwJxnLOTvXBEtlATkSoetZxYFLAiyfVDI4hElRRK6AgzPg==
X-Gm-Message-State: AOJu0Yxm/9TIW1OZRUKRjQgvP+iHf6TjSohG05JozGvQ9fQzfnDZmFji
 br2fMwfqeAgh8TgaFen+7V0UKgUT6IzYVAkZlj4H2RHHvc15p18ZAdsAqFum8FQyKncumAgyDnV
 kQ4g+/Q==
X-Google-Smtp-Source: AGHT+IHx2Byvjyjh0ea5IdvKmc91y0Pmrf61cd6ku64NAaTUDqsDJknuo3qYW1dbxjHYZqLaWh6VvA==
X-Received: by 2002:a05:600c:1f90:b0:426:6a84:2087 with SMTP id
 5b1f17b1804b1-427ba72b1b5mr8481565e9.34.1721114910078; 
 Tue, 16 Jul 2024 00:28:30 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm150039505e9.33.2024.07.16.00.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:28:29 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Bin Meng
 <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao
 <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 06/13] doc: Add a description for bootmeth_cros
In-Reply-To: <20240715101354.97895-7-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-7-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:28:26 +0200
Message-ID: <87bk2xokx1.fsf@baylibre.com>
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

> Add documentation for the cros bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  doc/develop/bootstd/cros.rst     | 33 ++++++++++++++++++++++++++++++++
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  1 +
>  3 files changed, 35 insertions(+)
>  create mode 100644 doc/develop/bootstd/cros.rst
>
> diff --git a/doc/develop/bootstd/cros.rst b/doc/develop/bootstd/cros.rst
> new file mode 100644
> index 00000000000..96f148837ac
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
> +Note that a ChromiumOS image typically has two copies of the OS, each with its
> +own kernel and root disk. There is no initial ramdisk (initrd). This means that
> +this bootmeth typically locates two separate images.
> +
> +The compatible string "u-boot,cros" is used for the driver. The driver is
> +automatically instantiated if there are no bootmeth drivers in the devicetree.
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
> index bcc2c00c775..f12e93236a7 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -417,6 +417,7 @@ Bootmeth drivers are provided for:
>     - U-Boot scripts from disk, network or SPI flash
>     - EFI boot using bootefi from disk
>     - VBE
> +   - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
>     - EFI boot using boot manager
>     - :doc:`QFW <qfw>`: QEMU firmware interface
>  
> -- 
> 2.34.1
