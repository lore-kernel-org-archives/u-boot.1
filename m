Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9A7CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96568362C;
	Tue, 30 Sep 2025 20:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ailo/ZPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24EC68361E; Tue, 30 Sep 2025 20:44:29 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E7A283631
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso40000915e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257867; x=1759862667; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=J7VyfRXA4UyVmgJRHNBJWoP4wwr2QzP7OPyl9a3ZVlU=;
 b=ailo/ZPJUjcmJjA3fCPaTMokia0OiCiPGEeGzr1+az7jBBrPy5rDXHoOXJl8vVvjgt
 gSN+0XpoojkWn9NC+3j7B3xZv2T8wbjzb+lvv2iyXBZGjWhvBDFkA/48GmishEZbSWts
 TImnRZfmaoMvXlMaCPH1ayJcC5M+Cui0xK3QzGZcIvtgT452ibsh88EgbWICj6fYkBfX
 NiSrLS7FBnrkT7jGRFUqA6JXEXGZnRmIs8+BvPVx5P8y13fpnX6IViELzushqzolCbN7
 0wp8IH8tdLaTDyLgi7/jPuvJlkG9wojoNbrDQ6wOUFSm1ivm3Nnn3Z1FbLWLPXS+Funy
 5bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257867; x=1759862667;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=J7VyfRXA4UyVmgJRHNBJWoP4wwr2QzP7OPyl9a3ZVlU=;
 b=iA/GXzhu5HToPdn0AY6j/FtKu1XSBrTTaw9JlECBmJxUo/Sh9gPhNGgBIl04LgOk1Q
 cLckOqCGAdcGZNQBLLqNj0nrov7An+Dtd1EgBQwmQH1I32R4Qu9gT+LgMuolypT7MJ/2
 CsTgCzdWZTz9P93LZWK9blPwJ0PByQyq1VRo5lkxI0FNsPBJrE7pqGXtduMlb9qfuy+Z
 p4FA1SILJkFUafofG0IlRrDNkoulLYE4kv6uQhMLB62J4T2FJZtciyBRV7sZum1uAcl9
 VhVuESROlOikVc7+EMbmb7oOXWgJHbAbr3u0O+2ogLGgS+U4AkTj91nyBCb27p40nwrJ
 dCvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPUl2amhvuMmAEmQRzER0Pa1Vv7lJTPjZqRIvWT+OecIBJ0DpBVBLnEzktFHijJl2NiFqORm8=@lists.denx.de
X-Gm-Message-State: AOJu0YwQGWHKRH4SEQL0NS4SM9gktEc5n5TzCt5YBeZQAQ9xkFXgPJoy
 TJKp+xeqbKuB//0ucH+YQD8WCTrdoJE9zp8tJWLdRU0UB+ZqXISGlIl1FWJgkzgQX8Q=
X-Gm-Gg: ASbGncubVk0oWE+i23K0hEdE13kiIrqED/V3pwq9OFqPtjYRezBx2HwGNPCAm+UWNSR
 AoCXD07DLzXCzPYNcWCuzV/OBZY13atJPKuNMkv+Vrrs0GdKibFsokykjJN1s9HJ11PW4CalsPK
 kfJk3e+qc6CpASoWtY4cXQYGwpjiQQIgSW3ZCOaeoiEEbpu7/kxyt2DidKVUGqrLRJ1PQgCNtxf
 It8Clsy6vVQ3cIH4PpA+MYOAnadFIToBw9eLpZAbaqQ6g/ZgbalxovJ0x+3vUSGqgba3gcCYqxx
 mV56UM/zI7B+EynJoAUgx+pLAcs7fNU4W7+z3E98HP2Ki2nZec3GMDx3wLWAUqWcGWUiENiuBq5
 xbmWPB4ovDQGQ5lTzmOyQepxQer7YTdz31iHDlnY9IOhKqaI1+YMNlcHLpg1JWZGf9aYC0DyfWv
 KR8Ocu6oDpzqVYHORwPpQA/uwNDuUn0llqrg==
X-Google-Smtp-Source: AGHT+IGXAeAYE8zFhapQME2Q4scmOLA0L0l/xe3t0QwSI4iYQ+6tU7dRHrKnxj9o5BOqOQk4bvutlQ==
X-Received: by 2002:a05:6000:2301:b0:3de:78c8:120e with SMTP id
 ffacd0b85a97d-425577edd51mr498319f8f.6.1759257866472; 
 Tue, 30 Sep 2025 11:44:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602eccsm25113974f8f.40.2025.09.30.11.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:44:26 -0700 (PDT)
Message-ID: <0899541f-9ff4-4ecf-9e50-41fd248bf093@linaro.org>
Date: Tue, 30 Sep 2025 20:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/5] gpio: qcom_spmi: add pm660l
To: David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
 <20250914-sdm670-v1-5-a344024062ab@mainlining.org>
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
In-Reply-To: <20250914-sdm670-v1-5-a344024062ab@mainlining.org>
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

On 9/14/25 11:42, David Wronek wrote:
> This is used for the volume keys on some SDM670 devices.
> 
> Signed-off-by: David Wronek <david.wronek@mainlining.org>
> ---
>   drivers/gpio/qcom_spmi_gpio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index 22c8072534e9188445f0aaef5336863fd1da7a75..220b77dfa9338498cd44353050ff8b12a1769a82 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -743,6 +743,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
>   }
>   
>   static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
> +	{ .compatible = "qcom,pm660l-gpio" },
>   	{ .compatible = "qcom,pm8550-gpio" },
>   	{ .compatible = "qcom,pm8550b-gpio" },
>   	{ .compatible = "qcom,pm8550ve-gpio" },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
