Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470EFC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2012800C1;
	Tue,  6 May 2025 09:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GWYhHxJa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C293B82076; Tue,  6 May 2025 09:40:07 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB548007D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so29138835e9.1
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746517205; x=1747122005; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xP+jscrO7V/tITyiBkislRMvRREDQt0szXFIu/X7x7U=;
 b=GWYhHxJaj+2WcGK5sFom+EoInvQF5fFllDFSRAqJtkubskqetQn5B9K2bCI0BqHiOA
 LU4vLMQoMm/rwIzqSSJBwNC4HL7G3JWb0nBmK83H9vOTNlmiQ8vuBd6Oodl6F19rPL+G
 mc0vj6kRXc+9YL87OC0mWGIH1uczZtPN+mBMe4jV5IYHLrdkrwgdahV/RNyB3wz6+vtz
 bjdOWmlBbwF75g+y1NJjYkQgOjhwwDtWlq9IrsUqkMcknqP5+DOAVgplzEQe8bZHnGZA
 nz09gB8OizVhChsu+okCwVFGtSCQF4nZMXfRd00NqTMvkiXCQnOwh0ssp78OILVBnGTF
 1Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746517205; x=1747122005;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xP+jscrO7V/tITyiBkislRMvRREDQt0szXFIu/X7x7U=;
 b=arf4YJI2phd2BHdrVexkGp6+IaLxXuVhlYiHwCjmT1vqjQqKei5hmXe5g20QCW0CVS
 dYJsLCoVFbbFnuAVODEN2DmWY9HsC/wfhBCUgvvGeb1oiKymZ6GOkCu1yEQrttHxQ/GQ
 YMh7OxAVQH5bspqba0YjvxI1s4WySGNx8lvw3Q4DczfeJmCeL68G3rVFClynqMQe7+7y
 Zg/cqli/CkFWK3xnecVuQXO6rASaJDAHDQ9lcyqhgPW8s+FH1wrVZFImhtvy9Pj17sUd
 VQiLmHX0yb28ETFG1ijCznU0/7Bakvqw/VEgBE/HAjE7HmQk+MoJYDiunsHd3s3w3lJx
 FlEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuxhRREFA8/SCHS2HhDHfuMoX9CMKCkhkep0e/9K6xgSv+HXiqnWtWtB26nkHx0YxUsBnyilk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4gCqGA8KKoaKNeehBFfXLR/zATEXs7lkjzxqtsTaGRGaDZqXe
 K/uiX+X3p8WFj6AZqMrD73Q/ZmF72hApPEj6IgQBD6tomoSwN6bV50nyAI76FKA=
X-Gm-Gg: ASbGnctB+jMR90Y+d46VE1pUgRGZoCOqhk6ZIocBfmt0v26xUAPW3ZioZiy95daem2b
 Hj++IXnWTFmdKRw0i17+ZF/uKLjdybPqR+4IYocJqomJtsAmpr5cCJH3Aa8Tgo/J/N85wKpHq5A
 rOJ9DfWD22nTogzU2vhE6tkioqbioKx1aHFhKRuqx4k7WwAAPfkHuUfp4sl8dmoupausOpXZgCz
 sLvDa/81khxXRtIz9hokyXjKx/PCBpA4gUSzo2LSWKr4UuzWadhfRlDNZZVR5fGqvQHpKwswtoZ
 2oeEAS4wB/P5oWPCy6gW6gOa73vvFWRn6rpjpOY7np3UgfzFDsvaJmaSeefJUkngQwKfR53pxpb
 DMiog/uA6RqpBawtlgw==
