Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3596D374A3
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BBCF89023;
	Thu, 17 Oct 2024 16:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EZH8Yank";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBAA4889EB; Thu, 17 Oct 2024 16:41:24 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F14BF88FFB
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso5207795e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729176080; x=1729780880; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Kg5K3H9VSabu18ZLAZSSbwIuJr38DkYMDqLZpOMKfl8=;
 b=EZH8Yank/YNNTNWarNAr8wBE11XZ5AiA2opTlJ2ButzJzAYLLHmglzaNvOaVKiNSkW
 G0v01g7SjuPVJoa6We7mnC82YuQASdumGQBdP4mbXi0bzPHVLxcCpnxX2WLZ89atV4lu
 JQbR1NLXmcznriEbyjjh45zUD7TMDbn84TxgH5DcDq3HDYVkc80ZlfoZQbbCJptGuglw
 BBAOI8bFTyF/+DvR93rYCI6k5gzyKQ7tcWGFv+zlUHp2+j+vYE4kmbkUWdP3TuSaS5/b
 CSlAImmqPSVTTUHKQhN/RaAp5dM8nq332Zat1vCVG+nVU/CEvxW4DBAqXNX88ZN4jCGi
 q98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176080; x=1729780880;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Kg5K3H9VSabu18ZLAZSSbwIuJr38DkYMDqLZpOMKfl8=;
 b=e8hVp4ixEcFwVu4E6CHVPR4D+DcZYg9Rkbv/TPrnTkcMofTAhLIPVp/Hc6iZKf8MMm
 M2RImUXZUqZwnRHWZH/viKQU5MhEdgQ/cLjzyfrF5NLVkLBKi92v9VqtJ3Fh8oF3+M5k
 ZEgj1AF7XnPklU1tqIuhPXinHmu5ew3F2AQD4+W6Itc0J5+GSUNqCOE0+QOoOKnXcVf+
 uC5JFU/KK2296KcuWlWrUggRUMd+qGGonU3egV+6XVg3sqnKsgBEvSZ1zO2Fnc9nvOxC
 qJL34ul6YrhUKoKZiZvvPHbrwjvGuaMExOlDNGd/W0AsUqhgIIVoujTWX8w3sfi+FBYP
 x+xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWv6bcAOeBkcOc3L2IdsBHX4Ao5V0DEiC1PkW53QQC3XzQpt1PqZufFIllr4OLUDP1bYtJSvE=@lists.denx.de
X-Gm-Message-State: AOJu0YwagxwAzuX2sr1XFc5n9xDDyyC9Pboa6ZKICD3uhcm+MEgt0Cm7
 s8iVomCGq1THpg07CtGI1/PAlacg9YjcgyoNWOqg0ZYnm3GZBUB8SGkQViqTAIA=
