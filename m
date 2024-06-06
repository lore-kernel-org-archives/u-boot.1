Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94833C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE7E58848F;
	Thu,  6 Jun 2024 14:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JRgm1H0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF9087D40; Thu,  6 Jun 2024 12:17:11 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537A18780E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 12:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=muvarov@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a69607c6ccaso78760566b.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717669029; x=1718273829; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdhrg4nw4FISvoHoJL4f9PdkFlO2WZrSEpeo2CNFAAg=;
 b=JRgm1H0ygehNUTVQbGiq4rCUERtAWkG8xb12XL1WpbnZKo6pq7CRtdlm+7f7+NliXl
 FhOJ0faAZbUEohcCavmW4IVevYbcYm9hjO6wTxaa7dk5OU5TLeh9p3qEiwEpuI/lMqaY
 BIyoi3tSHuKdLmfpsKonAAisM5csO7qi+YB1uTqIjspp5E3itgKl+Ho0WlNlFrB1P0Eg
 MUsGlM8yB+L382DveWHDw7+ZTaXTsiMvar079Hh34TgyXrf0XoYi6338Lv4mjR6kaWuO
 FyVv9OqVyM2PFQiUDIROUvG5k7mL+zIM0OAdNwF4ISLRANjFu5r9AnwgxQGQf2OIIT2W
 M5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717669029; x=1718273829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdhrg4nw4FISvoHoJL4f9PdkFlO2WZrSEpeo2CNFAAg=;
 b=dtWhr+qOIvAw/a5aUJo34gTv+1OWIOw/rRsbG0cteqkH+Na2wEq0J2DoKPUBhLPiSK
 RkPjBVsgNPxwKpLHvR3SDrkcF7e7qi34JiLj+t6bf4Vp3a7qLa0sVs+/GWOYFqj7KBA1
 LMv4a7SMPSRF67d8FSrPHE+8scf9JZBzOV+3VDHQvs/LWPJ/aI78uAqJO/0fpsleh8g4
 vFhWCSfNlokL6HDhy0krsSuk/f9tJ9h5JPZsuZbG175rfnnJfcu9DTinjsODg+dXw5Nx
 TLACsAPFWlLxvvdfKTkRb5H+ocP+rJkmaVJJScdctFb1PuRTekVp09f+Bp+EGgtjmNUB
 bE0w==
X-Gm-Message-State: AOJu0YwN6kkA0WG+rZEnwzaOCLoUg1ezmfR3KYyW7r9OJ6vkFGHDXJKK
 n2gF0gKftRDNfrIuzxVS/vK6Gmqpk8s4tvZVHoOZtT2FOkDlr+bxxbEi3Jl8G/2HNOLYkvjR2yp
 FQRdyinyM/X6W+OljFSb8Vu0MJdc=
X-Google-Smtp-Source: AGHT+IGRk3q66Im9IogaBquG479wIMrDE59dP5Vbo0SVdpx+Ln5f7SRBGofa6/ZT5Heq9jlVtQIaZevsEyDmUeoWmko=
X-Received: by 2002:a17:906:a184:b0:a67:7649:3c38 with SMTP id
 a640c23a62f3a-a69a024ce58mr299940066b.49.1717669028362; Thu, 06 Jun 2024
 03:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <98a1de5f01dad1ad55b68ebadcbad1f6357246a6.1716566960.git.jerome.forissier@linaro.org>
 <CAJGZr0LjFDH5XETPRwSKVS_=KCDbdf9Mi0NneFwyM7_YOXi4OQ@mail.gmail.com>
 <e6c307e8-5621-42e2-9c89-024a93e11496@linaro.org>
In-Reply-To: <e6c307e8-5621-42e2-9c89-024a93e11496@linaro.org>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Thu, 6 Jun 2024 13:16:56 +0300
Message-ID: <CAJGZr0Lu_ZUMOLpFGuvARW5FzC8jKo1iEBxds9xJQet7RHM4iw@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] net-lwip: add wget command
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 06 Jun 2024 14:31:15 +0200
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

