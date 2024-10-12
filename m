Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAFACF2568
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 13:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5863D88B23;
	Sat, 12 Oct 2024 15:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jiseG7J9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AD5688B23; Sat, 12 Oct 2024 15:40:48 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC41788B4B
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 15:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c928611371so4081333a12.0
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728740445; x=1729345245; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Av3Q7J9i+ZMZAu9lFI8BujGQOFhuvuF76V5K7AoHBOU=;
 b=jiseG7J9aydeaalhASL7LTh7ZR9OqhJgVwJmxX7XujXKXotGpXNxKxVbVw889LP+lQ
 7UUi1Njo8kkg4yhs8mUrrY4PCS/U12gFVrv1YHcNthYCOnNPn1WF3L1LhiOkoq/zuQ5N
 EsYS+c5zLk0iy3UlBz7jmCVY9WR1bEQ8F5vPFJU5fbWCa0uvho4vARguRd6foWVBz36L
 fsHahRX3KPszUNr10Hfz41AGKU385+F/XS8dUa/wd48DQq/TxbXj/412jrwjeyhZtdUG
 dJ7NIG2O9vLuURSZVZT/nH2m+QfnjjvgucR7uKpq4kElHQEhvsJ9nNwXsBZyaOTzOEwX
 g1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728740445; x=1729345245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Av3Q7J9i+ZMZAu9lFI8BujGQOFhuvuF76V5K7AoHBOU=;
 b=oaWIGOyCFfjApyZ/LkY+4f0HcSl8hbKOB4xSNn0AAWiju9oAuyti6TdBr1f/i4uolx
 rs05gkzf54UZ6T2LC/zgibIZGLzGsmqzjOLEwlHNmczCY/kFSL9/BvZGK2uls8ae0cWt
 Oqgat1Cm+QkVXC7JoSKDI6Xe+Fzi8kTL6J6/r0Z7Hk0sQP/raHznhGF0VuEcl2IQkPoR
 NLmLkBr00AqRTQ0yUt/BvWMgA2aGCEBXLNk14zTzNM6ooS2ajLVKC7u8fRIq3wFvX10/
 AnJNb4fcZ2p8/8t479s9K/7S2rg1fVxCwQANk/0hZ1CZPnBFZ7bjOOix1J/ewRLVbHsp
 spNQ==
X-Gm-Message-State: AOJu0YwmSvff4+D6xPkCw3bOQCIqow7AEYPtaBeETmf/6hYKUFK8uz8o
 sktagyV6eaXr3Z4FM3JhymWExqgFlKwWofHHP5jJYmF7u8m1KfYyGIbTOoR8qoU=
X-Google-Smtp-Source: AGHT+IF1oP9zbRdixuQKO9NyNGGajcsm2dgdlJj+/KiK23FcF7xTmemyqNbzre6ToBod53rGT0X+5w==
X-Received: by 2002:a17:907:1c15:b0:a99:f1eb:8deb with SMTP id
 a640c23a62f3a-a99f1eb8e5cmr137493466b.62.1728740444830; 
 Sat, 12 Oct 2024 06:40:44 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80dcd64sm326615966b.177.2024.10.12.06.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 06:40:44 -0700 (PDT)
Message-ID: <b32edd88-fb11-4dae-9055-c4b45114e5f3@linaro.org>
Date: Sat, 12 Oct 2024 15:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: stub: add sm8150 compatible id
To: Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241011-clk-stub-sm8150-v2-1-552bbeffe7fc@devpi.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241011-clk-stub-sm8150-v2-1-552bbeffe7fc@devpi.de>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 11/10/2024 17:38, Julius Lehmann wrote:
> Add support for sm8150 clock controller to clk stub driver.
> 
> ---
> Simple patch to extend the clk stub driver to support binding to sm8150 clock controllers.
> 
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes in v2:
> - fix: syntax typo, missing ","
> - Link to v1: https://lore.kernel.org/r/20241009-clk-stub-sm8150-v1-1-697313752979@devpi.de
> ---
>   drivers/clk/clk-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index ea817031fa6c0cc1ea21000273b5651be5d05e65..5fbbb07b7f7b93e619baf596064c4b3a3bfeecc0 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
>   
>   static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,sm8150-rpmh-clk" },
>   	{ .compatible = "qcom,sm8250-rpmh-clk" },
>   	{ .compatible = "qcom,sm8550-rpmh-clk" },
>   	{ .compatible = "qcom,sm8650-rpmh-clk" },
> 
> ---
> base-commit: d0f74bd417daf6492975ce346843ba0767caf51c
> change-id: 20241009-clk-stub-sm8150-b7a29e0f43ba
> prerequisite-message-id: 20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org
> prerequisite-patch-id: 01b791d83c26250b3ff485045b88d5889f911bb8
> prerequisite-patch-id: 66febbc73195c71535e2423d14f1ff6994ac36cd
> 
> Best regards,

-- 
// Caleb (they/them)

