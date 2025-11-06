Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E720FCCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 17:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41EDA83C0B;
	Thu,  6 Nov 2025 17:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pInM73gX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C9C83C14; Thu,  6 Nov 2025 17:59:51 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B31683BEB
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 17:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6d3676455so374828a34.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762448387; x=1763053187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51NGFbk7lZggExeiShqp6h4HRmZbD01paPGNiQej7Jc=;
 b=pInM73gXHlFR42cypnew0mF5QMYFK1VD7BJQbdMHMwgtYpsGmD8MuPjyZbijP+k9DD
 /FGlCfWIXy47xV5Yp+ONtaqbSXu/h8+n7j+Lj6eYM0ZTIVZRX0TwuuDFRsOaoIiCsZ79
 GlaHz+IzFpwGWEi6Kv2ckRFXGa5GmBhbZC77I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448387; x=1763053187;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=51NGFbk7lZggExeiShqp6h4HRmZbD01paPGNiQej7Jc=;
 b=tafURG7Hxunay9uISmMhuXomaebETYWRvebQPOnyFJ3WoEyC4/9WWsFOjjEDS51Fow
 t7rGO+UVbH3j02JAhn8JLGHLJTMjVMLN3O8xZelyf45EYm+wHiGgsTqRWQ7j9/btFkMl
 vvlqJ7tDeuM7JQT8C1nHNzDQKX0yhpoO01Vy1nxFvby4PWhdBikBWec7tDWcVG8fXDnb
 5ETnt4WTq9qb7Nq6pKvASWGlYng/51i7gbgty2z2DCvaLFOHIgscCG8oh1V31SoHhQX9
 ATqX8WnHVP+yU1HMjborZkBNeGR4BYJNg9cJkwum9uifBaWM/caf4qiyDvjDLNI/0ECi
 g25g==
X-Gm-Message-State: AOJu0YyYN8hAeKJCMpMtar2effty4Jxa3bhu/brRnxCLZFBMlpHU2QTE
 YfseqYw69bLNltWAYbj1v2G2nUdvfOi8pRJ1mHjx+xmRzo5OXs2ZAIazRNxgrj+nkYc=
X-Gm-Gg: ASbGncu2kcPhHmWy04T2Ac6WGQWQPN+rSVJOAfl2oWOtp2MTw3euw1kZtR2AD/lsQWS
 0NZ4ktbB0owC59CrD2HBisnZT9bt6jjMABYfDhgN8ivrPCe4U/LkR0GIja9x4mIyZ4z3cr0hMk7
 aipHO1L6ch4x3o03u+xP5Qhrcaqv9U6V/3hgMnRfeZH3B8JnVPM3Ce4uMKZW3fbfbd0dxEODU3E
 OjYZrtRhgj866oJlexhZE7bBlYibHsMALxDS95391q+foO8+m3Kzu+KXV1liRXJ8kWvI9aGcqyC
 lG8gKfPb1f545YIjrJ54YLQqm0THoJZW4PCIZw7kHPKjLA4eHHWIB70FPc9U+U2OiKL/zn7aFhy
 jjAU42tl+VTQt8nyNliaE/NqKuij8kQD41m2ZocR5T+RfoQ+luUqyB2ft5PhUehHj1TIwFaQStB
 b8GKsqlJ+jqLMjYqwNqDpQNCj8wGmgdrt1ieVzcg==
X-Google-Smtp-Source: AGHT+IEJ/bNVzVDwJ8FV3cG5LLBhqZAiyYraHRIdw6xLvrTBSi+4d+PrIZZNQGbyT+ndN3GN5ZcWGQ==
X-Received: by 2002:a05:6830:25c5:b0:7c6:a628:22e8 with SMTP id
 46e09a7af769-7c6efc9d2fcmr246391a34.5.1762448384739; 
 Thu, 06 Nov 2025 08:59:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f11323absm24819a34.23.2025.11.06.08.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 08:59:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: Heiko Schocher <hs@nabladev.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Zixun LI <admin@hifiphile.com>
In-Reply-To: <20251024125251.39886-1-wolfgang.wallner@br-automation.com>
References: <20251024125251.39886-1-wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH] gpio: Return -ENODEV if gpio_hog_lookup_name() is
 empty
Message-Id: <176244838376.3056677.6463796811857088332.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 10:59:43 -0600
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

On Fri, 24 Oct 2025 14:52:45 +0200, Wolfgang Wallner wrote:

> If CONFIG_GPIO_HOG is not set, then gpio_hog_lookup_name() is empty,
> and thus does not initialize any of its parameters. It does still
> return 0 though, and so any calling function might assume that the
> parameters have been initialized successfully.
> 
> Change the return value to -ENODEV in this case, as the function
> would in the case when CONFIG_GPIO_HOG is set but the gpio hog
> could not be found.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] gpio: Return -ENODEV if gpio_hog_lookup_name() is empty
      commit: 854901ccd43a2f547d2bf090456214c6033144c5
-- 
Tom


