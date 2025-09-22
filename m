Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21864CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 09:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7F683280;
	Mon, 22 Sep 2025 11:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SgzH5rRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA240832F9; Mon, 22 Sep 2025 11:12:21 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C61D83211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 11:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-62fbc90e6f6so4913335a12.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 02:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758532335; x=1759137135; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aD3isQrfnPJYf15zaRzSOLwt3ulMzWN0KVOYQ8r0/+0=;
 b=SgzH5rRQSPemIi+Si+fEjSsvPYysJrHWFSZFZYHB/fCFkCIm4li6QIwmjuvpQcl1EB
 A7fdJsNjJSXjRiYSF4B4QJq3magKlz5O/tTWxVfMjaU6RrA9ec+aK2/5ewCDXoEYOjq1
 l30N9QcBH9LZr7HcqpVbd7hWjsvHtdfWb++xftCQ7NfbwPsrJOUoT4TiXocQCemlEymR
 UVPUCifrEvY1WIN+W+iihk/j8PnDgjvSN2i8xdVYp4EbhLz9F0PKVNVQzm9ih8KmCk04
 /jfI1Crh7O7ow9Lkwwdi31eMxHsuhKQWq7bjkbsPSXDBST92QcGY8xfUDLfvDfzjdC87
 0QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758532335; x=1759137135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aD3isQrfnPJYf15zaRzSOLwt3ulMzWN0KVOYQ8r0/+0=;
 b=wHJpxtVtL4+8rR3S6LLAO7gqnsslzQq1mcXgcISfd9CuV0JdG0XDIpCZeGLLsVP0td
 gRrpgoPgF6tIMOBNZ9fRnTjw6LVfp/Hw+dkuuW0NmSr8UNrY1tNI2vSJXAZIrwilmqTB
 Emiwp7WSc6T9nPDmWnPpCQuSj46UP+Q6JKy1gC0U/xmudhikQKolTdFJ6/TiF+DpyxuD
 PxVOf/IJtXeI/74eSmhIaLkGobFD5YCotvo5TP9r6E20yoYmmzEN8KwY/a1ISULikVrl
 0OoZjhWk5MENPAeysrmUeQoh8aj4Q0ye8c6PO7vMA7XHHtZkvs8YaqWE6/oWm8jiwzv7
 ba0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV36oXrG8M5jkl2mJF1BpOQLpvBBk/fOXDG96tE+P/OyIoGmdWazihI5BpDO17YqOH8yM98dqI=@lists.denx.de
X-Gm-Message-State: AOJu0YxafGsIhgoSTkScPxAiJQA5keofclgj4PtCgRDpntFfZlo0DfPW
 2I/G9XITh43me5MvC0rqXTfKZ04L3HxgdqRXShFsIUDdmoH+ZfMZJz0ASj8AdM/ty+Y6C/5uIsU
 uliAiXdSHjWhFOL+PqHvw58EoBFQhF98=
X-Gm-Gg: ASbGncsMU6Aqh2lGnEZfZmP2lOdMdDAStr36rm5Wo5Aru3VQiI1wE8RvkXJXDoGp95l
 35/3qFCM/XCSKUNQ/0BkQpgqDK3fIzjPpF0KyIcfUSEGUSa702rZLdNRlCDCuFnUuLCCstFowNh
 LkbQLMdGX5G4DwAXs6a+glJJfL9oWR8vJX3jxETGxToogHsZ7NW09iV9MRg/ZmXuHLvHpIAny/T
 oWKtY0F
X-Google-Smtp-Source: AGHT+IGapxUmK6UJ6u1C30e97XtZvJTErM+K+Ull5kN7UWypE2yw3cV8VBqY3skD9/2ciASPjyt0juGzlfKib3Xhy7s=
X-Received: by 2002:a05:6402:23db:b0:62f:7760:f90c with SMTP id
 4fb4d7f45d1cf-62fc0a7b88cmr9906153a12.31.1758532334553; Mon, 22 Sep 2025
 02:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250921174312.154990-1-clamor95@gmail.com>
 <20250921174312.154990-2-clamor95@gmail.com>
In-Reply-To: <20250921174312.154990-2-clamor95@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 22 Sep 2025 10:12:03 +0100
X-Gm-Features: AS18NWC7TO7boeV4pJJGn1971QZBt1MWuJ97DWkrE5lNr1xE6tNIlcP-lhI-fZY
Message-ID: <CALeDE9O9ADznKVav69BdjS2D-cm1-dHZT38ECQQGvh0raU=F9Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] configs: tegra: remove ATAGS support
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sun, 21 Sept 2025 at 18:43, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Remove support for ATAGS-based OS booting. ATAGS are used for booting
> older Linux kernel versions and we are moving away from using those.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Looks good to me.

