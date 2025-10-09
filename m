Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599A0CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 16:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1FB841EF;
	Thu,  9 Oct 2025 18:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oPJ3AkUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B03842E6; Thu,  9 Oct 2025 18:43:51 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D62840F5
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 18:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso8516585e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028228; x=1760633028; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=P+Sm/OIwTo7X182698+/qb+bwJ38K/Y/IT0TdL6j3Wg=;
 b=oPJ3AkUKsrN72yW/tlwlC6HieYDc9gWUkHRptNB+A1qW3A9cIKsl/r77aixu6zHXEh
 NZUYTXYZ0d4nXAf9JGyTKqsQvTsCDzConx0MoH8VMUqPdZbep6DEnrYbsGua7UCXdLqY
 W0qOe+rydvg6eaKDfIbpfEOgOoDLYf+Mmc/MIIFlX8E9c3GkUhZLt+h2sk44qggi2yee
 FChYIDPJdiZygxFuXwRDa6040+NJ9S3I14PXs69G/GEtK8Qu6QIWwDKKKdNX+7z54CW9
 cgNvob30zjkzRJOQ4mrkEn5EDf2yQn/qHdc36qYY7cTvyOAwgYcPRn6sT25Ak47HDr5A
 O+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028228; x=1760633028;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=P+Sm/OIwTo7X182698+/qb+bwJ38K/Y/IT0TdL6j3Wg=;
 b=aZFtxmMTH08+/PgJai74EijVZ0OHWL/y9QM3zb7KIsKGO1Jyd2Am+7WeeW9VmOfllJ
 07J7o7XeBo7DlFV33dEG+W1wVoeWh4ZwfGe8Ut6efymdjkF4CTxLYGiWqr7ISMKN1kHU
 fUmG/fo/zzgSXUApv0XwHanfEggUhVRS+kzitKC8XSH9T3yeKcI9d/S/HxRrpk2IqTnL
 NF8KAgq6hdwxiXGQacVFIjYUkKuHHXfmr0berWKH4AciDYq4prVyIW7Fces1H+N3Fl+3
 FRwQXKEurTkUIRlHlY2YdhrYJUmCWasjSsDJHaPoWkF805mJEThlkSGm+JGIhImcuO86
 SzYA==
X-Gm-Message-State: AOJu0Yzz52UWcaeq+T8dTmch80IwTEkcP5aFvZizD/na6E7rHc3xMiis
 yJc5h1ilUAg7xad1D1nbFqJZll8tgYV6UyrswIbY9gEnRdl2mSSCw+3kJqk8seltNU1mDEYD2EM
 +lYNd
X-Gm-Gg: ASbGncuYFw5TjAu6LrQc+RvTol33oOrFt/VJIGL2wInFWDlBslpOO8wPn4DEio5E6T4
 ppxkW1/3FDMgTjr/cOUIYEghqxpmUlXSm6ffP3XwxrIgJgDG3xeL2UQKCfA6+ekPlqU9Op1G+gp
 rsBRkBXUs1hCQwb6MSjK8h0KKFqNgmwqQY1taCVoZVrVnOCx4wYL+V8nBE+rf9ON8doodbuyUZn
 Sayf22lF+LmEeKlII94McwWPm20D8DdfXmotiE1R+bNlKJora1TJyR4QGsIlvOXU5HydBxFhfXP
 E1wqoQOFjxbn0oprwMz1IfV1GZ5rVusfir3H6YNChu/XSfHyvralnaQTmMYi8Gdi6WySYjPPYzm
 TGXmBxYrjRimhPfwWnKOkAGZ7ugIhXE92jFP6km3Tha1BzSFq2qa7hLDLbc8lO0HS9XXzSVKQ5x
 GshtXr7FNS8dbQHa/80ppwLO7U4S8=
