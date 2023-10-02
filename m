Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B74E7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8040D871AD;
	Mon,  2 Oct 2023 20:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oe1bL1Uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A899F87171; Mon,  2 Oct 2023 20:56:54 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFF48718A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so6124366b.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696273010; x=1696877810; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0jQzTqI0U6mDbme8c4xN7kzsxqGhMuTGFKiqNDZWRuI=;
 b=Oe1bL1Uc5H5enkRqxvSQGyhzeNT8lc9RQKm5kKcSBsE6RjNm5jRoMG2ZlC03WBz5rf
 4Js9G/JEQd/V3TZvGyf0SiOmn93ZfUG1sqkeuHUTblvoeU+0nnsA8OK16IWaBjttvhGQ
 m0VSqW+HnPMO+2pNCSU/0Ftv1So5AjyU2q4uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273010; x=1696877810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0jQzTqI0U6mDbme8c4xN7kzsxqGhMuTGFKiqNDZWRuI=;
 b=XznZBVFIBYE4We31vecQKYFQCsSqZg33CLDG2QphM2tcMfemvsUt7S78Scps8lo/gJ
 dYPUh50saq12YACZ67Ia8elJwTXJv6qjFPKxqk/aRQZTKNggxtaS3e7fbykOpmYudNlY
 Bvvbn3UlfrzgppS0IRI5noXQb2ibTFNOqv6ukkQob7tsXUb19/eTa9rphjABGsm+eiyu
 Nt0jXghjn2wgIJTEXdfi4u0I3Sa7Eoxd6nhkIoihoNXpt1WiqR727EbdJmI5m8gGOT5k
 i35y6JdCflKQ5qUnoKI+8YIJ1YnfmhX3w5pRcOJiDAIR5KwKao2XYiMYZzln1fqp3c+3
 JlMQ==
X-Gm-Message-State: AOJu0YzvLE1c9GbfmH2j39kXchV7LusvmnAun/lxbo2QoZF1tc6bLY4P
 znScAAiAz0qci5yRPeZDgsRFjp5VEtu0ObvWm2XINg==
X-Google-Smtp-Source: AGHT+IHcDSAuraVUzXoUTOPMA/9g1Ij3IasRAVb9CS76U7uy8G81ALD7HteMElYzlvHMFLhGrAWU7XplRTYzjP2+cTo=
X-Received: by 2002:a17:906:31da:b0:9b2:ba66:bbb0 with SMTP id
 f26-20020a17090631da00b009b2ba66bbb0mr11154755ejf.28.1696273010250; Mon, 02
 Oct 2023 11:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-4-detlev.casanova@collabora.com>
In-Reply-To: <20231002152142.76516-4-detlev.casanova@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 12:56:29 -0600
Message-ID: <CAPnjgZ1abN-ckwPikKORDakxceg52WHzRd484WtcsneLcp07fw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] sysinfo: Add a test
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>
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

Hi Detlev,

