Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B43CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DED846BD;
	Wed, 20 May 2026 22:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HZakqPRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89E9A843B6; Wed, 20 May 2026 22:13:11 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5728984659
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6949831a7bcso3046261eaf.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779307987; x=1779912787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b/MXY/qzqBeuqTcNbQgH8uuriLXTZcLq0mVSSl/pFXU=;
 b=HZakqPRKYzUaGJofFkWW87qjnuc4M2TpZbNwHt5zf7IPdGHIfdFpH/TJTtJ6E7DxEb
 UBTC9wtxSkSFDEFsMisqqu6IuCCfYUq1RHcrZZXxZdYkJmugw+WRa6crRiRs/5L9NZ15
 rHbOIyfcWBo0LrFEe8OEoTDEqMExu/u+T2oL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779307987; x=1779912787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/MXY/qzqBeuqTcNbQgH8uuriLXTZcLq0mVSSl/pFXU=;
 b=fQdDYWBhZ5mpEiFdUlqRbRD7/oE2R80EjQqa6HvhFLr/mgb6m6PumGMyUaoXIw8/Wf
 4AviOvGdqR8UWWWqbNJ9cZp0YOnL2xszEOCxgZIGRgzQE6E+QKUk9FP+qVcS/l5JLznh
 F4KxK8qYuc+IXIQkCNByfBzleKx97xhUZnu80jK5atzm6S6MnU/7NYT7HOYBmzCBlkZY
 ztuQkSdAD4XuQd75EcykDqguWo/uvwbAa0pAonUWWO9+WCiNmAXCG2DoV807KfINwPtk
 5uVR5A1AvkKOiLIa1uwKgQUOrdlAY/J2mNiH5cUxiFVaOUyvrq5FKsFgKKm6ojW0qz8M
 eo1g==
X-Gm-Message-State: AOJu0YzNDFbyjxE+ccnv7X58ngpPw1zRdSsCJKFxPWqd0h1ZGP1TZUS8
 qnWYj88fh3P5r15Ie4W4xOnc42447ISN2kz4HosrxXsCr7BMfdBUjZhiro45sVReHhGolRCN8B0
 CrwdDyD2l
X-Gm-Gg: Acq92OHY3/W+893DXcK2d6VcmEbIwodVBP3y55vnv7c8q2Q6vhOkoQxhLcVnnuncBEw
 ahOaJwFxOrAYMrCDdi1TlECpP0vYr0IN0p3VHRYtE6Ah6BWNTE8qPoeUcyI2LNgVjoEcJmBSH9U
 5GIQsq6UdTbDquhLOZHku2wdPmq7HEBjo9CsotvUbMEBZoj/cyQmPxEdREZObLOllc8AFuHV+Gf
 tekup+OLOvpX5Dhd4WGYd52r8yz9rMAp4i8wtB5Gz/3gh1csU8VFpEuPv4EvJNnaGFezPkkv5oP
 mERtpzNuuVNYL9wO08nrkbmLrVwbNsW0/BO/m/uEjVZ/luk8/J+zmGnOWCGNYfBMOELzXWkturc
 EW/nL1nZ2QjnjxPoDUSNMQKzA9edd1aeXDrur32VpJSetXNKobQxFk3eD5Bo0KK8aKcvtJHBd6y
 JUlKjJWgcoHvTOMUETmFD05QXKU+jU
X-Received: by 2002:a05:6820:821:b0:68e:314a:aefa with SMTP id
 006d021491bc7-69c9437d9dfmr15368557eaf.28.1779307987056; 
 Wed, 20 May 2026 13:13:07 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d045e6fb1sm8862051eaf.2.2026.05.20.13.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 13:13:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 0/2] Convert env export and import to use getopt()
Date: Wed, 20 May 2026 14:12:12 -0600
Message-ID: <20260520201218.3752042-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

U-Boot has had a getopt() implementation for over five years but it is
not used much; most commands hand-roll their own argv loops to spot
-x style flags. The env export and env import sub-commands have the
gnarliest of these parsers in nvedit.c

Each one walks every -prefixed argv element by hand, opens an inner
loop to split grouped flags and tracks a counter to catch a repeated
format flag.

This short series converts both sub-commands to getopt(). The mutex
check for the format flags is done after the option loop, since it is
a per-command rule rather than an option-parsing rule, and the trailing
positional list is read straight out of argv from gs.index onwards.

There is no functional change. getopt() stops at the first non-option,
just as the hand-rolled loops did, so options still have to appear
before the positional arguments.

Each command gains a 'select GETOPT' so the parser is linked in on
boards that do not already enable it.

For firefly-rk3399:

  03: cmd: nvedit: Use getopt() in env export
     aarch64: (for 1/1 boards) all -45.0 rodata +27.0 text -72.0
  04: cmd: nvedit: Use getopt() in env import
     aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0


Simon Glass (2):
  cmd: nvedit: Use getopt() in env export
  cmd: nvedit: Use getopt() in env import

 cmd/Kconfig  |   2 +
 cmd/nvedit.c | 186 +++++++++++++++++++++++----------------------------
 env/common.c |   2 +-
 3 files changed, 85 insertions(+), 105 deletions(-)

---
base-commit: 87ed7fe45c76dd78094a2c9a4953676b4b7ace6e
branch: clid3

-- 
2.43.0

