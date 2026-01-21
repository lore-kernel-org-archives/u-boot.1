Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD90C4451E
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 11:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF618341A;
	Wed, 21 Jan 2026 12:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bw7ZbJzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0376B83946; Wed, 21 Jan 2026 12:46:35 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A68E83015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so484613f8f.1
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 03:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768995991; x=1769600791; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xkObEXn5ICuY8xdt3jZ+BeRS4lN2H7X1IkucSGLwLtA=;
 b=bw7ZbJzmJ7oBApe7+HlhQGD1HAfzMdJvHk099EKt4dzTUuihxdK/+F+hN1aVKSyBAq
 4HerXwDjFsRbGLn7mHwAsSEcSOQnJUG1VqLKEGW3xRFlxeSqZa5oBOMjCSSOxS6Qr63c
 ibD/o+yl0x8dFWzLqoVVJNODVAalqJdDnGAiI8GpYQcgJP6PR8kTczN84NrusiJLLXVW
 5o8W8yo7kuabK++PKbKGLgoZI5WU3W2P7v/afA0mN7tBNm9ReRo9R9a8QF/ZCYXMEOyU
 rHkAw0See4ykUjVSx3Kt4AWGJVGyXq+AUKP0w+yyQzls2g4CgVw0/FV4vA9Dtqn9m3jT
 BJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768995991; x=1769600791;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkObEXn5ICuY8xdt3jZ+BeRS4lN2H7X1IkucSGLwLtA=;
 b=qlGoTaKptIUbqZ0XHxURK1AQwoaEcb12H/U9PtknGv+zoeu9zLMdp4PgZ73cHWr5RO
 9pvmVdFY/tDyMkflXutKGmTPJAozpTc0F/KAJ8FdWrAPadeUDODglxL8vXJPvBONmIZ+
 BkSMaiqQ0xxm2wO6R3y329rm6R7Qj8JGORhDcWnXIouDiZlQ7z70o/VuIuY4QQkx2xuH
 jnQ7P+wQHxD4yz7AW5empO7oekM0NFffW7n+KxywV9EZMeKqQ7dxNfWjR+JDob27DMqR
 RnrgvYpSIZyE9G/DZlbbj8Z4P8dgWwm9+JmqHM7RfEtvnJ9GSfxn/1rdJPufWl57J43u
 InQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIE2r4149r2/qHYMidG7RfCcIhZNMtVmvfWzjoKCOUHREb8q1nlpc6IMxes8me72hYniJHR6M=@lists.denx.de
X-Gm-Message-State: AOJu0YxIdhZrOxOmSdDJMykTI39o0dbyDSJcYkFxrs77fV3gk0wYD6ev
 YUfQp9vPcc/PuvH65fB26QQuIzQa+gkmeWqp8Y3DoDC6PgQxwaOK9IPph2EH2PLeKz8=
X-Gm-Gg: AZuq6aIbHk30mc8W+meRFkBO00q3Q50YNlZFjOI5HyyyVzxyP9x14P4uTpL3nUHsCaa
 xT3n7i5GHpYk/4ohzfSYT3WR/OMOnCL1m39mBAmgCNAWQo1/BLHI8vhh2oWsyzkIOoRX9/nO1T4
 cToct/RK9QhqUoq/mjo0b+FQR6myuMuDgDRAJe4N2hCzTm17qL6kAFiCWzs4WyR3iTKir/8B+7d
 CgHSnnzWAPzezOxcPbGMsIBoAO16hLhvNQVRPP4oSpL0Lbv1fzmp3ZKU1a0L+LWqQpYvDFXi9Mx
 tSnh/j09UjaQxy2qsu0DRalgXssWEs5l7EKP06D26CcevOYeZ6N+Q1G8yMReXK4cbfEu5/Ec3WW
 pYwfaqM+uC+ir13Oy9V7VSIeXkHvCzFT/SUAPFexHU8JH7adKPx4wB08nJFarWy19xHlIZfhqkZ
 Wvj1EbpUiqli2vy7zdK+pBqZVwk96oB/O1Bpob98H4t1KsInN747PsJSBWdzF/E1BnJzPUcZxrU
 Q==
