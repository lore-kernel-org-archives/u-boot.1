Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A621C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 12:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D20C80E88;
	Sat, 15 Feb 2025 13:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TP14hl7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53C080EEB; Sat, 15 Feb 2025 13:06:05 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80AC480B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abb86beea8cso2210766b.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739621163; x=1740225963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dNAxAzcD+yHjwwS2QtfZhdDEceJ7CgDSc6oUyHhqyr4=;
 b=TP14hl7AOq7plGebPL20XhDarh14199UWOzj4kgXW71ZzCcCoiB5fJ+ZCacLcU7Dqu
 lKV4f6PNu6dLhZwrZdxEtrOpmVcrJS9sOoz+1GXPFFhsaiQmD8+KUeco53dyZdztASdh
 Gw/1U4lWDqqckE5ypf4C6wXZ/9ieXuiSrmsLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739621163; x=1740225963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dNAxAzcD+yHjwwS2QtfZhdDEceJ7CgDSc6oUyHhqyr4=;
 b=BoJ9wtHC5oTgfGEK6OY47gL1U21Yl+DxR7k18AzxJcEQRVy21dZoetgOCUwgX8aGVk
 EwiYI0zqsYz3tdgtTlTRDCFdi9LLoJGLjuF066n5ldUe6kzP4Kv+dAcUUb5Mg1m71P8e
 Pc1bp3RR1nymtkG1Y+PSBLbMRTvzmMvbzWL0DCzKsvAT94PZYImgDpHRQkf35q+fp0b7
 dzO8m2huXeDR29IoXGgj+zX9beblf53KQLvc4VW/XaGuOY0R+GFU9++Zj5IhG+8c3ZxN
 d+X95/fCFXZpyF9wJWq4HLVz1ADp9DwEXXe0A2jKUJTo72WsN78/2Trn6WylmAYcANPx
 GWkA==
X-Gm-Message-State: AOJu0Yyf2Aogu5NvFVJGWW0TJ/SE98Sy2Xg15KhfsO4gW7ayDPbBvHcG
 5r0eJPyLHDF825kayoqxKHrcnEhz8FOCltrK18zcN/UDpwDV8C3x2VUJSrg6q7nqFAQ97X0GlIV
 Amdqwx3rc7fyuwaMfVx29MpBN+a13GeQ72UGE8HEP6xycdhI=
X-Gm-Gg: ASbGncs30HQ/aGIXNC6MadCe3yU5Gecf3j9NmRlGdvCjIooF9+DV6NAvVCQ7DyZQaWO
 d3yee9InKfTrcczj2XVuoKlGTKWmwUtHlT47Rk0GMDZthkbwhtMKA3vyVaLB6gVHb6ZvRQxRI1w
 ==
X-Google-Smtp-Source: AGHT+IEk5QhmMfXUPLmLGGmdNMMR/ksOTzn5j2Oi9ln0L8Uvjlz9We/bfu/y994rNkOVoeehxH6PE1JfM58laL6w9Tk=
X-Received: by 2002:a17:907:7e9c:b0:ab7:c893:fc80 with SMTP id
 a640c23a62f3a-abb70d9d0bdmr249486066b.24.1739621162921; Sat, 15 Feb 2025
 04:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20250211135829.3467088-1-fiona.klute@gmx.de>
In-Reply-To: <20250211135829.3467088-1-fiona.klute@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 05:05:50 -0700
X-Gm-Features: AWEUYZl_q4onWzTfqNAnriK5beEWoV-PVtn5uFRP33MG9vGBLbRGQoqzU6JyHlo
Message-ID: <CAFLszTgiA3_SsQEPg_+denTdJ3hMrWyKPsQUho5=EjeOF_W5XA@mail.gmail.com>
Subject: Re: [RFC] Raspberry Pi: copy /system/linux, {serial,
 revision} from firmware
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Fiona,

On Tue, 11 Feb 2025 at 07:56, Fiona Klute <fiona.klute@gmx.de> wrote:
>
> Both the Raspberry Pi downstream kernel [1] and some userspace tools
> [2] use the revision property to identify the board, and the latter
> fails if it is absent. The firmware creates the /system node, so we
> need to do the same.
>
> [1] https://github.com/raspberrypi/linux/blob/0f292fbb6346b05766152902076895558ac23f9a/arch/arm/mach-bcm/board_bcm2835.c#L23-L33
> [2] https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852ede5aaa388180da/rpihw.c#L579
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> I'm sending this as RFC because I'm not sure if creating a temporary
> overlay is the best approach here, advice on a better way to create the
> /system node if needed is very much welcome. I know I'll need to add
> more error checks, I'll do that after I know I have the right approach.
>
>  board/raspberrypi/rpi/rpi.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

From my side, if my rpi seriesl[1] results in my becoming a rpi
maintainer, I'll take a look at this and other pending rpi patches.

>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index aa39afa338a..647716127c7 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -550,6 +550,41 @@ int copy_property(void *dst, void *src, char *path, char *property)
>         return fdt_setprop(dst, dst_offset, property, prop, len);
>  }
>
> +int copy_system_node(void *fdt, void *fw_fdt)
> +{
> +       const fdt32_t *prop;
> +       char fdto[2048];
> +       int src_offset;
> +       int len;
> +
> +       src_offset = fdt_path_offset(fw_fdt, "/system");
> +       if (src_offset < 0)
> +               return -1;
> +
> +       fdt_create(fdto, sizeof(fdto));
> +       fdt_finish_reservemap(fdto);
> +       fdt_begin_node(fdto, "");
> +       fdt_begin_node(fdto, "fragment");
> +       fdt_property_string(fdto, "target-path", "/");
> +       fdt_begin_node(fdto, "__overlay__");
> +       fdt_begin_node(fdto, "system");
> +
> +       prop = fdt_getprop(fw_fdt, src_offset, "linux,serial", &len);
> +       if (prop)
> +               fdt_property(fdto, "linux,serial", prop, len);
> +       prop = fdt_getprop(fw_fdt, src_offset, "linux,revision", &len);
> +       if (prop)
> +               fdt_property(fdto, "linux,revision", prop, len);
> +
> +       fdt_end_node(fdto);
> +       fdt_end_node(fdto);
> +       fdt_end_node(fdto);
> +       fdt_end_node(fdto);
> +       fdt_finish(fdto);
> +
> +       fdt_overlay_apply_verbose(fdt, fdto);
> +}
> +
>  /* Copy tweaks from the firmware dtb to the loaded dtb */
>  void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>  {
> @@ -560,6 +595,8 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>         /* The firmware provides a more precise model; so copy that */
>         copy_property(fdt, fw_fdt, "/", "model");
>
> +       copy_system_node(fdt, fw_fdt);
> +
>         /* memory reserve as suggested by the firmware */
>         copy_property(fdt, fw_fdt, "/", "memreserve");
>
> --
> 2.47.2
>

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=437666
