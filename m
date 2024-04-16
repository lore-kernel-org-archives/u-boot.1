Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97701C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 13:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0383D88410;
	Tue, 16 Apr 2024 15:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AyLUg7jP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1D188414; Tue, 16 Apr 2024 15:01:51 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 070208840B
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 15:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-343d2b20c4bso3312692f8f.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713272504; x=1713877304;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/+E3ijC7n5yWPG+T7d+ZmujyjcZz1BJnhkYXgOIT6Vg=;
 b=AyLUg7jPKgz2b3DredXnpfmqTmgiX/82wPu2wZNQDkEvBXGRhFqi9jKQDfl8FxqMlu
 hLsuT8WRNokswt50IvgVxwgk/6g3KGs5J1itSZcb2OWwE3nAxVM+h9ZWnbviSkqa57ys
 U6MzEQhyW2c4KerQxPuIRpwNXKaiS+bqa3q+IYNZZlAxc6qiP/s7xJ6KLVGtv+FlaV5v
 vOvcqSP9GapCPzBF6FfrEVg9X0enOzhSoQrLhzZD+mc+bijjO9qQb0w4H70vB+URIufI
 YVdz40W1c5BUhFECLWFqyzDKc45iUExdTGFz1cFQhVUymjM0A5i9oDjAei6GxmNaUIR7
 a1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713272504; x=1713877304;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+E3ijC7n5yWPG+T7d+ZmujyjcZz1BJnhkYXgOIT6Vg=;
 b=PNaHODq1I1A3o06hzQFG6PHSWk7Nn8DRz9UV8c6yxwUi1iJg1xXPr9AALs2SXz+nb9
 SEfWXCqmhrggGeA5yTVc8nmg++bKjJs+H05XphxRymEgskMqUdcxxxkax8de9bNX+K1F
 4Khqp8lpRQv5JSs6hqGM/xfrzkgQ6aejjP8blTijk2ZquHtdqZaEcxqd0fKjMJ+hZuEc
 2ufn0EVWJLuwM+uuRSurFd7Eaoaw62M5ZYrRR+AOe0dJqr1v/hSvdBtQEm5PYnEhVneU
 mW8mcitL82tl8UeSqCbSclMoNT4gWt+fkCigmsaBJHijux3XfT8qLi2btPNhl0w7a8ap
 vPIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbV1X2IbpC2hyV8PPZFqTrXKc0tItnADbILlmPGvbe6REyZQ137qNGm7DHSM3bOghhVBb02Jxw3j0dv/k89SkaCeiGaQ==
X-Gm-Message-State: AOJu0YzzEo6xm1xR0mOC38NXpTzgSXS9iK+ntLju0i/vISViSvExSNbt
 gecVCqbnpje4URsSn3ggNpnOhHKjPFnGzRZOwYPM6/mfJbMqWedNEnPth5gUfh4=
X-Google-Smtp-Source: AGHT+IFiLKjiLK39SxumEz/TSSgvC6ftCDCvDYfccPXwziS06qrCZbQOM7sHJkZoiSGQRmWUJlkhLg==
X-Received: by 2002:adf:db48:0:b0:345:e409:7be2 with SMTP id
 f8-20020adfdb48000000b00345e4097be2mr9642033wrj.45.1713272504344; 
 Tue, 16 Apr 2024 06:01:44 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 dp4-20020a0560000c8400b00343ca138924sm14718695wrb.39.2024.04.16.06.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 06:01:43 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Bin Meng <bmeng.cn@gmail.com>, Eddie James
 <eajames@linux.ibm.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, Sean
 Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] Kconfig: Remove all default n options
In-Reply-To: <4ac3dca43448d6b6660c947cd7d50b1112cd235d.1713169203.git.michal.simek@amd.com>
References: <4ac3dca43448d6b6660c947cd7d50b1112cd235d.1713169203.git.michal.simek@amd.com>
Date: Tue, 16 Apr 2024 15:01:41 +0200
Message-ID: <87a5lt4g22.fsf@baylibre.com>
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

Hi Michal,

Thank you for the patch.

On lun., avril 15, 2024 at 10:20, Michal Simek <michal.simek@amd.com> wrote:

> default n doesn't need to be specified. It is default option anyway.
> Similar changes have been done by commit 18370f14975c ("Kconfig: Remove all
> default n/no options").
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

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
>  	config MEASURE_IGNORE_LOG
>  	bool "Ignore the existing event log"
> -	default n
>  	help
>  	  On platforms that use an event log memory region that persists
>  	  through system resets and are the first stage bootloader, then
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 8eeb99eea5ed..6c8ad1b87e87 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -444,7 +444,6 @@ config CMD_ELF
>  
>  config CMD_ELF_FDT_SETUP
>  	bool "Flattened Device Tree setup in bootelf cmd"
> -	default n
>  	depends on CMD_ELF
>  	select LIB_LIBFDT
>  	select LMB
> @@ -2573,7 +2572,6 @@ config CMD_CROS_EC
>  config CMD_SCMI
>  	bool "Enable scmi command"
>  	depends on SCMI_FIRMWARE
> -	default n
>  	help
>  	  This command provides user interfaces to several SCMI (System
>  	  Control and Management Interface) protocols available on Arm
> -- 
> 2.44.0
