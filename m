Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E1AEE49A5
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 00:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F60E86407;
	Wed, 23 Aug 2023 02:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b3YUxxYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B24686403; Wed, 23 Aug 2023 02:15:05 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DDD86420
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 02:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a56ed12c0so479141b3a.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 17:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692749700; x=1693354500;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=go0AsT6xzlh1TBAcwjkq+ppk0+es0eHFFiLwI7+eWyo=;
 b=b3YUxxYvbZZxHpSd44fZ9QMrniL+tPDWnOassin8zWWC/b+tCxtY2eNXRb2DDIw3Kl
 zI6af0pF1N5tOwbaFcp1vKNma5RJAo8oIBnch+MQmF+tMOYISVO2ux2bWUdM35xrO4RZ
 xfvL/rIm9Yenr9G37E4Xbar/Rlm9LpFs4xC6MLKN6Gmezq6dLvdRW3TSRA0VEDJ1vUOw
 eZO6++nzM4hbJuU5BrjBwCi83t7zhqhmPw0BXiXY4tVNeZAE2jAl7z/eSj6bl69zCo5T
 m1Luh6eR6NcBAyCRhdur2rv1pUH3QIG9w1SRHVz7tgg31IvZKs/sv+VElXnT1Gm5fQ/q
 wOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692749700; x=1693354500;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=go0AsT6xzlh1TBAcwjkq+ppk0+es0eHFFiLwI7+eWyo=;
 b=ZohWoX1Ah8XO8LzM92zrdNiU/K06y5hLvxnSN9Ic54/ImJOsgr5Ky02WT0SQYMbvbZ
 v43JFYuEK2Q79b1QPv4I9d4+ACn/5cV2OWlPt6cJgfQZLMx7JCTP9AlDIyUIPRQA+8A5
 YrXkzJizkapzUDpa7xoB2/7c3RzN+6nBbWZ90Izx9kkh4ssT+mwd5VafaVkuhMp6uF2R
 NKQMkxcXvM4aItX4LhqD3uh2+Fif5zN3OsP1FW/LVL0kKnY+2/G9vIttNhLb3IVyT9du
 2sOdlL/Q+k4HrGiNR8hfMUGZ8PDZT8CV3OzPQCz7OjuMd3v+hY/7djPgazKtY4lH1/rn
 JYTw==
X-Gm-Message-State: AOJu0YxclutvNkAAfHanVC+c5LRPaIz4BmYcO/XLdsZP3rWFQy9+XKhr
 f1Cxn7yJEjO3Dj7G5ZtRXNVr6g==
X-Google-Smtp-Source: AGHT+IGGEsTFuU/1oWIJCJeoneoBaU2j0CK3ZW58U5WXx43l6TfnZ7f/acsznMhALpVYwo4XJKe2ZA==
X-Received: by 2002:a05:6a00:3107:b0:68a:4bf9:3b21 with SMTP id
 bi7-20020a056a00310700b0068a4bf93b21mr7821385pfb.0.1692749700254; 
 Tue, 22 Aug 2023 17:15:00 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:c42c:e1e7:4c2:47d8])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a62e40d000000b00686f0133b49sm8284661pfh.63.2023.08.22.17.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 17:14:59 -0700 (PDT)
Date: Wed, 23 Aug 2023 09:14:57 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: dm: allow for selecting uclass and device
Message-ID: <ZOVPgTwvgp05BmcO@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230822024611.32977-1-takahiro.akashi@linaro.org>
 <CAPnjgZ1AqoeO1UV7Hbo-XGPXOXL7odtqLdzyOAkXXZHMn7p67Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1AqoeO1UV7Hbo-XGPXOXL7odtqLdzyOAkXXZHMn7p67Q@mail.gmail.com>
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

