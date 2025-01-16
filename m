Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DB2C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 10:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B87A380716;
	Thu, 16 Jan 2025 11:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rUwX367y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D4478070C; Thu, 16 Jan 2025 11:15:49 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8D380040
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43635796b48so4599045e9.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737022547; x=1737627347;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=er8rp9CGjktBCm/y58SqcfOGuzBpC60m/kkY+m+C7e8=;
 b=rUwX367yllXm5tHxII3Oe3e7KFYFqd1i7eflNl+1gGzL6jmgG6ZCi6Cn8/hTqGyQrB
 6bwsrh3VjwAIgQEngiwp270v4IxYpKtx+FPkpKF1gmWgcyugRuqxkV63JYXMcp33nbzx
 TgW0nMltlOcQK08j/JYnvI2Fma3jk6tauE8p8X6mo+RkFUERXBAQwJmu6IdqBIFtFD2F
 DXven9dpFkJd3uuEJqzfCidJZxfqidHjkCbb/0RUCWRq9IWpqaQh2Bdtb8+/spd+xsf3
 rKN7hxDDm4UE2TfkzLPnYRio2c+SNF894tQDzXQmfoj3m405HF6awR78pEPn1DH96t4I
 RiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737022547; x=1737627347;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=er8rp9CGjktBCm/y58SqcfOGuzBpC60m/kkY+m+C7e8=;
 b=rOgjllwnpmxr+tu8UA4yHfB5d474f2Va3a8SWZB26Oc1VTnw7bA3fVy4ddKIYKwgT+
 8SncXz4yLds6jeAykHo4jFZ0IwbzbsHHzkaRVlv7u+d+Htp+JtRsshbV5zmhMYqtm8mW
 L1gmhT39DYn8sveJN1es4sKmcJcBKbUW/8OfjQA2E1MjuAlt92hUJr02moOM3It6jI/K
 oJ6HJ86wjovmNU6+vuP8aZ49xEW+b664xwNX/eoyfRCjeOvuKYAIuslxjOzw/6HJazqs
 Nlj95HJ2Iby6CTugXMU72WON/qBvaV6D+B3ZgKXqk/l7qNHUM/1bdxzdSq6rueNbK4FW
 45wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb/9Sxoj5Iq7F1W6qc68xmuFbeuiFoyTFHDGMnrwFJwHIpTR1WM2mMin/AliYrR104WJ6Syjo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0zQasqes5IGo5NpP0z1WVkoITO7PmY5zEqS5sWcslfQ2mpk8F
 3yw7WRLIgjqGUV4ch89nWx7FTrtOsSyXypIYgPj4y1q6TuQMLzo/tAbBoUvOqdA=
X-Gm-Gg: ASbGncsjj1k8J2pi+OGuq5vA9J4e9QCIQptxahQcJCok1zw39kVbCEUJSROfGibmwg+
 Ns6cR+gArJQl9Fh/2Xf3xGRt8FEE2OKA5CJbNi/6pnDM1FNC4vbE3jcjakszRa9bONLTGTMLvrW
 +e3/97Zwksynjv/Kr2OZ9d/RmwAnz3ttbNfTHvWLbgD5fo3ZmbeR8wczCpHJiGYxZAW8lOvloZ0
 aO3hjer2jS1bV5N0WP+SDYEuUy5IZwvHjuuBxsFnV+Az3NgZI8RB3ZX3TafhKnejw==
X-Google-Smtp-Source: AGHT+IGBxsvY2KXA1C77rcCpOr3Sm2NbLbNgg7tMZCybLr+FbNI1hNLQ98qcgq2DDnVGcFy8lcvnIw==
X-Received: by 2002:a05:600c:a014:b0:434:e69c:d338 with SMTP id
 5b1f17b1804b1-437c6b014f7mr50794935e9.5.1737022546935; 
 Thu, 16 Jan 2025 02:15:46 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499558sm55137405e9.8.2025.01.16.02.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 02:15:46 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 8/9] board: stih410-b2260: Remove
 board_usb_init/cleanup()
In-Reply-To: <20250116081738.2511223-9-patrice.chotard@foss.st.com>
References: <20250116081738.2511223-1-patrice.chotard@foss.st.com>
 <20250116081738.2511223-9-patrice.chotard@foss.st.com>
Date: Thu, 16 Jan 2025 11:15:45 +0100
Message-ID: <874j1z83ou.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Patrice,

Thank you for the patch.

On jeu., janv. 16, 2025 at 09:17, Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> Since DM_USB_GADGET is enable for this board, board_usb_init()
> and board_usb_cleanup() can be removed.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Yay, glad to see some more board_usb_{init,cleanup}() getting removed!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  board/st/stih410-b2260/board.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)
>
> diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/board.c
> index 3a495eb5089..8ad593cccdd 100644
> --- a/board/st/stih410-b2260/board.c
> +++ b/board/st/stih410-b2260/board.c
> @@ -7,10 +7,6 @@
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <asm/cache.h>
> -#include <asm/global_data.h>
> -#include <linux/usb/otg.h>
> -#include <dwc3-uboot.h>
> -#include <usb.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -42,31 +38,6 @@ int board_init(void)
>  }
>  
>  #ifdef CONFIG_USB_DWC3
> -static struct dwc3_device dwc3_device_data = {
> -	.maximum_speed = USB_SPEED_HIGH,
> -	.dr_mode = USB_DR_MODE_PERIPHERAL,
> -	.index = 0,
> -};
> -
> -int board_usb_init(int index, enum usb_init_type init)
> -{
> -	int node;
> -	const void *blob = gd->fdt_blob;
> -
> -	/* find the snps,dwc3 node */
> -	node = fdt_node_offset_by_compatible(blob, -1, "snps,dwc3");
> -
> -	dwc3_device_data.base = fdtdec_get_addr(blob, node, "reg");
> -
> -	return dwc3_uboot_init(&dwc3_device_data);
> -}
> -
> -int board_usb_cleanup(int index, enum usb_init_type init)
> -{
> -	dwc3_uboot_exit(index);
> -	return 0;
> -}
> -
>  int g_dnl_board_usb_cable_connected(void)
>  {
>  	return 1;
> -- 
> 2.25.1
