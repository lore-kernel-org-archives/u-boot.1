Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEA6CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E0088CC1;
	Fri,  4 Oct 2024 08:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MRotpkw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B041988CEB; Fri,  4 Oct 2024 08:01:55 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93CD088A0E
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e0946f9a8eso1294482a91.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 23:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728021711; x=1728626511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dkVaI0+iB30LuLPbAMVZY+HLDfYGuLT9FtRZx6APA0c=;
 b=MRotpkw3nSyjQRdI7kHRYCeh+KzZDgH5BcSo+yYgE3MuSvfBygANc9Lrtr8mZVnpou
 2WJBtWWYZC56fLx750izt41h4dCmAqPthg7VvkwDKxgCapAVIkD1zbyV4MIRk56cZB3e
 XPcTFHsPEkBecqw9/qn7gIXDos+MssqfD7evH1Usw4h/UnYqONCJ9r/Q76ui+xmby+MK
 Kx0DSkvvmtDAXLHBopUiJX/O+fZHFY2+jEWO998fl6Ob9g06FgKvBw/QdlByD8ubfiYX
 0lyn/7GGm0JmIY3zwq6qFpKMkywTGY4Cq0xJXSINrZPeaGh1RfK/dpMhbaczap2/v4OZ
 hiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728021711; x=1728626511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dkVaI0+iB30LuLPbAMVZY+HLDfYGuLT9FtRZx6APA0c=;
 b=efhtpB2wVkZmtpCjyTP+fzHzs0DDgBeQz3zM9GLaDfW0GurUvXeh15a4jIex+II9WW
 PcberGfmXD3pwnUXjVVKxvQZMiTo3DEI6XsLuCVpGFcQ9OO0KiahmBf9ugRo/fSHpSLO
 KGLAFUoE/hY9KnOHHy8XCCV5n9TT1INXuKD7OE4Mmm4GJHygb4EHSgAzU/W/Vl6C7j4k
 J0AWHbreLsIQxxmTuSEYniZW4C6mtGYSIRMnnpW9xZVEjWyUeFmetr/h6TKWutDoX7BX
 5qkwztfPD9k2T1xEkFHgIColK76seXOY1GaJzbBLAfnXb6hKlC2J11CQlYJJN5Vy0KpP
 5jgw==
X-Gm-Message-State: AOJu0YwXVpW478AksjqG8gF7oOrNoK8YODsigEqaA81NQn8VzWnGTB0o
 yftxmCfDBKEUFb8qAFk79ylDNoAmaWXy4hUrLk9D4zi0eKc1V7TP3AbsTB9Wq590Uz8LGaJfFa+
 IOX8e82/YAGP+6lq2pg54K1Fy9q2dDfnhe/75/Q==
X-Google-Smtp-Source: AGHT+IEPtLFdAeXgsFsgZ3yhl9HmWFCdE8XqQo5rFbfRrxThgvLbhffBMNHzvD+Y0hqi0OaN+cXB8yarDinKPLvdvgA=
X-Received: by 2002:a17:90b:17c8:b0:2d1:c9c8:301c with SMTP id
 98e67ed59e1d1-2e1e631ef62mr1829698a91.29.1728021711028; Thu, 03 Oct 2024
 23:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <fe12e1f45985088649336fb032f4b724724a1f89.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <fe12e1f45985088649336fb032f4b724724a1f89.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 09:01:15 +0300
Message-ID: <CAC_iWj+mjqONzfNwNxneZVo8DO5gd5aYJJQ8e8eYv6AHhqPYvg@mail.gmail.com>
Subject: Re: [PATCH v11 27/29] configs: use syntax CONFIG_FOO=n in
 tools-only_defconfig
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

On Thu, 3 Oct 2024 at 18:47, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The tools-only defconfig causes troubles on MacOSX due to the default
> C compiler being Clang (LLVM) rather than GCC and more specifically
> due to [1]. Therefore replace "# CONFIG_FOO is not set" with the
> equivalent "CONFIG_FOO=n" using the following command:
>
>  $ sed -i -e 's/# \(CONFIG_[^ ]*\) is not set/\1=n/' \
>        configs/tools-only_defconfig
>
> This fixes the tools_only_macOS CI job on GitHub [2].
>
> [1] https://github.com/llvm/llvm-project/issues/78778
> [2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=9105&view=results
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>  configs/tools-only_defconfig | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
> index e00f2c48598..7511e30d709 100644
> --- a/configs/tools-only_defconfig
> +++ b/configs/tools-only_defconfig
> @@ -4,26 +4,26 @@ CONFIG_ENV_SIZE=0x2000
>  CONFIG_DEFAULT_DEVICE_TREE="sandbox"
>  CONFIG_SYS_LOAD_ADDR=0x0
>  CONFIG_PCI=y
> -# CONFIG_SANDBOX_SDL is not set
> +CONFIG_SANDBOX_SDL=n
>  CONFIG_ANDROID_BOOT_IMAGE=y
>  CONFIG_TIMESTAMP=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
> -# CONFIG_BOOTSTD_FULL is not set
> -# CONFIG_BOOTMETH_CROS is not set
> -# CONFIG_BOOTMETH_VBE is not set
> +CONFIG_BOOTSTD_FULL=n
> +CONFIG_BOOTMETH_CROS=n
> +CONFIG_BOOTMETH_VBE=n
>  CONFIG_USE_BOOTCOMMAND=y
>  CONFIG_BOOTCOMMAND="run distro_bootcmd"
> -# CONFIG_CMD_BOOTD is not set
> -# CONFIG_CMD_BOOTM is not set
> -# CONFIG_CMD_BOOTI is not set
> -# CONFIG_CMD_ELF is not set
> -# CONFIG_CMD_EXTENSION is not set
> -# CONFIG_CMD_DATE is not set
> +CONFIG_CMD_BOOTD=n
> +CONFIG_CMD_BOOTM=n
> +CONFIG_CMD_BOOTI=n
> +CONFIG_CMD_ELF=n
> +CONFIG_CMD_EXTENSION=n
> +CONFIG_CMD_DATE=n
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_NO_NET=y
> -# CONFIG_ACPIGEN is not set
> +CONFIG_ACPIGEN=n
>  CONFIG_AXI=y
>  CONFIG_AXI_SANDBOX=y
>  CONFIG_SANDBOX_GPIO=y
> @@ -32,9 +32,9 @@ CONFIG_DM_RTC=y
>  CONFIG_SOUND=y
>  CONFIG_SYSRESET=y
>  CONFIG_TIMER=y
> -# CONFIG_VIRTIO_MMIO is not set
> -# CONFIG_VIRTIO_PCI is not set
> -# CONFIG_VIRTIO_SANDBOX is not set
> -# CONFIG_GENERATE_ACPI_TABLE is not set
> -# CONFIG_EFI_LOADER is not set
> +CONFIG_VIRTIO_MMIO=n
> +CONFIG_VIRTIO_PCI=n
> +CONFIG_VIRTIO_SANDBOX=n
> +CONFIG_GENERATE_ACPI_TABLE=n
> +CONFIG_EFI_LOADER=n
>  CONFIG_TOOLS_MKEFICAPSULE=y
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
