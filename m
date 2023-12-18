Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D84C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 892D0871CD;
	Mon, 18 Dec 2023 16:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yaxI0NMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF8B86FF7; Mon, 18 Dec 2023 16:37:45 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F7A8746C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d1bcd93b0so5522815e9.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702913863; x=1703518663; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=p8VllhJS+hyJ3Ze+DPb43lnuarJy6P8W8HSQJReWTXs=;
 b=yaxI0NMiINpw0meBucdU4l8wC/x03r6z9RWmpFxOOxRsmEnQmt5Ttt1+aeFUAOE7/l
 5kYgtizYNowG+e0JQk98N9fKsUUzFX54BS2u2wv9g1srnWG/wBogjzdj/pUO37Fwb2EA
 n1T3H8Rb75NZpLP6M3Mx7miVWh6KrJqqaiwZefI1MZQZo0cgbiugHp3/l6S7mBt49Ipf
 WQQP380C+++x1wNVkQ8wa5qsAMPbF7W5KBHLJ4K7M7/pwSMyhKbWwVvBP4TaohoOOEEK
 ooWPhSYhMYui7m7YY/qSThbLN2INOi+drTGPjgcFLrCMX+LS6yPs6I97XDbMQczfxtIH
 3uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702913863; x=1703518663;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=p8VllhJS+hyJ3Ze+DPb43lnuarJy6P8W8HSQJReWTXs=;
 b=d45IKcMSduESWrKG0OhzIDN/YINIKElyRrcC72/Sq0/4py4DYYpKx/uDQM0PA5w0JX
 0oWHGnHAH0p9unsdKrXXdClmWrs1dYJxjuksgOhtb/ufC6Ic+Ycj/Tr2KvuiVRWnspRM
 +uyIyUGyIZlfiXWBkMRwV4ga7OBuUg7vwUgWr2WoZVnQstRCfebeuD6JQzjGt33r1frr
 g1Pxjnz77jVcyM1sbgnn/wmS0OVQabnxjhZBVTrvfCNNuy54WI8KVCT+w+gmDNJ7VCqy
 9ZsnYZeR7h9tIO9nYqcE2Yf8m4oPuEY+A3vsJfOjkkswToWBda+JLKEuw0oljU4Dre05
 9vfw==
X-Gm-Message-State: AOJu0YyQW32fjO7HoxR0eDtcfLlfoLrYcPY/QFRrI/+Sq1xMg7B1nHG6
 7D475OQlfO+lee0VNvlN3MkEGg==
X-Google-Smtp-Source: AGHT+IE2QRunw7NDd0czn1d8SqFEiPVXK9vvZxJfsoWJ69evREU426ME62xILu97ckcAB6SePXDssQ==
X-Received: by 2002:a05:600c:1392:b0:40c:55c4:45ec with SMTP id
 u18-20020a05600c139200b0040c55c445ecmr6713093wmf.46.1702913863204; 
 Mon, 18 Dec 2023 07:37:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b425:da5d:c0cf:a505?
 ([2a01:e0a:982:cbb0:b425:da5d:c0cf:a505])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c354100b0040c411da99csm36987121wmq.48.2023.12.18.07.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 07:37:42 -0800 (PST)
Message-ID: <0b7d6cd7-4248-47d7-81c8-7466177d5172@linaro.org>
Date: Mon, 18 Dec 2023 16:37:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Content-Language: en-US, fr
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com,
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
 <06036b6f-70b8-4b80-823d-d9716cbbf160@linaro.org>
 <CAPnjgZ2wcmGOjbVdNCyzSWNGzBPjPqcjdVcbPu8J2wadnxFRrQ@mail.gmail.com>
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
In-Reply-To: <CAPnjgZ2wcmGOjbVdNCyzSWNGzBPjPqcjdVcbPu8J2wadnxFRrQ@mail.gmail.com>
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

Hi,

On 18/12/2023 16:01, Simon Glass wrote:
> Hi Neil,
> 
> On Mon, 18 Dec 2023 at 02:54, <neil.armstrong@linaro.org> wrote:
>>
>> On 17/12/2023 19:41, Tom Rini wrote:
>>> On Sat, Dec 16, 2023 at 11:46:18AM -0700, Simon Glass wrote:
>>>> Hi Tom,
>>>>
>>>> On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
>>>>>
> [..]
> 
>>> And my point with the above is that other SoC maintainers (Neil, for
>>> amlogic) have said (paraphrasing) he does not want to do N smbios node
>>> patches. Which is why Ilias' patch is if not 1000% correct, it's Good
>>> Enough and will, if it's really a problem to have all lower case
>>> information displayed, spur people to see providing that information as
>>> a real problem that needs to be solved. Or it will be seen as good
>>> enough.
>>>
>>
>> If some platforms requires a more "correct" smbios dataset, then they're
>> welcome adding the required smbios node, and it's perfectly understandable,
>> but for the other community-maintained platforms we need some valid fallback
>> data otherwise they'll be de facto excluded from some tools for no valid reasons.
> 
> Do you know which tools require SMBIOS tables? I found sos and another
> Redhat one.

SMBIOS data is translated into dmi informations in Linux, and a little
lookup in GitHub gives 6.4K files using something from /sys/devices/virtual/dmi/id/,
and by very commonly used tools like lshw and probably fwupd.

Neil

> 
> Regards,
> Simon

