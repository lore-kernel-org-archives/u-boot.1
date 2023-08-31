Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF01DC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC28486550;
	Thu, 31 Aug 2023 05:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LL0EmMLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE6D86550; Thu, 31 Aug 2023 05:49:03 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29148654A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so388973a12.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693453740; x=1694058540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=id0AfkcoSatLa3jYeNCeKn9xELm1T537pxRveibXe9k=;
 b=LL0EmMLdPynJrtFST6PN9S0JDWNZwX8YKm0wIERJXV9n3NFrs/G1dSgEIG2pSajUNY
 62cp3uiNxHeFmryx0qiMSj+9Mw5RRMHV1DpCFuDK55IQpjYVPXDo1O6wWf/c/kg+0emj
 zFUFk9NKexp2rMtCmwM6c+074+96yYmhFu/uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693453740; x=1694058540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=id0AfkcoSatLa3jYeNCeKn9xELm1T537pxRveibXe9k=;
 b=NVB/2NObNHUm+RST06n3niLmRawF8ObylTmCKeGVCao4ex+qdlMD5Kk/a8vUIbx4SN
 1GnDeX0u8cRIDDn/LEgoO4evtRQVGrNNO5uWSeU1dMgqhOrWNSyhNwutfoOmFDNHu49t
 ftJXMcWvHVUGQZRVROu5OpPt6VHRF4M0Q7JNdSp8/gyNQ/4cNrKXGlxOlaQrEF9bbA9c
 AXqG2Z5rlzIJTM5QEyjdLOzKFhyo9aO3CciFQArk8fGO7SdbQmwfkVKe7s+mZW6tVpQP
 4CAqoGKYjJGfj6ER07K5WHjmX1KBXhMC7ztGdvlcIyRyc90TzCaot+pIJytlIWk2rYV5
 DHGg==
X-Gm-Message-State: AOJu0YzOJVnAAcltuOVMuzUrT/8mIh3ZAiDfVPqluBdsyEe5RUJUXwIb
 7KGKc6qzjcw8Y++WjvHZiu1qbngbDfdnVi0C1Heupj7kFNDFaV2WA+0jsA==
X-Google-Smtp-Source: AGHT+IGPixkNZrnip2A5/jOir8S2LF0MMPOjkenPA+ZjaAEb7n7y5TniGv86ivhxfTmoNuaMt/BvYVoHeAMbTldFF4M=
X-Received: by 2002:aa7:de0e:0:b0:52a:40cf:4dff with SMTP id
 h14-20020aa7de0e000000b0052a40cf4dffmr3089785edv.9.1693453740208; Wed, 30 Aug
 2023 20:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230823014947.20876-1-takahiro.akashi@linaro.org>
In-Reply-To: <20230823014947.20876-1-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 21:48:48 -0600
Message-ID: <CAPnjgZ3XKONQXhcjU0sU=3GNx8D4VjVUhSQ5de0dsVFt1bb54w@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: dm: allow for selecting uclass and device
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

On Tue, 22 Aug 2023 at 19:50, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> The output from "dm tree" or "dm uclass" is a bit annoying
> if the number of devices available on the system is huge.
> (This is especially true on sandbox when I debug some DM code.)
>
> With this patch, we can specify the uclass name or the device
> name that we are interested in in order to limit the output.
>
> For instance,
>
> => dm uclass usb
> uclass 121: usb
> 0     usb@1 @ 0bcff8b0, seq 1
>
> uclass 124: usb
>
> => dm tree usb:usb@1
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
> If you want forward-matching against a uclass or udevice name,
> you can specify "-e" option.

I don't really know what 'forward matching' means.

Please use forward instead of forword in the code

>
> => dm uclass -e usb
> uclass 15: usb_emul
> 0     hub-emul @ 0bcffb00, seq 0
> 1     flash-stick@0 @ 0bcffc30, seq 1
> 2     flash-stick@1 @ 0bcffdc0, seq 2
> 3     flash-stick@2 @ 0bcfff50, seq 3
> 4     keyb@3 @ 0bd000e0, seq 4
>
> uclass 64: usb_mass_storage
>
> uclass 121: usb
> 0     usb@1 @ 0bcff8b0, seq 1
>
> uclass 122: usb_dev_generic
>
> uclass 123: usb_hub
> 0     hub @ 0bcff9b0, seq 0
>
> uclass 124: usb
>
> => dm tree -e usb
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
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> v2
> - allow for forward-matching against the name
> - update command doc
> ---
>  cmd/dm.c             |  48 ++++++++++++++----
>  doc/usage/cmd/dm.rst |  30 ++++++++++-
>  drivers/core/dump.c  | 116 ++++++++++++++++++++++++++++++++-----------
>  include/dm/util.h    |  15 ++++--
>  4 files changed, 165 insertions(+), 44 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks for doing this. It will be a big time-saver. I also wonder if
it would be better if the default were to do a substring search and
you have to add a flag to search for a single device?

