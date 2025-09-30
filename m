Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E77ECCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91062800D7;
	Tue, 30 Sep 2025 20:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qxEEBb8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7BCC80819; Tue, 30 Sep 2025 20:40:49 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D04800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e4c9083a0so1655955e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257646; x=1759862446; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=rBe2Gev/s1sZsbU9jQWM20t45zs8ZXVTjH7woedeEE0=;
 b=qxEEBb8Oh9ilBh6MRWFgjo/uoBoLnVxeiKZwxjgSNMpui7BvYGlyrLZs6xFy/xMTT9
 Xo2Y5eDv8v0Gooza54ls7EO3N5nEQS1NHKGoVQ94tjQFB1wAox417lfNtBbcGUCuu1sp
 TFai9+GtQYUCJ5UZsGAQFNGOqFcTj/UxNj2tpBCX754rddidr7KnpD8PESXTkT4ZGWzi
 TN4oKme45g04b+SRFZAx9nOUV19RqhHbh+enq7gAzZ0Kdiigge82qqkdVpRu46VZNGvj
 xKNSDpRh0fdE7PfZRZfMriZRNmgG2BzoucUdlkzZ1AEC8SyG3vdazRpZdFG1xsNN9xu7
 +RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257646; x=1759862446;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rBe2Gev/s1sZsbU9jQWM20t45zs8ZXVTjH7woedeEE0=;
 b=PaSMpjm5A8qdpOvXf3H/XwdZW/z3A3GGaksFuC1XGHKd1E+5Q09DfK0MMKu5GIPBpP
 DgwQAisoADw1cvULyHAf1RpyYen3Ra0xIwOq0pJr8/M+kxcq3y6XwUCMkhly9k3h+/sK
 2dkGI+3oPfj47baX56xWoGZJM4/Tiu26b6R6LWpq3B+Qz+8zdo0ktwamiHktidwzuw1X
 TEt3Ficw5zAKISqX/JQKmpOqzBbRVoNDUzL8+aDIkaVu6qsOl7wu/KtIg1ksMF9XeyZu
 6O6ooAKZ9/eEo+LNAsLCSeBVN7Lo2J9ol6q1P8WfrvE7r6IKljLZyO6Q1PhMrv1VzBXM
 zMWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+PXg/buk5+FzFaDCknmFJBzzRvkj0ZvIqqOnnlBk48YViR9mavwY70bklwuVi0PQjiP/u3uc=@lists.denx.de
X-Gm-Message-State: AOJu0YwyXD4Ey7DPPwcVvL8XsgMVZX0ySzxVJmMHeS4pKv4iz5AP3V+j
 NG2JC8l57tBP29E+NYeePMdIatT8CzihiSJTvcODYNo3TVWja3i/R7ZZM5CtxMe0KVAOnOTQHFw
 Y2Jxa
X-Gm-Gg: ASbGncssZ5QZnylOrL0g0cuM7WtwUvzAQgs8/UY5WszD/j+byeS8euAW6NR8cwPMPqL
 gtP67WS687h77tcnBA2XYEZFsOhJKIjmtOe0zzRSs2ES6/CZYSJ5fUQJlNY5GLBX/s8IfrBNsay
 bk2frqPCLr/WlLXuArkMKioIjHWGYfILpmC2nZUF07fOCCYGCJm6wWmGk2OulddQ5oqULHIIPiV
 GGS6/jgJG1uNUtO+KUTNVWcaUh6H5pMXDzN0BOCsdSeR+2/WoOlCWTyfrw/L1DdCC2r4LMi2zGZ
 +CsPrNJffNgmJuiTKun6dxBtw4n/Q1jc6bRvDHG1Id8sVC8Xt8DxHSUQWjjllOn2xLxfxjRsn8H
 nCKB12EqTgqu8w8UcS/909U6o2MrOpzhxlgW3H+t2i0RZFJVH5CATlIL92Gfb23pxcI5YKd40Ky
 LZaG0OlllQmpqwjNK/Q9mP8ont9M9pVXgScA==
X-Google-Smtp-Source: AGHT+IEFEVH+tcDB3oqyJjHjdx/Bp8SICwsvK+RMd8wcLCqAmKYmle7l4kWLoI+r6ecazLLoEZPPTw==
X-Received: by 2002:a05:600c:c055:b0:46e:1b9d:ac6c with SMTP id
 5b1f17b1804b1-46e58d165a6mr28490055e9.17.1759257646302; 
 Tue, 30 Sep 2025 11:40:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b622f37sm19950415e9.1.2025.09.30.11.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:40:45 -0700 (PDT)
Message-ID: <ba150735-e4c8-4592-8df4-d408abac0933@linaro.org>
Date: Tue, 30 Sep 2025 20:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] gpio: qcom: Support GPIOs on PM7325 PMIC
To: Luca Weiss <luca.weiss@fairphone.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250917-spmi-gpio-pm7325-v1-1-6b75c2c62d8b@fairphone.com>
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
In-Reply-To: <20250917-spmi-gpio-pm7325-v1-1-6b75c2c62d8b@fairphone.com>
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

On 9/17/25 14:52, Luca Weiss wrote:
> The GPIOs on PM7325 work fine using the qcom_spmi_gpio driver and
> enables the use of the Volume Up button Fairphone 5 smartphone.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/gpio/qcom_spmi_gpio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index 3f3c98e2d935a34bb030532025e8765a2dd2b186..c540648497d7f958dca51e9be399c5443a8eeebe 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -744,6 +744,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
>   
>   static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
>   	{ .compatible = "qcom,pm6350-gpio" },
> +	{ .compatible = "qcom,pm7325-gpio" },
>   	{ .compatible = "qcom,pm8550-gpio" },
>   	{ .compatible = "qcom,pm8550b-gpio" },
>   	{ .compatible = "qcom,pm8550ve-gpio" },
> 
> ---
> base-commit: 18973d4b0801ec6d7fddc0084601036b5c3b08ad
> change-id: 20250917-spmi-gpio-pm7325-4551f3999f1c
> prerequisite-change-id: 20250618-sm6350-bringup-08e24e0f8bb2:v2
> prerequisite-patch-id: f0b44882a110259dd421dc3fd223cf3569e32f2d
> prerequisite-patch-id: 8aeea48ec719d8c8f2f2533f0a121cb206bc9d8d
> prerequisite-patch-id: cad2258c74346db458bf00bfcfa7cf28bbaa5384
> prerequisite-patch-id: 662587c7dbb756b1a4ebc7094b8fc76bbf692ca8
> prerequisite-patch-id: 1f3bc441288f9f39da49f3352b2b859186d4f599
> prerequisite-patch-id: de48fae371ec03c10baf56714aff89a449323c75
> prerequisite-patch-id: b98fd5098930e14ddb1818921abaed1a204d7d07
> prerequisite-patch-id: 0f12120d67ad63d2332f9dc095219f6c00e1df3b
> prerequisite-patch-id: 51738fdbf87d833f90106b60e874e74286b84fad
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
