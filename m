Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98C4CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A59B86F16;
	Sun, 15 Oct 2023 09:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CAansci0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60AFB86F27; Sun, 15 Oct 2023 09:30:19 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D5186F1F
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so34876695e9.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697355015; x=1697959815; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fo9bOOoREDYFQA6r7PsEeGGjBoC8RItgSspyIPy2QB8=;
 b=CAansci0+A1YuUzPcY8qlINJppJ/+zl/WlwrLLNZs5ZsIHKYXdSJVACQhsSJCXXgrK
 bAU188QJruH2a9UMzBj7E6GTMoMQqeFwfISc4Y0jMpgGNsEtoi8cZn2DCNEXQ7OZ2e64
 oUIbrXTG3PexHX9MFtC5stQkfzi67b9rfrv8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697355015; x=1697959815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fo9bOOoREDYFQA6r7PsEeGGjBoC8RItgSspyIPy2QB8=;
 b=KPm0nt+msr0f6wVSoWbFLpcdTAcLHAb5GgD8qu3hJq0kuuoGkWROPg3SE6uQRNDrVb
 +Y40GaUV2HEEKnaHksmAu45EHfCNIoCXoWWRX7lozV5cqP+uoYUOJ4hRbcF3Fdv9RUEc
 gy11cW2EzviRnMeeG6d0gkKxl9f64/QOpr2SRpL4Bh3kLTRL/Q7UQgVOjBflj3B0+JDs
 G+fpk2XXCXF+nDA/l3f6F7V9zUWtp3vx15G9D2NnMj2ntT2JfHegGFRDKflvGSmDVSLi
 f+rXppftklaaBgXwUHIw+U7NaUNLvW7CP9nWPXWJVyWs7YSOsiDjGo17hO1Ar1nPmPsH
 USsA==
X-Gm-Message-State: AOJu0YwqlOSltr5N+Rg+xsOS9Gt3xYACCmQgQFoQhcDBm71tFM6+AIgx
 WDc9njj30Z0rhwZ6+Jrl0wqW4EEy9mXfA2MbjJe9hjj98xxuopSpU1k=
X-Google-Smtp-Source: AGHT+IHNYAxm2gWq9U55yucFt6UfF/3UzkfCidT62PhtxSQjQ+8jypIaMENhLiyF2vId9DQeFOQQeX7cZqlIF0+EJSE=
X-Received: by 2002:ac2:592a:0:b0:4fd:fc36:68a2 with SMTP id
 v10-20020ac2592a000000b004fdfc3668a2mr22856946lfi.1.1697307600656; Sat, 14
 Oct 2023 11:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
 <e0bbaa48-6a9a-f56c-a9b9-809e7ca11592@gmail.com>
 <7488c39a-2d40-0886-4142-415420a9df26@rock-chips.com>
In-Reply-To: <7488c39a-2d40-0886-4142-415420a9df26@rock-chips.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 14 Oct 2023 12:19:47 -0600
Message-ID: <CAPnjgZ3cSSg78gqivhj0GeXrStj5uUTsaFYM2LEHpD8PzLpFng@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] rockchip: test: dm: add rkmtd test
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Johan Jonker <jbx6244@gmail.com>, philipp.tomsich@vrull.eu, 
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 u-boot@lists.denx.de
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

Hi,

On Fri, 13 Oct 2023 at 00:17, Kever Yang <kever.yang@rock-chips.com> wrote:
>
>
> On 2023/10/13 04:52, Johan Jonker wrote:
> > Add Rockchip rkmtd test:
> > Create/attach/detach RKMTD device.
> > Send/read data with Rockchip boot block header.
> > Test that reusing the same label should work.
> > Basic test of 'rkmtd' commands.
> >
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>
> Thanks,
> - Kever
> > ---
> >
> > Changed V3:
> >    New patch
> > ---
> >   test/dm/Makefile |   1 +
> >   test/dm/rkmtd.c  | 201 +++++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 202 insertions(+)
> >   create mode 100644 test/dm/rkmtd.c

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

> >
> > diff --git a/test/dm/Makefile b/test/dm/Makefile
> > index 7ed00733c1a6..a5e0a2744375 100644
> > --- a/test/dm/Makefile
> > +++ b/test/dm/Makefile
> > @@ -100,6 +100,7 @@ obj-$(CONFIG_REMOTEPROC) += remoteproc.o
> >   obj-$(CONFIG_DM_RESET) += reset.o
> >   obj-$(CONFIG_SYSRESET) += sysreset.o
> >   obj-$(CONFIG_DM_REGULATOR) += regulator.o
> > +obj-$(CONFIG_CMD_RKMTD) += rkmtd.o
> >   obj-$(CONFIG_DM_RNG) += rng.o
> >   obj-$(CONFIG_DM_RTC) += rtc.o
> >   obj-$(CONFIG_SCMI_FIRMWARE) += scmi.o
> > diff --git a/test/dm/rkmtd.c b/test/dm/rkmtd.c
> > new file mode 100644
> > index 000000000000..90b404f85441
> > --- /dev/null
> > +++ b/test/dm/rkmtd.c
> > @@ -0,0 +1,201 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> > +/*
> > + * Test derived from:
> > + * /test/dm/host.c
> > + * Copyright 2022 Google LLC
> > + * Written by Simon Glass <sjg@chromium.org>
> > + *
> > + * Copyright (C) 2023 Johan Jonker <jbx6244@gmail.com>
> > + */
> > +
> > +#include <common.h>
> > +#include <asm/test.h>