See below

>
> diff --git a/cmd/dm.c b/cmd/dm.c
> index 3263547cbec6..1aa86aab9c1c 100644
> --- a/cmd/dm.c
> +++ b/cmd/dm.c
> @@ -59,11 +59,26 @@ static int do_dm_dump_static_driver_info(struct cmd_tbl *cmdtp, int flag,
>  static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
>                            char *const argv[])
>  {
> -       bool sort;
> -
> -       sort = argc > 1 && !strcmp(argv[1], "-s");
> -
> -       dm_dump_tree(sort);
> +       bool extended = false, sort = false;
> +       char *device = NULL;
> +
> +       for (; argc > 1; argc--, argv++) {
> +               if (argv[1][0] != '-')
> +                       break;
> +
> +               if (!strcmp(argv[1], "-e")) {
> +                       extended = true;
> +               } else if (!strcmp(argv[1], "-s")) {
> +                       sort = true;
> +               } else {
> +                       printf("Unknown parameter: %s\n", argv[1]);
> +                       return 0;
> +               }
> +       }
> +       if (argc > 1)
> +               device = argv[1];
> +
> +       dm_dump_tree(device, extended, sort);
>
>         return 0;
>  }
> @@ -71,7 +86,20 @@ static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
>  static int do_dm_dump_uclass(struct cmd_tbl *cmdtp, int flag, int argc,
>                              char *const argv[])
>  {
> -       dm_dump_uclass();
> +       bool extended = false;
> +       char *uclass = NULL;
> +
> +       if (argc > 1) {
> +               if (!strcmp(argv[1], "-e")) {
> +                       extended = true;
> +                       argc--;
> +                       argv++;
> +               }
> +               if (argc > 1)
> +                       uclass = argv[1];
> +       }
> +
> +       dm_dump_uclass(uclass, extended);
>
>         return 0;
>  }
> @@ -91,8 +119,8 @@ static char dm_help_text[] =
>         "dm drivers       Dump list of drivers with uclass and instances\n"
>         DM_MEM_HELP
>         "dm static        Dump list of drivers with static platform data\n"
> -       "dm tree [-s]     Dump tree of driver model devices (-s=sort)\n"
> -       "dm uclass        Dump list of instances for each uclass"
> +       "dm tree [-s][-e][name]   Dump tree of driver model devices (-s=sort)\n"
> +       "dm uclass [-e][name]     Dump list of instances for each uclass"
>         ;
>  #endif
>
> @@ -102,5 +130,5 @@ U_BOOT_CMD_WITH_SUBCMDS(dm, "Driver model low level access", dm_help_text,
>         U_BOOT_SUBCMD_MKENT(drivers, 1, 1, do_dm_dump_drivers),
>         DM_MEM
>         U_BOOT_SUBCMD_MKENT(static, 1, 1, do_dm_dump_static_driver_info),
> -       U_BOOT_SUBCMD_MKENT(tree, 2, 1, do_dm_dump_tree),
> -       U_BOOT_SUBCMD_MKENT(uclass, 1, 1, do_dm_dump_uclass));
> +       U_BOOT_SUBCMD_MKENT(tree, 4, 1, do_dm_dump_tree),
> +       U_BOOT_SUBCMD_MKENT(uclass, 3, 1, do_dm_dump_uclass));
> diff --git a/doc/usage/cmd/dm.rst b/doc/usage/cmd/dm.rst
> index 74c6b01e3619..12b7edeed685 100644
> --- a/doc/usage/cmd/dm.rst
> +++ b/doc/usage/cmd/dm.rst
> @@ -12,8 +12,8 @@ Synopis
>      dm devres
>      dm drivers
>      dm static
> -    dm tree [-s]
> -    dm uclass
> +    dm tree [-s][-e] [uclass name]
> +    dm uclass [-e] [udevice name]
>
>  Description
>  -----------
> @@ -127,6 +127,12 @@ If -s is given, the top-level devices (those which are children of the root
>  device) are shown sorted in order of uclass ID, so it is easier to find a
>  particular device type.
>
> +If -e is given, forward-matching against existing devices is
> +made and only the matched devices are shown.

I don't understand this...can you expand it a bit so it is clear what
-e does and what forward-matching is?

> +
> +If a device name is given, forward-matching against existing devices is
> +made and only the matched devices are shown.
> +
>  dm uclass
>  ~~~~~~~~~

Regards,
Simon
