Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1FACD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC8A84862;
	Mon, 25 May 2026 17:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XdxQKn+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BDD784879; Mon, 25 May 2026 17:14:47 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF478482E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-687d82dd690so3405686a12.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722085; cv=none;
 d=google.com; s=arc-20240605;
 b=GQbgclVZSerRuzWz9eVNoiIZ7Wl4qYZH56H/wndgfE8y7j5cBs/XsnJqAeJsOc3EUy
 NMrXG6NqIHFXvpqsBrzGiQySdmGuAWQdljNSwkkIIiRebAqrObYl9oY71eJLRidI6j7V
 W6Ms9eERfq3//4fKSDrKC3OY3/vt1j3PIaZN131stKs8JGqTd8kDuh8KOm++YaQ1g5lp
 0jV3oBeZgKheVspr0VnZgophX5Hzjm88usmdK+8KeGQwyJN3u+xKpw1UYXy91/a8hS4k
 GXWia/kDnYgTYpdKVghpOz14jnoQqYzMYJn8hRbnXWBnTRkqHE4MYiZGmr3F454L25rT
 Tm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sLhVfYVW/YkNoRu/w3UlANT5PgY1bTDbfIJIpLCy6Ps=;
 fh=mF8mApqaJ/xFjUdmSSdkaUQ+2N+5Qe4Eg+ulGUngA6c=;
 b=ROkkyufb6NXPIpF5uK/5Ey3ELoaExiNN1mztdnwyIb7BX2/LSU+sJZySnqynuBr0pB
 t52IsISfVruYqu7Ic9YwjCej482sY2tARxhG39xKeujKZVCiXZzStI3PWgnfPQYdqbwZ
 Sp58WP7Sf52+W8xICxtjXuHRzgZN0K11nxVP7iwfUmNQcZFgMI8VHBgyf+RPhjKjBEl1
 HHC1cN1qVo3iIUKeyrO+Zmx24DZGL8uKXMbU8dVX5UyF1jPHtxqycY2gyvmWsEEgevvu
 8cDiosRgxrjICFO2Q8bvA3Ecyva4YdZSR3Trasf6C1lO3tuY/ntPz0i3ELxy38Z4V3Nh
 CxBw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722085; x=1780326885; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sLhVfYVW/YkNoRu/w3UlANT5PgY1bTDbfIJIpLCy6Ps=;
 b=XdxQKn+2gIx03N70VH9DALYa7TSIYXPKV5NPHswoRec6QmKt+sdATDVI1UpHxy9WaV
 ZIqq0DixHynpLN2UGRLX3NrIC12oVUwEzcKaWV3egsuknpvHz781vGgJejnZLVVVj7ap
 HELBaH3X5AbTkquzi5CDHfmVR8DZjZOynXV3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722085; x=1780326885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLhVfYVW/YkNoRu/w3UlANT5PgY1bTDbfIJIpLCy6Ps=;
 b=ltQWFM0o1s51ii8vI0sUK/VJJBqIU1+iPHh8yYTMT9f4/omBydoo/+ZNicFxpC6WuA
 tRwb/HbfA7HhsKT1sqvMd1HoUODICi33xozumpvFuywo3U020W0/YBKQf3pnRvdOkfpU
 FD+MpJSChzueZAphV8/DjfdBlx9gh/P/A2gGwaMs+VJvD0ijD+PFJv3BPHfyMCTE+RWi
 6n+ZQ2s5jUjupnJ05s/XPK/XqqvaXSTAviRz0pP0/OhBKCdLksxl7sbySdF7ybZLHY9Y
 BdivGqlwAKxzgLgt8a/2MiM/jjiu/P4IPe0YpeABdcG7/JvNC1ELpD10dBr801uF6hvb
 SgxQ==
X-Gm-Message-State: AOJu0YzZ5x0M/ZDmKP1XVHzi8c1O+1+m9V6G+ilEePTC+frG8ljqHWo1
 sRUNuVEhhCZ+3T8tvxKnHBn4FeXB7rqhRw5yFsu+ubMon1LzpEqHUmBZXEiq1ixwA15pJpzBGvc
 ywmw6cvvbuM25U8D0Yz7XrLJLEdwAZKHrIJlGQnNA
X-Gm-Gg: Acq92OHz9LyZH8UcG/0LTbF5ybPY2v9vQcnhiNRX5pONskbVxnkqC26B1eSGyjA+v2u
 dI5MO2f1lfwMdm2XTytSZnWlGuMdv1vZB9jUr5+vvGGcdVxAoOIjcCvr3KdZByXh1t3vhU6VydO
 Tl9XJw418WaU2jT2J4VrSlYbneSPQFT1VFA7zsw8QUNiKR18byNcXsdWuKB0x8u3SQhJWfVccUP
 0F9OxPztiK0BC90uXzava/oFFAyinhVaIj9dIXmc760aOF7UUh+abtK8+1V6Hfvz4uAnB2A1VR0
 EVEOAA==
X-Received: by 2002:a17:906:845a:b0:bd4:4593:33dd with SMTP id
 a640c23a62f3a-bdd272cf2aemr571462666b.34.1779722084770; Mon, 25 May 2026
 08:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB28052BDFBF18D3094BC9E598DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB28052BDFBF18D3094BC9E598DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:14:32 -0600
X-Gm-Features: AVHnY4LHzTFTJm5qP-bdtlF_GubESSdO0AM8HLuQQOLj9ZWeyGTeJCXoPNy_ztk
Message-ID: <CAFLszTiR5w95s68JxSvpwuW55r_cw+Hee1H6V4=xO8CBHzDATA@mail.gmail.com>
Subject: Re: [PATCH] drivers: watchdog: Fix dev_read_addr error check
To: fberder@outlook.fr
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Francois,

On 2026-05-21T18:38:24, Francois Berder <fberder@outlook.fr> wrote:
> drivers: watchdog: Fix dev_read_addr error check
>
> dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
> and not 0.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
>
> drivers/watchdog/starfive_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/watchdog/starfive_wdt.c b/drivers/watchdog/starfive_wdt.c
> @@ -291,7 +291,7 @@ static int starfive_wdt_of_to_plat(struct udevice *dev)
>       struct starfive_wdt_priv *wdt = dev_get_priv(dev);
>
>       wdt->base = (void *)dev_read_addr(dev);
> -     if (!wdt->base)
> +     if (wdt->base == (void *)FDT_ADDR_T_NONE)
>               return -ENODEV;

Since wdt->base is a void *, please can you use dev_read_addr_ptr()
here? That returns NULL on error and avoids the cast, matching other
watchdog drivers (see ast2600_wdt, etc.):

    wdt->base = dev_read_addr_ptr(dev);
    if (!wdt->base)
            return -EINVAL;

(since this is a DT fault I think -EINVAL is better)

Regards,
Simon
