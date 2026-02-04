Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00EAE87840
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 14:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BDAE80212;
	Wed,  4 Feb 2026 15:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g0s4JBxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F2483A36; Wed,  4 Feb 2026 15:01:50 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 789B980086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 15:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45c9fdf2a06so485751b6e.2
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 06:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770213707; x=1770818507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nrR+j51YNOjGFlPoVEY7SGjxhBGYVMlVKeH4RO4Nc0=;
 b=g0s4JBxE6LHKHLHGI/n6Ci4PhEBDCuExr44nteMsNO0zDWLhAqRYyYdi7YXIA8tzi7
 YR5gsQmxLDc0fpE4MdGzqZNigxq8VMki/ipCv86xSfsbPSrIHSKbIn6CFBzdR8iZIcs2
 Np+DWLK+YQTnxa1/xoz6IrXD3VjhAs88F7ODg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770213707; x=1770818507;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5nrR+j51YNOjGFlPoVEY7SGjxhBGYVMlVKeH4RO4Nc0=;
 b=jFR8PJz/hKQ/g0b8jPuJZwmj9Op/gBXEc9q15xj3mURd9fEiWtFIDZ6SCUmWjGwbot
 rg2X6ybaZE9XU7KFcE+k+XtRI4b7zxbrrpRa2i8F8VqkpZ0CpmVdkxfvbTgUqoGr+0GU
 zF/rE4Iv6P4pxZSy9/taKZsXpOB8Gax1wVtwtrWzcd+ezBdgJWmg6QtYC4FOUup69UFI
 e+cRuFpCggPAL8uS5GHVC70djLLNRYyFQhRx1fq1w14HjpZLV2ik8IYyXV9zhguxFzoU
 h0S0MxxpqHas1BQpWPx9CNvWsdU1mK11AugHq3ZS7+vqJph6y+OWLnu/S5acGZ7z6dLf
 6ajQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqTI1Nrsmu3ay7xASQ15t8ZlUKztDlC7tl5oEl6NwPKCcv5LNKTLKkmjYuxjzAUkhwdMt4UMI=@lists.denx.de
X-Gm-Message-State: AOJu0YyUB8SE3JqSunPOendqpNVkFfdVWtUrH7vT5xzX8w3hODaDljD7
 MgXRE/xrrZHaDEdYQ0dHWZkK6Aw3F2QkiddgMTomU0+fSSL+bcYF5arL7Xu0pHxY/dE=
X-Gm-Gg: AZuq6aI4HcspLKP+EN9Hc7QX5N4J/xKuB0ecz98Fw/s2Y3M6vUsi3VLGWMOakrjJUiG
 npN0a5Ix+bBIpdpup0PlikzqHD/mLOuVIRdQTZH9v+nTUQF8I2cl0ec5bl+iOCyK7yeARMk9xuG
 7Rf6PmRv7ULaYnlM/qI6QhpREAQglqSr9XYs5g8dbzgefTBEuHK1c+h6QAy7FNwRL9WIDIu35BD
 OFVXy85RI3ForbAO+BjyDFRsuotvoEzRXXUGq5vrz90UnSx05rc13wR/rZ8JRi+7bU+sj8Dpr8d
 KpcU75UBM93OZFi5GqPRaJBP/T3YILX3MzBv/E2qRXW7Mu3LCtRGlSIzvze08OMVznCm4gZtsM6
 Go6X2jeIQk34impG2sX0jpbulqf0u+8zoztcjcBY2Z4dtqx6h05goLH5jBLsTJRAuJRtLUn38V0
 71nN5lgPLkQ2m1XmDfceeQicxNtUVXE2euZ+Ln2E/VGK07mXmg7IOn5XiqvI+T9HvTre5EvrV1v
 Ewbjl6Fbm9eANlR2NKzsYXsX4u+RCDoWHMIaA==
X-Received: by 2002:a05:6808:2396:b0:450:1433:f13a with SMTP id
 5614622812f47-462d586f338mr1701471b6e.11.1770213707029; 
 Wed, 04 Feb 2026 06:01:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a590fe5f7sm1369437fac.9.2026.02.04.06.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 06:01:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20260127101413.2812815-1-ernestvanhoecke@gmail.com>
References: <20260127101413.2812815-1-ernestvanhoecke@gmail.com>
Subject: Re: [PATCH v1 0/2] toradex: aquila-am69: fix SPL USB DFU, drop
 obsolete clock
Message-Id: <177021370577.1736867.16116664582049382489.b4-ty@konsulko.com>
Date: Wed, 04 Feb 2026 08:01:45 -0600
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

On Tue, 27 Jan 2026 11:14:10 +0100, Ernest Van Hoecke wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> This is a small, board-specific series for Aquila AM69.
> 
> Patch 1 fixes intermittent SPL USB DFU gadget enumeration.
> Patch 2 drops a stale MCU_CLKOUT0 enable for ETH_1. V1.1 hardware uses
> an external 25 MHz crystal, and support for earlier revisions was
> already removed from the DT before upstreaming.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] arm: dts: k3-am69-aquila: Fix SPL USB DFU gadget failures
      commit: cdd51332cc87b1964f6b48d1c1d5ac142b0dc7a5
[2/2] board: toradex: aquila-am69: Remove ETH_1 MCU_CLKOUT0
      commit: 81cd740838b1fdc6c473580254f0f217df375bcc
-- 
Tom


