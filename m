Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CF9CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 10:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8408488B;
	Wed,  6 May 2026 12:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DLgysV+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A23284897; Wed,  6 May 2026 12:49:22 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D55584882
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 12:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-67b7c71c165so7827780a12.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 03:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778064559; cv=none;
 d=google.com; s=arc-20240605;
 b=ZIrrxRXFOXY9GnwdlyIouGRHJUcDfwCFSwo9icYK+OYX6EIXNmH5d+M78gQ6/fG8CU
 6JOu0zghENW1BYQmhw36iifcEropVYFBv+BFMkHC2hKRP4zaN3t59GfcTve4JMQBojRW
 8RL/IThFY2UnuvvVnbHN5RCulvfXu2Oal8DigZQOnG3d8dji4U7UazsApQjv8KOufpjB
 B6yaPFKFjvzATs24H8oeVvKXnraqQ5Gp1swPjQJJ+LGBSwt9baW863JxQ7kIHHfnxcNY
 Sj1ggNkN2/6h00L8LQQ8CgldXyOw9/w4SKPZNlCScxuCaz+egRQnVznefTkEfLdyBYcV
 4tLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kX4JTa/WzmJFD4bBfqq8b7xF6GkUeJRZjgAbIx2V7No=;
 fh=zRLnNarVXgpDlU5dj8kDuox+8a6k7QvOF1dsRmOKbvw=;
 b=Sz0OlMeobHGmBrOfl83BZp8Z186G5/Ci5fisJOOsvsjNA5GvpnqCvXd/TZqV6gt00b
 yLFI6lZ0EkVvs2UzC4mb4kaQ0eIkHYfyLfI5SPM3/AnjmI8S5+U6b0RiGzjVQTBADiEZ
 vtoEpDJyXjeTA7LYqUL5eHu7eVmvHwHu0CCK4CZntq19Y1mc7qfR+LBMMrmbHO8xYArb
 0wpzAG99RTIDhDI4rkPwRoJ+VVv8NJPf8qkf28PjHm+1SJiytB5zoV1csH9oQOLIo91y
 t+Z0rH1G85wz9JbB1Va7AgCijx8MyM51fM2CBUivLhlQHQKOd/9O+hqQNb1xCb72mT5A
 WXRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778064559; x=1778669359; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kX4JTa/WzmJFD4bBfqq8b7xF6GkUeJRZjgAbIx2V7No=;
 b=DLgysV+UH5BjMUGp7in1cJ3ywwg/C22a1ZJW5Sjv1Fe2Wd+LwI9+kRwqIUcJzOSxRb
 cMBU+yKnu0zl6hfxb56I9RJJL2AUj736jBKkhLcAIh1I395Z68Yk9dIW6DMPNQRBYAiX
 rVTqr4HRTzqdBwA+FNH48jtmNm/5umap/EdR4kK699L/8UPfUbai5QgshjxcF+h5X6SX
 5fOsMrm8XbmJVQU5G0XIuUYCgrkq2YRniOtYCZW5BanbeZscgGrZ2No/mNqSCmUzzEiq
 FzVU3o1i/LflsvVPNHKcWSj7Sdhk6/EnfCuGRf9mCysmswNuHALvi2yCFhmmdXeuyAaW
 2VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778064559; x=1778669359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kX4JTa/WzmJFD4bBfqq8b7xF6GkUeJRZjgAbIx2V7No=;
 b=I7gtE/kYJHyiMxFzblMevNHb26aTdoB3gq8tdU/VNXNVyjfOrIrODmNwL2iPOifcMY
 /HM4Uqwws9/30QJgoLS4GPCNaPhbGJ3L4hnwtKULqeEbpeFN+bdxV/uyQ1iRjMMOb4au
 saAbnxpG4M/LHlrg4usDBLg5QXTai6c2AlX1DyTKDAcbmBdB3is71JwTmk4jTRQDRp64
 n6IXvhHjQtm2a4wcJH6Gs5Vvohf+6zgvLm5poQiMZV2D4B2nTiexHUvTsVtMN3eLCzAc
 AYVl1jwi6/Z8GhFf0wrVHtTJeHJ37YvQwSbGEE2nD5rz1COJvGvtY1JhfoXCGMixOHP3
 YoYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ82+78vgiaQJogwQhGwFDR+i8g3Yd7C12/pvH+TrpoWtCUVCAvnfDo8QkChnuwAQHoen2jP950=@lists.denx.de
