Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE9FC47073
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 18:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C11987710;
	Wed, 10 Jan 2024 19:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZWytLThT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B4287AC9; Wed, 10 Jan 2024 19:50:36 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F0887508
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e5c317b34so404795e9.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704912634; x=1705517434; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FWJBa8cFc1FCojmIRs7ra/sWSczM6Wncqn1pKohtU3E=;
 b=ZWytLThTXPZ6OzJ8NAeQuvn/NBOxNYEFcu+b5VwqcYLChvruvZdIrB2nkuIcW9fPjq
 maEGnNj6k++HctMSO59n5JkZoUrK+JPMZpkcOZUJik0P+sjCDhANp0v8BvE3xwEKbAet
 rqlkp+WgHHL2V6aIy3RpyE+z25Cj3ueKjEIRKICslW6JCnc1+EJsRoi5EuD4DlqYAjjy
 El7wyyWmW+VLEpw5EtVgpQMeF+wO8fTDegNA/qSdzc6q+W6CHO4kg18RDoBfYMdJBVos
 mZjG+4S+fMz1J62mDdIF0Uop4ppxs3D8M3PQYnJdif+s9p+8VqoaLzNOVea8f5022BeY
 GOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704912634; x=1705517434;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FWJBa8cFc1FCojmIRs7ra/sWSczM6Wncqn1pKohtU3E=;
 b=RO9CegCFkgxz1SZaJXOgN/KkYckaPsLJOxlmfKZ0JMlGiWyv9KXU3MGCx2whJZX7Yw
 RoWNf9PYNDVYA1w1ZDOR9NqPyWkNhg2TaA9Y1a5oxD4XwDTh/zo8cTqyHX2D741NNXAE
 vzrHcM7R2dEmjXyEOOmVmqnccnGjC7Cj6pPUFU1kevI0MSuWuuyhjqi/vxLWXtjhGNIe
 oZ1HKiG1bb6zOXvIW2h7IrIiCxIkT2X+lBk+gdE6HyzWLINKXADtyuyIZTDcYO89eUrl
 1vLJQ+9yYocUP6+X0z2S7fRU0KFoVmxYaiWHgwU6XqDbUL6fWNjs3URAKv8AJOQ3SmK0
 6X8w==
X-Gm-Message-State: AOJu0YyUdbVFOYKVu+HqojxjAnQtzJlG4SlgAE6AnxOHcogjf0eOvEoI
 sON5ReJ3QXCnxTT6oL25kAVVAcMo3deXSQ==
X-Google-Smtp-Source: AGHT+IHU9IUeGihF4wQAz8Pqj9KY7ONkTaTB1ffMGb7ZaMm7ZrAP5fL91Od6DQRx3YOwQC15snN5Vw==
X-Received: by 2002:a05:600c:4293:b0:40e:4d21:6729 with SMTP id
 v19-20020a05600c429300b0040e4d216729mr789847wmc.71.1704912634212; 
 Wed, 10 Jan 2024 10:50:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5dee:51de:9349:2adf?
 ([2a01:e0a:982:cbb0:5dee:51de:9349:2adf])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a5d420a000000b0033719111458sm5458864wrq.36.2024.01.10.10.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 10:50:33 -0800 (PST)
Message-ID: <056e0dc2-d3e2-4b78-bd1a-c19dce447be0@linaro.org>
Date: Wed, 10 Jan 2024 19:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] clk: meson: add Hardware Clock measure driver
Content-Language: en-US, fr
To: Sean Anderson <seanga2@gmail.com>, u-boot-amlogic@groups.io,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <17A1E40D16C3C77A.26427@groups.io>
 <829ca7ca-0da6-468c-a70c-d0bb35a57fa9@linaro.org>
 <fb51d65c-7fc4-d303-a09e-4b5aa69407cb@gmail.com>
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
In-Reply-To: <fb51d65c-7fc4-d303-a09e-4b5aa69407cb@gmail.com>
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

On 10/01/2024 16:41, Sean Anderson wrote:
> On 1/10/24 04:23, Neil Armstrong wrote:
>> Hi Sean,
>>
>> On 18/12/2023 10:47, Neil Armstrong via groups.io wrote:
>>> Amlogic SoCs embeds an hardware clock measure block, port it
>>> from Linux and implement it as a UCLK_CLK with only the dump
>>> op and fail-only xlate.
>>>
>>> Based on the Linux driver introduced in [1].
>>>
>>> [1] commit 2b45ebef39a2 ("soc: amlogic: Add Meson Clock Measure driver").
>>>
>>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> Should I take this via the amlogic tree ?
> 
> If you like.
> 
> I will be doing a PR sometime before the merge window ends.

If you're making a PR, I won't except for this, so please take it then!

Neil

> 
> --Sean

