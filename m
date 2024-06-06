Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388BDC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 09:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9520A87D40;
	Thu,  6 Jun 2024 11:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ng+9FCpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF29883E3; Thu,  6 Jun 2024 11:56:47 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDBA878E2
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 11:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4213b94b8b5so8804945e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717667804; x=1718272604; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ci1vZaNmtpQWdB18e3fe9FeTq5RaDTFdA6Qmqo4L6Uw=;
 b=Ng+9FCpfhJX8+qkwMRWnqvkLwnobYmKCPlP9C8BZvQpQ4okieCXBnzXmZvOPbRngb3
 rBqphmVNxM1XXHQCtVS1I1eLq/INQ/7uSp7e4YW4StkO/fYKWVyYE9lAWwjh0jjrjgzc
 5r1gL2xErchIS6qbKwyQyvkawSk11O0dwdtMW8X/7eNlyBrA1zD82T+4liuJan6ub5I9
 Sn+bC0yxjjEUcQARy8mUd8zbsw0BEK57JLlkbjgK9aYyTisnaBf5+DGuXOT4icSn1MyW
 gg0gCRJY8azfdL0sIqqFJkZVGzT6WJnERmzvG8EO+srpKA2/ILZ3cMTXQ0fIUlHjNJ4W
 g24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717667804; x=1718272604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ci1vZaNmtpQWdB18e3fe9FeTq5RaDTFdA6Qmqo4L6Uw=;
 b=Q0kHYbUX6Nr8ZNevDEViy7YJVhtUi78uCRh2f6SsOhXzTFE30WQc7/eDi3routC2ne
 +EzA/2f9xfbVJYZuhwdYnZfnYsKOIUfxJ3Y88b/GKM9hAOK+EyU7BV5074hNwb23sXLg
 Su5mSaCH/qNPaybumDl2rhMwo0/cwfQk3//7HuMoEee3U4M6Ej64jfLwBy0eq4CFVUyK
 HqEn1Ynf1HPw3Ua59ZGIzfCMDC5hyvDy0TDcCnsvcf51pBFcnH8X03pXupp9K/HYsf2O
 6ZgSHUG7T7/k1vDhYPsWbtMv9eghpxdmGfRhOA1cissHzA+U9XTGCWsDshardHCkH8qw
 j/+Q==
X-Gm-Message-State: AOJu0Yxao5Y9jfTKSnVuHXUOEsnmPFgYCwPL1wUGZXYxh6lhg3RuvhR2
 fggjEydCW0Ictxn9j3om3sKzXPBITy557MhDGdM+u0NxowN5FuOBNrLRO9foNMA=
