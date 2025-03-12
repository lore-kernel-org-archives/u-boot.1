Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759D7C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 06:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8D5801BE;
	Wed, 12 Mar 2025 07:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BW/70hhH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A72E805D7; Wed, 12 Mar 2025 07:40:46 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECD38007D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 07:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e63c966fe37so199286276.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741761643; x=1742366443; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TNvawmpGO1+t3weJ2+lGwVMc60kxZXwBUaP1KH4hDE4=;
 b=BW/70hhHynvbKOlDLBYuccNWRq+mF3izjT/ajITPXdnPHCmXFTNf8st9WJDxaChHEr
 4OFix2zJNBbksBZ21Z0Qt5C83J4k2ZncACEGAh8KFW7AhIHEXhy5vvWV99zePHLnCtgB
 2Qdd5rFj7RDU2WQR8URh79f+d9YwhsoUt/LOmTYDtR5wD/N68yZxAJxa1nMR0Hj1qpfX
 J+jICcXbgyhAk4YrU5JYAmo1gYRPuC0hoZ3o2kU8XJx154R+eXfCxRMHOppbRJgMYk4s
 /1emex7S5+RpW31klDKdXvSjyjVbexc5ZDHIjsV9FGLe316mPWti1Yg6NQdCL9UJgSEP
 bkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741761643; x=1742366443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TNvawmpGO1+t3weJ2+lGwVMc60kxZXwBUaP1KH4hDE4=;
 b=jea13jyMETz5bEx6IFRxs00nSLyaUKmX+ymBXBJqyynNEClmagpXY7eX1DgNheyyUM
 o+J2k2uTtR9Te4jIqwVHS9YGk/w3u0mepYqh9XXoCTQujcHTzIRuhbnKJgdDiuALWaAu
 kEf72c+NQ3OH7SuK0AI9fNG2ZaDlWP+bd7fy/mLVAysC3Q7IfzMMIYfSN81znWfq4VbY
 pzUmVDJPCtRra4nZsL0bydYSAsHT1P/6TLW0/wZYLjqeS2RGRK7I61Cl5Bb1HaAX5gjN
 QWZl5qXr1XNDpAm1bcDF7OT0v3oKAeplDUu9eJ8N/Clfz+aJGBpnXN174hqZETVRidO6
 v4DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWewIFf+R913GhhG/2ZDpk37OUY+zYJFqbKLef3T1aYRca0mRInqyVrshvIGDN9/+eETFrhFV0=@lists.denx.de
X-Gm-Message-State: AOJu0YzEEWb8l5D+pPjdjEy19nAHJ+dZzRPtqeWp2mqoDQAUTu7mRait
 drmsu2qGECqspC3TOOhp8DaxKQnqXmeWMAbwIT45XaPYLgqlRRTXHB1krYcYwsJeV3zOLXS4WtS
 2sdKgVOsFEc455JsrSDgm9ZC5ROJzxg8+ZF1Zew==
X-Gm-Gg: ASbGncvYlQ9QumhpQD0Ld8EcZEXSI/7NrQoRitiTYMyk7PALkIeX4pr9q3oHHf4N0nz
 VRwNop4jy3TaaQOAfuAAv2oZg90T+yiR2PZxaPTEcfCQf7c79OHIeVjuDzBRaafFTVMLM0Eg4el
 Wuqnf2shFy7JDggMfdVwJmqnTpRY0=
X-Google-Smtp-Source: AGHT+IHBPEC1QP5+3kxTkztUITkpfY9BG/pwaF0dLrAXYkTEvvkfmnESUn3jtT5PXovbjX2HZ6bdcvrEoFsNnVbKv48=
X-Received: by 2002:a05:6902:278a:b0:e60:9821:3a with SMTP id
 3f1490d57ef6-e63b5136e33mr7644595276.6.1741761642931; Tue, 11 Mar 2025
 23:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250226223547.393611-1-j-humphreys@ti.com>
 <20250226223547.393611-3-j-humphreys@ti.com>
In-Reply-To: <20250226223547.393611-3-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Mar 2025 08:40:07 +0200
X-Gm-Features: AQ5f1JqZu-ezw8V3lLtayOn6VXe75gJj6z7UrUNTjSGCJZNoRCuJ0NuSk1CU4wM
Message-ID: <CAC_iWjKRrPvBPo-o8yK6e5gyuQQ_2VKgE-zdRQ2JuV3HDXUSzQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] efi_firmware: set EFI capsule dfu_alt_info env
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
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

On Thu, 27 Feb 2025 at 00:36, Jonathan Humphreys <j-humphreys@ti.com> wrote:
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
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  lib/efi_loader/efi_firmware.c | 51 ++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 5a754c9cd03..0ffaf5c8f72 100644
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
> @@ -663,7 +665,28 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>         if (status != EFI_SUCCESS)
>                 return EFI_EXIT(status);
>
> -       if (fit_update(image))
> +       orig_dfu_env = env_get("dfu_alt_info");
> +       if (orig_dfu_env) {
> +               orig_dfu_env = strdup(orig_dfu_env);
> +               if (!orig_dfu_env) {
> +                       log_err("strdup() failed!\n");
> +                       return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> +               }
> +       }
> +       if (env_set("dfu_alt_info", update_info.dfu_string)) {
> +               log_err("Unable to set env variable \"dfu_alt_info\"!\n");
> +               free(orig_dfu_env);
> +               return EFI_EXIT(EFI_DEVICE_ERROR);
> +       }
> +
> +       ret = fit_update(image);
> +
> +       if (env_set("dfu_alt_info", orig_dfu_env))
> +               log_warning("Unable to restore env variable \"dfu_alt_info\".  Further DFU operations may fail!\n");
> +
> +       free(orig_dfu_env);
> +
> +       if (ret)
>                 return EFI_EXIT(EFI_DEVICE_ERROR);
>
>         efi_firmware_set_fmp_state_var(&state, image_index);
> @@ -717,6 +740,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>         u8 dfu_alt_num;
>         efi_status_t status;
>         struct fmp_state state = { 0 };
> +       char *orig_dfu_env;
>
>         EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>                   image_size, vendor_code, progress, abort_reason);
> @@ -747,8 +771,29 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>                 }
>         }
>
> -       if (dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
> -                            NULL, NULL))
> +       orig_dfu_env = env_get("dfu_alt_info");
> +       if (orig_dfu_env) {
> +               orig_dfu_env = strdup(orig_dfu_env);
> +               if (!orig_dfu_env) {
> +                       log_err("strdup() failed!\n");
> +                       return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> +               }
> +       }
> +       if (env_set("dfu_alt_info", update_info.dfu_string)) {
> +               log_err("Unable to set env variable \"dfu_alt_info\"!\n");
> +               free(orig_dfu_env);
> +               return EFI_EXIT(EFI_DEVICE_ERROR);
> +       }
> +
> +       ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
> +                              NULL, NULL);
> +
> +       if (env_set("dfu_alt_info", orig_dfu_env))
> +               log_warning("Unable to restore env variable \"dfu_alt_info\".  Further DFU operations may fail!\n");
> +
> +       free(orig_dfu_env);
> +
> +       if (ret)
>                 return EFI_EXIT(EFI_DEVICE_ERROR);
>
>         efi_firmware_set_fmp_state_var(&state, image_index);
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
