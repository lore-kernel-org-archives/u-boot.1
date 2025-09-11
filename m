Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85386CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31F7833E9;
	Thu, 11 Sep 2025 19:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LsNQd0Hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9704A833D1; Thu, 11 Sep 2025 19:12:33 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E0DD83390
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30cce892b7dso454404fac.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757610750; x=1758215550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ph62Zgze+PDXAJudjb4JCGmMj6vL54xBiOOnPYBXBA=;
 b=LsNQd0Hnl5OJs/VRNbKr5LQumfja74K9DhjtO24G/EJFrJ3Th2T6fN3rVgQSEfwaWP
 2PWTK3j8uXUkxwuSKkESiG9agkWFUWNWeLB60Nn65KxnkpBgwNunPd9isE2+dTFssM3M
 of5toZVG6RypKSpjlNh1EK1OIiYyF6u0kMblc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757610750; x=1758215550;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ph62Zgze+PDXAJudjb4JCGmMj6vL54xBiOOnPYBXBA=;
 b=UjV9wvaYe06ZmfA+1Makzba+sSHdSYpqVPzFkR4Zc6gJNqHyRYOfdKVg3aN3bfWwKr
 crm7oaw+Ga8kz5jDNWfAA8NoknvXCW48bj7iG/nSwsXzSE18Be0uFvRQiPME9Zmg20kD
 hsko6ucOV2K9oT8tnp3PZ3tWOtaywyQFp1YiPWGSdAOpesdabQ/ZnyCwgrjyaB07OWQm
 1ql7CJVIyjHuJG69ZJpuywLiFsw84aj+0o8YaycV1r60hofn6iwOSVWkgi6G4mHAAZ3+
 uwnkSo1bGmonLm2iGgPOrdvi+8WZO5HnIf6pepG2znsN4ekhYMu/S0Osyvo2P5IUcuVC
 Bp2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyC01uvn1q+ma25/D867UfL22Ws8oqlY207BO8pOKDsxf/8XbZPMNsNYm2HhC/q6Sq2Ufg7gk=@lists.denx.de
X-Gm-Message-State: AOJu0YxfQ4qiAr6naPop1mpB/2dFfylbHjQZR1Cb4dObFkUXMjG02hEB
 UiU95uLKbNRzS9j/586UoLaOK/PKHm4kJh/50waD+SKG0Qxhs1W8N5IsfnSZAXRJrto=
X-Gm-Gg: ASbGncsbdsfCKUujk2jRilRidB+Q5QLzVyEjxHHTikH70810eaRJLSt6lt9yrnpK9Ik
 ZLpV2rsDAroPs+wjVX1AyIsu2GbuGULB348LWg8YqNTkZDdzqCEob0B/gif+tTsVGbzhVQnKAKU
 xGNaN6bR0vCfHeHLDwkjKekYLH2nhcXGHUcQGMAkXSiiD91lg26TsQoY/8cCSu8ha3q+3Yb31cz
 8wvPjcNsOO0y+7RxPwPHCH5P1J2/Ck5e1DRKJaZiplAU6jVyg7oANia7CnyS7YJB201luj3KSOh
 36IlT9D2CCxqPsA3kdvprUUIfujzNWP5d7vbp0OrpdpQ8mVfMALMVMy26QdMKdcCTiJoanFJ82a
 h8qkli7ajD7OHwzkestQpy+/3deVnw6xqpoKlmbEzfTZMUZg0nvXNPoY=
X-Google-Smtp-Source: AGHT+IEQF1bq0H6mYQUCYl3eAECHTr0AOnlJL1RUIXxkR6qdcJoc9zm7FN+uAmg8rRqlxS2TvQA/+g==
X-Received: by 2002:a05:6871:28d:b0:31d:8964:b4b6 with SMTP id
 586e51a60fabf-32e5457b92bmr5842fac.18.1757610750008; 
 Thu, 11 Sep 2025 10:12:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d33454175sm539312fac.10.2025.09.11.10.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:12:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
In-Reply-To: <20250828135235.26711-1-heinrich.schuchardt@canonical.com>
References: <20250828135235.26711-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] spl: SPL_DM_SPI_FLASH depends on SPL_DM_SPI
Message-Id: <175761074858.2771962.11850381112229702517.b4-ty@konsulko.com>
Date: Thu, 11 Sep 2025 11:12:28 -0600
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

On Thu, 28 Aug 2025 15:52:35 +0200, Heinrich Schuchardt wrote:

> The SPI flash driver does not build without SPI support enabled.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spl: SPL_DM_SPI_FLASH depends on SPL_DM_SPI
      commit: 2083378ff0f096789dcc84a3e5b57891e053421c
-- 
Tom


