Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8D8CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29529890CC;
	Wed,  9 Oct 2024 03:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NuyhzMWz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7984B890C9; Wed,  9 Oct 2024 03:55:33 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A82F89017
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71def715ebdso3104732b3a.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438930; x=1729043730; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssE3YN2d1hqlssUsax134Jo6cDyIuD45xldJatWeChE=;
 b=NuyhzMWzct8cSCzU7yj5Ekk7MAy1ZJH/JCicqWRErZZXDq2MMdFYGRUGgSiJVKwQDr
 FhCLutsXn/EA7Bk5yooAd7Zmy5p1tTEa96cz4Pbl2blXGRdh+OQtOiP2M/P82+k+ILMv
 SEyrTAV/14TcHj9Ie5+gOVzESZUbCpw+C6x5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438930; x=1729043730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssE3YN2d1hqlssUsax134Jo6cDyIuD45xldJatWeChE=;
 b=Q8/FxxMp9mpx/giEO8er9fTmgQmXRNRiHMQMiCRb52/3ih/WOVXEzeqm/UZI7boL7V
 ACsRyDRAW1+uGUxJFhEfvA8rVRI4ZucF4O8yXbCq2i+yJWIQwkDe7O66DKNOZi3j8bLp
 9bomUfg9I9u0DL7IT4EQJXJmBpsNB9pHrgENmpxul8GwHnBJl+i3Cz9Lmf6SF45n6Y+A
 UX6FOTrB5UeThc6habbFbB7wRjUKBAx5U032Fzb0PbUxj6KJpfqDQfeKgjS5erlKdKfi
 34XqZqh+nJH9f/USqU7l+fPEGr9NVLrXEIEkBs0f4xYvo46WtSF3Fw0tREcRT9NdEeR8
 yE2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnqm3xItQZG2BBg64/Lkdx9NA680RxeALVICKhOHxs/hTccUHIxo/CHx5x8GfHNUXqIHo/jlM=@lists.denx.de
X-Gm-Message-State: AOJu0YwbTDZwOGpQOx99dp2RTgxIAtqwz57JKuSby/CQx76AgLJLrFf6
 HiHjNnYGNVk0RrQORdc8WI7COeUvG4I9Ozl1MrID//86150HCGguHmlOP0T8fs89GDveiaZtMfM
 Y5BVgAGx61h+XvdVOffzlqf37yqsjCzCMemjoGB/HSuTgAQBj+w==
X-Google-Smtp-Source: AGHT+IGxiNXPstqPFqL0GD+ubXMDi0CvjGS466HTQn5OVstRkOhzFeIPIatF2+h0aruWUY4Iv1T6W4aPUdsOvZT3XZs=
X-Received: by 2002:a05:6a00:1894:b0:71d:ee1b:c851 with SMTP id
 d2e1a72fcca58-71e1db737ddmr1402901b3a.7.1728438929680; Tue, 08 Oct 2024
 18:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241005191353.1927660-5-andriy.shevchenko@linux.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:55:16 -0600
Message-ID: <CAFLszThNc-N9+PC9AvSknpGZ66GsfW1Tscd3c5XRvx8kjdBj+g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] x86: cpu: Add missing header inclusion
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Without asm/cpu_x86.h inclusion a compiler is not happy:
>
>   arch/x86/cpu/cpu_x86.c:14:5: warning: no previous prototype for =E2=80=
=98cpu_x86_bind=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/cpu_x86.c:29:5: warning: no previous prototype for =E2=80=
=98cpu_x86_get_vendor=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/cpu_x86.c:41:5: warning: no previous prototype for =E2=80=
=98cpu_x86_get_desc=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/cpu_x86.c:55:5: warning: no previous prototype for =E2=80=
=98cpu_x86_get_count=E2=80=99 [-Wmissing-prototypes]
>
> Add missing header inclusion.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/cpu/cpu_x86.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/arch/x86/cpu/cpu_x86.c b/arch/x86/cpu/cpu_x86.c
> index 6c53f0ea821f..6c32ae499df3 100644
> --- a/arch/x86/cpu/cpu_x86.c
> +++ b/arch/x86/cpu/cpu_x86.c
> @@ -7,6 +7,7 @@
>  #include <dm.h>
>  #include <errno.h>
>  #include <asm/cpu.h>
> +#include <asm/cpu_x86.h>
>  #include <asm/global_data.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
