Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49426CF0449
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9EB289150;
	Wed,  9 Oct 2024 12:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V1hCHOrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 460D089186; Wed,  9 Oct 2024 12:29:58 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E73C89114
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b7eb9e81eso79299115ad.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728469794; x=1729074594; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xpVlL/ChWvSMub69yFaWxMsHTM67M0NP3ojf+0ekeMo=;
 b=V1hCHOrYtCHvpxVhHFZqnFIlC5Y6yp6Z31xYitDKr5K0hAVngvP/uzIl0oMrJ1MUaN
 7+ioSKnFq46yPfAZRjMRWk+nQJjqwPEa3HrAliH25LgF9h5wilMT4PdERnqsasVQRFVq
 toG405IMV8874/cX2Bxv5QQpCdi2vRcIwnE+f6clIwUG6mbts/lNkOLrjDh6YET7nOeJ
 4WqElgFXWThnRiKsoIDYUUrHaPjYW7x5inixgvVD8Y6ALzW+c8oISHbzlmObIrGLlW2g
 uhjq+IplXscpHUCmSg5/Tr7o/cGn6JJt8EWoJFmaFEm0X/yLt4wUD5AcTZWOniSkjaQ9
 8TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728469794; x=1729074594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xpVlL/ChWvSMub69yFaWxMsHTM67M0NP3ojf+0ekeMo=;
 b=o5jbR0CvQZmh3aD/CzJt3xa8dGqqvpfHEIXUB9srqbHeMGMmIwqJwzSz2q5b7HIQk2
 QtuSUodPYePczBomDJzWKvjVE4spE7LGWtnAsOkDtoQSQDentaRiWFJgPKAVcnB+ygJU
 Xldn8ojH+qb+FqtDksWIL0+tSxNKnF4NwLx9WnUaxQDpYRN0tl8VfKLeCysX/EJXf5B9
 QMLhRYEPWYe0FXczBasPL7vEqzUKvMmTIVePsp8+EbqM05QHwc+JKJHTSUclPGjLyz1/
 nVlDm2ejSHRf4r1BmBTIw9LYM73QsK78A3fW0woB/DaevEtLhQqaYg09l0G0VcS5b8/8
 BmQQ==
X-Gm-Message-State: AOJu0YzOvcOhvfs3coUarNEkjA3zL+dZ4zqrJ3vkGg/CDp/60szGQ8W7
 tEU/ngCWV85y1XqvK9H+QSrnsMNRwNJfJxUCKavkeH01+jQknpCRhlPDMwQzGYdwc5Gpqbx6vh4
 N6Nb0eZM+1H/gyIbyITpBGmq1amThugFRGM1W/hHYVchfZKGNj6w=
X-Google-Smtp-Source: AGHT+IGa/cLwoGIrLFE7wgFZdahTfR1x9HNI0ayjT4LfeOK0GFINyyPcHGdGf+mIEBAp1//l4Tg2xtoAVmzBw/CbsWg=
X-Received: by 2002:a17:902:fb04:b0:20b:7ec0:ee21 with SMTP id
 d9443c01a7336-20c6370ba82mr22133345ad.19.1728469794357; Wed, 09 Oct 2024
 03:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-2-sjg@chromium.org>
In-Reply-To: <20241009015020.25817-2-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 13:29:18 +0300
Message-ID: <CAC_iWjJGwk4ugysAr33Xi=vSUXbLsrrz3NaHYk7RM66QX4GTmw@mail.gmail.com>
Subject: Re: [PATCH 1/6] common: Fix up malloc() comment in reserve_noncached()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

On Wed, 9 Oct 2024 at 04:50, Simon Glass <sjg@chromium.org> wrote:
>
> The function name has changed, so update it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  common/board_f.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 154675d0e40..2e04a47b546 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -501,9 +501,9 @@ static unsigned long reserve_stack_aligned(size_t size)
>  static int reserve_noncached(void)
>  {
>         /*
> -        * The value of gd->start_addr_sp must match the value of malloc_start
> -        * calculated in board_r.c:initr_malloc(), which is passed to
> -        * dlmalloc.c:mem_malloc_init() and then used by
> +        * The value of gd->start_addr_sp must match the value of
> +        * mem_malloc_start calculated in board_r.c:initr_malloc(), which is
> +        * passed to dlmalloc.c:mem_malloc_init() and then used by
>          * cache.c:noncached_init()
>          *
>          * These calculations must match the code in cache.c:noncached_init()
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
