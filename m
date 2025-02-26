Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241DCC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BD281253;
	Wed, 26 Feb 2025 17:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k2gP4SGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A43F811DF; Wed, 26 Feb 2025 17:27:26 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CABD8128D
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f2b7ce2f3so4996611f8f.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740587244; x=1741192044; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6dacbaLKdGI3TES6WhTZW2VCWXjsq9H82fy7RxrFLkI=;
 b=k2gP4SGitVjVl9Szaqphw26yA5Y1olRUN9JjrMrHoW+QKCxavHrDhld4yuS70qYuCZ
 L0DRfltkVSgxZG6mwIJqolbgG1JqEJTUJl9pFd9hop4uYarv+xen3MSUc4Lx0kWmW46C
 CcbPRxIOeDIa6Wq/ViUy+DDsq7y4uVqSCwPM3X0ZkWye4T9rk/tR9CJUEb5OR0EwrSIK
 lB+e/VKremAPYVGIA+4ru8kmo5eW2K0TfVKvpl+X2XKL1OWh2Pn8EqPsIBHPT1ouvnR8
 DmTMm6MdAbZ7O974h66+YI0XnGMZFFyjZ5usnXuuO0EBTVEFzfVpMhlJpsSf7ebNxXaD
 5/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587244; x=1741192044;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6dacbaLKdGI3TES6WhTZW2VCWXjsq9H82fy7RxrFLkI=;
 b=Tz2vbgbBE5VJL9+VDrgiATlaCE+fIsq5DTL5WyCIoND2GDrrEaIDVfUZPO/pfntO94
 NFxDT+p6v9yvOPO3CkgFOys20CpGIX+v0Slono52lW9MH71OrZkIrSlCkOZtrrXVONx9
 P3RpIdh1wd9eeIJo0beM/JsRTqa1DqwjycGlGF2nyfZIpmiumZos8YLYWnbua/a9Rm/N
 ScswvSwQ6n7kgNd52Vb6Ubo8S/S7jD4IQ3W1XQQaBKsCpID30DTvkzIU+E+Mqlvc/9k/
 Pm66p1VAYwPwprbqQwR+K1jZCTXLH8QEQt38QGmNRxr+NpbriEdCc392s7z77FytPW8f
 E/VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXlGFEobAsJKQkz46BYb2Ckel8XG4xD4NzZ01RiC/WKmT/wHWKAPtoknVbPH81aNC946lcvYw=@lists.denx.de
X-Gm-Message-State: AOJu0YxxbIbDrxgwBGt3hgyNNugUnqudR2TQ1NgRv0eulKn27VagpjIZ
 Wo1FVuPpF/GcLpxVVXiaLpVWhWfwl4cql3BPTyBlOeelDn3FLzYgj5P5fX4/tZk=
X-Gm-Gg: ASbGncvVFuV3f3k7fShCsA/YIxX9rMCQTauNF2CtiZspbiqwGSvJkOMrL4K2uz5mx05
 6vaewE+DCxe/EF60Ukuv4nCz5+tEzmhL+C8sjkSwl45FbOVw0nKW+PuHBrtwZ5Mj8Sx7yDnCI38
 qPXMdptJ/sdw3XUY7LLi78MNc15s5dKmJ9BuF0hyFYXdLeAeMYmYwNRZAZkeRDiky8C2ZqqM7D/
 BReZPC7cvPJDJdX8nIvKiPfLHlMJSrkr4LitcKummEsiK5xmbb+xrjAaqisi35M5oGwAbgQbN9t
 euw6RIsxom+cESkQ/ki+KHmlbtl7CgouAyudC50CD6wft8CK/c5rEr7MQwDk9xAWoSIPZqhMbTc
 DQTw=
X-Google-Smtp-Source: AGHT+IEwbC8CAeL+W0e8tWdesMqXrEYNBPpvZYGW1to9pD6pRTIUUE6eu4p9WsgOFhxK4P8sBLhmUg==
X-Received: by 2002:a05:6000:18a2:b0:38f:50bd:ad11 with SMTP id
 ffacd0b85a97d-38f707840afmr17542742f8f.5.1740587243748; 
 Wed, 26 Feb 2025 08:27:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ee49:80db:c8ef:c826?
 ([2a01:e0a:982:cbb0:ee49:80db:c8ef:c826])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e7214sm6142017f8f.75.2025.02.26.08.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 08:27:23 -0800 (PST)
Message-ID: <6d3a3c32-f657-4bae-ab7a-81c32aa0d2df@linaro.org>
Date: Wed, 26 Feb 2025 17:27:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/2] rng: msm: support newer SoCs
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
 <9094cfe6-34ae-42cb-84c1-6965121d1a19@linaro.org>
 <20250226142134.GG2640854@bill-the-cat>
 <20250226142248.GH2640854@bill-the-cat>
 <034c875c-0ed9-47d0-aebb-41413b5b1651@linaro.org>
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
In-Reply-To: <034c875c-0ed9-47d0-aebb-41413b5b1651@linaro.org>
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

On 26/02/2025 15:44, Caleb Connolly wrote:
> 
> 
> On 2/26/25 14:22, Tom Rini wrote:
>> On Wed, Feb 26, 2025 at 08:21:34AM -0600, Tom Rini wrote:
>>> On Wed, Feb 26, 2025 at 02:07:28PM +0100, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 25/11/2024 18:12, Neil Armstrong wrote:
>>>>> Add support for RNG on newer SoCs which shares the
>>>>> RNG hardware between different Execution Environments (EE).
>>>>>
>>>>> Also enable it by default to fill KASL seed when running Linux.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>> Neil Armstrong (2):
>>>>>         rng: msm: add support for newer Qualcomm hwrandom IPs
>>>>>         configs: qcom_defconfig: enable RNG driver and command
>>>>>
>>>>>    configs/qcom_defconfig |  3 +++
>>>>>    drivers/rng/msm_rng.c  | 13 ++++++++++++-
>>>>>    2 files changed, 15 insertions(+), 1 deletion(-)
>>>>> ---
>>>>> base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
>>>>> change-id: 20241125-topic-sm8x50-rng-714cd0012391
>>>>>
>>>>> Best regards,
>>>>
>>>> Gentle ping, who's supposed to take this ?
>>>
>>> It's amlogic, you can pick it up.
>>
>> Sigh, sorry, too early. Caleb usually sends the PR for Qualcomm but if
>> the two of you agree you can also send one.
> 
> These are already upstream and marked accepted on patchwork afaict?
> 
> ; g ls -1 a1efde55bbaf
> a1efde55bbaf rng: msm: add support for newer Qualcomm hwrandom IPs
> 
> ; g tag --contains a1efde55bbaf
> v2025.04-rc1
> v2025.04-rc2
> v2025.04-rc3
> 
> Looks like it got missed on the thanks list (did i totally forget to run b4 ty?)

Oh super cool, I forgot to check !

Thanks,
Neil

> 
> Kind regards,
> 
>>
> 

