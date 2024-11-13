Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74849D41C27
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 10:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD56489544;
	Wed, 13 Nov 2024 11:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="htbgolRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A6E89554; Wed, 13 Nov 2024 11:19:34 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9608A891A0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 11:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7240fa50694so5269960b3a.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 02:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731493171; x=1732097971; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QYblQ4pBvZCn6xh3pYfrkTpIPlbaGOZnWJZObgjfBQ0=;
 b=htbgolRZYl2cr9oxHeGfSb995YTEpY3YI/2HK9YwE4RczbrgFBBJ2mNNNjIegAcPd3
 6cVfodoSdo0WmTb51PZpLrfEL+9ZtA5ANOfG0Emy4GZ8BMpSDHVMKB311qWoLUvIdEF5
 iXTS5ogXy832SY9O677vL44yS/z6jBzh0SCmqWgHj2TLgBWW2Cw8hq/sBL0HY6m3QYqt
 DYb/iMmLUgIKXvmMvRYat63kDIUCGJ60VAs25A85iqK4OofSymYS6t00/MSuatfLfuX6
 nSEMM/A2T9/qNmTTXxWdTMLuhzdU5JbSsEKRkWROqhdk5aJOOzbQT0vFu9IxaYrIeShN
 lbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731493171; x=1732097971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QYblQ4pBvZCn6xh3pYfrkTpIPlbaGOZnWJZObgjfBQ0=;
 b=JIruUlIBf6SPV5Y2VDa3yVE/TB69Br58AazQUH1whLFuwVh0ok/RCwNuIUBlE3tbqd
 SsMktUO9Jx3Asx24b0nT7Ln7VWABCI4R0wxe1YIJl9IChiXGJgQAEvWlaJUEaMpIlq0O
 lu42qb9FJ2caRV8wyJGtIH9kKBKkAFEkK96OY4oeZR0dhao5RnxR9G22eqz/b1OEzVR6
 i4h6+TsSTUY7SaULntVOaYux0kiuRHtE+AZP5kIUvRztIswS2Wa3o8P0z6dj/36Xc/78
 Nd6+mhd5aIz6BX0jVl0pS/PZSVI6Pgs+PZZmJdjnZXRqVY3osZAolDtq8me5+HTlqwad
 3ZLg==
X-Gm-Message-State: AOJu0Yyb0u7t35XrJFJ3XLMEQ3IskPE/JEqZsNLwhu0z1PuGfq0OK6JD
 xNypUukCZQ9iCO2gn3gnPxJ9kTuIM9srlB47GQ2/lQ1iTTZFoR6Q9SmqKlZ2jKbvISKtpRwc2JT
 XT0if3ahys3SoeCWZl3ly1y3nK7MMU+yHLxM3AQ==
X-Google-Smtp-Source: AGHT+IH0OOea3NzVq6wtyp5PTqxVGn0hfkvkhJ5bS/9nQaZfEx21IWPNPOoQHN1giOFkscqkpasfwT6igQzI8aXvKq0=
X-Received: by 2002:a05:6a20:8429:b0:1db:e870:7b19 with SMTP id
 adf61e73a8af0-1dc70378a59mr3637661637.10.1731493171107; Wed, 13 Nov 2024
 02:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-5-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-5-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 12:18:54 +0200
Message-ID: <CAC_iWjLFFEh4gQQ=TGpr4c-rJrR7xUAwE4A2cnir3N2mJ9rZ7Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] efi_loader: device_path: add efi_dp_from_ipv4
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
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

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> Changes in v3:
> - Removed some unnecessary void* casts.
> - Changed sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
>   in efi_dp_from_ipv4.
>
>  lib/efi_loader/efi_device_path.c | 38 ++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index ee387e1dfd..82a45da1fa 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -974,6 +974,44 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
>         return start;
>  }
>
> +struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
> +                                        struct efi_ipv4_address *mask,
> +                                        struct efi_ipv4_address *srv)
> +{
> +       struct efi_device_path *dp1, *dp2;
> +       efi_uintn_t ipv4dp_len;
> +       struct efi_device_path_ipv4 *ipv4dp;
> +       char *pos;
> +
> +       ipv4dp_len = sizeof(*ipv4dp);
> +       ipv4dp = efi_alloc(ipv4dp_len + sizeof(END));
> +       if (!ipv4dp) {
> +               log_err("Out of memory\n");
> +               return NULL;
> +       }
> +
> +       ipv4dp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +       ipv4dp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
> +       ipv4dp->dp.length = ipv4dp_len;
> +       ipv4dp->protocol = 6;
> +       if (ip)
> +               memcpy(&ipv4dp->local_ip_address, (void *)&ip, 4);
> +       if (mask)
> +               memcpy(&ipv4dp->subnet_mask, (void *)&mask, 4);
> +       if (srv)
> +               memcpy(&ipv4dp->subnet_mask, (void *)&srv, 4);

The copies above seem wrong.
Isn't that supposed to be memcpy(&ipv4dp->local_ip_address, ip,
sizeof(*ip)); etc...

> +       pos = (void *)((uintptr_t)ipv4dp + ipv4dp_len);
pos = (void *)(uintptr_t)ipv4dp+...


> +       memcpy(pos, &END, sizeof(END));
> +
> +       dp1 = efi_dp_from_eth();
> +       dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)ipv4dp, 0);
> +
> +       efi_free_pool(ipv4dp);
> +       efi_free_pool(dp1);
> +
> +       return dp2;
> +}
> +
>  /* Construct a device-path for memory-mapped image */
>  struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>                                         uint64_t start_address,
> --
> 2.43.0
>

Thanks
/Ilias
