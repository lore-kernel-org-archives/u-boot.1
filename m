Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FE3CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B06F0839FD;
	Tue, 28 Oct 2025 09:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ipBpj8+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD4F083A13; Tue, 28 Oct 2025 09:15:01 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E45839D6
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42966ce6dbdso4095006f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761639299; x=1762244099; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Wcu5xXbIS3pDMmPwBn10nYzO6zGgUnuBuqeE2aWdSTk=;
 b=ipBpj8+98IiCgROTonxNjyEITcIn1YXYfUSyLmd7FGuEXVrvvQh3ULbD6glvudTzFj
 +nnwHBdZCnooDeAKOEIuuJCRjDe+v38eVgyf4nm9YdIKupUi3ZFfi+CbS5VkzmuW7uie
 v5VJe51SdCfcb9wAhrqjRYS7gkYTTJ4kInnbS6BP4l48IW7g6tngcu5pAKLoFsCgrWo5
 U4JMdnXn6XA0XAwr0GpV3+d0YN7y/SpmV8aX4q9yvIOXjkuOSmwDE2HLBVuEh8vqEbkb
 C8yVrK+UTVtbV75dMAztw//xk1jT7Hx89YMSE3Jje3gLLqacNQxzpNpuDhPfDlYHb/dk
 XSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761639299; x=1762244099;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Wcu5xXbIS3pDMmPwBn10nYzO6zGgUnuBuqeE2aWdSTk=;
 b=UJ97Oz2oVWRTeCj2Y6bYsUQRiKX/GGDObA8GOCmYCxazUAoKQqEegDCJiQWNDDSucw
 uQQsJ7d7xPCtYNWcgNoOpdHJ/LADWeMB7HYBbx2fAAW8u1jlsXDbDuRPRrZc90xDbgB+
 gnx6yKmE+iGveNm2x4/3ro7Z/j6GU67JgktLij3QqnN/s5DFB8HePK1jDISWbAVS16+B
 QTvTi1diIjoxaAMoViwUQ6+z8VH5tbW/fkQcj8BStF0yhctN817B8UeXfZMvA5jHDHV4
 QrmFCb6GDkGdDYyOpO+PE10ftb85Z4KCY9umHYaeLXehHyigrSb7DQbq14hIf800qFHZ
 SrSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHLFQ5OBCSwV06EvjZwtzEXJ9Ju4Fv0T9WxosXEwz0/67SnqCPMLqZdwS27uDcfx/ocQAFXQE=@lists.denx.de
X-Gm-Message-State: AOJu0YwS6QMi99DBqAm5aLV0l2keb+WyQPUPOCnGq+ohLhymFBo9veeT
 05VEx01NcN/ij7d3HjM2nvIHWMjSR7i6rubhHWsCqhDLxZ7bsFOAnby/g1LVz2aFPoo=
X-Gm-Gg: ASbGncsBTf8ztjIJIrJB6GES+C4ZzAeTL9iwtetEO4d870Fuvski2/lyT0Li3AvG4ZG
 o96+JgrlrfaLEgsbFXja9soeyHWS6NNb8eqibdPXhktcDvMQ4425VprJqe7kQU3SL93/v3CBdow
 Hi1QP4GFhJMK7KMYCrCqqKZdpAlvFayeRouK3T4Z6uGySacw6TaBzhRmpt/iKNAho1wE7A1N4P+
 08vrVcGKf2qQUtgQK7FdW6VpaTD2xgHLstkKaZEM0961+boxE/ROlQ/SWclHxMk0XxPi/fzFdbZ
 PTPbjCsIPr7CFZWxd867oN8B9L6rydf0SAqm3aHBlThneE2DALZNEOH6moTYFZmeoUuuP5L/EeG
 7r9ja2lraWBiG3BfyQsrtn+bLlfJcF4tIntU4yfOD4h7LPQeApqQJQD6+O+JvpHvKR+1BmCxHfr
 RKiYpQidq/HOTbhg4SZ5ShMy1PJBjHMWmBmI280LFDrDEzoQqwxQ==
X-Google-Smtp-Source: AGHT+IEUZq3/YAIgQ34fZBaeQffY/CYzQPH5UtoK3+fQG8r6Z3DK/De94EMF0nwY7objwp9NVkYW7A==
X-Received: by 2002:a05:6000:2f85:b0:428:3e7f:88c3 with SMTP id
 ffacd0b85a97d-429a7e7a759mr2067300f8f.50.1761639298914; 
 Tue, 28 Oct 2025 01:14:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df473sm18838447f8f.42.2025.10.28.01.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:14:58 -0700 (PDT)
Message-ID: <d396ac77-5a44-4bd5-a964-b050797d4879@linaro.org>
Date: Tue, 28 Oct 2025 09:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/6] ufs: amd-versal2: Fix indent
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sumit Garg
 <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
 <20251027170706.29302-3-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20251027170706.29302-3-marek.vasut+renesas@mailbox.org>
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

On 10/27/25 18:06, Marek Vasut wrote:
> Fix indent, use tabs. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/ufs/ufs-amd-versal2.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index 896dda2de4e..89931921ff9 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -330,7 +330,7 @@ static int ufs_versal2_init(struct ufs_hba *hba)
>   		return PTR_ERR(priv->rstphy);
>   	}
>   
> -	ret =  zynqmp_pm_ufs_cal_reg(&cal);
> +	ret = zynqmp_pm_ufs_cal_reg(&cal);
>   	if (ret)
>   		return ret;
>   
> @@ -567,9 +567,9 @@ static const struct udevice_id ufs_versal2_ids[] = {
>   };
>   
>   U_BOOT_DRIVER(ufs_versal2_pltfm) = {
> -	.name           = "ufs-versal2-pltfm",
> -	.id             = UCLASS_UFS,
> -	.of_match       = ufs_versal2_ids,
> -	.probe          = ufs_versal2_probe,
> -	.bind           = ufs_versal2_bind,
> +	.name		= "ufs-versal2-pltfm",
> +	.id		= UCLASS_UFS,
> +	.of_match	= ufs_versal2_ids,
> +	.probe		= ufs_versal2_probe,
> +	.bind		= ufs_versal2_bind,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
