Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29085C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5B4F88958;
	Wed, 31 Jul 2024 09:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xoP0LuTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A74F8897F; Wed, 31 Jul 2024 09:32:07 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B9F08890A
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cf93dc11c6so2909228a91.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722411123; x=1723015923; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B7FQql2JxT7hka86PwbkEwyOGSMoI3uCNE8paAWRr+U=;
 b=xoP0LuTJ94KVIkxIEFSKP53wDuvc2c619hNVHcAQi5i/ZB+R7oYAR7SpWTI9lIjUsA
 rzSAT623ee4l+vfy+cpGujHRSAblhJpxjrynJuMCUW+veqdOjmzrPznCDqVzruadM1cM
 /JeSkpNsDIbVnQVk7soyDxcICNjy+s6FFAF9UQ/dbThVMILWPKx/4VoEec27Gl0BAzU3
 Yn+zAJv8xX2PMJyIN8h2UJ3Y0kmvzJ4yMWR8jcb8yLyfouUgCoqjLnNvF3fX5Fjv3eT8
 gVep95ydq6rPxa9joL4ja3T09fL53IBLry6ZXWdPe3SU2DRqZP9p5ln88F4xvt0U5jIH
 bKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722411123; x=1723015923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B7FQql2JxT7hka86PwbkEwyOGSMoI3uCNE8paAWRr+U=;
 b=mUt/lpRKACHe+ezeIogVd29RO1WRH1xXeq201fy98Z/PScJGCWMSXLpVVxN+gKi25f
 IP2jR87+J8+Bzbph/AmsmcY30bGfjo2AKLmdaa2Y+SD+lG9WVURFjDbGAAlEDREf98T0
 leMhm5TplOhJF3h3VZ6Eft8Mpxb8mY6aeCQOV3SD67CvQu9+BmAE3Po9+bz4Ira984HS
 PDDeJQdLmZiWHdDWvy4Gnz32K+6FL3YchpoMNsqktxrALF3qew+1HP6I3kllNoop3Djd
 olTeM6reulahT5cCdD3yT6lKcfg3ZxUs0QbiPTcESTl6/tV2s5ycIC2ODbMGYp4SVq1f
 +yxQ==
X-Gm-Message-State: AOJu0YyEfDDx9HGhZo3ue0Z4x8iAyW3W4+yvqF/wrleXVEBFOPuIg68L
 39mhBn52ORBCCw5sK0dHMaQeD41gBR7lFkl5z+4FvE9VIrg04OOFXINutbkKfFs5RdUcTR+w8eP
 SLiJpcrxhTfKVDtUYZxo/8AmrY7asjbP9PzwCxQ==
X-Google-Smtp-Source: AGHT+IEH8/al2ezYFRSbmMxh9apO8rb15kj091daWKUHj9zqaB6aLSJi/ewVgDNFMzqEFXEoheaJNNvxa1OILwo3HKc=
X-Received: by 2002:a17:90a:fe16:b0:2cb:4bed:ed35 with SMTP id
 98e67ed59e1d1-2cf7e835fd4mr14046480a91.41.1722411123372; Wed, 31 Jul 2024
 00:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-5-sughosh.ganu@linaro.org>
In-Reply-To: <20240730111132.1097315-5-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 31 Jul 2024 10:31:27 +0300
Message-ID: <CAC_iWjKa5AO1A3MupbwkJOEnvTtE7-039qKNXCbSoW3X+ku8Og@mail.gmail.com>
Subject: Re: [PATCH 5/5] dm: use list_count_nodes() for counting list nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>
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

