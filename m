Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAA9CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 21:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2627786AE6;
	Sun, 24 Sep 2023 23:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oy+QIJfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E997C86AE9; Sun, 24 Sep 2023 23:14:41 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E321986ACC
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 23:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d7f0a60a159so6019485276.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695590078; x=1696194878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zW1VnZjjbuM6+jbGeEpZEc1G7ti+Ppbr5bxANNd1w0E=;
 b=Oy+QIJfwsdkxOTM2KmkanXibF+FpP25unPfZDAkphL5fUZzT1rjL0IioxzcEjjGP6x
 EP2iVBrxaQLHsgZf1kInVt3BPsEHDD9DPUvZ3qH8obA+uB5lH+IjZ0nv2gNE3SpWu/gz
 Etp47fiBw1UTCGPdkfXvfN5iGxxjZfj3G5xfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695590078; x=1696194878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zW1VnZjjbuM6+jbGeEpZEc1G7ti+Ppbr5bxANNd1w0E=;
 b=ZvVabLRj3YNYx6+8C9jRXK6QHQR/96qb9dBOpRhw2HyxAry3sEYKd5xMLjQxY1opnm
 wNsdMLKhY4IHYqwL3N0K9m5kMsZwrccs4d3+z/pEo4N0sdkl1ErhmdgBTq5xK0ub5YeG
 6kZsX/G4bJ3LoLHKTI9BFsw8k1QFQVeIp3i7+K2rHNUpaHeXaPqhNI3hd1oV3KQXreEL
 SHYELcgYCGJ8Uuay+K6Cp23TH6dfjs8+hHur1zV/hvXMVnk0NM3Aj//kiNNu8OMRG0bc
 rySS6PKBrrgGM1DHDYQffv+C43MfKrZKJONsIk1Z0nbYjEUgavoEcJM0XAfEMXLDf+NP
 NEfA==
X-Gm-Message-State: AOJu0Ywz94INLTNsK3SzuHJPprfgQRwyJV5s7BvW2ypCJ/rb8CaemmJz
 i3zxeK/CZ9hKPi7XJeYsk1xVOzgavzFqBKQx9TsYVA==
X-Google-Smtp-Source: AGHT+IEC+/3Af2A4N5HZg7hidgCKdFIS6YVYfM17fD3qwJ8jN0wzSYMfsZKcr21hL6IHLJ3Wt3FelA==
X-Received: by 2002:a25:374f:0:b0:d81:754a:7cb8 with SMTP id
 e76-20020a25374f000000b00d81754a7cb8mr4069616yba.65.1695590078491; 
 Sun, 24 Sep 2023 14:14:38 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 y189-20020a2532c6000000b00d853795d3e6sm1910167yby.9.2023.09.24.14.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 14:14:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] common: Drop linux/printk.h from common header
Date: Sun, 24 Sep 2023 17:14:36 -0400
Message-Id: <169559006560.570255.3044474542070146582.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915002147.797352-1-sjg@chromium.org>
References: <20230915002147.797352-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 14 Sep 2023 18:21:46 -0600, Simon Glass wrote:

> This old patch was marked as deferred. Bring it back to life, to continue
> towards the removal of common.h
> 
> Move this out of the common header and include it only where needed.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom

