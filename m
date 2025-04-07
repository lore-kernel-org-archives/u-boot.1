Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6CBC3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 06:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F78482C55;
	Mon,  7 Apr 2025 08:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="II9URWLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884FF82C87; Mon,  7 Apr 2025 08:39:46 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF2182B9D
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 08:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so3477698f8f.3
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 23:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744007984; x=1744612784; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pJOYRWQAOwU/h4CyamtHuLRgXVYP2egr5v51VtxkpOE=;
 b=II9URWLefY3dA5TfnyVTra7aKNrYX6dcUfpd2sMxVkuzcgahuB40xVHoxwZ6P+2W2K
 ctjCM2cjdV73itCkJ2aFV6eQfw8YGz6vKnV2+0cQ/ZWjHNDKyn/jjpgQg6E/XS477HvJ
 YDY8whYD8TkUZJ9LIICqqtJg9wxtD3uh45KmJ/3trgl0SsAlO8KvdETACMl+NKhIRZlX
 iZ49mhc0U4BF6lKfr8U5dk0HqGZcu3U/OGNLTVXo6a4VCq1xcv9zzmKwR1vBv8CPv9tB
 Na1yZoGnvm2ie1NicoD5mZ6u2Cx+gtb6jldc88yOic0SLIpAs0wso292c/g+g/Rkww8n
 vQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744007984; x=1744612784;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pJOYRWQAOwU/h4CyamtHuLRgXVYP2egr5v51VtxkpOE=;
 b=L13b6Bedv4gu9p+VZg2bAdCyuSdHxiLk0xMRll04I1gS9A21RInc5lAy8ifuvxBPSf
 AqZwDdQpsUU6DuYkmu8FGo2EWtkAEmPmZHBjvtu2RfL2KMiDbQMWgtKCGv3/fZFcbG4r
 IxmurMM1B6zjP7qoo9ohVnMYEmp2kJkPc9m/eCPbx3eqgGgM107nHSNUcbkpfHsdALAH
 52KnaImeTnZGUlCLWQDK5WIDxqamlxSjsmzgHbN9TwtolYDJi+ZXL3FmQS8MSmjNf/D3
 0Yydd5q3rCjzaG2EYwyIN2/0sLjpIGewMj623yOhFhs4iouLKnlpsSJuwm0iirJ/MJue
 pq/Q==
X-Gm-Message-State: AOJu0Yw1C1hH/qismXazwNv9ytfxBe3YhT2NHVYWyBe//MtkmnnViYMq
 V1Z8LaFzRghxeajoA3HWC5o2sgl415O052KQFDmPBTV+EeCTL7cTtg8ykg0hOkI=
X-Gm-Gg: ASbGncs9wvtHM5N/OxrOh2Ve4tMy3Hg6w0nfN7rdl71oY7+fUcfWtDjCwF3BI1B7bYS
 TNgYS4d+izw/S1RS9HdlLO28NxaEhOK0MIjZnCZOySUhCMTaMxjQgC7dBxa19stMJtgyVto50Qx
 x6QgULoSXdluqGfxH/douksmI34lywxlHFhyY+NKc19s3MK59bWwYeHAQAeZpn/W6bqglNY76j7
 KKwKj+Ylnvo67ppe+ssth5j4hpmZvXURNoiweDX/u//LqLkvesUOxnTMSLpEJWSztJc8m1t2Nw+
 cu+YNNrgsEn4+q1QuGYdggFB5jwRHuezNEFXC8XzC2z+r4RN7Q6rIPGcqqTXZdk=
X-Google-Smtp-Source: AGHT+IG4d9ULWXvTuRHEHLj/rsrngOxCvJK+Sk9tD7TMFVq3PEL3X9+IKXxdEgyqjWZIH4YqTGWq+g==
X-Received: by 2002:a5d:5f83:0:b0:390:ee01:68fa with SMTP id
 ffacd0b85a97d-39d0de2564cmr9899084f8f.24.1744007983775; 
 Sun, 06 Apr 2025 23:39:43 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b76f2sm11220771f8f.53.2025.04.06.23.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Apr 2025 23:39:43 -0700 (PDT)
Message-ID: <d046117c-2a69-490e-8093-3d0f3499514d@linaro.org>
Date: Mon, 7 Apr 2025 09:39:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] board: atmel: sama5d2_wlsom1_ek: Fix spurious
 serial output
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
References: <20250404113919.3860489-1-festevam@gmail.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250404113919.3860489-1-festevam@gmail.com>
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



On 4/4/25 14:39, Fabio Estevam wrote:
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
> The reason for the spurious characters is that the UART0 clock is
> being enabled too early, prior to adjusting its correct frequency.
> 
> Fix the problem by removing the early UART0 clock enablement in C code.

I am not convinced.
The purpose of this early UART would be to get output *before* the DM
code would enable clocks, pins, etc, for exactly that purpose, early
debug output.
So to remove all this and make the initialization rely on the SPL DM
code would defeat the purpose.

> 
> SPL DM code will adjust the correct UART0 clock frequency and then enable
> it at the appropriate time.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Make the minimal change to fix the spurious characters. Improve
> the explanation in the commit log.
> 
>  board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
> index 04de1257eca0..ff5e51ee3926 100644
> --- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
> +++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
> @@ -45,8 +45,6 @@ static void board_uart0_hw_init(void)
>  {
>  	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 26, ATMEL_PIO_PUEN_MASK);	/* URXD0 */
>  	atmel_pio4_set_c_periph(AT91_PIO_PORTB, 27, 0);				/* UTXD0 */
> -
> -	at91_periph_clk_enable(ATMEL_ID_UART0);
>  }
>  
>  void board_debug_uart_init(void)

