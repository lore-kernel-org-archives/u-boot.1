Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113F5CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8619E86D73;
	Thu, 21 Sep 2023 03:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="mIxSFCq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D45D86D21; Thu, 21 Sep 2023 03:06:08 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350A286D3E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59e88a28b98so5181057b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sGKDH4HsOuBwMVOLXuz6npw3ZYUIvxOXDCSaur46vM8=;
 b=mIxSFCq6S0X5M2RztSpGKFmm9t4V9CV15gq/BiZW7LUf7SN0+PNim2R6H07iuEQR9f
 bPkSd/sPt+QhAn64qpW0r7KtWnul6/GhmkjCgvtWLaUEcB9mQomEDffWXG/cQn40371r
 B15Yqbhk6Omp0esEZmCACAC24E7n0KezaM+BBo0DZap/MMGRzZjPF7io6bBju7jxbDDg
 KFNm9Soe35ZH8C3j3IWswjAqYDMoWaobnk8sMIDAy2kpNLUj2UNOFi+barXBnk/JzM89
 LkT9Ft/WUXtw1aVQQzjkajLRCYl7TLuvs16TttS7la+lY26OBibaqHq1nLteIMjjyZ/W
 EPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sGKDH4HsOuBwMVOLXuz6npw3ZYUIvxOXDCSaur46vM8=;
 b=At1pDriCaeRU9O2RysVtN4USfAML28aqpZJWvsmubbpFb2BzhNi1WgughKxsoE+glm
 TLdWVDUxPFteZ46cZqqYXQ9rs1KB8/Jj1F9DgcknyV5uQLCKk03QydNjrT/JPpJaAKau
 BJXkx6jfdt7kSj7wZlhDHukgzr2V0oh+Ju0aoR18TmP2b1iT5WgAYAC4wt9+rsDfQoaM
 VUjlr1cokb3cwaVTC0fqDeL2fWlhghouvNrAWWw4Jo0XP/6WToraJDrp9igQCmBFUzhJ
 IOE4T6t9Y8NfSPQN4Zu0K9+j22/l8jUST+FwU72ekoqQ38z3QoIRcYjVDzUx0ElhMwy3
 TF2A==
X-Gm-Message-State: AOJu0YzOCFYjPToOTRuArXL0ite8h8d7joHTcm+RUmp3mISH013gGAcV
 yAfMwhf0eCcmovLEZ/cBX2WFD4hsI6W1TAHLJ7Na3Q==
X-Google-Smtp-Source: AGHT+IGzlF4hYv23o1UlBQGli/n6WG2aL9icMIsem6b+S8CHdx2kJ+x32Hf+1CmhBursHbBoIauiZoC0vjPvjPEP4n0=
X-Received: by 2002:a81:a04b:0:b0:577:3cd0:3728 with SMTP id
 x72-20020a81a04b000000b005773cd03728mr6844897ywg.14.1695258357409; Wed, 20
 Sep 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911163536.20735-1-avromanov@salutedevices.com>
 <20230911163536.20735-9-avromanov@salutedevices.com>
In-Reply-To: <20230911163536.20735-9-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:03:15 -0600
Message-ID: <CAPnjgZ3RE1abid=c+t2KyLNrUpA2d+=7hMeE-bSzv=hpR5fHsw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] arch: meson: use secure monitor driver
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
 takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, 
 marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, 
 jh80.chung@samsung.com, paul.barker@sancloud.com, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, kernel@sberdevices.ru
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

Hi Alexey,

On Mon, 11 Sept 2023 at 10:35, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> Now we have to use UCLASS_SM driver instead of
> raw smc_call() function call.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  arch/arm/mach-meson/Kconfig |   1 +
>  arch/arm/mach-meson/sm.c    | 110 +++++++++++++++++++-----------------
>  2 files changed, 58 insertions(+), 53 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

with fix below

