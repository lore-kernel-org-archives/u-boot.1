Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A81E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 245F880331;
	Wed, 11 Dec 2024 17:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A/vyYSxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C1DE8036B; Wed, 11 Dec 2024 17:36:32 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112A8800CF
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d437235769so1346401a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733934989; x=1734539789; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ASMGgZ1K4HI9Zej5iTQkkyqgzJ3en9uERPSV3tHC3HA=;
 b=A/vyYSxW/6KooU870q9rYYfRZbws++dzc1O1vG7cbFt1IwFCPvFCtwe+tGDxshrAQL
 5ykE2CJIz5zFfIpRsYoCkxDJ8nuaCFagDpEG32mX2oRUX1B0MoTLVh+g/8V0BQnMS16s
 4Um4loDiWBOUCuLqjNrGkeg5deknGz6dQAUd08RXrxlAuudbItIVj7iq+MZ3D0nXKcmq
 Y8nUFk+dJIzi3SsN2MWftwipflkjUPuhmxepVEKniJZq2UMoLYCGn16xaQ8UybdYxM0v
 lmYQ0SnBN27JlraQ2AdDclcOXinkSXx/1yOjFATfoYC6oMqrqXSFW8GLZ66e1rohtCrJ
 NCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934989; x=1734539789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ASMGgZ1K4HI9Zej5iTQkkyqgzJ3en9uERPSV3tHC3HA=;
 b=cLSu5BCDL8/NtSPSTG/KPUozVvgJlIRA6OpVO+W53MKJPqH+ek8iBL5q27oWtiP6+5
 kYB7iuaQAWtTWtuj4oMiP6kDejcU7o6sUu8gJUDpHvrxNftGuOSulan9Gb5UIV56jWzY
 LB/vZ+1enJKS0ATCBYNuCShPJXbW+OmERI0cBpWeade1vhmvIb5KeoPj1q/euyWl0wQ2
 inmtfyX6FfjaG4VtzfeZiXXg6TxCyFuHTrE9FtOCTMLsMN5Q5x8jvvJ/xFeKtCjDg9Dx
 KLRTX0COa7Jlwkhit5e4dc+CIxQo77T3vS5+my2wzyts0C40GxTo5d57cqPbES1YLO7x
 CN3Q==
X-Gm-Message-State: AOJu0YzWrT0kKLkE50eTaDIUwL393XEit/Bb5//OEN4S+mVOtlnYV3XI
 ztzvO/IsOk9H6HPH+TP7D2x2ABQoatmAiVVP+1P8ZaECGCJlzAyUdzXOnz7Y+FIrsR2ymAMmW3S
 kQaj7SuXHSybflF/6Wy3d4VWBzXPL4x4Z
X-Gm-Gg: ASbGncud+YAjs1S1CEqchTYxwl640Vd9XrAD1dQPFg8PEQFVvybTKtiHMNd3xbOPM/G
 D1cQePb+36C8L+At8Y2jAiwboJaugHcfKsn0=
X-Google-Smtp-Source: AGHT+IFobezSVDTgUkIKYsurkUdnKbRzjLWtD8U4He3n/JgYRwCOuwgtGVwGqs4vAHNI3ThGxxvNEHFTkL3LhITpdFY=
X-Received: by 2002:a05:6402:35c6:b0:5d1:2652:42ba with SMTP id
 4fb4d7f45d1cf-5d4330ab69dmr3732316a12.16.1733934989361; Wed, 11 Dec 2024
 08:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20241209195528.730260-1-sjg@chromium.org>
 <20241209195528.730260-6-sjg@chromium.org>
In-Reply-To: <20241209195528.730260-6-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 11 Dec 2024 16:36:18 +0000
Message-ID: <CALeDE9M_Bgaxom1Ac3Uomu=Mnd+mvKeGNAsHxn63kve8qfwzUg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] rpi: Use the U-Boot control FDT for fdt_addr
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>,
 Matthias Brugger <mbrugger@suse.com>, Francois Berder <fberder@outlook.fr>, 
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 9 Dec 2024 at 19:55, Simon Glass <sjg@chromium.org> wrote:

> The fdt_addr variable is used in extlinux as a fallback devicetree if
> none is provided by the boot command.
>

And what about where extlinux isn't used?


> The existing mechanism uses the devicetree provided to U-Boot, but in
> its original, unrelocated position. For the rpi_4 I am using, this is
> at 2b35ef00 which is not a convenient place in memory, if the ramdisk
> is large.
>
> U-Boot already deals with this sort of problem by relocating the FDT
> to a safe address.
>
> So use the control-FDT address instead.
>

Please re-word the above, it doesn't make sense to me, "the rpi_4 I am
using" .... what about the other millions of RPis out there?


> Remove the existing comment, which is confusing, since the FDT is not
> actually passed unmodified to the kernel: U-Boot adds various things
> using its FDT-fixup mechanism.
>

Don't remove it, re-word it so it's up to date.


> Note that board_get_usable_ram_top() reduces the RAM top for boards with
> less RAM. This behaviour is left unchanged as there is no other
> mechanism for U-Boot to handle this.
>

The below looks irrelevant to the patch at hand, it looks like it should be
in the cover letter.


> In version 2, it incorporates some changes to fdt_addr, etc. suggested
> by Tom, as well as adding myself as a maintainer.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Drop patch to allow expanding the devicetree during relocation
>
>  board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 9122f33d88d..8f6ab1b1b9b 100644
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
> @@ -325,19 +327,10 @@ static void set_fdtfile(void)
>         env_set("fdtfile", fdtfile);
>  }
>
> -/*
> - * If the firmware provided a valid FDT at boot time, let's expose it in
> - * ${fdt_addr} so it may be passed unmodified to the kernel.
> - */
> +/* Allow U-Boot to use its control FDT with extlinux if one is not
> provided */
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
> @@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  {
>         int node;
>
> -       update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> +       if (blob == gd->fdt_blob)
> +               log_debug("Same FDT: nothing to do\n");
> +       else
> +               update_fdt_from_fw(blob, (void *)gd->fdt_blob);
>
>         node = fdt_node_offset_by_compatible(blob, -1,
> "simple-framebuffer");
>         if (node < 0)
> --
> 2.34.1
>
>
