Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E62C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 434E4887C6;
	Tue, 16 Jul 2024 09:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N/MUsZtV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1385E88979; Tue, 16 Jul 2024 09:25:15 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8F28875C
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266f535e82so34439955e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721114712; x=1721719512;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yyGrZwxus/Y+gMT5SxDmk1aXONHBOlINWNoPT1rhiWQ=;
 b=N/MUsZtVKF1pB1JYV6jvlmVZp1vsjYaZkCQoxnODFZD59KbBPPEYEXbKbTukiD7fCg
 IN+PZe/jt+3+KfgjkHRqYBB/80ZF9rK479rXC7WJz6LfatvYHp3x5YWOppw1ZxgAdci6
 p6QHYWw9J/28eWuyf1pP/MfXe/ppCSZF/RFWIQ7Q9Eqt4THEGpAWKbERu9O6ZTydcCjb
 tcXZyedSQxbA4SlxwR7zr5mXKqC+1z3rsuRHyhULfGM2E0Z9f0xk6uD0e08mm2Y5SH91
 njPV6BgjrRX0/H1H8o6QNZZTF4w8hjsk8d6pbdwOpqJfsEH9yI4p4qfT5tN9JH2nnlbt
 zccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114712; x=1721719512;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yyGrZwxus/Y+gMT5SxDmk1aXONHBOlINWNoPT1rhiWQ=;
 b=AJdo3aX8k7RB6Ftl18jjxbnY4Lot52X4lgU6fjUlyJZBWA/+G3xhL7GkF1YeaGMDsi
 eylI+qCC/pfsaIir5BVtINxXMchbzNxtVRkHVxzCDDyhiQ7Fvz5ZRIE5yutJ2GUiqBNd
 oWr2efgFc5JpGXAhyIWnSLjjd/Dsk1KxxFtWUcP4H3nXAWLomxzJes47EJdqWkOfWYPY
 ZgQIU+5kkV09/B76WxzgsVjQwHcvbsoRHf/bv/yq/kfHf4DNvv7lVms4lpGwoWkC2oHR
 UMw/1od9ZvXb4eWkYYzkDtVHovThP0p8Byprs/PZB16svbu5Wyk0/UzU8nw9ZM/IwU4y
 vhXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV4ea5+YLYB7KiuxPFVyhtrZaGNfs8eiKSLW3QQouxTxoOcsBid1s8puHLmhYHRntderL3tQWbfpbpBSyaMScrbOMinQ==
X-Gm-Message-State: AOJu0YzcOKfctWpimyj1L+OkEUdjnAvL4iE8qQFOPbIm/LySBOyq6Eza
 2MJFVxiLT5Ym2+Jt8v0fNFpzVw8CKGWe96WP8yj9kcaFpcTzi/M6EmmsI9b+yrU=
X-Google-Smtp-Source: AGHT+IF+9iItRjbrbaw1f+L9yLtJwPjW7jNNT3cAU4f86VhGL6IU+l5igxaxP7Q8yfC0YLsiU2vpug==
X-Received: by 2002:a5d:6911:0:b0:366:f469:a8d with SMTP id
 ffacd0b85a97d-36826152649mr740094f8f.35.1721114711920; 
 Tue, 16 Jul 2024 00:25:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3c38sm8212301f8f.8.2024.07.16.00.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:25:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Bin Meng
 <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao
 <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 05/13] doc: Add a description for bootmeth_qfw
In-Reply-To: <20240715101354.97895-6-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-6-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:25:08 +0200
Message-ID: <87ed7tol2j.fsf@baylibre.com>
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

> Add documentation for the qfw bootmeth.
>
> Fix up the compatible string to drop the 'extlinux' part, which is not
> relevant to this bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  boot/bootmeth_qfw.c              |  2 +-
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  1 +
>  doc/develop/bootstd/qfw.rst      | 21 +++++++++++++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
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
> index fd0692daf0d..bcc2c00c775 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -418,6 +418,7 @@ Bootmeth drivers are provided for:
>     - EFI boot using bootefi from disk
>     - VBE
>     - EFI boot using boot manager
> +   - :doc:`QFW <qfw>`: QEMU firmware interface
>  
>  
>  Command interface
> diff --git a/doc/develop/bootstd/qfw.rst b/doc/develop/bootstd/qfw.rst
> new file mode 100644
> index 00000000000..b0d47fd246a
> --- /dev/null
> +++ b/doc/develop/bootstd/qfw.rst
> @@ -0,0 +1,21 @@
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
> +provided by the QEMU `-kernel` argument, the iniital ramdisk and provided by

iniital -> initial

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
> +The compatible string "u-boot,qfw-bootmeth" is used for the driver. The driver
> +is automatically instantiated if there are no bootmeth drivers in the
> +devicetree.
> -- 
> 2.34.1
