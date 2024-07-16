Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C6EC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1B38878A;
	Tue, 16 Jul 2024 09:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2RUilzsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FDD588984; Tue, 16 Jul 2024 09:30:49 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 963358875C
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42660b8dd27so34425465e9.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115047; x=1721719847;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kprzt1dlusX6IVWKZ9Xxa0ikjl5FvHO3vZQHzEF+TBA=;
 b=2RUilzsmfdfAieQFLlXcl1cgA74VY3KI9hnVsjN8PLfdjsfH72XvlnKugsPU78Gwlc
 vCMsoGhRXKfTmD8Zq4eLq/A5MvTJM6oSNI37rmABGr+gox4j300x8K7NZRIzJXFaNrRa
 zZ1pmVI4O9iOutVJXioCIE2cCOjbcRgZZX/EkB55K3nb8TIHpp+z6Wd7SgcCitUKVAVs
 3BQZ07j5RxliX9nr0pYKDgStm7g+b6mPlwDECJpVTqqWrLuJxd5GD57776c8qhJsMv2w
 DQ8tfmj34vdg6DCdaXYBLZmqOyCb2+885xNGPrPZF9ssdBGxhbAimCRdNoEEuC+O2gbY
 07Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115047; x=1721719847;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kprzt1dlusX6IVWKZ9Xxa0ikjl5FvHO3vZQHzEF+TBA=;
 b=ER+D+dUKeOJ/+CSzMvbSCYGzK1QR1nOzbJHQTpcU8Chzkq7wJJOvJlVp3ODz1OQEk9
 WDauQyM46URztdLZZf0kWpeF5WLJeS0/bxHt34dfRa/n8kkQpDrJjDkJVZzwuvCkS1N1
 aFnZrAPcOdlPGndoY//8JZASeThkQsYkqO6ZWff6hciHIWAMqyhTkkkbN+yTEoqgN3Eh
 4S7HLM0SXJ+zYwC+RyxLMR5a6cbPcCMrWZWbO9nJXEJe786lAQpSv70ORUApFFTHwL4u
 SyOsOSyHtf3WNUM/VbcGt3hgouCse/RWk4toXixArJc5edtmw3qKE/3wOrO5gtdXuPaJ
 c5DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY+KdNQ3a6DvAL29iHYH0XKKBd7An1WyjALnlBJHD2t2oh0vGIQtAUYzcHQmcunLL9kTLbj4dHdLfCRVLThdqbebDNLw==
X-Gm-Message-State: AOJu0YyXVe+FQkKPs+g6MZzv9D99A/YWrwly6zyvXKUMyxVz0yVnwE/Y
 YLqGAFUoFDiDJhS3+v5eHMp2pfp155QgEMnf2w+RugRZLb3LmHlnFzyWbpniiWw=
X-Google-Smtp-Source: AGHT+IFJrHCLDTlqEv5ANWC8tbK1KahaOffXFTA7/xMcQMJ3kfMKj8quvzczXM533fkVwLy1luIhSw==
X-Received: by 2002:a05:600c:1c0d:b0:426:68f2:4d7b with SMTP id
 5b1f17b1804b1-427ba65e3bemr9609675e9.3.1721115046822; 
 Tue, 16 Jul 2024 00:30:46 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e983e7sm112461035e9.23.2024.07.16.00.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:30:46 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>, Quentin
 Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 07/13] doc: Add a description for bootmeth_sandbox
In-Reply-To: <20240715101354.97895-8-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-8-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:30:43 +0200
Message-ID: <878qy1okt8.fsf@baylibre.com>
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

> Add documentation for the sandbox bootmeth.
>
> Fix up the compatible string to drop the 'extlinux' part, which is not
> relevant to this bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  boot/bootmeth_sandbox.c          |  2 +-
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  1 +
>  doc/develop/bootstd/sandbox.rst  | 18 ++++++++++++++++++
>  4 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 doc/develop/bootstd/sandbox.rst
>
> diff --git a/boot/bootmeth_sandbox.c b/boot/bootmeth_sandbox.c
> index 0bc8f688e30..26c713bb5f3 100644
> --- a/boot/bootmeth_sandbox.c
> +++ b/boot/bootmeth_sandbox.c
> @@ -55,7 +55,7 @@ static struct bootmeth_ops sandbox_bootmeth_ops = {
>  };
>  
>  static const struct udevice_id sandbox_bootmeth_ids[] = {
> -	{ .compatible = "u-boot,sandbox-extlinux" },
> +	{ .compatible = "u-boot,sandbox-bootmeth" },
>  	{ }
>  };
>  
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> index 69fd3c2d2eb..2c5d2d3fade 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -11,3 +11,4 @@ Standard Boot
>     pxelinux
>     qfw
>     cros
> +   sandbox
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index f12e93236a7..58acaa4d3ce 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -420,6 +420,7 @@ Bootmeth drivers are provided for:
>     - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
>     - EFI boot using boot manager
>     - :doc:`QFW <qfw>`: QEMU firmware interface
> +   - :doc:`sandbox <sandbox>` used only for testing
>  
>  
>  Command interface
> diff --git a/doc/develop/bootstd/sandbox.rst b/doc/develop/bootstd/sandbox.rst
> new file mode 100644
> index 00000000000..508f0fd5baa
> --- /dev/null
> +++ b/doc/develop/bootstd/sandbox.rst
> @@ -0,0 +1,18 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Sandbox Bootmeth
> +================
> +
> +The sandbox bootmeth is only used for testing. It does not provide any facility
> +for booting an OS. While sandbox can do all the processing before the actual
> +boot, it is not connected in this bootmeth.
> +
> +When invoked on a bootdev, this bootmeth pretends to find a bootflow and creates
> +the associated structure.
> +
> +When the bootflow is booted, the bootmeth returns -EENOTSUPP indicating that it
> +is not supported.
> +
> +The compatible string "u-boot,sandbox-bootmeth" is used for the driver. The
> +driver is automatically instantiated if there are no bootmeth drivers in the
> +devicetree.
> -- 
> 2.34.1
