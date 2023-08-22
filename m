Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956CAEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F15D386EE9;
	Tue, 22 Aug 2023 05:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C3uuorPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B27871C2; Tue, 22 Aug 2023 05:23:10 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A12B867D2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4ff9abf18f9so5982083e87.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674586; x=1693279386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4E1Dk6hDOlyQ48NlJW02k9ZtaD0EbMk7sS+NJpvY1Po=;
 b=C3uuorPJt/JzOf08N7M5LdAMLPXUSwQnJc6n7Mue/FvD3iy7oqzL1P6jcr5NbqTMe0
 RmsyqmvWgUIzzchuKXOb5PjD1haf+brIkNE8HiLDq/3P79ZTYhs/gKEHzjj7xQ1cfYXX
 3COx3ljqpuO8c1gDSqt3Y8QrOkJ+ZTpxHUv9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674586; x=1693279386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4E1Dk6hDOlyQ48NlJW02k9ZtaD0EbMk7sS+NJpvY1Po=;
 b=WlvFq7MdoRmBws8o0WVukqv8aqhOtlWXhvkA6lO5V6ecSRhfI9efwKE9ir8l4gp9UP
 y1SpksSbJiNlOQfdBCkJsM+ZBtCgwa/csEyfH67nXhsJSuLFjTUYzDcThwrLyFJv3Qtm
 P/E7D6Mqb6xKZz1Fo2GeXJXO9XvryXCA9uJ8GU6t1gmT6jly2vWvw/yXnxBmRzELgyzA
 QvyM8pQYc5nN/kkB226ZDkQynYtAjHM4ZSmfdIiFUcptvA9wthEgztBxZSj4AccIVRq2
 YWJ1P0NgK8DTmvtTLZb2eUZiVO22EgCWrLb8UNPKBcKRX+sxoAcV+SRHAQoFFdhWTXWN
 hcpA==
X-Gm-Message-State: AOJu0YyK/63faR/aSd0EDcZ5od9LCEhJkLeL8bDsyNx2VSqJqVgORdwi
 OQxx9p/24yHZu2cfSOxduIwcs5W/ZKZbQMlar1CaWNO4n8A5sS9U4VE=
X-Google-Smtp-Source: AGHT+IFV4h6z1g7q1MrO1mmNlGfbKkpiIixsRccbV17Ob1gB51fcSfR+TfJ6kj0ZeFz+hqjjVx0lwaSTwqUW86IQ2dk=
X-Received: by 2002:a19:6d1b:0:b0:4fe:f2e:6cfd with SMTP id
 i27-20020a196d1b000000b004fe0f2e6cfdmr5381978lfc.62.1692674586308; Mon, 21
 Aug 2023 20:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230822024611.32977-1-takahiro.akashi@linaro.org>
In-Reply-To: <20230822024611.32977-1-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 21:22:54 -0600
Message-ID: <CAPnjgZ1AqoeO1UV7Hbo-XGPXOXL7odtqLdzyOAkXXZHMn7p67Q@mail.gmail.com>
Subject: Re: [PATCH] cmd: dm: allow for selecting uclass and device
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de
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

Hi AKASHI,

On Mon, 21 Aug 2023 at 20:46, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> The output from "dm tree" or "dm uclass" is a bit annoying
> if the number of devices available on the system is huge.
> (This is especially true on sandbox when I debug some DM code.)
>
> With this patch, we can specify the uclass or the device
> that we are interested in in order to limit the output.
>
> For instance,
>
> => dm uclass usb
> uclass 121: usb
> 0     usb@1 @ 0bd008b0, seq 1
>
> => dm tree usb:usb@1

Perhaps this should just provide a substring to search for and it can
find everything with a uclass name or device name that contains the
string?

Otherwise, can you drop the usb. part ? Is it needed?

