Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ADDC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 15:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7453D876F3;
	Thu, 21 Dec 2023 16:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qLcFQWei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F33876C6; Thu, 21 Dec 2023 16:11:38 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E6E87885
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c2bb872e2so9396865e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703171496; x=1703776296; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3UV0chnVzS0VxlULwoDde+Oi20cAaG/gkJxnRHFK+sE=;
 b=qLcFQWeiMdDG9pabrwFV2uVWaYlueFWKDfCkK4lYHXVbxI74xC9EQZtTq/+gVJFRJf
 qKnoL3ZRzHtI9uiHw8yaZ7NlnEVIO7vml5eqMAojxAZBGcJ4HbrR98QDjjyIqLOHxl68
 NE+i6axcNJv6DUY0vD04utv9PEnSOEAJymL5zjuOdZsJo00b3U39vX5Sm8lZ/K85lnda
 FxKKqoX+77nzfW65cFaMEJsAjPSDokmOeqy34JysvjnTXU7Ky/f/vXriOmm/ERRVQbNH
 wuYsrQtX88uIogR7b8KGJV0ZMWJJlK8EnRQyYrVfD2v8ejyf9Kf+4Zfq60CQItKB1xZv
 t7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171496; x=1703776296;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3UV0chnVzS0VxlULwoDde+Oi20cAaG/gkJxnRHFK+sE=;
 b=io7Q7iTOm+rsxRaTSXthUsVAKV6fKKQCU2RZi1QKcsyFfZA9hFJXquR4Zp0qrsj4F1
 ulcsFNgzA6Hl+y/LyZW3ZTI5XnWT3hUhwixZevn2ISAOFdmuEoGzw2L40b0mZnHGdves
 jTrB206Nz91iC2qRtZ+VXjs6KaDikleMqWc0rRj9XUeOdFqc0quKBwpYWbIZP1ILR0+3
 D7zbV6SrbWVQgZwYM4puoxCbA3bVEn+1gDdWIhz9FerqjWtJ3W7zBLLwMAnXBKO5IUKG
 FQJ4bitsBB/8HyV3w7oVkVnSUC+xv7QjqN5J+K6/57Stqf8WsIsnZhb1tRygoHh/pIo0
 JNrg==
X-Gm-Message-State: AOJu0Yz5RtrmNhGge4WqdnNpvKoID8Gs82jxp6R8RUGKOpNSlXSWAExp
 JS1zXBrOsdu2kQoR/lrJgqplOg==
X-Google-Smtp-Source: AGHT+IHAkkbOFbA1rbcCpvRWdT7WT+1OJI1iOFpD5qAPNPeISmEz+Vm1BjCRNuP7h6AOYOg7dovfnw==
X-Received: by 2002:a05:600c:8512:b0:40c:6948:e46f with SMTP id
 gw18-20020a05600c851200b0040c6948e46fmr452965wmb.347.1703171496172; 
 Thu, 21 Dec 2023 07:11:36 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 p35-20020a05600c1da300b0040b360cc65csm3818065wms.0.2023.12.21.07.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 07:11:35 -0800 (PST)
Message-ID: <6befd0c9-b5b2-47b7-a7eb-640951203e80@linaro.org>
Date: Thu, 21 Dec 2023 15:11:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: dts: starqltechn: 4K align memory
Content-Language: en-US
To: Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <20231221142409.82877-1-dsankouski@gmail.com>
 <20231221142409.82877-2-dsankouski@gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231221142409.82877-2-dsankouski@gmail.com>
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

Hi Dzmitry,

Thanks for sending this series.

I think these changes should be mostly encompassed by [1].

With the exception of the MUIC which we should add in a -u-boot.dtsi file.

Could you give that seris a spin?

On 21/12/2023 14:24, Dzmitry Sankouski wrote:
> Fix memory size to 4K aligned.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Dzmitry Sankouski <dsankouski@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
> 
>  arch/arm/dts/starqltechn.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
> index 3c0f42c977..e6d57d2668 100644
> --- a/arch/arm/dts/starqltechn.dts
> +++ b/arch/arm/dts/starqltechn.dts
> @@ -25,7 +25,7 @@
>  
>  	memory@80000000 {
>  		device_type = "memory";
> -		reg = <0 0x80000000 0 0xfe1bffff>;
> +		reg = <0 0x80000000 0 0xfe1c0000>;
>  	};
>  
>  	framebuffer: framebuffer@9D400000 {

-- 
Thanks and regards,
// Caleb (they/them)