=D1=87=D1=82, 6 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 12:56, Jero=
me Forissier <jerome.forissier@linaro.org>:
>
>
>
> On 5/28/24 15:39, Maxim Uvarov wrote:
> > =D0=BF=D1=82, 24 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 19:22, =
Jerome Forissier <jerome.forissier@linaro.org>:
> >>
> >> Add support for the wget command with NET_LWIP.
> >>
> >> About the small change in cmd/efidebug.c: when the wget command based
> >> on the lwIP stack is used the wget command has a built-in URL
> >> validation function since it needs to parse it anyways (in parse_url()=
).
> >> Therefore wget_validate_uri() doesn't exist. So, guard the call in
> >> efidebug.c with CONFIG_CMD_WGET.
> >>
> >> Based on code initially developed by Maxim U.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
> >> Cc: Maxim Uvarov <muvarov@gmail.com>
> >> ---
> >>  cmd/Kconfig        |   7 ++
> >>  cmd/Makefile       |   5 +-
> >>  cmd/efidebug.c     |   8 +-
> >>  cmd/net-common.c   | 112 ++++++++++++++++++++++++++++
> >>  cmd/net-lwip.c     |  12 +++
> >>  cmd/net.c          | 115 -----------------------------
> >>  include/net-lwip.h |  51 +++++++++++++
> >>  net-lwip/Makefile  |   1 +
> >>  net-lwip/wget.c    | 180 ++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  9 files changed, 372 insertions(+), 119 deletions(-)
> >>  create mode 100644 cmd/net-common.c
> >>  create mode 100644 net-lwip/wget.c
> >>
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index 6ef0b52cd34..d9a86540be6 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -2117,6 +2117,13 @@ config CMD_TFTPBOOT
> >>         help
> >>           tftpboot - load file via network using TFTP protocol
> >>
> >> +config CMD_WGET
> >> +       bool "wget"
> >> +       select PROT_TCP_LWIP
> >> +       help
> >> +         wget is a simple command to download kernel, or other files,
> >> +         from a http server over TCP.
> >> +
> >>  endif
> >>
> >>  endif
> >> diff --git a/cmd/Makefile b/cmd/Makefile
> >> index 535b6838ca5..e90f2f68211 100644
> >> --- a/cmd/Makefile
> >> +++ b/cmd/Makefile
> >> @@ -129,8 +129,11 @@ obj-$(CONFIG_CMD_MUX) +=3D mux.o
> >>  obj-$(CONFIG_CMD_NAND) +=3D nand.o
> >>  obj-$(CONFIG_CMD_NET) +=3D net.o
> >>  obj-$(CONFIG_CMD_NET_LWIP) +=3D net-lwip.o
> >> +obj-$(filter y,$(CONFIG_CMD_NET) $(CONFIG_CMD_NET_LWIP)) +=3D net-com=
mon.o
> >>  ifdef CONFIG_CMD_NET_LWIP
> >> -CFLAGS_net-lwip.o :=3D -I$(srctree)/lib/lwip/lwip/src/include -I$(src=
tree)/lib/lwip/u-boot
> >> +lwip-includes :=3D -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree=
)/lib/lwip/u-boot
> >> +CFLAGS_net-lwip.o :=3D $(lwip-includes)
> >> +CFLAGS_net-common.o :=3D $(lwip-includes)
> >>  endif
> >>  obj-$(CONFIG_ENV_SUPPORT) +=3D nvedit.o
> >>  obj-$(CONFIG_CMD_NVEDIT_EFI) +=3D nvedit_efi.o
> >> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> >> index c2c525f2351..d80e91ecadd 100644
> >> --- a/cmd/efidebug.c
> >> +++ b/cmd/efidebug.c
> >> @@ -741,9 +741,11 @@ static int efi_boot_add_uri(int argc, char *const=
 argv[], u16 *var_name16,
> >>         if (!label)
> >>                 return CMD_RET_FAILURE;
> >>
> >> -       if (!wget_validate_uri(argv[3])) {
> >> -               printf("ERROR: invalid URI\n");
> >> -               return CMD_RET_FAILURE;
> >> +       if (IS_ENABLED(CONFIG_CMD_WGET)) {
> >> +               if (!wget_validate_uri(argv[3])) {
> >> +                       printf("ERROR: invalid URI\n");
> >> +                       return CMD_RET_FAILURE;
> >> +               }
> >>         }
> >>
> >>         efi_create_indexed_name(var_name16, var_name16_size, "Boot", i=
d);
> >> diff --git a/cmd/net-common.c b/cmd/net-common.c
> >> new file mode 100644
> >> index 00000000000..b5dfd2c8866
> >> --- /dev/null
> >> +++ b/cmd/net-common.c
> >> @@ -0,0 +1,112 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * (C) Copyright 2000
> >> + * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> >> + */
> >> +
> >> +#include <command.h>
> >> +#include <dm/device.h>
> >> +#include <dm/uclass.h>
> >> +#ifdef CONFIG_NET
> >> +#include <net.h>
> >> +#elif defined CONFIG_NET_LWIP
> >> +#include <net-lwip.h>
> >> +#else
> >> +#error Either NET or NET_LWIP must be enabled
> >> +#endif
> >> +#include <linux/compat.h>
> >> +#include <linux/ethtool.h>
> >> +
> >> +static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, cha=
r *const argv[])
> >> +{
> >> +       const struct udevice *current =3D eth_get_dev();
> >> +       unsigned char env_enetaddr[ARP_HLEN];
> >> +       const struct udevice *dev;
> >> +       struct uclass *uc;
> >> +
> >> +       uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
> >> +               eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env=
_enetaddr);
> >> +               printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name,=
 env_enetaddr,
> >> +                      current =3D=3D dev ? "active" : "");
> >> +       }
> >> +       return CMD_RET_SUCCESS;
> >> +}
> >> +
> >> +static int do_net_stats(struct cmd_tbl *cmdtp, int flag, int argc, ch=
ar *const argv[])
> >> +{
> >> +       int nstats, err, i, off;
> >> +       struct udevice *dev;
> >> +       u64 *values;
> >> +       u8 *strings;
> >> +
> >> +       if (argc < 2)
> >> +               return CMD_RET_USAGE;
> >> +
> >> +       err =3D uclass_get_device_by_name(UCLASS_ETH, argv[1], &dev);
> >> +       if (err) {
> >> +               printf("Could not find device %s\n", argv[1]);
> >> +               return CMD_RET_FAILURE;
> >> +       }
> >> +
> >> +       if (!eth_get_ops(dev)->get_sset_count ||
> >> +           !eth_get_ops(dev)->get_strings ||
> >> +           !eth_get_ops(dev)->get_stats) {
> >> +               printf("Driver does not implement stats dump!\n");
> >> +               return CMD_RET_FAILURE;
> >> +       }
> >> +
> >> +       nstats =3D eth_get_ops(dev)->get_sset_count(dev);
> >> +       strings =3D kcalloc(nstats, ETH_GSTRING_LEN, GFP_KERNEL);
> >> +       if (!strings)
> >> +               return CMD_RET_FAILURE;
> >> +
> >> +       values =3D kcalloc(nstats, sizeof(u64), GFP_KERNEL);
> >> +       if (!values)
> >> +               goto err_free_strings;
> >> +
> >> +       eth_get_ops(dev)->get_strings(dev, strings);
> >> +       eth_get_ops(dev)->get_stats(dev, values);
> >> +
> >> +       off =3D 0;
> >> +       for (i =3D 0; i < nstats; i++) {
> >> +               printf("  %s: %llu\n", &strings[off], values[i]);
> >> +               off +=3D ETH_GSTRING_LEN;
> >> +       };
> >> +
> >
> > It looks like here you missed kfree().
>
> Good catch! This is already missing in master (cmd/net.c). I will fix
> in v3 and also send a patch for master.
>
> >> +       return CMD_RET_SUCCESS;
> >> +
> >> +err_free_strings:
> >> +       kfree(strings);
> >> +
> >> +       return CMD_RET_FAILURE;
> >> +}
> >> +
>
> [...]
>
> >> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
> >> new file mode 100644
> >> index 00000000000..25b75040806
> >> --- /dev/null
> >> +++ b/net-lwip/wget.c
> >> @@ -0,0 +1,180 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/* Copyright (C) 2024 Linaro Ltd. */
> >> +
> >> +#include <command.h>
> >> +#include <console.h>
> >> +#include <display_options.h>
> >> +#include <image.h>
> >> +#include <lwip/apps/http_client.h>
> >> +#include <lwip/timeouts.h>
> >> +#include <net-lwip.h>
> >> +#include <time.h>
> >> +
>
> [...]
> >> +
> >> +static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
> >> +                           u32_t rx_content_len, u32_t srv_res, err_t=
 err)
