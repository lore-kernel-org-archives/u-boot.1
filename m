Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEB0C83F27
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9BE88C33;
	Thu, 29 Aug 2024 16:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bsJIyQcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C848A88C6F; Thu, 29 Aug 2024 16:05:40 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0199988C20
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-201e52ca0caso4547835ad.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940336; x=1725545136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MxiP2Q6LqBqVvGT0X4PpqLgJqLesUEPbDzg+57mUG6c=;
 b=bsJIyQcLQLMhrycVo8ebf5SX3+CiozglDNElRSvBrXscX/BS2jAjPXNJqL0bKlJERS
 5UIhD4vh28W91B/tEG/WGXpFXzB/6m3ogyW9MTaAxpa37XCVnCogzJCjpOC9TNj46HUj
 P/XhVW7qPFBoQT0ZzanRfIrHdG4IvxtY9YNSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940336; x=1725545136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MxiP2Q6LqBqVvGT0X4PpqLgJqLesUEPbDzg+57mUG6c=;
 b=O+yFRH4yKq3Vtut5k+hnIjDeUTvHulqcyjAIqMEK6qkydYFRpsO1orG2V1ToMiL6UT
 suxyKnZwMSTFsh+s9FK+48VYzex2KRbmujRWGb9uSgGqZO6tep4SxG3UTrLpBMPGrTVo
 sUfc5u3lMATaPwDoIvIXF3jXsly3tMiHTbeXNQb+NyDIqzju4ZQ8O9hPKjGJeHadQNx5
 SXTa5XFB0EZzbw7UWa3nN9VfBV8NWwx9+6k0Dwpi7JClm7ApyVtRskNdqUh50vFWpVnC
 9ZKICgn9J5/zKGMJeTfFiN6+n1k9WtPO/MOEtAEway0USGeUto7euZ/AOpi+thfLN9Lq
 ZoMw==
X-Gm-Message-State: AOJu0Yw9CN7iUDAp+4/Gau7VdfwYNHo5h6O6HPyNouKBUflIDfWbfByh
 2vp424K/eH8gXpUjl7D6JegTlNW68zNIWs71OkiBIKsBOn+10uctpSBglmQPx2jHyDo1CWmp/L2
 0ljmpLqo5R9ZvfGhMoo1Wk0yrkBrf+9x+7IO5
X-Google-Smtp-Source: AGHT+IFaJPY/nxioQboV4Du3rJ/kzaiA9IZMIilI9VMvkXQrMn5xT1EK4fWmF0x0cknjKh1bkJdMOu4vjGfQWQyzovA=
X-Received: by 2002:a05:6a20:2a18:b0:1cc:e5eb:e91f with SMTP id
 adf61e73a8af0-1cce5ebe9b2mr1156202637.1.1724940336233; Thu, 29 Aug 2024
 07:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240826125111.1332215-1-lukas.funke-oss@weidmueller.com>
 <20240826125111.1332215-2-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20240826125111.1332215-2-lukas.funke-oss@weidmueller.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:04:59 -0600
Message-ID: <CAFLszTjkQ3eaNYmjXW1dcQSCtS2odWC1yGFGcNPqFBpgtcHdLw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] env: introduce variable ranges
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mario Six <mario.six@gdsys.cc>, Sean Anderson <seanga2@gmail.com>,
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

Hi,

On Mon, 26 Aug 2024 at 06:51, <lukas.funke-oss@weidmueller.com> wrote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> This commit extends the flags-variable with ranges for environment
> variables. The range is appended to the variable flags using
> the '@'-character. A range can be decimal (min/max), bitmask or regular
> expression (64 byte).
>
> Value ranges for variables can be used to make the environment more
> robust against faults such as invalid user input or attacks.
>
> Decimal-range:  foo:da@<min>-<max>
> Hexadecimal-range(bitmask): bar:xa@0xdeadbeed
> Regex-range: mystring:sa@r"klaus|haus|maus"
>
> Example:
>
>         "decimalvalue:dw@100-200,"
>     ...
>
> => env set decimalvalue 1
> 1 < 100 || 1 > 200
> => env set decimalvalue 150
> =>
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
>  cmd/nvedit.c              |  30 +++---
>  env/flags.c               | 217 +++++++++++++++++++++++++++++++++++++-
>  include/configs/sandbox.h |   5 +
>  include/env_flags.h       |  27 ++++-
>  include/search.h          |   1 +
>  test/env/Makefile         |   1 +
>  test/env/range.c          | 113 ++++++++++++++++++++
>  7 files changed, 377 insertions(+), 17 deletions(-)
>  create mode 100644 test/env/range.c