X-Google-Smtp-Source: AGHT+IG9MivdNdjqHRbBwamBsyJnGHmSlQPQpDmDwzbgziwmZ2a3GUD1AgqjbFGIr6nCsWIB9XdNrA==
X-Received: by 2002:a05:6000:1889:b0:410:3a4f:12c8 with SMTP id
 ffacd0b85a97d-42666ab888emr5051653f8f.20.1760028227470; 
 Thu, 09 Oct 2025 09:43:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee?
 ([2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426cd96f68csm166443f8f.29.2025.10.09.09.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:43:47 -0700 (PDT)
Message-ID: <c6694467-8efb-404d-862d-4df62dd60db6@linaro.org>
Date: Thu, 9 Oct 2025 18:43:46 +0200
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
In-Reply-To: <CAFLszTi9omZ372BocVZ39nHbgofM5in=Nz4yvCXrHVEgoJPiQg@mail.gmail.com>
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

On 10/9/25 14:28, Simon Glass wrote:
> Hi Neil,
> 
> On Thu, 9 Oct 2025 at 05:54, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 10/9/25 13:16, Simon Glass wrote:
>>> Hi Neil,
>>>
>>> On Thu, 9 Oct 2025 at 02:18, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 10/9/25 02:25, Simon Glass wrote:
>>>>> Hi Neil,
>>>>>
>>>>> On Wed, 8 Oct 2025 at 09:31, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>>>
>>>>>> Let's introduce the Interconnect subsystem based on the Linux framework
>>>>>> which is used to vote for bandwidth across multiple SoC busses.
>>>>>>
>>>>>> Each bus endpoints are materialised as "nodes" which are linked together,
>>>>>> and the DT will specify a pair of nodes to enable and set a bandwidth
>>>>>> on the route between those endpoints.
>>>>>>
>>>>>> The hardware resources that provide those nodes and provides the way
>>>>>> to vote for the bandwidth are called "providers".
>>>>>>
>>>>>> The Interconnect uclass code is heavily based on the Linux one, with
>>>>>> some small differences:
>>>>>> - nodes are allocated as udevices instead of Linux idr_alloc()
>>>>>> - tag management is minimal, only normal xlate is supported
>>>>>> - dynamic IDs is not implemented
>>>>>> - getting nodes states at probe is not implemented
>>>>>> - providers are probed on demand while the nodes links are traversed
>>>>>> - nodes are populated on bind
>>>>>>
>>>>>> Fully tested with associated DM test suite.
>>>>>>
>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> ---
>>>>>>     drivers/Kconfig                            |   2 +
>>>>>>     drivers/Makefile                           |   1 +
>>>>>>     drivers/interconnect/Kconfig               |  10 +
>>>>>>     drivers/interconnect/Makefile              |   6 +
>>>>>>     drivers/interconnect/interconnect-uclass.c | 548 +++++++++++++++++++++++++++++
>>>>>>     include/dm/uclass-id.h                     |   2 +
>>>>>>     include/interconnect-uclass.h              |  74 ++++
>>>>>>     include/interconnect.h                     |  81 +++++
>>>>>>     8 files changed, 724 insertions(+)
>>>>>
>>>>> 'interconnect' is such a long and vague word :-)
>>>>
>>>> I didn't chose the name => https://docs.kernel.org/driver-api/interconnect.html
>>>>
>>>> I don't see why we should take a different name in U-Boot.
>>>>
>>>> But I can definitely use "Generic System Interconnect" in the documentation
>>>> and commit messages if it's clearer.
>>>
>>> Yes, we should use the same name. Docs can help.
>>>
>>>>
>>>>>
>>>>> There seems to be a piece missing here. The uclass should have
>>>>> operations, so that it makes sense for different drivers to implement
>>>>> the methods. I see some there, but also a lot of direct calls from the
>>>>> test to sandbox. I see quite a few functions which lack a struct
>>>>> udevice * - I suspect I am missing something?
>>>>>
>>>>> We normally have a ..._get_ops() macro in the uclass header. Also we
>>>>> normally have stub functions which get the ops and call the function.
>>>>>
>>>>> I see code to remove children, but driver model does this
>>>>> automatically[1]. Same with bind(). If there is a bug in this, can you
>>>>> give a few details, or ideally a test case?
>>>>
>>>> All of this is present and well thought, I went into multiple designs:
>>>> - interconnect uclass provides ops -> interconnect_ops, icc_node doesn't
>>>>      provide any ops since they are just internal objects
>>>> - there's only a single direct call to the sandbox driver to get the
>>>>      setting resulting of the aggregate() & set() op calls, this is purely for
>>>>      validation of the calculations, the sandbox-interconnect-test only uses
>>>>      the public inteconnect.h API
>>>
>>> OK, I missed that.
>>>
>>>> - For the lack of udevice, it's because I did use the same interconnect API which
>>>>      return a "icc_path" private structure which contains a set of interconnect
>>>>      nodes which forms path across the different providers.
>>>
>>> We do a similar think with clk, although the function signature is
>>> different in U-Boot from Linux.
>>>
>>> I assume the caller would be a driver? If so, passing in a struct
>>> icc_path * might be more efficient than using malloc() each time.
>>
>> I'm not against that but the size of icc_path depends on it's size:
>>
>> +struct icc_path {
>> +       size_t num_nodes;
>> +       struct icc_req reqs[];
>> +};
>>
>> So we would still need to alloc the reqs anyway and expose the internals
>> with no benefits.
> 
> Indeed. Sometimes in U-Boot we use fixed sizes to avoid realloc(), but
> I'm not sure if it makes sense here.
> 
>>
>>>
>>>>
>>>>      Setting a bandwidth on a node is meaningless, same for interconnect providers,
>>>>      this is why we set a bandwidth on a set of nodes, which get aggregated with the
>>>>      other path votes from other devices.
>>>>
>>>>      The key here is the "nodes" which are subdevices of interconnect providers
>>>>      created at bind time, and gets referenced in icc_path objects.
>>>>
>>>>      I made sure we can't remove either interconnect devices or icc_node devices
>>>>      if they are still referenced in an active icc_path.
>>>
>>> OK
>>>
>>>>      This is the reason of the device_remove() & device_unbind() calls in the test
>>>>      to make sure we're not left with dangling pointers to non-existent icc_node
>>>>      and providers devices.
>>>
>>> The specific code is this:
>>>
>>> +       device_foreach_child(pos, dev) {
>>> +               debug("%s(pos=%s)\n", __func__, pos->name);
>>> +               ret = device_remove(pos, DM_REMOVE_NORMAL);
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
>>>
>>> This is in the pre_remove() method. But if you just remove that code,
>>> doesn't driver model remove the children anyway?
>>
>> No it only removes the children from the same driver:
>> =============><=====================
>> int device_chld_remove(struct udevice *dev, struct driver *drv,
>>                         uint flags)
>> {
>>
>> <snip>
>>
>>          device_foreach_child_safe(pos, n, dev) {
>>                  int ret;
>>
>>                  if (drv && (pos->driver != drv))
>>                          continue;
>> =============><=====================
>> Same for unbind.
>>
>> Added in https://lists.denx.de/pipermail/u-boot/2018-June/332597.html with the bind/unbind command.
> 
> Ick, that is a bug.
> 
>>
>> So perhaps I'm doing something unintended here, I was
>> also expecting removing/unbinding a device would remove all the
>> childs whatever the uclass.
> 
> Yes, it should be fixed.

I guess it should be fixed and a test case added.

Should I handle this ?

Neil

> 
> Regards,
> Simon
> 
>>
>> Neil
>>
>>>
>>>>
>>>> Note I won't re-invent a new API here, the api in interconnect.h is fine and
>>>> works well, I made sure to use all U-Boot driver model offers to avoir allocating
>>>> random objects myself, and keep the interconnect core functions strictly
>>>> identical to the kernel, making it:
>>>> - well integrated in DM (on-demand probe, nodes as DM devices)
>>>> - resulting with the same results as in Linux
>>>> - using the same API
>>>> - easy to sync back from Linux
>>>> - easy to port a driver from Linux
>>>
>>> Yes that sounds good.
>>>
>>>>
>>>>>
>>>>> Also, please can you add:
>>>>>
>>>>> - comments to the header file, at least
>>>>> - something in doc/
>>>>> - a command to list things / provide information
>>>>
>>>> Yep, I'll add those.
>>>
>>> OK thanks.
>>>
>>>>
>>>> Thanks,
>>>> Neil
>>>>
>>>>>
>>>>> Great to see the automated tests!
>>>>>
>>>>> Regards,
>>>>> Simon
>>>>>
>>>>> [1] https://docs.u-boot.org/en/latest/develop/driver-model/design.html#removal-stage
>>>>
>>>
>>> Regards,
>>> Simon
>>

