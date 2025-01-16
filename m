Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFAFC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A2280214;
	Thu, 16 Jan 2025 14:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="et7e1QQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E5078033D; Thu, 16 Jan 2025 02:59:35 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03CCC80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-467a8d2d7f1so4037761cf.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736992772; x=1737597572; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4tWoucHdYZcxyQuDCHPKf5o/9FAcip3CYgQH8wvP9M=;
 b=et7e1QQJ26hhmvZhKAEhvlDq8TTSj+C9jryUFCIVyTexy1t5YP7PrDigLUYylsArQB
 jWvPpElEAg4dsqFfTGSEi55NYbEqfheIgKtf7cubx14L9iL1xJ9KxxQXwut1UbVzJnzF
 poIoqUDot3QlYWp53vRcL3JbR3D42im2RmQDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736992772; x=1737597572;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4tWoucHdYZcxyQuDCHPKf5o/9FAcip3CYgQH8wvP9M=;
 b=j+imN8T0iYD8z0Soe9/Gxag/6hkcwl5XXlfBNXG4ufRFsTCAJMVlGxfK/dfnDg6XO3
 CoYRLE6D7ie7mEHwJX4+IPavTmMJEp5Xb1cczaK/q0Y0BaeBNSH4yVojGwAohnPct3q7
 I+5cm07H7Qee5buJYYU/64+cUa5JXxX9r5kq9SAe6WypLcOMMHETBN4xImPUmBoWzBHy
 0bq627VY9cd5NTUlUoGq4Gq0FSPDCK+R7tLn3nACzjZ4UqdIoC9OwOzEmQUhqhXT3ccu
 3JDktWp/kpI95JGO9UeNJjryELRJuoADfXx2yVmRkYoZm1h2mM48+q/1OAvg+YBKQ3jz
 vPrw==
X-Gm-Message-State: AOJu0YzvBsSE8gAIlPuks5C258utfiRyF1lHCWYP16wOB/QF0TE0oUgg
 Zc38xoMrbHR709yc5DokIIqUiAjrdNwdnTlS6d1idfDKK1g3H8QzqD77dwJ5Rog=
X-Gm-Gg: ASbGncsSIfH/8dDUmdF/PGumqLshWBVThBkyGrZtxzhrxHHqAT/MJmB4k4dbZeu18lY
 2wy5hLPUk6wJVE4nu3AmbCrmzj3qgR+dM5Dl9puf6Aik397ecp8XV8Yc3pAsLxL5ozRI4JjuUUf
 ZM4kj5cWX8gfxc5Bw/eBnuJQ1jyAEC3YlWyOe7tljyxcqveo9Eful7BgixVb0szhTrCFWcHxxSB
 m36Cn+VAK56Vzb7GU6WaXf619NIBj9o5KNp4LJwsnrd/wTmN3ti
X-Google-Smtp-Source: AGHT+IGh/NSqjfK6/7bdjzamxWTLEFX3kBv7FQgaYhlyxq6l/DjqnDfK4r5vWh1Q/oeGeR4noJgbQQ==
X-Received: by 2002:a05:622a:190d:b0:467:8734:994f with SMTP id
 d75a77b69052e-46c70eb036fmr464222831cf.0.1736992771858; 
 Wed, 15 Jan 2025 17:59:31 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873dbf16sm70740921cf.67.2025.01.15.17.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:59:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Dragan Simic <dsimic@manjaro.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tim Harvey <tharvey@gateworks.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Wang Jie <dave.wang@rock-chips.com>
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH v4 00/19] bootstd: Support recording images
Message-Id: <173699276700.697899.2030941287512738823.b4-ty@konsulko.com>
Date: Wed, 15 Jan 2025 19:59:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:52 +0100
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

On Fri, 15 Nov 2024 16:19:07 -0700, Simon Glass wrote:

> This series provides a way to keep track of the images used in bootstd,
> including the type of each image.
> 
> At present this is sort-of handled by struct bootflow but in quite an
> ad-hoc way. The structure has become quite large and is hard to query.
> Future work will be able to reduce its size.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


