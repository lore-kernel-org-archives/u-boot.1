Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C13CDB471
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 08:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA076848BA;
	Mon, 22 Jun 2026 10:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gX8SzYcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347B3848DC; Mon, 22 Jun 2026 10:04:25 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3ECD84832
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 10:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-662dc3879acso3630721d50.0
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 01:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782115462; cv=none;
 d=google.com; s=arc-20240605;
 b=gmDy4zphYGsRIYWAatyqCgABq8u/VZkxaUluxmG3IYrvC9tQP1aWHP6mLio2e4N4N5
 wncLdHbMzQ/w8lAtIc6oFB96GBLoqp6Pc6O5n6vgnvCQ1mDQQ7+zK2kX8xwSBTWJpHLD
 hlJcl/t2G6xQM+aoigup1Wwu/FCKKsaxow9gMhTjK3L4XkNdJmmdAaHK25S01W4tEOnz
 lB0dMjSvs+C/UNNOAMTcQElZ8OhQ2uMcswzwJYAyq7ELDII2xfHOBCWEaaYstErlfo9l
 jlghSW3zAeSeUv4m7Hc3cnAxS0p48ujoin+BrOawc4qgwjzYKbRP4LZCCo/s2/Uq3oTM
 PNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=a4XYabP2qFZTEBt1iCtD19+be3qmcHK7nWd5pdkX8Oc=;
 fh=0G8wOfqcebRkhFk1zr8IqT1/qppHAlISwH/QHkPv2L0=;
 b=UqVFiGra+12iNlYvZ/P+KEum0eUxXLmUBo2Wa3xY3OJRz0CGWgeK+yRJgmv0MA3LDB
 u7RwUAOJs7CHLzPZtwjje4a7rJXXQSqSXK7iUdt4DTgiGwyzTWa0UQmpImK0ynPnaVkr
 z5ibWSbNhESWnXN03wpHxXWBtJ/l3yIIHkuWBDvzTZhFBcCdVaBXUqXrEuEXZBthq0g1
 rVL7J+dOn0icpeCY7/6O5RsdVfkvo457eGoMFA5Ebt9TS0rRv+V+syXNgT0hT1NoedYm
 IJOeHryJhccb5MwelJQlMiwT3q+cgd3lONHAUnPmTg4YYcTdRWyzXuihYrtpjhn+m/ld
 1daQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782115462; x=1782720262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a4XYabP2qFZTEBt1iCtD19+be3qmcHK7nWd5pdkX8Oc=;
 b=gX8SzYcZQxWflXf6rsqGFQj+I5Guxlxatsun73nX9e+AKUTrCXK4UB2IPy/kpqwOVd
 XQGKThrnaa+pfp6m0OtS0IHNAk1EATIzz3/md8B+8fPEhre/3Tmkeq9shA3fGNauJYy7
 sqW2dHNnCUhdarP6NZNUnLSZkwoPp9Zw2gzAK8NPY87b55nTtrxTFFsG1uw71Xzwbb2F
 a1TPuOWb9qLLuBOGfEEFho8m5u8onkpjdjV9naxIlP5+3GHYnT/krFasdNnLKUjUDrsf
 4GrtLdhtVQXFWOemvhsW6SPMNk546hedUos17542PpjaqgysTnYD9cFOtK6nwR7/KWje
 Be4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115462; x=1782720262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4XYabP2qFZTEBt1iCtD19+be3qmcHK7nWd5pdkX8Oc=;
 b=X/hYehPVtm/T3KteYJcBTU0lzSUPMpsxTfwOkb+sAx+JcTinMcS4tqJPNy8mG1OQPi
 02JkoZd8Vs4Meuhxy34QcDAcZSfCaWSJohurfYGWZ5TJqODSYBRK0Ddv+FWyCOKeoD+M
 kEzp/nnrdRQeI+fZu0/gDRghpR8RsbwYMnbMjTmI+318Awxcdr8Q8OD2E46xdKUY8XRC
 s1A4h4SI9lyAiZwkkoBu9PAbZmwa4Wf8GVJZkPprxGxK4q8DMlwMyY3Fpkg46R0D+YiR
 u1i6pEMduhXU/D3WSpldwNZ4d0PsekfXOM1o0PONTZdTqBDtnv+nTNiXFtYKl0QzFUlJ
 7roA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rri029jppFj3dYyzQYZzYZZQp5Ecpok4mL/kukIqTXBqY2X6N8EZDcN07uxpgJqlEX6lm/Xivk=@lists.denx.de
