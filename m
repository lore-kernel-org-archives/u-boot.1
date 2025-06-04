Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BF9C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 12:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 028EE800D7;
	Wed,  4 Jun 2025 14:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="izkK+pAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EBA803DF; Wed,  4 Jun 2025 14:33:19 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BE780050
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 14:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-addda47ebeaso592205566b.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749040397; x=1749645197; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=SEVfxqOV0wXJXE42NG4zPYPud7wXVlDhd2ZFA14yEsA=;
 b=izkK+pAzNASyewfpgGe7lbKockG29ACEZicTxJbJG/ytF9sHpXIU1C20UbWYOtDJz4
 VP3tNJLW5jB2xBZBT6+9ICXdmMn0aIm0sgZcC5yNlhB8IpNkh1KB2wCqwP9dTvfmnrhE
 FxBgRLwfG9kb4cKRaG8s5SvGBtQct+pRXsI6gAu5JPV5enrtULTBQxSP4Rw2Fh/Dii5r
 P+oIlTaGvaNKv3gAFfaQdQbc+hL/YulxxehqV0+h1Uv1QMerMIDmSSXb+4L0zTZaeBAq
 ystUOW5VvyIg8J8l4DzLLx7aWg00cvGqmhFsYv7/hWR8Krj9/XvFnNV++iY9DWTvkBg/
 cLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749040397; x=1749645197;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SEVfxqOV0wXJXE42NG4zPYPud7wXVlDhd2ZFA14yEsA=;
 b=DmcjNhiC0ZTBotXXCd3Pg3mtGvl/R/dqYmQoVcmOtKsNU8VYfsaGPAHL4ZCBrKTXvJ
 1M3xXQHbdYGbsbZDRuntN033R2KLD5YWYp40FSDy1gAPKeQ7KpmZypOvGZltLKutLmD+
 pUY76eBZSP213qK/fkvSVlY6baWQfcAYcLP6A4hJsY8NV5hrhevzYeHofvDESYtYzYyH
 1aKH2NFYrKQcUfi0S3dMPRH7PCYsfzH/dO8+ziBcmUbQHFNLGdSvquXdZpyo/NVXGHLd
 p6RVrqgDqXzbhFf2SmlvijTmeA2kFaHXJxB05KRioFiq9dwYdE6ipIbDukZm5mVy3e1j
 rS4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6h/LMnWtfTQcMfjvDtjKgXoSs1R2XDfKV1wiryBcdHO1h8MqdugQGZtW5s9LO+2uAwXTVVMw=@lists.denx.de
X-Gm-Message-State: AOJu0YzdYJfZkpA+SaSRpZ3bz/BA3aIDyYNSvxoQHdvNWIZ/TxNOHqLZ
 Rswo5P5/RH6zW+hf7JygmerQS88JMWyvwNVQwo7i+/kyzFzjgh3BafZZM8szAAsyUfk=
X-Gm-Gg: ASbGncseQ2WkWWplogVuTgio2OCTbds7C8NwE7G96s4NfNbMg1mcr6TTlpPY4ukrWbS
 o0ZZJDnDpJXx4b0PAWBFmqnk4N2uNe8r2z3vzrYYCWstbuhnwZdkJzLeVEAXNcq9FZX0xrWOncm
 Np8gqJsY0E/7aS8he2ZSS5tU8W+8p68kbTPSyreZ2wRecCygwmGmARW5bQcdY5irjUftCKy2uzm
 JMsic8EWBb3h92h+ORtGRWZrWGBXn+HeAFJu6rYJncd/9u2N4ZZjeClcCKMHbmZ0alYVhjhthZj
 IAsgBNcTbrLc0jk6h8XkrtLQvHVUow8JfHgu00RxxFTrfuuPx4FyC/2959cpY5mGu4J1ewRi3Lt
 bKVMw6gqwuZ5bZa9NwraeACcdiw==
X-Google-Smtp-Source: AGHT+IHNbu9PmoR74eEOPrtD5aPjguW1sXxnje7AgkEkA9n5l1w+JHHMB3uM7CEtoWzL2wJ7HqLsLA==
X-Received: by 2002:a17:906:c145:b0:ad8:8883:9fef with SMTP id
 a640c23a62f3a-addf8d8fcf3mr224480066b.26.1749040397228; 
 Wed, 04 Jun 2025 05:33:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:fef9:cf1c:18f:2ab8?
 ([2a01:e0a:3d9:2080:fef9:cf1c:18f:2ab8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb2ead829csm961984866b.79.2025.06.04.05.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 05:33:16 -0700 (PDT)
Message-ID: <e06612b5-7bfb-48d3-afcc-227b12348ebb@linaro.org>
Date: Wed, 4 Jun 2025 14:33:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] board: qualcomm: add a MAINTAINERS file
To: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250604113452.1075503-2-casey.connolly@linaro.org>
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
In-Reply-To: <20250604113452.1075503-2-casey.connolly@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 04/06/2025 13:34, Casey Connolly wrote:
> Add a MAINTAINERS file for assigning maintainership of a particular
> Qualcomm platform or board (if board specific files exist). It is
> intended to supplement the treewide ARM SNAPDRAGON maintainers with
> folks who have a more specific interest.
> 
> Add an initial entry for the QCS6490 platform which powers the RB3 Gen 2 board.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   board/qualcomm/MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
>   create mode 100644 board/qualcomm/MAINTAINERS
> 
> diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
> new file mode 100644
> index 000000000000..0c07ea2df728
> --- /dev/null
> +++ b/board/qualcomm/MAINTAINERS
> @@ -0,0 +1,9 @@
> +# This MAINTAINERS file is for folks with an interest in a particular platform
> +# or board under ARM SNAPDRAGON
> +
> +# RB3 Gen 2 and similar boards
> +QUALCOMM DRAGONWING QCS6490
> +M:	Casey Connolly <casey.connolly@linaro.org>
> +S:	Maintained
> +N:	qcs6490
> +N:	sc7280

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