Can you put this behind a Kconfig? We should avoid the code-size
increase for existing boards.

Also please add doc/

Unfortunately I have a lot of minor comments about this patch, partly
due to the existing env code.

>
> diff --git a/cmd/nvedit.c b/cmd/nvedit.c
> index 98a687bcabb..f02545c7a55 100644
> --- a/cmd/nvedit.c
> +++ b/cmd/nvedit.c
> @@ -352,10 +352,13 @@ static int print_static_flags(const char *var_name, const char *flags,
>  {
>         enum env_flags_vartype type = env_flags_parse_vartype(flags);
>         enum env_flags_varaccess access = env_flags_parse_varaccess(flags);
> +       struct env_flags_range *range = env_flags_parse_varrange(flags);
>
> -       printf("\t%-20s %-20s %-20s\n", var_name,
> +       printf("\t%-20s %-20s %-20s %-20s\n", var_name,
>                 env_flags_get_vartype_name(type),
> -               env_flags_get_varaccess_name(access));
> +               env_flags_get_varaccess_name(access),
> +               env_flags_get_varrange_name(range, type));

This is too long. Perhaps we need to rename the env_flags_get_...
functions to envf_get_...

> +       free(range);
>
>         return 0;
>  }
> @@ -364,6 +367,7 @@ static int print_active_flags(struct env_entry *entry)
>  {
>         enum env_flags_vartype type;
>         enum env_flags_varaccess access;
> +       struct env_flags_range *range;
>
>         if (entry->flags == 0)
>                 return 0;
> @@ -371,9 +375,11 @@ static int print_active_flags(struct env_entry *entry)
>         type = (enum env_flags_vartype)
>                 (entry->flags & ENV_FLAGS_VARTYPE_BIN_MASK);
>         access = env_flags_parse_varaccess_from_binflags(entry->flags);
> -       printf("\t%-20s %-20s %-20s\n", entry->key,
> +       range = (struct env_flags_range *)entry->range;
> +       printf("\t%-20s %-20s %-20s %-20s\n", entry->key,
>                 env_flags_get_vartype_name(type),
> -               env_flags_get_varaccess_name(access));
> +               env_flags_get_varaccess_name(access),
> +               env_flags_get_varrange_name(range, type));
>
>         return 0;
>  }
> @@ -401,19 +407,19 @@ int do_env_flags(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>
>         /* Print the static flags that may exist */
>         puts("Static flags:\n");
> -       printf("\t%-20s %-20s %-20s\n", "Variable Name", "Variable Type",
> -               "Variable Access");
> -       printf("\t%-20s %-20s %-20s\n", "-------------", "-------------",
> -               "---------------");
> +       printf("\t%-20s %-20s %-20s %-20s\n", "Variable Name", "Variable Type",
> +               "Variable Access", "Variable Range");
> +       printf("\t%-20s %-20s %-20s %-20s\n", "-------------", "-------------",
> +               "---------------", "---------------");
>         env_attr_walk(ENV_FLAGS_LIST_STATIC, print_static_flags, NULL);
>         puts("\n");
>
>         /* walk through each variable and print the flags if non-default */
>         puts("Active flags:\n");
> -       printf("\t%-20s %-20s %-20s\n", "Variable Name", "Variable Type",
> -               "Variable Access");
> -       printf("\t%-20s %-20s %-20s\n", "-------------", "-------------",
> -               "---------------");
> +       printf("\t%-20s %-20s %-20s %-20s\n", "Variable Name", "Variable Type",
> +               "Variable Access", "Variable Range");
> +       printf("\t%-20s %-20s %-20s %-20s\n", "-------------", "-------------",
> +               "---------------", "---------------");
>         hwalk_r(&env_htab, print_active_flags);
>         return 0;
>  }
> diff --git a/env/flags.c b/env/flags.c
> index 233fd460d84..dc0a9c5764f 100644
> --- a/env/flags.c
> +++ b/env/flags.c
> @@ -20,6 +20,9 @@
>  #else
>  #include <linux/kernel.h>
>  #include <env_internal.h>
> +#include <vsprintf.h>
> +#include <malloc.h>
> +#include <slre.h>

Please check include ordering.

>  #endif
>
>  #ifdef CONFIG_NET
> @@ -34,6 +37,8 @@
>  #define ENV_FLAGS_WRITEABLE_VARACCESS_REPS ""
>  #endif
>
> +#define ENV_FLAGS_RANGE_SEPERATOR '@'

Too long... how about ENVF_RANGE_SEP ?

> +
>  static const char env_flags_vartype_rep[] = "sdxb" ENV_FLAGS_NET_VARTYPE_REPS;
>  static const char env_flags_varaccess_rep[] =
>         "aroc" ENV_FLAGS_WRITEABLE_VARACCESS_REPS;
> @@ -115,6 +120,35 @@ const char *env_flags_get_varaccess_name(enum env_flags_varaccess access)
>  {
>         return env_flags_varaccess_names[access];
>  }
> +
> +const char *env_flags_get_varrange_name(struct env_flags_range *range,
> +                                       enum env_flags_vartype type)
> +{
> +       static char range_str[64];

Eek, best to avoid statics. How about the caller passes in the buffer?

> +
> +       if (!range)
> +               return "";
> +
> +       switch (type) {
> +       case env_flags_vartype_decimal: {
> +               snprintf(range_str, sizeof(range_str), "%lld-%lld",
> +                        range->u.int_range.min, range->u.int_range.max);
> +               break;
> +       }

Please drop {} around these

> +       case env_flags_vartype_hex: {
> +               snprintf(range_str, sizeof(range_str), "0x%llx", range->u.bitmask);

"%#llx"

Do we really want 64-bit values?

Also see simple_xtoa(), simple_itoa()

> +               break;
> +       }
> +       case env_flags_vartype_string: {
> +               strlcpy(range_str, range->u.re, sizeof(range_str));
> +               break;
> +       }
> +       default:
> +               return "";
> +       }
> +
> +       return range_str;
> +}
>  #endif /* CONFIG_CMD_ENV_FLAGS */
>
>  /*
> @@ -151,6 +185,9 @@ enum env_flags_varaccess env_flags_parse_varaccess(const char *flags)
>         if (strlen(flags) <= ENV_FLAGS_VARACCESS_LOC)
>                 return va_default;
>
> +       if (flags[ENV_FLAGS_VARACCESS_LOC] == ENV_FLAGS_RANGE_SEPERATOR)
> +               return va_default;
> +
>         access = strchr(env_flags_varaccess_rep,
>                 flags[ENV_FLAGS_VARACCESS_LOC]);
>
> @@ -211,6 +248,138 @@ static void skip_num(int hex, const char *value, const char **end,
>                 *end = value;
>  }
>
> +struct env_flags_range *env_flags_parse_varrange(const char *flags)
> +{
> +       char *range;
> +       struct env_flags_range *r;
> +       enum env_flags_vartype type;
> +
> +       if (!flags)
> +               return NULL;
> +
> +       range = strchr(flags, ENV_FLAGS_RANGE_SEPERATOR);
> +       if (!range)
> +               return NULL;
> +
> +       range++;
> +
> +       r = (struct env_flags_range *)malloc(sizeof(struct env_flags_range));
> +       if (!r)
> +               return NULL;

Isn't that an error?

> +
> +       type = env_flags_parse_vartype(flags);
> +
> +       /* parse regex range r"someregex" */
> +       if (!strncmp(range, "r\"", 2)) {
> +               if (IS_ENABLED(CONFIG_REGEX)) {
> +                       if (type != env_flags_vartype_string) {
> +                               free(r);
> +                               return NULL;
> +                       }
> +
> +                       char *rstart = strchr(range, '"');
> +                       char *rend = strrchr(range, '"');
> +
> +                       memset(r->u.re, 0, sizeof(r->u.re));
> +
> +                       if (rstart == rend) /* invalid format r" */
> +                               return NULL;
> +
> +                       rstart++;
> +                       if (rstart == rend) /* empty regex is okay */
> +                               return r;
> +
> +                       if ((rend - rstart) < sizeof(r->u.re))
> +                               strlcpy(r->u.re, rstart, rend - rstart);
> +                       else
> +                               return NULL; /* too big */
> +               }
> +       } else if (is_hex_prefix(range)) {
> +               /* parse bitmask range 0x[a-fA-F0-9]+ */
> +               if (type != env_flags_vartype_hex) {
> +                       free(r);
> +                       return NULL;
> +               }
> +               r->u.bitmask = (u64)simple_strtol(range, NULL, 16);
> +       } else {
> +               /* parse integer range [0-9]+-[0-9]+ */
> +               s64 min, max;

This supports a signed range, but might someone want unsigned?

> +
> +               if (type != env_flags_vartype_decimal) {
> +                       free(r);
> +                       return NULL;
> +               }
> +
> +               char *lhs = strcpy(r->u.re, range); /* exploit regex buffer */
> +               char *rhs = strchr(lhs[0] == '-' ? lhs + 1 : lhs, '-');
> +
> +               if (!rhs) {
> +                       free(r);
> +                       return NULL;
> +               }
> +
> +               *rhs++ = '\0';
> +               min = simple_strtol(lhs, NULL, 10);
> +               max = simple_strtol(rhs, NULL, 10);
> +               r->u.int_range.min = min;
> +               r->u.int_range.max = max;
> +       }
> +
> +       return r;
> +}

