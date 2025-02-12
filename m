Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50340C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 16:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF59780C98;
	Wed, 12 Feb 2025 17:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D4eLlCip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8762E80CB0; Wed, 12 Feb 2025 17:17:17 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72D080EB0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 17:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso1111329866b.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739377034; x=1739981834; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eYN0t1p7kE7gwzZEwBpw0Xa8T2G3Sw5En65lX8+YtQw=;
 b=D4eLlCipLYl3gw2eiSVITmUGPveR4GObRiO93aW5LjvTz2fREd9/fgC16Svnztk2H+
 XrzGsma4ymWm2d2oNdw7DKyP2QuumYr/SiQHlEMGitvpp62tLlKy6fbtA8x04Rh758er
 NF2S24bLkGY0nKCdVzwKMoHJDTiesNEMRIRYb/i8QLa5De6xogvYgykI5z8juhMc4fzh
 HU6Os7OJR4aENMpVQg7aW2ORKeTGtYZr1f0Gdxc8C8CSFMsl0lVAxeRk6AXACN1pKCkE
 tWSflmPDLa4gc0BSpHfA+kBf8uZi20+fEutEoxT48y2bSNqErOLtMtRKsildCfSt6zMK
 zB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739377034; x=1739981834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eYN0t1p7kE7gwzZEwBpw0Xa8T2G3Sw5En65lX8+YtQw=;
 b=VSQWVC2n4Glebvpv3FfCw77ga6oG1XUf23/EL+7tWdxXIQHlh2AuT0bPLYnq68LZva
 zpcIOrpvgEQexxGEOThesNDY8n0NdgObjGXsmlaLkmHRdTqtBN52grsCTyr3eZE/NY+q
 GFQilAWADXIcd0IUhfOqTrAowV2vkHpBLy2d6B4229mYeKD5J/c2ZlsSDPbmNSS40nwd
 /BOmEynn1CtPisL5iw6xbT/mFonk4fwDE3v009OrTnFB339jS4sDDNGNwltpyes8UIjb
 GL/NGhc4Iz+6shTX4F5a6ilvvnKgZR6IKhMT6LAFHIQFKPzilr78KiV93ty7BGyPYnbd
 Q56Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHnvepBtJRpsK6UMyVSCXsD3tT3zXO1fTfq9055YI2TvuBX7Kq9JWgFc4g2gvshgYGVXbAg+0=@lists.denx.de
X-Gm-Message-State: AOJu0YwzeOkGlf7LI/xC4O+w7FWYw+iblYQZEsVFkFqY+mnB6N3/5F/H
 2+ZNv8hrj9ThJciYq914JTf5lOEdOuzrh+1Ydvi90f2zrwHL/6iRHh45DtBh88o=
X-Gm-Gg: ASbGncvNPnkkO1yrrBWG2EYG9Rna+d8UJ1T/A7YhskxNOaIbVhHzvL/RfAiAeRWm+vh
 c9IpIspJRDmnnBQFxEpJwKlcP+xU6M+vF56SI1eN0Q79dpwmopIXxyTSOeWN7+ZFlWYbMSHDm3O
 F0+AbMLySAaLaZCkwnbh2RdeXYVtJUiz8IMMWLnRai5jsS/hJ+vCgVwI1df8s/1icLXoX8E7x5R
 lcEj7Xn0AVXfSOFlG/Af+NPUl/ziHuULvFX7rfdgmr4uxATWom+YIxio6DWTt8qzlOg85OTtVP8
 ivw+AzzKiQCfDvLSJe3Bcvg=
X-Google-Smtp-Source: AGHT+IGsv8dAeeajEVxqM7kx5qpsRqYEx51tb8Eey7hSfmnC22hDgzDBHReKtu7t/zaZm1q9X/gdng==
X-Received: by 2002:a17:907:3e13:b0:ab7:8507:fcc9 with SMTP id
 a640c23a62f3a-ab7f336e842mr331520266b.12.1739377034276; 
 Wed, 12 Feb 2025 08:17:14 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f491c6sm1308568466b.15.2025.02.12.08.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:17:14 -0800 (PST)
Message-ID: <7ec1b83d-1145-4043-b194-97fef6682a54@linaro.org>
Date: Wed, 12 Feb 2025 18:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: atmel-quadspi: Depend on SPI_MEM
To: Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, John Watts <contact@jookia.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>
References: <20250123073713.2988293-1-ada@thorsis.com>
 <20250123073713.2988293-3-ada@thorsis.com>
 <20250123143250.GG60249@bill-the-cat>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250123143250.GG60249@bill-the-cat>
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



On 1/23/25 16:32, Tom Rini wrote:
> On Thu, Jan 23, 2025 at 08:37:13AM +0100, Alexander Dahl wrote:
> 
>> Most other spi-mem drivers also depend on SPI_MEM.  Fixes this build
>> error:
>>
>>     arm-v5te-linux-gnueabi-ld.bfd: drivers/spi/atmel-quadspi.o: in function `atmel_qspi_supports_op':
>>     /mnt/data/adahl/src/u-boot/drivers/spi/atmel-quadspi.c:460: undefined reference to `spi_mem_default_supports_op'
>>     make[1]: *** [/mnt/data/adahl/src/u-boot/Makefile:1821: u-boot] Error 1
>>
>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
Applied to u-boot-at91/next !
Thanks