On Mon, 2 Oct 2023 at 09:22, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> The test runs one of each subcommand and checks that the output matches
> the values in the sandbox sysinfo driver.
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  configs/sandbox_defconfig |  1 +
>  drivers/sysinfo/sandbox.c | 17 +++++++++++++
>  test/cmd/Makefile         |  1 +
>  test/cmd/test_sysinfo.c   | 51 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 70 insertions(+)
>  create mode 100644 test/cmd/test_sysinfo.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 62bc182ca16..409e3d88012 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -129,6 +129,7 @@ CONFIG_CMD_EROFS=y
>  CONFIG_CMD_EXT4_WRITE=y
>  CONFIG_CMD_SQUASHFS=y
>  CONFIG_CMD_MTDPARTS=y
> +CONFIG_CMD_SYSINFO=y
>  CONFIG_CMD_STACKPROTECTOR_TEST=y
>  CONFIG_MAC_PARTITION=y
>  CONFIG_AMIGA_PARTITION=y
> diff --git a/drivers/sysinfo/sandbox.c b/drivers/sysinfo/sandbox.c
> index d270a26aa43..cc7783907a9 100644
> --- a/drivers/sysinfo/sandbox.c
> +++ b/drivers/sysinfo/sandbox.c
> @@ -7,9 +7,14 @@
>  #include <common.h>
>  #include <dm.h>
>  #include <sysinfo.h>
> +#include <version.h>
>
>  #include "sandbox.h"
>
> +#define SANDBOX_BOARD_ID       0x42
> +#define SANDBOX_BOARD_REV_MAJOR        U_BOOT_VERSION_NUM
> +#define SANDBOX_BOARD_REV_MINOR        U_BOOT_VERSION_NUM_PATCH
> +
>  struct sysinfo_sandbox_priv {
>         bool called_detect;
>         int test_i1;
> @@ -48,6 +53,15 @@ int sysinfo_sandbox_get_int(struct udevice *dev, int id, int *val)
>         struct sysinfo_sandbox_priv *priv = dev_get_priv(dev);
>
>         switch (id) {
> +       case SYSINFO_ID_BOARD_ID:
> +               *val = SANDBOX_BOARD_ID;
> +               return 0;
> +       case SYSINFO_ID_BOARD_REV_MAJOR:
> +               *val = SANDBOX_BOARD_REV_MAJOR;
> +               return 0;
> +       case SYSINFO_ID_BOARD_REV_MINOR:
> +               *val = SANDBOX_BOARD_REV_MINOR;
> +               return 0;
>         case INT_TEST1:
>                 *val = priv->test_i1;
>                 /* Increments with every call */
> @@ -71,6 +85,9 @@ int sysinfo_sandbox_get_str(struct udevice *dev, int id, size_t size, char *val)
>         int index = (i1 * i2) % ARRAY_SIZE(vacation_spots);
>
>         switch (id) {
> +       case SYSINFO_ID_BOARD_MODEL:
> +               snprintf(val, size, "sandbox");
> +               return 0;
>         case STR_VACATIONSPOT:
>                 /* Picks a vacation spot depending on i1 and i2 */
>                 snprintf(val, size, vacation_spots[index]);
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index 6e3d7e919ef..dc8f59d87f2 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -26,6 +26,7 @@ ifdef CONFIG_SANDBOX
>  obj-$(CONFIG_CMD_READ) += rw.o
>  obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
>  obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
> +obj-$(CONFIG_CMD_SYSINFO) += test_sysinfo.o
>  endif
>  obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
>  obj-$(CONFIG_CMD_WGET) += wget.o
> diff --git a/test/cmd/test_sysinfo.c b/test/cmd/test_sysinfo.c
> new file mode 100644
> index 00000000000..7ba6dd0df89
> --- /dev/null
> +++ b/test/cmd/test_sysinfo.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Tests for sysinfo command
> + *
> + * Copyright 2023, Detlev Casanova <detlev.casanova@collabora.com>
> + */
> +
> +#include <common.h>
> +#include <command.h>
> +#include <asm/global_data.h>
> +#include <display_options.h>
> +#include <test/lib.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +#include <version.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define REV_(x, y) #x "." #y
> +#define REV(x, y) REV_(x, y)
> +
> +struct test_data {
> +       char *cmd;
> +       char *expected;
> +};
> +
> +static struct test_data sysinfo_data[] = {
> +       {"sysinfo model", "sandbox"},
> +       {"sysinfo id", "0x42"},
> +       {"sysinfo revision", REV(U_BOOT_VERSION_NUM, U_BOOT_VERSION_NUM_PATCH)},

I would prefer that write out the lines in code. I don't think it
helps much to put these in a table.

> +};
> +
> +static int lib_test_sysinfo(struct unit_test_state *uts)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(sysinfo_data); ++i) {
> +               ut_silence_console(uts);
> +               console_record_reset_enable();

drop those two lines

> +               ut_assertok(run_command(sysinfo_data[i].cmd, 0));
> +               ut_unsilence_console(uts);
> +               console_record_readline(uts->actual_str,
> +                                       sizeof(uts->actual_str));
> +               ut_asserteq_str(sysinfo_data[i].expected, uts->actual_str);

ut_assert_nextline(sysinfo_data[i].expected, uts->actual_str);

> +               ut_assertok(ut_check_console_end(uts));
> +       }
> +
> +       return 0;
> +}
> +
> +LIB_TEST(lib_test_sysinfo, 0);

Add UT_TESTF_CONSOLE_REC

> --
> 2.41.0
>

Regards,
Simon
