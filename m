Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E904F3C24C
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 13:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE2F83F2A;
	Mon,  9 Mar 2026 14:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tp5rY3av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A465839DF; Mon,  9 Mar 2026 10:10:34 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AEAB83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 10:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ae50a33ff8so57242395ad.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773047429; x=1773652229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i7rjWK49TUH9ekdp1QMxyQxU55YA5sQz5Chk7nKfYVM=;
 b=Tp5rY3avFDY4h1PRjCDjDCpvogVPCE501w1hYnSSKQ6baoAdeJGdq9NnjeQttuxr1P
 10rNk44aEYpv8qD1X8Wpc8Zq7Ar6BEAm2cOGGVjI0GLBknSz7ZHrQ7O2GdNBBjt0QrFo
 moHNNI73vmQs1PPuLL4fy5Lxhn74WJwqDQbv5JtmCB+mjb6X3b0ac1mtp0f4k9NY1J31
 BpiySMspZlqoy9ln3UyRsaoCSSqZfAdtLec2jnuNaukGsG2Z5vx1reGzjRc0B1J1GBWy
 n3weja3epf5cjhJTuAC5BeoSo3yteMjVhxxm78W6TF2q8nswLCLsiTkSlhDlF4572d19
 7KBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773047429; x=1773652229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7rjWK49TUH9ekdp1QMxyQxU55YA5sQz5Chk7nKfYVM=;
 b=i678ysO1/UhCd2/DhqjuWRrQfr0lasqMrAk41HJCRmdteh/d5d+F4jUeER7ddsG1kh
 rypy3MVVyx8+LbGAniqSwBynma2wbfLoSQ0ZlRN9WHsR3orEunw1ndZVeHS3zq/tt8IA
 f2uxNTkG1KNuOhAKjnxH/Dy1v0QxjCG6hmlHDTTsK7f0K+RHEgO9Ht86CbLKhJGjO9I9
 jO3LLs60h+XukJVfunLmzqq7u0g9HUHfyVHbK1Ux3FROBYNqGISsGZJEd5Zv9/y1C1R9
 giaScHzzobmIWGhL3mYTcb2gD/DbIfP5OjqNYPWMdSOmRWsxxy54YGUKIbNlQJaETBSD
 J0iQ==
X-Gm-Message-State: AOJu0Yzii+UwX+Bkc/5CXBnZHqUsb2MGkyVYbGAlAqvQei7YImWBWfMl
 kDOBBFW60bDSQ21ouT1IQYsFE27nmjs2WYpk0wIXcHmzRpi9XAxypjfghRM18oeO
X-Gm-Gg: ATEYQzyAxSWfq4WGGLpTBeDFXCAlQzozyTl32nxqCmv+JvnL2SRXswzaBRtLp1ZwyBJ
 NnU22kPkquCwaQhdS3mwbjb49KhhXACWk8hURKUO+IeCsW0kzATZk71uGGCAG5bItRdMcyHv+zN
 ZyR8KU3tuAREIPr6CMKIYtcPk8H1Z7A1lh7VwhTQ6VXd3TUwfxCJX6acA6X1/uCgOofNBu2EJQx
 p0KtCC2Q7t8R3h0RW/nIP/U6TyA6UbmCPT8/Ro5hex0GIewEY+PhGWrd4IQTXqzrEgXisdVrysH
 x5bOcumb4fqn1xLqalABEJqZ+N9tQQF01WKooFy+NQYfYQQ7ijwwDImnirz7A4bS7HsW79put4x
 fmhgZSrITRXZGylO25PqtTsBoQ1Og8PKO+JtW/eLsKdQhk3FwTwHWFGmFXBMIyf+622hUvwUadc
 pne+EwWM7tiaxqeMfh2/ZdQMvvM31AegOYXxcHJPbWkg==
