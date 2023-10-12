Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B23CCDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBED986DF7;
	Thu, 12 Oct 2023 05:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OCGDtok5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB79D86E29; Thu, 12 Oct 2023 05:43:35 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9059786E0F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7ab31fb8bso6366427b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082210; x=1697687010; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lcuWVZkMNPDzE6rEqGAbXBtGTZoW/40FKZE4ErBCfF0=;
 b=OCGDtok5psRB8mjOV9vAU9RgY/VC29hhhcfJ8a39UjsmPyk6U6iRs9svcAy/3ImWsf
 sLcy3jBlz2vnpLyV8ONiCKISZDelDtYb16tMkp2W4Y+kX7b8iGqEl0qA7QPHZl8F7GtH
 bjb30fJWTjyX3NidW3itUFSYOpetTSHMgYifo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082210; x=1697687010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcuWVZkMNPDzE6rEqGAbXBtGTZoW/40FKZE4ErBCfF0=;
 b=ne/o+sIzFYMoM+knO2XdD/ZEqpanx21A2dGhGH2Z6Ac3jb9ToXew2fjVycWNCEvWn0
 2PAf5nFnLlNq7pwdUAfidtK77/qkmaERb6qIu8mH+e9j7/eNuAoNumnF8KldPnIovBT/
 cd/SW1jtUzrlis/aQ5kDBYQC5xuWqRqql0NeABJ1yVBHXiJicsoYbPVWWsJ5Rw14a6Vb
 f1OBm0PI9jpWgISzvTulvhjhf++7O8XvoKhJYvtmB/ytvG1teRPTPNtMZIGdj5uQSmF6
 VDpaQV0b0u7kQcCAJqn8OF0jLwCTNO3AuXlO/CiRkhxgYlb4WgAhjojYNDoSK0nou4yL
 cG2Q==
X-Gm-Message-State: AOJu0YwNkBqDPFp653qKEWzwIK/lW2WxcQC/v9iJMRYuZl/WchPUBlwH
 wV36JiY3g8ydpOh/tqvQqi9dhRVr6ITD13SdbLs2PIJthcJ8qSkQF8k=
X-Google-Smtp-Source: AGHT+IG5hZxX9YsQ2STrMNPthSahS0Np64X9feiE97UNzdAprex754voBydEZu17aupEhDRCCXb6yohLWTW5xBi7z0U=
X-Received: by 2002:a05:690c:d94:b0:5a7:fcae:f3e2 with SMTP id
 da20-20020a05690c0d9400b005a7fcaef3e2mr965497ywb.43.1697082210022; Wed, 11
 Oct 2023 20:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-10-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-10-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:03 -0700
Message-ID: <CAPnjgZ2EaPEQArs73V1Cm1RoaD6YaHVpLUfB6oFYJTQXd=JiMA@mail.gmail.com>
Subject: Re: [PATCH 09/26] spl: Allow enabling SPL_OF_REAL and SPL_OF_PLATDATA
 at the same time
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Heiko Schocher <hs@denx.de>
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

Hi Sean,

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> Sandbox unit tests in U-Boot proper load a test device tree to have some
> devices to work with. In order to do the same in SPL, we must enable
> SPL_OF_REAL. However, we already have SPL_OF_PLATDATA enabled. When
> generating platdata from a devicetree, it is expected that we will not need
> devicetree access functions (even though SPL_OF_CONTROL is enabled). This
> expectation does not hold for sandbox, so allow user control of
> SPL_OF_REAL.
>
> There are several places in the tree where conditions involving OF_PLATDATA
> or OF_REAL no longer function correctly when both of these options can be
> selected at the same time. Adjust these conditions accordingly.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  drivers/core/Makefile               | 1 +
>  drivers/i2c/i2c-emul-uclass.c       | 2 +-
>  drivers/serial/sandbox.c            | 2 +-
>  drivers/sysreset/sysreset_sandbox.c | 2 +-
>  dts/Kconfig                         | 8 +++++---
>  test/test-main.c                    | 2 +-
>  6 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

with a due sense of foreboding

I wonder whether this might create confusion?

