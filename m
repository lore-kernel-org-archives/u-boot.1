Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCD5CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 23:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E749E836AC;
	Wed, 13 May 2026 01:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="k9aWnkkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7512883E36; Wed, 13 May 2026 01:38:32 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 122EB800AE
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 01:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-47cba53479aso3800582b6e.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778629108; x=1779233908;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ra7fmiWqJ5Q6ECeu905hy3Zbu19RDYv3x2bQ88f1DSc=;
 b=k9aWnkkwyFPQa+g33PvUjhzjif5Z3BIaRihkhSgy8b1AByN4lanbln3wN4JSMKrtGp
 Ub61QGYmRih9EovutZDu1XqjpAsMCf7XIyYYQ8INUazXy2RpbljxyIqKPtItks7WX7qr
 +O8WL6SENdkSK1RLII+fvLzWDe5wHGiEW3hSCeZVXtEPB/k7VCVXB9cccr0evs9VrC6C
 556rD9Zsq/C8tjJkfHLR4fk48iAkNTu6Ba9/g4wmqLRUvvJFFj26HpmvMiOpC/iPD07A
 YDZUVIae4Pizv0AyuRqM+5cFaRCdj+CpSvj7jyTNzkWfbcSJS/ykgW0Mpmyq5WeeWR97
 4D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778629108; x=1779233908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ra7fmiWqJ5Q6ECeu905hy3Zbu19RDYv3x2bQ88f1DSc=;
 b=DeqzigZcqF9LE0SLrRmVSFqapG6a90naP8QWenjV9qgkbAnQqFBeRNuTYxILy6OFEM
 hSIK00wAXHxOEU0cstPFQ6VXKnRhGCm3HdX6RULFimgqhVbj+KYBZKuJQd33ohtTRt5+
 tdHN1YAkEtcBPUliEdCWiEpevKY5p8kzXEG4pfy0mU/zLBjk4sjEyTCtUjWVJANyVou1
 UzXGCplnddxMbk6HZeqpB7T0MMIRTOPYaExL1AbwejE4VvVLc/W5O7fJndtsLnzB8vGD
 ZaN9TFC5OlRGXAV19Zms2g51TdBRwndvse4BEO6FwECltX50vgGzyFwxZ+OxL78T+Bzm
 vJVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9nYkA6XlyOyZBnNwBPf8eMvrPLkLhlUhJW092uxkBh9SFIPWExKnu7bxwihHiYHdZ0HJOlLc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywr6IabDSmgKfjPJjuIr88Z7tryqjdGwbMkPG3umQGsqa1AZyOm
 0tPvfQ3PI6nDAJRmRjnvwarOxxKttZhdb+raXlipo4VsBhgR6wGI61FtON82fVP5CiY=
X-Gm-Gg: Acq92OG9pR7CEIl2n2mNlfP42XuAJT/JVshj7SDK7FYeDsm3sD0UmmvAmaWBewW+lM0
 e2e+KZBNjPXQP5+MNjIVlTQRJZ8qn9sCKjj4jdrfOWUbY3rq6aPccwzoyBohz299UGg76Qn1bRS
 bwKYNhIMjyfyNbEF9RWbLjRQUHEEpg+vQFuCAuUDq4J1PkxrItZXHpYmjXa9aINxYQcIchDRdh8
 qLvjRaN2C56K+9qwiLzO8bDVsPNBX0JgDQ+IyNMNQB67SZG7m9UXn9tczcl2VmyWM81TV1lCF/i
 27vNE5dzC8WOPLlz6i5L1mi6rG8OEEdVs+aMj4yVY3NSs0+uWCvLPDoalBzlnLJzSeDByM46qXv
 abajMG1DLWXoVj1uT4xuN9atj8RUbkXL+JglL+r4Ytqb440Gsv5TBrwLVJrw2udcQfgE42JeL62
 tB7IpHckiMVQfrIEQLLQGQUl2FnMeF+uHXY7e+/ZyWOk6l1Uu7tV5p9aDrbM1jVXAGbW3EcAW/m
 Q==
