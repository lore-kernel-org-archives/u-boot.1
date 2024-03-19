Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4C7C54F7B
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 14:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE9F87F13;
	Tue, 19 Mar 2024 15:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XGG9BFgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9203A87F39; Tue, 19 Mar 2024 15:45:53 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 408D087E6D
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 15:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41468993f93so2537465e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710859550; x=1711464350; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FktCkD2mHzSZO4l03osSrt2zdRSyakdIKVVUcAz2/nw=;
 b=XGG9BFgDIcXapxu+CCkGKNJvIrruy9EjjIPVvJ8mCayTrvXdWAqqJIPMoNDkXGnS5p
 wEBY0HtTF2/VKw2m5Pk3NQhbH5AsYHDYjyfrxHegT2NM/m8xkq2q9HGEVHSjcibyujjZ
 J8dzu1FxnNkvjPYBmbruQY/rrzdK+SjKP4yVnz5dXkHQTqeZ4YOQt9aSeG1I2ZeBM3Lm
 xn8smzDC5YX9CtSBdbbip/PfPWiB3ZuDeqMH+EYRlsT+N4Pij24apwJvkN7RqiS7vCTx
 aXAEXQP6vxB1u5ggNWDL7c+PnyXbIWrtWHDOWoTJFiZakJtrFelbxpCPWTWxKCESk8Qy
 4JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710859550; x=1711464350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FktCkD2mHzSZO4l03osSrt2zdRSyakdIKVVUcAz2/nw=;
 b=kwcx/KlxGFkA3ui4ctUzrMn9G+3DVvOyfujRCeNPbOa/E9tnPyXzxCYiBb22hncVWI
 kucSXL9FDrcdMBz0P//U4NvP7n5CEuB+5VkhYRjCumUjmnVkoJdFQmIkcjc2zAHV5Ymc
 QQqRc+iVwY9IJalAa5MyDBbLaZkq9bets1LfK/zwGMsZ4CpClJPs41Gzql9PVQn/0Mdq
 RSWRhOlbXa6QYb5FWk1N9ok0gQZwnk5WfSvBYWa7wnZF402EsTcOYyISwrRr61Zu+3qr
 b7R4q82/Obju+8odpHqF2ReGhwSnrsGnj04bOxiPkmET44H5oDb4gBhHbcArv1Ax+qNi
 u74w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjq4zyZAKp7uMAQJ1WoxbXTRSaC7otkEep7GHRF23FbtO1Yd/CmbJV26Soya9epROgvloIIZn3PytEb7dF/qCi0EUyBA==
X-Gm-Message-State: AOJu0Yy7/B3SVQVbB0c+t1WMD7ga7QSVdmANBjBNeAsyvcoroORR56mJ
 yVh6WiYK7VI7xDc26BY77x8iReIRktDn0TA8WPYoajpM/B3wimkktAZrnf1uYWOvlC/xR68MWKk
 2
X-Google-Smtp-Source: AGHT+IHR/spK2wZCwozQzwkP20sVO5bd7EVNIuB+o/USEVosL8eCiGBXjsXOY4i9PA2sPcqycVEB6Q==
X-Received: by 2002:a05:600c:49a1:b0:414:8e7:cd60 with SMTP id
 h33-20020a05600c49a100b0041408e7cd60mr1982939wmp.8.1710859549642; 
 Tue, 19 Mar 2024 07:45:49 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a05600c3b9600b0041408451874sm11273277wms.17.2024.03.19.07.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 07:45:49 -0700 (PDT)
Message-ID: <33f81c08-aa1d-4519-ad8d-0876480934c2@linaro.org>
Date: Tue, 19 Mar 2024 14:45:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] mach-snapdragon: fixup USB nodes
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-10-e1b38d9b4fa4@linaro.org>
 <CAFA6WYP5Mm2PsBJe36jeP7zVHWmj0igwoVWp=e9r+sKcx14zSw@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYP5Mm2PsBJe36jeP7zVHWmj0igwoVWp=e9r+sKcx14zSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Sumit,

