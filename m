Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082C0C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 23:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31FC888B22;
	Fri, 19 Jul 2024 01:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z9wxcExA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E236388746; Fri, 19 Jul 2024 01:10:21 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21EF885F1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 01:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d9dfc7c5f6so661630b6e.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721344218; x=1721949018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5vYDx/Q1akqoqQPejZVNbMZ1gWumiU1VqCs0Bifgd8=;
 b=Z9wxcExAx2X3Y3mA5cGAU5jjNjuL6ZzoPYgSZeNgPkZYPLQ2V7fbqngUpa3dpif3be
 6vSrP/2cO0wMpFrHM3fZX9ueu5ZmBjTiDfymzwx7bmJfN8efvVUevxO9EAh8nZ1DK/MI
 JEJxC0hKA4SbO9K+nCtf46SzkKdHOwbas/4gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721344218; x=1721949018;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5vYDx/Q1akqoqQPejZVNbMZ1gWumiU1VqCs0Bifgd8=;
 b=VG4Boa2ngFnIIMivqs9vhSChtJTtIxEcgcEOCzSX6V3QXQzvLQJIzeHXxEo7RzDttR
 gYSwolEZA2OiFEnCJdaaVIE+8n2Cce/5tY7dhbzHrcyeSEc1IBBU+2obIPmm3xXvsDw7
 KwammgUJRekK0PyJ7scEdwmxJ1SIpgebLpogeDh6LLWJ3leH1u07WHlS3MjKLQVU9Zfb
 ergkZs/gVNDyhBfsvi0nZQOGS9wo1kw6c5eXdw4NWs1cn+Jcjwg8pEIZHT8yVHZUtvfu
 jphEpQD5cnYTnZrW1Lk3U67M3Fbv6zUieRJsZJv7FcmYXq0xiEKUzv45Y97AMGlttYBw
 kUGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF0zNPXDKMIDb6183siGUc2augvMvwvdkL10KqqABDm9ovLZzvv2naYOOcXx21+mcwnssebIY6Cx0Vxk7oEj+vNRqsvQ==
X-Gm-Message-State: AOJu0YxAeZhq5gD1Qrlb6mHnd5z1ET/JO4VpLoGHRAxzI5xJumnROg0m
 C4i403Xru2+xsapmi2+jSy6pk+PdzUKsbUBe4WYzcl1ZaBb08Vw/l2gba70rLX8=
X-Google-Smtp-Source: AGHT+IHKIHYbyB8yXBPKCkTcaR8OAZ5uR1GfZWhkVQISNJ/wtWgtL2Dza23z2LjLwsy5wNNMfjmjhw==
X-Received: by 2002:a05:6808:2181:b0:3da:a48b:d1e6 with SMTP id
 5614622812f47-3dad51f2ef7mr6261199b6e.16.1721344218600; 
 Thu, 18 Jul 2024 16:10:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae09ce8aasm55128b6e.45.2024.07.18.16.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 16:10:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
References: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
Subject: Re: [PATCH v3 0/5] bootstd: Add Android support
Message-Id: <172134421771.2776895.17285970503833035551.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 17:10:17 -0600
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

On Wed, 10 Jul 2024 10:40:01 +0200, Mattijs Korpershoek wrote:

> Android boot flow is a bit different than a regular Linux distro.
> Android relies on multiple partitions in order to boot.
> 
> A typical boot flow would be:
> 1. Parse the Bootloader Control Block (BCB, misc partition)
> 2. If BCB requested bootonce-bootloader, start fastboot and wait.
> 3. If BCB requested recovery or normal android, run the following:
>    a. Get slot (A/B) from BCB
>    b. Run AVB (Android Verified Boot) on boot partitions
>    c. Load boot and vendor_boot partitions
>    d. Load device-tree, ramdisk and boot
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


