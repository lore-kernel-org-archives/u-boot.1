Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946FBC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B7288596;
	Tue, 28 May 2024 18:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YZ2/27mR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05278841F; Tue, 28 May 2024 15:40:00 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70CFB883A5
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=muvarov@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so148158666b.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716903598; x=1717508398; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cY3j9BcW3XDljdR6sEEvzJsmlUy7nsUy7e8O3sskGc=;
 b=YZ2/27mRBtuGUeMA8ZntGtSm6mrJhMHUrvb6cPZqZTzCKubvfrIs+FdTFYGDhCmpno
 7mgEXP1RSs0j51CkLwWU0Pd+qgb3mCkYEw5K4mEXdIzQhuLR0ee1aOyt3GCweBWNAdBx
 0wTIvVemHd3Dlf/0oDQy6EGJtiEHD9pHRc7dJCwbpmoywoqMS7shqD8nlaiy0TcDmVFi
 JsltUczMaeLe6yXjjgVWdaan0VK/m8fhrXf9r0iIqZYhiBgJpQarsRKFY5hjcX4L+HMp
 yECLkWEkox1M7Bi608Df1rzWZ5V0frQMTlmnguU6eCS3NPugUAva+EewjhKqL4lWdmoL
 TYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716903598; x=1717508398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cY3j9BcW3XDljdR6sEEvzJsmlUy7nsUy7e8O3sskGc=;
 b=nksDbqMAuAWwn6U7S3rt4PVrqV5u04t3hyEs9YgaU8eKgukPVLC651bvqb4tIuXIev
 xjLPBsSTfQzPPoM1e01H0N2MLy2CkioTqDDw5KQTfp1PFlB+JYIiDh/eDQhJeDVs5KiM
 27j1zNENAfWuL4u7hQ32kT4p8BSXyY4URcXlWaQwyX/vJrKTWlpV/4O8yuMM1IKmWYMW
 Moe9YBKrpMQdDoy97JibvqQdlrjaiM1b/rrVMSzfT52Nit3dtIMjOlWnR6J8xeGGaTsT
 5E2D970YkwNSLi/VC5pxTGVpjwAd5gV34iD1XWHmEz5YxKg9NOApSc1WFCsi26BMUeLE
 /fyA==
X-Gm-Message-State: AOJu0YzesfV9lBjyCX6ZI6UZnjhczhDZTqrgsYGkyg4lfOt5vkGZvr9U
 f52J4RmCAtP3ybGZNLSe3RcQaXHEAFO4DdUNhMtKU55dYQsHh4DOI8oQ6L+lBNmW8joSu48oUJr
 R53rzu1iSgtlOEW8iaWYMjkSepxU=
X-Google-Smtp-Source: AGHT+IH5jk7GRDASoAQhjZRTTz+TM4XARWDzitx587UTlc4CNcYKHew9KI4E4wF/r2LCsPmfN3vNPWdwiLhmkmlsMrg=
X-Received: by 2002:a17:906:3955:b0:a63:5138:4f4 with SMTP id
 a640c23a62f3a-a6351380549mr89186466b.35.1716903597457; Tue, 28 May 2024
 06:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <98a1de5f01dad1ad55b68ebadcbad1f6357246a6.1716566960.git.jerome.forissier@linaro.org>
In-Reply-To: <98a1de5f01dad1ad55b68ebadcbad1f6357246a6.1716566960.git.jerome.forissier@linaro.org>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Tue, 28 May 2024 16:39:43 +0300
Message-ID: <CAJGZr0LjFDH5XETPRwSKVS_=KCDbdf9Mi0NneFwyM7_YOXi4OQ@mail.gmail.com>
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
X-Mailman-Approved-At: Tue, 28 May 2024 18:47:36 +0200
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

