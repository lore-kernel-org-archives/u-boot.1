Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550ABC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA6F88418;
	Tue, 28 May 2024 10:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UwgXBzxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75B088428; Tue, 28 May 2024 10:29:39 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5347588402
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8ecafd28cso402046b3a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716884976; x=1717489776; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=29VM3WZ8dmsUHbERM5GnF1ewc+RDYroCmJSXo7UPmBM=;
 b=UwgXBzxblQifJvex5Y7xpP2K1TZnxcKmiosz+DkegIV7CT6tK+UyNcXhov3bQ5ixuz
 fKaR0pKPSrMEPbIVrxegIH47bSGwHGqfq+zoMO7HrnhQqcmoApigZ3tS05c72aoWY4LS
 sEYZMuK6uNu+Dc8pY/j/Ag/5OfZLvYso5g7KnoLwPLGs+oVqt86uSPzgXnQKsFCngtxx
 qYQEq03J79PpaDTw5oJHXoZNBPF2zRMIx40ObHlPim4iCVhGOeA02HsMZPjOd43nxTcS
 DUryci6VA1ZvibTRW0EOI3o7OYq8WuKRzO09Hg/xNE+QG5RvEfzvaLjtHiX+22ri/3VW
 LNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716884976; x=1717489776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=29VM3WZ8dmsUHbERM5GnF1ewc+RDYroCmJSXo7UPmBM=;
 b=FRhGgWNADjKvfsiFeUDtTf6CRUbsfyPIUOf5x9Lpo/WKnTFXj/mQEZGxPORBJwp9hk
 qnrqTrHIkY4Cx2IJ4L7+x/SwVSNI+3h7Fu6CzVXUvZm+7Ij12YkM3cIAsR5SZTtTRz2/
 w+V6EBi6Tr3tbEYQPcp8NNer59amJPC7OFtp2lVeLWWzfQ4ly2y83JEfkhsYFgrBYaBj
 6kmvuLTQqE1vzyxQYqNqQryiCMbj7A4eXbswXPAUcT8ZORS9G+OnyMgvDkDGh9HM7yvI
 LHux8uS0+c4S1bNLeHQQ6S3TSrsNfMuI6Z/3kTrK6VYd27x7rX4J/NJMDxQNJL++1Bus
 iH2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIFRGAIHYxNfEDexLQjYwbye9q/Aj83skK/0xy49GmU9u04gcjfeclRPGGBmrMsa1yYjJIDZHojA8hY9DnXItM3rL4Vg==
X-Gm-Message-State: AOJu0YyOFfiRQrSpTywLDqVREYZkxOH18vWov57MsM2wJTgqXjEXNyiE
 L5djJfSz59BVQmdTzasfgg8g29jkQE/oL9GgU7inn4P+SQxS2oHbaC1w4cr6fB5XGumf8g94XIo
 4XYXIXnrZQgqsGxvbipcpwudFZdcyGlHAtvIMFw==
X-Google-Smtp-Source: AGHT+IE0h2tC3jlDR/sqeegxsj0oqN9cQaufT/YOvQRykAxZreT+hrrh4Wkk15zkKL4nWsjSGQpmfXPrMnLeS6QyBEU=
X-Received: by 2002:a05:6a00:f90:b0:6f0:c828:87ef with SMTP id
 d2e1a72fcca58-6f8f2a4a294mr13232642b3a.3.1716884975751; Tue, 28 May 2024
 01:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
 <20240527-b4-qcom-capsule-updates-v2-6-47583d7ad428@linaro.org>
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-6-47583d7ad428@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 11:28:59 +0300
Message-ID: <CAC_iWjKy+4Ch6HwymkV_HHpNsUsEtOv4XDfnCmgAhKvyA7ki_w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] mach-snapdragon: use SYSRESET_PSCI
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Mon, 27 May 2024 at 20:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Capsule updates depend on SYSRESET, which we currently don't select but
> instead use a custom reset_cpu() implementation which just calls
> psci_reset().
>
> Clean this up, drop our custom function and require PSCI reset.
>
> There are some Qualcomm platforms that either can or do run without PSCI
> support, but we didn't handle these properly before anyway.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig                 | 2 ++
>  arch/arm/mach-snapdragon/board.c | 5 -----
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 39ad03acd2e4..0d5161358e33 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1084,8 +1084,10 @@ config ARCH_SNAPDRAGON
>         select OF_CONTROL
>         select OF_SEPARATE
>         select SMEM
>         select SPMI
> +       select SYSRESET
> +       select SYSRESET_PSCI
>         select BOARD_LATE_INIT
>         select OF_BOARD
>         select SAVE_PREV_BL_FDT_ADDR
>         select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index c4a3394706e6..b0d9a65bb8f5 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -106,13 +106,8 @@ void *board_fdt_blob_setup(int *err)
>
>         return (void *)fdt;
>  }
>
> -void reset_cpu(void)
> -{
> -       psci_system_reset();
> -}
> -
>  /*
>   * Some Qualcomm boards require GPIO configuration when switching USB modes.
>   * Support setting this configuration via pinctrl state.
>   */
>
> --
> 2.45.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
