Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068C1CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5606C846CF;
	Tue, 19 May 2026 11:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qEIYETMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD4B846D0; Tue, 19 May 2026 11:43:35 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE1FA846C6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso40816275e9.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779183813; x=1779788613; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KBkUYeJgWwdH7DrbZ++pZZcI5hj0XkXBHVfCpkjQxzQ=;
 b=qEIYETMrv8qziwHs4u/d8orrOEKJBOi3PiXOawx+wosalXm4qGqpJGoTDlj/V6W6cY
 GG9o+4y4ODiJhBuytOuU5K2jeCm0XkkGfQ5BpfOAjrrLyzRHupQ9nwV4PY7ZBhgTBjcI
 zPapD53PpdCG1kF3rIS4vzRWnTx5EzGmMo+tg+IZ7KBKiYS8XRQhUGKhzJG/ESmAcysx
 VMVDfWcbjSJ54Jpm+sYSbml+ZTUguF/OdYq6poMV5DIZ/sKnFfXM0Ykl71kGC9uU60Uh
 UrYGmtzcTkwGcmihzANSzRLdaxwUEZfNs93mCUNsQG1tQV4tIG9MDkFvGlgooV5lJW/q
 1iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779183813; x=1779788613;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBkUYeJgWwdH7DrbZ++pZZcI5hj0XkXBHVfCpkjQxzQ=;
 b=OPdMKzktE3pMvYkQIjXX9cX58ABA5ZHTe9s9fflLPo1/7AK+Z5r53xq4/kzClInER4
 +dkth+hn5Z8YFmCts5rQ88ymOFPYXQ2KgzW1GO6PEliMMz9EjnBmUURyhyFfNBnyO2Sd
 o5Bsyh6HgXj3Av77MbYeAvGyR1zjUtK6VCDvcQqjFsvamXXgjTdLePAr/A9WH1Ekw7Yg
 V+NIeUqMmDfRRNdQ9up17tIl3r3vkHVjbBCkJRkYtbLg5VTosmQQqRJbozS1DQ1xiP7z
 ojyn7UHodgVQK/h6Eba06YxkSe5ucnSo7AOpKhTPx3YGnUByLJcwfWPjckyurwnGGFMj
 5pVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FmzlyLQD2Mt7HZOX+jNJl5Uovhc0llOqi/Wvjkinsnw2S24oPIcC86EGoQpxgpa75MDBloFY=@lists.denx.de
X-Gm-Message-State: AOJu0YxjH/P/AYmhdqzNXSojX+kdH9cmf1keCijKxcIwaI5GlythD9e6
 zGhwvx9bhdIg+nf47+wBm/xYsyUGfmH8k75BzRRmHVwK5Y6mi6HhkApWf8NAHBG98zE=
X-Gm-Gg: Acq92OGrS1XIHzXQsL9glQx3dFhv7j0hdE2CxoRmp1xvDOmHRFnN/hljkBTfwYCBKgi
 p1rZMGuqEC4rRHyLAkTHpfwAB0dFPSQn5NZUMCpa7cF+GKRFvmbjVa4ytzRIvsEOSndTXIEVGbc
 UVjIPBKoZDtGzCccCZyWpwH+9pa1Y4Oo4kY79LF6Zmm7UWTAqY137icluKoAM4qU/RIcWyF/8Ux
 T3XrwSJ7fGjst38Y4JWZT8Oh5qBtbnkAt1U+/JYiiFqY/SjqHnos1AAjfN6SkoDmxsLJ7cQAvMn
 PZGtewnCaHLl5r0SKtUZry2XwbhCE2xQ6rmIkhG9OxM8UfK7bZK6hSWGj8/SHqYVuMEJs4Xyy6N
 urkdVQDFpShiK8E4UctbzRuMBcsSTN3yH+k7vizzwz3DzOC8MPgdzX4TIwvq/B0ZpHiIh80DG4/
 NRRdrrjzHPbfrOQb/xG7NEB7LT7cRhyiVIbFsJxZOQNf42hWR5tsPUIBI+jEId6hbRpWIvVn1/C
 E3L
X-Received: by 2002:a05:600c:4692:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48fe6325978mr291423965e9.20.1779183813263; 
 Tue, 19 May 2026 02:43:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf80d04sm102642765e9.36.2026.05.19.02.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 02:43:32 -0700 (PDT)
Message-ID: <dae53987-d05e-4d8d-9999-842b4131f204@linaro.org>
Date: Tue, 19 May 2026 11:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260508122128.512798-1-marek.vasut+renesas@mailbox.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260508122128.512798-1-marek.vasut+renesas@mailbox.org>
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

On 5/8/26 14:21, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/nvme/nvme-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/nvme-uclass.c b/drivers/nvme/nvme-uclass.c
> index 44c88ad27f3..4ab9567450f 100644
> --- a/drivers/nvme/nvme-uclass.c
> +++ b/drivers/nvme/nvme-uclass.c
> @@ -44,7 +44,7 @@ UCLASS_DRIVER(nvme) = {
>   	.id	= UCLASS_NVME,
>   };
>   
> -struct bootdev_ops nvme_bootdev_ops = {
> +static const struct bootdev_ops nvme_bootdev_ops = {
>   };
>   
>   static const struct udevice_id nvme_bootdev_ids[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
