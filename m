Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD87C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 14:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E027870BC;
	Tue, 14 Nov 2023 15:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jAZBoayE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD76868AE; Tue, 14 Nov 2023 15:56:48 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5609870D2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 15:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40839652b97so44919425e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699973806; x=1700578606; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zUiSphwKkftrhJ8dfGFL1rPc/SgpwTn53A3Uzr3MVX0=;
 b=jAZBoayENG/w9wcy6qGp7G/M11/xuZisxOaJieqgczCRoOc6qK2TCOQORnW178Ndyr
 6tJzksjkNg7cGGOslYefd3w2VqSqWb8Azfrj+0SH6VNEjCvCa9zIgepsFi213G/R9iH2
 e9xdd8B4igOYz9jwAH/058BK+Gxk2bxOKUZC1f3AwbVlKJj1ojgssZL1AWN9EPVloMYX
 GBPM5lg8GkcEfLZCkNiQudCEFEA2w/Fo4PwDDQACczdz4IlLtO0fih9RrL7H8YUa78NG
 BJt5tlSM3qyLFB0tKnfxYyE+poqR/k/JZcE0RRIC1ZD2gqx4DML4L91PgK2jx2AxpKv8
 p50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699973806; x=1700578606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zUiSphwKkftrhJ8dfGFL1rPc/SgpwTn53A3Uzr3MVX0=;
 b=BIMHPD0y2HZmsDGg2RlvZvUqEtzz03sTF3B9wPb4xGkInas2FYntVUZnQknwX5/FmW
 z1pkkYUZcnD0SMfXw2xIdMJt298PMdRovscEVMhZ8HIf3SYFT6Cn79+S6sPB9RvEDkmo
 h9QK3ym1Mnakwa+YEA0ngintd/hqzy0MZ6SgDLeoVUIVO8KuuMe3tteHXWvXvrOgEOtG
 gaC8m7PyjaVEqd9KHoLzVbJ3mTczyQoLWg85d5+ApHizrV2Pj4Sc5r3gqV612g49jIPb
 0pPSea4Ppx2YK4ZXQpyxv62ZUZ2fBxUHxVI54NQXAwymrJFzCeiZCbosCTMtJP8KL8AV
 NAXQ==
X-Gm-Message-State: AOJu0Ywl8Tak28lnt+gFAjZkr+yrEp7/FZV286Qz2N3XB/O82IzsLwjl
 an71vfJqHBYiIlVx6x5qT6/oqQ==
X-Google-Smtp-Source: AGHT+IFlHYJM+kM/JZL3f7mfJF4oQHATKyYb13B4HrxlmcysaoH6eLKD43EQgLE9MRHFfhfwGG+8ig==
X-Received: by 2002:a05:600c:a0a:b0:404:72fe:ed5c with SMTP id
 z10-20020a05600c0a0a00b0040472feed5cmr8389519wmp.29.1699973806260; 
 Tue, 14 Nov 2023 06:56:46 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a1c720f000000b0040a44179a88sm14375754wmc.42.2023.11.14.06.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:56:45 -0800 (PST)
Message-ID: <16d76254-8883-41c0-85cf-81bc9977ac59@linaro.org>
Date: Tue, 14 Nov 2023 14:56:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: msm-geni: don't rely on parent misc device
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: u-boot@lists.denx.de
References: <20231114-b4-geni-uart-v1-0-48c8ba9dda36@linaro.org>
 <20231114-b4-geni-uart-v1-1-48c8ba9dda36@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231114-b4-geni-uart-v1-1-48c8ba9dda36@linaro.org>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index 78fd9389c036..3e2e15b6cefe 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
[...]
> @@ -499,16 +499,22 @@ static void geni_set_oversampling(struct udevice *dev)
>  	 * It could happen that GENI SE IP is missing in the board's device
>  	 * tree or GENI UART node is a direct child of SoC device tree node.
>  	 */
> -	if (device_get_uclass_id(parent_dev) != UCLASS_MISC)
> -		return;
> +	if (!ofnode_device_is_compatible(parent_node, "qcom,geni-se-qup")) {
> +		pr_err("%s: UART node must be a child of geniqup node\n",
> +		       __func__);
> +		return -ENODEV;
> +	}
>  
> -	ret = misc_read(parent_dev, QUP_HW_VER_REG,
> -			&geni_se_version, sizeof(geni_se_version));
> -	if (ret != sizeof(geni_se_version))
> -		return;
> +	/* Read the HW_VER register relative to the parents address space */
> +	addr = ofnode_get_addr(parent_node);
> +	geni_se_version = readl(addr + QUP_HW_VER_REG);
> +
> +	printf("geni_se_version: %x\n", geni_se_version);

Drop this debugging printf
>  
>  	if (geni_se_version >= QUP_SE_VERSION_2_5)
>  		priv->oversampling /= 2;
> +
> +	return 0;
>  }
>  
>  static inline void geni_serial_init(struct udevice *dev)
> @@ -553,8 +559,11 @@ static inline void geni_serial_init(struct udevice *dev)
>  static int msm_serial_probe(struct udevice *dev)
>  {
>  	struct msm_serial_data *priv = dev_get_priv(dev);
> +	int ret;
>  
> -	geni_set_oversampling(dev);
> +	ret = geni_set_oversampling(dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* No need to reinitialize the UART after relocation */
>  	if (gd->flags & GD_FLG_RELOC)
> 

-- 
// Caleb (they/them)
