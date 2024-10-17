Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DC8D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54C389100;
	Fri, 18 Oct 2024 01:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oA2dKHm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D0A89139; Fri, 18 Oct 2024 01:11:54 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E9789065
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbd005d0f9so10594836d6.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206711; x=1729811511; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/thQMT9ITRj7D8EkZPBaHyECj8EHtwEOHvZhDfkszOk=;
 b=oA2dKHm/Sb6TcWWi54N5eOLODOzdUHiVtzrHXqaPQd4jC7L87+PQotQY5kxtzH7V76
 C00uaXzNCeuuRuBJoc2Kx7/r2B/1Fru1L4i64D9yAg0f6wL0/HKrYBKAj6rO9wKA/8C+
 1yfYbNTQvfNfu5OLE8kCaU3pl1ntLisXDMZyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206711; x=1729811511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/thQMT9ITRj7D8EkZPBaHyECj8EHtwEOHvZhDfkszOk=;
 b=oYDhljuVr0+0cboChpMIiKT48RP9SldVL+6uCCvyl6SQKm9o+s1qo5lLQ3E+20vJRt
 VGBA9cxE4d1BQnRh2gaUUA8tUPtW53cbob5WSL2nmcgBT+iOPUKbEAxur0pIw+GJ15Z7
 /GnBItfc7UiRfaBGs9C9MmIzv5Z2sOcqgNLZrF/i8xmH8mv2puLLadCxr3lq5ZC6wYrf
 WYsqMLi1cn7sZIKfBj4Vlhv3Q4C71F0d3oUmJbLQDdg82dcGrqCppeje9vpyR8dSkD+k
 gWspaxmKyTO2BnfAvt4+LX14z6IMPzWgEQI0lnxxuiFRMcQSccmxQ8oWFySCtgTUV5e+
 yGYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHjwm5GU2bBBfKXR0HHDjm9dVhLmn+BspsZq1N5njFcP+D1EU9emlseYbDCA4OFflFtR4cOxQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxLvhXJeOeaI2nXOvzWoAg7WmRR9tJFGkgQLWdmtMrkA//uHzhs
 dpxOS+8atIrSMKiCFZdaIZRJlDDbAYYTjRizOCg3FP4W9+5mU6X8FTXvtUykXm0lOmkaQGAJDgN
 F7X9mZEIyQ0HV4FF46qWaZQBSOFib0yturR/i
X-Google-Smtp-Source: AGHT+IFwEhb8g1lpDuUvFs0GSsI8B8KGM3BYCSTdYvxA7vaUSbJS4CFC9GSsQVy9dM476JW6qWGRNECbelK0wM/6NBY=
X-Received: by 2002:a05:6214:5d0d:b0:6cb:e770:f50b with SMTP id
 6a1803df08f44-6cde15ec09dmr5750906d6.33.1729206711172; Thu, 17 Oct 2024
 16:11:51 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:50 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTiddxkR3sUj2aZyLf8xe8gQBj-PyuaiDibTQg1skV6VEw@mail.gmail.com>
References: <CAFLszTiddxkR3sUj2aZyLf8xe8gQBj-PyuaiDibTQg1skV6VEw@mail.gmail.com>
 <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-3-andriy.shevchenko@linux.intel.com>
Date: Thu, 17 Oct 2024 16:11:50 -0700
X-Google-Sender-Auth: k3u78KO9Hk4fXrfH4idguTsElYk
Message-ID: <CAFLszTgmhe4QtowWF0_CZURMCbs+kxvqZnj0EhvG-UXb9U+xzQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] x86: cpu: Mark a few functions static
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Applied to u-boot-dm, thanks!
