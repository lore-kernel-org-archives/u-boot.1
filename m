Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F7BE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 14:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A3680200;
	Wed, 11 Dec 2024 15:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="flR/x9uL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE108022F; Wed, 11 Dec 2024 15:45:40 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6EB801FB
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 15:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6ef7c9e9592so65421057b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 06:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928336; x=1734533136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kw85BGldM74UGx0mALy3V0bSJ+9RzutG7mk6LIhi950=;
 b=flR/x9uLfdrQTErCS5LzIH+vUoRQpjG3U+5DZuUmxVMtaSf2plcrJijkNBONP1ZONc
 zkwBrEvyIKRf9n7M/VmDgRKr6dObTkXzogm1YqqfFi3vdZUMaKgceB+apCuG3+4P02t+
 +DOdvvWSVMDp4JVSPeu7heKRX/uJGni/kjkSdOZFyk1yoSP41gg3l4dnC21bcEYwMKXC
 qnUz9AthuZN80qeGs2+ktfyqGO++aKL+AsDhiavU+WYtPjg0jEBrhGbDpf4NPrZnjF20
 dP8CEVk44Dh/E/yfSQtWL+XL06Sxg2Uiob2NHaJSVO5QXIrLLRGjGt9SAZ9a8OI58GbU
 vZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928336; x=1734533136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kw85BGldM74UGx0mALy3V0bSJ+9RzutG7mk6LIhi950=;
 b=CUZy2PKuIhkphISGJjZnuDrzRQOUq26RcppVxrUv1Lxrvr487Dkf2REYT74a+2x5JL
 clab1YTtW1517DiZ65GonYRYCg9uPCfiuoQoO4ERE2hfNg7La8PFjOSrB0q0sayTHOZV
 luSx0+H7RMehUX+GXRHTIn0WWHCymV1McCL65JpaKYlTDBlOL2uXeTkbJRz0uugJ7t4s
 POx8ieLREDB7NMVwnRfqn2AHsrC2D+/FNvd4kSkB5rgtVXdxWkk+7v3aAqojGDEd4S3Q
 yFcexBsQZALJpywCqGef74e1RifkQISoHuxvh2LVvyD09hwNHLzb87DlAMegl+vJLJhl
 M4lw==
X-Gm-Message-State: AOJu0YyGqJKlOjVdg9G+9LZym1MhMx5c3dhBtgQmkTZyX6u1yElM6sue
 KEOf/DsKP5oTNsiQy6KiI7i6Ps5vzAzD0auUUDt1LKWEsL3wMVF6wZYCEXeerN2HHFYNb7nLUrs
 1rsBnUzi/Pkobvbt8tOXKYE1B1HIaIyadsS+HDlWxJXimB3Nv
X-Gm-Gg: ASbGncv68fsU5TfhkhCYpY8FHdI391QctuvUldsAI1Z2CTdqJT7GLMuCOnj723nakUA
 cCVdugUsqld7DwNpdPUgTz2QoGn+9RrLcS6U=
X-Google-Smtp-Source: AGHT+IFzXYeaPvBSwk6KXQ9HILDgEjD6gdL7GrVsAQm4jUpsGrwGLWrvw0lnJxeroLNvvL7rEqQYd9K0IH7cZerVqko=
X-Received: by 2002:a05:690c:6713:b0:6ef:c688:1b8d with SMTP id
 00721157ae682-6f147fa0151mr34730807b3.6.1733928336382; Wed, 11 Dec 2024
 06:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-2-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-2-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 16:45:00 +0200
Message-ID: <CAC_iWjLhpi5Wmd8569vgRP3O=CSoQUgLAaOYg7LyY_iOHG+U5A@mail.gmail.com>
Subject: Re: [PATCH v5 01/23] efi: Define fields in struct efi_mem_desc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Matthew Garrett <mgarrett@aurora.tech>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

[...]

>         u32 reserved;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 39809eac1bc..ee0cdd36500 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -788,8 +788,10 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>  /**
>   * efi_add_memory_map_pg() - add pages to the memory map
>   *
> - * @start:                     start address, must be a multiple of
> - *                             EFI_PAGE_SIZE
> + * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
> + * is actually a pointer provided as an integer. To pass in an address, pass
> + * in (ulong)map_to_sysmem(addr)

Why is this a pointer? This is the physical address of the hardware.

Thanks
/Ilias
> + *
>   * @pages:                     number of pages to add
>   * @memory_type:               type of memory added
>   * @overlap_conventional:      region may only overlap free(conventional)
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index e493934c713..f1154f73e05 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -384,7 +384,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>  /**
>   * efi_add_memory_map() - add memory area to the memory map
>   *
> - * @start:             start address of the memory area
> + * @start:             start address of the memory area. Note that this is
> + *                     actually a pointer provided as an integer. To pass in
> + *                     an address, pass in (ulong)map_to_sysmem(addr)
>   * @size:              length in bytes of the memory area
>   * @memory_type:       type of memory added
>   *
> --
> 2.34.1
>
