Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D499C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E928D870EA;
	Thu, 30 Nov 2023 03:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lMCcTBu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC988767C; Thu, 30 Nov 2023 03:46:26 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5315A87652
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-da30fd994fdso1324916276.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312381; x=1701917181; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=52oMwfOtdUlrYDxJNpEkYspZUN3qP2WZc4B/ra7UPbI=;
 b=lMCcTBu4jbJUfKGL3b1opNDkcm7BwQWR5HB8LYjXau1MoL0wzSzhUxRqByeFC2rhAE
 ynC5DF8FatriozwR8pVNHQrDFaEDx11zMxct2ycfqpYmmitS4hcv8TNIYeY5DK14H6l9
 D6S7SFyT2wx+7o1iYzJzCLNLCELuXV0yPQcLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312381; x=1701917181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=52oMwfOtdUlrYDxJNpEkYspZUN3qP2WZc4B/ra7UPbI=;
 b=XMH+cIFER0kbwRiZ5mGhG5p1xHakXwuvpJ6AxbrDqUWPDlgykT/vZwfcOrQkimUDtB
 8s3eRjWFmt4P3rW6UsHh3NhGEXR3tcGcIwPDYTX9ta2z87iE+OM8FkLchGZhXmyq7xOK
 5l9Caw+li+T+/bh2V8fqPl/D8fR5QnZO4tTvYhCECFzfLKo4bbXBNlccxQc6JZMrfgfD
 pPBZSxXnHcYoX2P/99PMgmVyrLKMEVspYLCKVjNfcMtQgNb6Avd4iTrNyhs+IG0liveT
 lO54Fn4URMzdHjaAsRmLgm0984wUBWEkDTkbzbBB93hRxXW4at2+/vu6wKBnN9Fw/vRz
 LKRw==
X-Gm-Message-State: AOJu0Yzpu/EeT/BiA8lnHK97sjAuJidSxh1Ua9LRyI/Psk0PzdAjovoe
 QzrHX8RziSdR/joK7e2TKvtQvsMY7RwjUR0Fsfk10w==
X-Google-Smtp-Source: AGHT+IH4it/RkiY5NNvSadj74eK6sf9qjcyXUBpsOKFXlJb9gks/i9MosLWZOmB7CtERJOwlERXQ7PV3VdW9lJu/ow8=
X-Received: by 2002:a05:690c:3709:b0:5cd:fdfd:dc28 with SMTP id
 fv9-20020a05690c370900b005cdfdfddc28mr14128436ywb.7.1701312380792; Wed, 29
 Nov 2023 18:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20231127171058.165777-2-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:26 -0700
Message-ID: <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

Hi Ilias,

On Mon, 27 Nov 2023 at 10:11, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> If a value is not valid during the DT or SYSINFO parsing,  we explicitly
> set that to "Unknown Product" and "Unknown" for the product and
> manufacturer respectively.  It's cleaner if we move the checks insisde
> smbios_add_string() and always report "Unknown" regardless of the missing
> field.
>
> pre-patch dmidecode
> <snip>
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Unknown
>         Product Name: Unknown Product
>         Version: Not Specified
>         Serial Number: Not Specified
>         UUID: Not Settable
>         Wake-up Type: Reserved
>         SKU Number: Not Specified
>         Family: Not Specified
>
> [...]
>
> post-patch dmidecode:
>
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Unknown
>         Product Name: Unknown
>         Version: Unknown
>         Serial Number: Unknown
>         UUID: Not Settable
>         Wake-up Type: Reserved
>         SKU Number: Unknown
>         Family: Unknown
> [...]
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> Changes since v1:
> - None
>
>  lib/smbios.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index d7f4999e8b2a..fcc8686993ef 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -102,7 +102,7 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)

I suggest that this function have an additional str property
indicating the default string. Then you can pass DEFAULT_VAL or
something like that, to each call.

>         int i = 1;
>         char *p = ctx->eos;
>
> -       if (!*str)
> +       if (!str || !*str)

Does it ever happen that the string is present but empty?

>                 str = "Unknown";
>
>         for (;;) {
> @@ -151,8 +151,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
>                 const char *str;
>
>                 str = ofnode_read_string(ctx->node, prop);
> -               if (str)
> -                       return smbios_add_string(ctx, str);
> +               return smbios_add_string(ctx, str);
>         }
>
>         return 0;
> @@ -231,7 +230,7 @@ static int smbios_write_type0(ulong *current, int handle,
>         t->vendor = smbios_add_string(ctx, "U-Boot");
>
>         t->bios_ver = smbios_add_prop(ctx, "version");
> -       if (!t->bios_ver)
> +       if (!strcmp(ctx->last_str, "Unknown"))

That is really ugly...checking the ctx value looking for a side effect.

Can you not have smbios_add_prop() continue to return NULL in this case?

>                 t->bios_ver = smbios_add_string(ctx, PLAIN_VERSION);
>         if (t->bios_ver)
>                 gd->smbios_version = ctx->last_str;
> @@ -281,11 +280,7 @@ static int smbios_write_type1(ulong *current, int handle,
>         fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
>         t->manufacturer = smbios_add_prop(ctx, "manufacturer");
> -       if (!t->manufacturer)
> -               t->manufacturer = smbios_add_string(ctx, "Unknown");
>         t->product_name = smbios_add_prop(ctx, "product");
> -       if (!t->product_name)
> -               t->product_name = smbios_add_string(ctx, "Unknown Product");
>         t->version = smbios_add_prop_si(ctx, "version",
>                                         SYSINFO_ID_SMBIOS_SYSTEM_VERSION);
>         if (serial_str) {
> @@ -315,11 +310,7 @@ static int smbios_write_type2(ulong *current, int handle,
>         fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
>         t->manufacturer = smbios_add_prop(ctx, "manufacturer");
> -       if (!t->manufacturer)
> -               t->manufacturer = smbios_add_string(ctx, "Unknown");
>         t->product_name = smbios_add_prop(ctx, "product");
> -       if (!t->product_name)
> -               t->product_name = smbios_add_string(ctx, "Unknown Product");
>         t->version = smbios_add_prop_si(ctx, "version",
>                                         SYSINFO_ID_SMBIOS_BASEBOARD_VERSION);
>         t->asset_tag_number = smbios_add_prop(ctx, "asset-tag");
> @@ -344,8 +335,6 @@ static int smbios_write_type3(ulong *current, int handle,
>         fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
>         smbios_set_eos(ctx, t->eos);
>         t->manufacturer = smbios_add_prop(ctx, "manufacturer");
> -       if (!t->manufacturer)
> -               t->manufacturer = smbios_add_string(ctx, "Unknown");
>         t->chassis_type = SMBIOS_ENCLOSURE_DESKTOP;
>         t->bootup_state = SMBIOS_STATE_SAFE;
>         t->power_supply_state = SMBIOS_STATE_SAFE;
> --
> 2.40.1
>

Regards,
Simon
