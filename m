Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F1BCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA64B8484F;
	Tue, 26 May 2026 16:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yfykaNMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F958488F; Tue, 26 May 2026 16:53:16 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0612A846A5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4585a116a4aso8888831f8f.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779807192; x=1780411992; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iiUjiBfDve9QTLVdhMwwP9HOc/5a+4H8wM3p9SKAmKU=;
 b=yfykaNMnIJ6h088W3o8wpX3GXCIaNff63JMDQLNPsQR5AfT4v8J9Q+dsPhtyrc3tVR
 iMzXrHAHHUVFADmqEQ2Ngh0OCE9DMcEdAmGJiuK60MDATNlLarWwQbxcLbwB5bvdU0El
 SkexpUSpRQkEY5uKugRr2hKdt12yrJZfWoKxI2ou+1JF6hUqHnv8LJcKCgzIGGMrme9k
 FNljG86gkavYzQwOpnosLC22GUszeMXvq6F3ygKWZP9E9i/07QGn8WGq6Odo2wEtuZsV
 pBZgO64zodzoADC/hJTfDLcAqaCaVJiBhVMbQgeQrBuzaZzKt+039GSrXdcpTnE7xuCy
 jF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807192; x=1780411992;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iiUjiBfDve9QTLVdhMwwP9HOc/5a+4H8wM3p9SKAmKU=;
 b=opZqgWyyW73h9cqUryuc+h1HD8PoLFnVjd+EdLxBbNY7Md1i4VPQhtbQkgnMlLuGf4
 qGjTp3uyRIxQMHfFBsQ0AqVRPideWO2uXUhh6f/2lu1bT2J4HY6AJ9BI1vvWxMwx9m9E
 oC8yDS1erGfkrOj0NM9yT0hVTzS23ZvnSapKTbXPn8hWKDO/qjAywBLd4C34DJyN+q9t
 AmCu11cQro5pbsBr2CaqBAt2BUGzZTnCVCXhJhSCNV7bRW7RzVl1jgvdfKV9poFWY4ql
 eVYWyFTfM0J5NP/4XmJU0djNOQtRSNsY1ZQXp4TtSXsqTmq4MGWG/pEXzHZ2asrSDhvM
 K8Kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/E/zbpu8vIzhs24mZe86RVKd0d52cWC8U9EYgTAu7um2A0ACZPXZ00n2G8cx/usDu3MjNVCqk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1hpMXoNJESCabmZDEfzWKMqHMQUloxpMV94cSNuzf6aIJurdl
 CTcG2a6YNbUhMmV6SrjcNU2x8fKFxCBGCG6TPeLkQvajsQ3YEciiINksNwIpcrB/5vw=
X-Gm-Gg: Acq92OFgNzFiCpFHw6jUcNPa+hB0ffoGSMic7xZ7EbpeliVlEmJMqryIXYlPMco4WZg
 PR0B8k6aBzUDMv6KhyN3yQajJMEYbHmjVx2Wl3Tk+xVgfZuuT1nsLFbIkhQfja2Y8usfNyPKAV1
 wBtgcedl/J+hF+GbudgddwHVZUViQJXuBL2v5QLZd3UR1N9ZEan3QL3ihOvB+zxo1pGg1zOYwTf
 JR/x1UhhbYemU8Kp3bV1VNwSDYaQYis9h7f/E+fpKq1pQmB/w+UtOUaoWotU6ExBI0NUnF/AZrS
 +mKj5qbW3fLazUQK3E5SLLEUFf6QWajQlYxVCodBM3A0OxDYdwaR9k93dlo4Fh5D2d0MoocEgLV
 ZsZTLx2qtUSkQ48Q4ENClwHzyG5F3FXSzyY3joc2O3aQoOAIjhUDrhx+EJ7ZAld2NMlDKnRlGUG
 iY2hwdvm5A6vs/UxuHSr9AWM+FdXV9JG1a6gtCxFwpXgzDoDW+mPMNBV/ckewMihyD16+xXnlo6
 A==
X-Received: by 2002:a05:6000:26ce:b0:45e:891c:648e with SMTP id
 ffacd0b85a97d-45eb36703damr30815024f8f.8.1779807192418; 
 Tue, 26 May 2026 07:53:12 -0700 (PDT)
Received: from [192.168.1.36] (p549d4239.dip0.t-ipconnect.de. [84.157.66.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd1780sm38786241f8f.16.2026.05.26.07.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:53:11 -0700 (PDT)
Message-ID: <b9e3b26b-6fcf-40f2-b959-e8d6afe92efb@linaro.org>
Date: Tue, 26 May 2026 16:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: Fix invalid usage of dev_read_addr
Content-Language: en-US
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
References: <BESP194MB28058363D3E3AD5E44EB31EBDA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <BESP194MB28058363D3E3AD5E44EB31EBDA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
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

Hi Francois,

On 25/05/2026 22:46, Francois Berder wrote:
> dev_read_addr returns a fdt_addr_t and not a pointer type.
> Replace dev_read_addr by dev_read_addr_ptr.
> Check that base pointer is valid.

Is there something in particular that motivated this change? The patch
is fine but basically comes across as noise since this error condition
will basically never be hit in practise (the DT would have to be wrong
in a really obvious basic way) and if it were the clock driver would
fail to probe and we'd crash hard.

I'm happy to take it but for the sake of accountability please add the
appropriate Fixes: tag and offer some more context on what tools you're
using to find issues like this.

Kind regards,

> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  drivers/clk/qcom/clock-qcom.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 6b46d9db744..e238b76d42e 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -489,8 +489,14 @@ static const struct reset_ops qcom_reset_ops = {
>  
>  static int qcom_reset_probe(struct udevice *dev)
>  {
> +	void *base;
> +
> +	base = dev_read_addr_ptr(dev);
> +	if (!base)
> +		return -EINVAL;
> +
>  	/* Set our priv pointer to the base address */
> -	dev_set_priv(dev, (void *)dev_read_addr(dev));
> +	dev_set_priv(dev, base);
>  
>  	return 0;
>  }
> @@ -564,8 +570,14 @@ static const struct power_domain_ops qcom_power_ops = {
>  
>  static int qcom_power_probe(struct udevice *dev)
>  {
> +	void *base;
> +
> +	base = dev_read_addr_ptr(dev);
> +	if (!base)
> +		return -EINVAL;
> +
>  	/* Set our priv pointer to the base address */
> -	dev_set_priv(dev, (void *)dev_read_addr(dev));
> +	dev_set_priv(dev, base);
>  
>  	return 0;
>  }

-- 
// Casey (she/her)

