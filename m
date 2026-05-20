Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53503CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 12:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81BC68470E;
	Wed, 20 May 2026 14:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yw9yU/5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9328470E; Wed, 20 May 2026 14:47:50 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A05CF846E6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 14:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso46756845e9.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779281266; x=1779886066; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2uXkcfEiJwmIgQykFlrWZZPM9hLUJyCbdLE+3XLDzjA=;
 b=Yw9yU/5ebpodl0m/+xxtEfufd+zB1w+aZPxe/jqHresdA9pH4YzXVUvW4GmIunQrIP
 tBQHuWeUcXUCOVdg3Ynnmgn0z7qj1LVxdam7wv2C1gSst0/9BOWOmjoCXxqguF7oqjn3
 gcLWB4EzqI4WNEGyln9knG9WcLw4RUrk4862fT8MAjWFSK0LUPxdYoYioMC0LWHBdXnU
 epjlrfQeYw8OCXU42By70lmf5dQuLgEvXzWJc7sxwfwRyG9bLHTe2JZcrpWzF+lYdZPL
 5v8lc/YqFHEIGzNwIqELuuLATge5Zt+B8Qa/c1fbKnNkZ+uK/dKpM9J3hg5SuzhLT19G
 y8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779281266; x=1779886066;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2uXkcfEiJwmIgQykFlrWZZPM9hLUJyCbdLE+3XLDzjA=;
 b=IAwxpJfNdOkIVsNHR0CzbUoA5rkeKC3i2NkPVr1KWzZQ0qSezkqfbyVX4uLTyfExj9
 aEVqAbOUFB6XmMLAy73d5EP1z2jqtFW/YWV1uxS2B5CidVDCMZCwiI+zZG+03iUc/2y7
 u4QQW/M7B3wluWjpzFuo1oNGh75uFD+jLOi6iv/C59eZb5n5jtqvz+46fiO9Cg7rsDOS
 eP0AYBlD/aeyWrDwRU+vuqpGfEgdFmJ53GrgxE2WUC6YPfyDHKKL7XkudquFtowtMa82
 ZjC1BBYBpws9yVPc13qH8bmo9kuoDwb1x0aJNrZtCEAmd+0Ro3JPFb7ZAaxWLwKgashz
 Hq7g==
X-Gm-Message-State: AOJu0YxsC05g7Fxq1L+tO0VRoubmrVryhY53HmmK59m+rPpCY1Ie8SzM
 q3TNHcpXz6qBBZs3w+54oz756YG4JiAB5TdXr2rhG22w163JzpPSIs7XNRGBsTQg34DEOPebqf7
 T3iCG
X-Gm-Gg: Acq92OFM1gJuPeK1E1JQC6P8wkI0KW0LX3fn3uD64o2OrK6hbGpKoB8zFy/BM4bs2wi
 fMubTiAUxchQZgib1BQihjUuip/w4mxTAr04BEVJlfPyrwZoHLUOQp/No3QTdBLQvUAnHmH6RwS
 gp5ufGyItpkD+dxg1PYxrpSB5ZNISzsAUBXbTZq45WeHsJLw/aVywgUUkOUncXG+iQ1X+TqgbAQ
 fiviCTCO+g4Wm4jtQxgT+L59T5gRSumApI4WL8THP2tA4421cx5IABG1RdmkSAUkE3BZ5/DugS9
 M2SAECtL4UmcyQRd590e2xpo67NzUHWD31Ty3JJ8a6Tm68CQ6bGV1lU07E04l1LZIFGY9TzZ7Jr
 oqnRm3IRqkWaX/u2XE+XEk53f+4TPFDDOke9YA8A2/2cUwsO8cBbMqj0HtIL3c7TJt+VVM1N6yw
 GvDHcm0X1gFAU9BK0IrWLqnQebamIdY1evsh0PQlYj+H8mVGhShu9gs12whnhRrM02ucwdKn1il
 g==
X-Received: by 2002:a05:600c:a406:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48fe4fa1902mr278462585e9.6.1779281265896; 
 Wed, 20 May 2026 05:47:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dec9:6d:b572:fe67?
 ([2a01:e0a:106d:1080:dec9:6d:b572:fe67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88495sm387898355e9.4.2026.05.20.05.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 05:47:45 -0700 (PDT)
Message-ID: <0b5b81a1-9e17-4523-90ef-aad2bf934115@linaro.org>
Date: Wed, 20 May 2026 14:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: UFS boot and UFS tool
To: Raz <raziebe@gmail.com>
Cc: u-boot@lists.denx.de
References: <CAPB=Z-rjEF5fCXcYWfeskz3W3u16FoW4VN48O-OZTz+fp81Q3A@mail.gmail.com>
 <a97ae4de-3159-4678-ab25-e5ce9ff1e12d@linaro.org>
 <CAPB=Z-rJpjJxPHaFvuvvrPBG6yvr1vjAxzvjBML1bbnqzU8fZQ@mail.gmail.com>
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
In-Reply-To: <CAPB=Z-rJpjJxPHaFvuvvrPBG6yvr1vjAxzvjBML1bbnqzU8fZQ@mail.gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,


On 5/20/26 08:34, Raz wrote:
> There are many commands. ufs luns is a common example.  see patch
> attached please.

Good, the changeset looks sane, please split the whole change into
logical and incremental changes, in the following order for example:
- fixes & typo fixups
- API export
- new API
- initial ufs cmd changes to accept subcommands
- add subcommands

Those commands are nice but I would like a way to "protect" those
so you can't change the LUNs desc accidentally, like perhaps
an intermediate command like "ufs allow-modify-desc" which asks
for a confirmation in order to call other commands which can
modify the descriptors.

Thanks,
Neil

> 
> # ufs luns
> | LUN 0       | LUN 1       | LUN 2       | LUN 3       | LUN 4       |
> | 16 MB       | 16 MB       | 4 MB        | 2000 MB     | 80000 MB    |
> 
> On Tue, May 19, 2026 at 6:47 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On 5/19/26 13:53, Raz wrote:
>>> Hey,
>>>
>>> I have added a ufs_tool driver to my U-Boot repository. It extends the
>>> ufs command to provide access to IDNs and flags. Mainly, it allows
>>> creating and listing LUNs.
>>
>> This is something very welcome!
>>
>>>
>>> In addition, I am currently adding UFS functionality to the environment.
>>
>> Which kind of functionalities ?
>>
>>>
>>> 1. Are there any other engineers working on it ?
>>
>> AFAIK no, you're free to send,
>>
>>> 2. What is the procedure of posting a code ? Pull requests or emails ?
>>
>> It's mainly aligned on the Linux practices, you can find the U-Boot particularities in
>> https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-updated-patch-versions
>>
>> If you're unsure about the features implementation, please tag the patches as RFC.
>>
>> Thanks,
>> Neil

