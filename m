Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4CBC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80ACC88167;
	Mon, 15 Apr 2024 14:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cVCcNDGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3954881D0; Mon, 15 Apr 2024 08:47:53 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF6F688179
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-516cbf3fe68so3430631e87.0
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713163671; x=1713768471; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EurkQkPBnR6FMEN+44e+enFD2b38D+j9YcAjOPhHjh4=;
 b=cVCcNDGguMIEoC+VW1YIzaNq/j84g1Ew1sjd9li5e5FO1LGx3CMVpmJqT7Os2OyOKU
 DnQNz+amzQ2k7pD2d202tBNvYdBaYY5W2Jp6YmEXf/2P6UfLQJoqCBHMBHEMmu2jfhzn
 hDgXY1Omj9NR2/DMTbWntlsCjcm8pNQQhtgphIKqR9HKjgICfTHV0/6Db9147tx0zWri
 q4PAgL1031813l/GpbFZSi7pNsg4NqqF86t7cF/dEDrLRRRM6xQ84eZotBpvUERt2Ola
 Lh4bE4oS0OeXngIVTZBqMO2OTZb3/dFojDBgGJvyokcFokQ6B+A9EPAa646ryRZeYc5U
 8UeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713163671; x=1713768471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EurkQkPBnR6FMEN+44e+enFD2b38D+j9YcAjOPhHjh4=;
 b=UHdPjY/UYhClCfMwoR24RrVT1NbhUi/U5MxAegyIRDQXKfKCX96PxoboTFW9zndHoS
 dupTbtP60b+VXBDPJ5sLcjJ2XbQgsurFoBQeQJmUF01dU2fHTZMXbY6LcjafnYgdHRh5
 zNcwbBQ2FN3Q8G9Slm6a2Gtxj/J/w0pcjRZXyDUJ88qoH+F2bZiTUpmJxvGB64oRJl00
 tTqfwHONbyQy4rqfEL3bEH6PXtZAT0dvaHKSBBj64DJaF97fauytvHcK/gsZsBwMrHhB
 pva2S1kMRy85B3An9LNZ9Cmx/pr9vOoBR5memIYQQ9pTKgdqjlO2vbDUuUK1w/9QT7xf
 sWXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgcbj1YLRwzgBclDpaqZOSGOGsj65mYSUrNl6u4/MLhdA09l3WeQkjlsj7wBhFmrEWpd5O2jQktoNDcrqmx13GNo3djw==
X-Gm-Message-State: AOJu0YzHXq/w8DKFkyPU0JIzPCGNc1WvoGrzoFDysYwiQ0FPHuUKTLh6
 WMHxQ5X3zABnGOimh7CbaZWTeZXWofmEi+aFAk380p2nsjhbJtaMjBE+4qHCtR4=
X-Google-Smtp-Source: AGHT+IH9C9L2Il+0EmdXsKDYkcxM7wsCuzhtwg69sWpGZOVlc++DAEauKl4pj+R9GYDXhAtgV8gJng==
X-Received: by 2002:ac2:46fa:0:b0:518:8e3c:4647 with SMTP id
 q26-20020ac246fa000000b005188e3c4647mr4195054lfo.7.1713163671131; 
 Sun, 14 Apr 2024 23:47:51 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a05600c45cb00b00417f65f148esm11895633wmo.31.2024.04.14.23.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 23:47:50 -0700 (PDT)
Message-ID: <377037b3-1bf2-492b-bb88-de233d8b373c@linaro.org>
Date: Mon, 15 Apr 2024 07:47:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mtd: spi-nor-core: Rework default_init() to take
 flash_parameter
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
 <9db9fb39e655b514c21952e0a5005572510ad3ec.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <9db9fb39e655b514c21952e0a5005572510ad3ec.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 15 Apr 2024 14:14:08 +0200
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



On 4/15/24 05:33, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> default_init() fixup hook should be used to initialize flash parameters
> when its information is not provided in SFDP. To support that case, it
> needs to take flash_parameter structure like as other hooks.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

I'd like to get rid of the default_init hook, let's not extend it if
possible. Can you use the late_init hook instead?

Cheers,
ta
