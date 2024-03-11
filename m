Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB3EC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD9687D0A;
	Mon, 11 Mar 2024 13:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qqg4aQ3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F80F87E32; Mon, 11 Mar 2024 13:29:33 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2466987E0D
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e93514a6aso680127f8f.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710160170; x=1710764970; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Al/98F6/9EpM/BOn6USwA1QT06lg2aRVpmxa/n2pc3w=;
 b=Qqg4aQ3F/IONiBkRs3hrjKd/kxoU/39epyOl8MF0ypCLejNwGzMeTm7TTEsk2d+j3Q
 IRj4ziDVqAf+3TaTYONAsHMOqj4FRSLZ7TiQntiDDXYEw1+GETsU6OMRFyJI5xVtazor
 rGoX6/u0I9OWGZQYGH5Rt5H/uMKrBfzBVOc/sTI3REn/W1tV0Pascu/SAo7KLfNnZGlI
 qApke8FeI+mO2ZwbDjxRF+M1yie4gmC66HGL5GjNO+rRXV8sOD00L3opnlx72fdZ46MP
 ZQpaNDNWEsbYiSU2IJ9WLBevv6zn1ps8xEtGPZY9CJ1svc3PYMjYKPLGuETBMtecWP9/
 v1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710160170; x=1710764970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Al/98F6/9EpM/BOn6USwA1QT06lg2aRVpmxa/n2pc3w=;
 b=q2/ei9NSDaKMdoueVnW7kEggNRzws90ibpG6N97w0xwIQZLIunpRt8JYV9LHV1QbXI
 tuYzu5X2y4hFvgxx+lS6QdHUNv2pksAWFIb/rHaFKvlcLnZJGV0h2vz+Sfhy0eZXGZzj
 psbtBNk6UlvAuMo3chIeTB33hecianBl2f9SQfXNEif2wVqU23o2t0AHLPg+hEqm710a
 xrI4Fr7ZwikWUmH3uUoec1XMpS2fsNLADqqleeOhyCQr5wRZMUjLpNC5xbPQDAR9VLNJ
 Q2MVC4bTG67pKQMeqzlDWEl8usFZ0f+BZ5iLOpCGo+7CPBLljraH/7dKoRG2JjPT+5CN
 mdjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWyNP8sX2pslZwMCNZ19jS9YnNcGAMhbi80e0m1+DD5ya8bxbiTM7DbrS2Le+Bs7YB61hV1IHIu8rxcjONBM1LJ8vKxA==
X-Gm-Message-State: AOJu0Yzw/X1wxpZkC81tVs2KW3dj40yMXfzenwqou6iaSTY31U1BTLTM
 sBSuGcMqaE4Ozh5dGlfUMZ7rjGux0GIUR3VWw6tqN6EEQVE01MI6wsdpozMgNuk=
X-Google-Smtp-Source: AGHT+IGXBpp3bjB0Y1KGHvO4B0ZQ374l/WTv/Pt/ES6Ln+Aox7K1qIWDO8Cq1LIV7xCOWA1cqRuMZQ==
X-Received: by 2002:adf:c004:0:b0:33e:7f67:5dd8 with SMTP id
 z4-20020adfc004000000b0033e7f675dd8mr4475114wre.54.1710160170589; 
 Mon, 11 Mar 2024 05:29:30 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a5d58d0000000b0033b87c2725csm6319712wrf.104.2024.03.11.05.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 05:29:30 -0700 (PDT)
Message-ID: <f244a428-4cfa-4e1d-8aac-e54d368b8b16@linaro.org>
Date: Mon, 11 Mar 2024 12:29:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by
 default
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org, stephan@gerhold.net
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-2-sumit.garg@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240311111027.44577-2-sumit.garg@linaro.org>
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



On 11/03/2024 11:10, Sumit Garg wrote:
> Enabling LINUX_KERNEL_IMAGE_HEADER by default doesn't allow
> ENABLE_ARM_SOC_BOOT0_HOOK to work properly on db410c when U-Boot is
> loaded as a first stage bootloader. It leads to secondary CPUs bringup
> failure and later causing the Linux kernel to freeze.
> 
> So fix it via selectively enabling LINUX_KERNEL_IMAGE_HEADER where it's
> actually required.
> 
> Fixes: 059d526af312 ("mach-snapdragon: generalise board support")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 65fa7ba4ce7..27f3d9a43e1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1090,7 +1090,7 @@ config ARCH_SNAPDRAGON
>  	select BOARD_LATE_INIT
>  	select OF_BOARD
>  	select SAVE_PREV_BL_FDT_ADDR
> -	select LINUX_KERNEL_IMAGE_HEADER
> +	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	imply CMD_DM
>  
>  config ARCH_SOCFPGA

-- 
// Caleb (they/them)
