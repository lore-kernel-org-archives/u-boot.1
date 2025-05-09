Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45731C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 18:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6576382935;
	Fri,  9 May 2025 20:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aq/iJ3/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7660C82905; Fri,  9 May 2025 20:57:49 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564DC8211F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 20:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso1689311fac.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746817066; x=1747421866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpB6kVAsnXV8HokFQjRn27K3V7SyVG3zKZOI6UIiWe4=;
 b=aq/iJ3/dywbGaV/GkPvE+w5zE+Iup1bG5y6E/TVc6fohW6nUXr61UjQ1IFn9zSfsvx
 EJmgtHASoCl/6x3cfjmE4j7dMartfMwJrzwOYQ27L/CiCF1h8Zm4vu0bNYsFpETIwdn5
 U0dsFHP/1KbSVoGQVeyu7ASRCgurO7UPp1Dbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746817066; x=1747421866;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpB6kVAsnXV8HokFQjRn27K3V7SyVG3zKZOI6UIiWe4=;
 b=J7pPk89WtKaP3f6hEnl1rk+CJGmkVfughXIToVh56YXJmP1VYpch0xPD0TLiYuYuxU
 yQSIQs/y/YsD+zdwT2PTrMTSN504zLyZRcHLDdKRYEpvYs/orDC3iTH5OKGFJukkaOOk
 +Qg/R7VnRYlBGtnRmxREdX9QS+OAywhIvookLlHBBYxYIUL3ovU1swd4QBqNDl9CqONc
 5ttkY/QP5UnZd5fPjU+jiglU635/w9jg9UP/NQXRpWzG583BIWY6QY6++BSmUscQD/vm
 XmuCT8x44X44z9BuXx99jRqk2yFcDgA+39CzusDXY4P7dGqZDVH5ckpUXq7LRaFj3R3P
 BJSA==
X-Gm-Message-State: AOJu0Yz7r2EcrWuFibpfsj4MUWuckyScNlXkNxwRONqIxZpxpzo96DC5
 L7n6vh/5mcEp4Gp+H4azk0Z6XGs62BA7o97rWT0WcQBeuaKJ+hmHYvAXSgbklEY=
X-Gm-Gg: ASbGnctM+dXYBlsTfF4Aw+HD0JTnh1lkyA8FvQIriolCTPBIauxORHSrxNJhH28pehH
 8gI1/J+iJqY/S59wbDLDQFXNNzNtPrz8rtgHtqwMZPcCK6bA0EpGAVuma0eC9JUeLiBAoU066Ry
 XnbGOiE1YreiBOcabuGMZpy97sHiJeTm7ePYLCicWveQgR0IFLV4kpGqCEYh2lpk0h9ovrIn8O+
 q1EN/Nyhkw2MiABRzGlDS/cT7yVMOM70uaAI4Z7+Mh+OhA7QXb2OGsv2R5xtJjN/b+GatWVr8Uu
 eHlgjxMyI9rkARgK2NWgyFuuJl806VYL6/MJ4ygKPbayH3vEJGdIaA2xeyaPtBr737R61CJ3urb
 b8jY3Zo/WM8Q=
X-Google-Smtp-Source: AGHT+IEinhHFvmACrsniL6PIuIas0L3N0enTR2wYreNRPVytvDbTFk++XBCAu1leHEiFzdERDX0BvQ==
X-Received: by 2002:a05:6870:889f:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-2dba455ab5emr3002646fac.36.1746817065861; 
 Fri, 09 May 2025 11:57:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba06e7a10sm721707fac.18.2025.05.09.11.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 11:57:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20250226203115.3831923-1-trini@konsulko.com>
References: <20250226203115.3831923-1-trini@konsulko.com>
Subject: Re: [PATCH] x86: apl: Correct usage of IS_ENABLED() macro in
 acpi-pmc-uclass.c
Message-Id: <174681706430.750074.4591683918940175694.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 12:57:44 -0600
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

On Wed, 26 Feb 2025 14:31:15 -0600, Tom Rini wrote:

> This file was using IS_ENABLED() to test for CONFIG flags but omitted
> the CONFIG_ prefix and so did not work as expected.
> 
> 

Applied to u-boot/master, thanks!

[1/1] x86: apl: Correct usage of IS_ENABLED() macro in acpi-pmc-uclass.c
      commit: 4cc29d0109ec4cb7e8121cab3df565916b0c3c11
-- 
Tom


