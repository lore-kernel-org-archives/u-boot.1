Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B577C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 11:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E90D8757F;
	Sat,  9 Dec 2023 12:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yyep+W+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9509E875A4; Sat,  9 Dec 2023 12:43:04 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC4708757C
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 12:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-54f49c10c37so3288383a12.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 03:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702122181; x=1702726981; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwGPFAnXjm3NGXsSKWwkkOFZT/rbiHK3CBTJDA6QJUg=;
 b=Yyep+W+9uejhMUpq2AOagaRZdWygllk0hKyrPhChBRZtvZXyCHeQROSAQlS0ZTLGAf
 cqQPwFGyw4Y9nm3SX0BVfjQCBtifqF3HtgWL/k5ZzMUTyTuvEJO9b9JUducJh2+coGpe
 JXwy6Z+rmR1QH+XQHNlBq2e+Pd/x2EfjhJkX+lHS6eqay1+22D6x6ydZGvh2RHdYo1EM
 s6jHO1/7FkNYt+/r4Bn5lzV1HT9eiUeFxO75veZXLacO6Gtq8db4HJK/HEuOzKOuNnup
 aUD0MFTOjuJu9FGQn30ZAARLCM6YDAf1bQnDF0Wzl77YtcWkVQ1NM6j7cpc/AhakwctU
 jEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702122181; x=1702726981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jwGPFAnXjm3NGXsSKWwkkOFZT/rbiHK3CBTJDA6QJUg=;
 b=LGaOCfgjnuk6nm5aYrTQrkyLzzVvP8l+R4Ax1SiqSBTrLeVVu+ciVzL18bXUPKx8dc
 0yWHgsBim4bFv0eSuxNdfSvtBAlSlezqox0O5tBLzUptpl3sf8emeG49hJ2gRw5lTED8
 5XnurSSjRQtlnPdVfff0p5qBd3Cmqym0FJ4FzedrlVhlqiggKAhLO7RDqApMOuxZ6mbG
 T5usqW/gpSyikbWAZ/jUDLCXjuQzj9wNx75uBZ9WktSylwva+RZ5u2JtGnzy+d8Ixo2h
 QvwkvJWv+L8eYyVoRuefg9h9U3P5mEEgTw8yz3tI3+nnOqWV3EyA661cNwVtGYd5WJvP
 Tvhw==
X-Gm-Message-State: AOJu0Yxp0vtSpdzd/i991F91nvT4Pk/VHUY+m2AtNy4/dmNjnU0qE5Ru
 rMbmA6tPSHaVPrOB2INFC4RIH0kC4ZYsyTLRuFo=
X-Google-Smtp-Source: AGHT+IGwvTUJF0GiS2THRdP48OtQ9QoZOz11BFCbnHXQaBlSyrw9hxnZwpubZD5spEu5ieIDOBLT+mr8HURkrXCEQzA=
X-Received: by 2002:a50:f604:0:b0:54c:c745:49dd with SMTP id
 c4-20020a50f604000000b0054cc74549ddmr1442625edn.19.1702122180746; Sat, 09 Dec
 2023 03:43:00 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20231207091850.17776-2-ilias.apalodimas@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 9 Dec 2023 11:42:49 +0000
