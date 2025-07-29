Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40D5C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0F5829F5;
	Tue, 29 Jul 2025 17:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K4rYRRFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E050D82BCD; Tue, 29 Jul 2025 17:57:42 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3E9829E7
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso59136985e9.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804660; x=1754409460; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BszAnaDpv64bCI2lqD6q+SKtEvY7eQwIWLytJ46DSsA=;
 b=K4rYRRFb8qoG+KcuRPnHcs27mIv6gcKbATJJw7/cz7YL7xvcK8j+VzNXWgXis7sidS
 wbPVNO0BL8Y27bEnJst7F+njQiupZpRwVJv0PI90eRzjgCa+zsM+cHgPDefV70l+A9ZI
 7mA+tb607Tc9hc3TEbHsRO+WUnfEV4A3W7T27Dtv96knGdtvGSR6ue6LeZ+xuGG6Bp9O
 JeIKQdjclKm/XwZs1ri6QLkNgV7IJzrpp2LMzkvNOodwvDa4juGl4hZ+8Lp9RChshXQ2
 ftEktWA641ZuOEnnI8/c0q5Nn263ur5Arbp8+mzmLb+N4XEtDADkqIp+aLhJVA0UGjEZ
 bmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804660; x=1754409460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BszAnaDpv64bCI2lqD6q+SKtEvY7eQwIWLytJ46DSsA=;
 b=J5mZLW41pDR7SHaV3qBxdAai7Uyoqz5MxSHlKhcb2u7h0aZVOj5PrD/VxTjlDT+U3F
 5jNsVEJjHmojJpCcVVuekn71CAU/yosMwcA6Db6tRVKNQTtBko3R2lebYTz3fsfGI9MJ
 JH9Q91TkqsXXMhIjSDYJPwKyPjEm9vUL4m06o8h38r3nbGk6EkTMdIsyK7KjwsJ0kEPq
 kvX4guG55cx5EpI7rjPbn0Ts3a5dNpI4SjE615I23i71wkyNQD6CUk/1dwHJ5GbOubTZ
 7EXnwrJNpHmnUdSogjDm2iB3aom7fx7XsEYsig9ZSjyh/QKXA+tjTsDzicfqITrannSn
 Cspw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyw8J6++z9Qh/PHvH0THD+uHMIedtSQud8L/Mr0iLJXsiQOTVDJUWiYnLNovMfHv/M9jcN8Uo=@lists.denx.de
X-Gm-Message-State: AOJu0YwH0rIABsPeEGXF6QcR/eqvOoWys+T+Z+TRZvImveDJchDcg8S3
 Wx/DmqNh+7ky8FISVVq/jBPwMw/BJtVB+GykshCLY14dgLzZlWYn44+sc/9ZhM1qVDI=
X-Gm-Gg: ASbGncvMDGCPvibnvBKYMYuNdEGMEQ/8KT3BhAtVSfAb/Q9PtKmGmFXFW/F35cr9/ey
 i1T8qR+t5jGgj2YJm0eOM6E25iH3xbPLuPing+t/GHYhktwked2F27W3zNQ4w14oi1Mnyhj3Tk0
 h7Gxe3+WQ5PjBuoP+KkT8htzXeKMXkTnzkCUuX0dAVprtkMo89zJLfSboPSCEoFYvF0gpcu89T4
 f3eX+pHZwStV63NNK0T7hwfcpMpGuJzz0pzNjAR6lcE7MHG7/pMmSJk+tDLaMEvYwa5nnvNRbVi
 0YL2lLhqHlzKv7yUsdbPOxRr0rklTwJhqqqp/Qd80EhBcEw/ftzXQrbeS7bFUOuqYWF5FJaoWHo
 A4euzP4G/qV5HkGhOYHR6PdBqT2cfy8M3YVv2fb+YKKsHd68CLL5WLcFNLENe8RdWRDef816StA
 ==
X-Google-Smtp-Source: AGHT+IGVb4dlNFs6MKb6U5+aRxuP5D3QUzi7LJxES+2FwsHo1soNv8076if/lKah6QBz3KcKwBWTMw==
X-Received: by 2002:a05:600c:530c:b0:455:ed0f:e8d4 with SMTP id
 5b1f17b1804b1-45892b9dfd4mr4231685e9.10.1753804659759; 
 Tue, 29 Jul 2025 08:57:39 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054ef47sm202437835e9.8.2025.07.29.08.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 08:57:39 -0700 (PDT)
Message-ID: <228b7fe2-bb45-4a15-befd-6a4dc6409c29@linaro.org>
Date: Tue, 29 Jul 2025 17:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] lib: expose unwind_stack() and call it from
 panic()
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
 <20250729-b4-arm64-backtrace-symbols-v4-9-8d8bda8e22c1@linaro.org>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-9-8d8bda8e22c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 7/29/25 17:52, Casey Connolly wrote:
