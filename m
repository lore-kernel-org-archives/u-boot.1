Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639D0C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 09:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE3F822D7;
	Thu,  3 Jul 2025 11:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sUzFahJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E503A82A76; Thu,  3 Jul 2025 11:11:29 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA84382103
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 11:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so5342871276.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751533886; x=1752138686; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qpeK4dX7CfknLbPsR/n6tToAU6SvfqtWgQWgi1cpW7U=;
 b=sUzFahJwHUP96KVN0sfGHFgVP4rd4sQIKjm3N8t8oc1DSWlE23Icb5N87+b6uryvnM
 1d9MxF5HF5PPUV7mBINaTTOxl2es5YlbU47LDiMe5vl4jCJXlNTu92SDEI9JTTSUgRYI
 S8UYOjss/I6eNyqlyqvCBRMtFCL5tAGhXyG1XWF9O+Lt5tqv3oH7+7SLeBZv0uxC26vS
 +pm/8G4Ru2vHop/2vabjNacki34D/Zt2QTJaL2I16UPptJIxjbrRc9bz2t3P14/BXIoL
 +spIX3XtFPNNpjLU5/ntLS1ARBIXiqLLGH6niRnWxSq+w3wTHskSZnmlfXZR7hNpsdwQ
 HNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533886; x=1752138686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qpeK4dX7CfknLbPsR/n6tToAU6SvfqtWgQWgi1cpW7U=;
 b=FMIxb/dzmY8Ua7b/v0alHXLUwpn8q/lo1S3pFiKek2vi+THvV9NTP6FrYBWIS23Mpp
 Dfdp9j6rxZszotGw0atwbnOu8vxfV7SONaGTHrGMb1ymHX5OniZzwDv4esopXQiZGPt+
 g9Nfqw3xV0uqu2XjbbZkIdhP6cOF2U7/Ww02fHIDw+btVFKHqPcfNIsSqz+0lYgmAHqq
 Bb5A4C1kSMG7WKA6l9U2PcuBORubr3nksagax/iv1UqFUuEVQToqIAsGEqPyQuj7WlXB
 DD7XsG9WIqE3bUx+w8yv8/zTGRW+zVTJKo0ntonJ8/RxMcT4WLs5vrZnT556Q9LwnM/P
 4mRw==
X-Gm-Message-State: AOJu0YykYcenbU9GfpzHBMpkSPVReEhkMooT14/WKl2F4oiNDNZRGJ5V
 2ht/GC3k8wFDNNE7cyCHCKOAIB231f0D5HaOY/Xgz32ZoLjfL+mGpFHvskSQenOHj6bttNmwvTL
 y1VuregdISCfmZoKZd5gwyy0BjqjvKBOdIiRzvpo8tw==
X-Gm-Gg: ASbGncvGnT3OsozYoWvVnLXR/A7zcMjMzeiouLWqKiQ1YfHxM7+TqRHSRSPH773C43Y
 E5iOjPzNIqRW5X/ISiptoQbrLXkWAnZCz8+WupSE7Pgdc+v3vCRf/QonzGSunT05odnr9qJbS/o
 XZPit5Y6EvUkgsXwOf652EtiHFDjw+NTr3QKSB3ZPoDuWY
X-Google-Smtp-Source: AGHT+IEA5ik6kqTUnFbGZzGx7UXoI44Y0mBKxQoRxQiu6OwLQlo2+PVPK/5Rpzu9YF0Q5pmziTviLDsel/xFe628H28=
X-Received: by 2002:a05:690c:7105:b0:70d:ed41:f979 with SMTP id
 00721157ae682-71658fd7220mr42533617b3.1.1751533886562; Thu, 03 Jul 2025
 02:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-4-paulliu@debian.org>
In-Reply-To: <20250703062811.72871-4-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Jul 2025 12:10:50 +0300
X-Gm-Features: Ac12FXw_XM3w_G0xbisnPvwzw9ElHgVqv2MxwsUkAOmBl7-Kh9k5dDYiB2P2-7I
Message-ID: <CAC_iWjJNHa0NYr=hB7pRyN-E02iwhKaOXfYfv-LyG9_JoObJjw@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] lib: efi_loader: efi_memory.c: add efi_realloc()
 for realloc memory
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>
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

