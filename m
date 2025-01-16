Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2644BC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 10:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E68E801B0;
	Thu, 16 Jan 2025 11:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ho7w6zKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2026780283; Thu, 16 Jan 2025 11:12:53 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D60B80040
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so373544f8f.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737022370; x=1737627170;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1sZLeW/e4nK6k7TBZfoml57UfddSa5n/ufI29ugtAVA=;
 b=ho7w6zKlDDZfc9P1Jt3MW/n3rZ+BeHxhfzwigM+uhEXclQ5JDbyNVZUvNq0tRVO+9y
 JAnfXbZwKzL48/8JlxX/mXlYCjrM2Cfhy8V+jyq2e7cgvv81NTRVJViCqE/kWamdKi5S
 1l8VD+zm3UudY7grZsvvWsMMaq8g7jK1pNWCylV2R3fpmoKpreYYLNb54GjqrB6D6byJ
 IJfOzYDuG46tw637kabrr6mSkpGTrpHL+yjFtB7g2z62abuQITFxp+AV2Q9NUV6e0rqH
 qqVWTn0zdv7TyIDpPVan1ko+ov/WSRBI9kSz/1uTFxmdnlIznt6Vtg+8DIZSwn1luRol
 qV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737022370; x=1737627170;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1sZLeW/e4nK6k7TBZfoml57UfddSa5n/ufI29ugtAVA=;
 b=keNPZLqT7l94Tvf00Kg2d/AvMDc2byuGIino8B9p3gzFxqxg7OzGGf9YktRrTHn1/k
 T9M508QfkLeKA/8oF2ZyKxeGHqX/6gcdQXrO/FRXqvvvmjHgM4o5NXKhlnEqp/DqUaDK
 dY1tBhoX8pJht78ks3HKln3jVkBjLGamS4n/cS27Qmtvemh3Iw1E1zEyXK91Nl36m9Fc
 +Epv9lFE/z+P+V2EwXfY/Qklj2hILUllW7C5BtCl2n2+Eqpg3FPvQpOat+0bxipBbWDr
 RaL58RHrrrnhRQqW2bp6v6Zgcabta2MK3TO+ZlylQUjV/vr1ficC/CfyfJZD1/4+/tSD
 T3Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8v2KPE/qC9jlADPbbxitAjayjB8f11MyuuUpLvjUERaQEL+3m1ek7ao+WMIDJrTUEwoOZMw4=@lists.denx.de
X-Gm-Message-State: AOJu0YwUMCnaP/Lb8y/bpnYMubdUbdvZrlEf7FkaxpJ0olgRKdvmoas/
 Cb6NpUtsru724x02hMYH1tujcTI+BxBbETM/PbmsQX7ubdFjD9v7O/dSpSnPCJUzRKZybatvwv6
 t
X-Gm-Gg: ASbGncsv2XYpuocoj+C2Gwx/UfRGkpkRylf4bYJhzpNMR9j6onGHHmXlIVDJbnZWoYg
 jUO1dEPVD/atBS9DHFA2cPJ0CX5MiogT8mZwFLKXyuc7ZWoPWUXhzwwsnZjRWM2688LnOPS8TxZ
 PVHBDQ5oZX3pOxDfR1yu4dMCZ8f3uj0Wbh3BH1EFbSHXXN/5wlxO4cVSvGyYzr9ECdYEauaW6v3
 n2xbm8EzDnAyRWb7YTwHB8G7NMd7y3GXQ6nr6NKxUdsCNU7dHpWfg8lcLurqtl/fg==
X-Google-Smtp-Source: AGHT+IEBZWWf0hGg7JL5kQsEal9SRk5oUcOVywFDBMAFrWyGSiXNusntukw7nhveXpQ7uj+4xENPUw==
X-Received: by 2002:a05:6000:4007:b0:38b:ed19:756 with SMTP id
 ffacd0b85a97d-38bed19084cmr1539162f8f.41.1737022368574; 
 Thu, 16 Jan 2025 02:12:48 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b7f79sm20398446f8f.69.2025.01.16.02.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 02:12:48 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut <marex@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Neil Armstrong <neil.armstrong@linaro.org>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 3/9] usb: dwc3-generic: Reorder include
In-Reply-To: <20250116081738.2511223-4-patrice.chotard@foss.st.com>
References: <20250116081738.2511223-1-patrice.chotard@foss.st.com>
 <20250116081738.2511223-4-patrice.chotard@foss.st.com>
Date: Thu, 16 Jan 2025 11:12:47 +0100
Message-ID: <877c6v83ts.fsf@baylibre.com>
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

> Reorder include following rules available here :
> https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

Nitpick: we don't state in the commit message that we also removed the
unused includes.
A sentence like: "While at it, also remove the unused includes" would be
nice to have.

If you need to send v3 for other reasons than this comment, please
consider adding it.

In case, this is a nitpick, so:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>
>
> ---
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
