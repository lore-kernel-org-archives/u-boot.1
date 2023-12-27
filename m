Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012C2C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 11:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 086C587988;
	Wed, 27 Dec 2023 12:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HutP4UWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DFB8798B; Wed, 27 Dec 2023 12:08:08 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A8A28795F
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e5a9bcec9so6104886e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 03:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703675285; x=1704280085; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oNyphCdXuK87wHrqz1LQy4kq1H40M5WCt/oHgjVyo9I=;
 b=HutP4UWT1gjlYrMNsf5JX/7hnPjEXeZL6fkbeORC0PCMa+I6RYUWNE/0fzRKAZo4ck
 WQ4lDcUwkreErqn00WYaJEIF1PQC1SgyHBvDZ7ZLmkYHUcj2FJxMzSe/9Kkx+iQMAepj
 vzXDJWATxAvmEfcnjnfa2R44gzCaM2M6uO9BUjfugd7Tdb0yqXs9SIam0BsToTQX2LgS
 +fbi+JM1B6rbuEISctXZkHoPIgX53acWAJsSxtEEHIKElIdLAMAevTJ/XjUEyYygWGsd
 06qI7xk+v0oCoJluq6+UTNSUxHmQ8EPfeI4HumeZT7K+qMSuRUHhHBxPeXY5SVRDlC/L
 1YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703675285; x=1704280085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNyphCdXuK87wHrqz1LQy4kq1H40M5WCt/oHgjVyo9I=;
 b=DYnooDaXN9w0WaVqWPUzkyk4eG8lCmgSJXexxT3Pe3Tz1JuD6N16Fwgl2nFTRs4e65
 wwm7DvfWNYCj5OiD/r8w5aOXosm3vJG0rOLk5SFI/tJAB2T72zP2XJVwh+5r1dXNRwNz
 5l50DECKLfes48iXINnJcDuQ3hr3GCZ7xRO4VkIzwD0uGXH2j5WNvv/nBBKm3BD9aXX8
 tsR+dit9dE48T/1xN44qK+T51dWLQIsYZX26+UgRfhA8HvCHUw81dnP5OYiPLZlxkvzb
 uoqxkcVLft4ExGyHdwS48QUGMO2KGC4WuBdDk/ChGzytIU9lLUfGxLZvYywWvsLO0R9S
 sMMg==
X-Gm-Message-State: AOJu0YyalutaxVlzq6MJaNM/thNxJ4M/0eA+cgGYeSC07rUcuPsBKQ+a
 6ilRLJEQcxSFSIOYjxzOY/Yl2VofFJFLlN7d9m3WZ5OmFUtriQ==
X-Google-Smtp-Source: AGHT+IFW9JtbwGVaQcNVoWCxrL3qR7Iqb/9nT9Jve1Ya1QVSuLMELYclaGt36/QxpJKj2gbzN7x8YfGaLBmFKmht4gc=
X-Received: by 2002:a19:f50d:0:b0:50e:3b11:3b08 with SMTP id
 j13-20020a19f50d000000b0050e3b113b08mr3106735lfb.70.1703675285331; Wed, 27
 Dec 2023 03:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-6-sjg@chromium.org>
In-Reply-To: <20231227074025.2178825-6-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 13:07:29 +0200
Message-ID: <CAC_iWjLa8mz0x-1gw7yvn7WMdz_adt6+AtFmDHjZrn6JF3D3Lw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] smbios: Correct gd_smbios_start()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Troy Kisky <troykiskyboundary@gmail.com>
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

On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
>
> This should access arch-specific properties. Fix it and update the
> existing usage.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add a new patch to correct gd_smbios_start()
>
>  include/asm-generic/global_data.h | 2 +-
>  lib/efi_loader/efi_smbios.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index e8c6412e3f8..c1f7818817f 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -553,7 +553,7 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
>  #endif
>
>  #ifdef CONFIG_SMBIOS
> -#define gd_smbios_start()      gd->smbios_start
> +#define gd_smbios_start()      gd->arch.smbios_start
>  #define gd_set_smbios_start(addr)      gd->arch.smbios_start = addr
>  #else
>  #define gd_smbios_start()      0UL
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index bbb8421ce14..49adc87e45a 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -28,7 +28,7 @@ efi_status_t efi_smbios_register(void)
>         ulong addr;
>         efi_status_t ret;
>
> -       addr = gd->arch.smbios_start;
> +       addr = gd_smbios_start();
>         if (!addr) {
>                 log_err("No SMBIOS tables to install\n");
>                 return EFI_NOT_FOUND;
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
