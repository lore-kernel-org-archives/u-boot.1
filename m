Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E5AD41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9945783B48;
	Thu, 11 Dec 2025 11:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B0irrI6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEF4F83C08; Thu, 11 Dec 2025 11:27:22 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA84383642
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47755de027eso5377305e9.0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 02:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765448835; x=1766053635; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ykHSRjMtrM5Zog518JA2tBXd4jtQbiwyTJEMP/uLgsw=;
 b=B0irrI6Mnoxdci+Isknhmj5cLcB4/UMbPYcc0rNw6rfi/2NARCHHu1irGYAGgufdVp
 U1OD1TfdHF22tfK6R1lQuCdzZLQMs/7IetmX9NJXap/HUl7Ys01f9lwHwHOdbaErNf6g
 BoB9GwF4PMnvFTfRPsxVIq/DEELoxQf7bDNn0knCxiPzZqLuCcKpuWFSGY9i8pj9GxO4
 RaEAnj3TOrdY7FNm11d4X1+NR10qY7GihtfC8lGzduD+xPsgHskfdp4nn5r4nIsXw0DX
 TIiKOpUt8c3iw02OftjA/IrSN/FQyzgGWVGsykHqm04my/cXs+6AE+Wivk9AWX7PKvu5
 GvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765448835; x=1766053635;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykHSRjMtrM5Zog518JA2tBXd4jtQbiwyTJEMP/uLgsw=;
 b=XXcA3+KzMKr7CSRo8wzDatoyP8g1XHmPRNE0EReGKloZ8FCVDWcRSJWQDmCyKmOSW5
 96+jHypbcSc6ahPfsnubq1h6hHFnPmrFwe2JxXt81i7r7WPacsKFokxZPqFaUF2PFopl
 g4DOkALVH086b//7lIq9llE09oflzGlygARZOxnS2zn188WcZ0p4RVSuaccwrH8gaC/9
 c9PdB6In3y8FgZthyDwZKLL4TXIC/U7waij0wXg30Go/gqtsU24Fhhhq6CUkFg3dxHVx
 Ja8cYYzn3q0V/MMyYVFLOAQ/CO35D6U6E3XU8wkenVcxeP/HMjPyU1OJl7MVOpFh9Voh
 uFJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvBQbAXlJcYXPVodiinYtQEJIrUcso0BPdkJssRFVPL4DaP2JnE4hZola2fxg4vs5VWWsHXNc=@lists.denx.de
X-Gm-Message-State: AOJu0YxzgY3n812RTOgyffr1k4I9LmFxDaNVC8tldu+sKl39Y3g34NAr
 L4n6+o+VvMpMv24HmDulaYH69ENOc8IuSPgrNKDyJ/AGkykoDUlxY126dwi8/pe7WbY=
X-Gm-Gg: AY/fxX6j3FxVQw+A/HXF33d//lO5Oi73sAGAqAqkqR9/LZ+1XQejSBmZ3H/JWJfXWoe
 x2saQxRFbpKNu+T4iF/0ulYznlCWBy/r39nbFAEBz1zLYbOGO37lTnAavADerU4wZWG3dGnGrLs
 mzZrSzwGrdzafmykVt2phWbJjNpwjTYV+R3FrpBV++s4XLg5XBa6WWpOZIwLXkdNvTnPxJyNJtM
 zm0dO60GDfrUwRj0Qd2XLym7uCylt5zV8YaLAeL28I58hATaDojqa+BYnQhhoCIspX556DRxUz3
 SO0SFZyOtvGaOlNziOERltxtLePxCWEEL1TBiQB7brtYC1n1MPfSoUe0Y3f9I99Ts1B4W+gIZd3
 RAONEAZHj3OWe4xsogTy1tr+FukzQiqRFh7KQDb7uSYvo9bOuEDbQJZEo6blTj4BSRnVj2htZMo
 OgGbQ+yQsFqLW2oY+gbcpihBS5+N1+/6o0e9RUBRAHag7YW5obFq/eehK8z6oS
X-Google-Smtp-Source: AGHT+IEh8lSt8qJU4WVEya36Xo0yPlvmBHl7KcYvoDcJKDrqS3xLzy/DP9k+Qt6oJ0SDL3T1wmeFNQ==
X-Received: by 2002:a05:600c:3514:b0:477:28c1:26ce with SMTP id
 5b1f17b1804b1-47a837fd255mr49964195e9.7.1765448834999; 
 Thu, 11 Dec 2025 02:27:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6?
 ([2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85f38sm4898330f8f.28.2025.12.11.02.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 02:27:14 -0800 (PST)
Message-ID: <17a90f64-32e4-4b1f-85b5-bf6a2da1408a@linaro.org>
Date: Thu, 11 Dec 2025 11:27:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ufs: Disable UTP command timeout in slow mode
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
References: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
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
In-Reply-To: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
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

On 11/26/25 16:06, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> When the UFS controller is operating in slow (PWM) mode,
> the driver is disabled the timeout for UTP send commands.
> In high-speed mode, the timeout remains enabled to
> detect stalled or failed transfers. This change ensures reliable
> operation in slow mode, where command completion may take longer
> and timeouts are not required.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/ufs/ufs-uclass.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 3c8e4299259c..7a80a9d5664b 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -917,11 +917,13 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>   		enabled_intr_status = intr_status & hba->intr_mask;
>   		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
>   
> -		if (get_timer(start) > QUERY_REQ_TIMEOUT) {
> -			dev_err(hba->dev,
> -				"Timedout waiting for UTP response\n");
> -
> -			return -ETIMEDOUT;
> +		if (hba->max_pwr_info.info.pwr_rx != SLOWAUTO_MODE &&
> +		    hba->max_pwr_info.info.pwr_tx != SLOWAUTO_MODE) {
> +			if (get_timer(start) > QUERY_REQ_TIMEOUT) {
> +				dev_err(hba->dev,
> +					"Timedout waiting for UTP response\n");
> +				return -ETIMEDOUT;
> +			}
>   		}
>   
>   		if (enabled_intr_status & UFSHCD_ERROR_MASK) {

OK seems valid

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
