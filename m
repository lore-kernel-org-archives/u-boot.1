Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D2BC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 08:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897948855C;
	Fri, 23 Aug 2024 10:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wKesWz2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9174588641; Fri, 23 Aug 2024 10:53:34 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4048806A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 10:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso12448535e9.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724403212; x=1725008012; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jFizrNLBGJfQBmXaxS7CRPlSxBfoe9oXjYU+fV7ZdLg=;
 b=wKesWz2PdKmFGktU0fOGZuEUllMt/fqyAwdKHXEyk222Vd/C7YTqHtlnbudewLYjSB
 6NO14Q/f01ZlgR36OeO3xzuJv/G0NvHKeBCUh08fmpBYbfj2hU3J8polvhU2rPT3W72/
 yrVJrzj4hUCBnH58HEqKchkJ9PoENeUEQih+67ahSkU0vtyqLfLf5VaLsuqF4EHDf1D6
 6HONr6le95NpKPlXDB74V4H1ouUsLFqcl+WkS3o3xvI3QLXKZbBgl50kUC58cuE+gebE
 BI0OG9NM4qgESjlMkKPzWcN3im4qxwsVdmIKe9R4DTW2ZvptOc90h1qhNWmUaHFDG5VP
 ABVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724403212; x=1725008012;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jFizrNLBGJfQBmXaxS7CRPlSxBfoe9oXjYU+fV7ZdLg=;
 b=uc8+tTPQpsVrs5LoZ+saBFWpm9XA+g47s3yAKfR+DqQj+mb2CgpihMa0NUsEHEzNsY
 V+uOJiwXL44QpRQ5RIrZiut+MI0CrYRsMjF9GM9+KHstLOHY0fkaKL92f8m4aikoonPd
 TnBKsrNNn8k2w1HLrNUCriNb3huo8qFtizzP5tLwYlALBGngBsEDRrBkAjebrt5pKZ4D
 AUHj5JQfuX2DFsCH2PIDrxL5yqmbU/DfuwLHb06v9y2/j1sjZxeHWIdx8GFaEA9dN3Qk
 VzYt0OB1oiAWbgnwaoAbdHR+tqCsyZ/eGi9G65aXdJnyeuxCbWa6OOTv62sTHJM3EUgp
 Zl/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFNvdQugI6GfbSLS90KDUIs2AlHK7WivHW+LCLUtjRWvUOzbw0f8j9asQk9oXjfJsyWmqAK4I=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0T1E5y+HQQT3ebTZ7cJ5xRmSP9x/LttaOfOsPSJCIeewzi5CV
 lT58kjOij0h1gNEAeCmx3FpnG7BTYRqLIlr8G2t+D0uyHiN0jyk9MQNviUAYY2A=
X-Google-Smtp-Source: AGHT+IEVkf0byAbk4UAUVYW0mgG3ePRv4dA5QKa2hVBp7m5fD259rKBkADwlUhgVm7xYb/3NUfVhug==
X-Received: by 2002:a7b:c399:0:b0:427:d8f7:b718 with SMTP id
 5b1f17b1804b1-42acd5d7dacmr9434335e9.24.1724403210871; 
 Fri, 23 Aug 2024 01:53:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:995c:3fea:6b19:4a51?
 ([2a01:e0a:982:cbb0:995c:3fea:6b19:4a51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac5159450sm52139335e9.17.2024.08.23.01.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 01:53:30 -0700 (PDT)
Message-ID: <887fcb7b-5bd7-40ef-9bb5-ab9ed5079b06@linaro.org>
Date: Fri, 23 Aug 2024 10:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>, U-Boot-Denx <u-boot@lists.denx.de>,
 u-boot-amlogic@groups.io, kernel <kernel@sberdevices.ru>, oxffffaa@gmail.com
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
 <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
 <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
 <CAOf5uw=UKXVB5H3DBzFFPx8nrXw3S44yPq=5CD+VAVHGuAmQTg@mail.gmail.com>
 <0343aa52-8f23-4447-1827-3de7710735f3@salutedevices.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <0343aa52-8f23-4447-1827-3de7710735f3@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 23/08/2024 10:29, Arseniy Krasnov wrote:
> Hi! Got it, thanks!
> 
> On 23.08.2024 11:10, Michael Nazzareno Trimarchi wrote:
>> Hi Arseniy
>>
>> On Thu, Aug 22, 2024 at 9:04 AM Arseniy Krasnov
>> <avkrasnov@salutedevices.com> wrote:
>>>
>>> Hi, thanks!
>>>
>>> Thanks, Arseniy
>>>
>>> On 22.08.2024 00:17, Michael Nazzareno Trimarchi wrote:
>>>> Hi
>>>>
>>>> I will read them tomorrow ;)
>>>>
>>>> Thank you for understanding
>>>>
>>
>> All the series are delegated to Neil. I will review anyway but I think
>> that will then pick from him

Sure I can pick them if reviewed!

Neil

>>
>> Michael
>>
>>>> Michael
>>>>
>>>> Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.com> ha
>>>> scritto:
>>>>
>>>>> Hi, sorry, pls ping  😄
>>>>>
>>>>> Thanks
>>>>>
>>>>> On 08.07.2024 10:13, Arseniy Krasnov wrote:
>>>>>> Patchset is based on patchset for Linux (today merged to nand-next):
>>>>>>
>>>>> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salutedevices.com/
>>>>>>
>>>>>> Here is description from it:
>>>>>>
>>>>>>   >  Amlogic's boot ROM code needs that some pages on NAND must be written
>>>>>>   >  in special "short" ECC mode with scrambling enabled. Such pages:
>>>>>>   >  1) Contain some metadata about hardware.
>>>>>>   >  2) Located with some interval starting from 0 offset, until some
>>>>>>   >     specified offset. Interval and second offset are set in the
>>>>>>   >     device tree.
>>>>>>   >
>>>>>>   >  This patchset adds R/W support for such pages. To enable it we can
>>>>> setup
>>>>>>   >  it in dts:
>>>>>>   >
>>>>>>   >      nand-is-boot-medium;
>>>>>>   >      amlogic,boot-pages = <1024>;
>>>>>>   >      amlogic,boot-page-step = <128>;
>>>>>>   >
>>>>>>   >  It means that each 128th page in range 0 to 1024 pages will be
>>>>> accessed
>>>>>>   >  in special mode ("short" ECC + scrambling). In practice this feature
>>>>> is
>>>>>>   >  needed when we want to update first block of NAND - driver will
>>>>> enable
>>>>>>   >  required mode by itself using value from device tree.
>>>>>>
>>>>>> The only difference is that patchset for Linux updates DT bindings, while
>>>>>> this adds NAND_IS_BOOT_MEDIUM flag support.
>>>>>>
>>>>>> Changelog:
>>>>>>   v1 -> v2:
>>>>>>   * Pls see per-patch changelog.
>>>>>>
>>>>>> Arseniy Krasnov (3):
>>>>>>    mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
>>>>>>    mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
>>>>>>    mtd: rawnand: meson: read/write access for boot ROM pages
>>>>>>
>>>>>>   drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
>>>>>>   drivers/mtd/nand/raw/nand_base.c  |  3 ++
>>>>>>   include/linux/mtd/rawnand.h       |  5 ++
>>>>>>   3 files changed, 65 insertions(+), 27 deletions(-)
>>>>>>
>>>>>
>>>>
>>
>>
>>

