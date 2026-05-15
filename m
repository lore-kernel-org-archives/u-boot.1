Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8153BCD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 07:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBD283AA9;
	Fri, 15 May 2026 09:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sAwQ9TVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF0B83EF9; Fri, 15 May 2026 09:34:35 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0487838BB
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 09:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65c7efdb7d8so11468883d50.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 00:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778830470; cv=none;
 d=google.com; s=arc-20240605;
 b=eTxI9oUD3XPnZn4ss/ELnZ6O/r/QD+Fsb7IqDFAAt9BwwjMsHgcMrx9szi53alZQ8X
 zAQdSIFtusp8rwUPyI5Yjez36lSSeyQCILRLynKq60HmSYRr/hOqJAgJgnb7V25WERiZ
 lKWfYp0nDti5XYrLjdNE6fKPgEkBx5ROjFNwn8FbuelAfIY6q6UsVsdKMu63oQqhjtY2
 EUBV5A6dm98iUrZpWka4CUZ6WVnJEVthkBCM3dqSOr3jviqu57IWYyNVPjiXwg9Aztfv
 PSo+z3Y6L+1r/i8u8VwAb/fa2m3EwGYusXy5G+x7Q9DkXg2Cc9PNUrZgcZz1ZUrjXkIZ
 LKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G3ItBA1HCCxdI+Aah5WL/t6YwLeEm8ZjUZ4I+NQYMVs=;
 fh=n3NeBbVEsH896qmKKSj+P5XnYtn+NtG3sfnKu/Fm1ic=;
 b=AMHVRbGufWmknPagSXR5rXV3K+xnwQEU15uY7Oc9BqK/wMs55bpa3aA14e0qINyp8D
 kW27ILZ/GtFYiXQl9LYAxCiRtPK8XJ5o69950UbcO6hDy2l6nCx6xcc4jUhRtMpMpjyh
 0ErAm2cQvptV/3al6XPNwm7H7V9lRE0GBhTR+KU9f9/BvnQQgjmeV53DZsXQujirb97W
 qJrm1envWyImpgxUJQYz+LTu/hF9vaXh5tXUXNodO/IXqGeABl7bCFdM6d8req63fyUZ
 6LCzlVIHRtRc439kDrfe+zTEDxwS1nhejZQdlOgUrIiPDWhaHr7KiLhUnCyoTQBOslpl
 6mVg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778830470; x=1779435270; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G3ItBA1HCCxdI+Aah5WL/t6YwLeEm8ZjUZ4I+NQYMVs=;
 b=sAwQ9TVw+Q14+/5Wj+2cvp5hg7WaNvFniqfKFtYuOoUXaylSqRZkQGF3ObYqxYliiX
 Qvgqr3lxXgRnudQBJFqpJSOkiZuI9s+DZ3WsLuERIXjAeZ2F90ynZg0Y1Tr5cN9bs8K8
 upoKMdb4bBFW3cDarKkARZs2I9Pb/1JGddvhgGkKihs6c9bP+rDiY0+ggXjRf2xmAZWF
 yO1ixfSc5FYifOiw1dJ+G3GYWCcCsgTnB204X42E29H8KnpUAzzZQc8RIhE2Fy0cM5FQ
 O5xhKrw6EnCavvbypQaQksjZqaLjyoftd+cSZgixAjIw6gMbNeeSq7EwzazCC2vewHk5
 xJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778830470; x=1779435270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3ItBA1HCCxdI+Aah5WL/t6YwLeEm8ZjUZ4I+NQYMVs=;
 b=lTj/3DPhOM9gyAbOMoCZ95pF9FHOUPHfAOk1yCdkHQLjJ1Xtqh4H5DqBFzRxGLhApZ
 pQA2Em869fZiqyMfZDvFttCZniZX8iTbV3NhzDgFYxq3UmFrPcFqBk1EpA96+f7qQeoH
 ezn8fMGDm79v1ONK2UgW/qS0fLvQcCuT8jlSih5SeAujTH/0j9Ihgxip6wCeW8Xmv/k0
 kWJ6qGJZNEIreMdz2Q+Xx6xyDcOdB75ClOqVqBA55iD0/Ep71jLmxOmK8tJFVMrlveTp
 OvgNER1fcam0FobyL9l8bz4E+8HRMCdMERiqUGnWpBOGd8O6bak1I/A6R8Ld1mmmUYN8
 lVdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QNLPEmGP9jkL0MtesMTY2jNDRNSRjZIHga+5lm6FuN3L8knVTo+GasgqNOv/7CwNWEGnxk+o=@lists.denx.de
