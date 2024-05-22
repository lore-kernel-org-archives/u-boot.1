Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBBEC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 18:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A51E881A9;
	Wed, 22 May 2024 20:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nj13SfYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B478811D; Wed, 22 May 2024 20:20:31 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 946378836D
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 20:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51fdc9af005so10244737e87.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716402029; x=1717006829; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x4t8/gg2a9DXDfpbecqUlkasGncVak8+nqGk1peGtDk=;
 b=nj13SfYLPW7+Ld9vNNv/Hfq5IiZe+I8ORhdO9w6bAuZ4YgB84IXi5FBq0wkqDO4Tmv
 PchHgSC6oxANvXfYStq5X3I5jvfnijY9WYA9umoI1SAmU8KpK78qJnkhXttIRPTpBEr5
 d/xmyGRACmN9PqNUCG2ZGL9cIDeYV3dDa4lTka8V1TQs4qa1Sh/vlWlxHd6qkXJ2EsaM
 dQqzz9oZoB3XRsaCxbeOIHp3jcyt4cT/C7xaA/dpjmG1h7k1LEqWgbWpSOwXrPrOWUS9
 yN0wOLx4jtxYXp66BlH2j/WbtIbKPrvD6uC4GG6jkG6No/Q9miwWseUhDYg059bVsG5+
 8j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716402029; x=1717006829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x4t8/gg2a9DXDfpbecqUlkasGncVak8+nqGk1peGtDk=;
 b=ta9L7n/q4q9m37uF3Y5izUcK75lSMv1E6GYgu0xycioM24cuxye2BbDyM22l7JmW79
 ryCKUpGWABoAkgVfwRErdkk4HkRZAmeJxlQR24vqhP34gPIVmVQBC2gKpXDafg433CHV
 pCQSbUnYjdrAmn7+aX2DyB1SN449qe349u1ROrFfr0BjvvOQcPwjqWuqTUI+jeaV88eY
 l8LIlgRJIs4aoSfGxrNwObPbCrtxxw/Gl10puCcZc6bipK3gLsosnpU18kieMnkmGack
 mJHUU8Qf3IgPXMAqsUKUEj4NZBMFN8RUEl3BeN177viVAoxFAzz2s+6hmOnnfaxpOFpc
 1Mfg==
X-Gm-Message-State: AOJu0Yw9Jb6xhJQLk0jAyZ2J3C00J+rUIFkIJC5FWY64a8vHjvoHs+eo
 tOxQFXgmkvzgayps39i93yGKcGNWJ7FrsB19tQ4MHxHgRDVaTYmyB6Pi4jvR1OGjGk7Rx6NjYXD
 u4cAff8kSBQ3WE41OgdGK6M/B1Y0mwjwnYDIkNw==
X-Google-Smtp-Source: AGHT+IENYlXiQwFdECQNYy+vAsrLwBeoBLTg97WBZyq9vCdUGEWMOusdbDEdhBDiltbCJcz5ToJGnFRyK3OKj6GizzQ=
X-Received: by 2002:a05:6512:b93:b0:51d:4383:9e59 with SMTP id
 2adb3069b0e04-526bbea2410mr2849262e87.0.1716402028866; Wed, 22 May 2024
 11:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <6c98b28ebe3d2371cc1c62c531ae6115bc93c09e.1716393035.git.jerome.forissier@linaro.org>
In-Reply-To: <6c98b28ebe3d2371cc1c62c531ae6115bc93c09e.1716393035.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 May 2024 21:19:53 +0300
Message-ID: <CAC_iWjK6=npC2_BdrAEbXWovqbdmcXm65Xs7avh8tq85dc3SRA@mail.gmail.com>
Subject: Re: [PATCH 09/15] net-lwip: add support for EFI_HTTP_BOOT
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Jerome,

On Wed, 22 May 2024 at 19:04, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Implement the wget_with_dns() function which is needed by
> CONFIG_EFI_HTTP_BOOT=y. Note that there is no dependency added on
> CONFIG_CMD_DNS_LWIP because CONFIG_CMD_WGET_LWIP natively supports
> hostname resolution.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  lib/efi_loader/Kconfig |  5 +++--
>  net-lwip/wget.c        | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 430bb7f0f7..9d8dc8c756 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -505,8 +505,9 @@ config EFI_RISCV_BOOT_PROTOCOL
>
>  config EFI_HTTP_BOOT
>         bool "EFI HTTP Boot support"
> -       select CMD_DNS
> -       select CMD_WGET
> +       select CMD_DNS if NET
> +       select CMD_WGET if NET
> +       select CMD_WGET_LWIP if NET_LWIP
>         select BLKMAP
>         help
>           Enabling this option adds EFI HTTP Boot support. It allows to
> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
> index 0ed8b77c47..a3e65dc80e 100644
> --- a/net-lwip/wget.c
> +++ b/net-lwip/wget.c
> @@ -166,3 +166,19 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>
>         return CMD_RET_FAILURE;
>  }
> +
> +#if defined(CONFIG_EFI_HTTP_BOOT)
> +int wget_with_dns(ulong dst_addr, char *uri)
> +{
> +       char addr_str[11];
> +       struct cmd_tbl cmdtp = {};
> +       char *argv[] = { "wget", addr_str, uri };
> +
> +       snprintf(addr_str, sizeof(addr_str), "0x%lx", dst_addr);
> +
> +       if (do_wget(&cmdtp, 0, ARRAY_SIZE(argv), argv) == CMD_RET_SUCCESS)
> +               return 0;
> +

Calling a command directly feels a bit weird.
Can we do this instead:
- Split do_wget in patch #7 and carve out 2 functions. The first will
prepare the arguments and the second will call httpc_get_file_dns()
and run the loop
- Once that's split you can use the newly split function here and
avoid calling a command

Thanks
/Ilias
> +       return -1;
> +}
> +#endif
> --
> 2.40.1
>
