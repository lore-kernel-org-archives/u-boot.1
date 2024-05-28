Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5716C25B79
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0171688412;
	Tue, 28 May 2024 10:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s/j11xqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F30D88418; Tue, 28 May 2024 10:04:06 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD9587F8D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2e95a883101so5750101fa.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716883443; x=1717488243; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=W8moefeEYB+tMXPSiBG1kG/xJz6XTjKtKP0Cbuw1Zc8=;
 b=s/j11xqNpN9DVbNALzWOtCV64jimaAX1IT6hvx0dHQT6kfLTgTWf/LufSAAMAnF4Pf
 zUN/vh+Ek4K01nbbu0BC2QLB/d1ppttwNid9PHm1zIm14OUXGCyfKHc3N01Gud7bu1iC
 Aj5sTQ8Vx8lxyBK7Er2MFLF0cGTEMfgseTu/snoLqfYtR5tevXFxUX9vou9SRaKpHVSS
 BhmCwVsAs1yh535NzvY87n4mQrytlIwWjB9Eye49Q6qeC/uhqCNVnTBrwcx9VqtZhzT7
 StHCsaqpR1IpK1i+/RDVhakBRW1R8yJmKV+tqZbwGzi2Am77pomMkZ2uY1H+/QfwZkp6
 UTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716883443; x=1717488243;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W8moefeEYB+tMXPSiBG1kG/xJz6XTjKtKP0Cbuw1Zc8=;
 b=DW+biaf74TvOZwOjL8847o0OgTzz7Uo3ciu0YWUxQKLWqhmFZWLOGRS9gweLdg+3Av
 +DQoe8s1pU7uNi8sgMztR9GDVqg8cNERx6x6n/mMydWhAECV1QAtD26SeK1PV+85sx85
 9O9wGer7jSKzlhk5HE25eBNKlcrmizAt1GwqOAj4t2CH4AjNScoustB5vKGZxBLw+5MM
 +6Og+igBH/02da4HWJOo7nTLGiUUDNZQewK3ggrWL82G3LfVJPJacxU0OJLCgGUfehPX
 BCw0Y6v1O67Az7EIneQwBUp3fFB9eyiylkXQO0rg1dhsbPT7prL2ufKXNNEPInfEqjCi
 nEqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuAYA8XzBt5Jt6TlZEsPfWmd0+f6l4m4hzRlctsE5dHjuSqON2hKmz7PElpNH3ezuLlRGkVHTdYe+0fdRh4Jb/u9AgkA==
X-Gm-Message-State: AOJu0YwV+6xGim5dpOD2f5KUEWmNmrr1OZ8cyIv1nkWztoKuhU9PmTC/
 LPBt+UF30tEICynZTnTRFmn0faCAsrovow81AE9Z2G9jMbZ+XqNAGkpK1i6xE6A=
X-Google-Smtp-Source: AGHT+IHaGvDYFOhnBrwEctYmvWXlcRjs+Lm9Z/rWw0ledNvfG1VsjmmkKu/84+1qsnoATi2fF/5RQA==
X-Received: by 2002:a2e:9808:0:b0:2dc:bd75:41ba with SMTP id
 38308e7fff4ca-2e95b0cc3b9mr66857551fa.27.1716883443119; 
 Tue, 28 May 2024 01:04:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8f19:f965:3f93:6385?
 ([2a01:e0a:982:cbb0:8f19:f965:3f93:6385])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fb99e8sm165636865e9.43.2024.05.28.01.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 01:04:02 -0700 (PDT)
Message-ID: <5d67ec7a-b938-46f1-b919-c9733fbf230d@linaro.org>
Date: Tue, 28 May 2024 10:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/8] mmc: msm_sdhci: work around a bug when writing
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
 <20240527-b4-qcom-capsule-updates-v2-3-47583d7ad428@linaro.org>
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
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-3-47583d7ad428@linaro.org>
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

On 27/05/2024 19:17, Caleb Connolly wrote:
> For some unknown reason, writes of larger than 1 block always fail with
> a checksum error on Qualcomm v5 controllers.
> 
> Until this is resolved, work around the issue by setting b_max to 1 for
> these controllers.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/mmc/msm_sdhci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 4ce0de6c47d8..fc3e8d101b6e 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -195,8 +195,15 @@ static int msm_sdc_probe(struct udevice *dev)
>   		return ret;
>   	host->mmc->priv = &prv->host;
>   	upriv->mmc = host->mmc;
>   
> +	/*
> +	 * FIXME: v5 controllers have a bug in U-Boot that causes all writes
> +	 * greater than 1 block to fail. Work around this by setting b_max to 1.
> +	 */
> +	if (var_info->mci_removed)
> +		plat->cfg.b_max = 1;
> +
>   	return sdhci_probe(dev);
>   }
>   
>   static int msm_sdc_remove(struct udevice *dev)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
