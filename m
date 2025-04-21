Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED579C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 10:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 247B181B4B;
	Mon, 21 Apr 2025 12:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OuVDuSvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17FE581DE3; Mon, 21 Apr 2025 12:34:28 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35FF819D2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 12:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so5961440a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745231664; x=1745836464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ngq9/i4kbUsYRMSggng2b0peGbIgHJkMLz1sA82ubc=;
 b=OuVDuSvnOo71cPSUt524OkI1F39YO65Wa36dAO764gzxdXMLa/maI7YNvjEJ2MwcWD
 mKhBepnTRAOUqW8h+bp2oVR/h6dkFluHGpVtfovdviv3gDlUfWXNF7HDkb+mzZ9iyOk3
 QQqToW2NLcy+AEoWBn2+PRU2z4gQ8mzQP3NDkUcY2ISzI1v8xF43GXkLIsgcI6htmbQs
 QamQaS4Wvnov06tkSeTPieI5VaoPzBEsRfBQFbGt4r6D93kEavS40UquAYZFCFRExp9/
 g+gEazq2Abaiw3ZXP3bFk/IdZ54shOyBcOYftlsVj7HDdXorYvvApP4XhusAEV0WOyVI
 nomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745231664; x=1745836464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Ngq9/i4kbUsYRMSggng2b0peGbIgHJkMLz1sA82ubc=;
 b=FCavfLAuv4/Ryey71AQkomQGChjkARR9S0OMm9mz/x8CFn6z7KqOKIwVBEnvDotO7L
 4TTIFhaTw8LRXszpts6HtkQ9nTPLTi2BOXAL8tD8+tpYeh3SSs8DPfDB/LCrNjYR0cZP
 5w1hOQOlPZp6xvT04WPEHe3u87HFAU7iu6LMmFE0yJPcTnbegUVsa6FY+AkT1QZCZA+f
 YW0pUC/nQmeO5j/9pwwWZtPb0pQOEKSGXrsMIqzepq72vSyG16o8iBOmNnnNjHAYtvtB
 Q/eTpYywP+PnW0EUROP72G+8jX88iLB82slIHhm+1o5nOHCW+bz3b7ZPCAyliZUxdTJD
 e6Ew==
X-Gm-Message-State: AOJu0Yzf8GwVPd+SilM9GQGl9PJpNk1q5x21jdMv0XLZ5taXdD3wcvxz
 yy9wMNY93zlFHd2clvKoDbuFwaBhDF+29e7iMJzyQjI3VEaMFJfuLWEeJ8gBi+FkOEnfdLAAHAZ
 TcFZ3SAFJWhavzaSrF8JegOZ5IXI=
X-Gm-Gg: ASbGncv7ZvUUSHdLX5zTcQwRH39EzFRt+7xEQ54FEEFqD8q4YzAWyP25Am68NhjXrDK
 PqFmzPzh0yU5k70rFQ9KQQ6n+7Elr73mNkByEUW0fRFd8ksPB31KvGCuEnk4/GdqU20i9yVl6g9
 6PYkspO3oKq11WPHtS75aqBI7xBM42ijA7tMBJWt/Y0mlFW0PioUlyQjdLGuQC
X-Google-Smtp-Source: AGHT+IFZrCdAK1KndEwC2Unladh9n/Pj6A54unoIydR5s2t+QIEOo6zbaA9vxyxeGBMTlvFAXJQZSiNnxZThM1QSNE4=
X-Received: by 2002:a05:6402:2808:b0:5e7:c773:ae35 with SMTP id
 4fb4d7f45d1cf-5f628504ecdmr8561964a12.5.1745231664101; Mon, 21 Apr 2025
 03:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-6-sjg@chromium.org>
In-Reply-To: <20241220003447.2913443-6-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Apr 2025 11:34:13 +0100
X-Gm-Features: ATxdqUFmIb9ZmwaGn4X2wLzCt7xs2F4aaz3RlZAVIFMLPPVcbVLKRF3peYT8uMQ
Message-ID: <CALeDE9PnQSp3knoo5Hc4_2UUWhF0sJ=bHeL2zi2K5TReQqXLPA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] rpi: Use the U-Boot control FDT for fdt_addr
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

Hi Simon,

With the other changes in the rpi pull this no longer applies.

On Fri, 20 Dec 2024 at 00:35, Simon Glass <sjg@chromium.org> wrote:
>
> The fdt_addr variable is used in extlinux as a fallback devicetree if
> none is provided by the boot command. Otherwise the only use in U-Boot
> seems to me efi_install_fdt() when the internal FDT is required.
>
> The existing mechanism uses the devicetree provided to U-Boot, but in
> its original, unrelocated position. In my testing on an rpi_4, this ends
> up at 2b35ef00 which is not a convenient place in memory, if the ramdisk
> is large.
>
> U-Boot already deals with this sort of problem by relocating the FDT
> to a safe address.

I'm not sure the context of the two paragraphs, they seem to conflict
with each other.

> So use the control-FDT address instead.

The RPi is interest as we have different DTs, the one the firmware
provides, which is useful as it deals with things like overlays, the
U-Boot one we've typically not used or one loaded from disk which is
generally the upstream Linux kernel one, how does this change address
that? I have concerns this will change the logic overall. Does it?

> Remove the existing comment, which is confusing, since the FDT is not
> actually passed unmodified to the kernel: U-Boot adds various things
> using its FDT-fixup mechanism.
>
> Note that board_get_usable_ram_top() reduces the RAM top for boards with
> less RAM. This behaviour is left unchanged as there is no other
> mechanism for U-Boot to handle this.

Could you answer my query above and rebase?

Thanks,
Peter

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - Expand the comment on set_fdt_addr()
> - Update the commit message to talk in terms of my testing
>
> Changes in v2:
> - Drop patch to allow expanding the devicetree during relocation
>
>  board/raspberrypi/rpi/rpi.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index c46fe4b2350..f74006e0968 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -3,6 +3,8 @@
>   * (C) Copyright 2012-2016 Stephen Warren
>   */
>
> +#define LOG_CATEGORY   LOGC_BOARD
> +
>  #include <config.h>
>  #include <dm.h>
>  #include <env.h>
> @@ -326,18 +328,13 @@ static void set_fdtfile(void)
>  }
>
>  /*
> - * If the firmware provided a valid FDT at boot time, let's expose it in
> - * ${fdt_addr} so it may be passed unmodified to the kernel.
> + * Allow U-Boot to use its control FDT with extlinux if one is not provided.
> + * This will then go through the usual fixups that U-Boot does, before being
> + * handed off to Linux
>   */
>  static void set_fdt_addr(void)
>  {
> -       if (env_get("fdt_addr"))
> -               return;
> -
> -       if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC)
> -               return;
> -
> -       env_set_hex("fdt_addr", fw_dtb_pointer);
> +       env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
>  }
>
>  /*
> @@ -571,7 +568,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  {
>         int node;
>
> -       update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> +       if (blob == gd->fdt_blob)
> +               log_debug("Same FDT: nothing to do\n");
> +       else
> +               update_fdt_from_fw(blob, (void *)gd->fdt_blob);
>
>         node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
>         if (node < 0)
> --
> 2.34.1
>
