Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF039C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D6288980;
	Tue, 16 Jul 2024 09:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Su8HcQUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9550388984; Tue, 16 Jul 2024 09:49:35 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F0788907
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so35414905e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721116172; x=1721720972;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VqRmicf9+LArg2q4v3gqjIb9XEUpnUdMDKeTdzCIkk4=;
 b=Su8HcQUg8YleCEykLLxypJK00uJtRmWBX6RLzchszfWq+STNTdZltUknb9t4Otyjmn
 A4lMVyzavVUwfqSbE4K1gX7erFHAjgiipTUJlFtLqmJpDCfKvzXJ6wbV0fbgKUKxOTOJ
 /mP5/m4DcVc73dviPOOMdZn8EhJSuA5xBbydd3qOZFp/Sqj+1SLhhcOB4ajhQnCRBdRK
 xm23rwiovJWYhcN3IRt0VUxYNWCSZ8m11BjwRB0BOORl+ruUACvk/uhi6fWUy4I+bwDY
 baPmn3hODqhrwLjSRpvbzbxsG9uZgmVvKL+DEOwrXNPwBhGB7XFk6nkBQa9IQDSM8IWI
 6SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721116172; x=1721720972;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VqRmicf9+LArg2q4v3gqjIb9XEUpnUdMDKeTdzCIkk4=;
 b=L1JQw7MeQssbNjXZCAvlL6Ku+GU/1mt5cblh+dw5xIb7bsB0Yli5pKCZ0HyE0c5kaw
 y/TP4SDVnSnJ4DazAwojVYypsl3cenNzF8uPaOLHe1RPjatdsoL0pozFwfSn0AAldFM3
 oAgaDZjjLzCgVkZGyPhk0hlyTRsQFqPMutI4d7gln9r8Y3NKkNqjR5Q+lZKSzkMfE6OV
 zUj+6xmwjs6S4/9ygem4Y5bdJshv0z2XC/B6HKig8zKk74Ls1kpkZUQmLPXTxjW2D/HK
 X8d3xJzWdVE8v+r5gDv12hhKmLz/rlhKxkxJ33PftWXp+pA3Ty3SjU8Laf9klc00EO96
 d79A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpn4Twh/8y09zr84eL5V+pIrr4RQv0b9RF5rAzn7QpS12HRB7GyMloXlKR67ciZe21KewrVpprIpefsX7FTWgQZfEsZw==
X-Gm-Message-State: AOJu0YxHFpf9z6i7d2zVn0bXdpZM5A0S9Uj0ZwMAaxkTRArV76wlEEp3
 KES7l6HKqxEODpaQzb/cddvW8tL7btVTccwfSGh+PE0IUKFfHyatfKu4mo3yQY1F5yb4X890NiV
 aeb8KkA==
X-Google-Smtp-Source: AGHT+IGJqouA1Unjlsqk2tgSrhlHeSzGISDhndOFa62b4Idssdt1yKmuTE8hg9CbclO5WhqRutdm5Q==
X-Received: by 2002:a05:600c:4fce:b0:426:8ee5:5d29 with SMTP id
 5b1f17b1804b1-427ba628f03mr8438455e9.9.1721116172355; 
 Tue, 16 Jul 2024 00:49:32 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25babbsm145434885e9.20.2024.07.16.00.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:49:31 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 11/14] doc: Add a description for bootmeth_script
In-Reply-To: <20240716070419.1897560-12-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-12-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:49:28 +0200
Message-ID: <87cyndn5dj.fsf@baylibre.com>
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

> Add documentation for the script bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - Adjustments from Heinrich's comments
>
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  2 +-
>  doc/develop/bootstd/script.rst   | 52 ++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100644 doc/develop/bootstd/script.rst
>
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> index 2c5d2d3fade..9d35b567d55 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -11,4 +11,5 @@ Standard Boot
>     pxelinux
>     qfw
>     cros
> +   script
>     sandbox
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index add054f3088..e4924b55ae7 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -414,7 +414,7 @@ Bootmeth drivers are provided for booting from various media:
>  
>     - :doc:`extlinux / syslinux <extlinux>` boot from a storage device
>     - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
> -   - U-Boot scripts from disk, network or SPI flash
> +   - :doc:`U-Boot scripts <script>` from disk, network or SPI flash
>     - EFI boot using bootefi from disk
>     - VBE
>     - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
> diff --git a/doc/develop/bootstd/script.rst b/doc/develop/bootstd/script.rst
> new file mode 100644
> index 00000000000..58ddc1cae1d
> --- /dev/null
> +++ b/doc/develop/bootstd/script.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Script Bootmeth
> +===============
> +
> +This bootmeth provides a way to locate and run a script on a block or network
> +device. It can also support SPI flash.
> +
> +For a block device the file is read from the selected partition, which must use
> +a supported filesystem. The subdirectory to search in is defined by the bootstd
> +list of prefixes ({"/", "/boot"} by default) and can be adjust with the
> +`filename-prefixes` property in the bootstd device.
> +
> +For a network device, the filename is obtained from the `boot_script_dhcp`
> +environment variable and the file is read using tftp. It must be in the
> +top-level directory of the tftp server.
> +
> +In either case (file or network), the bootmeth searches for the file and creates
> +a bootflow if found. The bootmeth searches for "boot.scr.uimg" first, then
> +"boot.scr" if not found.
> +
> +For SPI flash, a script is read from flash using the offset provided by the
> +"script_offset_f" environment variable.
> +
> +Some attempt is made to identify the Operating System: so far this only detects
> +an `Armbian <https://www.armbian.com>`_
> +distro. For block devices, if a file called "boot.bmp" exists in the same
> +directory then it is used as the bootflow logo.
> +
> +When the bootflow is booted, the bootmeth sets these environment variables:
> +
> +    devtype
> +        device type (e.g. "usb", "mmc", "ethernet" or "spi_flash")
> +
> +    devnum
> +        device number, corresponding to the device 'sequence' number
> +        `dev_seq(dev)`
> +
> +    distro_bootpart
> +        (block devices only) partition number on the device (numbered from 1)
> +
> +    prefix
> +        prefix used to find the file
> +
> +    mmc_bootdev
> +        device number (same as `devnum`), set for sunxi mmc devices only
> +
> +The script file must be a FIT or a legacy uImage. It is loaded into memory and
> +executed.
> +
> +The compatible string "u-boot,script" is used for the driver. It is present
> +if `CONFIG_BOOTMETH_SCRIPT` is enabled.
> -- 
> 2.34.1