X-Gm-Message-State: AOJu0YxvfkkdANKDpaVNq+FBRTzSkWNU7Xpr4Xltk3qAR5ATz071Lqem
 LZH3a8go1GPtebG7dKT6XT4WoAemlMmQDQgjjNCndTAvRGjDCrtWzFg/Z8FxZRS1wrTSPpR415J
 lMKmCcQxTN73DYFdUVf3B5HLIFotVHnn0iNzkXedJXg==
X-Gm-Gg: AfdE7cmizrJ5ui7X/FA8iodC7bse5lDJIuXBLeMl4sU/FcMfRD4AL3StfZ8Oz+9vwVg
 V5+06ZhwYypWcwXnBRrrEUVgJKuEAjK9XfRRfZqCiox+63T9TKsvvrsuFn4X/rQA/M+EBbv/qHI
 o9q3dtjm9BRp0s3ef/g3SsBx3wYoDodc4TbHWf61BFmWC9dr7lcWNTPDY/khj1yCGbisc50+M1+
 4INc4IaquB0+i9PpbawZvX2K/I2QUNgGhhLWw6yqeJ+EUkUcb+ODt0NK78gdnW6muZNparli0Hv
 4xoe3Mi7UETRQruTv/9PTUpP5LV/KV55NESSNvs7ouER8Gi3hUupEDwf/G9LQivhgj7q5xXBcjh
 IDPmyYPwkRCVlILApd9OriUDXhja1LmqteakFQWbLDWYUl+wKNyxFYw3pVeGtBwoVgMORyTjx4m
 +PDhQMpDDcekMkNHrZnkKl5O3Y7Mo4yH3WsZkzpEjfxYEUU4hyl8DzLShmbvA1vICzfg2vtTx3z
 /qe+YPj8CFFVjOwNPsabTIPDEVM4Zyy7lWtZnRPnNkp9zRrhJpQgseynToU7OxQHLkawWR6hs5n
 7TXusG+2mvTsWh/czQZQjWokTYLk0AEKVAju8QocNQigct3wlhk722gTk0YvYtoltW/o3xs=
X-Received: by 2002:a05:690e:12cd:b0:660:9c4e:a44d with SMTP id
 956f58d0204a3-662ffb9debbmr11192842d50.6.1782115461706; Mon, 22 Jun 2026
 01:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jun 2026 11:03:44 +0300
X-Gm-Features: AVVi8CewCa_cOs73dZZuRqVhesPXH583s8ke7-7hudHX4h5NqHqpfA9Bvg_u0pU
Message-ID: <CAC_iWjKhmkpzGJOpsVt1Q8ASMcvts7A-3LU+JQowDpatYfcchg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] efi_loader: fix open_file_system() memory leak
 on fallback path
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sun, 21 Jun 2026 at 11:19, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> In dtbdump.c and smbiosdump.c, open_file_system() falls back to
> locating the UEFI system partition via locate_handle_buffer() when
> the loaded image's own partition does not expose the simple file
> system protocol. The handle buffer returned by locate_handle_buffer()
> must be freed via free_pool().
>
> The guard condition read 'if (handle)' (checking the image handle,
> which is never NULL) instead of 'if (handle_buffer)', so the buffer
> was freed unconditionally even when locate_handle_buffer() was never
> called and handle_buffer remained NULL, and it also obscured the
> intent. Change the condition to 'if (handle_buffer)'.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> v2:
>         new patch
> ---
>  lib/efi_loader/dtbdump.c    | 2 +-
>  lib/efi_loader/smbiosdump.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
> index 1e72404ecc1..865edc33a97 100644
> --- a/lib/efi_loader/dtbdump.c
> +++ b/lib/efi_loader/dtbdump.c
> @@ -350,7 +350,7 @@ open_file_system(struct
> efi_simple_file_system_protocol **file_system)
>                                         EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>         if (ret != EFI_SUCCESS)
>                 error(u"Failed to open simple file system protocol\r\n");
> -       if (handle)
> +       if (handle_buffer)
>                 bs->free_pool(handle_buffer);
>
>         return ret;
> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
> index 974728a43af..494c3d18945 100644
> --- a/lib/efi_loader/smbiosdump.c
> +++ b/lib/efi_loader/smbiosdump.c
> @@ -248,7 +248,7 @@ open_file_system(struct
> efi_simple_file_system_protocol **file_system)
>                                         EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>         if (ret != EFI_SUCCESS)
>                 error(u"Failed to open simple file system protocol\r\n");
> -       if (handle)
> +       if (handle_buffer)
>                 bs->free_pool(handle_buffer);
>
>         return ret;
> --
> 2.53.0
>
>
