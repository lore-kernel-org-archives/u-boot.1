Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B62CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 15:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D32BF80107;
	Tue, 21 Oct 2025 17:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CbZ+lBD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0418802C1; Tue, 21 Oct 2025 17:16:50 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD56800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 17:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b3d50882cc2so1086582266b.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761059808; x=1761664608; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oM4PAnpuIk/4+dqmmb8BxFC5Pj7BverPaLo1VaFJEp4=;
 b=CbZ+lBD1Syu3J5jTrSX7pjpcjO/TU6L1ojdC6yZoX9j2F4E8FwwR2DeNbhKt9edvYR
 AvEvSzutqYV8d5OBK5MuvEJcOgHoIv6BjrgZ4E8t3TgLYSqyCS0wSpVfx7Rmbb6J2uhO
 INdba05/BEAfpCAuyUWPeu8ch1euHI+5W0++0NuF7e6ENkF+usdVOXrHPqZUXXOaaXvq
 bC524mcJWAq05DQD660fEBJrbXh9OLhNRb50q+RQmipumlNC41aVN4rw+XHjmgdaG79f
 uuEOSM0AlgUIanb/Y3YE1QGmSuiuq8jen0/KHNL2Hddijvy55RezcLfwkf3XP09RI1hw
 TSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761059808; x=1761664608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oM4PAnpuIk/4+dqmmb8BxFC5Pj7BverPaLo1VaFJEp4=;
 b=QwLEt4BoKfDceqCHbeV94G569QuQKOtYi9X4mCqYWY/sy62wa7K3NxuOv7iEmQnfhr
 /ejWu8ITQpdDOBhpxqGXPsFDpivtRDUajDB7WaFbfBaVcwA50rW22THDEnHKLORRFkON
 04aFkvgXLy4WWyXrweBA0dnzHTGWuEXlbdaabgKLcUH5+jOAZxzg7tGohrQRjCnjctI6
 XGXn4WgTMwjycmpRABZ9+wRKTw5iOvSfLkpq5veEmVB8CG69aeskfMZ5Zin8XqvcHrLX
 bNg0yjS96p/+Sqj3PnjCECcgRYvTDr4olvI/7TMk92x2lQe8hleiHK2MI94xDd+4evpj
 OQtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv2fi9pvNEKLh0OLyQkYJFhrEUZWOtuUxa+K7CAnSwWzQIMfZJFaxeMIDKGU+c47coBELwqio=@lists.denx.de
X-Gm-Message-State: AOJu0Ywq9px+4rA2t8I7aXL0cok78SG0++XE4VZQ7FW36TC6xwVcW5SI
 hkpIlevGYDs4awzDxJah+nhc1KKAIxHWorr/H5PfNexn/JVko3YexSjZkIuY/mO2ZYc=
X-Gm-Gg: ASbGncunc0Uj5V+64KMftLJTLjxQHaxSfb0+w5mQjQjU0arYb9K+l+Q+IBMk9mn5Egb
 n5YuD4dne53SJkAZukavy1LEvJggQH3/0y0Q5Nz1a214N+CFtDwIkJIEbNvM35Ax+jL9/yasqBB
 qGITlWMy2Luxe7IOlFBTvGj18wHkZWAj0rUNyx2/eyTju0iJ8NcNv/lC3cmdy8jFoV0kHk4IqIC
 O9N2A0F4MeFpQmbF/i9rAr5cE4pSG3DBAh5JtG4HLyS/38sooM++HaMKvSHQqkPeIbtw2OqGucV
 g6C8jrYyD0ZnitfCLHIgnPZeIAktFoKaoMei1Pp9XEZozsnhROLo2WDFseHsnzvA3ctI0lCaLb7
 CkeaogZzU4EHvXkoeFYpq01gpLiqlu+mY84HLy35NqcS7wwhAlRkGTL7Gf9AYlLuhweN1AqduBt
 m66L4GdFHzGCy/sPdIVw==
X-Google-Smtp-Source: AGHT+IHHH4MQKgcuDa2sX82teKKy0P3r8Wntf90hMkSB/pCWkWGLayD1j8RwJwlQ47kCUWD7ASGWXw==
X-Received: by 2002:a17:906:2542:b0:b6c:1c9b:c579 with SMTP id
 a640c23a62f3a-b6c1c9bc5f9mr474030666b.36.1761059807943; 
 Tue, 21 Oct 2025 08:16:47 -0700 (PDT)
Received: from [192.168.0.39] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65e7da25d4sm1087561066b.9.2025.10.21.08.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 08:16:47 -0700 (PDT)
Message-ID: <974571e5-c2f9-4800-a189-d64c0a00c698@linaro.org>
Date: Tue, 21 Oct 2025 18:16:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: sam9x60ek: select PIT as tick-timer
To: Dharma Balasubiramani <dharma.b@microchip.com>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>
References: <20251013093220.32833-1-dharma.b@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251013093220.32833-1-dharma.b@microchip.com>
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



On 10/13/25 12:32, Dharma Balasubiramani wrote:
> U-Boot currently enables the UPLL during boot, which triggers a udelay()
> call that depends on the system tick timer. Since no explicit tick source
> is defined in the device tree, boot stalls on this board.
> 
> Define the "tick-timer" property under /chosen and point it to the PIT
> node, ensuring U-Boot uses the PIT as the tick source.
> 
> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> ---
> 
> Changes in v2:
> - Moved the 'tick-timer' property to sam9x60ek-u-boot.dtsi.
> 

Applied to u-boot-at91/master , thanks !
