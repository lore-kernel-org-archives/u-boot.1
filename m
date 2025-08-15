Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D5ACA0EE0
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 07:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439E683A24;
	Fri, 15 Aug 2025 09:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lGVI6YrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9A183A98; Fri, 15 Aug 2025 09:22:03 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B96839AF
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 09:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so8749445e9.1
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 00:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755242517; x=1755847317; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=61b+z5Hs+LoaBQeu6BDS44+1Jl0mPcKV94XUdLjdf/A=;
 b=lGVI6YrVcCbOSMCMkPGQpgPsdl2ovux0LclUXO8/BImPAFZ4HShrk62JrUr1ajyi52
 2UslYvx4tGlK+a7cfQ4K2pac6sRP4MpLx/iqiKN4jDcAoTWqBNeQuJN7lTywnIquPfrq
 5MhM66Uw2gfoZB6Slq22QoXecjuW97G9nvS1kp6mp5V16Pfp2Vdyre+wOV4fPzhr9JO0
 PcvhOlR6rsl0+kSmX17PPiHcJ7bm7cA20PI88HBl9hLmX6W+J4/Y9R6jny4xr2zrjE7Y
 bY23z2/QRNdrl3jM9QY3ehn7AgEjaVtHr2xEsmFDWRG5WVRAri9KXk05NgxG0+dxBW9h
 OPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755242517; x=1755847317;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=61b+z5Hs+LoaBQeu6BDS44+1Jl0mPcKV94XUdLjdf/A=;
 b=HOg/h1/JBIvA/JUND5kkva5Ij+6DGlRqi5ftisuMKV9j6Di92i0ytMaI43wmHOEpb5
 Swsig2xFwtgdOImhUrnqDp42yG4TkcOsQB3Pxf8mN41NwsNdPfrf9EaqxH2m0kkLjsmR
 LYho4wIVpFI4AlYUSR+I7A6Dy1xhqOdcGDg1neKQQyufMO1sKrczdo3WOCBreCHFZSbl
 DqA2lgMS/vgGsb7cplluqm2SOZlhlrMyC3TOLDpExjJWZaM1kZBFKbLsQfJA24W6OgrL
 j/YKNOkfiyT2RYqlyUp4aTbjZFfLhgku/RGtiShit7E67BziLE7ydfh4El5WZkVnboUn
 o0Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8/+SYXv8F+Rhf5KyjFJpiTCnoCkl6NYbCkNREaxIa2wB+IUsJMrgYtyI9MLO0kdJnY1dYPkw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7cdRs3MkeJ670hzDk2x+oEHx59F9qfwJNYKDCRxbqZXVW8kjP
 do3lvtAnNIP4V7Ew6YB3KQsjDoUwoZ3gwLtCcHHhZTJb737lRWzKa9x+zdRdgKhZ61bPyeHdQqr
 njpJC0SBavw==
X-Gm-Gg: ASbGncvfHMaL6Y0Fkip2ZyHwhP4lYbKy9yImU0uXlLQYER5LJ00WvYujePQ24LshBEP
 TGYJun+nbsZF6A+q7pKvaPeJIFJNjmal3PWiMoR3rLwC6S5m/8MUZnNQQji09wOzl21zYRKiWhC
 jIEnEuScipa518DVDWGHXAFApRWCCdcb7B9wGVLQCJE+0XuIIGQxLCjMUBFQEUvV012Vssb6UiR
 VgVn4DE9D3dFLNTlB8bsY7GppndU42Zy5pRIqT8mqyixOTASfPjFNu9HMGvzHxh3qOiZ1tT3IVd
 3m3cz+PH2GWZS5ABAUMJzYu6tj1nk6Z3wx3qxnpNmirfF/s+eG/5yQ8wpCYKQ9HEBiIC7Es9Tog
 fU96DpolbM+XJ8/H7f5EuYBE0BoarKSoxmouMkBsz
X-Google-Smtp-Source: AGHT+IER+cm5TtRljTlSnmdK5LkzsGs+rXbuSjslgi/ZxUga8hXK4bDpMLif8p8X9s7ukStto9oTvg==
X-Received: by 2002:a05:600c:3baa:b0:458:bc3f:6a72 with SMTP id
 5b1f17b1804b1-45a23d36b37mr3398015e9.4.1755242516692; 
 Fri, 15 Aug 2025 00:21:56 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a223206c7sm8145335e9.16.2025.08.15.00.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Aug 2025 00:21:56 -0700 (PDT)
Message-ID: <2d968b86-b45e-4d72-9f65-7696cdd0f617@linaro.org>
Date: Fri, 15 Aug 2025 10:21:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: sama7d65_curiosity: Resync with savedefconfig
To: Mihai Sain <mihai.sain@microchip.com>, ryan.wanner@microchip.com,
 trini@konsulko.com, Romain.Sioen@microchip.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
References: <20250811073033.5173-1-mihai.sain@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250811073033.5173-1-mihai.sain@microchip.com>
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



On 8/11/25 10:30, Mihai Sain wrote:
> Perform a clean up of the initial defconfig file,
> and resync with savedefconfig.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
> 

Applied to u-boot-at91/master, thanks !
