Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92216C46CCD
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B6D87E39;
	Mon, 18 Dec 2023 16:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dHM+RChJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2146887E0A; Mon, 18 Dec 2023 16:02:47 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6505987E37
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dbd4608121fso359873276.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=juYM4HsBAk2fy1jHONRBYzW9qe+khotBjYUfJZORppQ=;
 b=dHM+RChJf9h/TkkVsPpEjTAvd/v+aenoZ99i4M6GD7X+VKrVejfnm9D/+LlQRZ1qev
 lUZhNGyyMCEMUM5YfPsaHrLgq2NauiXIeFgyzVfpUqXdOzDlypKyNnalTjTK2UiNFlSf
 UnfBD5xF2uS8ub316URuqucQlKDDIwGQiTSPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=juYM4HsBAk2fy1jHONRBYzW9qe+khotBjYUfJZORppQ=;
 b=q90cHawEpXuxr9NGqDziMbZU53GhQaFIK6hsUDZ4IJ/1IMZD8TCVlSyZK/RevXSJow
 s81dQo2g+lZ9PYw6t8idHHbndktU3NvYE/w8T5q/y4K/7f8SpGKG1/KntUSzVKGin02C
 dW6tLDXbMK4BSKIvbWaoOZy7ZpCZvyGiIziRkDeExrAjkHDRttKCUmFCWtPlqYBb9EHO
 Q9zkk2TG7y9Hdl3k10LAeSV0UROwHHGZ+mkDVmnukZP1zLwqmA7CDWjyam+dN0ifp3n0
 IxZMWdvRb6jHekGrU2YJ1EQ/VDvp5wipyFIKrzNKoGDAqlgPtlqGWRo1O89IZ/QQoyty
 nL7Q==
X-Gm-Message-State: AOJu0YxudgdS8P5DKQ8+b8+XVpxPEGrZVI2FseywxNFgo+jQ1uZPkzyN
 C6l2NAm3z7skRYzTzL8+pKDIfEsT6+SPWM2G4wMgYQ==
X-Google-Smtp-Source: AGHT+IFN+CK60CwS4LXUtrhsNBgdUe3RZVgxSDZfYKpnV6E++dajDdM0QJVT+UClJ0HGiQjZdvR2JNlKCGqWg3pULTk=
X-Received: by 2002:a25:2e08:0:b0:dbc:f196:eadd with SMTP id
 u8-20020a252e08000000b00dbcf196eaddmr2998116ybu.16.1702911752786; Mon, 18 Dec
 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
In-Reply-To: <20231218072428.1802969-1-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:47 -0700
Message-ID: <CAPnjgZ2rYujD-yb=Zgz=bxe8iS3MGSdrL9KfVsDqz8R_H+FVfA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add SE HMBSC board support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 lukma@denx.de, seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com, 
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com, 
 benjamin.missey@non.se.com, daniel.thompson@linaro.org
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

Hi Sumit,

On Mon, 18 Dec 2023 at 00:24, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> SE HMIBSC board is based on Qcom APQ8016 SoC. One of the major

Could you please add a doc/ file for this board and explain how to
build it and how to run U-Boot on it?

> difference from db410c is serial port where HMIBSC board uses UART1 as
> the debug console with an RS232 port, patch #1 - #3 adds corresponding
> driver support.
>
> Patch #4 adds main HMIBSC board specific bits, features:
> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> - 2GiB RAM
> - 64GiB eMMC, SD slot
> - WiFi and Bluetooth
> - 2x Host, 1x Device USB port
> - HDMI
> - Discrete TPM2 chip over SPI
>
> Patch #5 - #7 enables specific board features like RAUC support,
> environment protection and USB networking support.
>
> This patch series is based on top of Qcom maintainer tree [1] + the latest
> PMIC patch-set [2]. Feedback is very much welcome.
>
> [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/u-boot-qcom-next?ref_type=heads
> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=385322
>
> Sumit Garg (7):
>   clk: apq8016: Add support for UART1 clocks
>   serial_msm: Add support for RS232 GPIOs
>   serial_msm: Enable RS232 flow control
>   board: Add SE HMIBSC board support
>   hmibsc: Enable RAUC support
>   hmibsc: enable U-Boot Environment variables protection
>   hmibsc: Enable LAN75XX USB ethernet driver
>
>  arch/arm/dts/Makefile              |   1 +
>  arch/arm/dts/hmibsc-uboot.dtsi     |  43 +++++++
>  arch/arm/dts/hmibsc.dts            | 188 +++++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/Kconfig   |  18 +++
>  arch/arm/mach-snapdragon/Makefile  |   1 +
>  board/schneider/hmibsc/Kconfig     |  15 +++
>  board/schneider/hmibsc/MAINTAINERS |   6 +
>  board/schneider/hmibsc/Makefile    |   5 +
>  board/schneider/hmibsc/hmibsc.c    | 179 +++++++++++++++++++++++++++
>  board/schneider/hmibsc/hmibsc.env  |  11 ++
>  configs/hmibsc_defconfig           |  79 ++++++++++++
>  drivers/clk/qcom/clock-apq8016.c   |  44 ++++++-
>  drivers/serial/serial_msm.c        |  23 +++-
>  drivers/usb/host/Kconfig           |   1 +
>  include/configs/hmibsc.h           |  59 +++++++++
>  15 files changed, 665 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/dts/hmibsc-uboot.dtsi
>  create mode 100644 arch/arm/dts/hmibsc.dts
>  create mode 100644 board/schneider/hmibsc/Kconfig
>  create mode 100644 board/schneider/hmibsc/MAINTAINERS
>  create mode 100644 board/schneider/hmibsc/Makefile
>  create mode 100644 board/schneider/hmibsc/hmibsc.c
>  create mode 100644 board/schneider/hmibsc/hmibsc.env
>  create mode 100644 configs/hmibsc_defconfig
>  create mode 100644 include/configs/hmibsc.h
>
> --
> 2.34.1
>

Regards,
Simon
