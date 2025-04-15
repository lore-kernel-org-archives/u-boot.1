Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525E7C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8D7826AD;
	Tue, 15 Apr 2025 19:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eUQnPhIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A128296B; Tue, 15 Apr 2025 19:09:45 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEAEE8209C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-603f54a6c8aso3347190eaf.0
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744736981; x=1745341781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsch996fIJn/YfFo8MOC92cNQtkKXqIRkyFgBeD/18s=;
 b=eUQnPhIZRs03nHU3e7ec3kt/zoJUINeWb5Ip7lUeeKAURkvocKCF3/zCpYa9OkLQmb
 DWO1Gw2sSLtk0B3uc68LyYBwf6pLNLK+jfwcbiBgX99moXZ/GsxQSInShrNvY3ncBPkU
 FXI+dkIygbVVHashXh5HfcnWbBfoGmZIoWZG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744736981; x=1745341781;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsch996fIJn/YfFo8MOC92cNQtkKXqIRkyFgBeD/18s=;
 b=A5fftJ216/Vc3cG1Wz9xrt7jXxVU2CH8sMISgzWbVvii7uP6S4LjpA4QAdnadlH8AO
 vAsFumhSRQoJhmgOeDgJ59jhjidc0TOT1CYEmzJ7AYO3trYWfubLXVlxmSVTjpy4v4T/
 0f+VET3IgsximIizDdjbDXYXyp+rwLhBWOfQGRQ4cshQKzo9SGdVPvIk8vacQtTbgpct
 C4AV1ioRh67nixk2hKFETHHf8YIfg+MJ8YLuhTc2+UxQzhHOxmqrUCPecNcVojLjjZUG
 tOGiGLPKwEpZuufwe13i1BrLMjNqAMeIND04D/bKUsgIKZROgO4mDRsllKeWtD3Tq5LZ
 lp0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp6w1woK3oSaFjZ7l4OKZwXxenw8xHXPQSRINC/Ny0lLUItGG1mpEr3G5uL2b2TSZ5R3fbvJg=@lists.denx.de
X-Gm-Message-State: AOJu0YxfxjDHGtTnSW/c3eXGDDyFlUdE3mEThById8uKjun+ndQPg0rn
 n3ZXJCarvsR6J3KII5Km3SwiyZ4qzIHR9Yo9EYjk8ZbUhvLH78pbLR5ABl83UJs=
X-Gm-Gg: ASbGnctguNxfGVpJ7J+JQ/1yCqjCwLp1bWDemKZGeiXhxKhFGI1JAY+AWj5kgnreWsd
 rqljtta3OETloCpk48d8HPTOQwzs6/iBxQiXb8E1r5ReRfRIm8NkbaeI68/PxEhIX0kcsWnMVG3
 tluPadkjpmDtvPn/7AhRyWSUszGk+9QQPBVe5BUP8GQ5A3z1WmzZNhjJeWGBG8vb18vMFg/qdjK
 MBKR+hjpWrjrjwqoGiBPyws4p4qEXk6tU6jqjwEccqFSGucMqA42SDBCxpUBpKkaUnlv6wHmPau
 OHVOadnJhIviyUZIViuvcHLY70eSbWkSk0Z1oNCBZNEjFyRdqHJSHylpF/Zg8DMxdjsIV1FJEsR
 hd9LoObXmxyY=
X-Google-Smtp-Source: AGHT+IHlfhroNYvJ6OVB0YXibCEYWjM1B17A1fnRLBM7g/lJ/a0/igeOD8jezl86MSCs8HjLICcsiA==
X-Received: by 2002:a05:6820:4c0b:b0:604:2b3:2c9b with SMTP id
 006d021491bc7-6046f57abfcmr9433290eaf.4.1744736981511; 
 Tue, 15 Apr 2025 10:09:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f5bdbf0sm2474209eaf.40.2025.04.15.10.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 10:09:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
In-Reply-To: <20250407-iomux-stop-v1-1-d6485f7446fd@linaro.org>
References: <20250407-iomux-stop-v1-1-d6485f7446fd@linaro.org>
Subject: Re: [PATCH] IOMUX: Fix stopping unused dropped consoles
Message-Id: <174473698080.645182.1337804897952228348.b4-ty@konsulko.com>
Date: Tue, 15 Apr 2025 11:09:40 -0600
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

On Mon, 07 Apr 2025 13:10:00 +0200, Stephan Gerhold wrote:

> iomux_match_device() returns -ENOENT instead of the end index, which means
> console_stop() is never called at the moment for unused consoles.
> 
> This prevents e.g. f_acm from releasing the USB gadget interface when
> removing it from stdio/stderr/stdin.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] IOMUX: Fix stopping unused dropped consoles
      commit: 265420ebc10bc96275be5eb81fe6157d46e135d4
-- 
Tom


