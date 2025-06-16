Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E74EC71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAD681760;
	Mon, 16 Jun 2025 15:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mminb/Dj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A37A781760; Mon, 16 Jun 2025 15:10:06 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0008070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-710f39f5cb9so43092677b3.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750079403; x=1750684203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ppy3cMzx/3jYDUGaYvp3n9gHDvFckEcroA2kKSOOq8Q=;
 b=Mminb/Djam40W/EU8DCYQjOAjrjuDXW2gO2Q0DLqNhIgrNUvT9gVVL3BSdisR6a/sC
 yc8oLzybi/emMdB0FZCSEy/MX2eT8xvpDYiEeJgZIRXCDfDPo5TZGhqtRRGJrdkcn/Qh
 Hnxe2vd7SUJLjVVy5AebjrY1gDN9m8Ixj9tu4eQYF1v3V6q5n85PalzgOhfqqeuFwrSU
 XTtzxQ70kzai6/nv8dstgZrDi+zC4PJN6bB6NEK2j09dQY6himqh7uAaU1sfmt6o8iaa
 y2aniHhcJ4vcaYv7KdBlqFDcMRGHrL5eHKyp3W+Da8JzKG6/MO8ybE9j0t0ZGybLIhsM
 OwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750079403; x=1750684203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ppy3cMzx/3jYDUGaYvp3n9gHDvFckEcroA2kKSOOq8Q=;
 b=q89LJMZ67IqIB/k7Iyi4hn64RRxQ/R2B/gwjtbPOtgb3NWJsMn/SBIsJmebSGzbfqn
 6YGZIV6jB6lYvSbH+NbXWC/6XE0WdGI3RFkIK6zvTM8577liObk3Iz2KNvAsiDhRSEzG
 JQM1w4H0T2xPPneQzo+nRk6vLDKiFKQuOxQ3urqGg/qXl8HDGTnZm095MB2MDpqSCtLw
 4fyhoeta9FfcTJi55y9sxUtwYtJrNwFQcm/nVBZWpQHE3Rk6YrtnPfm9UJTtEHjKzWoN
 VcBQ8gFjSNh2B5Wys7mdjCvuzWaaSInWjIFRjJC34NQx/lyXxAR/zhdIdeAxOSv+EFV3
 Co3Q==
X-Gm-Message-State: AOJu0YxpEqjOFVcbEL0gocx6QWsafpZJFa++BZkeT9dA2jBG8MDLNtJk
 jdWW13/l2mkPxngGAaJb547dmX6/K8kCmyJ57tAzuuO9FkPV3GQyxUZfzTFKKLlKb+vxhvOLbq8
 pQrPiBzI83FcWKt+mGCijq1E+AcVcItur32KL2GwVrQ==
X-Gm-Gg: ASbGncs4MQDHAVB6GBNvPiUHJlWpcI/mumS0xX4+qb9yPx0PaPbGgoWLiNzcyYWCOU+
 w49H8mAvv1pYbsUlwnuBZuhthwvZKI9njClTikxy3Zxz+9Ie8rIv52rawQJFSENQKsP7S8bwDFk
 t+P4KbTMV7Rw/RRik8TkOOpqhnIdDFqtwCGXgTzPaPRRCr37uc0DXUEkI=
X-Google-Smtp-Source: AGHT+IFJ1MPbKrKISiAgLQKSfGJHaUBQfMXOJvesDDVxQ+pjrCD518CJBzFaTY6KRprnih4psTiipbj2ZvYqzVaWr1g=
X-Received: by 2002:a05:690c:3681:b0:70e:18c0:dac5 with SMTP id
 00721157ae682-71175397bb6mr128329777b3.10.1750079403162; Mon, 16 Jun 2025
 06:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250611050844.210384-1-paulliu@debian.org>
 <20250611050844.210384-4-paulliu@debian.org>
In-Reply-To: <20250611050844.210384-4-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 16:09:27 +0300
X-Gm-Features: AX0GCFu8XPXiBZJsrUNF2CY9NRWXvXlyeOw8QqCKOrUBG-JtxvXFXkHBiQwfzvk
Message-ID: <CAC_iWjLhWKRdGmuwV6OO-yKBbbjE2Kdr=NrxbMoR9Rxy4NYM=g@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] lib: efi_loader: efi_memory.c: add efi_realloc()
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

[...]

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

Shouldn't you check that *ptr != NULL before returning success here?

> +               return EFI_SUCCESS;
> +       }
> +
> +       ret = efi_check_allocated((uintptr_t)*ptr, true);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
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
