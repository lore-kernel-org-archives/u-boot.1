Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53669C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79EDD807B1;
	Fri,  6 Jun 2025 08:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OXMHVTRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 396A081E25; Fri,  6 Jun 2025 08:11:32 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1CA800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so1557342f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749190289; x=1749795089; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v3b9lBM0RXYfEX4MIYIHXZyhbCZf0Fa1EDDm3/PyQCw=;
 b=OXMHVTRUdM2fhIHcntXnqLcNviZh1x+Imh0R/0PPKuxH4ykftS/ToqxzSIkSnMXjEc
 4VR0Ttx1dnOafxNsWHLKjjgTL7kkxvK1IaHUy2/sDlr+pvMdKUdSXTDytynKBMF7H9Nw
 C44USqHl7KFFByJAY1OkmrcjLwW1c+eny8xkAOcq89DWmwsmZVrHdqzIj4Q/WTzHblEJ
 CGxvGAfHDOJy5i851qWPqcyW+o2OX0jboPd4YGMSGHcVPlNdbjRAJXC9gCn6aDKXkP2j
 WrDHlqr/DdYGy0ncLPJZCoiVxDWlewwzS+pWf1CK5sZJC4i+R4L9GG6F8pT+AX3n2ThB
 w4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749190289; x=1749795089;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v3b9lBM0RXYfEX4MIYIHXZyhbCZf0Fa1EDDm3/PyQCw=;
 b=Eo6KZzPspjxUaFxKM86aAnoDfBL3TF302Rga71lesKrW5Hj+5DIB/PjDUswrO2lKW5
 VQCidmwxPi756QA/84M+RUIwhMia1bVkL2/RzqP12cMF5woCIl6RD6pmFLYXkwZjWHhL
 BvPgIWVa+2m+pXaUkumxV+B3Evm7py2PL32hKn2wJCngs3KcdCc2VoKzM4fF95LZYQRi
 SZxEhWn/Wm5XIiduwnK3rpwL6SCvMYWLD50ZGCpkVp8bJXwgyReoYuos7/fUoxWChqy0
 iPfmm9ZKBWs7iie8Tu/kiAJ6GsNu3OTaqM5wmeGuq1H6nX8el5PuBFExV1EVCC4/bZiu
 Ve2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpDIsfDhxbZ+9y5oXqpqpkjg8mccAUWMR7iKjglDn1ryqI1rpZCxIMQZPfsLndRh5ZFxVgCFA=@lists.denx.de
X-Gm-Message-State: AOJu0YzUM0/5/D/y+lKdNN3wpMecD3ZV3Qau35HR9m9KRZb+5qdt7uL6
 HLhnHNr1EIENgIQjYcmrre+H+bIje5yYnsxvzHx801kAaTduIWCjYshf9lTJR0WrwZ0=
X-Gm-Gg: ASbGnctyw1DHpwrJMJiMZdN+6s85URthwEr010DfJ7gfRPxaZfaEa7PumYUZVq4nVzG
 YALMBDr9RAVS7PKQ1LmpyQUNmAOIUl/+fZrb17pcdw5+od23Q+rf4Oc4oi0Zyaa89svJwEtV0qC
 7tImUQymRxMGg8gE04Y+WxdA+qqpVIYv5n9ULJQtStx2eYQJBIq/oA2/XP+tyd5JdFlVqgLUdnO
 f6b2hmrGqEdQhNVC47iN16s6l2QT+xycg98btiFfYpm9uqgvw0HlBtp04pXYFennkVlkIhgIrlg
 jYk9gQxW6OeazShhTCa2xeQ8rizN/ODSKeBDKcUxp5lOAHXPHFTeC29Hcco=
X-Google-Smtp-Source: AGHT+IHGJD+3n4cdyLwNCyFx4ln0gCBMutKL/AOPbUyL69RXJJinsx37+rd38fsYQYEMlcm6C4eCNA==
X-Received: by 2002:a05:6000:18ac:b0:3a5:298a:3207 with SMTP id
 ffacd0b85a97d-3a531cb07b8mr1714129f8f.48.1749190289294; 
 Thu, 05 Jun 2025 23:11:29 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323b6612sm925859f8f.41.2025.06.05.23.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 23:11:28 -0700 (PDT)
Message-ID: <7e70dffd-78d3-4339-b644-495294b72fff@linaro.org>
Date: Fri, 6 Jun 2025 09:11:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] clk: at91: clk-main: drop parent_name check when
 registering main_rc oscillator
To: Manikandan.M@microchip.com, lukma@denx.de, seanga2@gmail.com,
 sjg@chromium.org, Oliver.Gaskell@analog.com, malysagreg@gmail.com,
 nathan.morrison@timesys.com, mkorpershoek@kernel.org,
 robert.marko@sartura.hr, jerome.forissier@linaro.org,
 sebastian.reichel@collabora.com, duje.mihanovic@skole.hr,
 sumit.garg@kernel.org, patrice.chotard@foss.st.com,
 Nicolas.Ferre@microchip.com, u-boot@lists.denx.de
References: <20250603050556.80851-1-manikandan.m@microchip.com>
 <20250603050556.80851-5-manikandan.m@microchip.com>
 <8d7091fb-b07b-4b4c-ba73-fefe574b8fd9@linaro.org>
 <b01bea7a-8c91-46a8-b09a-084b8330d7db@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <b01bea7a-8c91-46a8-b09a-084b8330d7db@microchip.com>
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



On 6/6/25 07:42, Manikandan.M@microchip.com wrote:
> Hi Eugen,
> 
> On 05/06/25 12:05 pm, Eugen Hristev wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 6/3/25 08:05, Manikandan Muralidharan wrote:
>>> The clk_register function logs an error if parent_name is missing from the
>>> Device Tree.On the SAM9X7, the main_rc node is omitted to stay aligned with
>>> the Linux Device Tree.Remove the parent_name check in at91_clk_main_rc()
>>> to allow it to pass NULL when the parent is not specified.
>>
>> Hello Manikandan,
>>
>> Can you explain a bit? parent_name is a field inside a struct, not in
>> DT, so where is this parent_name taken from ?
>> If the main_rc is now gone, which clock fails without this patch ?
>>
> 
> uclass_get_device_by_name() fails if the main_rc node is omitted from 
> the Device Tree, resulting in an error message being printed to the 
> console from clk_register(). This patch suppresses that message.

Which device is looked up ?
For which clock ?

> 
>> Eugen
>>>
>>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>>> ---
>>>   drivers/clk/at91/clk-main.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
>>> index 09daae97676..a5186f885f0 100644
>>> --- a/drivers/clk/at91/clk-main.c
>>> +++ b/drivers/clk/at91/clk-main.c
>>> @@ -110,7 +110,7 @@ struct clk *at91_clk_main_rc(void __iomem *reg, const char *name,
>>>        struct clk *clk;
>>>        int ret;
>>>
>>> -     if (!reg || !name || !parent_name)
>>> +     if (!reg || !name)
>>>                return ERR_PTR(-EINVAL);
>>>
>>>        main_rc = kzalloc(sizeof(*main_rc), GFP_KERNEL);
>>
> 

