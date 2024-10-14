Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF98ED1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 16:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 145028901E;
	Mon, 14 Oct 2024 18:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iSGwLE14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA23890A9; Mon, 14 Oct 2024 18:20:19 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016F288F91
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 18:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-430f6bc9ca6so34975925e9.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728922816; x=1729527616; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zLunCdkx3a07Yv3a9pkayhs6ZabqWLoKKSqyiMZXiZQ=;
 b=iSGwLE14twqf6z6BXiWI4C/Ki2mK4Rm9zLCkKmrvKItrv9oS6VJOjLYPcv8cg/u+su
 4SBhKY4ukMidXfAityE24MhG+k8e2AhaSNDF2TaBmb6c0atdz8tSH3RYkYfgsdAppX6x
 pCu6i02YAML62Jv20MT6eKkB6jfAUyJKRm1taansdnaFiYOSVJOu/2c0EwE4qNwWeePN
 mKHjlDAVUG9VvRD1t9znF2luA0dmmgfBqSE5NHennb0AIwUKlDACCvwh7ZLLS0udqef4
 J6LU1xlD8dYn2Kk6D7h+R3E7OZreu/xACupDHU8APdacoRY2NZgMDLZ6eOTMmUQtiNzH
 MHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728922816; x=1729527616;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zLunCdkx3a07Yv3a9pkayhs6ZabqWLoKKSqyiMZXiZQ=;
 b=jKa3PyQGSzfhoQRZyZP9RIpJW4Knsd1GkD4gjMTBEJDB1vuP1URkMYJIHv8wCafAT/
 SPw5mMPGVXeks5q32X4Xif3OthY7l2lJfO+Suj9SCowEievCrKRlyKHt3d0/d3NljCvv
 qnoVE6/T5OBsZJ9qW66AhXeBaS0SPCKX8knDE6McHMCtGLZuG7bLHmvyvKgd4SnBR4hV
 uOryG8/4ZKW6FkH5ajxjz6MshvzKnHTr+GU6CNv3I00I4ENLhU+Meq50oiin+LRMIAsb
 F+MQowZB6SxtY2cNZkHO4+ezc4PLMvWOwlQSD9wb4n+XHBjX0Vp5yiVwJdEQHZNxQeJL
 1HIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxtlVEOmj1OJUEkALexEjlOscaESi3VitoQdFXxE1iqP9HSH60ID6LuT3Ei08AR8IuZcvreSk=@lists.denx.de
X-Gm-Message-State: AOJu0YzuQbqlr14WBDllBXh9rG0iLBgMv1Dt5/g3z0cgwvPVF/5nVyej
 mqliz+uMe6BdMUxA3B0/M4eq0hTa8ndJa+37MJ6DCi46rZfPQX4kHkEO0RHeCVA=
X-Google-Smtp-Source: AGHT+IHbicsqoCdsdNpdVuADsIq2/PogFgdIkqMn+vSwo3g90O6XSraX0+RsgBzFQwlRxZZS3wqodA==
X-Received: by 2002:a05:600c:8714:b0:430:57f2:baef with SMTP id
 5b1f17b1804b1-4312561a03amr86543275e9.32.1728922816412; 
 Mon, 14 Oct 2024 09:20:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bf3:bb7:467:a56f?
 ([2a01:e0a:982:cbb0:6bf3:bb7:467:a56f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf5188dsm155948095e9.24.2024.10.14.09.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 09:20:15 -0700 (PDT)
Message-ID: <bd22c304-18ff-4af9-b8a3-e59a89e0debc@linaro.org>
Date: Mon, 14 Oct 2024 18:20:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: device that supports both usb host & usb device modes?
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, u-boot@lists.denx.de
References: <up3oe2ackjkjzugqypzcjzmqs4lgktbhn677lorwmztfwqkki6@s4z5orfn5ca7>
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
In-Reply-To: <up3oe2ackjkjzugqypzcjzmqs4lgktbhn677lorwmztfwqkki6@s4z5orfn5ca7>
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

Hi,

On 10/10/2024 09:31, Marek Behún wrote:
> Hi all,
> 
> I am searching for HW that supports both USB host & USB device/gadget
> mode, on the same USB port, capable of switching between these modes
> at runtime.
> 
> Preferably supported in upstream kernel.

The following commercial dev boards support dual and runtime switch on mainline U-Boot and Mainline Linux:
- Khadas VIM3/L (with external supply)
- Odroid-N2(+) https://www.hardkernel.com/shop/odroid-n2-with-4gbyte-ram-2/
- Odroid-N2L https://www.hardkernel.com/shop/odroid-n2l-with-2gbyte-ram/
- Odroid-HC4 https://www.hardkernel.com/shop/odroid-hc4/
- Libre Computer AML-A311D-CC https://libre.computer/products/aml-a311d-cc/ (with external supply)
- Libre Computer AML-S905D3-CC https://libre.computer/products/aml-s905d3-cc/ (with external supply)
- BananaPi M5 https://wiki.banana-pi.org/Banana_Pi_BPI-M5 (with external supply)
- BananaPi M2S hhttps://wiki.banana-pi.org/Banana_Pi_BPI-M2S  (with external supply)

Neil

> 
> Has anyone done this for example with Raspberry Pi?
> 
> Thanks.
> 
> Marek

