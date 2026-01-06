Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC622CE9D78
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D2683FA3;
	Tue,  6 Jan 2026 17:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GHqLldf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FA9E83FAA; Tue,  6 Jan 2026 17:22:31 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C0F83F9B
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so4961474a12.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767716549; x=1768321349; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JPZN0M39bjOylosMNSR8xu+TFuM+diE/BbCT9iM6zV8=;
 b=GHqLldf2AYiac+RO65XG+aensma5KAO9B51tEWQq8v58fZThxevNnxzYYIfp3xrzfs
 Lddkc4bJqkR3TTTfOJBKvhgtGnbh15FqsmzGbSXYMdu/XLIx5SJK/8i3saDrBiUWYiWZ
 rFW6ChEIu2xV9M0kiXojFPpEx8rZaMDZHzn4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716549; x=1768321349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPZN0M39bjOylosMNSR8xu+TFuM+diE/BbCT9iM6zV8=;
 b=IJ9iDi9wzlKNwJ2LuwgmWMLMF4P0AxAP4chWCicWa/zPv5mplyFwwN2TE1YpszjQCt
 7aQrOzcX27+d19Z9fO8Gc0q8wtidJK68wn42v9sgdWh8mA3keP7B7onu8F6iwd9bAlRS
 +Tar37VfcB7W6Zo2ylUHpEBeafsc+lANK0Dq67EQDWUW+5GdWYCn9qhzlNZb97b3Ols9
 HzFEkSXYBhAg5F0Q0eqlIUaEWBryusy3a8Hav8XEIv9EuM7OzBjl2wBKsMhzbT50KPg+
 efyQkQHv0BRHVej+e1TG4h1oRIysYLacd20aCmxNLvcW54zW610UJ36Y6D/3X9lW4S8e
 mDzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSoTbOrTDSdzIqbFhXNdITaqXqi9XrABQrt7q8NydyQMvI19SE3qa0ooxn4EwdYeDQDk/vDX8=@lists.denx.de
X-Gm-Message-State: AOJu0YwIClUfyhOKHsnf444xWlzFBdW9NGB0H/buRiuA1ERVSsYNoAJC
 DQRdLmzpevsYXxU2iq5jcN9UxolUDPiVRGPdkefROfSb0I9JDjZS1CSSiali/rFZ4/SVKiX4jxT
 AJ216frWhAO4eAQocG0qJh6xTH5PtImyei6/k7SAx
X-Gm-Gg: AY/fxX6RMmA3+8sQCbsp/kKSKny/YqSmoZQtSSfYIOjKT32Bw3M8TtVWfho2xZcr0Tm
 RQLLSIhW1U9evgDaowuz4FAVGoIsh0fxWn6AeuFRhg7JFAKlVgwxZPBlDDT1y3X8F0hU1u6ISM9
 P9wshkRx4vqrn/zRIZXZDlx45QK4EDPt1mnjBOnU79xJHvCllR4apRiNFpwwpxdCccRTu1ZNwpU
 pkSelLlMl20SQelIZvt/4YqcIuNq2lUXir1++vVkwdb7ItJjuh2tbRqLOEf5H9Cm6IRMVLfjLIs
 96oV
X-Google-Smtp-Source: AGHT+IGtYZgWotW16zX2Wpi3Kwm6lP/Ns96pPKwWzXn3/v+5RjvK2XSq8NGQcEE4QFtea5JeJqMMHvyzDTyKTX6TvFo=
X-Received: by 2002:a17:907:3f9c:b0:b80:3fc4:3762 with SMTP id
 a640c23a62f3a-b8429892021mr346959966b.1.1767716548985; Tue, 06 Jan 2026
 08:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
 <20260106122134.2047864-2-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260106122134.2047864-2-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Jan 2026 09:22:15 -0700
X-Gm-Features: AQt7F2qI7-shetiCoznHADru9-TR-M69w5JPWhskvRFdwIapo410L5oyWtqJA-o
Message-ID: <CAFLszThuNoyeZQ=uJGh2v9dqwkvH2bYo+KPzTOLrRJRX7PxbmA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] efi_loader: Add platform hook for FDT loading
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 varadarajan.narayanan@oss.qualcomm.com, adrianox@gmail.com, 
 paul.liu@linaro.org, wolfgang.wallner@at.abb.com, javier.tia@linaro.org, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Aswin,

On Tue, 6 Jan 2026 at 05:22, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Introduce a weak function efi_load_platform_fdt() to allow platforms
> to provide custom device tree selection logic. This enables platforms
> with special requirements (such as multi-DTB selection based on
> hardware detection) to load fdt.
>
> The default weak implementation does nothing, Platforms can provide
> a strong implementation to load platform-specific device trees.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  include/efi_loader.h         |  2 ++
>  lib/efi_loader/efi_bootmgr.c |  4 ++++
>  lib/efi_loader/efi_fdt.c     | 23 +++++++++++++++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3e70ac07055..62c3df48f71 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1303,4 +1303,6 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq);
>
>  void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size);
>
> +void efi_load_platform_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size);
> +
>  #endif /* _EFI_LOADER_H */
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a687f4d8e85..ed06a65feb7 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1332,6 +1332,10 @@ efi_status_t efi_bootmgr_run(void *fdt)
>                         efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
>                         fdt = fdt_distro;
>                 }
> +               if (!fdt) {
> +                       efi_load_platform_fdt(handle, &fdt_distro, &fdt_size);
> +                       fdt = fdt_distro;
> +               }
>         }
>
>         /*
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index bfaa9cfc207..bfcfd933adf 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -78,6 +78,29 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq)
>         return 0;
>  }
>
> +/**
> + * efi_load_platform_fdt() - Platform-specific FDT loading hook (weak)
> + *
> + * @handle:    handle of loaded image
> + * @fdt:       on return device-tree, must be freed via efi_free_pages()
> + * @fdt_size:  buffer size
> + *
> + * This weak function allows platforms to provide custom DTB selection logic.
> + * The default implementation does nothing, allowing the standard distro boot
> + * path to handle FDT loading. Platforms can override this function to
> + * implement custom multi-DTB selection or other platform-specific logic.
> + *
> + * If this function successfully loads a DTB, it should set *fdt to point to
> + * the loaded DTB and return. If it cannot load a DTB, it should set *fdt to
> + * NULL, and the standard distro boot logic will be used as fallback.
> + */
> +__weak void efi_load_platform_fdt(efi_handle_t handle, void **fdt,
> +                                 efi_uintn_t *fdt_size)
> +{
> +       /* Default: do nothing, let standard distro boot handle it */
> +       *fdt = NULL;
> +}
> +
>  /**
>   * efi_load_distro_fdt() - load distro device-tree
>   *
> --
> 2.34.1
>

This is working at the wrong level and a weak function is not a good
idea IMO. You should have a way to determine the compatible string,
not a particular dtb, so that we can use the normal FIT-based
compatibles-string matching to boot, as is done on Qualcomm-based
Chromebooks, for example.

This is the sort of thing that a sysinfo driver could provide.

Also, for this particular platform, are you using grub as well?

Regards,
Simon
