Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4144ECD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 23:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC29C836AC;
	Wed, 13 May 2026 01:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="b5GQBgvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14DAE83EEF; Wed, 13 May 2026 01:42:10 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71F18800AE
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 01:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-47c941f7213so3755930b6e.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778629325; x=1779234125;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g65474wZTIaoDwdEdF5ec70Aj0JI0Gjeu2qsPqlfzdg=;
 b=b5GQBgvlvnYCP69hTxdTFPWm5EJhaeV2BVURv09gMSC0wwg166JuH9WhOU61KpjW/W
 z6ScmPEbj29VPh8Le014P/dEtoGACeuq3k11yJnzTV9XkMAp3W8pGR3nMD4R+DSsgmEG
 I6+JqG9fDF9MAHjuZFhkk3XQq3OpX2UUSgK0dX1Wjd6zzv7jtssyXd1O8sR/r8/2zlTk
 Qu0j3YBH8gt4Q+iH42bglx4beAM+FHC1bKgL3vPR6ZEPKrfeo0AYn1BXqPmidl0H5M6t
 8OsRaPAogLBYq3rn+LmR4vlpA0PbQBMefyUg7TIoCnvXUCX05yDYModQBXOehuJ8zHEq
 LKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778629325; x=1779234125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g65474wZTIaoDwdEdF5ec70Aj0JI0Gjeu2qsPqlfzdg=;
 b=kvd/RbBIVvU/VU236R2m0o323+BmP179CB0WFdd2nLYXU3ETKl1MIA0fySmnc4F7wl
 P1UZfdlW7zQOf5ugUXfIy9j1U0b5nW0iyunJpopNKm5Oxr8f7BpAWpxbHAirDA+JQDk2
 I8s6S0O/MmDLng3HrmFlEo/178vVoXu8Zpf3gCjqzvnVsd1ik7sf6ANPR2K2kquBSUoK
 qgOgwMkmg7bqHeHntad3+sshQDqpNbq+fcoh2o8iR2tgjMww4yvC1Aw57h3YRnzuS3gx
 s+1DcrYLYPC5i6gegFzycE6v6oNerpc5rz5Yl2U7qA/5bMEAnbJ/eL1MWd7TaIsJ3vIG
 oaBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/D+SqeJlh2mxfypbAQTNnwOixNyldABDCL8ohvCEEcXku1LX0zZwIuua9Sx69qee70IGhrJpk=@lists.denx.de
X-Gm-Message-State: AOJu0YwKlxqluuvWth1q2yZZuOtuAC92OPCRcDTvJpCk/8wFWeABtRHK
 GtBaX0UL34cLqJp96crAz7eKX2Qgo3WPl4IK9Zs0vNd8U7Tc/p3YNS7VVNUi+Gn1RpY=
X-Gm-Gg: Acq92OG5+7Uz9SWnP4rIslc4Ixk5Nc7pOzhkvFbGZaQwWF7OpZpuMhwe48p9FSBjmGZ
 KH7rtJq8/QtfrUfWP7s7r3+Ry5Aefs8Ps9fPXgg70RmV9qq2SGUap9+YIk/XVVXOC1v4+gKwl66
 pAI4vFSboupL9vraUxYJ2BdiKj3EjylFkMEvZD70EyqKJSsCRzQ/P5pdFfi0G05Zddz6av4/+EZ
 dr4rlnRimYyHdp6OUJRMRrDrPkNWWDR+LmhW50Ed0EdwoVSBGiLAxpWgWXVQT5TVzhvk66Ep4o1
 sfW491xxza0gXiXEx7dmTMNrLPUdCAdHAxEr5NOt5BBfCVIAEfPDHIJrACt3bmNxskv+5uksWZr
 uf91f7kF39KszrF03D2YYKBSAUgBOTI4TJovqJHPnidpSLgrsC1oE5NdF2f/WASDABkhFPLFbaw
 PyCFt388rP2vK784TxSj/kNaaMVLpilWUvDDIYfidu9p3861ThpSMlTivbtryV7R7CktjYYyzeD
 Q==
X-Received: by 2002:a05:6808:1a12:b0:467:91:fb32 with SMTP id
 5614622812f47-482b622fa19mr350139b6e.39.1778629325193; 
 Tue, 12 May 2026 16:42:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7ca1:aac3:aee4:c93f?
 ([2600:8803:e7e4:500:7ca1:aac3:aee4:c93f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c769c9b12sm23315012b6e.17.2026.05.12.16.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 16:42:04 -0700 (PDT)
Message-ID: <fd91e95b-d45b-4fdf-807d-54f87a19b26a@baylibre.com>
Date: Tue, 12 May 2026 18:42:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>, Michal Simek
 <michal.simek@amd.com>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>, Markus Gothe
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
 <20260509111157.4039434-7-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509111157.4039434-7-mikhail.kshevetskiy@iopsys.eu>
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

On 5/9/26 6:11 AM, Mikhail Kshevetskiy wrote:
> This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/pinctrl/airoha/Kconfig          |    5 +
>  drivers/pinctrl/airoha/Makefile         |    2 +
>  drivers/pinctrl/airoha/pinctrl-an7581.c | 1076 +++++++++++++++++++++++
>  3 files changed, 1083 insertions(+)
>  create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
> 
> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
> index eb87afbb374..986d23c2e3d 100644
> --- a/drivers/pinctrl/airoha/Kconfig
> +++ b/drivers/pinctrl/airoha/Kconfig
> @@ -9,3 +9,8 @@ config PINCTRL_AIROHA
>  	select REGMAP
>  	select SYSCON
>  	bool
> +
> +config PINCTRL_AIROHA_AN7581
> +	tristate "AN7581 pin controller and gpio driver"
> +	depends on TARGET_AN7581
> +	select PINCTRL_AIROHA
> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
> index a25b744dd7a..909bd9a04d9 100644
> --- a/drivers/pinctrl/airoha/Makefile
> +++ b/drivers/pinctrl/airoha/Makefile
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
> +
> +obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
> diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
> new file mode 100644
> index 00000000000..606e042b069
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
> @@ -0,0 +1,1076 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> + * Author: Markus Gothe <markus.gothe@genexis.eu>
> + */
> +#include "airoha-common.h"
> +

It still throws me off that the en7581_ prefix is not the same
as the file name/driver name/config symbol name. If en7581
is preferred, can we change everything (an7581) to match?

> +static const int en7581_pon_pins[] = { 49, 50, 51, 52, 53, 54 };
> +static const int en7581_pon_tod_1pps_pins[] = { 46 };
> +static const int en7581_gsw_tod_1pps_pins[] = { 46 };
> +static const int en7581_sipo_pins[] = { 16, 17 };
> +static const int en7581_sipo_rclk_pins[] = { 16, 17, 43 };
> +static const int en7581_mdio_pins[] = { 14, 15 };
> +static const int en7581_uart2_pins[] = { 48, 55 };
> +static const int en7581_uart2_cts_rts_pins[] = { 46, 47 };
> +static const int en7581_hsuart_pins[] = { 28, 29 };
