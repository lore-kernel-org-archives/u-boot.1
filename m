Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5710FFF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E0084129;
	Tue,  7 Apr 2026 21:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="by8Wk96e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28610841DA; Tue,  7 Apr 2026 21:50:26 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA44884118
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67e0d3f288aso3418337eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591423; x=1776196223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/pRJklR2dZeBYaavXN11w8ILYm5qXRPGvGoH7GyV64=;
 b=by8Wk96eKigvF7FZhl7PKXaSTP7m3VouSKDL8PSUcB7JyiQyNQsnmGHispYwyHH/jn
 3KuIWMZROy6L/YYV2Tg5dP4iMkAWcSwOdEFICYQps1hBlYp1wdMzHj1SrMbqdkzYJ7zH
 Z+Pn/ps93DsS7Vj61pJbJhliaPJ7iZPedFeqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591423; x=1776196223;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1/pRJklR2dZeBYaavXN11w8ILYm5qXRPGvGoH7GyV64=;
 b=OPEzWCD7+UcxHD5RZO7erdxKMO6au0wzl3AWrLX3MYcInCKAlBr8f8z2oqacdTzXhY
 y7oVNmkSiR9IZvFoTO4cnslY1Bo7wPmuIkbkjvXu6WRa1cAI31mfGFo/qGZa6B0QKiyC
 jZLTvG6whxRIWT/lQ2aLWzDRoZGxJ1VWRsd/+A0cSCL8gj2gRdpiuSXi0HI4yJ4UNtON
 8wlCoPW6C4WZD+bqj8Vpf3w1jo6yy9WatbdCEPT0T3MPFUmRH1SiwpLw7CQQ+oZTKR+R
 2ChHvPexnB3UGwDFsSeXftUCvqLtLr/p75zdaXhvSpCVxysxC8+yresfLKwRfPxhBunr
 0/jQ==
X-Gm-Message-State: AOJu0YwrootEk0s/2h20x7QjDhwDedKg+LM0yKmJZPcuOOg9TWbK+UaG
 PtkJssFfZEK1mtU/fQDecxAIGi7ZD833GqfXuGNpSyfBNRpVds1LEXKNTmhIxaG81po=
X-Gm-Gg: AeBDiesDl31BUloPNPfLCuG0c35z5i18dnBQNJOsYbhjdIiaq94k8yz4dGjpDprtjGR
 /Ny2St2Y9ydTrG5CRURPS0J1edV1niza2Bki9LJvT++p+AU9hEfHgcHHDrE5ClFF3YLfBy5VfRW
 kPSHTjjeNvf2pkVdRaKgo7+jr/h2+FkQMdP1xDwPWtl0n8yWkdIM1vRwtrIG54W9Mke1A6dQVlC
 Wx7UFHJQN5VunSIWdeCsKLih13dvmKrksXOL0AE9QbB7hyT2K+cMZQK4jP00DLrzsotuIr5GiZr
 itO2hjkoUJecmytadw90+XHb/lfgpy/cqDV3OQLN/KlajO2zapJBgDCzFm3QO8sLq8cK9hLVMTs
 afLq6x8V33LwAXBRd09zlR1XpX/hVMuY3CKyA7kbNURjGxM+jPNfFkebMiqN3rjCEqqZO8j+Rvm
 MgTDtLVUbhwu09EXpT6KdCEmlkVxuePpgnlKuSmnKPRuWrc+jTbhgz10en2JtS6xLzO1USbtjpc
 2UsJjWYfVjbp0Gv6fX0lB8AmU4aIip2HM/bxg0Q6hcdSP4=
X-Received: by 2002:a05:6820:993:b0:67e:3f0d:422a with SMTP id
 006d021491bc7-6821d238445mr9229320eaf.8.1775591422665; 
 Tue, 07 Apr 2026 12:50:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Caleb Ethridge <caleb.ethridge@analog.com>, E Shattow <e@freeshell.de>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Yao Zi <me@ziyao.cc>
In-Reply-To: <20260324100921.1783280-1-philip@philipmolloy.com>
References: <20260324100921.1783280-1-philip@philipmolloy.com>
Subject: Re: [PATCH] arm: mach-sc5xx: Align header paths with SYS_SOC
 convention
Message-Id: <177559142061.2108693.18115222269413056131.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:20 -0600
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

On Tue, 24 Mar 2026 10:09:44 +0000, Philip Molloy wrote:

> Define CONFIG_SYS_SOC in the mach-sc5xx Kconfig. Follow the standard
> U-Boot include path convention by moving the SC5xx SoC headers from
> arch/arm/include/asm/arch-adi/sc5xx/ to the conventional
> arch/arm/include/asm/arch-sc5xx/ location. Update includes from
> <asm/arch-adi/sc5xx/*.h> to <asm/arch/*.h> across mach-sc5xx and board
> files.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: mach-sc5xx: Align header paths with SYS_SOC convention
      commit: c98bf0533be6479f6b7d973b2419e9c4b7181456
-- 
Tom


