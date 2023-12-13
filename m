Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AAEC4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77AB87633;
	Wed, 13 Dec 2023 20:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kC1o81We";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD33E871AA; Wed, 13 Dec 2023 20:52:06 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E462387834
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d8a772157fso65065127b3.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497122; x=1703101922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I2L8AYxNZ98vS0veIw0qd9iJJXovWL2n7tkrdHHAGb4=;
 b=kC1o81WetsYiNjqbZYxUmp7dehMCnbEffII3I/nL+LllgLTHLk5QClLOgjV5sCdNN2
 X0j2EFUjYPtD5qXXQv6egPxWbFlewDsYI+cqKeuDof+iFhdFilWBn8F54B4l/pWk1F/+
 XVIlXvM7BOd72NXhdr4kz+1eG1zyOYatRuVoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497122; x=1703101922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2L8AYxNZ98vS0veIw0qd9iJJXovWL2n7tkrdHHAGb4=;
 b=Yo94il3P7c03mvvg7PLmuGS6CIuEAZNEPrYEtXC9t8t93mg+aWyYI9iHpIE1NHVZBL
 1n9fr3KwMAmmVLGU7UZx5p1oHYt7Dl3O1CQVCKgjiOGGsSmSx2S3a+RwTfBqwRIS1jzV
 Yb6/EKMvSU8crIwLBFAZj+lGXm6ktsQRklZ/nvHoWjKrU2aYpxVrTrZV96ZGtbyilIIO
 NcJU3tHc5YSBpk4HdpSxD6A1V5epB4Kjoll7KsiRR073AvNQAKaWseGZNqbjhslLnyRe
 SVq5KPScNxdCP6YBFAIFdiRMR3o7Qh3NUhBga8zP2Yah4j1A7QQi1U1O1mEfbYUiTU1D
 KRnQ==
X-Gm-Message-State: AOJu0YwBAslC4IxbHtW8ZMrxpbdFnw7DXvbf58NsobOknvOTvqZYgJV6
 IMpKyWtZB+B4oMKwrOi9NV+zO2qxwQPZBZB9MWta9w==
X-Google-Smtp-Source: AGHT+IE2lys2GsbSEAGNDnp7qm4AgIYzLE8byugAWDEskQ24rNHipthzRvfRJB1aBjG6SIOFOVgoXOazJHBeEG1fvww=
X-Received: by 2002:a5b:14f:0:b0:db7:dacf:ed7c with SMTP id
 c15-20020a5b014f000000b00db7dacfed7cmr5616951ybp.93.1702497122337; Wed, 13
 Dec 2023 11:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20231207091850.17776-2-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:51:20 -0700
Message-ID: <CAPnjgZ2Y5Dzhp2c5qsoDEjY-w8NsueEHgvCSfTEbtEOPMTJ9wA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] smbios: Simplify reporting of unknown values
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 u-boot@lists.denx.de
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

On Thu, 7 Dec 2023 at 02:19, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> If a value is not valid during the DT or SYSINFO parsing,  we explicitly
> set that to "Unknown Product" and "Unknown" for the product and
> manufacturer respectively.  It's cleaner if we move the checks insisde
> smbios_add_prop_si() and provide an alternative string in case the
> primary is NULL or empty
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
> While at it make smbios_add_prop_si() add a string directly if the prop
> node is NULL and replace smbios_add_string() calls with
> smbios_add_prop_si(ctx, NULL, ....)
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v2:
> - refactor even more code and remove the smbios_add_string calls from the
>   main code. Instead use smbios_add_prop() foir everything and add a
>   default value, in case the parsed one is NULL or emtpy
> Changes since v1:
> - None
>
>  lib/smbios.c | 73 +++++++++++++++++++++++++---------------------------
>  1 file changed, 35 insertions(+), 38 deletions(-)
>

I actually think we should just stop here and first write a test for
what we already have. I can take a crack at it if you like?

