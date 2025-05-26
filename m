Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A85C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399A082DB7;
	Mon, 26 May 2025 16:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Br+3qdy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B8F82E17; Mon, 26 May 2025 16:12:08 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1808E82D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6ff4faf858cso14720767b3.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748268725; x=1748873525; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kHdnD0PGrzVHc19W4DPSxzGO7SnR62p0SaWa72YkkGw=;
 b=Br+3qdy6/bKHy5OBolts2zwznnhHPZSSGRBVgslKU3yA/G58uTIOAspxbChj/dLSJp
 qt7TZPVr9G+6vgZ2YBlWkRyMHTcBoOgicDsZvlhcyMTeKcxC8HUdYykRCRj9om+K5+cW
 0rsjwT6/IbA88QCJ//pMHbFddI6TjMOiaA2ZYAfjyo40Vq7pnJHmeefVdNF1xQvJ4XT4
 IevOq0UouW6HIlRBeJO6ISrvXJydvtmUhc6XR5DKHf1F8rd8JI28xwQl4vGdnqLj00k8
 l9t8ISj7eCkCMnIqitAVZg9x/XdS6spOAM8tqEQro3i6ZUzfQx02ASnPXrQ09bOjUNmg
 qFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748268725; x=1748873525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHdnD0PGrzVHc19W4DPSxzGO7SnR62p0SaWa72YkkGw=;
 b=FjXPXeT4Q/Y/GlE1D4bQZmBOhaQfZYVrvoA245sUEDEVaqdFjsKjsXj6kVatKhp19m
 b8502grBwzkbDXHf8wO9Eb7FQS5pH52RhQ0M+B9hpmsqGkMmUgq+ncykAv4g7peQIhxw
 CA+eujcjp5rv4zGKY/+7jj9NCeZUIHFaGfN+ZF0XfTheZ6v8Y98NQMBmAAJsSd8kAlNM
 Vs+Dfr/LXvLoAeGPUgJwc3c7CLIWfkSg4OWVLOS5pGNocyYdjXkGRt5ASBV507kvCqOe
 KPDn/nBUdhptiNU2wieg3lIUXVggxOZw79yUXBoTdYp3th5Fna1hHfivSEyEIkHBFHXV
 hzLw==
X-Gm-Message-State: AOJu0Yw6DNbywAGXZW4E0u4UgwlZCadIntfQ8j02UqanNeftZoYJr0vp
 xhx3ZpkDkSjj++wyeLO/YhMy3pUK3LAFMhK7Dz5U6xdA44TzvWQd5XNjTyuI5/lxEiCIkXNEe3b
 sR3Msby68mf83EubgDg87CTvE/5yycHa96ljjYdetZA==
X-Gm-Gg: ASbGncu3SXM20kRqKsLwLEiUOdzTqJ9J9aaF85uHs3nZGd7CMyBVgasgPbDWVw3Vitg
 CkhELmcNM3rF3Q+L/hRRQSPtuPdKAYWH9ANWD23yNMbQsSCOPNNWjTp7Hb6XKoab5eL1Z5ZlFD4
 HpYTKwc/s9bCPbt3tY07m7+/hHpyPXUYgg5g==
X-Google-Smtp-Source: AGHT+IHw2oFy6dqCYmT8OrmsqAsZdx5IoH/hdZJcf5OZGXtpfNg05SnlmkIf3v0CyWZ0aY0GC4L7bwdLGxeyUL2bhCE=
X-Received: by 2002:a05:690c:7405:b0:70c:965b:4700 with SMTP id
 00721157ae682-70e2db1597amr100771687b3.31.1748268724859; Mon, 26 May 2025
 07:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250522011749.3498970-1-paulliu@debian.org>
 <20250522011749.3498970-4-paulliu@debian.org>
In-Reply-To: <20250522011749.3498970-4-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 May 2025 17:11:28 +0300
X-Gm-Features: AX0GCFuT1p5jQahUa4PFMQMxaDOuAf8u-_lhEi33Dw-wsBTd7fvT5VN4yqndAHw
Message-ID: <CAC_iWjKTN6vLH=Fdp1ncqu3oM+0oqX1PsJ4jbdOBzCBHbdd4gg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] lib: efi_loader: efi_memory.c: add efi_realloc()
 for realloc memory
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Paul,

[...]

> + * efi_realloc() - reallocate boot services data pool memory
> + *
> + * Reallocate memory from pool for a new size and copy the data from old one.
> + *
> + * @ptr:       pointer to old buffer
> + * @size:      number of bytes to allocate
> + * Return:     pointer to allocated memory or NULL
> + */
> +void *efi_realloc(void *ptr, size_t size)
> +{
> +       efi_status_t ret;
> +       void *new_ptr;
> +       struct efi_pool_allocation *alloc;
> +       u64 num_pages = efi_size_in_pages(size +
> +                                         sizeof(struct efi_pool_allocation));
> +       size_t old_size;
> +
> +       if (!ptr)
> +               return efi_alloc(size);
> +
> +       ret = efi_check_allocated((uintptr_t)ptr, true);
> +       if (ret != EFI_SUCCESS)
> +               return ptr;

This is a bit weird here. If we return a pointer how can we tell
success vs failure?
I think we should return EFI/SUCCESS fail and just pass a **ptr as an argument?

Thanks
/Ilias
> +
> +       alloc = container_of(ptr, struct efi_pool_allocation, data);
> +
> +       /* Check that this memory was allocated by efi_allocate_pool() */
> +       if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> +           alloc->checksum != checksum(alloc)) {
> +               printf("%s: illegal realloc 0x%p\n", __func__, ptr);
> +               return ptr;
> +       }
> +
> +       /* Don't realloc. The actual size in pages is the same. */
> +       if (alloc->num_pages == num_pages)
> +               return ptr;
> +
> +       old_size = alloc->num_pages * EFI_PAGE_SIZE -
> +               sizeof(struct efi_pool_allocation);
> +
> +       new_ptr = efi_alloc(size);
> +
> +       /* copy old data to new alloced buffer */
> +       memcpy(new_ptr, ptr, min(size, old_size));
> +
> +       /* free the old buffer */
> +       efi_free_pool(ptr);
> +
> +       return new_ptr;
> +}
> +
>  /**
>   * efi_free_pool() - free memory from pool
>   *
> --
> 2.39.5
>
