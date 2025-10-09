Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED9FCCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 08:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD7B83965;
	Thu,  9 Oct 2025 10:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L40ogUrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED4D83966; Thu,  9 Oct 2025 10:39:32 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E36083955
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 10:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso7651195e9.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759999169; x=1760603969; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wGynw7dOQ1Z71YLlqCgjcpun5WJltfAjHdBwrZbYl1g=;
 b=L40ogUrSVgzTH2+1aJ2QZcm0cMWgGcFcHXEWAXlcGujXYPU72NvgYFerI9cK1KZlAW
 PdLobu6Lfq18BVbfWl1wYKz0zNLRvbMx6LZpOhMu5p1rTGSddCrti58tvlHQXTf8Z7kZ
 LALG+BUf4/FMkXtyls/tGBomJWvnvtnk96jwi2Prc98KxPoDoQf9IJpGGC5ENyVrV2ux
 OntRMfjoCABDpdu955QZJMMeAvL0tTTtMyiua7w/ifcfY8Vu0v/ZuW10BQJ+gnZolGYD
 wmnKjLCKQ/eSYx0vW99mU6uRpUllheV2BLPs6P/snIdxIQMzcpxGqjQVGsIi+V+kJQHz
 pQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759999169; x=1760603969;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wGynw7dOQ1Z71YLlqCgjcpun5WJltfAjHdBwrZbYl1g=;
 b=ALjLh+BYjEphuWgwDmxFYhMF8MSKMZ0h2pj3hF0zfroEPlUPRkGlFEsWHx+AoKpiSE
 1wYncZoWWOfuawnS8ZoTXyAjzYhqfEu0yaPittQzsMS3kzk4uctfhfCnNDr3UEOkWcH8
 In41yrMdp1jqGTLq1EAf+wjwjvjeT03b+aASmvLw1PimDiL9lXp29Vx3OvsU+FBfeqtt
 NaMpj6ZC0VTpA/+ODMIkKLhJlp1Yv8fgSjDVttp+FcQOilUgRmnomvOm8gybByx8EhHg
 R7uYWbDbh7c8yKNwGd4XTvrPWrPts+z6HEno2KC6h7NFPvxUBmCwgUznhUSQCDbbBPql
 nJDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw/2KwnJUD1ws1fckP7Hoqbd6uyawoXLIFr57bNmLrLO/M080+ikCc1KsYMnu11futtGsUQOE=@lists.denx.de
X-Gm-Message-State: AOJu0YzNtcHg9GuEwNijzszFPLYvmB6rLteZIUVW2iHyrYPOco1c75j/
 gq0W5ige5UFv3zU4Z2B4faOsozA61f15nw+JmhFgDzuh0LrRIkhqzcUqlHln0JUIxcE=
X-Gm-Gg: ASbGnct1B7iBtvZKTyCumqAdG13xqbBU0U2xVpn6wy+2MeUv+cfmYHrq/g2pBithw4e
 /ndQIXIkYN2QnSQ6DuigoAmkcDrT78in4pGhhJAm6ht07a8d2F6dqUw/PzoPjfErkgE5Oh/XdxK
 4yEGjw17v0sPVBqJAaoK8SRIe6jk0NSnVEYvlbpaQ0cUgrrA+slHC0FmZKMCgY5O2UFbYJznVWY
 K6njZ/Df8p1oavscZW8xS30Tjcvro4r449iLn7NnNHdl8V7h1OsIevU7SXCsopiU/NlfwLbXhl8
 dSggr56UwBb5ArmKDZqe0bcTfZPWJN+x2gRz6h2eVye1BIrp7ejYAob/a1SgAaLA9vZI7TTFJuk
 xgkdtLGbzKEprK6SEmpnMkhvjpoXYz0NVCTCNV42ARrQPE8HlCyhMX8EaF3/61TZ3uxF1
X-Google-Smtp-Source: AGHT+IGI3TRwtYRnDxDNruInktmiAPxOEfvmTWLImR7FTxm+MOFrTc8osaR+Z/zVvx7F8YoPSZj44w==
X-Received: by 2002:a05:600c:138f:b0:46e:19f8:88d8 with SMTP id
 5b1f17b1804b1-46fa9b17d03mr40983525e9.34.1759999169467; 
 Thu, 09 Oct 2025 01:39:29 -0700 (PDT)
Received: from [192.168.0.36] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab36ed3bsm34100755e9.0.2025.10.09.01.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 01:39:29 -0700 (PDT)
Message-ID: <31c388ab-77d1-4190-9135-eb5c3395b003@linaro.org>
Date: Thu, 9 Oct 2025 11:39:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] timer: Tighten dependencies on MCHP_PIT64B_TIMER
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Durai Manickam KR <durai.manickamkr@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>
References: <20251001203037.2828258-1-trini@konsulko.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001203037.2828258-1-trini@konsulko.com>
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



On 10/1/25 23:30, Tom Rini wrote:
> The MCHP_PIT64B_TIMER driver is not safe to compile on 64bit platforms
> such as allyesconfig on a 64bit host. Tighten the dependencies here to
> the platforms which use it today.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Durai Manickam KR <durai.manickamkr@microchip.com>
> Cc: Eugen Hristev <eugen.hristev@linaro.org>

Acked-by: Eugen Hristev <eugen.hristev@linaro.org>

> Cc: Manikandan Muralidharan <manikandan.m@microchip.com>
> Cc: Ryan Wanner <ryan.wanner@microchip.com>
> Cc: Mihai Sain <mihai.sain@microchip.com>
> ---


[...]
