Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0D1C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 13:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B05AA84AAE;
	Wed, 15 Jul 2026 15:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IoZ56Zh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E056184ADD; Wed, 15 Jul 2026 15:59:45 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8213C84A6B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-497deab2d66so1825968b6e.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784123982; x=1784728782; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4wnrt9AVgYgJMPnOqIcmqrXleNJdwxYRjxpkdgJAu/A=;
 b=IoZ56Zh86viHFUNSgrnzz3EENtHBVU8FavaZgYwq7nPH8KPnxieeoyu2neohTEiKJv
 m/qLvQ1p2ZPNUIc1sHwFGLS8ljjTBnnasJ+iNOrCE2oEdLisvKmmoMeWnS5KfHx0RFW5
 asEKf90H/CoSIQVaXdXBfT8uHei/PpZTIh72s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784123982; x=1784728782;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4wnrt9AVgYgJMPnOqIcmqrXleNJdwxYRjxpkdgJAu/A=;
 b=Fteiu1DSR9CRGCIA5l3AjHT9oWrSqqXxRTCMZCGw9e32auv3Pzad5Xv5bftBl94fFD
 GbCsxk3R++pMosZETecpKqoJ5t7S2T6TsXlnDjPh5uS6Cj+BUWDbCpx/zKh3pd13gcJv
 ZBuofzhlGoXoodQ1EiXgVOQLRDay861VVDjYX1hA11D6wXG2OeZZ7kQIBPdb3Bu/2Ih4
 exlQu+kxcS+QTr3ofGAull1GIH2oP9ch1dkDYH4uICz2ZKingBxEmcIpZ+JIRuzyPoX6
 y1s5DcXWbX4GaBs0w5Ms5BRVQrHkHT7dvNB8qroQz8X08rQ9W99nWOTLqQYl+ANuo5rT
 G+dg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2ZzMYZMftBHxykIHVr6cDnTnBdccxHfbUeiZNyfFwndm0b/eeTfbLxvWnYK7zqZmrdv9Vhtg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyef7K4gEfI2awufjUjSd6Uc0mYO/bxsFS2Mco5MaN10AaW8d/t
 Q8Q3T0s8tM5uqllJI+uX67L8kVaK+ogQWEqPeWn0j6t8IwwVj8cJnG2MN+OII6FibfY=
X-Gm-Gg: AfdE7cnDm1d3uZ6Z6KGWEHJ2rmYkXrvqF+rnl9hkXEg9SqyD1UoVc0B2F0kdqMr22tJ
 UmPKadL19CUX2mPN4kFqVbhXeot+Jl4pz0bSy2EbS2v8i6Kw0N3afPoA70e4aE5ofWWGrj0+5EN
 /Q/rub+LbEK5tCRE/QOmYMp7sbJgZCYiKpY9qDIZcXW+3KLbnV5DvoWto8VQRc6MyCxdRgeZMv6
 rGJ+MD8wUYpZKrf62oo5EHPtSPxftptEygOsxfCM91WE+69d+1OU71fCn0I1mjT0HlFKuPEK/Ao
 +uxZ3lcEPfVWi957orm2ILFNLCnFJtckj/gZfLxSvA0VKmPf/FX1Kc02i/Hp7ZeUNRq/I4H0p+0
 IT5oxv68EfIaem3kejrZGBuVJaIgaMYfvJKrRjNnSdB2a13lNyWW2UWKNufXdkBVBu+ip+u+6Bg
 gzK7ln95qj0eb34hl0doB3PtxpubjP9RuRbaP0OLIU6L7rrhBlx6oXR/zqsEifE/5uJJBRP9YI3
 /8NoctXoVjM5kx+nnB2JQXxBpOxye7D1F3ptrD83cZ12k0=
X-Received: by 2002:a05:6808:180f:b0:4a3:cea7:4ab6 with SMTP id
 5614622812f47-4a42d0001d6mr9625654b6e.10.1784123982170; 
 Wed, 15 Jul 2026 06:59:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1afbfbbaasm16162301b6e.12.2026.07.15.06.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:59:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Peng Fan <peng.fan@nxp.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Michal Simek <michal.simek@amd.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>
In-Reply-To: <20260702-pinctrl-v1-0-4d2bd89fc213@aspeedtech.com>
References: <20260702-pinctrl-v1-0-4d2bd89fc213@aspeedtech.com>
Subject: Re: [PATCH 0/4] pinctrl: aspeed: Add AST2700 pinctrl drivers
Message-Id: <178412398045.44767.15914058749313027151.b4-ty@konsulko.com>
Date: Wed, 15 Jul 2026 07:59:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 02 Jul 2026 18:08:33 +0800, Billy Tsai wrote:

> The AST2700 is Aspeed's 7th-generation BMC SoC with a dual-die
> architecture: SoC0 (CPU die) and SoC1 (I/O die) each have their own SCU
> with independent multi-function pin controls. Initial AST2700 platform
> support is already merged in next, including the ast2700.dtsi pinctrl0
> and pinctrl1 nodes, but no pinctrl driver backs them yet.
> 
> This series adds one pinctrl driver per die, each followed by a patch
> adding its pin configuration support. Both drivers use the generic
> pinctrl framework and are compatible with the Linux kernel device tree
> bindings, using the same group and function names as the Linux
> aspeed,ast2700-soc0/soc1-pinctrl drivers so pin states can be shared
> between the kernel and U-Boot device trees.
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] pinctrl: aspeed: Add AST2700 SoC0 pinctrl driver
      commit: 1b87385aacf2c8a5d6d9296984509ae8376d6165
[2/4] pinctrl: aspeed: Add AST2700 SoC0 pinconf support
      commit: ada5d0e7e2ceb118a70df7d8c15b53d0d91c7d3b
[3/4] pinctrl: aspeed: Add AST2700 SoC1 pinctrl driver
      commit: c0e2aeb9dfe551a1b01a44dfffe917e8997898c3
[4/4] pinctrl: aspeed: Add AST2700 SoC1 pinconf support
      commit: 02d74afe94a5510312d01ad79a3801c589cb6a20
-- 
Tom


