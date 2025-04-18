Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9EAC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2021B83290;
	Fri, 18 Apr 2025 16:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RHab9B2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B97881B4B; Fri, 18 Apr 2025 16:22:25 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3870B83253
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-605ff8aa9d2so231315eaf.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744986142; x=1745590942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUsV4/N+qgB+Z8BEfXWjsI27a0rUxB7OtpOhv9u3MXQ=;
 b=RHab9B2BxmSfsCk3p5ATULkbSTa0GKRsvM3p70lNVGbGVNQreFP2vDH6vjihuKqAQN
 6pa3TGgjbM95dyZRBMgrGQKWBfMK3OZILpNkQrpeY3eLQxd2zkc6ZAIR75IJ1jZ+UK26
 4t1DyGyVA/sknJrM2a6RP5x5zv3Tosb+W1DZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744986142; x=1745590942;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUsV4/N+qgB+Z8BEfXWjsI27a0rUxB7OtpOhv9u3MXQ=;
 b=w1AmqVoLS9fMhc5u/XesM8O8JiwopFrbbi3VxRC8NS5f6toPCAGuBBqXrToGshqPef
 fWsYB0XWDrWTSUfLuFGnw6KdipT3lXguunpWzj3T9pY1y95QIiV1ScsLE1hWrlpd2uMb
 WIWQgAiYS/UG08ESZhAM4H3BmjswtPMjOWINgLMqe1XaAq7nmywcfg7e8/EGsXlqBWb+
 AV3Zs0jMnbWf2dAIb6dLDwf3riPCFSPYDYn4DK6a4kxPaXdyJVicNq0bxhc92ogHH/AR
 jecB5QtbkVO2PXO+3Fl9ciCn86GaFqhmM5vCLKA7Pzx5a9IbTqa7XT0yQiUbZqb9XM3B
 1IIA==
X-Gm-Message-State: AOJu0Yx5fQzyxBedN/Znck/CxH0ZzPox0B7dvYeTwTu9k3Mjg2Cyl6oI
 GRkBc3U9Q8FbTeBUlmYHWjt51skm6CPA3AgNYxUSoLgd8djcnG2z0EpOXWyRkZO3qJ+UvrjCZ3R
 L
X-Gm-Gg: ASbGncu3JrR4LQGpA/UXwmtgB2+y9tLNh2c6FR/CLLFXBGw3ZoEyvyl+9uN0d/xolCd
 1whd9StrDNy9zzOilR/yj7zqgD4FDoRQJUvYwYmn86+zVdzASteT8OBa/LVdl65yNzazrnAyKaE
 Eimlo5ZcYWLchlPhSw691URasArLpSPfsfd0KBAx9+WwS52RSJfze7SQcEt7za8c9k1W3xey/lY
 n0Zz1lq2O4iOd+BziPSFD7wnrzQ/g/W+kujDoLMyDFCctVR3nWGnHaRd1NQRaory8039iPUO8mu
 n6TdnOJ6RYyCwiAU6b9R7BKLRij3FLoCkZoPaKcSZyd3lq+g02lsNmS5SBAz7H4IM/10ONHvD/9
 i
X-Google-Smtp-Source: AGHT+IFRE6gj2wRfL8PHERPydfAo9vAZOSswRrHtv6IgSnLqmnPblcVr05roYWo5UXxO9M19Yk/ANg==
X-Received: by 2002:a05:6820:1ac5:b0:603:fd3b:aef6 with SMTP id
 006d021491bc7-606005e133dmr1200619eaf.8.1744986142001; 
 Fri, 18 Apr 2025 07:22:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff5f778bsm384787eaf.17.2025.04.18.07.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:22:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250411-am65x-sdt-boot-v1-1-5e63b025a93e@ti.com>
References: <20250411-am65x-sdt-boot-v1-1-5e63b025a93e@ti.com>
Subject: Re: [PATCH] configs: am65x_evm_a53: convert to a standard boot
 flow
Message-Id: <174498614067.3131457.12311887640934732570.b4-ty@konsulko.com>
Date: Fri, 18 Apr 2025 08:22:20 -0600
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

On Fri, 11 Apr 2025 17:48:39 -0500, Bryan Brattlof wrote:

> Rather than maintaining custom hush scripting to boot the SDK, migrate
> to a 'standard boot' method which simplifies maintenance and enables
> multiple distributions to use this evaluation module.
> 
> 

Applied to u-boot/master, thanks!

[1/1] configs: am65x_evm_a53: convert to a standard boot flow
      commit: ec43e63206fb6b0b50f114feb074462c5e140dea
-- 
Tom