=D0=BF=D1=82, 24 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 19:22, Jero=
me Forissier <jerome.forissier@linaro.org>:
>
> Add support for the wget command with NET_LWIP.
>
> About the small change in cmd/efidebug.c: when the wget command based
> on the lwIP stack is used the wget command has a built-in URL
> validation function since it needs to parse it anyways (in parse_url()).
> Therefore wget_validate_uri() doesn't exist. So, guard the call in
> efidebug.c with CONFIG_CMD_WGET.
>
> Based on code initially developed by Maxim U.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
> Cc: Maxim Uvarov <muvarov@gmail.com>
> ---
>  cmd/Kconfig        |   7 ++
>  cmd/Makefile       |   5 +-
>  cmd/efidebug.c     |   8 +-
>  cmd/net-common.c   | 112 ++++++++++++++++++++++++++++
>  cmd/net-lwip.c     |  12 +++
>  cmd/net.c          | 115 -----------------------------
>  include/net-lwip.h |  51 +++++++++++++
>  net-lwip/Makefile  |   1 +
>  net-lwip/wget.c    | 180 +++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 372 insertions(+), 119 deletions(-)
>  create mode 100644 cmd/net-common.c
>  create mode 100644 net-lwip/wget.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 6ef0b52cd34..d9a86540be6 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2117,6 +2117,13 @@ config CMD_TFTPBOOT
>         help
>           tftpboot - load file via network using TFTP protocol
>
> +config CMD_WGET
> +       bool "wget"
> +       select PROT_TCP_LWIP
> +       help
> +         wget is a simple command to download kernel, or other files,
> +         from a http server over TCP.
> +
>  endif
>
>  endif
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 535b6838ca5..e90f2f68211 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -129,8 +129,11 @@ obj-$(CONFIG_CMD_MUX) +=3D mux.o
>  obj-$(CONFIG_CMD_NAND) +=3D nand.o
>  obj-$(CONFIG_CMD_NET) +=3D net.o
>  obj-$(CONFIG_CMD_NET_LWIP) +=3D net-lwip.o
> +obj-$(filter y,$(CONFIG_CMD_NET) $(CONFIG_CMD_NET_LWIP)) +=3D net-common=
.o
>  ifdef CONFIG_CMD_NET_LWIP
> -CFLAGS_net-lwip.o :=3D -I$(srctree)/lib/lwip/lwip/src/include -I$(srctre=
e)/lib/lwip/u-boot
> +lwip-includes :=3D -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/l=
ib/lwip/u-boot
> +CFLAGS_net-lwip.o :=3D $(lwip-includes)
> +CFLAGS_net-common.o :=3D $(lwip-includes)
>  endif
>  obj-$(CONFIG_ENV_SUPPORT) +=3D nvedit.o
>  obj-$(CONFIG_CMD_NVEDIT_EFI) +=3D nvedit_efi.o
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index c2c525f2351..d80e91ecadd 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -741,9 +741,11 @@ static int efi_boot_add_uri(int argc, char *const ar=
gv[], u16 *var_name16,
>         if (!label)
>                 return CMD_RET_FAILURE;
>
> -       if (!wget_validate_uri(argv[3])) {
> -               printf("ERROR: invalid URI\n");
> -               return CMD_RET_FAILURE;
> +       if (IS_ENABLED(CONFIG_CMD_WGET)) {
> +               if (!wget_validate_uri(argv[3])) {
> +                       printf("ERROR: invalid URI\n");
> +                       return CMD_RET_FAILURE;
> +               }
>         }
>
>         efi_create_indexed_name(var_name16, var_name16_size, "Boot", id);
> diff --git a/cmd/net-common.c b/cmd/net-common.c
> new file mode 100644
> index 00000000000..b5dfd2c8866
> --- /dev/null
> +++ b/cmd/net-common.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2000
> + * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> + */
> +
> +#include <command.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +#ifdef CONFIG_NET
> +#include <net.h>
> +#elif defined CONFIG_NET_LWIP
> +#include <net-lwip.h>
> +#else
> +#error Either NET or NET_LWIP must be enabled
> +#endif
> +#include <linux/compat.h>
> +#include <linux/ethtool.h>
> +
> +static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, char *=
const argv[])
> +{
> +       const struct udevice *current =3D eth_get_dev();
> +       unsigned char env_enetaddr[ARP_HLEN];
> +       const struct udevice *dev;
> +       struct uclass *uc;
> +
> +       uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
> +               eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_en=
etaddr);
> +               printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name, en=
v_enetaddr,
> +                      current =3D=3D dev ? "active" : "");
> +       }
> +       return CMD_RET_SUCCESS;
> +}
> +
> +static int do_net_stats(struct cmd_tbl *cmdtp, int flag, int argc, char =
*const argv[])
> +{
> +       int nstats, err, i, off;
> +       struct udevice *dev;
> +       u64 *values;
> +       u8 *strings;
> +
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
> +       err =3D uclass_get_device_by_name(UCLASS_ETH, argv[1], &dev);
> +       if (err) {
> +               printf("Could not find device %s\n", argv[1]);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       if (!eth_get_ops(dev)->get_sset_count ||
> +           !eth_get_ops(dev)->get_strings ||
> +           !eth_get_ops(dev)->get_stats) {
> +               printf("Driver does not implement stats dump!\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       nstats =3D eth_get_ops(dev)->get_sset_count(dev);
> +       strings =3D kcalloc(nstats, ETH_GSTRING_LEN, GFP_KERNEL);
> +       if (!strings)
> +               return CMD_RET_FAILURE;
> +
> +       values =3D kcalloc(nstats, sizeof(u64), GFP_KERNEL);
> +       if (!values)
> +               goto err_free_strings;
> +
> +       eth_get_ops(dev)->get_strings(dev, strings);
> +       eth_get_ops(dev)->get_stats(dev, values);
> +
> +       off =3D 0;
> +       for (i =3D 0; i < nstats; i++) {
> +               printf("  %s: %llu\n", &strings[off], values[i]);
> +               off +=3D ETH_GSTRING_LEN;
> +       };
> +

It looks like here you missed kfree().

> +       return CMD_RET_SUCCESS;
> +
> +err_free_strings:
> +       kfree(strings);
> +
> +       return CMD_RET_FAILURE;
> +}
> +
> +static struct cmd_tbl cmd_net[] =3D {
> +       U_BOOT_CMD_MKENT(list, 1, 0, do_net_list, "", ""),
> +       U_BOOT_CMD_MKENT(stats, 2, 0, do_net_stats, "", ""),
> +};
> +
> +static int do_net(struct cmd_tbl *cmdtp, int flag, int argc, char *const=
 argv[])
> +{
> +       struct cmd_tbl *cp;
> +
> +       cp =3D find_cmd_tbl(argv[1], cmd_net, ARRAY_SIZE(cmd_net));
> +
> +       /* Drop the net command */
> +       argc--;
> +       argv++;
> +
> +       if (!cp || argc > cp->maxargs)
> +               return CMD_RET_USAGE;
> +       if (flag =3D=3D CMD_FLAG_REPEAT && !cmd_is_repeatable(cp))
> +               return CMD_RET_SUCCESS;
> +
> +       return cp->cmd(cmdtp, flag, argc, argv);
> +}
> +
> +U_BOOT_CMD(
> +       net, 3, 1, do_net,
> +       "NET sub-system",
> +       "list - list available devices\n"
> +       "stats <device> - dump statistics for specified device\n"
> +);
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index 3abafdf7969..b80375c831e 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -2,6 +2,10 @@
>  /* Copyright (C) 2024 Linaro Ltd. */
>
>  #include <command.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +#include <linux/compat.h>
> +#include <linux/ethtool.h>
>  #include <net-lwip.h>
>
>  #if defined(CONFIG_CMD_DHCP)
> @@ -35,3 +39,11 @@ U_BOOT_CMD(
>         "hostname [envvar]"
>  );
>  #endif
> +
> +#if defined(CONFIG_CMD_WGET)
> +U_BOOT_CMD(
> +       wget,   3,      1,      do_wget,
> +       "boot image via network using HTTP protocol",
> +       "[loadAddress] URL"
> +);
> +#endif
> diff --git a/cmd/net.c b/cmd/net.c
> index d407d8320a3..03b4582204f 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -676,118 +676,3 @@ U_BOOT_CMD(
>  );
>
>  #endif  /* CONFIG_CMD_LINK_LOCAL */
> -
> -static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, char *=
const argv[])
> -{
> -       const struct udevice *current =3D eth_get_dev();
> -       unsigned char env_enetaddr[ARP_HLEN];
> -       const struct udevice *dev;
> -       struct uclass *uc;
> -
> -       uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
> -               eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_en=
etaddr);
> -               printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name, en=
v_enetaddr,
> -                      current =3D=3D dev ? "active" : "");
> -       }
> -       return CMD_RET_SUCCESS;
> -}
> -
> -static int do_net_stats(struct cmd_tbl *cmdtp, int flag, int argc, char =
*const argv[])
> -{
> -       int nstats, err, i, off;
> -       struct udevice *dev;
> -       u64 *values;
> -       u8 *strings;
> -
> -       if (argc < 2)
> -               return CMD_RET_USAGE;
> -
> -       err =3D uclass_get_device_by_name(UCLASS_ETH, argv[1], &dev);
> -       if (err) {
> -               printf("Could not find device %s\n", argv[1]);
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       if (!eth_get_ops(dev)->get_sset_count ||
> -           !eth_get_ops(dev)->get_strings ||
> -           !eth_get_ops(dev)->get_stats) {
> -               printf("Driver does not implement stats dump!\n");
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       nstats =3D eth_get_ops(dev)->get_sset_count(dev);
> -       strings =3D kcalloc(nstats, ETH_GSTRING_LEN, GFP_KERNEL);
> -       if (!strings)
> -               return CMD_RET_FAILURE;
> -
> -       values =3D kcalloc(nstats, sizeof(u64), GFP_KERNEL);
> -       if (!values)
> -               goto err_free_strings;
> -
> -       eth_get_ops(dev)->get_strings(dev, strings);
> -       eth_get_ops(dev)->get_stats(dev, values);
> -
> -       off =3D 0;
> -       for (i =3D 0; i < nstats; i++) {
> -               printf("  %s: %llu\n", &strings[off], values[i]);
> -               off +=3D ETH_GSTRING_LEN;
> -       };
> -
> -       return CMD_RET_SUCCESS;
> -
> -err_free_strings:
> -       kfree(strings);
> -
> -       return CMD_RET_FAILURE;
> -}
> -
> -static struct cmd_tbl cmd_net[] =3D {
> -       U_BOOT_CMD_MKENT(list, 1, 0, do_net_list, "", ""),
> -       U_BOOT_CMD_MKENT(stats, 2, 0, do_net_stats, "", ""),
> -};
> -
> -static int do_net(struct cmd_tbl *cmdtp, int flag, int argc, char *const=
 argv[])
> -{
> -       struct cmd_tbl *cp;
> -
> -       cp =3D find_cmd_tbl(argv[1], cmd_net, ARRAY_SIZE(cmd_net));
> -
> -       /* Drop the net command */
> -       argc--;
> -       argv++;
> -
> -       if (!cp || argc > cp->maxargs)
> -               return CMD_RET_USAGE;
> -       if (flag =3D=3D CMD_FLAG_REPEAT && !cmd_is_repeatable(cp))
> -               return CMD_RET_SUCCESS;
> -
> -       return cp->cmd(cmdtp, flag, argc, argv);
> -}
> -
> -U_BOOT_CMD(
> -       net, 3, 1, do_net,
> -       "NET sub-system",
> -       "list - list available devices\n"
> -       "stats <device> - dump statistics for specified device\n"
> -);
> -
> -#if defined(CONFIG_CMD_NCSI)
> -static int do_ncsi(struct cmd_tbl *cmdtp, int flag, int argc, char * con=
st argv[])
> -{
> -       if (!phy_interface_is_ncsi() || !ncsi_active()) {
> -               printf("Device not configured for NC-SI\n");
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       if (net_loop(NCSI) < 0)
> -               return CMD_RET_FAILURE;
> -
> -       return CMD_RET_SUCCESS;
> -}
> -
> -U_BOOT_CMD(
> -       ncsi,   1,      1,      do_ncsi,
> -       "Configure attached NIC via NC-SI",
> -       ""
> -);
> -#endif  /* CONFIG_CMD_NCSI */
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 0019d1524e5..6fda940fec2 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -51,6 +51,56 @@ int eth_env_get_enetaddr_by_index(const char *base_nam=
e, int index,
>  int eth_init(void);                    /* Initialize the device */
>  int eth_send(void *packet, int length);           /* Send a packet */
>  int eth_rx(void);
> +
> +/**
> + * struct eth_ops - functions of Ethernet MAC controllers
> + *
> + * start: Prepare the hardware to send and receive packets
> + * send: Send the bytes passed in "packet" as a packet on the wire
> + * recv: Check if the hardware received a packet. If so, set the pointer=
 to the
> + *      packet buffer in the packetp parameter. If not, return an error =
or 0 to
> + *      indicate that the hardware receive FIFO is empty. If 0 is return=
ed, the
> + *      network stack will not process the empty packet, but free_pkt() =
will be
> + *      called if supplied
> + * free_pkt: Give the driver an opportunity to manage its packet buffer =
memory
> + *          when the network stack is finished processing it. This will =
only be
> + *          called when no error was returned from recv - optional
> + * stop: Stop the hardware from looking for packets - may be called even=
 if
> + *      state =3D=3D PASSIVE
> + * mcast: Join or leave a multicast group (for TFTP) - optional
> + * write_hwaddr: Write a MAC address to the hardware (used to pass it to=
 Linux
> + *              on some platforms like ARM). This function expects the
> + *              eth_pdata::enetaddr field to be populated. The method ca=
n
> + *              return -ENOSYS to indicate that this is not implemented =
for
> +                this hardware - optional.
> + * read_rom_hwaddr: Some devices have a backup of the MAC address stored=
 in a
> + *                 ROM on the board. This is how the driver should expos=
e it
> + *                 to the network stack. This function should fill in th=
e
> + *                 eth_pdata::enetaddr field - optional
> + * set_promisc: Enable or Disable promiscuous mode
> + * get_sset_count: Number of statistics counters
> + * get_string: Names of the statistic counters
> + * get_stats: The values of the statistic counters
> + */
> +struct eth_ops {
> +       int (*start)(struct udevice *dev);
> +       int (*send)(struct udevice *dev, void *packet, int length);
> +       int (*recv)(struct udevice *dev, int flags, uchar **packetp);
> +       int (*free_pkt)(struct udevice *dev, uchar *packet, int length);
> +       void (*stop)(struct udevice *dev);
> +       int (*mcast)(struct udevice *dev, const u8 *enetaddr, int join);
> +       int (*write_hwaddr)(struct udevice *dev);
> +       int (*read_rom_hwaddr)(struct udevice *dev);
> +       int (*set_promisc)(struct udevice *dev, bool enable);
> +       int (*get_sset_count)(struct udevice *dev);
> +       void (*get_strings)(struct udevice *dev, u8 *data);
> +       void (*get_stats)(struct udevice *dev, u64 *data);
> +};
> +
> +#define eth_get_ops(dev) ((struct eth_ops *)(dev)->driver->ops)
> +
> +struct udevice *eth_get_dev(void); /* get the current device */
> +int eth_get_dev_index(void);
>  const char *eth_get_name(void);
>  int eth_get_dev_index(void);
>  int eth_init_state_only(void); /* Set active state */
> @@ -85,5 +135,6 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,=
 char *const argv[]);
>  int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]=
);
>  int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[=
]);
>  int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[]);
> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv=
[]);
>
>  #endif /* __NET_LWIP_H__ */
> diff --git a/net-lwip/Makefile b/net-lwip/Makefile
> index aa247859483..bc011bb0e32 100644
> --- a/net-lwip/Makefile
> +++ b/net-lwip/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_DHCP) +=3D dhcp.o
>  obj-$(CONFIG_CMD_DNS) +=3D dns.o
>  obj-$(CONFIG_CMD_PING) +=3D ping.o
>  obj-$(CONFIG_CMD_TFTPBOOT) +=3D tftp.o
> +obj-$(CONFIG_CMD_WGET) +=3D wget.o
>
>  # Disable this warning as it is triggered by:
>  # sprintf(buf, index ? "foo%d" : "foo", index)
> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
> new file mode 100644
> index 00000000000..25b75040806
> --- /dev/null
> +++ b/net-lwip/wget.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2024 Linaro Ltd. */
> +
> +#include <command.h>
> +#include <console.h>
> +#include <display_options.h>
> +#include <image.h>
> +#include <lwip/apps/http_client.h>
> +#include <lwip/timeouts.h>
> +#include <net-lwip.h>
> +#include <time.h>
> +
> +#define SERVER_NAME_SIZE 200
> +#define HTTP_PORT_DEFAULT 80
> +
> +static ulong daddr;
> +static ulong saved_daddr;
> +static ulong size;
> +static ulong prevsize;
> +#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
> +static ulong start_time;
> +static enum done_state {
> +        NOT_DONE =3D 0,
> +        SUCCESS =3D 1,
> +        FAILURE =3D 2
> +} done;
> +
> +static int parse_url(char *url, char *host, u16 *port, char **path)
> +{
> +       char *p, *pp;
> +       long lport;
> +
> +       p =3D strstr(url, "http://");
> +       if (!p)
> +               return -EINVAL;
> +
> +       p +=3D strlen("http://");
> +
> +       /* Parse hostname */
> +       pp =3D strchr(p, ':');
> +       if (!pp)
> +               pp =3D strchr(p, '/');
> +       if (!pp)
> +               return -EINVAL;
> +
> +       if (p + SERVER_NAME_SIZE <=3D pp)
> +               return -EINVAL;
> +
> +       memcpy(host, p, pp - p);
> +       host[pp - p + 1] =3D '\0';
> +
> +       if (*pp =3D=3D ':') {
> +               /* Parse port number */
> +               p =3D pp + 1;
> +               lport =3D simple_strtol(p, &pp, 10);
> +               if (pp && *pp !=3D '/')
> +                       return -EINVAL;
> +               if (lport > 65535)
> +                       return -EINVAL;
> +               *port =3D (u16)lport;
> +       } else {
> +               *port =3D HTTP_PORT_DEFAULT;
> +       }
> +       if (*pp !=3D '/')
> +               return -EINVAL;
> +       *path =3D pp;
> +
> +       return 0;
> +}
> +
> +static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf=
 *pbuf,
