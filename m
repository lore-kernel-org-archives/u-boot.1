Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E48C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4D487F39;
	Mon, 19 Feb 2024 10:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SuoAwohI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F014187DBE; Mon, 19 Feb 2024 10:50:38 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D6C87F35
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4125eabb8f4so13073355e9.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708336205; x=1708941005; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+ukHQPxY/qams9+FSTLBT0/sTGuwPJRAvJ2CNhYDg1k=;
 b=SuoAwohIWX5RWEcKzpjOtYhOAh2XnGQpiV5z3QEXxGJarT9pfHOOpi33vqwzh2aG/g
 9blr7uDCn5jB5oDCM+Czsv/yj4NHVTN9l+USVX/JpM7j68jAabXhSoM+o4zU7jtgiq/7
 VSxX958yqRDWg6Y7dKN0ST4TNHNZ3H/629gEdFrNAuWxMn/a2zDDDGwn1R3fswZCtGAz
 +HMf1SCzGpPr2EtK4OJFmZSUDDKH//jrLD4hB4uUer71SB+YIFmnw9EmkoOY6tQHyMxK
 SCIV9+dk2ZfNnZ+FHQiY4TWWzhOoE3nLDJI8m1VuOW/YRvmgAMezJpfLC3Zix96ZCgzC
 rfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708336205; x=1708941005;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+ukHQPxY/qams9+FSTLBT0/sTGuwPJRAvJ2CNhYDg1k=;
 b=B+ahU2kJnSgKRi3PVcpUWvjXBuYzBaGiCnTMNU1m2pCLBdzM5KpdyDvJdTK8lqs9JS
 T5MtLl5EXZIp58Ice29FQpvqH+1Uq0GfhiSRMPZzyIk7liBUXA9ZEwQ0K5UA1gOjakOw
 FIz7jgAcRJXzKgkpoDEFIfHdIgTk7J8wWxIbaAHlSYmGRNKznSW2OnE76BMobOX14HYg
 dEO4hVypwLOJqXC0UaKlyeakSPLvM9CELpRN2LJ1O5200VbH2CTpR8iFe9nIEe3IqaRU
 AGK2K7AsxVrzbqfKF+mfaLbAvIMPvuiTUKXq0VKy8xklSKoI3gRMxONNMCmGa0aIVXE/
 6hEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAX4sXX1MsK43GgGpXGZaU1LnHWFFj++VyiOik8iSC6eYkhAbMCrByMeezpDzIwXaas9/JkEwdZ1dWTb4YNEO3ViOlzg==
X-Gm-Message-State: AOJu0YxN4XXn9Xxhvv1SdQbCITpFtyVsOpx5fdGubF7kq3ky1HAFPqTJ
 rEy/HmLfy2H2G+F899W1QaRZNOteaekFNJFhFa0Fx/X54zRcFWcEP1aeXcAbCJc=
X-Google-Smtp-Source: AGHT+IEOLTXXtZTXvY1OvpRTQ7VJAToDnKTEfLjpGhG/SYiDMm1SS9DIfn1I0XJ6OvZMuopDvt5t6Q==
X-Received: by 2002:a05:600c:4592:b0:410:a039:ed5d with SMTP id
 r18-20020a05600c459200b00410a039ed5dmr8584527wmo.33.1708336204866; 
 Mon, 19 Feb 2024 01:50:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f?
 ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm10136159wmo.16.2024.02.19.01.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 01:50:04 -0800 (PST)
Message-ID: <9a9cb3eb-089f-40ce-932f-5e013adebe06@linaro.org>
Date: Mon, 19 Feb 2024 10:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 15/39] pinctrl: qcom: apq8016: init pre-reloaction
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-15-ed06355c634a@linaro.org>
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
In-Reply-To: <20240215-b4-qcom-common-target-v4-15-ed06355c634a@linaro.org>
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

On 15/02/2024 21:52, Caleb Connolly wrote:
> On the DB410c we support running as a first stage bootloader. This
> requires initialising the GPIOs which are muxed to UART before they can
> be used. Add DM_FLAG_PRE_RELOC to the apq8016 pinctrl driver to ensure
> that we do this early enough.
> 
> This is required to prevent the first few lines of UART log from being
> dropped.
> 
> Reported-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/pinctrl/qcom/pinctrl-apq8016.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index 10796710ba7a..df5bd1c19f6e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -73,4 +73,5 @@ U_BOOT_DRIVER(pinctrl_apq8016) = {
>   	.of_match	= msm_pinctrl_ids,
>   	.ops		= &msm_pinctrl_ops,
>   	.bind		= msm_pinctrl_bind,
> +	.flags		= DM_FLAG_PRE_RELOC,
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
