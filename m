Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11484CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 10:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96167848A1;
	Wed,  6 May 2026 12:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvBawPhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B6A0848AE; Wed,  6 May 2026 12:53:29 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C598488B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 12:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67bc8609a9bso4181399a12.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 03:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778064807; cv=none;
 d=google.com; s=arc-20240605;
 b=ILxHWUqMzpDt6Wq9sMGA1Djish4ps/RrmuNHDxSovspwPlV1ixiwGAlLuVTXjc5Fh5
 MzDu+qU8Ii1SLEQaL38Hj0WDolZnju99ulPBzUHtMKDy2gyqOEcvVhjXsgks/fpX60jV
 UPVdCjtT/8jXd3UpanDSrHjh2EDcdO9EohVVMBANRik5rpUC3wxYZ2BWNpmC9tYhMIts
 3ZgjgZy+bLv371Nc8G8naZAnjLC3RES3UO0Vtjz2lfgiykGJ7/QyGz2u/nBXhNHOh7O4
 /WmwOCEapO+aHKQseFAitTFJqQsPie61lCksmQRivF7D3ErF4ljC5ECWb7pnlhOs714p
 +/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7Qn2YpoPFgXSQBR+RTehkqViNZpwjN41bSwjPkcbo9U=;
 fh=D7iEwFdYJqYJrNgrSKWmk+VeLW31/ippd26/9OpP6PM=;
 b=VbIdY4aYgdhLD26u32yKodUc3Nwil9D3zKqZl6kufxouuOLpxgQm8LaNCkFFNktV0H
 Dkdxy2JPWxyVvJRsu93vzW3XzGtd2/bpfKiKt4HuZ/TqO0AdrP8pvznysKRvh0V/S6hi
 SK0G82Rw434hmMDUn6kNXFJuOAqWzUWa2jB0HPEthIlGHxLkRlFuqhLwEgN2jNopZJxI
 w2upV/r8eSOOV6z4XTTS5vhrEx1nYYv/zoBAz+tFZww1V5pQG18Vi4w4oPr9K4zqolhB
 5A/cmMQh34TIKUxithsSoyGX6QBhpS9erXQfVNI6hYjhDq39tOPlTstgvOG/ndTdHH9C
 2/TQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778064807; x=1778669607; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Qn2YpoPFgXSQBR+RTehkqViNZpwjN41bSwjPkcbo9U=;
 b=IvBawPhj6fWFUpSXH5V5Ip0trp394yebojer6fLmfCUoIElqJrw78yzoTSBiFDSLcY
 VXlLS6xiCVO5Q5VpO5xOvB+JPfPJcxR95HotmGvUOgc4qJ+vjCU6NSe5vKVtFVWGN7An
 EI++E0FPOGD0TLCqMr5ez20fr1jAXlkoKTmuLzUBUiK6RpZwsHVDDoyjXWgmjBHnOEIr
 +vVDlq+ig7zMa5fwwRAhg4mQAMmeF8mExpG4V7FNSv/qdkn7cuR6J3KsTIEBtiSePQgn
 j+gAyjSrY/hEKVvDraiQ3ICdbTp//65VuaVkfLbBXpBzb4WTnxUScDn37Xm/gMg8WYhn
 p8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778064807; x=1778669607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Qn2YpoPFgXSQBR+RTehkqViNZpwjN41bSwjPkcbo9U=;
 b=DbTs4S0zpTEhkA2zM04hlwwW5qN79NjGECUwcTL+Sp5fp4hvYMmAi0gOVpKD+sPijc
 np15xi87M+Ku8kjuL6YiX2Laik56qtfX1zNw2uaIJzA+V6qbZbZmVULUa7jX+vJ46TT1
 ltBKz8RJLSvynvlOAsSk1lVNk+Wr608qUr7UdmUO7W1HG6EEiF4RGTlGKBK+FoupAX5H
 nh69R0ARGVpeALVVQj0TskYDANdMWuUANPBvQaiGj97UT2MhFFFTxhfDsscKUsveyhUz
 jPNNaSZHpxhG9b+Rf2J7CrDFEFxyvsPG8chMXS6OXD+oD4Wgys4ycYGnSofp+75CeSmL
 D92g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dVT9auiWQYH+CmV0vQXR16XeBhIjLa6E//UTxFx7lfkqi4/wUgyuNW0u0PQfR13fP6MsXOuU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2lZ31hOBWAizhZeLz3GYeRraluq6oHSZcsxVjU7ZL7iGTkQFF
 BiW+Ap7YL0WU6aUIHo+y5rZQFityyfAP7ZI2NZKQARtz6FTbLNlUUrU+AwY3oarvIE0fPB0nOoa
 U4mvbP+wRJ8yaDrBEWt1OohrO5tc7ozg=
