Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760B6C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E367288992;
	Tue, 16 Jul 2024 09:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gp1YDLQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF356874AC; Tue, 16 Jul 2024 09:38:55 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8D8889A0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso37843575e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115533; x=1721720333;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KWdJA+KvdfppNglmdfzlfTESIUH3r0/b8IoUaQlbaro=;
 b=gp1YDLQuahbzK6NMAZnaOz0Kv1SBUUN4ynRX3B1nhYSIMukj/V6VWYtmgLrZtM+Wrp
 zBo8sAuo0B52t6ngARfmF7B5fj/e6ZYHX+75nM4+SYR0qlIKmTtjeksjbbMmzpKkCibk
 /wzf8HwRCE2siD/Ebido4M0QzkEfLB1zQdxqz1p04d3WOg3l8tLtPwnLBQI1x3cauG6Y
 pZed3eGOXKvIhZL5ZB0gS3yv++sSZ/cP5feWgaXOSJfhdD1h1hN94K7S4Sqp7rCTlfbQ
 cmiaMSDAx1FukYOzSfypkA6jPlnSgeHS8eofAiQClHPjuMIJRT0bcKZqFnSFXLvrlVx5
 GveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115533; x=1721720333;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KWdJA+KvdfppNglmdfzlfTESIUH3r0/b8IoUaQlbaro=;
 b=cwDAYa/+7C7hBgdH33rve3tTRuItIpVlohgqeaWx3QsevcmMnqUvx+npzWo6sIIP65
 4hCHB9qc1lNRqyuShu/P8tqN3+T3DzAhkXPW13d1Ta3vhngYhNbnYZKjhkQymKjZ1vvm
 yT67sAZylSO7jjZgEay7gwT+asIbN/4tMQIaW7RQc1JFOKs/IY3UdnpFfwkru6zOUzNc
 fL7+88XgDZlxmS4CVjUd8OkAxHIvin8QSJtFQz9osso40vYZlBonPumJtwQ0Yqm/8bbq
 P9CEPWVLuiwzBqOGRHpYxWongK6jUy0JI4Jv8U1lzMge/dVJbbZ3bH3zJ8rw8WaCCbGU
 sCnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQPCUZzJ5pVgQoKaPkje37CqtgtQNojG+6ECwhE65VVYIEcofp1ZcfRAIkOeHd+dIRqZ2qufgO36oPGM4UxwdRS9efNg==
X-Gm-Message-State: AOJu0YwVzvSAvvqz36IXiHvAlAvtckFq7RwKzInB6Q3Bf7H32nyfH2b6
 Ilz+BtmvgOq6sWhSlh26RPetzss+t3KRvdeTs/DcslYhfvMG7gi24piQAgX0jVa0TVGE+yFwHin
 6I1NN6w==
X-Google-Smtp-Source: AGHT+IFOZkqP5i1a+hm0jb6pvjDLxJfEZPU9NLSOKDErPLyr4xwr4DpIq4NzkvXkQ5huNKYnKwQqhw==
X-Received: by 2002:a05:600c:19ca:b0:426:5b21:97f9 with SMTP id
 5b1f17b1804b1-427ba72811fmr8636445e9.32.1721115532975; 
 Tue, 16 Jul 2024 00:38:52 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb50fsm113243775e9.38.2024.07.16.00.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:38:52 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 05/14] doc: Add a description for bootmeth_pxe
In-Reply-To: <20240716070419.1897560-6-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-6-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:38:49 +0200
Message-ID: <87ttgpn5va.fsf@baylibre.com>
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

> Add documentation for the pxe bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Nitpick: now that pxelinux.rst exist, can we link to this file in
extlinux.rst ?

> ---
>
> Changes in v2:
> - Adjustments from Heinrich's comments
>
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  2 +-
>  doc/develop/bootstd/pxelinux.rst | 27 +++++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>  create mode 100644 doc/develop/bootstd/pxelinux.rst
>
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> index 5bbb3d633a3..5052afe448f 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -8,3 +8,4 @@ Standard Boot
>  
>     overview
>     extlinux
> +   pxelinux
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index 7af159b9ca8..b9b45f1e7a7 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -413,7 +413,7 @@ Available bootmeth drivers
>  Bootmeth drivers are provided for booting from various media:
>  
>     - :doc:`extlinux / syslinux <extlinux>` boot from a storage device
> -   - extlinux boot from a network (PXE)
> +   - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
>     - U-Boot scripts from disk, network or SPI flash
>     - EFI boot using bootefi from disk
>     - VBE
> diff --git a/doc/develop/bootstd/pxelinux.rst b/doc/develop/bootstd/pxelinux.rst
> new file mode 100644
> index 00000000000..a4e559160ca
> --- /dev/null
> +++ b/doc/develop/bootstd/pxelinux.rst
> @@ -0,0 +1,27 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +PXE Bootmeth
> +============
> +
> +PXE (Preboot eXecution-Environment) provides a way to boot an operating system
> +over a network interface. The PXE bootmeth supports PXELINUX and allows U-Boot to
> +provide a menu of possible Operating Systems from which the user can choose.
> +
> +U-Boot includes a parser for the `extlinux.conf` file described
> +`here <https://uapi-group.org/specifications/specs/boot_loader_specification>`_.
> +It consists primarily of a list of named operating systems along with the
> +kernel, initial ramdisk and other settings. The file is retrieved from a network
> +server using the TFTP protocol.
> +
> +When invoked on a bootdev, this bootmeth searches for the file and creates a
> +bootflow if found. See
> +`PXELINUX <https://wiki.syslinux.org/wiki/index.php?title=PXELINUX>`_ for
> +a full description of the search procedure.
> +
> +When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
> +context, then pxe_process() to process the file. Depending on the contents, this
> +may boot an Operating System or provide a list of options to the user, perhaps
> +with a timeout.
> +
> +The compatible string "u-boot,extlinux-pxe" is used for the driver. It is
> +present if `CONFIG_BOOTMETH_EXTLINUX_PXE` is enabled.
> -- 
> 2.34.1
