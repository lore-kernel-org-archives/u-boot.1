Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAECE95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB2086EDB;
	Sun,  8 Oct 2023 01:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="EfQybngP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3A986D3F; Sun,  8 Oct 2023 01:12:17 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D51C86EA6
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59f6041395dso41681687b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gv1nFrnBnq9DkH0Bl+I3WP9yogc0dfC/g/BVOcpgrYs=;
 b=EfQybngPgyZlEUjH/lViDxoxhmVSMUQGNnonzRjxI5eVEE+mJvUmjPbqmtPAx/CTUk
 C2Cv/OqpJpHjZPiAn8mxj37EBEtDWF2hc+tOlZONiRsfkeXZY/lAF4wPSsolM7JVwVeO
 Z1S1BpFHJfcW4ygO0xODdOy8VZeOr8kUWV5cspH13pDbX/Ur25j82ihzBpjtQK2sVKht
 yXrdyWJnZ2XtG2J//11uUcEtI3/9Urc9SMwOQM0z2CsY/558/nHY35ttbYqmvPoKVCWX
 4HGHig0OdMDfwtOJIn3dHNuYfH1bh982morwEeq43UJRNV0a330OVKkfxGDi48+buB76
 gsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gv1nFrnBnq9DkH0Bl+I3WP9yogc0dfC/g/BVOcpgrYs=;
 b=O3Iqp2Y7SnJf+YsRkBKm71F/zX6acB9dNHuF0Sw/hUWg6RVLNzRrWYqHTN0I97nmKU
 3i0EcRMOPasVGrSbF63x34UmiTBveqQxd6Wuc/boExiVT3UyJTfo+VoZUvGt84U6HUvR
 p1PkWLb3qY1O549yCTCC1KT+QsHVkoU5h4Zts7xFW2ZLG9mvX2jY9Xu/drXETeor6Rlj
 YLC9Ri9EVzb8Z5Z9Dp5fyAdsMl0Ak0szQ+U4ApHE5J9nO8c++YhD39xXfxjJtEWC9R38
 m/RE7f7JEov5iL3FCbcbuWl645ln+GvuzQoNOjpThH0vnUifTF7ax2rVy6HQiGKuKP9T
 g6rw==
X-Gm-Message-State: AOJu0YwFMI2nHYR9meNv6KNNC+3tAf0YP3mfNZuQUaWdDpNP/WIrtBWy
 j1v8xZWctqS6PVZFhQBhnBepVgOcyzf+D0gMGlGviQ==
X-Google-Smtp-Source: AGHT+IGPvHG6tJWulr9PJ8+JJHK+sH0v/6ClrsFoLKEHqK/byJu118s+nbItxBvyiKS+LEeJ9tu3joYVIP9hdIN8Ers=
X-Received: by 2002:a0d:c886:0:b0:59f:9c08:8f12 with SMTP id
 k128-20020a0dc886000000b0059f9c088f12mr13821212ywd.38.1696720299249; Sat, 07
 Oct 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231006112351.2275090-1-randolph@andestech.com>
 <20231006112351.2275090-2-randolph@andestech.com>
In-Reply-To: <20231006112351.2275090-2-randolph@andestech.com>
From: Simon Glass <sjg@google.com>
Date: Sat, 7 Oct 2023 17:09:52 -0600
Message-ID: <CAPnjgZ2K-Rq6mDZYzeYKn0=0oTZjXWtQSXFGPZvpeihvjkQJNg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/7] riscv: dts: Introduce SPL_LOAD_FIT_CONFIG
 symbol
To: randolph@andestech.com
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com, peterlin@andestech.com
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

Hi Randoph,

On Fri, 6 Oct 2023 at 05:26, Randolph <randolph@andestech.com> wrote:
>
> Introduce common Kconfig symbol for riscv architecture
> This symbol SPL_LOAD_FIT_CONFIG for binman itb layout selection
> Default is using binman.dtsi
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  arch/riscv/Kconfig               | 7 +++++++
>  arch/riscv/dts/ae350-u-boot.dtsi | 1 +
>  arch/riscv/dts/ae350_32.dts      | 1 -
>  arch/riscv/dts/ae350_64.dts      | 1 -
>  4 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index aff1f33665..ec1cfcaaa7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -422,4 +422,11 @@ config TPL_USE_ARCH_MEMSET
>
>  endmenu
>
> +config SPL_LOAD_FIT_CONFIG
> +       string "Default FIT configuration for SPL"
> +       default "binman.dtsi"
> +       depends on SPL_LOAD_FIT
> +       help
> +         Specify corresponding FIT configuration for SPL modes.
> +
>  endmenu
> diff --git a/arch/riscv/dts/ae350-u-boot.dtsi b/arch/riscv/dts/ae350-u-boot.dtsi
> index aef9159b7a..ff5725501f 100644
> --- a/arch/riscv/dts/ae350-u-boot.dtsi
> +++ b/arch/riscv/dts/ae350-u-boot.dtsi
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +#include CONFIG_SPL_LOAD_FIT_CONFIG

That doesn't seem great to me. I will check the next patch.

>  / {
>         cpus {
> diff --git a/arch/riscv/dts/ae350_32.dts b/arch/riscv/dts/ae350_32.dts
> index 61af6d5465..2caabad888 100644
> --- a/arch/riscv/dts/ae350_32.dts
> +++ b/arch/riscv/dts/ae350_32.dts
> @@ -2,7 +2,6 @@
>
>  /dts-v1/;
>
> -#include "binman.dtsi"
>  #include "ae350-u-boot.dtsi"
>
>  / {
> diff --git a/arch/riscv/dts/ae350_64.dts b/arch/riscv/dts/ae350_64.dts
> index 8c7db29b4f..9d5f6c743c 100644
> --- a/arch/riscv/dts/ae350_64.dts
> +++ b/arch/riscv/dts/ae350_64.dts
> @@ -2,7 +2,6 @@
>
>  /dts-v1/;
>
> -#include "binman.dtsi"
>  #include "ae350-u-boot.dtsi"
>
>  / {
> --
> 2.34.1
>

Regards,
Simon