> diff --git a/lib/smbios.c b/lib/smbios.c
> index d7f4999e8b2a..444aa245a273 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -102,9 +102,6 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
>         int i = 1;
>         char *p = ctx->eos;
>
> -       if (!*str)
> -               str = "Unknown";
> -
>         for (;;) {
>                 if (!*p) {
>                         ctx->last_str = p;
> @@ -134,11 +131,18 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
>   *
>   * @ctx:       context for writing the tables
>   * @prop:      property to write

which can now be NULL?

> + * @dval:      Default value to use if the string is not found or is empty
>   * Return:     0 if not found, else SMBIOS string number (1 or more)
>   */
>  static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> -                             int sysinfo_id)
> +                             int sysinfo_id, const char *dval)
>  {
> +       if (!dval || !*dval)
> +               dval = "Unknown";

You shouldn't need this, right? It is already the default valuie.

> +
> +       if (!prop)
> +               return smbios_add_string(ctx, dval);
> +
>         if (sysinfo_id && ctx->dev) {
>                 char val[SMBIOS_STR_MAX];
>                 int ret;
> @@ -151,8 +155,8 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
>                 const char *str;
>
>                 str = ofnode_read_string(ctx->node, prop);
> -               if (str)
> -                       return smbios_add_string(ctx, str);
> +
> +               return smbios_add_string(ctx, str ? str : dval);
>         }
>
>         return 0;
> @@ -161,12 +165,15 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
>  /**
>   * smbios_add_prop() - Add a property from the devicetree
>   *
> - * @prop:      property to write
> + * @prop:      property to write. The default string will be written if
> + *             prop is NULL
> + * @dval:      Default value to use if the string is not found or is empty
>   * Return:     0 if not found, else SMBIOS string number (1 or more)
>   */
> -static int smbios_add_prop(struct smbios_ctx *ctx, const char *prop)
> +static int smbios_add_prop(struct smbios_ctx *ctx, const char *prop,
> +                          const char *dval)
>  {
> -       return smbios_add_prop_si(ctx, prop, SYSINFO_ID_NONE);
> +       return smbios_add_prop_si(ctx, prop, SYSINFO_ID_NONE, dval);
>  }
>
>  static void smbios_set_eos(struct smbios_ctx *ctx, char *eos)
> @@ -228,11 +235,9 @@ static int smbios_write_type0(ulong *current, int handle,
>         memset(t, 0, sizeof(struct smbios_type0));
>         fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->vendor = smbios_add_string(ctx, "U-Boot");
> +       t->vendor = smbios_add_prop(ctx, NULL, "U-Boot");

What is this doing exactly? I don't really understand this change.

>
> -       t->bios_ver = smbios_add_prop(ctx, "version");
> -       if (!t->bios_ver)
> -               t->bios_ver = smbios_add_string(ctx, PLAIN_VERSION);
> +       t->bios_ver = smbios_add_prop(ctx, "version", PLAIN_VERSION);
>         if (t->bios_ver)
>                 gd->smbios_version = ctx->last_str;
>         log_debug("smbios_version = %p: '%s'\n", gd->smbios_version,
> @@ -241,7 +246,7 @@ static int smbios_write_type0(ulong *current, int handle,
>         print_buffer((ulong)gd->smbios_version, gd->smbios_version,
>                      1, strlen(gd->smbios_version) + 1, 0);
>  #endif
> -       t->bios_release_date = smbios_add_string(ctx, U_BOOT_DMI_DATE);
> +       t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
>  #ifdef CONFIG_ROM_SIZE
>         t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
>  #endif
> @@ -280,22 +285,19 @@ static int smbios_write_type1(ulong *current, int handle,
>         memset(t, 0, sizeof(struct smbios_type1));
>         fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->manufacturer = smbios_add_prop(ctx, "manufacturer");
> -       if (!t->manufacturer)
> -               t->manufacturer = smbios_add_string(ctx, "Unknown");
> -       t->product_name = smbios_add_prop(ctx, "product");
> -       if (!t->product_name)
> -               t->product_name = smbios_add_string(ctx, "Unknown Product");
> +       t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
> +       t->product_name = smbios_add_prop(ctx, "product", "Unknown");
>         t->version = smbios_add_prop_si(ctx, "version",
> -                                       SYSINFO_ID_SMBIOS_SYSTEM_VERSION);
> +                                       SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
> +                                       "Unknown");
>         if (serial_str) {
> -               t->serial_number = smbios_add_string(ctx, serial_str);
> +               t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
>                 strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
>         } else {
> -               t->serial_number = smbios_add_prop(ctx, "serial");
> +               t->serial_number = smbios_add_prop(ctx, "serial", "Unknown");
>         }
> -       t->sku_number = smbios_add_prop(ctx, "sku");
> -       t->family = smbios_add_prop(ctx, "family");
> +       t->sku_number = smbios_add_prop(ctx, "sku", "Unknown");
> +       t->family = smbios_add_prop(ctx, "family", "Unknown");
>
>         len = t->length + smbios_string_table_len(ctx);
>         *current += len;
> @@ -314,15 +316,12 @@ static int smbios_write_type2(ulong *current, int handle,
>         memset(t, 0, sizeof(struct smbios_type2));
>         fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->manufacturer = smbios_add_prop(ctx, "manufacturer");
> -       if (!t->manufacturer)
> -               t->manufacturer = smbios_add_string(ctx, "Unknown");
> -       t->product_name = smbios_add_prop(ctx, "product");
> -       if (!t->product_name)
> -               t->product_name = smbios_add_string(ctx, "Unknown Product");
> +       t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
> +       t->product_name = smbios_add_prop(ctx, "product", "Unknown");
>         t->version = smbios_add_prop_si(ctx, "version",
> -                                       SYSINFO_ID_SMBIOS_BASEBOARD_VERSION);
> -       t->asset_tag_number = smbios_add_prop(ctx, "asset-tag");
> +                                       SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
> +                                       "Unknown");
> +       t->asset_tag_number = smbios_add_prop(ctx, "asset-tag", "Unknown");
>         t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
>         t->board_type = SMBIOS_BOARD_MOTHERBOARD;
>
> @@ -343,9 +342,7 @@ static int smbios_write_type3(ulong *current, int handle,
>         memset(t, 0, sizeof(struct smbios_type3));
>         fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->manufacturer = smbios_add_prop(ctx, "manufacturer");
> -       if (!t->manufacturer)
> -               t->manufacturer = smbios_add_string(ctx, "Unknown");
> +       t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
>         t->chassis_type = SMBIOS_ENCLOSURE_DESKTOP;
>         t->bootup_state = SMBIOS_STATE_SAFE;
>         t->power_supply_state = SMBIOS_STATE_SAFE;
> @@ -388,8 +385,8 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
>  #endif
>
>         t->processor_family = processor_family;
> -       t->processor_manufacturer = smbios_add_string(ctx, vendor);
> -       t->processor_version = smbios_add_string(ctx, name);
> +       t->processor_manufacturer = smbios_add_prop(ctx, NULL, vendor);
> +       t->processor_version = smbios_add_prop(ctx, NULL, name);
>  }
>
>  static int smbios_write_type4(ulong *current, int handle,
> --
> 2.40.1
>

From my understanding, the only thing your fallback adds is the
manufacturer ('vendor' from DT compatible = "vendor,board"), and the
product (from DT model = "..."). This is an awful lot of code to make
that change and it seems very, confusing to me.

Instead, can you do something like:

if (!IS_ENABLED(CONFIG_SYSINFO)) {
   const char *compat = ofnode_read_string(ofnode_root(), "compatible");
   const char *model = ofnode_read_string(ofnode_root(), "model");
   const *p = strchr(compat, ',');
   char vendor[32];

  *vendor = '\0';
  if (p) {
      int len = p - compat + 1;

      strlcpy(vendor, compat, len);
  }

  // add these two strings to the ctx struct so that
smbios_write_type1() can pass them as defaults
}

You still need to make the 'default' change, but much of the other
code could go away?

Regards,
Simon
