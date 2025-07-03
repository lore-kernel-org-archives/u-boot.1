Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225B1C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 13:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E42882063;
	Thu,  3 Jul 2025 15:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="STGyrPHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDBD822D7; Thu,  3 Jul 2025 15:27:28 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A1E8091A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 15:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e84207a8aa3so3696091276.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751549245; x=1752154045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IILFGeLhhYpXfGeORFMPdGpkB1j4YKFKmKZbf4mR014=;
 b=STGyrPHc1dQUNCB866x5TuYnn5iVVKxVCFpnVxb3YL/9BGzbYbJXT/ep35qddDGU0m
 al+zqETUZkDPqqg47AsDrri8o+NkZes/qJA0giDAJkxu52lN44djcbw+BU/gPmTYJK6w
 0eHMWlOv//htq+qdwxV/OgVNLCLdCRH8rAUzmJP3BUxzTG2ZCAmDheNaj6EVx23Xr1y2
 eds2Tqydg8HGbVt6KyKBVX3R/VTeRConYzUaxT4YdJGTdMsfv2w0K/hz2ASP4HQX8cfG
 fqPGWYKezHHzvV10mFejWf+UBph+ElW4urC4AdqtJ5qDKliPx3bxFcy7DITIvqVSjQYy
 2VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751549245; x=1752154045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IILFGeLhhYpXfGeORFMPdGpkB1j4YKFKmKZbf4mR014=;
 b=DzqTnnFHlGI0TUKQBgFiuOWHwaaT4r60tDTjmvRog/PnydhOPMC2GsZ5leButI9DeT
 CfuY6ulljzx65MTMXU4JJZnet3PccS3RxFT3IWvso0I7c9WerH1anEVcuaVuyhoAXufh
 o0YlQSTKPUsA3QcOCTD7biMKvPq0r93AahlHtO9GUzvOBSsOqh1iRXB6JktfPBrJl8O/
 dW3sV31ouVEr3oRy2SlwMxgsHjiw5moI85+A677fRmIRh8BLKNcQkFaZ4FyvO02sxVlL
 krPt9YYR0XoVof8xrwcCDp6ABDpx5i7FpqMD1uHfF1IFvdwqbkRc6KvrGNsZscVrUS4j
 2cuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWVDA/YSli9y/X+59GoYhR5hjW6vVj1CF6WZXjxiapkBCr4NYaP2XjH5Arvkp76svSe89Ra5k=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7iLUPVN5HMaBJO/3v+ZBuTN4XVRLfsJ8Y0g0S1HKbxBufaNZZ
 MdMhRKDhlaA9Dh0luxcS1lq/D3ZZtfQxNEtsOQw38M6fNa9oNkdbKD3pZEjjYKL7beEJS2d0/iT
 BEhDd3SOz4myNGrITtKVDES7iWv6vN1lr6+W2adDoJJD61q9WrKzPUWo=
X-Gm-Gg: ASbGncvMwgycU4ysf0LUJo/lFlxhl6m+qAmFwuB9o/14HxmYhEwUxTZpmLNyqqkW9hS
 mBoAkoYP4bE6DG2y4IglrcND4hDj4X7LdaWdqOMgBoNFoVBG7Qn+mZ4lSD+aqfThsOR5fHbM7ag
 4fHf284H8qm3XbGrwB9ub7aagsC2Hus2d540k9SxHwqYLi
X-Google-Smtp-Source: AGHT+IFA5LTogIvgrNkHZqR1VS6At/2PFjCL1JS/FgCofGGo6VX9CbyG6jzx7AOjOb/qa21WMsZ6Y7LKwj22fd5tUok=
X-Received: by 2002:a05:690c:6a11:b0:712:d70b:45d5 with SMTP id
 00721157ae682-7164d4cdff0mr95682267b3.33.1751549245467; Thu, 03 Jul 2025
 06:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
 <20250703051951.43372-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250703051951.43372-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Jul 2025 16:26:49 +0300
X-Gm-Features: Ac12FXx3J4Q7MQPRNDFF1tAtxyPppZoc3nMpbsjlBCV-3V5dlWRHwOj4lfedJV4
Message-ID: <CAC_iWjKynGnRKmzc9y=m3EXDNZTOPVWB10zhw=s1zc4EtE2g_A@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: simplify interrupt code
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
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