>
> diff --git a/drivers/core/Makefile b/drivers/core/Makefile
> index bce0a3f65cb..acbd2bf2cef 100644
> --- a/drivers/core/Makefile
> +++ b/drivers/core/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_$(SPL_)OF_LIVE) += of_access.o of_addr.o
>  ifndef CONFIG_DM_DEV_READ_INLINE
>  obj-$(CONFIG_OF_CONTROL) += read.o
>  endif
> +obj-$(CONFIG_$(SPL_)OF_PLATDATA) += read.o
>  obj-$(CONFIG_OF_CONTROL) += of_extra.o ofnode.o read_extra.o
>
>  ccflags-$(CONFIG_DM_DEBUG) += -DDEBUG
> diff --git a/drivers/i2c/i2c-emul-uclass.c b/drivers/i2c/i2c-emul-uclass.c
> index 1107cf309fc..d421ddfcbe2 100644
> --- a/drivers/i2c/i2c-emul-uclass.c
> +++ b/drivers/i2c/i2c-emul-uclass.c
> @@ -46,7 +46,7 @@ int i2c_emul_find(struct udevice *dev, struct udevice **emulp)
>         struct udevice *emul;
>         int ret;
>
> -       if (!CONFIG_IS_ENABLED(OF_PLATDATA)) {
> +       if (CONFIG_IS_ENABLED(OF_REAL)) {
>                 ret = uclass_find_device_by_phandle(UCLASS_I2C_EMUL, dev,
>                                                     "sandbox,emul", &emul);
>         } else {
> diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
> index f4003811ee7..f6ac3d22852 100644
> --- a/drivers/serial/sandbox.c
> +++ b/drivers/serial/sandbox.c
> @@ -280,7 +280,7 @@ U_BOOT_DRIVER(sandbox_serial) = {
>         .flags = DM_FLAG_PRE_RELOC,
>  };
>
> -#if CONFIG_IS_ENABLED(OF_REAL)
> +#if CONFIG_IS_ENABLED(OF_REAL) && !CONFIG_IS_ENABLED(OF_PLATDATA)
>  static const struct sandbox_serial_plat platdata_non_fdt = {
>         .colour = -1,
>  };
> diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
> index 3750c60b9b9..f485a135299 100644
> --- a/drivers/sysreset/sysreset_sandbox.c
> +++ b/drivers/sysreset/sysreset_sandbox.c
> @@ -132,7 +132,7 @@ U_BOOT_DRIVER(warm_sysreset_sandbox) = {
>         .ops            = &sandbox_warm_sysreset_ops,
>  };
>
> -#if CONFIG_IS_ENABLED(OF_REAL)
> +#if CONFIG_IS_ENABLED(OF_REAL) && !CONFIG_IS_ENABLED(OF_PLATDATA)
>  /* This is here in case we don't have a device tree */
>  U_BOOT_DRVINFO(sysreset_sandbox_non_fdt) = {
>         .name = "sysreset_sandbox",
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 9152f5885e9..c6fb193ca89 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -410,12 +410,14 @@ config SPL_OF_PLATDATA
>           declarations for each node. See of-plat.txt for more information.
>
>  config SPL_OF_REAL
> -       bool
> +       bool "Support a real devicetree in SPL"

To avoid the user doing something silly, I wonder if it would be
better to keep this option hidden, but enable it for sandbox_spl via
Kconfig?

> +       depends on SPL_OF_CONTROL
> +       select SPL_OF_LIBFDT
>         help
>           Indicates that a real devicetree is available which can be accessed
>           at runtime. This means that dev_read_...() functions can be used to
> -         read data from the devicetree for each device. This is true if
> -         SPL_OF_CONTROL is enabled and not SPL_OF_PLATDATA
> +         read data from the devicetree for each device. You do not need to
> +         enable this option if you have enabled SPL_OF_PLATDATA.
>
>  if SPL_OF_PLATDATA
>
> diff --git a/test/test-main.c b/test/test-main.c
> index edb20bc4b9c..b7015d9f38d 100644
> --- a/test/test-main.c
> +++ b/test/test-main.c
> @@ -303,7 +303,7 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
>         if (test->flags & UT_TESTF_PROBE_TEST)
>                 ut_assertok(do_autoprobe(uts));
>
> -       if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
> +       if (CONFIG_IS_ENABLED(OF_REAL) &&
>             (test->flags & UT_TESTF_SCAN_FDT)) {
>                 /*
>                  * only set this if we know the ethernet uclass will be created
> --
> 2.37.1
>

Regards,
Simon
