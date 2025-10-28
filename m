Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38518CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8787836C8;
	Tue, 28 Oct 2025 14:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TNat7QJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D2C9836C8; Tue, 28 Oct 2025 14:02:14 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC06A8352B
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 14:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso3868812f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 06:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761656532; x=1762261332; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=uyZEaO1YZtNMqWdChpQVYIYKSlJmCSLpDn1B5ENyNPQ=;
 b=TNat7QJrjDF2cxVjqr9gLM5Xvo5jqhqVIQL1Ms+8NjsL53Li3ExRLJz7sF+nFdRlKN
 ZZiWX6XiSR09FapRrpQ/Ow8cdNvjpjCKkxWF15M1ENdaxea9jTfQ7h/Hd95gxQY6+6UZ
 QtwTPUw+sDLFh7hFcqoUYPoKZZyFE+CYVgK8j30EnDl9WHqu4FgFraZZo6VhE3llp5ec
 nH3Mi6F2WJnTVTkl9DesNk8RS70H8xcdMGNGLridtXhRtOkRHgurLyVI3ZfOmW2waI1R
 1q8p9LDGwWcTHqeXO518V70vC5wkTe2p1iGrfoUOhYao4Zk+v2uIDx8G2p8G/yWzYglQ
 cSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761656532; x=1762261332;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uyZEaO1YZtNMqWdChpQVYIYKSlJmCSLpDn1B5ENyNPQ=;
 b=EIWQOTwRtsFmzyMikNLKpERD7y81c8IRslcZS58f0oHvfLLd2CkupqEBj5Qi4ejDP/
 MUiKU+k/6dxyoffMdr4DwrSOy2uQAy+kMHMPnl8kEsNWy9AzRpO0JX8zJio0nnDVW7uA
 BFsemURUR4X/yPjam49LQFh2nkYqh0Rqp631gj4Ho6WYftWPA7JkVqKWDdh4UpydhVZ+
 /1Fs7TaQGZleUrErCfxso9iLB4h87GYwrgii/tzokCGzHhGXBuRmwSdYJaU9LV0ma5o6
 0+Cb/bnFyHMprzQxpUdqqvZWM2CX9wh1R4iG6MvF1c5ErP62nYUN0SCMNjUKx8huBS8X
 ScwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4hW40xyIWEhAzHQswssa6Fvrvlyizs+Boh7262oAoJgdcXi4ydZ5rJ3EaeU3wlEQnlj10xl4=@lists.denx.de
X-Gm-Message-State: AOJu0YzLSqk1QRmuFDFRNYd6vLJUaTkzd5zvAoosaHPQstWtHOi4qj2P
 47aKe0mPnu4vwPXeWYWKulDCPHTUW6H0WO2ZLo8CXgUPAeNp3+MUh8rSkEzi6kRVpi4=
X-Gm-Gg: ASbGncsvLz5IZFqQ8uD4AydQocXsoCqLs9N3dCkrUqBpKJhap2mSXBYU90rwFOJBrfN
 v00bo4JizfesqmsOuvknbbXwLmyRJ5sNsq1j+LHiZeeLqKupy1dC5NR2aNe0q7Mm49OnKYJZG6K
 b5iKpZ/G0OGwNn5cbuIjWKG0zebUOMQ5xLYahCYZTRBlJbdTpHqr+U6BCJx2pS6OYy1U6Ly84He
 dndFGpYj9eIsJzfVKYmLyTj6fws1J2eS1gNTUaLXXK+s/M9aW+NCzu16eAF8c1p5It9rSz0Za1L
 DUafttrWggc1cdmYBsCAwnCaOH4dtrMJsoqJ0uclVBszw7Nsn5M6RbdPdDB57MiO1X6JXfrnXA+
 +H52SWFd1y8Rjj4SZZ6eCMZniDMNaaEQyfLB9nX2OTJpAGNPkK61Ix76It5cbWOPMxYnl8o77d/
 GQh8nygd8h7IQQD1N3wZUpIhVboScWGgFjyCqC2CMmpsA16u+vsg==
X-Google-Smtp-Source: AGHT+IFeMBNwIzxaX3OseGQaA4FK/h5TNftjYv99Mv5T1hsXMKbg51TQvCXWorUdL+065scsE//VSg==
X-Received: by 2002:a05:6000:2088:b0:425:7e38:a09e with SMTP id
 ffacd0b85a97d-429a7e4a11emr2518567f8f.2.1761656531964; 
 Tue, 28 Oct 2025 06:02:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db839sm21054656f8f.34.2025.10.28.06.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 06:02:11 -0700 (PDT)
Message-ID: <ea83aa0d-9db8-4a7a-8b4e-bf32c9aa4ffc@linaro.org>
Date: Tue, 28 Oct 2025 14:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 3/4] mach-snapdragon: fixup power-domains
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 peng.fan@nxp.com, rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
 <20251027113312.3815169-4-aswinm@qti.qualcomm.com>
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
In-Reply-To: <20251027113312.3815169-4-aswinm@qti.qualcomm.com>
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

On 10/27/25 12:33, Aswin Murugan wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> RPMH power domain properties were initially removed from the
> device tree due to the absence of driver support. Since RPMH
> power domain driver is added now, the fixups are removed.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v5:
> - No changes to this patch in v5
> 
> v4:
> - Reverted the inclusion of qcom-rpmpd.h header in pervious versions.
> 
> v3:
> - Removed OF_LIVE_SA8775P config, since there is no SA8775P specific fixups are done
> 
> v2:
> - Removed the power domain fixups, since the power domains are handled in qcom-rpmhpd driver
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 31 -----------------------------
>   1 file changed, 31 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index eec2c0c757e..93c16821e54 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -116,36 +116,6 @@ static void fixup_usb_nodes(struct device_node *root)
>   	}
>   }
>   
> -/* Remove all references to the rpmhpd device */
> -static void fixup_power_domains(struct device_node *root)
> -{
> -	struct device_node *pd = NULL, *np = NULL;
> -	struct property *prop;
> -	const __be32 *val;
> -
> -	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
> -	for_each_of_allnodes_from(root, pd) {
> -		if (pd->name && !strcmp("power-controller", pd->name))
> -			break;
> -	}
> -
> -	/* Sanity check that this is indeed a power domain controller */
> -	if (!of_find_property(pd, "#power-domain-cells", NULL)) {
> -		log_err("Found power-controller but it doesn't have #power-domain-cells\n");
> -		return;
> -	}
> -
> -	/* Remove all references to the power domain controller */
> -	for_each_of_allnodes_from(root, np) {
> -		if (!(prop = of_find_property(np, "power-domains", NULL)))
> -			continue;
> -
> -		val = prop->value;
> -		if (val[0] == cpu_to_fdt32(pd->phandle))
> -			of_remove_property(np, prop);
> -	}
> -}
> -
>   #define time_call(func, ...) \
>   	do { \
>   		u64 start = timer_get_us(); \
> @@ -158,7 +128,6 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>   	struct device_node *root = event->data.of_live_built.root;
>   
>   	time_call(fixup_usb_nodes, root);
> -	time_call(fixup_power_domains, root);

I think the fixup should be removed only if QCOM_POWER_DOMAIN is enabled, no ?

Neil


>   
>   	return 0;
>   }

