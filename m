Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8457E8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF248416F;
	Fri,  3 Apr 2026 21:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EYjAunp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940E984132; Fri,  3 Apr 2026 21:47:18 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9BC8407E
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d750eeaec3so1009308a34.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245635; x=1775850435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1YPiVB6D7szISYD8oUhFMoCqO4SDHiNGHjE6BNudb9c=;
 b=EYjAunp7b5jkE9llcgv0VwetMNv2AqAqm302cC3QTLkTpoL5nm/53Dtwti6fm62KrF
 3Z+9OyMCGEazvpvabeoD1zZY7ZntVhnqulhv/ndstVLJpNFC6I3prcQllcugH97cGpPA
 UoL8VQretXsKbSvCBoohzBEgRgsS4NjRFTxaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245635; x=1775850435;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1YPiVB6D7szISYD8oUhFMoCqO4SDHiNGHjE6BNudb9c=;
 b=NBc/vOXR7vPy0Y9Kkwhqqi34UNaJPph7AmzjJ4u/wwH6gd+zLUDD9BgoA3zVq4XO3F
 ZVeag2jNUhNMBecB2PdoF5l3rPfgJQTBIDhlTZj6i+peaptDARL0sIU2YcZ0Xiq7+bGo
 ZwL2jTm+RFGkIbA+1Co5wpiCqa6RsZWXi5TtYlPLDCdXAopwXn5VTDcommqOO6Gn53rV
 HlmEjSBzm7Fimi6eGJtKfSuSEC2E8H5hQmYNKoQYT4v3JCD3cXmUAdRjx7F/NshozxSf
 +nbJmvFyS1ib2BxBdXVKzY88QwiTbwZgEBVWnHooF5gA9RI2Nl+k2FOoxCKzYs1gKCJy
 AWag==
X-Gm-Message-State: AOJu0Ywl9Ur387YfKyxXro3KbV9Rjuwkzpa9kRk54wl46V9Jf2VVtARR
 9D2xM6r1hcccshE+Y8tltDNQzpQwz5KLQhWkKSLNOlUDsx74C0G8KlZ50SwSe0sq4M0=
X-Gm-Gg: ATEYQzyzkwT7MMEE7SCQyCpJc2MKh6Ou5ZiPEfl62TP0EfGlg83+udpmA7RSufoOJG7
 tHMgx8CsUIvk1F3qidiqYFWXg5rukrtEPS/BJq0YkcY4y2QvMw1xSxSYcBIn/0scJNyHb3sx7Xk
 QdHiTFwq6m/vNhZG8WXdYDcsAdBLAyB6E4gfvEWnvCaZs7mhUiR5depyco6zla4wS3djKou248u
 9URoq0Uxb86Gn50Xb/Q4XwTcBFZanJeCsv/PgnPlWHT7Y/Ge0V6W50lCv8F5g8zjp8EsuC5BUyb
 z4uyGRzT3UmX16IlsgRIwW90Zv5ENIA+ZWh3gTbRhhQKvisJ6QT6uiJN1x9+xCKcJsm0RH1peni
 V8mtlVVpEm9VSsdEpBCNpON3VelF5HYvS/h8JKFFotJoftJkBuWo67x6r7zFSwKThW4yHwtT5xU
 yTrcaMPRlbGGMSHcfLvKVl+mJusCbb3GWYM8qa068pJ6O20THOlyegSS1gGhOFsdkTHd4C73ZQW
 fdFKrkbEiW2CtxgqQLaehjvTA2E2BPw9+sezhpjFKBqgCA=
X-Received: by 2002:a05:6830:6014:b0:7d7:d4ee:c02d with SMTP id
 46e09a7af769-7dbb7112c01mr2724313a34.21.1775245635175; 
 Fri, 03 Apr 2026 12:47:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205326.3788614-1-trini@konsulko.com>
References: <20260320205326.3788614-1-trini@konsulko.com>
Subject: Re: [PATCH] bootcount: Give i2c-eeprom a unique identifier
Message-Id: <177524563460.2281750.14968099124430004696.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:14 -0600
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

On Fri, 20 Mar 2026 14:53:26 -0600, Tom Rini wrote:

> Every U_BOOT_DRIVER entry must be unique and this driver was re-using
> the name of the bootcount_spi_flash driver. Change to
> bootcount_i2c_eeprom.
> 
> 

Applied to u-boot/next, thanks!

[1/1] bootcount: Give i2c-eeprom a unique identifier
      commit: e5e268091e5ead232e2938a152ae0662fefc2ae4
-- 
Tom


