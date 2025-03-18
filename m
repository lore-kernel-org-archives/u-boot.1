Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6682C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 11:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 207A380107;
	Tue, 18 Mar 2025 12:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f0Ny3fAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0CF80548; Tue, 18 Mar 2025 12:16:19 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF3D800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 12:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6ff4faf858cso28069257b3.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742296576; x=1742901376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yz42WIot2/CWs4jRtll6Q9fUFdcO6Yk3X2AXQ75lzu0=;
 b=f0Ny3fAOALer0m1ApDJ1DuXVwJu8hXAvvQun8NS67lOXRVTML4YoC8ZRJh6Mulov+l
 H6/zAyT+vITJNstizOXieduFi2eGZs3A4Qr4IAs45lpb8Cj9LSc+jtHHHzWpK9TZkM6o
 nZVQHq5GwZOnDJ8/3uhnnCG53XkZKErT8jVM+HOefTIt55fZkGduSP/WZnw4oZ3JaWAK
 SzBLIp5AItAEZEfkZ+jkWoEMAOvnKxlg07mcHuNUHUgrSLI9WKU7MhtzdIBEi65f4Kzb
 +okTyox9xyywS2vaWa4xWJJ7Bg6HOa3ISOWmAyjODRjzKq4CSFBCMmo1FbgW/V7yH9an
 LcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742296576; x=1742901376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yz42WIot2/CWs4jRtll6Q9fUFdcO6Yk3X2AXQ75lzu0=;
 b=UPH1mgLmT9vxfEZRjs+3H0dsSFUfbTj1M6gRBBO7ofiFPT8lJkZs/oyg0YOlah0w6z
 7sCL/AAqQHwS+w9zbVteI7optgUeLtumzJIpVciRPB8iMJCL92NKlyaAUd7Q3lxpfEWx
 EcfOEMVizpNxPGfjzbIDxIMdjGKC1jmifdujIRTKCaSoAaX8VLIpbtpooMRidejydYs6
 eiYckoL3LPxte+gVyIyipNh/tAeS8jRuufJ0g0u+7RckFFA8U49VGRAL2EZoe5gYJc33
 tDZ+EazqAyvXCAFbBmG6x6FAEE6hS+YWGN+mg5Te746STPAqrUjVIce8VPPmTXWUA3OB
 qMTg==
X-Gm-Message-State: AOJu0Yxgkiohjgo5+XnWBRvHnNKNKdYom/fNa+6xCIjcwh0qRsHmL2AU
 FpYkBHu4wnyiAw/s2N7Atb4ICvvFQJtWwO341SYQp0spti2ywqSdbF5X+iZREGVjrAHnmFKZTmC
 ZSKeNmceAtYZmqpaFWueVCpyHGWEyZilyN1TV3Q==
X-Gm-Gg: ASbGncsJ+nYnQGORpYcNzllcXtUADHuuYs1D8PMaZq+XYBrOtH9wJ+PtsMgh9oM4JMA
 CaQq0U5LH/vk//ePWqNg/z6NUyOSQzZx97FdNeHkh8raqKKVkPwBz7Sf4drmOMaP1s8QorKsn8J
 xG1sTQOfHoTjbQvqdZ9oduIo+SV2c=
X-Google-Smtp-Source: AGHT+IEibtcmuAekgR3xim9x7FJQmrE7E+MUDwoF3kbRrTooFfwpDmQpjTfUxEiZOTVQlweUVmkIz08M7XwwOuK41bc=
X-Received: by 2002:a05:690c:7487:b0:6ef:57ad:9d6e with SMTP id
 00721157ae682-6ff45eab26cmr212062677b3.15.1742296575887; Tue, 18 Mar 2025
 04:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-3-jerome.forissier@linaro.org>
In-Reply-To: <20250318104659.1114340-3-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Mar 2025 13:15:40 +0200
X-Gm-Features: AQ5f1Jr7fJNK_FUj1EqMUa8U15_oleGvipkTMq_ZjXPiDLXNTDi7Xb6SAZqnE88
Message-ID: <CAC_iWjLCAs1CXA4f4C5TBn1i3QxeYwk3F84f9Q7M_=LW5Z+Lcg@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] arm: add initjmp()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Tue, 18 Mar 2025 at 12:47, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Implement initjmp() for Arm.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/Kconfig                  |  1 +
>  arch/arm/lib/setjmp.S         | 12 ++++++++++++
>  arch/arm/lib/setjmp_aarch64.S | 10 ++++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 14111ca14fb..7a3141e92b3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -95,6 +95,7 @@ config ARC
>  config ARM
>         bool "ARM architecture"
>         select HAVE_SETJMP
> +       select HAVE_INITJMP
>         select ARCH_SUPPORTS_LTO
>         select CREATE_ARCH_SYMLINK
>         select HAVE_PRIVATE_LIBGCC if !ARM64
> diff --git a/arch/arm/lib/setjmp.S b/arch/arm/lib/setjmp.S
> index 2f041aeef01..81bef578719 100644
> --- a/arch/arm/lib/setjmp.S
> +++ b/arch/arm/lib/setjmp.S
> @@ -34,3 +34,15 @@ ENTRY(longjmp)
>         ret  lr
>  ENDPROC(longjmp)
>  .popsection
> +
> +.pushsection .text.initjmp, "ax"
> +ENTRY(initjmp)
> +       stm  a1, {v1-v8}
> +       /* a2: entry point address, a3: stack base, a4: stack size */
> +       add  a3, a3, a4
> +       str  a3, [a1, #32]  /* where setjmp would save sp */
> +       str  a2, [a1, #36]  /* where setjmp would save lr */
> +       mov  a1, #0
> +       ret  lr
> +ENDPROC(initjmp)
> +.popsection
> diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
> index 1b8d000eb48..01193ccc426 100644
> --- a/arch/arm/lib/setjmp_aarch64.S
> +++ b/arch/arm/lib/setjmp_aarch64.S
> @@ -39,3 +39,13 @@ ENTRY(longjmp)
>         ret
>  ENDPROC(longjmp)
>  .popsection
> +
> +.pushsection .text.initjmp, "ax"
> +ENTRY(initjmp)
> +       /* x1: entry point address, x2: stack base, x3: stack size */
> +       add x2, x2, x3
> +       stp x1, x2, [x0,#88]
> +       mov  x0, #0
> +       ret
> +ENDPROC(initjmp)
> +.popsection
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
