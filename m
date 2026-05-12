Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9575BCD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 07:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2928C801A9;
	Tue, 12 May 2026 09:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JXeK8uMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0FF980398; Tue, 12 May 2026 09:09:06 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E199B800AE
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 09:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5637886c92aso2480203e0c.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 00:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778569742; cv=none;
 d=google.com; s=arc-20240605;
 b=j2bzWApGlYy+HHMP18V7NkmcVKRJI3ifa50RiV5WieB5nkEJ6JElmOrju45ptmCmCo
 z2Qw3KSlVE3yGDWrKNPq3OU7UoabMkQX6DQD3eHTtq6xfRpBld0CdJ1ilaNqLGIkZQy8
 Jj5Cux7MIm8vvSp5gASKW7Tmem9zjsJoBisxqOPeQ9e9TQQ1aZidwp5gco1w1Ic/vBru
 0/tGH+xz9XG1VtIsGGDkyArwre6dxVkqE7pqQQDoq5I8suNii87Hpryam4cPl0TlcLn7
 uTw9Z7yqlxAUcHmEiExXNwV2WSewuoHoObDg7v3WYHykfWFmktHl0U/djGO9FqChHBCR
 xTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1fWZXaMs3GX/R1R3cp+rOa7kgAPbv4azPmJlMurqZqk=;
 fh=VQfG0fmv5KJzLQhl0ufYpqdXBYQXanyqisBUd6SiNas=;
 b=akwL0pskGBhYLaAJiiWRM9QZdOffFnd5NnxBG1Gph8KSh0qDUGXBs+hhk/aPdKNQbP
 /k2QYLrgxKHDnkhCfijR0ney2bGKqZjPtTrBQJLc4+jZoxsj2/gK2AeNC9zSgkyvWkvs
 IM9o/BeLc2q/fzDpLeh0AGiOu20/v8aUBEzI6atItIp9hBe2x0rogtgkXQlp6oEDOz9J
 KzvlaG5xECr6Q94lzPu7HdrtQ1RFVTdvAr/0gFVk6ttxPyOmTRFfwa4VL+eU5DnQJL8y
 K8YTwPmQ2y6DyJQai4WQ7JKky0N+S5hv0qH429jhzQDRmMU5heyKSkiuVd/5Q/+8/v6Q
 f5Xw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1778569742; x=1779174542;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1fWZXaMs3GX/R1R3cp+rOa7kgAPbv4azPmJlMurqZqk=;
 b=JXeK8uMFk4MhJUXRCM+JgWdVSNLXvGUJX5kkvlLKjmmlrHyo1FwV3ICSKfM6HpLqz4
 zx4Wx01ta/s9nKN9LVq0Wff8bNAufkVhkl9J004n89VyQIw36zk0zFC6naYsrQYVZTup
 xM7hCTUMkwCLpsgn+0AzvQU82drckMTSOKMSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778569742; x=1779174542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fWZXaMs3GX/R1R3cp+rOa7kgAPbv4azPmJlMurqZqk=;
 b=H1baJdU22RX2tsJ05/5GOZXwacSovDoasJFXP38KVV0OtDfchxrWGy/j1v5iTyzrNg
 3UOLNj6F5PE9ognbp6nIruOFg+i6ABYVE9aOqIbgrtI+0MrM3vLPDzqOs4fy1Wxb3Fom
 8oKdXcgu88NRkFzeGQYJKshPL21F6hdobKk+z9T3OlnZD4jjL7aBXfxIYN1zHz3NZfJU
 j8nNjleUknfyRchQq5aoIw70nScqyzJgPmaCSupTi+IpowB3oavz3KFzG9as+eT46vHv
 o/wbG7CMxpD9TjPRoZgIxYt/zbrZl9uTSAGmZc6IGgkSlZ1RwwFPfUjXCOm9Pzcj7wXy
 CLXg==
X-Gm-Message-State: AOJu0Yy82Fltl0O6zZsUk4Q3ANon2s0tXhaCR0rBoj8hRc3gAeVHWko5
 we8vTzTG6awoBLb5Tu1Mgfztz0Bvf3D5JUX/4lzbs20ThP7OBafYWzXgzT4bbcGB3bTACaOqc5Q
 67vZrPyhq8NAhq8b8OCKiosC4oJs2sHhqvDAYDFXGAg==