X-Gm-Message-State: AOJu0Ywbszupmsm7WKyHuG9A+A/ny6rUrETIHMQ2YMBxvVV6pR3o5OgS
 gX6WJpBxZrtd4wn2jOhxgw//ZYitHz1QwDmMbusxP8gRbHnjznaRyZKaymBDDWbVsWDttX3Umcw
 iPHTRSEpLT6hMF9cp6lXmsgXv9pJQbeQ=
X-Gm-Gg: AeBDietdje2CBovvHLBhzAIXYLbsjAlJ5Pe7E+DsmrpHNlUbIPUEMdWqvFUwz1VoXw1
 tCoWCsnKtxevgRBqy4m0sKUEdVPD14tZ70V+NmF+3hjC3xY/xhl3TOaIxiWLRPAa4y2cc6nUXo7
 GgM5BYcD9aNST2t/BXKVZ1gcRUee2irNlNww5+EGWR1MRMP3yIIxkM3JpfcdcvMtSTHgcONxbjE
 y9dX1AjZtMCdylNTS651GVRXrvNjWhuJ96eHg9nPPm9yuQVx7mDMc7CRd50QMCE1xUzSZNeYgAj
 Yyn8zOGGai04rC9z2nihyupMahUCY+hv7paSomyO2CZNmdj2jQOru5HYP8c5UWF3BM+VafdSRcX
 +K33sjlnZbhJsGtWZJZpYUASeyG2zD/Xor2X1dh6HqI/zseaofkYVLFpJEc6F92YPwV1RsUDsQK
 ozuixQWI3DWUA=
X-Received: by 2002:a05:6402:a60f:b0:67b:4aab:247e with SMTP id
 4fb4d7f45d1cf-67d642c0997mr905301a12.16.1778064559294; Wed, 06 May 2026
 03:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260428162319.99B4268B05@verein.lst.de>
 <20260428163929.3501268D0D@verein.lst.de>
In-Reply-To: <20260428163929.3501268D0D@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 6 May 2026 11:49:07 +0100
X-Gm-Features: AVHnY4Jntsh0kxo_lfBrCTAyn-kjlNw5NOAZboafgn4AGJDk2ITjiIdUx6CKYbU
Message-ID: <CALeDE9OtPmdEHY--QuOPY=xzUzMypqrXvGr9VRQDfByxG2kELw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] pci: brcmstb: Add RPi5 reset facilities
To: Torsten Duwe <duwe@lst.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, 
 Andrea della Porta <andrea.porta@suse.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Stanimir Varbanov <stanimir.varbanov@suse.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,
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

> A driver for Broadcom reset controllers ported from
> linux/drivers/reset/reset-brcmstb.c to U-Boot.

The subject for this is wrong, it's a new reset driver, not part of
the pcie subsystem.

> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
>
> ---
>  configs/rpi_arm64_defconfig   |  1 +
>  drivers/reset/Kconfig         |  7 +++
>  drivers/reset/Makefile        |  1 +
>  drivers/reset/reset-brcmstb.c | 97 +++++++++++++++++++++++++++++++++++
>  4 files changed, 106 insertions(+)
>  create mode 100644 drivers/reset/reset-brcmstb.c
>
> diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
> index 69e8e72c5d7..153d7ed301e 100644
> --- a/configs/rpi_arm64_defconfig
> +++ b/configs/rpi_arm64_defconfig
> @@ -44,6 +44,7 @@ CONFIG_BCMGENET=y
>  CONFIG_PCI_BRCMSTB=y
>  CONFIG_PINCTRL=y
>  # CONFIG_PINCTRL_GENERIC is not set
> +CONFIG_RESET_BRCMSTB=y
>  CONFIG_DM_RNG=y
>  CONFIG_RNG_IPROC200=y
>  # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 66911199c8b..e0561df8058 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -64,6 +64,13 @@ config RESET_BCM6345
>         help
>           Support reset controller on BCM6345.
>
> +config RESET_BRCMSTB
> +       bool "Generic Reset controller driver for Broadcom"

