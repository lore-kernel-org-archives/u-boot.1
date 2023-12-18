Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD257C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 09:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD4F87D31;
	Mon, 18 Dec 2023 10:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HMHJx/HA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A4287D31; Mon, 18 Dec 2023 10:54:37 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F158C87DDB
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33668cdb982so531712f8f.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702893274; x=1703498074; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=SXy89cPJlqsZx/xXSRs6rpsjGjKxXjWRtAvDFE45onM=;
 b=HMHJx/HAxVqNpuM6L1IluW79cOOCFlMyTeAIulGWykD4MyY3g2wlTdk8jgE22qSmq6
 fpqpO0Xy3+PDsWLyhbopdPswwnFxgaOpcq7Ho0yrEyfZHBuzp+hN2tGLgtD41DLQ7zS7
 xZI1h0GMYAim1GSkRWChWYT69z3axxwox/s/2B6ZExkVp+ucuxOwa4EqxqIQhV1Qx7XG
 tfyZ84IbjJbuuN5EXlCj4XrG5pybdtZ890dsZ0zsj29i/+LjDF7EEp2A7Qko+GXkl7bA
 GY4bzLCYvSJbOK5tQR8Ofyn37G3h9O1UIpgodnAvAsOBr/DQ8vdQ7eNDTS/mYyPaYMoq
 vLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702893274; x=1703498074;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SXy89cPJlqsZx/xXSRs6rpsjGjKxXjWRtAvDFE45onM=;
 b=h0KQ67gtUllvAS8lFdWy5kCSVVffbsUyBNNUOrNsqshVWZCuzdixkfmy5WVu5ZNYF6
 uskSs3Rjk/kLCXoufv6F2ZuPWSuoYIgI5vxQXUL78GB8IL5q7nWpWbUROj1eCBFN3/OE
 KbXCpaOuJvpahXLMoBjawjdVPd/nk0OhQrHbj7hpaFQ3RsoflcFAS3dLKAUmQaigKldD
 7Pl8Xvm78Eh3tFt6XFPqkXAa3Z+M6y9MEEJgNunx0b87vKIDviHHcQ54SNdZdcW8ah32
 /YZr15a3YL2ICBSPoAbOo+pLwF3AOmMTCYgPWC33YvdwvlbXWaZF7C0Wj/4gKqHR5CUf
 LARQ==
X-Gm-Message-State: AOJu0YzoAxMeKJmss9Qt1iwquaghSXXOPlzUL3i0dVJyY5r4CYRhqEC0
 WhXw1QgRLG1SgZ+Zlk/+RNw/pw==
X-Google-Smtp-Source: AGHT+IF+b0ONrS7s/t0CoIh0vK2cFQcwHwzLyAU+rqETs9yvDyOjvbVFpsPG6LVaIKBJXkLz5wmCCg==
X-Received: by 2002:adf:ebc7:0:b0:333:4913:c465 with SMTP id
 v7-20020adfebc7000000b003334913c465mr7621641wrn.102.1702893274102; 
 Mon, 18 Dec 2023 01:54:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b425:da5d:c0cf:a505?
 ([2a01:e0a:982:cbb0:b425:da5d:c0cf:a505])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a056000180200b003366d6b0df6sm522171wrh.13.2023.12.18.01.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 01:54:33 -0800 (PST)
Message-ID: <06036b6f-70b8-4b80-823d-d9716cbbf160@linaro.org>
Date: Mon, 18 Dec 2023 10:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Content-Language: en-US, fr
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 u-boot@lists.denx.de
References: <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
 <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
 <20231213230545.GM2513409@bill-the-cat>
 <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
 <20231214131139.GY2513409@bill-the-cat>
 <CAPnjgZ17b7sZX-dey5mdXJJ17g5ho_U2UZkawyFYU19R-gidhQ@mail.gmail.com>
 <20231217184100.GC2513409@bill-the-cat>
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
Organization: Linaro Developer Services
In-Reply-To: <20231217184100.GC2513409@bill-the-cat>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 17/12/2023 19:41, Tom Rini wrote:
> On Sat, Dec 16, 2023 at 11:46:18AM -0700, Simon Glass wrote:
>> Hi Tom,
>>
>> On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Wed, Dec 13, 2023 at 08:19:11PM -0700, Simon Glass wrote:
>>>
>>> [snip]
>>>> The new DT nodes / SMBIOS binding [1] allows for the correct
>>>> information to be provided, though.
>>> [snip]
>>>> [1] https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings/sysinfo/smbios.txt
>>>
>>> I think the only feedback I can give on your message here is to please
>>> go upstream that binding, and then we can see what to do afterwards.
>>
>> I am still tearing my hair out waiting for the reserved-memory and
>> binman patches to be accepted. Every few weeks there is another
>> comment, but no action. Rob seems to be the only one engaged.
>>
>> Perhaps I should do a conference talk about what is wrong with DT?
> 
> Perhaps.
> 
>> This is my experience so far:
>>
>> - there is no urgency to apply anything
>> - no one wins acclaim for applying a patch
>> - everyone complains later if a patch is applied that they didn't agree with
>> - people chime in wanting to understand the use case, but don't/can't/won't
>> - any sort of expressed doubt results in delay
>> - maintainers hope that the submitter will lose interest and go away
>> - not enough people add review tags, even if they look at it
>>     ... because they are worried about looking bad to others on the ML

I agree some subsystems are not easy to deal with, but it's not the case for most of them (Qcom, Amlogic, TI, ST...),
and I think it's the case of some other Linux subsystems, and we all know it's
an issue but I do not have the power to solve that, so yes please do
a conference talk but not only about DT because it's simply not true.

>>
>> I would be happy to discuss how to improve matters, but that is what I see.
>>
>> Anyway, the lowest-hanging fruit at present is the U-Boot /options
>> stuff. I was hoping someone else would step up to clean it up. There
>> should be no impediment.
> 
> And my point with the above is that other SoC maintainers (Neil, for
> amlogic) have said (paraphrasing) he does not want to do N smbios node
> patches. Which is why Ilias' patch is if not 1000% correct, it's Good
> Enough and will, if it's really a problem to have all lower case
> information displayed, spur people to see providing that information as
> a real problem that needs to be solved. Or it will be seen as good
> enough.
> 

If some platforms requires a more "correct" smbios dataset, then they're
welcome adding the required smbios node, and it's perfectly understandable,
but for the other community-maintained platforms we need some valid fallback
data otherwise they'll be de facto excluded from some tools for no valid reasons.

Neil
