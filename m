Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2FACCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A84800D7;
	Tue, 30 Sep 2025 20:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kZXeBivb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F72800B1; Tue, 30 Sep 2025 20:41:22 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62BC1835D0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so1382595f8f.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257679; x=1759862479; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+B1WmXJ+tCxuTdS6YHf+agzAmlUYiEA402kCLZz4g8Y=;
 b=kZXeBivb+fQ1e9l9QMJaj34iA4vUgPg7DOoZPIfMMKowgSC9hpsJkXc1Y5hvjuYVT3
 xLJIgANWX8iPKYcwNS7H3KKM/VM8kSagjc9jCyLCmUc1rg5Rts5/53AadKYFr3xbmbxI
 SmCR7/fO5/XR9PJEopxOpXoLVsC3qL65p8+de3uqMi8IsngOVBits9l6WD2bUvwaZsFH
 /qp8QkBhwz6xUI833weo0nYf2Pr2pfUUHgq6uhCCss3bKKJ5ttxmDHeI+lPyDSXie1Gi
 eyD3CBHag9AJlHeyqCzxQXo5XzTEH7X3wzNKdXOYJCEM5/k2NWx3Uaff31YBw8uGs30y
 gNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257679; x=1759862479;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+B1WmXJ+tCxuTdS6YHf+agzAmlUYiEA402kCLZz4g8Y=;
 b=Bbo3Vh61bPwD4P0IOyNMV49PcCPlhwHtjUbJdfEE42YSKziRN8EYoS0FYN2dbnVqsV
 lUUWMOtJmSEy6I+v/tVwj2dParXnklR/PlwvdKPb0nuc7gEL4Kn2m2K6Iqg//lvx5mjE
 lL1X7vIPa5Ais3JSAcaSi5joEuGDFU6GU0BoHCOezDBxwXwBzH694xmd1zEg0VZC5o05
 0uDxlinmru93p8ZOaL60KAxLi8d5oLmmpgblPDjAuBJxlUXGCVjWwU2fischXPXazKIr
 B1dKaPsxCWTlhlt0iBzzn5wFbOEnSq3C2GN/vHtDB2JeKJ7B/Ca0EJnXw5ctigMfG7Kl
 0vVQ==
X-Gm-Message-State: AOJu0YzBg0kjlqreje49tm6VMDetgycSOPMwqsLX4rFnorh4cbwJ04OS
 a2yssbwjmute5tZ+D1Teu/yEYtKOEYaK84qHXZtQEFTSogvviAlMHwT4YbYEOIuPKbs=
X-Gm-Gg: ASbGncsN8KMChMuobkDUGh9NE5SIs0eN6cYm8zTdc8/nRddvchGy9iK52Bq5aeGb+KB
 OIP1v/pAw+jJ92lJz3UnsQLJY1hgS/KDpj3EmP4HhuGBnthMODjEiebiWuKcJZSMu7Qwna2bvWm
 4w+bD5Mg9ObQwSbQdA9RBxgxC//Bpd0Rc+mnae/+UHMCztPxfSN8b9zulImjrbllKpBam9KJwdh
 M/VHuh+vOEpCjktsftriLubteFJKy4VGJOv2+7Lh5cAByP5jTsYYAN0XINgjN1UuEOH6FKq5KQ0
 VciO0PbHj+U6x5armB8hNkovHveY3cKQFHlxlkfsKceFRJl07fRWs1Ve7kyRGHdoUN9AgHEuIg5
 3MFxxymoABR1Z+CJtjY9et9MtMpawDnYAOcc6Urv8On6FJWiuwm0iOUjYTuaIVLWXM9tSBPpg5G
 uE9ceE3Et3+pFqfdTHnytX3Io=
X-Google-Smtp-Source: AGHT+IEeFr4+p0l1oWeeQlG8nG/dV09rm9O138hdEdcimwOvUUZkUzfYuMOLK8RjUc7dL8aRtOgiwA==
X-Received: by 2002:a05:6000:186f:b0:3ee:109a:3a83 with SMTP id
 ffacd0b85a97d-42557824f1emr543427f8f.29.1759257678722; 
 Tue, 30 Sep 2025 11:41:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921bcfsm25736759f8f.43.2025.09.30.11.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:41:18 -0700 (PDT)
Message-ID: <d31dd41b-7ffa-42d9-9727-c6e36bfd5a80@linaro.org>
Date: Tue, 30 Sep 2025 20:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 7/9] gpio: qcom: Support GPIOs on PM6350 PMIC
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
 <20250917-sm6350-bringup-v2-7-13346fc2a2f6@fairphone.com>
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
In-Reply-To: <20250917-sm6350-bringup-v2-7-13346fc2a2f6@fairphone.com>
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

On 9/17/25 14:47, Luca Weiss wrote:
> The GPIOs on PM6350 work fine using the qcom_spmi_gpio driver and
> enables the use of the Volume Up button Fairphone 4 smartphone.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/gpio/qcom_spmi_gpio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index 22c8072534e9188445f0aaef5336863fd1da7a75..3f3c98e2d935a34bb030532025e8765a2dd2b186 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -743,6 +743,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
>   }
>   
>   static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
> +	{ .compatible = "qcom,pm6350-gpio" },
>   	{ .compatible = "qcom,pm8550-gpio" },
>   	{ .compatible = "qcom,pm8550b-gpio" },
>   	{ .compatible = "qcom,pm8550ve-gpio" },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
