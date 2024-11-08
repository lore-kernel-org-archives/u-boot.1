Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF84ED5E14C
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 10:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073AF8902D;
	Fri,  8 Nov 2024 11:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SBo7vALV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8667A88EBA; Fri,  8 Nov 2024 11:10:21 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1328902D
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 11:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d4c482844so1211046f8f.0
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 02:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731060619; x=1731665419; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=S9s9wQSK+zE3ZeyEW821Io6phZev57dH2YRnq+c1lI4=;
 b=SBo7vALVz47edR9THwb3OXn6wqjBf2Xj5GJkVlOuqz5DGmMthbmkW8ygrUmx0x2YLp
 MLjWucafIIxT6D6yq7wAnlRbFJtc2s+icZ83QnWgmAS/F8EwZm9kgfL2EjfI0VLNbSUS
 NCnHrkyJ0t7jJJm6PXkHZskfssv1V4XZ1DhrQZgF7SePBWAKGAl2SIAqkueqienT1oIn
 1wDOQ5HBTf8v8qPnYmJaXkIwzKjbi2d4IkMNhEHeVJ0ueXQDEITKrsnfgu5w7lDSWYLy
 VXgjrIOODuNYXCURArnSQAUv/GPEbLEcvrR/1lbEZ8bHUQHvJpmZXUbO/21ugr7I68Th
 bEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731060619; x=1731665419;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=S9s9wQSK+zE3ZeyEW821Io6phZev57dH2YRnq+c1lI4=;
 b=sO5oE6Yb1JIOtPqPj683R+2GSJvhHezBPWcWWy63HaKuwO44mY84Z6zLQunqdMEhPg
 eI7be5Kj3RYOWe1HMS1CwSim3cPhrbzB/HIfOg1DPLLf+aountYEd0P9T/baD7R/o+vv
 QH++FguGFAbANf8s3u/iW6mytC3XrRF8qFN4rDi2JciOg20z7MH2dwUyiB99RNicE9CH
 7rbpSVcv/ZLTKV1pBe1oZUOG+DbBmWpATGl4NUyEhtrZTNL8t2JYdeQNZaNCBTe+zrI7
 BmdzrOQwCAmUtvSyF1GVxDtcB9JRK7ACRKExhDB3im4NVNAX7ZPFD5wBT4RcZzp5sI6o
 jYCA==
X-Gm-Message-State: AOJu0YzQkkRdtrGP876gh4WVd5MExVJ2JcTJYrLOnQ9aB4UxHmTi7WWP
 6jOG6TNXcaSubS7qjIao7SF7POlQbTRi+xJMV1SJLWaQObrGCoPm8WjtAkki80o=
X-Google-Smtp-Source: AGHT+IFkNvm79j/hELKkG2tYJq01oKQ6G6LjjaUl0SrF5t1KipAjhWmutVwwWeTia/jr1ki9X0dV8w==
X-Received: by 2002:a05:6000:184b:b0:37c:d558:a931 with SMTP id
 ffacd0b85a97d-381f1873086mr1645649f8f.31.1731060618869; 
 Fri, 08 Nov 2024 02:10:18 -0800 (PST)
Received: from [172.16.23.252] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed99aa18sm4080686f8f.61.2024.11.08.02.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 02:10:18 -0800 (PST)
Message-ID: <fd46ba38-29e3-44df-a4d5-e520119f23a2@linaro.org>
Date: Fri, 8 Nov 2024 11:10:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/6] configs: khadas-vim3{l}: fix userdata size
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
 <87msia3urk.fsf@baylibre.com>
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
In-Reply-To: <87msia3urk.fsf@baylibre.com>
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

On 08/11/2024 11:05, Mattijs Korpershoek wrote:
> Hi Neil,
> 
> On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:
> 
>> After increase boot and recovery partition userdata was not resize.
>> so on VIM3 16GB and VIM3L `fastboot oem format` or `gpt write mmc 2
>> $partitions` fail because end of last partition is outside of eMMC
>> size.
>>
>> Remove 64MB on userdata partitions to fix it.
>>
>> Fixes: ce138d9742bf ("configs: khadas-vim3{l}: Increase boot/recovery
>> partition size")
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
> 
> Do you think you can pick up just this patch ([3/6])?
> 
> Since it's a fixing a regression that I introduced I'd like this to
> picked up without depending on the rest of the series.

Sure I was waiting for your go!

Neil

> 
> Thanks!
> Mattijs
> 
>>   include/configs/khadas-vim3_android.h  | 4 ++--
>>   include/configs/khadas-vim3l_android.h | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
> 
> [...]

