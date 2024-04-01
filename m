Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FFBCD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 04:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CCBA88047;
	Mon,  1 Apr 2024 06:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="quHaeo2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0070F87D84; Mon,  1 Apr 2024 06:47:25 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249BA882C5
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 06:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7dec16fc4b2so966394241.3
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 21:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711946840; x=1712551640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JPXqFNZ29ACAwKtinbakdbyW0KNf+EaYHEkSPAUj1kU=;
 b=quHaeo2LYV9w1W+jo/lIADO1TkaLfr9KLbq8KvtMTToRLJ1ia4IOBckvAIthDRceMt
 /O9sX4ghCEiwfnopKnGGmvMX6vAKgtl6c+Xq/GYmzMZgWEm2pgd90QU8Z3GY5nb5Bddj
 W6aD7F2yiZjiZgLKXqSOb39KVwc7g++aKGFfXENRTGg/PiBjPnf6Ex/xbWwnEjnqfSmK
 wjQ2GsGGcuBr9OEj64KvgHJW6HHfcSSto3Gs2wdmk7NY+rbThRX+aRKdJxL+IQshnS2t
 DzVRHTEkkhUKBZYw56APF1oUQWS9QcQrGNSd/8HKQafrp+7frUETssN3maixPjMH87nW
 vrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711946840; x=1712551640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JPXqFNZ29ACAwKtinbakdbyW0KNf+EaYHEkSPAUj1kU=;
 b=FuoFkdEqJGZsLoJXgOYIgxbhzR30+KWpJgCBjxv66QjjUvJjm1XajrMC29c4v5GA9D
 qJxgOr2ejf91uls0dzYTQdPKUBM2wNOAeo/foHKxXLN6Zf62+YDNXHM8dqR/bYFMJBKz
 goK6HuUlWaK8fNDCZYiS5eiGaG7OZ4KpJ8f52JtCCo1jf2t0GmJAs5rZyGUpBMKOpYrh
 dPqHTm9RCngjfMMknGTm73LYB0NOyZRoyqpWY+hwCo7HJub5Tk46hJngEsMKNw4QAyMB
 PpQk6lf7oIG6YKC56UvPUJWH/H3AzlA2GSf5zC8jBmzd1IDOCJhsLZicW8QaoE19ks6T
 dS0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2nYRaF0UUUnR6n7/nuSVQF5rrzLtvF9p1VgAzHtLyGqbB6uCtgofb80VuG/7HqHYN/ew7VNnTkrgpgZ6cmkDUiBxHlw==
X-Gm-Message-State: AOJu0Ywwszot2E+zxPT9wCyilja35sNZhOUcvwHKAHzTlshIE4uT0ULG
 jHFtn/kJuChvqq1tPpF/ApSBb69E3qRMD3Kf2+A6xB3vpLHp618Yq35xs7XCc5X5m7Z30MKl/KP
 Fh9nZsmJ0ltZ61Zf1WAxwcOfFTgBROrBxOEbTNw==
X-Google-Smtp-Source: AGHT+IHIad7JN4hCml+yE5tY4SjUCoLCiSBWyEcuM4d9eeDr1wtCf6J2YHYP1HAWXWHTuFmIk3aUiSx+W81ZFy7tcok=
X-Received: by 2002:a67:ef46:0:b0:478:6f9e:bc24 with SMTP id
 k6-20020a67ef46000000b004786f9ebc24mr2343405vsr.31.1711946839972; Sun, 31 Mar
 2024 21:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-10-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-10-4e98228b3d03@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 10:17:09 +0530
Message-ID: <CAFA6WYMFE_xoj80AA4OQFKQf7cb7sLzWH4+8YqargihG-OfOJg@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] mach-snapdragon: fixup USB nodes
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
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

