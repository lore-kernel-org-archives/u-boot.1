Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCD1E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61909802E6;
	Wed, 11 Dec 2024 16:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yJiemrK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FF1802F4; Wed, 11 Dec 2024 16:19:42 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A9AF8021A
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f150ddc86dso4055367b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733930378; x=1734535178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lGEhPcwHZcKeB09Acin5Y3sZ2gcFGlPJQav/UVIV06Q=;
 b=yJiemrK205LnokmgwP9QPXK5rDWA0UKicG67JVKPuxplmw+EdkepKZbcH8MFYg1poH
 oTcgVnVLxfKMNOeIiUr/alfRpP0ydXwclXpScMRvKlvjVQPPBmGdjKKfMt9ugpApZueV
 5DCGBULxOqV6O+P1L4vv2osdW3ae1GmOt8nFJVpYtlYwIMS1ECKVV7Ev2ymgIxajVjzH
 IfaJLny1TMFOmDlwGMJdDRqytoET+FpNMuHqzKYpJmTv0Er/fqe6d6oibvWj1uzCkYcT
 poVrmSA0swe77C7q/RZsrGt9lPhZNJxLX2I5cOAhI32VMin3Vl2A/H29s78F13dzGcAj
 HbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930378; x=1734535178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lGEhPcwHZcKeB09Acin5Y3sZ2gcFGlPJQav/UVIV06Q=;
 b=GrjIHNhLboWgSUtyBtcc+OBx6FjL2KnvJS6DUJn61iTLhDcOTUUF1lJUh4YaIWS2oD
 zjS3iEzhhIsK9UqRFlD6tTEkO5oMyr0IkohNP9XVH0hC8PfQ2BK8C/AeHYcrvLKjveUE
 pbrd4smBt/yRKxVdSvZ2smB6mNi6mLfdrfcVRin75RgmdW5h/ufyLbLOuJGDSKIx0ozH
 amVMAh48BsgWWg2DGLRql2IdrvHtLJU/x2mL+DVpGjUNuPkoEadmtQ07dojPkfPyoRFH
 xm1VA7z6ENf45Av962xJg94H1YGEt5fivH4eRxVJjovcqUr5l9P4kl4nfxH1gdLeedkO
 7DUA==
X-Gm-Message-State: AOJu0Yz7syKSZ3mP6J84RcN/zqzJXQtFwBuMulW1dCyumXBZeumQmiSN
 F2pUM13DQCATZCWUrpSBizcUrHESxHw028/Fvq8AAzSawJ1gJ4wb5g/8z/gO4WFgC7SrCEVk6A8
 1gi+zWUYMboonW6HnsppIVlmsgp0MTPwFxLj9mg==
X-Gm-Gg: ASbGncs7M6I/OH+P1n55fIlR2RMSsLi+bkF+EnGgv0WcwhpAbcm3CZcO5mDzMQ18Ey6
 YD9mhRwchB6fTyfK2IOdToZu5ElBH2MuEHcg=
X-Google-Smtp-Source: AGHT+IHuvLwUJCbBDPvYpf+Zuv2atiNmpgSY8nlDirnwAKHDw23W8NlvdR4/I9pyumH7+OODcB/h7x2WwMDnIzbV+og=
X-Received: by 2002:a05:690c:6c09:b0:6f0:22d3:e148 with SMTP id
 00721157ae682-6f147fd046dmr34554287b3.22.1733930378278; Wed, 11 Dec 2024
 07:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-19-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-19-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 17:19:02 +0200
Message-ID: <CAC_iWj+warnOCWhpp9H4-AUc70Ft-6jRM9tRcZ3yVTKJ1_88FA@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] efi_loader: Don't try to add sandbox runtime code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> This cannot work since the code is not present in the emulated memory.
> In any case, sandbox cannot make use of the runtime code.
>
> For now, just drop it from sandbox. We can always adjust things to copy
> it into memory, if needed.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 0f149f99c7d..6475b94f951 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -767,16 +767,22 @@ static void add_u_boot_and_runtime(void)
>         runtime_mask = SZ_64K - 1;
>  #endif
>
> -       /*
> -        * Add Runtime Services. We mark surrounding boottime code as runtime as
> -        * well to fulfill the runtime alignment constraints but avoid padding.
> -        */
> -       runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> -       runtime_end = (uintptr_t)__efi_runtime_stop;
> -       runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> -       runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> -       efi_add_memory_map_pg(runtime_start, runtime_pages,
> -                             EFI_RUNTIME_SERVICES_CODE, false);


Can sandbox boot an OS? If not there's no point adding this. But if
you insist, I prefer
if (IS_ENABLED(CONFIG_SANDBOX)
    return

at the top of the function

Thanks
/Ilias

> +       if (!IS_ENABLED(CONFIG_SANDBOX)) {
> +               /*
> +                * Add Runtime Services. We mark surrounding boottime code as
> +                * runtime as well to fulfill the runtime alignment constraints
> +                * but avoid padding.
> +                *
> +                * This is not enabled for sandbox, since we cannot map the
> +                * sandbox code into emulated SDRAM
> +                */
> +               runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> +               runtime_end = (uintptr_t)__efi_runtime_stop;
> +               runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> +               runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> +               efi_add_memory_map_pg(runtime_start, runtime_pages,
> +                                     EFI_RUNTIME_SERVICES_CODE, false);
> +       }
>  }
>
>  int efi_memory_init(void)
> --
> 2.34.1
>