X-Received: by 2002:a05:6000:1acb:b0:42f:b555:5274 with SMTP id
 ffacd0b85a97d-434df0ed3d6mr27940393f8f.20.1768995991070; 
 Wed, 21 Jan 2026 03:46:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:8ae8:f59d:ae95:f372?
 ([2a01:e0a:3d9:2080:8ae8:f59d:ae95:f372])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597ae9f37sm6428952f8f.8.2026.01.21.03.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 03:46:30 -0800 (PST)
Message-ID: <311e0216-54f4-48c4-859c-d2db0a424340@linaro.org>
Date: Wed, 21 Jan 2026 12:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 casey.connolly@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20251229114312.668068-1-sumit.garg@kernel.org>
 <b60d5ee7-fa27-4dc1-8a09-964912ec5654@linaro.org>
 <aWDXQFXQcaoeV7ka@sumit-xelite>
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
In-Reply-To: <aWDXQFXQcaoeV7ka@sumit-xelite>
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

On 1/9/26 11:24, Sumit Garg wrote:
> On Thu, Jan 08, 2026 at 05:19:32PM +0100, neil.armstrong@linaro.org wrote:
>> On 12/29/25 12:43, Sumit Garg wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Add support for OP-TEE live tree DT fixup support which enables U-Boot
>>> OP-TEE driver to be probed. As well as the EFI DT fixup protocol allows
>>> the live tree fixup to be carried over to the OS for the OP-TEE driver
>>> in the OS to probe as well.
>>>
>>> Note that this fixup only gets applied if CONFIG_OPTEE gets enabled.
>>
>> Can't the presence of OP-TEE be detected dynamically via scm calls ?
> 
> SCM calls aren't present in case of TF-A/OP-TEE flow.

exact, but SMC calls are.

first thing optee driver does is calling OPTEE_SMC_CALLS_UID:

-> optee_probe()
-> is_optee_api()

Please investigate how this SMC would behave when QSEECOM or QTEE none are
present.

SMC calls are mandatory to be implemented for PSCI, so they should simply
return an error.

Neil

> 
> -Sumit
> 
>>
>> Thanks,
>> Neil
>>
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> ---
>>>    arch/arm/mach-snapdragon/of_fixup.c | 34 +++++++++++++++++++++++++++++
>>>    1 file changed, 34 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
>>> index eec2c0c757e..29a99f73cf3 100644
>>> --- a/arch/arm/mach-snapdragon/of_fixup.c
>>> +++ b/arch/arm/mach-snapdragon/of_fixup.c
>>> @@ -146,6 +146,37 @@ static void fixup_power_domains(struct device_node *root)
>>>    	}
>>>    }
>>> +static void add_optee_node(struct device_node *root)
>>> +{
>>> +	struct device_node *fw = NULL, *optee = NULL;
>>> +	int ret;
>>> +
>>> +	fw = of_find_node_by_path("/firmware");
>>> +	if (!fw) {
>>> +		log_err("Failed to find /firmware node\n");
>>> +		return;
>>> +	}
>>> +
>>> +	ret = of_add_subnode(fw, "optee", strlen("optee") + 1, &optee);
>>> +	if (ret) {
>>> +		log_err("Failed to add 'maximum-speed' property: %d\n", ret);
>>> +		return;
>>> +	}
>>> +
>>> +	ret = of_write_prop(optee, "compatible", strlen("linaro,optee-tz") + 1,
>>> +			    "linaro,optee-tz");
>>> +	if (ret) {
>>> +		log_err("Failed to optee 'compatible' property: %d\n", ret);
>>> +		return;
>>> +	}
>>> +
>>> +	ret = of_write_prop(optee, "method", strlen("smc") + 1, "smc");
>>> +	if (ret) {
>>> +		log_err("Failed to optee 'method' property: %d\n", ret);
>>> +		return;
>>> +	}
>>> +}
>>> +
>>>    #define time_call(func, ...) \
>>>    	do { \
>>>    		u64 start = timer_get_us(); \
>>> @@ -160,6 +191,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>>>    	time_call(fixup_usb_nodes, root);
>>>    	time_call(fixup_power_domains, root);
>>> +	if (IS_ENABLED(CONFIG_OPTEE))
>>> +		time_call(add_optee_node, root);
>>> +
>>>    	return 0;
>>>    }
>>

