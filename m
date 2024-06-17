Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1672C2BA18
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 09:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E897887D14;
	Mon, 17 Jun 2024 11:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="frGqwB3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E3587D70; Mon, 17 Jun 2024 11:53:32 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B54387CDA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 11:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52bc3130ae6so4680439e87.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718618010; x=1719222810; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XqS0qLtOzE16tGVNPJdRipwsw2RXjBDc19fT5YiT8Rg=;
 b=frGqwB3H8jKFyptJSOnHRGnUTITWlWbJG+pF+LZEoYfvx1SAKdAXhrbNYuzrj7m4Eg
 aUOAqqnISktL06IqKXS2l6feo2CRFpomkU6mJ0yZbS1X2V2Egpl5/RDX/EjpAVO5AkZp
 SZlMIxBLRKVX6QRdVMVz59IPI2NfzP0yIWGRvv7szE5jU8PCyqqtlRx9JZvyKEChGsZ/
 xGWbQus+mrBkYgJQWroNSA/HVV/zqNEErx5pQzvZ5hbZyYrusl8+Myp+Ty1tiv/xgTWY
 Q8tCpY9nes3dGDbX9YMZZr3gF4MhCgCihndUhBD/RnKZmko/qz69akDGMwxzdIDVBmeI
 lPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718618010; x=1719222810;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XqS0qLtOzE16tGVNPJdRipwsw2RXjBDc19fT5YiT8Rg=;
 b=ea7l0p7B23wMsSNPMmzrGd2JjJK8XaKs0xR+zni9c/NfQajP+xT/6hc8+DbnKECQTe
 pAVZ5hFpQpgqWegJCx3a6seA4/6xKA06dwJBewlwJF2gIGcHK+4iUWsuSXADJZzXeRTw
 Xs6penNM8Gn7zZd2fi94uoZ5EyVtgSGx/z6YCrkVrE+oin8csmFibRVZGtJ3EWDwnCGf
 CDfacR/FTTMWzN3S4ZnuEqY6TTFa+Z2LVZPfuBFopFUqzgrcSTtTjaNUCBmTKHO5uTkh
 +djVixKreaTZ6wjyhYBkpjKNLDNDvPZ6n9qM23Y//WPzkeBZAQMkSUtZAw6sGLMZAjHJ
 +94g==
X-Gm-Message-State: AOJu0YzMQNgZUEjzFaaT48UhOmuuhgL2AmkzhgJX7iysKiL4leim0npM
 8AvC/DiQ2bsFIIswNrONa30Sq15NBOZqj46M6HTF56LsYTus/jo5H6kcLlXkLNY=
X-Google-Smtp-Source: AGHT+IGro4HCOuB2wVxIyhk8XQ1AUBSYdOLzoEt8cmmzadH9UITM1ixqmF3qjmNjGMakv2RYDEGpTA==
X-Received: by 2002:a05:6512:2353:b0:52c:a8a5:df38 with SMTP id
 2adb3069b0e04-52ca8a5e126mr7479515e87.68.1718618009641; 
 Mon, 17 Jun 2024 02:53:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7f86:d83c:9278:7757?
 ([2a01:e0a:982:cbb0:7f86:d83c:9278:7757])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e73bcsm186710405e9.41.2024.06.17.02.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 02:53:29 -0700 (PDT)
Message-ID: <e007fc56-7b40-4517-901e-4062945c0f70@linaro.org>
Date: Mon, 17 Jun 2024 11:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] soc: qcom: rpmh and cmd-db drivers
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org>
 <20240617-b4-qcom-rpmh-v1-2-bd2336923e0a@linaro.org>
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
In-Reply-To: <20240617-b4-qcom-rpmh-v1-2-bd2336923e0a@linaro.org>
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

On 17/06/2024 10:32, Caleb Connolly wrote:
> Introduce two Qualcomm SoC drivers, the RPMh and cmd-db. RPMh is a the
> name for the second generation Resource Power Management hub on Qualcomm
> SoCs. Most core regulators have to be controlled via this hub.
> 
> The cmd-db is a region of memory which contains offsets and data about
> how to communicate with the RPMh.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/soc/Kconfig              |   1 +
>   drivers/soc/Makefile             |   1 +
>   drivers/soc/qcom/Kconfig         |  25 ++
>   drivers/soc/qcom/Makefile        |   4 +
>   drivers/soc/qcom/cmd-db.c        | 246 ++++++++++++++++
>   drivers/soc/qcom/rpmh-internal.h | 141 +++++++++
>   drivers/soc/qcom/rpmh-rsc.c      | 619 +++++++++++++++++++++++++++++++++++++++
>   drivers/soc/qcom/rpmh.c          | 110 +++++++
>   include/soc/qcom/cmd-db.h        |  42 +++
>   include/soc/qcom/rpmh.h          |  29 ++
>   include/soc/qcom/tcs.h           |  78 +++++
>   11 files changed, 1296 insertions(+)
> 

<snip>

> +
> +	if (drv->ver.major == 3) {
> +		printf("RPMh v3 not supported\n");
> +		return -EOPNOTSUPP;
> +	} else {
> +		drv->regs = rpmh_rsc_reg_offset_ver_2_7;
> +	}


I think you can safely add the v3 offsets:

==========><======================================
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 29fc0c2ed49..a4ff374675d 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -152,6 +152,24 @@ static u32 rpmh_rsc_reg_offset_ver_2_7[] = {
  	[RSC_DRV_CMD_RESP_DATA]		= 0x40,
  };

+static u32 rpmh_rsc_reg_offset_ver_3_0[] = {
+	[RSC_DRV_TCS_OFFSET]		= 672,
+	[RSC_DRV_CMD_OFFSET]		= 24,
+	[DRV_SOLVER_CONFIG]		= 0x04,
+	[DRV_PRNT_CHLD_CONFIG]		= 0x0C,
+	[RSC_DRV_IRQ_ENABLE]		= 0x00,
+	[RSC_DRV_IRQ_STATUS]		= 0x04,
+	[RSC_DRV_IRQ_CLEAR]		= 0x08,
+	[RSC_DRV_CMD_WAIT_FOR_CMPL]	= 0x20,
+	[RSC_DRV_CONTROL]		= 0x24,
+	[RSC_DRV_STATUS]		= 0x28,
+	[RSC_DRV_CMD_ENABLE]		= 0x2C,
+	[RSC_DRV_CMD_MSGID]		= 0x34,
+	[RSC_DRV_CMD_ADDR]		= 0x38,
+	[RSC_DRV_CMD_DATA]		= 0x3C,
+	[RSC_DRV_CMD_STATUS]		= 0x40,
+	[RSC_DRV_CMD_RESP_DATA]		= 0x44,
+};

  static inline void __iomem *
  tcs_reg_addr(const struct rsc_drv *drv, int reg, int tcs_id)
@@ -573,10 +591,9 @@ found:
  	drv->ver.minor = rsc_id & (MINOR_VER_MASK << MINOR_VER_SHIFT);
  	drv->ver.minor >>= MINOR_VER_SHIFT;

-	if (drv->ver.major == 3) {
-		printf("RPMh v3 not supported\n");
-		return -ENOTSUPP;
-	} else
+	if (drv->ver.major == 3)
+		drv->regs = rpmh_rsc_reg_offset_ver_3_0;
+	else
  		drv->regs = rpmh_rsc_reg_offset_ver_2_7;

  	ret = rpmh_probe_tcs_config(dev, drv);
==========><======================================

And add my:
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550 & SM8^%)


<snip>

