Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D16E732DE
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0903686E5A;
	Thu, 28 Sep 2023 16:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XSmEJjJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D095086E5B; Thu, 28 Sep 2023 16:32:45 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9451864C3
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9b2b53e17feso427050466b.3
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695911563; x=1696516363; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+eIqy5Hu4aeUsmxl4o3xY/4e3wIvQ1x5pDo27qJ898U=;
 b=XSmEJjJ4HtQR683FANzHnraC+14qmDuDZd2OaVjBvnEOAtCHYp5o21WeuUYThiSt5I
 s5DuX+ZRMVlULDRUZQLqg/13GSx4WagRhRR8i/SkO/CcQv1bt6++Ob3IOWu/y93P8wfa
 gXYe0kdPsHrqegP6echZm7GbqMrnTENN/jkoMF9Xe5yFliqtefSsDzmmg61iP9vaFJm0
 kw3f1+v6tI3LdbpKo5ZD9bfBrAsEhnO41JStboMBzAhC0iOQI2JL4qQ/oPB7Ucp/Wyxr
 Mz5BPQt9fJTqmz7FMn4VGKm5jH97dVUh6fdXJi+9XIvSHOqFyX8d/WfciwAyBxQH+Osp
 2R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695911563; x=1696516363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+eIqy5Hu4aeUsmxl4o3xY/4e3wIvQ1x5pDo27qJ898U=;
 b=dE4DTPiIxFh6x1Zun4Zj/uw0H/77w56GU85sHDiehKzRnuclYGNUqi/2OyI2+vSJOw
 ARD9b/YcoG9w2tDXVqKdzbRafphtJKVRQ2a0ACIkgV4XIXZWpsd2GimrBY2f8J+AjSnb
 EviUKi3VhbtUAirMuqi/9ijMKwfum3QgjlW0OHKeye7M/MZ7TOkfrTKL5oeAvH9RFYQR
 IGpMGoRtLDxxVVyvXzY4WLOWRGA/X0Z7yGTGJMp224s+Tc4aIPOYRbj2N2T3/Zzyy4ju
 0fx/IC3Rn97gnBbSZ2iMYZC4is3l1RUzrAijwx39owtT7ZBpPXrGRi38A6CUUFINGH14
 K3QQ==
X-Gm-Message-State: AOJu0Yz1XTmwxTjzrFIOi2jaEjHkK8IzdGG42fxcFAFXRji06+br/c22
 4iSGbmNVscAwhPXl0lESCzOYt22FX9CF1E945hVCSQ==
X-Google-Smtp-Source: AGHT+IGqmVBg07keEzLUrLFzlbxBVNs25RYsfVp6smRwP8KEqPE/YXeNEfe5H/SB7e2f5x+khnGDuFMF2X8gaspFDKg=
X-Received: by 2002:a17:907:7806:b0:9a1:aea2:d18d with SMTP id
 la6-20020a170907780600b009a1aea2d18dmr1287380ejc.48.1695911562897; Thu, 28
 Sep 2023 07:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
 <20230927093631.1595494-6-masahisa.kojima@linaro.org>
In-Reply-To: <20230927093631.1595494-6-masahisa.kojima@linaro.org>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 28 Sep 2023 20:32:31 +0600
Message-ID: <CAD8XO3brLfDuxSQ=gzC9FOAoBF3Xtf_8x95EbPNz52bVeUQLQQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] cmd: efidebug: add uri device path
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
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

On Wed, 27 Sept 2023 at 15:38, Masahisa Kojima <masahisa.kojima@linaro.org>
wrote:

