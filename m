Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC347C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 16:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E62687F41;
	Fri,  7 Jun 2024 18:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fNRtbw/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532F687F6F; Fri,  7 Jun 2024 18:29:58 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AFC587E50
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 18:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5295eb47b48so2881312e87.1
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717777795; x=1718382595; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=WOEzIUuYoh662eS+PFSjnuW2J+3Xd/ukGaT2sdj+DnA=;
 b=fNRtbw/i1h/EL9/98NLtyUS+67+xEJcShZ/bZKzJ5o0zSP8wVpHAKud5YHHGbbU2AD
 9ltygO3ha6hedHseDao2C/KQ7qBhClAOKbC/Vp4nfmhtoTj6zQ7f4C8gfWlKMbsOapRL
 xbQ2Icm/zw5ZFhmImdCyri1cYLlSRs68FuXehQ+85EpaIFltkxyUJdQidJZEXfWK6yaf
 qnsgd+7NeLqjq/baEByxJBkh32sU03LL+Uzn1/wXFi9F5X89vlZm5eNsahMD52wEOorq
 4B3IEV5sBYZPh0gmgZBBplHEjJxSOGFNGgi09b57JLSfe29uHvzwaRys2ysQxkrk6AFo
 fLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717777795; x=1718382595;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WOEzIUuYoh662eS+PFSjnuW2J+3Xd/ukGaT2sdj+DnA=;
 b=EMO6Ej94Kc9YyKpwqb5bA/J2Ec1U/q26YDlFoJnkTK+XLYbwEum4qGbS2dJLb/RXXi
 3lhqy3bbu3qPxz+hx4zNKwGE7FOmkmPR0lpDqs7JPDr+5OtdxrGfErtswIaqXEprj+zI
 7e9Fva+8qmUJFyJYisX9bCM3o2v9fOZrjgBVS4il5TMuTOOkdm5c0gU3cMPz7BgvEQDx
 FIPh4b749gfodvK91ndBqIeLCA/EexWdGf1rlAiR5NBYLYG+GXH28lKcSoZRByOeYrH4
 5cV4k1iH17IxoHC7oXYbXg3+PyyXMlSJksGXQ75OcHss24W8Ti3cJZTd7zDlGevl9K9O
 eFvA==
X-Gm-Message-State: AOJu0YwdRlipQ9fzZKcPuqEpxmw9kI9UvoUUI8FswlZp7DoQN6cgOgnI
 RJYEhXJ0afL6rv42UpDkyeflKvp9dZ2myVijRgD1JKgLUb85RK9Qey35v9LzqQg=
X-Google-Smtp-Source: AGHT+IH8MOWH/Ipgv/JKY00W9wv82T4RPfWCnKYVlfJmGpZkl9M28INyANFnQprA8TeFd4f1BCYacg==
X-Received: by 2002:ac2:42d5:0:b0:52c:1298:7304 with SMTP id
 2adb3069b0e04-52c12987422mr160880e87.26.1717777795264; 
 Fri, 07 Jun 2024 09:29:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e4b:b0d3:6a34:6404?
 ([2a01:e0a:982:cbb0:7e4b:b0d3:6a34:6404])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158149013sm91810955e9.35.2024.06.07.09.29.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 09:29:54 -0700 (PDT)
Message-ID: <246fd99b-84d1-4bf0-9dfe-1fa099d4eb08@linaro.org>
Date: Fri, 7 Jun 2024 18:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] spmi: msm: disable read/write log
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240607142229.50709-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20240607142229.50709-1-caleb.connolly@linaro.org>
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

On 07/06/2024 16:22, Caleb Connolly wrote:
> Most devices have buttons exposed via the PMIC, the button polling
> therefore triggers a log spam if debug logging is enabled.
> 
> Someone would only ever want to log SPMI read/writes to debug very
> specific issues, they can then uncomment these debug logs.

My bad sorry...

> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/spmi/spmi-msm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
> index b0d6226041e5..58c676423f40 100644
> --- a/drivers/spmi/spmi-msm.c
> +++ b/drivers/spmi/spmi-msm.c
> @@ -118,9 +118,9 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
>   		return -EPERM;
>   
>   	channel = priv->channel_map[usid][pid] & SPMI_CHANNEL_MASK;
>   
> -	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
> +	//dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);

Perhaps dev_vdbg would be better ?

>   
>   	switch (priv->arb_ver) {
>   	case V1:
>   		ch_offset = SPMI_CH_OFFSET(channel);
> @@ -185,9 +185,9 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
>   		return -EIO;
>   
>   	channel = priv->channel_map[usid][pid] & SPMI_CHANNEL_MASK;
>   
> -	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
> +	//dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
>   
>   	switch (priv->arb_ver) {
>   	case V1:
>   		ch_offset = SPMI_CH_OFFSET(channel);