On Tue, 30 Jul 2024 at 14:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The linux kernel has the list_count_nodes() API functions which is
> used for counting nodes of a list. This has now been imported in
> U-Boot as part of an earlier commit. Use this function and drop the
> list_count_items().
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  drivers/core/util.c | 14 ++------------
>  include/dm/util.h   |  8 --------
>  test/dm/bus.c       |  5 +++--
>  test/dm/core.c      |  9 +++++----
>  test/dm/test-fdt.c  |  5 +++--
>  5 files changed, 13 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/core/util.c b/drivers/core/util.c
> index 108a3bc4da..fa893485a0 100644
> --- a/drivers/core/util.c
> +++ b/drivers/core/util.c
> @@ -3,23 +3,13 @@
>   * Copyright (c) 2013 Google, Inc
>   */
>
> +#include <vsprintf.h>
>  #include <dm/device.h>
>  #include <dm/ofnode.h>
>  #include <dm/read.h>
>  #include <dm/util.h>
>  #include <linux/libfdt.h>
> -#include <vsprintf.h>
> -
> -int list_count_items(struct list_head *head)
> -{
> -       struct list_head *node;
> -       int count = 0;
> -
> -       list_for_each(node, head)
> -               count++;
> -
> -       return count;
> -}
> +#include <linux/list.h>
>
>  #if CONFIG_IS_ENABLED(OF_REAL)
>  int pci_get_devfn(struct udevice *dev)
> diff --git a/include/dm/util.h b/include/dm/util.h
> index 95c3527a37..ec518c51d9 100644
> --- a/include/dm/util.h
> +++ b/include/dm/util.h
> @@ -16,14 +16,6 @@ struct dm_stats;
>
>  struct list_head;
>
> -/**
> - * list_count_items() - Count number of items in a list
> - *
> - * @param head:                Head of list
> - * Return: number of items, or 0 if empty
> - */
> -int list_count_items(struct list_head *head);
> -
>  /**
>   * Dump out a tree of all devices starting @uclass
>   *
> diff --git a/test/dm/bus.c b/test/dm/bus.c
> index a338c7f567..95326f23da 100644
> --- a/test/dm/bus.c
> +++ b/test/dm/bus.c
> @@ -14,6 +14,7 @@
>  #include <dm/test.h>
>  #include <dm/uclass-internal.h>
>  #include <dm/util.h>
> +#include <linux/list.h>
>  #include <test/test.h>
>  #include <test/ut.h>
>
> @@ -27,14 +28,14 @@ static int dm_test_bus_children(struct unit_test_state *uts)
>         struct uclass *uc;
>
>         ut_assertok(uclass_get(UCLASS_TEST_FDT, &uc));
> -       ut_asserteq(num_devices, list_count_items(&uc->dev_head));
> +       ut_asserteq(num_devices, list_count_nodes(&uc->dev_head));
>
>         /* Probe the bus, which should yield 3 more devices */
>         ut_assertok(uclass_get_device(UCLASS_TEST_BUS, 0, &bus));
>         num_devices += 3;
>
>         ut_assertok(uclass_get(UCLASS_TEST_FDT, &uc));
> -       ut_asserteq(num_devices, list_count_items(&uc->dev_head));
> +       ut_asserteq(num_devices, list_count_nodes(&uc->dev_head));
>
>         ut_assert(!dm_check_devices(uts, num_devices));
>
> diff --git a/test/dm/core.c b/test/dm/core.c
> index dbad1b317d..5bc5e8e82e 100644
> --- a/test/dm/core.c
> +++ b/test/dm/core.c
> @@ -16,6 +16,7 @@
>  #include <dm/util.h>
>  #include <dm/test.h>
>  #include <dm/uclass-internal.h>
> +#include <linux/list.h>
>  #include <test/test.h>
>  #include <test/ut.h>
>
> @@ -123,15 +124,15 @@ static int dm_test_autobind(struct unit_test_state *uts)
>          * device with no children.
>          */
>         ut_assert(uts->root);
> -       ut_asserteq(1, list_count_items(gd->uclass_root));
> -       ut_asserteq(0, list_count_items(&gd->dm_root->child_head));
> +       ut_asserteq(1, list_count_nodes(gd->uclass_root));
> +       ut_asserteq(0, list_count_nodes(&gd->dm_root->child_head));
>         ut_asserteq(0, dm_testdrv_op_count[DM_TEST_OP_POST_BIND]);
>
>         ut_assertok(dm_scan_plat(false));
>
>         /* We should have our test class now at least, plus more children */
> -       ut_assert(1 < list_count_items(gd->uclass_root));
> -       ut_assert(0 < list_count_items(&gd->dm_root->child_head));
> +       ut_assert(1 < list_count_nodes(gd->uclass_root));
> +       ut_assert(0 < list_count_nodes(&gd->dm_root->child_head));
>
>         /* Our 3 dm_test_infox children should be bound to the test uclass */
>         ut_asserteq(3, dm_testdrv_op_count[DM_TEST_OP_POST_BIND]);
> diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
> index 18c89eef43..31effff59c 100644
> --- a/test/dm/test-fdt.c
> +++ b/test/dm/test-fdt.c
> @@ -19,6 +19,7 @@
>  #include <dm/util.h>
>  #include <dm/of_access.h>
>  #include <linux/ioport.h>
> +#include <linux/list.h>
>  #include <test/test.h>
>  #include <test/ut.h>
>
> @@ -162,7 +163,7 @@ static int dm_test_fdt(struct unit_test_state *uts)
>         ut_assert(!ret);
>
>         /* These are num_devices compatible root-level device tree nodes */
> -       ut_asserteq(num_devices, list_count_items(&uc->dev_head));
> +       ut_asserteq(num_devices, list_count_nodes(&uc->dev_head));
>
>         /* Each should have platform data but no private data */
>         for (i = 0; i < num_devices; i++) {
> @@ -217,7 +218,7 @@ static int dm_test_fdt_pre_reloc(struct unit_test_state *uts)
>          * one with "bootph-all" property (a-test node), and the other
>          * one whose driver marked with DM_FLAG_PRE_RELOC flag (h-test node).
>          */
> -       ut_asserteq(2, list_count_items(&uc->dev_head));
> +       ut_asserteq(2, list_count_nodes(&uc->dev_head));
>
>         return 0;
>  }
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
