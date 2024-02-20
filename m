Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09726C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 09:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F85687E02;
	Tue, 20 Feb 2024 10:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P6GK9NKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8824787D7E; Tue, 20 Feb 2024 10:51:12 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1423A87FA6
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 10:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3e8c1e4aa7so201981866b.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 01:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708422665; x=1709027465; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IT2Qak09ilBeVNUrmqFEw9pIEc23Y0szvVgeI1xIqtA=;
 b=P6GK9NKceq7D8mfvMS6tyFSC2hj8AIh6B4+523mLk17vYCt/N98v+TA0ggV/gwhoVy
 H1QfYMRY0HdNtuBYy4MKKJSO3c4J40H+j127COAwyMQKrWvwpM0r/9iqYS0/sTquiBqa
 IiuNFQJs5N5pKPjwIaeP0e164hT/AxwOV0Wjc5nUa1qKhOSfjPEyPd4E6zGKzaAYKOa5
 DYFPE/vp5fTG8yZDRtwnfyB1UuUKev2zDzdYZZtzsCnJoNeUxzHI/slxgnrR4T+902q6
 TIv8fsQa4lGp5bwMRas/Mr6m7O/q2FDG/JmnDd3d1sGK/63HQ+G1LtrbPSsUTajXJMWd
 ND4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708422665; x=1709027465;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IT2Qak09ilBeVNUrmqFEw9pIEc23Y0szvVgeI1xIqtA=;
 b=s1N1DJ6aFUbw4QPzeaGpj+hy4ODmWQffHWsVIMmu9BPF01jZ3SN/7WHpszkzOQ8oWV
 qm7LTZrIYyc/IyYgFzWobDZqyp5ApauctmjJVQYkGb36aunV9koxrJ3Y6OO2ihPpgfN1
 pQLYtGUQ/d6kfeD5j41BEwXFMOEbULwdDybM6LYorp4hnI2c2JBs6gvWXFU44LWVfSfN
 iVm02rAC6FCOfmUN4nyYJTu6NqiNH2hJZQfJ+09QIeIuKPxhAq+O/xgE/SQbVOttvsos
 sbpu0a3V3A5II89ljkVeABEX1nU+fSaCkWiF9MOTMYbJt6ZbtcPMVcWfqJC7i84hjeD+
 FaIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwocqeR30/1VvXVEuW50FCIghlTOLFluNF71UrCqabr+5Tsc4FurJE0oaj8rH0WXlmfmMn83WAwOJePCchivIqBCyBgQ==
X-Gm-Message-State: AOJu0YwxnYTqBYO+BBGjOr812Pa9IoEtt0SK78X8aPpQaYzKW4eoIxsr
 glwaYBGsEYDL8EGF8PT0xVG9pQ7FPFbx3DhWk6fbJMWg0ugaXIGVo/hxRwccN3E=
X-Google-Smtp-Source: AGHT+IEYA72jknOVaMT9Yj3RiC/aIdK3NtEHWZcaivCEp3FHfg8QBtaFrEWffs1vCQt77gd4FxdnNA==
X-Received: by 2002:a17:906:27d4:b0:a3e:b0b4:a83f with SMTP id
 k20-20020a17090627d400b00a3eb0b4a83fmr3261034ejc.6.1708422665580; 
 Tue, 20 Feb 2024 01:51:05 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 js1-20020a170906ca8100b00a3ec3390ea1sm1331309ejb.25.2024.02.20.01.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 01:51:05 -0800 (PST)
Date: Tue, 20 Feb 2024 12:51:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: trini@konsulko.com, sjg@chromium.org, vigneshr@ti.com,
 matthias.schiffer@ew.tq-group.com, nm@ti.com, u-boot@lists.denx.de,
 srk@ti.com
Subject: Re: [PATCH] dma: ti: k3-udma: Fix error handling for
 setup_resources() in udma_probe()
Message-ID: <bca16d1a-986d-4e73-9ac0-2799a058c06f@moroto.mountain>
References: <20240216104105.494602-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216104105.494602-1-s-vadapalli@ti.com>
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

On Fri, Feb 16, 2024 at 04:11:05PM +0530, Siddharth Vadapalli wrote:
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index eea9ec9659..8a6625f034 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -1770,9 +1770,11 @@ static int udma_probe(struct udevice *dev)
>  		return PTR_ERR(ud->ringacc);
>  
>  	ud->dev = dev;
> -	ud->ch_count = setup_resources(ud);
> -	if (ud->ch_count <= 0)
> -		return ud->ch_count;
> +	ret = setup_resources(ud);
> +	if (ret <= 0)
> +		return ret;

The code was like this originally, but setup_resources() can't actually
return zero so it would be nicer to say:
	ret = setup_resources(ud);
	if (ret < 0)
		return ret;

regards,
dan carpenter


> +
> +	ud->ch_count = ret;
>  

