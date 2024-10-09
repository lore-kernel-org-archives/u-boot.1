Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC88CF042E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6106089119;
	Wed,  9 Oct 2024 03:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MnbaBQkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C6489121; Wed,  9 Oct 2024 03:57:02 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3D5890F7
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbcd8ce5f9so23186d6.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439019; x=1729043819; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bKwOuWxx5ex1vpfuDi9avUVHI2DwZk6e6bm12D1zLQ=;
 b=MnbaBQkVfQm639d5OHYGxtpB3c+PHADyOanB1UDk+x3wjN9CXIT1EwcbpwJ5+09pgI
 xAL4TPknc4/D4PxxEN0IWl2upsd8vu3fKw0T+N+zVViIrwzsZvS8TgUt3LPG5Lg1UAao
 z9tD23uUB29/Jb/Prx2q6tydnLWUnwx3Uc+p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439019; x=1729043819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bKwOuWxx5ex1vpfuDi9avUVHI2DwZk6e6bm12D1zLQ=;
 b=SLONFkOxGoTPPi9rXTPUlwrshhFrCOLysOTTaYJqReALk504oNR0idQP1xXuqfUXnH
 8WeTfGJWstTXJ14UmaWeQbcwrW8Zrp05IukztxdiUSshX4RhZ52xZcNjRec5MdAp36Jz
 x4p7sqHHQ6zi/4mi88YJTKbAwF1Zc2FEHBn175MR3LLb+bq39FCFq90bGOOeojhXcAfA
 PmlqR+6000gwaLPUNsdRMYEOS+/fLyEyJNnyoe+R7AscCzu7oCpfuA3H5wvD8sT/QZx+
 jVTL3gqG/S5adrr9gUMqIqUo/3IghoK7AM6S62QwMrgcXGKiXpt4S6pQ1B96gA7mIstR
 B/SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Ea0uWYSsBioUbCz/c5gUZfO6+2vElPlocLcbuSYk2iibeLlk44EFTtDc7aykz0p+OP+ZJA8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9SYYIpk4jRmiHTxzfLrfyKhP+oDunOX1S65W70Z7m1wzJlpTm
 cOa/zpbCmwI/16LG711ZH1XBAfuDJS1trWQSfq+X4Lhjibnlk7V7wgPx0Q1ynODtOYr/rfoocIV
 x78/fCjPKi6If8PoGpY1ea+R7lwFdGqRWqvos
X-Google-Smtp-Source: AGHT+IE1KfsZ86uxgUZheOLUnRa6EG6nn/KWwxIxkANRX2VvmG6TIX6ULfKTNv9DB8Y4vPSB1lPbDwvqixBwmAqmrCU=
X-Received: by 2002:a05:6214:5b06:b0:6cb:99db:bdd5 with SMTP id
 6a1803df08f44-6cbc955cc9emr22877166d6.39.1728439019491; Tue, 08 Oct 2024
 18:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241005191353.1927660-3-andriy.shevchenko@linux.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:56:44 -0600
Message-ID: <CAFLszTiddxkR3sUj2aZyLf8xe8gQBj-PyuaiDibTQg1skV6VEw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] x86: cpu: Mark a few functions static
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
> Some functions are not used anywhere except the same file
> where they are defined. Mark them static. This helps avoiding
> the compiler warnings:
>
>   arch/x86/cpu/cpu.c:343:6: warning: no previous prototype for =E2=80=98d=
etect_coreboot_table_at=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/mtrr.c:90:6: warning: no previous prototype for =E2=80=98m=
trr_write_all=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/i386/interrupt.c:240:6: warning: no previous prototype for=
 =E2=80=98__do_irq=E2=80=99 [-Wmissing-prototypes]
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/cpu/cpu.c            | 2 +-
>  arch/x86/cpu/i386/interrupt.c | 2 +-
>  arch/x86/cpu/mtrr.c           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
