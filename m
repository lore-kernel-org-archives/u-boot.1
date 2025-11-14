Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74D8CDE019
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 07:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4228B83A6A;
	Fri, 14 Nov 2025 08:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="juEspG5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A01E83A03; Fri, 14 Nov 2025 08:03:45 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91D4483959
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 08:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-641e9422473so359417d50.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 23:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763103821; x=1763708621; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=141J5rg6TRUx8RIaZeUVtj6PNX4wCR/4Oj4n/dIr97E=;
 b=juEspG5L9RDQSdwmL+UvrwGUPQWu9ZBDXH9wIqGHN4iRVbUjuKrEzxWmXr4kveyeV+
 qIjgmuA79X1aXVu8ltEN/LQxSVn9ovGJ7MHuO1BkwSkfteKrCKRNZV+X7w9P1iXanabD
 4F4fHtl6wumPftew/qD4f2D2WShYg3VyPLmRqO9qQVsC/stbzjXg9depOVZ0wSx4apiz
 ZgAQAmzsTzq/PXWkFk80LxOUYqtSPl6c7/7SZMUcTUeDH51zAp4e/sDtN6H6OSQdnWIW
 dYUGk4rI9Ko+GhPO7cu49d3QaJB68RjpQEoVO5iexpoET3mmm9TQjJLJAC2a4pVfhA24
 snAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763103821; x=1763708621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=141J5rg6TRUx8RIaZeUVtj6PNX4wCR/4Oj4n/dIr97E=;
 b=Ck+8Rq77bFoYT+9Zp5Lb+ET8Xgy2LkMC5shOHVtXj5H+4wA97xkaDKLKnbOB3a8F5C
 MblDVN7IL3EEx3n8h064xqA4AXI91bsVoSY3A3jpUTMT0kq2d/ljQaNrCBzr0rVaKENG
 pC841d8Fqx39v3RCcUI32rGvJKP7gmffMGr5e2y/ORWfmCZDsIS9wy9iOHRgfghC3uqs
 upe37PGlH30qmKUdyl1wQgFmVsg3+OTrc5Xa+yaNSc5LbQNgxZ1GDmWNVXbdLRssXm+x
 KRBEOHzCyKpoWXixzscruq7Cm3prWXnaB4nXSkFaBZdM1wzzhR6Juw66475MVVQstVYW
 8l+w==
X-Gm-Message-State: AOJu0YzEZt63CmwWBu27UttluLvtLixQfv2tEaMGwJC51nUWBEZhCQdT
 +mJVFtQhGSc3mxv8UfxEonCJITZNPwXFS7UhO8c8jOZLhgIsMEXfWekAbNNiIzxlPhjXfROq1iQ
 gcMIUKpSUd7raRiPnqws2BwUXglkMDAv27ojdE42jdQ==
X-Gm-Gg: ASbGncv0LdwsRi6ZX9PqacjgbTyyxC5vywJ/lF9w7jShoklAwURXz2qny2Z/fq2y/DT
 shomu8/lQz8SBosorFdwcLwCSH3qT/TIIyqj+zNlo6TdntZpDoRKIv3Ap71AutVfcu0Ew4pPD/U
 Yax74IPPrE30NeemA1mg25HPQ4N9CkFjHn8obd2v3tEkSj8i6poUbLRwLL30WTJGdWuct39HPcO
 hreiYSbUmYdpKmgmrSOXhGeZwjh6QyaRMj8GAp3rmf8I2N01fv9HYkb5K+MiLLGRW0ujVplSTmQ
 aofsbGf5E0Q0Z9nDtLlaqOF8ly6yw7ufQr5dIQWiZlwri+2McII=
X-Google-Smtp-Source: AGHT+IF8XVuAfIF6UvTWUzkMmG7m2e9y8DYhb5V5g9D3LM794TVbAk2Kc/SyfZ1az/d6W+SIZYamGux48frEYs4WszE=
X-Received: by 2002:a05:690c:22c9:b0:789:3166:25a7 with SMTP id
 00721157ae682-78931663580mr1772767b3.46.1763103821318; Thu, 13 Nov 2025
 23:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Nov 2025 09:03:05 +0200
X-Gm-Features: AWmQ_bmN3fpxNpDLLysTAlDT7FZg7_RpqZKORIMzavGmGy3xf6V4b4vyy5LMSGM
Message-ID: <CAC_iWjJE1meO7UonS2-hUSkkcnxQWCerqdN4mb_wcR7rpVXy+g@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Assure fitImage from capsule is used from
 8-byte aligned address
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>
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

Hi Marek,


On Thu, 13 Nov 2025 at 13:56, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The fitImage may be stored in EFI update capsule at address that
> is not aligned to 8 bytes. Since fitImage is a DT, new version of
> libfdt 1.7.2 rejects such an unaligned DT. Patch the code and copy
> the fitImage into aligned buffer in case it is not aligned. This
> does increase overhead for unaligned fitImages in EFI capsules, but
> tries to keep the overhead low for aligned ones.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

At some point I'd prefer getting rid of FIT images for capsules
overall. It was implemented as an alternative to authenticated capsule
updates, but since then proper capsule support has been added. The
patch is ok though for now,

> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jonathan Humphreys <j-humphreys@ti.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> Cc: u-boot@lists.denx.de
> ---
>  lib/efi_loader/efi_firmware.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 216df83de67..953a310190b 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -651,6 +651,7 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>         efi_status_t status;
>         struct fmp_state state = { 0 };
>         char *orig_dfu_env;
> +       void *img;
>
>         EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>                   image_size, vendor_code, progress, abort_reason);
> @@ -677,7 +678,20 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>                 return EFI_EXIT(EFI_DEVICE_ERROR);
>         }
>
> -       ret = fit_update(image);
> +       /* Make sure the update fitImage is properly aligned to 8-bytes */
> +       if ((uintptr_t)image & 7) {

Can we replace this with IS_ALGINED?

> +               img = memalign(8, image_size);
> +               if (!img)
> +                       return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
> +               memcpy(img, image, image_size);
> +       } else {
> +               img = (void *)image;
> +       }
> +
> +       ret = fit_update(img);
> +
> +       if ((uintptr_t)image & 7)
> +               free(img);

Initialize img to NULL and make the check a bit simpler to read (or
get rid of it overall)

Other than that LGTM

Cheers
/Ilias
>
>         if (env_set("dfu_alt_info", orig_dfu_env))
>                 log_warning("Unable to restore env variable \"dfu_alt_info\".  Further DFU operations may fail!\n");
> --
> 2.51.0
>