On Thu, 28 Mar 2024 at 23:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> We don't support USB super-speed in U-Boot yet, we lack the SS PHY
> drivers, however from my testing even with a PHY driver there seem to be
> other issues when talking to super-speed peripherals.
>
> In pursuit of maintaining upstream DT compatibility, and simplifying
> porting for new devices, let's implement the DT fixups necessary to
> configure USB in high-speed only mode at runtime. The pattern is
> identical for all Qualcomm boards that use the Synaptics DWC3
> controller:
>
> * Add an additional property on the Qualcomm wrapper node
> * Remove the super-speed phy phandle and phy-name entries.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Makefile    |   1 +
>  arch/arm/mach-snapdragon/board.c     |   3 +
>  arch/arm/mach-snapdragon/of_fixup.c  | 123 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h |  20 ++++++
>  4 files changed, 147 insertions(+)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 857171e593da..7a4495c8108f 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -2,4 +2,5 @@
>  #
>  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>
>  obj-y += board.o
> +obj-$(CONFIG_OF_LIVE) += of_fixup.o
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 6f762fc948bf..65e4c61e866a 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -27,8 +27,10 @@
>  #include <fdt_support.h>
>  #include <usb.h>
>  #include <sort.h>
>
> +#include "qcom-priv.h"
> +
>  DECLARE_GLOBAL_DATA_PTR;
>
>  static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>
> @@ -159,8 +161,9 @@ void __weak qcom_board_init(void)
>
>  int board_init(void)
>  {
>         show_psci_version();
> +       qcom_of_fixup_nodes();
>         qcom_board_init();
>         return 0;
>  }
>
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> new file mode 100644
> index 000000000000..4fdfed2dff16
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * OF_LIVE devicetree fixup.
> + *
> + * This file implements runtime fixups for Qualcomm DT to improve
> + * compatibility with U-Boot. This includes adjusting the USB nodes
> + * to only use USB high-speed, as well as remapping volume buttons
> + * to behave as up/down for navigating U-Boot.
> + *
> + * We use OF_LIVE for this rather than early FDT fixup for a couple
> + * of reasons: it has a much nicer API, is most likely more efficient,
> + * and our changes are only applied to U-Boot. This allows us to use a
> + * DT designed for Linux, run U-Boot with a modified version, and then
> + * boot Linux with the original FDT.
> + *
> + * Copyright (c) 2024 Linaro Ltd.
> + *   Author: Caleb Connolly <caleb.connolly@linaro.org>
> + */
> +
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dm/of_access.h>
> +#include <dm/of.h>
> +#include <fdt_support.h>
> +#include <linux/errno.h>
> +#include <time.h>
> +
> +/* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
> + * USB controllers. Rather than requiring source level DT changes, we fix up
> + * DT here. This improves compatibility with upstream DT and simplifies the
> + * porting process for new devices.
> + */
> +static int fixup_qcom_dwc3(struct device_node *glue_np)
> +{
> +       struct device_node *dwc3;
> +       int ret, len, hsphy_idx = 1;
> +       const __be32 *phandles;
> +       const char *second_phy_name;
> +
> +       debug("Fixing up %s\n", glue_np->name);
> +
> +       /* Tell the glue driver to configure the wrapper for high-speed only operation */
> +       ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
> +       if (ret) {
> +               log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* Find the DWC3 node itself */
> +       dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
> +       if (!dwc3) {
> +               log_err("Failed to find dwc3 node\n");
> +               return -ENOENT;
> +       }
> +
> +       phandles = of_get_property(dwc3, "phys", &len);
> +       len /= sizeof(*phandles);
> +       if (len == 1) {
> +               log_debug("Only one phy, not a superspeed controller\n");
> +               return 0;
> +       }
> +
> +       /* Figure out if the superspeed phy is present and if so then which phy is it? */
> +       ret = of_property_read_string_index(dwc3, "phy-names", 1, &second_phy_name);
> +       if (ret == -ENODATA) {
> +               log_debug("Only one phy, not a super-speed controller\n");
> +               return 0;
> +       } else if (ret) {
> +               log_err("Failed to read second phy name: %d\n", ret);
> +               return ret;
> +       }
> +
> +       if (!strncmp("usb3-phy", second_phy_name, strlen("usb3-phy"))) {
> +               log_debug("Second phy isn't superspeed (is '%s') assuming first phy is SS\n",
> +                         second_phy_name);
> +               hsphy_idx = 0;
> +       }
> +
> +       /* Overwrite the "phys" property to only contain the high-speed phy */
> +       ret = of_write_prop(dwc3, "phys", sizeof(*phandles), phandles + hsphy_idx);
> +       if (ret) {
> +               log_err("Failed to overwrite 'phys' property: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* Overwrite "phy-names" to only contain a single entry */
> +       ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy"), "usb2-phy");
> +       if (ret) {
> +               log_err("Failed to overwrite 'phy-names' property: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed"), "high-speed");
> +       if (ret) {
> +               log_err("Failed to set 'maximum-speed' property: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void fixup_usb_nodes(void)
> +{
> +       struct device_node *glue_np = NULL;
> +       int ret;
> +
> +       while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
> +               ret = fixup_qcom_dwc3(glue_np);
> +               if (ret)
> +                       log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
> +       }
> +}
> +
> +#define time_call(func, ...) \
> +       do { \
> +               u64 start = timer_get_us(); \
> +               func(__VA_ARGS__); \
> +               debug(#func " took %lluus\n", timer_get_us() - start); \
> +       } while (0)
> +
> +void qcom_of_fixup_nodes(void)
> +{
> +       time_call(fixup_usb_nodes);
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> new file mode 100644
> index 000000000000..0a7ed5eff8b8
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef __QCOM_PRIV_H__
> +#define __QCOM_PRIV_H__
> +
> +#if CONFIG_IS_ENABLED(OF_LIVE)
> +/**
> + * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
> + *
> + * Adjusts nodes in the live tree to improve compatibility with U-Boot.
> + */
> +void qcom_of_fixup_nodes(void);
> +#else
> +static inline void qcom_of_fixup_nodes(void)
> +{
> +       log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
> +}
> +#endif /* OF_LIVE */
> +
> +#endif /* __QCOM_PRIV_H__ */
>
> --
> 2.44.0
>