On Thu, 3 Jul 2025 at 08:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Carve out a function except_msg() to handle the output for most type of
> interrupts.
>
> Consistently use 16 digits for printing the exception syndrome register
> esr to match the register size.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/lib/interrupts_64.c | 72 ++++++++++++------------------------
>  1 file changed, 24 insertions(+), 48 deletions(-)
>
> diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
> index 970f8b6831f..cc20528327b 100644
> --- a/arch/arm/lib/interrupts_64.c
> +++ b/arch/arm/lib/interrupts_64.c
> @@ -170,14 +170,18 @@ static bool smh_emulate_trap(struct pt_regs *regs)
>         return true;
>  }
>
> -/*
> - * do_bad_sync handles the impossible case in the Synchronous Abort vector.
> +/**
> + * except_msg() - print exception message
> + *
> + * Print exception message, register contents, backtrace, loaded EFI images.
> + *
> + * @msg:       message describing exception type
> + * @pt_regs:   registers
>   */
> -void do_bad_sync(struct pt_regs *pt_regs)
> +static void except_msg(const char *msg, struct pt_regs *pt_regs)
>  {
>         efi_restore_gd();
> -       printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
> -              pt_regs->esr);
> +       printf("%s handler, esr 0x%016lx\n", msg, pt_regs->esr);
>         show_regs(pt_regs);
>         if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>                 show_backtrace(pt_regs);
> @@ -185,18 +189,20 @@ void do_bad_sync(struct pt_regs *pt_regs)
>         panic("Resetting CPU ...\n");
>  }
>
> +/*
> + * do_bad_sync handles the impossible case in the Synchronous Abort vector.
> + */
> +void do_bad_sync(struct pt_regs *pt_regs)
> +{
> +       except_msg("Bad mode in \"Synchronous Abort\"", pt_regs);
> +}
> +
>  /*
>   * do_bad_irq handles the impossible case in the Irq vector.
>   */
>  void do_bad_irq(struct pt_regs *pt_regs)
>  {
> -       efi_restore_gd();
> -       printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
> -       show_regs(pt_regs);
> -       if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -               show_backtrace(pt_regs);
> -       show_efi_loaded_images(pt_regs);
> -       panic("Resetting CPU ...\n");
> +       except_msg("Bad mode in \"Irq\"", pt_regs);
>  }
>
>  /*
> @@ -204,13 +210,7 @@ void do_bad_irq(struct pt_regs *pt_regs)
>   */
>  void do_bad_fiq(struct pt_regs *pt_regs)
>  {
> -       efi_restore_gd();
> -       printf("Bad mode in \"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
> -       show_regs(pt_regs);
> -       if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -               show_backtrace(pt_regs);
> -       show_efi_loaded_images(pt_regs);
> -       panic("Resetting CPU ...\n");
> +       except_msg("Bad mode in \"Fiq\"", pt_regs);
>  }
>
>  /*
> @@ -218,13 +218,7 @@ void do_bad_fiq(struct pt_regs *pt_regs)
>   */
>  void do_bad_error(struct pt_regs *pt_regs)
>  {
> -       efi_restore_gd();
> -       printf("Bad mode in \"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
> -       show_regs(pt_regs);
> -       if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -               show_backtrace(pt_regs);
> -       show_efi_loaded_images(pt_regs);
> -       panic("Resetting CPU ...\n");
> +       except_msg("Bad mode in \"Error\"", pt_regs);
>  }
>
>  /*
> @@ -236,7 +230,7 @@ void do_sync(struct pt_regs *pt_regs)
>             smh_emulate_trap(pt_regs))
>                 return;
>         efi_restore_gd();
> -       printf("\"Synchronous Abort\" handler, esr 0x%08lx", pt_regs->esr);
> +       printf("\"Synchronous Abort\" handler, esr 0x%016lx", pt_regs->esr);
>         dump_far(pt_regs->esr);
>         printf("\n");
>         show_regs(pt_regs);
> @@ -251,13 +245,7 @@ void do_sync(struct pt_regs *pt_regs)
>   */
>  void do_irq(struct pt_regs *pt_regs)
>  {
> -       efi_restore_gd();
> -       printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
> -       show_regs(pt_regs);
> -       if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -               show_backtrace(pt_regs);
> -       show_efi_loaded_images(pt_regs);
> -       panic("Resetting CPU ...\n");
> +       except_msg("\"Irq\"", pt_regs);
>  }
>
>  /*
> @@ -265,13 +253,7 @@ void do_irq(struct pt_regs *pt_regs)
>   */
>  void do_fiq(struct pt_regs *pt_regs)
>  {
> -       efi_restore_gd();
> -       printf("\"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
> -       show_regs(pt_regs);
> -       if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -               show_backtrace(pt_regs);
> -       show_efi_loaded_images(pt_regs);
> -       panic("Resetting CPU ...\n");
> +       except_msg("\"Fiq\"", pt_regs);
>  }
>
>  /*
> @@ -282,11 +264,5 @@ void do_fiq(struct pt_regs *pt_regs)
>   */
>  void __weak do_error(struct pt_regs *pt_regs)
>  {
> -       efi_restore_gd();
> -       printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
> -       show_regs(pt_regs);
> -       if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -               show_backtrace(pt_regs);
> -       show_efi_loaded_images(pt_regs);
> -       panic("Resetting CPU ...\n");
> +       except_msg("\"Error\"", pt_regs);
>  }
> --
> 2.48.1
>
