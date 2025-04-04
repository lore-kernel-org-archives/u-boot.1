Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D8AC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 07:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C87828D0;
	Fri,  4 Apr 2025 09:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="soz5HaOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFC88291D; Fri,  4 Apr 2025 09:04:01 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40F7D828BC
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 09:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso11276255e9.0
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743750239; x=1744355039; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dvCJnUBb9WJwrd/FC2yUFkZytgdfYP0UBdIKIQoQbz4=;
 b=soz5HaOxGA2zRV5oGSeMOfvw28DgvqMkG/iYrN99xMaMOH+OrCWY0sTP/3vIJtdIYI
 pKkNlSum9mUz/YifhYazGY3wCD2jODhShoLy3r06nLxdyXq6dM5FpBEbXVE+/rZ8cYwP
 vHobjPMds4coHeJHQYQAqzA3h3KltOac+z3HuALdgts0F6K36ki3E3mxhUEW1vyp8MVa
 S55sBF9GsWUTXeUuw2x+WGw4t5yJZYJ4FttY/aven2Aa8bFIYxcmEPA+4nsEj6DL+ZYm
 W5ah60glDJoeNOHbrLIFysL1+PAe2UwPF90TIPVGDZPJHKsvQe+lSkNejVVD6rZcr3XQ
 GR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743750239; x=1744355039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dvCJnUBb9WJwrd/FC2yUFkZytgdfYP0UBdIKIQoQbz4=;
 b=qhrM41j6c1w5YyEWac5t8YeuanMljahIXpqsGWYW4u36PhrVK1YNq2ebdTfgBNZZx2
 +qIYG5YtRpx429p8ZxibrDbEJN7C1ZRowEz2uaZu5j5PgAi0tTppFOLQbFJgW7B8Yd6Z
 nE2I/smHPpSNnf+c1ReBzoWcbYbLK0rPvkv3zVJoop90lxmUwE+zbX3ZlDA8JyXe4vBm
 eblhBcH+bIU4waprcwXzEMoukVluZHwIJT2zb+UulkrpDJJJe0dEc5CaGDD/vp6Dt4tc
 PBuQJQ9pYUzsTZFODp4HLejPUNjYIcSQe11G6RDab6cUZJiiwTrwCuLAKR2gOiiSFO18
 G6sQ==
X-Gm-Message-State: AOJu0YyVdw8rmbt0Ctz0xoCJWyUYMu11CnN69fU1q148DP6WKfpbQ6Ri
 dVkydkGApNfHngNojUHLzdN6j2eo9s2LrMHhpkl6kQJNndkrOdZBqrKa5Ek5aL0=
X-Gm-Gg: ASbGncs7hU2ilB6XlNzRxZTrU5fN3kltkf1GyIJLvSCDDXCEp5ngmsdf+kuJg5jO7Y3
 +iB89t6gj/s5V5s61QM642XFhxl5QqG8aLQl4atNydMKU9oMjG4dRCfLj6vcsqKyP00y1vZthg5
 Y8g++eLRWYFpZnt53VQKarjP8ufiuZZyIPuuLAOOmJD9eeTT+POyfpeWu+XdQueJbsvF+YFJWj8
 bjfvu1wYEJDuWwWpRgQyqb0AgDiXtJG7ltNLGeLcdqVXS/NFcb2ze+5Y8dqzk55qu46yD2AmdRo
 TCtG/zzyp1iOmwbuabSzZho+47IRGEY5gLNiYWcdrclrc4Q+zlfJ
X-Google-Smtp-Source: AGHT+IE1SyethDYOC4ysbt84X5ckYF40Bm7fPamZ8JgoedsZjzBRfsa3v7jYviZpkUNgp5kiNZz5KQ==
X-Received: by 2002:a05:600c:3b27:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-43ecf9c4686mr9400375e9.23.1743750238666; 
 Fri, 04 Apr 2025 00:03:58 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b8a3sm40830005e9.19.2025.04.04.00.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 00:03:58 -0700 (PDT)
Message-ID: <97b00a14-e866-4d23-88b8-e84410ebe036@linaro.org>
Date: Fri, 4 Apr 2025 10:03:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: atmel: sama5d2_wlsom1_ek: Fix spurious serial
 output
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
References: <20250404023642.3793338-1-festevam@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250404023642.3793338-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 4/4/25 05:36, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, there are always some spurious characters showing up
> right before SPL banner is shown:
> 
> RomBOOT
> ���=������
> U-Boot SPL 2025.04-rc5-00023-g9ed4e2c45f25 (Apr 03 2025 - 23:23:17 -0300)
> Trying to boot from MMC1
> 
> <debug_uart>
> ...
> 
> Fix this problem by removing the redundant UART iomux and clock
> initialization from the board code, as they are handled by DM code.

If it's a redundant initialization, how does that lead to spurious
characters ?
My take on this is that the UART is initialized too late, and the lines
are floating for some time.
... or wrongly initialized vs baud, etc, for a certain amount of time.

> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
> index 04de1257eca0..a0ecc4f42a90 100644
> --- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
> +++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
> @@ -41,17 +41,8 @@ int board_late_init(void)
>  #endif
>  
>  #ifdef CONFIG_DEBUG_UART_BOARD_INIT
> -static void board_uart0_hw_init(void)
> -{
> -	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 26, ATMEL_PIO_PUEN_MASK);	/* URXD0 */
> -	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 27, 0);				/* UTXD0 */
> -
> -	at91_periph_clk_enable(ATMEL_ID_UART0);
> -}
> -
>  void board_debug_uart_init(void)
>  {
> -	board_uart0_hw_init();
>  }
>  #endif
>  

