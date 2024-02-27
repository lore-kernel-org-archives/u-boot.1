Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD378C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 555A287C94;
	Tue, 27 Feb 2024 14:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VkREIxX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEB387FF7; Tue, 27 Feb 2024 14:38:35 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92ED287EDF
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412ad927275so4167065e9.3
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 05:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709041112; x=1709645912; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=0CdQ4/Hgyvzk3UCjyq88zPjz9SAcY+jYYLOA4hojJ+4=;
 b=VkREIxX/3tJB9MX4z9UjW0cT59OIprChGhQPyknSvXAQjtpgxx9NzGto/Cu6PjaLp+
 AUiADhjRpfDSxeXbBmSRLF3oPqPFhiBdqSHt586+rgOeyN+yg39clYcTE1NOByCKwhJP
 SseegkTLzPP8yrG4h9+9KK3MRPS/8SQ01DKWnbKtQgfQ+nM6f+01R10QsOjvkR0J4ueW
 shug/w80UkIdeXqDeoOM87/x0Nc3HOvjDylgeo+vcnRIqNsXIY38L6B6gsKVxMv6zLHA
 WZjLI/WtFo3ktxO6CEE5Glihpa2IUoP4eisM8skTTP+zi35f1Jgo/90VjWac4yGPuA5p
 vjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709041112; x=1709645912;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0CdQ4/Hgyvzk3UCjyq88zPjz9SAcY+jYYLOA4hojJ+4=;
 b=ce+pZTamqTrNb040T0Gbey0ZBzDZheyENKHzG78EoW28su5CrAoECveSTNrc4M3iZl
 qM17RJD++lv60dH8mTMjVAkU4l2N8DMr/Z/NHsqYQqRC59hDoF6lgsZKr98TSnyOMkLd
 mQJMN91jeQ7RJUq3STfPsr+i2xEXhDAa8Ka7ekFxBogtxIxk1fZJUUHdEoFhbmIcIHL6
 ew3Wcc8CvosGApfM7VR4CkLEl2zvTIgNJgqK46O1Grb77RmK2nZ6s8ePHSxd6Vciewig
 moqv/YCm8NNGX5A1DyZZKDlU4dy+DJ+J+GhiAnjulxHYmTEfOPkG4iTWmQ3t/9wHD7y3
 KWTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgRWTwRwKRMTIi3EDIZfTKytA7DVhMRzi9AOVudzoYXdX3mZJbedCDynBY6RgpX+wEjZ6MBjItlNqp81HMK8I0fh6FDw==
X-Gm-Message-State: AOJu0Ywt77AVUKi64TJnkKEby/x9S/68fZOj+QcpMDiuWriANQSjhpCs
 B0G+8WiNhCALE+Dqbs9m9FggYNMNeBfvTjAdXS6gxKBBmgtSDn+VdfiBAm0mzVY=
X-Google-Smtp-Source: AGHT+IFVfs2AU9hSrINcdJEhaNoVykQcYIj3k4IFCtS/jvv0eDaNtS68+iAFO586Js5LEsSS/+SXWQ==
X-Received: by 2002:a05:600c:6b07:b0:412:117d:949c with SMTP id
 jn7-20020a05600c6b0700b00412117d949cmr9553196wmb.41.1709041111945; 
 Tue, 27 Feb 2024 05:38:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:68ee:e3d3:74d9:c0d1?
 ([2a01:e0a:982:cbb0:68ee:e3d3:74d9:c0d1])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a05600c4f8100b004127ead18aasm11485160wmq.22.2024.02.27.05.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 05:38:31 -0800 (PST)
Message-ID: <6d57d749-7967-4475-b84f-326bfbffc5f2@linaro.org>
Date: Tue, 27 Feb 2024 14:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/3] board: amlogic: jethubj100: small updates
To: Viacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240227065551.580199-1-adeep@lexina.in>
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
Organization: Linaro Developer Services
In-Reply-To: <20240227065551.580199-1-adeep@lexina.in>
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
> Update JetHub D1/D1+ board support files.
> 
> Viacheslav Bocharov (3):
>    board: amlogic: jethubj100: fix common config header
>    board: amlogic: jethubj100: update MAINTAINERS
>    board: amlogic: jethubj100: update docs
> 
>   board/amlogic/jethub-j100/MAINTAINERS | 2 +-
>   doc/board/amlogic/jethub-j100.rst     | 9 ++++++---
>   include/configs/jethub.h              | 2 +-
>   3 files changed, 8 insertions(+), 5 deletions(-)
> 
> 
> base-commit: d49fa3defa50c6d3f04acbb52fd486c13c14ab6a

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
