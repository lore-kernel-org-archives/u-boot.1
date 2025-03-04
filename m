Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A36C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506BA814B6;
	Tue,  4 Mar 2025 14:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hdJGXLin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13CA814B6; Tue,  4 Mar 2025 14:52:13 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881248144A
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so4035156276.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741096330; x=1741701130; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fdllVgrrkuznP21nnyyl3TlCdlVFk/cBf88PBB5c2qs=;
 b=hdJGXLiniKRKoIj2cmySr+3lvoo/rkwlzJFmfvDpZ1L1z6aYk0az46ajcoW90gV7os
 p8Zuu0mjDwh0+SJEED2BQxNmpQf4+QJC9WnJZz2p6sfOfdMzfp4hV5aKVMHrGzadmbiM
 cIdhoZglyF4w4E9eVnwNuiEBxfIfA44yhi6n0EKU/EnirQWVPSg6tmzUzDnnmT/qN/gW
 WaKEDDMOxAJ0rHimZHwhjXnU3+I3C3OkBT4NwXZeYLGzbGOk2egcP2CFzXsOmykqwBr0
 jX7LLGh/t/EopiePRLi1/d4uaaJznEoc/+9ThINYOJyqv4N3Q90AILvVQfdr1o2hxQIZ
 FwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741096330; x=1741701130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fdllVgrrkuznP21nnyyl3TlCdlVFk/cBf88PBB5c2qs=;
 b=vYEyA0AP1Ng8rrAhr+4S3uPLz55+AEcWwxvV7rAlok6CClpsgsBahtCEzCQiNwuyp7
 AtB4r8VTfvJhS0sCK/bWUh/9YDUD+RWVia4Ksf+H5jxRaXGQ2zJfcS/eSE/BTJxlU0pv
 gI1MyiM5uh9EYtWazBLzmKkRmFwygE+T2wo7cNGI64i3mz0Ia+My+F27YY12SIcyBc4W
 9lHhwv+HnzkZlHvZncwvStInjmzLthKSb14pLXepTNKsaNccVnDcWiEZl2PjBC5LRitu
 fGc9JnSgDQzwJGWJr+BVSXi+Tn5r+VbanqbvjCIodRYNprTxidbbFvcUaw7K+d2sbYKP
 9NUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsOHn+aepibdssyHx2BO3J7Ab5wqF7UY4FnnTLL/ilTE3S4dx5x4MGM34REZotsLzjdwlKnOo=@lists.denx.de
X-Gm-Message-State: AOJu0YynfwneZXhufF2MCxKynzvkJF4A0qwCYgGsZR4Q9zxBf0747+8U
 XUGIlzRekUGLXAhq1y6jPw3k1efpVGxOEDy5ZVRGSE4mXW8nISKVIth3lb8bp1wgZTSpdSTB/11
 RzW7rglgVUuYdHUYGisdkhYHRza2mESIUAYY9BQ==
X-Gm-Gg: ASbGncspisLgRvhajyKzaUndJPkqrAhJrfhnseBfBMkaox1FMLA6w85pcW2OoWmSf7s
 Y1Q8MY3rIWZCoCU0/2V+M7/ar9iTOsnnx+AP0W7/amF1TI/YuLr+J6n6KwrECiLXjBaLPmhQyMV
 Z0UZ0f3QvlCE0tXf/8QIXyTOGqJZVA
X-Google-Smtp-Source: AGHT+IHEkX8blFYYnLV0/FW64PhcoHrfgxGaDKSntbip5iZb0N/Sw2V28p9eN6ueep0QJp7dxzO9En3JgQufX3Ye4i4=
X-Received: by 2002:a05:6902:2611:b0:e60:88f9:b081 with SMTP id
 3f1490d57ef6-e610c3b5fc7mr4269140276.17.1741096330359; Tue, 04 Mar 2025
 05:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
 <20250302142121.150480-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250302142121.150480-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Mar 2025 13:51:34 +0000
X-Gm-Features: AQ5f1JpturvMmvrkc41UG75C7jRn8_1yhwe3iLQhVGTaJ54-TBtfKGY3SeC6Flw
Message-ID: <CAC_iWjJqHEw+JDiSUK1GJFq2Cmpzspg+t9R5rZRRO-jnbZpgkg@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi_loader: Clean up usage of structure jmp_buf_data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Janne Grunau <j@jannau.net>, Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
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

On Sun, 2 Mar 2025 at 14:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> From: Yao Zi <ziyao@disroot.org>
>
> Structure jmp_buf_data provides the underlying format of jmp_buf, which
> we actually don't care about. Clean up existing code to use the standard
> jmp_buf type. This introduces no functional change.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  include/efi_loader.h          | 4 ++--
>  lib/efi_loader/efi_boottime.c | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 1d75d97ebbc..22b724f311a 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -15,13 +15,13 @@
>  #include <efi_api.h>
>  #include <image.h>
>  #include <pe.h>
> +#include <setjmp.h>
>  #include <linux/list.h>
>  #include <linux/sizes.h>
>  #include <linux/oid_registry.h>
>
>  struct blk_desc;
>  struct bootflow;
> -struct jmp_buf_data;
>
>  #if CONFIG_IS_ENABLED(EFI_LOADER)
>
> @@ -485,7 +485,7 @@ struct efi_loaded_image_obj {
>         efi_status_t *exit_status;
>         efi_uintn_t *exit_data_size;
>         u16 **exit_data;
> -       struct jmp_buf_data *exit_jmp;
> +       jmp_buf *exit_jmp;
>         EFIAPI efi_status_t (*entry)(efi_handle_t image_handle,
>                                      struct efi_system_table *st);
>         u16 image_type;
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index bdf9e7e8066..853a1c8c097 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -21,7 +21,6 @@
>  #include <usb.h>
>  #include <watchdog.h>
>  #include <asm/global_data.h>
> -#include <setjmp.h>
>  #include <linux/libfdt_env.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -3199,7 +3198,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>         void *info;
>         efi_handle_t parent_image = current_image;
>         efi_status_t exit_status;
> -       struct jmp_buf_data exit_jmp;
> +       jmp_buf exit_jmp;
>
>         EFI_ENTRY("%p, %p, %p", image_handle, exit_data_size, exit_data);
>
> @@ -3238,7 +3237,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>         }
>
>         /* call the image! */
> -       if (setjmp(&exit_jmp)) {
> +       if (setjmp(exit_jmp)) {
>                 /*
>                  * We called the entry point of the child image with EFI_CALL
>                  * in the lines below. The child image called the Exit() boot
> @@ -3444,7 +3443,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
>         struct efi_loaded_image *loaded_image_protocol;
>         struct efi_loaded_image_obj *image_obj =
>                 (struct efi_loaded_image_obj *)image_handle;
> -       struct jmp_buf_data *exit_jmp;
> +       jmp_buf *exit_jmp;
>
>         EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
>                   exit_data_size, exit_data);
> @@ -3511,7 +3510,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
>          */
>         efi_restore_gd();
>
> -       longjmp(exit_jmp, 1);
> +       longjmp(*exit_jmp, 1);
>
>         panic("EFI application exited");
>  out:
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
