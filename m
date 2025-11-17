Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF453CEBF61
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 14:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5669C83942;
	Mon, 17 Nov 2025 15:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LUq+F3QB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0810083946; Mon, 17 Nov 2025 15:52:25 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F948393F
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 15:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63f96d5038dso3545655d50.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 06:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763391141; x=1763995941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dLz9f8XSJ9KaoI6Yq9/RKMqmNLT7X2+oRffpHN22w34=;
 b=LUq+F3QBv2Qvp+WikIFU7yuvREUSzXF64t31PsR6tFjPUMTikK7vQRlQ1I2xTAYZGT
 rIdteT8nnfUQ/qsmmM5YwUB1CmcqUG2NdNe4ckBwtZ+l+J0qHBJAXnL0R7WlZnCvU+qC
 rCo65VVHNSMnhWpy7ntMSZp/5mUHpBEnbQ5KCX8Ns7rcKxzc+SK51yIEpvA7Lk8YLkds
 cnOLl+L3t7teTCAQXJGyPpmmra53Hq/eGK3jLV7ibhatbmWmyXCO8QDAVSrZJjTjDDSK
 syHxHaJg+A7+MGndUOQMFlT1xPa3Ml57i8GoXmCNsgCTFsMcTu2CrnUBbKnFRYdlDFjO
 kUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763391141; x=1763995941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLz9f8XSJ9KaoI6Yq9/RKMqmNLT7X2+oRffpHN22w34=;
 b=B30cA8XH81tLUfatzYtVXajE55ZIchWSG26MjurBSCtMF58X7mtPbXuLzv/Sj3hUBO
 dswSxUfxWXCAoZIipOumrPARm3rngNPFYHaAaBBTmCCkTet8YRujGnpA2yqjIdgMr2lc
 wv41BISYM+/WzB+Ww6F02yWIGIy4Yc9g5vJnY3hoXYAG4stER/LMNBcjT2GJcYnOxMrL
 nRG8vPMe+kZjaoNWyCdQekhJzN47KbHc6fV+q2u+kwBrpyP9jsvp52FsD2fNX0gmhmMk
 2DVCOal9Gg8JMYKIM9WeSFG0NgklOflZQpuq0CAZhpzZ1/nyN8XV9oSGOhBH8iXtBj/9
 amUQ==
X-Gm-Message-State: AOJu0Yz0xMyio8pVlIB9mhj0ihJ+V1xSFwiRSVdefS2l+WnBCS55Knth
 pLWCu4BwMaN0xM29jukDWnjFxnrx0o+EGLwmy2eYUcyV6pwz/LEYqd+DRBX9st77GECX0BQK+FG
 iJrnMshdMVkg1s1fC87TadMUZ0Nv5O68DagbqCuTjNY8raQPunL00pZs=
X-Gm-Gg: ASbGnctl/10/aEPUeemSBTr8kntHEcvWIENgxPECuXcWnsDhRkiS8ZlLOi8odUOHdOe
 jhQ3STr5kGJ5UpEN0TWu/TRw+BRgLUvjbH18A5JxB/1jj5+ysKaKbcwGaOWGZnx6xrJtcC7Xo0O
 mG8XnZ25zOBHlKkOg3W0jJjfYqjPAKsLV+5PKHQycap22kg4ZdQkwnJDj14ZUGaWGiO2I1duBhP
 +jFIM92LlpZAr0lcpJUjrWd9SR4gTEslUeIPxDN40q3p0oO4U9hcou4MW1xTSfECg8T4Egifas8
 MpVBKGfw/1ca0/H1nQfFYv3SRWle5jdzPFvRJMrAtdQ/Ni9R0RM=
X-Google-Smtp-Source: AGHT+IHIB7ZH23OE1hlywSP8yby04IwEt8gktp/D8UVpdJ6l6PmLnUXXqhiL4OzaHRfUxj3w5yDO1ok2TdfLapo1rqM=
X-Received: by 2002:a05:690e:4312:b0:640:c9c1:a329 with SMTP id
 956f58d0204a3-641e76270bcmr8442739d50.32.1763391141475; Mon, 17 Nov 2025
 06:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
 <20251114093246.56422-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251114093246.56422-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 17 Nov 2025 16:51:45 +0200
X-Gm-Features: AWmQ_blI6PS1uY1WtRPUZgovpXphGokA7Z-Kf46FsGkrq3vfumptiI20ZshmPE4
Message-ID: <CAC_iWjJDMbLuOQtnrKqh_-o9+UVMEmDz3MbfTY_1ND_CfjEwcQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] efi_selftest: expose runtime table address
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 14 Nov 2025 at 11:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Save the address of the EFI runtime as a global variable.
> This allows to simplify the setup of tests.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  include/efi_selftest.h          | 1 +
>  lib/efi_selftest/efi_selftest.c | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/efi_selftest.h b/include/efi_selftest.h
> index 1b708849bcb..4ee46cbbb66 100644
> --- a/include/efi_selftest.h
> +++ b/include/efi_selftest.h
> @@ -19,6 +19,7 @@
>
>  extern const struct efi_system_table *st_systable;
>  extern const struct efi_boot_services *st_boottime;
> +extern const struct efi_runtime_services *st_runtime;
>
>  /**
>   * efi_st_printf() - print a message
> diff --git a/lib/efi_selftest/efi_selftest.c b/lib/efi_selftest/efi_selftest.c
> index 191da7fc451..2b95713afb4 100644
> --- a/lib/efi_selftest/efi_selftest.c
> +++ b/lib/efi_selftest/efi_selftest.c
> @@ -16,7 +16,7 @@
>
>  const struct efi_system_table *st_systable;
>  const struct efi_boot_services *st_boottime;
> -static const struct efi_runtime_services *runtime;
> +const struct efi_runtime_services *st_runtime;
>  static efi_handle_t handle;
>  static u16 reset_message[] = u"Selftest completed";
>  static int *setup_status;
> @@ -259,7 +259,7 @@ efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
>
>         st_systable = systab;
>         st_boottime = st_systable->boottime;
> -       runtime = st_systable->runtime;
> +       st_runtime = st_systable->runtime;
>         handle = image_handle;
>         con_out = st_systable->con_out;
>         con_in = st_systable->con_in;
> @@ -347,8 +347,8 @@ efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
>         efi_st_get_key();
>
>         if (IS_ENABLED(CONFIG_EFI_HAVE_RUNTIME_RESET)) {
> -               runtime->reset_system(EFI_RESET_WARM, EFI_NOT_READY,
> -                                     sizeof(reset_message), reset_message);
> +               st_runtime->reset_system(EFI_RESET_WARM, EFI_NOT_READY,
> +                                        sizeof(reset_message), reset_message);
>         } else {
>                 efi_restore_gd();
>                 do_reset(NULL, 0, 0, NULL);
> --
> 2.51.0
>