In general, this function should likely return an error code, with r
returned as a pointer argument.

> +
> +static int _env_flags_validate_range(const struct env_flags_range *range,
> +                                    enum env_flags_vartype type,
> +                                    const char *newval)
> +{
> +       if (!range)
> +               return -1;
> +
> +       switch (type) {
> +       case env_flags_vartype_decimal: {
> +               s64 value = simple_strtol(newval, NULL, 10);
> +               s64 min = range->u.int_range.min;
> +               s64 max = range->u.int_range.max;
> +
> +               if (value < min || value > max) {
> +                       printf("## Error: value out of bounds\n"
> +                               "%lld < %lld || %lld > %lld\n", value, min, value, max);
> +                       return -1;
> +               }
> +               break;
> +       }
> +       case env_flags_vartype_hex: {
> +               u64 value = (u64)simple_strtoll(newval, NULL, 16);
> +               u64 mask = range->u.bitmask;
> +
> +               if ((value | mask) != mask) {
> +                       printf("## Error: value out of bounds\n"
> +                               "value = 0x%llx, mask 0x%llx\n", value, mask);
> +                       return -1;
> +               }
> +               break;
> +       }
> +       case env_flags_vartype_string: {
> +#if defined(CONFIG_REGEX)

Can you use: if IS_ENABLED() ?

> +               struct slre slre;
> +
> +               if (slre_compile(&slre, range->u.re)) {
> +                       if (slre_match(&slre, newval, strlen(newval), NULL) == 0) {
> +                               printf("## Error: value does not match regex\n"
> +                                      "value = %s, re = %s\n", newval, range->u.re);
> +                               return -1;
> +                       }
> +               }
> +#endif
> +               break;
> +       }
> +       default:
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_NET
>  int eth_validate_ethaddr_str(const char *addr)
>  {
> @@ -241,7 +410,7 @@ int eth_validate_ethaddr_str(const char *addr)
>   * with that format
>   */
>  static int _env_flags_validate_type(const char *value,
> -       enum env_flags_vartype type)
> +                                   enum env_flags_vartype type)
>  {
>         const char *end;
>  #ifdef CONFIG_NET
> @@ -360,6 +529,20 @@ enum env_flags_varaccess env_flags_get_varaccess(const char *name)
>         return env_flags_parse_varaccess(flags);
>  }
>
> +/*
> + * Look up the range of a variable directly from the .flags var.

Needs a proper comment...what does it return?

> + */
> +struct env_flags_range *env_flags_get_range(const char *name)
> +{
> +       const char *flags_list = env_get(ENV_FLAGS_VAR);
> +       char flags[ENV_FLAGS_ATTR_MAX_LEN + 1];
> +
> +       if (env_flags_lookup(flags_list, name, flags))
> +               return NULL;
> +
> +       return env_flags_parse_varrange(flags);
> +}
> +
>  /*
>   * Validate that the proposed new value for "name" is valid according to the
>   * defined flags for that variable, if any.
> @@ -395,6 +578,25 @@ int env_flags_validate_varaccess(const char *name, int check_mask)
>         return (check_mask & access_mask) != 0;
>  }
>
> +/*
> + * Validate that the variable "name" is valid according to
> + * the defined range for that variable, if any.

same

> + */
> +int env_flags_validate_range(const char *name, const char *newval)
> +{
> +       int r;
> +       enum env_flags_vartype type;
> +       struct env_flags_range *range;
> +
> +       type = env_flags_get_type(name);
> +       range = env_flags_get_range(name);
> +
> +       r = _env_flags_validate_range(range, type, newval);
> +
> +       free(range);
> +       return r;
> +}
> +
>  /*
>   * Validate the parameters to "env set" directly
>   */
> @@ -460,8 +662,10 @@ void env_flags_init(struct env_entry *var_entry)
>         ret = env_flags_lookup(flags_list, var_name, flags);
>
>         /* if any flags were found, set the binary form to the entry */
> -       if (!ret && strlen(flags))
> +       if (!ret && strlen(flags)) {
>                 var_entry->flags = env_parse_flags_to_bin(flags);
> +               var_entry->range = env_flags_parse_varrange(flags);

error handling?

> +       }
>  }
>
>  /*
> @@ -489,11 +693,13 @@ static int set_flags(const char *name, const char *value, void *priv)
>         /* does the env variable actually exist? */
>         if (ep != NULL) {
>                 /* the flag list is empty, so clear the flags */
> -               if (value == NULL || strlen(value) == 0)
> +               if (value == NULL || strlen(value) == 0) {

Should be: if !value || !strlen(value)

or even !value || !*value to maybe save code space

>                         ep->flags = 0;
> -               else
> +               } else {
>                         /* assign the requested flags */
>                         ep->flags = env_parse_flags_to_bin(value);
> +                       ep->range = env_flags_parse_varrange(value);
> +               }
>         }
>
>         return 0;
> @@ -547,6 +753,9 @@ int env_flags_validate(const struct env_entry *item, const char *newval,
>                                 name, newval, env_flags_vartype_rep[type]);
>                         return -1;
>                 }
> +               if (item->range &&
> +                   _env_flags_validate_range(item->range, type, newval) < 0)
> +                       return -1;
>         }
>
>         /* check for access permission */
> diff --git a/include/configs/sandbox.h b/include/configs/sandbox.h
> index 2372485c84e..8dec2b2cc89 100644
> --- a/include/configs/sandbox.h
> +++ b/include/configs/sandbox.h
> @@ -21,4 +21,9 @@
>  /* Unused but necessary to build */
>  #define CFG_SYS_UBOOT_BASE     CONFIG_TEXT_BASE
>
> +#define CFG_ENV_FLAGS_LIST_STATIC \
> +       "decimalvalue:da@100-200," \
> +       "regexvalue:sa@r\"foo|bar\"," \
> +       "bitmaskvalue:xa@0xf00f"
> +
>  #endif
> diff --git a/include/env_flags.h b/include/env_flags.h
> index 2476043b0e3..dfe45ce04d5 100644
> --- a/include/env_flags.h
> +++ b/include/env_flags.h
> @@ -32,8 +32,19 @@ enum env_flags_varaccess {
>         env_flags_varaccess_end
>  };
>
> +struct env_flags_range {

Please comment the struct

> +       union  {
> +               char re[64];
> +               u64 bitmask;
> +               struct {
> +                       s64 min;
> +                       s64 max;
> +               } int_range;
> +       } u;
> +};
> +
>  #define ENV_FLAGS_VAR ".flags"
> -#define ENV_FLAGS_ATTR_MAX_LEN 2
> +#define ENV_FLAGS_ATTR_MAX_LEN 64

