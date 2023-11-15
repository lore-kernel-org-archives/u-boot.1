Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54128C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC2086FB2;
	Wed, 15 Nov 2023 13:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ilis4q40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF2886996; Wed, 15 Nov 2023 13:17:08 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30D186FB2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cc44736f2so41840341cf.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 04:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700050623; x=1700655423; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8IBtniKArQFPOMy32LZpT6ua0LdMLN8CQgQD8wuaMy8=;
 b=Ilis4q40N/4LSK93VI7Z1o9XBuwh8guzGicLukn6DvNuFM4M33aRS5LaCITnU6A9wZ
 tAjwlpNs/XO08uffy55Szb1wAuzGa90xJusbWaHKAeJRWX12cswF8ABXw1CoMoep2bU3
 7Gt5YE4tNJWM5a4oXNau+5rsouQefY3i+dmD8FII9o6uORrbhW4b3ku6nybqt335xGBB
 5Pl0c83YRDbbj4ewY7pKo48gDSHkM8hF75qBDP7c8JvT/dRl56HK3ZBxIoUWOWAyGCql
 2GFqJ8YVC4ogYhEA4pXjX1LMNPUARE262y0Ko5dI5gI/KpQAq5eujnRKRQsEHI30P2+O
 NSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700050623; x=1700655423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8IBtniKArQFPOMy32LZpT6ua0LdMLN8CQgQD8wuaMy8=;
 b=NxB/nkOpFxc/YTJ3gizP6TIYOzr/DzylRvPyusGAC5PpdmApP7N7HjFEJjkX80e6ZE
 b9IbV3JWeUsYwd5DaT75Vl0TftGTWcmFmwEucnDOvKmshJQmoMVAZ4DzlLESiqV1Hp7M
 uPzJPYbK4pMOIgNEagbpQxhi3TVLS+mTgoJqcXwjVpFCJP8KoFrgJs+h8J9Orb/IEzj3
 Hw7bKIsoSGsVESXvH2vmk6DRkXOIX0M02hGk9IbbjRQb6wQ/OaPCqXCLQ8yudkHWzAad
 nk1OiHwkdjNkenjdijEwv/PKM+q3lOlSerVl18EeDJOUZHmLruJUZ4ZZDpUaX8XOOAFC
 upgw==
X-Gm-Message-State: AOJu0Yyb45Mb+NQBPhYsW91S+7D2tz76rYuQALFZUWGha+V7uVyhqNEN
 X+N4SXVjNTtFGgh74AFWF18=
X-Google-Smtp-Source: AGHT+IFMxA8+oOA1evZgrstmbWyDUH6sZeuIWjr5OF75XoNrIWkiLCzRgSHhTcDz0u7saql/gS50DQ==
X-Received: by 2002:ac8:7e86:0:b0:41e:22a2:8ab with SMTP id
 w6-20020ac87e86000000b0041e22a208abmr5726250qtj.46.1700050623406; 
 Wed, 15 Nov 2023 04:17:03 -0800 (PST)
Received: from [172.20.3.47] ([12.191.197.195])
 by smtp.gmail.com with ESMTPSA id
 o9-20020ac872c9000000b00419b094537esm3529895qtp.59.2023.11.15.04.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 04:17:02 -0800 (PST)
Message-ID: <ceadaf58-c675-4d66-ac4f-65fca205c019@gmail.com>
Date: Wed, 15 Nov 2023 21:16:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-cadence: Add support for Cadence sdmmc v6
To: "KuanLim.Lee" <kuanlim.lee@starfivetech.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Yuklin Soo <yuklin.soo@starfivetech.com>,
 WeiLiang Lim <weiliang.lim@starfivetech.com>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 "cpgs@samsung.com" <cpgs@samsung.com>
References: <20231003072320.2008-1-kuanlim.lee@starfivetech.com>
 <CGME20231101001948epcas1p21f7980fd9ab6a99e884eeb08409b1f48@epcas1p2.samsung.com>
 <1891546521.01698969782305.JavaMail.epsvc@epcpadp4>
 <2e47818072d74a8cac1c55888543a947@EXMBX066.cuchost.com>
 <4a9aa7b7ce6243b68623ef4ee1bca822@EXMBX066.cuchost.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@gmail.com>
