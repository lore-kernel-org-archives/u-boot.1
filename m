Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A445CF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040F48911A;
	Wed,  9 Oct 2024 03:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HMXGekyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC00589116; Wed,  9 Oct 2024 03:57:00 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EBF38910D
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71dfc1124cdso317277b3a.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439017; x=1729043817; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzQGDHkYZs49UchAEWwYPZYbWh3Ssb5/k/XuPY91nGg=;
 b=HMXGekyRO8wYiauZ4cbtBpZ/TEK0zZi0UARKvwKgmYpwjTyGCVvfTkSiwkoMAtBZ6A
 PgMrpVJ+aWGMUDjtElJZTU2xMzCJTylzSx4iNok7eea/mIHjPPwkKPZgeTyVufWf+xVj
 hajZlUHJ63w5iNSvomYWoTjTrwXX405I0Gx94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439017; x=1729043817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pzQGDHkYZs49UchAEWwYPZYbWh3Ssb5/k/XuPY91nGg=;
 b=XFn3K9hCkGiufGsSL15QvEoE5JD99nn3hsxi+2CzaVnqgxvSF4ll8H1Ihgp0etDfPO
 yY+cCuRrGsBEfphlcDT8m+sxpJerXo3fS98hkfG08wrJkT7NzrtIzzPxIUbz9kIiqpR6
 FJjq5YOFdeo5thY4hxy9AWphoQ/Vy8JQhc5SzszAbC97uohV1RZtLc68IjKpwF70sKaB
 FhPs8Nd9Pf1MLPYIO2wUf+KZ6xkg/rG2T1/9i+Dmh2gD9gSiN7/pR1Pu1c/y7zgj4VCg
 U9niuLlwBPwn29DeC0sgX+3u41znHXWnaZ/UCSwRg0aTPVT4fE0JQ6exOJXeebcSEWdG
 sF9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQUlCNS2Q2ILdZRJJ+pq+SL0YP+FGLbY42kMrQw4AEbud8hK/t01+QrAjPuBlKUU/lIi8oTAU=@lists.denx.de
X-Gm-Message-State: AOJu0YyBBDmPAXxYLSN+ZtWykUXlSRXQyOYjd7SGUaxnAwkhXvlUI30m
 zLIAjdg34QVzjyWS/jArvVlyCLEOg/KbC91rvOJb8ZCCwATmQ6z8D4gMXFo9aZrzEoovXLINSYl
 HhV5NI87pL4N1k2O2egzBqM5kQL0K4GVxE66J
X-Google-Smtp-Source: AGHT+IEfN6ENvjZYC12dHWfRHNxHUtYnsb8Hc7S1ePEKVgBfvUlXYBKCAsNJ+GDgt9ITytnldtREsaBL1UeewYXJbVM=
X-Received: by 2002:a05:6a00:4fca:b0:70d:2a1b:422c with SMTP id
 d2e1a72fcca58-71e1d658e20mr1696285b3a.7.1728439017170; Tue, 08 Oct 2024
 18:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241005191353.1927660-2-andriy.shevchenko@linux.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:56:43 -0600
Message-ID: <CAFLszTivZ-2fExaAkkc+gK3tq5dYwf4uxUXjkj2dhpkpopJKqw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] x86: cpu: Use default print_cpuinfo() for all
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
> Most of the copies of the print_cpuinfo() call the default method.
> Remove all of those in order to have only the default one when
> no `cpu` command is compiled.
>
> This also helps avoiding compiler warning, e.g.:
>
>   arch/x86/cpu/tangier/tangier.c:23:5: warning: no previous prototype for=
 =E2=80=98print_cpuinfo=E2=80=99 [-Wmissing-prototypes]
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/cpu/broadwell/cpu.c                 | 12 ------------
>  arch/x86/cpu/coreboot/coreboot.c             |  5 -----
>  arch/x86/cpu/cpu.c                           |  6 +++++-
>  arch/x86/cpu/efi/app.c                       |  5 -----
>  arch/x86/cpu/efi/payload.c                   |  5 -----
>  arch/x86/cpu/ivybridge/cpu.c                 | 14 --------------
>  arch/x86/cpu/qemu/qemu.c                     |  6 ------
>  arch/x86/cpu/quark/quark.c                   |  6 ------
>  arch/x86/cpu/slimbootloader/slimbootloader.c |  5 -----
>  arch/x86/cpu/tangier/tangier.c               |  5 -----
>  arch/x86/cpu/x86_64/misc.c                   |  5 -----
>  arch/x86/include/asm/u-boot-x86.h            |  1 -
>  arch/x86/lib/fsp/fsp_common.c                |  6 ------
>  13 files changed, 5 insertions(+), 76 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW, this function is deprecated...since with CONFIG_CPU it is shown
by the CPU driver.

Regards,
Simon