On Mon, Aug 21, 2023 at 09:22:54PM -0600, Simon Glass wrote:
> Hi AKASHI,
> 
> On Mon, 21 Aug 2023 at 20:46, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > The output from "dm tree" or "dm uclass" is a bit annoying
> > if the number of devices available on the system is huge.
> > (This is especially true on sandbox when I debug some DM code.)
> >
> > With this patch, we can specify the uclass or the device
> > that we are interested in in order to limit the output.
> >
> > For instance,
> >
> > => dm uclass usb
> > uclass 121: usb
> > 0     usb@1 @ 0bd008b0, seq 1
> >
> > => dm tree usb:usb@1
> 
> Perhaps this should just provide a substring to search for and it can
> find everything with a uclass name or device name that contains the
> string?

Well, I wanted to implement the feature with minimum effort,
using the existing API, like uclass_find_device_by_name().

Well, I'll try.

> Otherwise, can you drop the usb. part ? Is it needed?
> 
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
> > Please note that, at "dm tree", the uclass name (usb) as well as
> > the device name (usb@1) is required.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  cmd/dm.c            | 30 ++++++++++++++++++++--------
> >  drivers/core/dump.c | 48 +++++++++++++++++++++++++++++++++++++++------
> >  include/dm/util.h   | 13 ++++++++----
> >  3 files changed, 73 insertions(+), 18 deletions(-)
> 
> Thanks, I've been wanting this for ages.

Me, too :)

> Can you please add doc/ as well?

Yes.