Message-ID: <CALeDE9Mj9oLC8ZeBa84Kp8UCVDkRNUK0oUEPJyPLxhX3ePHQEg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] smbios: Simplify reporting of unknown values
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sjg@chromium.org, sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 7, 2023 at 10:17=E2=80=AFPM Ilias Apalodimas
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
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

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
> diff --git a/lib/smbios.c b/lib/smbios.c
> index d7f4999e8b2a..444aa245a273 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -102,9 +102,6 @@ static int smbios_add_string(struct smbios_ctx *ctx, =
const char *str)
>         int i =3D 1;
>         char *p =3D ctx->eos;
>
> -       if (!*str)
> -               str =3D "Unknown";
> -
>         for (;;) {
>                 if (!*p) {
>                         ctx->last_str =3D p;
> @@ -134,11 +131,18 @@ static int smbios_add_string(struct smbios_ctx *ctx=
, const char *str)
>   *
>   * @ctx:       context for writing the tables
>   * @prop:      property to write
> + * @dval:      Default value to use if the string is not found or is emp=
ty
>   * Return:     0 if not found, else SMBIOS string number (1 or more)
>   */
>  static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> -                             int sysinfo_id)
> +                             int sysinfo_id, const char *dval)
>  {
> +       if (!dval || !*dval)
> +               dval =3D "Unknown";
> +
> +       if (!prop)
> +               return smbios_add_string(ctx, dval);
> +
>         if (sysinfo_id && ctx->dev) {
>                 char val[SMBIOS_STR_MAX];
>                 int ret;
> @@ -151,8 +155,8 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx,=
 const char *prop,
>                 const char *str;
>
>                 str =3D ofnode_read_string(ctx->node, prop);
> -               if (str)
> -                       return smbios_add_string(ctx, str);
> +
> +               return smbios_add_string(ctx, str ? str : dval);
>         }
>
>         return 0;
> @@ -161,12 +165,15 @@ static int smbios_add_prop_si(struct smbios_ctx *ct=
x, const char *prop,
>  /**
>   * smbios_add_prop() - Add a property from the devicetree
>   *
> - * @prop:      property to write
> + * @prop:      property to write. The default string will be written if
> + *             prop is NULL
> + * @dval:      Default value to use if the string is not found or is emp=
ty
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
> @@ -228,11 +235,9 @@ static int smbios_write_type0(ulong *current, int ha=
ndle,
>         memset(t, 0, sizeof(struct smbios_type0));
>         fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->vendor =3D smbios_add_string(ctx, "U-Boot");
> +       t->vendor =3D smbios_add_prop(ctx, NULL, "U-Boot");
>
> -       t->bios_ver =3D smbios_add_prop(ctx, "version");
> -       if (!t->bios_ver)
> -               t->bios_ver =3D smbios_add_string(ctx, PLAIN_VERSION);
> +       t->bios_ver =3D smbios_add_prop(ctx, "version", PLAIN_VERSION);
>         if (t->bios_ver)
>                 gd->smbios_version =3D ctx->last_str;
>         log_debug("smbios_version =3D %p: '%s'\n", gd->smbios_version,
> @@ -241,7 +246,7 @@ static int smbios_write_type0(ulong *current, int han=
dle,
>         print_buffer((ulong)gd->smbios_version, gd->smbios_version,
>                      1, strlen(gd->smbios_version) + 1, 0);
>  #endif
> -       t->bios_release_date =3D smbios_add_string(ctx, U_BOOT_DMI_DATE);
> +       t->bios_release_date =3D smbios_add_prop(ctx, NULL, U_BOOT_DMI_DA=
TE);
>  #ifdef CONFIG_ROM_SIZE
>         t->bios_rom_size =3D (CONFIG_ROM_SIZE / 65536) - 1;
>  #endif
> @@ -280,22 +285,19 @@ static int smbios_write_type1(ulong *current, int h=
andle,
>         memset(t, 0, sizeof(struct smbios_type1));
>         fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->manufacturer =3D smbios_add_prop(ctx, "manufacturer");
> -       if (!t->manufacturer)
> -               t->manufacturer =3D smbios_add_string(ctx, "Unknown");
> -       t->product_name =3D smbios_add_prop(ctx, "product");
> -       if (!t->product_name)
> -               t->product_name =3D smbios_add_string(ctx, "Unknown Produ=
ct");
> +       t->manufacturer =3D smbios_add_prop(ctx, "manufacturer", "Unknown=
");
> +       t->product_name =3D smbios_add_prop(ctx, "product", "Unknown");
>         t->version =3D smbios_add_prop_si(ctx, "version",
> -                                       SYSINFO_ID_SMBIOS_SYSTEM_VERSION)=
;
> +                                       SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
> +                                       "Unknown");
>         if (serial_str) {
> -               t->serial_number =3D smbios_add_string(ctx, serial_str);
> +               t->serial_number =3D smbios_add_prop(ctx, NULL, serial_st=
r);
>                 strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
>         } else {
> -               t->serial_number =3D smbios_add_prop(ctx, "serial");
> +               t->serial_number =3D smbios_add_prop(ctx, "serial", "Unkn=
own");
>         }
> -       t->sku_number =3D smbios_add_prop(ctx, "sku");
> -       t->family =3D smbios_add_prop(ctx, "family");
> +       t->sku_number =3D smbios_add_prop(ctx, "sku", "Unknown");
> +       t->family =3D smbios_add_prop(ctx, "family", "Unknown");
>
>         len =3D t->length + smbios_string_table_len(ctx);
>         *current +=3D len;
> @@ -314,15 +316,12 @@ static int smbios_write_type2(ulong *current, int h=
andle,
>         memset(t, 0, sizeof(struct smbios_type2));
>         fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->manufacturer =3D smbios_add_prop(ctx, "manufacturer");
> -       if (!t->manufacturer)
> -               t->manufacturer =3D smbios_add_string(ctx, "Unknown");
> -       t->product_name =3D smbios_add_prop(ctx, "product");
> -       if (!t->product_name)
> -               t->product_name =3D smbios_add_string(ctx, "Unknown Produ=
ct");
> +       t->manufacturer =3D smbios_add_prop(ctx, "manufacturer", "Unknown=
");
> +       t->product_name =3D smbios_add_prop(ctx, "product", "Unknown");
>         t->version =3D smbios_add_prop_si(ctx, "version",
> -                                       SYSINFO_ID_SMBIOS_BASEBOARD_VERSI=
ON);
> -       t->asset_tag_number =3D smbios_add_prop(ctx, "asset-tag");
> +                                       SYSINFO_ID_SMBIOS_BASEBOARD_VERSI=
ON,
> +                                       "Unknown");
> +       t->asset_tag_number =3D smbios_add_prop(ctx, "asset-tag", "Unknow=
n");
>         t->feature_flags =3D SMBIOS_BOARD_FEATURE_HOSTING;
>         t->board_type =3D SMBIOS_BOARD_MOTHERBOARD;
>
> @@ -343,9 +342,7 @@ static int smbios_write_type3(ulong *current, int han=
dle,
>         memset(t, 0, sizeof(struct smbios_type3));
>         fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
>         smbios_set_eos(ctx, t->eos);
> -       t->manufacturer =3D smbios_add_prop(ctx, "manufacturer");
> -       if (!t->manufacturer)
> -               t->manufacturer =3D smbios_add_string(ctx, "Unknown");
> +       t->manufacturer =3D smbios_add_prop(ctx, "manufacturer", "Unknown=
");
>         t->chassis_type =3D SMBIOS_ENCLOSURE_DESKTOP;
>         t->bootup_state =3D SMBIOS_STATE_SAFE;
>         t->power_supply_state =3D SMBIOS_STATE_SAFE;
> @@ -388,8 +385,8 @@ static void smbios_write_type4_dm(struct smbios_type4=
 *t,
>  #endif
>
>         t->processor_family =3D processor_family;
> -       t->processor_manufacturer =3D smbios_add_string(ctx, vendor);
> -       t->processor_version =3D smbios_add_string(ctx, name);
> +       t->processor_manufacturer =3D smbios_add_prop(ctx, NULL, vendor);
> +       t->processor_version =3D smbios_add_prop(ctx, NULL, name);
>  }
>
>  static int smbios_write_type4(ulong *current, int handle,
> --
> 2.40.1
>
