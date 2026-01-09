Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FF2D16810
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C338431C;
	Fri,  9 Jan 2026 12:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V9YWK945";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26168431C; Fri,  9 Jan 2026 12:33:36 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FAF183F56
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so44113005ad.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958413; x=1768563213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0nonbAbZSf2+cAS1MyY499SVCPiwbq6ANHdmhdKQHBY=;
 b=V9YWK9457oICBS7DzkJuwAEVBa3X8nSn4EoqD0eAizJ8qlPWmjIxo9NTmhnqkR+zYu
 8uI67PAKfBhnS30YWPr6qhOwH2Tk+idai4tNjV7wjkDmClTjGj7B5RAfbsRhyzyMFaXT
 KmOjRC5VfpwDZQTwLxFJpC9T8mkSt+e9QY/zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958413; x=1768563213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nonbAbZSf2+cAS1MyY499SVCPiwbq6ANHdmhdKQHBY=;
 b=XvsEcdfRsylzJe6h6ZARrtJLaB3kcrTTw2mOM8i5pxpaPVMo3kpoFY0ENEa3M0Qb7T
 AJF2UO5E4CRJXXGzTlwUkkuQ9aMvGtKfprXuJOJ7HkvdZYA+sqpbnkyYSk0l3cc4B+On
 EiS3qel4IplwB1L/XkQJ+N2tNXZT+eNDgTs6W0G0weCsd14FEv3+9Q4oPOVK4pxBfPJd
 GleSyDhRRuJSi9EUISR/9orf8Dhvu7SeyLjbxvO/v1kcG/pGM5QmC+oWRyzuzycwFwhy
 1EULg1YXVrLOFnaviLK2c3kiuzsKajfchUkKw4bSoGHwMiBopywX4miOA1nEQZn0fbet
 1eRw==
X-Gm-Message-State: AOJu0YwVYYwwEL2/OCkAtSjz1lLcnchjKRT+yJApfMIQr7pBAONLzgJW
 saa+/b3Y5CU683+c1no7L3JeeJ/fK7tKKm7F2FIJyPQcecqAbl5Jd158kLavL/bsNv0XM51/Q6b
 pVH5HlwkBtivA3UANZkUOM4OinstBmQUyICPLdW/5
X-Gm-Gg: AY/fxX50OF8JpoUBgcI5iz2DiMCbB8/N3L+lb8T7F78TGG6I2kDXbHX3aqJlcftGY4t
 +e3Z7Ht/L4xGiIRRYthBtWZT5uZDnzeTay5Ti45pDzqzF63UTmbwl4L5IPjIwIr8KPKXWjbNJi+
 3QYbhSOz6YzyV71YYJz4wPPzd5ikFsNW+gaQZDNw6zNpPHM5nxupUMfSEI96ZeANTfpf6dm4INS
 eufRknE4KCYmYnk2xFzEbDggd+0OY2IwVTlzGBjF/aOGXdBBYeBAwdUQkh3XpQ+GV5Qtg==
X-Google-Smtp-Source: AGHT+IFP2a03sWtKz2pN1oKl0MysvDg72L12OHG0lYfuDox5xDpm/LQ7qB4seDbNoSFaTknj5hG5A3UE39QZ3Ih9390=
X-Received: by 2002:a17:903:1a8b:b0:2a1:5785:4417 with SMTP id
 d9443c01a7336-2a3ee487487mr89898575ad.34.1767958412955; Fri, 09 Jan 2026
 03:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
 <20260108-topic-musb-probing-v2026-01-v2-2-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-2-2a47c6e0e73a@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:32:23 -0700
X-Gm-Features: AQt7F2oR6UaMoiixcD5twJgQzkknTQoviOTOAzY4-OotF669EOpBiLj1mFodZo4
Message-ID: <CAFLszTiNU=2cJTkB2c8d4NrFZ7K0KR7LQnPYO0TWzX_BuBrUFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dm: core: lists_bind_fdt: Replace found variable
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>
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

Hi Markus,

On Thu, 8 Jan 2026 at 04:17, Markus Schneider-Pargmann (TI.com)
<msp@baylibre.com> wrote:
>
> 'found' is only used at the end of the function to print a debug
> message. No need to maintain a variable if we can just return 0
> immediately when a driver was bound successfully.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  drivers/core/lists.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> index 52ba6c7bfa007b660b854de62c97ad3c1761f1a5..9d1ca38212ee7f53b8894f964f096611c8ec20a5 100644
> --- a/drivers/core/lists.c
> +++ b/drivers/core/lists.c
> @@ -204,7 +204,6 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>         const struct udevice_id *id;
>         struct driver *entry;
>         struct udevice *dev;
> -       bool found = false;
>         const char *name, *compat_list, *compat;
>         int compat_length, i;
>         int ret = 0;
> @@ -275,14 +274,14 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>                                 ret);
>                         return log_msg_ret("bind", ret);
>                 } else {
> -                       found = true;
>                         if (devp)
>                                 *devp = dev;
> +                       return 0;
>                 }
>                 break;
>         }
>
> -       if (!found && ret != -ENODEV)
> +       if (ret != -ENODEV)
>                 log_debug("No match for node '%s'\n", name);
>
>         return 0;
>
> --
> 2.51.0
>

I like to have a single successful return at the end of each function
so that it is easier to follow what is going on. But since you wrote
this patch:

Reviewed-by: Simon Glass <simon.glass@canonical.com>

Regards,
Simon
