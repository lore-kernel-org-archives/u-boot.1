Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE142CD98ED
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 20:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971B9848D7;
	Wed, 17 Jun 2026 22:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="paEI/Dy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3A2848C5; Wed, 17 Jun 2026 21:47:17 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A118460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 21:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4877a7b451dso107506b6e.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781725632; x=1782330432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQhwbHYUHEzfrZFP3yTn5Iv5m+QMmOLccAAlGYA3ajg=;
 b=paEI/Dy2O5y0kM49hAjaTUK2r2ROY1YNOJ1HBvU0WJlWVMJDOXBT0fPwDkZESOLke4
 FzsVsKCsZ//Z2bXwnZzeAadXwa8kN6CTHw3nBwQRRYSgQ2asDdSATpYVGmyHu5nGWdxZ
 eN6JwRuBEkwBviuyjq+r1BcwmsdWHyQ1hzmbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781725632; x=1782330432;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TQhwbHYUHEzfrZFP3yTn5Iv5m+QMmOLccAAlGYA3ajg=;
 b=q082Yr4yGdy0FJwj8hu/TiIUn5asI3OhUKkPvSD/77lL3wrOxpytJ3/7kyh01xwStm
 vN+OCFjiS7v9DZDONTkYGkWnrbc/yP9+ym7HYtpRKLQkP24oJ1SQ5nvRW5gn7i1HkDiX
 FIXmujCg/tyUBVKKTO9HeqiE1Xo1r6KEts4KfvnTlV8nnL85SpmTN7wHgaZQLX9IeVpV
 pLkGdXALc9FDZKMRUudk8WlBcxJInc/ePPGdiWSzW2oaefkBGcV98aQPdrX4I/sg/CDb
 9IvSrczR3UdZjWhuN8qW0Kn+6LzOhPVaVViuRstQLmkZ3MSpgLuK+zqd590pdT/Kur/5
 GSWA==
X-Gm-Message-State: AOJu0YxgIHsWrct+ZkpjRF3IREjhTG5jyqkst0obajZH8veQrfACwS26
 8WYnjWUEwEVTZ+OrzhYJQu5PWdnEQ/tEMMGCsfx2oMh8beBp4SL6BG04eRzKI8cnmGM=
X-Gm-Gg: Acq92OEchs+jV3X3tn/nUcRXY293ris+gEGxzTguxWdfdk2FyA0i+3Jub/sXXpAi6Zl
 bAgELfqw3G5eDNY+RHXJXMMFFXsp3tMqgq9vWAw4MmsyzvPYchl/oGXQJ556vnvdNS9og9sqd6L
 wSBPWXNpIbSutVyFb2Mk40h5Py+wmLcyDbCowvSzfnAGvmlz3V1TWJ7vzptQ3RWgWNsLTaX1MHn
 dJRCQ2dEAOfqiybel251h5rWZeHIIBvb5WLdixaio5UQtPQYcNQdEUAlMgGT7YaPgMEnF3JVA5G
 hhMGqiG1wtNp6K6hAnRzdOhNioP4TGebNeCMZ2Leh8dRbyL2N1tnEyBknmbveG2AoFevazcMdB6
 jJ+QdvftiMU22THDYzAO0gOd6s+Z8fqUXc+wMS6sGF7+zoBBZGN45qoZIgbIfdk2d6YqI9CCN94
 CdzUAWnO76uugtlwoPaKTpSuwSDu7hG6gaX95raJcr8OPQILUyHaeFNHfSKvFLBWoCxsw+uYigM
 kBtZ1t2WUuGXoAvFvhbVR6ZK8Mw6L74Gq4OILw=
X-Received: by 2002:a05:6808:3a11:b0:489:47f1:504b with SMTP id
 5614622812f47-4895701b7f5mr664441b6e.26.1781725632509; 
 Wed, 17 Jun 2026 12:47:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4875dda5f7csm6798219b6e.1.2026.06.17.12.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:47:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@nabladev.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
References: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
Subject: Re: [PATCH v3 0/6] arm: omap: Add back omap4 support
Message-Id: <178172562987.2028295.17012196970784373353.b4-ty@konsulko.com>
Date: Wed, 17 Jun 2026 13:47:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 17 Jun 2026 22:33:43 +0200
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

On Mon, 08 Jun 2026 15:11:56 +0200, Bastien Curutchet wrote:

> This series aims to add back the omap4 support. This support was removed
> by commit b0ee3fe642c ("arm: ti: Remove omap4 platform support") because
> at that moment, none of the OMAP4-based boards had done the migration to
> DM_I2C.
> My use case is an old product based on the Variscite's omap4 system on
> module. I needed to upgrade U-Boot on it for security reasons. I think
> that this work could benefit to other people who may have same kind of
> product to maintain.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] arm: omap: Move PRM I2C channel frequency to vc.c
      commit: bc93b4bcb312644bdab114b4601e2db0c8837343
[2/6] arm: ti: omap: Extract common clock definitions
      commit: 9a4f6790967912b1a3518abdbe9236fce5b49dfe
[3/6] clk: ti: Remove AM33xx dependency
      commit: de2e3f00f2fa3fc4c11be48b3ef6af7b0fd7bd33
[4/6] configs: omap4: remove unused boot target devices
      commit: 196b1fe9bf80959648cf54b2e36c08dfd24fc1ad
[5/6] arm: ti: Introduce back omap4 support
      commit: 93d204f7175cb52fa57ebef63a0d940ad5940dbe
[6/6] board: variscite: add support for the omap4_var_som
      commit: 8974dd64e621d3a2c5d2d1fe038bacac35996758
-- 
Tom


