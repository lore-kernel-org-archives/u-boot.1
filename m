Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01509C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 11:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1DBB87630;
	Sat,  9 Dec 2023 12:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g6HaJtlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E98B587630; Sat,  9 Dec 2023 12:45:32 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B6C8757F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 12:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54dcfca54e0so3554684a12.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 03:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702122330; x=1702727130; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAaUZhJN0TgXiU3BpM54tDosoRqLceuhxD7CM5U2QoA=;
 b=g6HaJtlwdNo22WViZNjzsX6T5pWl7fJ83VdBuSnfnB0WHZg6HxwP5ZMLUIWXkfzLzd
 wXXe++oNbR7k/6vCzyrTGOP8KYO0zKn4UnfMH/XkHXZX0sPe/sCbnmGrFQ3YJU8BCMtP
 dPPl9AuHG0vUTMH96bnlDu3p1mVngwpIF8fSfitMzZ9MeM5zfGK+Nyh5GbEz685bF2dL
 Aj7UiCarqBpC4vpPc55ptGopIe8MXb/Na4NSkJItQM/BC5DrD0fEeqntKtMGNR9dv5Bh
 eBtO61dtOojaH7msKPB56r62l+2xUroI4zW8xO+OquFxKTvfBdRgxAgnmo+LSorospQu
 g4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702122330; x=1702727130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAaUZhJN0TgXiU3BpM54tDosoRqLceuhxD7CM5U2QoA=;
 b=svnP0qF8DpfxskZIdO4CZjtR7FtvMZtf4n/SCyRl6099zK3CskCnJ4rJuueIrv32eU
 CYg1c5FXWnsmEsce90DmamBJkruFDfLpXhNgapFODPTelMuFIfWbYnj+lXvN6vdgpB7p
 y5di03c0AkSPeffNgdY7y2yvsA/2rn+7xsYqQvaxUX6THeLZef4QV4dAQTnS06XOpcNM
 yTpnQ4Q6P7vgY6ktGuxEbAglYH91nV4yM6+EGuV+W0xjbZLfOPNLWAlmGRP8OrLXlTUA
 LajSL5iaMREnnrDCKbEKeZZMpzEkskETBevULjNoDv6pq+zHJSq4azPbvk45Y5IDfVvt
 07oQ==
X-Gm-Message-State: AOJu0YwdY4YJu1TvuaYnK6WgJyY7AIhUzRhZveWabzW81OcOSP5B3qiI
 Vd3tHfIbSbT27XoOObRwD7D6tDtfY21mYweoG4U=
X-Google-Smtp-Source: AGHT+IGkm/YO5OSLBLqL+ndBGsmQx62a36qwtTGwtwpmGWLHqS2E9AfkAh+FXGQkTE+bAvwn7b+YfXn3jMe96OnVjPY=
X-Received: by 2002:a05:6402:2152:b0:54c:7994:ac02 with SMTP id
 bq18-20020a056402215200b0054c7994ac02mr937704edb.33.1702122329961; Sat, 09
 Dec 2023 03:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
In-Reply-To: <20231207091850.17776-3-ilias.apalodimas@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 9 Dec 2023 11:45:18 +0000
Message-ID: <CALeDE9O9u_y+t5eM=fiNn70hENRSNN_X9BTpsJkwEdegNMDvGA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
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

