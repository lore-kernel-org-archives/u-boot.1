Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5A4CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 23:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1656846BC;
	Fri, 15 May 2026 01:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tGF+Qhxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD220846AA; Fri, 15 May 2026 01:15:55 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE7DB8469A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 01:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4756e74f8edso6770754b6e.1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778800552; x=1779405352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dZEsAoaZzF68dr3KS1IQ9u82NSgnMXROqukifQU8Vk=;
 b=tGF+QhxgHhn9hdCxbCgbzziQX51cKzqe+Xcp7IjqhLHVbeyalCJ6NA0uTNDgatf56q
 PS89G42sg8tM8CdDwqV5QMjp8dCLg5dZo/RarL80b8BUOsVDHj1D+AT6VhC7BCA1cTHX
 9ntxedcHkc3MlSfCTCikDBnbj2cnTB9+rHASA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778800552; x=1779405352;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/dZEsAoaZzF68dr3KS1IQ9u82NSgnMXROqukifQU8Vk=;
 b=Lou4p/t7/kylf62m0ZiZ1p4kNDnuCM24/pfukOZ7kSItTOZ0rn9t/sD6ABKGSQMXxi
 B44jf+MoUrKKE2xpxE1B6UccOOuO0F47dFlCtwzCnvtEzRk0KDxbJDgg1EU30fMKUzVc
 i/GbzA1dmKbZh4IJCrqDbgWFUD1o0+/UrBtLkP6PcvZy4PcBmtqdLCwYXd0WjgBKEHGX
 mz2xoGCwF7SXdkrvgcD3naIeWVp5cGRFHhcdHv7N8BIYlraflzGthqgkN7OVHokvCfDI
 e5dnAdkuE/i4QF2uj3IsrpJSQVZFJcF/rqAq2Le65/bS6n3G6tCQam7YpHd4x/tuxdPs
 zyAA==
X-Gm-Message-State: AOJu0YyEcGl6qjrk9rQcmClLLm7bwBCiCppHDdCvyqNLK4/7LL58siQQ
 8G2siIS2r3whjrz+kVaAAIV1Xnrf4wJuSh19ZERgtkLb57Wu7TcOqfvQL16iNl+B3Xo=
X-Gm-Gg: Acq92OGmyCqrqPZoacuyWBr1enpTNg9ewMMEnIbgOUrW7WSZbXNBK6KFOL9hWA3d4GX
 CBngDjSIIYXAU72eYZL1U/leW5Js6F89vZcStVMLSXbLS72ofbYuLZDw7fcGwvIItf3PGHlFOXv
 A7gI9xr1jdC64AukwD7ZMFIP2mR7cVNOP0m0ouiav2Id1mJgjvEqTFiPb8b2Ir2fJjZAhY3oPPt
 pA874a42YnyLmmHWCc8knagTINdGI60q7PMZSh0WAYB/2KqMyTyNKzxfHfXj1DJngfoofo8FJz4
 DYsse0UlXqFS8B4Y7cSa/Pe4RzoYdJErLr4apGAYquIHeUzLZVGflPO5uLh5IbqActIfO4EWpuF
 oqvgmssuk6+GUMMWJjPccO4zUaFbe+AffT4PdEV9yLi00NlG7O5gtfUkpzviW3aTm2Zf6ET91g7
 ST4l83lM5+nOg6Cs0LtnDH2vu7a24Dn3hR6a3AM7szTa0Gyc1n0GXxI8VhysP53YnOLZU4eoXgG
 cZHcm/2EuuQvQEOWMG2M3hf3N6sFYzwFiCnAAPVNrj+nbDWVDjvO3waoQ8ksh/pKEX0jx8=
X-Received: by 2002:a05:6808:c1e4:b0:467:1da9:2b0f with SMTP id
 5614622812f47-482e576236bmr1215716b6e.34.1778800552422; 
 Thu, 14 May 2026 16:15:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc144b86sm3020885fac.1.2026.05.14.16.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 16:15:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maarten.Brock@sttls.nl, pbrobinson@gmail.com, 
 quentin.schulz@cherry.de, kory.maincent@bootlin.com, msp@baylibre.com, 
 ilias.apalodimas@linaro.org, sbellary@baylibre.com, 
 romain.gantois@bootlin.com, Parvathi Pudi <parvathi@couthit.com>
Cc: pratheesh@ti.com, j-rameshbabu@ti.com, praneeth@ti.com, vigneshr@ti.com, 
 srk@ti.com, rogerq@ti.com, danishanwar@ti.com, m-malladi@ti.com, 
 krishna@couthit.com, mohan@couthit.com, pmohan@couthit.com, 
 basharath@couthit.com
In-Reply-To: <20260507062547.1570033-1-parvathi@couthit.com>
References: <20260507062547.1570033-1-parvathi@couthit.com>
Subject: Re: [PATCH v4] board: ti: am335x: Conditional MDIO PAD
 configuration instead of static for AM335_ICE
Message-Id: <177880055073.4123088.765364678315601902.b4-ty@konsulko.com>
Date: Thu, 14 May 2026 17:15:50 -0600
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

On Thu, 07 May 2026 11:53:49 +0530, Parvathi Pudi wrote:

> This patch removes the static MDIO pinmux configuration from
> rmii1_pin_mux[] and instead configures the MDIO pins conditionally
> during board_init(). Previously, the MDIO_CLK and MDIO_DATA pins
> were always configured for CPSW in mux.c, which could lead to
> unnecessary pin ownership and conflicts in scenarios where CPSW
> is not used.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: ti: am335x: Conditional MDIO PAD configuration instead of static for AM335_ICE
      commit: 55e767426ef6dc59d40eacc89dae6cdee2c582ee
-- 
Tom