Should probably have
depends on ARCH_BCM283X

> +       help
> +         This enables reset controller for Broadcom devices.
> +         If you wish to use reset resources managed by the Broadcom
> +         Reset Controller, say Y here. Otherwise, say N.
> +
>  config RESET_UNIPHIER
>         bool "Reset controller driver for UniPhier SoCs"
>         depends on ARCH_UNIPHIER
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 088545c6473..ad5fe6b6184 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_RESET_AIROHA) += reset-airoha.o
>  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
> +obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
>  obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
> diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
> new file mode 100644
> index 00000000000..7861f7c9baf
> --- /dev/null
> +++ b/drivers/reset/reset-brcmstb.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Broadcom STB generic reset controller
> + *
> + * Copyright (C) 2024 EPAM Systems
> + *
> + * Moved from linux kernel:
> + * Author: Florian Fainelli <f.fainelli@gmail.com>
> + * Copyright (C) 2018 Broadcom
> + */
> +
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <reset-uclass.h>
> +
> +struct brcmstb_reset {
> +       void __iomem *base;
> +};
> +
> +#define SW_INIT_SET 0x00
> +#define SW_INIT_CLEAR 0x04
> +#define SW_INIT_STATUS 0x08
> +
> +#define SW_INIT_BIT(id) BIT((id) & 0x1f)
> +#define SW_INIT_BANK(id) ((id) >> 5)
> +
> +#define usleep_range(a, b) udelay((b))
> +
> +/* A full bank contains extra registers that we are not utilizing but still
> + * qualify as a single bank.
> + */
> +#define SW_INIT_BANK_SIZE 0x18
> +
> +static int brcmstb_reset_assert(struct reset_ctl *rst)
> +{
> +       unsigned int off = SW_INIT_BANK(rst->id) * SW_INIT_BANK_SIZE;
> +       struct brcmstb_reset *priv = dev_get_priv(rst->dev);
> +
> +       writel_relaxed(SW_INIT_BIT(rst->id), priv->base + off + SW_INIT_SET);
> +       return 0;
> +}
> +
> +static int brcmstb_reset_deassert(struct reset_ctl *rst)
> +{
> +       unsigned int off = SW_INIT_BANK(rst->id) * SW_INIT_BANK_SIZE;
> +       struct brcmstb_reset *priv = dev_get_priv(rst->dev);
> +
> +       writel_relaxed(SW_INIT_BIT(rst->id), priv->base + off + SW_INIT_CLEAR);
> +       /* Maximum reset delay after de-asserting a line and seeing block
> +        * operation is typically 14us for the worst case, build some slack
> +        * here.
> +        */
> +       usleep_range(100, 200);
> +       return 0;
> +}
> +
> +static int brcmstb_reset_status(struct reset_ctl *rst)
> +{
> +       unsigned int off = SW_INIT_BANK(rst->id) * SW_INIT_BANK_SIZE;
> +       struct brcmstb_reset *priv = dev_get_priv(rst->dev);
> +
> +       return readl_relaxed(priv->base + off + SW_INIT_STATUS) &
> +                       SW_INIT_BIT(rst->id);
> +}
> +
> +struct reset_ops brcmstb_reset_reset_ops = {
> +       .rst_assert = brcmstb_reset_assert,
> +       .rst_deassert = brcmstb_reset_deassert,
> +       .rst_status = brcmstb_reset_status};
> +
> +static int brcmstb_reset_probe(struct udevice *dev)
> +{
> +       struct brcmstb_reset *priv = dev_get_priv(dev);
> +
> +       priv->base = dev_remap_addr(dev);
> +       if (!priv->base)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id brcmstb_reset_ids[] = {
> +       {.compatible = "brcm,brcmstb-reset"}, {/* sentinel */}};
> +
> +U_BOOT_DRIVER(brcmstb_reset) = {
> +       .name = "brcmstb-reset",
> +       .id = UCLASS_RESET,
> +       .of_match = brcmstb_reset_ids,
> +       .ops = &brcmstb_reset_reset_ops,
> +       .probe = brcmstb_reset_probe,
> +       .priv_auto = sizeof(struct brcmstb_reset),
> +};
> --
> 2.54.0
>
