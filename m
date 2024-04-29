Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35251C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3CF889BC;
	Tue, 30 Apr 2024 01:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GPDaYRjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1919D889C2; Tue, 30 Apr 2024 01:04:11 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8F1889BE
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78edc3ad5fdso439930185a.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431847; x=1715036647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4OkU69KqRAZtCdX01nuAlpHosc8QM39NCx3rLs3xlA=;
 b=GPDaYRjgXJJTo5r8CqRBmm8qwA3keUVUFCbIOIkQqOPxk6svHBBlBc67Fzgkbwm0hG
 xeHazo1X6rm1NEXJZ7vHZ9a2XHSMCtjUAuZQ7vmTGefEjSfezJ2170KIhkI4vo9DShSO
 BwoivSnLEQCPKThZEcbSL3BkUpdVnkiiZhNbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431847; x=1715036647;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4OkU69KqRAZtCdX01nuAlpHosc8QM39NCx3rLs3xlA=;
 b=O33Da3MG/1Ao5idoxWAQcCFoTxcNBYNKKuSpWe0+ptoI2V3a4SeFz+pxd0KsOCEcu4
 NlOMcynsypfcYfuR3xozZbYQ+CAuMai9HId4+sUrdy9OfsSQXGSoyH5mtf/oW4QV9jZG
 ej+zNRCmsiTTD8Ui5Y5TnH3CZZoA4okSCC6CoepYDGiGf33jetaCvEKZRf86Y1a6pZv6
 HXA6BowvRjaOZJ4tEjO/y2Q0tA4woImIWHs2BB58ZfHr8kJ5Qf4OIx2g1MM9W5itaEed
 HTI9hUX4JugO2IHdlzr0uDbRy3RFPIq8azFiR6kvNTwEbrhCTPp7mL+AqTs72np/PxeM
 87UQ==
X-Gm-Message-State: AOJu0YwmZfQDDksY0Cw9WVz1XczUVIAcN4Zvsj16eiM3LxnPKHYn2tpG
 F/Wdedeniq9FM2nFMfpKTceOpeDC5gGUP8Os+BSZByTKWgRT20urx1URkasLADWFeEBhcY/w351
 RPjMSBQ==
X-Google-Smtp-Source: AGHT+IHEU4HEQx1u2F1OleaArbZUvZWfi4hz30CzlZhl6nqCOlPpluUSEUmnMK+J1ZIC3MqFDCIEhA==
X-Received: by 2002:a05:620a:4110:b0:790:c91a:73ae with SMTP id
 j16-20020a05620a411000b00790c91a73aemr1749842qko.2.1714431845465; 
 Mon, 29 Apr 2024 16:04:05 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: michael@amarulasolutions.com, flavia.caforio@amarulasolutions.com
In-Reply-To: <20240417162434.524878-1-andrea.calabrese@amarulasolutions.com>
References: <20240417162434.524878-1-andrea.calabrese@amarulasolutions.com>
Subject: Re: [PATCH] .gitignore: Add files produced by TI platform
Message-Id: <171443184448.1749944.64324703103922173.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 17 Apr 2024 18:24:34 +0200, Andrea Calabrese wrote:

> Add files produced by compilation of TI platforms:
> 
> *.ti-secure(-rom)
> *.map
> *-board-config
> custMpk.pem
> *.bin_*
> *.fit
> *.itb
> tispl.bin_unsigned
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


