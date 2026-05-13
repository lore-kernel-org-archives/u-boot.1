Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43056CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1E68460E;
	Wed, 13 May 2026 16:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="a0FwGmWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC7B84653; Wed, 13 May 2026 16:03:54 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3CF480F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4670464029eso3912242b6e.2
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778681031; x=1779285831;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jnr96JgFD0BWfoUphrNN1HJjhh07e84fJmyf55pCrw4=;
 b=a0FwGmWRjT+cgrrYhu4Rc2sQg7a7mtKnusapXp0ScHecc+yQHO7wIN2B3B21hSDNrV
 ZScaYsbG/YaNy9OjYQpOS3B7ytmlV+IEU5W/njUKuV94aNmnHqZuPd8qVQCqTD3Hk0c3
 l+2Z7eW9cBR0YzwFAGINYYXs3iiVM46rubtkiJ6/2RZ1AJIXm9mqxOSfVWjBzV3760qy
 6RN34ucUg+zmhf9cjrSJLsY9yY7PpsWSsGZ7Nj8Zmr1zIalq/nkxsri74WyRLJXgLce5
 hHtkX0gmcrHtmuDuFGcglKi/1ZCcYmzWxPYpzJO1t+S8JT5/uRUeBBUOY0a6Rbb1gWUm
 vOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778681031; x=1779285831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jnr96JgFD0BWfoUphrNN1HJjhh07e84fJmyf55pCrw4=;
 b=joWP19gwYbKw8+O/uSo/TsS6yd4IrajOMsg8eMEORkvkfC6DFWWgeD1m7IiNeU/kdZ
 SIi7qA3WqEFH4s4X875YUdYBg+WF4fHJxZGMq2vRTWrrWg8R4b0T49kU4uCTyYu/AgSA
 2bO1ixOWir3Rnr1JM3haWsHrbukIZrLcCwzvQGs0zRePSvXnPg35R/HphbnPJrWsKuoC
 z2KEn2ur4WABbSIvTsFZTvs3EQM/feiQZn8Al/PjI1owvuuZkxHIPyvveIBwZXWFehGD
 JVK50YWm7+hTm09BEcppxxgP8vc3/7SSTXgDMcvJG2rofSUmicEmbJwm3ynvZxJiMAYp
 8SNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Xe+ONgNZ+PdVFpzIIAEpULFMIH5uN9X6ZuPgER2FLz1eQxIq3VGixy9l2G9z5SKHt8LnSCaY=@lists.denx.de
X-Gm-Message-State: AOJu0YxrAuXmdYHbwG1T+GJdAkVzf7QCBMM1iNTda4AqNHUgFAtBpTLs
 gcjvkYzjQEj4mHnCP+2Omnjls5/9ZNKRBqCy3REQkj9lU7V82+5uQXVu+UtRn7veMaI=
X-Gm-Gg: Acq92OH3WUZG2ejTgpr8nnxanBbHxWEytG9m0WVounplPVa70LdzSZivvGi00FQAzqE
 +2hF7FJIweMbXktHq10RNjuVxkkXWWnbjTolBr1ccgf20Oew3Mb2GYKjI9KLkg+3tfb93DTdh1O
 s48hk2XOsk1uX/o7V1e5tKxRm4enwiAmd2+Q50EMNfdNYRfEIwBAVhzFkB09UdREjWvSlJS5jbA
 qrY83Gjew0QHuSFzpcAjYaomW3H8bE2Kfy1Ga6AK9LhdZrZdldT0v4Hao7CgzfkjiSWy3RPXnbE
 xJGTzQIleGXrxATeKFm8/2cLI7d2+BHd+t/xxT5XNH7TBvsLeSUP0UE/d/7BwsKWWJCz6V9Bhbu
 M+Ut/ydpCgPpmOpimJ8AY+0eeAdV9CFO0huUqlqDS9jYOE15acISM9hYVejfRcRx8tdADduHF4z
 omfHC72YrzzMJOMiW9Gak62JIcSAP2MjoKDDm5O7OPcQkg9NZFSjKwiMKKH5KBsnWy97NcGd3Z1
 A==
