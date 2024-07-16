Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AD2C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED88B887C6;
	Tue, 16 Jul 2024 09:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vwvl6sxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542578897B; Tue, 16 Jul 2024 09:21:50 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14AFB8875C
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so39999275e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721114507; x=1721719307;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nUzVEJg8NtekAmgd90qJtrkOCSIcF7D1vNR5jsW20y8=;
 b=vwvl6sxXaQRbHsNRQtso5Q3kwc4Tx9lI0r0VzRPdmwE8+oxBIfLKhfWF1EGcuebGTX
 RMeZhHgBYF8ub/oOZcooIu4nZeYYlM/sKyz9XoEYZL58zYE4i1gSxPbPZ45USscBweBs
 5QQubJdQ9MioqzGLh6D/HQOzuEJoCsxF8of0PskduV9e8Vn+6Yq9zSf/jfFaNiU1WlG1
 HmfN2ilqtT0KnPAuu4u5s8Rb3Xur6WnBPIfPf3mPixYUZts0UNGv6QuaIwdJo4JPURQw
 ctZ72D6WxIk15awZ4tgv/LXzmtAWMzZG6aZAqdUQ2Z9qnWDOyQ0oxGQfNQUOFTVqzhWw
 pzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114507; x=1721719307;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nUzVEJg8NtekAmgd90qJtrkOCSIcF7D1vNR5jsW20y8=;
 b=oyZXjOLYpDfqbwfDzZKCPmMlpCuCAr5251AN3kDFPdTAYZ9DJWIKW/MOFPVUM/fihq
 VdqCsmjfhPsGBdaeJQvDKyC8KN/e2S+1wh3mMAkWgQl0iw3x6fN4lm447I7ky+twjmcc
 9EbCUx7vTEPpCs8F8UXTW9Q/BVqn1XZbVwMpux/REL88eJ/d8e6nB07ty+tY/3OOL2j8
 vd7H/xIMrgfO4sGExqdjjZZii9Scdt7QgmHl83lp0sHzK4ITxSaxny/ZAurhvjm7gAyE
 v3mhiifZbmhUmRs/VIQr6//+NwnztNMT7rUQva/YBc9IJheQ3BMAgDqgJjGHB9o6eApG
 XzFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2FPzJoQielvFBSPWOrf46OcH07sM7i8Q/IMQkVDYVfUc/j6JFxym0/QiJ/I3utPEloRVyHtHzOy2tIlsWSksjmmihhA==
X-Gm-Message-State: AOJu0Yx9rE+KXUllQGugRYrwjL2zVOjOgoYX0yr+E4AvqvuqN4e3u4E1
 BtEC4UBiVU8KvJnJr4Ioz7V9zSLB4c4lGo/pQl4DWXVOmaVzkUjKeWPYriM/zlTlK8azliTnC4Y
 HhchEsw==
X-Google-Smtp-Source: AGHT+IE/rdAC1jQl7xFkhuZUw7odHs3TIlDl8qVFF4TorDyAMBinGafSwK/cHAnxqnt0/hXAaeW7ow==
X-Received: by 2002:a05:600c:4f44:b0:424:aa35:9fb9 with SMTP id
 5b1f17b1804b1-427ba64ce8dmr8850835e9.2.1721114507261; 
 Tue, 16 Jul 2024 00:21:47 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3681c30a024sm3916670f8f.96.2024.07.16.00.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:21:46 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Bin Meng
 <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao
 <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 04/13] doc: Add a description for bootmeth_pxe
In-Reply-To: <20240715101354.97895-5-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-5-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:21:42 +0200
Message-ID: <87h6cpol89.fsf@baylibre.com>
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

> Add documentation for the pxe bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Nitpick: now that pxelinux.rst exist, can we link to this file in
extlinux.rst ?

> ---
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
> index 086a0b1281d..fd0692daf0d 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -413,7 +413,7 @@ Available bootmeth drivers
>  Bootmeth drivers are provided for:
>  
>     - :doc:`extlinux / syslinux <extlinux>` boot from a disk
> -   - extlinux boot from a network (PXE)
> +   - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
>     - U-Boot scripts from disk, network or SPI flash
>     - EFI boot using bootefi from disk
>     - VBE
> diff --git a/doc/develop/bootstd/pxelinux.rst b/doc/develop/bootstd/pxelinux.rst
> new file mode 100644
> index 00000000000..08ba67e09c5
> --- /dev/null
> +++ b/doc/develop/bootstd/pxelinux.rst
> @@ -0,0 +1,27 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +PXE Bootmeth
> +============
> +
> +PXE (Preboot eXecution-Environment) provides a way to boot an Operating System
> +over a network interface. The PXE bootmeth supports PXELINUX and allows U-Boot to
> +provide a menu of possible Operating Systems from which the user can choose.
> +
> +U-Boot includes a parser for the `extlinux.conf` file described
> +`here <https://uapi-group.org/specifications/specs/boot_loader_specification>`_.
> +It consists primarily of a list of named OSes along with the kernel, initial
> +ramdisk and other settings. The file is retrieved from a network server using
> +tftpboot.
> +
> +When invoked on a bootdev, this bootmeth searches for the file and creates a
> +bootflow if found. See
> +`PXELINUX <https://wiki.syslinux.org/wiki/index.php?title=PXELINUX>`_ for
> +a full description of the search procedure.
> +
> +When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
> +context, then pxe_process() to process the file. Depending on the contents, this
> +may boot an OS or provide a list of options to the user, perhaps with a timeout.
> +
> +The compatible string "u-boot,extlinux-pxe" is used for the driver. The driver
> +is automatically instantiated if there are no bootmeth drivers in the
> +devicetree.
> -- 
> 2.34.1
