Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF000D41D4A
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E02D89534;
	Wed, 13 Nov 2024 14:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JM8TkBav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6FA3894D4; Wed, 13 Nov 2024 14:39:37 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A00089574
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso1227857166b.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731505174; x=1732109974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t00HJ6nZl5YlL7kjFu+M5lbvcvCSnY+lTe1PE3+6ZDc=;
 b=JM8TkBavRRAfflhj+IXqPmgW4cRwErnH/8eIymlgwtCnNicVzlsZMjS+OtwCj2upSl
 RD/9rOyfIj4QDxUXFLILu8HU3YArKFyoUmuVJqcfVMs+jdgyNCz85j/YXmLIeqFRSgie
 38jYpX/8/bsjHzM1TbgmzCbprm11E1jTWqO6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731505174; x=1732109974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t00HJ6nZl5YlL7kjFu+M5lbvcvCSnY+lTe1PE3+6ZDc=;
 b=Qkue5in0I525oDcrWSo4o+OW5yQL/CwxyJDXX8aoMuS82hg8cSMZsrtDLFWtjCL8e+
 eP+nNqjVV5Lo9YujF9c6vD1neY0ZNrKGEByajEbWMYjv4Y9SI2A26bGaFKaRtA9fJWXD
 MJNNKxZYZ951DTp7wwmhjIk78+jUYQhl7GhJZLodoGEDxLcEx5IX0WCpTHJGx9qowtDE
 9MrawpkpvJCJKTsm0A4AQfSZpJh5eiMwb/VYFoHJM6W0KMlCDPnqx3GBDIVmy1BT/itZ
 QZn7zpCXGHlugSd4TLJJ6VkSNx/tbQlIx2aqVSu2G+FrdNMNBb/qAyLksPXMD183bW+k
 V2kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnCVQwXvV6a8QcgysVhaFfOOUO+Hvc4ZaA126BwY+Ua6QLsZZcJDx1drox/6/CJw9Fu67il0k=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/zvUvoEYQI+3oL/+Lm6PqKiF0S4QaQwL0uQ4XLUimXtk3PgWf
 gsIz42DZXZCvewUdHMuyKkWbq7H2R9xggPM7jJ2xMpp8DZ+DzjvGuSpKrQNMKVaYeAHHOjaAJSh
 Oh1v/t8QzDkzjR6TAMrxacFmvSsT/mAZYj80T
X-Google-Smtp-Source: AGHT+IGyyajfb6oy25KF9gWq7MDMq6dKJRUAswXoKCpfP0fAGRVmNpvJavLXG/lbXbt9S6LUWTDRBqEt/KkWKeyEJBw=
X-Received: by 2002:a17:907:9603:b0:a9e:b5d0:de6 with SMTP id
 a640c23a62f3a-a9ef0016d4emr1940979466b.50.1731505173787; Wed, 13 Nov 2024
 05:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20241112102644.37459-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241112102644.37459-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 06:39:22 -0700
Message-ID: <CAFLszTjvmy2a8G7jU7_xO-QfGoOBihqAHXZecrtHXm1qa5o9_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] configs: SiFive Unmatched: add 'nvme scan' to
 preboot
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, u-boot@lists.denx.de, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Tue, 12 Nov 2024 at 03:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Without 'nvme scan' the ESP on the NVMe drive is not found early.
> EFI variables cannot be persisted.
>
>     Hit any key to stop autoboot:  0
>     Cannot persist EFI variables without system partition
>     ** Booting bootflow '<NULL>' with efi_mgr
>     Loading Boot0000 'mmc 0' failed
>     EFI boot manager: Cannot load any image
>     Boot failed (err=-14)
>     scanning bus for devices...
>     ** Booting bootflow 'nvme#1.blk#1.bootdev.part_1' with efi
>     Booting /\EFI\BOOT\BOOTRISCV64.EFI
>     error: no suitable video mode found.
>     GNU GRUB  version 2.12
>
> With 'nmve scan' booting works as expected.
>
>     Hit any key to stop autoboot:  0
>     ** Booting bootflow '<NULL>' with efi_mgr
>     Loading Boot0000 'mmc 0' failed
>     Loading Boot0001 'nvme 0' failed
>     Booting: nvme 1
>     error: no suitable video mode found.
>     GNU GRUB  version 2.12
>
> Reported by Yuri Zaporozhets <yuriz@vodafonemail.de>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         mention board in subject
> ---
>  configs/sifive_unmatched_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
> index 058e5fab683..1ea744ffa80 100644
> --- a/configs/sifive_unmatched_defconfig
> +++ b/configs/sifive_unmatched_defconfig
> @@ -27,7 +27,7 @@ CONFIG_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x84000000
>  CONFIG_BOOTSTD_DEFAULTS=y
>  CONFIG_USE_PREBOOT=y
> -CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};"
> +CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};nvme scan"
>  CONFIG_DEFAULT_FDT_FILE="sifive/hifive-unmatched-a00.dtb"
>  CONFIG_SYS_CBSIZE=256
>  CONFIG_SYS_PBSIZE=276
> --
> 2.45.2
>

This is handled automatically by bootstd. It uses 'hunters' to scan
devices as it goes. So this scan would not be wanted unless the device
is booting from nvme.

It seems that bootmgr is very-much doing its own thing in U-Boot. Can
we make it run the hunters, instead, perhaps?

Regards,
Simon
