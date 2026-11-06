Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DB606A32E
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O6eWkzvP;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GgTpjYqo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CFB481846;
	Fri,  6 Nov 2026 16:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BESp7IxKArrP; Fri,  6 Nov 2026 16:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 26675812FE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793982927;
	b=W0KX+qfgFn9yYP2tyBOTg0CzcTAzlXBpP0vZdNYjq41K19dRbnGdpqCo5zz0NjVDd7uL
	 ip9Oj0hz8P/QbSPEDeFQX3XirhpaZ6tWXBLXXmOEcoqwnKDDt2X25rcT7AY2nhUt0MdPU
	 MBxHftQgvf76XyU8OMEhhLBmfq5huPsO0j3pyyPFPV0Nk/ZQ8mPzRBSvaNEkUpyMRiVxu
	 huKsEBMioJ4nYPyHLbzIJVAQd/ifipumNcDcBgfRipYi4fEPayTKwAEaPrFduelrfGBm0
	 Idxo5OSs2jOUAz2HYhGCdM4YxupVre+wr3YQP8oIbUJGExeseK6ff53aBVfvGE4mtgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793982927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eXLOs6EJzhNWbAmujTWJ6lgjzMNwJylMA26vDD2Aj9s=;
	b=q8i3rcs1ff/wpZpCC9JYzFSnJeHLT7YXIH6IhjKBiOasgOLbMYw0tyBHxY58h4O9BW+c
	 G0xMgl7NCjxiLEIAC76Es2tXWYXr0+AuDvYufY7TPoo4NvOocIn0Rmbh0ElqbyJ2x8Nge
	 ZVFH3AD7MSD9THwf9oTrEwnU6w3HJOrCEhQYd75rwU8Mrs9mOYABCaDiHQ99B/u0hUp2Q
	 BF5RKdDGyrWOGbgxEavOjGLyAPx0HEDf7aGN3URILbPwNjnA56nXigKs9g7BoMEfGSrQu
	 LzQtkyQjxQnii518mL7PWAKPhMBusG+WQtrSrB4wNdFwFXZSbmERIFr6JOyvWHWncsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793982927;
	bh=eXLOs6EJzhNWbAmujTWJ6lgjzMNwJylMA26vDD2Aj9s=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O6eWkzvP+U7mb0Y4vYyPfeZx5ERUSjbs2bZcOF6pXHH/GMzFGNUsfKNmt8SbbMNV1
	 6zoDXcEs/aSfePK0LzeTdKc6z+FRKtcw0z3siWx11FZAQnPQRoOPxF8OgylZLHfm73
	 LDz0UDIdaAGZVXS5qDOvajXq+LfJflvM6K+YPSXS5gvIe+f1tSgFl/EKIpsxl0bVGC
	 jLY9ndfRNiyNM623r3U4qdOe/dt5HAg39tzVOWX54YKA23ssvhowyTbVbE1DBh542s
	 hKbQtPPS4Pd7Ianlw5GqYvgSzbChQNNHEVyBkv5ob4aUD5WbfFu+vx6eTCGwJA3aRI
	 8qDVpZuW5YUGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26675812FE;
	Fri,  6 Nov 2026 16:35:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6163B4B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47112403CB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1CYqW3SDY-Zd for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E084A400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GgTpjYqo
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E084A400AF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:35:23 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so8110235e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793982921; x=1794587721;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eXLOs6EJzhNWbAmujTWJ6lgjzMNwJylMA26vDD2Aj9s=;
 b=GgTpjYqoBpIeAghvuhRxq73igsepi/kWMcdKorKCur5SWHE9yxcA0auJhBS1wlRYPw
 fne5HkQDPQtcK0kKekZwJBoSPTr6xF5LIDMwzm/86Wx4VBqThIGm6+/L7m8bqa2GWmD1
 o+Ng5wx9BuXnpHmv/CBW4dqFlJMrl2xPMOJ8iI4LhE37/BDsk/xPGUFRFNMCOkHl+4SP
 eiuAA9juYgNM/ZAvqBk2iMjPzHAHeNQhx7hdHlGjvapbtSlOqHAZZJx1YWZS2IAElcQh
 qd5QlOQnPzDebKsWI26TWfarMd3PE2xCjyc7T7CMT+p0isTIlaVAL4o7ahXXtfdSDnZ6
 +pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793982921; x=1794587721;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eXLOs6EJzhNWbAmujTWJ6lgjzMNwJylMA26vDD2Aj9s=;
 b=V/iTsrUdFIWLezcLYbOLEGol5icmKi3Fib8gSd6ZoPQdkmNJdPdOW+sUIEu+kBUd1i
 12u1Va8V7lyxH/tRKF9QzavVbUtkJeD3hhmMuux/qU3mLMvff7tDpAhNPVrWibz6eOnh
 qvMxMIKSLpeG+gk01dxHBgZwyM3MMJd2l7hvqv8OofgfnXoP6STQpZDmcfAHGBqtU+hK
 ZGrOaM1Boa9DAcpcKLMqzB+jW874ThRqXtp4f2NQViZfTey1aycwXpuhVqUXfm2OpVp4
 m+aVCuhpauzYnHF3NXG0XpQ+oHbahcod4RT1qe6Xbu3VCUH0+iiYdwgUFiAkOg8gmFYB
 DzWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBytafev9zj8DP3l3YYxm3R8r4TMeM4SomhgZKPjhPuVFaxbRUK6awQstt8FTopUIgZpP5Y9I/4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+IASjWZ13gxOF3bBDmADwRB2Q5PDS1x0H+Y2PhBtHBr9D8muys
 qKNVvpN27w2Sskvob0BHTw5+OKy2Az1rPOyLFOVY3WQLs2g9q097G8sKlTlxRfuxF1M=
