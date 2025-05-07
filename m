Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7851FC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ADEF81F32;
	Wed,  7 May 2025 14:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ppvui7/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ADC8820EB; Wed,  7 May 2025 14:01:47 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A808059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 14:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so58130105e9.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746619304; x=1747224104; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=5/EZs/5P3xPz8a1FS8ijckX7N7lrxVsTDArOdHFDVOU=;
 b=ppvui7/WRTONcwFONlPnEDX1H1/+YDZZYyCn3Af8H20anpW3VLnZajdFoBRGSv38l9
 gHe8hWzObMuKXKoDF7LQ+ZUqNO7HWujm0QNzpK25fQliLUt8agT98wYVpR+IBXGx3FJQ
 K78BDNkDXj/rUiM4wycEhyUbfC/jAazBfFWG5h5zwTTIJ7YRpAbk9KZGjZqoE9IjB842
 0R+SQUzEJkjmYE8TfzMCj8Ro6o9+qoF2TLSmtNZYrZS+9BTWTIHqMslZemGTKmeP5Tun
 G+Mwxtd2Da9FcvV4mOywW/aV1/H4U4dZ9PHQzrHOUgln5Ozor46Pz4KkokYp6e/sw+dl
 FKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746619304; x=1747224104;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5/EZs/5P3xPz8a1FS8ijckX7N7lrxVsTDArOdHFDVOU=;
 b=WkfBepHPRZOLRLf4qwY4KByZiZFFrdUMZz3q2hsj2ZbtS2AP2L3UYgXLnIR/ZOenmX
 DlGmMmmIz/kH+uO0fsqT8UI9AqREeZY/91SVrsPNWymcmUGg0T9Zvbuk1eT5Pih0/2LN
 yZ2buvy9TgK+evdVjwcVHXmqNd8bhkSGnSdK+sb8beRsHcvSjRIrF9RyTv0McVrocpVP
 UvSn9TwGepX1DJlP/L082L2U6fEiWK0G/nvTCJcSppEEcZFR9VqX7aQAsuMRS11k0+mg
 UGCZU4RyPfQUjLNDPvbIOK/agRnkhnWD+S+OKY7wcoYFO4/0xq4NVrSrdy/e5XgYdVYO
 xfEQ==
X-Gm-Message-State: AOJu0YxfJu9oxKg1dQlOFdGDRNx9GWVXJD+yU4QTXZ+TR8dkDiHiKHTP
 7IebqZhuKe0TTHDVfKfpptLqjpApQHUzpZ3SrY/lwkfNDFNfnFx+/ZEpwl4CihQ=
X-Gm-Gg: ASbGncsUkghl0u+Co21xTWsDN2h6eQUsUuydIy/y+6DaVsbOCDaXKUTpQdyvDIvy86S
 hlsxHmTyOxZ3UmKWKBJUhFRdrheWAQV6WpEh0rEpjy9YX3YfWHTvq7hnZ+Y0kbs+CnIKiCFWPxe
 Y7sd8KG9+H82TClEVForNYHdKOiIzENSs1RUYGLUjqwIn17LO/MEdZfBu3MnbhuTy+aSeVXzu9j
 i0yOfDRqRDk9FOo1UC/3P3X5hlQ8RAC/Cpjvp1+zl4LLOuitt/IvwtnVj/gYdK/3T4PnnvZWw4j
 E6wFZhowL4hK2wxdN8p3EDuC5ad74cEfaBhERK807PATa0Kb6dzswdxg0Dq5R1Rv0bmFFyb4EmP
 wG6OkH/vVYI2WWxxPog==
X-Google-Smtp-Source: AGHT+IEm9H6jOdRU5tvuHDlvV9wm5h68WGhM78RvTo/EH/a9N5+wvGGtt8QPEz87ONNk1Kif6Dl5ZA==
X-Received: by 2002:a05:600c:1e24:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-441d44c7d80mr23917915e9.19.1746619304392; 
 Wed, 07 May 2025 05:01:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:784f:3312:6406:12a9?
 ([2a01:e0a:3d9:2080:784f:3312:6406:12a9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d441559dsm29877735e9.34.2025.05.07.05.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 05:01:43 -0700 (PDT)
Message-ID: <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
Date: Wed, 7 May 2025 14:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: Odroid n2+ usb broken on reboot
To: Wayne Schroeder <raz@chewies.net>
Cc: u-boot@lists.denx.de, "u-boot-amlogic@groups.io"
 <u-boot-amlogic@groups.io>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
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
In-Reply-To: <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
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

On 05/05/2025 15:12, Wayne Schroeder wrote:
> If I add the usb reset command, it works reliably at reboot, but it
> does not work on a fresh power-up with that change.

OK this means there's a dangling resource, Does USB always work within
U-Boot or it breaks U-Boot and Linux in those cases ?

> 
> 
> On Mon, May 5, 2025 at 2:07 AM <neil.armstrong@linaro.org> wrote:
> 
>> I think it's a very long term issue, USB lacks a proper reset at probe on
>> warm reset, does USB still work from U-Boot after the reboot ?
>>

