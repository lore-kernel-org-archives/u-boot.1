Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8762C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D0188266;
	Thu,  6 Jun 2024 14:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VWe1MZdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA0B8823C; Thu,  6 Jun 2024 14:14:58 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A522788274
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ead2c6b553so9671101fa.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717676096; x=1718280896; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u2aQzUhlyprrAXxRPzeiFeL8brkI0i+9gn8vza1JTVs=;
 b=VWe1MZdMN7zsaQjXfmrcGd7k6l1KwS+n+AmcZJks7RJUB1I3bf4+xmxRtnEeP+ZH0u
 OB+LMkqh2Sz/H9qq9yH/Q1DDbKnVzQNNX9gPlOHYnXKWxCRv/x74NxUoCUfGL1TtT9tj
 ydxH3afOPD1aXQteVjehRZ76us4ZqyNQ6hc2JOP9FevNvFVt/BhlsoKeaDaEwtKIxEAy
 lhXzyXphflk9ZcGOuR+FD6mrF3ut/P6nnS01fxTVArgB5QdIYo4IE/Nz5vS5MJ+HPStM
 CtcQnkUDNHVNEu4mFtA25wDBHDmXGyEY1v7qZ+WWBlzHkvuiHek00xoB1+4q9gOwD7wk
 kvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676096; x=1718280896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2aQzUhlyprrAXxRPzeiFeL8brkI0i+9gn8vza1JTVs=;
 b=P5XSTMmMZ5PMSPoh0LJunsGtrzC/btkPSEogd4tSkAGQzml9EBv5BdUkR8/bbXU7l9
 rty58Csy1kq5nwqGjcuG/lVxJky9mmj4S7sSW9ZfKwLqAXegOgg3cVi+a2HfNaVsCp4c
 H9EaIAeEHgfAfPw971OZ8kp1Q1a+/SIhpcab2/2PQNvPPUKIRKImbSon211BMXdJQlQ4
 LmKBFwvwo3mz20wol2f8Kb8whKP+QcppekiuWuEoJ1M2XqMBP+5d6SmayjpN/Ia/PgrF
 kaL+Db32r1Tzsoybsdq12W9EmbrM+75ZQ95YCqZ+9XwZ6TLpVjg1T/gM7BgKUJ7Ur/xw
 eVLg==
X-Gm-Message-State: AOJu0YwRmB2IJ8IjyMeTPoXWw64vlkuPFJTkalvkBGkkWbfQtRe95tYS
 3vYkjqUE9NxqQXyOk/3DfvMFaiq2BBH5fXb0B5J5FvSg8eAxwABpabznynnoWJU=
X-Google-Smtp-Source: AGHT+IFHj4n4Bu9KRVTCH5kkO9fL/X51dHcprEgyjeZypuVEfF/S1U9Z7V05Ij9vSWn35q1Ao+rWQw==
X-Received: by 2002:a05:651c:88:b0:2ea:7f2f:d374 with SMTP id
 38308e7fff4ca-2eac7a0f8d4mr40721291fa.29.1717676095842; 
 Thu, 06 Jun 2024 05:14:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a5f47sm20149845e9.24.2024.06.06.05.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 05:14:55 -0700 (PDT)
Message-ID: <afddfebf-9a9e-4713-b4be-964816abbfe2@linaro.org>
Date: Thu, 6 Jun 2024 14:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] net-lwip: add wget command
To: Maxim Uvarov <muvarov@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Peter Robinson
 <pbrobinson@gmail.com>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Edmond <seanedmond@microsoft.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <98a1de5f01dad1ad55b68ebadcbad1f6357246a6.1716566960.git.jerome.forissier@linaro.org>
 <CAJGZr0LjFDH5XETPRwSKVS_=KCDbdf9Mi0NneFwyM7_YOXi4OQ@mail.gmail.com>
 <e6c307e8-5621-42e2-9c89-024a93e11496@linaro.org>
 <CAJGZr0Lu_ZUMOLpFGuvARW5FzC8jKo1iEBxds9xJQet7RHM4iw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJGZr0Lu_ZUMOLpFGuvARW5FzC8jKo1iEBxds9xJQet7RHM4iw@mail.gmail.com>
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



On 6/6/24 12:16, Maxim Uvarov wrote:
> чт, 6 июн. 2024 г. в 12:56, Jerome Forissier <jerome.forissier@linaro.org>:

[...]

>>>> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
>>>> new file mode 100644
>>>> index 00000000000..25b75040806
>>>> --- /dev/null
>>>> +++ b/net-lwip/wget.c
>>>> @@ -0,0 +1,180 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/* Copyright (C) 2024 Linaro Ltd. */
>>>> +
>>>> +#include <command.h>
>>>> +#include <console.h>
>>>> +#include <display_options.h>
>>>> +#include <image.h>
>>>> +#include <lwip/apps/http_client.h>
>>>> +#include <lwip/timeouts.h>
>>>> +#include <net-lwip.h>
>>>> +#include <time.h>
>>>> +
>>
>> [...]
>>>> +
>>>> +static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>>>> +                           u32_t rx_content_len, u32_t srv_res, err_t err)
>>>> +{
>>>> +       ulong elapsed;
>>>> +
>>>> +       if (httpc_result != HTTPC_RESULT_OK) {
>>>> +               log_err("\nHTTP client error %d\n", httpc_result);
>>>> +               done = FAILURE;
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       elapsed = get_timer(start_time);
>>>> +        log_info("\n%u bytes transferred in %lu ms (", rx_content_len,
>>>
>>> This print I commented for another patch to match current python tests.
>>
>> What do you mean? Is this text incorrect because some tests expect something
>> else? Which ones?
> 
> You modified the python test to expect this output if LWIP is enabled.

It was in the TFTP test.

> Instead of adding one
> more 'if LWIP' to the python test you can make this log_info() output
> the same as the original code.
> But this is up to you. Somebody sometime later will need to drop 'if
> LWIP' from python code.
I dropped the TFTP message change in v3. I will not change the message
for wget since I don't see any issue with that.

Thanks,
-- 
Jerome

> 
> BR,
> Maxim.
