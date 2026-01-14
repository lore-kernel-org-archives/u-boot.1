Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BF8D37E3B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755CA83623;
	Wed, 14 Jan 2026 15:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="icTWYpYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B39835B3; Wed, 14 Jan 2026 15:39:58 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5DBA80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso40281265e9.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768401596; x=1769006396; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=RDADzJv3EKdoU3yFZ39RzHNYUGiXmirOoZwTT778R9s=;
 b=icTWYpYCuocirIkGMv5fpKsnD2X6+agia6dg2s7oD+aUyv4q2PV1rnH/aa5QEnwYtJ
 WgU8MxiKhaotfrvrqedPPd3BRl9JkZZsmawA2TMc8pmAk7o/B8tO1l6GVozvhmJQpUNM
 zNrItZAWLXg2auxRatY5X2Amjd4QBp9dGzuGvxzGsT239PUk3ftMBVAlNbeUa/+PkmeA
 Be150ktAgf0hkAooV8gaHKcVfLURVHws/294cjMIzM/fo3wTsQOcZyqw21hQMsGII++R
 1SgL37T9twtBDfKmdkEl+bN7kv5kBq0Qbk6oNGxJvNe9vG00Lch59ww30dUywAvxR54L
 gnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768401596; x=1769006396;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDADzJv3EKdoU3yFZ39RzHNYUGiXmirOoZwTT778R9s=;
 b=aRB3+7kH6crIsifh1XIVuuWb/nC4rsm+EcxScDoo9pTjc0A8D6vEOcjD0NPnosJenb
 PfQ94KqqsmmkzXBtVxF429Mredd5U978Z3rjCYbbUCVzP5Xi2JS4uK2cgWsU4qMGbWh1
 EOoducaPniyDF/jTM7yO2osrcIzUBBRNmeVPO1kBEh0cZsJphqJFzayStL5+4bm1Nz78
 bc2qThVIk8S/JCpx9oK372NCnTlOXarOCuryypuUmvfyaUh5rkZeJFJTPrkQnOjRJlKk
 dz/rxfX0ixPESB1Dnd1mQYa7HUihbFwusslqxs528D/hvdqEEQvvlQMUMCW05t/S0bEC
 TtXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU496JNjxJI4jfqPI6lvrPExthjaT68nYECCKIAwhVvS8iP4Em0R9LI5KxUnNVbAIp7EhlyhXY=@lists.denx.de
X-Gm-Message-State: AOJu0YzywvRCEE4mBO4gTtwB0ICbLSSEDU3lv+4PTXGMV8MC9xRNtGXY
 Y4zvRWD7y4Y3QrfWjupKXqFW1rrK94qfCA4mXeW0Lte14+B+E/GKvQXSI8lxL56BkJ0=
X-Gm-Gg: AY/fxX56O0+Hap4ijuzSpHv2t26Jjlw9T/U2vUtWZUMgLmBTHLdSlhGbHPRh7peJqMX
 gR7579VP6Yx0HKcqGviK6S9tOEOf+vLYzwGBw7ky6ZkPaUXdo3NIiNePnml8FEyx2NWY7/0cQFf
 RaS08GZStgnaKm0kQVhZ7MoWbfx6/zrMQcQWreSEe0L/l8Bbp+2uSyk3Rf8ClhX3nmxEIC4OOlh
 MnNRnvyx55rXfRippE/0hNtD+U/DLZYbb79KpM1sO3athhRMwRbbz9M2OQED59goOOLmZ6fMePO
 CL2+rGegleSP6AdEjNyVBe3rqUVLYM5rfj54Vw6cVRe57xhJqd6OuTHZc2CtnLru6l7D8Vvk9+N
 +1wgx2gGleVNOBy6Ui1I7sPtPqkMGeuUTN9ngMuCQLD4pzk2lx1ly8CxWdb88U6jw3nYS5TDwr6
 ClfVuGJ7kKlyW8h3eE7Orh/MYISsBQGnQKFUXP+kxvXGWw17L9BVxO3pQ+Bb9oKPg=
X-Received: by 2002:a05:600c:8b2f:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-47ee4840941mr29048205e9.36.1768401595645; 
 Wed, 14 Jan 2026 06:39:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee0b48921sm25418295e9.0.2026.01.14.06.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:39:54 -0800 (PST)
Message-ID: <d1fbf0fd-9181-46a6-82a5-f8ffa9844a5a@linaro.org>
Date: Wed, 14 Jan 2026 15:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] mach-snapdragon: of_fixup: support new flat dwc3 node
To: Casey Connolly <casey.connolly@linaro.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 u-boot@lists.denx.de
References: <20260114135739.1546815-1-casey.connolly@linaro.org>
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
In-Reply-To: <20260114135739.1546815-1-casey.connolly@linaro.org>
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

On 1/14/26 14:57, Casey Connolly wrote:
> Qualcomm DTs are being updated to use a new format where the dwc3 glue
> node and controller are combined into a single DT node. Update the fixup
> code to handle this case.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 40 +++++++++++++++++++++--------
>   1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index eec2c0c757e0..5b6076ea8e57 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -31,31 +31,37 @@
>    * USB controllers. Rather than requiring source level DT changes, we fix up
>    * DT here. This improves compatibility with upstream DT and simplifies the
>    * porting process for new devices.
>    */
> -static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np)
> +static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np, bool flat)
>   {
>   	struct device_node *dwc3;
>   	int ret, len, hsphy_idx = 1;
>   	const __be32 *phandles;
>   	const char *second_phy_name;
>   
>   	debug("Fixing up %s\n", glue_np->name);
>   
> +	/* New DT flattens the glue and controller into a single node. */
> +	if (flat) {
> +		dwc3 = glue_np;
> +		debug("%s uses flat DT\n", glue_np->name);
> +	} else {
> +		/* Find the DWC3 node itself */
> +		dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
> +		if (!dwc3) {
> +			log_err("Failed to find dwc3 node\n");
> +			return -ENOENT;
> +		}
> +	}
> +
>   	/* Tell the glue driver to configure the wrapper for high-speed only operation */
>   	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
>   	if (ret) {
>   		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
>   		return ret;
>   	}
>   
> -	/* Find the DWC3 node itself */
> -	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
> -	if (!dwc3) {
> -		log_err("Failed to find dwc3 node\n");
> -		return -ENOENT;
> -	}
> -
>   	phandles = of_get_property(dwc3, "phys", &len);
>   	len /= sizeof(*phandles);
>   	if (len == 1) {
>   		log_debug("Only one phy, not a superspeed controller\n");
> @@ -103,15 +109,27 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
>   }
>   
>   static void fixup_usb_nodes(struct device_node *root)
>   {
> -	struct device_node *glue_np = root;
> +	struct device_node *glue_np = root, *tmp;
>   	int ret;
> +	bool flat;
> +
> +	while (true) {
> +		flat = false;
> +		/* First check for the old DT format with glue node then the new flattened format */
> +		tmp = of_find_compatible_node(glue_np, NULL, "qcom,dwc3");
> +		if (!tmp) {
> +			tmp = of_find_compatible_node(glue_np, NULL, "qcom,snps-dwc3");
> +			flat = !!tmp;
> +		}
> +		if (!tmp)
> +			break;
> +		glue_np = tmp;
>   
> -	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
>   		if (!of_device_is_available(glue_np))
>   			continue;
> -		ret = fixup_qcom_dwc3(root, glue_np);
> +		ret = fixup_qcom_dwc3(root, glue_np, flat);
>   		if (ret)
>   			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
>   	}
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
