Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4651CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4812E8487F;
	Mon,  1 Jun 2026 14:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qEH0l+CA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670E58488D; Mon,  1 Jun 2026 14:03:32 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 614978487F
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 14:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so1984438f8f.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780315409; x=1780920209; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=a1Wey3un0fXTH19wrNGP1LhTu9gQnKFoUWyi+rqBlPU=;
 b=qEH0l+CAC9AjkjcVF99nqmB02HiU/6lzlWCef5owoVseHMvWSUGk2wY8FOqowWkZ2o
 3PNuHUfeWWMYWgEiu2drFjbyHGO/4GtFd9Lw+/zHvS7z1SMXp1CDci7u2jtrIHQL+NL7
 qhNUvsIkh9ibpoVxT0liWgO/l31ybg2QqmOv+qEEg8+v2IFcrM1j6wyX+0FSv/Hs7t1Q
 bAH5AfUzUYSBX/e0xJyCoAVmAg0PxM+ZYtVERG6E14o9Ect92i2cq3iWTdKXEBXNgnMa
 a5yaPsQUdmlwyeN/IRNSptdJlOXPa1wGwFqy4V73hY2Qh8Sewvg5kq0eygQGK5QPdj+J
 13nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315409; x=1780920209;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1Wey3un0fXTH19wrNGP1LhTu9gQnKFoUWyi+rqBlPU=;
 b=BhCzBzKmMzKSF6y4pnSIroa7Uja5xzcuCxCrczu1OkZkdy60xurLoofQrPJdhrGdZV
 HuMBXKyL90tCI1C3ZGfgh44tTWF2jMjApqKfM0XwRbkfwvddVf8gtCO5w9n4hlc2Yg6q
 JSNOc1UVc4axFz2aIXXmbEi8COinu7d9moPZQwhunDh37YsNybipsQlSzSZL3WVDNZfP
 BhXPJUChaHiT/oCL0TwK0gnevTcK/VEhL2WLtvIvDyhteTXX5RMqffYPE2/wGi34l14g
 nMf+6oPQLCItdauzke5Z+3J7sGmj3gdVVlh9+x7k3DDSBHz8F3zekXBGY+M5TMdMDyGe
 8M4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ90iKV1/Yw1e3s5YuuPBu3Z7JvOFqKR1QKOT0wTzTTrlgRb5wInjjf1n7xB20yItlidYiOjdsk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp2bL5vuaQhv4yvQECBbpr7YLdEMtx70/34v2KR8CkAG2jsxWa
 OBTuGhHw1GaFW40qxZwdx/T9xtyJIL6MHBTnKmjfs6VEfVF4ThcyZBIXsdHAuJTP3oM=
X-Gm-Gg: Acq92OEcZIgwU5ltMSirP0QcqF28vs2t5gciOlD8LSV8vKN7LBoUhkDF+h+71cyF8bf
 b86NfJ21g3xZkwbNNr8r8HjMAhsWUdCIQs9raec8hF6xKkUR5D1aCOZOoCcZ/Tlot8hR8IZ0abA
 VpkbTrTStkXIWBOAIWj7Oya/dP6JVw+5Hns/xICyt+G5cyVknkIYOVbAxnB9n0Vh449MybQR0eU
 7DXcRxdps9psp1En4L3yRJPDoKHH5MPb5nZqraQ/S9dDm3wfI3ulJFE2l827kAZfbIZJtRQJ7AL
 kgBwiviQOHaPAw+CynJ5IrRkmI2qjxU4kYGqYQjBAU+ut+GpSCTExk3sD1Lyiw6J3IR70PLv51j
 qDZH3XSckso2iYkeAWTiQy1L5uaU6to5Rsws21+Lr2v83Ld5v4Wr+LQ9GVnDlkvNjsBwfDQsX6a
 oVVykI757v+WBquvURzk60lwTTCCQmDDaQ5ecuioVNUfXPunn7vnPbUrCFAzqGiXeeHmRQYTFXm
 +6tPg51ht1Hx0kpcA==
X-Received: by 2002:a05:6000:18ab:b0:460:c9f:8747 with SMTP id
 ffacd0b85a97d-4600c9f897fmr11924854f8f.33.1780315408668; 
 Mon, 01 Jun 2026 05:03:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2fd4:bcb3:83d3:ecb5?
 ([2a01:e0a:106d:1080:2fd4:bcb3:83d3:ecb5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef356a4c4sm25348347f8f.31.2026.06.01.05.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 05:03:28 -0700 (PDT)
Message-ID: <337ae033-f5b4-4771-a063-dc6b0cd8f47a@linaro.org>
Date: Mon, 1 Jun 2026 14:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/2] Add gpio configuration support for Qualcomm
 Snapdragon platform
To: petr.hodina@protonmail.com, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Rui Miguel Silva <rui.silva@linaro.org>,
 phone-devel@vger.kernel.org
References: <20260601-qcom-gpio-v1-0-e24bcdb35da0@protonmail.com>
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
In-Reply-To: <20260601-qcom-gpio-v1-0-e24bcdb35da0@protonmail.com>
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

On 6/1/26 13:52, Petr Hodina via B4 Relay wrote:
> This patch series adds the gpio configuration as input along with
> pull-up/down/disable and drive strength for output.
> 
> Remove the reconfiguration from the set_direction.
> 
> This enables on mainline Linux phones to use volume-up in menu.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
> Petr Hodina (2):
>        gpio: qcom_pmic_gpio: implement standard pinconf parameters
>        gpio: qcom_pmic_gpio: don't reset pull on direction change
> 
>   drivers/gpio/qcom_pmic_gpio.c | 41 ++++++++++++++++++++++++++++++++---------

Please switch to drivers/gpio/qcom_spmi_gpio.c instead, this driver is
deprecated and should be removed once it's tested on all SoCs referenced.

Thanks,
Neil

>   1 file changed, 32 insertions(+), 9 deletions(-)
> ---
> base-commit: 1f89ddd61cd8c27a3dc1fc7edbeccb55d424eb72
> change-id: 20260601-qcom-gpio-98e85ab22647
> 
> Best regards,
> --
> Petr Hodina <petr.hodina@protonmail.com>
> 
> 

