Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FD5C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECFC82D17;
	Wed, 18 Jun 2025 09:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CB7PXQ9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B1082D17; Wed, 18 Jun 2025 09:32:45 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 328FD82C8D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-608acb0a27fso8690250a12.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750231963; x=1750836763; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BTnAmdGJIMsQqaxb3Fs/f92ABGNJPO5p97emM6v72q0=;
 b=CB7PXQ9VSODn1Ah3/KYsI1fnUgQ/CrtVgBRB/YKJNoV4/EU3bquQmuZ/aO5vRBmESd
 1eGdR3kPxc8OuKSjt5kC9GDuETkfSnmdutdqDbu7ZpGlgErJrPnR0kqh8SQ3fqa2yRRR
 60bBz6j3SlKBFg89QWQDvAeC33RnmUneN9pRKccxSH7GBmoKacHuLg8fRxxZGg6aT3CG
 7GXFJKHNzvNAWjuZ1hZtlglWErRqYhXCGiNsEHlS9Eyuxc6QqIaeR6lpuIGjTf1ANAiS
 tsJI4nHoDD+2dxBR4k+uyDlQrjn/R2AbT2yMbLHHvwzGKvO71xosjGauDfla213C+SAP
 jskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750231963; x=1750836763;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BTnAmdGJIMsQqaxb3Fs/f92ABGNJPO5p97emM6v72q0=;
 b=u88pPWGdkOWlW+RRCWHE/NdzieWSrP4HSHHgTbyK2kS4KohvtD8ojwTiF3vzBhajZg
 GZ2mwSzXa/kLs9gYdaDPLtx6dU6+PKiwqbWQhKoYeDyn1Plqc5AE8XbdBDTBGpYH3EW/
 C3rL6u/7E5hH2vl/c5QNW1IKStTpc/rZN1koBgMXeNmly5w7aAtxL8DGNG6UsYXwe4Zx
 kojndXS9cauTv+WVjPYB6OXCqvFHOtBAxCbarTeH+xJ6XOL8weU718wrzS51VEi23dQI
 dhPJ2e1+CPLT0dWh4dhvKnVYBCXXjxj68fNgU/JcGwQRHdn1L68oFfZhotN4Tb5DajBT
 H+CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUywXcFv+ql9TwHSKlATLL4XU7BCTRrvYoSoUI04raOG+615BPHVJqUXE89hgoTAkNeDfBLzbc=@lists.denx.de
X-Gm-Message-State: AOJu0YyIPTLZtJxXA9r2vjpZIS+KNw3Gkykp6JYml471r32D8natmnHs
 Q/LT2wVD/NDOtIWwYemhPfivfxKkhZviWDfLu25HEfyIVzI0uOfl+KpCpn7kQVrgjGk=
X-Gm-Gg: ASbGncv/paE/iqBw+eA7D2KyZwUmjOfSE/o9zAHhKcImrpVwWaw5arg+rzwhBaKaUuQ
 GN9XBZw8plvA9/Gdh+D6r0E/BkyWv6eKf6x0Ynl75GvbTQNMx08tjK/LKafO/zqayUFCBAAxWDI
 K4txwxOIra0bRPIw9XogoKuGFwh31mUGLPgbxW7JCwi6Lf8cy7l/gv4GrYbu9pfDYnQOzp28RB7
 rM4+hCsYx9OtrmL4CFXCOjCtU0YHHzh9cPueBSut+gJ+KUujEzgQhqG6re33yVWrZrOmDPdo2xj
 Sfbx4LKhlzu7pOebQl9kN+gBD9m7ILWrqEU/ecPNDNTQce7BPWJcwEUz36RNXGuDc8uwwQ==
X-Google-Smtp-Source: AGHT+IFHxOuMIu11eYJE1bKoX+HY29DQ2fvaZThFBfzWSCJLsnlnmQjCgjnch2cpVXmgey/qxwgqVg==
X-Received: by 2002:a05:6402:1d4a:b0:601:a681:4d5c with SMTP id
 4fb4d7f45d1cf-608d099f35amr15291173a12.32.1750231962619; 
 Wed, 18 Jun 2025 00:32:42 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b4a5b6a5sm9482179a12.40.2025.06.18.00.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 00:32:42 -0700 (PDT)
Message-ID: <0db37e36-4383-4b82-b27b-e2103e842212@linaro.org>
Date: Wed, 18 Jun 2025 10:32:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] configs: sam9x75_curiosity: Add initial mmc
 default config
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com, sjg@chromium.org,
 Oliver.Gaskell@analog.com, malysagreg@gmail.com,
 nathan.morrison@timesys.com, mkorpershoek@kernel.org,
 robert.marko@sartura.hr, jerome.forissier@linaro.org,
 sebastian.reichel@collabora.com, duje.mihanovic@skole.hr,
 sumit.garg@kernel.org, patrice.chotard@foss.st.com,
 nicolas.ferre@microchip.com, u-boot@lists.denx.de
References: <20250603050556.80851-1-manikandan.m@microchip.com>
 <20250603050556.80851-10-manikandan.m@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250603050556.80851-10-manikandan.m@microchip.com>
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



On 6/3/25 08:05, Manikandan Muralidharan wrote:
> Add default configuration for sd-card to boot the linux kernel.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
