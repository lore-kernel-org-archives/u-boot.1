Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B444C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 13:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36FEB88148;
	Fri,  1 Mar 2024 14:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e18hjjYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A46F58813A; Fri,  1 Mar 2024 14:48:17 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B83EA8814A
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 14:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a44b0b2c7cdso42603766b.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 05:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709300893; x=1709905693; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=0GI0yUdoTdJaxhh/LVRaEugw/4qRC1T8OrLHfUKQHlQ=;
 b=e18hjjYOUlsc3p1VVS5oAN2fMRPyJdzUfabSxoPPNI8FVYnVOGwJHz+A9+B1BL0QIh
 kSnetWucJ3QWXp9/JUcvGzcvBDnbLyOtXPXjTDx4UYblvyPNwyh3PN7+HOCKinUUEyiR
 Vkp7WI8R+47BwFC7OTaXC3yt9b74MuYePlhm3KFXv3TJjWKdIVqYymGDb0YglmsuAZe1
 IOndv8+aRzSreaulWqwc/nUXHeods146Gfs6826wNk/9HIi/uK499wjUs2cfqV+Ttiz6
 a0ET/rmjYLQ+n8NDJIb2yJUggAJJBz78wavncvftnf9He3ZnQMhhYf5zwyhkiB4FSA7X
 2xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709300893; x=1709905693;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0GI0yUdoTdJaxhh/LVRaEugw/4qRC1T8OrLHfUKQHlQ=;
 b=PqkBvlbf0SZT7pbSHGW3S4ZSTT8UEI4tzu/IubT3/jbaBsK66+yTdR221sPIa5VXm1
 2sViqkXCtJvfzvPkUNOqisJc0uYJPd1xb9x77S00t7O+YgG3MenYYpsiyroSZfvym5H2
 6hVzpmpj7ZkHZvTgH45X0P3YhF48Rw38+CbpjRnhJhG6wi0bJboSmOgILWUJsMqNEmdE
 V/Fa18jOUpMqDpxLkY34ihbbkS6ClsACYqqC1Pg9y4Oz/W2UtaMpAzymxlgWdLtwDuAb
 TngJGm2ubvttjYlRpTz3dIcZjPpkeqTVZ8SQWQlBiomWI7NrPYWeLeOep2VbTTwhcVB7
 gmjQ==
X-Gm-Message-State: AOJu0YxVc5UBHhYY+ijMBLQocXfRGCQfS6fk7dgRbKl9CX7lYQnK1Bay
 ovxd8Ar0NV0AnmdH3ryJDFMDKCQae/m2YJxiH1Uwd4c9urLglT3ZMS063EobAXI=
X-Google-Smtp-Source: AGHT+IGfzdCnreNKbLwPfQpzcRj8KgrXW3xSyC3x62eRqTfO4rvhdwuhQ7wvkQBb+G9vWqZ4coaaLg==
X-Received: by 2002:a17:906:29c7:b0:a44:bb64:9d0f with SMTP id
 y7-20020a17090629c700b00a44bb649d0fmr144224eje.72.1709300893003; 
 Fri, 01 Mar 2024 05:48:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8beb:89b5:61ff:3fd8?
 ([2a01:e0a:982:cbb0:8beb:89b5:61ff:3fd8])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a05600c474d00b00412c1d51a0dsm4179837wmo.45.2024.03.01.05.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 05:48:12 -0800 (PST)
Message-ID: <0ef45d67-1428-4d8a-b157-2ee65a3c9948@linaro.org>
Date: Fri, 1 Mar 2024 14:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
Content-Language: en-US, fr
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de, mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
 festevam@gmail.com, nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk,
 paul.barker.ct@bp.renesas.com
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAFA6WYMBMQH10cHnsfmC5efkkohfzftz=6u0N4RMXrVrByZzOw@mail.gmail.com>
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
In-Reply-To: <CAFA6WYMBMQH10cHnsfmC5efkkohfzftz=6u0N4RMXrVrByZzOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 01 Mar 2024 14:48:40 +0100
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

On 01/03/2024 14:30, Sumit Garg wrote:
> On Fri, 1 Mar 2024 at 18:27, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:
>>
>>> Changes in v6:
>>> --------------
>>> - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
>>> - Patch #3: Incorporate fix for sandbox CI failure.
>>> - Patch #6: Incorporate shell script comments from Marek.
>>> - Patch #8: Incorporate documentation review comments from Paul.
>>>
>>> [...]
>>
>> Applied to u-boot/next, thanks!
>>
> 
> Thanks Tom and everyone involved with the reviews. I hope we can carry
> forward from this effort towards a healthy devicetree story for
> U-Boot.

Thanks Sumit!

I'll try to submit patches for Amlogic GXL & G12A to switch to this!

Neil

> 
> -Sumit
> 
>> --
>> Tom
>>
>>

