Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B3DC54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 09:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4132487073;
	Mon, 25 Mar 2024 10:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DnFkY4YA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5975877FB; Mon, 25 Mar 2024 10:41:22 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D28187061
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 10:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4148bc73069so1336965e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711359680; x=1711964480; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=0L2naDWR5wSXzNC2dSz36D7V8qn+x0FqAk42bj0OH9c=;
 b=DnFkY4YAtdXAuR5XpT5SMF31Idp+YCLF4dxvt95X3jGWZjxyd08xrGhHBO3+HcGop0
 R+9hiJ/oCutRKNT80X0N7GdlTaFJzwsSPOQanrhPdkegllU5ecwAhJKohHgDa1unct8y
 emQmoKEG6i5GSEu33zZzAuf6Bm9ey/vIqRaZ3OA1VxzGoYwtb5SiMqNXs5bJ71CxobvV
 xa8NzXKw1m4OMUEnAcuAZ54gYqAVvvhQOig5q/T1lsn4ImUQ6hh5vSg50HEMK30ulu6C
 MAlY+HcKeGVfTQ9Ts3FDscsrKcKpgUYhI9hE0jmLafPLuGHooODpnkFdvF/MywtSwqmj
 Pm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711359680; x=1711964480;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0L2naDWR5wSXzNC2dSz36D7V8qn+x0FqAk42bj0OH9c=;
 b=CovLq0y1Cz5OixqlIxFoT19wq3SgfM8yYNRVKj6BzXp5s3yqzvJJTACD9wpAQlpjtZ
 E+I+8iusqahEH3IjhO7KW32yBH5qdZorUwyIApkKYIUajnRiZYPdRItB9AZRM0MGQiLv
 Qly7quWoGC5Cu3ziVtsN6HWHLu8ml5hjk6Q0qz1Quu+7fZdyq4bnewbMSi10iLQiLw4s
 QclQKiAkQUuypDBINijfDdph31MgCsJ9pczsRU/3is2r6/BTVcV9Y5o7+e1OZMbG6P0q
 Sj2a5OUiQj5A+p8wxYZaF+nHkZOXe71dswhwCdzfQ0MwTX56cf7KtQKURVj7rUpa4kJ8
 viNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs03gOEDHcnUSG6IBH2M+ROZXAnGtxkHmxay1zB37Tl0srOuxxxaMp27mxd2Y9FrBHBsENk5keozLLwcZQL/u3Fl4y9w==
X-Gm-Message-State: AOJu0YztwG5P2PTTTU1i4AFNf27EYGEyZ9wIfMDc0+uNogEhdeCzsmvz
 +Obv+Y1WVdVZ8r7r5mjvh4sRCR+jVKNbeK24Tc3ixnasvps5CHQuBklSTAszRac=
X-Google-Smtp-Source: AGHT+IH0QmT9/nORhVQMFmwvns4C4b1sjBYYfJzE4CJafUDlI4gKu3gmqhkqJ5Ipf853rwlMlr2CDA==
X-Received: by 2002:adf:f8c5:0:b0:341:76bc:2bfe with SMTP id
 f5-20020adff8c5000000b0034176bc2bfemr5893140wrq.4.1711359679582; 
 Mon, 25 Mar 2024 02:41:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:32cb:35f3:5930:592a?
 ([2a01:e0a:982:cbb0:32cb:35f3:5930:592a])
 by smtp.gmail.com with ESMTPSA id
 ch19-20020a5d5d13000000b00341bb338407sm7655387wrb.99.2024.03.25.02.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 02:41:19 -0700 (PDT)
Message-ID: <82a76f25-b532-4dac-825e-50d4d5e9e5b9@linaro.org>
Date: Mon, 25 Mar 2024 10:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 3/3] board: amlogic: jethubj100: update docs
To: Viacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240227065551.580199-1-adeep@lexina.in>
 <20240227065551.580199-4-adeep@lexina.in>
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
In-Reply-To: <20240227065551.580199-4-adeep@lexina.in>
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

On 27/02/2024 07:54, Viacheslav Bocharov wrote:
> Improove documentation, add new revision.
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>   doc/board/amlogic/jethub-j100.rst | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
> index 86acdafa06f..80bed6e919e 100644
> --- a/doc/board/amlogic/jethub-j100.rst
> +++ b/doc/board/amlogic/jethub-j100.rst
> @@ -1,9 +1,9 @@
>   .. SPDX-License-Identifier: GPL-2.0+
>   
> -U-Boot for JetHub J100 (A113X)
> +U-Boot for JetHub J100/J110 (A113X)
>   ==============================
>   

I have a CI failure: https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/jobs/804174
/builds/u-boot/custodians/u-boot-amlogic/doc/board/amlogic/jethub-j100.rst:4:Title underline too short.
U-Boot for JetHub J100/J110 (A113X)

Could you check and send a follow-up patch I can squash on top?

Thanks,
Neil