In-Reply-To: <4a9aa7b7ce6243b68623ef4ee1bca822@EXMBX066.cuchost.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 11/15/23 12:36, KuanLim.Lee wrote:
> Hi Jaehoon,
> If there are no more feedback, I will send out version2 patch soon.
> 
> On 11/7/23 14:24, Kuan Lim Lee wrote:
>>
>> Hi Jaehoon,
>>
>> On 11/1/23 08:20, Jaehoon Chung wrote:
>>> From: Jaehoon Chung <jh80.chung@samsung.com> Hi
>>>
>>> On 10/3/23 16:22, Kuan Lim Lee wrote:
>>>> From: Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>
>>>>
>>>> Cadence SDMMC v6 controller has a lot of changes on initialize
>>>> compared to v4 controller. PHY is needed by v6 controller.
>>>>
>>>> Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
>>>> Reviewed-by: Alex Soo <yuklin.soo@starfivetech.com>
>>>> Reviewed-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
>>>
>>> I didn't see their Reviewed-by tag in mailing list.
>> They are my colleagues who collaborated develop code with me.
>> I think I should them in Signed-off-by, and put your name in Reviewed-by
>>
>>>
>>>> ---
>>>>  drivers/mmc/Kconfig              |  13 ++
>>>>  drivers/mmc/Makefile             |   1 +
>>>>  drivers/mmc/sdhci-cadence.c      |  63 ++-----
>>>>  drivers/mmc/sdhci-cadence.h      |  68 +++++++
>>>>  drivers/mmc/sdhci-cadence6-phy.c | 302
>>>> +++++++++++++++++++++++++++++++
>>>>  5 files changed, 396 insertions(+), 51 deletions(-)  create mode
>>>> 100644 drivers/mmc/sdhci-cadence.h  create mode 100644
>>>> drivers/mmc/sdhci-cadence6-phy.c
>>>>
>>>> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig index
>>>> de01b9687b..cec881d862 100644
>>>> --- a/drivers/mmc/Kconfig
>>>> +++ b/drivers/mmc/Kconfig
>>>> @@ -573,6 +573,19 @@ config MMC_SDHCI_CADENCE
>>>>
>>>>  	  If unsure, say N.
>>>>
>>>> +config MMC_SDHCI_CADENCE_V6
>>>> +	bool "SDHCI support for the Cadence SD/SDIO/eMMC controller &
>>> driver version 6"
>>>> +	depends on BLK && DM_MMC
>>>> +	depends on MMC_SDHCI
>>>> +	depends on OF_CONTROL
>>>> +	select MMC_SDHCI_CADENCE
>>>> +	help
>>>> +	  This selects the Cadence SD/SDIO/eMMC driver version 6.
>>>> +
>>>> +	  If you have a controller with this interface, say Y here.
>>>> +
>>>> +	  If unsure, say N.
>>>> +
>>>>  config MMC_SDHCI_AM654
>>>>  	bool "SDHCI Controller on TI's Am654 devices"
>>>>  	depends on ARCH_K3
>>>> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile index
>>>> 2c65c4765a..cdcce55b8b 100644
>>>> --- a/drivers/mmc/Makefile
>>>> +++ b/drivers/mmc/Makefile
>>>> @@ -61,6 +61,7 @@ obj-$(CONFIG_MMC_SDHCI_ATMEL)		+=
>>> atmel_sdhci.o
>>>>  obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= bcm2835_sdhci.o
>>>>  obj-$(CONFIG_MMC_SDHCI_BCMSTB)		+= bcmstb_sdhci.o
>>>>  obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
>>>> +obj-$(CONFIG_MMC_SDHCI_CADENCE_V6)	+= sdhci-cadence6-phy.o
>>>>  obj-$(CONFIG_MMC_SDHCI_AM654)		+= am654_sdhci.o
>>>>  obj-$(CONFIG_MMC_SDHCI_IPROC)		+= iproc_sdhci.o
>>>>  obj-$(CONFIG_MMC_SDHCI_KONA)		+= kona_sdhci.o
>>>> diff --git a/drivers/mmc/sdhci-cadence.c
>>>> b/drivers/mmc/sdhci-cadence.c index 327a05ad11..d7a270e74c 100644
>>>> --- a/drivers/mmc/sdhci-cadence.c
>>>> +++ b/drivers/mmc/sdhci-cadence.c
>>>> @@ -17,56 +17,7 @@
>>>>  #include <linux/libfdt.h>
>>>>  #include <mmc.h>
>>>>  #include <sdhci.h>
>>>> -
>>>> -/* HRS - Host Register Set (specific to Cadence) */
>>>> -#define SDHCI_CDNS_HRS04		0x10		/* PHY access
>> port */
>>>> -#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
>>>> -#define   SDHCI_CDNS_HRS04_RD			BIT(25)
>>>> -#define   SDHCI_CDNS_HRS04_WR			BIT(24)
>>>> -#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
>>>> -#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
>>>> -#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5,
>> 0)
>>>> -
>>>> -#define SDHCI_CDNS_HRS06		0x18		/* eMMC
>> control */
>>>> -#define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
>>>> -#define   SDHCI_CDNS_HRS06_TUNE			GENMASK(13,
>> 8)
>>>> -#define   SDHCI_CDNS_HRS06_MODE			GENMASK(2,
>> 0)
>>>> -#define   SDHCI_CDNS_HRS06_MODE_SD		0x0
>>>> -#define   SDHCI_CDNS_HRS06_MODE_MMC_SDR		0x2
>>>> -#define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
>>>> -#define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
>>>> -#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
>>>> -#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
>>>> -
>>>> -/* SRS - Slot Register Set (SDHCI-compatible) */
>>>> -#define SDHCI_CDNS_SRS_BASE		0x200
>>>> -
>>>> -/* PHY */
>>>> -#define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
>>>> -#define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
>>>> -#define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
>>>> -#define SDHCI_CDNS_PHY_DLY_UHS_SDR25	0x03
>>>> -#define SDHCI_CDNS_PHY_DLY_UHS_SDR50	0x04
>>>> -#define SDHCI_CDNS_PHY_DLY_UHS_DDR50	0x05
>>>> -#define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY	0x06
>>>> -#define SDHCI_CDNS_PHY_DLY_EMMC_SDR	0x07
>>>> -#define SDHCI_CDNS_PHY_DLY_EMMC_DDR	0x08
>>>> -#define SDHCI_CDNS_PHY_DLY_SDCLK	0x0b
>>>> -#define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
>>>> -#define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
>>>> -
>>>> -/*
>>>> - * The tuned val register is 6 bit-wide, but not the whole of the
>>>> range is
>>>> - * available.  The range 0-42 seems to be available (then 43 wraps
>>>> around to 0)
>>>> - * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
>>>> - */
>>>> -#define SDHCI_CDNS_MAX_TUNING_LOOP	40
>>>> -
>>>> -struct sdhci_cdns_plat {
>>>> -	struct mmc_config cfg;
>>>> -	struct mmc mmc;
>>>> -	void __iomem *hrs_addr;
>>>> -};
>>>> +#include "sdhci-cadence.h"
>>>>
>>>>  struct sdhci_cdns_phy_cfg {
>>>>  	const char *property;
>>>> @@ -112,8 +63,11 @@ static int sdhci_cdns_write_phy_reg(struct
>>>> sdhci_cdns_plat *plat,  }
>>>>
>>>>  static int sdhci_cdns_phy_init(struct sdhci_cdns_plat *plat,
>>>> -				const void *fdt, int nodeoffset)
>>>> +			       const void *fdt, int nodeoffset)
>>>
>>> Is there any reason to touch this?
>> I thought the space key is misaligned. I think I better not to touch it.
>>>
>>>
>>>>  {
>>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_CADENCE_V6))
>>>> +		return sdhci_cdns6_phy_init(plat,
>>> SDHCI_CDNS_HRS06_MODE_SD);
>>>> +
>>>>  	const fdt32_t *prop;
>>>>  	int ret, i;
>>>>
>>>> @@ -163,6 +117,9 @@ static void sdhci_cdns_set_control_reg(struct
>>> sdhci_host *host)
>>>>  	tmp &= ~SDHCI_CDNS_HRS06_MODE;
>>>>  	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
>>>>  	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS06);
>>>> +
>>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_CADENCE_V6))
>>>> +		sdhci_cdns6_phy_init(plat, mode);
>>>>  }
>>>>
>>>>  static const struct sdhci_ops sdhci_cdns_ops = { @@ -172,6 +129,9
>>>> @@ static const struct sdhci_ops sdhci_cdns_ops = {  static int
>>>> sdhci_cdns_set_tune_val(struct sdhci_cdns_plat *plat,
>>>>  				   unsigned int val)
>>>>  {
>>>> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_CADENCE_V6))
>>>> +		return sdhci_cdns6_set_tune_val(plat, val);
>>>> +
>>>>  	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS06;
>>>>  	u32 tmp;
>>>>  	int i, ret;
>>>> @@ -301,6 +261,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
>>>> static const struct udevice_id sdhci_cdns_match[] = {
>>>>  	{ .compatible = "socionext,uniphier-sd4hc" },
>>>>  	{ .compatible = "cdns,sd4hc" },
>>>> +	{ .compatible = "cdns,sd6hc" },
>>>>  	{ /* sentinel */ }
>>>>  };
>>>>
>>>> diff --git a/drivers/mmc/sdhci-cadence.h
>>>> b/drivers/mmc/sdhci-cadence.h new file mode 100644 index
>>>> 0000000000..2c42cff2f3
>>>> --- /dev/null
>>>> +++ b/drivers/mmc/sdhci-cadence.h
>>>> @@ -0,0 +1,68 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (C) 2022 Starfive.
>>>> + *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
>>>
>>>
>>> Does it right Copyright and author? the below codes are taken from
>>> sdhci- cadence.c.
>> Some parts of #define are taken from sdchi-cadence.c, some parts of #define
>> are written by me. I think I still better put back the original Copyright and
>> author.
>>
>>>
>>>> + */
>>>> +
>>>> +#ifndef SDHCI_CADENCE_H_
>>>> +#define SDHCI_CADENCE_H_
>>>> +
>>>> +/* HRS - Host Register Set (specific to Cadence) */
>>>> +/* PHY access port */
>>>> +#define SDHCI_CDNS_HRS04		0x10
>>>> +/* Cadence V4 HRS04 Description*/
>>>> +#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
>>>> +#define   SDHCI_CDNS_HRS04_RD			BIT(25)
>>>> +#define   SDHCI_CDNS_HRS04_WR			BIT(24)
>>>> +#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
>>>> +#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
>>>> +#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5,
>> 0)
>>>> +
>>>> +#define SDHCI_CDNS_HRS05		0x14
>>>> +
>>>> +/* eMMC control */
>>>> +#define SDHCI_CDNS_HRS06		0x18
>>>> +#define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
>>>> +#define   SDHCI_CDNS_HRS06_TUNE			GENMASK(13,
>> 8)
>>>> +#define   SDHCI_CDNS_HRS06_MODE			GENMASK(2,
>>> 0)
>>>> +#define   SDHCI_CDNS_HRS06_MODE_SD		0x0
>>>> +#define   SDHCI_CDNS_HRS06_MODE_MMC_SDR		0x2
>>>> +#define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
>>>> +#define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
>>>> +#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
>>>> +#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
>>>> +
>>>> +/* SRS - Slot Register Set (SDHCI-compatible) */
>>>> +#define SDHCI_CDNS_SRS_BASE		0x200
>>>> +
>>>> +/* Cadence V4 PHY Setting*/
>>>> +#define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
>>>> +#define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
>>>> +#define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
>>>> +#define SDHCI_CDNS_PHY_DLY_UHS_SDR25	0x03
>>>> +#define SDHCI_CDNS_PHY_DLY_UHS_SDR50	0x04
>>>> +#define SDHCI_CDNS_PHY_DLY_UHS_DDR50	0x05
>>>> +#define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY	0x06
>>>> +#define SDHCI_CDNS_PHY_DLY_EMMC_SDR	0x07
>>>> +#define SDHCI_CDNS_PHY_DLY_EMMC_DDR	0x08
>>>> +#define SDHCI_CDNS_PHY_DLY_SDCLK	0x0b
>>>> +#define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
>>>> +#define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
>>>> +
>>>> +/*
>>>> + * The tuned val register is 6 bit-wide, but not the whole of the
>>>> +range is
>>>> + * available.  The range 0-42 seems to be available (then 43 wraps
>>>> +around to 0)
>>>> + * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
>>>> + */
>>>> +#define SDHCI_CDNS_MAX_TUNING_LOOP	40
>>>> +
>>>> +struct sdhci_cdns_plat {
>>>> +	struct mmc_config cfg;
>>>> +	struct mmc mmc;
>>>> +	void __iomem *hrs_addr;
>>>> +};
>>>> +
>>>> +int sdhci_cdns6_phy_init(struct sdhci_cdns_plat *plat, u32 mode);
>>>> +int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned
>>>> +int val);
>>>> +
>>>> +#endif
>>>> diff --git a/drivers/mmc/sdhci-cadence6-phy.c
>>>> b/drivers/mmc/sdhci-cadence6-phy.c
>>>> new file mode 100644
>>>> index 0000000000..dd3df27dc8
>>>> --- /dev/null
>>>> +++ b/drivers/mmc/sdhci-cadence6-phy.c
>>>> @@ -0,0 +1,302 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-platform_driver
>>>> +/*
>>>> + * Copyright (C) 2022 Starfive.
>>>
>>> s/2022/2023?
>> I will put 2023.
>>
>>>
>>>> + *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
>>>> + */
>>>> +
>>>> +#include <common.h>
>>>> +#include <dm.h>
>>>> +#include <asm/global_data.h>
>>>> +#include <dm/device_compat.h>
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/bitops.h>
>>>> +#include <linux/bug.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/iopoll.h>
>>>> +#include <linux/sizes.h>
>>>> +#include <linux/libfdt.h>
>>>> +#include <mmc.h>
>>>> +#include <sdhci.h>
>>>> +#include "sdhci-cadence.h"
>>>> +
>>>> +/* IO Delay Information */
>>>> +#define SDHCI_CDNS_HRS07		0X1C
>>>> +#define   SDHCI_CDNS_HRS07_RW_COMPENSATE		GENMASK(20,
>>> 16)
>>>> +#define   SDHCI_CDNS_HRS07_IDELAY_VAL			GENMASK(4,
>>> 0)
>>>> +
>>>> +#define SDHCI_CDNS_HRS09		0x24		/* PHY Control
>> and
>>> Status */
>>>> +#define   SDHCI_CDNS_HRS09_RDDATA_EN		BIT(16)
>>>> +#define   SDHCI_CDNS_HRS09_RDCMD_EN		BIT(15)
>>>> +#define   SDHCI_CDNS_HRS09_EXTENDED_WR_MODE	BIT(3)
>>>> +#define   SDHCI_CDNS_HRS09_EXTENDED_RD_MODE	BIT(2)
>>>> +#define   SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE	BIT(1)
>>>> +#define   SDHCI_CDNS_HRS09_PHY_SW_RESET		BIT(0)
>>>> +
>>>> +#define SDHCI_CDNS_HRS10		0x28		/* SDCLK
>> adjustment
>>> */
>>>> +#define   SDHCI_CDNS_HRS10_HCSDCLKADJ		GENMASK(19,
>> 16)
>>>> +
>>>> +#define SDHCI_CDNS_HRS16		0x40		/* CMD/DAT
>> output
>>> delay */
>>>> +
>>>> +/* PHY Special Function Registers */
>>>> +//#define DLL_PHY_REG_BASE		0x2000
>>>> +
>>>> +/* register to control the DQ related timing */
>>>> +#define PHY_DQ_TIMING_REG_ADDR		0x2000
>>>> +
>>>> +/* register to control the DQS related timing */
>>>> +#define PHY_DQS_TIMING_REG_ADDR		0x2004
>>>> +
>>>> +/* register to control the gate and loopback control related timing */
>>>> +#define PHY_GATE_LPBK_CTRL_REG_ADDR	0x2008
>>>> +
>>>> +/* register to control the Master DLL logic */
>>>> +#define PHY_DLL_MASTER_CTRL_REG_ADDR	0x200C
>>>> +
>>>> +/* register to control the Slave DLL logic */
>>>> +#define PHY_DLL_SLAVE_CTRL_REG_ADDR	0x2010
>>>> +#define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY
>>> 	GENMASK(31, 24)
>>>> +#define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY
>>> 	GENMASK(7, 0)
>>>> +
>>>> +/* register to control the global settings for PHY */
>>>> +#define PHY_CTRL_REG_ADDR		0x2080
>>>> +
>>>> +struct phy_reg {
>>>> +	u32 phy_dqs_timing;
>>>> +	u32 phy_gate_lpbk_ctrl;
>>>> +	//u32 phy_dll_master_ctrl;
>>>
>>> Remove unused code.
>> Noted.
>>>
>>>> +	u32 phy_dll_slave_ctrl;
>>>> +	//u32 phy_ctrl;
>>>
>>> ditto
>> Noted.
>>>
>>>> +	u32 phy_dq_timing;
>>>> +	//cp_sw_half_cycle_shift; ASIC
>>>
>>> Ditto
>> Noted.
>>>
>>>> +};
>>>> +
>>>> +struct controller_reg {
>>>> +	u32 hrs07;
>>>> +	u32 hrs09;
>>>> +	u32 hrs10;
>>>> +	u32 hrs16;
>>>> +};
>>>
>>>
>>> As some reg values can be re-used. I don't know what its value means.
>>> e.g) 0x00380004 is sued sd_ds/emmc_sdr/emmc_ddr/emmc_hs200.
>> This value is generated by script provided by Cadence.
>> e.g.) phy_dqs_timing_reg (0x2004) is a 32 bits register, inside the register has
>> few component: use_ext_lpbk_dqs, use_lpbk_dqs, use_phony_dqs,
>> use_phony_dqs_cmd, phony_dqs_sel, dqs_select_tsel_start and
>> dqs_select_tsel_end.
>>
>> Each components value is generated by script and I combined the value in a 32
>> bits value, 0x00380004.
>>
>>>
>>> I don't want to use a magic code. If you can add some macros, it's
>>> more readable.
>> Should I change the struct in way below, so that it is more reable?
>> static struct sdhci_cdns_phy_reg_pairs sd_ds_mode_setting[] = {
>> 		{0x00380000, PHY_DQS_TIMING_REG_ADDR},
>> 		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
>> 		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
>> 		{0x00000180, PHY_CTRL_REG_ADDR},
>> 		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
>> };
>>
>> Or I have to put each value of components and put a convertion function in the
>> code to change this to 32 bits value and program inti register,
>> phy_dqs_timing_reg (0x2004)?
>>
>>>
>>>> +
>>>> +static struct phy_reg sd_ds_phy_cfg = {
>>>> +	0x00380004,
>>>> +	0x01A00040,
>>>> +	0x00000000,
>>>> +	0x00000001,
>>>> +};
>>>> +
>>>> +static struct phy_reg emmc_sdr_phy_cfg = {
>>>> +	0x00380004,
>>>> +	0x01A00040,
>>>> +	0x00000000,
>>>> +	0x00000001,
>>>> +};
>>>> +
>>>> +static struct phy_reg emmc_ddr_phy_cfg = {
>>>> +	0x00380004,
>>>> +	0x01A00040,
>>>> +	0x00000000,
>>>> +	0x10000001,
>>>> +};
>>>> +
>>>> +static struct phy_reg emmc_hs200_phy_cfg = {
>>>> +	0x00380004,
>>>> +	0x01A00040,
>>>> +	0x00DADA00,
>>>> +	0x00000001,
>>>> +};
>>>> +
>>>> +static struct phy_reg emmc_hs400_phy_cfg = {
>>>> +	0x00280004,
>>>> +	0x01A00040,
>>>> +	0x00DAD800,
>>>> +	0x00000001,
>>>> +};
>>>> +
>>>> +static struct controller_reg sd_ds_ctrl_cfg = {
>>>> +	0x00080000,
>>>> +	0x0001800C,
>>>> +	0x00020000,
>>>> +	0x00000000,
>>>> +};
>>>> +
>>>> +static struct controller_reg emmc_sdr_ctrl_cfg = {
>>>> +	0x00080000,
>>>> +	0x0001800C,
>>>> +	0x00030000,
>>>> +	0x00000000,
>>>> +};
>>>> +
>>>> +static struct controller_reg emmc_ddr_ctrl_cfg = {
>>>> +	0x00090001,
>>>> +	0x0001800C,
>>>> +	0x00020000,
>>>> +	0x11000001,
>>>> +};
>>>> +
>>>> +static struct controller_reg emmc_hs200_ctrl_cfg = {
>>>> +	0x00090000,
>>>> +	0x00018000,
>>>> +	0x00080000,
>>>> +	0x00000000,
>>>> +};
>>>> +
>>>> +static struct controller_reg emmc_hs400_ctrl_cfg = {
>>>> +	0x00080000,
>>>> +	0x00018000,
>>>> +	0x00080000,
>>>> +	0x11000000,
>>>> +};
>>>> +
>>>> +static unsigned int sdhci_cdns6_read_phy_reg(struct sdhci_cdns_plat *plat,
>>>> +					     u32 addr)
>>>> +{
>>>> +	u32 data = 0;
>>>> +
>>>> +	writel(addr, plat->hrs_addr + SDHCI_CDNS_HRS04);
>>>> +	data = readl(plat->hrs_addr + SDHCI_CDNS_HRS05);
>>>> +	return data;
>>>> +}
>>>> +
>>>> +static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_plat *plat,
>>>> +				      u32 addr, u32 data)
>>>> +{
>>>> +	u32 readdat = 0;
>>>> +
>>>> +	writel(addr, plat->hrs_addr + SDHCI_CDNS_HRS04);
>>>> +	writel(data, plat->hrs_addr + SDHCI_CDNS_HRS05);
>>>> +	readdat = readl(plat->hrs_addr + SDHCI_CDNS_HRS05);
>>>> +
>>>> +	if (readdat != data) {
>>>> +		pr_err("Error, %s: Writing failed!: address: 0x%x, value : 0x%x,
>>>> +		       readval: 0x%x\n", __func__, addr, data, readdat);
>>>
>>>
>>> Doesn't need to return error value?
>> Yes, I think it will be changed  to return error value.
>>>
>>>
>>>> +	}
>>>> +}
>>>> +
>>>> +static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat,
>>>> +				     unsigned int reset)
>>>> +{
>>>> +	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS09;
>>>> +	u32 tmp;
>>>> +	int ret;
>>>> +
>>>> +	tmp = readl(reg);
>>>> +	tmp &= ~SDHCI_CDNS_HRS09_PHY_SW_RESET;
>>>> +
>>>> +	if (reset)	/* Switch On DLL Reset */
>>>
>>>
>>> 	/* Swithc On DLL Reset */
>> Noted, thanks for telling.
>>
>>> 	if (reset)
>>> 		...
>>> 	else
>>> 		...
>>>
>>>
>>>> +		tmp |= FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 0);
>>>> +	else		/* Switch Off DLL Reset */
>>>> +		tmp |= FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 1);
>>>> +
>>>> +	writel(tmp, reg);
>>>> +
>>>> +	if (!reset) {
>>>> +		ret = readl_poll_timeout(reg, tmp,
>>>> +					 (tmp &
>>> SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE),
>>>> +					 3000);
>>>
>>> Add a comment why it needs to poll during 3000.
>> Actually 3000 us is a safe range. User manual doesn’t specify, I put myself.
>> Comment will be like below:
>> /* After reset, wait for PHY_INIT_COMPLETE in HRS09 register until it is set to 1
>> within 3000us*/
>>
>>>
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +int sdhci_cdns6_phy_init(struct sdhci_cdns_plat *plat, u32 mode) {
>>>> +	struct phy_reg *phy_cfgs;
>>>> +	struct controller_reg *ctrl_cfgs;
>>>> +	void __iomem *reg = NULL;
>>>> +	u32 tmp;
>>>> +	int ret;
>>>> +
>>>> +	switch (mode) {
>>>> +	case SDHCI_CDNS_HRS06_MODE_SD:
>>>> +		phy_cfgs = &sd_ds_phy_cfg;
>>>> +		ctrl_cfgs = &sd_ds_ctrl_cfg;
>>>> +		break;
>>>> +
>>>> +	case SDHCI_CDNS_HRS06_MODE_MMC_SDR:
>>>> +		phy_cfgs = &emmc_sdr_phy_cfg;
>>>> +		ctrl_cfgs = &emmc_sdr_ctrl_cfg;
>>>> +		break;
>>>> +
>>>> +	case SDHCI_CDNS_HRS06_MODE_MMC_DDR:
>>>> +		phy_cfgs = &emmc_ddr_phy_cfg;
>>>> +		ctrl_cfgs = &emmc_ddr_ctrl_cfg;
>>>> +		break;
>>>> +
>>>> +	case SDHCI_CDNS_HRS06_MODE_MMC_HS200:
>>>> +		phy_cfgs = &emmc_hs200_phy_cfg;
>>>> +		ctrl_cfgs = &emmc_hs200_ctrl_cfg;
>>>> +		break;
>>>> +
>>>> +	case SDHCI_CDNS_HRS06_MODE_MMC_HS400:
>>>> +		phy_cfgs = &emmc_hs400_phy_cfg;
>>>> +		ctrl_cfgs = &emmc_hs400_ctrl_cfg;
>>>> +		break;
>>>
>>>
>>> If there is no matched mod, phy_cfgs and ctrl_cfgs should be NULL.
>> Noted.
>>
>>>
>>>> +	}
>>>> +
>>>> +	/* Switch On the DLL Reset */
>>>> +	sdhci_cdns6_reset_phy_dll(plat, 1);
>>>> +
>>>> +	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR,
>>>> +				  phy_cfgs->phy_dqs_timing);
>>>> +	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR,
>>>> +				  phy_cfgs->phy_gate_lpbk_ctrl);
>>>> +	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
>>>> +				  phy_cfgs->phy_dll_slave_ctrl);
>>>> +
>>>> +	/* Switch Off the DLL Reset */
>>>> +	ret = sdhci_cdns6_reset_phy_dll(plat, 0);
>>>> +	if (ret) {
>>>> +		printf("sdhci_cdns6_reset_phy is not completed\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/* Set PHY DQ TIMING control register */
>>>> +	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR,
>>>> +				  phy_cfgs->phy_dq_timing);
>>>> +
>>>> +	/* Set HRS09 register */
>>>> +	reg = plat->hrs_addr + SDHCI_CDNS_HRS09;
>>>> +	tmp = readl(reg);
>>>
>>>
>>> I'm not suer why plat-hrs_addr assigned to reg.
>>> How about using the below?
>>>
>>> hrs_base_addr = plat->hrs_addr;
>>>
>>> readl(hrs_base_addr + SDHCI_CDNS_HRS10);
>>>
>>> Then you can change the below code like
>>>
>>> readl(hrs_base_addr + SDHCI_CDNS_HRS16); readl(hrs_base_addr +
>>> SDHCI_CDNS_HRS07);
>>>
>>> Otherwise, readl(plat->hrs_addr + SDHCI_xxx);
>> Noted, this looked simpler.
>>
>>>
>>>
>>>> +	tmp &= ~(SDHCI_CDNS_HRS09_EXTENDED_WR_MODE |
>>>> +		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
>>>> +		 SDHCI_CDNS_HRS09_RDDATA_EN |
>>>> +		 SDHCI_CDNS_HRS09_RDCMD_EN);
>>>> +	tmp |= ctrl_cfgs->hrs09;
>>>> +	writel(tmp, reg);
>>>> +
>>>> +	/* Set HRS10 register */
>>>> +	reg = plat->hrs_addr + SDHCI_CDNS_HRS10;
>>>> +	tmp = readl(reg);
>>>> +	tmp &= ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
>>>> +	tmp |= ctrl_cfgs->hrs10;
>>>> +	writel(tmp, reg);
>>>> +
>>>> +	/* Set HRS16 register */
>>>> +	reg = plat->hrs_addr + SDHCI_CDNS_HRS16;
>>>> +	tmp = ctrl_cfgs->hrs16;
>>>> +	writel(tmp, reg);
>>>> +
>>>> +	/* Set HRS07 register */
>>>> +	reg = plat->hrs_addr + SDHCI_CDNS_HRS07;
>>>> +	tmp = ctrl_cfgs->hrs07;
>>>> +	writel(tmp, reg);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat,
>>>> +			     unsigned int val)
>>>> +{
>>>> +	u32 tmp, tuneval;
>>>
>>> Ditto.
>> Any problem with this? I think current way looked simple.

Ah, My opinion is the using a val or other meaningful name instead of tmp.

Best Regards,
Jaehoon Chung

>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>> +
>>>> +	tuneval = (val * 256) / SDHCI_CDNS_MAX_TUNING_LOOP;
>>>> +
>>>> +	tmp = sdhci_cdns6_read_phy_reg(plat,
>>> PHY_DLL_SLAVE_CTRL_REG_ADDR);
>>>> +	tmp &= ~(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY |
>>>> +		 PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY);
>>>> +	tmp |=
>>> FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY, tuneval) |
>>>> +		FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY,
>>> tuneval);
>>>> +	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
>>> tmp);
>>>> +
>>>> +	return 0;
>>>> +}
>>>
> 
