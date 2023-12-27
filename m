Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2511FC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDCA878C1;
	Wed, 27 Dec 2023 09:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y96eVJQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC5C187951; Wed, 27 Dec 2023 09:41:12 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBED1877CD
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ccc41e1105so17983591fa.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703666470; x=1704271270; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VhSvujTFTTWH4AYF2OTwq6LOzkiaQpVedf6q418XqSA=;
 b=Y96eVJQHtd01m6IfJ/GvKCsRZiOg30yzUqeZLtpzfMyZw0FBDR2D9VUHQ8Qzwh/hP8
 WxsvFiaPoq2ykFowhaMaRUTTGjgiXq68Axf5NZftf1p2SedCULEJeeWuGPxdvZ1pmEOQ
 HptTUbwqZx/rvFnPGkwZbpanCKy7Gdk9TGLiB7KS/wLuL/UjoarEBeroNeJb0I1eDDT9
 xTm2IsAApSkhYW/Uwq079soEfUg2ZOoA2B8fIUAMTIulovGjeWtanhZoYRpc3Oig4NsP
 NoUkS4fNtxGormcDNeaj91S27KkBrH2G26k9/1bIEXthViPw8hN4dfFOsl6uU5gpJFkF
 Fb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703666470; x=1704271270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VhSvujTFTTWH4AYF2OTwq6LOzkiaQpVedf6q418XqSA=;
 b=X5jKUE5MIrWWmvJ74rDNP3/SzVdzD23Y0cOe/MtWg2COtKRtofp4snqlz4iklfU3KW
 5S0+FRpMjvqoNecqlSkkmS/ejHI65tnOH7KZBdHl5rTjsrmDX6+Cdwj8sBEVn/fw5zOZ
 0C28WK/TLkgPxuI5+netVkRBV3B66aZjaDpCNwln+ritJj3Qyu7LNgKmpz5Jej6JcW21
 4IgS/hS46Cd0tHg1+W/maX84Wcj5ulK3oYrXMHvGZek5Wqm5ZdOjkqGdx0mPrTp11a7Q
 SxTPa4h6oVn+EX886lpTPnWQx8wUQwCwKV8QW6eFiRTi2XkZcnjI6j6l8KFXySky4sXT
 o0Kg==
X-Gm-Message-State: AOJu0Yx5GLCS57HOcvr36ExbEuvytiUu7DQF1KAOaad17t2FmkqFuJc5
 WzMIPSlt5ymkUa9gf59OU/ihah5g0cNbpcJgpmwl+JN9NkTG6Q==
X-Google-Smtp-Source: AGHT+IGoyxWfzoEAmqhoxGFl52BC71asUm2Vu09EuIuGqML5ciEXVZOY4WCZi1Y6tCvZl6WewUWzIUAwbKc3cYDLOJ8=
X-Received: by 2002:a05:6512:246:b0:50e:18dd:60a6 with SMTP id
 b6-20020a056512024600b0050e18dd60a6mr2924602lfo.37.1703666470074; Wed, 27 Dec
 2023 00:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20231222181250.49764-1-xypron.glpk@gmx.de>
In-Reply-To: <20231222181250.49764-1-xypron.glpk@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 10:40:33 +0200
Message-ID: <CAC_iWjJ+zTtpAoro1od_jMxtP2R=2ejc6cboE7sd8V+QZ9K7FA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: smbios: verify_checksum() is duplicate
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Christian Gmeiner <christian.gmeiner@gmail.com>
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

Hi Heinrich,

On Fri, 22 Dec 2023 at 20:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> The function verify_checksum() duplicates what table_compute_checksum()
> does. Replace it.
>
> Fixes: 415eab0655a8 ("smbios: add parsing API")

If we could drop this during the merge or send a v2 it would be great.

> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  lib/smbios-parser.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
> index f4de350e6e..a29a06398d 100644
> --- a/lib/smbios-parser.c
> +++ b/lib/smbios-parser.c
> @@ -5,23 +5,9 @@
>
>  #define LOG_CATEGORY   LOGC_BOOT
>
> +#include <tables_csum.h>
>  #include <smbios.h>
>
> -static inline int verify_checksum(const struct smbios_entry *e)
> -{
> -       /*
> -        * Checksums for SMBIOS tables are calculated to have a value, so that
> -        * the sum over all bytes yields zero (using unsigned 8 bit arithmetic).
> -        */
> -       u8 *byte = (u8 *)e;
> -       u8 sum = 0;
> -
> -       for (int i = 0; i < e->length; i++)
> -               sum += byte[i];
> -
> -       return sum;
> -}
> -
>  const struct smbios_entry *smbios_entry(u64 address, u32 size)
>  {
>         const struct smbios_entry *entry = (struct smbios_entry *)(uintptr_t)address;
> @@ -32,7 +18,7 @@ const struct smbios_entry *smbios_entry(u64 address, u32 size)
>         if (memcmp(entry->anchor, "_SM_", 4))
>                 return NULL;
>
> -       if (verify_checksum(entry))
> +       if (table_compute_checksum(entry, entry->length))
>                 return NULL;
>
>         return entry;
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
