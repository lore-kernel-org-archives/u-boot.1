Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BEFC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 08:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD26F86F6E;
	Thu,  9 Nov 2023 09:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jmgll9Fq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 634BE86F93; Thu,  9 Nov 2023 09:00:58 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D56786F55
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 09:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c7369df9d6so7069331fa.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 00:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699516855; x=1700121655; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KMYaZ46oFMCRYjRqnvoZIVrhuGbalMTjBb2tKlS5Bvo=;
 b=Jmgll9FqlQxy0sL8/JSORU8AqsBTd+IbUdMLt89Q+pyk8HLWJf/9rv/QQ3ZuPpclHz
 R2yvR4ttLFut1tnuaIbOVHOM1xXHsx82JFNsR4v1ryXHfRUaB++gWQpr3/VnmXEBdbxG
 7jIV7a6CWAH8LqBr0TF+NSRei5c9wESNJjcfhzTrgApo1zDzXASpFpI6W5GM6hHxraCi
 LzZu6UohWhXqPIF169vxEhJw6w7PeYPfzGCO/BycsLcX5gE3n1Ufi7cYoL566RodS74N
 JpK8z77yj6F21haPjXfJOPPnl4fzkt/E/0ocRnODIuIDhlxGAmqi/Re1AYERI7ehSDR4
 EQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699516855; x=1700121655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KMYaZ46oFMCRYjRqnvoZIVrhuGbalMTjBb2tKlS5Bvo=;
 b=QHRbzAjwPQE8NYhf93i9D6TEZRR30dAEoNcS8NKpOayhVp3kFXagWadiVg/L0Y1lJy
 8mha5WrKAUBFarqsA53aQgi5MJtyA1MAB7rt5THHsGAnrg1XR7fSa3ZJM7RvHZDx9Jsc
 i457Bn5aPQGaHM1SETvbK8BwAkIgYt3nlAtrip10XesXguBsAAuRGKZJyXhlfteOwoi8
 S1JPgqQcpWRZnM7nrLhFQ/boEEx15buCWv2d125OiUgMjrcUgHMV2j6rT3RAUQ8V+VBU
 A0mv3lX4MKq/r2VdsslYt0ZWj8AV7T/NLxm0pds+WpfblgpmrJIBK8TDOIFHOHtv7KGx
 d3WQ==
X-Gm-Message-State: AOJu0YwTYPGWIOZSrktymf5bFOnTt7se8+tjEel2W0nFEqUeLmR4vb2r
 ODFVocgZLklbp6kubM2IZ/qgXGmrupLjdrYXQrsF1Q==
X-Google-Smtp-Source: AGHT+IENkvMSclM76Ai6lsVxWKBHHll5wO1fYR0GPRV5kd4j3jyUOykXGmajq0ZtZ0J9+Y27BEzw8+K5S9SnTXtys/I=
X-Received: by 2002:a2e:8049:0:b0:2c5:14f8:d5dc with SMTP id
 p9-20020a2e8049000000b002c514f8d5dcmr3364882ljg.14.1699516855433; Thu, 09 Nov
 2023 00:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
 <20231108110637.3691441-9-masahisa.kojima@linaro.org>
 <CAPnjgZ0OrgyUH7qWovzghjsNUKmsbC_=X=Cws6WrpuRKLsG=0A@mail.gmail.com>
In-Reply-To: <CAPnjgZ0OrgyUH7qWovzghjsNUKmsbC_=X=Cws6WrpuRKLsG=0A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Nov 2023 10:00:19 +0200
Message-ID: <CAC_iWjK_Ti+uwJu29_LXqBsL==dFU1PT0cvqHX5gc0-3GeBwdw@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] cmd: efidebug: add uri device path
To: Simon Glass <sjg@chromium.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
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

Hi Simon,

On Thu, 9 Nov 2023 at 03:15, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Masahisa,
>
> On Wed, 8 Nov 2023 at 04:08, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> >
> > This adds the URI device path option for 'boot add' subcommand.
> > User can add the URI load option for downloading ISO image file
> > or EFI application through network. Currently HTTP is only supported.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  cmd/efidebug.c | 51 ++++++++++++++++++++++++++++++++++++
> >  include/net.h  |  8 ++++++
> >  net/wget.c     | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 130 insertions(+)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> >
> > diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> > index 201531ac19..42b306e708 100644
> > --- a/cmd/efidebug.c
> > +++ b/cmd/efidebug.c
> > @@ -19,6 +19,7 @@
> >  #include <log.h>
> >  #include <malloc.h>
> >  #include <mapmem.h>
> > +#include <net.h>
> >  #include <part.h>
> >  #include <search.h>
> >  #include <linux/ctype.h>
> > @@ -829,6 +830,53 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
> >                         argc -= 1;
> >                         argv += 1;
> >                         break;
> > +#if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
>
> (my very late comment could be looked at after this is applied, since
> it is already at v11)
>
> Can this be move to 'if'? You can put it inside the case and really
> this code should be in a function, as do_efi_boot_add() is already
> long.

I think it can.  Kojima-san will send a v12 since there's a small
issue in patch #7. I think he can fix that as well

