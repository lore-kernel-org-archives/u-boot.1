Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746DACD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F284C84CF4;
	Sat,  9 May 2026 17:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HnyTWTdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 098B584CFE; Sat,  9 May 2026 17:17:06 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C0D84CD5
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbe437b072so1594453a34.2
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778339817; x=1778944617;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=amPkeP+uqDL5CEtFnLeCFPFG0XzDG9KuRqAx9wBiUz4=;
 b=HnyTWTdPo8RQPoRSw3gm7PvcIi6BtruSzQeD9/IoBlxUK/HVrxWbx9EPRgSnmw+NSz
 zIfeL0HuNyZfVw4bq6mNdcYfzQQt1TzNhyaa8c7h2mvFA5GMCGSyV0PvHK9Mh8OFEedS
 PoJFSgm0+HI7qqnwvKhn/sT4nMc9JIOvzDGKAehb7m9ugoaXDsE0gBuEufxbUMfWY/vP
 2COZd+DFY0GeK5umrqkOCOJkC+x41Bv6hT11oIJNM1Lv70SLpMbSA5LFyoUDlhVlBaDA
 J7emZg0fx0C5n09o+Mo1CvYUJZlBn5cMOb+zZTSImxKVIDJCKEWI9iqc4AOGtlvZxig1
 gpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778339817; x=1778944617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=amPkeP+uqDL5CEtFnLeCFPFG0XzDG9KuRqAx9wBiUz4=;
 b=WqtAhbQmvrOA5tYHQ4h6i689nXZl92LYvI5gRnBlU5UfKAvMH6uoUPPNQZZUrt4Spg
 LaaDJ7YkGWNHeDqqQ6A8btdQoS6EZfQCKOuyCM1ICp2ATWQIN5zEcglFY2VtibpjpV8g
 4BBdZ1bWQ+JmN0eeWp6rtDenc3kHdi0Wj2FrgaN1gFOil7HqExIE6eJolH22Ih/wlsBq
 YtLOaXZj2XQLRDobI6HPG2Z93m959vt+IDPt6rU6DElcow+Nprc8MVRPECZ+N5oPzgdb
 Qor3A00FoVaT+fHxhGSmDaq4gLXYyCkoQvgmw1jhbeDpZlL5Td7I7tKO1tMqAPqElWrB
 /FqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+VHHRoHTUMDk25cnlNi1QGQJ/azTmiXdHVoV0yQHHokKTu2NQ4PQZPVnPMzx33qD+vK6EIr8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/TKqlc9au1nNjVtH/r0FkH+1p9ZShO6VWqa71thbcILHXRgQq
 0TsSEoaOZIDknTd0JfvbQs1q+xF9Q2kcn+6VQw8syv9OVc0mc+wdNkp0TOrfK1tpv2A=
X-Gm-Gg: Acq92OGiWXn3Ml19RZ2u2L+mX0hpttK81VkHLg8L9bi+to09HrZEGgNhbxaLBfuLOBk
 4BVwo9pGptVQfKXezkAc/itOV9x/ytnjZlLwWnySJywRVHYSHGeXpgf+sEQjkXXiqVRnS8i1cDK
 UX+b2HCX8jZb9qcdZtUkvvtNCMpku06v9475ne+BD2YKed0aYEpKEe7HF/SCy+3inuce+Tq7bUw
 BrfxJBu/RI2Jh6S9Sqwr0TPXj1N7Hkp54hGRZGPAt5v0Eu/GJfMO07ObEXQjaiOUam1+6WRr4iD
 bP3T4P1DzmFiSl5Zqv7cl/zPWNdBAT+8xW9/wpmHMaf0bXI14eYHzlsc2uXE9emMfjRbECv+gzs
 e6l4D4SPeKui6SIvrRJVM7xZeXIGIn/ptYPxTRETyiOCWh/NZ1rhA5WLDH23IkIMTxjlFWZ3fSu
 k2pCALk0jGKAdTGOa9jIqv9q+bFny1V8EPkltZrWsH2BeoQcEwx+YmemcXGK2/pzBI2iYdGsNwb
 g==
X-Received: by 2002:a05:6830:6588:b0:7d7:5113:f83a with SMTP id
 46e09a7af769-7e1df0f959dmr9832278a34.25.1778339817385; 
 Sat, 09 May 2026 08:16:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7?
 ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8fe3esm3082837a34.21.2026.05.09.08.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 08:16:55 -0700 (PDT)
Message-ID: <150787c2-785c-4c97-8c9d-06797c3bebae@baylibre.com>
Date: Sat, 9 May 2026 10:16:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Sean Anderson <sean.anderson@linux.dev>,
 Yao Zi <me@ziyao.cc>, Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>, Markus Gothe
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
 <20260504130306.2764862-5-mikhail.kshevetskiy@iopsys.eu>
 <63eb62e7-f301-470f-9524-c261c85dfbd9@baylibre.com>
 <d0d07e96-c638-4639-b2b5-12becabbb933@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d0d07e96-c638-4639-b2b5-12becabbb933@iopsys.eu>
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

On 5/9/26 5:40 AM, Mikhail Kshevetskiy wrote:
> 
> On 5/7/26 00:44, David Lechner wrote:
>> On 5/4/26 8:03 AM, Mikhail Kshevetskiy wrote:
>>> This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
>>>
>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>> ---
>>>  drivers/pinctrl/airoha/Kconfig          |    5 +
>>>  drivers/pinctrl/airoha/Makefile         |    2 +
>>>  drivers/pinctrl/airoha/pinctrl-an7581.c | 1074 +++++++++++++++++++++++
>>>  3 files changed, 1081 insertions(+)
>>>  create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
>>>
>>> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
>>> index eb87afbb374..986d23c2e3d 100644
>>> --- a/drivers/pinctrl/airoha/Kconfig
>>> +++ b/drivers/pinctrl/airoha/Kconfig
>>> @@ -9,3 +9,8 @@ config PINCTRL_AIROHA
>>>  	select REGMAP
>>>  	select SYSCON
>>>  	bool
>>> +
>>> +config PINCTRL_AIROHA_AN7581
>>> +	tristate "AN7581 pin controller and gpio driver"
>>> +	depends on TARGET_AN7581
>>> +	select PINCTRL_AIROHA
>>> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
>>> index a25b744dd7a..909bd9a04d9 100644
>>> --- a/drivers/pinctrl/airoha/Makefile
>>> +++ b/drivers/pinctrl/airoha/Makefile
>>> @@ -1,3 +1,5 @@
>>>  # SPDX-License-Identifier: GPL-2.0
>>>  
>>>  obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
>>> +
>>> +obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
>>> diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
>>> new file mode 100644
>>> index 00000000000..2505818251c
>>> --- /dev/null
>>> +++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
>>> @@ -0,0 +1,1074 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
>>> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
>>> + * Author: Markus Gothe <markus.gothe@genexis.eu>
>>> + */
>>> +#include "airoha-common.h"
>>> +
>> The en7581_ prefix doesn't match the file name or Kconfig. Did you
>> mean to use an7581_ everywhere?
> Good question. EN7581 is the initial name of the chip. The rename to
> AN7581 was caused by renaming of Econet company to Airoha. There are a
> lot of places where en7581_ prefix is used. Also this prefix used in the
> original linux driver, so I prefer to keep it as is.
>>
Then why not also change the file name, etc. to match? Otherwise, it just
looks like a typo if you don't know the history.
