Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBDEE68144
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 08:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C3683981;
	Tue, 17 Feb 2026 09:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tev9+pE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8572A83981; Tue, 17 Feb 2026 09:19:12 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5918063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 09:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad62a294bso3768151d50.1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 00:19:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771316348; cv=none;
 d=google.com; s=arc-20240605;
 b=QN7VmIIVZ6v6fcahkirxVnkCH1WTl6kWVTqKD5cUYAVERFLP2F6wglpwWiCV81ecGG
 yaSHPxpOQOyef7ZBsTqqxzMlLap04MiYxN+cMZ2alyHL+NFHt5wKv3N6g0RvSI3Wrxn2
 +QXNw0tHxPoPMyVbKGcAfKLKyFn4rgk9jQwdAwg+lZrPBHXzHamFrJM+52umkKSLR/YF
 8byzdFPG/fA9T+xwbJpOmjxe0i7VDU8b/xXiRxGmO4irqWycMjXLPVsKmT/LGqQDPC4/
 oUXQxD/vcJxYKvSdp7AKsuQZXMx0ER0C0i2qxdDafcLCEzZIxYkGnNXKJwiYwmL943qf
 aVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BEeqx9gvH0GB0im+sfr567PKuQNBdX6+9MMg6uwFhxU=;
 fh=nmOET/bi3KC3q+E+bCnIhh/rBdfN5/u98oR220eDYfE=;
 b=HreXA+RLl0J6TgG4lO1+jFHtAgyQmWzZ0jHob0N1M5R2z6q5E/C2hX4z0e8BsG2VFw
 0aCRg6jTvSCjYlmUjsKS9RG+iGb2s3CeFEKphm4FqT85jf5iuL+okYTs61Jgza/FWVOd
 G39MP4ykATR2e2dG2BvyGM9kHC5WDUNDGT0WIe+ER6IcjqKv5nrnrV3kXG3Y6+BiG0fv
 Mhk/fZaSwPvURRZp86Uoyi+kmpusRio/OGd5IxlkGj1phljyFdcRHLLrjM+6x9iMmT41
 pAIVuuhC7KNrTzFc0Yx8uIFegkCN/yBn+FmwtzCD8HTcRx9QsyP+o+XgfXq+VAcmAKUK
 IUJg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771316348; x=1771921148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BEeqx9gvH0GB0im+sfr567PKuQNBdX6+9MMg6uwFhxU=;
 b=tev9+pE17fQwqfWq2qJlCThU/RhgjfS2QcFK1Cw5ryOKKkx8r5+fD+IdACpO/Uhmbv
 0Twgmj4KP6TYuQD/np6yqkmRP8nbd30w+wZ+HD20WLI4PpsAD/SudADkS9uBYputjFvp
 /GeWMXIZQKRdCfEgrRg7iRdxa/N2PExPn7J0bJ3KN57cfXee8oK5Y/riuK8guSqkeAqd
 o/MpJ6YnL5vzO/rDaLjNscjH7VW6S0j5yqSsWl3+UbxXTqQHgbNe9cFxw93aLXQt/ByZ
 jlXVabCwcwQ2nBfYqTBbhOUJ93flLX6Ltw1agmcdBpk80R+O+Xo+TzUdjQ7gjU4ttpoF
 MeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771316348; x=1771921148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEeqx9gvH0GB0im+sfr567PKuQNBdX6+9MMg6uwFhxU=;
 b=CUUwVToaORNQxRz2z48N90hemwP3ghtiBCjeDHxF/LMw5RtV70KoiTnRW5SP7OGngl
 nghmjekAWPyCT56ggPyLEJgNGShjdZnoSDEtMQI9ehZ+OGAmppeOMhdgmfdc3w4Ff4hI
 0q7iCFyqNgZqqDBoUvB84nlao6Qbul3TExh8tenJY6XtYzkn7GD/HSrmnAviYTHjH12s
 iLjCA8vD6rZbZsA5swYVGosae7+SK1R5bDfsp2SzxznYvXxzjhWW5plvldkX8EQisdqW
 4P1uYGUWBFZNmwYwA+NUN7I4odb9/GyKNeJzN0Qeqv4kM53PofP/yngmhNiUuGSe9ie2
 7ECg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgTwBHXlRUiC6QR7SrNqqDRtAOFAdqcG6Y2MD2J+wjy8xV5l66LXm6OptX/hvuF93aYjIPQ24=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6sh6VHaHAAHysKN8ClxFqu0qZR2IUNSNzoiqhI0eV64RbrqLA
 eJXw06xXV/T59hifwkfNYVkKKUuqXBX608zc3jxCGZlJkGd2wom2RzNsPpYrwx9rYKiYK/BOQ9H
 jfgXLwLnBAgdtKQqD3OGR8O52fGW+rXR9HlqJGxSaLw==
