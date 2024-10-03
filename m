Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6D8CF34CA
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 22:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2DE888D7F;
	Thu,  3 Oct 2024 23:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="impLKayl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AAD788E7A; Thu,  3 Oct 2024 23:59:54 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BFA288CC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a99de9beb2so80245885a.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727992791; x=1728597591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Sn47kbXkC3M0En+l6P24O4XIyAKBsysmLmdo6YiUvI=;
 b=impLKaylrMZVV8Jn01A4033uwSKfbtSPL2FC+1cH06RlqwmE7ngcCGra9D/a4D6Nwp
 kLi7SlWISk+ut9n4eEfHqclNZiMcB41D2Ui1zo3K2gZFwzm2g2IVNTzdqaEMMO5f5D8Q
 BI9njnUjj6wkrAwdYRujDAlC3vi26fIveTkcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992791; x=1728597591;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Sn47kbXkC3M0En+l6P24O4XIyAKBsysmLmdo6YiUvI=;
 b=LdNArXtwvUyr4OIwmzmbNmi09v3Fc7Kwj9lx3ZlUTdANf+lSjls9Te++uqYGBBB62D
 ZamZpqRyESqJrs4h+Tq+qY7XxDXEwZSqpdoFLZb3LL1RFBtAxXbs//N9zMge7SJ85kFa
 sc9WE2aAjWm/jCQKEdUG8NZd7wZ4+ZfarrblXbQfPitWY2suaVKH6XdF/UI/7HrA4AIl
 wf+UUaGnINY9UpEOhDxV8XdDX+xwBqrz33Wj7IR706dGCC+wlRqLiG0DN/fxu+/Nt3Uq
 wTkujzp6uCld+Ap4MiqH+jSVelY8WsWhRLDGkRPWA8lSfwF+imF06HpmcKqui4qoccEt
 05jA==
X-Gm-Message-State: AOJu0Yw9tB0gSgLqM315ShkjUtnPuvtA6NQkAd+ZevDacMRSZjaqICTR
 ENd/UUch0lz5FUig6TmP2MFGAAl0GOaNzsJskKQd7EfWYGZNbHvidBhUfrLai2o=
X-Google-Smtp-Source: AGHT+IE8FAjwynUNAfVlay2iVA9FBqA6KsiUNzb7N2eRjgFpisfb+hlI4+N5wE5Ru8lM1SBezczqpg==
X-Received: by 2002:a05:620a:19a6:b0:7ac:d6ea:b4eb with SMTP id
 af79cd13be357-7ae6f421826mr112185585a.4.1727992791153; 
 Thu, 03 Oct 2024 14:59:51 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae6b39a72asm82652985a.28.2024.10.03.14.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:59:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>, 
 "Gaskell, Oliver" <Oliver.Gaskell@analog.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
Subject: Re: [PATCH v2 00/18] vbe: Series part D
Message-Id: <172799278824.2108277.1271226953823485187.b4-ty@konsulko.com>
Date: Thu, 03 Oct 2024 15:59:48 -0600
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

On Fri, 20 Sep 2024 09:24:24 +0200, Simon Glass wrote:

> This includes various patches towards implementing the VBE abrec
> bootmeth in U-Boot.
> 
> Changes in v2:
> - Update this to say VPL instead of TPL
> - Default this option to off to avoid TPL-code-size increases
> - Drop the unnecessary interior check for CONFIG_IS_ENABLED(DM_MMC)
> - Update subject to mention that a newline is added too
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


