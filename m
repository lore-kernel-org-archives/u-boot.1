Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520CCC83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 04:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C0D386554;
	Thu, 31 Aug 2023 06:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SISulg/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5028655A; Thu, 31 Aug 2023 06:34:54 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18EBF8083C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 06:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bf7b5e1f06so808805ad.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 21:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693456489; x=1694061289; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KV4eiQAmeEAczxibaJj9RQiwGpxIcl2aSEV33gYZ5bc=;
 b=SISulg/NrW29IvKiAFyiztCstJC9VPXJJmm1uUNh3mRqiysjFi0nx5YQW0IT8Z5v85
 bWvKqMp2Zm1EKrNZH+lDEVlrH0ZLDV0SWjIxd7hoKVNDq14VIZI6xhOXj7DesmoAtnJC
 LXrx8GZFXgWMn8YT9qQwhEAJFuouY25flLjdk3XqgSKysOVQo+FHiYk+19NmZnzVxMOE
 m/6zd9CL+7xNjNcMaqEtVvAB+aIZiYI4kgE+BKRZvMSxyvZ+i8u/kYcvda1jJAKGXNYo
 J4rVLT2j+iNtp8Bgih0zGf2VwJYt0dY/E1BvjQHJXa3YtRUZIc6JN52dn2p+EcMpMu4T
 IpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693456489; x=1694061289;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KV4eiQAmeEAczxibaJj9RQiwGpxIcl2aSEV33gYZ5bc=;
 b=XXdcSJGL4ZmIamzx6XTqI2cN755qVJP2tNaCJj1hPutD9shP98E3ucixSkcmvkhBTi
 31deVdg+XbqpuBDJZeyXjSkGTydJpqqWvLNY8aX2ZPr4DDC7e7XVfrWjwJy5z31zK/Op
 dX1wDnKkrpgMrzjrFvrNzIN/RbkTL+B6JbzorZxVcQ4q0dIEJc3nGZubD/q0rW2L/OkJ
 P6HHqf1CxftF2oDuK2LWsC0vXtsXSmQrBtthAooSZQPIVOIYrzVyGXZniZz6Dwb4Dn0T
 Zml5BbYpxKL6B9udaeTBxcd/AnlnE+r3vb4Yvh4evPA0RYEO8R1Oknt8LHkIHBZq9Xrk
 wl3g==
X-Gm-Message-State: AOJu0YyzWhmLLUUUv8QL3Jo3ffH3f8PHKNeTOQH/nfLA0Vbmq0GjfkrZ
 33RaK9foSe3H/+nShXNVkQJlGw==
X-Google-Smtp-Source: AGHT+IH3iUwyags6lxSDVIUMKqKp2xSsm/80xq4is3NW8aDLaaJstOQXPq1vf9cUjgpDRCKnPU/9tQ==
X-Received: by 2002:a05:6a20:8f28:b0:14d:7b6:cf2d with SMTP id
 b40-20020a056a208f2800b0014d07b6cf2dmr4890122pzk.0.1693456489159; 
 Wed, 30 Aug 2023 21:34:49 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:15e5:d5f9:7b14:839d])
 by smtp.gmail.com with ESMTPSA id
 o28-20020a63921c000000b0055386b1415dsm433393pgd.51.2023.08.30.21.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 21:34:48 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:34:46 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: dm: allow for selecting uclass and device
Message-ID: <ZPAYZnzF+KeIwMMr@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230823014947.20876-1-takahiro.akashi@linaro.org>
 <CAPnjgZ3XKONQXhcjU0sU=3GNx8D4VjVUhSQ5de0dsVFt1bb54w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3XKONQXhcjU0sU=3GNx8D4VjVUhSQ5de0dsVFt1bb54w@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 09:48:48PM -0600, Simon Glass wrote:
> Hi AKASHI,
> 
> On Tue, 22 Aug 2023 at 19:50, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > The output from "dm tree" or "dm uclass" is a bit annoying
> > if the number of devices available on the system is huge.
> > (This is especially true on sandbox when I debug some DM code.)
> >
> > With this patch, we can specify the uclass name or the device
> > name that we are interested in in order to limit the output.
> >
> > For instance,
> >
> > => dm uclass usb
> > uclass 121: usb
> > 0     usb@1 @ 0bcff8b0, seq 1
> >
> > uclass 124: usb
> >
> > => dm tree usb:usb@1
> >  Class     Index  Probed  Driver                Name
> > -----------------------------------------------------------
> >  usb           0  [   ]   usb_sandbox           usb@1
> >  usb_hub       0  [   ]   usb_hub               `-- hub
> >  usb_emul      0  [   ]   usb_sandbox_hub           `-- hub-emul
> >  usb_emul      1  [   ]   usb_sandbox_flash             |-- flash-stick@0
> >  usb_emul      2  [   ]   usb_sandbox_flash             |-- flash-stick@1
> >  usb_emul      3  [   ]   usb_sandbox_flash             |-- flash-stick@2
> >  usb_emul      4  [   ]   usb_sandbox_keyb              `-- keyb@3
> >
> > If you want forward-matching against a uclass or udevice name,
> > you can specify "-e" option.
> 
> I don't really know what 'forward matching' means.

Really? I believed that forward-matching was a common word.
I meant that it searches for any string starting with
a specific sub-string. In other words, it would be
"^<sub-string>" in a regular expression.
So, for example, "usb" should match with "usbABC", "usb-DEF",
"usb_GHI" and so on, but not match with "ABCusb".

> Please use forward instead of forword in the code
> 
> >
> > => dm uclass -e usb
> > uclass 15: usb_emul
> > 0     hub-emul @ 0bcffb00, seq 0
> > 1     flash-stick@0 @ 0bcffc30, seq 1
> > 2     flash-stick@1 @ 0bcffdc0, seq 2
> > 3     flash-stick@2 @ 0bcfff50, seq 3
> > 4     keyb@3 @ 0bd000e0, seq 4
> >
> > uclass 64: usb_mass_storage
> >
> > uclass 121: usb
> > 0     usb@1 @ 0bcff8b0, seq 1
> >
> > uclass 122: usb_dev_generic
> >
> > uclass 123: usb_hub
> > 0     hub @ 0bcff9b0, seq 0
> >
> > uclass 124: usb
> >
> > => dm tree -e usb
> >  Class     Index  Probed  Driver                Name
> > -----------------------------------------------------------
> >  usb           0  [   ]   usb_sandbox           usb@1
> >  usb_hub       0  [   ]   usb_hub               `-- hub
> >  usb_emul      0  [   ]   usb_sandbox_hub           `-- hub-emul
> >  usb_emul      1  [   ]   usb_sandbox_flash             |-- flash-stick@0
> >  usb_emul      2  [   ]   usb_sandbox_flash             |-- flash-stick@1
> >  usb_emul      3  [   ]   usb_sandbox_flash             |-- flash-stick@2
> >  usb_emul      4  [   ]   usb_sandbox_keyb              `-- keyb@3
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> > v2
> > - allow for forward-matching against the name
> > - update command doc
> > ---
> >  cmd/dm.c             |  48 ++++++++++++++----
> >  doc/usage/cmd/dm.rst |  30 ++++++++++-
> >  drivers/core/dump.c  | 116 ++++++++++++++++++++++++++++++++-----------
> >  include/dm/util.h    |  15 ++++--
> >  4 files changed, 165 insertions(+), 44 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Thanks for doing this. It will be a big time-saver. I also wonder if
> it would be better if the default were to do a substring search and

Initially, I implemented so, but felt it is annoying to see
(sometimes many) unexpected matched devices, especially
when you know the exact name of device.
See my example "dm uclass -e usb".

> you have to add a flag to search for a single device?

Does 'single' mean the first matched word or exactly-same one?

Either way, I don't have a strong opinion here, though.

Thanks,
-Takahiro Akashi