Please comment this item. I don't know what it means.

>  #define ENV_FLAGS_VARTYPE_LOC 0
>  #define ENV_FLAGS_VARACCESS_LOC 1
>
> @@ -108,6 +119,11 @@ const char *env_flags_get_vartype_name(enum env_flags_vartype type);
>   * Return the name of the access.
>   */
>  const char *env_flags_get_varaccess_name(enum env_flags_varaccess access);
> +/*
> + * Return the range of the access.

That is too vague, please add a proper function comment in the normal
U-Boot style.

> + */
> +const char *env_flags_get_varrange_name(struct env_flags_range *range,
> +                                                                               enum env_flags_vartype type);
>  #endif
>
>  /*
> @@ -118,6 +134,10 @@ enum env_flags_vartype env_flags_parse_vartype(const char *flags);
>   * Parse the flags string from a .flags attribute list into the varaccess enum.
>   */
>  enum env_flags_varaccess env_flags_parse_varaccess(const char *flags);
> +/*
> + * Parse the flags string from a .flags attribute list into the varaccess enum.

same here

I know you are just following the existing code, but please try to
improve it :-)

> + */
> +struct env_flags_range *env_flags_parse_varrange(const char *flags);
>  /*
>   * Parse the binary flags from a hash table entry into the varaccess enum.
>   */
> @@ -154,6 +174,11 @@ int env_flags_validate_access(const char *name, int check_mask);
>   * the defined flags for that variable, if any.
>   */
>  int env_flags_validate_varaccess(const char *name, int check_mask);
> +/*
> + * Validate that the variable "name" is valid according to
> + * the defined range for that variable, if any.
> + */
> +int env_flags_validate_range(const char *name, const char *newval)
>  /*
>   * Validate the parameters passed to "env set" for type compliance
>   */
> diff --git a/include/search.h b/include/search.h
> index 7faf23f4aca..c3de3109a4d 100644
> --- a/include/search.h
> +++ b/include/search.h
> @@ -34,6 +34,7 @@ struct env_entry {
>                 int flags);
>  #endif
>         int flags;
> +       void *range;

