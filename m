Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4004CC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 06:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D3786420;
	Mon, 28 Aug 2023 08:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I1DZOxuy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D808863E8; Mon, 28 Aug 2023 08:02:34 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2175A807C4
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a56401b9aso1979662b3a.1
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 23:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693202549; x=1693807349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dWqEvBY3wQxKoSEewFVPOp6DqqwEx8H4sQ3TEYrrLok=;
 b=I1DZOxuymxEsBY2jPs9sT4WbLIZ59eOCMC55rmQ6gbdb49BXcLRr3cjp5dKBEjVNw0
 9j98gUofj0LoCiHYHULQf3jIe6HhBOMgpcwL2KgPynAISmXFBk6n2R0p4fPyUCJhkzxo
 q52UZQGvcuIK0cFrbdTuF3YN04emMZ6zYszMkN7yluAZi51UduzQe6kWyML8XFp1MOjW
 Enz3LU0bGQCOq2z1ZfuS40wx/hBaMwq87SP/lq8/Axk4Nl4XOycijLFwK/GXv1a7BBGR
 1kmyxuYq/lQwcRBjNQB3AwG2qEZVbHr/+1NI/pAyx/vV+ag+cor9FRtBfhBKZvBWTpbu
 2peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693202549; x=1693807349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dWqEvBY3wQxKoSEewFVPOp6DqqwEx8H4sQ3TEYrrLok=;
 b=RkNuQipKTwYvImapUZm/k3MYQ/4ysf+/UIu/3BSc/C9bmNVqki+tBYNgH5iy83h/Nf
 IV7p4XoKZK04x+UKLYv4xE4crX3vzrmuLCAg1szjyuFZzdO1LQQICrJwtQOyYxslj+qa
 b71iTK1MMacH5wEsJx0J56FhvJl4iGRpw9hnzpb6vpMm7A9Y+bcHplQr3Ee8PZxqcEf4
 rlf/gBX8051Py+PaIoegqIa6pnwhUA+s6CNNIt+HpeuaZXC4nudOUCt/jD6Xw/Ak0h+V
 OcRJlEGjKq3Jq90dfsd4Bn78m9pWuHOSLRNK95FWOla/AOALgN41jpe+DJ8bYSCN5qa5
 8FvQ==
X-Gm-Message-State: AOJu0YybQTOdGXt5uqBf8SUlcwFxoF9hK+HYLNil3RgToFvQ2LmuBEDI
 tybD9DzE7dA/OvJ2kchjNMLyL830ZLxoFdr1Uhn8vA==
X-Google-Smtp-Source: AGHT+IEWqA4+Y672SDgdBCJGp0TrU5J1XH1v+VUw9wTkkGrQOO3w0MioTeNr0JAVxU60TQje9/Se6fbwJPqRhNngk5M=
X-Received: by 2002:a17:90a:db08:b0:26b:3f10:820f with SMTP id
 g8-20020a17090adb0800b0026b3f10820fmr18154009pjv.36.1693202549287; Sun, 27
 Aug 2023 23:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
 <20230823083721.1318097-2-masahisa.kojima@linaro.org>
 <ZOagOlRLw8cOsFM7@octopus>
 <CADQ0-X_3KeWE72jO2ymiCgE-_uU8URBsQVHGryi_41O7oqXYUg@mail.gmail.com>
 <d03a441a-a7a9-f6f8-5eb1-36ed5924d70b@gmx.de>
In-Reply-To: <d03a441a-a7a9-f6f8-5eb1-36ed5924d70b@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 28 Aug 2023 15:02:18 +0900
Message-ID: <CADQ0-X9nTg3CxXLK347dr1Gw4kJ-vBqoJRNdtxv-JeJscTWcJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: efidebug: add uri device path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de, 
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

Hi Heinrich,

