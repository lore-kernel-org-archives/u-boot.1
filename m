Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BFAC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 19:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6D187B76;
	Thu, 26 Oct 2023 21:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H2dQVwON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57ECB87649; Thu, 26 Oct 2023 21:00:23 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A071686FC8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 21:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c594196344so18917641fa.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698346816; x=1698951616; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dX74xVzXZs3++p7by4LqfuczjzKUE6y7kJIcBIl02Fk=;
 b=H2dQVwONvrsENeOC8IBWyGcj/pzmLsv8n/NV4Q+oO582EldrEH2J2IvuNXzv3AJdlc
 oc3uEPxxbV/0nmCWny+H3pQx5TYjkmkkfCApUeevMuSfHroVEh71bLcm5DhfCsIQtapI
 UkArVInHkPQveO5TPpDgeWDVOjk5SgKn6pUZpOoLfUVNlFtgOrg9rtBW+Pqx1OOrJ0Ou
 lp8awBXpjqWIT/L8qgNaicPzsKZb5qywpEdOk4xIWbLdnjciWJmTVXwbyT2tJlm/AtwS
 ZCk/subYxRsbPCxCuVOvRBVHIGOJs4WW0jd6Xxk06pWsTGrXnBh5SoywZX5U6iwVG/j+
 MTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698346816; x=1698951616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dX74xVzXZs3++p7by4LqfuczjzKUE6y7kJIcBIl02Fk=;
 b=R8Te76ZqUUcWn+G2xjWltfu57nYfDeFnUUDezJvKFPoEr0OL1RGS9DK9/+c2UActbd
 H5iB67TjCgVfiZQZQUZhWP8T9zVFc6aqsP8cLtUb/Utx5kOPGrudlgG0SI4s9ILU808k
 gdC+6Nub6HNo7euMkJCl8FUcNz8Qnc6JV163VM7GxErtXN1RZcCapbznyWL92z7g1+Xy
 Lgjwcs9kfolFFKvrHCXzy5Xiec0svy3jhjbe93XNPvFC8Mh2N8H0LOSAszgXfVYoDOwT
 eC1CXk1qY2fVAZPAvBzI7+jSQSvWvx9apse7EU2603p7bDv6f4gEwOr/n8h+fJd9vf0m
 5A2A==
X-Gm-Message-State: AOJu0Yy2AC8Zf4Ixq6fe99EfBNIFkF/cMtj0VB3FrLlryJ22AlCaP7lb
 0p5nkTvJkw15LYTDO/uktdJuQwbKdujE5AJTaDihkg==
X-Google-Smtp-Source: AGHT+IEeARLaz/YBaTxEvZGqfAb8GCG9hoe7f0CZF+RasLL9+JoAWqL8/0SL7EAVF6JE2oEOu+gARufNZsWeTwC1eqw=
X-Received: by 2002:a05:6512:4026:b0:507:a16d:cf55 with SMTP id
 br38-20020a056512402600b00507a16dcf55mr197766lfb.68.1698346816583; Thu, 26
 Oct 2023 12:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231025062845.3100964-1-masahisa.kojima@linaro.org>
 <20231025062845.3100964-7-masahisa.kojima@linaro.org>
In-Reply-To: <20231025062845.3100964-7-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Oct 2023 21:59:40 +0300
Message-ID: <CAC_iWj+-r-rFoxLmn+cvqx4tEYzRtamKSAhnbyBUd3O54qtkcw@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] cmd: efidebug: add uri device path
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
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

