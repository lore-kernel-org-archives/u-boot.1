Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9279C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 785D183BF1;
	Thu,  7 Aug 2025 07:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZxHAmx2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6723483BF1; Thu,  7 Aug 2025 07:32:42 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B9B83BC9
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bd6e84eddso816712b3a.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544758; x=1755149558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c7TZZFdahogjAI/k+arCl179QzWpwb/O0uS5R95t4oI=;
 b=ZxHAmx2IJAhMASmhUbSODsqz3B+OEJqBpxGST09A6qjeA9oncZx+GLV2WfIGOwX66R
 U8ut/kyhA/sHzAr3gLY9gIjavZa4nh4oMQk/5B5aNp2H8EFA4xKvd/iTK5FwwjNp4WiK
 WmSgRkCZsnxzDWo6hTGreCBg/7nGhOq8OnwAgx4rhB1gtPZUhuRFxo8qNdPbEplnJtfg
 QBdQ/vlYtOhIILB/+KZY5FR7jh0y9FoyhkZfOIKXdOUFcfPNqjTpdC0OgI3rH2h1y1nW
 St8hz+bfVYXCyVGwKWpf9OHlJqbRtZR2evshoL+kg6EduboBJBUJMmgeDDRcHcU+8xiC
 iWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544758; x=1755149558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c7TZZFdahogjAI/k+arCl179QzWpwb/O0uS5R95t4oI=;
 b=rJRoqIb+q9Dsy8hROt23lXub+SY9PtFJrasmfPPbr2TypTl8GArdZJuGkUk5OjCLrU
 5eVp5fxvhWDDSu0A5jKp1+VhHrBNfmSkxvh99pP/06SRqdQrvMo2S4Um4tyM0dzRB8v/
 H8tp2RzweaWIZSc4QGPvAqoRiHs2z5xvEpZFJb33sHuwHgbjZ9Lwd7gkZC0OTy585kNI
 kLivT3igHhoXH3Hbfwyhxgjskm7UY569SeaitYZotMXxVYL3X2lADEbVqeLRcZUI8vSw
 iOJDrH/MiOJVih+89CDvzGjXBuI6kLod68CSYx6n9MCjO7Q4oB4W5o8RSVlg/Xca4mLt
 DEjA==
X-Gm-Message-State: AOJu0YwFxFb+Q9OruF1g7EZfsGpubEzvFHH0eBwhQump0qnfrm5OUOaU
 MTfYlUnDP3tPsTm50h1AISw5A4E6gZvmS24FVIB1Hddbmtum7fdB3cCz
X-Gm-Gg: ASbGnctGVf86Z/szrcy5BReM+8mJ+dZLAj8hYnwREV5nNUOIFEwrNvSoTZP8P8sPgsu
 od04vAYOoRgonSrJPzwvD7STOD3FZTDl6uEbCEEiWwZ732mqj0hkTua1FaMuoxMZKog97v4zILI
 cGtpZ/7lKQrZNHgpwYUmSK8DYXKNjtazntpJsAkx/FA2deCDuu3tRNA/89OW/LkT9694loZKA+a
 WPPJL12426iQWUkNmmrwp05d57hO7JZ+eVPTb/QBw34YJCU9CkJDeHNSN4mmfOzgFLOwkU60eYD
 UyZeCLNQppa72iT/3SuUV6SYhBhJ/s07YGq+yGqiTlr8PlDnp+mLfow8j20dXnoBJ9YAJ3t/dXr
 0pGJdlug8Fmx71X5mnvgXf+XbfxYgDndgq2OTWxzKZRnO
X-Google-Smtp-Source: AGHT+IE6kHW8NNoi0GHOVn2PUvOcAmkG8e3Ypm4ICiyEJbAu+chuhEsotsqrB1Sd7ToFQlN6TZwp5w==
X-Received: by 2002:a05:6a21:33a1:b0:23d:d9dd:8e4f with SMTP id
 adf61e73a8af0-240313b0efdmr8228206637.28.1754544758179; 
 Wed, 06 Aug 2025 22:32:38 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3216126c98fsm4384084a91.21.2025.08.06.22.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:32:37 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/7] modify npcm7xx/8xx feature and bug fixed
Date: Thu,  7 Aug 2025 13:32:17 +0800
Message-Id: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

modify npcm7xx/8xx feature and bug fixed

Jim Liu (4):
  arm: dts: nuvoton: Change timer node
  misc: npcm_host_intf: Add Arbel eSPI workaround
  misc: npcm_host_intf: Disable pending KCS/BPC interrupts
  configs: npcm: remove CONFIG_SYS_SKIP_UART_INIT

Stanley Chu (3):
  arm: dts: npcm8xx: add pinmux for VCD input
  pinctrl: npcm8xx: add support for setting VCD input source
  i2c: npcm: fix consecutive dm_i2c_read/write error

 arch/arm/dts/nuvoton-common-npcm8xx.dtsi  | 15 +++++------
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi  |  4 +++
 board/nuvoton/arbel_evb/arbel_evb.c       |  9 ++++++-
 board/nuvoton/poleg_evb/poleg_evb.c       |  2 ++
 configs/arbel_evb_defconfig               |  1 -
 configs/poleg_evb_defconfig               |  1 -
 drivers/i2c/npcm_i2c.c                    |  7 +++++
 drivers/misc/npcm_host_intf.c             | 33 ++++++++++++++++++++++-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  2 ++
 9 files changed, 61 insertions(+), 13 deletions(-)

-- 
2.34.1