On Sat, 26 Aug 2023 at 11:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/25/23 07:57, Masahisa Kojima wrote:
> > On Thu, 24 Aug 2023 at 09:11, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> >>
> >> Hi Kojima-san,
> >>
> >> On Wed, Aug 23, 2023 at 05:37:19PM +0900, Masahisa Kojima wrote:
> >>> This adds the URI device path option for 'boot add' subcommand.
> >>> User can add the URI load option for downloading ISO image file
> >>> or EFI application through network(e.g. HTTP).
> >>>
> >>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >>> ---
> >>>   cmd/efidebug.c | 39 +++++++++++++++++++++++++++++++++++++++
> >>>   1 file changed, 39 insertions(+)
> >>>
> >>> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> >>> index 0be3af3e76..62f867df2a 100644
> >>> --- a/cmd/efidebug.c
> >>> +++ b/cmd/efidebug.c
> >>> @@ -829,6 +829,44 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
> >>>                        argc -= 1;
> >>>                        argv += 1;
> >>>                        break;
> >>> +             case 'u':
> >>> +             {
> >>> +                     char *pos;
> >>> +                     int uridp_len;
> >>> +                     struct efi_device_path_uri *uridp;
> >>> +
> >>> +                     if (argc <  3 || lo.label) {
> >>> +                             r = CMD_RET_USAGE;
> >>> +                             goto out;
> >>> +                     }
> >>> +                     id = (int)hextoul(argv[1], &endp);
> >>> +                     if (*endp != '\0' || id > 0xffff)
> >>> +                             return CMD_RET_USAGE;
> >>> +
> >>> +                     efi_create_indexed_name(var_name16, sizeof(var_name16),
> >>> +                                             "Boot", id);
> >>> +
> >>> +                     label = efi_convert_string(argv[2]);
> >>> +                     if (!label)
> >>> +                             return CMD_RET_FAILURE;
> >>> +                     lo.label = label;
> >>> +
> >>> +                     uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
> >>> +                     fp_free = efi_alloc(uridp_len + sizeof(END));
> >>> +                     uridp = (struct efi_device_path_uri *)fp_free;
> >>> +                     uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> >>> +                     uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> >>> +                     uridp->dp.length = uridp_len;
> >>> +                     strcpy(uridp->uri, argv[3]);
> >>> +                     pos = (char *)uridp + uridp_len;
> >>> +                     memcpy(pos, &END, sizeof(END));
> >>> +                     fp_size += uridp_len + sizeof(END);
> >>> +                     file_path = (struct efi_device_path *)uridp;
> >>> +                     argc -= 3;
> >>> +                     argv += 3;
> >>> +                     break;
> >>> +             }
> >>> +
> >>>                default:
> >>>                        r = CMD_RET_USAGE;
> >>>                        goto out;
> >>> @@ -1492,6 +1530,7 @@ static char efidebug_help_text[] =
> >>>        "  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
> >>>        "  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
> >>>        "  (-b, -i for short form device path)\n"
> >>> +     "  -u <bootid> <label> <uri>\n"
> >>
> >> It might be a matter of personal preference, but
> >> since the current syntax of efidebug is already much complex,
> >> I don't want to add more options unless it's necessary.
> >> How about re-using "-B" option, say
> >>     => efidebug -B 3 debian-netinst uri - https://foo.com/baa
>
> You just replace one set of alternatives (-B -b -u) against another
> (mmc, nvme, uri, ...). I cannot see that this reduces complexity.
>
> >
> > I understand your concern. OK, I will add uri in -b|B and also update
> > documentation.
>
> It is unclear to me what the difference between -b and -B shall be for
> URIs. Would -B be with the device path of the network device
> (/VenHw()/MAC()/URI()) and -b without (/URI())?

Differentiating -b and -B for URI is not mandatory, I think.
To keep implementation simple, I would like to add '-u' option as the
original patch does.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> >
> > Thanks,
> > Masahisa Kojima
> >
> >>
> >> BTW, I think that <bootid> and <label> should have been moved out of "-b|B"
> >> when Ilias introduced this new syntax.
> >>
> >> -Takahiro Akashi
> >>
> >>
> >>>        "  -s '<optional data>'\n"
> >>>        "efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
> >>>        "  - delete UEFI BootXXXX variables\n"
> >>> --
> >>> 2.34.1
> >>>
>
