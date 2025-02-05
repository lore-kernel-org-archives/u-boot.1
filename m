Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A1DC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 09:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BFED805D7;
	Wed,  5 Feb 2025 10:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mUum4m1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DFF805E7; Wed,  5 Feb 2025 10:17:29 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9629880207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 10:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e580d6211c8so6582988276.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 01:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738747046; x=1739351846; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fn4WZafD2c7701b7xb9FtcJLybc5k9pYeNVg2HN6Ecs=;
 b=mUum4m1sy7/78WGN4ptg2J0o2V68Ub5a7PjAiO85N0gGec99mVCd5cromAX4N2iOI6
 ietz4D0FaVX/RWIpQRv54ofuUjP/b1rLF7VpfSFG80xFuFBAaocym+e+VA84idSLlFD6
 EIUsPXbaSGsS3VWBLM5IjfeaUEUV2f6/yn36cGLhEp456G28Sfb1+9Meh4pCJQgI9jAx
 lw2M5tkB244/3rarW/NzGMLnrssTcSuMwMfeFd06S+mcjiROW9COjEsaz+4C00S9gfB1
 8kouL7x0ZM7B74bBDxavqz+EvR4AQFjnDdSJoAHNkYbtmT1FJODlDzSo3OtJVLuROHWg
 IItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738747046; x=1739351846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fn4WZafD2c7701b7xb9FtcJLybc5k9pYeNVg2HN6Ecs=;
 b=qBjIrKrzbxU4EEsozu4gIqO8v0/ZQVG4UcPbFyU5mnwqyJm7R1ZBPrIaAZCwrSPGNP
 qnj9UlhdrWwOK43TcKt1CP+t9ubriU10fBHGwaaCIKDvIRt7cMAWSY7TRtZm0Ear2sF+
 pfXamxbeYY4fwHiqN2CTBu0HAv9BI2gq50aF9fgriqgCXhl7NdVoGrtN7h6gd8AnByuJ
 kxl0r86ZiKeubvPpDbJMvQEVEw/IgCREHlleAX9yS7Fr1PkAgh4QJzrk6pOUbM4K9ieb
 psIILXE5WAx+b2gskweNLVQQK3hjWdb3ujVVTjhGabnNzTEsETh+zWkXepgrh8ZuAp7N
 lKJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV67YMuzmOzae2wJpAMFdvDv9h3mpEAsOnDM74zgR7SyNtslDqvjGCjiGI65d1H3owsr8zFHk8=@lists.denx.de
X-Gm-Message-State: AOJu0YwrmsCFA7ecwX6tm7IDfRUci9abbkL6KqQlCe/FPE4fS/5ZjRQz
 l+nBoiK4THWM3dWv+ajjdNSVL8gSvR4SDr8Ok1UbWl5ENgjfuZJA3FTNUMqlbStbPfx/hIGRK7E
 M45fK+qYlCfjWtqUXAsA/l1gbs7HYaZb/INTgSA==
X-Gm-Gg: ASbGncvzmEfD2pHPnrjqxbhkRlHEEHPbPzCBI0GF2bHjcww8y0GU5S81qSi2BjS4UE9
 /l+bilkEVhUatHLLLsgh8pBH8k7pDzK4MPsg9lpMYYnFnIrLv1xrq/BGFc74taR3AIFAPrbaN
X-Google-Smtp-Source: AGHT+IExB3T2KeiBWJJbuTLdhg3x+fxRSEoXWOHlLACrBzatsE2Hq1XqSrylCaWWmKafltzoGcGjibLsG/k5OltmGEA=
X-Received: by 2002:a05:6902:e0b:b0:e58:908e:bac0 with SMTP id
 3f1490d57ef6-e5b259d1810mr1633099276.6.1738747046376; Wed, 05 Feb 2025
 01:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20250203215351.2840144-1-j-humphreys@ti.com>
 <20250203215351.2840144-2-j-humphreys@ti.com>
In-Reply-To: <20250203215351.2840144-2-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 11:16:50 +0200
X-Gm-Features: AWEUYZm_I3VKq3uvPh7xELwsewLOBKEuZmVJiCuKLMY3ZE71kKYeGQQAsCm0YYs
Message-ID: <CAC_iWjLODSE6x5YKe2ZbWzGr=YL0jxgEyNLDe30vPVPq7CJDhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_firmware: set EFI capsule dfu_alt_info env
 explicitly
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Daniel Schultz <d.schultz@phytec.de>, Viacheslav Bocharov <adeep@lexina.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Aashvij Shenai <a-shenai@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Apurva Nandan <a-nandan@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Lukasz Majewski <lukma@denx.de>,
 s-vadapalli@ti.com, u-boot@lists.denx.de
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