X-Google-Smtp-Source: AGHT+IE9EGOS6CwNTkTW25xwJECjRGXmSqXMDY1dX+PdAm7bmzOQoJqpC/PssQYG3dEzJ1xqsThbIQ==
X-Received: by 2002:adf:e945:0:b0:356:50e7:e942 with SMTP id
 ffacd0b85a97d-35e8ef93637mr3833667f8f.61.1717667804319; 
 Thu, 06 Jun 2024 02:56:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07?
 ([2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fc12e0sm1107790f8f.100.2024.06.06.02.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 02:56:44 -0700 (PDT)
Message-ID: <e6c307e8-5621-42e2-9c89-024a93e11496@linaro.org>
Date: Thu, 6 Jun 2024 11:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] net-lwip: add wget command
To: Maxim Uvarov <muvarov@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Peter Robinson
 <pbrobinson@gmail.com>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Edmond <seanedmond@microsoft.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <98a1de5f01dad1ad55b68ebadcbad1f6357246a6.1716566960.git.jerome.forissier@linaro.org>
 <CAJGZr0LjFDH5XETPRwSKVS_=KCDbdf9Mi0NneFwyM7_YOXi4OQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJGZr0LjFDH5XETPRwSKVS_=KCDbdf9Mi0NneFwyM7_YOXi4OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 5/28/24 15:39, Maxim Uvarov wrote:
> пт, 24 мая 2024 г. в 19:22, Jerome Forissier <jerome.forissier@linaro.org>:
>>
>> Add support for the wget command with NET_LWIP.
>>
>> About the small change in cmd/efidebug.c: when the wget command based
>> on the lwIP stack is used the wget command has a built-in URL
>> validation function since it needs to parse it anyways (in parse_url()).
>> Therefore wget_validate_uri() doesn't exist. So, guard the call in
>> efidebug.c with CONFIG_CMD_WGET.
>>
>> Based on code initially developed by Maxim U.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
>> Cc: Maxim Uvarov <muvarov@gmail.com>
>> ---
>>  cmd/Kconfig        |   7 ++
>>  cmd/Makefile       |   5 +-
>>  cmd/efidebug.c     |   8 +-
>>  cmd/net-common.c   | 112 ++++++++++++++++++++++++++++
>>  cmd/net-lwip.c     |  12 +++
>>  cmd/net.c          | 115 -----------------------------
>>  include/net-lwip.h |  51 +++++++++++++
>>  net-lwip/Makefile  |   1 +
>>  net-lwip/wget.c    | 180 +++++++++++++++++++++++++++++++++++++++++++++
>>  9 files changed, 372 insertions(+), 119 deletions(-)
>>  create mode 100644 cmd/net-common.c
>>  create mode 100644 net-lwip/wget.c
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 6ef0b52cd34..d9a86540be6 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -2117,6 +2117,13 @@ config CMD_TFTPBOOT
>>         help
>>           tftpboot - load file via network using TFTP protocol
>>
>> +config CMD_WGET
>> +       bool "wget"
>> +       select PROT_TCP_LWIP
>> +       help
>> +         wget is a simple command to download kernel, or other files,
>> +         from a http server over TCP.
>> +
>>  endif
>>
>>  endif
>> diff --git a/cmd/Makefile b/cmd/Makefile
>> index 535b6838ca5..e90f2f68211 100644
>> --- a/cmd/Makefile
>> +++ b/cmd/Makefile
>> @@ -129,8 +129,11 @@ obj-$(CONFIG_CMD_MUX) += mux.o
>>  obj-$(CONFIG_CMD_NAND) += nand.o
>>  obj-$(CONFIG_CMD_NET) += net.o
>>  obj-$(CONFIG_CMD_NET_LWIP) += net-lwip.o
>> +obj-$(filter y,$(CONFIG_CMD_NET) $(CONFIG_CMD_NET_LWIP)) += net-common.o
>>  ifdef CONFIG_CMD_NET_LWIP
>> -CFLAGS_net-lwip.o := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
>> +lwip-includes := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
>> +CFLAGS_net-lwip.o := $(lwip-includes)
>> +CFLAGS_net-common.o := $(lwip-includes)
>>  endif
>>  obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
>>  obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
>> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
>> index c2c525f2351..d80e91ecadd 100644
>> --- a/cmd/efidebug.c
>> +++ b/cmd/efidebug.c
>> @@ -741,9 +741,11 @@ static int efi_boot_add_uri(int argc, char *const argv[], u16 *var_name16,
>>         if (!label)
>>                 return CMD_RET_FAILURE;
>>
>> -       if (!wget_validate_uri(argv[3])) {
>> -               printf("ERROR: invalid URI\n");
>> -               return CMD_RET_FAILURE;
>> +       if (IS_ENABLED(CONFIG_CMD_WGET)) {
>> +               if (!wget_validate_uri(argv[3])) {
>> +                       printf("ERROR: invalid URI\n");
>> +                       return CMD_RET_FAILURE;
>> +               }
>>         }
>>
>>         efi_create_indexed_name(var_name16, var_name16_size, "Boot", id);
>> diff --git a/cmd/net-common.c b/cmd/net-common.c
>> new file mode 100644
>> index 00000000000..b5dfd2c8866
>> --- /dev/null
>> +++ b/cmd/net-common.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * (C) Copyright 2000
>> + * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>> + */
>> +
>> +#include <command.h>
>> +#include <dm/device.h>
>> +#include <dm/uclass.h>
>> +#ifdef CONFIG_NET
>> +#include <net.h>
>> +#elif defined CONFIG_NET_LWIP
>> +#include <net-lwip.h>
>> +#else
>> +#error Either NET or NET_LWIP must be enabled
>> +#endif
>> +#include <linux/compat.h>
>> +#include <linux/ethtool.h>
>> +
>> +static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> +{
>> +       const struct udevice *current = eth_get_dev();
>> +       unsigned char env_enetaddr[ARP_HLEN];
>> +       const struct udevice *dev;
>> +       struct uclass *uc;
>> +
>> +       uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
>> +               eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
>> +               printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name, env_enetaddr,
>> +                      current == dev ? "active" : "");
>> +       }
>> +       return CMD_RET_SUCCESS;
>> +}
>> +
>> +static int do_net_stats(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> +{
>> +       int nstats, err, i, off;
>> +       struct udevice *dev;
>> +       u64 *values;
>> +       u8 *strings;
>> +
>> +       if (argc < 2)
>> +               return CMD_RET_USAGE;
>> +
>> +       err = uclass_get_device_by_name(UCLASS_ETH, argv[1], &dev);
>> +       if (err) {
>> +               printf("Could not find device %s\n", argv[1]);
>> +               return CMD_RET_FAILURE;
>> +       }
>> +
>> +       if (!eth_get_ops(dev)->get_sset_count ||
>> +           !eth_get_ops(dev)->get_strings ||
>> +           !eth_get_ops(dev)->get_stats) {
>> +               printf("Driver does not implement stats dump!\n");
>> +               return CMD_RET_FAILURE;
>> +       }
>> +
>> +       nstats = eth_get_ops(dev)->get_sset_count(dev);
>> +       strings = kcalloc(nstats, ETH_GSTRING_LEN, GFP_KERNEL);
>> +       if (!strings)
>> +               return CMD_RET_FAILURE;
>> +
>> +       values = kcalloc(nstats, sizeof(u64), GFP_KERNEL);
>> +       if (!values)
>> +               goto err_free_strings;
>> +
>> +       eth_get_ops(dev)->get_strings(dev, strings);
>> +       eth_get_ops(dev)->get_stats(dev, values);
>> +
>> +       off = 0;
>> +       for (i = 0; i < nstats; i++) {
>> +               printf("  %s: %llu\n", &strings[off], values[i]);
>> +               off += ETH_GSTRING_LEN;
>> +       };
>> +
> 
> It looks like here you missed kfree().

Good catch! This is already missing in master (cmd/net.c). I will fix
in v3 and also send a patch for master.

>> +       return CMD_RET_SUCCESS;
>> +
>> +err_free_strings:
>> +       kfree(strings);
>> +
>> +       return CMD_RET_FAILURE;
>> +}
>> +

[...]

>> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
>> new file mode 100644
>> index 00000000000..25b75040806
>> --- /dev/null
>> +++ b/net-lwip/wget.c
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/* Copyright (C) 2024 Linaro Ltd. */
>> +
>> +#include <command.h>
>> +#include <console.h>
>> +#include <display_options.h>
>> +#include <image.h>
>> +#include <lwip/apps/http_client.h>
>> +#include <lwip/timeouts.h>
>> +#include <net-lwip.h>
>> +#include <time.h>
>> +

[...]
>> +
>> +static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>> +                           u32_t rx_content_len, u32_t srv_res, err_t err)
>> +{
>> +       ulong elapsed;
>> +
>> +       if (httpc_result != HTTPC_RESULT_OK) {
>> +               log_err("\nHTTP client error %d\n", httpc_result);
>> +               done = FAILURE;
>> +               return;
>> +       }
>> +
>> +       elapsed = get_timer(start_time);
>> +        log_info("\n%u bytes transferred in %lu ms (", rx_content_len,
> 
> This print I commented for another patch to match current python tests.

What do you mean? Is this text incorrect because some tests expect something
else? Which ones?
 
>> +                 get_timer(start_time));
>> +        print_size(rx_content_len / elapsed * 1000, "/s)\n");
>> +
>> +       if (env_set_hex("filesize", rx_content_len) ||
>> +           env_set_hex("fileaddr", saved_daddr)) {
>> +               log_err("Could not set filesize or fileaddr\n");
>> +               done = FAILURE;
>> +               return;
>> +       }
>> +
>> +       done = SUCCESS;
>> +}
>> +
>> +int wget_with_dns(ulong dst_addr, char *uri)
> 
> static?

No, this function is called from lib/efi_loader/efi_bootmgr.c.

>> +{
>> +       char server_name[SERVER_NAME_SIZE];
>> +       httpc_connection_t conn;
>> +       httpc_state_t *state;
>> +       char *path;
>> +       u16 port;
>> +
>> +       daddr = dst_addr;
>> +       saved_daddr = dst_addr;
>> +       done = NOT_DONE;
>> +       size = 0;
>> +       prevsize = 0;
>> +
>> +       if (parse_url(uri, server_name, &port, &path))
>> +               return CMD_RET_USAGE;
>> +
>> +       memset(&conn, 0, sizeof(conn));
>> +       conn.result_fn = httpc_result_cb;
>> +       start_time = get_timer(0);
>> +       if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
>> +                              NULL, &state))
>> +               return CMD_RET_FAILURE;
>> +
>> +       while (!done) {
>> +               eth_rx();
>> +               sys_check_timeouts();
>> +               if (ctrlc())
>> +                       break;
>> +       }
>> +
>> +       if (done == SUCCESS)
>> +               return 0;
>> +
>> +       return -1;
>> +}
>> +
>> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>> +{
>> +       char *url;
>> +       ulong dst_addr;
>> +
>> +       if (argc < 2 || argc > 3)
>> +               return CMD_RET_USAGE;
>> +
>> +       dst_addr = image_load_addr;
>> +
>> +       if (!strncmp(argv[1], "0x", 2)) {
> 
> As I remember u-boot can eat hex and decimal numbers for arguments for
> most of the commands.

Right. I'll use hextoul() properly in v3.

>> +               if (argc < 3)
>> +                       return CMD_RET_USAGE;
>> +               dst_addr = hextoul(argv[1], NULL);
>> +               url = argv[2];
>> +       } else {
>> +               url = argv[1];
>> +       }
>> +
>> +       if (wget_with_dns(dst_addr, url))
>> +               return CMD_RET_FAILURE;
>> +
>> +       return CMD_RET_SUCCESS;
>> +}
>> --
>> 2.40.1

Thanks,
-- 
Jerome