X-Gm-Gg: AeBDievOVYhKydLt27cfTzQKd2bVHL9obae5TcLNpHmfLcUKfzGRb2wXCLFb39S8BMU
 btFTXKbffUo2gFPvysbQVlZ76oJq3q6gDwVilY0bW4jmC468D7WL0JaozEGzGuIsM9thzC3McCu
 HXkiN/yAnd/RX9GB5ph1z3zeyhdbFwRCT/pkS73MsFjeHoBGnT4OHnOIck31LMCji7K7RieKt8t
 KYFbne9rDOTxDCEeC2BIRyIXe/YmhB7nIrfKiiBRaFytAM2BcPqB+n8C/5c2oxAAVkGtUiJMvOx
 wAJd46MHbzjRowPvaxUXKzoi22NlGUFN4RxJPifZswmd9LheYKne/W+XQjhRKdBhkv0imWlIlp9
 7wz0N6mF5tmSfYpj3r+YRCusz/ohdGWMWFdPk47gNPX22FznRzPwAx6en40r9jMeMh5Av5CJg/w
 p5xywCIDJL/24=
X-Received: by 2002:a05:6402:1cc7:b0:67c:64c0:b43c with SMTP id
 4fb4d7f45d1cf-67d642be9cemr1080733a12.16.1778064806567; Wed, 06 May 2026
 03:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260428162319.99B4268B05@verein.lst.de>
 <20260428163932.5540868D0F@verein.lst.de>
In-Reply-To: <20260428163932.5540868D0F@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 6 May 2026 11:53:15 +0100
X-Gm-Features: AVHnY4JYSmYEdznfkXQPLRoeeSYyw7_C9SL8wZJaa8F7Nl96YdaH2xuNcvxvnjg
Message-ID: <CALeDE9PHVnWug=PfASSXeoccF=hzZ5x=OFYeK9x62mooJnMMpw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] pci: brcmstb: Add RPi5 rescal reset facilities
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

On Tue, 28 Apr 2026 at 17:39, Torsten Duwe <duwe@lst.de> wrote:
>
> From: Torsten Duwe <duwe@suse.de>
>
> A driver for Broadcom rescal reset controllers ported from
> linux/drivers/reset/reset-brcmstb-rescal.c to U-Boot.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Tested-by: Pedro Falcato <pfalcato@suse.de>

Wrong subject.

> ---
>  configs/rpi_arm64_defconfig          |   1 +
>  drivers/reset/Kconfig                |   7 ++
>  drivers/reset/Makefile               |   1 +
>  drivers/reset/reset-brcmstb-rescal.c | 103 +++++++++++++++++++++++++++
>  4 files changed, 112 insertions(+)
>  create mode 100644 drivers/reset/reset-brcmstb-rescal.c
>
> diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
> index 153d7ed301e..38af5029403 100644
> --- a/configs/rpi_arm64_defconfig
> +++ b/configs/rpi_arm64_defconfig
> @@ -45,6 +45,7 @@ CONFIG_PCI_BRCMSTB=y
>  CONFIG_PINCTRL=y
>  # CONFIG_PINCTRL_GENERIC is not set
>  CONFIG_RESET_BRCMSTB=y
> +CONFIG_RESET_BRCMSTB_RESCAL=y
>  CONFIG_DM_RNG=y
>  CONFIG_RNG_IPROC200=y
>  # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index e0561df8058..b4237bf98bf 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -71,6 +71,13 @@ config RESET_BRCMSTB
>           If you wish to use reset resources managed by the Broadcom
>           Reset Controller, say Y here. Otherwise, say N.
>
> +config RESET_BRCMSTB_RESCAL
> +       bool "Generic Rescal Reset controller driver for Broadcom"

