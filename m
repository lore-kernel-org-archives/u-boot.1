Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA21C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 07:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93FF86D11;
	Sat, 18 Nov 2023 08:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q0jDblPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E658D86D10; Sat, 18 Nov 2023 08:50:34 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24B086828
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 08:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c4fdf94666so34157121fa.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700293826; x=1700898626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FTG1Ocz9hT+diFOd+bFOG/B69vQCBq8/WgwkRBYlwAw=;
 b=Q0jDblPTBG4oLYFRx+ZCwgUNpIA1uzgzP8pLS0eNI7v73zB/iSCbK8Vfm9MJXnK/bO
 aqdyKiMtFYxH2BE9+suqTQjcYZolTImI8K+/fvExjhKBkY2qtxPc1UnPYdqNlXT6NCv6
 hi24LVIEl8vzKYKWc28YKQ2NbVjUKbMljG+O8Aai2X1NC7xZFP/cBfxt5DszQJV9yYSv
 1RDxW33UmL7OstVxAtwoa8zhzt62BsZkaDcq5Esv4FGzz2xDI0LY/T4s2K6ANUqe+Hjj
 too4ZY4+R8rIceqbTF9KzOVtnUMtZVRfPH6BvL+J+pGyxfmPwIlKRSUZhjR1ndFLkP06
 aGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700293826; x=1700898626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FTG1Ocz9hT+diFOd+bFOG/B69vQCBq8/WgwkRBYlwAw=;
 b=M3bpHvzzlyEnPPTthf5ahs2XGgsCfKdoGmB7576bxsvXTr70dNb8RpagjmE5HLEXm3
 9ojtDFwls/vRxj8Vdw1jVuE0ZsyCDJaKIQrsdjl2s+YfY39kSntycaBIcqhMDSBMdRdc
 X0UGcfxnzLyoFnvoKrOmKvfg67HcdUJ5nwtXOLOkBTSDF8+8YTjxzhkTlwbQ+EYnjUs7
 +DcOcs2CGxiOo+RV3ayAhJZik156X+fzazIhffqV5cqRhcYROSHOKS17sFZCyeL5EdbH
 o59CwDETopEKWgesFfM/OKiuc711BVRqsJSSMaBvUID8VQ7sYAQmqsnLw/b4miH8EYXj
 MfbA==
X-Gm-Message-State: AOJu0YzLpUWnSEDDkWPz8/08gDRWV8rAAoAJ7N6+jKQgeClqQpfrYoy9
 qFaZ9AD+P8LDdxsFdC+MNLntc9XPV7bmg1sdvCTD2w==
X-Google-Smtp-Source: AGHT+IFs6iMJhSOpapb22qHFxmo7cWiprS/og+Pb0vm4evYyUirnaMNTOU1y4Sb6WNpG1Y42HMNtKYcnMg9fjskd2Ng=
X-Received: by 2002:a2e:b904:0:b0:2c0:318a:6ee1 with SMTP id
 b4-20020a2eb904000000b002c0318a6ee1mr1185128ljb.49.1700293825741; Fri, 17 Nov
 2023 23:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20231116041043.362055-1-sjg@chromium.org>
 <20231116041043.362055-2-sjg@chromium.org>
In-Reply-To: <20231116041043.362055-2-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 18 Nov 2023 09:49:49 +0200
Message-ID: <CAC_iWjLF_wvaMpLWo+Xs1BLnPkcPe2oReq6krqJz3EPh6=53mA@mail.gmail.com>
Subject: Re: [PATCH v2 01/32] arm: x86: Drop discarding of command linker-lists
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>, 
 Bin Meng <bmeng.cn@gmail.com>
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

On Thu, 16 Nov 2023 at 06:11, Simon Glass <sjg@chromium.org> wrote:
>
> Since we can now cleanly disable CMDLINE when needed, drop the rules
> which discard the command code.  It will not be built in the first
> place.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>
> (no changes since v1)
>
>  arch/arm/cpu/u-boot.lds     | 3 ---
>  arch/x86/cpu/u-boot-64.lds  | 4 ----
>  arch/x86/cpu/u-boot-spl.lds | 4 ----
>  arch/x86/cpu/u-boot.lds     | 4 ----
>  4 files changed, 15 deletions(-)

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index fc4f63d83489..7724c9332c3b 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -14,9 +14,6 @@ OUTPUT_ARCH(arm)
>  ENTRY(_start)
>  SECTIONS
>  {
> -#ifndef CONFIG_CMDLINE
> -       /DISCARD/ : { *(__u_boot_list_2_cmd_*) }
> -#endif
>  #if defined(CONFIG_ARMV7_SECURE_BASE) && defined(CONFIG_ARMV7_NONSEC)
>         /*
>          * If CONFIG_ARMV7_SECURE_BASE is true, secure code will not
> diff --git a/arch/x86/cpu/u-boot-64.lds b/arch/x86/cpu/u-boot-64.lds
> index d0398ff00d71..00a6d8691211 100644
> --- a/arch/x86/cpu/u-boot-64.lds
> +++ b/arch/x86/cpu/u-boot-64.lds
> @@ -11,10 +11,6 @@ ENTRY(_start)
>
>  SECTIONS
>  {
> -#ifndef CONFIG_CMDLINE
> -       /DISCARD/ : { *(__u_boot_list_2_cmd_*) }
> -#endif
> -
>  #ifdef CONFIG_TEXT_BASE
>         . = CONFIG_TEXT_BASE;   /* Location of bootcode in flash */
>  #endif
> diff --git a/arch/x86/cpu/u-boot-spl.lds b/arch/x86/cpu/u-boot-spl.lds
> index a0a2a06a18cd..50b4b1608552 100644
> --- a/arch/x86/cpu/u-boot-spl.lds
> +++ b/arch/x86/cpu/u-boot-spl.lds
> @@ -11,10 +11,6 @@ ENTRY(_start)
>
>  SECTIONS
>  {
> -#ifndef CONFIG_CMDLINE
> -       /DISCARD/ : { *(__u_boot_list_2_cmd_*) }
> -#endif
> -
>         . = IMAGE_TEXT_BASE;    /* Location of bootcode in flash */
>         __text_start = .;
>         .text  : {
> diff --git a/arch/x86/cpu/u-boot.lds b/arch/x86/cpu/u-boot.lds
> index a31f4220a000..c418ff44aa08 100644
> --- a/arch/x86/cpu/u-boot.lds
> +++ b/arch/x86/cpu/u-boot.lds
> @@ -11,10 +11,6 @@ ENTRY(_start)
>
>  SECTIONS
>  {
> -#ifndef CONFIG_CMDLINE
> -       /DISCARD/ : { *(__u_boot_list_2_cmd_*) }
> -#endif
> -
>         . = CONFIG_TEXT_BASE;   /* Location of bootcode in flash */
>         __text_start = .;
>
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