>  Class     Index  Probed  Driver                Name
> -----------------------------------------------------------
>  usb           0  [   ]   usb_sandbox           usb@1
>  usb_hub       0  [   ]   usb_hub               `-- hub
>  usb_emul      0  [   ]   usb_sandbox_hub           `-- hub-emul
>  usb_emul      1  [   ]   usb_sandbox_flash             |-- flash-stick@0
>  usb_emul      2  [   ]   usb_sandbox_flash             |-- flash-stick@1
>  usb_emul      3  [   ]   usb_sandbox_flash             |-- flash-stick@2
>  usb_emul      4  [   ]   usb_sandbox_keyb              `-- keyb@3
>
> Please note that, at "dm tree", the uclass name (usb) as well as
> the device name (usb@1) is required.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  cmd/dm.c            | 30 ++++++++++++++++++++--------
>  drivers/core/dump.c | 48 +++++++++++++++++++++++++++++++++++++++------
>  include/dm/util.h   | 13 ++++++++----
>  3 files changed, 73 insertions(+), 18 deletions(-)

Thanks, I've been wanting this for ages.

Can you please add doc/ as well?

>
> diff --git a/cmd/dm.c b/cmd/dm.c
> index 3263547cbec6..99268df2f87a 100644
> --- a/cmd/dm.c
> +++ b/cmd/dm.c
> @@ -59,11 +59,20 @@ static int do_dm_dump_static_driver_info(struct cmd_tbl *cmdtp, int flag,
>  static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
>                            char *const argv[])
>  {
> -       bool sort;
> +       bool sort = false;
> +       char *device = NULL;
>
> -       sort = argc > 1 && !strcmp(argv[1], "-s");
> +       if (argc > 1) {
> +               if (!strcmp(argv[1], "-s")) {
> +                       sort = true;
> +                       argc--;
> +                       argv++;
> +               }
> +               if (argc > 1)
> +                       device = argv[1];
> +       }
>
> -       dm_dump_tree(sort);
> +       dm_dump_tree(device, sort);
>
>         return 0;
>  }
> @@ -71,7 +80,12 @@ static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
>  static int do_dm_dump_uclass(struct cmd_tbl *cmdtp, int flag, int argc,
>                              char *const argv[])
>  {
> -       dm_dump_uclass();
> +       char *uclass = NULL;
> +
> +       if (argc > 1)
> +               uclass = argv[1];
> +
> +       dm_dump_uclass(uclass);
>
>         return 0;
>  }
> @@ -91,8 +105,8 @@ static char dm_help_text[] =
>         "dm drivers       Dump list of drivers with uclass and instances\n"
>         DM_MEM_HELP
>         "dm static        Dump list of drivers with static platform data\n"
> -       "dm tree [-s]     Dump tree of driver model devices (-s=sort)\n"
> -       "dm uclass        Dump list of instances for each uclass"
> +       "dm tree [-s][name] Dump tree of driver model devices (-s=sort)\n"
> +       "dm uclass [name] Dump list of instances for each uclass"
>         ;
>  #endif
>
> @@ -102,5 +116,5 @@ U_BOOT_CMD_WITH_SUBCMDS(dm, "Driver model low level access", dm_help_text,
>         U_BOOT_SUBCMD_MKENT(drivers, 1, 1, do_dm_dump_drivers),
>         DM_MEM
>         U_BOOT_SUBCMD_MKENT(static, 1, 1, do_dm_dump_static_driver_info),
> -       U_BOOT_SUBCMD_MKENT(tree, 2, 1, do_dm_dump_tree),
> -       U_BOOT_SUBCMD_MKENT(uclass, 1, 1, do_dm_dump_uclass));
> +       U_BOOT_SUBCMD_MKENT(tree, 3, 1, do_dm_dump_tree),
> +       U_BOOT_SUBCMD_MKENT(uclass, 2, 1, do_dm_dump_uclass));
> diff --git a/drivers/core/dump.c b/drivers/core/dump.c
> index 3e77832a3a00..855d6ca002b7 100644
> --- a/drivers/core/dump.c
> +++ b/drivers/core/dump.c
> @@ -85,11 +85,35 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
>         }
>  }
>
> -void dm_dump_tree(bool sort)
> +void dm_dump_tree(char *uclass, bool sort)
>  {
>         struct udevice *root;
>
> -       root = dm_root();
> +       if (uclass) {
> +               char *device;
> +               enum uclass_id id;
> +
> +               device = strchr(uclass, ':');
> +               if (!device) {
> +                       printf("name %s: invalid format\n", uclass);
> +                       return;
> +               }

Can the parsing needs to happen in the caller? This might be called
from SPL, for example. We don't want it returning an error

> +               *device = '\0';
> +               device++;
> +
> +               id = uclass_get_by_name(uclass);
> +               if (id == UCLASS_INVALID) {
> +                       printf("uclass %s: not found\n", uclass);
> +                       return;
> +               }
> +               if (uclass_find_device_by_name(id, device, &root)) {
> +                       printf("device %s:%s: not found\n", uclass, device);
> +                       return;
> +               }
> +       } else {
> +               root = dm_root();
> +       }
> +
>         if (root) {
>                 int dev_count, uclasses;
>                 struct udevice **devs = NULL;
> @@ -127,13 +151,25 @@ static void dm_display_line(struct udevice *dev, int index)
>         puts("\n");
>  }
>
> -void dm_dump_uclass(void)
> +void dm_dump_uclass(char *uclass)
>  {
>         struct uclass *uc;
> -       int ret;
> -       int id;
> +       enum uclass_id id;
> +       int count, ret;
> +
> +       if (uclass) {
> +               id = uclass_get_by_name(uclass);
> +               if (id == UCLASS_INVALID) {
> +                       printf("uclass %s: not found\n", uclass);
> +                       return;
> +               }
> +               count = 1;
> +       } else {
> +               id = 0;
> +               count = UCLASS_COUNT;
> +       }
>
> -       for (id = 0; id < UCLASS_COUNT; id++) {
> +       for ( ; count; id++, count--) {
>                 struct udevice *dev;
>                 int i = 0;
>
> diff --git a/include/dm/util.h b/include/dm/util.h
> index 4bb49e9e8c01..ee1b34c103e3 100644
> --- a/include/dm/util.h
> +++ b/include/dm/util.h
> @@ -27,14 +27,19 @@ struct list_head;
>  int list_count_items(struct list_head *head);
>
>  /**
> - * Dump out a tree of all devices
> + * Dump out a tree of all devices starting @uclass
>   *
> + * @uclass: uclass+device name

yes, but what does it mean?

>   * @sort: Sort by uclass name
>   */
> -void dm_dump_tree(bool sort);
> +void dm_dump_tree(char *uclass, bool sort);
>
> -/* Dump out a list of uclasses and their devices */
> -void dm_dump_uclass(void);
> +/*
> + * Dump out a list of uclasses and their devices
> + *
> + * @uclass: uclass name

That's a bit vague. What is it for?

> + */
> +void dm_dump_uclass(char *uclass);
>
>  #ifdef CONFIG_DEBUG_DEVRES
>  /* Dump out a list of device resources */
> --
> 2.34.1
>

Regards,
Simon
