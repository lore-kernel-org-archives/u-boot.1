Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDEACE8E65
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 11:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9354A88EE0;
	Thu, 24 Oct 2024 13:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E2buklIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8A988EE0; Thu, 24 Oct 2024 13:30:16 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D534788C7B
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb6110c8faso7276401fa.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729769406; x=1730374206; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QyFFxTYwv1jJXGXk9sHZfM8RGUMlCig7USSVDvqZ0z8=;
 b=E2buklIqGY0Gxrxeuvn2TItAkdUpmx5WkMFXg4U0zoC2YnkUTTpH5NnIqKkzOkAchb
 75SaMOMqPfxQ+gPssvDBhZGa8GXpUbNtvH5DJu/p5cHPA3D9x9OR9gEsKUE2rTEZL6HE
 SRa9RlRIDp/5Im4K4hQUGXbsRuJH/vdpAeQDIX5nHE+qJ3gVBEeVZclTQ8SpjHLGa73m
 rg2S9vmh/s2QifbJtpx+lFLRQnri6fejB4qvWT+BMXX91nebsIYbybFoVy5K7eZnGeqU
 7AcIoijFQ+r6nyUxlUF7MvYZ/TS/JvNxK0hwKfPGQzXeKBLjljbgoZC8yW9WOHWdnSQn
 fCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729769406; x=1730374206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QyFFxTYwv1jJXGXk9sHZfM8RGUMlCig7USSVDvqZ0z8=;
 b=ni0dczbKlHQ/VkocJoX4jLWfQeaFvfoEowbP6ZhaxUFOZHwORUs+I0RH6Hgkh9J+hI
 gZJXM6deEvLGG+RpVqSeybtxMGZ6l7BLPDdmOQBvb9p4IgzXLYEwbzSh3YBVpGdtbsRh
 cHV+kYzYRcY1sFZJePIf9yUNT6d42LwZvLRFB4nkmrGBQZPdCfLWZZ+dZQnSHr6gMhxs
 CfzKSnSLpB3GrlR1wsVMseNdwHlqPm/zkVvAoCto7vr9HMNlXP6dTs490Vm1+QErYdfe
 Gpe+3T0WmE//5SC6mggVbqUfrxntkHHp7uyafcnpC2vREzEOZHqRAdWNsyhkBzhHeTwn
 jY2g==
X-Gm-Message-State: AOJu0Yw/8cthei0/qVoyqKIGNUxwFTlR2ogH5frDN+Ceykug3sC6ZVzb
 GIVCfnvVc9BVnc+M2cchYI3kt/xREsHjc6i3UvGlojalGLYp2rIe/VKanOUHrSPFZSF6F8KljMO
 QywegQhtxkjD/qF7LZK835LBUuVk=
X-Google-Smtp-Source: AGHT+IGRojJN57X2WsQHr0WPupYPun/8BXsPPJIiyH3nKNzBIt+/jd+A4SFBQFiwQEP5kE3NQR7J1kANq4qne8Ofzls=
X-Received: by 2002:a2e:701:0:b0:2fb:607b:4cde with SMTP id
 38308e7fff4ca-2fca8277985mr7971911fa.39.1729769405757; Thu, 24 Oct 2024
 04:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241023131012.2445564-1-martin.stolpe@gmail.com>
 <20241023131012.2445564-2-martin.stolpe@gmail.com>
In-Reply-To: <20241023131012.2445564-2-martin.stolpe@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 24 Oct 2024 12:29:53 +0100
Message-ID: <CALeDE9N0_ntH1cU5SKQmN9SQEW6uPRQnKHRd90tp7N+H0HO9Ww@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] rpi: Only add frame buffer node if
 CONFIG_FDT_SIMPLEFB is set
To: Martin Stolpe <martinstolpe@gmail.com>
Cc: u-boot@lists.denx.de, Martin Stolpe <martin.stolpe@gmail.com>, 
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
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

Hi Martin,

> The functions fdt_simplefb_add_node and fdt_simplefb_enable_and_mem_rsv
> are only available if CONFIG_FDT_SIMPLEFB is enabled.

Is this a follow up on the patch [1] you sent a month ago? If so it's
not really a v1, and you should add a chnagelog as to what's changed
as well as cc: the people that provided feedback.

[1] https://lists.denx.de/pipermail/u-boot/2024-September/565514.html

> Signed-off-by: Martin Stolpe <martin.stolpe@gmail.com>
> ---
>
>  board/raspberrypi/rpi/rpi.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index ab5ea85cf9..47db441696 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -569,11 +569,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>
>         update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
>
> -       node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
> -       if (node < 0)
> -               fdt_simplefb_add_node(blob);
> -       else
> -               fdt_simplefb_enable_and_mem_rsv(blob);
> +       if (CONFIG_IS_ENABLED(FDT_SIMPLEFB)) {
> +               node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
> +               if (node < 0)
> +                       fdt_simplefb_add_node(blob);
> +               else
> +                       fdt_simplefb_enable_and_mem_rsv(blob);
> +       }
>
>  #ifdef CONFIG_EFI_LOADER
>         /* Reserve the spin table */
> --
> 2.43.0
>
