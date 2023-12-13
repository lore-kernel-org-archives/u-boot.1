Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D4CC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E658C87833;
	Wed, 13 Dec 2023 20:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e8hUQIQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A3087833; Wed, 13 Dec 2023 20:52:25 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 907418783D
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbcd348f64cso898447276.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497136; x=1703101936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RCeIPamFAjjC+zlE7Ekg43qIxBE94hcNmnMMdt3LdNs=;
 b=e8hUQIQBuL+emhA7449NtJK+eiy4dW/oP50dSbTrkEaoGexdH1Fs1NQnCLh4j7r2TX
 jv9dInFjaxQYPogSphpO6kGvwi4dFC19MaKNQ8HWqTom2E5N1fwJkTuD7PrTLbR3dqkh
 7dOd2t/fsyZEgdhJ14RvGIMtLs93/t0k9KXdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497136; x=1703101936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RCeIPamFAjjC+zlE7Ekg43qIxBE94hcNmnMMdt3LdNs=;
 b=Oua3z+Qu7iYfaQhKvF3V+4nlTIqB6e/oR+9gW5GDgb1JPEBcESnQYKHy75HIAvSxKb
 GEOrCJ42i+XFY7w9IKJUXFLNhPTcGj4mRgM5kO5slKCoZl7CJkFFsXR1UrDOjSRlrMl4
 5sPoOp6JekeWOciieu/LCQTIoK0rTijQWNSumColDaVppG6WetIakuDuQ9pAG4458ca7
 JQ4WP6Jqo2BQ0H4Bgll9dEm+rNiBGVO/g+XJrlbCHS8p7qlUS/r6N0/dL8eWOpYLVu09
 NjGJKJ4MnhBU0TtRRxI889T06Ne7ysI6MB5ove/D3CpIGTmb/DWnjh0L1GlhJ1VLtrr5
 kWEA==
X-Gm-Message-State: AOJu0YxmKK+U0Ruy8JUq3FJSZYiPsWXRUM0G1Hp8yioaDgmidbveGwbp
 bu41mmLIDjLnlb+0rrarTrGu//K1IexRfC73t03wcA==
X-Google-Smtp-Source: AGHT+IFQTUKLtcpigHnj1F2aWjk6tIM1gVLz4JQztv3t0Xq3iR+yvnAYgxCZ9oETf0C0HCXzii+1sMWSk9tIIbSy4qE=
X-Received: by 2002:a05:6902:89:b0:da0:3535:41f4 with SMTP id
 h9-20020a056902008900b00da0353541f4mr5824458ybs.7.1702497135959; Wed, 13 Dec
 2023 11:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
In-Reply-To: <20231207091850.17776-3-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:51:33 -0700
Message-ID: <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
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

Can we add a Kconfig to enable this?

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
> @@ -124,6 +158,42 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
>         }
>  }
>
> +/**
> + * get_str_from_dt - Get a substring from a DT property.
> + *                   After finding the property in the DT, the function
> + *                   will parse comma-separated values and return the value.
> + *                   If nprop->max exceeds the number of comma-separated
> + *                   elements, the last non NULL value will be returned.
> + *                   Counting starts from zero.
> + *
> + * @nprop: sysinfo property to use
> + * @str: pointer to fill with data
> + * @size: str buffer length

must be >0

> + */
> +static
> +void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_t size)
> +{
> +       const char *dt_str;
> +       int cnt = 0;
> +       char *token;
> +
> +       memset(str, 0, size);

*str = '\0' should be enough, assuming size is not 0

> +       if (!nprop || !nprop->max)
> +               return;
> +
> +       dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);
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
> @@ -137,6 +207,8 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
>  static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
>                               int sysinfo_id, const char *dval)
>  {
> +       int ret;
> +
>         if (!dval || !*dval)
>                 dval = "Unknown";
>
> @@ -145,18 +217,30 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
>
>         if (sysinfo_id && ctx->dev) {
>                 char val[SMBIOS_STR_MAX];
> -               int ret;
>
>                 ret = sysinfo_get_str(ctx->dev, sysinfo_id, sizeof(val), val);
>                 if (!ret)
>                         return smbios_add_string(ctx, val);
>         }
>         if (IS_ENABLED(CONFIG_OF_CONTROL)) {
> -               const char *str;
> -
> -               str = ofnode_read_string(ctx->node, prop);
> +               const char *str = NULL;
> +               char str_dt[128] = { 0 };
> +               /*
> +                * If the node is not valid fallback and try the entire DT

s/and/then/ ?

> +                * so we can at least fill in manufacturer and board type
> +                */
> +               if (ofnode_valid(ctx->node)) {
> +                       str = ofnode_read_string(ctx->node, prop);
> +               } else {
> +                       const struct map_sysinfo *nprop;
> +
> +                       nprop = convert_sysinfo_to_dt(prop);
> +                       get_str_from_dt(nprop, str_dt, sizeof(str_dt));
> +                       str = (const char *)str_dt;

can't you drop the case?

> +               }
>
> -               return smbios_add_string(ctx, str ? str : dval);
> +               ret = smbios_add_string(ctx, str && *str ? str : dval);
> +               return ret;
>         }
>
>         return 0;
> --
> 2.40.1
>

Regards,
Simon
