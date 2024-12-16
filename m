Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382ECE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 00:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602CF80137;
	Mon, 16 Dec 2024 01:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DESILEeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98BB80141; Mon, 16 Dec 2024 01:25:52 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E0CC80050
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 01:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df91so4167170a12.0
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734308750; x=1734913550; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KI+RtTi2SO8nCsQnnPld1BN+olyqON3SAwYU0Ytf3pY=;
 b=DESILEeTKcMFg9EoB2O8JBdHbVYaMyTijp9As6eSTq7EqlQWe8eo119ZmFbfA9K8j9
 oNTZLC5ib2CiYwFdS/RwHvNGVidBw+iCU6kJLoww6OmJoJlh29Tf3uQctoEOsoRKXGK+
 rhQof+eHYfs0bG7MCxizZSAHbKVVKG6aB/EDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734308750; x=1734913550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KI+RtTi2SO8nCsQnnPld1BN+olyqON3SAwYU0Ytf3pY=;
 b=ZBcriq6EJG4CtaOtFnFuwv9sq1TIA19e7Znv8SsgwK7cbJ634rb2l/A1Uud5YQ8aCN
 qMIa85L/zKflYmMKjT5bDFVBgfgZYvmdgmezyDCYtSxLUyYMKQqSWp/+gW42WesZC63P
 NOnl8pje9qcRWPi4ptDdeMexeD8dspA5O+hOBNynFvO86Px96AuEPpJpXjpI/4kdCJGR
 npBAmhIgO9P8rfcBZWu5SNQLArfJ9GMBxTv4G44iOYEI+eoWhu7QzW2M3slVZ4tJ7qly
 LwSLOCRX4BR/hqH/6vqpsHJTG40OgBgtJdhxV+rYLlDBoGPflkQ0Q6YZv/31xcUm/UnW
 DB6Q==
X-Gm-Message-State: AOJu0YzG/tiAVBPKwz6IY/x29v8NuHnICz923kOHpV64S8USWB/fPUTA
 DSMhaiH4vZu2ND1m2RH0cjAodHUgYgSQq4hoN8M8CUN45Rmn4ZkxDuFMIAmQuiyiX6xj5J9givh
 HCV4FiBHM4sbPwN0v4jx4O5bl/qcq4MfpiYrzsMwAIn/G7wo=
X-Gm-Gg: ASbGnctGJ/3Wv5QcZCZyu+z1Ys9NylBU/AUr+wiyTOjBhrKM61dME489YsoHtImE3T2
 8oT7wr1L1sAz0USkXc/ss1X/I8N4nD9IhWyRcXz5hMNqp2rOP3GUuI5Lj4NOpYpBxUfQi/mo=
X-Google-Smtp-Source: AGHT+IHiG4PeXbxSe/7hyagrgJYNQ1ihGilRZdyaEKzCuYWHq47UuIA6KLZrBt0jznXfMbseJm9OslrZTM2koh0R/c0=
X-Received: by 2002:a17:907:6d0a:b0:aab:7507:7a94 with SMTP id
 a640c23a62f3a-aab77909ca5mr1082487466b.16.1734308749958; Sun, 15 Dec 2024
 16:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
In-Reply-To: <20241213225543.392282-2-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Dec 2024 17:25:38 -0700
Message-ID: <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
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

Hi Raymond,

On Fri, 13 Dec 2024 at 15:56, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Get tpm event log from bloblist instead of FDT when bloblist is
> enabled and valid from previous boot stage.
>
> Note:
> This patch depends on:
> [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/tpm_tcg2.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 7f868cc883..acaf0acb88 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -19,6 +19,7 @@
>  #include <linux/unaligned/generic.h>
>  #include <linux/unaligned/le_byteshift.h>
>  #include "tpm-utils.h"
> +#include <bloblist.h>
>
>  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
>                       u32 *pcr_banks)
> @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>         *addr = NULL;
>         *size = 0;
>
> +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) && !bloblist_maybe_init()) {

Please drop the second term...the bloblist is inited by U-Boot already.

Also please drop the first term. If you find it in the bloblist, just use it.

In other words, this code should be unconditional.

> +               *addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
> +               if (*addr && *size)
> +                       return 0;
> +       }
> +
>         addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
>         if (!addr_prop)
>                 addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> --
> 2.25.1
>

Regards,
Simon
