Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBB1C61DCB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 09:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F34383D17;
	Sat, 21 Feb 2026 10:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nz6nRB/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A1F883D0F; Sat, 21 Feb 2026 10:42:59 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8732783936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so26136395e9.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771666977; x=1772271777;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9PO6pVCLnxYeObBpmYmSx5Qlk/y9vxXwkd9KZsfV4mA=;
 b=nz6nRB/crfLdKbLQnLZLt24wg9T+E/FDG2z9Y5MFlNgaYRWFB1Nc7PIPkrg9Axg+qt
 B2FMlt56vTkCIBcH4R3UH5LX8Lf/3TBh6Zi3LSgjwSIS1sf1VgDNInPf3tP1ejpZPYhX
 ODVuHZ6tgnok4oY0SageoL2vCC9r6o71/6lOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771666977; x=1772271777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PO6pVCLnxYeObBpmYmSx5Qlk/y9vxXwkd9KZsfV4mA=;
 b=sH5CwcFcWTWbi1YfgTgun7Toa5veRW2bSxN9w/CUdke3FNt/pznU2DWEngPyAQmbvk
 2/Irk9OISve+v2eBuME9OV8s++xynSnvtoKQBV/lrBlF1a4hXpWoF0ZNis1ECGdmQyAf
 4rDr1yX7ETEB5DdCy2ljWaF2gZRDO0G4r7SkhDXzNCJ9iszhs2eU7HahIbMlIEZ9D54s
 0qfxr21PP0cuAEgf6AP2BVDotWcPtIs/d7vdu+DJJ7GDGLi2Kl+noYTDYXfFCXFuY1qK
 aa7nw/ekfsr1BIEG3hWd39am2cG2owokxW+cRGyvlBKaDRcR3YohI1WXv7VZ58LQ0X1j
 VvCQ==
X-Gm-Message-State: AOJu0YyCTkoSWm9SgFm0ejKC1cYCfq0GCQZuuaHCWfYOCA5dDvod2qv0
 +7Rodi2tnqjAr+Ra/PRaD4OS+hMZOBRKUvT2sjvR2mGsawhitkeA2Qn9IZZzEGv6s1dNFvlckkI
 iX/4U
X-Gm-Gg: AZuq6aL7pL9hFTns6BRtuhLG4UAnMlW9RXAzVf/VUon1snfQ8XozSTHy0PVB17am/tE
 wqv6mREYQatr93hsk2zs06C8SmrGdVzsYa4HsEtg7qZxx31DBuFXCckUjHzWW++CXmtkF7wfhEB
 6tBjZQ9qxWkLg6Gh4kYFCAoom23L8ljLSHgiXk+B/nbGPmkScl3QaW7ht9E9K6MlKOEhdWAPSqS
 COytPaMqDmJikqnxgSWJDXn4sD8WyICfKPCh4xh4sgBOfvZRFktOWI7q1KCQlkr64gkzBzftPGi
 I5eKxDGYvtFopmjgzplB6nBX9AUFhZv0EcdQpBgjDhcTTFC4QTU736Q9LaDIHLK1rMzHVFQ1PXc
 nFyst45wC2HJSNxGEvJa+5ybo4uPOK14Pa+6UrgwXxYqjJigOscO8QtN8L8D75iJ16CDHFDtqlU
 G2Pr57/5zQjVM4Gy0g9830DmFFcBzmJHH94hfN/HwcVY3DK8ojh6bgD8x6DTbCZbFwTBowdbDUM
 cBHzeyItTKrC+IxAlOPscdUhmqE5mn1MuIt4LK/KVWEpiYNWdizhft/j3SVQjJQkJcUg1TeG4sF
 cVCFXbU7Tw13E/4HLozsldIc
X-Received: by 2002:a05:600c:c4ac:b0:483:7ce6:1efb with SMTP id
 5b1f17b1804b1-483a95e252amr36537005e9.17.1771666976743; 
 Sat, 21 Feb 2026 01:42:56 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f3968sm42694225e9.19.2026.02.21.01.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 01:42:55 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 0/8] video: support Rocktech RK050HR345-CT106A panel
Date: Sat, 21 Feb 2026 10:42:14 +0100
Message-ID: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
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

This series adds support for the Rocktech RK050HR345-CT106A panel.
The initialization of this panel requires a 9-bit word length
configuration. To support this, I have extended the STM32 SPI driver
(including support for the STM32MP25 SoC) to implement the set_wordlen
operation.

To properly validate these changes and ensure the SPI uclass correctly
handles the word length propagation, I have also implemented the
corresponding logic in the sandbox driver and added a dedicated unit
test.

I have grouped these patches together to provide a complete overview of
the implementation and its verification.

Changes in v2:
- Rplace tristate with bool in drivers/video/Kconfig

Dario Binacchi (8):
  spi: add support for bits-per-word setting
  spi: sandbox_spi: support wordlen setup
  test: spi: add sandbox_spi_get_wordlen interface
  test: dm: spi: add testcase for spi_set_wordlen()
  spi: stm32: clean up buffer length assignment
  spi: stm32: add support for bits-per-word setting
  spi: stm32: extend support to STM32MP25
  video: support Rocktech RK050HR345-CT106A panel

 arch/sandbox/include/asm/test.h |   8 +
 drivers/spi/sandbox_spi.c       |  21 ++
 drivers/spi/spi-uclass.c        |  19 ++
 drivers/spi/stm32_spi.c         |  67 +++++-
 drivers/video/Kconfig           |   8 +
 drivers/video/Makefile          |   1 +
 drivers/video/ilitek-ili9806e.c | 354 ++++++++++++++++++++++++++++++++
 include/spi.h                   |  12 ++
 test/dm/spi.c                   |  16 ++
 9 files changed, 499 insertions(+), 7 deletions(-)
 create mode 100644 drivers/video/ilitek-ili9806e.c

-- 
2.43.0

base-commit: 30b8c03d8c8f500b3e4cc51f7b7abf573180ea51
branch: RK050HR345-CT106A-ON-SPI