X-Received: by 2002:a17:902:e5c6:b0:2ae:7f84:79e3 with SMTP id
 d9443c01a7336-2ae823840ebmr109033535ad.16.1773047429308; 
 Mon, 09 Mar 2026 02:10:29 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:b804:b819:bea6:9fa])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83e57af3sm144119105ad.13.2026.03.09.02.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 02:10:28 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:10:26 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] serial: goldfish: Add DEBUG_UART support
Message-ID: <aa6OgiIKC2Z6Hwv0@google.com>
References: <20260309023234.640209-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309023234.640209-1-daniel@0x0f.com>
X-Mailman-Approved-At: Mon, 09 Mar 2026 14:13:07 +0100
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

On Mon, Mar 09, 2026 at 11:32:34AM +0900, Daniel Palmer wrote:
> Add debug support for the goldfish tty so it can be used for
> early debugging. This will be really useful when adding support
> for relocation etc.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  doc/board/emulation/qemu-m68k.rst | 10 ++++++++++
>  drivers/serial/Kconfig            |  8 ++++++++
>  drivers/serial/serial_goldfish.c  | 18 ++++++++++++++++++
>  3 files changed, 36 insertions(+)

I think we should also call debug_uart_init() in qemu-m68k.c. This way,
the <debug_uart> string will be properly printed when the
CONFIG_DEBUG_UART_ANNOUNCE option is enabled.

> 
> diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu-m68k.rst
> index 6c4de54cf6a8..2f2e6bd6444a 100644
> --- a/doc/board/emulation/qemu-m68k.rst
> +++ b/doc/board/emulation/qemu-m68k.rst
> @@ -31,6 +31,16 @@ The minimal QEMU command line to get U-Boot up and running is:
>  Note that the `-nographic` option is used to redirect the console to stdio,
>  which connects to the emulated Goldfish TTY device.
>  
> +Debugging U-Boot
> +----------------
> +
> +If you need early debugging output enable `CONFIG_DEBUG_UART_GOLDFISH`.
> +The base address for the UART can be found by activating the QEMU monitor,
> +running `info qtree`, and then looking for the goldfish tty device and
> +taking the mmio address.
> +
> +Baud rate doesn't matter.
> +
>  Hardware Support
>  ----------------
>  The following QEMU virt peripherals are supported in U-Boot:
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index b84cb9ec781d..f6a696e6c94c 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -510,6 +510,14 @@ config DEBUG_UART_XTENSA_SEMIHOSTING
>  	  start up driver model. The driver will be available until the real
>  	  driver model serial is running.
>  
> +config DEBUG_UART_GOLDFISH
> +	bool "Goldfish TTY"
> +	help
> +	  Select this to enable the debug UART using the Goldfish TTY driver.
> +	  This provides basic serial output from the console without needing to
> +	  start up driver model. The driver will be available until the real
> +	  driver model serial is running.
> +
>  endchoice
>  
>  config DEBUG_UART_BASE
> diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> index 4ac2cfb62315..58c494918786 100644
> --- a/drivers/serial/serial_goldfish.c
> +++ b/drivers/serial/serial_goldfish.c
> @@ -115,3 +115,21 @@ U_BOOT_DRIVER(serial_goldfish) = {
>  	.priv_auto = sizeof(struct goldfish_tty_priv),
>  	.flags	= DM_FLAG_PRE_RELOC,
>  };
> +
> +#ifdef CONFIG_DEBUG_UART_GOLDFISH
> +
> +#include <debug_uart.h>
> +
> +static inline void _debug_uart_init(void)
> +{
> +}
> +
> +static inline void _debug_uart_putc(int ch)
> +{
> +	void *base = (void *)CONFIG_DEBUG_UART_BASE;

It might be better to use CONFIG_VAL(DEBUG_UART_BASE) here to keep it
robust for potential future SPL/TPL builds.

Also, since this is a mmio register, I think casting to void __iomem *
would be more appropriate.

Regards,
Kuan-Wei

> +
> +	__raw_writel(ch, base + GOLDFISH_TTY_PUT_CHAR);
> +}
> +
> +DEBUG_UART_FUNCS
> +#endif
> -- 
> 2.51.0
> 