please check header order [1]


> > +#include <blk.h>
> > +#include <dm.h>
> > +#include <dm/device-internal.h>
> > +#include <dm/test.h>
> > +#include <fs.h>
> > +#include <rkmtd.h>
> > +#include <test/test.h>
> > +#include <test/ut.h>
> > +
> > +#define BUF_SIZE     12 * 512
> > +
> > +/* Basic test of the RKMTD interface */
> > +static int dm_test_rkmtd(struct unit_test_state *uts)
> > +{
> > +     struct udevice *dev, *part, *chk, *blk;
> > +     char write[BUF_SIZE], read[BUF_SIZE];
> > +     static const char label[] = "test";
> > +     struct rkmtd_dev *plat;
> > +     struct blk_desc *desc;
> > +     struct sector0 *sec0;
> > +     int i;
> > +
> > +     ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_RKMTD, &dev));
> > +     ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_PARTITION, &part));
> > +
> > +     ut_assertok(rkmtd_create_device(label, &dev));
> > +
> > +     /* Check that the plat data has been allocated */
> > +     plat = dev_get_plat(dev);
> > +     ut_asserteq_str("test", plat->label);
> > +     ut_assert(label != plat->label);
> > +
> > +     /* Attach RKMTD driver */
> > +     ut_assertok(rkmtd_attach(dev));
> > +     ut_assertok(uclass_first_device_err(UCLASS_RKMTD, &chk));
> > +     ut_asserteq_ptr(chk, dev);
> > +
> > +     /* Get RKMTD block device */
> > +     ut_assertok(blk_get_from_parent(dev, &blk));
> > +     ut_assertok(device_probe(blk));
> > +
> > +     /* There should be a GPT partition table in this device */
> > +     ut_asserteq(0, uclass_first_device_err(UCLASS_PARTITION, &part));
> > +
> > +     /* Write a boot block and verify that we get the same data back */
> > +     desc = dev_get_uclass_plat(blk);
> > +     ut_asserteq(true, desc->removable);
> > +     ut_asserteq(LBA, desc->lba);
> > +
> > +     memset(write, 0, BLK_SIZE);

'\0'

> > +
> > +     for (i = BLK_SIZE; i < sizeof(write); i++)
> > +             write[i] = i;
> > +
> > +     sec0 = (struct sector0 *)write;
> > +     sec0->magic = 0x0FF0AA55;
> > +     sec0->rc4_flag = 0;
> > +     sec0->boot_code1_offset = 4;
> > +     sec0->boot_code2_offset = 4;
> > +     sec0->flash_data_size = 4;
> > +     sec0->flash_boot_size = 8;
> > +
> > +     rkmtd_rc4(write, 512);

check error

