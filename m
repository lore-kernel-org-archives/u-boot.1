Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA775CD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 13:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477C884944;
	Fri,  5 Jun 2026 15:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="putBu0eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D5C8496E; Fri,  5 Jun 2026 15:09:31 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A37848A1
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so12826675e9.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780664969; x=1781269769; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Ml6RUZLsybLtaNHChJJrlPVejcPlGSwv5i9HQEZLVXk=;
 b=putBu0eqjoM1y/GcN1UPeFUxebHhLlq+18LyCkCYBXIcTwe2sFyfcd9362ECYWG004
 XPe6DvbKNT4KZqw7eKbeewVsMZ0R+fl2knY3t5sGruji7FR2Ujo8GG++9/YeWbWMeQeY
 1BfK1fbEUvh6XAtJTu7jWp7Tt2nmXv3nQwcB1a80cwlv/+FgTGtqtRsSGTz2yJk5UJw2
 OOKV7js4pp5nqNx7gzchZ3hYKvQg1jBA45HiUgQ9UA9lSOtmZTxYB9VM39n2ycWchDYm
 TF5IZsWlaLzsISnqB71pFQxWZ7qQAnq0AMqBqMSRrV70kiSrVw9aO2yRus/saqt8DMQn
 AKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780664969; x=1781269769;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ml6RUZLsybLtaNHChJJrlPVejcPlGSwv5i9HQEZLVXk=;
 b=kYeke/ShpDJAkhFWjbf2/Rtkwv2eoYQxisj3mp3PjTsLNCFuhlMZH2E4tSlN3sEFk0
 /ynt/WcownUpbijBAl5o+OjuJxxhFx8EvmqE7HPIWBlt6d6FIMOilkrzJK21sULMhjEA
 M8on1KLKZgQdpXB1mXsipPhoKYH/sqGxo9Qs1/d5tf2tpRTddD+LQT2DAQ+//bX0/r38
 GRD2YxSfBlxty6ub82cfDWY0psVcbjakx7zEG3IYqmhCcSyeG5qxlasJb9Hfyp/N34My
 WvukK87+oy4TJO6/uoaytSXkYKcdNuEyrmaO27fjy9EUwNs79LsO4PgHYpA957JbrEv8
 6Vjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hg0eMWu8s3igLUvhFMNFr+D1nhT4y1I4Fj+TygFrW6rlro1+0KZ1xuGh+cf17LRmqRxstEFI=@lists.denx.de
X-Gm-Message-State: AOJu0YycsVLkJKjFpLSewpSlFWsasAMVc4MrmYK7jJMe5gz+RCIhbxbs
 N6lc4pXwcuApVRovGONrIFOI10J5l637KqDdcgxCjK5Dgcjy2Yf1JpakkJUrBZLhRvA=
X-Gm-Gg: Acq92OHRQlbSlftmEgdCC2ratrD66Bj1e1AE31BjLsxhRXa4F//r8LSPVfJE3cDFTsq
 yQQE2ctMAiVlpUmt+xH/Z34JZHDyPMNhyF3Khjf1XWyF1Iuroyi0KxqN5ZBI04e1v2MfkZofRpw
 k34QKsV+GxLCVMYRpaasuH31qbfpQJtPQmIx3M7b6wA0WOefiEguadcfF4+1HtMh4nXz43u0gyV
 Y5si4nsd9CBwRaZ/8BHw/kHFckJmbnkJ/s+eKgqadAyZtgmUvZBWXWh4bfJamC2s+eCLaYXwPVg
 4Yfxb2TPSfKucJBEklkSYTaiMhUGf35z/tKoKgNJMbfvUZ8+/9zeCz0AHZbhyOJu+VJkqCOhPz5
 Z4qo1Ok2SDJ4eCr3RThV0h9TsrPnIPht4CVmfQJsfpweic3uVzy0RuRYPmaOwsGrWVgcLszsdcm
 ZSRQF0Gzng0kNAqaI1bTUIvX3TpsEILA7gNvzCCmPkuJXuX6FLXyCOLy5dNDiVY0PLvzgJ23an4
 I3eyPML3nNMWEhxqw==
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id
 5b1f17b1804b1-490c260f3cdmr52545135e9.27.1780664968853; 
 Fri, 05 Jun 2026 06:09:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668?
 ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm15893188f8f.7.2026.06.05.06.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 06:09:28 -0700 (PDT)
Message-ID: <ff8193d7-d13a-468a-a78b-2fd20935101d@linaro.org>
Date: Fri, 5 Jun 2026 15:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 08/14] power: domain: meson-gx-pwrc: Staticize and
 constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-8-marek.vasut+renesas@mailbox.org>
Content-Language: en-US, fr
In-Reply-To: <20260508122247.512862-8-marek.vasut+renesas@mailbox.org>
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

On 5/8/26 14:22, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot-amlogic@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/power/domain/meson-gx-pwrc-vpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/domain/meson-gx-pwrc-vpu.c b/drivers/power/domain/meson-gx-pwrc-vpu.c
> index 1c56e8508c3..325296b0dd7 100644
> --- a/drivers/power/domain/meson-gx-pwrc-vpu.c
> +++ b/drivers/power/domain/meson-gx-pwrc-vpu.c
> @@ -262,7 +262,7 @@ static int meson_pwrc_vpu_of_xlate(struct power_domain *power_domain,
>   	return 0;
>   }
>   
> -struct power_domain_ops meson_gx_pwrc_vpu_ops = {
> +static const struct power_domain_ops meson_gx_pwrc_vpu_ops = {
>   	.off = meson_pwrc_vpu_off,
>   	.on = meson_pwrc_vpu_on,
>   	.of_xlate = meson_pwrc_vpu_of_xlate,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