On Wed, 25 Oct 2023 at 09:30, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This adds the URI device path option for 'boot add' subcommand.
> User can add the URI load option for downloading ISO image file
> or EFI application through network. Currently HTTP is only supported.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  cmd/efidebug.c | 51 ++++++++++++++++++++++++++++++++++++
>  include/net.h  |  8 ++++++
>  net/wget.c     | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 201531ac19..42b306e708 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -19,6 +19,7 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <mapmem.h>
> +#include <net.h>
>  #include <part.h>
>  #include <search.h>
>  #include <linux/ctype.h>
> @@ -829,6 +830,53 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>                         argc -= 1;
>                         argv += 1;
>                         break;
> +#if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> +               case 'u':
> +               {
> +                       char *pos;
> +                       int uridp_len;
> +                       struct efi_device_path_uri *uridp;
> +
> +                       if (argc <  3 || lo.label) {
> +                               r = CMD_RET_USAGE;
> +                               goto out;
> +                       }
> +
> +                       id = (int)hextoul(argv[1], &endp);
> +                       if (*endp != '\0' || id > 0xffff)
> +                               return CMD_RET_USAGE;
> +
> +                       label = efi_convert_string(argv[2]);
> +                       if (!label)
> +                               return CMD_RET_FAILURE;
> +
> +                       if (!wget_validate_uri(argv[3])) {
> +                               printf("ERROR: invalid URI\n");
> +                               r = CMD_RET_FAILURE;
> +                               goto out;
> +                       }
> +
> +                       efi_create_indexed_name(var_name16, sizeof(var_name16),
> +                                               "Boot", id);
> +                       lo.label = label;
> +
> +                       uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
> +                       fp_size += uridp_len + sizeof(END);
> +                       fp_free = efi_alloc(fp_size);
> +                       uridp = (struct efi_device_path_uri *)fp_free;
> +                       uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +                       uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> +                       uridp->dp.length = uridp_len;
> +                       strcpy(uridp->uri, argv[3]);
> +                       pos = (char *)uridp + uridp_len;
> +                       memcpy(pos, &END, sizeof(END));
> +                       file_path = (struct efi_device_path *)uridp;
> +                       argc -= 3;
> +                       argv += 3;
> +                       break;
> +               }
> +#endif
> +
>                 default:
>                         r = CMD_RET_USAGE;
>                         goto out;
> @@ -1491,6 +1539,9 @@ U_BOOT_LONGHELP(efidebug,
>         "  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
>         "  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
>         "  (-b, -i for short form device path)\n"
> +#if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> +       "  -u <bootid> <label> <uri>\n"
> +#endif
>         "  -s '<optional data>'\n"
>         "efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
>         "  - delete UEFI BootXXXX variables\n"
> diff --git a/include/net.h b/include/net.h
> index 57889d8b7a..c748974573 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -935,4 +935,12 @@ static inline void eth_set_enable_bootdevs(bool enable) {}
>   */
>  int wget_with_dns(ulong dst_addr, char *uri);
>
> +/**
> + * wget_validate_uri() - varidate the uri
> + *
> + * @uri:       uri string of target file of wget
> + * Return:     true if uri is valid, false if uri is invalid
> + */
> +bool wget_validate_uri(char *uri);
> +
>  #endif /* __NET_H__ */
> diff --git a/net/wget.c b/net/wget.c
> index 2087146b37..6ae2237a0a 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -566,3 +566,74 @@ out:
>         return ret;
>  }
>  #endif
> +
> +/**
> + * wget_validate_uri() - validate the uri for wget
> + *
> + * @uri:       uri string
> + *
> + * This function follows the current U-Boot wget implementation.
> + * scheme: only "http:" is supported
> + * authority:
> + *   - user information: not supported
> + *   - host: supported
> + *   - port: not supported(always use the default port)
> + *
> + * Uri is expected to be correctly percent encoded.
> + * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
> + * and space character(0x20) are not allowed.
> + *
> + * TODO: stricter uri conformance check
> + *
> + * Return:     true on success, false on failure
> + */
> +bool wget_validate_uri(char *uri)
> +{
> +       char c;
> +       bool ret = true;
> +       char *str_copy, *s, *authority;
> +
> +       for (c = 0x1; c < 0x21; c++) {
> +               if (strchr(uri, c)) {
> +                       log_err("invalid character is used\n");
> +                       return false;
> +               }
> +       }
> +       if (strchr(uri, 0x7f)) {
> +               log_err("invalid character is used\n");
> +               return false;
> +       }
> +
> +       if (strncmp(uri, "http://", 7)) {
> +               log_err("only http:// is supported\n");
> +               return false;
> +       }
> +       str_copy = strdup(uri);
> +       if (!str_copy)
> +               return false;
> +
> +       s = str_copy + strlen("http://");
> +       authority = strsep(&s, "/");
> +       if (!s) {
> +               log_err("invalid uri, no file path\n");
> +               ret = false;
> +               goto out;
> +       }
> +       s = strchr(authority, '@');
> +       if (s) {
> +               log_err("user information is not supported\n");
> +               ret = false;
> +               goto out;
> +       }
> +       s = strchr(authority, ':');
> +       if (s) {
> +               log_err("user defined port is not supported\n");
> +               ret = false;
> +               goto out;
> +       }
> +
> +out:
> +       free(str_copy);
> +
> +       return ret;
> +}
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