X-Google-Smtp-Source: AGHT+IFXUA43vyNDhST7ezUSiIs+bLkAzsB87ggeRdEWyfOcKiUCwau+x9AMsfmezuxVZnzlqy+GxA==
X-Received: by 2002:a05:600c:3ba2:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-441d0fbd2demr17167805e9.2.1746517205049; 
 Tue, 06 May 2025 00:40:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:127a:7a9e:6ba7:152f?
 ([2a01:e0a:3d9:2080:127a:7a9e:6ba7:152f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a286b9sm158003495e9.28.2025.05.06.00.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 00:40:04 -0700 (PDT)
Message-ID: <729bf495-7b72-4fbf-8ed0-4a439d3c3caa@linaro.org>
Date: Tue, 6 May 2025 09:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/4] env: Add support for storing env variables in SCSI
 devices
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 joe.hershberger@ni.com, michael@amarulasolutions.com,
 avromanov@salutedevices.com, sjg@chromium.org, hs@denx.de,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 cniedermaier@dh-electronics.com, xypron.glpk@gmx.de,
 venkatesh.abbarapu@amd.com, ansuelsmth@gmail.com,
 ilias.apalodimas@linaro.org, mkorpershoek@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250506072415.1970069-1-quic_varada@quicinc.com>
 <20250506072415.1970069-4-quic_varada@quicinc.com>
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
In-Reply-To: <20250506072415.1970069-4-quic_varada@quicinc.com>
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

On 06/05/2025 09:24, Varadarajan Narayanan wrote:
> Allow SCSI to be able to store environment variables.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   env/Kconfig            |  15 +++++-
>   env/Makefile           |   1 +
>   env/env.c              |   3 ++
>   env/scsi.c             | 115 +++++++++++++++++++++++++++++++++++++++++
>   include/env_internal.h |   1 +
>   5 files changed, 134 insertions(+), 1 deletion(-)
>   create mode 100644 env/scsi.c
> 
> diff --git a/env/Kconfig b/env/Kconfig
> index 9f5ec44601e..9496975f212 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -74,7 +74,7 @@ config ENV_IS_DEFAULT
>   		     !ENV_IS_IN_MMC && !ENV_IS_IN_NAND && \
>   		     !ENV_IS_IN_NVRAM && !ENV_IS_IN_ONENAND && \
>   		     !ENV_IS_IN_REMOTE && !ENV_IS_IN_SPI_FLASH && \
> -		     !ENV_IS_IN_UBI && !ENV_IS_IN_MTD
> +		     !ENV_IS_IN_UBI && !ENV_IS_IN_MTD && !ENV_IS_IN_SCSI
>   	select ENV_IS_NOWHERE
>   
>   config ENV_IS_NOWHERE
> @@ -297,6 +297,13 @@ config ENV_IS_IN_NAND
>   	  Currently, CONFIG_ENV_OFFSET_REDUND is not supported when
>   	  using CONFIG_ENV_OFFSET_OOB.
>   
> +config ENV_IS_IN_SCSI
> +	bool "Environment in an SCSI device"
> +	depends on SCSI
> +	help
> +	  Define this if you have an SCSI device which you want to use for the
> +	  environment.
> +
>   config ENV_RANGE
>   	hex "Length of the region in which the environment can be written"
>   	depends on ENV_IS_IN_NAND
> @@ -731,6 +738,12 @@ config ENV_MMC_USE_DT
>   	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
>   	  are not used as fallback.
>   
> +config SCSI_ENV_PART

This should be SCSI_ENV_PART_UUID

> +	string "SCSI partition UUID for saving environment"
> +	depends on ENV_IS_IN_SCSI
> +	help
> +	  UUID of the SCSI partition that you want to store the environment in.
> +
>   config USE_DEFAULT_ENV_FILE
>   	bool "Create default environment from file"

<snip>

> +};
> diff --git a/include/env_internal.h b/include/env_internal.h
> index ee939ba4293..75b46d0bcb0 100644
> --- a/include/env_internal.h
> +++ b/include/env_internal.h
> @@ -115,6 +115,7 @@ enum env_location {
>   	ENVL_SPI_FLASH,
>   	ENVL_MTD,
>   	ENVL_UBI,
> +	ENVL_SCSI,
>   	ENVL_NOWHERE,
>   
>   	ENVL_COUNT,

Wider question, what is specific to scsi here ? it could work with any block device.

Neil