X-Gm-Gg: AYBFou1cjaLYkYUqQ+vD4gQAB5MpI28/9Dc74ICxpdixuIuftWYfqfvJovZ/3JgdhHh
 3SM3dfJt3ATiGIoTZcXXthcFyuO6ZxVbTI1mjNwdhlP69JGgkShk50Chg/0LHvrBxLP5rS59r7Z
 EKmzrwYmhZ7e3lKM8IY5GvHvpu1NQpOGD8ylNVHFWpkkPThmvZNjstdilR/+At7PkZaEOKtKD67
 uFxJ+G/G5mPZoffdHfge7F+dmThDjspww5caGd5CJBFv9YHF7Dt2d5nkLl82lQw1HijDp73GSaf
 K8JMZa72cFpq5Rx7IMvgvQubx6anfRJ+KPOwGLy7CwBLmMC6hr6M6vED+8xHV+1ssjil6zNVNvl
 j9sltmzR2E3mLtsNx7w7lfkw5HUW8gjRxR3W9lhMkHl8Pdd0Ar1XNC0exBoJlceMMtmTdWpWnM3
 RoH7rYDknBicxia8w7AnsB+bvg2T2IqHOhT5tBxIL9xSHXbnBimpgKAoCClV8C4SEZFCDX8o0z9
 8psQ6Zyf1n2BP2r/7/K1ha73zDVC7reZ6txvP/8tg6S0xXUlp1Y4bwBxCrKwcXhHWbi0c1VVksf
 2vdle7VNZc6XA941g30HI7cp2I3bn/Ke4iTu/J2cTIi472WGH2pmTlJSsYUwp0IBlTUI
X-Received: by 2002:a05:600c:8b66:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4b6df212910mr50654225e9.7.1793982921317; 
 Fri, 06 Nov 2026 08:35:21 -0800 (PST)
Received: from [192.168.1.37] (p5b29ebc8.dip0.t-ipconnect.de. [91.41.235.200])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbd0846sm4951475e9.3.2026.11.06.08.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 08:35:18 -0800 (PST)
Message-ID: <640a8d21-bce7-4185-a4fa-9cc3c350f3bc@linaro.org>
Date: Fri, 6 Nov 2026 17:35:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] arm: mach-snapdragon: add QCS6490 PCIe1
 power/reset sequencing
Content-Language: en-US
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, senthilkumar.l@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
 <20261104163408.1250410-8-sumit.dhami@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20261104163408.1250410-8-sumit.dhami@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 04/11/2026 17:33, Sumit Singh Dhami wrote:
> From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> 
> The QPS615 PCIe switch and downstream Renesas uPD720201 xHCI
> controller on QCS6490/RB3 Gen2 need their reset and power-enable
> lines sequenced before PCIe enumeration. A static DT gpio-hog only
> drives a fixed level once at probe, so it cannot re-assert again on a
> warm reboot while the PMIC rails stay powered.
> 
> Add a qcom_board_init() override that drives these reset/power-enable
> GPIOs directly via the DM GPIO API, issuing a real
> assert-hold-deassert pulse on every boot.

NAK, we have a driver model for a reason, use it. Please also write
commit messages/comments by hand, this is a lot of words that say
basically nothing about this patch.

