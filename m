Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCC2C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 08:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6821C8790F;
	Tue, 16 Jan 2024 09:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ihBKaB4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F6E58791E; Tue, 16 Jan 2024 09:52:36 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F21487753
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-337b8da1f49so247431f8f.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 00:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705395153; x=1705999953; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=AfRzFltmzTdUpxYh2qcZ4hUa1HOyMq690o7hmKbHvl0=;
 b=ihBKaB4RUXkJDFFVQNDjfymXvs191QB8n5igxXNK0il7/l3vbzscn60NRP2AF4h7JW
 8U8Ml+g+iS7XPk6xAwdA4TmaDllip5Rtb7Pr5UA6/ElE1chXXHlxCFfoqVPUIhuW7FBU
 mHNceFGp6mGQRfFKPYP9sPJjOQIfw9ZQ08/FSEm6zDOHBtc4clZvMPg8tybJrfaXusVB
 n4tJJykcQZQgFFMfmrZdSSpopj/Y28gmTr3bYgFR8oT6YuLnzK9nKYntXikNVZWZeQcg
 dcIinjETVulPsI6VP5N8zS5mciBCuPD9hm8j1ArAZ49UyY2rRfF8WPkvilKT4UNxzW2m
 X/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705395153; x=1705999953;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AfRzFltmzTdUpxYh2qcZ4hUa1HOyMq690o7hmKbHvl0=;
 b=C20ShBo6+cVQfs4VvmRkcujE3Fsm7s+fvKlhfVBgn1WZj04kzfukmQ7gQEXGK7uwVy
 rCoL8l73jqsmtsnZIwpBXQmC+CSu7TBSWkD0Co1OaOmyPo7huKnhWqDuuO/HmEhHo6Rs
 8H1mM/B4MJP6nEHMbUJRMDP3kgzK+1BYFGoeMelWCkarbXZQpqSgI1Rd5QegcDBbEQEc
 m2UFU+NgiV6eF4SCkQ5khYerG9TDtx37hVKcL2qxtbH1JF9TvbnrNkIMpYWSq1EMMuTt
 XpLoDPF26TRxgMTp6HgJpFcNPJFZzL4efkWgYHunMJYVMz+kHuq6JzTqeGEMffQq8N2+
 LrRw==
X-Gm-Message-State: AOJu0YwZG+kDY4GM53NxAWp0aVF7hHDZvUS9MtWvWscb4b2qX9O41SO4
 VZaYmo5dvTtWfghUoYeu7JRZgJlhYWPadg==
X-Google-Smtp-Source: AGHT+IHbl15DkkXj5IxzZvA28sLKiV2G7xwtFN/VXnr2Ehg2p2Y5Vpw6CdwMcrpV56jfe5Wb8C3AeQ==
X-Received: by 2002:a05:600c:5387:b0:40e:5186:7ed1 with SMTP id
 hg7-20020a05600c538700b0040e51867ed1mr2570937wmb.25.1705395153320; 
 Tue, 16 Jan 2024 00:52:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:30a6:c236:cc88:349e?
 ([2a01:e0a:982:cbb0:30a6:c236:cc88:349e])
 by smtp.gmail.com with ESMTPSA id
 iv11-20020a05600c548b00b0040d8ff79fd8sm18558876wmb.7.2024.01.16.00.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 00:52:32 -0800 (PST)
Message-ID: <2a8c9b79-604c-46dd-a2c8-e4ed9c95e2e1@linaro.org>
Date: Tue, 16 Jan 2024 09:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] sandbox_flattree: enable button support
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20240115185122.776217-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20240115185122.776217-1-caleb.connolly@linaro.org>
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

On 15/01/2024 19:50, Caleb Connolly wrote:
> sandbox_flattree enables QCOM_PMIC_GPIO which now depends on BUTTON. As
> a result the button tests now get run, but fail because the ADC and GPIO
> button drivers aren't enabled.
> 
> Enable them to run the tests for sandbox_flattree.
> 
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/sandbox_flattree_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
> index 0b637727d9f1..ad364f6e128e 100644
> --- a/configs/sandbox_flattree_defconfig
> +++ b/configs/sandbox_flattree_defconfig
> @@ -101,6 +101,9 @@ CONFIG_SYS_ATA_DATA_OFFSET=0
>   CONFIG_SYS_ATA_REG_OFFSET=1
>   CONFIG_SYS_ATA_ALT_OFFSET=2
>   CONFIG_SYS_ATA_IDE0_OFFSET=0
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
> +CONFIG_BUTTON_GPIO=y
>   CONFIG_CLK=y
>   CONFIG_CLK_COMPOSITE_CCF=y
>   CONFIG_CLK_K210=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