> >> +{
> >> +       ulong elapsed;
> >> +
> >> +       if (httpc_result !=3D HTTPC_RESULT_OK) {
> >> +               log_err("\nHTTP client error %d\n", httpc_result);
> >> +               done =3D FAILURE;
> >> +               return;
> >> +       }
> >> +
> >> +       elapsed =3D get_timer(start_time);
> >> +        log_info("\n%u bytes transferred in %lu ms (", rx_content_len=
,
> >
> > This print I commented for another patch to match current python tests.
>
> What do you mean? Is this text incorrect because some tests expect someth=
ing
> else? Which ones?

You modified the python test to expect this output if LWIP is enabled.
Instead of adding one
more 'if LWIP' to the python test you can make this log_info() output
the same as the original code.
But this is up to you. Somebody sometime later will need to drop 'if
LWIP' from python code.

BR,
Maxim.
>
> >> +                 get_timer(start_time));
> >> +        print_size(rx_content_len / elapsed * 1000, "/s)\n");
> >> +
> >> +       if (env_set_hex("filesize", rx_content_len) ||
> >> +           env_set_hex("fileaddr", saved_daddr)) {
> >> +               log_err("Could not set filesize or fileaddr\n");
> >> +               done =3D FAILURE;
> >> +               return;
> >> +       }
> >> +
> >> +       done =3D SUCCESS;
> >> +}
> >> +
> >> +int wget_with_dns(ulong dst_addr, char *uri)
> >
> > static?
>
> No, this function is called from lib/efi_loader/efi_bootmgr.c.
>
> >> +{
> >> +       char server_name[SERVER_NAME_SIZE];
> >> +       httpc_connection_t conn;
> >> +       httpc_state_t *state;
> >> +       char *path;
> >> +       u16 port;
> >> +
> >> +       daddr =3D dst_addr;
> >> +       saved_daddr =3D dst_addr;
> >> +       done =3D NOT_DONE;
> >> +       size =3D 0;
> >> +       prevsize =3D 0;
> >> +
> >> +       if (parse_url(uri, server_name, &port, &path))
> >> +               return CMD_RET_USAGE;
> >> +
> >> +       memset(&conn, 0, sizeof(conn));
> >> +       conn.result_fn =3D httpc_result_cb;
> >> +       start_time =3D get_timer(0);
> >> +       if (httpc_get_file_dns(server_name, port, path, &conn, httpc_r=
ecv_cb,
> >> +                              NULL, &state))
> >> +               return CMD_RET_FAILURE;
> >> +
> >> +       while (!done) {
> >> +               eth_rx();
> >> +               sys_check_timeouts();
> >> +               if (ctrlc())
> >> +                       break;
> >> +       }
> >> +
> >> +       if (done =3D=3D SUCCESS)
> >> +               return 0;
> >> +
> >> +       return -1;
> >> +}
> >> +
> >> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const a=
rgv[])
> >> +{
> >> +       char *url;
> >> +       ulong dst_addr;
> >> +
> >> +       if (argc < 2 || argc > 3)
> >> +               return CMD_RET_USAGE;
> >> +
> >> +       dst_addr =3D image_load_addr;
> >> +
> >> +       if (!strncmp(argv[1], "0x", 2)) {
> >
> > As I remember u-boot can eat hex and decimal numbers for arguments for
> > most of the commands.
>
> Right. I'll use hextoul() properly in v3.
>
> >> +               if (argc < 3)
> >> +                       return CMD_RET_USAGE;
> >> +               dst_addr =3D hextoul(argv[1], NULL);
> >> +               url =3D argv[2];
> >> +       } else {
> >> +               url =3D argv[1];
> >> +       }
> >> +
> >> +       if (wget_with_dns(dst_addr, url))
> >> +               return CMD_RET_FAILURE;
> >> +
> >> +       return CMD_RET_SUCCESS;
> >> +}
> >> --
> >> 2.40.1
>
> Thanks,
> --
> Jerome



--=20
Best regards,
Maxim Uvarov