On 19/03/2024 13:49, Sumit Garg wrote:
> Hi Caleb,
> 
> On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> We don't support USB super-speed in U-Boot yet, we lack the SS PHY
>> drivers, however from my testing even with a PHY driver there seem to be
>> other issues when talking to super-speed peripherals.
>>
>> In pursuit of maintaining upstream DT compatibility,
> 
> I can understand the reasoning behind this but since we enable these
> fixups for every Qcom platform it may turn out to be counter
> productive. There can be embedded use-cases where bootup times have
> stringent requirements. Also, depending upon CPU speed/freq the add-on
> times due to these can be significant.

I have measured this on a few different boards:

On DB410c, the slowest board we currently support
* of_live_build took 7228us
* Fixing up USB nodes took 131us
* Fixing up power domains took 88us

On RB1 (the slowest new platform with a QCM2290 SoC)
* of_live_build took 2078us
* Fixing up USB nodes took 39us
* Fixing up power domains took 27us

The time taken initially to build the livetree is likely made back as it
is much much faster to query than the flat tree (as you can see, walking
every single node takes <100us on db410c). I took some rough
measurements of the boot-to-console time on sdm845 (see the "enable
livetree" patch) and basically concluded that the delta between live and
flat trees is within the margin of error.

If a specific board for whatever reason wants to avoid using OF_LIVE
then I'm fine with that, db410c isn't using it for example.
> 
> I would suggest we rather solve these USB issues either via a common
> Qcom *-u-boot.dtsi file which can be included for every board.
> 
> -Sumit
> 
>> and simplifying
>> porting for new devices, let's implement the DT fixups necessary to
>> configure USB in high-speed only mode at runtime. The pattern is
>> identical for all Qualcomm boards that use the Synaptics DWC3
>> controller:
>>
>> * Add an additional property on the Qualcomm wrapper node
>> * Remove the super-speed phy phandle and phy-name entries.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  arch/arm/mach-snapdragon/Makefile    |   1 +
>>  arch/arm/mach-snapdragon/board.c     |   3 +
>>  arch/arm/mach-snapdragon/of_fixup.c  | 115 +++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-snapdragon/qcom-priv.h |  19 ++++++
>>  4 files changed, 138 insertions(+)
>>
>> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
>> index 857171e593da..7a4495c8108f 100644
>> --- a/arch/arm/mach-snapdragon/Makefile
>> +++ b/arch/arm/mach-snapdragon/Makefile
>> @@ -2,4 +2,5 @@
>>  #
>>  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>>
>>  obj-y += board.o
>> +obj-$(CONFIG_OF_LIVE) += of_fixup.o
>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>> index 6f762fc948bf..65e4c61e866a 100644
>> --- a/arch/arm/mach-snapdragon/board.c
>> +++ b/arch/arm/mach-snapdragon/board.c
>> @@ -27,8 +27,10 @@
>>  #include <fdt_support.h>
>>  #include <usb.h>
>>  #include <sort.h>
>>
>> +#include "qcom-priv.h"
>> +
>>  DECLARE_GLOBAL_DATA_PTR;
>>
>>  static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>>
>> @@ -159,8 +161,9 @@ void __weak qcom_board_init(void)
>>
>>  int board_init(void)
>>  {
>>         show_psci_version();
>> +       qcom_of_fixup_nodes();
>>         qcom_board_init();
>>         return 0;
>>  }
>>
>> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
>> new file mode 100644
>> index 000000000000..6810c8617cc0
>> --- /dev/null
>> +++ b/arch/arm/mach-snapdragon/of_fixup.c
>> @@ -0,0 +1,115 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * OF_LIVE devicetree fixup.
>> + *
>> + * This file implements runtime fixups for Qualcomm DT to improve
>> + * compatibility with U-Boot. This includes adjusting the USB nodes
>> + * to only use USB high-speed, as well as remapping volume buttons
>> + * to behave as up/down for navigating U-Boot.
>> + *
>> + * We use OF_LIVE for this rather than early FDT fixup for a couple
>> + * of reasons: it has a much nicer API, is most likely more efficient,
>> + * and our changes are only applied to U-Boot. This allows us to use a
>> + * DT designed for Linux, run U-Boot with a modified version, and then
>> + * boot Linux with the original FDT.
>> + *
>> + * Copyright (c) 2024 Linaro Ltd.
>> + *   Author: Caleb Connolly <caleb.connolly@linaro.org>
>> + */
>> +
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include <dm/of_access.h>
>> +#include <dm/of.h>
>> +#include <fdt_support.h>
>> +#include <linux/errno.h>
>> +
>> +/* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
>> + * USB controllers. Rather than requiring source level DT changes, we fix up
>> + * DT here. This improves compatibility with upstream DT and simplifies the
>> + * porting process for new devices.
>> + */
>> +static int fixup_qcom_dwc3(struct device_node *glue_np)
>> +{
>> +       struct device_node *dwc3;
>> +       int ret, len, hsphy_idx = 1;
>> +       const __be32 *phandles;
>> +       const char *second_phy_name;
>> +
>> +       debug("Fixing up %s\n", glue_np->name);
>> +
>> +       /* Tell the glue driver to configure the wrapper for high-speed only operation */
>> +       ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
>> +       if (ret) {
>> +               log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       /* Find the DWC3 node itself */
>> +       dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
>> +       if (!dwc3) {
>> +               log_err("Failed to find dwc3 node\n");
>> +               return -ENOENT;
>> +       }
>> +
>> +       phandles = of_get_property(dwc3, "phys", &len);
>> +       len /= sizeof(*phandles);
>> +       if (len == 1) {
>> +               log_debug("Only one phy, not a superspeed controller\n");
>> +               return 0;
>> +       }
>> +
>> +       /* Figure out if the superspeed phy is present and if so then which phy is it? */
>> +       ret = of_property_read_string_index(dwc3, "phy-names", 1, &second_phy_name);
>> +       if (ret == -ENODATA) {
>> +               log_debug("Only one phy, not a super-speed controller\n");
>> +               return 0;
>> +       } else if (ret) {
>> +               log_err("Failed to read second phy name: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       if (!strncmp("usb3-phy", second_phy_name, strlen("usb3-phy"))) {
>> +               log_debug("Second phy isn't superspeed (is '%s') assuming first phy is SS\n",
>> +                         second_phy_name);
>> +               hsphy_idx = 0;
>> +       }
>> +
>> +       /* Overwrite the "phys" property to only contain the high-speed phy */
>> +       ret = of_write_prop(dwc3, "phys", sizeof(*phandles), phandles + hsphy_idx);
>> +       if (ret) {
>> +               log_err("Failed to overwrite 'phys' property: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       /* Overwrite "phy-names" to only contain a single entry */
>> +       ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy"), "usb2-phy");
>> +       if (ret) {
>> +               log_err("Failed to overwrite 'phy-names' property: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed"), "high-speed");
>> +       if (ret) {
>> +               log_err("Failed to set 'maximum-speed' property: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void fixup_usb_nodes(void)
>> +{
>> +       struct device_node *glue_np = NULL;
>> +       int ret;
>> +
>> +       while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
>> +               ret = fixup_qcom_dwc3(glue_np);
>> +               if (ret)
>> +                       log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
>> +       }
>> +}
>> +
>> +void qcom_of_fixup_nodes(void)
>> +{
>> +       fixup_usb_nodes();
>> +}
>> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
>> new file mode 100644
>> index 000000000000..d18fd1883b7f
>> --- /dev/null
>> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
>> @@ -0,0 +1,19 @@
>> +
>> +#ifndef __QCOM_PRIV_H__
>> +#define __QCOM_PRIV_H__
>> +
>> +#if CONFIG_IS_ENABLED(OF_LIVE)
>> +/**
>> + * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
>> + *
>> + * Adjusts nodes in the live tree to improve compatibility with U-Boot.
>> + */
>> +void qcom_of_fixup_nodes(void);
>> +#else
>> +static inline void qcom_of_fixup_nodes(void)
>> +{
>> +       log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
>> +}
>> +#endif /* OF_LIVE */
>> +
>> +#endif /* __QCOM_PRIV_H__ */
>>
>> --
>> 2.44.0
>>

-- 
// Caleb (they/them)
