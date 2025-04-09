Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C186EC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE4283904;
	Wed,  9 Apr 2025 19:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v3ABUoBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9AAB83933; Wed,  9 Apr 2025 19:21:05 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DB4838FA
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so61069635e9.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219263; x=1744824063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SccCAlR2TCuyLkxbJ37lzpu23Ku9LCkgMzwM9Vh2+TE=;
 b=v3ABUoBPcM7QGWRbFydMKqHMjKoEZjH1Jcxg0ejOxlkpzHW7ejLOC8JtW2GUyM+nkS
 yK7J8vYSFT/a0ml5Ar3h43tHIayaIT0OIqlFQn8crb+NDwwzJmH+dclr0+qmao9E4i66
 1/LTDqfQm4bZxP3FUAm7E4c58fyPjuz2T1VnBSdwfGxBldP6cQySDKZxlw/rnA69XkuY
 nwq8wTl1IDbK9X+RpD6FtpFju6lAvmx83dEcLbnDLDIBJxEyzFgD5Q11TDZdkVrL3CdU
 EJ2ZyflUd/e7cn0NQFVyXm9qpRSDOuNPHzdmG596BqDF2AGJAOBoL+qT0SAogF8MWIkB
 4WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219263; x=1744824063;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SccCAlR2TCuyLkxbJ37lzpu23Ku9LCkgMzwM9Vh2+TE=;
 b=cUhp6nqHAYtv0nmRS2HLDGem6fqU56wpmUpCz0VMRDg0PzJO+tRaXrSnOw6wSjgKy4
 Pt0ezqUlPzpH9cwHcQmQpvcq9vWo/G/pGJX8LGDUgU/J+hxi21kkY23X397R/9jI/o6z
 MuaJDk93ZKUy2XrqLcOBf9VSzXhA0u/4WKOErn2ajG7ujM1kuHV1uh5Vd5kCWQLeG17X
 T4rsWVaDv1UKnY/PJX1gbUzXcy5Ghb8h/kZ5d9oPeexV7xHt90o7QC1O18mVuUGwCfbs
 xCil/Q00sAlZRAS/0HTgh7NQFjJALjMfP4ZlRJDNqoXaNPVKGFN9Nw63df4wrhRWSarc
 kLgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfUz6BQVYyN11ioqSIhHNtEGyH0Dzs6MNS4u8ftMFpoBXzwq7UqtG6OGMz0nJuN4kxzgqLXOs=@lists.denx.de
X-Gm-Message-State: AOJu0YzbUnIHkBgAi32Q1brCCKBgHmisZ6DfvXOg2/RrzsvM3V5VmxT2
 XlqINc1uZ+vHxOjrk0rUaT4GJAov5NfpWAE+Z9ffaHpW4M/aWA3zGTaGSCm671AW2+XyyUkvq2z
 DSWE=
X-Gm-Gg: ASbGncud+7EBWpnAETANtXx+679hyPkwF1JLufzD78nUiSG7TYipS4wP4CA83NRuKDg
 ZpJTrvRaldpZlAYdDdwhDIY6fEAb7QpQSHhoCZDdZxV5vCP35lbowIwjFIS4owYBr0HLupLZ+OK
 vKgeNEKnRt1FjVhz2pCXSq4gLt9MssHy1PAe0Ba/sJ7lAIdyGmjcH6EmC4yaFynrHCySzxBZpd1
 6G4/8kam3Z5cp8XMqZywMy5OwslOU3v5pcRpEoD9MuoCsMcmiuLy5qg05ELbugvlNt1Mf6Lo2CM
 YGasCi2V2jKv4Tp1v8IoeBSTpS2mnyk3bOhdmBchkxn2oaOdrtDDbVXaP1A95mBlRTi9w1H7jhr
 Rwxl4Og==
X-Google-Smtp-Source: AGHT+IFg2YI/NJpBnckZ3kyXL+BN3giEUb+Z5GU1X03v2nAciDRzajJUScfUtVtGpCHdqlniY09ebg==
X-Received: by 2002:a05:600c:474a:b0:439:9e13:2dd7 with SMTP id
 5b1f17b1804b1-43f1ec7cf31mr39544695e9.2.1744219262956; 
 Wed, 09 Apr 2025 10:21:02 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893612dbsm2167529f8f.1.2025.04.09.10.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:21:02 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250402142812.368168-1-caleb.connolly@linaro.org>
References: <20250402142812.368168-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] hmibsc_defconfig: disable DM_USB_GADGET
Message-Id: <174421926152.1813778.3298259589872837340.b4-ty@linaro.org>
Date: Wed, 09 Apr 2025 19:21:01 +0200
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


On Wed, 02 Apr 2025 16:28:03 +0200, Caleb Connolly wrote:
> As with the db410c this breaks linking as it conflicts with the USB
> controller used by these platforms.
> 
> This fixes building after DM_USB_GADGET was enabled by default for
> mach-snapdragon.
> 
> 
> [...]

Applied, thanks!

[1/1] hmibsc_defconfig: disable DM_USB_GADGET
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/ddbb13b6a4a3

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