Thanks
/Ilias
>
> > +               case 'u':
> > +               {
> > +                       char *pos;
> > +                       int uridp_len;
> > +                       struct efi_device_path_uri *uridp;
> > +
> > +                       if (argc <  3 || lo.label) {
> > +                               r = CMD_RET_USAGE;
> > +                               goto out;
> > +                       }
> > +
> > +                       id = (int)hextoul(argv[1], &endp);
> > +                       if (*endp != '\0' || id > 0xffff)
> > +                               return CMD_RET_USAGE;
> > +
> > +                       label = efi_convert_string(argv[2]);
> > +                       if (!label)
> > +                               return CMD_RET_FAILURE;
> > +
> > +                       if (!wget_validate_uri(argv[3])) {
> > +                               printf("ERROR: invalid URI\n");
> > +                               r = CMD_RET_FAILURE;
> > +                               goto out;
> > +                       }
> > +
> > +                       efi_create_indexed_name(var_name16, sizeof(var_name16),
> > +                                               "Boot", id);
> > +                       lo.label = label;
> > +
> > +                       uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
> > +                       fp_size += uridp_len + sizeof(END);
> > +                       fp_free = efi_alloc(fp_size);
> > +                       uridp = (struct efi_device_path_uri *)fp_free;
> > +                       uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +                       uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +                       uridp->dp.length = uridp_len;
> > +                       strcpy(uridp->uri, argv[3]);
> > +                       pos = (char *)uridp + uridp_len;
> > +                       memcpy(pos, &END, sizeof(END));
> > +                       file_path = (struct efi_device_path *)uridp;
> > +                       argc -= 3;
> > +                       argv += 3;
> > +                       break;
> > +               }
> > +#endif
> > +
> >                 default:
> >                         r = CMD_RET_USAGE;
> >                         goto out;
> > @@ -1491,6 +1539,9 @@ U_BOOT_LONGHELP(efidebug,
> >         "  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
> >         "  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
> >         "  (-b, -i for short form device path)\n"
> > +#if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> > +       "  -u <bootid> <label> <uri>\n"
> > +#endif
> >         "  -s '<optional data>'\n"
> >         "efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
> >         "  - delete UEFI BootXXXX variables\n"
> > diff --git a/include/net.h b/include/net.h
> > index 57889d8b7a..c748974573 100644
> > --- a/include/net.h
> > +++ b/include/net.h
> > @@ -935,4 +935,12 @@ static inline void eth_set_enable_bootdevs(bool enable) {}
> >   */
> >  int wget_with_dns(ulong dst_addr, char *uri);
> >
> > +/**
> > + * wget_validate_uri() - varidate the uri
> > + *
> > + * @uri:       uri string of target file of wget
> > + * Return:     true if uri is valid, false if uri is invalid
> > + */
> > +bool wget_validate_uri(char *uri);
> > +
> >  #endif /* __NET_H__ */
> > diff --git a/net/wget.c b/net/wget.c
> > index 2087146b37..6ae2237a0a 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -566,3 +566,74 @@ out:
> >         return ret;
> >  }
> >  #endif
> > +
> > +/**
> > + * wget_validate_uri() - validate the uri for wget
> > + *
> > + * @uri:       uri string
> > + *
> > + * This function follows the current U-Boot wget implementation.
> > + * scheme: only "http:" is supported
> > + * authority:
> > + *   - user information: not supported
> > + *   - host: supported
> > + *   - port: not supported(always use the default port)
> > + *
> > + * Uri is expected to be correctly percent encoded.
> > + * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
> > + * and space character(0x20) are not allowed.
> > + *
> > + * TODO: stricter uri conformance check
> > + *
> > + * Return:     true on success, false on failure
> > + */
> > +bool wget_validate_uri(char *uri)
> > +{
> > +       char c;
> > +       bool ret = true;
> > +       char *str_copy, *s, *authority;
> > +
> > +       for (c = 0x1; c < 0x21; c++) {
> > +               if (strchr(uri, c)) {
> > +                       log_err("invalid character is used\n");
> > +                       return false;
> > +               }
> > +       }
> > +       if (strchr(uri, 0x7f)) {
> > +               log_err("invalid character is used\n");
> > +               return false;
> > +       }
> > +
> > +       if (strncmp(uri, "http://", 7)) {
> > +               log_err("only http:// is supported\n");
> > +               return false;
> > +       }
> > +       str_copy = strdup(uri);
> > +       if (!str_copy)
> > +               return false;
> > +
> > +       s = str_copy + strlen("http://");
> > +       authority = strsep(&s, "/");
> > +       if (!s) {
> > +               log_err("invalid uri, no file path\n");
> > +               ret = false;
> > +               goto out;
> > +       }
> > +       s = strchr(authority, '@');
> > +       if (s) {
> > +               log_err("user information is not supported\n");
> > +               ret = false;
> > +               goto out;
> > +       }
> > +       s = strchr(authority, ':');
> > +       if (s) {
> > +               log_err("user defined port is not supported\n");
> > +               ret = false;
> > +               goto out;
> > +       }
> > +
> > +out:
> > +       free(str_copy);
> > +
> > +       return ret;
> > +}
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
