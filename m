Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7060EC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 484A684B19;
	Thu,  9 Jul 2026 03:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="UpJ4XZpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C17884A3A; Wed,  8 Jul 2026 23:13:06 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6953B84A1F
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 23:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb787dec99so667088a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783545181; x=1784149981; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0OH/hSoS+08EgTEkQisbcOTjDDaUEI1NjbscoskIk94=;
 b=UpJ4XZpl0daqlbHL/ZFKV3D0cE/OoMtnoddnhrLO1PBj6PuTU/MhI21YLfS1q9xjzi
 Y8WlM/f36iuE7PiKxzl8dlBfHcY1Fmqjr85+DGsHl70x0kouBq280PY19Q3uah3d4Q7a
 kVHvA/EIuoAva/Zna4r0KXf0HdC7+WoQFaBnTmunKbgCBARcx9eN/MOS1BnStXWo9F2g
 eFWlC5KugsHF/J+u02Hj5KogjaZ/zc/+7Zu0gdP7oxN7r55lxUCBXaWIgchjPxdqAMgz
 kbvqkqOa9AQk+QI/3DDntlLj92b0UJBNnBv/lUj9V9h9d1WUV3yrwcNPDP9EAmIM1PR7
 ACqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783545181; x=1784149981;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0OH/hSoS+08EgTEkQisbcOTjDDaUEI1NjbscoskIk94=;
 b=r1CrFlCvQmKvrAU/W8fG7/kWm4VE9MGadcIM4wznx4f7R0aWZOvAsPJKC25Xw5BnHE
 tcaSTN6ownS8dDba17BtxlhBDPuTq130rFNFbQhMUP6lXNByRc5D8i22qCxYVSmF4kh6
 ZjUGdE8O1NpgK5by3P6C6lsZdDdIjnpTTGB0SzTV/7c7xPRVz+um6Fb/5TdPHwSUi5W/
 rPTjTu3d/TqSVORkvyQTw0BToTctuR/VpIxRLBf+HSnafSROLrUeEOmr+m6Zv+KjMpv9
 wvvai/t8mPQYn/NEXDR7DKQe+vSTx5P3LdoCEArfVlucD1Xr6lWDbcxAxLkYkHer3JX9
 eFFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0XyCeHfu33WUdASqdF4GpArkQWSOZYvVkP4lrdFEDIaTo7u7AxBFkY82fAlvZWPsiMkU8MFw=@lists.denx.de
X-Gm-Message-State: AOJu0YzkAZ+OXOshi0OwMyvUPWqQqaT6giu5UoAINcvPNYjBvx4zH5ua
 3NhOk/E4LjVlz7HEeX5WwhXw6oGSBrAT8ZkWIsqpr4w4K/zwlHXD2LInrUR/PSamxpc=
X-Gm-Gg: AfdE7cnqdKqaP3wh8JMGxy5/5Sdj4hQxpKMvsloAqrdGxQzsaSfPkOKrvHK0VvRK8BB
 u4LdtJoTsiZAKdcrjHpYM1WqeeuZt31vM+1qTZ6q0DTUZMZUfOXxWd8SEXzePaaTYYZh8kL1rp9
 fTL8H1jSJrgO0C301AY2qIG2Ul1V4hftGgYWKLkJHEzqpRmu80ZlHKYpSPlzJZQ/bfm2WitiS87
 0zMDdHHcDHAKllyAb1ZVE+hwAgFMs68A7fSHdRZCFNY9EVEDlIpWoZ/DyN+Fr4uRMJnRZmUtdrE
 rGHozbJllyWIi1ERryXDfjBNWza3ocyewRs110L5cR2+eSoYCFoAXCqCDE2JM+iQK0pGK3nOhtI
 OE0FSfJ/EkkUp7UsE23MUvJhb+4UeNBBSZ9KgCHWYdnnWPzGiLvggbuhpSDDijdbl4e1AR9TbXJ
 AZz+dl2N1dRLIF5xZlUdcUZIYjjIuLF+5BbUWsJynK914Yd6MOvkPeCH6jmIU1Vbg=
