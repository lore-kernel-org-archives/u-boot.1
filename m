Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88785D5AE79
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 122618922E;
	Thu,  7 Nov 2024 10:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yn+nG6wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04EA989032; Thu,  7 Nov 2024 10:53:13 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C237189235
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e30db524c2so621540a91.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973189; x=1731577989; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=87R6eCLun81wOrefjQMgutTQgRCFE8VyHLOM2ExvcZs=;
 b=yn+nG6wi8BYoZMLleA+AHa/L4hfEEUpdt5XYjzLCY6yWeA5EeaF2Vfi6XOut2QPC0o
 aoL+b6US4HNHaX9+IAYrZDpNIKWj1AlgWcZ8ey63xD+M0TZcRLMDLNdBM+/8wghVxPl/
 p9cgzs5it0db6QZpLxwMWrYEIlO4CbhQnk8voFAn1LMf353vaXvYsMfV3WlkEUdan/3b
 b2UHEaUvhw5Tm4FB9kycO5ZS5vnnl3m6NMXT2+50TD+479tQ7/7aBlvk9atGbNjg6KSa
 Tn3qdV56kDj1Z2r7PiOYu6My3ZI2yQzqyCrSwb0KUiFhU1+nDWixGgSfRfrPxUGUcwTe
 g9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973189; x=1731577989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=87R6eCLun81wOrefjQMgutTQgRCFE8VyHLOM2ExvcZs=;
 b=D71gxRAwbTUyab656kCZBp7HLwmSYLW4NG/ZgJmXqunLeeGvzfyjtDMlHbUUMZkPW2
 EjIifr7T2aM9RCfqHcYZsT6q4ZMjkm8gpwKuY1BjXvdivpJiPeOPWghMXnIC9/eBiI/x
 zmvJnNRn+95xIRSVBxeyUgx9VjEbBi+zRBFsmiRXdNohZZKrFKnKGA+mYm8KwYt/hPbF
 vCwiM7OqwvL0vCybtWmfTnS5zwkWxh6qIhaVg6nGWrnh+EL08NpI9Py+1exugzhsS1Z7
 cJBDBXadi1Y05Iu4rPdLarG+0I+AvWW7x6tCc63erihh1Ow9a8nG91oT5lEM9GQOvGnV
 2csA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrBZQrfyVYEm+9pwAaFV3qEzUbhqw7LBkbp94iyurjRdnuYIUpX26FifWl8JehsxtenPyIwX8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf7yeuxHc69yDQf858y6X+0L9tmKU6n2OEYXFXVSuBHglx8dhv
 0YfqyolFWOWft7PBmDcWJLr0vkKq4WT6YpOuMGBb8awUZ8EMkFNuZ0rT9GtM5MXNwMyUdUtA0/4
 v9U4jDStTfYcGogtHPXmzroUzwGYiIxy8ZCu0dw==
X-Google-Smtp-Source: AGHT+IGLxjogupitC/eobZ+DUSVbU7qsVk+x9tLA/HmPGsrp3MMS0lY+PhrDMHOvn1eAfGOqR/L9DoAy/nJ8DoVrcJE=
X-Received: by 2002:a17:90b:3c49:b0:2d8:8430:8a91 with SMTP id
 98e67ed59e1d1-2e94c2b3825mr33871932a91.10.1730973189200; Thu, 07 Nov 2024
 01:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
 <20241103071200.82853-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103071200.82853-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Nov 2024 09:52:32 +0000
Message-ID: <CAC_iWjLAcT0DjGs1pm3ZD6YtLAZtWATe1901KDb5KuSk-H=3Sw@mail.gmail.com>
Subject: Re: [PATCH 2/3] lib: uuid: fix uuid_str_to_le_bin() on 32-bit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

Thanks Heinrich

On Sun, 3 Nov 2024 at 07:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
> Use function hextoull() instead.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/uuid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index c6a27b7d044..19f33dd1477 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -35,6 +35,7 @@
>  #ifdef USE_HOSTCC
>  /* polyfill hextoul to avoid pulling in strto.c */
>  #define hextoul(cp, endp) strtoul(cp, endp, 16)
> +#define hextoull(cp, endp) strtoull(cp, endp, 16)
>  #endif
>
>  int uuid_str_valid(const char *uuid)
> @@ -339,7 +340,7 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
>         tmp16 = cpu_to_le16(hextoul(uuid_str + 19, NULL));
>         memcpy(uuid_bin + 8, &tmp16, 2);
>
> -       tmp64 = cpu_to_le64(hextoul(uuid_str + 24, NULL));
> +       tmp64 = cpu_to_le64(hextoull(uuid_str + 24, NULL));
>         memcpy(uuid_bin + 10, &tmp64, 6);
>
>         return 0;
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