Please add comment...also why is this void * ?

>  };
>
>  /*
> diff --git a/test/env/Makefile b/test/env/Makefile
> index 9a98fd47966..717cbc5555e 100644
> --- a/test/env/Makefile
> +++ b/test/env/Makefile
> @@ -6,3 +6,4 @@ obj-y += cmd_ut_env.o
>  obj-y += attr.o
>  obj-y += hashtable.o
>  obj-$(CONFIG_ENV_IMPORT_FDT) += fdt.o
> +obj-y += range.o
> diff --git a/test/env/range.c b/test/env/range.c
> new file mode 100644
> index 00000000000..ed2cf27ef91
> --- /dev/null
> +++ b/test/env/range.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2024
> + * Lukas Funke, Weidmueller GmbH, lukas.funke@weidmueller.com
> + */
> +
> +#include <vsprintf.h>

This should go below env_flags

> +#include <command.h>
> +#include <env_attr.h>
> +#include <env_flags.h>
> +#include <test/env.h>
> +#include <test/ut.h>
> +
> +/*
> + * Set values according to their range
> + */
> +static int env_test_env_set_range(struct unit_test_state *uts)
> +{
> +       int r;
> +       char *value;
> +
> +       r = env_set("decimalvalue", "100");
> +       ut_asserteq(0, r);

ut_assertok(env_set("decimalvalue", "100"));

> +       value = env_get("decimalvalue");
> +       ut_asserteq_str("100", value);
> +       r = env_set("decimalvalue", "500");
> +       ut_asserteq(1, r);

please combine the line pairs into a single line

> +
> +       r = env_set("regexvalue", "foo");
> +       ut_asserteq(0, r);
> +       value = env_get("regexvalue");
> +       ut_asserteq_str("foo", value);
> +       r = env_set("regexvalue", "klaus");
> +       ut_asserteq(1, r);
> +
> +       r = env_set("bitmaskvalue", "0xf00f");
> +       ut_asserteq(0, r);
> +       value = env_get("bitmaskvalue");
> +       ut_asserteq_str("0xf00f", value);
> +       r = env_set("bitmaskvalue", "0x0110");
> +       ut_asserteq(1, r);
> +
> +       return 0;
> +}
> +