Hi Jonathan,

On Mon, 3 Feb 2025 at 23:54, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>
> The current implementation of EFI capsule update uses set_dfu_alt_info() to
> set the dfu_alt_info environment variable with the settings it requires.
> However, set_dfu_alt_info() is doing this for all DFU operations, even
> those unrelated to capsule update.
>
> Thus other uses of DFU, such as DFU boot which sets its own value for the
> dfu_alt_info environment variable, will have that setting overwritten with
> the capsule update setting. Similarly, any user defined value for the
> dfu_alt_info environment variable would get overwritten when any DFU
> operation was performed, including simply performing a "dfu 0 list"
> command.
>
> The solution is stop using the set_dfu_alt_info() mechanism to set the
> dfu_alt_info environment variable and instead explicitly set it to the
> capsule update's setting just before performing the capsule update's DFU
> operation, and then restore the environment variable back to its original
> value.
>
> This patch implements the explicit setting and restoring of the
> dfu_alt_info environment variable as part of the EFI capsule update
> operation.
>
> The fix is fully implemented in a subsequent patch that removes the capsule
> update dfu_alt_info support in set_dfu_alt_info().
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  lib/efi_loader/efi_firmware.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 5a754c9cd03..d8b6d34ccab 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -649,8 +649,10 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>         efi_status_t (*progress)(efi_uintn_t completion),
>         u16 **abort_reason)
>  {
> +       int ret;
>         efi_status_t status;
>         struct fmp_state state = { 0 };
> +       char *orig_dfu_env;
>
>         EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>                   image_size, vendor_code, progress, abort_reason);
> @@ -663,9 +665,22 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>         if (status != EFI_SUCCESS)
>                 return EFI_EXIT(status);
>
> +       orig_dfu_env = env_get("dfu_alt_info");

I don't think this will work. env_get returns a pointer to the data
which is going to change after the env_set
IOW this piece

        env_set("dfu_alt_info", "test1");
        orig_dfu_env = env_get("dfu_alt_info");
        printf("now %s\n", orig_dfu_env); -> will print test1

        env_set("dfu_alt_info", "test2");
        dfu_env = env_get("dfu_alt_info");
        printf("Orig %s now %s\n", orig_dfu_env, lala); -> will print
test2 test2

You have to copy the value of the pointer to an allocated piece of
memory to restore it

Thanks
/Ilias


> +       ret = env_set("dfu_alt_info", update_info.dfu_string);
> +       if (ret) {
> +               pr_err("unable to set env variable \"dfu_alt_info\"!\n");
> +               return -EINVAL;
> +       }
> +
>         if (fit_update(image))
>                 return EFI_EXIT(EFI_DEVICE_ERROR);
>
> +       ret = env_set("dfu_alt_info", orig_dfu_env);
> +       if (ret) {
> +               pr_err("unable to set env variable \"dfu_alt_info\"!\n");
> +               return -EINVAL;
> +       }
> +
>         efi_firmware_set_fmp_state_var(&state, image_index);
>
>         return EFI_EXIT(EFI_SUCCESS);
> @@ -717,6 +732,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>         u8 dfu_alt_num;
>         efi_status_t status;
>         struct fmp_state state = { 0 };
> +       char *orig_dfu_env;
>
>         EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>                   image_size, vendor_code, progress, abort_reason);
> @@ -747,10 +763,23 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>                 }
>         }
>
> +       orig_dfu_env = env_get("dfu_alt_info");
> +       ret = env_set("dfu_alt_info", update_info.dfu_string);
> +       if (ret) {
> +               pr_err("unable to set env variable \"dfu_alt_info\"!\n");
> +               return -EINVAL;
> +       }
> +
>         if (dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
>                              NULL, NULL))
>                 return EFI_EXIT(EFI_DEVICE_ERROR);
>
> +       ret = env_set("dfu_alt_info", orig_dfu_env);
> +       if (ret) {
> +               pr_err("unable to set env variable \"dfu_alt_info\"!\n");
> +               return -EINVAL;
> +       }
> +
>         efi_firmware_set_fmp_state_var(&state, image_index);
>
>         return EFI_EXIT(EFI_SUCCESS);
> --
> 2.34.1
>
