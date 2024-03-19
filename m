Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E13DC54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 13:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECCD287EBA;
	Tue, 19 Mar 2024 14:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uwyhISyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB78C869F7; Tue, 19 Mar 2024 14:49:40 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43AB987F13
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 14:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4739b6ddc94so747876137.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710856176; x=1711460976; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ToszpYMqUdd0il8ylnJyrOhHCQZpWfl0yNYr6q5Zz+U=;
 b=uwyhISyW0ScjpKnIGLKiIhIhb5Trxwlp3c40sWYtUe3Hg5P4dBn/7p9kOBzVCWuoL1
 bmwuOABplbTmuUC69JdoGmDlZQ2U/ofqrEXA/3G/vJPY2M9wED08iZ86fcFONqyN/jOP
 wsU2rvfurd/aKO0/bkXsCr1z1kIoDUPSf4dVRbsijHK9O0EMv+hop4Gk0CJgrCQcpa0U
 i9umhfeOdOk41ZYGSChh2PVhRGBuax0YQM/0tI5ixuiY8b3I3A9+oxMyaT3f6oLtnSNx
 7RvZqhVf9KZdMgPSh5xVPE7a1JirBMOn4XE9yzOPFIENUx+kzUWjGl0mYJIX6tIMcyFt
 WV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856176; x=1711460976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ToszpYMqUdd0il8ylnJyrOhHCQZpWfl0yNYr6q5Zz+U=;
 b=PEPxmQD4iZtGlEYVsjzBV+dzOpshkB+kdildumWYQoqew6n44nAZmU4MoHiz/uu7oK
 8lZ9lZ7DHX1HrFzg11XklYZ91yg4MYpH8zKFaUC8l63qpLEXmcb7AbxzaNcw/NT9Zka4
 ZzxUYRQIwlTBVl45YKDFn9X9zJ73Tn3WnZ/yZ7DS5Hecj8tPWei6+ZmHp9PsqhVhGy5y
 t1OOWTkQPwhJ+Ycxcg34bmNXkz7nY95FtTZ5UXp8x1nylLoNr4ygY+lzznHPIsHgVQza
 +dVEvgqdsBmnnGVE1irrt1sjdrOSMaqrAHVsFFx2ctbzXmpEokPRFv71+WCHXpCH3l5Z
 ALrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYLIwgm4Ks4XiM/5dYwI2p58kI3VrP7IJKX2RGsXnu4gBE6+Ui/2WEt3j9DpeTa90h5jWCShxREuHFmDnMmb2owsxQJQ==
X-Gm-Message-State: AOJu0YxTa0hgyB5fyWzUtuVRUsRmDJ2qdWEvi7lmhmZcSVyqoJhCogvU
 S3qIO/WEVxRmQlavyJIptNqT5SMlyiUWkrv63F8r4uNYfZC9cMLfQCo8OTNehGGf5/rQywvCSZM
 GqpgVQkFLw9RFljAh0mZZH4tk6/Hs0NnqEPcYYw==
X-Google-Smtp-Source: AGHT+IHKpL25Q7EPq/BNR4IiT7HoSUPzHAbP8evRrsf5EB5p5Sr5f+neXS+c+V6pyIYw198Pp0NrKLBcpUb+7CIg1Gw=
X-Received: by 2002:a05:6102:2255:b0:475:3706:1088 with SMTP id
 e21-20020a056102225500b0047537061088mr11538598vsb.19.1710856176060; Tue, 19
 Mar 2024 06:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-10-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-10-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Mar 2024 19:19:25 +0530
Message-ID: <CAFA6WYP5Mm2PsBJe36jeP7zVHWmj0igwoVWp=e9r+sKcx14zSw@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] mach-snapdragon: fixup USB nodes
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

Hi Caleb,

On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> We don't support USB super-speed in U-Boot yet, we lack the SS PHY
> drivers, however from my testing even with a PHY driver there seem to be
> other issues when talking to super-speed peripherals.
>
> In pursuit of maintaining upstream DT compatibility,

I can understand the reasoning behind this but since we enable these
fixups for every Qcom platform it may turn out to be counter
productive. There can be embedded use-cases where bootup times have
stringent requirements. Also, depending upon CPU speed/freq the add-on
times due to these can be significant.

I would suggest we rather solve these USB issues either via a common
Qcom *-u-boot.dtsi file which can be included for every board.

-Sumit

> and simplifying
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
>  arch/arm/mach-snapdragon/of_fixup.c  | 115 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h |  19 ++++++
>  4 files changed, 138 insertions(+)
>
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
> index 000000000000..6810c8617cc0
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -0,0 +1,115 @@
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
> +void qcom_of_fixup_nodes(void)
> +{
> +       fixup_usb_nodes();
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> new file mode 100644
> index 000000000000..d18fd1883b7f
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -0,0 +1,19 @@
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