>
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index 669ca09a00..d6c8905806 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -11,6 +11,7 @@ config MESON64_COMMON
>         select PWRSEQ
>         select MMC_PWRSEQ
>         select BOARD_LATE_INIT
> +       select MESON_SM
>         imply CMD_DM
>
>  config MESON_GX
> diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
> index b5dd6c6d39..0c60aa8695 100644
> --- a/arch/arm/mach-meson/sm.c
> +++ b/arch/arm/mach-meson/sm.c
> @@ -9,6 +9,7 @@
>  #include <dm.h>
>  #include <log.h>
>  #include <regmap.h>
> +#include <sm.h>
>  #include <syscon.h>
>  #include <asm/arch/sm.h>
>  #include <asm/cache.h>
> @@ -18,70 +19,62 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/bitfield.h>
> +#include <meson/sm.h>
>
> -#define FN_GET_SHARE_MEM_INPUT_BASE    0x82000020
> -#define FN_GET_SHARE_MEM_OUTPUT_BASE   0x82000021
> -#define FN_EFUSE_READ                  0x82000030
> -#define FN_EFUSE_WRITE                 0x82000031
> -#define FN_CHIP_ID                     0x82000044
> -#define FN_PWRDM_SET                   0x82000093
> -
> -static void *shmem_input;
> -static void *shmem_output;
> -
> -static void meson_init_shmem(void)
> +static inline struct udevice *meson_get_sm_device(void)
>  {
> -       struct pt_regs regs;
> -
> -       if (shmem_input && shmem_output)
> -               return;
> +       struct udevice *dev;
> +       int err;
>
> -       regs.regs[0] = FN_GET_SHARE_MEM_INPUT_BASE;
> -       smc_call(&regs);
> -       shmem_input = (void *)regs.regs[0];
> -
> -       regs.regs[0] = FN_GET_SHARE_MEM_OUTPUT_BASE;
> -       smc_call(&regs);
> -       shmem_output = (void *)regs.regs[0];
> +       err = uclass_get_device_by_name(UCLASS_SM, "secure-monitor", &dev);

Can you use uclass_first_device_err(UCLASS_SM, ...

instead? We should not be looking up devices by name.

> +       if (err) {
> +               pr_err("Mesom SM device not found\n");
> +               return ERR_PTR(err);
> +       }
>
> -       debug("Secure Monitor shmem: 0x%p 0x%p\n", shmem_input, shmem_output);
> +       return dev;
>  }
>
>  ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size)
>  {
> -       struct pt_regs regs;
> +       struct udevice *dev;
> +       struct pt_regs regs = { 0 };
> +       int err;
>
> -       meson_init_shmem();
> +       dev = meson_get_sm_device();
> +       if (IS_ERR(dev))
> +               return PTR_ERR(dev);
>
> -       regs.regs[0] = FN_EFUSE_READ;
>         regs.regs[1] = offset;
>         regs.regs[2] = size;
>
> -       smc_call(&regs);
> +       err = sm_call_read(dev, buffer, size,
> +                          MESON_SMC_CMD_EFUSE_READ, &regs);
> +       if (err < 0)
> +               pr_err("Failed to read efuse memory (%d)\n", err);
>
> -       if (regs.regs[0] == 0)
> -               return -1;
> -
> -       memcpy(buffer, shmem_output, min(size, regs.regs[0]));
> -
> -       return regs.regs[0];
> +       return err;
>  }
>
>  ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
>  {
> -       struct pt_regs regs;
> -
> -       meson_init_shmem();
> +       struct udevice *dev;
> +       struct pt_regs regs = { 0 };
> +       int err;
>
> -        memcpy(shmem_input, buffer, size);
> +       dev = meson_get_sm_device();
> +       if (IS_ERR(dev))
> +               return PTR_ERR(dev);
>
> -       regs.regs[0] = FN_EFUSE_WRITE;
>         regs.regs[1] = offset;
>         regs.regs[2] = size;
>
> -       smc_call(&regs);
> +       err = sm_call_write(dev, buffer, size,
> +                           MESON_SMC_CMD_EFUSE_WRITE, &regs);
> +       if (err < 0)
> +               pr_err("Failed to write efuse memory (%d)\n", err);
>
> -       return regs.regs[0];
> +       return err;
>  }
>
>  #define SM_CHIP_ID_LENGTH      119
> @@ -90,18 +83,21 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
>
>  int meson_sm_get_serial(void *buffer, size_t size)
>  {
> -       struct pt_regs regs;
> +       struct udevice *dev;
> +       struct pt_regs regs = { 0 };
> +       u8 id_buffer[SM_CHIP_ID_LENGTH];
> +       int err;
>
> -       meson_init_shmem();
> +       dev = meson_get_sm_device();
> +       if (IS_ERR(dev))
> +               return PTR_ERR(dev);
>
> -       regs.regs[0] = FN_CHIP_ID;
> -       regs.regs[1] = 0;
> -       regs.regs[2] = 0;
> +       err = sm_call_read(dev, id_buffer, SM_CHIP_ID_LENGTH,
> +                          MESON_SMC_CMD_CHIP_ID_GET, &regs);
> +       if (err < 0)
> +               pr_err("Failed to read serial number (%d)\n", err);
>
> -       smc_call(&regs);
> -
> -       memcpy(buffer, shmem_output + SM_CHIP_ID_OFFSET,
> -              min_t(size_t, size, SM_CHIP_ID_SIZE));
> +       memcpy(buffer, id_buffer + SM_CHIP_ID_OFFSET, size);
>
>         return 0;
>  }
> @@ -141,13 +137,21 @@ int meson_sm_get_reboot_reason(void)
>
>  int meson_sm_pwrdm_set(size_t index, int cmd)
>  {
> -       struct pt_regs regs;
> +       struct udevice *dev;
> +       struct pt_regs regs = { 0 };
> +       int err;
> +
> +       dev = meson_get_sm_device();
> +       if (IS_ERR(dev))
> +               return PTR_ERR(dev);
>
> -       regs.regs[0] = FN_PWRDM_SET;
>         regs.regs[1] = index;
>         regs.regs[2] = cmd;
>
> -       smc_call(&regs);
> +       err = sm_call(dev, MESON_SMC_CMD_PWRDM_SET, NULL, &regs);
> +       if (err)
> +               pr_err("Failed to %s power domain ind=%zu (%d)\n", cmd == PWRDM_ON ?
> +                               "enable" : "disable", index, err);
>
> -       return regs.regs[0];
> +       return err;
>  }
> --
> 2.25.1
>

Regards,
Simon
