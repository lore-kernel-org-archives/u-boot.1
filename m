Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F35AECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 07:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B490688EEC;
	Tue, 10 Sep 2024 09:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lvm6RtpF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0960D88EBC; Tue, 10 Sep 2024 09:29:44 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6771F88EEC
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 09:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c3c3b63135so5553912a12.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725953381; x=1726558181; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bVQiExnsLojJ7gwq3QdoNqa/rFTdqPc3JyK8G8fa1nI=;
 b=Lvm6RtpF/Qn4PkAlgcQns7KQcpgBfiMD0nlhS9UVK6o/nfhJeWYJbcg0+zrjn4Llkb
 pXLHmF5LlephMP42DMa6m3b4iWpBLlmt8LtUwVoLskbRJmE9XFbPLunuqcjUqbkW8HDm
 oRNmHhvRmBmU97zvAi66LyqYSSahP0WFydIbX0osirJj/7HFREusqBlgqolmJ4CaVir+
 ZYCmn5+PwRJgD7d/mPaA0zUqnH8g1mKkZPrVDxanAO0Xb0vxRt5B2/8TeQKzkDG4d0zP
 WICUblmhFA02Sul8eiV0BR+5eZSWnxOLWqy3q8CsXi/K/OiBnbxXwgkncyEPAHmLIdbC
 HdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725953381; x=1726558181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVQiExnsLojJ7gwq3QdoNqa/rFTdqPc3JyK8G8fa1nI=;
 b=fe5vUDqEDBsYqKjpTPloa3z2jQn8u7YNsSjDKxHomk7QfGhDykccVFKCl3cFySwEpz
 YQ4OYXEC/STLNoNQAXDmRwW/N1exsrj0cc04GPECXTUaY7jlczOdQc+xMeqIc8GxarBh
 TJ7eCGC+vyt38B+asi1Yojyi2EAsXWA3S265x5StjISGPhBZBFc5hvTioZY4utoHIUAf
 ZL4Li/oSmMazbVSLi95mwgYL2/aZXbq3yqpMhmJwCERQrTsygD29/bzwxHbToW8BqR7U
 YIflhOuH5nwwvRhopcdfEhM2NIJrVugBSW2g4tmxexEpprbyTVU+Pqr4Lee9wu0MOT5o
 Vfaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYUXwqONasmYFhzQS/dT6/1cf7Kyh1X5DnxkJmqKwJUts+7Pj0D8lqjfhnBHc8H9UYtZwnkmI=@lists.denx.de
X-Gm-Message-State: AOJu0YwklzUIKg2DkGjLEAR3WdHxGXt5TKmZcMpMLfGV96h6lD83e2DA
 CV10bY1vzAyU5dqxI+EIuKQsmbEbrBoikVSO6ZPQxjt0j6UFL23UWA/af0/k/0w0g0xd44JJZ3C
 hLZxlHQuTFVLKm8HIZl9pCvND1AhF43Ds7kgGHQ==
X-Google-Smtp-Source: AGHT+IHBxpUwZAnV20+9+PjMkpFF8XMHK6JVZnrqPiqu9oZdNRh8WIfJKytN92Y640lwRiQ04KWGPTvIBV3HRkUTx78=
X-Received: by 2002:a05:6402:5193:b0:5c3:c520:b019 with SMTP id
 4fb4d7f45d1cf-5c3dc7c7154mr9979736a12.34.1725953380584; Tue, 10 Sep 2024
 00:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 10 Sep 2024 12:59:29 +0530
Message-ID: <CADg8p94ZnxVCc0VJ9hkAQ1Ka2Y9=Yt995KisJpFDXboMMfT3Yw@mail.gmail.com>
Subject: Re: [PATCH] board: rpi: Enable capsule updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: pbrobinson@gmail.com, mbrugger@suse.com, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>, "Ivan T. Ivanov" <iivanov@suse.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
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

On Tue, 10 Sept 2024 at 12:09, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Since RPI works well using EFI and has no size limitations with regards
> to U-Boot, add the needed structures and Kconfig options needed to
> enable capsule updates
> ---
>  board/raspberrypi/rpi/rpi.c | 22 ++++++++++++++++++++++
>  configs/rpi_4_defconfig     |  2 ++
>  2 files changed, 24 insertions(+)

Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>

A couple of nits below.

>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index ab5ea85cf9f8..1f342eee12b2 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -63,6 +63,28 @@ struct msg_get_clock_rate {
>         u32 end_tag;
>  };
>
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .fw_name = u"RPI_UBOOT",
> +               .image_index = 1,
> +       },
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = "mmc 0=u-boot.bin fat 0 1",
> +       .num_images = ARRAY_SIZE(fw_images),
> +       .images = fw_images,
> +};
> +
> +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> +void set_dfu_alt_info(char *interface, char *devstr)
> +{
> +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +               env_set("dfu_alt_info", update_info.dfu_string);
> +}
> +#endif

Is this really needed? We have a weak function in efi_firrmware.c
which is doing exactly this.

> +
> +
>  #ifdef CONFIG_ARM64
>  #define DTB_DIR "broadcom/"
>  #else
> diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> index f5fb322aa8fc..c70414e6fcaf 100644
> --- a/configs/rpi_4_defconfig
> +++ b/configs/rpi_4_defconfig
> @@ -65,3 +65,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_VIDEO_BCM2835=y
>  CONFIG_CONSOLE_SCROLL_LINES=10
>  CONFIG_PHYS_TO_BUS=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

Can we also add the efidebug and efi nvedit commands here. They are
pretty handy especially when it comes to capsule updates. Thanks.

-sughosh