X-Received: by 2002:a05:6808:c14a:b0:467:9ca:4b8a with SMTP id
 5614622812f47-482b2a9393dmr963322b6e.11.1778629108288; 
 Tue, 12 May 2026 16:38:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7ca1:aac3:aee4:c93f?
 ([2600:8803:e7e4:500:7ca1:aac3:aee4:c93f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935904sm23117020b6e.11.2026.05.12.16.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 16:38:27 -0700 (PDT)
Message-ID: <96a3ac76-c983-4575-beaa-892a96687d7e@baylibre.com>
Date: Tue, 12 May 2026 18:38:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] pinctrl: airoha: add shared pinctrl code
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
 <20260509111157.4039434-6-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509111157.4039434-6-mikhail.kshevetskiy@iopsys.eu>
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
> This patch introduce shared Airoha pinctrl code.
> Also it sorts contents of pinctrl makefile.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/pinctrl/Kconfig                 |   1 +
>  drivers/pinctrl/Makefile                |  61 +-
>  drivers/pinctrl/airoha/Kconfig          |  11 +
>  drivers/pinctrl/airoha/Makefile         |   3 +
>  drivers/pinctrl/airoha/airoha-common.h  | 476 ++++++++++++
>  drivers/pinctrl/airoha/pinctrl-airoha.c | 927 ++++++++++++++++++++++++
>  6 files changed, 1450 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/pinctrl/airoha/Kconfig
>  create mode 100644 drivers/pinctrl/airoha/Makefile
>  create mode 100644 drivers/pinctrl/airoha/airoha-common.h
>  create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
> 
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 578edbf8168..46a95a1ab6b 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -405,6 +405,7 @@ config SPL_PINCTRL_ZYNQMP
>  
>  endif
>  
> +source "drivers/pinctrl/airoha/Kconfig"
>  source "drivers/pinctrl/broadcom/Kconfig"
>  source "drivers/pinctrl/exynos/Kconfig"
>  source "drivers/pinctrl/intel/Kconfig"
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index 29fb9b484d0..6c6e8b59122 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -3,39 +3,42 @@
>  obj-y					+= pinctrl-uclass.o
>  obj-$(CONFIG_$(PHASE_)PINCTRL_GENERIC)	+= pinctrl-generic.o
>  
> +obj-y					+= broadcom/
> +obj-y					+= nxp/
> +
> +obj-$(CONFIG_ARCH_ASPEED)		+= aspeed/
> +obj-$(CONFIG_ARCH_ATH79)		+= ath79/
> +obj-$(CONFIG_ARCH_MTMIPS)		+= mtmips/
> +obj-$(CONFIG_ARCH_MVEBU)		+= mvebu/
> +obj-$(CONFIG_ARCH_NEXELL)		+= nexell/
> +obj-$(CONFIG_ARCH_NPCM)			+= nuvoton/
> +obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
> +
>  obj-$(CONFIG_PINCTRL_ADI)		+= pinctrl-adi-adsp.o
> +obj-$(CONFIG_PINCTRL_AIROHA)		+= airoha/
>  obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
>  obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
>  obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
> -obj-y					+= nxp/
> +obj-$(CONFIG_PINCTRL_EXYNOS)		+= exynos/
> +obj-$(CONFIG_PINCTRL_INTEL)		+= intel/
> +obj-$(CONFIG_PINCTRL_K210)		+= pinctrl-k210.o
> +obj-$(CONFIG_PINCTRL_MESON)		+= meson/
> +obj-$(CONFIG_PINCTRL_MSCC)		+= mscc/
> +obj-$(CONFIG_PINCTRL_MTK)		+= mediatek/
> +obj-$(CONFIG_PINCTRL_PIC32)		+= pinctrl_pic32.o
> +obj-$(CONFIG_PINCTRL_QCOM)		+= qcom/
> +obj-$(CONFIG_PINCTRL_QE)		+= pinctrl-qe-io.o
>  obj-$(CONFIG_$(PHASE_)PINCTRL_ROCKCHIP)	+= rockchip/
> -obj-$(CONFIG_ARCH_ASPEED) += aspeed/
> -obj-$(CONFIG_ARCH_ATH79) += ath79/
> -obj-$(CONFIG_PINCTRL_INTEL) += intel/
> -obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
> -obj-$(CONFIG_ARCH_NPCM)         += nuvoton/
> -obj-$(CONFIG_PINCTRL_QCOM) += qcom/
> -obj-$(CONFIG_ARCH_RENESAS) += renesas/
> -obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
> -obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
> -obj-$(CONFIG_$(PHASE_)PINCTRL_TEGRA)	+= tegra/
> -obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
> -obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
> -obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
> -obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
> -obj-$(CONFIG_PINCTRL_MESON)	+= meson/
> -obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
> -obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
> -obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
> -obj-$(CONFIG_ARCH_NEXELL)	+= nexell/
> -obj-$(CONFIG_PINCTRL_QE)	+= pinctrl-qe-io.o
> -obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
> -obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
> -obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
> -obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
> -obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X) += pinctrl-sx150x.o
> +obj-$(CONFIG_PINCTRL_SANDBOX)		+= pinctrl-sandbox.o
> +obj-$(CONFIG_PINCTRL_SCMI)		+= pinctrl-scmi.o
> +obj-$(CONFIG_PINCTRL_SINGLE)		+= pinctrl-single.o
> +obj-$(CONFIG_PINCTRL_STARFIVE)		+= starfive/
> +obj-$(CONFIG_PINCTRL_STI)		+= pinctrl-sti.o
> +obj-$(CONFIG_PINCTRL_STM32)		+= pinctrl_stm32.o
>  obj-$(CONFIG_$(PHASE_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
> -obj-$(CONFIG_PINCTRL_TH1520)	+= pinctrl-th1520.o
> -obj-y				+= broadcom/
> +obj-$(CONFIG_PINCTRL_SUNXI)		+= sunxi/
> +obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X)	+= pinctrl-sx150x.o
> +obj-$(CONFIG_$(PHASE_)PINCTRL_TEGRA)	+= tegra/
> +obj-$(CONFIG_PINCTRL_TH1520)		+= pinctrl-th1520.o
> +obj-$(CONFIG_PINCTRL_UNIPHIER)		+= uniphier/
>  obj-$(CONFIG_$(PHASE_)PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
> -obj-$(CONFIG_PINCTRL_STARFIVE)	+= starfive/

If we are going to sort these, it should be done in a separate commit.

