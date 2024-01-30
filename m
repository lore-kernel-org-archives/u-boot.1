Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75DAC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC8D87E14;
	Tue, 30 Jan 2024 15:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FT4zEGBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A0A87E1E; Tue, 30 Jan 2024 15:37:46 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2F987E10
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40fafae5532so3294265e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706625464; x=1707230264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o/lsW2A939r5o4nBht+X+J/yqPEaeHru8n5Yogd9wjM=;
 b=FT4zEGBUmSTZfIDAHGnV5wIyAJzlojfWCUbWhzZJ87PaN0vQBNkH27wZZPCwe97i/u
 ypwLcqlM0bwc6jbMKj1sDKV6+kLiVxIia/AVooT7qxELPv+NebBiUTHkXhWHlKXApi8C
 80nB8sp4HfX9VAxIV2LA0juEDEjzpsXUUirKhcDQHQqk6U1tXVDCUQwaw7sQrjC6OO55
 JpS2MnlGC9MV1/GEn5RrmYJ0/0CrPSxicfBt23TNGxUcXSpFMJLrb2YQk9Y5U718QC5+
 oOa8b3BiUz6JKX1dFUkS1Iy2QPsIPPW2CosOBKYs5A+uLhFGchFZeXzdo2QqnDm59V6j
 LobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706625464; x=1707230264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/lsW2A939r5o4nBht+X+J/yqPEaeHru8n5Yogd9wjM=;
 b=p1MOG78HSFgrSjhiFsvz5Pfu6xKgnQhm2g0jOML7LuzENIwcq72T8bA3MfNyvhYEhw
 n/GGM1XmjIPGsnbhUFG1216epDi3BG1yKZ1mtcSIyNKlyPmQQEpCBUcsxToKVpUYcXuC
 QsO479yUNHIKmKtvs4Uy7Hwi70fpbPvKA7eGIFmbtO51IrJa1hL6q1U8ug3CI7PCUDnG
 RZK7lTK9J/J3guLAahBSQpsD/YG5MH+ATkLscxsc0aJ1ZMDRhVll5ZZiaT6icpwuZQXE
 ToxKkdK1QR/RrgVzywRUPSNfJBpGSZQXPGEjirUZ/At3128WdOD2FZr3VmM8nBQdjOIG
 6oaA==
X-Gm-Message-State: AOJu0YxPfvvvDvwSNdZhev4iVwz7EMmPNQhX7Q/d+BHby1c4m9mMI4Gd
 87MW5QirqyvXPKEmqFNLCDsjonyGf9anFBd3bGGemomqmWRjkjVdJ652/yV7mTY=
X-Google-Smtp-Source: AGHT+IGG0EZxfHX8wbCUND/1kXlSKO/5FN4c8xkbMec1/KzWHyyjopcRJf71TbRyPAbfDqVHgMCQ1g==
X-Received: by 2002:a05:600c:5123:b0:40e:5933:e2c2 with SMTP id
 o35-20020a05600c512300b0040e5933e2c2mr9577496wms.19.1706625463815; 
 Tue, 30 Jan 2024 06:37:43 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 fb4-20020a05600c520400b0040ebf340759sm13320691wmb.21.2024.01.30.06.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:37:43 -0800 (PST)
Date: Tue, 30 Jan 2024 17:37:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 14/36] board: dragonboard410c: upstream DT compat
Message-ID: <cf3dc99f-6c7b-42b2-9b4f-b3986aa2a646@moroto.mountain>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-14-e523cbf9e556@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-b4-qcom-common-target-v3-14-e523cbf9e556@linaro.org>
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

On Tue, Jan 30, 2024 at 02:05:02PM +0000, Caleb Connolly wrote:
> @@ -119,6 +120,26 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int ehci_usb_of_bind(struct udevice *dev)
> +{
> +	ofnode ulpi_node = ofnode_first_subnode(dev_ofnode(dev));
> +	ofnode phy_node;
> +
> +	if (!ofnode_valid(ulpi_node))
> +		return 0;
> +
> +	phy_node = ofnode_first_subnode(ulpi_node);
> +	if (!ofnode_valid(phy_node)) {
> +		printf("%s: ulpi subnode with no phy\n", __func__);
> +		return -ENOENT;
> +	}
> +
> +	return device_bind_driver_to_node(dev, "msm8916_usbphy", "msm8916_usbphy",
> +					  phy_node, NULL);
> +
> +	return 0;

Delete the extra return 0.

> +}

regards,
dan carpenter

