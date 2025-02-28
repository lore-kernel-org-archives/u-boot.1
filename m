Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B198C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7113810ED;
	Fri, 28 Feb 2025 13:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FPb+oO8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB72810F6; Fri, 28 Feb 2025 13:02:04 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E85809D4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6f6ca9a3425so18519907b3.2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740744120; x=1741348920; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YrSHR+WUc/utlwuIS/Ioby7A5vY6+DaX2Z8uJSPJMbc=;
 b=FPb+oO8t81zKQH5Isc78WNq9T8JOHXwCI/7sA/tJfCJFeVo3q4IKJGfiGtiIhjUKix
 K7NXRTYrXuJMaEqGc1B98E1srmX12+/camUytR8blZItPf++6RirfipR6DQXixcmZX3H
 S4g0oGTE9JTJrGVSTGKfdZKGJVGVYdHuDuzNdWxLvcbtfAuNbSOVCQpdap6PBxQstjlj
 /izhFsKv6dbwesdn3P/FSGLqw5YBKVl4SkdOGRzhrDCo3f3e3nJLsl3HS6ptMvnblmNA
 VmWCzVCl9PE+LbJnVEx7ny36FMf0PUufhBKwUqlQYgiruxgG8MBnL0BDngK6BUG6ftyI
 jqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740744120; x=1741348920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YrSHR+WUc/utlwuIS/Ioby7A5vY6+DaX2Z8uJSPJMbc=;
 b=RBhagnHt6iCm9MN3DWN80ijgOOEhdxKXC/e4j7TOO3UbtvM8jc2tpCCTh2Wc0b8vz3
 Lkrj3WWI/lQTlO9cTSg4wUsWmm/gr3EQwk9F0f5jy6CtH1XgnzNyCSAiyNOD3kqi9ngu
 Lk0zIy0AKAsc0sYZMGTPNiSsMiX18cOCtKjuRENDjiK6Rm+x3MhgUxYtDvPlAF2r7o7F
 3OF7e30qDT66xHAKat6qblvs1j8TnzMrBPN66v9xcUx1pSvmTMV8/iQ6FghHmSQTJ9Ft
 yqDvawKcGeRz+Dg+aL2xu5JWCobJxOjKlEOxyWfBuB1IQcVFWj91dzWeu3PLMKWjiZsM
 uzww==
X-Gm-Message-State: AOJu0YzDyXMX9zi2Vk6U4JSskgg4ugSYR2KMkAgzzXC/6YZRCtGeH/R0
 TL7wX005aCIWrr2ty3qNpLEKKTedY4ZX26OrZqnmXuTa6RB4HaxQdI1VvtvSNQefa7Qo3lx3lk4
 pOYeaHSN7XkkiOjBpr9A85XiIUA+qfAGrbC1KlQ==
X-Gm-Gg: ASbGncuuwsm7rxh7WA9k89j/FV/zZVsADyLykLWYAgukfv/t7AL0rA22DCaFsUzEidZ
 RcowA52JT+lEOItkvyY2uk6/1sHwKlexoA3RA4Vv4DCMj2bIvc+U0OcNmP+6ggtBeC+ol8AoNO7
 W34c1PxVmViG1VnzE+zvBGVOR4BuJWieDgu25ERXE=
X-Google-Smtp-Source: AGHT+IEv9RsyZaC2UiJKBdSxoZgqK3iGlAlgm4mlieng0m8gQAezz45IdaWMGeIoZF4+J9XV04+S1/u4rGb/YMhTW8g=
X-Received: by 2002:a05:690c:4b8c:b0:6fd:22fb:f21b with SMTP id
 00721157ae682-6fd4a08d05fmr45082557b3.18.1740744120284; Fri, 28 Feb 2025
 04:02:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <2589612a53a9e9feb67b8e8286e87893359676d1.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <2589612a53a9e9feb67b8e8286e87893359676d1.1740499185.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 14:01:23 +0200
X-Gm-Features: AQ5f1Jro0zuPJB2EjVWVTiQpwO_mKwrVLwrRxK9K-WoOaw9p6-wrYqtvISFaAHM
Message-ID: <CAC_iWjKmA3=YpG7=wkfMFN+p8XPJETjhsUtvb9WF3SnkDBm1mQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] arch: introduce symbol HAVE_INITJMP
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>
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

Hi Jerome,


On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> HAVE_INIJMP will be set by architectures that support initjmp(), a
> non-standard extension to setjmp()/longjmp() allowing to initialize a
> jump buffer with a function pointer and a stack pointer. This will be
> useful to later introduce threads. With this new function it becomes
> possible to longjmp() to a particular function pointer (rather than
> to a point previously reached during program execution as is the case
> with setjmp()), and with a custom stack. Both things are needed to
> spin off a new thread. Then the usual setjmp()/ longjmp() pair is
> enough to save and restore a context, i.e., switch thread.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 35b19f9bfdc..8d5b54031b3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -13,6 +13,12 @@ config HAVE_SETJMP
>         help
>          The architecture supports setjmp() and longjmp().
>
> +config HAVE_INITJMP
> +       bool
> +       help
> +        The architecture supports initjmp(), a non-standard companion to
> +        setjmp() and longjmp().
> +
>  config SUPPORT_BIG_ENDIAN
>         bool
>
> --
> 2.43.0
>\


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
