Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB70DC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 16:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4918882AA7;
	Tue,  3 Jun 2025 18:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qtPnAKWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2307182AAA; Tue,  3 Jun 2025 18:43:23 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B2F82A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 18:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450caff6336so36131125e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748969001; x=1749573801; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=5pclwUCy0d4E2/0ZUsStu9N6qNXeSZ7bJklkJFQhIZg=;
 b=qtPnAKWc7Akow4tZYDQByeG7HemWh6zY2ATt2wT4wU/x0yE18+g3dALZxsXiyo+NYu
 yerNxSIePanouSG+HzpJ7Qu+4o1ciftLpulg2HLl/I4W6lH2dI0dwxcXhQbzbTz5Ewx2
 UBNxGoIqEbXpFXb/TlKr0OJVuIhWKa+deUxgMId8CqOKo0RItMmUHDvyh4S3Pepw0b0w
 x5Es0xBaSZs3vWFSVcUBqMAw0L9fh9KakyH7IOe7g9oAuNlDDvGdt+k0YbBl7BDjewTs
 hguSmAKfnPLz0Pmy76P0cHkmrQZaSUyu7/2r0cTEAvEFfQQ7AkB06u7Oc3arx3KVYVKj
 VFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748969001; x=1749573801;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5pclwUCy0d4E2/0ZUsStu9N6qNXeSZ7bJklkJFQhIZg=;
 b=MMdf/PCvsHKqoeNCO4EgK2hcBNHYp3qJecEvDnbjWb5eaqJb5qH2xck9rcS9Izd8E3
 wcpYEUCHLRPHhPVCQbScv02H1DnyOyxPeZzTSFF/byL4y1SDlGlY5cyfEl4DpAiu9oOA
 yY37fceXxUj7MIyW/i93cL3jj3L2JuAGV+q+9Ltqb8ClVaWB1Q7WgXIieLUtMvujs+eC
 lGc8sE8zDYgDOj1t8rrn8ZEfSPZrUV2xPHGQITNLDg9OEfhomfBU+AMqaumnRD7R4Gnp
 +RIAl7T8hbaqz6bF0yNWNfOrhCNaLl4vsoW5dqPI8cXslLUw3tYuu8gf9cfKhiHFIapE
 +fjQ==
X-Gm-Message-State: AOJu0YwS5VRjz5TWh/ps6dZ/3sBjqikemOW6+rrkDaYICv9c0m1S7McO
 YNu2CdheN+qg5WQ2g1D1K8WEzJqkHKGfBXTrbcve4UtJ9Kglw8P3CrrWyeg6llvpW4Q=
X-Gm-Gg: ASbGncvlZANV4fXzaEytJ+7jaEyDIsBucV3PVRaKczCKYTx8gxpSPY/O3CK9YOLyi68
 BzJCLweW1cN1lJKo1lqoxRU/iC+RP0K5UmPGBdq+NbpiOXZgAyISlZyKryW4YRX9ZD+5xjlJM7V
 UhX7uF9jvC2Ik9uoW0XokOFiG0Yc07DXEmvIaCvGvCwEOgjK9MS2DkOpVTRQqYp+PIkQN43ccJH
 6sc3bk1/7Cbem+IWWV6NX/GVIY6VYYLmrcjFntK7np3RjN9vx5tnJqVys1I8pBN4xQBeUUNE/XN
 t5bGXbbcl9anBT0hjvWA8pl5bVuRLwNuKckxKF3wqBgvKrEBnh38E0GNxuOKmiUA8wQhE4v9Zyp
 NN3qtUUC6hdRtZyLU5kKtjsBFTg==
X-Google-Smtp-Source: AGHT+IE92KZDZaq/UX59f2o41XTVBVaMWgtV4rZA3H/GseJo9B0zD2h91xk9Og7b5P08i8hhsZTjoA==
X-Received: by 2002:a05:6000:1447:b0:3a4:d6aa:1277 with SMTP id
 ffacd0b85a97d-3a4f89d3557mr13147277f8f.37.1748969000613; 
 Tue, 03 Jun 2025 09:43:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:563:3654:17de:c930?
 ([2a01:e0a:3d9:2080:563:3654:17de:c930])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b89dsm19040246f8f.19.2025.06.03.09.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 09:43:20 -0700 (PDT)
Message-ID: <cebc988b-de5b-45af-92ba-08ee7998aaef@linaro.org>
Date: Tue, 3 Jun 2025 18:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC/RFT 0/2] gpio: qcom: rewritte SPMI gpio driver from
 Linux driver
To: Tom Rini <trini@konsulko.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
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
In-Reply-To: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
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

On 01/04/2025 11:47, Neil Armstrong wrote:
> The current SPMI gpio driver is very old and doesn't support
> pin state tracking to fully support the whole pinconf calls.
> 
> The simplest is to rewritte the driver using the v6.14 Linux
> driver and fully implement pinctrl, pinmux, pinconf and gpio
> support using all the newer interfaces.
> 
> The goal is to deprecate the old one it has been validated
> on currently supported hardware.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (2):
>        gpio: qcom: add new driver for SPMI gpios
>        gpio: qcom: move pm8550 gpio to new driver
> 
>   drivers/gpio/Makefile         |    2 +-
>   drivers/gpio/qcom_pmic_gpio.c |   20 +-
>   drivers/gpio/qcom_spmi_gpio.c | 1035 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1037 insertions(+), 20 deletions(-)
> ---
> base-commit: 5ca70325b64f760bf4190f206a0e88dda495e3d2
> change-id: 20250401-topic-sm8x50-pmic-gpio-pinctrl-new-2588c35a461c
> 
> Best regards,

How should we go forward ?

Neil