> +                          err_t err)
> +{
> +       struct pbuf *buf;
> +
> +       if (!pbuf)
> +               return ERR_BUF;
> +
> +       for (buf =3D pbuf; buf; buf =3D buf->next) {
> +               memcpy((void *)daddr, buf->payload, buf->len);
> +               daddr +=3D buf->len;
> +               size +=3D buf->len;
> +               if (size - prevsize > PROGRESS_PRINT_STEP_BYTES) {
> +                       printf("#");
> +                       prevsize =3D size;
> +               }
> +       }
> +
> +       altcp_recved(pcb, pbuf->tot_len);
> +       pbuf_free(pbuf);
> +       return ERR_OK;
> +}
> +
> +static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
> +                           u32_t rx_content_len, u32_t srv_res, err_t er=
r)
> +{
> +       ulong elapsed;
> +
> +       if (httpc_result !=3D HTTPC_RESULT_OK) {
> +               log_err("\nHTTP client error %d\n", httpc_result);
> +               done =3D FAILURE;
> +               return;
> +       }
> +
> +       elapsed =3D get_timer(start_time);
> +        log_info("\n%u bytes transferred in %lu ms (", rx_content_len,

This print I commented for another patch to match current python tests.

> +                 get_timer(start_time));
> +        print_size(rx_content_len / elapsed * 1000, "/s)\n");
> +
> +       if (env_set_hex("filesize", rx_content_len) ||
> +           env_set_hex("fileaddr", saved_daddr)) {
> +               log_err("Could not set filesize or fileaddr\n");
> +               done =3D FAILURE;
> +               return;
> +       }
> +
> +       done =3D SUCCESS;
> +}
> +
> +int wget_with_dns(ulong dst_addr, char *uri)

