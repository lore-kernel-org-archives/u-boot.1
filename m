Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51286C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559218715C;
	Thu, 30 Nov 2023 03:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XgXtCSGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C67E875CC; Thu, 30 Nov 2023 03:45:53 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDAE86EF6
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-548f853fc9eso319186a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312350; x=1701917150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fa0nDSR3kb/XK9NJ/gfR482nAz4SBeDyRY+gUF2tx/0=;
 b=XgXtCSGqozuMS5jQToVPo/aIiPAo0BTJDmXuet6q+Qk4zr/OqDy8vMbuNcgXQc22f5
 H0mo46o8F6WbnUCpaQAnUXtvJff8CRitTAeSGwjwy9sUPalZBfzGMeycE+rskBQScfuK
 A/dtuXyLu4TUxykRJRozvzA1OeO0QywDFsL8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312350; x=1701917150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fa0nDSR3kb/XK9NJ/gfR482nAz4SBeDyRY+gUF2tx/0=;
 b=FZC25etjhwA7sn1LMgxGLnHgp1M8vgWIKHBk4kO3rQiz27dS50nD33m5MZSBh81zKn
 JMYRQ2Dz5E3KFF/zZD+VMqVP1NW7PeP5DNc2Uvk4PUFc5Z9/H7L3hJ3CjwcL9Htqtdbe
 Rbn27GwBCulXjM7nf43aNNTIxNIE4wm5+vpBCCbDCWuVpxntlYGSeEmI4WsT4BhW/7hZ
 rqHBgF+BxA3b1SkfrGYBayel6QeJmTh6mh/vL7x+AvOtV+bK7voJyB7JSaIajk97vZp8
 rWy6c/4FBqxf1P1nrS2N5qv18EibneCWOvYRPVoS6Mr9UswSi4PUfg8ocHhZW5YtxsMZ
 p1NA==
X-Gm-Message-State: AOJu0YyIJz91crz3KFR6r4K1QAoS8FUkp5HDdOVbgvwtEJo0wSOWtdez
 /r3Pf/jBSdzYWU/PJINyMEr5tvuX8lIXluuZuhmvlg==
X-Google-Smtp-Source: AGHT+IFhdDRRm+4g8nZTwWRYxCVdAg111KG/184Fkc8WpE8Vd4Bbl6m6EtxzsTws7o5uwwoBdDm1lTyjJ/oGKI/6Ioo=
X-Received: by 2002:a17:906:1281:b0:9dd:7133:881 with SMTP id
 k1-20020a170906128100b009dd71330881mr13045843ejb.40.1701312349891; Wed, 29
 Nov 2023 18:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
In-Reply-To: <20231127171058.165777-3-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:25 -0700
Message-ID: <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
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
> ---
> Changes since v1:
> - Tokenize the DT node entry and use the appropriate value instead of
>   the entire string
> - Removed Peters tested/reviewed-by tags due to the above
>  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 90 insertions(+), 4 deletions(-)
>

Can this be put behind a Kconfig? It adds quite a bit of code which
punishes those boards which do the right thing.


> diff --git a/lib/smbios.c b/lib/smbios.c
> index fcc8686993ef..423893639ff0 100644
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
> + * @max: Max index of the tokenized string to pick. Counting starts from 0
> + *
> + */
> +struct map_sysinfo {
> +       const char *sysinfo_str;
> +       const char *dt_str;
> +       int max;
> +};
> +
> +static const struct map_sysinfo sysinfo_to_dt[] = {
> +       { .sysinfo_str = "product", .dt_str = "model", 2 },
> +       { .sysinfo_str = "manufacturer", .dt_str = "compatible", 1 },
> +};
> +
>  /**
>   * struct smbios_ctx - context for writing SMBIOS tables
>   *
> @@ -87,6 +109,18 @@ struct smbios_write_method {
>         const char *subnode_name;
>  };
>
> +static const struct map_sysinfo *convert_sysinfo_to_dt(const char *sysinfo_str)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(sysinfo_to_dt); i++) {
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
> @@ -127,6 +161,42 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
>         }
>  }
>
> +/**
> + * get_str_from_dt - Get a substring from a DT property.
> + *                   After finding the property in the DT, the function
> + *                   will parse comma separted values and return the value.

spelling

> + *                   If nprop->max exceeds the number of comma separated

comma-separated

> + *                   elements the last non NULL value will be returned.

elements, the

> + *                   Counting starts from zero.
> + *
> + * @nprop: sysinfo property to use
> + * @str: pointer to fill with data
> + * @size: str buffer length
> + */
> +static
> +void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_t size)
> +{
> +       const char *dt_str;
> +       int cnt = 0;
> +       char *token;
> +
> +       memset(str, 0, size);
> +       if (!nprop || !nprop->max)
> +               return;
> +
> +       dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);

Could this use ofnode_read_string_index() ?

> +       if (!dt_str)
> +               return;
> +
> +       memcpy(str, dt_str, size);
> +       token = strtok(str, ",");
> +       while (token && cnt < nprop->max) {
> +               strlcpy(str, token, strlen(token) + 1);
> +               token = strtok(NULL, ",");
> +               cnt++;
> +       }
> +}
> +
>  /**
>   * smbios_add_prop_si() - Add a property from the devicetree or sysinfo
>   *
> @@ -139,19 +209,35 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
>  static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
>                               int sysinfo_id)
>  {
> +       int ret = 0;
> +
>         if (sysinfo_id && ctx->dev) {
>                 char val[SMBIOS_STR_MAX];
> -               int ret;
>
>                 ret = sysinfo_get_str(ctx->dev, sysinfo_id, sizeof(val), val);
>                 if (!ret)
>                         return smbios_add_string(ctx, val);
>         }
> +
>         if (IS_ENABLED(CONFIG_OF_CONTROL)) {
> -               const char *str;
> +               const char *str = NULL;
> +               char str_dt[128] = { 0 };
> +               /*
> +                * If the node is not valid fallback and try the entire DT
> +                * so we can at least fill in maufacturer and board type

spelling

> +                */
> +               if (ofnode_valid(ctx->node)) {
> +                       str = ofnode_read_string(ctx->node, prop);
> +               } else {
> +                       const struct map_sysinfo *nprop;
> +
> +                       nprop = convert_sysinfo_to_dt(prop);
> +                       get_str_from_dt(nprop, str_dt, sizeof(str_dt));
> +               }
>
> -               str = ofnode_read_string(ctx->node, prop);
> -               return smbios_add_string(ctx, str);
> +               ret = smbios_add_string(ctx, ofnode_valid(ctx->node) ?
> +                                       str : (const char *)str_dt);
> +               return ret;
>         }
>
>         return 0;
> --
> 2.40.1
>

Any chance of a test for this code?

Regards,
Simon
