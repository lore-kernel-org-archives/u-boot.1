Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7980AC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 08:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B712F803B5;
	Wed, 22 Jan 2025 09:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fxrSlrl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6884D80586; Wed, 22 Jan 2025 09:55:42 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F028780283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso3719996f8f.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737536139; x=1738140939;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dGWwsG/XzfO7NwnbGT0Xp/2hNB+Hmy5CfDuT7KyqAsg=;
 b=fxrSlrl+56Nc+9SKS1iypexOU7Du8ZPNlmonPTcwDc6NvyK/aMT7hrEU973P2ejCCA
 e6ralhw4vq2Dse2PQeUFSBe7ylwrHOuXH4J5flVP3hNZo53VnW5H5pc9RdA+YPSF4qVH
 eTWjuwfQ1mKoPKBvOQnofQrXbWqzVwzRTL6Sg7U50O8I31/PfubfI3P8RNlaxR4Ac4IR
 CMS+xqtuQnqnTxIIj81x4seEDnlgciLskZyIyx2xoOC8PkTOktK2IVcRUmxJDUNXVhS+
 Gf8wg4ESDVQyDyNfn+8aXwxpLdJHZiJKvoPcBELaVngxofJOLa8xpSDwCHeHfKz3mUek
 u2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737536139; x=1738140939;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dGWwsG/XzfO7NwnbGT0Xp/2hNB+Hmy5CfDuT7KyqAsg=;
 b=IVkLi/MX8VTY4P8G4ejlaB4vVE3gegk5lOem2QdLc26J6q350zHAlmm/15TRw1xvhT
 jBEASV+dWvaYmZD1FTWa7ZaIew17yj8jONhvARQOl9MjZuq6QzLNg8os7HcEmc7ZN73J
 79A360MLQWC/Rs26SVEydO5jjYgXrcvtNJ92kDkxnqTpcfVm6Q+qtjr1p3UyYccXpsGf
 sAz08xeECEqzRvVA9M6IlY3f5SXW5Ov7rUH8TxcWGJiuWj3inok8zgP7jyyissJLOI6z
 1Lmx+yhEoyuk8U/AiKnMXaWiHrurNzPjSFpegMcKwj1dWv71OD3cQ3HltZxJv2KIvau1
 +1jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNZEkkLfCKM6rcSUjoBMOcgySNGCsjss1W2ef9yu0/eLqsGJ/IgTACyF1NsTiymbOvSJ13BdA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9x/TDIwBGkCzFd/PSf7snFDtiOIKzrXyuUtLbLSIriRd4MvHr
 e3U2sLijYzN10ImtbMegISMF0AUvrzQ4Lr5pssq+dm0hagnMKwYsFUnBGyGCfV4=
X-Gm-Gg: ASbGncuuV7Pn4iKbGtlvH6iFX+QIflzYUztptuwom8LQ/pXbMQHBmdG/FicEaQSIuBb
 e1vXGOHfJSrgnAUWyZqlZNcN/KWiHOFwKOXk4pwsOHCBN8K8VCPeZGNvsrH9njaSu3mpLCeqqus
 BviqSt/MtvyPruV+ILpWCHNhfmeCD/o5MIfXXS990F8l9lqTM8A0oUh+dTNiTHIQQJbb8C/GAIz
 WVnEMIvGwsoqo6qNMnPRTvgguo7mXduAYc9vLdp85bPYP5kpBdw9yEWTiFAJCuKhYAgr5TuSe+E
 Gx24oDkLIOotmg==
X-Google-Smtp-Source: AGHT+IGf+XpOR0ZbaZev6nXAj7CaAHOfSzCQAOtoktCgm9+mNyNk0LsnDcb0CBxR6sd+zK9ywhmYiw==
X-Received: by 2002:a5d:6d86:0:b0:38a:8e2e:9fcc with SMTP id
 ffacd0b85a97d-38bf57befa9mr19968016f8f.45.1737536139214; 
 Wed, 22 Jan 2025 00:55:39 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3222bebsm15834308f8f.30.2025.01.22.00.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 00:55:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut <marex@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Neil Armstrong <neil.armstrong@linaro.org>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 3/9] usb: dwc3-generic: Reorder include
In-Reply-To: <20250120080120.51657-4-patrice.chotard@foss.st.com>
References: <20250120080120.51657-1-patrice.chotard@foss.st.com>
 <20250120080120.51657-4-patrice.chotard@foss.st.com>
Date: Wed, 22 Jan 2025 09:55:37 +0100
Message-ID: <874j1rkz1y.fsf@baylibre.com>
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

On lun., janv. 20, 2025 at 09:01, Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> Reorder include following rules available here :
> https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files
>
> Remove useless include files.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> ---
>
> Changes in v3:
>   - Update comment by adding "Remove useless include files"
>
> Changes in v2:
>   - remove useless include files
>
>  drivers/usb/dwc3/dwc3-generic.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2ab41cbae45..bc7d2d4234b 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -7,29 +7,17 @@
>   * Based on dwc3-omap.c.
>   */
>  
> -#include <cpu_func.h>
> -#include <log.h>
>  #include <dm.h>
> -#include <dm/device-internal.h>
> +#include <reset.h>
> +#include <asm/gpio.h>
>  #include <dm/lists.h>
> -#include <dwc3-uboot.h>
> -#include <generic-phy.h>
> -#include <linux/bitops.h>
>  #include <linux/delay.h>
> -#include <linux/printk.h>
> -#include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> -#include <malloc.h>
>  #include <power/regulator.h>
> -#include <usb.h>
> -#include "core.h"
> -#include "gadget.h"
> -#include <reset.h>
> -#include <clk.h>
>  #include <usb/xhci.h>
> -#include <asm/gpio.h>
> -
> +#include "core.h"
>  #include "dwc3-generic.h"
> +#include "gadget.h"
>  
>  struct dwc3_generic_plat {
>  	fdt_addr_t base;
> -- 
> 2.25.1
