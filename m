Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75C9C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2316A88297;
	Thu, 29 Aug 2024 09:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cDZDeT4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3862987FA7; Thu, 29 Aug 2024 09:32:05 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C30188440
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-714187df604so952274b3a.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724916721; x=1725521521; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7yGfh5CVl0GniJ4q2pgMNozdtMg3eMRdtvCw9Pp0NAQ=;
 b=cDZDeT4ioR55EogJ+GFZ2hJiTfnEtfNPGzverkm/3F+V0hNhFz/wD5AvBP76vUps0v
 pyCNMTdG8CTZK+x550vinP1SbRG0/4NkxgGek2Ef7w1r7Aj+y4yOlGBPHtxjx4WyaFMp
 m1fBm/3eZLsjUOUa3xsX6faAXGPKV6aF8MAHyrZopssfL6NK13yckMKZco2QNAXUlCQP
 OQRaLYMrZF7hC6RRrks1WTAexC03m/gOKdC6au4ctuhK/bZliM2tYJl/rAZw87uZ1PfR
 8RXkhsjrSIXLfH+xjyfcWg4/KVXVQd0jNvr2MNNCfKslH+4YyA0vghCgzPyH4Jqj8zkD
 2Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724916721; x=1725521521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yGfh5CVl0GniJ4q2pgMNozdtMg3eMRdtvCw9Pp0NAQ=;
 b=Tl1sAsK/55V0wDIHg/Ggu6lsI8SVY4TBvVxY3mzA5Wv2gPlLHrVzVwna+fzMn/OMVp
 IwmA89foETJzNOnQtHcvoDvmpo6H1dRgFhafjU0O3EE+ljvq66qfVg6dBQ2oHy9okRw1
 jxShxbDEsis/lZzAtiS08z/Vt/rVwR2oL/4CyNKd/fItponf+hjM6zvUvweXy+9+fvDb
 yJ8rxarc0OtcxhWDUab5Xrb9I2wRE6zKj7gJ3EdOWPgNVyDn4V7J+GeWHjFgYqp4GO45
 kBg4dYerdVmSdSSjGmu1qMnV6f1T6kObd2Ysf6HEwU+z3w2d3do4MPhaya5JHpGBV+9R
 O5/g==
X-Gm-Message-State: AOJu0Yyq3OMSl7eLzH2MmIxJKKWd3GCmSkjLg8ZRSoBhLf3M98YZcKlp
 glEgMitwMiYEreb0ek9wFGFd5dTI5O/rkQIMarIUUGGA4OyRjLlf7qAc9rsrVZ5sml4mTfU1N2D
 DlJxGsQ0tO/Gh+BQvYIqQ+xb+/FS1bww/0Z85Pw==
X-Google-Smtp-Source: AGHT+IHkeXkyP5KVd6GPLBPFBWj1YM9fivAayPWh446ZkER7IsQI00TEZ1eN2vmsJlRZ8N992kJeP0hcqpcG3w5AUq0=
X-Received: by 2002:a17:90b:3810:b0:2d3:d79f:e8b7 with SMTP id
 98e67ed59e1d1-2d85c545eb6mr1308290a91.5.1724916721315; Thu, 29 Aug 2024
 00:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <7de6a75453d11fa56ae81f3ad3d0f16f0d12546e.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <7de6a75453d11fa56ae81f3ad3d0f16f0d12546e.1724846454.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Aug 2024 10:31:24 +0300
Message-ID: <CAC_iWj+Z050XcrEegH=xDRPgiWv3Q1jUd8FxZUgCWeEQ8F8qcQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
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

On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
> detected and the sandbox build fail. It typically happens when using
> ccache. For example:
>
>  $ make sandbox_defconfig
>  $ make CROSS_COMPILE="ccache x86_64-linux-gnu-" \
>         CC="ccache x86_64-linux-gnu-gcc"
>  [...]
>  In file included from boot/bootmeth_efi.c:16:
>  include/efi_default_filename.h:33:2: error: #error Unsupported UEFI architecture
>     33 | #error Unsupported UEFI architecture
>        |  ^~~~~
>
> A similar error occurs when the build is done via buildman and
> ~/.buildman contains:
>
>   [toolchain-wrapper]
>   wrapper = ccache
>
> Fix the issue by considering only the last word in $(CROSS_COMPILE).
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f90e48f58a..dc7bdd7942 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,7 +21,7 @@ include include/host_arch.h
>  ifeq ("", "$(CROSS_COMPILE)")
>    MK_ARCH="${shell uname -m}"
>  else
> -  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
> +  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
>  endif
>  unexport HOST_ARCH
>  ifeq ("x86_64", $(MK_ARCH))
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
