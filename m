Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9AAC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 15:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2367C88261;
	Fri, 28 Jun 2024 17:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xZF/McBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D55588254; Fri, 28 Jun 2024 17:38:42 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760C088286
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 17:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so5829335e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719589120; x=1720193920; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aAUzl6mfADwpGxqIFXpVPSadF7lLguG+3nnYbv/gn9E=;
 b=xZF/McBeJ6RT/HgLBL0pwoTL60r7pyLJd5XoCFyYcemhVKj5IHETfyc8CwIzihZhVF
 9QFYb+EzAE3u2JwTeOLKNbnLlrQ7GaJyPZW/VTQF8eMNL/uV0RtgLmEdg8pRgYYMRj1o
 sDL0e92SRcCsKT97JqSl/xCm+XOHTPa7jlEsOolAOEK50HA4+z6u5j6QJedc1NWFEo6w
 DKmkOnS//kShRt9CJFnCGCZNlHEBKlLIrIP0Mf/5SkjoydD/LAw35fQITYEjgwFFBfnA
 jGg8VzBVQ5Kt/D8jnJ6mNx1eG0LmK4vJV7BoWb3KtMUAMuag57AbIh2cmzLg1h3z5Oxr
 EJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719589120; x=1720193920;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aAUzl6mfADwpGxqIFXpVPSadF7lLguG+3nnYbv/gn9E=;
 b=p9O7C+NP3lUvn2UuLpFXhRCnc/jA3Sd724+AT9KtUCthnXkqhaIHcFz06u4qMxKSkf
 5WQbY2GG8uY9fw0f9IHMfxxy/bq0M+4lusAPsc81V5DrtRiFNAvQV6PzZtmpZEXLhvUP
 tOzRfHROtPsaOew38URcGruU1aIQ4wfwr5b0T9kxi6fApJ2cIeliSsbaT9Cse8hpgNNZ
 G1Gkjoghr/VgGHp+tqf2IDvZtM8vVISICAwTlp5HJaV45Bk8ZKI0Dz6cA36Ib3Vc+MRo
 UJ1gGtQO4YRXWlmaeVItu/RhX3rlcPmqd3/1hebZ0Rsf8u7X+Mps/aGWSMc9quzamE3r
 QAew==
X-Gm-Message-State: AOJu0YyACjKzIkdVZeM3bxoqJ75E/DjeUNTy2730TXLEsNsqJENecq4i
 4zJR8CVa58CIsBx7qyftUWOZdCm9RvsVfLJ5FjOS+8aYAc1qPU61TAt2J31SH1k=
X-Google-Smtp-Source: AGHT+IGI9Hgx7oqKiJuTMy+vUV9Hb6jdXEK4gLMNMVj3TTiAt+gF0KZWpz+R6+wIS3PRaLG1mEV0JA==
X-Received: by 2002:a05:6000:1885:b0:360:7a3f:7a3a with SMTP id
 ffacd0b85a97d-366e96b23e2mr14484568f8f.44.1719589119456; 
 Fri, 28 Jun 2024 08:38:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:698a:cbfc:82e9:f7c1?
 ([2a01:e0a:982:cbb0:698a:cbfc:82e9:f7c1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb950sm2647321f8f.83.2024.06.28.08.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 08:38:38 -0700 (PDT)
Message-ID: <a29c5a2e-c771-41ab-9006-da7d3a86be5c@linaro.org>
Date: Fri, 28 Jun 2024 17:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] soc: qcom: rpmh and cmd-db drivers
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org>
 <20240617-b4-qcom-rpmh-v1-2-bd2336923e0a@linaro.org>
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
In-Reply-To: <20240617-b4-qcom-rpmh-v1-2-bd2336923e0a@linaro.org>
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

Hi Caleb,

On 17/06/2024 10:32, Caleb Connolly wrote:
> Introduce two Qualcomm SoC drivers, the RPMh and cmd-db. RPMh is a the
> name for the second generation Resource Power Management hub on Qualcomm
> SoCs. Most core regulators have to be controlled via this hub.
> 
> The cmd-db is a region of memory which contains offsets and data about
> how to communicate with the RPMh.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/soc/Kconfig              |   1 +
>   drivers/soc/Makefile             |   1 +
>   drivers/soc/qcom/Kconfig         |  25 ++
>   drivers/soc/qcom/Makefile        |   4 +
>   drivers/soc/qcom/cmd-db.c        | 246 ++++++++++++++++
>   drivers/soc/qcom/rpmh-internal.h | 141 +++++++++
>   drivers/soc/qcom/rpmh-rsc.c      | 619 +++++++++++++++++++++++++++++++++++++++
>   drivers/soc/qcom/rpmh.c          | 110 +++++++
>   include/soc/qcom/cmd-db.h        |  42 +++
>   include/soc/qcom/rpmh.h          |  29 ++
>   include/soc/qcom/tcs.h           |  78 +++++
>   11 files changed, 1296 insertions(+)
> 

<snip>

> +
> +static int cmd_db_get_header(const char *id, const struct entry_header **eh,
> +			     const struct rsc_hdr **rh)
> +{
> +	const struct rsc_hdr *rsc_hdr;
> +	const struct entry_header *ent;
> +	int i, j;
> +	u8 query[sizeof(ent->id)] __nonstring;
> +
> +	/*
> +	 * Pad out query string to same length as in DB. NOTE: the output
> +	 * query string is not necessarily '\0' terminated if it bumps up
> +	 * against the max size. That's OK and expected.
> +	 */
> +	strncpy(query, id, sizeof(query));
> +
> +	for (i = 0; i < MAX_SLV_ID; i++) {
> +		rsc_hdr = &cmd_db_header->header[i];
> +		if (!rsc_hdr->slv_id)
> +			break;
> +
> +		ent = rsc_to_entry_header(rsc_hdr);
> +		for (j = 0; j < le16_to_cpu(rsc_hdr->cnt); j++, ent++) {
> +			if (memcmp(ent->id, query, sizeof(ent->id)) == 0) {

I had to change to:
			if (strncmp(ent->id, query, sizeof(ent->id)) == 0) {
otherwise I get:
Failed to read RPMh address for bobb1
...

on SM8550 and SM8650.

Linux uses memcmp, but it pads the buffer with strtomem_pad(), strncpy doesn't seem to do the padding.
	
Neil

> +				if (eh)
> +					*eh = ent;
> +				if (rh)
> +					*rh = rsc_hdr;
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return -ENODEV;
> +}

<snip>