static?

> +{
> +       char server_name[SERVER_NAME_SIZE];
> +       httpc_connection_t conn;
> +       httpc_state_t *state;
> +       char *path;
> +       u16 port;
> +
> +       daddr =3D dst_addr;
> +       saved_daddr =3D dst_addr;
> +       done =3D NOT_DONE;
> +       size =3D 0;
> +       prevsize =3D 0;
> +
> +       if (parse_url(uri, server_name, &port, &path))
> +               return CMD_RET_USAGE;
> +
> +       memset(&conn, 0, sizeof(conn));
> +       conn.result_fn =3D httpc_result_cb;
> +       start_time =3D get_timer(0);
> +       if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv=
_cb,
> +                              NULL, &state))
> +               return CMD_RET_FAILURE;
> +
> +       while (!done) {
> +               eth_rx();
> +               sys_check_timeouts();
> +               if (ctrlc())
> +                       break;
> +       }
> +
> +       if (done =3D=3D SUCCESS)
> +               return 0;
> +
> +       return -1;
> +}
> +
> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv=
[])
> +{
> +       char *url;
> +       ulong dst_addr;
> +
> +       if (argc < 2 || argc > 3)
> +               return CMD_RET_USAGE;
> +
> +       dst_addr =3D image_load_addr;
> +
> +       if (!strncmp(argv[1], "0x", 2)) {

As I remember u-boot can eat hex and decimal numbers for arguments for
most of the commands.

> +               if (argc < 3)
> +                       return CMD_RET_USAGE;
> +               dst_addr =3D hextoul(argv[1], NULL);
> +               url =3D argv[2];
> +       } else {
> +               url =3D argv[1];
> +       }
> +
> +       if (wget_with_dns(dst_addr, url))
> +               return CMD_RET_FAILURE;
> +
> +       return CMD_RET_SUCCESS;
> +}
> --
> 2.40.1
>


--=20
Best regards,
Maxim Uvarov
