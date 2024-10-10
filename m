Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FDFCFC5F4
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 18:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD2489155;
	Thu, 10 Oct 2024 20:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="emARdUEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3CCD891D8; Thu, 10 Oct 2024 20:50:25 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5AF890FD
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 20:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb3d2ce75eso21147336d6.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728586218; x=1729191018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y9IQYvkSdVBNfZdXhLg5UUuPVnodlYdExIe0fLhzpXA=;
 b=emARdUEta7lEATkyaTs8pJdfyHmF0P/AJ/OMFZBuSXXG7xQ61CDbm39WucVaH4IFzl
 uujGGuHB7ey+LKqr46KBKhptWOOf2nZdjcOfPbySq9YiL7RMnuRz/wGiZLZz2/9mrh2J
 xQVihvSL2sbyl2FT9xKTc7ng0S/GuplEGr6aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728586218; x=1729191018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y9IQYvkSdVBNfZdXhLg5UUuPVnodlYdExIe0fLhzpXA=;
 b=tfn5ldajbLIYJjDksj8bw4JsdXQsr96SwXad2E/zmq/2Iy07a1nR5kojpAWC7G+Hw6
 nC4jDaEHIH4bX1nFL3xxKUziHHgNa3gtfWtoH1Q3i2WodeZXsdEiYQx9/+YgLP6dOR1n
 Nf+wVuPUYfIPLourPB6IYVg9UEiC0kU/TFmBaaBaBzuey7yIFz4uZbRaD82tGYS30Qbx
 oH36FSeLylT8q8+sWqnLDhOaldY1AGupVhhTUltLn4VxE7WiTBc67dyBdwWW9FJO0xq2
 bJcZXOpDQBZdsvpybyR0JAWHhrb9DS7z0eRUjrMBSfSqeQjHw4sG5tGDgigrEOS8LR0h
 T2+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/NNCFB4yYWem3sPBOb8vF2aLHZ7wYV+lDjNsqs+tInNuk2V6SBiviGYgi1gL8ijsiQRmwo6s=@lists.denx.de
X-Gm-Message-State: AOJu0YxcGE7RhWVFGrrKBPXUaWYEmrdeFeh8tRzsJrs0UZbeJprx7b2A
 mFWVE2kEdqjCzvIdz7MWX3FeCTiGMKrUpTBASosLNh8Aj5CumUNmDwyJtcQsnDTvI6k+KvC0HWq
 EMjFIP5s7Lw4qgA8tpu9FnwpRRLeu0PfTHMog
X-Google-Smtp-Source: AGHT+IHcf54SyMRnv181wjc1HXGyqdSAIN2opU2IoQlNZbp/8prh3Ad9t+Ebp+XqY1JSMyDtKktDa8qk10AiECiLXkc=
X-Received: by 2002:ad4:4501:0:b0:6cb:e6f4:dc47 with SMTP id
 6a1803df08f44-6cbe6f4e02cmr45721216d6.16.1728586218081; Thu, 10 Oct 2024
 11:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241010070909.288313-1-n-francis@ti.com>
In-Reply-To: <20241010070909.288313-1-n-francis@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Oct 2024 12:50:07 -0600
Message-ID: <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
Subject: Re: [PATCH] boardf: Modify DRAM message
To: Neha Malcom Francis <n-francis@ti.com>
Cc: trini@konsulko.com, devarsht@ti.com, jonas@kwiboo.se, richard@nod.at, 
 raymond.mao@linaro.org, u-kumar1@ti.com, u-boot@lists.denx.de
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

Hi Neha,

On Thu, 10 Oct 2024 at 01:09, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
> modify the message to show exactly what is meant:
>
> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 154675d0e40..b7add8f7d3d 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -254,7 +254,7 @@ static int show_dram_config(void)
>
>         print_size(gd->ram_size, "");
>         if (!sizes_near(gd->ram_size, size)) {
> -               printf(" (effective ");
> +               printf(" (available for U-Boot out of total ");
>                 print_size(size, ")");
>         }
>         board_add_ram_info(0);
> --
> 2.34.1
>

I've forgotten why the first number can be so much lower than the
second. What is causing that?

This is quite a long string...could we say "(total 32 GiB)" ? Then
perhaps add something to doc/ to talk about the banner that U-Boot
prints?

Regards,
Simon
