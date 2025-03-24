Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6238C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ECC2806FC;
	Mon, 24 Mar 2025 19:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="baZm/Xbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8506808AF; Mon, 24 Mar 2025 19:37:21 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E05780548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2a01bcd0143so6465163fac.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742841438; x=1743446238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBLPs0gVXN/tXllyc7XSzG9XDDUG2Kjz8nIZvA5U4jM=;
 b=baZm/XbxAiJv7x8lwZonhgonBEPf0jOpnypFE8Cqub5SSr3WGaccv0r/cgBd5JO+mz
 DuuDicYxvqzyvJMFEILA6/EZQ3sGo4f9uLzaeHJ5zBFRiUJ4VTIua3tgZsv2d1umDf6D
 qtVxZFwSJp/0BBpdBhsyIympJUsVMvFM1bJ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742841438; x=1743446238;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBLPs0gVXN/tXllyc7XSzG9XDDUG2Kjz8nIZvA5U4jM=;
 b=eFhNUjVdc2pRzZhNYGsZeNTtAlVIMryHY6RV8D+otbET4+8WdqC0rvkvQnbX+VQemK
 0DM31iIWq0gcvlMdckXthUr84IEE1UUJM6fLmQ2mvhUkUpUEKUdLlPBgxuh74tnxQOZa
 sF+44WHhDkSm66rd3Q3cK1k8HfNsPPXAE6JIGhjGMVayG5uVnnfzSN1KtIuGM6toFU14
 i1sV4NoRNpWwt0l8whudqn+aBWnhyFJmi3LKL+2U1Knbt2HwBGG4lc+CiU121bHeqvkq
 EE+30oy3g1nnNjLZvnyZcUsvt1nlf7MuUfoGzYDZepbDZs2R0hzJh4kl4fufHT0sC1oc
 ngsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgu8ibzHrBLbSQF44Uz0MdHr5CkibluoNuqBux4XUmEmTZOWTBD7TVxiYkpahjlSs+lKZmj2U=@lists.denx.de
X-Gm-Message-State: AOJu0YwsTuhFKCsID7f9SFuwO/Si/9X0GDCT+5DzgA/lgIY7kFukN5oC
 tudd8oz7jj/BGVQsh9NS3X34y4DnKKR+BCDT3HvIim8xdphIfShR5pQHwzktZd4=
X-Gm-Gg: ASbGncsfLMaOyByke2EHBgTVeXrBWNdl8l9/vi/3l9yefoMVymMHZWGJQLO70R0GoI7
 3TSfzkbpIPnRZqs8RH1poPn6hMvindtdWV3DpWagJBy8NerIVogwy/SIOtJGvzxB5Evotx5HHLi
 sGznaeZsm7XBP7ay+1pQsMGAPTyniCXFldEvi3zvE9+57LhununxtZojO5FJe80Ei4b4L3BxM1Q
 REDV21igqKTaxqyeS83JrAJnBpepoI2bsZQKDFO78Fv/VyAdGfhnQ/bx5ao8hQEIupZE+19rZBC
 3RnA3K0zpPL6D3M9zWFxMP4FysjvUK9sd4TyZwHIbg==
X-Google-Smtp-Source: AGHT+IH/BPvr0Eo7CCu2/QleBsdi1nQT6gtSpV51+oI4q4GkzhfykM4RCErTGyLH6PjZvG68e+09wA==
X-Received: by 2002:a05:6870:8194:b0:2c2:cd87:7521 with SMTP id
 586e51a60fabf-2c780246312mr9255017fac.4.1742841437672; 
 Mon, 24 Mar 2025 11:37:17 -0700 (PDT)
Received: from [127.0.1.1] ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c77f05de8asm2175559fac.36.2025.03.24.11.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:37:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: ardb@kernel.org, Ben Schneider <ben@bens.haus>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Nam Cao <namcao@linutronix.de>, Baruch Siach <baruch@tkos.co.il>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
References: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] lmb: change the return code on lmb_alloc_addr()
Message-Id: <174284143630.113610.5861951971425665672.b4-ty@konsulko.com>
Date: Mon, 24 Mar 2025 12:37:16 -0600
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

On Fri, 14 Mar 2025 12:57:02 +0200, Ilias Apalodimas wrote:

> Ben reports a failure to boot the kernel on hardware that starts its
> physical memory from 0x0.
> The reason is that lmb_alloc_addr(), which is supposed to reserve a
> specific address, takes the address as the first argument, but then also
> returns the address for success or failure and treats 0 as a failure.
> 
> Since we already know the address change the prototype to return an int.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] lmb: change the return code on lmb_alloc_addr()
      commit: 67be24906feb6efecce70cd5bfdc2ba8f06d3d5b
-- 
Tom


