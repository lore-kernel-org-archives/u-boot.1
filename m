Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D19FD3775
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E7D84127;
	Wed, 25 Feb 2026 17:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QNM4al3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4426A84120; Wed, 25 Feb 2026 17:21:09 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E2A84171
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-480706554beso81229665e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772036336; x=1772641136;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=87tZXl2A99AxHhfTppqdnkU1d7h0JgGf/Rr9i4VdH+4=;
 b=QNM4al3CHgxBAPIlkKfies61XShg2jc2Ux/irywxqJOWPRTEwFR7x0/xbNQv18FSl8
 qitNK7CwlVLS+tyCqeSbSwjQot6k128EiVAUTt9z1i82yxGWoknBYLR1eCruL4pHH+bm
 Yo/bXw677En/1LpWWG2TQ5YxNhAi3oTZJKVt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036336; x=1772641136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87tZXl2A99AxHhfTppqdnkU1d7h0JgGf/Rr9i4VdH+4=;
 b=bWDW7/To8iHnkmm8zzhCeXDrYjjmYe9LJTjE7sinOYyiZTuvJPsNqY95qhCaUZcHsQ
 08scbcagjUpgiyESdgiYXdSjB7Y5id2ui7JrVmMq17kxb7sRgbQgPHlaFZ4oLYk3rQCo
 uhUiySVo8skBWost57PRxP6JvLQJtBOooxllLmFlEZ1l+abK3gUs/XNBqBPszy81VLOO
 hMYUyrrr8/1KmHz1S8G39YwmK/z4vR9uZJia/0LpClBuWuHQLiO75rN3tSAwdw9ow8Q+
 97BEJMnrVzXPUw40T83UJlxLuEcT03Z7CgZO0BZ9sAeKvHQ/Kq5U0AqV9eqz/dpSmbCj
 nKug==
X-Gm-Message-State: AOJu0YxOzl6xEUP3WsevcKRG3SqUFKXXke66E7Rb01Apdl8S9IyjNoYV
 OV2OsKJK7fXeAJP+jhPXuXRMYBDmk+5s1kOM6i+q8L3jHHUhPwG7oe/1E7dNjKvk8Ut9Qi4H4KW
 9Y3bv
X-Gm-Gg: ATEYQzxiPctFrfrfnHaS9ldCNgImrCz/M36nEIF75gYbngvTSPDIRCxZDuEXHNU6qu8
 b2gTqEtfSs/70at1e0ZSvUvoJwhzMmdDbS/YH5SUti4BguzP0NKXwP8pN0x/2EJSZj8MHSQbMi7
 wqO6wYdACSo/W/jaR9DJuhN5F6vw45gv90dhxPHs9qMN7d3/rjfUXcAPD7JRA14t+u4ZVvVJKk1
 MBB8ZHEOvDZKEKrfyinAXatfNMiTYbpWWdB2wR/Rpo44caiaM7LJF156ROHXuP3vk13SvwRvIE1
 TLOEzLp5nVZnIv6Rm3hlBtTgQ3oYOGTStvwzcCwCPSoCqFzfr7FUOfi+8Txv6iuhrkh0U3X0+fa
 kXP75c9bhvfTnzQ0uAEREe9aPMhyr/2OgRz30nuXPhHMllMV4AF0oqT3Z1+lC9XIEibfvaOQDms
 v1dRBUZ1B8zD8K+NWp2LbXJDXC/7laELshxwf/dRWU57E09EHQnFYF8HKQg/eXm2XY3vJWhkrp+
 n/oBOf6w4VYeA/uKQEco+PdY8gG/SSkR1XHj0szWoNXBZ2SnDzsRb4zxm8=
X-Received: by 2002:a05:600c:5488:b0:483:71f7:2797 with SMTP id
 5b1f17b1804b1-483c217cb60mr17933945e9.14.1772036336164; 
 Wed, 25 Feb 2026 08:18:56 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:18:55 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
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
Subject: [PATCH v3 0/9] video: support Rocktech RK050HR345-CT106A panel
Date: Wed, 25 Feb 2026 17:16:51 +0100
Message-ID: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Use struct spi_slave data to access wordlen parameter instead
  of driver private data.
- Move the stm32_spi_is_enabled() helper to the new patch
  "spi: stm32: add stm32_spi_is_enabled() helper"
- Insert blank lines to separate code in ilitek-ili9806e.c

Changes in v2:
- Rplace tristate with bool in drivers/video/Kconfig

Dario Binacchi (9):
  spi: add support for bits-per-word setting
  spi: sandbox_spi: support wordlen setup
  test: spi: add sandbox_spi_get_wordlen interface
  test: dm: spi: add testcase for spi_set_wordlen()
  spi: stm32: clean up buffer length assignment
  spi: stm32: add stm32_spi_is_enabled() helper
  spi: stm32: add support for bits-per-word setting
  spi: stm32: extend support to STM32MP25
  video: support Rocktech RK050HR345-CT106A panel

 arch/sandbox/include/asm/test.h |   8 +
 drivers/spi/sandbox_spi.c       |  17 ++
 drivers/spi/spi-uclass.c        |  22 +-
 drivers/spi/stm32_spi.c         |  71 ++++++-
 drivers/video/Kconfig           |   8 +
 drivers/video/Makefile          |   1 +
 drivers/video/ilitek-ili9806e.c | 356 ++++++++++++++++++++++++++++++++
 include/spi.h                   |  14 ++
 test/dm/spi.c                   |  16 ++
 9 files changed, 502 insertions(+), 11 deletions(-)
 create mode 100644 drivers/video/ilitek-ili9806e.c

-- 
2.43.0

base-commit: 4f70106beafe30df8b0528a3d8b2543cd48fe241