> 
> See below
> 
> >
> > diff --git a/cmd/dm.c b/cmd/dm.c
> > index 3263547cbec6..1aa86aab9c1c 100644
> > --- a/cmd/dm.c
> > +++ b/cmd/dm.c
> > @@ -59,11 +59,26 @@ static int do_dm_dump_static_driver_info(struct cmd_tbl *cmdtp, int flag,
> >  static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
> >                            char *const argv[])
> >  {
> > -       bool sort;
> > -
> > -       sort = argc > 1 && !strcmp(argv[1], "-s");
> > -
> > -       dm_dump_tree(sort);
> > +       bool extended = false, sort = false;
> > +       char *device = NULL;
> > +
> > +       for (; argc > 1; argc--, argv++) {
> > +               if (argv[1][0] != '-')
> > +                       break;
> > +
> > +               if (!strcmp(argv[1], "-e")) {
> > +                       extended = true;
> > +               } else if (!strcmp(argv[1], "-s")) {
> > +                       sort = true;
> > +               } else {
> > +                       printf("Unknown parameter: %s\n", argv[1]);
> > +                       return 0;
> > +               }
> > +       }
> > +       if (argc > 1)
> > +               device = argv[1];
> > +
> > +       dm_dump_tree(device, extended, sort);
> >
> >         return 0;
> >  }
> > @@ -71,7 +86,20 @@ static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
> >  static int do_dm_dump_uclass(struct cmd_tbl *cmdtp, int flag, int argc,
> >                              char *const argv[])
> >  {
> > -       dm_dump_uclass();
> > +       bool extended = false;
> > +       char *uclass = NULL;
> > +
> > +       if (argc > 1) {
> > +               if (!strcmp(argv[1], "-e")) {
> > +                       extended = true;
> > +                       argc--;
> > +                       argv++;
> > +               }
> > +               if (argc > 1)
> > +                       uclass = argv[1];
> > +       }
> > +
> > +       dm_dump_uclass(uclass, extended);
> >
> >         return 0;
> >  }
> > @@ -91,8 +119,8 @@ static char dm_help_text[] =
> >         "dm drivers       Dump list of drivers with uclass and instances\n"
> >         DM_MEM_HELP
> >         "dm static        Dump list of drivers with static platform data\n"
> > -       "dm tree [-s]     Dump tree of driver model devices (-s=sort)\n"
> > -       "dm uclass        Dump list of instances for each uclass"
> > +       "dm tree [-s][-e][name]   Dump tree of driver model devices (-s=sort)\n"
> > +       "dm uclass [-e][name]     Dump list of instances for each uclass"
> >         ;
> >  #endif
> >
> > @@ -102,5 +130,5 @@ U_BOOT_CMD_WITH_SUBCMDS(dm, "Driver model low level access", dm_help_text,
> >         U_BOOT_SUBCMD_MKENT(drivers, 1, 1, do_dm_dump_drivers),
> >         DM_MEM
> >         U_BOOT_SUBCMD_MKENT(static, 1, 1, do_dm_dump_static_driver_info),
> > -       U_BOOT_SUBCMD_MKENT(tree, 2, 1, do_dm_dump_tree),
> > -       U_BOOT_SUBCMD_MKENT(uclass, 1, 1, do_dm_dump_uclass));
> > +       U_BOOT_SUBCMD_MKENT(tree, 4, 1, do_dm_dump_tree),
> > +       U_BOOT_SUBCMD_MKENT(uclass, 3, 1, do_dm_dump_uclass));
> > diff --git a/doc/usage/cmd/dm.rst b/doc/usage/cmd/dm.rst
> > index 74c6b01e3619..12b7edeed685 100644
> > --- a/doc/usage/cmd/dm.rst
> > +++ b/doc/usage/cmd/dm.rst
> > @@ -12,8 +12,8 @@ Synopis
> >      dm devres
> >      dm drivers
> >      dm static
> > -    dm tree [-s]
> > -    dm uclass
> > +    dm tree [-s][-e] [uclass name]
> > +    dm uclass [-e] [udevice name]
> >
> >  Description
> >  -----------
> > @@ -127,6 +127,12 @@ If -s is given, the top-level devices (those which are children of the root
> >  device) are shown sorted in order of uclass ID, so it is easier to find a
> >  particular device type.
> >
> > +If -e is given, forward-matching against existing devices is
> > +made and only the matched devices are shown.
> 
> I don't understand this...can you expand it a bit so it is clear what
> -e does and what forward-matching is?
> 
> > +
> > +If a device name is given, forward-matching against existing devices is
> > +made and only the matched devices are shown.
> > +
> >  dm uclass
> >  ~~~~~~~~~
> 
> Regards,
> Simon