> unwind_stack() will walk the callstack and show the symbol names
> if available by using the architecture-specific framepointer
> implementation.
> 
> When available, call unwind_stack() during a panic to give more
> information about what caused the panic and help with debugging.
> 
> Adjust the interrupt handlers to call panic_str() to avoid duplicating
> the backtrace.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   arch/arm/lib/interrupts_64.c | 8 ++++----
>   include/symbols.h            | 9 ++++++++-
>   lib/panic.c                  | 7 +++++++
>   3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
> index 08d81ca7f654c586521ff97bb5ca37229c9b939d..949ae0f94168fd53036c1dff376b574808ebf9ea 100644
> --- a/arch/arm/lib/interrupts_64.c
> +++ b/arch/arm/lib/interrupts_64.c
> @@ -109,10 +109,10 @@ struct stack_frame {
>   
>   static void print_sym(unsigned long lr)
>   {
>   	/* Print the symbol address and the offset to the LR */
> -	printf("\t<%#016lx> %s+%#lx\n", lr - (gd->flags & GD_FLG_RELOC ? gd->reloc_off : 0),
> -	       symname, offset);
> +	printf("\t<%#016lx> %pS\n", lr - (gd->flags & GD_FLG_RELOC ? gd->reloc_off : 0),
> +	       (void *)lr);

Oops, I fluffed this fixup commit.


>   }
>   
>   /**
>    * show_backtrace - show backtrace using frame pointers
> @@ -228,9 +228,9 @@ static void except_msg(const char *msg, struct pt_regs *pt_regs)
>   	show_regs(pt_regs);
>   	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>   		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
>   	show_efi_loaded_images(pt_regs);
> -	panic("Resetting CPU ...\n");
> +	panic_str("Resetting CPU ...\n");
>   }
>   
>   /*
>    * do_bad_sync handles the impossible case in the Synchronous Abort vector.
> @@ -279,9 +279,9 @@ void do_sync(struct pt_regs *pt_regs)
>   	show_regs(pt_regs);
>   	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>   		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
>   	show_efi_loaded_images(pt_regs);
> -	panic("Resetting CPU ...\n");
> +	panic_str("Resetting CPU ...\n");
>   }
>   
>   /*
>    * do_irq handles the Irq exception.
> diff --git a/include/symbols.h b/include/symbols.h
> index c5267edbe768f304bc0f6235e71a39b6c3835a67..845f993060f042139df46bcc51a0180faadc35bc 100644
> --- a/include/symbols.h
> +++ b/include/symbols.h
> @@ -4,9 +4,9 @@
>   #include <string.h>
>   
>   #define KSYM_NAME_LEN 127
>   
> -#if IS_ENABLED(CONFIG_SYMBOL_LOOKUP)
> +#if CONFIG_IS_ENABLED(SYMBOL_LOOKUP)
>   const char * __attribute__((weak)) symbol_lookup(unsigned long addr, unsigned long *symaddr, unsigned long *offset,
>   			   char *namebuf);
>   #else
>   static inline const char *symbol_lookup(unsigned long addr, unsigned long *symaddr, unsigned long *offset,
> @@ -21,4 +21,11 @@ static inline const char *symbol_lookup(unsigned long addr, unsigned long *symad
>   	namebuf[3] = '\0';
>   	return namebuf;
>   }
>   #endif
> +
> +#if CONFIG_IS_ENABLED(FRAMEPOINTER)
> +/**
> + * unwind_stack - unwind the callstack and print a backtrace.
> + */
> +void unwind_stack(void);
> +#endif
> diff --git a/lib/panic.c b/lib/panic.c
> index 0f578b5b5131589d215f5f4b16b95d9c9f3e8ce3..6f8bd7cc1eef7e5d97ba925bef65cc46924b4418 100644
> --- a/lib/panic.c
> +++ b/lib/panic.c
> @@ -14,8 +14,9 @@
>   #include <command.h>
>   #endif
>   #include <linux/delay.h>
>   #include <stdio.h>
> +#include <symbols.h>
>   
>   static void panic_finish(void) __attribute__ ((noreturn));
>   
>   static void panic_finish(void)
> @@ -44,8 +45,14 @@ void panic(const char *fmt, ...)
>   	va_list args;
>   	va_start(args, fmt);
>   	vprintf(fmt, args);
>   	va_end(args);
> +
> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER)) {
> +		puts("\n");
> +		unwind_stack();
> +	}
> +
>   #endif
>   	panic_finish();
>   }
>   
> 