> > +
> > +     ut_asserteq(12, blk_dwrite(desc, 64, 12, write));
> > +     ut_asserteq(12, blk_dread(desc, 64, 12, read));
> > +     ut_asserteq_mem(write, read, BUF_SIZE);
> > +
> > +     ut_assertok(rkmtd_detach(dev));
> > +
> > +     ut_asserteq(-ENODEV, blk_get_from_parent(dev, &blk));
> > +     ut_assertok(device_unbind(dev));
> > +
> > +     return 0;
> > +}
> > +DM_TEST(dm_test_rkmtd, UT_TESTF_SCAN_FDT);
> > +
> > +/* Reusing the same label should work */
> > +static int dm_test_rkmtd_dup(struct unit_test_state *uts)
> > +{
> > +     static const char label[] = "test";
> > +     struct udevice *dev, *chk;
> > +
> > +     /* Create a RKMTD device with label "test" */
> > +     ut_asserteq(0, uclass_id_count(UCLASS_RKMTD));
> > +     ut_assertok(rkmtd_create_device(label, &dev));
> > +     ut_assertok(rkmtd_attach(dev));
> > +     ut_assertok(uclass_first_device_err(UCLASS_RKMTD, &chk));
> > +     ut_asserteq_ptr(chk, dev);
> > +     ut_asserteq(1, uclass_id_count(UCLASS_RKMTD));
> > +
> > +     /* Create another device with the same label (should remove old one) */
> > +     ut_assertok(rkmtd_create_device(label, &dev));
> > +     ut_assertok(rkmtd_attach(dev));
> > +     ut_assertok(uclass_first_device_err(UCLASS_RKMTD, &chk));
> > +     ut_asserteq_ptr(chk, dev);
> > +
> > +     /* Make sure there is still only one device */
> > +     ut_asserteq(1, uclass_id_count(UCLASS_RKMTD));
> > +
> > +     return 0;
> > +}
> > +DM_TEST(dm_test_rkmtd_dup, UT_TESTF_SCAN_FDT);
> > +
> > +/* Basic test of the 'rkmtd' command */
> > +static int dm_test_rkmtd_cmd(struct unit_test_state *uts)
> > +{
> > +     struct udevice *dev, *blk;
> > +     struct blk_desc *desc;
> > +
> > +     console_record_reset();

Should not need this (with flag below)

> > +
> > +     /* First check 'rkmtd info' with binding */
> > +     ut_assertok(run_command("rkmtd info", 0));
> > +     ut_assert_nextline("dev       blocks label          ");
> > +     ut_assert_console_end();
> > +
> > +     /* Bind device 1 */
> > +     ut_assertok(run_commandf("rkmtd bind test1"));
> > +     ut_assertok(uclass_first_device_err(UCLASS_RKMTD, &dev));
> > +     ut_assertok(blk_get_from_parent(dev, &blk));
> > +     desc = dev_get_uclass_plat(blk);
> > +
> > +     ut_assertok(run_command("rkmtd info", 0));
> > +     ut_assert_nextline("dev       blocks label          ");
> > +     ut_assert_nextline("  0          609 test1          ");
> > +     ut_assert_console_end();
> > +
> > +     /* Bind device 2 */
> > +     ut_assertok(run_commandf("rkmtd bind test2"));
> > +     ut_assertok(uclass_next_device_err(&dev));
> > +     ut_assertok(blk_get_from_parent(dev, &blk));
> > +     desc = dev_get_uclass_plat(blk);
> > +
> > +     ut_assertok(run_command("rkmtd info", 0));
> > +     ut_assert_nextline("dev       blocks label          ");
> > +     ut_assert_nextline("  0          609 test1          ");
> > +     ut_assert_nextline("  1          609 test2          ");
> > +     ut_assert_console_end();
> > +
> > +     ut_asserteq(1, run_command("rkmtd info test", 0));
> > +     ut_assert_nextline("No such device 'test'");
> > +     ut_assert_console_end();
> > +
> > +     ut_assertok(run_command("rkmtd info test2", 0));
> > +     ut_assert_nextline("dev       blocks label          ");
> > +     ut_assert_nextline("  1          609 test2          ");
> > +     ut_assert_console_end();
> > +
> > +     /* Check 'rkmtd dev' */
> > +     ut_asserteq(1, run_command("rkmtd dev", 0));
> > +     ut_assert_nextline("No current rkmtd device");
> > +     ut_assert_console_end();
> > +
> > +     ut_asserteq(1, run_command("rkmtd dev missing", 0));
> > +     ut_assert_nextline("No such device 'missing'");
> > +     ut_assert_console_end();
> > +
> > +     ut_assertok(run_command("rkmtd dev test2", 0));
> > +     ut_assert_console_end();
> > +
> > +     ut_assertok(run_command("rkmtd dev", 0));
> > +     ut_assert_nextline("Current rkmtd device: 1: test2");
> > +     ut_assert_console_end();
> > +
> > +     /* Try a numerical label */
> > +     ut_assertok(run_command("rkmtd dev 0", 0));
> > +     ut_assert_console_end();
> > +
> > +     ut_assertok(run_command("rkmtd dev", 0));
> > +     ut_assert_nextline("Current rkmtd device: 0: test1");
> > +     ut_assert_console_end();
> > +
> > +     /* Remove one of the bindings */
> > +     ut_assertok(run_commandf("rkmtd unbind test1"));
> > +
> > +     /* There should now be no current device */
> > +     ut_asserteq(1, run_command("rkmtd dev", 0));
> > +     ut_assert_nextline("No current rkmtd device");
> > +     ut_assert_console_end();
> > +
> > +     ut_assertok(run_command("rkmtd info", 0));
> > +     ut_assert_nextline("dev       blocks label          ");
> > +     ut_assert_nextline("  1          609 test2          ");
> > +     ut_assert_console_end();
> > +
> > +     return 0;
> > +}
> > +DM_TEST(dm_test_rkmtd_cmd, UT_TESTF_SCAN_FDT);

| UT_TESTF_CONSOLE_REC

> > --
> > 2.39.2
> >

Regards,
Simon


[1] https://u-boot.readthedocs.io/en/latest/develop/codingstyle.html#include-files
