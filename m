Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717BDC71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 05:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D325F8642D;
	Fri, 25 Aug 2023 07:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eoV3bVhA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93EEC8681D; Fri, 25 Aug 2023 07:58:35 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0637852DB
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 07:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a7d7df4e67so411893b6e.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 22:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692943111; x=1693547911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/1EYhnrpENpFYy8cgSFHbVXevE+0WZhJs9JInc9Gqs=;
 b=eoV3bVhACOB42WNeccVGscOSZ9mQx1P8RUfn4tmTojxLpfgGTJ2JZFjgrkpmo1mVTd
 svmBbQ8RA64EIZhH6xKl9zyOMz0HRa4jR3eYgactNkM5MTkmM6Nnctp4vCGb374WC8sM
 2x7CTw7YKNxdRuLUZDlIuDZyLeruG5kc1rgJoLeWhVx7u10RzotzfqvxHYGFSBLDYVAV
 WpTPjfSN1ZrhjGZjBZ8ggj0T/43FdIy5cg81thMNebZmBfakq8pejeARpIg5OB0Qjxdj
 nWjUzEC9FK9BWEape9oRh79N8LbFOOXXjX93gHeEgRQQn23C3CByZvi/uhbC+RTOPO8+
 V4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692943111; x=1693547911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/1EYhnrpENpFYy8cgSFHbVXevE+0WZhJs9JInc9Gqs=;
 b=GAwmFp7D/ikRn/CMzUhy6KwUl++6QiCpM898V04bS0/uz6qf/P7BWFPHkw5vzq8kbG
 JZeFv+ghWa7MQi2scPNhe4ddI1xspH7X0XHiuqHX0Xj0eyPf2aFc1Ymo4eu+bJSuJ5/i
 ja293qAQ61sN2ciFSkxByY46hb/3ebQRWlx0f0Yc3WkSMQNLydoIpD8obrXTe0FGB5ZY
 FeKD0zzWAxun2pROeVQWqx6rlKjPVD8Ot1lDUdGUG5rE2SVtftdbG0H5FGV3fiL9t+a1
 ZcXnhA0z36q/wsvO0CwZ1ePNLFzV5WZsha9/OM2Ng2nceJvxUU25NIxIwe9Zs++S24SR
 PmEg==
X-Gm-Message-State: AOJu0YxhH3DT/RpU+KG6whB4WQ6hl/jfK5EhxaD6kMuW+8gj0fEi8iSW
 id7I7gGJFsxnBy0ArgxIYah3pBl4zT/RaudrHgt9+g==
X-Google-Smtp-Source: AGHT+IF4d6n62NZ4X2GuUKIfJZgGEAGKoLcDonZ+W0eUy4kOmH0GbHHkNNq5cr2ijb4jzEpnkKwr71h3ngTWONeWF2w=
X-Received: by 2002:a05:6808:2a5c:b0:39b:a87f:91e8 with SMTP id
 fa28-20020a0568082a5c00b0039ba87f91e8mr1663215oib.45.1692943111386; Thu, 24
 Aug 2023 22:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
 <20230823083721.1318097-2-masahisa.kojima@linaro.org>
 <ff697396-ce30-e6c3-b7fa-5aac053dec4c@gmx.de>
In-Reply-To: <ff697396-ce30-e6c3-b7fa-5aac053dec4c@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 25 Aug 2023 14:58:20 +0900
Message-ID: <CADQ0-X_rnpkN8pzfVazrj_Tgd6rrauyBN-SJs1wzO-KL=V8JLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: efidebug: add uri device path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Thu, 24 Aug 2023 at 14:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/23/23 10:37, Masahisa Kojima wrote:
> > This adds the URI device path option for 'boot add' subcommand.
> > User can add the URI load option for downloading ISO image file
> > or EFI application through network(e.g. HTTP).
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   cmd/efidebug.c | 39 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 39 insertions(+)
> >
> > diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> > index 0be3af3e76..62f867df2a 100644
> > --- a/cmd/efidebug.c
> > +++ b/cmd/efidebug.c
> > @@ -829,6 +829,44 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
> >                       argc -= 1;
> >                       argv += 1;
> >                       break;
> > +             case 'u':
> > +             {
> > +                     char *pos;
> > +                     int uridp_len;
> > +                     struct efi_device_path_uri *uridp;
> > +
> > +                     if (argc <  3 || lo.label) {
> > +                             r = CMD_RET_USAGE;
> > +                             goto out;
> > +                     }
> > +                     id = (int)hextoul(argv[1], &endp);
> > +                     if (*endp != '\0' || id > 0xffff)
> > +                             return CMD_RET_USAGE;
> > +
> > +                     efi_create_indexed_name(var_name16, sizeof(var_name16),
> > +                                             "Boot", id);
> > +
> > +                     label = efi_convert_string(argv[2]);
> > +                     if (!label)
> > +                             return CMD_RET_FAILURE;
> > +                     lo.label = label;
> > +
> > +                     uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1; > +                   fp_free = efi_alloc(uridp_len + sizeof(END));
> > +                     uridp = (struct efi_device_path_uri *)fp_free;
> > +                     uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +                     uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +                     uridp->dp.length = uridp_len;
> > +                     strcpy(uridp->uri, argv[3]);
>
> This assumes that argv[3] is a valid URI.
>
> Would it be preferable to validate that the string is percent encoded,
> conforms to RFC 3986, and contains a supported scheme, an authority, and
> a path?
>
> As a user I would like related errors to be caught at entry and not at
> runtime.

OK, I agree. I will add input uri validation here.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> > +                     pos = (char *)uridp + uridp_len;
> > +                     memcpy(pos, &END, sizeof(END));
> > +                     fp_size += uridp_len + sizeof(END);
> > +                     file_path = (struct efi_device_path *)uridp;
> > +                     argc -= 3;
> > +                     argv += 3;
> > +                     break;
> > +             }
> > +
> >               default:
> >                       r = CMD_RET_USAGE;
> >                       goto out;
> > @@ -1492,6 +1530,7 @@ static char efidebug_help_text[] =
> >       "  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
> >       "  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
> >       "  (-b, -i for short form device path)\n"
> > +     "  -u <bootid> <label> <uri>\n"
> >       "  -s '<optional data>'\n"
> >       "efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
> >       "  - delete UEFI BootXXXX variables\n"
>
