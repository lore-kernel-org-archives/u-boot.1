Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51ADC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 09:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FB78129F;
	Wed, 19 Mar 2025 10:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x2twMViK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9CB8141E; Wed, 19 Mar 2025 10:32:12 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE04781101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 10:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e634c42a296so5365707276.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742376729; x=1742981529; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/2Ib0oeyN7MeDDK7vg7hquCMft2Suzz1ggMdxX7KcRg=;
 b=x2twMViK1SGXiMeWt+yg6N4TCJtdDKwMXH8k+FqSw51OgJ0nAJgQI7T3FAlICjPrEg
 YcsTmRrbCQdOadmqdno6caJuUtt5QvhHnrWxqadTLvdAyRbZO5Gd2SRpMBs5QsKABXro
 W3b32a3LWkfrKbVojk4Obd4FwTqhSVBekSLxnIt9HX5mTl3kqRRqCXFWXnPfpf6KEwy/
 jUonJZ1+klPnDFGEe90nvuddNDgORtjlI9MmiBOdgBPqlGfsEKaKvBYST6k+7sSDsRTv
 NnkkCAI3xYbzybesJpEyfp1lJQVBVRM/YYcF3Ea//2XjR1sJ04Pbp8OcRchREeGxHWRO
 wh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742376729; x=1742981529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/2Ib0oeyN7MeDDK7vg7hquCMft2Suzz1ggMdxX7KcRg=;
 b=eQit9eGzk/P+hJJJI1+lho3Poy+nrkxZUA8DXq8WfwSFQJmSHEQtidMnOCnLYqOWnc
 INm/CRHqnUCe6R+DZyloqRENT2ufrY614MAbFHZJv+EzNEtGlJ5T565WziusO1HtlXOS
 M1UXUMQqXimKNak75EmwH87KFjHyvzzBqGnkklCCe9ni0nc5Om2IYhSiKn6xLkqEEzTU
 2e9PQDiIyHvFz/AHDN39Y7XfSA1kFoau1kiO+g7AtvLA3ZcHnKTMQ0t0jVq1zDZBa30b
 RE1mx5eiSiPekOeO3t6LjtuAzebhBi+od0JFISSnTzDQGw/fGmloTX/iHSjtHZrFF9hL
 TrOg==
X-Gm-Message-State: AOJu0YwvgiFW596MoZrfG2xrmD0gsRCKGXLRVbMLoL9jDUKwCbQmqpXK
 FhXdFJwaeYx32pXbiZCcWVjbbFbpD4CxsIyenlSphVBU4x0jKJW6QBb8tOOtV9B+8dUVs/XjJhS
 vNi4aQpOEcM7M385tBLRf3VvAbmsuHWpvnX6rzw==
X-Gm-Gg: ASbGncsvTwD7KFteEs8Xa1ezMQz4gX/6svwASXOw2kfkDc7BEmL47Tz37WK/qDvA1cx
 9d1cDqcflm3Yuu7bbpoEfhRylsXs1o2cGbpwUkl0EaWaWyp9fmX4qRc8IXgfjXildyHcG4uIwkZ
 obqbz8tjfTViXAm/pLwsfW1IsU8VA=
X-Google-Smtp-Source: AGHT+IFQv0BZr90WXBwV7oL7evLgJOQWoLkRkfcyDpN3YdhzAy39bxHCe9cLqV9VzxX7iQOWbFK6SbN/3mrf0asyF3E=
X-Received: by 2002:a05:6902:2388:b0:e63:ca12:7733 with SMTP id
 3f1490d57ef6-e667b3a9747mr2644258276.10.1742376728815; Wed, 19 Mar 2025
 02:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-3-adriano.cordova@canonical.com>
In-Reply-To: <20250318132347.646703-3-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Mar 2025 11:31:33 +0200
X-Gm-Features: AQ5f1JpZvk1P_KvGuuGRm2bbaHrp_SDvqcO-4bcnB_tlIa_JFsOFNK-1ENowpXQ
Message-ID: <CAC_iWjKA8tzKdcRSUPWVdDkRNf2GEiz6dzbM6J6A+f788QqyJQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: binary_run: register an initrd
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
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

Hi Adriano,

[...]

>   */
>  static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
> +                                     void *initrd, size_t initd_sz,
>                                       struct efi_device_path *dp_dev,
>                                       struct efi_device_path *dp_img)
>  {
>         efi_status_t ret;
> +       struct efi_device_path *dp_initrd;
>
>         /* Initialize EFI drivers */
>         ret = efi_init_obj_list();
> @@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> +       dp_initrd = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, (uintptr_t)initrd, initd_sz);

Why do we need reserved memory? What the EFI stub does, is allocate a
new memory buffer which you later copy the initrd to.
I think Boot Services Data is enough.

[...]

Thanks
/Ilias
