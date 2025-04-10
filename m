Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4194C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FEB83A03;
	Thu, 10 Apr 2025 09:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ThoOPgRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D32D83A15; Thu, 10 Apr 2025 09:48:22 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CDB83A03
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so278781f8f.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744271299; x=1744876099; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=J36iu0BO6MSkZlVasGb+W8mSaxOA6ngug0PvQs5SRio=;
 b=ThoOPgRsWwkoYA5jsUfGnjyO9npyn81XHWOUfXClvG3qL961374IN7Fvn+7ndjM1k4
 atgdwkRxY/wEn/ND8mlK38SoPjgPnOokKiKAZV9eXP/mRCUGYy0xMQFb3wIkl7h+pyrX
 FiXZTMVGl5T8jOkvWcS3bFMthOCN/+91etueTKHjJT0uDxQKCT4A3Mhf2SisL7DPyVzf
 yzJz6uqAfCWdumfRU9J/XNremSyU9Gv19XQP8DrTi3NiIxMPNO8huvlGawrS9tZjlaz3
 WQzJTgRrNyHFZ8l+Gp/uXJ969Hd+xS5HFhhbkyM9U0RRCet0JcE9wAvrboMzzLTlhdDF
 hqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744271299; x=1744876099;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=J36iu0BO6MSkZlVasGb+W8mSaxOA6ngug0PvQs5SRio=;
 b=HG9kPrVJCusbSEF+S+RnSEImyW83wexu/y8fwslNhjx0f4SjgWaK6KfSQAlGvU7Xin
 Sz2nDwaFUQJjVINl+LWWgdXZi2TVuF+2CPYJx9LFq1k+iEwUGDRfxOLFbmOryz2hjdjs
 vFYKN/tOrGssuYXYf9Sa5TSZrtFp1SrMs/S4zgxrZyILNDvwoTl+UMNit4+JT4Hg7+Ng
 Y5nG+mGn+YlcJFtGe/4bjUSNYc1Rs3Acp9wZwh7qq3kdnafk6//qlaLcEw65lG7cbTCj
 Xyn3lDm11S1oV5ZhUb3nIH7t5zyl6YUwccxO5Qi8FOSnIZIH03uDW8tTfegpqxx4pb/W
 d0jw==
X-Gm-Message-State: AOJu0YxXe3mo1I6DNwO5lifeZKkk4aqg4R8AFUoCIQ9P49Ke8quVqZaj
 ylP55+denqa28e02jjSfcVh5e71KTPGWbjeAp4OLSJXV7eicnaXx5YtmMaNimJI=
X-Gm-Gg: ASbGncsSXkTLQ91gjjhepewPAi5Deuwumrhag9LFgUtOHx3fQ5omfeBKMFI8Vav1wWA
 ovd3jyf4v57k78yFUq7HZVgI/F0YiDg5OevlQT3uc8ul7TWH5FtLscha5v8DTXYCcbSTweGRXgW
 3aplDgFOWExjoyvphZiLm+SzfTv5VS9rl5QGRiE38Scmm9xZkEZWs+9xrnHKSNoPFFAZ5cKXfin
 gMcaOCcIwXlrT7szoCkL1BFfe5ORopCQ+bhfYfy6FAjy63x3TfVAfYszNzGTNYIzpJg+7bOl8BI
 LBHIxELo9T3shgF8h2DqYwhEO0Le1IUhB8WVsYHK+BaIsLLzwnLy1m5gb3aLJHXKDn6j9TtDOZn
 omlV0+H8Id31ran1D7Q==
X-Google-Smtp-Source: AGHT+IEXs/mIHdFo7hrO5lPjwoGoCbslxCv7de/12svRoKo3A8864fNyXQ473LffuIEvOGwl2lQhjQ==
X-Received: by 2002:a05:6000:1a8c:b0:390:e9b5:d69c with SMTP id
 ffacd0b85a97d-39d8f4713cemr1301715f8f.25.1744271299444; 
 Thu, 10 Apr 2025 00:48:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe?
 ([2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0b35sm3906739f8f.70.2025.04.10.00.48.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 00:48:19 -0700 (PDT)
Message-ID: <8683856d-5bd2-4e6f-b4f3-9a5928b707c5@linaro.org>
Date: Thu, 10 Apr 2025 09:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pinctrl: qcom: handle reserved ranges
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de
References: <20250401-topic-sm8x50-pinctrl-reserved-ranges-v1-1-0fe88b491707@linaro.org>
 <84ec2a78-6f9b-469f-b8a1-de44132e31bd@postmarketos.org>
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
In-Reply-To: <84ec2a78-6f9b-469f-b8a1-de44132e31bd@postmarketos.org>
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

On 10/04/2025 01:40, Alexey Minnekhanov wrote:
> On 4/1/25 10:46, Neil Armstrong via groups.io wrote:
>> From: Caleb Connolly <caleb.connolly@linaro.org>
>>
>> Some Qualcomm boards feature reserved ranges of pins which are protected
>> by firmware. Attempting to read or write any registers associated with
>> these pins results the board resetting.
>>
>> Add support for parsing these ranges from devicetree and ensure that the
>> pinctrl and GPIO drivers don't try to interact with these pins.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm/mach-snapdragon/include/mach/gpio.h | 15 +++++++
>>   drivers/gpio/msm_gpio.c                      |  9 ++++
>>   drivers/pinctrl/qcom/pinctrl-qcom.c          | 64 ++++++++++++++++++++++++++++
>>   3 files changed, 88 insertions(+)
> 
> ...
> 
>> +#define MSM_PINCTRL_MAX_RESERVED_RANGES 32
>> +
>>   struct msm_pinctrl_priv {
>>       phys_addr_t base;
>>       struct msm_pinctrl_data *data;
>> +    u32 reserved_ranges[MSM_PINCTRL_MAX_RESERVED_RANGES * 2];
>> +    int reserved_ranges_count;
>>   };
> Why storing of reserved pins isn't implemented using bitmap?
> 
>      DECLARE_BITMAP(reserved_pins, 256);
> 
> would only consume 32 bytes, instead of 256+4 like here.
> 
> Do I miss something?


You're right, I'll convert it to bitmap.

Neil

> 
> ---
> Regards,
> Alexey Minnekhanov