Same comment on the deps as per the other reset driver.

> +       help
> +         Support rescal reset controller on Broadcom.
> +         If you wish to use reset resources managed by the Broadcom
> +         Reset Controller, say Y here. Otherwise, say N.
> +
>  config RESET_UNIPHIER
>         bool "Reset controller driver for UniPhier SoCs"
>         depends on ARCH_UNIPHIER
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index ad5fe6b6184..c369bdb3d6c 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
>  obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
> +obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
>  obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
> diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brcmstb-rescal.c
> new file mode 100644
> index 00000000000..fc8fcfa8b3f
> --- /dev/null
> +++ b/drivers/reset/reset-brcmstb-rescal.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Broadcom STB generic reset controller
> + *
> + * Copyright (C) 2024 EPAM Systems
> + * Moved from linux kernel:
> + * Copyright (C) 2018-2020 Broadcom
> + */
> +
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <errno.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <reset-uclass.h>
> +
> +#define BRCM_RESCAL_START 0x0
> +#define BRCM_RESCAL_START_BIT BIT(0)
> +#define BRCM_RESCAL_CTRL 0x4
> +#define BRCM_RESCAL_STATUS 0x8
> +#define BRCM_RESCAL_STATUS_BIT BIT(0)
> +
> +struct brcm_rescal_reset {
> +       void __iomem *base;
> +};
> +
> +/* Also doubles a deassert */
> +static int brcm_rescal_reset_set(struct reset_ctl *rst)
> +{
> +       struct brcm_rescal_reset *data = dev_get_priv(rst->dev);
> +       void __iomem *base = data->base;
> +       u32 reg;
> +       int ret;
> +
> +       reg = readl(base + BRCM_RESCAL_START);
> +       writel(reg | BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
> +       reg = readl(base + BRCM_RESCAL_START);
> +       if (!(reg & BRCM_RESCAL_START_BIT)) {
> +               dev_err(rst->dev, "failed to start SATA/PCIe rescal\n");
> +               return -EIO;
> +       }
> +
> +       ret = readl_poll_timeout(base + BRCM_RESCAL_STATUS, reg,
> +                                (reg & BRCM_RESCAL_STATUS_BIT), 100);
> +       if (ret) {
> +               dev_err(rst->dev, "time out on SATA/PCIe rescal\n");
> +               return ret;
> +       }
> +
> +       reg = readl(base + BRCM_RESCAL_START);
> +       writel(reg & ~BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
> +
> +       dev_dbg(rst->dev, "SATA/PCIe rescal success\n");
> +       return 0;
> +}
> +
> +/* A dummy function - deassert/reset does all the work */
> +static int brcm_rescal_reset_assert(struct reset_ctl *rst)
> +{
> +       return 0;
> +}
> +
> +static int brcm_rescal_reset_xlate(struct reset_ctl *reset_ctl,
> +                                  struct ofnode_phandle_args *args)
> +{
> +       /* This is needed if #reset-cells == 0. */
> +       return 0;
> +}
> +
> +static const struct reset_ops brcm_rescal_reset_ops = {
> +       .rst_deassert = brcm_rescal_reset_set,
> +       .rst_assert = brcm_rescal_reset_assert,
> +       .of_xlate = brcm_rescal_reset_xlate,
> +};
> +
> +static int brcm_rescal_reset_probe(struct udevice *dev)
> +{
> +       struct brcm_rescal_reset *data = dev_get_priv(dev);
> +
> +       data->base = dev_remap_addr(dev);
> +       if (!data->base)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id brcm_rescal_reset_of_match[] = {
> +       {.compatible = "brcm,bcm7216-pcie-sata-rescal"},
> +       {},
> +};
> +
> +U_BOOT_DRIVER(brcmstb_reset_rescal) = {
> +       .name = "brcmstb-reset-rescal",
> +       .id = UCLASS_RESET,
> +       .of_match = brcm_rescal_reset_of_match,
> +       .ops = &brcm_rescal_reset_ops,
> +       .probe = brcm_rescal_reset_probe,
> +       .priv_auto = sizeof(struct brcm_rescal_reset),
> +};
> --
> 2.54.0
>