X-Google-Smtp-Source: AGHT+IGqdbR54/ZEi8cMv7/GRbAoE3zZylW6htibK/mMjNQnP2zmaVKyucaV0JZcYNQO/ZTSpq88QQ==
X-Received: by 2002:a05:600c:1d15:b0:42c:b750:1a1e with SMTP id
 5b1f17b1804b1-43149fb3416mr65504235e9.0.1729176080308; 
 Thu, 17 Oct 2024 07:41:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20?
 ([2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c4061bsm28202035e9.25.2024.10.17.07.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 07:41:19 -0700 (PDT)
Message-ID: <3df90aa7-70bd-414e-beee-ff2c4fae7d58@linaro.org>
Date: Thu, 17 Oct 2024 16:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 4/4] qcom_defconfig: enable capsule update support
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
 <20241012-b4-qcom-capsule-updates-v4-4-abd05f15255f@linaro.org>
 <de283020-8286-4910-8b15-d0e86d60ed17@linaro.org>
 <7b0f3d88-f750-4a88-b67a-85412083f2be@linaro.org>
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
In-Reply-To: <7b0f3d88-f750-4a88-b67a-85412083f2be@linaro.org>
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

On 17/10/2024 15:19, Caleb Connolly wrote:
> 
> 
> On 14/10/2024 08:53, Neil Armstrong wrote:
>> On 12/10/2024 15:57, Caleb Connolly wrote:
>>> Enable all the necessary options for capsule updates to work, as well as
>>> a few additional EFI features.
>>>
>>> Capsule updates themselves are only enabled for the RB3 Gen 2, since the
>>> exact details on where to flash U-Boot (or how to handle multiple boot
>>> methods) has not been finalised for other boards.
>>
>> -----------------------/\ finalized
> 
> Finalised is the correct spelling in British English :P

Ah Ah sorry, my mailer spell checked is in English USA, sorry :-p Adding the british one right now!

Since you're a certified British, I'll trust you!

Neil

> 
> Is there a rule about this? XD
> 
> Thanks for the review!
>>
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>   configs/qcm6490_defconfig | 6 ++++++
>>>   configs/qcom_defconfig    | 8 +++++++-
>>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
>>> index 5ddc5ab3ef8c..ba26924da161 100644
>>> --- a/configs/qcm6490_defconfig
>>> +++ b/configs/qcm6490_defconfig
>>> @@ -18,4 +18,10 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>>>   CONFIG_TEXT_BASE=0x9fc00000
>>>   CONFIG_REMAKE_ELF=y
>>>   CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
>>> +
>>> +# Enable capsule updates
>>> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>>> +CONFIG_EFI_CAPSULE_ON_DISK=y
>>> +CONFIG_EFI_IGNORE_OSINDICATIONS=y
>>> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>>> index e7ed03ff0f24..4c8ff0e84372 100644
>>> --- a/configs/qcom_defconfig
>>> +++ b/configs/qcom_defconfig
>>> @@ -20,21 +20,24 @@ CONFIG_LOG_MAX_LEVEL=9
>>>   CONFIG_LOG_DEFAULT_LEVEL=4
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>>   CONFIG_CMD_BOOTMENU=y
>>> +CONFIG_CMD_NVEDIT_EFI=y
>>>   CONFIG_CMD_EEPROM=y
>>>   CONFIG_SYS_I2C_EEPROM_BUS=2
>>>   CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
>>>   CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
>>>   # CONFIG_CMD_BIND is not set
>>>   CONFIG_CMD_CLK=y
>>> +CONFIG_CMD_DFU=y
>>>   CONFIG_CMD_GPIO=y
>>>   CONFIG_CMD_I2C=y
>>>   CONFIG_CMD_MMC=y
>>>   CONFIG_CMD_UFS=y
>>>   CONFIG_CMD_USB=y
>>>   CONFIG_CMD_CAT=y
>>>   CONFIG_CMD_BMP=y
>>> +CONFIG_CMD_EFIDEBUG=y
>>>   CONFIG_CMD_REGULATOR=y
>>>   CONFIG_CMD_LOG=y
>>>   CONFIG_OF_LIVE=y
>>>   CONFIG_USE_DEFAULT_ENV_FILE=y
>>> @@ -44,15 +47,18 @@ CONFIG_CLK=y
>>>   CONFIG_CLK_QCOM_APQ8016=y
>>>   CONFIG_CLK_QCOM_APQ8096=y
>>>   CONFIG_CLK_QCOM_QCM2290=y
>>>   CONFIG_CLK_QCOM_QCS404=y
>>> -CONFIG_CLK_QCOM_SC7280=y
>>>   CONFIG_CLK_QCOM_SDM845=y
>>>   CONFIG_CLK_QCOM_SM6115=y
>>>   CONFIG_CLK_QCOM_SM8150=y
>>>   CONFIG_CLK_QCOM_SM8250=y
>>>   CONFIG_CLK_QCOM_SM8550=y
>>>   CONFIG_CLK_QCOM_SM8650=y
>>> +CONFIG_CLK_QCOM_SC7280=y
>>> +CONFIG_DFU_MMC=y
>>> +CONFIG_DFU_SCSI=y
>>> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
>>>   CONFIG_MSM_GPIO=y
>>>   CONFIG_QCOM_PMIC_GPIO=y
>>>   CONFIG_DM_I2C=y
>>>   CONFIG_SYS_I2C_QUP=y
>>>
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 

