Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CDDC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E14B98277D;
	Fri, 11 Jul 2025 22:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oTptUj7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE5882F8E; Fri, 11 Jul 2025 22:00:49 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 540CA8277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40ba2ad38ddso1319745b6e.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752264046; x=1752868846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beL9TA7Ta0DjawVb2yO+QFLFrnsjNLvafSvIOYC4G2s=;
 b=oTptUj7Sb7cG6yO+GfuVBnBGlU/VoBh/1JMHR93ZRTggpXSGDW338BxdTtxYuBw+VM
 stqjM9+GGkw8gxZWfe1fZ5Nlitks34XeDtdOjH3uq7cXTx/pPz/zj1gFxeN/0ieHfluP
 J8u61IwtR0izXMp+AUHB6wc+BGlJo+3V80e10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264046; x=1752868846;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beL9TA7Ta0DjawVb2yO+QFLFrnsjNLvafSvIOYC4G2s=;
 b=mysCmFD8V13jj9Wn4os87p9PuNpgl9LmA6iqI0FcddxvTxvvtwY+cdhjnTb6RpHcf1
 Sx3NpNSBONu/dwahVHlxr5awqfRb113Nf+rNIM/KIMdmz6fMmHVfc46eDGHls0VNpz0e
 0dHTT2lTN4SgzFS8b1KfH5C9ICgkJZk+tDTZPCUZkjGdX5NDiy98m0tL9sBHNlheImm4
 yRKVESmVGsC+ZfUjhLsHfkT9b0Dkes6cyHAiE8I+IRaLOjYNtiqcnuVuta/WTe36WniF
 kRW+IZaqNz0tA9sOQa5vvOu5eAnkkKw4Av/qJAurGygGf70adYGNTCqLqy3YoTEbSHOy
 yWUQ==
X-Gm-Message-State: AOJu0YxXhhfW946tHo4/bX0VwLZEKOel8KA5LV3aRPGmcRygfQ5Zm2j9
 EfqgoglN1aUDl0P/PAmRTmjQq0qpydjR+3CHStgqeMKD0tRmFRv1fGjiPa/QOHH8OUQ=
X-Gm-Gg: ASbGnct2JE7x86TOVOFdCtOYQu5Ikig1z84JI894VeLe+whOvn91vKLqKgBTcZvcaBQ
 cTEbt1AVvvjzMuzjbNmIUhhEbO3hTALQ/R1EsExKvxffHKWzEPQ+bt6/deOEYXxZobL43t35/vS
 1dzz7sc/fZidk5Ll4igKqgQwgf3RULyn4cP/sKFRDQgoWIqSriwLuFoM/kCZpaNou0QsUBejqLW
 4a7KChW8ydEcUgaH1czCJnvehpcGLn0/TIhhW9xVD2Aa7MOagjaZugEXJXZ8yRi3YY/aRZe4Nv4
 9WRXEaGGyCgM2JkVVdJlk8JjS9pezal2sHZVaM9Qa0VpW8F0n38FdxuI7F//cBMYN9hYEgjCRip
 XV/jdgjJRu5+SXXDIMwnKth1xOY2qM3TRhfjnoHQ7ZvXRjKIdtrYb6G4=
X-Google-Smtp-Source: AGHT+IHGVQ+vO4S60De2WQPswDy3xFnl1nN2k7RwANaLSapn+QKVPlXFPQ6N2YatfTgki42XkU8RUg==
X-Received: by 2002:a05:6808:15a5:b0:3fb:57ca:1ea7 with SMTP id
 5614622812f47-4153a378024mr2766248b6e.36.1752264045839; 
 Fri, 11 Jul 2025 13:00:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414161e2b74sm666516b6e.0.2025.07.11.13.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 13:00:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Heiko Schocher <hs@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wang Jie <dave.wang@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250629105711.24687-1-clamor95@gmail.com>
References: <20250629105711.24687-1-clamor95@gmail.com>
Subject: Re: [PATCH v1 0/4] Create uclass for HW AES cryptographic devices
Message-Id: <175226404410.2365211.17651819002335257428.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 14:00:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 29 Jun 2025 13:57:07 +0300, Svyatoslav Ryhel wrote:

> Add uclass for HW AES cryptographic devices found on some devices, like
> Tegra20/Tegra30 SoC AES engine.
> 
> Ion Agorria (3):
>   dm: crypto: Create AES uclass
>   crypto: aes: Add software AES DM driver
>   cmd: aes: Add support for DM AES drivers
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] dm: crypto: Create AES uclass
      commit: 0d84494064193f4f41b147ca4d30ad51ebf6620a
[2/4] crypto: aes: Add software AES DM driver
      commit: a2e86dafd72dc1bc167459b25f6ab6efe038a119
[3/4] cmd: aes: Add support for DM AES drivers
      commit: b01444aa14cf9f1e4e5415135ec5b6b2cbfa0574
[4/4] test: dm: add AES engine test
      commit: e82ba0be9be130dc27996f11e41d82e1da95104f
-- 
Tom


