Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96E0D1AD5E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2819C88B70;
	Wed, 16 Oct 2024 15:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NUHCeXE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A32F88B70; Wed, 16 Oct 2024 15:49:15 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A35D88B70
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 15:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43115b31366so61327535e9.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729086552; x=1729691352; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=u997WGv2lM9pxB92KwBtOzQYGNMvrwBNdxUg7fG8UxY=;
 b=NUHCeXE9VfXWULTsQZrtxBzmEALdN/tVNPRyx8Em01IpMq+htV/KLfg+agR9BerW34
 LGTJOKEQMjDUMRW+I7lnnCCpeHoY6ACnrFaqjk3JAjZg72Q2ix1o2ANrEpfxx0eYGqvf
 n69H1dv+Se8s5+r9dETB3KQ08s4m87se3Xy4TDbWNj6xZHMGd4hVbfRKzwtodSuzP/PP
 CahH3ZdQT61+dpgs1o62XWxEPXAHFju29vnNabTYE6vZvdIKLTFN47xGXwWFQ/73yk+s
 ZM6Go2MchaZqh/NZHyKqi6cqmm1Fm/ffBmL4AYh4Y+n6mlS3g0THuGk7vW5O/+w5f0Wt
 pfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729086552; x=1729691352;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u997WGv2lM9pxB92KwBtOzQYGNMvrwBNdxUg7fG8UxY=;
 b=qmwv4i69lY0vDJaRZTbvMNvVnxfgWbF1ndE1jaLnM9+vCynjPWgfhwnh3khmGc1vQJ
 WhMXsLU9i/Pmg0DyEANwkmcGNCfqkLAkjlutZC0l0G+Ab9CdsyivBvDalnmQ1bu13nDL
 7LojJ7/shxfHiGEewhvo7WwcpslfXXYMeqOApQpE8aVEAIBjY6Hs9o3s8h5ffG99FazM
 0ouaIL62HfUKQSVAzVsgGvGK+NtMDL/xKzygTRVmviC0gOs3heX+3k8G1KN4Cbd6UvzB
 fWRy/j+sqBp4KGtgr0pstf609ym60IkjGcYSMltKPHG3cmNq43icHUsINjwLwiAULjfD
 X+5w==
X-Gm-Message-State: AOJu0YyEOp08xcSzLQcq/sozxmXRUNGrRpPkQVYMsMBMOzQkw6ua+Kth
 txTPD4zjPeOyyAQt3TJ18PExyr1FAg6nUQtChKqQ1jp3G5QbMF1iMiAcQvr/I8g=
X-Google-Smtp-Source: AGHT+IHpssrudNqmVs5LAp3fREohaDTWL960QefSJSfmTTu/gkMrX648Thk9k6hhBIdD427iQ7KjbQ==
X-Received: by 2002:a05:600c:5589:b0:431:4e25:fe26 with SMTP id
 5b1f17b1804b1-4314e26013fmr25390985e9.27.1729086552495; 
 Wed, 16 Oct 2024 06:49:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:fd09:f78e:726a:6fa2?
 ([2a01:e0a:982:cbb0:fd09:f78e:726a:6fa2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc419ffsm4352233f8f.111.2024.10.16.06.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 06:49:12 -0700 (PDT)
Message-ID: <ed38496e-4075-4a8d-aab4-47ce49505041@linaro.org>
Date: Wed, 16 Oct 2024 15:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: dwc3-generic: use DR_MODE_OTG when dr_mode isn't
 specified
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20241016-topic-usb-dwc3-dr-mode-otg-v1-1-4fda56072723@linaro.org>
 <e4585dc6-5c1f-4c6f-a696-49d31626a431@denx.de>
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
In-Reply-To: <e4585dc6-5c1f-4c6f-a696-49d31626a431@denx.de>
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

On 16/10/2024 13:22, Marek Vasut wrote:
> On 10/16/24 10:26 AM, Neil Armstrong wrote:
>> The USB DRD bindingsa at [1] are clear, if not specified the dr_mode
>> property defaults to otg, and this is how Linux behaves.
>>
>> A cleanup is ongoing on the Linux Device Trees to remove dr_mode when
>> set to "otg", so take this in account and do not fail anymore when
>> dr_mode isn't specified in the glue or dwc3 node.
>>
>> [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/usb/usb-drd.yaml
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Is there a matching Linux kernel commit which implements this behavior in Linux ?

In DWC3, the logic is there since v3.12-rc1 in commit a45c82b84c844 ("usb: dwc3: adapt to use dr_mode device tree helper") [1]

```
if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
	dwc->dr_mode = USB_DR_MODE_OTG;
```

[1] https://github.com/torvalds/linux/commit/a45c82b84c844cd85b2ed1aa32596f1bffa32716

Neil
