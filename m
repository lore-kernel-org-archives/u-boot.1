Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5DBC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 07:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6200981E25;
	Thu,  5 Jun 2025 09:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gCv8Nio9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C530D81E25; Thu,  5 Jun 2025 09:46:49 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8636C82145
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 09:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a51d552de4so353371f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749109607; x=1749714407; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XbXXBprpZ31uyW48O5ikP2TZZYfKoO/Xf4btv/M3gJw=;
 b=gCv8Nio9kZ97T6IebiE8kf/dMxRrtnY+Z/m8ZGrq9zniiYpNvHwFTV3PK+vu6Yc8Eb
 LtWzqou+AsxKslNab2pR7DULTaLechLDNc3NTQFLnAWMgS1jTgPdCSOAnY75Awnxk7db
 N5HXbP8CYQN3lyMJ1oOPyBKeXaqWl5yRxLI69gmMcJGzE+vbfKVt5lGjBE82QtaJvbNR
 yoFl7nmDNvub5ek/8/gg+QX8uwX6DQVQEsJwajEoR7B5xhcoGUrcXIynWEyfKMMsK1my
 UEXSpjdvvHIipXgYAdk7SKdMhLtSovNPC80hXAT3o05IRz3iqdNZY+U8niXWVlS8byza
 45rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749109607; x=1749714407;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XbXXBprpZ31uyW48O5ikP2TZZYfKoO/Xf4btv/M3gJw=;
 b=pTaopPoxErYNWU74LFjWF0wcM4ywrtUvtbdwxArb5gP88dBgnvHq/1qpaNTII7qNHR
 n6bliiO4Z8tlj2bxpAUYQESeyy/9OhJY8ex2afCrCimkt3AlqGL7jBHKLH8sZc7C6KK8
 XRC3NoUHKL+c4XsY5tXlF7maMcLFbAu6zXDBOPTjUQeFs6Ia+uSJt7ZuRcZex1MK9P3y
 08EQQEc/X6dHX/xdviiUMxPLpWpgKloJt+DiXOR0tw46asAEHuFXuEuOR8ffgB6V4t9C
 9P0ALc7tDXBGNKN2PASFaLCLrgu9xe/vyA//hX7D+z/+h7YbEaYeq/LmSlkVVe7fL3XG
 qPkg==
X-Gm-Message-State: AOJu0Yxmz7O3Yc4cVdJMRsS2UPSfEgQOo2z83C963g7UH28BxIa81UyY
 o1gBQBHzToS/UuScL0mFn8AyjYIiFkthkdAA3VdjjZYC5Nqf5zEQE0mATNt0FVmSJv2L+lUw2kE
 QhmHw
X-Gm-Gg: ASbGnct7nRtizhMFiuiS6YPBlPgW8tCX1gpxGM3usD5bvTiZ/NPt+gfW8yFGly5DWEG
 44mfELMOk30vxBuKBcCshkGG7AX+YpsTM77f/5KBRXOudC93kXG1HS6/xkFfS5KIxL+CmOLDCHd
 ZFld0bjAN10jTQuy8X3rkKigVo0EiBb2BdUBnNEiW4BzURUkAPj1tgR7lmYlgPh5KwDwu4fm/J/
 Uh3MnJIezkBCZcxfaNtdDARXbCO9TGJNAEgolHRGAeIQtYwTcJPFlYk1v1kEfqJhquIcGWBmf6P
 xabUuWjbCnpHJsNXjS6peW2l6h5QDswzqqnnSlzna7kv4iotsoRvqoI05q1d6C7ZucwyVSLvwDf
 SLPv/ziN2m0/jSg6AbV9vkPTjKm0f
X-Google-Smtp-Source: AGHT+IH7spiy+L4u4RXq1s8Fgd+PCyHSD4m48r7EuNNTuFoC89VQbcNdmRGUdV8Wgmb76J6uF8rnsQ==
X-Received: by 2002:a5d:5f42:0:b0:3a4:e6b4:9c4b with SMTP id
 ffacd0b85a97d-3a51d8f6bbfmr4174738f8f.1.1749109606873; 
 Thu, 05 Jun 2025 00:46:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:53e5:f2b3:9ac1:62cd?
 ([2a01:e0a:3d9:2080:53e5:f2b3:9ac1:62cd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009745esm23982246f8f.71.2025.06.05.00.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 00:46:46 -0700 (PDT)
Message-ID: <18fa55c7-e04a-4086-8a7d-1e73d997cca6@linaro.org>
Date: Thu, 5 Jun 2025 09:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC/RFT 0/2] gpio: qcom: rewritte SPMI gpio driver from
 Linux driver
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
 <cebc988b-de5b-45af-92ba-08ee7998aaef@linaro.org>
 <724196e1-a409-4b03-8145-3dbb473e3949@linaro.org>
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
In-Reply-To: <724196e1-a409-4b03-8145-3dbb473e3949@linaro.org>
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

On 04/06/2025 14:40, Casey Connolly wrote:
> 
> 
> On 6/3/25 18:43, Neil Armstrong wrote:
>> On 01/04/2025 11:47, Neil Armstrong wrote:
>>> The current SPMI gpio driver is very old and doesn't support
>>> pin state tracking to fully support the whole pinconf calls.
>>>
>>> The simplest is to rewritte the driver using the v6.14 Linux
>>> driver and fully implement pinctrl, pinmux, pinconf and gpio
>>> support using all the newer interfaces.
>>>
>>> The goal is to deprecate the old one it has been validated
>>> on currently supported hardware.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>> Neil Armstrong (2):
>>>        gpio: qcom: add new driver for SPMI gpios
>>>        gpio: qcom: move pm8550 gpio to new driver
>>>
>>>   drivers/gpio/Makefile         |    2 +-
>>>   drivers/gpio/qcom_pmic_gpio.c |   20 +-
>>>   drivers/gpio/qcom_spmi_gpio.c | 1035 +++++++++++++++++++++++++++++++ ++++++++++
>>>   3 files changed, 1037 insertions(+), 20 deletions(-)
>>> ---
>>> base-commit: 5ca70325b64f760bf4190f206a0e88dda495e3d2
>>> change-id: 20250401-topic-sm8x50-pmic-gpio-pinctrl-new-2588c35a461c
>>>
>>> Best regards,
>>
>> How should we go forward ?
> 
> Unless you have any concerns let's pull this into -next and see what happens. I'm preparing a PR atm>

For me it's all good, once it's merge I'll migrate to the new one and add all the other compatible
from the Linux driver.

Thanks !
Neil

>> Neil
> 

