Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2902DCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 13:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9956E848A1;
	Wed, 10 Jun 2026 15:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LeAYghaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6666C848A9; Wed, 10 Jun 2026 15:09:38 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A4B8489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490b8a97b11so74956475e9.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781096975; x=1781701775; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YUF9VxNILwaZ8Dx4ELstI6DLUODFsxwWoO/ycOiixnE=;
 b=LeAYghaCrSuh5EjKMGAGcDIpnM9lDld7Tj7E3tLBNN1G7VihFRkOzbu1c/u4/cFeC8
 W2RI59c8DyUiNUvVP/ODQPD1Vh+b7gA7sKY6KALZjjo7og9/EYrGUrWUj+3728HIm/19
 QgFjQnwiuCvMHZyQNmzecKDAtxgomOoCIYKTG+0ZjQKl9cVgLK/iYH7nw5wMzH9WmgRy
 z4KzRGbPYkYnhoW0Qj02cwth6G/8cvIsapq9rH60ln/Ewe+l5Hc2bICoQffaDtTNR60z
 Z2FmXUCVsL+6jnAOrLnriJzuzw5KnvabfWaGiBTGMtj5Fp7EC0Zja467pcTmR/5cqG9l
 qNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781096975; x=1781701775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUF9VxNILwaZ8Dx4ELstI6DLUODFsxwWoO/ycOiixnE=;
 b=bfZ24b3AKClUevIoFfkcq5G2UAY8dyLVluPoCerrNAoM4tCFR+mJcXCXzqlBs3xSXu
 oX2DTeuIa/hI+DI1ILrarrHKP4c1cu5UhJsZv5rE8bZFTAWNCJfL5dggxcYdsdZC5opI
 iDv6xMWxO39EWZMQ2izXCs8uXpj6J2ypcw+9bOgv3Q84CsrmN04SgSpQkBrv15Pkt4JF
 fBECqb+ZlFDV7H77CTwtfr405ldJiLiUONc4VCmKESTWjz+3EyC7jzrTwq2Ea8fwQCwa
 5h8biKX0l2HACr0dnLmwJ1Z56QEwc4Ig32r+NS8LDAf6vbZPU9Lgek9NafIrOw6Nb1Ev
 qO9Q==
X-Gm-Message-State: AOJu0YySGJ/t9896H23qSiIy40L9mF1rbwFZzhcQwAehdpJ34h2u6e1p
 chkstSfwveOloQTWGpP0X9veQzUy7eqQsKlNz2G4TZC9e4hFBj9AAvE0urq/2/g/eg0=
X-Gm-Gg: Acq92OHyAdbzfgtpmpzbcyrlRRMqEMnA0SDZXHYnkhRtPUpn9bJhZKMiIvwqEsXegHi
 oqsGncjLgKNF3mausqiXJ0qx4FUtkX3MGlqx+r7/3yU8rwD7j2grIXvbtwgKm4UhGdPrrWm+rQc
 MEuF9oKcE6aFRrZ/a36KaP/e02gupJUJoKje8UvBWDyl2dURUwnjVlIFBp4I/g2XqNeP6FYvg5q
 5yr+ofUdj6bsHMdtP/hYt5k+OKO+fFjOjTx2utcBW5djbCDeEPAhi0pzITRJ6n9EPpy4NM3uOyH
 MnMLrM6RYy6ZL691u+8BXb9lImnkM1JYRBfk06m4zJBn8l1gYWDCwP6RKlmFixPfjcgoPzrog9p
 n3dgLVzcUfS14tFndOtA0B53IN9OsFKJ0hAbMVU4cxyKUjne8oPrkARhU6U+68Skv2tjMUQaYmQ
 vQn0Fiw+4SH58UhqShlhvIr71X7idR82WkRYxBFIvBU/dsbfg=
X-Received: by 2002:a05:600c:c491:b0:490:b9d3:a9ce with SMTP id
 5b1f17b1804b1-490c2606a1fmr423393095e9.30.1781096974584; 
 Wed, 10 Jun 2026 06:09:34 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff23:4441:7c57:ff85:2733:9342])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35133csm69288706f8f.25.2026.06.10.06.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:09:34 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:09:30 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>, Brian Sune <briansune@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2] mach-snapdragon: formalize APQ8016 debug UART init
Message-ID: <ailiCiJ1aJDMimyb@linaro.org>
References: <20260610-apq8016-debug-uart-v2-1-acf43d28add6@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-apq8016-debug-uart-v2-1-acf43d28add6@samcday.com>
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

On Wed, Jun 10, 2026 at 11:57:20AM +1000, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> The dragonboard410c (and likely other SB-off devices) can run U-Boot
> early enough in the boot chain such that UART clock isn't started, and
> pins aren't configured.
> 
> APQ8016 has two UART peripherals, each with its own clock and TLMM pins.
> 
> Two new debug-apq8016-uartN.config fragments are provided. Each
> configures the appropriate UARTDM aperture. The newly introduced
> DEBUG_UART_APQ8016 Kconfig symbol pulls in MSM debug UART, and enables a
> board-level debug_uart_init function to start the right clock and mux
> the right TX pin.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
> Changes in v2:
> - Rename APQ8016_TLMM_GPIO_ENABLE to APQ8016_TLMM_GPIO_OE
> - Link to v1: https://lore.kernel.org/r/20260603-apq8016-debug-uart-v1-1-1e46b2cd0fe6@samcday.com
> ---
>  arch/arm/mach-snapdragon/Kconfig              |  9 +++++++
>  arch/arm/mach-snapdragon/Makefile             |  1 +
>  arch/arm/mach-snapdragon/debug-uart-apq8016.c | 37 +++++++++++++++++++++++++++
>  board/qualcomm/debug-apq8016-uart1.config     |  4 +++
>  board/qualcomm/debug-apq8016-uart2.config     |  4 +++
>  drivers/serial/Kconfig                        |  1 +
>  drivers/serial/serial_msm.c                   | 10 --------
>  7 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index d3de8693b5a..43e6fd1bc42 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -1,5 +1,14 @@
>  if ARCH_SNAPDRAGON
>  
> +config DEBUG_UART_APQ8016
> +	bool "APQ8016 early debug initialization"
> +	select CLK_QCOM_APQ8016
> +	select CONFIG_DEBUG_UART_MSM

Should we have the CONFIG_ prefix here in Kconfig? Not sure if both
works, but I'd expect this isn't required/typical here.

Thanks,
Stephan
