Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3CFC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 05:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B9E8681D;
	Fri, 25 Aug 2023 07:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cd2gVRFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 147A086824; Fri, 25 Aug 2023 07:57:47 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE18C852DB
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 07:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-44d3e4ad403so285795137.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 22:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692943062; x=1693547862;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ogwFZCBXvH7DM6BNIQrt10KA5sfy+2UyL7kE9A1XCd8=;
 b=Cd2gVRFhOXqEC+LLVx5OBVDehlSNYUixBK4b8Ue4VbENjwcKMdee+kemq6Eq/nSWZt
 njNttKDBh2U+nPSWhlO28+JzEoqcYnEQYtlt6MVANm6eFjuBGgYEQKITovstPovdPVY0
 nGcMoR7bvCU1/38f1dku9RirSBpxI+rKp2QxRa52HteqAcGU1csgGyWpYvufEMtMQwWh
 7S9jmyhEoixuApELhV8mDeDQPXM77EbLdpr/SP1Llqqhhm47FKpaLlbyBG9ntZ33zlI+
 +YmFR9kxMNwCfSUw0rVB291390RumQ6rOT8srdGBzgsvvHjTtD02110NFJMe8Tq6SWOi
 6I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692943062; x=1693547862;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ogwFZCBXvH7DM6BNIQrt10KA5sfy+2UyL7kE9A1XCd8=;
 b=ch4QcKPcO2mnESOq1bkTDRpX34mRoxAeScfuMrPqhwSDzSCMeoiLRIyGh7yLvWpcYw
 WUeLyKGmbzOyWlqpPU/Oqp1mpFkrm9zAgyyBSFEx3dv7yHifvULDHP8EOFdH49XyQd8A
 EPN4xLt6+RgNdjvyl8CEHVb+WO9MmKSWH6/VLziMrb7kT9qwk9NhVUxHVvcv62F+IcJJ
 wZgX675MVUi8oi8BgegJNmmwIz8UAcj99bkSBDP8QcisWvtrKW+LTNHVnHFcSxQOA7oA
 rdEAyQM84E6QPgg2WLySpnrXkbRHm60ysO6wPIFPwId4sL/A3HSrCWuhkBndA7LdiqcQ
 3ZrA==
X-Gm-Message-State: AOJu0YxmJDcZBCh1CBr5JSzHpelX0MNZ54of6En9Oigelericg29Ai6M
 8Mn9FDqx7qidgHzPR+MjMaP1ZBBb0inv85yG+it+wg==
X-Google-Smtp-Source: AGHT+IET1U8exCFR9imYvxq9lmzMEQNBXPVZP/GPwqN4XVtTKhvU4TxxSZdH5vSFaZzSD1JXddmq5r2HjcSZzdBdB7k=
X-Received: by 2002:a05:6102:52a:b0:44a:ae24:ee50 with SMTP id
 m10-20020a056102052a00b0044aae24ee50mr16062260vsa.10.1692943062514; Thu, 24
 Aug 2023 22:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
 <20230823083721.1318097-2-masahisa.kojima@linaro.org>
 <ZOagOlRLw8cOsFM7@octopus>
In-Reply-To: <ZOagOlRLw8cOsFM7@octopus>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 25 Aug 2023 14:57:31 +0900
Message-ID: <CADQ0-X_3KeWE72jO2ymiCgE-_uU8URBsQVHGryi_41O7oqXYUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: efidebug: add uri device path
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Thu, 24 Aug 2023 at 09:11, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Hi Kojima-san,
>
> On Wed, Aug 23, 2023 at 05:37:19PM +0900, Masahisa Kojima wrote:
> > This adds the URI device path option for 'boot add' subcommand.
> > User can add the URI load option for downloading ISO image file
> > or EFI application through network(e.g. HTTP).
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  cmd/efidebug.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
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
> > +                     uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
> > +                     fp_free = efi_alloc(uridp_len + sizeof(END));
> > +                     uridp = (struct efi_device_path_uri *)fp_free;
> > +                     uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +                     uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +                     uridp->dp.length = uridp_len;
> > +                     strcpy(uridp->uri, argv[3]);
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
>
> It might be a matter of personal preference, but
> since the current syntax of efidebug is already much complex,
> I don't want to add more options unless it's necessary.
> How about re-using "-B" option, say
>    => efidebug -B 3 debian-netinst uri - https://foo.com/baa

I understand your concern. OK, I will add uri in -b|B and also update
documentation.

Thanks,
Masahisa Kojima

>
> BTW, I think that <bootid> and <label> should have been moved out of "-b|B"
> when Ilias introduced this new syntax.
>
> -Takahiro Akashi
>
>
> >       "  -s '<optional data>'\n"
> >       "efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
> >       "  - delete UEFI BootXXXX variables\n"
> > --
> > 2.34.1
> >
