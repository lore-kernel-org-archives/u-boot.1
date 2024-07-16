Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6017BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38520874AC;
	Tue, 16 Jul 2024 09:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Bqjl8A0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE3F889C1; Tue, 16 Jul 2024 09:40:47 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC875889AD
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3679f806223so3613467f8f.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115645; x=1721720445;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9F9udPNv3SNK8XrCbL9UphAf93M5VdP1kZhENnU0MTA=;
 b=3Bqjl8A0ibTQqMz4gUmHtUi74G68YAqbOSnhpLVZ9g+giAUe0fTC4RT5P3BIlLRzN2
 64gayLuKN+ezMl7EFSP1rg3oBQ0xQgtlEAsHuQyE5tkgeNIucCPFpdSPgfxGGxw1xcDz
 nxYj6Uk24ltjBj33F/a1kHShM112WJSRIH1+hrv2Ts40mHqGw7QjpWhoTnHz0arrSHlL
 1KhMz4+V9BFJ+3HRRgPcZ1U7ziqVDC4EX2+aCeoKecrvLt2CVTYAgKQOdBlZBqWruVSf
 aZvvx2pZn5U/6Axm1wj5rUplne9aYc0vxfQmnHdfhcJnBR2i0IIdrTZ/AMekzbK/jSdL
 Z2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115645; x=1721720445;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9F9udPNv3SNK8XrCbL9UphAf93M5VdP1kZhENnU0MTA=;
 b=OA30m1sqxdrMOsZw3Rj/g20LQucRa9dnFsXzr6VIHaHD5Q3iiIpGkDFDOkGwwHK7rA
 jVO4FUQ5UZGBl3FPQSO/BdzcxhziKiucv4VD/JVtS/sIHnBAp88yEoaX/3OWlbXmoo4S
 V/g6pg+GD0OGn3P0SFU6LoFY8tLeTh6iYv2orzvQ9xdqalt3QS+M21GFmKd7lqS0QCZx
 zyU2oMeUkrF21SFW6xLfCmurX6/hz2HhLE+8ypWh1ggxmksE1k30qAoIOOqa2FHZTbfJ
 7VqPnJgFucncvMf2OYeN5jblyf7nfSQa2xbyKEDVsODlQYxXXHyDnLz82dVb6foDzKJf
 vHwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd172ThD1i+M9OyX25UH4rNW0foamVlAFahgZ1xsTtnkiv8HT4flUloXfAZrrTKMVkM4KyAxduJhRGknrtB2XG+GHz+g==
X-Gm-Message-State: AOJu0YyTBQZ4wOGL2iB99cnDf8eHhiIsn7Zz+1pnw7QBk/d2nSOwbS/T
 pwPRLz6JQ6T7LiwZtuS34xLy2AeKRINsYgRc33L3URmF+21pAb7AO9rF1kK09EM=
X-Google-Smtp-Source: AGHT+IHtmccJoqmUiJS9tTpTZf+fP69wznd4FJYbhRmTtS1lHPAyRScVNI318RGVumpmzwsjOLqZ0Q==
X-Received: by 2002:adf:ff8a:0:b0:363:b3ea:7290 with SMTP id
 ffacd0b85a97d-3682753b33bmr727263f8f.20.1721115644812; 
 Tue, 16 Jul 2024 00:40:44 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23999csm148755865e9.8.2024.07.16.00.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:40:43 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 06/14] doc: Add a description for bootmeth_qfw
In-Reply-To: <20240716070419.1897560-7-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-7-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:40:40 +0200
Message-ID: <87r0btn5s7.fsf@baylibre.com>
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

> Add documentation for the qfw bootmeth.
>
> Fix up the compatible string to drop the 'extlinux' part, which is not
> relevant to this bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>
> Changes in v2:
> - Adjustments from Heinrich's comments
>
>  boot/bootmeth_qfw.c              |  2 +-
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  1 +
>  doc/develop/bootstd/qfw.rst      | 20 ++++++++++++++++++++
>  4 files changed, 23 insertions(+), 1 deletion(-)
>  create mode 100644 doc/develop/bootstd/qfw.rst
>
> diff --git a/boot/bootmeth_qfw.c b/boot/bootmeth_qfw.c
> index dfaa944594e..2f8e00cf350 100644
> --- a/boot/bootmeth_qfw.c
> +++ b/boot/bootmeth_qfw.c
> @@ -88,7 +88,7 @@ static struct bootmeth_ops qfw_bootmeth_ops = {
>  };
>  
>  static const struct udevice_id qfw_bootmeth_ids[] = {
> -	{ .compatible = "u-boot,qfw-extlinux" },
> +	{ .compatible = "u-boot,qfw-bootmeth" },
>  	{ }
>  };
>  
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> index 5052afe448f..f8fce7207ce 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -9,3 +9,4 @@ Standard Boot
>     overview
>     extlinux
>     pxelinux
> +   qfw
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index b9b45f1e7a7..f23e344546d 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -418,6 +418,7 @@ Bootmeth drivers are provided for booting from various media:
>     - EFI boot using bootefi from disk
>     - VBE
>     - EFI boot using boot manager
> +   - :doc:`QFW <qfw>`: QEMU firmware interface
>  
>  Each driver is controlled by a Kconfig option. If no bootmeth driver is
>  selected by a compatible string in the devicetree, all available bootmeth
> diff --git a/doc/develop/bootstd/qfw.rst b/doc/develop/bootstd/qfw.rst
> new file mode 100644
> index 00000000000..b2ff1364fd8
> --- /dev/null
> +++ b/doc/develop/bootstd/qfw.rst
> @@ -0,0 +1,20 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +QFW Bootmeth
> +============
> +
> +`QEMU <hhttps://www.qemu.org/>`_ is a system emulator which is able to boot
> +Operating Systems. QEMU provides specific support for booting an OS image
> +provided on the QEMU command line.
> +
> +When invoked on a bootdev for UCLASS_QFW, this bootmeth reads the kernel
> +provided by the QEMU `-kernel` argument, the initial ramdisk and provided by

There is a "and" which should be removed here:
ramdisk and provided by -> ramdisk provided by

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>


> +`-initrd` and the boot arguments (command line) provided by `-append` into
> +memory ready for booting.
> +
> +When the bootflow is booted, the bootmeth tries the `booti` command first, then
> +falls back to the `bootz` command. U-Boot's 'control' devicetree is passed
> +through to the kernel.
> +
> +The compatible string "u-boot,qfw-bootmeth" is used for the driver. It is
> +present if `CONFIG_QFW` is enabled.
> -- 
> 2.34.1
