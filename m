Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A80C71135
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 12:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB2482B0F;
	Sun, 15 Jun 2025 14:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZ8gj38j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E2382C87; Sun, 15 Jun 2025 14:16:04 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470A981E06
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 14:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-adeaa4f3d07so689931966b.0
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749989762; x=1750594562; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NKUshNU74Ojpf6DKLazvuZluano6TtIecvnHy0w/+F0=;
 b=CZ8gj38jP8m1J1qpnByc4S0SEu60EOHudeZmuxtU0H1BwNFg//NXY35sjVz4vf6W5e
 8mcpy+LNvbiUPJmiw55L4vlb3LHUzon+OyLrs3E4prNDVs8ko6HDDf4YikwrQOhuqN6e
 sg/3OxiQNABlB9854HWfmzairAPK5G9/OdGcsfKW2TPAPr6+hG/gEoOoSh0Io6BgDbVJ
 uK0zzTl/WTCWbmtleECBaMw4gOWnq5UEqaeChU4mPtESGNcyAZq4olg+bkA16fexKz57
 iAnN6xJRhiKol+yWd++3A7qd+vHTFVkK/l3o+Esv3FE4B8WFAa1SxoTysPwAvMRP16hF
 b7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749989762; x=1750594562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKUshNU74Ojpf6DKLazvuZluano6TtIecvnHy0w/+F0=;
 b=Ci1uEJxYlLphIVvqKSSZSe3smjSoQYy4oOgKBTo6jEfLZdwAtBGUp79s8zH7fm9pCl
 aTmCplbYcD1I6UnLjzxXnrKCIkdyV62OG8BB5ZgZ0UMEgwWfLae1lbgViuOP4d3+Gd64
 U7YWPqWl03ZucDP756/MjNWU/q9XKk4EqQ25Bdo7XYQjSYJgC7XoM8gDk2uRj/ysBb4h
 h2Guf3o4e8RZ4HnBfok41zg1mHvJkhfMIhf9jmjYHmy4tPtnXPV8i3NiTtrqf5zcvkkE
 7nOgbctiC/XBE6sPh0MI+jqt/BuVvby9UKYbRzn4BSw6p/2HULes7eP05Mc0+vSOTE4r
 AD8Q==
X-Gm-Message-State: AOJu0YyDneaI2uLf04l/xo8LFmb19jqH5vl+zPnxpPfzbtQN1CF3W7LI
 XJ49w4+sQsovFEI64s90B8oyRsq0tqJqJpDoPcC5Ti6jRapuuBOmx3olp+/cO/uYncUNk0yG8FH
 oLKHWXB8DgwDq55eR+VWsY1MmOLpTq+s=
X-Gm-Gg: ASbGncu4F6+1gSf3BdnAXDT8nZFKIpIi59lg6gbVf+7XWDday0gCFAXTArDP4Z3TZFa
 yYBpCEoFPYE5Q4YDIp21eHYfzqSsCHrRwqLKplNOOKCfvHjKr6jZnqZiWfkpogXcbyo5OhDLeFf
 yglobW8mmrTJH8rxPOMcCZtWMv06p03AzkQ4Eny533H/dnxFAFuWdXFVI8yuEKwyI1Nic3ioNgR
 CHF
X-Google-Smtp-Source: AGHT+IE0AwT97dXoSAz9O4LPie3yW5z/oryroBa+Ipvl9Szb7LNio3oqYTp8/3fhMrYW8SE7E7HCb76TyLEl6bQ/70k=
X-Received: by 2002:a17:907:3e06:b0:ad8:a512:a9ea with SMTP id
 a640c23a62f3a-adfad3eac68mr369876066b.8.1749989761555; Sun, 15 Jun 2025
 05:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250514144649.1329480-1-fiona.klute@gmx.de>
In-Reply-To: <20250514144649.1329480-1-fiona.klute@gmx.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 15 Jun 2025 13:15:50 +0100
X-Gm-Features: AX0GCFtJx7ONBf6B4RyZcJ5aYv4XZcTTEOaYlfai-7piNn1az9FFMq5BgI9X_Uo
Message-ID: <CALeDE9O0-ejF_-coqOX=513xCnj0+H=FrsfgsC4tvFvgaZ6yNw@mail.gmail.com>
Subject: Re: [PATCH] rpi: copy /system/linux, {serial,
 revision} from firmware FDT
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
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

