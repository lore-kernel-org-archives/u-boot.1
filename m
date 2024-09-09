Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB6CE6FE49
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 07:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E19C288CE2;
	Mon,  9 Sep 2024 09:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OOSfibHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40AC188D36; Mon,  9 Sep 2024 09:20:32 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D75088C8E
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 09:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374ca7a10d4so2344791f8f.3
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 00:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725866429; x=1726471229; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=No4ruZuBcLBI5WUM658YoHo8ngtc+epYMsEChDWGEQ4=;
 b=OOSfibHLBflINIIHHYFY9lMZMKyKFNVQ7AzOEYV8hpojCuATpk8BOgk/G5KDveCc7Z
 SFMK6eSsmtR9GGD4vjv6erTjJwZQU4yzowliIlFSgQ9dX0xdLz4D9ME6Ykuo6NP7S8RK
 mijpsRC5TBTJ0YAtAFEbvWj5sLQtto2AZBzTTT9+PbK32dfq45HqGS4FHRCOhNj13mPY
 NLXFiTy8v02/wUwrgaSa5N6EpxAq7jLuZjpF4oHjTcw7p5EqcbjBe4sT7ExEXRZ1qn1O
 gMy8EdKC3L81AsGFOivKMfPCJQ3gRp7pxW/yHJ2clNEE/FldRk9QgF2CJnqMlVtH2JjB
 wDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725866429; x=1726471229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=No4ruZuBcLBI5WUM658YoHo8ngtc+epYMsEChDWGEQ4=;
 b=O+JPE67GEz054zwT4NJuQrxypEbInxiGrlq4Ru7nO4tV17LgYcsE/KTkxQ3lNDmDpM
 lfBNEnM7hlkbv0vUyRA63ZiaKNzm6NrAzPa4rQe/r05gg7avkyV2+m/CWWy3KpaAZ80n
 cwLoVp1TmMxmXiH3x5GM8e6ti1ve+ZJnGUDoI4h0/+05VEgnah+4nthVdjr+42mLH5/N
 qBOw718D+2C1O9mzuQm4m4sx7wpFFOMWUGLhtQC0PZwhUPl0VyA9WxxKkGDiERNdoQzl
 iT+xJsNi1X+I/y6w6DeQh7jaQb9egrrSfn0Yp+mantORIjXg/KHabLLfUB7O1AlPBKOT
 5jDA==
X-Gm-Message-State: AOJu0Yyf7fOdX6i0i/O9sNeuuh+C3d2RkrqJ2NdPdPHPIJ6oJ5PTXctI
 GLutqJcD7YhTcUvaDPtDr4HTRBjiWAczZAEcdj7hIDTYiD9lQefId9ow9BbWkQINgUtco/VpGWk
 f3iS7Ig==
X-Google-Smtp-Source: AGHT+IFOAC0p+Fw5Eu0VN7MMh51wowyrC/v0YAbU4PZeOQMvXpqo2se2VLZEVD2w1YUBeQTYAfAF9Q==
X-Received: by 2002:a5d:6892:0:b0:374:c79b:ca5f with SMTP id
 ffacd0b85a97d-37892703f43mr3957642f8f.46.1725866429166; 
 Mon, 09 Sep 2024 00:20:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:e4b2:9e37:c366:4d21?
 ([2a01:e0a:3cb:7bb0:e4b2:9e37:c366:4d21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564a18asm5199865f8f.15.2024.09.09.00.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 00:20:28 -0700 (PDT)
Message-ID: <62e13bd8-aa87-4277-955e-66e2e648ece5@linaro.org>
Date: Mon, 9 Sep 2024 09:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] net: fm: call dtsec_init_phy() only when it is
 defined
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
 <0313c96cea56acb5585f04bbf4da25145560de3b.1725351676.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <0313c96cea56acb5585f04bbf4da25145560de3b.1725351676.git.jerome.forissier@linaro.org>
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



On 9/3/24 10:38, Jerome Forissier wrote:
> dtsec_init_phy() is defined only with MII so add the proper conditional
> in the caller code.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/net/fm/eth.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
> index 19f3f0fef07..22025b6a273 100644
> --- a/drivers/net/fm/eth.c
> +++ b/drivers/net/fm/eth.c
> @@ -26,7 +26,8 @@
>  
>  #include "fm.h"
>  
> -#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
> +#if ((defined(CONFIG_MII) || defined(CONFIG_CMD_MII)) && \
> +     !defined(CONFIG_BITBANGMII))
>  
>  #define TBIANA_SETTINGS (TBIANA_ASYMMETRIC_PAUSE | TBIANA_SYMMETRIC_PAUSE | \
>  			 TBIANA_FULL_DUPLEX)
> @@ -701,8 +702,11 @@ static int init_phy(struct fm_eth *fm_eth)
>  		supported |= SUPPORTED_2500baseX_Full;
>  #endif
>  
> -	if (fm_eth->type == FM_ETH_1G_E)
> -		dtsec_init_phy(fm_eth);
> +	if ((IS_ENABLED(CONFIG_MII) || IS_ENABLED(CONFIG_CMD_MII)) &&
> +	    !IS_ENABLED(CONFIG_BITBANGMII)) {
> +		if (fm_eth->type == FM_ETH_1G_E)
> +			dtsec_init_phy(fm_eth);
> +	}

That doesn't work:

$ make -s ls1043ardb_tfa_defconfig
$ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
[...]
drivers/net/fm/eth.c: In function 'init_phy':
drivers/net/fm/eth.c:708:25: error: implicit declaration of function 'dtsec_init_phy' [-Werror=implicit-function-declaration]
  708 |                         dtsec_init_phy(fm_eth);
      |                         ^~~~~~~~~~~~~~
[...]

I will use #if CONFIG_IS_ENABLED(XXX) in v4.

Regards,
-- 
Jerome

  
>  #ifdef CONFIG_PHYLIB
>  #ifdef CONFIG_DM_MDIO
