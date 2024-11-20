Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1218D63926
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399F4895F0;
	Wed, 20 Nov 2024 11:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YSdYgvR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D5389661; Wed, 20 Nov 2024 11:56:48 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C64C89533
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso1581055b3a.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732100205; x=1732705005; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ym2CqD2pkH4ON8nsG4SCyYRGqBlyYLVf8QTrlbQcemI=;
 b=YSdYgvR21xoww7ymyzb/ILh+IBls3c4A+OBjkDPFQ59nszudxLqxXUavkfTIHQTAgs
 sO2gHun5C93vAxN2he3IphyZ4WdiVgRmoT5/98vBizSbyresFssQmPVwndM61bZMamJF
 7fsi7llh5rYPJb+yinYCHa6v3Qosef7BYc3SHU+3FKqToB+lpMnISYu/ceChcK/EsKNV
 BgCsDabew20ho/NcB3eMbEjdIRg6/QC4uxj/1VsjforzYWPdJJBYZb2Fie2mw393k+L+
 c+VD6//6Y9ejcz6VeIrE7k/fR66luBv1YnQL/Mhr+5gDfaMz90n26RtPjgpqX5huGhzx
 Utnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732100205; x=1732705005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ym2CqD2pkH4ON8nsG4SCyYRGqBlyYLVf8QTrlbQcemI=;
 b=aYepcwJKJsGc5gL1J6bd0C7dSDcuiE7No+bnT+0iskcQXV9+5O/GfB8ELLLgKxkdal
 DjHckW0jCGissW8jR06NjaGQ3LL/YNvUAN6AxsKxYZ17k7DmRzbvCBqwl9k2R38jxFj/
 lZ9EHPsuV2l7wY909uaytdGhclTyNzun9ocAiRhK5QhjGzqWCOibbZaLW8aIR1A99Dzh
 odrtweEZoMmIVfqwRykFlYSiQqdeqgic3jl6ObpQ4dqwbTcaa+bZAgKzS00g7kEDMgTQ
 k2T2HpfhKHFUhl3B0hiU2vu+pGH/ngbtK23u6mdYzWtQxZ31ptmYHhSMsY+MoYJc5iai
 wdhQ==
X-Gm-Message-State: AOJu0Yy7z8DwBQJNd5N8Hs3ajb36lGzYJMhnbjtLlMqtgMeZrPIiMeh/
 ELedLITV+J6R4x3+NwvoZ2J8t51Wo6wcofpSXNN4xKBiX2i8qj3zx5iy1mH149UlZ9l826Fz3+Z
 fmtGAzG9hI7QVVQx8erj64TfMesGNbiOmHxufgQ==
X-Google-Smtp-Source: AGHT+IH/WR6UkRQr3t09Fli6xuxwD6650+UvJRnSXo5Oy8yIshKFTHSyPXqgk0PIA8+wPGh1hhHDcF4bal78TV8SipY=
X-Received: by 2002:a05:6a00:3cc5:b0:71e:6c67:2ebf with SMTP id
 d2e1a72fcca58-724becb1131mr2472642b3a.11.1732100204644; Wed, 20 Nov 2024
 02:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-13-sjg@chromium.org>
In-Reply-To: <20241119131844.4078144-13-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Nov 2024 12:56:08 +0200
Message-ID: <CAC_iWjLVH8puoEvqu-UH6T8xvtQVvkAqksqtHq9+m+Xwq9xUjg@mail.gmail.com>
Subject: Re: [PATCH 12/39] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
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

Hi Simon,

On Tue, 19 Nov 2024 at 15:19, Simon Glass <sjg@chromium.org> wrote:
>
> This code cannot be compiled by boards which don't have this option. Add
> an accessor in the header file to avoid another #ifdef
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  boot/bootm.c    | 8 ++++----
>  include/bootm.h | 8 ++++++++
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 16a43d519a8..0a1040ef923 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -633,11 +633,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>         load_buf = map_sysmem(load, 0);
>         image_buf = map_sysmem(os.image_start, image_len);
>         err = image_decomp(os.comp, load, os.image_start, os.type,
> -                          load_buf, image_buf, image_len,
> -                          CONFIG_SYS_BOOTM_LEN, &load_end);
> +                          load_buf, image_buf, image_len, bootm_len(),
> +                          &load_end);
>         if (err) {
> -               err = handle_decomp_error(os.comp, load_end - load,
> -                                         CONFIG_SYS_BOOTM_LEN, err);
> +               err = handle_decomp_error(os.comp, load_end - load, bootm_len(),
> +                                         err);
>                 bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
>                 return err;
>         }
> diff --git a/include/bootm.h b/include/bootm.h
> index c471615b08c..d174f18ac18 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -89,6 +89,14 @@ struct bootm_info {
>  #define bootm_x86_set(_bmi, _field, _val)
>  #endif
>
> +static inline ulong bootm_len(void)
> +{
> +#ifdef CONFIG_SYS_BOOTM_LEN
> +       return CONFIG_SYS_BOOTM_LEN;
> +#endif
> +       return 0;
> +}

Do we really need a function for this?
Why don't you
#ifdef CONFIG_SYS_BOOTM_LEN
#define SYS_BOOTM_LEN CONFIG_SYS_BOOTM_LEN
#else
#define SYS_BOOTM_LEN 0
#endif

Thanks
/Ilias
> +
>  /**
>   * bootm_init() - Set up a bootm_info struct with useful defaults
>   *
> --
> 2.34.1
>
