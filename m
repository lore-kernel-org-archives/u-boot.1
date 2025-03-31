Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D26C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A720681DE3;
	Mon, 31 Mar 2025 15:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HqXIip1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F4FA8144A; Mon, 31 Mar 2025 15:52:44 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC0081EC0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so28176775e9.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743429162; x=1744033962; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=OZGH6oqhaOMGfgn0djiX4EknPYTTQlfXYQOvQchkMZU=;
 b=HqXIip1U6xufm/eTBysIiXwncCJWuOHmTWnCQWwUpb6VSJmpnxekFwDeoVM2fH68i6
 UTBGkHyUhR8pHnV9shkp3e9tR49BtkAMdeQXnE0Tg49IxYOYmSCuQxlzPoaDpZ4J8VH4
 YSiXapEP7B3To0tb/RW3jEf1/qOXEY278B8TVJhWDnKiRzljcV1P4tyyySHi8NrO3Eny
 OAXahiHluhmVrGGLSSWzLFiO8K2T/g4YaUvs65WDUxC2WyhJqoOx0l1YSFhYfnKXziqt
 wvl+vFG2Z2H2YjDu53n+RJ68m0NLbpIqM+4xEDVvIkJrGO4LTlpbU14wCNm8mazEXGxk
 f7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743429162; x=1744033962;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OZGH6oqhaOMGfgn0djiX4EknPYTTQlfXYQOvQchkMZU=;
 b=SbsouJH1ym0DPN75IAE/S9vlvntFhjMeDfBtl8y+b77qmwKXZjXYYPgU2imribzFEq
 GfQkyOdcb/iKhXy164T3Oamwbgu1dAnQhwIl8htggUxIxQic4ENo9zAI9sdTnoYHylZR
 o+ycBM8Qcc5YIsuYIi+WEVIYeGEtsbAC4xlCRYczILVGr0WkWTCIFpdwznXRnCpJ4zRS
 f0i44/b6ld45AblWfH+W322hSmrEZsQlLizHy9FnS2IxpX7ArltoYcuAhPEe0ImfJVLQ
 PuvQiz9LeIr6eBGaUU/4VKhhtE+GQ8eNQNSXpldVgjf0sCGib2Ia6gL36IbKQI28QH/8
 X39w==
X-Gm-Message-State: AOJu0Yw6Mt/M4ttu3FZnkAhEEliK5SsTbTEcyaEpCxR2KYLDJ+M7NdZn
 gHOvErETx/ksErLwBBWiIvg1fgiTDDoBK3ecJkggzHNX3wsC7QIkvYB8PHk6jRA=
X-Gm-Gg: ASbGncuZj88NMkHlZRiYIcBSjmmg74Z7ZcAJGJzVwqgCkr0MU9ZKBqm0h/W+punWPUb
 FkUZi4vD+J7LXjdDE4rOl/ByxUwOemOAYwwsk+gsv2KYUCpKfL6QBzb+yHQ0+YKk9SAh0dpazh7
 blfVYOS9lTbOrydMehv+QEmCE/sHC89seMHYCJY2Bx947j5GsblBtab8pnMg/jIhUEguhVmHQxc
 FGBWcWJ7UIZ8IP2CRAbh4ikM2+6jhTwWbJrC0ibEJJis3R7k9YE7jnXOqPPRyjj7WrBToILfxyY
 NIQV6kiVZwId6sZ+R7kmLqdPUEL7qDFym4lJnJGS5FDtyp20wO1mQxRqKPUVx/qF6WGcwZ4FPUr
 8zEY9+CXeHDRsoSKc
X-Google-Smtp-Source: AGHT+IEyVkcchXEKx8WnXHZh31zwh95iyiaPMAaulxiblOgWxwZK5cNFQoUv75pv9V0pLgduLsDA7Q==
X-Received: by 2002:a05:600c:4f0e:b0:43c:fa0e:4713 with SMTP id
 5b1f17b1804b1-43db5fbbcadmr77601665e9.2.1743429161675; 
 Mon, 31 Mar 2025 06:52:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:143:2e3d:45f1:fd2?
 ([2a01:e0a:3d9:2080:143:2e3d:45f1:fd2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba3e44sm127467715e9.4.2025.03.31.06.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 06:52:41 -0700 (PDT)
Message-ID: <69b9450c-3109-4ed9-a965-4b1c1dbe4a06@linaro.org>
Date: Mon, 31 Mar 2025 15:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/4] dfu: scsi: don't call scsi_scan()
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-3-afe2e3696675@linaro.org>
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
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-3-afe2e3696675@linaro.org>
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

On 26/03/2025 18:40, Caleb Connolly wrote:
> Calling scsi_scan() results in all the block devices (and EFI block
> devices) being destroyed and re-created. This breaks the EFI filesystem
> drivers during capsule update.
> 
> Remove the call, since boards really should be calling scsi_scan()
> themselves during board_init().
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/dfu/dfu_scsi.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dfu/dfu_scsi.c b/drivers/dfu/dfu_scsi.c
> index 9f95194784c1de00458843276872b1d23d023444..a234548ae46dc2a6ae1ca5770accb58f43782239 100644
> --- a/drivers/dfu/dfu_scsi.c
> +++ b/drivers/dfu/dfu_scsi.c
> @@ -341,13 +341,8 @@ int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr, char **argv, int
>   		if (*s)
>   			return -EINVAL;
>   	}
>   
> -	if (scsi_scan(false)) {
> -		pr_err("Couldn't init scsi device.\n");
> -		return -ENODEV;
> -	}
> -
>   	ret = find_scsi_device(dfu->data.scsi.lun, &scsi);
>   	if (ret < 0) {
>   		pr_err("Couldn't find scsi device no. %d.\n", dfu->data.scsi.lun);
>   		return -ENODEV;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
