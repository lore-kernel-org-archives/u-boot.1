Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8D4C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A71C87830;
	Wed, 13 Dec 2023 17:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GBpAInm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D2187830; Wed, 13 Dec 2023 17:50:36 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16E278784F
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5e263e43ff2so14554427b3.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702486232; x=1703091032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyOYFfd7ilByF70fY20VO4Z3BTj0CRGg/swc8ZTYBaM=;
 b=GBpAInm55l9NxpXX8Pwpr8dX4FKVleZawhPEksHe9FTqA33YjbcQCG49MRQIi8AKmb
 Q6K2eEUQriHhFxfDa4NakMCHwtoQ4RTfGtMi20kLRdaluzpD92zvBQ3zVpR4rckhR4YM
 rT9ORvc3bAAGz9djNotkJyd1OjngynOPTqJTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702486232; x=1703091032;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AyOYFfd7ilByF70fY20VO4Z3BTj0CRGg/swc8ZTYBaM=;
 b=iRGq1e+jB7ykmEiktUVJHP+aVe67FCnBZoZGgo7lQWj9PhV4CI1LM2I/2RcZD11bHG
 WYlrBVkwP2juJ4hhMLUbQOlho6q9hE5KCUjM1QMCzKYjy93/+HHlrnTcPotnD+EMoec6
 6R8N08vrlG0FU/foVYo5irvXgM7/0WAkexL1MTBIH+pZx+37kYSxqIhhvvGYoSC3b0UV
 xAlPq2s26hBA2MCkbUCy1nR1G/HrFA6y1R/engB3AFk08uw5QgBMoMLpi1zoIHfstctZ
 cYxPhaS1emrahtXs0Bu/n5hPGsiFVkAdqQcXPrSZdgBs61g7Kwlas7SvzmBYlF+lCJQY
 HouA==
X-Gm-Message-State: AOJu0YzQvqHkBUpc+rsxlaLIKY18EaeZxqLKWHGZ0RmmL6TNnMEothhg
 sFf/R260Qix5olmAvnJyBNF766szYj15kcPm0Es=
X-Google-Smtp-Source: AGHT+IHXUuGoE8118MQxo1Rx+vvbNkQPt66/ix7JiQhAcdNWlvJuQ27jPEP1JSlypLgwrEZV9aRdHQ==
X-Received: by 2002:a0d:d203:0:b0:5d8:8922:f560 with SMTP id
 u3-20020a0dd203000000b005d88922f560mr6503060ywd.79.1702486232488; 
 Wed, 13 Dec 2023 08:50:32 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 v190-20020a0dd3c7000000b005d75bce5836sm4781799ywd.28.2023.12.13.08.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 08:50:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marek Vasut <marex@denx.de>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Doug Zobel <douglas.zobel@climate.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>
In-Reply-To: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
References: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 0/6] some LED patches
Message-Id: <170248623185.2217435.16173809669522136612.b4-ty@konsulko.com>
Date: Wed, 13 Dec 2023 11:50:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Fri, 17 Nov 2023 12:38:05 +0100, Rasmus Villemoes wrote:

> I wanted to add support for ti,lp5562, and found an old submission
> from Doug. While trying to modify that to work in current U-Boot, I
> found a problem with the "move label handling to core" patches.
> 
> Patch 1 is a prerequisite for the ti,lp5562 driver, which turned out
> to be needed by Christian as well.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