Drop blank line (convention we use in tests)

> +ENV_TEST(env_test_env_set_range, 0);

Please add UTF_CONSOLE and assert_nextline() calls above, so you can
check the error output.

> +
> +static int env_test_range_to_str(struct unit_test_state *uts)
> +{
> +       struct env_flags_range range;
> +
> +       range.u.int_range.min = 123;
> +       range.u.int_range.max = 456;
> +       ut_asserteq_str("123-456",
> +                       env_flags_get_varrange_name(&range,
> +                                                   env_flags_vartype_decimal));
> +
> +       strcpy(&range.u.re[0], "^(some|value)_[0-9a-zA-Z]");
> +       ut_asserteq_str("^(some|value)_[0-9a-zA-Z]",
> +                       env_flags_get_varrange_name(&range,
> +                                                   env_flags_vartype_string));
> +
> +       range.u.bitmask = 0x12300000;
> +       ut_asserteq_str("0x12300000",
> +                       env_flags_get_varrange_name(&range,
> +                                                   env_flags_vartype_hex));

blank line before final return

> +       return 0;
> +}
> +
> +ENV_TEST(env_test_range_to_str, 0);
> +
> +static int env_test_range_parse(struct unit_test_state *uts)
> +{
> +       char str[64];
> +       struct env_flags_range *range;
> +
> +       range = env_flags_parse_varrange("s@r\"somevalue\"");
> +       ut_assertnonnull(range);
> +       free(range);
> +
> +       range = env_flags_parse_varrange("sw");
> +       ut_assertnull(range);
> +
> +       snprintf(str, sizeof(str), "d@%ld-%ld", LONG_MIN, LONG_MAX);
> +       range = env_flags_parse_varrange(str);
> +       ut_assertnonnull(range);
> +       ut_assert(range->u.int_range.min == LONG_MIN);

ut_asserteq(LONG_MIN, range->u.int_range.min)

> +       ut_assert(range->u.int_range.max == LONG_MAX);
> +       free(range);
> +
> +       snprintf(str, sizeof(str), "d@0-%ld", LONG_MAX);
> +       range = env_flags_parse_varrange(str);
> +       ut_assertnonnull(range);
> +       ut_assert(range->u.int_range.min == 0);
> +       ut_assert(range->u.int_range.max == LONG_MAX);
> +       free(range);
> +
> +       snprintf(str, sizeof(str), "d@%ld-0", LONG_MIN);
> +       range = env_flags_parse_varrange(str);
> +       ut_assertnonnull(range);
> +       ut_assert(range->u.int_range.min == LONG_MIN);
> +       ut_assert(range->u.int_range.max == 0);
> +       free(range);
> +
> +       range = env_flags_parse_varrange("x@0xff0000ff");
> +       ut_assertnonnull(range);
> +       ut_assert(range->u.bitmask == 0xff0000ff);
> +       free(range);

You could check there are no memory leaks here. See for example
lib_test_abuf_set().

> +
> +       return 0;
> +}
> +
> +ENV_TEST(env_test_range_parse, 0);
> --
> 2.30.2
>

Regards,
Simon
