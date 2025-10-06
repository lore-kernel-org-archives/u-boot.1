Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08948CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 20:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFE483DF0;
	Mon,  6 Oct 2025 22:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H3+6Q6hy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283EE83C46; Mon,  6 Oct 2025 22:40:41 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E80A83C46
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 22:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b457d93c155so957157666b.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759783238; x=1760388038; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LC+T9zwK0xcMrkMPDD519oYgjv8dua1n2jW2NrH337o=;
 b=H3+6Q6hySHPITSZ5WbBJ6hR/FnV309eG+Fvc5/1HxbOJszCDnjh2WSlG0nA5/rOwvW
 nL10U3zyhQSfUrXG/SGYZfjeYxTfomyFarx/qVvz2kVn7+kA08XT4ZdB+DJTyx4vSk+K
 UINs+ol83Q6IjlDFdDHCJbZBewT+hXmcOsmPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759783238; x=1760388038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LC+T9zwK0xcMrkMPDD519oYgjv8dua1n2jW2NrH337o=;
 b=iPtdT5iyrgE8jZNP1zOXqlAEjUsH5ahuHBsRDm3PxOmRp57VeFJrY1ZMeGUYVR2dX2
 /2OYEV+6FRYgbuT7ZSaoDBKVUrpSICSiiSz2Ek31Cy/98ddNVt0/0i8KO/RVkUvcIoSx
 eIRBGs6RArwi4hH4MTd1Z1m4NOcVpVpr8rCBktDn+uggVGh8qSTXwy02WS4OudkZrLzk
 d7aXOTHHVOOP7/ZW46JZFap8ezS4dU7d/6l/+K+8dhDDoYmHXMJbu+o+Oxfl3Fbdz9CW
 HnvVro0nBFBppD4bx75Tm+GfxTRdmxoui4MHwA4uqj+ELnjwbve4FjOZZW9nANREO+CU
 A3MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXbBF7wKi8CxMWR5CAxf9YpWXxyyEo2v3J19DcTANsTKH/zBLjxsbvzS+ir0Hy1ukv6qmS/Ck=@lists.denx.de
X-Gm-Message-State: AOJu0YzWp8XgAahZ25WEHtUosbgYw2fq0MHE9THdg66FnlHOOOFKA7Hg
 sg+V+HyHusmvP/HhCZ5YEroJoyl4AeHRWCZOwtzqN5YIGZPvFP7eusPe/lUNyYTeOq3DZx3s7Lp
 RaLk0RfOIP4BuL//adVCDENWCSc0sxVPpnOA09NYtZDpevFQZiUAG5w==
X-Gm-Gg: ASbGnct8ARp0X4U9Eb2xf4t9PHEOmdN7Z6ub3ZDDlRQbqqdXfCkUJj39lGdPChqoELs
 Nkg43+uckDn973QOEL5n3lbP6LO5Gg+1Pa03V/TrnnoI5QRdLHKwezzs0dHEFpUJoGxquwFN/z0
 N+bQII5SLZbkUdDv5N+2OOu2JSz7JaDhEJgYcee9tFA35UDW4OVCdrk6O6Yz1H6Xx1gIivCU1hf
 zN2ZGpV1qaPvTopIz7MbuJLu7NNSCV06KLEkbvE9Dk=
X-Google-Smtp-Source: AGHT+IFCk7xYlqT2S1sP0L1bOJQh/fZG/6bG7GOwVqP0GOhw9Ankm4J+pDD23x/EMc/Fjblsn41mutUA0q9Ydirp5G4=
X-Received: by 2002:a17:906:d54c:b0:b42:1324:7988 with SMTP id
 a640c23a62f3a-b49c146e7bcmr1905122166b.12.1759783238079; Mon, 06 Oct 2025
 13:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251003222714.4921-1-semen.protsenko@linaro.org>
In-Reply-To: <20251003222714.4921-1-semen.protsenko@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 14:40:25 -0600
X-Gm-Features: AS18NWAMgThxWQ7AlPh9Wlatghw-fHg0qJmBzgH5Q39GjYfhHlQbTUm_JOOGD9s
Message-ID: <CAFLszTiic5c_ZwX4hWJEAx=VGXxR8KOsNw2AQwzh92G-PRncGA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Fix bootflow info for efi_mgr
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Fri, 3 Oct 2025 at 16:27, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> A "Synchronous Abort" CPU exception happens on an attempt to run the
> "bootflow info" command for a global boot method (e.g. efi_mgr):
>
>     => bootflow select 0
>     => bootflow info
>
>     "Synchronous Abort" handler, esr 0x96000006, far 0x8
>
> It happens because do_bootflow_info() tries to dereference bflow->dev,
> which is NULL in case of efi_mgr. Add the corresponding check to prevent
> this NULL pointer dereference and make "bootflow info" command work
> properly for global boot methods.
>
> Fixes: 2d653f686b6d ("bootstd: Add a bootflow command")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  cmd/bootflow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> index 551dffbb8b89..081f64e12ce9 100644
> --- a/cmd/bootflow.c
> +++ b/cmd/bootflow.c
> @@ -404,7 +404,7 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
>         }
>
>         printf("Name:      %s\n", bflow->name);
> -       printf("Device:    %s\n", bflow->dev->name);
> +       printf("Device:    %s\n", bflow->dev ? bflow->dev->name : "(none)");
>         printf("Block dev: %s\n", bflow->blk ? bflow->blk->name : "(none)");
>         printf("Method:    %s\n", bflow->method->name);
>         printf("State:     %s\n", bootflow_state_get_name(bflow->state));
>
> base-commit: d33b21b7e261691e8d6613a24cc9b0ececba3b01
> --
> 2.39.5
>

Reviewed-by: Simon Glass <sjg@chromium.org>

If you like, you could an a test for this to bootflow_cmd_info()

Regards,
Simon