> 
> Gate the override behind the CONFIG_QCS6490_PCIE_INIT option.
> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig             |   9 +
>  arch/arm/mach-snapdragon/Makefile            |   1 +
>  arch/arm/mach-snapdragon/qcs6490_pcie_init.c | 178 +++++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 arch/arm/mach-snapdragon/qcs6490_pcie_init.c
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 2c182c7b974..a50e13efa6a 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -59,6 +59,15 @@ config QCOM_GENERATE_MBN
>  	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
>  	  supported.
>  
> +config QCS6490_PCIE_INIT
> +       bool "QCS6490 RB3 Gen2 PCIe1 power/reset sequencing"
> +       depends on DM_GPIO
> +       help
> +         Drive the PCIe1 downstream power-enable and reset GPIOs for the
> +         QPS615 PCIe switch and Renesas uPD720201 xHCI controller on
> +         QCS6490/RB3 Gen2 during board init. This overrides the weak
> +         qcom_board_init() in QCS6490.
> +
>  choice
>  	prompt "Qualcomm boot0.h workaround"
>  	optional
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 2360b7c658e..b3fa46548ae 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -9,6 +9,7 @@ ifeq ($(CONFIG_SPL_BUILD),y)
>  obj-y += board_spl.o
>  else
>  obj-y += board.o
> +obj-$(CONFIG_QCS6490_PCIE_INIT) += qcs6490_pcie_init.o
>  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>  endif
>  
> diff --git a/arch/arm/mach-snapdragon/qcs6490_pcie_init.c b/arch/arm/mach-snapdragon/qcs6490_pcie_init.c
> new file mode 100644
> index 00000000000..e2559255eef
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/qcs6490_pcie_init.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * QCS6490 / RB3 Gen2 PCIe power/reset initialization.
> + *
> + * Drives the PCIe1 (RC1) downstream power-enable and reset lines for the
> + * QPS615 PCIe switch and the Renesas uPD720201 xHCI controller directly
> + * via the DM GPIO API, issuing a real assert -> hold -> deassert pulse
> + * on every boot (see commit message for why a DT gpio-hog is not enough).
> + *
> + * Hardware topology (pcie1, RC1, x2 lanes):
> + *   Kodiak PCIe RC1 -> QPS615 PCIe switch -> Renesas uPD720201 xHCI
> + *
> + * Power/reset lines:
> + *   QPS615 switch:
> + *     vdd_ntn_0p9/vdd_ntn_1p8 - regulator-fixed nodes, self-enabled via DT
> + *     resx                    - PM8350C GPIO 1, active-low reset
> + *
> + *   Renesas uPD720201 xHCI (downstream of the switch):
> + *     vreg_pcie0_3p3  - PM7250B GPIO 1 output-high -> 3.3V supply enable
> + *     vreg_pcie0_1p05 - PM7250B GPIO 4 output-high -> 1.05V supply enable
> + *     hub_rst         - PM8350C GPIO 4, active-low reset
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. All rights reserved.
> + */
> +
> +#include <asm/gpio.h>
> +#include <dm.h>
> +#include <dm/uclass.h>
> +#include <linux/delay.h>
> +#include <log.h>
> +
> +/*
> + * PM8350C/PM7250B PMIC GPIO numbers used here are 1-based in the DT; the
> + * DM GPIO offset within the qcom_spmi_pmic_gpio device is 0-based.
> + */
> +#define PM8350C_RESX_OFFSET		0	/* gpio1: QPS615 resx */
> +#define PM8350C_HUB_RST_OFFSET		3	/* gpio4: Renesas hub reset */
> +#define PM7250B_PCIE0_3P3_OFFSET	0	/* gpio1: 3.3V enable */
> +#define PM7250B_PCIE0_1P05_OFFSET	3	/* gpio4: 1.05V enable */
> +
> +/* Settle delays, matching the fixed regulators' own ramp delays */
> +#define PCIE0_3P3_RAMP_US		4300
> +#define PCIE0_1P05_RAMP_US		10000
> +#define RESET_HOLD_MS			15	/* reset-low hold through rail ramp */
> +#define PCIE_POWER_SETTLE_MS		15	/* margin after resets deasserted */
> +
> +/**
> + * pmic_gpio_get_desc() - Build a gpio_desc for a PMIC GPIO offset and request it
> + *
> + * @gpio_dev:	PMIC GPIO uclass device (e.g. resolved via pmic_gpio_uclass_get())
> + * @offset:	0-based GPIO offset within @gpio_dev
> + * @label:	descriptive label for the request
> + * @desc:	returned descriptor
> + *
> + * Return: 0 on success, negative on error
> + */
> +static int pmic_gpio_get_desc(struct udevice *gpio_dev, uint offset,
> +			      const char *label, struct gpio_desc *desc)
> +{
> +	desc->dev = gpio_dev;
> +	desc->offset = offset;
> +	desc->flags = 0;
> +
> +	return dm_gpio_request(desc, label);
> +}
> +
> +/**
> + * pmic_gpio_drive() - Configure a PMIC GPIO as output and drive it high/low
> + */
> +static int pmic_gpio_drive(struct gpio_desc *desc, int value)
> +{
> +	ulong flags = GPIOD_IS_OUT | (value ? GPIOD_IS_OUT_ACTIVE : 0);
> +	int ret;
> +
> +	ret = dm_gpio_set_dir_flags(desc, flags);
> +	if (ret)
> +		return ret;
> +
> +	return dm_gpio_set_value(desc, value);
> +}
> +
> +/**
> + * pmic_gpio_uclass_get() - Find a PMIC GPIO controller by its DT compatible
> + *
> + * pm8350c_gpios/pm7250b_gpios are DT phandle labels, not U-Boot device
> + * names (the device name comes from the DT node name, e.g. "gpio@8800"),
> + * so uclass_get_device_by_name() cannot find them. Look up by compatible
> + * string instead, which is unique per PMIC on this board.
> + */
> +static int pmic_gpio_uclass_get(const char *compat, struct udevice **devp)
> +{
> +	ofnode node;
> +
> +	node = ofnode_by_compatible(ofnode_null(), compat);
> +	if (!ofnode_valid(node))
> +		return -ENODEV;
> +
> +	return uclass_get_device_by_ofnode(UCLASS_GPIO, node, devp);
> +}
> +
> +/**
> + * qcs6490_pcie_power_init() - Sequence PCIe1 downstream power and resets
> + *
> + * Assert both resets low first, enable the Renesas power rails, hold the
> + * resets through the rail ramp-up + settle time, then deassert both.
> + * Runs unconditionally on every boot (cold or warm).
> + *
> + * Return: 0 on success (non-fatal if a PMIC GPIO bus is not found)
> + */
> +static int qcs6490_pcie_power_init(void)
> +{
> +	struct udevice *pm8350c_gpio, *pm7250b_gpio;
> +	struct gpio_desc resx, hub_rst, pcie0_3p3, pcie0_1p05;
> +	int ret;
> +
> +	ret = pmic_gpio_uclass_get("qcom,pm8350c-gpio", &pm8350c_gpio);
> +	if (ret) {
> +		log_warning("pm8350c_gpios not found (%d), skipping PCIe power init\n",
> +			    ret);
> +		return 0;	/* non-fatal */
> +	}
> +
> +	ret = pmic_gpio_uclass_get("qcom,pm7250b-gpio", &pm7250b_gpio);
> +	if (ret) {
> +		log_warning("pm7250b_gpios not found (%d), skipping PCIe power init\n",
> +			    ret);
> +		return 0;	/* non-fatal */
> +	}
> +
> +	if (pmic_gpio_get_desc(pm8350c_gpio, PM8350C_RESX_OFFSET,
> +			       "qps615-resx", &resx) ||
> +	    pmic_gpio_get_desc(pm8350c_gpio, PM8350C_HUB_RST_OFFSET,
> +			       "renesas-hub-reset", &hub_rst) ||
> +	    pmic_gpio_get_desc(pm7250b_gpio, PM7250B_PCIE0_3P3_OFFSET,
> +			       "vreg-pcie0-3p3-en", &pcie0_3p3) ||
> +	    pmic_gpio_get_desc(pm7250b_gpio, PM7250B_PCIE0_1P05_OFFSET,
> +			       "vreg-pcie0-1p05-en", &pcie0_1p05)) {
> +		log_warning("failed to request PCIe power/reset GPIOs\n");
> +		return 0;	/* non-fatal */
> +	}
> +
> +	/* Assert both resets low before touching power rails */
> +	pmic_gpio_drive(&resx, 0);
> +	pmic_gpio_drive(&hub_rst, 0);
> +
> +	/* Renesas xHCI 3.3V */
> +	pmic_gpio_drive(&pcie0_3p3, 1);
> +	udelay(PCIE0_3P3_RAMP_US);
> +
> +	/* Renesas xHCI 1.05V */
> +	pmic_gpio_drive(&pcie0_1p05, 1);
> +	udelay(PCIE0_1P05_RAMP_US);
> +
> +	/* Hold resets asserted through the rail ramp-up */
> +	mdelay(RESET_HOLD_MS);
> +
> +	/* Deassert both resets (active-low -> drive high) */
> +	pmic_gpio_drive(&resx, 1);
> +	pmic_gpio_drive(&hub_rst, 1);
> +
> +	mdelay(PCIE_POWER_SETTLE_MS);
> +
> +	return 0;
> +}
> +
> +/**
> + * qcom_board_init() - QCS6490 / RB3 Gen2 board-specific initialization
> + *
> + * Overrides the empty __weak qcom_board_init() in mach-snapdragon/board.c.
> + * Sequences PCIe1 downstream power/reset so RC1 enumeration works reliably
> + * on both cold boot and warm reboot.
> + */
> +void qcom_board_init(void)
> +{
> +	if (ofnode_device_is_compatible(ofnode_root(), "qcom,qcm6490") ||
> +	    ofnode_device_is_compatible(ofnode_root(), "qcom,qcs6490"))
> +		qcs6490_pcie_power_init();
> +}

-- 
// Casey (she/her)

