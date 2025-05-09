Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6537C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 21:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0D582162;
	Fri,  9 May 2025 23:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ez8+Kslw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA7B8269F; Fri,  9 May 2025 23:24:35 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C17A68211F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 23:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad239f23e8fso13339366b.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746825872; x=1747430672; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZvmAB7/Wh1bw5qHcNY0N40vp8J1AENj0zvIrmWlMPc=;
 b=Ez8+Kslwror1WJZYxN5OkEhh+y24b0zAd8L4dQp8jJPJGQ9kI1rgism8YWTaEkEVva
 Y5D8saOkbww/63zD9sMLk68EjQr6xxjiKkmUA0V2TJXgdYloB0r3L6y0OKEqAgDqPRvg
 hAkpfhbN3KQ/oRgAyAXdk01LEe3KztbmGMuuQkmdjvNWUVDIJ7vTFVPj6ueZBD9Fov09
 lsJ9udwKLb4DZSLAhXBIJmDDR5LPyTGZ0a0TAcKFu3iwxrDknXjZgo+El5TkMSlBz5Ol
 bzcICua9Y+dhYbKcJVzaIxn+Ls9b/EJme+H0zIbueECwXBC8O2/586em1G7y/zAl97r4
 qE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746825872; x=1747430672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZvmAB7/Wh1bw5qHcNY0N40vp8J1AENj0zvIrmWlMPc=;
 b=KrSK55dNbdYjDjzUIGd7KFU1a4aYBxT6dGexr0nNtXMCDH7Pv5f78S7mLQcJBncB5G
 oFbGDIBFHGk/9VkRiWPhOY7jqqyWQ3Wh3PKd3w/vuuAYkOTq5ULBEaHh1GELiK9Kfpai
 AAg+xHVlIt10g9AqwpUY7hK516Gshl3TVmYKYLXiJ+ZRRP98A9sKtxLqE0WLM3rrPBaG
 u5b83XdT8a4i4iTVY2RlvNlp75be3mP3FNG7pO57rSpb7hJ75BzypCdtbAWyjZozTvIK
 8biifMAAHGJx3JolioY4jlL6x/D3NKeZYHNw8Sx3DrhAkgzi8HNw/jdMycwM91Yiw6cC
 Or8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTIg3jiV33KKBG9v3yirxQku2QcgcM0r0K8u5rrfSPl93jVg03BqDp8o9TJ1FjxOM8UHlyZgc=@lists.denx.de
X-Gm-Message-State: AOJu0YxsoyWdToJALydC9tNs+Dy1302QU2REKz8PmS9Fj2Vqd+dNCBIz
 eV64k/D/augtbYbbSJQprT3q966rUFlyXfWekk6CbVzFbn2wyLjkQFq0lf9KOfg=
X-Gm-Gg: ASbGncuawu5JWGHA0MKQ29UeHEDaVxnynZEgSWGxdmIiMrR9WWkE+Vb8t5vQFje7a1R
 f/M/VcOuUdRLLnrmuKEZn6u2uwuXXCzSMbpVHMcvqze8hc2cqpGLhdZB2cXtBdrXKDCVkCpbUrM
 CUUjHYsGz0RGI31ZT76K2iBNTNV+yzfiExcNhP7GSxJwrrFhPt5TkdtbBIwRjMbHMmoxJiuRgcu
 d3cVuHYnUvg3ny9L2RuGRA6cev2/9JEMVrnUYG3UqcHP5jYC91GQIhAOvRurgSCEJEgIQgPVHrf
 xO5Cplp52IRc547KvmVqCC/THVmXJIYQsUw303CEuC2MMfX2/j4xhhFeAouLKjhn9fPdupFNENl
 Vyq/VCUDtPEVlthD49ARSPcgTtQth5xlc2CEzAId048zIo7c0bFhYIyRcmLkx+HSp5mon0sstXl
 Jgg/R/XyQR6S6mqAVqVi5ZILpJsGvO6X6MDRB0nhdKpWc7IRw=
X-Google-Smtp-Source: AGHT+IF+ZomGiQKk2VGwSmUL0/8AsPCsEd8xR4nyh46DMbPcVxhNgLHBXd2TYwIMLwmnm6A2KKgN3A==
X-Received: by 2002:a17:907:84c:b0:ad1:8f1f:6961 with SMTP id
 a640c23a62f3a-ad2191405e9mr433314466b.43.1746825872100; 
 Fri, 09 May 2025 14:24:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:3b8a:ea00:8f63:e334:c9f0:f1e4?
 (2001-1c00-3b8a-ea00-8f63-e334-c9f0-f1e4.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:3b8a:ea00:8f63:e334:c9f0:f1e4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219376451sm206788866b.77.2025.05.09.14.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 14:24:31 -0700 (PDT)
Message-ID: <e6fdd5e8-daef-4e35-8a76-8823d99456f2@linaro.org>
Date: Fri, 9 May 2025 23:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] button: qcom-pmic: allow to specify code in devicetree
To: Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250424014811.3809818-1-alexeymin@minlexx.ru>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250424014811.3809818-1-alexeymin@minlexx.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 May 2025 23:33:32 +0200
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 4/24/25 03:48, Alexey Minnekhanov wrote:
> From: Alexey Minnekhanov <alexeymin@postmarketos.org>
> 
> Most device vendors put "Volume Down" button onto PMIC RESIN.
> But Sony is special: see
> dts/upstream/src/arm64/qcom/sdm630-sony-xperia-nile.dtsi or [1].
> They put "Volume Down" on PMIC GPIO 7 where others usually put
> "Volume Up", and KEY_VOLUMEUP is inside &pon_resin.
> 
> Currently if you boot U-Boot on such Sony device, you end up
> with 2 "Volume Down" buttons, and no "Volume Up", which makes
> navigating menu problematic.
> 
> Support reading devicetree "linux,code" property and override
> statically defined button code & label based on that.
> 
> [1] https://elixir.bootlin.com/linux/v6.15-rc3/source/arch/
> arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi#L263
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Thanks!

> ---
>   drivers/button/button-qcom-pmic.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index e3bb9bd758a..85addfe32a2 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -143,6 +143,21 @@ static int qcom_pwrkey_probe(struct udevice *dev)
>   
>   	priv->base = base;
>   
> +	ret = dev_read_u32(dev, "linux,code", &priv->code);
> +	if (ret == 0) {
> +		/* convert key, if read OK */
> +		switch (priv->code) {
> +		case KEY_VOLUMEDOWN:
> +			priv->code = KEY_DOWN;
> +			uc_plat->label = "Volume Down";
> +			break;
> +		case KEY_VOLUMEUP:
> +			priv->code = KEY_UP;
> +			uc_plat->label = "Volume Up";
> +			break;
> +		}
> +	}
> +
>   	/* Do a sanity check */
>   	ret = pmic_reg_read(priv->pmic, priv->base + REG_TYPE);
>   	if (ret != 0x1 && ret != 0xb) {

-- 
Casey (she/they)