On Thu, Dec 7, 2023 at 12:57=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> In order to fill in the SMBIOS tables U-Boot currently relies on a
> "u-boot,sysinfo-smbios" compatible node.  This is fine for the boards
> that already include such nodes.  However with some recent EFI changes,
> the majority of boards can boot up distros, which usually rely on
> things like dmidecode etc for their reporting.  For boards that
> lack this special node the SMBIOS output looks like:
>
> System Information
>         Manufacturer: Unknown
>         Product Name: Unknown
>         Version: Unknown
>         Serial Number: Unknown
>         UUID: Not Settable
>         Wake-up Type: Reserved
>         SKU Number: Unknown
>         Family: Unknown
>
> This looks problematic since most of the info are "Unknown".  The DT spec
> specifies standard properties containing relevant information like
> 'model' and 'compatible' for which the suggested format is
> <manufacturer,model>. Unfortunately the 'model' string found in DTs is
> usually lacking the manufacturer so we can't use it for both
> 'Manufacturer' and 'Product Name' SMBIOS entries reliably.
>
> So let's add a last resort to our current smbios parsing.  If none of
> the sysinfo properties are found, scan for those information in the
> root node of the device tree. Use the 'model' to fill the 'Product
> Name' and the first value of 'compatible' for the 'Manufacturer', since
> that always contains one.
>
> pre-patch:
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Unknown
>         Product Name: Unknown
>         Version: Unknown
>         Serial Number: 100000000bb24ceb
>         UUID: 30303031-3030-3030-3061-613234636435
>         Wake-up Type: Reserved
>         SKU Number: Unknown
>         Family: Unknown
> [...]
>
> and post patch:
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: raspberrypi
>         Product Name: Raspberry Pi 4 Model B Rev 1.1
>         Version: Unknown
>         Serial Number: 100000000bb24ceb
>         UUID: 30303031-3030-3030-3061-613234636435
>         Wake-up Type: Reserved
>         SKU Number: Unknown
>         Family: Unknown
> [...]
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> Simon, I'll work with tou on the refactoring you wanted and
> remove the EFI requirement of SMBIOS in !x86 platforms.
> Since this code has no tests, I'll add some once the refactoring
> is done
>
> Changes since v2:
> - Spelling mistakes
> - rebase on top of patch #1 changes
> Changes since v1:
> - Tokenize the DT node entry and use the appropriate value instead of
>   the entire string
> - Removed Peters tested/reviewed-by tags due to the above
>  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 89 insertions(+), 5 deletions(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 444aa245a273..3f0e1d529537 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -9,11 +9,14 @@
>  #include <dm.h>
>  #include <env.h>
>  #include <linux/stringify.h>
> +#include <linux/string.h>
>  #include <mapmem.h>
>  #include <smbios.h>
>  #include <sysinfo.h>
>  #include <tables_csum.h>
>  #include <version.h>
> +#include <malloc.h>
> +#include <dm/ofnode.h>
>  #ifdef CONFIG_CPU
>  #include <cpu.h>
>  #include <dm/uclass-internal.h>
> @@ -43,6 +46,25 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +/**
> + * struct map_sysinfo - Mapping of sysinfo strings to DT
> + *
> + * @sysinfo_str: sysinfo string
> + * @dt_str: DT string
> + * @max: Max index of the tokenized string to pick. Counting starts from=
 0
> + *
> + */
> +struct map_sysinfo {
> +       const char *sysinfo_str;
> +       const char *dt_str;
> +       int max;
> +};
> +
> +static const struct map_sysinfo sysinfo_to_dt[] =3D {
> +       { .sysinfo_str =3D "product", .dt_str =3D "model", 2 },
> +       { .sysinfo_str =3D "manufacturer", .dt_str =3D "compatible", 1 },
> +};
> +
>  /**
>   * struct smbios_ctx - context for writing SMBIOS tables
>   *
> @@ -87,6 +109,18 @@ struct smbios_write_method {
>         const char *subnode_name;
>  };
>
> +static const struct map_sysinfo *convert_sysinfo_to_dt(const char *sysin=
fo_str)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(sysinfo_to_dt); i++) {
> +               if (!strcmp(sysinfo_str, sysinfo_to_dt[i].sysinfo_str))
> +                       return &sysinfo_to_dt[i];
> +       }
> +
> +       return NULL;
> +}
> +
>  /**
>   * smbios_add_string() - add a string to the string area
>   *
> @@ -124,6 +158,42 @@ static int smbios_add_string(struct smbios_ctx *ctx,=
 const char *str)
>         }
>  }
>
> +/**
> + * get_str_from_dt - Get a substring from a DT property.
> + *                   After finding the property in the DT, the function
> + *                   will parse comma-separated values and return the va=
lue.
> + *                   If nprop->max exceeds the number of comma-separated
> + *                   elements, the last non NULL value will be returned.
> + *                   Counting starts from zero.
> + *
> + * @nprop: sysinfo property to use
> + * @str: pointer to fill with data
> + * @size: str buffer length
> + */
> +static
> +void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_t =
size)
> +{
> +       const char *dt_str;
> +       int cnt =3D 0;
> +       char *token;
> +
> +       memset(str, 0, size);
> +       if (!nprop || !nprop->max)
> +               return;
> +
> +       dt_str =3D ofnode_read_string(ofnode_root(), nprop->dt_str);
> +       if (!dt_str)
> +               return;
> +
> +       memcpy(str, dt_str, size);
> +       token =3D strtok(str, ",");
> +       while (token && cnt < nprop->max) {
> +               strlcpy(str, token, strlen(token) + 1);
> +               token =3D strtok(NULL, ",");
> +               cnt++;
> +       }
> +}
> +
>  /**
>   * smbios_add_prop_si() - Add a property from the devicetree or sysinfo
>   *
> @@ -137,6 +207,8 @@ static int smbios_add_string(struct smbios_ctx *ctx, =
const char *str)
>  static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
>                               int sysinfo_id, const char *dval)
>  {
> +       int ret;
> +
>         if (!dval || !*dval)
>                 dval =3D "Unknown";
>
> @@ -145,18 +217,30 @@ static int smbios_add_prop_si(struct smbios_ctx *ct=
x, const char *prop,
>
>         if (sysinfo_id && ctx->dev) {
>                 char val[SMBIOS_STR_MAX];
> -               int ret;
>
>                 ret =3D sysinfo_get_str(ctx->dev, sysinfo_id, sizeof(val)=
, val);
>                 if (!ret)
>                         return smbios_add_string(ctx, val);
>         }
>         if (IS_ENABLED(CONFIG_OF_CONTROL)) {
> -               const char *str;
> -
> -               str =3D ofnode_read_string(ctx->node, prop);
> +               const char *str =3D NULL;
> +               char str_dt[128] =3D { 0 };
> +               /*
> +                * If the node is not valid fallback and try the entire D=
T
> +                * so we can at least fill in manufacturer and board type
> +                */
> +               if (ofnode_valid(ctx->node)) {
> +                       str =3D ofnode_read_string(ctx->node, prop);
> +               } else {
> +                       const struct map_sysinfo *nprop;
> +
> +                       nprop =3D convert_sysinfo_to_dt(prop);
> +                       get_str_from_dt(nprop, str_dt, sizeof(str_dt));
> +                       str =3D (const char *)str_dt;
> +               }
>
> -               return smbios_add_string(ctx, str ? str : dval);
> +               ret =3D smbios_add_string(ctx, str && *str ? str : dval);
> +               return ret;
>         }
>
>         return 0;
> --
> 2.40.1
>