> ---
>  configs/chagall_defconfig         | 3 ---
>  configs/endeavoru_defconfig       | 3 ---
>  configs/grouper_defconfig         | 3 ---
>  configs/ideapad-yoga-11_defconfig | 3 ---
>  configs/mocha_defconfig           | 3 ---
>  configs/mot_defconfig             | 3 ---
>  configs/n1_defconfig              | 3 ---
>  configs/ouya_defconfig            | 3 ---
>  configs/picasso_defconfig         | 3 ---
>  configs/qc750_defconfig           | 3 ---
>  configs/star_defconfig            | 3 ---
>  configs/surface-2_defconfig       | 3 ---
>  configs/surface-rt_defconfig      | 3 ---
>  configs/tegratab_defconfig        | 3 ---
>  configs/tf701t_defconfig          | 3 ---
>  configs/transformer_t20_defconfig | 3 ---
>  configs/transformer_t30_defconfig | 3 ---
>  configs/x3_t30_defconfig          | 3 ---
>  18 files changed, 54 deletions(-)
>
> diff --git a/configs/chagall_defconfig b/configs/chagall_defconfig
> index 3acb7d53727..1688b4c4d07 100644
> --- a/configs/chagall_defconfig
> +++ b/configs/chagall_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="chagall"
> diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
> index 804b00697a1..165c0996038 100644
> --- a/configs/endeavoru_defconfig
> +++ b/configs/endeavoru_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="endeavoru"
> diff --git a/configs/grouper_defconfig b/configs/grouper_defconfig
> index b9068e18b03..b6c9550bbbc 100644
> --- a/configs/grouper_defconfig
> +++ b/configs/grouper_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="grouper"
> diff --git a/configs/ideapad-yoga-11_defconfig b/configs/ideapad-yoga-11_defconfig
> index d5befae419d..68ca8333019 100644
> --- a/configs/ideapad-yoga-11_defconfig
> +++ b/configs/ideapad-yoga-11_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="ideapad-yoga-11"
> diff --git a/configs/mocha_defconfig b/configs/mocha_defconfig
> index ab8cea69a02..ded43ccea58 100644
> --- a/configs/mocha_defconfig
> +++ b/configs/mocha_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_SYS_MALLOC_LEN=0x2500000
>  CONFIG_NR_DRAM_BANKS=2
> diff --git a/configs/mot_defconfig b/configs/mot_defconfig
> index dc6549cba76..f6066b9e149 100644
> --- a/configs/mot_defconfig
> +++ b/configs/mot_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x00110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="mot"
> diff --git a/configs/n1_defconfig b/configs/n1_defconfig
> index 9bba6db99b5..1940a2208a9 100644
> --- a/configs/n1_defconfig
> +++ b/configs/n1_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x00110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="n1"
> diff --git a/configs/ouya_defconfig b/configs/ouya_defconfig
> index 60cc3796c5e..e82f65a9a86 100644
> --- a/configs/ouya_defconfig
> +++ b/configs/ouya_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="ouya"
> diff --git a/configs/picasso_defconfig b/configs/picasso_defconfig
> index f5c6619a271..9d153694245 100644
> --- a/configs/picasso_defconfig
> +++ b/configs/picasso_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x00110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="picasso"
> diff --git a/configs/qc750_defconfig b/configs/qc750_defconfig
> index 3f85890bdbd..2be3838ae60 100644
> --- a/configs/qc750_defconfig
> +++ b/configs/qc750_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="qc750"
> diff --git a/configs/star_defconfig b/configs/star_defconfig
> index 38cbdec1c3a..59eabdcb2b4 100644
> --- a/configs/star_defconfig
> +++ b/configs/star_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x00110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="star"
> diff --git a/configs/surface-2_defconfig b/configs/surface-2_defconfig
> index 6e287539f53..d3e6166cf89 100644
> --- a/configs/surface-2_defconfig
> +++ b/configs/surface-2_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_SYS_MALLOC_LEN=0x2500000
>  CONFIG_NR_DRAM_BANKS=2
> diff --git a/configs/surface-rt_defconfig b/configs/surface-rt_defconfig
> index 4cd543ccb9c..88b67749095 100644
> --- a/configs/surface-rt_defconfig
> +++ b/configs/surface-rt_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="surface-rt"
> diff --git a/configs/tegratab_defconfig b/configs/tegratab_defconfig
> index 00a0843d4d0..27cb75c92b5 100644
> --- a/configs/tegratab_defconfig
> +++ b/configs/tegratab_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_SYS_MALLOC_LEN=0x2500000
>  CONFIG_NR_DRAM_BANKS=2
> diff --git a/configs/tf701t_defconfig b/configs/tf701t_defconfig
> index a9976bf0388..e8f920587c3 100644
> --- a/configs/tf701t_defconfig
> +++ b/configs/tf701t_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_SYS_MALLOC_LEN=0x2500000
>  CONFIG_NR_DRAM_BANKS=2
> diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
> index c0a5a2fd02c..61eab59fa3b 100644
> --- a/configs/transformer_t20_defconfig
> +++ b/configs/transformer_t20_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x00110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="transformer-t20"
> diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
> index eb3e41e68c5..6f8953aa103 100644
> --- a/configs/transformer_t30_defconfig
> +++ b/configs/transformer_t30_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SOURCE_FILE="transformer-t30"
> diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
> index 3081d1203cf..82fff349210 100644
> --- a/configs/x3_t30_defconfig
> +++ b/configs/x3_t30_defconfig
> @@ -1,8 +1,5 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_TEGRA=y
> -CONFIG_SUPPORT_PASSING_ATAGS=y
> -CONFIG_CMDLINE_TAG=y
> -CONFIG_INITRD_TAG=y
>  CONFIG_TEXT_BASE=0x80110000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_ENV_SIZE=0x3000
> --
> 2.48.1
>
