Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCC5C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 13:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BFB88410;
	Tue, 16 Apr 2024 15:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BZOU+Ube";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916EA88414; Tue, 16 Apr 2024 15:04:49 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD0028840B
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 15:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516d1c8dc79so5477487e87.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713272683; x=1713877483; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aQYN6l/v2W684LKy9iCf+pOUx0c31xn9I9mj8nu/+Gc=;
 b=BZOU+Ubeq8Xex6y839g2i66N3LZ2fIZDxdgLYCMivchN4tuoQcMufNvqhdoyid7v5G
 D9ZU33cBx9miE6uuKCQOoFJ1vVy+QzQkRcm288nltfqHpZv4/PvOyEk6Pw0j0UbcjD6e
 j6C1KiuYLJGBGWUuDtQvAa/KBpkq6KfasHYjk+kpDYbbp894y1Cvd4uTxW9xmsOy+smM
 wMhiCzt5FCAGyIkPN6O6+1aPBU6+P6KZ+x6MDl8jhFLeP7gCIwmROWS7QOXQDCHmNq0w
 ZL9H4zagtAKuSGcvuyFtfKL+OOfkW6GFZ5d3LdeOhB94WuyKUVqsqDhc3li9iKCF/pkf
 nh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713272683; x=1713877483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQYN6l/v2W684LKy9iCf+pOUx0c31xn9I9mj8nu/+Gc=;
 b=H2Vdq1/mw5XPrSfMTZ+AktZfolNKayOTZ6dIMybl1HPUVKZzePp18vdte8uTrpyecK
 qZklE5mmutUQ8C69nTB1qPMYH2ska2Oy9zz4pLaUqcHJ7d7NR8MVOhTNSrK1djRUacnr
 y5hI2swk+n7BJ2qSgxra41ee7MtqUy/BX/sxe2T7PhvUdmnTPzwEzRQtf5CdDS4EBLr1
 Ft7gp4E8oLFjx0MsnA+ebjtDTTy0lqJvI0RwyVO2iZAQxy8v0UyJthgjJLjAaXWxBug0
 RiDG837xaDviRRpH4MQPr5Vf/02wYrFRKtSOg7Ao5wYpYQMjhKiCO60NXpe0/zrBLO+a
 laqA==
X-Gm-Message-State: AOJu0YzPxuyQo9YzP/ZpPKRDDGAe7G4rjlnV6dw3FKUbArdKXugUiSG5
 PM2mTzwwUjtKRTbSspFfwQ7z6Sjxy14Nu3iruWMkemTQA2MN02fg7sxks4ydLZhBH6lxilKw9uc
 TUVAOonNV5VH3b0Sgw9sqL39/uuNNneZpJGCUYQ==
X-Google-Smtp-Source: AGHT+IFp01xipsU2i5Kpg8bmOJsdnbm8MxjdHDGBLVY8GAZfANjMIz20av4Zgtq5foexHxrTEeu/h8LL0wa8olc2z5E=
X-Received: by 2002:a19:e049:0:b0:516:a01c:87ca with SMTP id
 g9-20020a19e049000000b00516a01c87camr9789452lfj.12.1713272682970; Tue, 16 Apr
 2024 06:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <4ac3dca43448d6b6660c947cd7d50b1112cd235d.1713169203.git.michal.simek@amd.com>
In-Reply-To: <4ac3dca43448d6b6660c947cd7d50b1112cd235d.1713169203.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Apr 2024 16:04:06 +0300
Message-ID: <CAC_iWjKVdyEwTfw4wrdc3q9fRXoEg9ouEC0GHvBK=UPe1AAnnw@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Remove all default n options
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

On Mon, 15 Apr 2024 at 11:20, Michal Simek <michal.simek@amd.com> wrote:
>
> default n doesn't need to be specified. It is default option anyway.
> Similar changes have been done by commit 18370f14975c ("Kconfig: Remove all
> default n/no options").
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  boot/Kconfig | 1 -
>  cmd/Kconfig  | 2 --
>  2 files changed, 3 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 777e408e2438..bb61e8b24f1c 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -816,7 +816,6 @@ if MEASURED_BOOT
>
>         config MEASURE_IGNORE_LOG
>         bool "Ignore the existing event log"
> -       default n
>         help
>           On platforms that use an event log memory region that persists
>           through system resets and are the first stage bootloader, then
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 8eeb99eea5ed..6c8ad1b87e87 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -444,7 +444,6 @@ config CMD_ELF
>
>  config CMD_ELF_FDT_SETUP
>         bool "Flattened Device Tree setup in bootelf cmd"
> -       default n
>         depends on CMD_ELF
>         select LIB_LIBFDT
>         select LMB
> @@ -2573,7 +2572,6 @@ config CMD_CROS_EC
>  config CMD_SCMI
>         bool "Enable scmi command"
>         depends on SCMI_FIRMWARE
> -       default n
>         help
>           This command provides user interfaces to several SCMI (System
>           Control and Management Interface) protocols available on Arm
> --
> 2.44.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