X-Received: by 2002:a05:6808:bc7:b0:47c:3f6f:db98 with SMTP id
 5614622812f47-482b2d59128mr2153936b6e.35.1778681031194; 
 Wed, 13 May 2026 07:03:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:597d:f2e2:6bf1:a5e9?
 ([2600:8803:e7e4:500:597d:f2e2:6bf1:a5e9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4824f8f1964sm8491797b6e.7.2026.05.13.07.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 07:03:49 -0700 (PDT)
Message-ID: <ea12add3-e05b-4544-a327-c082d8573c68@baylibre.com>
Date: Wed, 13 May 2026 09:03:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
To: Tom Rini <trini@konsulko.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
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
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
 <20260509111157.4039434-7-mikhail.kshevetskiy@iopsys.eu>
 <fd91e95b-d45b-4fdf-807d-54f87a19b26a@baylibre.com>
 <633941db-10eb-49ad-a2dd-a81a71e6b6c9@genexis.eu>
 <20260513135606.GS1858239@bill-the-cat>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260513135606.GS1858239@bill-the-cat>
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

On 5/13/26 8:56 AM, Tom Rini wrote:
> On Wed, May 13, 2026 at 01:30:47PM +0200, Benjamin Larsson wrote:
>> Hi.
>>
>> On 13/05/2026 01:42, David Lechner wrote:
>>> On 5/9/26 6:11 AM, Mikhail Kshevetskiy wrote:
>>>> This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
>>>>
>>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>>> ---
>>>>   drivers/pinctrl/airoha/Kconfig          |    5 +
>>>>   drivers/pinctrl/airoha/Makefile         |    2 +
>>>>   drivers/pinctrl/airoha/pinctrl-an7581.c | 1076 +++++++++++++++++++++++
>>>>   3 files changed, 1083 insertions(+)
>>>>   create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
>>>>
>>>> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
>>>> index eb87afbb374..986d23c2e3d 100644
>>>> --- a/drivers/pinctrl/airoha/Kconfig
>>>> +++ b/drivers/pinctrl/airoha/Kconfig
>>>> @@ -9,3 +9,8 @@ config PINCTRL_AIROHA
>>>>   	select REGMAP
>>>>   	select SYSCON
>>>>   	bool
>>>> +
>>>> +config PINCTRL_AIROHA_AN7581
>>>> +	tristate "AN7581 pin controller and gpio driver"
>>>> +	depends on TARGET_AN7581
>>>> +	select PINCTRL_AIROHA
>>>> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
>>>> index a25b744dd7a..909bd9a04d9 100644
>>>> --- a/drivers/pinctrl/airoha/Makefile
>>>> +++ b/drivers/pinctrl/airoha/Makefile
>>>> @@ -1,3 +1,5 @@
>>>>   # SPDX-License-Identifier: GPL-2.0
>>>>   obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
>>>> +
>>>> +obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
>>>> diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
>>>> new file mode 100644
>>>> index 00000000000..606e042b069
>>>> --- /dev/null
>>>> +++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
>>>> @@ -0,0 +1,1076 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
>>>> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
>>>> + * Author: Markus Gothe <markus.gothe@genexis.eu>
>>>> + */
>>>> +#include "airoha-common.h"
>>>> +
>>> It still throws me off that the en7581_ prefix is not the same
>>> as the file name/driver name/config symbol name. If en7581
>>> is preferred, can we change everything (an7581) to match?
>>
>> The physical chip is marked AN7581 but I have seen some old EN7581 uses in
>> Airoha(Econet) material. I'm not really happy with this situation but for
>> some reason the en7581 name has been pushed for this SoC in mainline kernel
>> code.
>>
>> Ideally linux and uboot should use the same naming but I'm fine with
>> whatever gets code landing upstream.
> 
> I agree consistent naming with the linux kernel is important here.
> 

To be clear, I'm asking for s/an7581/en7581/ s/AN7581/EN7581/ in
this patch (which matches Linux). Right now we have a mix of both.

Mentioning AN7581 in the Kconfig help and in a comment at the top
of the driver file is fine too so that it can be found by both names.