> >
> > diff --git a/cmd/dm.c b/cmd/dm.c
> > index 3263547cbec6..99268df2f87a 100644
> > --- a/cmd/dm.c
> > +++ b/cmd/dm.c
> > @@ -59,11 +59,20 @@ static int do_dm_dump_static_driver_info(struct cmd_tbl *cmdtp, int flag,
> >  static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
> >                            char *const argv[])
> >  {
> > -       bool sort;
> > +       bool sort = false;
> > +       char *device = NULL;
> >
> > -       sort = argc > 1 && !strcmp(argv[1], "-s");
> > +       if (argc > 1) {
> > +               if (!strcmp(argv[1], "-s")) {
> > +                       sort = true;
> > +                       argc--;
> > +                       argv++;
> > +               }
> > +               if (argc > 1)
> > +                       device = argv[1];
> > +       }
> >
> > -       dm_dump_tree(sort);
> > +       dm_dump_tree(device, sort);
> >
> >         return 0;
> >  }
> > @@ -71,7 +80,12 @@ static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
> >  static int do_dm_dump_uclass(struct cmd_tbl *cmdtp, int flag, int argc,
> >                              char *const argv[])
> >  {
> > -       dm_dump_uclass();
> > +       char *uclass = NULL;
> > +
> > +       if (argc > 1)
> > +               uclass = argv[1];
> > +
> > +       dm_dump_uclass(uclass);
> >
> >         return 0;
> >  }
> > @@ -91,8 +105,8 @@ static char dm_help_text[] =
> >         "dm drivers       Dump list of drivers with uclass and instances\n"
> >         DM_MEM_HELP
> >         "dm static        Dump list of drivers with static platform data\n"
> > -       "dm tree [-s]     Dump tree of driver model devices (-s=sort)\n"
> > -       "dm uclass        Dump list of instances for each uclass"
> > +       "dm tree [-s][name] Dump tree of driver model devices (-s=sort)\n"
> > +       "dm uclass [name] Dump list of instances for each uclass"
> >         ;
> >  #endif
> >
> > @@ -102,5 +116,5 @@ U_BOOT_CMD_WITH_SUBCMDS(dm, "Driver model low level access", dm_help_text,
> >         U_BOOT_SUBCMD_MKENT(drivers, 1, 1, do_dm_dump_drivers),
> >         DM_MEM
> >         U_BOOT_SUBCMD_MKENT(static, 1, 1, do_dm_dump_static_driver_info),
> > -       U_BOOT_SUBCMD_MKENT(tree, 2, 1, do_dm_dump_tree),
> > -       U_BOOT_SUBCMD_MKENT(uclass, 1, 1, do_dm_dump_uclass));
> > +       U_BOOT_SUBCMD_MKENT(tree, 3, 1, do_dm_dump_tree),
> > +       U_BOOT_SUBCMD_MKENT(uclass, 2, 1, do_dm_dump_uclass));
> > diff --git a/drivers/core/dump.c b/drivers/core/dump.c
> > index 3e77832a3a00..855d6ca002b7 100644
> > --- a/drivers/core/dump.c
> > +++ b/drivers/core/dump.c
> > @@ -85,11 +85,35 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
> >         }
> >  }
> >
> > -void dm_dump_tree(bool sort)
> > +void dm_dump_tree(char *uclass, bool sort)
> >  {
> >         struct udevice *root;
> >
> > -       root = dm_root();
> > +       if (uclass) {
> > +               char *device;
> > +               enum uclass_id id;
> > +
> > +               device = strchr(uclass, ':');
> > +               if (!device) {
> > +                       printf("name %s: invalid format\n", uclass);
> > +                       return;
> > +               }
> 
> Can the parsing needs to happen in the caller? This might be called
> from SPL, for example. We don't want it returning an error

Do you mean that all the messages should be suppressed
in dm_dump_tree()?

> > +               *device = '\0';
> > +               device++;
> > +
> > +               id = uclass_get_by_name(uclass);
> > +               if (id == UCLASS_INVALID) {
> > +                       printf("uclass %s: not found\n", uclass);
> > +                       return;
> > +               }
> > +               if (uclass_find_device_by_name(id, device, &root)) {
> > +                       printf("device %s:%s: not found\n", uclass, device);
> > +                       return;
> > +               }
> > +       } else {
> > +               root = dm_root();
> > +       }
> > +
> >         if (root) {
> >                 int dev_count, uclasses;
> >                 struct udevice **devs = NULL;
> > @@ -127,13 +151,25 @@ static void dm_display_line(struct udevice *dev, int index)
> >         puts("\n");
> >  }
> >
> > -void dm_dump_uclass(void)
> > +void dm_dump_uclass(char *uclass)
> >  {
> >         struct uclass *uc;
> > -       int ret;
> > -       int id;
> > +       enum uclass_id id;
> > +       int count, ret;
> > +
> > +       if (uclass) {
> > +               id = uclass_get_by_name(uclass);
> > +               if (id == UCLASS_INVALID) {
> > +                       printf("uclass %s: not found\n", uclass);
> > +                       return;
> > +               }
> > +               count = 1;
> > +       } else {
> > +               id = 0;
> > +               count = UCLASS_COUNT;
> > +       }
> >
> > -       for (id = 0; id < UCLASS_COUNT; id++) {
> > +       for ( ; count; id++, count--) {
> >                 struct udevice *dev;
> >                 int i = 0;
> >
> > diff --git a/include/dm/util.h b/include/dm/util.h
> > index 4bb49e9e8c01..ee1b34c103e3 100644
> > --- a/include/dm/util.h
> > +++ b/include/dm/util.h
> > @@ -27,14 +27,19 @@ struct list_head;
> >  int list_count_items(struct list_head *head);
> >
> >  /**
> > - * Dump out a tree of all devices
> > + * Dump out a tree of all devices starting @uclass
> >   *
> > + * @uclass: uclass+device name
> 
> yes, but what does it mean?

In v1, the command expects "<uclass name>:<udevice name>" here
so that we can use uclass_find_device_by_name().
I will relax this restriction, by allowing "forward-matching"
against a device name, in v2.


> >   * @sort: Sort by uclass name
> >   */
> > -void dm_dump_tree(bool sort);
> > +void dm_dump_tree(char *uclass, bool sort);
> >
> > -/* Dump out a list of uclasses and their devices */
> > -void dm_dump_uclass(void);
> > +/*
> > + * Dump out a list of uclasses and their devices
> > + *
> > + * @uclass: uclass name
> 
> That's a bit vague. What is it for?

Literally, a uclass name like "usb".
Does it sound ambiguous?

-Takahiro Akashi


> > + */
> > +void dm_dump_uclass(char *uclass);
> >
> >  #ifdef CONFIG_DEBUG_DEVRES
> >  /* Dump out a list of device resources */
> > --
> > 2.34.1
> >
> 
> Regards,
> Simon
