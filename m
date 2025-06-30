Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A251C83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 16:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BBA809A5;
	Mon, 30 Jun 2025 18:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wF2eeynb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD9D80B9B; Mon, 30 Jun 2025 18:07:06 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47534800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so16665245e9.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751299622; x=1751904422; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TcYV3Dt23iKInL9oVET4xti4zYZnhvpDD0ivrWoEfPU=;
 b=wF2eeynbdiDUxoZVmt8rAW9pKQeviWP5YN3YvO5AWyaqepSjqLUzSALo2LevjsmHz3
 t0JCxkKDj+iah/Jhoddz8Gu6SsCVv9y5OzXPJ3nKED00nHB9I0Ls3+zQ5hXCtgjvecxy
 57KgEPwHMsQyEVEW8/0XkrSD1L2TPXcf8ykBqXp7BQykq/fmRe/E7ckVhl+rIlOPA5Qw
 7yEJ2u0D5Mz+YIfxZ2Z7GZptWXee76dibNziX52D4LvpTLX1W8TnHM7lYZgdays56l+p
 ndVXWttgUOIsjpXpL7uX4NKNRZySXYuI9yJBdJttPQKTJnnsFANmGYHfL38eBkjIGx0u
 XLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751299622; x=1751904422;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TcYV3Dt23iKInL9oVET4xti4zYZnhvpDD0ivrWoEfPU=;
 b=B6odX0cXA5H6ygU31V8TzmYueglPPA3cfPVXzFowHXVc1EIj3Htpqd0zlw9DdpuuUh
 S+fY6xdh65DNSNUmugEdGU9mWJH8ureSX8rM6n/dC4Z6Gi5eBn89AcPuDak+2mBy3EJA
 qkK1x3Vtga2zIS6HNGY8WQEToJcm36CKaQQlFUIIQD+QuPq1/7mbCISTfjWFm8yHprGI
 DFkiBWwn4QoXY80grQAxL07xSCenZSMcnBgaNbIn+B0P73YAH1dEuE8IUIgnrAov/Xk/
 qKNsBciACReByhWooliGushdY9KFZWSZQAERTBmoxj3MIPFnDRmRRDZwSve5DKFotyRL
 Q8yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1IqAaKLzjNSt6jB/6HNJWrycQiRAv9rY7evPiKwxZkT5zgqvkxSBOaBiQNKrjuRbXTQ9D0VU=@lists.denx.de
X-Gm-Message-State: AOJu0YwejHLb7Jl3ge0jq6ZmgEminG0yQnag/lxXqzP+g7i1RJbnw4qq
 Cw/8Jq3EPYR+Hi418CJ2Yu8idjHOl1vo9aobYJc7dHdq8pFZEi5H/uMuR74MOyd9WfM=
X-Gm-Gg: ASbGncs8ZXnYMhazrbKSVbjxHH/rPvoYYHoDe85tL7I40ESE34tWBPbM1ocWVwBcGdJ
 3rjYRsIJTQHdwf1/fOMPzYonSxUEIG2JQAO3ExF6GD01aIObUqWRhNZp+XfbnlPmy+4CekUuSy+
 KHTZGizupY7LkPR2ywKn983yY9Yu/kk3VR/kWEz068LKcDHKrC3Oy0YkQit3K2IxktQFX7v1NY2
 Gc2TJOwWVMSbhPQ0417T2nfM0/82Ww2eDaqF7BUsjXC7/wS4CqLl+7qwxOI1dCXjuoMHo26GYfg
 iITr39xe5fc3xv5LXxj69z6sFyKUwaGpFbi/NOaLKtyeS6dyCrFB+IuHD+Hw18fctXXuOa/7k7b
 yLiV47L+JFTWTb82udnC8NyVCyIOKp2yGe7gZXPY=
X-Google-Smtp-Source: AGHT+IEcLnOq2akBY6y+o5Bteq3L1nBaVJQgnZGAwodRh5t9T2dBwhNKulHGHkNs2VaooB+s49yGHA==
X-Received: by 2002:a05:600c:c0c3:20b0:450:cd50:3c64 with SMTP id
 5b1f17b1804b1-4538eea1cf7mr97955415e9.31.1751299621521; 
 Mon, 30 Jun 2025 09:07:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:abe8:a49c:efe7:4dfb?
 ([2a01:e0a:3d9:2080:abe8:a49c:efe7:4dfb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52c23sm10908341f8f.52.2025.06.30.09.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 09:07:01 -0700 (PDT)
Message-ID: <4e929895-17b7-4053-939a-5ba3d584f883@linaro.org>
Date: Mon, 30 Jun 2025 18:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] qcom_defconfig: enable USB mass storage gadget
To: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250626132550.353332-1-casey.connolly@linaro.org>
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
In-Reply-To: <20250626132550.353332-1-casey.connolly@linaro.org>
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

On 26/06/2025 15:25, Casey Connolly wrote:
> Enable the USB mass storage gadget to make it easy to access the
> internal storage on the board.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 7a1f80265771..d7f18820297d 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -39,8 +39,9 @@ CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_UFS=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_CAT=y
>   CONFIG_CMD_BMP=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_RNG=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
