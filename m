Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92169CE9D78
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D2883FBC;
	Tue,  6 Jan 2026 17:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hS8qHiTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D12483F5D; Tue,  6 Jan 2026 17:23:26 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EEFB83FBC
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34c565b888dso1259557a91.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767716603; x=1768321403; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3allArADSwsH5VWBhr3m52RgmRrmK6Gm5lYOT/Y9+rc=;
 b=hS8qHiTtAAYseoToOyBu/ZkJ8f+kAnGcMZ/r8KVY9BsjKHeWe8Fk67/AYlbFsLhl5N
 J8Hz35mYsZNMptt2N3Fp7G4TiyYVGQ/Lx4O38hMasBUJoEobLrTU04YsI9xCXPnb5jce
 zfa4s4lf+4boWTVhlK+Kpr234y3kyIr1wsR2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716603; x=1768321403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3allArADSwsH5VWBhr3m52RgmRrmK6Gm5lYOT/Y9+rc=;
 b=EGrAfovZK5tF8K3THtKQ7voXpwzUwGUNhpq5rs0NxTbfl84V4EEHqVU0Qe0Yva41eu
 yT/l9vqSO5yosSVs7Wy7U8CJZOyHsqhdwP7kG4nEUJuSbX8d+BNcYl87LMCcBl4un6JG
 vVhqTXDFf/2+m9ikTltoRW6jcBINqZEIPLQfi1UzI+/5KDHgn2YhH1On09Y/UBRV61pS
 wGATEeeDQdeWG7ceLlksHxUmufYWA05gWATvCLYZQQvt8yN/Btpgh5eAM00INFZkzDk0
 K/cnIpr88ITu6ggMrR4Ov9+w4qRI8KFCJO5QMhR7vEu8O58sWHPDe7WWzy7e1MYDitI0
 EaEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlTbZ6TcOXD7lwie0IVxwCXZm2XkSOxWMtS+GHPxQHmPL3jbxp8LQfhTKrdLmywApzeCcNu5k=@lists.denx.de
X-Gm-Message-State: AOJu0YxgdPkDhfu8dEoiAWISDDXgK8P4X4GXIWNLOYoMbY/MvqfzkZIy
 qcFTteUItXXh2BsnxfFmgDVjqHTnk+mj2orF21Km/fb+7ba0iC/Ok7/+jJRPkRobTU9zLvooqL0
 rwc8oPWF/BAxMN49lx9J0zPpmEoedppt9DgOFTEZr
X-Gm-Gg: AY/fxX7O3OTpQXMYdTpSWS0+DYCVMf4fvlXRqlm6G3whuU6BrQ6pAavhP62E+Hd9svK
 DzY1/tAvg6u+SN+iGKW8oE+Z/m4Y5JxKmKAH9JywDoKV/I//a0ljB+UMMSpGIUAntFaTZxvbjNj
 o9sdxmBd31HXzbwcm7HSm2VpbuF8ycl0fQlakn5SM0u6SalcD620yD0hujiWA0U1g0Rj0G5nqv0
 yUPxx5GACfFmQHIDjGYGaa+Hf7q6NCHxffg00x+akh32eSUq+r6Cr9JtqxySGCKPFKJ0w==
X-Google-Smtp-Source: AGHT+IFLmyRqOhaK77zfpy35WEBysZWyyuc9udbwd3QwvjXgYK2wn9Zr7PWTmwHTXg89+hKsDmgVA92s/OPe9HlMkGM=
X-Received: by 2002:a17:90b:524d:b0:34c:a35d:de19 with SMTP id
 98e67ed59e1d1-34f5f33d13emr2514699a91.33.1767716602836; Tue, 06 Jan 2026
 08:23:22 -0800 (PST)
MIME-Version: 1.0
References: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
 <20260101-clk-reparent-v2-2-3eb42b78c7f1@outlook.com>
In-Reply-To: <20260101-clk-reparent-v2-2-3eb42b78c7f1@outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Jan 2026 09:22:23 -0700
X-Gm-Features: AQt7F2p6a2l7Nwa8xZeuAfN8U67C1p9kLnifTLhaKI-MfmgfO2MCmqdrQCTUs3o
Message-ID: <CAFLszTjay9O3E-R2v31oZ2ao4h_N7V-AKdNZAKT9rORd06Bk1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: add uclass id check to clk_get_parent()
To: forbidden405@outlook.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Wed, 31 Dec 2025 at 12:52, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Check the uclass id in clk_get_parent() before casting dev->priv to
> struct clk *.  This sanity check can be also found in some other places
> and should be enforced.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/clk/clk-uclass.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>


> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 2167cd5ad0fe..bd18de972bb9 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -502,6 +502,10 @@ struct clk *clk_get_parent(struct clk *clk)
>         pdev = dev_get_parent(clk->dev);
>         if (!pdev)
>                 return ERR_PTR(-ENODEV);
> +
> +       if (device_get_uclass_id(pdev) != UCLASS_CLK)
> +               return ERR_PTR(-ENODEV);
> +
>         pclk = dev_get_clk_ptr(pdev);
>         if (!pclk)
>                 return ERR_PTR(-ENODEV);
>
> --
> 2.43.0
>
>
