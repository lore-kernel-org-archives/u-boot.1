Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85484ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 06:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27E88892C;
	Tue, 10 Sep 2024 08:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OZifZp0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CF48892C; Tue, 10 Sep 2024 08:41:58 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8175A8890D
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 08:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-207115e3056so21609425ad.2
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 23:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725950514; x=1726555314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=if2PYaA7KCYsiHsqJo8oh1CWqO6TgW4K5P5gQB6BthQ=;
 b=OZifZp0Z7gjDRJoe6UDiIARPzJxAQqT8IVwSi+EbrQWjp6HER8TjUZRMKrC3s4FAj0
 H1oCZnOf/KhsrUyVLLHWDRqXRABpAZk2VCKhTIVwoux0vKM0+Ru2YVVYjOtl+itKNCdU
 GYBXhmK71QITOQ78K0azDV8Exqjgq+NxWGzsqP3cACLPNbBWkRQ8GtFzcQEcxj8HRtBO
 TQSkO2iz7u64wOLWjMvACC65krUtXKd2eB7JADCOpco+3EhjAFCiSmxZAkQikhbsCvCo
 3OowFBDsaHCJjD4UARyPdTF3/4svkiZ8jY6LNZvGQPJtBD2GHgcl0spDBQmLFEW2C1tm
 BJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725950514; x=1726555314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=if2PYaA7KCYsiHsqJo8oh1CWqO6TgW4K5P5gQB6BthQ=;
 b=tKdYXUDR3x1KqY62wXMPoOw1WEaluUnZPOG7bkCM0WAAPEwpuN5hvaqfDUl9p9CkCV
 unUGXXJctJabyMLj7q6qA+4FcPExJNXLfUkUXNUPZ754Fk7WIjh8gyeTawqkElxdsJXi
 IXYVae9AqxpVkCozRIwCzQWXheP4ex2PO5OqolTy0B+MLnnqTof9rSd7ita4yom4i8yN
 mtRb2eCDS6KwaE5bxHFL5EI+dmyJUdf9xLNEJM9immWfuxHUWq986ntfBog8X10qsR2D
 /ucH81cKyR/ooDlIyXRGf1WqEe6DXonRyzT5hVeOEzsHXM73smz1QS4nK3pbx/lx8aPX
 WHTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMCLEhSQMlqYfuagaw7m/hMV8iDwh06gOHF+RET6VrXP45MwE6mI4O38qu4Q/pivj/MoFVm6w=@lists.denx.de
X-Gm-Message-State: AOJu0YyYdmmzIu4djQf3izUXB1XnES3PnEF8Mx7e7XAViace48T36Rgv
 DfIo34TxgGNYRKjMfeuLULrF47HexX9R06qJ2UccNZe1edK05oBd7heU9vUQvWDEnnaAfyU1kdJ
 o3VYYzITSrKIsnoogRFatMA3XqtNK8o+WBePX3A==
X-Google-Smtp-Source: AGHT+IFGrkaOqsYNlU50qrSz3y+DwNVb5vYvV2Kw8FlxtrNYtaioNfAV5yLoOSUPq+k3bztjhjJkh5s7NLfPcP76ido=
X-Received: by 2002:a17:902:d4c4:b0:205:5f2:34cf with SMTP id
 d9443c01a7336-206f0525ccamr156852405ad.24.1725950513452; Mon, 09 Sep 2024
 23:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Sep 2024 09:41:17 +0300
Message-ID: <CAC_iWj+cph1uZuUkE1nxbZd-WSQtw8ef+4OmzD6fC1QWTbkj4Q@mail.gmail.com>
Subject: Re: [PATCH] board: rpi: Enable capsule updates
To: pbrobinson@gmail.com, mbrugger@suse.com
Cc: sughosh.ganu@linaro.org, Tom Rini <trini@konsulko.com>,
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

Apologies for the noise, forgot to mention this needs to be applied on
top of https://lore.kernel.org/u-boot/20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org/,
once that lands

/Ilias

On Tue, 10 Sept 2024 at 09:39, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Since RPI works well using EFI and has no size limitations with regards
> to U-Boot, add the needed structures and Kconfig options needed to
> enable capsule updates
> ---
>  board/raspberrypi/rpi/rpi.c | 22 ++++++++++++++++++++++
>  configs/rpi_4_defconfig     |  2 ++
>  2 files changed, 24 insertions(+)
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
> --
> 2.45.2
>
