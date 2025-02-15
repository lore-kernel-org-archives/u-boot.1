Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9E6C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 13:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4127180B98;
	Sat, 15 Feb 2025 14:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hfppRJcF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C2980C6F; Sat, 15 Feb 2025 14:01:55 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A0E80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 14:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3078fb1fa28so28764251fa.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 05:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739624512; x=1740229312; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uexzINLYVpLsgRcWseUz12kGhmiQEp8+kWs027duCDU=;
 b=hfppRJcFvuPSL7n/WeTEZ/hJ9AO9jjBtsZlcF+SoXc7Dxd7g991UIla9QWNRAzbHNb
 gwd2fuHtXaKe+Q9L79JjVg5iPu8KtvtLkdPK6XUJQ9fDgAuC4hksTG5xshfeWGjlriFb
 u6VLjOrp+MA8x3bWsMDX8WSa08jVzjM9mDVVVwIxGTkwBMkX9z5qAasQSY+W8MLqqDWK
 haCnh0uM6070wm77ipKrlLsaDVUYXpIDm2KZwawKw0iM9XoPqxqXBCy2ALktXorfeL7F
 UBrRymGAC2nZyGOI/6OAymKLy/bzZCKpHyocHNA+ILZKGmM5r3Ww0u62xNINYwZXqbrl
 JC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739624512; x=1740229312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uexzINLYVpLsgRcWseUz12kGhmiQEp8+kWs027duCDU=;
 b=KaerMyulv1YgdHjGcecEwxzbUx4ExGjBWRPnoQvVY6dJVEXVu3F8nkwTjBgnpVV/nn
 vHaSLGBh4XHeEZeKdXRvsK5mxAibfxXjHIu+sxGksJf0HIClKJ43lDGDkK7Dpp4OCl52
 QR0rwdKq1v6Yud5l2Aea+8Or5J3mnV4WgufC17s/8DDMFPqqJZbE0S8TYVEIbJbpY9IV
 07HoX0bTlkmTOIeVbL0sm+I7u7aBPmCImCVPpxTZJvD5An/gFR+t8j2uDG59DKsEfmJZ
 hVBno9vG7rYbv2ocVImvDZzYzYMtcZd7zH0fF9eFwUeifTraI99tZDAQTX/LtPuTDNBX
 01cA==
X-Gm-Message-State: AOJu0Yx6ytVj7ZZ6d0I4iQ1p3/v3mT2/XBVpHrvN+P5FQsHDOJaSc0sa
 gr0wzVFP2RZ/CdaKkPknES+bqNr4EWVf4Y7c8Hdnk5MnocCcSOWj97TSVGpemOqNCyxPoV05Kzx
 f3PJYv4+x3Zqg4g0hGO4GOFsCGvM/Lw==
X-Gm-Gg: ASbGncs++VYnQdZlYMwnFNYbmAczNDcS3N5HORP7ZL/GrdE8qWaq6zkt4ydEXMFK6id
 7ZTVHaE5xaH0HJsIZE/CncJaal0DgblGJ4RIgh4rbfa+mCt2qYyobQGba5XY4ezgYSM3F5ouvyL
 Zspw0cbjS+uz40Aj3gLcHAZQzZDKvrvQ==
X-Google-Smtp-Source: AGHT+IHT4AeftcRbFMxGozCI5tfCDWiE+P/ZTT1PTksDjZL1bM0ti5peRZkljyDYraSzUpF+MXxe9pYTpkAv3n7WBX4=
X-Received: by 2002:a05:6402:254b:b0:5d3:cfd0:8d46 with SMTP id
 4fb4d7f45d1cf-5e0361ed374mr3145582a12.30.1739624501435; Sat, 15 Feb 2025
 05:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20250211135829.3467088-1-fiona.klute@gmx.de>
In-Reply-To: <20250211135829.3467088-1-fiona.klute@gmx.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 15 Feb 2025 13:01:30 +0000
X-Gm-Features: AWEUYZnIYF1zwYp088JHnQwJyM261zGaN___R-IhcngvLnmq3bzeffbZj07aS8s
Message-ID: <CALeDE9Oumn2xO0MPq+L5rsv5NEAjL=XM8zRNA38uV+MbqkVrzw@mail.gmail.com>
Subject: Re: [RFC] Raspberry Pi: copy /system/linux, {serial,
 revision} from firmware
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Fiona,

I'll review and test this the coming week and provide feedback.

On Tue, 11 Feb 2025 at 13:58, Fiona Klute <fiona.klute@gmx.de> wrote:

> Both the Raspberry Pi downstream kernel [1] and some userspace tools
> [2] use the revision property to identify the board, and the latter
> fails if it is absent. The firmware creates the /system node, so we
> need to do the same.
>
> [1]
> https://github.com/raspberrypi/linux/blob/0f292fbb6346b05766152902076895558ac23f9a/arch/arm/mach-bcm/board_bcm2835.c#L23-L33
> [2]
> https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852ede5aaa388180da/rpihw.c#L579
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
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index aa39afa338a..647716127c7 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -550,6 +550,41 @@ int copy_property(void *dst, void *src, char *path,
> char *property)
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
>