Hi Paul


On Thu, 3 Jul 2025 at 09:28, Ying-Chun Liu (PaulLiu) <paulliu@debian.org> wrote:
>
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>
> Add efi_realloc() for realloc memory that previously alloc by efi_alloc().
>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V4: Fix efi_realloc return failure code.
> V6: Return error status when efi_alloc failed.
> ---
>  include/efi_loader.h        | 10 +++++++
>  lib/efi_loader/efi_memory.c | 58 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index d0c72d0bc58..13ca2ec9a4e 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -878,6 +878,16 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
>  #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
>  /* Allocate boot service data pool memory */
>  void *efi_alloc(size_t len);
> +/**
> + * efi_realloc() - reallocate boot services data pool memory
> + *
> + * Reallocate memory from pool for a new size and copy the data from old one.
> + *
> + * @ptr:       pointer to the buffer
> + * @size:      number of bytes to allocate
> + * Return:     EFI status to indicate success or not
> + */
> +efi_status_t efi_realloc(void **ptr, size_t len);
>  /* Allocate pages on the specified alignment */
>  void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
>  /* More specific EFI memory allocator, called by EFI payloads */
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 0abb1f6159a..1570e300570 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -666,6 +666,64 @@ void *efi_alloc(size_t size)
>         return buf;
>  }
>
> +/**
> + * efi_realloc() - reallocate boot services data pool memory
> + *
> + * Reallocate memory from pool for a new size and copy the data from old one.
> + *
> + * @ptr:       pointer to old buffer
> + * @size:      number of bytes to allocate
> + * Return:     EFI status to indicate success or not
> + */
> +efi_status_t efi_realloc(void **ptr, size_t size)
> +{
> +       efi_status_t ret;
> +       void *new_ptr;
> +       struct efi_pool_allocation *alloc;
> +       u64 num_pages = efi_size_in_pages(size +
> +                                         sizeof(struct efi_pool_allocation));
> +       size_t old_size;
> +
> +       if (!*ptr) {
> +               *ptr = efi_alloc(size);
> +               if (*ptr)
> +                       return EFI_SUCCESS;
> +               return EFI_OUT_OF_RESOURCES;
> +       }
> +
> +       ret = efi_check_allocated((uintptr_t)*ptr, true);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +

Don't we also need a check here that the memory type you are trying to
reallocate is Boot Services Data?
If someone uses this currently to reallocate memory, it will change
whatever type he has to BDS.

You either add a check or better don't use efi_alloc(). Use
efi_allocate_pool() and preserve the type.

> +       alloc = container_of(*ptr, struct efi_pool_allocation, data);
> +
> +       /* Check that this memory was allocated by efi_allocate_pool() */
> +       if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> +           alloc->checksum != checksum(alloc)) {
> +               printf("%s: illegal realloc 0x%p\n", __func__, *ptr);
> +               return EFI_INVALID_PARAMETER;
> +       }
> +
> +       /* Don't realloc. The actual size in pages is the same. */
> +       if (alloc->num_pages == num_pages)
> +               return EFI_SUCCESS;

What if the size is smaller? Can't we just free the extra pages
instead of reallocing?

> +
> +       old_size = alloc->num_pages * EFI_PAGE_SIZE -
> +               sizeof(struct efi_pool_allocation);
> +
> +       new_ptr = efi_alloc(size);
> +
> +       /* copy old data to new alloced buffer */
> +       memcpy(new_ptr, *ptr, min(size, old_size));
> +
> +       /* free the old buffer */
> +       efi_free_pool(*ptr);
> +
> +       *ptr = new_ptr;
> +
> +       return EFI_SUCCESS;
> +}
> +
>  /**
>   * efi_free_pool() - free memory from pool
>   *
> --
> 2.39.5
>

Thanks
/Ilias
