Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3864DCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C20A883F91;
	Fri, 10 Oct 2025 14:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aO0NcSgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10BBB8410C; Fri, 10 Oct 2025 14:54:03 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD8F383EAC
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso12299445e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760100839; x=1760705639; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TRPxJj6wkJAr2x8Jr3LsG5cCIbCs7FE9ZjR2oW1cxSw=;
 b=aO0NcSgm31v5jAKO52QTOOCKJSGf0itcLNJOatq664BK1behRU2vXHa/PTy5SMe9I1
 +EeONW261N8e/aAqEv3fEunY7B2yd2PAaAgmPIAkdeTp+Xd9s/If3vnlcrUJi80LMjhW
 xxR9aNRn0K3NY66BUyVTvkGKQPZOMrJby3sa9dX0cGNm7OCFHsgc99WvPucfEAIbjd8Z
 G8M7L/XKDDt8HwqxyzILnYVnFvRyFiZurOl3OoxqeP0WEZQ+INfndD42YgUyzTG4muOw
 8H887hCCPsuOvfeMvJUHBPPaWY7GtwykFARP4OpaVzN8upDP198Tgt2lxtORBZYcdb9Z
 1mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760100839; x=1760705639;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TRPxJj6wkJAr2x8Jr3LsG5cCIbCs7FE9ZjR2oW1cxSw=;
 b=dH7uvThvTg4SJ9i84h/HHUO+TiIrICarng3P4cML5Sbo8bSIaKbS/P1lbGcS/ElWlf
 /kRVMA7p3x6W8/ARK5x0gSyCwPPWyWAnCdYuX/mkutqJbFz5V1QnUxYn0SLLZ5o1OSY/
 jDr63V++W5+pjm52235sNT/Bd5PNbcJaKqpNfqjN0GGBzA+PvxvjaIxCz3TXlsFmgJxm
 MxVOhbAXsTxuHnSrYUbKf41ATMXQ/jD+4APzHmdzJaoJ5Yx8tp8AMtOsiCvUXkZqEsGS
 9XdXMQVeLe7i9omqxm+IAn9ilimGNZtw4kHmWpCFfHfGNLfL9EGBIEYU40SQok43roNs
 h3kg==
X-Gm-Message-State: AOJu0Yx8Op7wOcDjmFEC/kCqRIVCLGbX8vkGjXNUENF8XH5syHYR8BEK
 Vs1QdUdNTShYz80NQ0RHi3J65WQtzx0akvjlGOgt8HPvIZGwDZSKFYGPvDmSqvQjF+A=
X-Gm-Gg: ASbGncuUsMqOKvOW9lrwreU3SEgM7YIs68alKodKPK39vPkTkX7NolW+oIo8xYK0Awe
 ofPukgEeSRRG2FCFm/bdVl383Y/re1NR1AB8LAhW1ZQxElI1Qupq3QA1JT/cPLr9AxuhdTBvuNC
 QMNkmdLqbfso2sOpVYJReXY6XbGAN9ndOx2qNhsWsqVXO6f0dhxHlxrgShPaKBseB1oWVzsAowZ
 TY12xenFkq+06TwD0AQvssXaTLflI1HXMoov0Tdj0Br9W9d/Y7maY92KMQlU4LTuTobyOhpTyaj
 qXxJ7sYJJHJptjcaMTc/aAdCnEFdk/lwdgOABw8G8g9mhFNiFZHtpHxDgO2s5wS9OO/jMt+wUpU
 OaWB2YtgCF2jkyOE4OX+ppVkhuc4crgZDycmKxyrwnFm4JOfV3SuCkYtwmMN3OV2grXWq0VuS4N
 eFzRkX55+dcydVC3tLJe03SEtp3FPrq5I8
