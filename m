Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F5CC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1295C8110C;
	Fri, 28 Feb 2025 13:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gGOaaQmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60EF681110; Fri, 28 Feb 2025 13:02:22 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC48809D4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f74b78df93so18753487b3.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740744138; x=1741348938; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2vuNM4CXNyxYb58yeyoOZzGlju1U6xopDtVwhDG+Ohg=;
 b=gGOaaQmP5BOWddfDkiNUukBLWpa+t5cabiikdKEuKSmO6yZqXQNDslTjYN1mfPqyp/
 suVZqgLx7M/1DB16fAJoxi25kjZrhDIbGYmaVDXCxfCg2qkyScMnkKhU7l6YSRGy5aMX
 cDoDhUskZNScVfKGBWWQTN3f3B6m9fCDNJJjcADwGsr2n22V/o/HqL6encR4tybzmsL3
 d5SeaxF/UGaTwh7HJw+gvVn/qZ6BG03yYdzS9H8O0dDXkrqW2gqqi8puUXLCpaFVPr10
 zk0k/WybTOxZGthpqSr02q9o3WKUCDT0Yb3bzu84G5u/Uoy4N/U07bozTlF3M8Lp0Cck
 v5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740744138; x=1741348938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2vuNM4CXNyxYb58yeyoOZzGlju1U6xopDtVwhDG+Ohg=;
 b=vZkAVHppHRbyO3gXWcXtL9UAbSkdmkdcpSKB1ZSRZt/psDoIc+h/RSxfDGxfenVhWe
 WObG13o+ahkrQaw4cJrH6HFg/eWjt/Kq90BEoHnhlqKDEigybpRp5omZjJOGiWVHe3TK
 1KaCzL0gthTK4gIBh+v4gQ4+m2tWK6P/1BzMU36VnmT3rBzsnNHuBZTFhRJpkzCDwENT
 SJdoHB/ZVnL8dEpk0nP6lCKXezbnfH27HGD+1QsqeBfPcAW/+HNA90jDB9A1/Zy/fyd3
 tBZlKQ+QMg14YR0XSq1pZnikoFeOQXEzaX/QCbI2snnIlHEDJiyF0URlgAgCynpcyXmd
 LF8w==
X-Gm-Message-State: AOJu0YxDbbLG3+aT/EaN2aQwo3DPAUjuc4gEF1GrMCC3JNVnkv6grxtQ
 T88bs+9+ZicGJqVMcy3cEa30ZSrXvI5XfUdhK2Oqx232VwCe/y4+EkcQ8jvwcRwHCgxDsCA8cGI
 oxWm6p+56zqli4njPumydbatYlgQJICLlKs33FA==
X-Gm-Gg: ASbGncuP6dohr+F4UWn/Z6wWp1d48eQzAzG7yV675D4dx4dc53Vrx7qLmSJdyucHT4S
 XCXYwoFTM6zqBeVxfC65qNWlNWiNAmrqgCw5PlMerrQpoddvmge4oy7XcnbB2t3Z/+4mZ67rSYl
 Vk1PwvVU/M9DDdYSvP2ZE1pqKsLpxAzvghyEC1fi8=
X-Google-Smtp-Source: AGHT+IF3lWz/1ArlpK/tshW70FSny11ZetfT3jG6O3jgK/cVwcCqlxEGoZhYi0Q9Fn2KPfVKzR3GURlJZoniG2y/QeY=
X-Received: by 2002:a05:690c:6188:b0:6fd:4702:d7f with SMTP id
 00721157ae682-6fd4a0fce31mr41078737b3.32.1740744138086; Fri, 28 Feb 2025
 04:02:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <bba48e537696016b94faa69a20f998256b060685.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <bba48e537696016b94faa69a20f998256b060685.1740499185.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 14:01:42 +0200
X-Gm-Features: AQ5f1JqHHes89SxxV_3Haib37-C1DVRzgtiYwdOp7rVnetXfVznWKH4G7gk2dnY
Message-ID: <CAC_iWjLUy064KhtDvPhj6r4o+UkhCgkWEyjRZ6V5j7_FuNwT=Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] arm: add initjmp()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
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

On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Implement initjmp() for Arm.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/Kconfig                  |  1 +
>  arch/arm/include/asm/setjmp.h |  1 +
>  arch/arm/lib/setjmp.S         | 11 +++++++++++
>  arch/arm/lib/setjmp_aarch64.S |  9 +++++++++
>  4 files changed, 22 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8d5b54031b3..57695fada8d 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -94,6 +94,7 @@ config ARC
>  config ARM
>         bool "ARM architecture"
>         select HAVE_SETJMP
> +       select HAVE_INITJMP
>         select ARCH_SUPPORTS_LTO
>         select CREATE_ARCH_SYMLINK
>         select HAVE_PRIVATE_LIBGCC if !ARM64
> diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp.h
> index 662bec86321..1ad5b500f2a 100644
> --- a/arch/arm/include/asm/setjmp.h
> +++ b/arch/arm/include/asm/setjmp.h
> @@ -23,5 +23,6 @@ typedef struct jmp_buf_data jmp_buf[1];
>
>  int setjmp(jmp_buf jmp);
>  void longjmp(jmp_buf jmp, int ret);
> +int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top);
>
>  #endif /* _SETJMP_H_ */
> diff --git a/arch/arm/lib/setjmp.S b/arch/arm/lib/setjmp.S
> index 2f041aeef01..320ddea85f9 100644
> --- a/arch/arm/lib/setjmp.S
> +++ b/arch/arm/lib/setjmp.S
> @@ -34,3 +34,14 @@ ENTRY(longjmp)
>         ret  lr
>  ENDPROC(longjmp)
>  .popsection
> +
> +.pushsection .text.initjmp, "ax"
> +ENTRY(initjmp)
> +       stm  a1, {v1-v8}
> +       /* a2: entry point address, a3: stack top */
> +       str  a3, [a1, #32]  /* where setjmp would save sp */
> +       str  a2, [a1, #36]  /* where setjmp would save lr */
> +       mov  a1, #0
> +       ret  lr
> +ENDPROC(initjmp)
> +.popsection
> diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
> index 1b8d000eb48..074320d25fb 100644
> --- a/arch/arm/lib/setjmp_aarch64.S
> +++ b/arch/arm/lib/setjmp_aarch64.S
> @@ -39,3 +39,12 @@ ENTRY(longjmp)
>         ret
>  ENDPROC(longjmp)
>  .popsection
> +
> +.pushsection .text.initjmp, "ax"
> +ENTRY(initjmp)
> +       /* x1: entry point address, x2: stack top */
> +       stp x1, x2, [x0,#88]
> +       mov  x0, #0
> +       ret
> +ENDPROC(initjmp)
> +.popsection
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