On Wed, 14 May 2025 at 15:47, Fiona Klute <fiona.klute@gmx.de> wrote:
>
> Both the Raspberry Pi downstream kernel [1] and some userspace tools
> [2] use the revision property to identify the board, and the latter
> fails if it is absent. The firmware creates the /system node which is
> not present in Linux DTS (mainline or vendor) for the Raspberry Pi
> boards, so we need to do the same.
>
> [1] https://github.com/raspberrypi/linux/blob/0f292fbb6346b05766152902076895558ac23f9a/arch/arm/mach-bcm/board_bcm2835.c#L23-L33
> [2] https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852ede5aaa388180da/rpihw.c#L579
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> I sent an RFC version of this patch [3] a while ago with the question
> if there's a better way to create the /system node than creating a
> temporary overlay. I didn't receive any response to that question, so
> I guess not.

Apologies, it got lost, replied on that thread.

> [3] https://lists.denx.de/pipermail/u-boot/2025-February/580364.html
>
>  board/raspberrypi/rpi/rpi.c | 70 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 1b0b664fa2b..6545306f6da 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -562,6 +562,74 @@ int copy_property(void *dst, void *src, char *path, char *property)
>         return fdt_setprop(dst, dst_offset, property, prop, len);
>  }
>
> +void copy_system_node(void *fdt, void *fw_fdt)
> +{
> +       void *fdt_copy = NULL;
> +       const fdt32_t *prop;
> +       char fdto[1024];
> +       int src_offset;
> +       u32 fdt_size;
> +       int len;
> +
> +       /*
> +        * If the firmware FDT does not have a /system node, there's
> +        * nothing to do.
> +        */
> +       src_offset = fdt_path_offset(fw_fdt, "/system");
> +       if (src_offset < 0)
> +               return;
> +
> +       /* Create a temporary overlay that adds the /system node. */
> +       if (fdt_create(fdto, sizeof(fdto)))
> +               return;
> +       if (fdt_finish_reservemap(fdto))
> +               return;
> +       if (fdt_begin_node(fdto, ""))
> +               return;
> +       if (fdt_begin_node(fdto, "fragment"))
> +               return;
> +       if (fdt_property_string(fdto, "target-path", "/"))
> +               return;
> +       if (fdt_begin_node(fdto, "__overlay__"))
> +               return;
> +       if (fdt_begin_node(fdto, "system"))
> +               return;
> +
> +       prop = fdt_getprop(fw_fdt, src_offset, "linux,serial", &len);
> +       if (prop)
> +               fdt_property(fdto, "linux,serial", prop, len);
> +       prop = fdt_getprop(fw_fdt, src_offset, "linux,revision", &len);
> +       if (prop)
> +               fdt_property(fdto, "linux,revision", prop, len);
> +
> +       if (fdt_end_node(fdto))
> +               return;
> +       if (fdt_end_node(fdto))
> +               return;
> +       if (fdt_end_node(fdto))
> +               return;
> +       if (fdt_end_node(fdto))
> +               return;
> +       if (fdt_finish(fdto))
> +               return;
> +
> +       /*
> +        * A failed overlay apply is destructive to the target, so use
> +        * a temporary copy and replace the FDT if successful.
> +        */
> +       fdt_size = fdt_totalsize(fdt);
> +       fdt_copy = malloc(fdt_size);
> +       if (!fdt_copy)
> +               return;
> +       memcpy(fdt_copy, fdt, fdt_size);
> +       if (fdt_overlay_apply_verbose(fdt_copy, fdto))
> +               goto cleanup;
> +       memcpy(fdt, fdt_copy, fdt_size);
> +
> + cleanup:
> +       free(fdt_copy);
> +}
> +
>  /* Copy tweaks from the firmware dtb to the loaded dtb */
>  void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>  {
> @@ -572,6 +640,8 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>         /* The firmware provides a more precise model; so copy that */
>         copy_property(fdt, fw_fdt, "/", "model");
>
> +       copy_system_node(fdt, fw_fdt);
> +
>         /* memory reserve as suggested by the firmware */
>         copy_property(fdt, fw_fdt, "/", "memreserve");
>
> --
> 2.49.0
>
