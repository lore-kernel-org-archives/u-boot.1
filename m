Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED21C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 10:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A21C87F88;
	Tue, 20 Feb 2024 11:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jeTMlCAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA7087D91; Tue, 20 Feb 2024 11:43:18 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9310387F99
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso5581226a12.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 02:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708425791; x=1709030591; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L65oWphDHgMlR4eZuh7VdGVaYzP1VkbC55H5WecoR9k=;
 b=jeTMlCAyQ3PrzmkO+s2oVQ3nH0YWuEoJIK02WZ5QwUP3J1pn8eUZ7cLDTvIFOf64b3
 wMPMIQPFLpN9WvXtE7Be2kGPdA2HcMnmQS1/0aVV4Vi8bJ/mJrZEV69CHp7aFpXCXeF5
 k5qkhHVC97+TMxxxD3w1qcjO86PlNl1i4mq6EyWJkCfepAe5OtVgRHATyM6kzKga7u2y
 Lnbk/DHQxbzWipmw4VXfTWT9SFs8s/bU4slQOIDNanUVmyd94+/rLYl/3SCBaFMeIdok
 rNrYPSoPBZ5jPlqcHpSEqqs8HnCL0QdAb985OpD7tvdL2zkMUAQeevrdY7sDWKQJ5Bax
 3eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708425791; x=1709030591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L65oWphDHgMlR4eZuh7VdGVaYzP1VkbC55H5WecoR9k=;
 b=MzmFRaAhkr6LzW89wI2f9LeNa/qiVf932ozbi/5tLb3TpimVdQ9EDdWXEA8RPHw6pN
 ItQd7tZDpdYPNK7lsn73364dSF4390b6bBCZS7TpYig3472wNokV2raOA+cU8xWbNBYZ
 BTVCgYGgZaHHTFJXXXs/Psuuc1uNKis5YWpUeoVWoZfDvPqenKMXFdSDNsbvlCqRrVu3
 DaJtIuPg/ZA2fgXenwFgRKggq8d2WTh/YfSaiVKzWJQI5Xy5un7uLvlPm8aZLorHgHuQ
 RAw7PdwqqgPVk2XDNhrVXRmcNdgGU6eKw37INSobL7aQrTFEldsG6s3V1TfZRpguuw09
 1Hjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqjadJd6TnEIzfOPIGpVU212EaLxBe9JluFiMgn1Zrql5Vnnww6ey+GcFHQ+HhgHXAbinhMlEwvFw1s7YU8Q9imTFrIA==
X-Gm-Message-State: AOJu0YxOYpRTvMpkD97BHXoqpyLMkoiisDIuW4uWcYJgOsIuX0nDXYM+
 Cee4c35APNXT78XEb6nHr06EVlJr8T+I5G4P0RI0nq3pTaO8aeMwK4FtP56RFis=
X-Google-Smtp-Source: AGHT+IGuM1QOliGlc+WZhkfW7hw1LbZFE8JlX/KOP4+4yBDgbF1LShSUN3InGB99ekiu+b9lGgupvg==
X-Received: by 2002:aa7:d899:0:b0:564:4028:e2cf with SMTP id
 u25-20020aa7d899000000b005644028e2cfmr3771984edq.24.1708425790913; 
 Tue, 20 Feb 2024 02:43:10 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 j24-20020aa7ca58000000b00564a2d7da28sm1154746edt.41.2024.02.20.02.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 02:43:10 -0800 (PST)
Date: Tue, 20 Feb 2024 13:43:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: trini@konsulko.com, sjg@chromium.org, vigneshr@ti.com,
 matthias.schiffer@ew.tq-group.com, nm@ti.com, u-boot@lists.denx.de,
 srk@ti.com
Subject: Re: [PATCH v2] dma: ti: k3-udma: Fix error handling for
 setup_resources() in udma_probe()
Message-ID: <fcec04ca-33a3-4d6a-b9fc-5db9fc002311@moroto.mountain>
References: <20240220100451.1053667-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220100451.1053667-1-s-vadapalli@ti.com>
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

On Tue, Feb 20, 2024 at 03:34:51PM +0530, Siddharth Vadapalli wrote:
> In udma_probe() the return value of setup_resources() is stored in the
> u32 "ch_count" member of "struct udma_dev", due to which any negative
> return value which indicates an error is masked.
> 
> Fix this by storing the return value of setup_resources() in the already
> declared integer variable "ret", followed by assigning it to the "ch_count"
> member of "struct udma_dev" in case of no error.
> 
> While at it, change the "return ret" at the end of udma_probe() to a
> "return 0", to explicitly indicate that probe was successful.
> 
> Fixes: a8837cf43839 ("dma: ti: k3-udma: Query DMA channels allocated from Resource Manager")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