X-Gm-Message-State: AOJu0YwRgL92qNUMTt8ynDJQPlBeQpggnHxbkIC0rL/SssvwJF06FyNA
 uQueg6c6ggeX1pV4O73Hd7JapWnZ489a1BnCQVFmtc9EeBugxnlZBpCstoVXkDDTE9FL/PROnJn
 dzpSte2cSsUyyVfLu1yHR7JdQhp/abhdHijoTgc5yQw==
X-Gm-Gg: Acq92OHeFJaGHQTu8PrGQZVRrZn3JuWy0CKjnXzklUNwtIgVdXUD/BuQivaMjVc8zfG
 Tj3Y1HrkbeIuLZgGEHOi+pmEE/Vr2dPcNkORCc0V00KpfGiSqkNZAdNd2S2p4wnbIQ8Q6MrAigN
 AM5rl40DlYttj+lCOl8TriPk3rRrDZa63Vs36IuB90JFvQ87JtkAVpTRwB4C0HpERW7RWaqID+2
 hUopQcgRBO2TMgF1ch6G9CQ2O6wpPT7HxDgqI2/KijWe5vg9i3hGvHcij5ejhkIyU3uOlm1lKmo
 4bPuotA4P2L+qjmjsJ/hrJwiF+FK6i/zPgai+iLBJffNCmSIU7jV77yGq440hFTqRdICAs8sfWy
 vJw+9aW5uPaxpgTAod8e1aMnfZlnZTXQ7vblW1JBTU99RWGnWg+ZqHWwq204IeVrQz2ziMkGBtb
 gIYKthp9SQuHK8ytcfIYqionIdCs4XtRbmD732s/Gb/BTIpZPEcxnwx3fTWRBCo2x+ygnR2KAJ4
 Up00chsv1Z+XM/0JOqH//9Fggf0nUjq33ONiaZ7S8WdjrY1uj4XId6QTLa7sPwvktGCgPuCJ27j
 oxaemClxjPVUXs2FEoqOW4Mlaha8p9bfzlqVLkOlZoNQxC+oqA2c5cnZVlXIkir1hXmehh5/NkJ
 wHUV7Pg==
X-Received: by 2002:a05:690e:4403:b0:651:be8b:e87e with SMTP id
 956f58d0204a3-65e2284f03bmr2199964d50.34.1778830470374; Fri, 15 May 2026
 00:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260513204943.736142-1-rs@ti.com>
 <20260513204943.736142-3-rs@ti.com>
In-Reply-To: <20260513204943.736142-3-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 May 2026 10:33:54 +0300
X-Gm-Features: AVHnY4IrE1T-jrRq3UU7d-4GiFSggehDhGKsZPrXZPqtG6vQ9KRrp8x7cq66E_4
Message-ID: <CAC_iWjJwNLfLoPKrzK8=ZOsdR4VeH3wkYBDqZqRf4hP+_ObnHQ@mail.gmail.com>
Subject: Re: [PATCHv8 2/3] test: boot: add a fdt reserved region check
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, sjg@chromium.org, u-boot@lists.denx.de
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

