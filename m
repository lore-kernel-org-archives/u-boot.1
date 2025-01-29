Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7220C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 06:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19EDC80EEF;
	Wed, 29 Jan 2025 07:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738130542;
	bh=T2QulzQrtUcmZZGPmSwU3xoI56sXMQWye6USnIewlio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=z1sLGdaXOLYjOecM9tczSJZpVDKaL48Jnbh5JWcMqLHNMmQF5CfD9aSBBGn6LcgMR
	 YghPDHwgertlw6S0iRJ3bmmj6CXr/h5C/gcGG7M/Ko4WywRl1jzmc3ex7h73NdcFzT
	 99xi83bRfrFykqUxK8JLHCWiAKyE9YiIa6lmWIlN5Z/NtrikoA6IGyN2zd7sD9V/eq
	 imevCjmQtXEW/qPkZh3MJYnKZjD3KtwbDY4vE9ncwlvLPrDOdM2uNjpdvuazvK5088
	 vL204c9e8B/WmyImj9cv93IKOhWHpnalB2+GW5KzzokvckU9sCPKgJ1Egwe1+meK1e
	 ARF8ydKb4Ko6g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC6880F10; Wed, 29 Jan 2025 07:02:20 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE56580EB5
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 07:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BI5HyKTJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7732810382D08; Wed, 29 Jan 2025 07:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738130537; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2QulzQrtUcmZZGPmSwU3xoI56sXMQWye6USnIewlio=;
 b=BI5HyKTJkpMuLgEnRd9zeRzKjKCf+tOx9qvGInN+WwzhPgV2kNFIAUdYE3JgMjr8ypk+Su
 F8QtT0ZU2bt78b9fxGCUps5ooNTVk+Uh7Ny5jsK9LCanY8NNQBD99g4p+Px9aIotA4PZrB
 WTLU/tQ4KdKFPigALUC8RE3vI6mAA64dHipcG84vcJxF0qi7IY1NTDbA7pKdTJS4FAhWrm
 piyk6CbQennlmp9Njk7PNT3qH+QlOHbGeW60z1zZD3g7c2+NsZW0Z1LTCUnCyUg0TdRWLb
 2XX4SMiaK+Fpon/jwBj1levdJ+pIf/qIuOFC7WO6F5gvMpZUcZBOzCfAt9o7jA==
Message-ID: <d7b9d79e-223c-8b66-989e-39bedae91c1f@denx.de>
Date: Wed, 29 Jan 2025 07:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] arm: Other boards should not show this option in
 menuconfig
Content-Language: en-US
To: 1425075683@qq.com
Cc: Enrico Leto <enrico.leto@siemens.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <tencent_991CA024CC85C92C1FAD9EF4413A36AD6007@qq.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <tencent_991CA024CC85C92C1FAD9EF4413A36AD6007@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello,

On 28.01.25 14:45, 1425075683@qq.com wrote:
> From: Liya Huang <1425075683@qq.com>
> 
> When I was using STM32 board,
> this option appeared in menuconfig and caused me trouble.
> I found that arch/arm/mach-imx/imx8/Kconfig
> already excludes using if endif.
> I don't know why other boards are displayed.
> I used the following command:
>      export CROSS_COMPILE=arm-none-eabi- ARCH=arm
>      make stm32h750-art-pi_defconfig
>      make menuconfig
> 
> Signed-off-by: Liya Huang <1425075683@qq.com>
> ---
> 
>   board/siemens/common/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/siemens/common/Kconfig b/board/siemens/common/Kconfig
> index 4ae12b1c973..800eb8dd1c1 100644
> --- a/board/siemens/common/Kconfig
> +++ b/board/siemens/common/Kconfig
> @@ -3,4 +3,5 @@ config FACTORYSET
>   
>   config DDR_SI_TEST
>   	bool "DDR signal integrity test implementations"
> +	depends on ARCH_IMX8
>   	default y

I think we can even more restrict this to

TARGET_CAPRICORN

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