X-Google-Smtp-Source: AGHT+IFHa13OEFbrAShUzotFC6GTkfN5qvikBxzVQZINha1UBSk2AjzAMmFPlev349/UDi2m1tRN/Q==
X-Received: by 2002:a05:600c:a402:b0:46f:b43a:aef4 with SMTP id
 5b1f17b1804b1-46fb43aaf69mr22204835e9.38.1760100838985; 
 Fri, 10 Oct 2025 05:53:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:2a00:b5fb:c622:3102?
 ([2a01:e0a:3d9:2080:2a00:b5fb:c622:3102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb48a60b8sm45764315e9.19.2025.10.10.05.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 05:53:58 -0700 (PDT)
Message-ID: <78fece4f-7b2c-4734-a351-b06fccbd3f83@linaro.org>
Date: Fri, 10 Oct 2025 14:53:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/7] Introduce the Interconnect Subsystem
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Mario Six <mario.six@gdsys.cc>, u-boot-qcom@groups.io
References: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
 <20251008-topic-interconnect-next-v2-1-c46e94dd328e@linaro.org>
 <CAFLszTi3cNihLKOvJhrm1GLYdxQKvkv-66Fdr6m90+vvdUtMMg@mail.gmail.com>
 <d0e157af-c5e7-45ee-9f8f-6b9a523d5505@linaro.org>
 <CAFLszTgemVk0tSMpBiMfgnh4LGaVKnOpGWa0N8WwE2Spf+ZUWA@mail.gmail.com>
 <8324c7c6-dcfb-4fe8-a9d3-9ab19fdac36c@linaro.org>
 <CAFLszTi9omZ372BocVZ39nHbgofM5in=Nz4yvCXrHVEgoJPiQg@mail.gmail.com>
 <c6694467-8efb-404d-862d-4df62dd60db6@linaro.org>
 <bfd6fcbb-2c7b-4463-b0ba-ea0a01a09ecd@linaro.org>
 <CAFLszTjDt__zEwcy4jioy9vgY+Sv52Ryz0b95JtFTT76-BTT2Q@mail.gmail.com>
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
In-Reply-To: <CAFLszTjDt__zEwcy4jioy9vgY+Sv52Ryz0b95JtFTT76-BTT2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/10/25 13:31, Simon Glass wrote:
> Hi Neil,
> 
> On Thu, 9 Oct 2025 at 17:48, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 10/9/25 18:43, Neil Armstrong wrote:
>>> On 10/9/25 14:28, Simon Glass wrote:
>>>> Hi Neil,
>>>>
>>>> On Thu, 9 Oct 2025 at 05:54, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>>
>>>>> On 10/9/25 13:16, Simon Glass wrote:
>>>>>> Hi Neil,
>>>>>>
>>>>>> On Thu, 9 Oct 2025 at 02:18, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 10/9/25 02:25, Simon Glass wrote:
>>>>>>>> Hi Neil,
>>>>>>>>
>>>>>>>> On Wed, 8 Oct 2025 at 09:31, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>>>>>>
>>>>>>>>> Let's introduce the Interconnect subsystem based on the Linux framework
>>>>>>>>> which is used to vote for bandwidth across multiple SoC busses.
>>>>>>>>>
>>>>>>>>> Each bus endpoints are materialised as "nodes" which are linked together,
>>>>>>>>> and the DT will specify a pair of nodes to enable and set a bandwidth
>>>>>>>>> on the route between those endpoints.
>>>>>>>>>
>>>>>>>>> The hardware resources that provide those nodes and provides the way
>>>>>>>>> to vote for the bandwidth are called "providers".
>>>>>>>>>
>>>>>>>>> The Interconnect uclass code is heavily based on the Linux one, with
>>>>>>>>> some small differences:
>>>>>>>>> - nodes are allocated as udevices instead of Linux idr_alloc()
>>>>>>>>> - tag management is minimal, only normal xlate is supported
>>>>>>>>> - dynamic IDs is not implemented
>>>>>>>>> - getting nodes states at probe is not implemented
>>>>>>>>> - providers are probed on demand while the nodes links are traversed
>>>>>>>>> - nodes are populated on bind
>>>>>>>>>
>>>>>>>>> Fully tested with associated DM test suite.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>>>> ---
>>>>>>>>>      drivers/Kconfig                            |   2 +
>>>>>>>>>      drivers/Makefile                           |   1 +
>>>>>>>>>      drivers/interconnect/Kconfig               |  10 +
>>>>>>>>>      drivers/interconnect/Makefile              |   6 +
>>>>>>>>>      drivers/interconnect/interconnect-uclass.c | 548 +++++++++++++++++++++++++++++
>>>>>>>>>      include/dm/uclass-id.h                     |   2 +
>>>>>>>>>      include/interconnect-uclass.h              |  74 ++++
>>>>>>>>>      include/interconnect.h                     |  81 +++++
>>>>>>>>>      8 files changed, 724 insertions(+)
>>>>>>>>
>>>>>>>> 'interconnect' is such a long and vague word :-)
>>>>>>>
>>>>>>> I didn't chose the name => https://docs.kernel.org/driver-api/interconnect.html
>>>>>>>
>>>>>>> I don't see why we should take a different name in U-Boot.
>>>>>>>
>>>>>>> But I can definitely use "Generic System Interconnect" in the documentation
>>>>>>> and commit messages if it's clearer.
>>>>>>
>>>>>> Yes, we should use the same name. Docs can help.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> There seems to be a piece missing here. The uclass should have
>>>>>>>> operations, so that it makes sense for different drivers to implement
>>>>>>>> the methods. I see some there, but also a lot of direct calls from the
>>>>>>>> test to sandbox. I see quite a few functions which lack a struct
>>>>>>>> udevice * - I suspect I am missing something?
>>>>>>>>
>>>>>>>> We normally have a ..._get_ops() macro in the uclass header. Also we
>>>>>>>> normally have stub functions which get the ops and call the function.
>>>>>>>>
>>>>>>>> I see code to remove children, but driver model does this
>>>>>>>> automatically[1]. Same with bind(). If there is a bug in this, can you
>>>>>>>> give a few details, or ideally a test case?
>>>>>>>
>>>>>>> All of this is present and well thought, I went into multiple designs:
>>>>>>> - interconnect uclass provides ops -> interconnect_ops, icc_node doesn't
>>>>>>>       provide any ops since they are just internal objects
>>>>>>> - there's only a single direct call to the sandbox driver to get the
>>>>>>>       setting resulting of the aggregate() & set() op calls, this is purely for
>>>>>>>       validation of the calculations, the sandbox-interconnect-test only uses
>>>>>>>       the public inteconnect.h API
>>>>>>
>>>>>> OK, I missed that.
>>>>>>
>>>>>>> - For the lack of udevice, it's because I did use the same interconnect API which
>>>>>>>       return a "icc_path" private structure which contains a set of interconnect
>>>>>>>       nodes which forms path across the different providers.
>>>>>>
>>>>>> We do a similar think with clk, although the function signature is
>>>>>> different in U-Boot from Linux.
>>>>>>
>>>>>> I assume the caller would be a driver? If so, passing in a struct
>>>>>> icc_path * might be more efficient than using malloc() each time.
>>>>>
>>>>> I'm not against that but the size of icc_path depends on it's size:
>>>>>
>>>>> +struct icc_path {
>>>>> +       size_t num_nodes;
>>>>> +       struct icc_req reqs[];
>>>>> +};
>>>>>
>>>>> So we would still need to alloc the reqs anyway and expose the internals
>>>>> with no benefits.
>>>>
>>>> Indeed. Sometimes in U-Boot we use fixed sizes to avoid realloc(), but
>>>> I'm not sure if it makes sense here.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>       Setting a bandwidth on a node is meaningless, same for interconnect providers,
>>>>>>>       this is why we set a bandwidth on a set of nodes, which get aggregated with the
>>>>>>>       other path votes from other devices.
>>>>>>>
>>>>>>>       The key here is the "nodes" which are subdevices of interconnect providers
>>>>>>>       created at bind time, and gets referenced in icc_path objects.
>>>>>>>
>>>>>>>       I made sure we can't remove either interconnect devices or icc_node devices
>>>>>>>       if they are still referenced in an active icc_path.
>>>>>>
>>>>>> OK
>>>>>>
>>>>>>>       This is the reason of the device_remove() & device_unbind() calls in the test
>>>>>>>       to make sure we're not left with dangling pointers to non-existent icc_node
>>>>>>>       and providers devices.
>>>>>>
>>>>>> The specific code is this:
>>>>>>
>>>>>> +       device_foreach_child(pos, dev) {
>>>>>> +               debug("%s(pos=%s)\n", __func__, pos->name);
>>>>>> +               ret = device_remove(pos, DM_REMOVE_NORMAL);
>>>>>> +               if (ret)
>>>>>> +                       return ret;
>>>>>> +       }
>>>>>>
>>>>>> This is in the pre_remove() method. But if you just remove that code,
>>>>>> doesn't driver model remove the children anyway?
>>>>>
>>>>> No it only removes the children from the same driver:
>>>>> =============><=====================
>>>>> int device_chld_remove(struct udevice *dev, struct driver *drv,
>>>>>                          uint flags)
>>>>> {
>>>>>
>>>>> <snip>
>>>>>
>>>>>           device_foreach_child_safe(pos, n, dev) {
>>>>>                   int ret;
>>>>>
>>>>>                   if (drv && (pos->driver != drv))
>>>>>                           continue;
>>>>> =============><=====================
>>>>> Same for unbind.
>>>>>
>>>>> Added in https://lists.denx.de/pipermail/u-boot/2018-June/332597.html with the bind/unbind command.
>>>>
>>>> Ick, that is a bug.
>>>>
>>>>>
>>>>> So perhaps I'm doing something unintended here, I was
>>>>> also expecting removing/unbinding a device would remove all the
>>>>> childs whatever the uclass.
>>>>
>>>> Yes, it should be fixed.
>>>
>>> I guess it should be fixed and a test case added.
>>>
>>> Should I handle this ?
>>
>> Wait the code is right, but still it doesn't work properly.
>>
>> I'll investigate further to understand.
> 
> OK...I'm not sure what that patch was about, but if the command needs
> to work that way you could create a new function, e.g.
> device_remove_by_drv() which only removes things for particular
> drivers?

Yeah my bad, it works as intended, I did a bad iteration where the parent
was wrong and it didn't work, I can remove everything and it works fine.

Neil

> 
> Regards,
> Simon