X-Received: by 2002:a05:6830:6a8d:b0:7e9:b4d0:539f with SMTP id
 46e09a7af769-7ebd016e4b2mr2975492a34.32.1783545181121; 
 Wed, 08 Jul 2026 14:13:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:19a8:8ead:9ca9:cb30?
 ([2600:8803:e7e4:500:19a8:8ead:9ca9:cb30])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb3f6826sm2642217a34.27.2026.07.08.14.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 14:13:00 -0700 (PDT)
Message-ID: <c6d85438-57dd-4661-a042-a19de98d1638@baylibre.com>
Date: Wed, 8 Jul 2026 16:12:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] power: domain: mediatek: split into per-SoC drivers
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>, Sam Shih
 <sam.shih@mediatek.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
 <20260708-mt8188-add-power-domain-v1-6-0e930b4f714e@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260708-mt8188-add-power-domain-v1-6-0e930b4f714e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:32 +0200
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

On 7/8/26 8:07 AM, Julien Stephan wrote:
> In order to prepare addition of future SoC, split the current driver
> into common shared code and SoC specific drivers:
> 
>   - mtk-power-domain.c now only holds the common register access and
>     power on/off/request/probe logic plus the shared power_domain_ops.
>   - mtk-power-domain.h exposes the register definitions, the mtk_scp_domain
>     data structures and the core helpers to the per-SoC drivers.
>   - mt7623-power-domain.c and mt7629-power-domain.c each hold their own
>     domain table and U_BOOT_DRIVER registration. The mt7629 driver also
>     matches the mt7622 compatible, preserving the previous behaviour.
> 
> Update the mt7622, mt7623 and mt7629 defconfigs to select the matching
> per-SoC driver.
> 
> No functional change intended.
> 

...

> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index a96c3fb979c..409d84628e3 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -83,12 +83,29 @@ config MESON_SECURE_POWER_DOMAIN
>  	  Enable support for manipulating Amlogic Meson Secure power domains.
>  	  Support for Amlogic A1 series.
>  
> -config MTK_POWER_DOMAIN
> -	bool "Enable the MediaTek power domain driver"
> +config MT7623_POWER_DOMAIN
> +	bool "Enable the MediaTek power domain driver for MT7623 compatible SoC"
>  	depends on POWER_DOMAIN && ARCH_MEDIATEK
> +	select MTK_POWER_DOMAIN
>  	help
>  	  Enable support for manipulating MediaTek power domains via MMIO
> -	  mapped registers.
> +	  mapped registers for MT7623 compatible SoC. The driver powers
> +	  the SoC power domains on and off and handles the associated bus
> +	  protection bits.
> +
> +config MT7629_POWER_DOMAIN

As in the other patch I comment on, this would make more sense as
MT7622_POWER_DOMAIN since that is the fallback compatible.

> +	bool "Enable the MediaTek power domain driver for MT7629 compatible SoC"
> +	depends on POWER_DOMAIN && ARCH_MEDIATEK
> +	select MTK_POWER_DOMAIN
> +	help
> +	  Enable support for manipulating MediaTek power domains via MMIO
> +	  mapped registers for MT7629 compatible SoC. The driver powers
> +	  the SoC power domains on and off and handles the associated bus
> +	  protection bits. It is also used on MT7622.
> +
> +config MTK_POWER_DOMAIN
> +	bool
> +	depends on POWER_DOMAIN && ARCH_MEDIATEK
>  
>  config QCOM_RPMH_POWER_DOMAIN
>  	bool "Enable the QCOM RPMH Power domain driver"
> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
> index f3cce2b104e..641071c2359 100644
> --- a/drivers/power/domain/Makefile
> +++ b/drivers/power/domain/Makefile
> @@ -14,6 +14,8 @@ obj-$(CONFIG_IMX8MP_MEDIAMIX_BLKCTRL) += imx8mp-mediamix.o
>  obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
>  obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
> +obj-$(CONFIG_MT7623_POWER_DOMAIN) += mt7623-power-domain.o
> +obj-$(CONFIG_MT7629_POWER_DOMAIN) += mt7629-power-domain.o

And same with the file name.

>  obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
>  obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
>  obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