X-Gm-Gg: Acq92OGE2fzH43SGitVSmedc/OO+bk5kyyC2DuQgDmW3h6V9CUB8JTQoDUczbZOSWRw
 piUvAbI2nMP2/vCcILG62OtrB0T2fb8gREpw2IWOvGoID4lH/ZttR65mmCTRn/klB9Cqbc2P81T
 Uw2nmtIBgPMGr2Qn4jJgYhHVq7wPwWoz7eT4gyvpHizhE5YPZ7x+qS81JiDUAWMGqZIVZ88C8QR
 t0smkq0tWPPmjtYUoy/xW5xFo1bzlSTAirVVDQ8HAXp82fhS7Yzpfc1fMq0m3C/9c3SBJ5+U6/4
 ZMBl2dWTOJqZj3VehAz0KyZK4d/yJLSVxLHb
X-Received: by 2002:a05:6122:6584:b0:575:2f91:6fd3 with SMTP id
 71dfb90a1353d-575d42410e2mr611322e0c.5.1778569742416; Tue, 12 May 2026
 00:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
 <20260430080627.849636-4-dario.binacchi@amarulasolutions.com>
 <5b02ed04-764c-4eee-ba58-0f84ef43446c@foss.st.com>
 <CABGWkvp-5GnhvOO46PoKBOKmh-XsTLbHQx63fMwm70J0NYZ55A@mail.gmail.com>
In-Reply-To: <CABGWkvp-5GnhvOO46PoKBOKmh-XsTLbHQx63fMwm70J0NYZ55A@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 12 May 2026 09:08:51 +0200
X-Gm-Features: AVHnY4IyVnhYngz5olqdD9qcAh972BlO0NCsAe1rgbkOJr_lEgP66PxH8fp0CqU
Message-ID: <CABGWkvrBZPN4LGia169JdrjhUyN5cSvnMt1hxH=Tx6JZ0NbRTQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] test: cmd: add unit tests for part command
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Simon Glass <sjg@chromium.org>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi everyone,

I am resending my previous reply because I received a delivery failure
notification last week indicating that Patrice's mailbox was full.

Patrice, did you have a chance to verify if the tests are passing fine now?
Please let me know if everything looks good or if you need

me to make any further modifications.

Thanks and regards

Dario

On Tue, May 5, 2026 at 9:55=E2=80=AFAM Dario Binacchi <
dario.binacchi@amarulasolutions.com> wrote:

> Hi Patrice,
>
> On Tue, May 5, 2026 at 9:26=E2=80=AFAM Patrice CHOTARD <
> patrice.chotard@foss.st.com> wrote:
>
>>
>>
>> On 4/30/26 10:06, Dario Binacchi wrote:
>> > Add unit tests for the 'part' command, specifically for the 'number',
>> > 'start', and 'size' subcommands.
>> >
>> > These tests establish a baseline for the current partition lookup
>> > functionality by name. This foundation will be used by subsequent
>> > patches to extend the command, ensuring consistent behavior as new
>> > features are introduced.
>> >
>> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> > Reviewed-by: Simon Glass <sjg@chromium.org>
>> >
>> > ---
>> >
>> > Changes in v8:
>> > - Skip the test in case the CONFIG_MCC is not enabled or the mmc
>> >   device is not found.
>> >
>> > Changes in v6:
>> > - Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
>> >   tests for part command"
>> >
>> > Changes in v4:
>> > - Place the part command tests in the cmd suite rather than the dm
>> >   suite.
>> > - Order the include files according the U-Boot coding style.
>> >
>> > Changes in v3:
>> > - Wrap the lines exceeding 80 columns
>> > - Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_comman=
d(
>> >
>> >  test/cmd/Makefile |   1 +
>> >  test/cmd/part.c   | 183 +++++++++++++++++++++++++++++++++++++++++++++=
+
>> >  2 files changed, 184 insertions(+)
>> >  create mode 100644 test/cmd/part.c
>> >
>> > diff --git a/test/cmd/Makefile b/test/cmd/Makefile
>> > index 5f2815b1bb65..8d6932f1176c 100644
>> > --- a/test/cmd/Makefile
>> > +++ b/test/cmd/Makefile
>> > @@ -26,6 +26,7 @@ obj-$(CONFIG_CMD_LOADM) +=3D loadm.o
>> >  obj-$(CONFIG_CMD_MEMINFO) +=3D meminfo.o
>> >  obj-$(CONFIG_CMD_MEMORY) +=3D mem_copy.o
>> >  obj-$(CONFIG_CMD_MEM_SEARCH) +=3D mem_search.o
>> > +obj-$(CONFIG_CMD_PART) +=3D part.o
>> >  ifdef CONFIG_CMD_PCI
>> >  obj-$(CONFIG_CMD_PCI_MPS) +=3D pci_mps.o
>> >  endif
>> > diff --git a/test/cmd/part.c b/test/cmd/part.c
>> > new file mode 100644
>> > index 000000000000..cac57a1a0e35
>> > --- /dev/null
>> > +++ b/test/cmd/part.c
>> > @@ -0,0 +1,183 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>> > +/*
>> > + * Test for part command
>> > + *
>> > + * Copyright (C) 2026 Amarula Solutions
>> > + * Written by Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> > + */
>> > +
>> > +#include <command.h>
>> > +#include <dm.h>
>> > +#include <env.h>
>> > +#include <part.h>
>> > +#include <vsprintf.h>
>> > +#include <dm/test.h>
>> > +#include <test/cmd.h>
>> > +#include <test/test.h>
>> > +#include <test/ut.h>
>> > +
>> > +static struct disk_partition gpt_parts[] =3D {
>> > +     {
>> > +             .start =3D 48,
>> > +             .size =3D 1,
>> > +             .name =3D "test1",
>> > +             .uuid =3D "c5bce7a2-03f0-4d03-9048-01ff23b9d527",
>> > +     },
>> > +     {
>> > +             .start =3D 49,
>> > +             .size =3D 2,
>> > +             .name =3D "test2",
>> > +             .uuid =3D "9df346e8-2c53-4cd8-b9ac-3af83f9a9b74",
>> > +     },
>> > +};
>> > +
>> > +static char disk_guid[UUID_STR_LEN + 1] =3D
>> > +     "8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
>> > +
>> > +static int setup_gpt_partitions(struct unit_test_state *uts,
>> > +                             unsigned int mmc_dev_num)
>> > +{
>> > +     struct blk_desc *mmc_dev_desc;
>> > +     char dev_str[10];
>> > +     int i, ret;
>> > +
>> > +     if (!CONFIG_IS_ENABLED(MMC))
>> > +             return -EAGAIN;
>>
>> Hi Dario
>>
>> Is there any reason to return -EAGAIN ? -ENODEV seems more appropriate ?
>>
>
> In the testing framework, returning -EAGAIN explicitly signals that the
> test should be skipped*.*
>
> As highlighted in the documentation for ut_run_test():
>
> *Return: 0 if all tests passed, -EAGAIN if the test should be skipped, -1
> if any failed*
>
>
> Since the necessary preconditions weren't met for some configuration in
> our case, I decided to skip.
>
> Thanks and regards,
>
> Dario
>
>
>> Thanks
>> Patrice
>>
>> > +
>> > +     snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
>> > +
>> > +     ret =3D blk_get_device_by_str("mmc", dev_str, &mmc_dev_desc);
>> > +     if (ret =3D=3D -ENODEV)
>> > +             return -EAGAIN;
>> > +
>> > +     ut_asserteq(mmc_dev_num, ret);
>> > +
>> > +     if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
>> > +             for (i =3D 0; i < ARRAY_SIZE(gpt_parts); i++)
>> > +                     gen_rand_uuid_str(gpt_parts[i].uuid,
>> > +                                       UUID_STR_FORMAT_STD);
>> > +
>> > +             gen_rand_uuid_str(disk_guid, UUID_STR_FORMAT_STD);
>> > +     }
>> > +
>> > +     ut_assertok(gpt_restore(mmc_dev_desc, disk_guid, gpt_parts,
>> > +                             ARRAY_SIZE(gpt_parts)));
>> > +     return 0;
>> > +}
>> > +
>> > +static int cmd_test_part_number(struct unit_test_state *uts)
>> > +{
>> > +     unsigned int mmc_dev_num =3D 2;
>> > +     char expected[10];
>> > +     int i, ret;
>> > +
>> > +     ret =3D setup_gpt_partitions(uts, mmc_dev_num);
>> > +     if (ret =3D=3D -EAGAIN)
>> > +             return ret;
>> > +
>> > +     ut_assertok(ret);
>> > +
>> > +     for (i =3D 0; i < ARRAY_SIZE(gpt_parts); i++) {
>> > +             env_set("partnum", NULL);
>> > +             ut_assertok(run_commandf("part number mmc %u %s partnum"=
,
>> > +                                      mmc_dev_num, gpt_parts[i].name)=
);
>> > +             snprintf(expected, sizeof(expected), "0x%x", i + 1);
>> > +             ut_asserteq_str(expected, env_get("partnum"));
>> > +     }
>> > +
>> > +     env_set("partnum", NULL);
>> > +     ut_asserteq(1, run_commandf("part number mmc %u bogus partnum",
>> > +                                 mmc_dev_num));
>> > +     ut_assertnull(env_get("partnum"));
>> > +
>> > +     return 0;
>> > +}
>> > +CMD_TEST(cmd_test_part_number, UTF_CONSOLE);
>> > +
>> > +static int cmd_test_part_start(struct unit_test_state *uts)
>> > +{
>> > +     unsigned int mmc_dev_num =3D 2;
>> > +     char expected[32];
>> > +     int i, ret;
>> > +
>> > +     ret =3D setup_gpt_partitions(uts, mmc_dev_num);
>> > +     if (ret =3D=3D -EAGAIN)
>> > +             return ret;
>> > +
>> > +     ut_assertok(ret);
>> > +
>> > +     for (i =3D 0; i < ARRAY_SIZE(gpt_parts); i++) {
>> > +             env_set("partstart", NULL);
>> > +             ut_assertok(run_commandf("part start mmc %u %d partstart=
",
>> > +                                      mmc_dev_num, i + 1));
>> > +             snprintf(expected, sizeof(expected), "%lx",
>> > +                      (unsigned long)gpt_parts[i].start);
>> > +             ut_asserteq_str(expected, env_get("partstart"));
>> > +     }
>> > +
>> > +     env_set("partstart", NULL);
>> > +     ut_asserteq(1, run_commandf("part start mmc %u 3 partstart",
>> > +                                 mmc_dev_num));
>> > +     ut_assertnull(env_get("partstart"));
>> > +
>> > +     for (i =3D 0; i < ARRAY_SIZE(gpt_parts); i++) {
>> > +             env_set("partstart", NULL);
>> > +             ut_assertok(run_commandf("part start mmc %u %s partstart=
",
>> > +                                      mmc_dev_num, gpt_parts[i].name)=
);
>> > +             snprintf(expected, sizeof(expected), "%lx",
>> > +                      (unsigned long)gpt_parts[i].start);
>> > +             ut_asserteq_str(expected, env_get("partstart"));
>> > +     }
>> > +
>> > +     env_set("partstart", NULL);
>> > +     ut_asserteq(1, run_commandf("part start mmc %u bogus partstart",
>> > +                                 mmc_dev_num));
>> > +     ut_assertnull(env_get("partstart"));
>> > +
>> > +     return 0;
>> > +}
>> > +CMD_TEST(cmd_test_part_start, UTF_CONSOLE);
>> > +
>> > +static int cmd_test_part_size(struct unit_test_state *uts)
>> > +{
>> > +     unsigned int mmc_dev_num =3D 2;
>> > +     char expected[32];
>> > +     int i, ret;
>> > +
>> > +     ret =3D setup_gpt_partitions(uts, mmc_dev_num);
>> > +     if (ret =3D=3D -EAGAIN)
>> > +             return ret;
>> > +
>> > +     ut_assertok(ret);
>> > +
>> > +     for (i =3D 0; i < ARRAY_SIZE(gpt_parts); i++) {
>> > +             env_set("partsize", NULL);
>> > +             ut_assertok(run_commandf("part size mmc %u %d partsize",
>> > +                                      mmc_dev_num, i + 1));
>> > +             snprintf(expected, sizeof(expected), "%lx",
>> > +                      (unsigned long)gpt_parts[i].size);
>> > +             ut_asserteq_str(expected, env_get("partsize"));
>> > +     }
>> > +
>> > +     env_set("partsize", NULL);
>> > +     ut_asserteq(1, run_commandf("part size mmc %u 3 partsize",
>> > +                                 mmc_dev_num));
>> > +     ut_assertnull(env_get("partsize"));
>> > +
>> > +     for (i =3D 0; i < ARRAY_SIZE(gpt_parts); i++) {
>> > +             env_set("partsize", NULL);
>> > +             ut_assertok(run_commandf("part size mmc %u %s partsize",
>> > +                                      mmc_dev_num, gpt_parts[i].name)=
);
>> > +             snprintf(expected, sizeof(expected), "%lx",
>> > +                      (unsigned long)gpt_parts[i].size);
>> > +             ut_asserteq_str(expected, env_get("partsize"));
>> > +     }
>> > +
>> > +     env_set("partsize", NULL);
>> > +     ut_asserteq(1, run_commandf("part size mmc %u bogus partsize",
>> > +                                 mmc_dev_num));
>> > +     ut_assertnull(env_get("partsize"));
>> > +
>> > +     return 0;
>> > +}
>> > +CMD_TEST(cmd_test_part_size, UTF_CONSOLE);
>>
>>
>
> --
> *Dario Binacchi*
> Senior Embedded Software Engineer
> M. +39 328 0625246
> dario.binacchi@amarulasolutions.com
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
> Amarula Solutions SRL
>  Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
> info@amarulasolutions.com
> www.amarulasolutions.com
>


--=20
*Dario Binacchi*
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
