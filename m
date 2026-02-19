Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCA7E9A055
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE30283CF2;
	Thu, 19 Feb 2026 18:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JrCmtot8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2B583CF5; Thu, 19 Feb 2026 18:51:47 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCDCF83CEE
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so9771825e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523505; x=1772128305;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cy4KkJttvJ9loTxMFwuXAS6gYR0rkuPozqGdtP6/ELg=;
 b=JrCmtot8gce2t3A5IvDjPdhjH0UQhYA2KeLeTOUDKFg5hY40lHDHSN2pE8Spwh8CgW
 rEVhK4HWwSsI6D5Nq+v2H3HYL+eZzIDqRYY9UgKf5xuOV3W6pPJKb7nn88nZXGBiddiE
 uYXDLOd1nfWSS3E8WhS3PXLLH57LPtPSm6KGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523505; x=1772128305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cy4KkJttvJ9loTxMFwuXAS6gYR0rkuPozqGdtP6/ELg=;
 b=a4kuUUesCSJjwNqbgIjQ0+prMZlOBK+fLafB52CLiXhNBw2uZ3kQs2Wlz9agGn+eKz
 S62VZAxE5SiwQtrIU+GJwSTNxs/jh9ehAN1nUtgA3j26A0KRkzSNxKWQ9SKfOkctuHri
 /VHj1FoD3CCfTKhKSaQq3qfGuLd+BAfhpKCXuiPsvUzGTcmREyeJC4glEgb2ETpwLz3R
 +9UWshJ9zUJMT/rfIs12Yo8tMaPNd/+t9M8hDzPrpWXBEOC20RYRCZKNt6aix7L+Qq4v
 lHFi5KtpECw8LLw0UV+w7vsJAgWFalgbDdHaATNz86mGZ3eN2OJf+HNIIz2jxJIuo+BQ
 DQLw==
X-Gm-Message-State: AOJu0YwRj0tmIavylYi/lTn0fjeOQpgHPt5aP+Uw6RuxpZPaPVvA3vq/
 kuxVM3az4/x0Wp/9yYrJ6bWQIP4tNlLyhsscmF0mXOOy2xLEnRsNjdz7+HyyS+bc+pCf0bwsU1O
 etQzp
X-Gm-Gg: AZuq6aJDWOSj33pspOJQSivdgsDkIjMxhy9hzMKMueQC+7f35llpc4mXm/X4KzKv+Kg
 noF+fh3PyDKGAd8P/fnm/BkqWTMMWsPuCZMN95TRtIrap2ajvJHd4ruUn8vpJgnWFKVTdkdIa7g
 ZKjn4NUDDXyRO4pOg/vkKgJTi0ig1GotE2R5e1Tfz8fCWjgGKyCBEtoNiuKJx5eTNrPcwWgz0ws
 dhgWJJEFHX97jUbS+pL5HRlMMAL8xhm+C7yDJIHwUT7u8ew569t2uiaq8Ly3s7zFsKIAx7GhJ51
 hdg1/ofDQdfLwaXTyXnNO4+ViPH5b4LKjq1n0yF7uo6deejDDBFxSfkDLDwWk+KlAc16oVzRSRu
 o6QKIqr4RpWBjni4IVHf+gC4+W6mciRU57XmyoBxtd6pKktbCkfUARNnAuPZfAFj924sHpHjym/
 YOGUdNAHJimO9bPlSjvhSJpOuQPnAg8M4OmHcDzRZbynHbKyu2vc2MMs0XCl2TqIZFSvgvZFRlJ
 QmZeLeyyo6o31DNraEyvY8BhiVw//tNgMCBSTNHbn3q6ua4x2GdH3jQFb2OQOxbl7kdcY69ZHdw
 oH8OZen6JIz0Ei3eEIJg4/f/
X-Received: by 2002:a05:600c:4e16:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-483a008dcc2mr46366975e9.12.1771523504939; 
 Thu, 19 Feb 2026 09:51:44 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm35485005e9.2.2026.02.19.09.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:51:44 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
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
 Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/8] video: support Rocktech RK050HR345-CT106A panel
Date: Thu, 19 Feb 2026 18:51:11 +0100
Message-ID: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
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

base-commit: 7dca54ef4c44c82bdc6716ac6cdc84c22c66e9ed
branch: RK050HR345-CT106A-ON-SPI
