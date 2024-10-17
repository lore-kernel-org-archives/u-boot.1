Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28425D374A2
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A20E688FF6;
	Thu, 17 Oct 2024 16:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JbKYelF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6697188B0C; Thu, 17 Oct 2024 16:54:36 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8D188FF6
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so761438f8f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729176872; x=1729781672; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XY8YdW91Am7HU4K1uUwZEVyF/nGnmDKCsqW4sapUszs=;
 b=JbKYelF1X5e/t3lBPTItoGymUL9yRq6ywrTztW0vlrC9Y+jcbq81uTvWu8WBNjMlu6
 Ex5Ifgt0n3uznGuKfXUHVmTngO8SWjOy6NIr//4n/GXrHt15X5JGU/aJPRFzZGrJiczc
 fhyqoE5hmuBc4cujpU729qlALMTDoZLeowRGb3gWUUzEb9MhqCbnJlL5HljyljODGMNG
 rfe06DKvvw+w1hrJl9BkE+BkSNloTELtLTNnDdlna8rBUN7hmfE+7oTxrUzHaEE94mke
 rgndflqOB5s3PrY4jWAjCdglEErcAugpzeJzWI1jM7uaTkE9Uj6KPxaBMgRQ4jNHM5HZ
 ku0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176872; x=1729781672;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XY8YdW91Am7HU4K1uUwZEVyF/nGnmDKCsqW4sapUszs=;
 b=X6xmVHszOtds28kJPJrBwtQh11dJMjWHTfgrCSP+2NFl7JIUxX9fqRBo26LWv/Yisy
 kdNSedar+8Fuqt50uW/377rJ0/iXLksi9C1uh8Ay4D2grWQrXUcY8utjNjLpKEQWsijk
 rI4AjFoa1u8Ds5qlI9jMBmo6cCkgc7Xai/8I1LuTwZE1SoepTVYBZC6I7sGgxFb6yp0G
 57YATouu88a5RFoXE/UXTrAJzlSBUnwCFnEhsd4rQXJM832wowl/nI7m180Hcpy1vAUG
 SFqBM7DOTXnWnoy7gcIVW4WcJYo6E4u/MkOvuHB0bdP1yoQQRzxC4eXhGehfgE9xj972
 e0nQ==
X-Gm-Message-State: AOJu0YwJMQUvRMqJLs69i3ozFnJeb2NpBCnsDY+PGtyaxLWydQq6TYpY
 Bu0C8dT3URkeBq/O83wcK/STqzqjuTBUEPILmN3XWjwn6QLv8iadHTtIRX+CjFk=
X-Google-Smtp-Source: AGHT+IGszNfnp7jduo/JXJt2XCJPCTo20IwkAX2FFryOJvSe/+7NfL/ADF3G1Urqa73szcE3rklM9g==
X-Received: by 2002:adf:e689:0:b0:374:c33d:377d with SMTP id
 ffacd0b85a97d-37d93e4cc2amr2230372f8f.28.1729176871538; 
 Thu, 17 Oct 2024 07:54:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20?
 ([2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc41154sm7464891f8f.108.2024.10.17.07.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 07:54:31 -0700 (PDT)
Message-ID: <b9ce38f7-a5d4-4e14-80e0-9b2e5e2b7393@linaro.org>
Date: Thu, 17 Oct 2024 16:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: dwc3-generic: use DR_MODE_OTG when dr_mode isn't
 specified
To: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241016-topic-usb-dwc3-dr-mode-otg-v1-1-4fda56072723@linaro.org>
 <c6b7e22d-2d84-4577-a2e4-d15363a45993@linaro.org>
 <21febc56-7224-4af0-a0a1-4eb707a3f94b@denx.de>
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
In-Reply-To: <21febc56-7224-4af0-a0a1-4eb707a3f94b@denx.de>
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

On 17/10/2024 15:52, Marek Vasut wrote:
> On 10/17/24 1:07 PM, Caleb Connolly wrote:
>>
>>
>> On 16/10/2024 10:26, Neil Armstrong via groups.io wrote:
>>> The USB DRD bindingsa at [1] are clear, if not specified the dr_mode
>>> property defaults to otg, and this is how Linux behaves.
>>
>> I guess this is (kind of?) a subset of
>>
>> https://lore.kernel.org/u-boot/20240621021135.1600847-2- caleb.connolly@linaro.org/

Yes and no, it should be on top of mine

>>
>> I need to respin that one...
> 
> It would be good to include that information in the commit message ...

Will do

> 
>>> A cleanup is ongoing on the Linux Device Trees to remove dr_mode when
>>> set to "otg", so take this in account and do not fail anymore when
>>> dr_mode isn't specified in the glue or dwc3 node.
>>
>> Definitely an improvement over the status quo heh
>>
>> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ... and eventually synchronize the DWC3 driver with current Linux kernel state of it.

Well, this behavior should've been in U-Boot since the beginning!

But yeah, it's should be done and it's another subject because it would
impact a lot of boards.

Neil

> 