X-Gm-Gg: AZuq6aIxqCPB+ApLw5/MWkDlUoQlezjPvuvSxOlBdKkeGdcmNcxj0fp+h/H2v0dqJUg
 dOSxXTWnA9gYVQ6P792eV338B9shgVmTyiBdxEdzNISNwtOI4z25b3vQKvhTaa3xwvH5dXgkWo/
 m4n49szUtd/AcXaYpF81o7DraFmUjTa8SQzhXBnROIg4HyfK2ZG0fspLTcrd7piMP/te3S0v3bp
 sTs9M46TBL2u6ng/YPqJS2gcoZVtJbW8GcsHe410dbBJ0V4HPWFYuhLBYJ2crWJ9T+xZIQ3WpRr
 rctK5Wiqi8XoKhKsdQrnatRp7JInuIwcJ0G1kiRASoenw/hsnC4J58T0j4bCHD4zBrbT8Sp23UJ
 YOG5A2jO0G/mtE2fdd4DhrLQxMcV/sngetXNJe7FSueq70Fe5YiS2ow2cy/F5sH2STk3jaYI5xO
 /Av0818al4b+JTdH46y3Si2abnJjg6G7NhMucKm+Xan0ew1yWU9mdkXQeAywo5ohJw1K0Flu5ZY
 qTR69BPuP0G4WkoKKMZPPoYmg8cKznMgo3BQE0R8iahEwsne9CU+8+DvHGPKhXX86+tRWGVYFRL
 kx1hfecdEPzrdI/6SUSbyqqM0vKaTgtC076Tu74cSLC3
X-Received: by 2002:a05:690e:bca:b0:649:4947:23e3 with SMTP id
 956f58d0204a3-64c21aada29mr8052308d50.40.1771316347754; Tue, 17 Feb 2026
 00:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20260217074655.34137-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260217074655.34137-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Feb 2026 10:18:32 +0200
X-Gm-Features: AZwV_QjQCcYqR79Tg9_vEgToK9nkceXbCVoQYZ_w3kz3eGTawWjp6GMiQVD1LD8
Message-ID: <CAC_iWjKvGLUoR7-hD3LdgkYy5Oh2zR+g+P5ZtKnkpg-A_XvfaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: require at least 128 KiB of stack space
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

On Tue, 17 Feb 2026 at 09:47, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The UEFI specification requires at least 128 KiB stack space. Consider this
> value as a prerequisite for CONFIG_EFI_LOADER.
>
> Mention the requirement in the CONFIG_STACK_SPACE description and decribe
> that the UEFI sub-system uses CONFIG_STACK_SPACE when defining the memory
> map.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  Kconfig                | 8 +++++---
>  lib/efi_loader/Kconfig | 2 ++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Kconfig b/Kconfig
> index ce25ea24a60..99b3cd62526 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -615,9 +615,11 @@ config STACK_SIZE
>         default 0x4000 if ARCH_STM32
>         default 0x1000000
>         help
> -         Define Max stack size that can be used by U-Boot. This value is used
> -         by the UEFI sub-system. On some boards initrd_high is calculated as
> -         base stack pointer minus this stack size.
> +         Define Max stack size that can be used by U-Boot. The UEFI sub-system
> +         considers this value when setting up the memory map. The UEFI
> +         specification requires 128 KiB or more of available stack space. On
> +         some boards initrd_high is calculated as base stack pointer minus this
> +         stack size.
>
>  config SYS_MEM_TOP_HIDE
>         hex "Exclude some memory from U-Boot / OS information"
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13e44be1d06..450ffa61c0a 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -15,6 +15,8 @@ config EFI_LOADER
>         # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
>         depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
>         depends on !EFI_APP
> +       # The EFI specification requires 128 KiB or more of stack space
> +       depends on STACK_SIZE >= 0x20000

Won't this disable EFI for ARCH_STM32 devices? Those define the
default stack size as 0x4000.

Thanks
/Ilias
>         default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
>         select EFI
>         select CHARSET
> --
> 2.51.0
>