> This adds the URI device path option for 'boot add' subcommand.
> User can add the URI load option for downloading ISO image file
> or EFI application through network. Currently HTTP is only supported.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  cmd/efidebug.c | 50 +++++++++++++++++++++++++++++++++++
>  include/net.h  |  8 ++++++
>  net/wget.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 0be3af3e76..f2fd6ba71d 100644
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
> @@ -829,6 +830,52 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int
> flag,
>                         argc -= 1;
>                         argv += 1;
>                         break;
> +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) &&
> IS_ENABLED(CONFIG_CMD_DNS))
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
> +                       id = (int)hextoul(argv[1], &endp);
> +                       if (*endp != '\0' || id > 0xffff)
> +                               return CMD_RET_USAGE;
> +
> +                       efi_create_indexed_name(var_name16,
> sizeof(var_name16),
> +                                               "Boot", id);
> +
> +                       label = efi_convert_string(argv[2]);
> +                       if (!label)
> +                               return CMD_RET_FAILURE;
> +                       lo.label = label;
> +
> +                       uridp_len = sizeof(struct efi_device_path) +
> strlen(argv[3]) + 1;
> +                       fp_free = efi_alloc(uridp_len + sizeof(END));
> +                       uridp = (struct efi_device_path_uri *)fp_free;
> +                       uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +                       uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> +                       uridp->dp.length = uridp_len;
> +                       if (!wget_validate_uri(argv[3])) {
> +                               printf("ERROR: invalid URI\n");
> +                               r = CMD_RET_FAILURE;
> +                               goto out;
> +                       }
> +
> +                       strcpy(uridp->uri, argv[3]);
> +                       pos = (char *)uridp + uridp_len;
> +                       memcpy(pos, &END, sizeof(END));
> +                       fp_size += uridp_len + sizeof(END);
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
> @@ -1492,6 +1539,9 @@ static char efidebug_help_text[] =
>         "  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file
> path>\n"
>         "  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
>         "  (-b, -i for short form device path)\n"
> +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) &&
> IS_ENABLED(CONFIG_CMD_DNS))
> +       "  -u <bootid> <label> <uri>\n"
> +#endif
>         "  -s '<optional data>'\n"
>         "efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
>         "  - delete UEFI BootXXXX variables\n"
> diff --git a/include/net.h b/include/net.h
> index 57889d8b7a..c748974573 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -935,4 +935,12 @@ static inline void eth_set_enable_bootdevs(bool
> enable) {}
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
> index 4801e28eb9..6a4d22be32 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -558,3 +558,75 @@ out:
>         return ret;
>  }
>  #endif
> +
> +/**
> + * wget_validate_uri() - validate the uri for wget
> + *
> + * @uri:       uri string
> + * Return:     true on success, false on failure
> + */
>

It's better to have a comment description in one place. You already have
it in the header file.  And even here the text is a little bit differ.


> +bool wget_validate_uri(char *uri)
> +{
> +       char c;
> +       bool ret = true;
> +       char *str_copy, *s, *authority;
> +
> +       /* TODO: strict uri conformance check */
> +
> +       /*
> +        * Uri is expected to be correctly percent encoded.
> +        * This is the minimum check, control codes(0x1-0x19, 0x7F, except
> '\0')
> +        * and space character(0x20) are not allowed.
> +        */
> +       for (c = 0x1; c < 0x21; c++) {
> +               if (strchr(uri, c)) {
> +                       printf("invalid character is used\n");
> +                       return false;
> +               }
> +       }
> +       if (strchr(uri, 0x7f)) {
> +               printf("invalid character is used\n");
> +               return false;
> +       }
>

So you validate that only English characters exist in the url. There are
urls with non English characters.



> +
> +       /*
> +        * This follows the current U-Boot wget implementation.
> +        * scheme: only "http:" is supported
> +        * authority:
> +        *   - user information: not supported
> +        *   - host: supported
> +        *   - port: not supported(always use the default port)
> +        */
> +       if (strncmp(uri, "http://", 7)) {
> +               printf("only http:// is supported\n");
>

log_err()


> +               return false;
> +       }
> +       str_copy = strdup(uri);
> +       if (!str_copy)
> +               return false;
> +
> +       s = str_copy + strlen("http://");
> +       authority = strsep(&s, "/");
> +       if (!s) {
> +               printf("invalid uri, no file path\n");
> +               ret = false;
> +               goto out;
> +       }
> +       s = strchr(authority, '@');
> +       if (s) {
> +               printf("user information is not supported\n");
> +               ret = false;
> +               goto out;
> +       }
> +       s = strchr(authority, ':');
> +       if (s) {
> +               printf("user defined port is not supported\n");
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
>
