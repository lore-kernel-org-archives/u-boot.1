Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F99CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 16:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0596983E8E;
	Wed,  8 Oct 2025 18:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MutfxO2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5AAC83F6D; Wed,  8 Oct 2025 18:04:33 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B63FA83E42
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 18:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso102257f8f.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759939471; x=1760544271; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KeE9PUQb7K7gTCbxnZLgZJD1sgiyNKJkEegdhWR1F7M=;
 b=MutfxO2ifEgZ4d9ZQ9R5pN4JNzN9nbO4+v9hxl/KmFBb5VaktE+hzLNLTwmqOy++AO
 VEUzyMxmQIM3VNteIpYRS59CxIJrJX6+/Fwf+j0aB51n07tEuJqeXXI6j5EZkFs3k1in
 ztEOPYFqis8Lyj9/5kPeITQzsN7OGJj6YxORQUIf8r+hFMhg2zDHnWJDOjicKc/4c4Mc
 PA3FyLz025TQKiIQJMTuY7F4TCW2X7jHcv2LB7LFjOdKyZqK2t8E1gVilZDOuzeQjCBw
 HGZyNHFphpfUVzXdA4nr21/nSAxZ6nCxXaNLDogc5Kuew3t7n/2QYJ2HIhaj3Wa5cwZQ
 hRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759939471; x=1760544271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KeE9PUQb7K7gTCbxnZLgZJD1sgiyNKJkEegdhWR1F7M=;
 b=SfLswi5p9UG2zWm0HdA9J+vXTjV8vZdfAar9IEMcMjHrdC3bJWHfljfTDUrVMeoTXE
 dQIiUGlXD0dCvQmituK0Tskf1wGksP7D5IKmnSD5xhYhIjfXmB8zUZ3LAgHmjnTTxQXE
 ddvJvDlP8IAGuYgyJ64uurXTdpnKA9aMby9o/VV01N4wL7YU8wRdrxKbjDADBEJwxeBx
 Ukoa2CLyT0PFzs1b0kgCbueBzE+Py7PQRBEgT7uElu2GBY+umFrGxLaIbr4D5sGc6s7o
 ibMGaNu4psjwyZbhA5X4gC2jGEfsV58tE/S8izMUwX8M+akxbYWpZy0DrObdLzIkmyU0
 Ys/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwiH/Xs4+U6RNP1i4DZvKWO0CawaXQHWkvhbY7mTJVgQQbT0LuFKJFhYCPM6U2DLQ5x6sCrJU=@lists.denx.de
X-Gm-Message-State: AOJu0YyKPsGYUTKj39XWJxAsXAUKS7+NJDisS1L8rlMu1hMiN6Qa7OMN
 MOAP3SqGYITZ0p4hn+Fi/8acmDzkdwCcZcKa/hXBZC+e03KKmwbmY1k9v4stpvh7ADU=
X-Gm-Gg: ASbGncsDGt7mCkTOTcNEF3RHdjRPl3Js05cQXLeoyKszJetxf/hO56ixVwEpRO6+2Iu
 +IkSwIRuB19PmC4J9nDxaPV0b6ThntX+aX1IFmWiA1MRyznXXWAclp3/uOsYmemtQ2C/UbpNQnZ
 9MOuzBCUS8DsGhdy0jyVieLPCnIpolJciU+AiUuMKJzsLh4F3dqJ4GXQcfhe7JPWQepAGw29Y7p
 Iv0Rizc/Fxfjm6z5WD68TISLxXZZziaY2gLGDV3jlsV/AsK5YgtA3QCpoUHDfsU4cMgU0pJFVJF
 hWn2Be5LwqKeTI+PBaIqsEowYCU2zKIQumMYCHMw3To5Ck/NvAqcYZYtrBJdV1zsURGm6j3avic
 f7MTXlx5SLppmEsP+urHQMu3hmaeO1CqMwH9/ymYEMrAMtyilYL8Epix1j5FR969xPfV6FY1akx
 Kx66HSWRrGBUtN4+rOAOhOYVycN903lzVTlzFYVXd4nzENSVJDrU4=
X-Google-Smtp-Source: AGHT+IGD/KSw12PHEoMxQmd5zSoZvNokMZqlZCvz2+q5h2qAzhVKq1QhjcolqZXKns00REF6UkJwoA==
X-Received: by 2002:a05:6000:4382:b0:404:ac77:6598 with SMTP id
 ffacd0b85a97d-42666ac3fc9mr3020242f8f.11.1759939471117; 
 Wed, 08 Oct 2025 09:04:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:12ac:56e6:7ebe:67b1?
 ([2a01:e0a:3cb:7bb0:12ac:56e6:7ebe:67b1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf0bsm30528631f8f.17.2025.10.08.09.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 09:04:30 -0700 (PDT)
Message-ID: <df967074-ed4a-45f8-b36e-d680ae69f689@linaro.org>
Date: Wed, 8 Oct 2025 18:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dwc_eth_ops: Correct check for FDT_64BIT
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251008150148.1859420-1-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251008150148.1859420-1-trini@konsulko.com>
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



On 10/8/25 17:01, Tom Rini wrote:
> There is no xPL_FDT_64BIT symbol and it would furthermore not likely
> make sense for there to be one. Correct this check to use
> IS_ENABLED and not CONFIG_IS_ENABLED.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Fix the commit message per Jerome
> 
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/net/dwc_eth_qos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 551ee0ea6a02..a098916a674b 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1411,7 +1411,7 @@ static fdt_addr_t eqos_get_base_addr_common(struct udevice *dev, fdt_addr_t addr
>  	struct eqos_priv *eqos = dev_get_priv(dev);
>  
>  	if (addr == FDT_ADDR_T_NONE) {
> -#if CONFIG_IS_ENABLED(FDT_64BIT)
> +#if IS_ENABLED(CONFIG_FDT_64BIT)
>  		dev_err(dev, "addr=0x%llx is invalid.\n", addr);
>  #else
>  		dev_err(dev, "addr=0x%x is invalid.\n", addr);

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks!
-- 
Jerome
