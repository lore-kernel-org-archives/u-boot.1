Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D616C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 06:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E453E88580;
	Tue, 27 Aug 2024 08:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G605UEeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6821E87C80; Tue, 27 Aug 2024 08:25:25 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B13A88580
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 08:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7143ae1b560so2794862b3a.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724739922; x=1725344722; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yNl+Acbx7AFIb6AKkLLHJeev05LghRmsOdfv25b4UGA=;
 b=G605UEeHhym+RbsZXERQC78WV3LprVV64zB8XE/d/nhOu6R+pKWEMP9nWxfictyPZK
 nVRHnX2ZEKwl480G7yAYJI2718qD9RLl9f+hqEyeQHjJUE2cG4xSnCs7KEqphKhs3Lkh
 0X+JTSgLfMt7rVLEJaUE1Dq4xdFtnmMuspQkKVh/aptXnEsN7v5F1taTF/4s8L+eQA13
 rMoR7oh4jXE34Q+W/2+PWwO3CPZJPZAp4cz/4xG3d/6ePIwxE28ANNux3l598s+IeumA
 1NFuBd96x1P9r1XaXk0XCKDV3zO7NOwUm8Ylj95q4qP2H7I8TM5rkVrtJDLRJ9VgUtn5
 VYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724739922; x=1725344722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yNl+Acbx7AFIb6AKkLLHJeev05LghRmsOdfv25b4UGA=;
 b=fdHcVY9rWv7QyKDulqGEcVcT2WKbmjoKnYUChjxMLbg+EFgdQIm22MCRnVlZAQr5Br
 hkoFpComM5ZFALg6bjXX/myzjG70tJTn88or3vPBWysTx9YfKF6CNR0J/rupjdPhP6yt
 y8qBNwyRZGccDtZW9hVfpizPuH51dW5pgaXcZ1Kt14wd7VN7xibQgx4qzq91u9MlKPEf
 6fUUe6/sYknOVg8hgXI1XeqIGEvkm7Kr9puIH3TFw31JHaIU2f174ZBZlj9tBrHX5h+a
 u5Mji3hx8TObTdzjcbplb4Oj6MM5zm9UsQBwtzPCjRUWfwtT99auX647jsoo1KnsgWk/
 0n7A==
X-Gm-Message-State: AOJu0YyVft3xArcD9Ibt8d8yXSohg4PT7EcJRRwkgG+pVtAblKLiK7di
 H9gNmJJwqlblAdXVlzkJA34THqeVAUGUf4B1s22kAnQcPQKfOd8IPfm8aW7j7+MTM2ANfRCEJKy
 0DwC5JIHMNjFeV7uXwXjLB5elNQkqgECb+hWofg==
X-Google-Smtp-Source: AGHT+IHU/YpYNW5sHmIGj/iZuNyKDcLpLmWRMcT0dMJybvis7YOk5rTOlgA3IvGL3pnPznqq1ibhKjbGQZbqg965ZTI=
X-Received: by 2002:a05:6a21:3987:b0:1ca:dc1e:9a86 with SMTP id
 adf61e73a8af0-1ccc08657ecmr1824461637.6.1724739921435; Mon, 26 Aug 2024
 23:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-9-sughosh.ganu@linaro.org>
In-Reply-To: <20240826115940.3233167-9-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Aug 2024 09:24:45 +0300
Message-ID: <CAC_iWjKYQVkWheRW0SZNZjwVwoO1HxhkaMUzwRE+d5DBJOtMEw@mail.gmail.com>
Subject: Re: [PATCH v4 08/27] lmb: config: add lmb config symbols for SPL
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
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

On Mon, 26 Aug 2024 at 15:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add separate config symbols for enabling the LMB module for the SPL
> phase. The LMB module implementation now relies on alloced list data
> structure which requires heap area to be present. Add specific config
> symbol for the SPL phase of U-Boot so that this can be enabled on
> platforms which support a heap in SPL.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since V3: None
>
>  lib/Kconfig | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index f8ac8daad3..6a9338390a 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1103,7 +1103,17 @@ config LMB
>         default y if ARC || ARM || M68K || MICROBLAZE || MIPS || \
>                      NIOS2 || PPC || RISCV || SANDBOX || SH || X86 || XTENSA
>         help
> -         Support the library logical memory blocks.
> +         Support the library logical memory blocks. This will require
> +         a malloc() implementation for defining the data structures
> +         needed for maintaining the LMB memory map.
> +
> +config SPL_LMB
> +       bool "Enable LMB module for SPL"
> +       depends on SPL && SPL_FRAMEWORK && SPL_SYS_MALLOC
> +       help
> +         Enable support for Logical Memory Block library routines in
> +         SPL. This will require a malloc() implementation for defining
> +         the data structures needed for maintaining the LMB memory map.
>
>  config PHANDLE_CHECK_SEQ
>         bool "Enable phandle check while getting sequence number"
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
