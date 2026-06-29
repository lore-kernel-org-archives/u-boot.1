Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F02C43327
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E78849FB;
	Tue, 30 Jun 2026 03:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mwMTh64a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348C984671; Mon, 29 Jun 2026 23:34:52 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141BC84AA2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-448cf99c133so508166fac.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782768889; x=1783373689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jx7A4XWFT7vOd/A6ufCF8sVMvP7JzmQuRxnvuNdRbdM=;
 b=mwMTh64abG/jpKkOsNvSzaLrM+9L81bnHLARORivMVoLn8uLFBim5b8Ga82oChaeAK
 gomX2dadBqQaPeNCMIhAg52vJR1ZjVCY09dNGTG9YsNL9NppBj9BGh0Tqfb4KyFojR0V
 QKbKsyHNOfhBmzHDZ5EYMiAGrsv3xcGhzSLfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782768889; x=1783373689;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jx7A4XWFT7vOd/A6ufCF8sVMvP7JzmQuRxnvuNdRbdM=;
 b=UTvA6jskwIYFNJoEppUiBpRlWKlpalbhnxj4F6vAmqfYWwLV44rLvdc88z61yqVNcO
 nJ7zCigpsrDsvn0EuFV8syZIkw8ELcExUqpKPSrKZFalzPIuD+S1Cr8lT4vf8uhtQfCQ
 Oo41p1W7fHCA8ULN5fIW6QNg8DGf+dFnopyAy43WNz4gAWSlr1o/FQkO4iv6Hl04LoRy
 vURK9kTXwYVX4wikxPMyarP5NxLrUSD423WdI5lsSLVEyYGAIPSEw8t+fMTrSKS+QIaC
 84CnVewnlE8ejBlndfP2NJPBwBf2a77yaVKl6jjIGExMPpjppcLKkay1H6ykAOAxurz4
 vQzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vVVqJcP1RGIxgum+VSOP7vy5HaRnoUIYF3vTKG82+qmqgV7znymiUXTXOtI0vpfhlx5bXNV0=@lists.denx.de
X-Gm-Message-State: AOJu0YzYk7c1rjFMnl/1iM/D0Ftns2GjHrMO8foYwK6KLUcYzq8RQXZI
 X97DpaIuoBG5/7uqucnwjHtQnbOAYBceRn3EojggO9mVjbKhcOy4BdfcFYXMJy31D4c=
X-Gm-Gg: AfdE7clSyEiyn11f9YR5eXMmboc1PVqS7CDHniTK4FxDOs8paB9oeTEgfMSfFOCZiIH
 C9SX0HQ7cJ1X42pTTWh+ncV2i9Scfm/EJmy5HLKtHGmaTG3kG6gUOZfnedCHBtZgDtds7X3RwME
 EQNIiKeF1P6FWSyFpNdRcbLS5t0MygzZMHFCQYkptZNRoZzjutJOlUdcZDA4ZkHargCCA2qUmi6
 IZHAqpmYO2Lv4S6MyiIttFs/10XbhIu26RzaPbwQ12qA4IPMFUl7DSJay09onCb/uvJVjJwvV+r
 I/NZLZ8i9I+Y/IS57eGZkPJwfllWhjlJfF5kp7GT/mm5zPWOhUS0M7sONLCYOo7bmmbz1uANzNb
 l865Ae7tFKG4bneQ7jgwMKmFNzmbX4ZuGAAX8uWI9i0K/ogwuo8yJzb0G/F+EIPhAcnDihlLCNk
 Ou7QhBOvkJepYmfikbLDitEGo8zufE0YTsp9hfKCbmPm3ZiJ8lTGT4TS0bJFonQqFin121n/s5K
 TD3z4clS2gxRFvR268ZQOf6Y5EfoJBKsaRis+M=
X-Received: by 2002:a05:6808:1a01:b0:495:af31:c67d with SMTP id
 5614622812f47-495eb8df4f3mr742613b6e.19.1782768888806; 
 Mon, 29 Jun 2026 14:34:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-494c3766f3esm5454697b6e.8.2026.06.29.14.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:34:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Philip Molloy <philip.molloy@analog.com>
In-Reply-To: <20260612-ast2700_clk-v4-0-9bea29cfdc39@aspeedtech.com>
References: <20260612-ast2700_clk-v4-0-9bea29cfdc39@aspeedtech.com>
Subject: Re: [PATCH v4 0/6] arm: aspeed: add initial AST2700 SoC support
Message-Id: <178276888626.793204.9603360436084101355.b4-ty@konsulko.com>
Date: Mon, 29 Jun 2026 15:34:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 30 Jun 2026 03:39:10 +0200
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

On Fri, 12 Jun 2026 17:43:07 +0800, Ryan Chen wrote:

> AST2700 is the 8th generation of Integrated Remote Management
> Processor introduced by ASPEED Technology Inc. It is a Board
> Management Controller (BMC) SoC family with a dual-die architecture:
> SoC0 ("CPU" die with four ARM Cortex-A35 application cores) and
> SoC1 ("IO" die with peripherals) each SoC have its own SCU PLLs,
> clock dividers and reset domains.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] spi: aspeed: add AST2700 support
      commit: 3fa1b49c940fffa5566560d5134f74b063645b7b
[2/6] arm: aspeed: add ASPEED AST2700 SoC family support
      commit: b62b55ba4b2d1cabd6bb0943685c3115f6ee8bd3
[3/6] arm: dts: aspeed: Add initial AST27xx SoC device tree
      commit: 40bf1417bab6363193c0213af011efeb105af2c2
[4/6] clk: ast2700: add clock driver support
      commit: 0758fddb3729b8b4e130f357cf8608ab1f4def5b
[5/6] reset: ast2700: add reset driver support
      commit: 6fb40812ddb846b02d585c55895242959cbb6495
[6/6] ram: aspeed: add SDRAM controller driver for AST2700
      commit: 4a72fd9fb09109857303ca64fd259009e1d4b554
-- 
Tom