On Wed, 13 May 2026 at 23:49, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Add a image_fdt suite and a check for boot_fdt_add_mem_rsv_regions. This
> will ensure the user is properly informed of any reservation failures.
> It will also validate that reservations are cleaned up correctly when
> switching FDTs.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> v8:
>         - Rework test_boot_fdt_add_mem_rsv_regions to mitigate lingering state
>
>  test/boot/Makefile          |  1 +
>  test/boot/image_fdt.c       | 70 +++++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c               |  2 ++
>  test/py/tests/test_suite.py |  2 +-
>  4 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 test/boot/image_fdt.c
>
> diff --git a/test/boot/Makefile b/test/boot/Makefile
> index 89538d4f0a6..640af6593cd 100644
> --- a/test/boot/Makefile
> +++ b/test/boot/Makefile
> @@ -14,6 +14,7 @@ endif
>
>  ifdef CONFIG_SANDBOX
>  obj-$(CONFIG_$(PHASE_)CMDLINE) += bootm.o
> +obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += image_fdt.o
>  endif
>  obj-$(CONFIG_MEASURED_BOOT) += measurement.o
>
> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> new file mode 100644
> index 00000000000..778951c1290
> --- /dev/null
> +++ b/test/boot/image_fdt.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <config.h>
> +
> +#include <fdt_support.h>
> +#include <image.h>
> +#include <lmb.h>
> +#include <malloc.h>
> +
> +#include <asm/global_data.h>
> +
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +#define IMAGE_FDT_TEST(_name, _flags) UNIT_TEST(_name, _flags, image_fdt)
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static int test_boot_fdt_add_mem_rsv_regions(struct unit_test_state *uts)
> +{
> +       phys_addr_t start = CFG_SYS_SDRAM_BASE + 0x100000;
> +       const void *old_blob = gd->fdt_blob;
> +       int ret = CMD_RET_FAILURE;
> +       ulong fdt_sz;
> +       int nodeoffset;
> +       void *new_blob;
> +
> +       /* Default reservation should exist */
> +       ut_asserteq(1, lmb_is_reserved_flags(start, LMB_NOMAP));
> +
> +       /* Attempting to re-reserve should warn the user */
> +       boot_fdt_add_mem_rsv_regions(gd->fdt_blob);
> +       ut_assert_nextlinen("ERROR: reserving");
> +       ut_assert_console_end();
> +
> +       /* Loading a new_blob device tree should be allowed */
> +       fdt_sz = fdt_totalsize(gd->fdt_blob);
> +       new_blob = malloc(fdt_sz);
> +       ut_assertok_ptr(new_blob);
> +       memcpy(new_blob, gd->fdt_blob, fdt_sz);
> +
> +       nodeoffset = fdt_path_offset(new_blob, "/reserved-memory");
> +       if (nodeoffset < 0)
> +               goto free_blob;
> +
> +       if (fdt_del_node(new_blob, nodeoffset))
> +               goto free_blob;
> +
> +       boot_fdt_add_mem_rsv_regions(new_blob);
> +       gd->fdt_blob = new_blob;
> +
> +       if (ut_assert_console_end())
> +               goto switch_fdt;
> +
> +       /* Reservation should not exist now */
> +       if (!lmb_is_reserved_flags(start, LMB_NOMAP))
> +               ret = 0;
> +
> +       /* Cleanup */
> +switch_fdt:
> +       boot_fdt_add_mem_rsv_regions(old_blob);
> +       gd->fdt_blob = old_blob;
> +free_blob:
> +       free(new_blob);
> +       return ret;
> +}
> +IMAGE_FDT_TEST(test_boot_fdt_add_mem_rsv_regions, UTF_LIVE_TREE | UTF_CONSOLE);
> diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> index 44e5fdfdaa6..363ed4eab30 100644
> --- a/test/cmd_ut.c
> +++ b/test/cmd_ut.c
> @@ -61,6 +61,7 @@ SUITE_DECL(fdt);
>  SUITE_DECL(fdt_overlay);
>  SUITE_DECL(font);
>  SUITE_DECL(hush);
> +SUITE_DECL(image_fdt);
>  SUITE_DECL(lib);
>  SUITE_DECL(loadm);
>  SUITE_DECL(log);
> @@ -88,6 +89,7 @@ static struct suite suites[] = {
>         SUITE(fdt_overlay, "device tree overlays"),
>         SUITE(font, "font command"),
>         SUITE(hush, "hush behaviour"),
> +       SUITE(image_fdt, "image fdt parsing"),
>         SUITE(lib, "library functions"),
>         SUITE(loadm, "loadm command parameters and loading memory blob"),
>         SUITE(log, "logging functions"),
> diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
> index 7fe9a90dfd3..08285f12a5f 100644
> --- a/test/py/tests/test_suite.py
> +++ b/test/py/tests/test_suite.py
> @@ -8,7 +8,7 @@ import re
>  EXPECTED_SUITES = [
>      'addrmap', 'bdinfo', 'bloblist', 'bootm', 'bootstd',
>      'cmd', 'common', 'dm', 'env', 'exit', 'fdt_overlay',
> -    'fdt', 'font', 'hush', 'lib',
> +    'fdt', 'font', 'hush', 'image_fdt', 'lib',
>      'loadm', 'log', 'mbr', 'measurement', 'mem',
>      'pci_mps', 'setexpr', 'upl',
>      ]
> --
> 2.54.0
>
